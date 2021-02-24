# Must have `sentry-cli` installed globally
# Following variable must be passed in
#  SENTRY_AUTH_TOKEN
# export JAVA_HOME=/usr/bin/java
SENTRY_ORG=will-captel
SENTRY_PROJECT=java-1
VERSION=`sentry-cli releases propose-version`

deploy: setup_release run_jar

setup_release: create_release # associate_commits

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(VERSION)

run_jar:
	mvn clean package && \
	 java -Dsentry.release=$(VERSION) -jar target/example-0.0.1-SNAPSHOT.jar
