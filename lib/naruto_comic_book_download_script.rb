#--------------------------------------------------
# Name:           naruto_comic_book_download_script.rb
# Description:    This Ruby script is used to batch download Naruto comic books
#                 which are hosted on http://www.jumpcn.com.
#
#                 Make ensure wget program can be found via PATH environment
#                 variable. The Windows version of wget program can be found
#                 at http://users.ugent.be/~bpuype/wget/.
#
#                 Usage:
#                 ruby naruto_comic_book_download_script.rb chapter
#
#                 Note:
#                 the chapter argument must be an Integer. Up to now, the valid
#                 chapter should be in eval((1..40).to_a + (370..469).to_a)
#
# Author:         Bin Shao <shaobin0604@qq.com> http://aquarium.yo2.cn
# Date:           Oct. 30, 2009
# License:        Apache License, Version 2.0
#--------------------------------------------------
require 'logger'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO

# valid chapters up to now
VALID_CHAPTERS_UPTO_NOW = (1..40).to_a + (370..469).to_a

# Download pictures in chapter
#
#  @param chapter Integer the chapter to be downloaded
#
def download_chapter_pics(chapter)
  unless chapter_valid?(chapter)
    $log.error "chapter not valid"
  end
  command_template = 'wget --directory-prefix="Naruto/%03d"' +
    ' http://gc.jumpcn.com/1/h/huo-ying-ren-zhe/%d/%03d.jpg'
  i = 0
  loop do
    i += 1
    system(command_template % [chapter, chapter, i])
    break unless $?.exitstatus == 0
  end
end

def chapter_valid?(chapter)
  chapter.is_a?(Integer) && VALID_CHAPTERS_UPTO_NOW.include?(chapter)
end

if __FILE__ == $0

  #  chapters = (1..40).to_a + (370..469).to_a
  if ARGV.length != 1
    puts "Usage: ruby naruto_comic_book_download_script.rb chapter"
    puts "chapter must be an Integer"
  else
    download_chapter_pics(ARGV[0].to_i)
  end
end

