:set showcmd
:source /home/guests/krishnaprasad.pa/.abbreviations
:highlight Normal ctermfg=white ctermbg=black
:set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
:setlocal complete+=k
:setlocal dictionary+=/home/guests/krishnaprasad.pa/autocomplete.txt
:set completeopt+=longest
:nnoremap <SPACE> <Nop>
:map <Leader>i :r ip
:map <Leader>manage :r websitemanager
:map <Leader>passman :r websitemanagerpassword
:map <Leader>cac :r cache
:set notimeout
:set ttimeout
:map <Leader>t :%s/hte/the/g
:map <leader>tl :s/hte/the/g
:map <Leader>w 7w
:map <leader>d :r settings<CR> :s/mail.fullimputinnovations.com/
:nnoremap <Leader>f :NERDTreeToggle<Enter>
:set shell=/bin/bash\ -i
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'dpelle/vim-LanguageTool'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'preservim/NERDTree'
call plug#end()

let g:openai_api_key='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'

function! MyCompleteFunc(findstart, base)
  if (a:findstart == 1)
    normal b
    return col(".") - 1
  else
    " Hardcoded path to dictionary. You could tweak this to use
    " whatever dictionary you have set with `set dictionary=`
    let l:data = readfile("/home/guests/krishnaprasad.pa/mydict.txt")
    return filter(l:data, 'v:val =~ ".*' . a:base . '.*"')
  endif
endfunction

" set completefunc=MyCompleteFunc



" Map a key to manually trigger the display update
" nnoremap <Leader>kn :call DisplayRelativeWordNumbers()<CR>

:map <Leader>h :r intro<CR> ggddGA


:set spellfile=/home/poornam/Templates/krishna.utf-8.add
:set hlsearch

:set spellfile=/home/poornam/Templates/krishna.utf-8.add
:set hlsearch

" Function to add a new abbreviation to the file


" Function to add a new abbreviation to the file
" Function to add a new abbreviation to the file




function! AddAbbreviation(typo, correction)
    let abbreviation_file = '/home/guests/krishnaprasad.pa/.abbreviations'
    let abbreviation_cmd = ':s/\V\<' . a:typo . '\>/' . a:correction . '/g'
    let abbreviation = ':iabbrev ' . a:typo . ' ' . a:correction

    try
        " Append the abbreviation to the file
        call writefile([abbreviation], abbreviation_file, 'a')

        " Add the abbreviation to the current Vim session
        execute abbreviation_cmd

        echo "Abbreviation added: " . abbreviation
    catch
        echo "Error: Unable to write to " . abbreviation_file
    endtry
endfunction

" Mapping to add a new abbreviation 
nnoremap <Leader>cc :call inputsave() <bar> let typo = expand('<cword>') <bar> let correction = input('Enter the correction: ') <bar> call inputrestore() <bar> call AddAbbreviation(typo, correction)<CR>









