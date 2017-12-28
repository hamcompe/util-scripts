# Change .htm to .html
for f in *.htm; do
  mv -- "$f" "${f%.htm}.html"
done

# Prepare directories
mkdir -p public/img
mkdir -p public/css
mkdir -p public/js

# Move all js,css,img files into their directory
mv -f */*.{svg,png} ./public/img
mv -f */*.js ./public/js
mv -f */*.css ./public/css

# Remove empty directories
find . -type d -empty -delete

# Edit files
for file in *.html; do
  filename="${file%.*}"

  sed -i -e 's/img src=".\/'$filename'_files/img src=".\/img/g' './'$file
  sed -i -e 's/<script src=".\/'$filename'_files\//<script src=".\/js\//g' './'$file
  sed -i -e 's/href="http:\/\/wealth-2e8c75.webflow.io\//href="\//g' './'$file
  # sed -i -e 's/href="\/"/href="#"/g' './'$file
  sed -i -e 's/<link href=".\/'$filename'_files\//<link href=".\/css\//g' './'$file
  sed -i -e 's/href="\/'$filename'/href="/g' './'$file
  sed -i -e 's/href="#" id="wealth-logo"/href="\/" id="wealth-logo"/g' './'$file
done

# Backups
mkdir -p backups
for file in *.html-e; do
  mv $file "./backups/${file}"
done


# Add hide badge css into css files
hideBadgeText='
  .w-webflow-badge {
    display: none !important;
  }
'
for f in public/css/*.css; do
  echo $hideBadgeText >> $f
done
