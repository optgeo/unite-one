require './conf.rb'
require 'json'

def minzoom(f)
  case f['properties']['code'].to_i
  when 10101, 1010101, 11201, 11202, 11203, 11204
    DST_MAXZOOM - 1
  when 10301, 10302, 10303, 10304, 10308, 10314, 10305,
    10508, 2010101, 10306, 10307, 10310, 10312
    DST_MINZOOM
  else
    DST_MAXZOOM
  end
end

def code(c)
  case c
  when 10101, 1010101, 11201, 11202, 11203, 11204
    '山地'
  when 10202, 10204, 2010201
    '崖・段丘崖'
  when 10205, 10206
    '地すべり地形'
  when 10301, 10302, 10303, 10304, 10308, 10314,
    10305, 10508, 2010101, 10306, 10307, 10310, 10312
    '台地・段丘'
  when 10401, 10402, 10403, 10404, 10406,
    10407, 3010101
    '山麓堆積地形'
  when 10501, 10502, 3020101
    '扇状地'
  when 10503, 3040101
    '自然堤防'
  when 10506, 10507, 10801
    '天井川'
  when 10504, 10505, 10512, 3050101
    '砂州・砂丘'
  when 10601, 2010301
    '凹地・浅い谷'
  when 10701, 3030101, 10702, 10705
    '氾濫平野'
  when 10703, 10804, 3030201
    '後背低地・湿地'
  when 10704, 3040201, 3040202
    '旧河道'
  when 3040301
    '落堀'
  when 10802, 10803, 10807, 10808
    '河川敷・浜'
  when 10805, 10806, 10901, 10903, 5010201
    '水部'
  when 10904, 5010301
    '旧水部'
  else
    c
  end
end

while gets
  f = JSON.parse($_.strip)
  f['tippecanoe'] = {
    minzoom: minzoom(f),
    maxzoom: DST_MAXZOOM,
    layer: 'one'
  }
  f['properties']['code'] = 
    code(f['properties']['code'].to_i)
  print "\x1e#{JSON.dump(f)}\n"
end

