#!/usr/bin/env bash
set -euo pipefail

GetConfig() {
  Cmd="ansible all -i "$1," -m command -a \"bash -c \
    'cat /etc/wireguard/client/$2/$2.conf; \
    qrencode -t ansiutf8 < /etc/wireguard/client/$2/$2.conf'\""
  eval $Cmd
}

declare Host=""
declare Client=""
while getopts ":h:c:" op; do
  case "${op}" in
    h) Host=${OPTARG};;
    c) Client=${OPTARG};;
    *) exit 1;;
  esac
done

[ x$Host = x ] && exit 1
[ x$Client = x ] && exit 1
GetConfig $Host $Client
