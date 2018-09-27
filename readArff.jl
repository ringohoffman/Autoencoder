# Source: https://gist.github.com/cbergmeir/1975970ecd8bd525af88

using DataFrames: readtable, DataFrame
# using GZip

##possible types in arff files are:
#real, numeric,
#date
#string
#nominal specifications, starting with {

function convertType(attrType)

  x = lowercase(attrType)
  res = nothing

  if in(x, ["real" "numeric"])

    res = "numeric"

  elseif startswith(x, "{")

    res = "nominal"

  else #date and string

    res = x

  end

  return(res)

end

function readArff(filename, gzip=false)

  f = nothing

  if gzip
    f = GZip.gzopen(filename)
  else
    f = open(filename)
  end

  lines = eachline(f)
    
  header = true
  colNames = nothing
  attrTypes = nothing
  myData = DataFrame()
  attributes = DataFrame()
  nAttr = 0
  nData = 0

  for l in lines

    if header

      mAttr = match(r"^[[:space:]]*@(?i)attribute", l)

      if mAttr == nothing

        mData = ismatch(r"^[[:space:]]*@(?i)data", l)

        if mData
          colNames = convert(Array, attributes[2,:])
          attrTypes = map(convertType, convert(Array, attributes[3,:]))

          header=false
          break
        end
      else
        nAttr += 1
        attributes[:, nAttr] = split(l)[1:3]
      end

    end

  end

  myData = readtable(f, allowcomments=true, commentmark = '%', names = vec(map(Symbol, colNames)))

  close(f)

  return(myData, attrTypes)

end


# @time myData, attrTypes = readArff("/home/cbergmei/data/arff/covtype.arff", false);

# @time res = readArff("/home/bergmeir/data/arff/gz/nursery.arff.gz", true);
# @time res = readArff("/home/bergmeir/data/arff/gz/nursery.arff.gz", true);

# @profile res = readArff("/home/bergmeir/data/arff/gz/nursery.arff.gz", true);

# @time res = readArff("/home/bergmeir/data/arff/nursery.arff");

# @time readArff("/home/bergmeir/data/arff/gz/covtype.arff.gz", true);
# @time readArff("/home/bergmeir/data/arff/gz/covtype.arff.gz", true);

# @time res = readArff("/home/bergmeir/data/covtype_edt.arff");


