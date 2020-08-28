DROP TABLE IF EXISTS pk;

CREATE TABLE pk (d Date DEFAULT '2000-01-01', x DateTime, y UInt64, z UInt64) ENGINE = MergeTree() PARTITION BY d ORDER BY (toStartOfMinute(x), y, z) SETTINGS index_granularity_bytes=19, write_final_mark = 0; -- one row granule

INSERT INTO pk (x, y, z) VALUES (1, 11, 1235), (2, 11, 4395), (3, 22, 3545), (4, 22, 6984), (5, 33, 4596), (61, 11, 4563), (62, 11, 4578), (63, 11, 3572), (64, 22, 5786), (65, 22, 5786), (66, 22, 2791), (67, 22, 2791), (121, 33, 2791), (122, 33, 2791), (123, 33, 1235), (124, 44, 4935), (125, 44, 4578), (126, 55, 5786), (127, 55, 2791), (128, 55, 1235);

SET max_block_size = 1;
SET max_rows_to_read = 5;

SELECT toUInt32(x), y, z FROM pk WHERE (x >= toDateTime(100000)) AND (x <= toDateTime(3));

DROP TABLE IF EXISTS pk;
