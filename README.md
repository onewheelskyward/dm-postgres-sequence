dm-sequence
===========

A http://datamapper.org property for using Postgresql sequences to populate your Serial fields.  I found a need for it since I'm accessing a legacy database in which the serial fields don't have the sequence trigger applied (thank you Doctrine).

It's a heavily adapted version of this gist by Chris Corbyn: https://gist.github.com/d11wtq/959059 

and converted it for use with Postgresql, and turned it into a gem.  Once it is more tested, I'll submit it to Rubygems.


