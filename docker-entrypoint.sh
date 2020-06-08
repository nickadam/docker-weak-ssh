#!/bin/sh

if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]
then
  ssh-keygen -A
fi

usermod -p '*' root

/usr/sbin/sshd

if [ ! -f "$HOME/.ssh/id_rsa" ]
then
  ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
fi

cp "$HOME/.ssh/id_rsa.pub" "$HOME/.ssh/authorized_keys"

while true
do
  ncat -lk -p 80 --sh-exec "echo -e 'HTTP/1.1 200 OK\r\n'; cat $HOME/.ssh/id_rsa"
done
