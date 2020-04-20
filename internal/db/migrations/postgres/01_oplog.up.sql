CREATE TABLE if not exists oplog_entry (
  id bigint generated always as identity primary key,
  create_time timestamp with time zone default current_timestamp,
  update_time timestamp with time zone default current_timestamp,
  version text NOT NULL,
  aggregate_name text NOT NULL,
  "data" bytea NOT NULL
);
CREATE TABLE if not exists oplog_ticket (
  id bigint generated always as identity primary key,
  create_time timestamp with time zone default current_timestamp,
  update_time timestamp with time zone default current_timestamp,
  "name" text NOT NULL UNIQUE,
  "version" bigint NOT NULL
);
CREATE TABLE if not exists oplog_metadata (
  id bigint generated always as identity primary key,
  create_time timestamp with time zone default current_timestamp,
  entry_id bigint NOT NULL REFERENCES oplog_entry(id) ON DELETE CASCADE ON UPDATE CASCADE,
  "key" text NOT NULL,
  value text NULL
);
create index if not exists idx_oplog_metatadata_key on oplog_metadata(key);
create index if not exists idx_oplog_metatadata_value on oplog_metadata(value);