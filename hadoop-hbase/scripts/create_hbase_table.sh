#!/usr/bin/env bash

#############CONFIGURATIONS###################################################
HBASE_NAME_SPACE="testDataBase"
HBASE_TEST_TABLE_NAME="testTable"
HBASE_TABLE_COLUMN_FAMILY="data"

HBASE_DATA_BLOCK_ENCODING='NONE'
HBASE_BLOOMFILTER='NONE'
HBASE_REPLICATION_SCOPE='0'
HBASE_VERSIONS='3'
HBASE_COMPRESSION='NONE'
HBASE_TTL='2147483647'
HBASE_BLOCKSIZE='65536'
HBASE_IN_MEMORY='true'
HBASE_BLOCKCACHE='true'
HBASE_MIN_VERSIONS='0'
HBASE_KEEP_DELETED_CELLS='false'

#############CREATE NAMESPACE#################################################
echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Create namespace : "${HBASE_NAME_SPACE}
echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Hbase command: (echo ''create_namespace '${HBASE_NAME_SPACE}''' | hbase shell)"
(echo "create_namespace '${HBASE_NAME_SPACE}'" | hbase shell) > log

#############CREATE ACTIVE_PASSIVE_TABLE######################################
echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Create Table : "${HBASE_TEST_TABLE_NAME}
echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Hbase command: (echo ''exists '${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME}''' | hbase shell)"
(echo "exists '${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME}'" | hbase shell) > log
cat log | grep "Table ${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME} does exist"
if [ $? -eq 0 ]
then
    echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Table does exist : "${HBASE_TEST_TABLE_NAME}
else
    echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Table does not exists : "${HBASE_TEST_TABLE_NAME}
    echo `date +'%Y-%m-%d %H:%M:%S'` [HBASE TEST] [HBASE SCHEMA] [HBASE CREATION] INFO "Hbase command: (echo ''create '${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME}',{NAME=>'${HBASE_TABLE_COLUMN_FAMILY}', DATA_BLOCK_ENCODING => '${HBASE_DATA_BLOCK_ENCODING}', BLOOMFILTER => '${HBASE_BLOOMFILTER}', REPLICATION_SCOPE => '${HBASE_REPLICATION_SCOPE}', VERSIONS => '${HBASE_VERSIONS}', COMPRESSION => '${HBASE_COMPRESSION}', TTL =>'${HBASE_TTL}', BLOCKSIZE => '${HBASE_BLOCKSIZE}', IN_MEMORY =>'${HBASE_IN_MEMORY}', BLOCKCACHE => '${HBASE_BLOCKCACHE}',MIN_VERSIONS => '${HBASE_MIN_VERSIONS}',KEEP_DELETED_CELLS => '${HBASE_KEEP_DELETED_CELLS}'}'' | hbase shell)"
    (echo "create '${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME}',{NAME=>'${HBASE_TABLE_COLUMN_FAMILY}', DATA_BLOCK_ENCODING => '${HBASE_DATA_BLOCK_ENCODING}', BLOOMFILTER => '${HBASE_BLOOMFILTER}', REPLICATION_SCOPE => '${HBASE_REPLICATION_SCOPE}', VERSIONS => '${HBASE_VERSIONS}', COMPRESSION => '${HBASE_COMPRESSION}', TTL =>'${HBASE_TTL}', BLOCKSIZE => '${HBASE_BLOCKSIZE}', IN_MEMORY =>'${HBASE_IN_MEMORY}', BLOCKCACHE => '${HBASE_BLOCKCACHE}',MIN_VERSIONS => '${HBASE_MIN_VERSIONS}',KEEP_DELETED_CELLS => '${HBASE_KEEP_DELETED_CELLS}'}" | hbase shell)
fi
(echo "describe '${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME}'" | hbase shell)
(echo "enable '${HBASE_NAME_SPACE}:${HBASE_TEST_TABLE_NAME}'" | hbase shell)