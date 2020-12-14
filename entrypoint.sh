#!/bin/bash
set -e

PGDATA=${PGDATA:-/home/jovyan/srv/pgsql}

if [ ! -d "$PGDATA" ]
then
    /usr/lib/postgresql/12/bin/initdb -D "$PGDATA" --encoding=UTF8
fi

/usr/lib/postgresql/12/bin/pg_ctl -D "$PGDATA" status \
|| /usr/lib/postgresql/12/bin/pg_ctl -D "$PGDATA" -l "$PGDATA/pg.log" start

psql postgres -c "CREATE USER jared"
createdb -O jared jared

exec "$@"