function! BlinkCurrentMatch()
    let save_view = winsaveview()
    let current_word = escape(expand('<cword>'), '\')
    try
        syntax match SearchTerms "\<%s\>" contains=ALL
        set syntax=ON
        redraw
        sleep 300m
    finally
        syntax clear SearchTerms
        redraw
        call winrestview(save_view)
    endtry
endfunction

" Set your preferred leader key (if not already set)

" Define a function to append the current file to a hardcoded file with timestamp, unique ID, and anchor in the index
function! AppendToFileWithTimestampAndUniqueIDAndIndex()
    " Hardcoded target file path
    let target_file = '/home/guests/krishnaprasad.pa/replies/replies'

    " Get the current timestamp
    let timestamp = strftime('%Y-%m-%d %H:%M:%S')

    " Ask for a unique ID
    let unique_id = input('Enter a unique ID: ')

    " Surrounding string
    let content_surrounding = "========================================================================================"

    " Get the entire content of the current file
    let entire_content = getline(1, '$')

    " Append the content to the target file
    let lines = [content_surrounding, 'ID: ' . unique_id, 'Timestamp: ' . timestamp] + entire_content + [content_surrounding]
    call writefile(lines, target_file, 'a')

    " Update the index file
    let index_file = '/home/guests/krishnaprasad.pa/replies/index'
    call writefile([timestamp . ' | ' . unique_id . ' | ' . target_file], index_file, 'a')

    echo "Contents appended to " . target_file . " with timestamp " . timestamp . " and unique ID " . unique_id
endfunction

nnoremap <Leader>bs :call AppendToFileWithTimestampAndUniqueIDAndIndex()<CR>

function! GoToCorrespondingLine()
    " Hardcoded index file path
    let index_file = '/home/guests/krishnaprasad.pa/replies/replies'

    " Get the ID from the current line
    let current_line = getline('.')
    let current_id = matchstr(current_line, '\d\+')

    " If an ID is found, open the target file and move to the corresponding line
    if !empty(current_id)
        let index_entries = readfile(index_file)
        for entry in index_entries
            if entry =~ '\V' . current_id
                let file_info = split(entry, ' | ')
                let file_path = file_info[2]
                let line_number = file_info[1]
                execute 'edit ' . fnameescape(file_path) | execute line_number
                return
            endif
        endfor
    endif

    echo "Corresponding entry not found in the index."
endfunction


" Define a function to append the current file to a hardcoded file
function! AppendToFile()
    " Hardcoded target file path
    let target_file = '/home/guests/krishnaprasad.pa/basicreplies'

    " Append the current file to the target file
    execute 'write >> ' . target_file

    echo "Contents appended to " . target_file
endfunction

" Map the function to <Leader>s
 nnoremap <Leader>s :call AppendToFile()<CR> 


" Map the function to <Leader>gt
nnoremap <Leader>gt :call GoToCorrespondingLine()<CR>

:iabbrev teh the
:iabbrev het the
:iabbrev hte the
:iabbrev Email email
:iabbrev afrihost Afrihost
:iabbrev UPon Upon
:iabbrev HI Hi
:iabbrev taht that
:iabbrev shost https://www.Afrihost.com/shared-hosting
:iabbrev dhost https://www.Afrihost.com/dedicated-hosting
:iabbrev vhost https://www.Afrihost.com/reseller-hosting
:iabbrev chost https://Afrihost.com/cloud-hosting
:iabbrev ehost https://Afrihost.com/domain-email
:iabbrev cpanel Cpanel
:iabbrev webmail Webmail
:iabbrev si is
:iabbrev pubip Your local machine IP address, you can get this using URL: http://whatismyipaddress.com/
:iabbrev sss screenshot
:iabbrev ck checking
:iabbrev att attached
:iabbrev att. attached.
:iabbrev hi Hi
:iabbrev hI Hi
:iabbrev dom domain
:iabbrev ck, checking,
:iabbrev afri Afrihost
:iabbrev thte that
:iabbrev ldf loading
:iabbrev uPon Upon
:iabbrev upon Upon
:iabbrev sthe the
:iabbrev ther, there,
:iabbrev ew we
:iabbrev upd update
:iabbrev nss nameservers
:iabbrev rgs registrar
:iabbrev tha that
:iabbrev ifne fine
:iabbrev ifen fine
:iabbrev ot to
:abbrev uccessful successfully
:abbrev sccessful successfully
:abbrev sucessful successfully
:abbrev succssful successfully
:abbrev succesful successfully
:abbrev successul successfully
:abbrev successfl successfully
:abbrev succesfully successfully
:abbrev succ successfully
:abbrev compd completed
:abbrev tthat that
:iabbrev krishnara krishna
:iabbrev acddress address
:iabbrev observer observe
:iabbrev htat that 
:iabbrev Afrhost Afrihost
:iabbrev setsp steps 
:iabbrev midn mind
:iabbrev cuasued caused
:iabbrev frmework framework
:iabbrev knwo know
:iabbrev ahve have
:iabbrev delet delete
:iabbrev contes contents
:iabbrev develoepment developement
:iabbrev dvelopement developement 
:iabbrev bene been
:iabbrev osrt sort
:iabbrev cuold could
:iabbrev tema team
:iabbrev chdkign checking
:iabbrev asseum assume
:iabbrev allcoated allcoated
:iabbrev assuem assume
:iabbrev aslo also
:iabbrev htere there
:iabbrev fo of
:iabbrev form ffrom
:iabbrev form from
:iabbrev fro for
:iabbrev ofr for
:iabbrev purhcasing purchasing
:iabbrev oru our
:iabbrev correspondign corresponding
:iabbrev acocunt account
:iabbrev amrutha amrutha
:iabbrev cna can
:iabbrev departmetn department
:iabbrev statemnet statemtns
:iabbrev purhcase purchase
:iabbrev anyalyzed analyzed
:iabbrev checkingm checking,
:iabbrev follwo follow
:iabbrev configuratino configuration
:iabbrev preivous previous
:iabbrev te the
:iabbrev iteslefr iteslf
:iabbrev iteslefr itself
:iabbrev docuemnt document
:iabbrev Emaila email
:iabbrev ntoe note
:iabbrev realted related
:iabbrev screenshost screenshot
:iabbrev oyou your
:iabbrev Exaxct exact 
:iabbrev Hit Hi 
:iabbrev ip IP 
:iabbrev odmain domain
:iabbrev websithe website
:iabbrev celar clear
:iabbrev nto not
:iabbrev coudl could
:iabbrev dashobard dashboard
:iabbrev msising missing
:iabbrev NOte Note
:iabbrev alos also 
:iabbrev migraiton migration
:iabbrev complted completed
:iabbrev statu status
:iabbrev su uus
:iabbrev passowrd password
:iabbrev konw know
:iabbrev clietnzone clientzone
:iabbrev Noet note
:iabbrev hte the
:iabbrev ifner infer
:iabbrev clientozne clientZone
:iabbrev woudl would
:iabbrev ahving having
:iabbrev subscdription subscription 
:iabbrev isntallation installation
:iabbrev pirmary primary
:iabbrev porivde provide
:iabbrev loding loading
:iabbrev inconvinience inconvenience
:iabbrev laoding loading
:iabbrev nkow know
:iabbrev wokring working
:iabbrev recordsare records
:iabbrev mgiration migration
:iabbrev wiht with
:iabbrev tghouhg though
:iabbrev thei this
:iabbrev currnet current
:iabbrev frmae frame
:iabbrev webiste website
:iabbrev ocntea contact
:iabbrev knidly kindly
:iabbrev tjhe the
:iabbrev escalted escalated
:iabbrev clinets clients
:iabbrev tnoe note
:iabbrev snot not
:iabbrev ferom from
:iabbrev infomration information
:iabbrev kinlyd kindly
:iabbrev However However,
:iabbrev poitned pointed
:iabbrev ther there,
:iabbrev ONce Once
:iabbrev jnwo know
:iabbrev copntents contents
:iabbrev yu you
:iabbrev pervious previous 
:iabbrev reocrds records
:iabbrev mnetioned mentioned
:iabbrev Afriohst Afrihost 
:nnoremap <Leader>sn :set number<CR>
:nnoremap <Leader>hn :set nonumber<CR>
:iabbrev omdain domain
:iabbrev rougint routing
:iabbrev pleaes please
:iabbrev detaisl details
:iabbrev bakc back
:iabbrev omdin domain
:iabbrev noet note
:iabbrev checkign checking,
:iabbrev poitns points
:iabbrev directoreis directories
:iabbrev dksik disk
:iabbrev anem name
:iabbrev anda and
:iabbrev bakcup backup 
:iabbrev iwht with
:iabbrev indicates indicates
:iabbrev iwth with
:iabbrev rpimrary primary
:iabbrev webstite website
:iabbrev changin changing
:iabbrev arleady already
:iabbrev Coudl Could
:iabbrev subomdinas subdomains,
:iabbrev ufrther further
:iabbrev awre aware
:iabbrev tonctact contact
:iabbrev helko hello
