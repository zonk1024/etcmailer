#!/bin/bash

EMAIL=zonk1024@gmail.com

# check for mutt if on debian/ubuntu
if uname -a | grep -qiE 'debian|ubuntu'; then
  if dpkg -l | grep -q '^ii  mutt '; then
    echo "You must have the package 'mutt' installed."
    exit 1
  fi
fi

# move to /
cd /

# if /etc.tgz exists already we'll be nice and move it
[ -f /etc.tgz ] && mv /etc.tgz /tmp/etc.tgz.$$

# make the tgz
tar czf etc.tgz etc

# FIRE!
echo "Your backup, from etcmailer." | mutt -s "etcmailer" -a /etc.tgz -- $EMAIL

# clean up
rm /etc.tgz

# remember the other half of being nice
[ -f /tmp/etc.tgz.$$ ] && mv /tmp/etc.tgz.$$ /etc.tgz
