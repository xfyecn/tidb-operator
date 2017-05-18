# This file is executed immediately after mysql_install_db,
# to initialize a fresh data directory.

##########################################
# Equivalent of mysql_secure_installation
##########################################

# Remove anonymous users.
DELETE FROM mysql.user WHERE User = '';

# Disable remote root access (only allow UNIX socket).
# DELETE FROM mysql.user WHERE User = 'root' AND Host != 'localhost';

# Remove test database.
DROP DATABASE IF EXISTS test;

##########################################
# tidb defaults
##########################################

# Create user database.
CREATE DATABASE IF NOT EXISTS test;

# Admin user with all privileges.
GRANT ALL ON *.* TO 'vt_dba'@'localhost';
GRANT GRANT OPTION ON *.* TO 'vt_dba'@'localhost';

# User for app traffic, with global read-write access.
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, FILE,
  REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES,
  LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW,
  SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER
  ON *.* TO 'vt_app'@'localhost';

FLUSH PRIVILEGES;

