module Paperclip
  module Storage
    module TokyoTyrant
      def self.extended base
        begin
          require 'rufus/tokyo/tyrant'
        rescue LoadError => e
          e.message << " (You may need to install the rufus-tokyo gem)"
          raise e
        end
      end

      def exists?(style_name = default_style)
        if original_filename
          tt_object(style_name)
        else
          false
        end
      end

      def tt_bucket
        @tt_bucket ||= Rufus::Tokyo::Tyrant.new(@options[:tt_host], @options[:tt_port])
      end

      def tt_object style_name = default_style
        tt_bucket[path(style_name).sub(%r{^/},'')]
      end

      def flush_writes #:nodoc:
        @queued_for_write.each do |style_name, file|
          tt_bucket[path(style_name).sub(%r{^/},'')] = file.read
        end

        after_flush_writes # allows attachment to clean up temp files

        @queued_for_write = {}
      end

      def flush_deletes #:nodoc:
        @queued_for_delete.each do |path|
          begin
            log("deleting #{path}")
            tt_bucket.delete(path)
          rescue Errno::ENOENT => e
            # ignore file-not-found, let everything else pass
          end
        end
        @queued_for_delete = []
      end

      def copy_to_local_file(style, local_dest_path)
        log("copying #{path(style)} to local file #{local_dest_path}")
        local_file = ::File.open(local_dest_path, 'wb')
        tt_bucket[path(style).sub(%r{^/},'')] = local_file.read
      rescue 
        warn("cannot copy #{path(style)} to local file #{local_dest_path}")
        false
      end
    end

  end
end