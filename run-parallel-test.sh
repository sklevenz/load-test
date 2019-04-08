#!/usr/bin/env bash

echo "$$" > "PID_PARALLEL"

if [ "$1" == "" ]; then
  echo "Usage: run-parallel-test.sh [url]"
  exit 0
fi

URL="$1"
FILE="$(mktemp)"

rm -rf gen/parallel
mkdir -p gen/parallel

for i in `seq 1 50`; do
  echo "$URL" >> $FILE
done

cat $FILE

while true; do
  #  cat "$FILE" | parallel "curl -sSi -X POST -d @data-1MB.file {}" >> "gen/parallel/response.log" 2>> "gen/parallel/response.err"
  cat "$FILE" | parallel "curl -sSi {}" >> "gen/parallel/response.log" 2>> "gen/parallel/response.err"
done
