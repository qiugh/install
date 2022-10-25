cd ~/
wget https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
tar zxvf apache-hive-3.1.3-bin.tar.gz
mv apache-hive-3.1.3-bin /opt/hive-3.1.3

echo '
export HIVE_HOME=/opt/hive-3.1.3
export PATH=${HIVE_HOME}/bin:$PATH
' >> ~/.bashrc

cd ~/
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.22.tar.gz
tar zxvf mysql-connector-java-8.0.22.tar.gz
cp ~/mysql-connector-java-8.0.22/mysql-connector-java-8.0.22.jar /opt/hive-3.1.3/lib/

hadoop fs -mkdir /tmp
hadoop fs -mkdir -p /user/hive/warehouse
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /user/hive/warehouse

#hive --service metastore

echo '

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
　　<name>javax.jdo.option.ConnectionURL</name>
　　<value>jdbc:mysql://localhost:3306/metastore?createDatabaseIfNotExist=true</value>
　　<description>JDBC connect string for a JDBC metastore</description>
</property>

<property>
　　<name>javax.jdo.option.ConnectionDriverName</name>
　　<value>com.mysql.jdbc.Driver</value>
　　<description>Driver class name for a JDBC metastore</description>
</property>

<property>
　　<name>javax.jdo.option.ConnectionUserName</name>
　　<value>root</value>
　　<description>username to use against metastore database</description>
</property>

<property>
　　<name>javax.jdo.option.ConnectionPassword</name>
　　<value>123456</value>
　　<description>password to use against metastore database</description>
</property>
</configuration>


' > /opt/hive-3.1.3/conf/hive-site.xml



schematool -dbType mysql -initSchema

hive -e 'show databaes;'

