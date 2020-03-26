
Pod::Spec.new do |spec|
  spec.name         = "DYWKnobControl"
  spec.version      = "0.0.1"
  spec.summary      = "轮盘"

  spec.description  = "轮盘"

  spec.homepage     = "http://EXAMPLE/DYWKnobControl"
  spec.license      = "MIT"
  spec.platform     = :ios, "12.0"

  spec.source       = { :git => "http://github.com/yeyutinglou/DYWKnobControl.git", :tag => "#{spec.version}" }
  spec.source_files  = "DYWKnobControl", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  end
