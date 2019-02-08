# Init the repository
ENV = $$(cat .env | grep -v "\#" | xargs -d "\r")

init: chmod-scripts
	hack/init-repo.sh
	editor .env
	editor Dockerfile

create: pull-base build

pull-base: chmod-scripts
	env $(ENV) hack/pull-image.sh

build: chmod-scripts
	env $(ENV) hack/build-images.sh


no-cache-build: chmod-scripts
	env $(ENV) hack/build-images.sh nocache

patch: chmod-scripts
	env $(ENV) hack/apply-patches.sh


faq:
	cat hack/faq.txt

chmod-scripts:
	chmod +x -R hack
