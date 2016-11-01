require "pathname"

module Manpages
  class ManFiles
    attr_reader :man_dir

    def initialize(gem_dir, target_dir)
      @target_dir = Pathname(target_dir)
      @man_dir = Pathname(File.join(gem_dir, "man"))
    end

    def manpages
      return [] unless man_dir.directory?

      man_dir.children(false).select do |file|
        file.extname =~ /.\d$/
      end.map {|file| man_dir.join(file) }
    end

    def man_file_path(file)
      man_section = file.extname.match(/\.(\d*)/)
      @target_dir.join("man#{man_section[1]}", file.basename)
    end
  end
end
