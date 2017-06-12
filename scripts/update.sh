#! /bin/bash

set -e

cd /web-design-standards

npm install --unsafe-perm

# I'm unclear on whether we need to do this; `npm install` will run
# its prepublish script, which currently runs `gulp build`, while
# the following line runs `gulp release`, which duplicates much of
# what `gulp build` does. But the web-design-standards-docs README says to
# do it, so we'll do it.
npm run build:package

cd /web-design-standards-docs

rm -f node_modules/uswds
ln -s /web-design-standards node_modules/uswds

npm install --unsafe-perm

# Let's build all the static assets jekyll will expect to exist,
# to make sure we don't have a race condition when running
# `docker-compose up`.
npm run prestart
