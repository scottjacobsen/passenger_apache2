#
# Cookbook Name:: passenger_apache2
# Recipe:: rvm
#
# Author:: Scott Jacobsen (<scott@neighborland.com>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This recipe is designed to work with a Single-User style RVM
# install. It has not been tested against a Multi-User install.

include_recipe "build-essential"
%w(libcurl4-openssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev).each do |p|
  package p
end

node.default['passenger']['apache_mpm']  = 'prefork'
node.default['passenger']['root_path'] = "#{node['passenger']['rvm']['root_path']}"
node.default['passenger']['ruby_bin'] = "#{node['passenger']['rvm']['ruby_bin']}"
node.default['passenger']['module_path'] = "#{node['passenger']['rvm']['module_path']}"

unless(node['passenger']['rvm']['user'])
  raise 'The RVM user must be defined!'
end

unless(node['passenger']['rvm']['ruby_string'])
  raise 'The ruby version must be defined in ruby_string!'
end

bash 'passenger_gem' do
  code "source $HOME/.rvm/scripts/rvm
rvm use #{node['passenger']['rvm']['ruby_string']}
gem install -v #{node['passenger']['version']} passenger"
  user node['passenger']['rvm']['user']
  group node['passenger']['rvm']['group']
  creates node['passenger']['root_path']
  environment({ "HOME" => node['passenger']['rvm']['user_home'] })
end

bash 'passenger_module' do
  code "source $HOME/.rvm/scripts/rvm
rvm use #{node['passenger']['rvm']['ruby_string']}
passenger-install-apache2-module --auto"
  user node['passenger']['rvm']['user']
  group node['passenger']['rvm']['group']
  creates node['passenger']['rvm']['module_path']
  environment({ "HOME" => node['passenger']['rvm']['user_home'] })
end
