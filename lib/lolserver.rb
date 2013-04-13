require 'sinatra/base'
require 'find'
require 'redcarpet'
require 'mime/types'

ROOT_DIR = Dir.pwd()

class Localserver < Sinatra::Base

  set :views, File.join(File.dirname(__FILE__), "views")

  helpers do
    def print_recursive(hash)
      buf ="<ul>\n"
      hash[:children].each do |item|
        if item.kind_of?(Hash)
          buf += "<li><span class=\"item\">#{item[:filename]}/</span>\n"
          buf += print_recursive(item)
          buf += "</li>\n"
        else
          buf += "<li><a class=\"item\" href=\"#{item}\">#{File.basename(item)}</a></li>\n"
        end
      end
      buf += "</ul>\n"
      buf
    end
  end

  def directory_hash(root, path, name=nil)
    def test_dir(path)
      if File.directory? path
        0
      else
        1
      end
    end
    result = []
    data = {:filename => (name || path)}
    data[:children] = children = []
    files = Dir.foreach(path).sort_by { |a| [ test_dir(a), a.count('/')] }
    files.each do |entry|
      next if (entry == '..' || entry == '.' || entry[0] == '.')
      full_path = File.join(path, entry)
      if File.directory?(full_path)
        children << directory_hash(root, full_path, entry)
      else
        children << full_path
      end
    end
    return data
  end

  def human_size(size)
    units = [ "B", "KB", "MB", "GB"]
    idx = (Math.log(size) / Math.log(1024)).floor
    ("%.3f" % ( size.to_f / 1024**idx)).sub(/\.?0*$/, units[idx])
  end

  get '/' do
    if File.exist? 'index.html'
      content_type :html
      send_file('index.html')
    else
      root = Dir.pwd()
      @title = File.basename(root)
      @files = directory_hash(root, ".")

      # @files = @files.sort_by { |a| [ a[:filename] ]}
      erb :list
    end
  end

  get '*' do
    exts = %w[.markdown .md .txt]
    filename = params["splat"].first
    fullpath = File.join(ROOT_DIR, filename)
    ext = File.extname(fullpath)
    if exts.include? ext
      @title = File.basename(filename)
      @buffer = IO.read(fullpath)
      if ext == ".txt"
        @buffer = "<pre>"+@buffer+"</pre>"
      else
        @buffer = markdown @buffer
      end
      erb :view
    else

      send_file( fullpath )
    end
  end

end

