#
# Cookbook Name:: logstash
# Recipe:: pyshipper
#
# Copyright 2012, enStratus Networks, Inc
#
# All rights reserved - Do Not Redistribute
#
include_recipe "build-essential"
include_recipe "logstash::default"
include_recipe "python::pip"
include_recipe "git"

if platform_family? "debian"
  package "python-dev"
elsif platform_family? "rhel","fedora"
  package "python-devel"
end

git "#{node['logstash']['basedir']}/shipper" do
  repository "git://github.com/lusis/logstash-shipper.git"
  reference "master"
  action :sync
end

%w{pyzmq-static simplejson argparse}.each do |ppkg|
  python_pip ppkg do
    action :install
  end
end
