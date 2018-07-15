#!/bin/bash

adduser consul
mkdir -p /etc/consul/consul.d/{bootstrap,server,client}
mkdir /var/consul
chown consul:consul /var/consul
touch /etc/systemd/system/consul.service
wget https://releases.hashicorp.com/consul/1.2.0/consul_1.2.0_linux_amd64.zip -P /etc/consul/
cd /etc/consul/
yum install unzip -y
ln -s /etc/consul/consul /bin/consul
rm -f /etc/consul/consul_1.2.0_linux_amd64.zip
