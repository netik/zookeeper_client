require 'mkmf'
require 'rbconfig'

HERE = File.expand_path(File.dirname(__FILE__))
BUNDLE = Dir.glob("zkc-*.tar.gz").first
BUNDLE_PATH = "c"

$CFLAGS = "#{RbConfig::CONFIG['CFLAGS']} #{$CFLAGS}".gsub("$(cflags)", "").gsub("-arch ppc", "")
$LDFLAGS = "#{RbConfig::CONFIG['LDFLAGS']} #{$LDFLAGS}".gsub("$(ldflags)", "").gsub("-arch ppc", "")
$CXXFLAGS = " -std=gnu++98 #{$CFLAGS}"
$CPPFLAGS = $ARCH_FLAG = $DLDFLAGS = ""

if ENV['DEBUG']
  puts "Setting debug flags."
  $CFLAGS << " -O0 -ggdb -DHAVE_DEBUG"
  $EXTRA_CONF = " --enable-debug"
end

# Specify the zookeeper library location here. 
ZKINCLUDES="-I/usr/local/include/c-client-src"
ZKLIBS="-L/usr/local/lib"

$includes = " -I#{HERE}/include #{ZKINCLUDES}"
$libraries = " -L#{HERE}/lib #{ZKLIBS}"

$CFLAGS = "#{$includes} #{$libraries} #{$CFLAGS}"
$LDFLAGS = "#{$libraries} #{$LDFLAGS}"
$LIBPATH = ["#{HERE}/lib"]
$DEFLIBPATH = []

$LIBS << " -lzookeeper_mt"

create_makefile 'zookeeper_c'
