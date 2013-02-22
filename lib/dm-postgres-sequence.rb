=begin
@url https://gist.github.com/d11wtq/959059
@author Chris Corbyn
@license None, use at your own risk
=end
module DataMapper
	class Property
		# Adds support for a sequences table to DataMapper, via a Sequence property type.
		#
		# class Person
		#   include DataMapper::Resource
		#
		#   property :id,   Sequence
		# end
		#
		# You can optionally specify a sequence name on the propery, if it doesn't match convention.
		#
		# class Person
		#   include DataMapper::Resource
		#
		#   property :id,   Sequence, :sequence_name => 'person_personid_seq'
		# end
		#
		# The standard naming convention is "#{table_name}_#{field_name}_seq".
		class Sequence < Integer
			Property.accept_options(:sequence_name)

			key     true
			min     1
			default lambda { |resource, property| property.next_sequence }

			@sequence_name = nil

			def initialize(model, name, options = {})
				field_name = options.fetch(:field, name).to_s
				@sequence_name = options.fetch(:sequence_name, sequence_name_for(model.storage_name, field_name))
				super
			end

			def next_sequence
				sql = "SELECT nextval(?)"
				repository.adapter.select(sql, @sequence_name).first
			rescue ::DataObjects::SQLError
				raise
			end

			private

			def sequence_name_for(table, column)
				"#{table}_#{column}_seq"
			end
		end

	end
end