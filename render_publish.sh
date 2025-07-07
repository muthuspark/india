#!/bin/bash
set -e  # Exit on any error
hugo
echo "Building site with Hugo..."
echo "Running pagefind..."
npx -y pagefind --site public
echo "Copying ads.txt..."
cp ads.txt public/ads.txt
xsltproc --output public/sitemap_index.xml filter_sitemap.xsl public/sitemap_index.xml
git add .
current_date=$(date +"%Y-%m-%d %H-%M-%S")
commit_message=${1:-"Release $current_date"}
git commit -m "$commit_message"
git push
echo "Deployment completed successfully!"