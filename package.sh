#!/bin/bash

fpm_dependencies=""
for dependency in $dependencies; do
  fpm_dependencies="$(echo $fpm_dependencies) -d $dependency"
done

output_dir=$1

# script to package this repo via fpm
fpm \
  -s dir \
  -t deb \
  -a "all" \
  -n "demo-project" \
  -v "$(cat VERSION)" \
  --maintainer "DemoCorp" \
  --provides "demo project" \
  --vendor "DemoCorp" \
  --before-install "hooks/before-install.sh" \
  --after-install "hooks/after-install.sh" \
  --before-upgrade "hooks/before-upgrade.sh" \
  --after-upgrade "hooks/after-upgrade.sh"

mkdir -p $output_dir
mv *.deb $output_dir
