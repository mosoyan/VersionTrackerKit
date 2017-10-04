Pod::Spec.new do |s|
  s.name         = "VersionTrackerKit"
  s.version      = '1.0.1'
  s.summary      = "App Version Tracker."
  s.description  = "VersionTrackerKit is a swift framework that can fully track app version"
  s.homepage     = "http://picpenapps.com"
  s.license      = "MIT"
  s.author    = "Hovsep Keropyan"
  s.platform     = :ios, '9.0'
  s.source       = {:path => "."}
  s.source_files  = "VersionTrackerKit", "VersionTrackerKit/**/*.{h,m,swift}"
  s.pod_target_xcconfig = {"SWIFT_VERSION" => '4'}
end
