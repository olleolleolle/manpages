module Manpages

  class Install

    def initialize(gem_dir, target_dir)
      @gem_dir    = gem_dir
      @target_dir = target_dir
    end

    def install_manpages
      ManFiles.new(@gem_dir, @target_dir).manpages.each do |file|
        link_manpage(file)
      end
    end

    private

    def link_manpage(file)
      man_target_file = ManFiles.new(@gem_dir, @target_dir).man_file_path(file)
      FileUtils.mkdir_p(File.dirname(man_target_file))
      FileUtils.ln_s(file, man_target_file, force: true)
    end

  end

end
