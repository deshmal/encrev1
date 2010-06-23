#! /usr/bin/ruby
## encre-platform-mocker.rb
## Login : <elthariel@rincevent>
## Started on  Thu Jun 17 11:10:18 2010 elthariel
## $Id$
##
## Author(s):
##  - elthariel <elthariel@gmail.com>
##
## Copyright (C) 2010 elthariel
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##

require 'rubygems'
require 'json'
require 'sinatra'

conf = {:red5_token => 'Keiqu0Iecouc4kiYuaF6ea3u',
        :auth => {'token1' => {'videochat_connect' => {'' => true},
                               'videochat_join' => {'room1' => true,
                                                   'room2' => false}},
                  'token2' => {'videochat_connect' => {'' => true},
                               'videochat_join' => {'room1' => false,
                                                   'room2' => true}}}}


get '/token/get' do
  {:token => conf[:red5_token]}.to_json
end

get "/token/:btoken/isvalid" do
  if params[:btoken] == conf[:red5_token]
    if conf[:auth][params[:token]] and conf[:auth][params[:token]][params[:type]] and conf[:auth][params[:token]][params[:type]][params[:scope]] == true
      return {:result => 'ok'}.to_json
    end
  end
  {:error => 'not_authorized'}.to_json
end
