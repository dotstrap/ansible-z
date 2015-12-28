# z-fish: fork of z (http://github.com/rupa/z) that works with the fish shell
# https://github.com/sjl/z-fish
# completion by: https://github.com/leiserfg/z-fish

function __complete_z
    [ -z $_Z_DATA ]; and set -l _Z_DATA "$HOME/.z"

    awk -v q=(commandline) -F"|" '
          BEGIN {
        if( q == tolower(q) ) imatch = 1
        split(substr(q, 3), fnd, " ")
    }
    {
        if( imatch ) {
            for( x in fnd ) tolower($1) !~ tolower(fnd[x]) && $1 = ""
        } else {
            for( x in fnd ) $1 !~ fnd[x] && $1 = ""
        }
        if( $1 ) print $1
    }
    ' $_Z_DATA 2>/dev/null
end

complete -c z -s r -x --description 'cd to highest ranked dir matching query'
complete -c z -s t -x --description 'cd to most recently accessed dir matching query'
complete -c z -s l -x --description 'list matches instead of cd'
complete -c z -s h -x --description 'see the help'

complete -f -c z -a '(__complete_z)' --description 'z'
 
