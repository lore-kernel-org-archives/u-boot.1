Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FA2FD376C
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6BD83F61;
	Wed, 25 Feb 2026 16:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MZwSiT22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605F883F61; Wed, 25 Feb 2026 16:42:25 +0100 (CET)
Received: from mail-yx1-xb133.google.com (unknown
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B9883E7A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64c9fcc24b3so1630928d50.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772034104; cv=none;
 d=google.com; s=arc-20240605;
 b=emq6NROi0IGvlre8Q2jot3dDHsj6zaNrnVCOTvyu1tkbjzIJUdr+OWocXHCQOvrXRJ
 OhKYh/o/VGI94YUu0VHi7Z+uDcTq+mY2IdRRyK9DPvH3R/hD80SzdfBkELV9lVAA1I91
 j/wrWPvXl00ZuOakfBTOqXCxTBprPng10F8cUdB9X9QBMqUWPJV29ZmcClM67mn6I3Jx
 OyZrLRYB0P6urmBqFJiHYJOzuC4SDWilVxg6bpqSuaG846Ml3wakrJwYRyydPC0X4a1W
 n8Flt53Cc/OjfBHBBUqfRsCRwDqng9c9taT6KgbrovfhJNXDCOj/qhvY9kyS9XmiYvHF
 t4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2Q7mU8Bfx+2YDmlLl7idEfgwjwE/aQFJtl5XELT5bWQ=;
 fh=gpYglHX6zInRvNI0lH9QqaScl7+ezfqHZaOqsiA76vQ=;
 b=k6w2p3ADAg+kKWkefF7QOFtfAsfJCc25J2zemBTaLhT2/wst2H5VqEDH0xGFMVjoHG
 tzfg7TC3jSZvJqJRslULREBh3HlB1DU7b4nJqVS2KjHaEIPuGjEC9s4nRoP4ZPzy2UUZ
 Z8ev5tOr77Xj5uFzcHtdxtpl0o/ACn2iiOArtgYHLxL6jscBPVg7bdT6wzoSDf4yq9kc
 LcT3Rhja/vJgEANQaMdVgeNZ9NmOYJf4rK5pJGTafEUFTD9bRWYR2eMG7reothoQWt7y
 DW56hPPMCjoCOAsToRXQbl2Xy51zgtUsZ88e5OC3NJHSnS2oeJ1ZQDh82Gg49ECABrQU
 OR3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772034104; x=1772638904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2Q7mU8Bfx+2YDmlLl7idEfgwjwE/aQFJtl5XELT5bWQ=;
 b=MZwSiT222zs3ota+PXUC+cPgawHeJFl/7CtMetQQnsZMpqRv9wXEXdk4ZeqO/cyang
 mrcEMNkWGOZ4MxWaChnHi+jwZpy0AKF4U2Q9UuwsqMxfRbVCaddQQxw5s164AxzUP1ka
 +Lo6xAGiJfi1HnTchpqDsVxcPrz5JzNY0bTQUMgOK2R/dnnJBXLjMWHV3mE9pWIaGnKr
 XiGtfP7P8N93a9+J2wNymlcnN3H45kNm4p7vBvil4kxpkf5AkNcFII6Jeb69jhq5sT4P
 4CuykXxTd46lJYF+5Xj1rxsEfhu2CS661Mrhyn3LLJ0nhKXyxwBV5gSwGwPh69pWtmXW
 6LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772034104; x=1772638904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Q7mU8Bfx+2YDmlLl7idEfgwjwE/aQFJtl5XELT5bWQ=;
 b=K5ptRMbfr/RtaOarOTS4mGt3sj/y75Hy9ooXyDupIoITF6AfZtUPpRDbDvCUfIOCRH
 /+roiKunUngerGOPR/kr/r/CMWaVuTirDBdbDKOVZM669Q5YYyzpp8YlTqvo19jnDLmD
 KhLcv7FBdFGLDBV6ROkyBvr4s5ZTIUJWvGMwq6s8sZivmJGXDY2spuynaQjPPiYj2EZY
 h1Vv+3P6HTu9EjHkJvkJ0flQP+BMkrsNLybbEQncWdKW88VJnUdVCrb/2PxCBTvpuO5T
 r1BhCtbiQDOQpR1bFFDg9J0HTXpwpfgtPBP0qdOliWmn55f8kzmnwAR6FuJJKbf9xGvJ
 XirA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRHK7htXY4xU6+KKzlT+37JXUqQxUvWuBfU7SYkqg93WpZOEZH0iz03RZuZmKkv4Z4GwTggHo=@lists.denx.de
X-Gm-Message-State: AOJu0YxDV+d85qFznOsr3VjzvY87JnDjPibfJcHV4d4KkUP+Y9hoAUBH
 qQE1x1LP03u2ee97Hfgezj0cSv/UrGqp3HTRfmWsqJwJzx9oLNsEirYdwgtwHzos0o0KNnO8NOP
 axRGjpCjuIQ54xfFpWRocIamw0SXyPc5Wm8dwYjDpRw==
X-Gm-Gg: ATEYQzxfzz1td5OZQVlND6xGvcxTbMv4WzaMNIhhJIc1mhSn8MTq/rX+yvj4RmwcpDP
 4NXrnDxdeM2MNFneVlYgWHtS7WjB4THS/4RaQ8Mo9gXuSJbT6dj2z/MoUC2OycRNFFhvYHj5yje
 Mz84fsReGsci2KbCjzUPgOhg30m3fiRikqpLTY9ExSD+IEf67fmthFB8ykV1KYcjVAAoBHLLK7I
 +Nyd4wRq+/gvXHr029S2orG8VK8l+w/3UX/0jp+eyjucgTVjozq1ZYhnAHr4Ssno/yOAnKpIdCk
 LhJTBC/rtCNESEnIa/GYFheRZyNDt+n7PauSZaAdwtP3d1rawlBi2vvZL0m/4N+kBCmk5G9/M8p
 ymIpZAflJxoC/q81hy/8x+hXbMqELdlZffvDUPdGOe6ROD0Y1hdRtDRDMsmB+2Uf3QAYo2RRef1
 nRE5sIh+q6zzhayOL6Ba6Ay+sMcRBZWwP0f7/QzweUyRflkEJvU3FpaPjlXpLQyZv+3abPDM3NF
 4MumaQjSRBojYb3Fb0NYR5MvfPAKzwfrWF/jfdKtcXxTsfy5ecuEOWjavMKQ2vF+o82oaDiVVkZ
 O88tNWMnOIDUtGIA+RkOtid0rKim7jgaTKY/YNXVUzzQHDYNHrM9TA==
X-Received: by 2002:a05:690e:138d:b0:64c:9f69:ec43 with SMTP id
 956f58d0204a3-64c9f69ece2mr4926347d50.21.1772034103863; Wed, 25 Feb 2026
 07:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Feb 2026 17:41:08 +0200
X-Gm-Features: AaiRm50GLwJpCTwsWWvhFze-fmZK_U_bMpDXTrIlUZ9yhHc8rxsM7Bb7kxph-2A
Message-ID: <CAC_iWjLK47e_6=PcAyDeU_FdtkUDa1N+iN9NekXhpTfv15Hwaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts: add checkkconfigsymbols.py
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, 25 Feb 2026 at 15:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add checkkconfigsymbols.py from Linux 7.0-rc1 (unchanged since v6.2).
> This tool allows to identify the usage of symbols that are not defined
> in Kconfig.
>
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/checkkconfigsymbols.py | 482 +++++++++++++++++++++++++++++++++
>  1 file changed, 482 insertions(+)
>  create mode 100755 scripts/checkkconfigsymbols.py
>
> diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbols.py
> new file mode 100755
> index 00000000000..36c920e7131
> --- /dev/null
> +++ b/scripts/checkkconfigsymbols.py
> @@ -0,0 +1,482 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +"""Find Kconfig symbols that are referenced but not defined."""
> +
> +# (c) 2014-2017 Valentin Rothberg <valentinrothberg@gmail.com>
> +# (c) 2014 Stefan Hengelein <stefan.hengelein@fau.de>
> +#
> +
> +
> +import argparse
> +import difflib
> +import os
> +import re
> +import signal
> +import subprocess
> +import sys
> +from multiprocessing import Pool, cpu_count
> +
> +
> +# regex expressions
> +OPERATORS = r"&|\(|\)|\||\!"
> +SYMBOL = r"(?:\w*[A-Z0-9]\w*){2,}"
> +DEF = r"^\s*(?:menu){,1}config\s+(" + SYMBOL + r")\s*"
> +EXPR = r"(?:" + OPERATORS + r"|\s|" + SYMBOL + r")+"
> +DEFAULT = r"default\s+.*?(?:if\s.+){,1}"
> +STMT = r"^\s*(?:if|select|imply|depends\s+on|(?:" + DEFAULT + r"))\s+" + EXPR
> +SOURCE_SYMBOL = r"(?:\W|\b)+[D]{,1}CONFIG_(" + SYMBOL + r")"
> +
> +# regex objects
> +REGEX_FILE_KCONFIG = re.compile(r".*Kconfig[\.\w+\-]*$")
> +REGEX_SYMBOL = re.compile(r'(?!\B)' + SYMBOL + r'(?!\B)')
> +REGEX_SOURCE_SYMBOL = re.compile(SOURCE_SYMBOL)
> +REGEX_KCONFIG_DEF = re.compile(DEF)
> +REGEX_KCONFIG_EXPR = re.compile(EXPR)
> +REGEX_KCONFIG_STMT = re.compile(STMT)
> +REGEX_FILTER_SYMBOLS = re.compile(r"[A-Za-z0-9]$")
> +REGEX_NUMERIC = re.compile(r"0[xX][0-9a-fA-F]+|[0-9]+")
> +REGEX_QUOTES = re.compile("(\"(.*?)\")")
> +
> +
> +def parse_options():
> +    """The user interface of this module."""
> +    usage = "Run this tool to detect Kconfig symbols that are referenced but " \
> +            "not defined in Kconfig.  If no option is specified, "             \
> +            "checkkconfigsymbols defaults to check your current tree.  "       \
> +            "Please note that specifying commits will 'git reset --hard\' "    \
> +            "your current tree!  You may save uncommitted changes to avoid "   \
> +            "losing data."
> +
> +    parser = argparse.ArgumentParser(description=usage)
> +
> +    parser.add_argument('-c', '--commit', dest='commit', action='store',
> +                        default="",
> +                        help="check if the specified commit (hash) introduces "
> +                             "undefined Kconfig symbols")
> +
> +    parser.add_argument('-d', '--diff', dest='diff', action='store',
> +                        default="",
> +                        help="diff undefined symbols between two commits "
> +                             "(e.g., -d commmit1..commit2)")
> +
> +    parser.add_argument('-f', '--find', dest='find', action='store_true',
> +                        default=False,
> +                        help="find and show commits that may cause symbols to be "
> +                             "missing (required to run with --diff)")
> +
> +    parser.add_argument('-i', '--ignore', dest='ignore', action='store',
> +                        default="",
> +                        help="ignore files matching this Python regex "
> +                             "(e.g., -i '.*defconfig')")
> +
> +    parser.add_argument('-s', '--sim', dest='sim', action='store', default="",
> +                        help="print a list of max. 10 string-similar symbols")
> +
> +    parser.add_argument('--force', dest='force', action='store_true',
> +                        default=False,
> +                        help="reset current Git tree even when it's dirty")
> +
> +    parser.add_argument('--no-color', dest='color', action='store_false',
> +                        default=True,
> +                        help="don't print colored output (default when not "
> +                             "outputting to a terminal)")
> +
> +    args = parser.parse_args()
> +
> +    if args.commit and args.diff:
> +        sys.exit("Please specify only one option at once.")
> +
> +    if args.diff and not re.match(r"^[\w\-\.\^]+\.\.[\w\-\.\^]+$", args.diff):
> +        sys.exit("Please specify valid input in the following format: "
> +                 "\'commit1..commit2\'")
> +
> +    if args.commit or args.diff:
> +        if not args.force and tree_is_dirty():
> +            sys.exit("The current Git tree is dirty (see 'git status').  "
> +                     "Running this script may\ndelete important data since it "
> +                     "calls 'git reset --hard' for some performance\nreasons. "
> +                     " Please run this script in a clean Git tree or pass "
> +                     "'--force' if you\nwant to ignore this warning and "
> +                     "continue.")
> +
> +    if args.commit:
> +        if args.commit.startswith('HEAD'):
> +            sys.exit("The --commit option can't use the HEAD ref")
> +
> +        args.find = False
> +
> +    if args.ignore:
> +        try:
> +            re.match(args.ignore, "this/is/just/a/test.c")
> +        except:
> +            sys.exit("Please specify a valid Python regex.")
> +
> +    return args
> +
> +
> +def print_undefined_symbols():
> +    """Main function of this module."""
> +    args = parse_options()
> +
> +    global COLOR
> +    COLOR = args.color and sys.stdout.isatty()
> +
> +    if args.sim and not args.commit and not args.diff:
> +        sims = find_sims(args.sim, args.ignore)
> +        if sims:
> +            print("%s: %s" % (yel("Similar symbols"), ', '.join(sims)))
> +        else:
> +            print("%s: no similar symbols found" % yel("Similar symbols"))
> +        sys.exit(0)
> +
> +    # dictionary of (un)defined symbols
> +    defined = {}
> +    undefined = {}
> +
> +    if args.commit or args.diff:
> +        head = get_head()
> +
> +        # get commit range
> +        commit_a = None
> +        commit_b = None
> +        if args.commit:
> +            commit_a = args.commit + "~"
> +            commit_b = args.commit
> +        elif args.diff:
> +            split = args.diff.split("..")
> +            commit_a = split[0]
> +            commit_b = split[1]
> +            undefined_a = {}
> +            undefined_b = {}
> +
> +        # get undefined items before the commit
> +        reset(commit_a)
> +        undefined_a, _ = check_symbols(args.ignore)
> +
> +        # get undefined items for the commit
> +        reset(commit_b)
> +        undefined_b, defined = check_symbols(args.ignore)
> +
> +        # report cases that are present for the commit but not before
> +        for symbol in sorted(undefined_b):
> +            # symbol has not been undefined before
> +            if symbol not in undefined_a:
> +                files = sorted(undefined_b.get(symbol))
> +                undefined[symbol] = files
> +            # check if there are new files that reference the undefined symbol
> +            else:
> +                files = sorted(undefined_b.get(symbol) -
> +                               undefined_a.get(symbol))
> +                if files:
> +                    undefined[symbol] = files
> +
> +        # reset to head
> +        reset(head)
> +
> +    # default to check the entire tree
> +    else:
> +        undefined, defined = check_symbols(args.ignore)
> +
> +    # now print the output
> +    for symbol in sorted(undefined):
> +        print(red(symbol))
> +
> +        files = sorted(undefined.get(symbol))
> +        print("%s: %s" % (yel("Referencing files"), ", ".join(files)))
> +
> +        sims = find_sims(symbol, args.ignore, defined)
> +        sims_out = yel("Similar symbols")
> +        if sims:
> +            print("%s: %s" % (sims_out, ', '.join(sims)))
> +        else:
> +            print("%s: %s" % (sims_out, "no similar symbols found"))
> +
> +        if args.find:
> +            print("%s:" % yel("Commits changing symbol"))
> +            commits = find_commits(symbol, args.diff)
> +            if commits:
> +                for commit in commits:
> +                    commit = commit.split(" ", 1)
> +                    print("\t- %s (\"%s\")" % (yel(commit[0]), commit[1]))
> +            else:
> +                print("\t- no commit found")
> +        print()  # new line
> +
> +
> +def reset(commit):
> +    """Reset current git tree to %commit."""
> +    execute(["git", "reset", "--hard", commit])
> +
> +
> +def yel(string):
> +    """
> +    Color %string yellow.
> +    """
> +    return "\033[33m%s\033[0m" % string if COLOR else string
> +
> +
> +def red(string):
> +    """
> +    Color %string red.
> +    """
> +    return "\033[31m%s\033[0m" % string if COLOR else string
> +
> +
> +def execute(cmd):
> +    """Execute %cmd and return stdout.  Exit in case of error."""
> +    try:
> +        stdout = subprocess.check_output(cmd, stderr=subprocess.STDOUT, shell=False)
> +        stdout = stdout.decode(errors='replace')
> +    except subprocess.CalledProcessError as fail:
> +        exit(fail)
> +    return stdout
> +
> +
> +def find_commits(symbol, diff):
> +    """Find commits changing %symbol in the given range of %diff."""
> +    commits = execute(["git", "log", "--pretty=oneline",
> +                       "--abbrev-commit", "-G",
> +                       symbol, diff])
> +    return [x for x in commits.split("\n") if x]
> +
> +
> +def tree_is_dirty():
> +    """Return true if the current working tree is dirty (i.e., if any file has
> +    been added, deleted, modified, renamed or copied but not committed)."""
> +    stdout = execute(["git", "status", "--porcelain"])
> +    for line in stdout:
> +        if re.findall(r"[URMADC]{1}", line[:2]):
> +            return True
> +    return False
> +
> +
> +def get_head():
> +    """Return commit hash of current HEAD."""
> +    stdout = execute(["git", "rev-parse", "HEAD"])
> +    return stdout.strip('\n')
> +
> +
> +def partition(lst, size):
> +    """Partition list @lst into eveni-sized lists of size @size."""
> +    return [lst[i::size] for i in range(size)]
> +
> +
> +def init_worker():
> +    """Set signal handler to ignore SIGINT."""
> +    signal.signal(signal.SIGINT, signal.SIG_IGN)
> +
> +
> +def find_sims(symbol, ignore, defined=[]):
> +    """Return a list of max. ten Kconfig symbols that are string-similar to
> +    @symbol."""
> +    if defined:
> +        return difflib.get_close_matches(symbol, set(defined), 10)
> +
> +    pool = Pool(cpu_count(), init_worker)
> +    kfiles = []
> +    for gitfile in get_files():
> +        if REGEX_FILE_KCONFIG.match(gitfile):
> +            kfiles.append(gitfile)
> +
> +    arglist = []
> +    for part in partition(kfiles, cpu_count()):
> +        arglist.append((part, ignore))
> +
> +    for res in pool.map(parse_kconfig_files, arglist):
> +        defined.extend(res[0])
> +
> +    return difflib.get_close_matches(symbol, set(defined), 10)
> +
> +
> +def get_files():
> +    """Return a list of all files in the current git directory."""
> +    # use 'git ls-files' to get the worklist
> +    stdout = execute(["git", "ls-files"])
> +    if len(stdout) > 0 and stdout[-1] == "\n":
> +        stdout = stdout[:-1]
> +
> +    files = []
> +    for gitfile in stdout.rsplit("\n"):
> +        if ".git" in gitfile or "ChangeLog" in gitfile or      \
> +                ".log" in gitfile or os.path.isdir(gitfile) or \
> +                gitfile.startswith("tools/"):
> +            continue
> +        files.append(gitfile)
> +    return files
> +
> +
> +def check_symbols(ignore):
> +    """Find undefined Kconfig symbols and return a dict with the symbol as key
> +    and a list of referencing files as value.  Files matching %ignore are not
> +    checked for undefined symbols."""
> +    pool = Pool(cpu_count(), init_worker)
> +    try:
> +        return check_symbols_helper(pool, ignore)
> +    except KeyboardInterrupt:
> +        pool.terminate()
> +        pool.join()
> +        sys.exit(1)
> +
> +
> +def check_symbols_helper(pool, ignore):
> +    """Helper method for check_symbols().  Used to catch keyboard interrupts in
> +    check_symbols() in order to properly terminate running worker processes."""
> +    source_files = []
> +    kconfig_files = []
> +    defined_symbols = []
> +    referenced_symbols = dict()  # {file: [symbols]}
> +
> +    for gitfile in get_files():
> +        if REGEX_FILE_KCONFIG.match(gitfile):
> +            kconfig_files.append(gitfile)
> +        else:
> +            if ignore and re.match(ignore, gitfile):
> +                continue
> +            # add source files that do not match the ignore pattern
> +            source_files.append(gitfile)
> +
> +    # parse source files
> +    arglist = partition(source_files, cpu_count())
> +    for res in pool.map(parse_source_files, arglist):
> +        referenced_symbols.update(res)
> +
> +    # parse kconfig files
> +    arglist = []
> +    for part in partition(kconfig_files, cpu_count()):
> +        arglist.append((part, ignore))
> +    for res in pool.map(parse_kconfig_files, arglist):
> +        defined_symbols.extend(res[0])
> +        referenced_symbols.update(res[1])
> +    defined_symbols = set(defined_symbols)
> +
> +    # inverse mapping of referenced_symbols to dict(symbol: [files])
> +    inv_map = dict()
> +    for _file, symbols in referenced_symbols.items():
> +        for symbol in symbols:
> +            inv_map[symbol] = inv_map.get(symbol, set())
> +            inv_map[symbol].add(_file)
> +    referenced_symbols = inv_map
> +
> +    undefined = {}  # {symbol: [files]}
> +    for symbol in sorted(referenced_symbols):
> +        # filter some false positives
> +        if symbol == "FOO" or symbol == "BAR" or \
> +                symbol == "FOO_BAR" or symbol == "XXX":
> +            continue
> +        if symbol not in defined_symbols:
> +            if symbol.endswith("_MODULE"):
> +                # avoid false positives for kernel modules
> +                if symbol[:-len("_MODULE")] in defined_symbols:
> +                    continue
> +            undefined[symbol] = referenced_symbols.get(symbol)
> +    return undefined, defined_symbols
> +
> +
> +def parse_source_files(source_files):
> +    """Parse each source file in @source_files and return dictionary with source
> +    files as keys and lists of references Kconfig symbols as values."""
> +    referenced_symbols = dict()
> +    for sfile in source_files:
> +        referenced_symbols[sfile] = parse_source_file(sfile)
> +    return referenced_symbols
> +
> +
> +def parse_source_file(sfile):
> +    """Parse @sfile and return a list of referenced Kconfig symbols."""
> +    lines = []
> +    references = []
> +
> +    if not os.path.exists(sfile):
> +        return references
> +
> +    with open(sfile, "r", encoding='utf-8', errors='replace') as stream:
> +        lines = stream.readlines()
> +
> +    for line in lines:
> +        if "CONFIG_" not in line:
> +            continue
> +        symbols = REGEX_SOURCE_SYMBOL.findall(line)
> +        for symbol in symbols:
> +            if not REGEX_FILTER_SYMBOLS.search(symbol):
> +                continue
> +            references.append(symbol)
> +
> +    return references
> +
> +
> +def get_symbols_in_line(line):
> +    """Return mentioned Kconfig symbols in @line."""
> +    return REGEX_SYMBOL.findall(line)
> +
> +
> +def parse_kconfig_files(args):
> +    """Parse kconfig files and return tuple of defined and references Kconfig
> +    symbols.  Note, @args is a tuple of a list of files and the @ignore
> +    pattern."""
> +    kconfig_files = args[0]
> +    ignore = args[1]
> +    defined_symbols = []
> +    referenced_symbols = dict()
> +
> +    for kfile in kconfig_files:
> +        defined, references = parse_kconfig_file(kfile)
> +        defined_symbols.extend(defined)
> +        if ignore and re.match(ignore, kfile):
> +            # do not collect references for files that match the ignore pattern
> +            continue
> +        referenced_symbols[kfile] = references
> +    return (defined_symbols, referenced_symbols)
> +
> +
> +def parse_kconfig_file(kfile):
> +    """Parse @kfile and update symbol definitions and references."""
> +    lines = []
> +    defined = []
> +    references = []
> +
> +    if not os.path.exists(kfile):
> +        return defined, references
> +
> +    with open(kfile, "r", encoding='utf-8', errors='replace') as stream:
> +        lines = stream.readlines()
> +
> +    for i in range(len(lines)):
> +        line = lines[i]
> +        line = line.strip('\n')
> +        line = line.split("#")[0]  # ignore comments
> +
> +        if REGEX_KCONFIG_DEF.match(line):
> +            symbol_def = REGEX_KCONFIG_DEF.findall(line)
> +            defined.append(symbol_def[0])
> +        elif REGEX_KCONFIG_STMT.match(line):
> +            line = REGEX_QUOTES.sub("", line)
> +            symbols = get_symbols_in_line(line)
> +            # multi-line statements
> +            while line.endswith("\\"):
> +                i += 1
> +                line = lines[i]
> +                line = line.strip('\n')
> +                symbols.extend(get_symbols_in_line(line))
> +            for symbol in set(symbols):
> +                if REGEX_NUMERIC.match(symbol):
> +                    # ignore numeric values
> +                    continue
> +                references.append(symbol)
> +
> +    return defined, references
> +
> +
> +def main():
> +    try:
> +        print_undefined_symbols()
> +    except BrokenPipeError:
> +        # Python flushes standard streams on exit; redirect remaining output
> +        # to devnull to avoid another BrokenPipeError at shutdown
> +        devnull = os.open(os.devnull, os.O_WRONLY)
> +        os.dup2(devnull, sys.stdout.fileno())
> +        sys.exit(1)  # Python exits with error code 1 on EPIPE
> +
> +
> +if __name__ == "__main__":
> +    main()
> --
> 2.51.0
>
