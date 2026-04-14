#!/bin/bash
# Replace empty onset (col1) and duration (col2) values with "n/a" in events TSV files.
export PS4='> '
set -x
set -eu

cd "$(dirname "$0")/.."

find . -name '*_events.tsv' -print0 | while IFS= read -r -d '' f; do
    awk -F'\t' -v OFS='\t' 'NR>1 { if ($1 == "") $1 = "n/a"; if ($2 == "") $2 = "n/a" } { print }' "$f" > "${f}.tmp"
    mv "${f}.tmp" "$f"
done
