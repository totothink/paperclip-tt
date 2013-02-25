# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name          = "paperclip-tt"
  gem.version       = "0.0.1"
  gem.platform      = Gem::Platform::RUBY

  gem.homepage      = "https://github.com/totothink/paperclip-tt"
  gem.description   = %q{Extends Paperclip with TokyoTyrant storage.}
  gem.summary       = gem.description
  gem.authors       = ["Aaron"]
  gem.email         = ["yalong1976@gmail.com"]

  gem.files         = Dir["lib/**/*"] + ["README.md", "LICENSE", "paperclip-tt.gemspec","CHANGELOG"]
  gem.require_path  = "lib"

  gem.required_ruby_version = ">= 1.9.2"

  gem.license       = "MIT"

  gem.add_dependency "paperclip", "~> 3.1"
  gem.add_dependency "rufus-tokyo"
end