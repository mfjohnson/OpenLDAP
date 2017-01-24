useradd ldapadmin -m
useradd ldapuser1 -m
useradd ldapuser2 -m
useradd ldapuser3 -m
useradd ldapuser4 -m

cd /usr/share/migrationtools
grep "ldap" /etc/passwd > passwd
./migrate_passwd.pl passwd users.ldif
ldapadd -x -w hadoop -D cn=Manager,dc=hadoop,dc=com -f users.ldif
grep "ldap" /etc/group > group
./migrate_group.pl group groups.ldif
ldapadd -x -w hadoop -D cn=Manager,dc=hadoop,dc=com -f groups.ldif
ldapsearch -x cn=ldap* -b dc=hadoop,dc=com