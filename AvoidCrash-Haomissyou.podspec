Pod::Spec.new do |s|
s.name         = "AvoidCrash-Haomissyou"
s.platform     = :ios, "7.0"
s.version      = "2.6.0"
s.summary      = "This framework can avoid Foundation framework potential crash danger"
s.homepage     = "https://github.com/xjh093/AvoidCrash-Haomissyou"
s.license      = "MIT"
s.source       = { :git => "https://github.com/xjh093/AvoidCrash-Haomissyou.git", :tag => s.version }

s.author           = { "Haomissyou" => "xjh093@126.com" }
s.social_media_url = "https://blog.csdn.net/xjh093"

s.ios.deployment_target = '7.0'

s.source_files = 'AvoidCrash/**/*.{h,m}'
s.requires_arc = [
                  'AvoidCrash/AvoidCrash.m',
                  'AvoidCrash/AvoidCrashStubProxy.m',
                  'AvoidCrash/NSObject+AvoidCrash.m',
                  'AvoidCrash/NSArray+AvoidCrash.m',
                  'AvoidCrash/NSDictionary+AvoidCrash.m',
                  'AvoidCrash/NSMutableDictionary+AvoidCrash.m',
                  'AvoidCrash/NSString+AvoidCrash.m',
                  'AvoidCrash/NSMutableString+AvoidCrash.m',
                  'AvoidCrash/NSAttributedString+AvoidCrash.m',
                  'AvoidCrash/NSMutableAttributedString+AvoidCrash.m']

end


