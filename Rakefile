require './conf.rb'

desc 'produce vector tiles'
task :produce do
  cmd = [
    "curl -O #{BASE_URL}/mokuroku.csv.gz; ",
    "zcat mokuroku.csv.gz | grep -o '^#{SRC_Z}\/.*\.geojson' | ",
    "parallel --line-buffer 'curl --output - --silent #{BASE_URL}/{} | ",
    "tippecanoe-json-tool' | ruby filter.rb | ",
    # "head -n 500000 | ",
    # "tee source.geojsons | ",
    "tippecanoe --minimum-zoom=#{DST_MINZOOM} --maximum-zoom=#{DST_MAXZOOM} ",
    "--force ",
    "--coalesce --detect-shared-borders ",
    "-o tiles.mbtiles; tile-join --force --no-tile-compression ",
    "--output-to-directory=docs/zxy --no-tile-size-limit tiles.mbtiles; ",
    "rm mokuroku.csv.gz"
  ].join
  sh cmd 
end

desc 'run vt-optimizer'
task :optimize do
  sh "node ../vt-optimizer/index.js -m tiles.mbtiles"
end

desc 'build style'
task :style do
  sh [
    "SITE_ROOT=#{SITE_ROOT} ",
    "parse-hocon style.conf > docs/style.json; ",
    "gl-style-validate docs/style.json"
  ].join
end

desc 'host'
task :host do
  sh "budo -d docs"
end

