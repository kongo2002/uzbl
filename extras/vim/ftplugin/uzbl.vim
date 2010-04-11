" Vim filetype file
" Filename:     uzbl.vim
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Sun 11 Apr 2010 08:37:44 PM CEST

" Defined Mappings:
"
"   <Leader>uu      Test current config with uzbl-core
"   <Leader>ub      Test current config with uzbl-browser
"   <Leader>uc      Diff current config with default uzbl config

if exists('b:did_ftplugin')
  finish
endif

if !exists('g:uzbl_prefix')
    let g:uzbl_prefix = '/usr/local'
endif

let b:did_ftplugin = 1

" enable syntax based folding
setlocal foldmethod=syntax

" correctly format comments
setlocal formatoptions=croql
setlocal comments=:#
setlocal commentstring=#%s

" config testing map for 'uzbl-core'
if executable('uzbl-core')
    com! -buffer UzblCoreTest !uzbl-core -c %
    nmap <buffer> <Leader>uu :UzblCoreTest<CR>
endif

" config testing map for 'uzbl-browser'
if executable('uzbl-browser')
    com! -buffer UzblBrowserTest !uzbl-browser -c %
    nmap <buffer> <Leader>ub :UzblBrowserTest<CR>
endif

" Compare/Diff current config with the default config file
function! s:CompareUzblConfig()
    let def_config = g:uzbl_prefix . '/share/uzbl/examples/config/config'

    if filereadable(def_config)
        if exists('g:uzbl_resize_on_diff') && g:uzbl_resize_on_diff
            set columns=160
        endif
        exe 'vert diffsplit ' . def_config
        wincmd p
    else
        echohl WarningMsg
        echom 'Could not find default uzbl config (set g:uzbl_prefix)'
        echohl None
    endif
endfunction

com! -buffer UzblDiffConf call s:CompareUzblConfig()
nmap <buffer> <Leader>uc :UzblDiffConf<CR>
