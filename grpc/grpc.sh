#!/bin/bash
# Run this script from the repository top level: ./grpc/grpc.sh
set -o pipefail
> errors.txt
> run.log
GHA2DB_PROJECT=grpc IDB_DB=grpc PG_DB=grpc GHA2DB_LOCAL=1 ./structure 2>>errors.txt | tee -a run.log || exit 1
GHA2DB_PROJECT=grpc IDB_DB=grpc PG_DB=grpc GHA2DB_LOCAL=1 ./gha2db 2015-02-23 0 today now 'grpc' 2>>errors.txt | tee -a run.log || exit 2
GHA2DB_PROJECT=grpc IDB_DB=grpc PG_DB=grpc GHA2DB_LOCAL=1 GHA2DB_MGETC=y GHA2DB_SKIPTABLE=1 GHA2DB_INDEX=1 ./structure 2>>errors.txt | tee -a run.log || exit 3
./grafana/influxdb_recreate.sh grpc
./grpc/setup_repo_groups.sh 2>>errors.txt | tee -a run.log || exit 4
./grpc/import_affs.sh 2>>errors.txt | tee -a run.log || exit 5
./grpc/setup_scripts.sh 2>>errors.txt | tee -a run.log || exit 6
./grpc/get_repos.sh 2>>errors.txt | tee -a run.log || exit 7
echo "All done. You should run ./grpc/reinit.sh script now."
