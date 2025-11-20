#!/bin/bash
mkdir -p cidr
for f in *.nft; do
  b="${f%.nft}"
	ipv4=$(grep -v '^#' "$f" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]+)?' | while read -r ip; do
	  [[ "$ip" == */* ]] && echo "$ip" || echo "$ip/32"
	done)

	ipv6=$(grep -v '^#' "$f" | grep -oE '([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}(/[0-9]+)?' | while read -r ip; do
	  [[ "$ip" == */* ]] && echo "$ip" || echo "$ip/128"
	done)
  [[ -n "$ipv4" ]] && echo "$ipv4" > "cidr/${b}_v4.txt"
  [[ -n "$ipv6" ]] && echo "$ipv6" > "cidr/${b}_v6.txt"
done
