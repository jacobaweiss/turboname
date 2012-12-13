require 'open-uri'

class Turboname
  CountryTLDs = %w{ac ad ae af ag ai al am an ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo br bs bt bu bv bw by bz ca cc cd cf cg ch ci ck cl cm cn co cr cs cu cv cx cy cz de dj dk dm do dz ec ee eg eh er es et eu fi fj fk fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sj sk sl sm sn so sr st su sv sy sz tc td tf tg tj tk tl tm tn to tp tr tt tv tw tz ua ug uk us uy uz va vc ve vg vi vn vu wf ws ye yt yu za zm zw}
  
  attr_accessor :name
  
  def initialize opts = {}
    case opts[:from]
    when :random
      self.name = from_random
    else
      self.name = opts[:from]
    end if opts[:from]
  end
  
  def save
    puts "Domain found: " + name
    `echo "#{name}" >> names.txt`
  end 
  
  def available?
    puts "checking if #{name} is available"
    (`whois #{name}`).include?("No match for") ? true : false
  end
  
  def tldize! what
    last_letters = what[-2..-1]
    if CountryTLDs.include?(last_letters)
      what[0..-3] + "." + last_letters
    else
      "#{what}.com"
    end
  end
  
  def name= new_name
    @name = tldize! new_name
  end
  
  def from_random
    vowels=["a","e","i","o","u"]
    line = File.readlines("dictionary.txt")[rand(435000)-1].gsub("\n","")
    rand(20).times do
      line=line.gsub(vowels.sample,vowels.sample)
    end
    line
  end
  
  def to_s
    @name
  end
  
  def length
    @name.length
  end
end

puts ' ________  _____  ___  ____  _  _____   __  _______'
puts '/_  __/ / / / _ \/ _ )/ __ \/ |/ / _ | /  |/  / __/'
puts ' / / / /_/ / , _/ _  / /_/ /    / __ |/ /|_/ / _/  '
puts '/_/  \____/_/|_/____/\____/_/|_/_/ |_/_/  /_/___/  '
puts "    finding a domain name for you since #{1800 + rand(100)}"
                                            

100999032982389.times do
  name = Turboname.new from: :random
  if name.length < 15
    if name.available?
      name.save
    end
  end
end
