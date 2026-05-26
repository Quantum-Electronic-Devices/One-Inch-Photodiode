\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{datasheet}[2026-05-26 LaTexX datasheet class]

% --------------------------------------------------------------------------
% Base class
% --------------------------------------------------------------------------

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\LoadClass[
    twocolumn,
    parskip=half,
    headings=normal
]{scrartcl}

% --------------------------------------------------------------------------
% Packages
% --------------------------------------------------------------------------

\RequirePackage{xcolor}

\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{tabularx}
\RequirePackage{threeparttable}

\RequirePackage[
    font=bf,
    skip=5pt,
    justification=raggedright,
    format=hang,
    singlelinecheck=off
]{caption}

\RequirePackage[pdfusetitle]{hyperref}

\hypersetup{
    colorlinks=true,
    linkcolor=.,
    urlcolor=blue
}

\RequirePackage[
    left=2cm,
    top=2cm,
    right=2cm,
    bottom=3.5cm
]{geometry}

\RequirePackage{lastpage}
\RequirePackage{scrlayer-scrpage}

% --------------------------------------------------------------------------
% User commands
% --------------------------------------------------------------------------

% Company logo
\newcommand{\@companylogo}{}
\newcommand{\companylogo}[1]{%
    \gdef\@companylogo{#1}%
}

% Revision identifier
\newcommand{\@revision}{}
\newcommand{\revision}[1]{%
    \gdef\@revision{#1}%
}

% Optional running logo for headers
\newcommand{\@headerlogo}{}
\newcommand{\headerlogo}[1]{%
    \gdef\@headerlogo{#1}%
}

% --------------------------------------------------------------------------
% General typography
% --------------------------------------------------------------------------

\setlength{\parindent}{0pt}

% Section appearance
\RedeclareSectionCommand[
    beforeskip=-3.5ex plus -2ex minus -1ex,
    afterskip=2.5ex plus .5ex,
    font=\Large\bfseries\sffamily
]{section}

% No section numbering
\setcounter{secnumdepth}{0}

% No line above footnotes
\renewcommand\footnoterule{}

% Table spacing
\renewcommand{\arraystretch}{1.5}

\newcommand{\thickhline}{%
    \noalign{\ifnum0=`}\fi
    \hrule height 1pt
    \futurelet\reserved@a\@xhline
}

% --------------------------------------------------------------------------
% Page styles with scrlayer-scrpage
% --------------------------------------------------------------------------

\setkomafont{pageheadfoot}{\normalfont\rmfamily}

% First page style. Do not print a header
\newpairofpagestyles[scrheadings]{firstpage}{
    % Footer
    \ifoot{\@revision}
    \cfoot{\@date}
    \ofoot{Page \thepage\ of \pageref{LastPage}}
    % Only footer line
    \KOMAoptions{
        footsepline = 0.5pt
    }
}
\ModifyLayer[addvoffset=-2pt]{firstpage.foot.above.line}

% All other pages. Print header.
\newpairofpagestyles[scrheadings]{datasheetStyle}{
    % Header
    \ihead{\@author}
    \chead{\@title}
    \ohead{\@date}
    % Footer
    \ifoot{\@revision}
    \cfoot{\@date}
    \ofoot{Page \thepage\ of \pageref{LastPage}}
    % Rules
    \KOMAoptions{
        headsepline = 0.5pt,
        footsepline = 0.5pt
    }
}

\ModifyLayer[addvoffset=-2pt]{datasheetStyle.foot.above.line}

\pagestyle{datasheetStyle}

% --------------------------------------------------------------------------
% Title layout
% --------------------------------------------------------------------------

\renewcommand{\maketitle}{%
    \twocolumn[%
        \@companylogo

        \vspace{0.95cm}

        {\Huge\sffamily\bfseries\@title\par}

        \rule{\textwidth}{1.5pt}

        \vspace{0.6cm}
    ]
    \thispagestyle{firstpage}
}
