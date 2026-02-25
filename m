Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB28FD375D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2952E83E61;
	Wed, 25 Feb 2026 14:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QdueNFvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EA083E63; Wed, 25 Feb 2026 14:11:31 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD42383E36
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 875B53F201
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772025055;
 bh=GmeOg8P+FjJPUlyraM8eHlwpprsOFiG4ja521dq9wvc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QdueNFvUQDmUuzB5U3MSFnNsJZxMwvY3HgYJ4tCI6X/mQf7BWNjLvVKe3ylzTBeCh
 VxHIOGz93+7XXvEIXt8toe+1CJMCYywzqEwVnaC3kQOeifva10Oxs8P2oGvHXpEAow
 TrJGFnhLdXBiPFM3ph9RdhI0ksQTLeuKSkPQKEW5lp/XKLbUc8kFcgKU3FBA3Jt/8T
 S2ZmpXmQTG1/109PSdEXUvByerm7Dd3Hvra5ibWrAZQ4wTz42oTIlFvfC8MZBimrrD
 wTsqJCYpdGsQghr0iYEDdt9C2B+NbaocPU0sDrtOobpnscXAdFZB8nw918lpxTJtJv
 4VCZZIr3P1FXLPq0kNomE2c8ArTPGH/xXCmRMEowOd2yXrg7/0WexUTlNgVg5cJEuQ
 10xNIuxVn+wHlL2A5XvVJwnLdKNEzul12dx54eNdYzoAbaitL6klOfxaA2MoBJ/BrB
 DjNxUJIc6FnGF5ABUzFrlDuyfhUhys0zo91m8ws/ybzwiB6kz0ogZih15+ED63uRkt
 w20LTINO/JSzH6LLoXE0trzHTNdtBEcdpPN+gUzB5XJE0WzdBK0+6EX4XrTgpPnD0V
 krOdQhfYCorBg9oVyuIls0aCkTnadtDYYZtdWyVpYdOLzHhDMITZ7+BQCp3FZG39VL
 azE/X8RzFGCqzq1DPI8RSXmI=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-436267b01c4so6568244f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 05:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772025055; x=1772629855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmeOg8P+FjJPUlyraM8eHlwpprsOFiG4ja521dq9wvc=;
 b=O5AoGyupk/203ElK1Np4AcWt+DlF+2BClMRGxfJmQUprPyFNLT94XiX4xQhjT1OxgB
 TaZRME0s0ODf6XKFttYiRY3ch8ooHqhYG2qumDCWO1MLpYkEo07PNAUnZYsg5Vnewvj0
 mKkoefLCn3H9IINl5XT3P+YjWSq32TIhxQ33ZaxM3Ip2GTdh4VIi3+uEIDEtLbkp2Jiw
 uFDqiAf+4AI0hgDKhWXVk/IrnMrJo8wZFoXZ8pWxxQ5YpEwq+YVcqIQQnnTuWkns23of
 28IOdc8mQ8lyi7Mhee+0hNg66Y4QeZd0t0ftiM82hPPxbh4hMCvOGQkEiCinhyyssZ3T
 PcIQ==
X-Gm-Message-State: AOJu0Yw3YaKRMLrlOFtRQjKVTpTHblk3DIOmKhcmYw/tDR+ieSUmTwcv
 3DMmqAc13nlVrcKPR1jtijqGVYuil8UdA/IgNJ+FXALvCU85XBDfrP4OE5Rnf+bpcESzkqfslUR
 dY4SAl9k6x31KguGTgQ51XnjFtBO66oscvM5OOarTsPqBcqRDSC01BkAQEMmr8Cy9BBG6g+o=
X-Gm-Gg: ATEYQzygqSUq94rqdR/XH26xIqzle+Dz+09ADXoGKIoU+JNUpL5USU1YuMbDcJvfbbZ
 clnxSJ+74pvRrBK97iWXtA30eAqNplSGygtmdGw6abE/ZWlXFK+i2JnXx+05nB821eqO3cZ4Hpf
 IOqXwTomCj8Us0qTUw6oRlQY1wREEcyctQCn9PHWyXN588iiAfVY4UPWDpwAL6+nn+svLCFFZ6W
 oOQtWimaPmshqOeW7yhcwBBQVg8zLLl/32W0AbkFtiA6+Vy0JTmDYBloEJ+pqBxY2x0YuYUB3Ti
 bBmwCLy3TjPydFazUhga4G6wdr0c28qxc64shFNbdmxjLqtljKOasss+ycvGjnFRxsuskEdzJMl
 kuiLnFkVBMYDEekSxh2WWijj+NEZbyCN2yZYaxcSUO9e5YQjXV9K9OEG8P4WDC86xZ+gM90XJ18
 7/j4SxcSDnw9mpmg/9xmtCYdCgU6jjhmQFYYq//qsMt+DC
X-Received: by 2002:a05:6000:2c0e:b0:436:da9:4371 with SMTP id
 ffacd0b85a97d-4396f154441mr29156462f8f.5.1772025055014; 
 Wed, 25 Feb 2026 05:10:55 -0800 (PST)
X-Received: by 2002:a05:6000:2c0e:b0:436:da9:4371 with SMTP id
 ffacd0b85a97d-4396f154441mr29156417f8f.5.1772025054468; 
 Wed, 25 Feb 2026 05:10:54 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9fb2sm34479617f8f.1.2026.02.25.05.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 05:10:53 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] scripts: add checkkconfigsymbols.py
Date: Wed, 25 Feb 2026 14:10:51 +0100
Message-ID: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add checkkconfigsymbols.py from Linux 7.0-rc1 (unchanged since v6.2).
This tool allows to identify the usage of symbols that are not defined
in Kconfig.

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/checkkconfigsymbols.py | 482 +++++++++++++++++++++++++++++++++
 1 file changed, 482 insertions(+)
 create mode 100755 scripts/checkkconfigsymbols.py

diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbols.py
new file mode 100755
index 00000000000..36c920e7131
--- /dev/null
+++ b/scripts/checkkconfigsymbols.py
@@ -0,0 +1,482 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+"""Find Kconfig symbols that are referenced but not defined."""
+
+# (c) 2014-2017 Valentin Rothberg <valentinrothberg@gmail.com>
+# (c) 2014 Stefan Hengelein <stefan.hengelein@fau.de>
+#
+
+
+import argparse
+import difflib
+import os
+import re
+import signal
+import subprocess
+import sys
+from multiprocessing import Pool, cpu_count
+
+
+# regex expressions
+OPERATORS = r"&|\(|\)|\||\!"
+SYMBOL = r"(?:\w*[A-Z0-9]\w*){2,}"
+DEF = r"^\s*(?:menu){,1}config\s+(" + SYMBOL + r")\s*"
+EXPR = r"(?:" + OPERATORS + r"|\s|" + SYMBOL + r")+"
+DEFAULT = r"default\s+.*?(?:if\s.+){,1}"
+STMT = r"^\s*(?:if|select|imply|depends\s+on|(?:" + DEFAULT + r"))\s+" + EXPR
+SOURCE_SYMBOL = r"(?:\W|\b)+[D]{,1}CONFIG_(" + SYMBOL + r")"
+
+# regex objects
+REGEX_FILE_KCONFIG = re.compile(r".*Kconfig[\.\w+\-]*$")
+REGEX_SYMBOL = re.compile(r'(?!\B)' + SYMBOL + r'(?!\B)')
+REGEX_SOURCE_SYMBOL = re.compile(SOURCE_SYMBOL)
+REGEX_KCONFIG_DEF = re.compile(DEF)
+REGEX_KCONFIG_EXPR = re.compile(EXPR)
+REGEX_KCONFIG_STMT = re.compile(STMT)
+REGEX_FILTER_SYMBOLS = re.compile(r"[A-Za-z0-9]$")
+REGEX_NUMERIC = re.compile(r"0[xX][0-9a-fA-F]+|[0-9]+")
+REGEX_QUOTES = re.compile("(\"(.*?)\")")
+
+
+def parse_options():
+    """The user interface of this module."""
+    usage = "Run this tool to detect Kconfig symbols that are referenced but " \
+            "not defined in Kconfig.  If no option is specified, "             \
+            "checkkconfigsymbols defaults to check your current tree.  "       \
+            "Please note that specifying commits will 'git reset --hard\' "    \
+            "your current tree!  You may save uncommitted changes to avoid "   \
+            "losing data."
+
+    parser = argparse.ArgumentParser(description=usage)
+
+    parser.add_argument('-c', '--commit', dest='commit', action='store',
+                        default="",
+                        help="check if the specified commit (hash) introduces "
+                             "undefined Kconfig symbols")
+
+    parser.add_argument('-d', '--diff', dest='diff', action='store',
+                        default="",
+                        help="diff undefined symbols between two commits "
+                             "(e.g., -d commmit1..commit2)")
+
+    parser.add_argument('-f', '--find', dest='find', action='store_true',
+                        default=False,
+                        help="find and show commits that may cause symbols to be "
+                             "missing (required to run with --diff)")
+
+    parser.add_argument('-i', '--ignore', dest='ignore', action='store',
+                        default="",
+                        help="ignore files matching this Python regex "
+                             "(e.g., -i '.*defconfig')")
+
+    parser.add_argument('-s', '--sim', dest='sim', action='store', default="",
+                        help="print a list of max. 10 string-similar symbols")
+
+    parser.add_argument('--force', dest='force', action='store_true',
+                        default=False,
+                        help="reset current Git tree even when it's dirty")
+
+    parser.add_argument('--no-color', dest='color', action='store_false',
+                        default=True,
+                        help="don't print colored output (default when not "
+                             "outputting to a terminal)")
+
+    args = parser.parse_args()
+
+    if args.commit and args.diff:
+        sys.exit("Please specify only one option at once.")
+
+    if args.diff and not re.match(r"^[\w\-\.\^]+\.\.[\w\-\.\^]+$", args.diff):
+        sys.exit("Please specify valid input in the following format: "
+                 "\'commit1..commit2\'")
+
+    if args.commit or args.diff:
+        if not args.force and tree_is_dirty():
+            sys.exit("The current Git tree is dirty (see 'git status').  "
+                     "Running this script may\ndelete important data since it "
+                     "calls 'git reset --hard' for some performance\nreasons. "
+                     " Please run this script in a clean Git tree or pass "
+                     "'--force' if you\nwant to ignore this warning and "
+                     "continue.")
+
+    if args.commit:
+        if args.commit.startswith('HEAD'):
+            sys.exit("The --commit option can't use the HEAD ref")
+
+        args.find = False
+
+    if args.ignore:
+        try:
+            re.match(args.ignore, "this/is/just/a/test.c")
+        except:
+            sys.exit("Please specify a valid Python regex.")
+
+    return args
+
+
+def print_undefined_symbols():
+    """Main function of this module."""
+    args = parse_options()
+
+    global COLOR
+    COLOR = args.color and sys.stdout.isatty()
+
+    if args.sim and not args.commit and not args.diff:
+        sims = find_sims(args.sim, args.ignore)
+        if sims:
+            print("%s: %s" % (yel("Similar symbols"), ', '.join(sims)))
+        else:
+            print("%s: no similar symbols found" % yel("Similar symbols"))
+        sys.exit(0)
+
+    # dictionary of (un)defined symbols
+    defined = {}
+    undefined = {}
+
+    if args.commit or args.diff:
+        head = get_head()
+
+        # get commit range
+        commit_a = None
+        commit_b = None
+        if args.commit:
+            commit_a = args.commit + "~"
+            commit_b = args.commit
+        elif args.diff:
+            split = args.diff.split("..")
+            commit_a = split[0]
+            commit_b = split[1]
+            undefined_a = {}
+            undefined_b = {}
+
+        # get undefined items before the commit
+        reset(commit_a)
+        undefined_a, _ = check_symbols(args.ignore)
+
+        # get undefined items for the commit
+        reset(commit_b)
+        undefined_b, defined = check_symbols(args.ignore)
+
+        # report cases that are present for the commit but not before
+        for symbol in sorted(undefined_b):
+            # symbol has not been undefined before
+            if symbol not in undefined_a:
+                files = sorted(undefined_b.get(symbol))
+                undefined[symbol] = files
+            # check if there are new files that reference the undefined symbol
+            else:
+                files = sorted(undefined_b.get(symbol) -
+                               undefined_a.get(symbol))
+                if files:
+                    undefined[symbol] = files
+
+        # reset to head
+        reset(head)
+
+    # default to check the entire tree
+    else:
+        undefined, defined = check_symbols(args.ignore)
+
+    # now print the output
+    for symbol in sorted(undefined):
+        print(red(symbol))
+
+        files = sorted(undefined.get(symbol))
+        print("%s: %s" % (yel("Referencing files"), ", ".join(files)))
+
+        sims = find_sims(symbol, args.ignore, defined)
+        sims_out = yel("Similar symbols")
+        if sims:
+            print("%s: %s" % (sims_out, ', '.join(sims)))
+        else:
+            print("%s: %s" % (sims_out, "no similar symbols found"))
+
+        if args.find:
+            print("%s:" % yel("Commits changing symbol"))
+            commits = find_commits(symbol, args.diff)
+            if commits:
+                for commit in commits:
+                    commit = commit.split(" ", 1)
+                    print("\t- %s (\"%s\")" % (yel(commit[0]), commit[1]))
+            else:
+                print("\t- no commit found")
+        print()  # new line
+
+
+def reset(commit):
+    """Reset current git tree to %commit."""
+    execute(["git", "reset", "--hard", commit])
+
+
+def yel(string):
+    """
+    Color %string yellow.
+    """
+    return "\033[33m%s\033[0m" % string if COLOR else string
+
+
+def red(string):
+    """
+    Color %string red.
+    """
+    return "\033[31m%s\033[0m" % string if COLOR else string
+
+
+def execute(cmd):
+    """Execute %cmd and return stdout.  Exit in case of error."""
+    try:
+        stdout = subprocess.check_output(cmd, stderr=subprocess.STDOUT, shell=False)
+        stdout = stdout.decode(errors='replace')
+    except subprocess.CalledProcessError as fail:
+        exit(fail)
+    return stdout
+
+
+def find_commits(symbol, diff):
+    """Find commits changing %symbol in the given range of %diff."""
+    commits = execute(["git", "log", "--pretty=oneline",
+                       "--abbrev-commit", "-G",
+                       symbol, diff])
+    return [x for x in commits.split("\n") if x]
+
+
+def tree_is_dirty():
+    """Return true if the current working tree is dirty (i.e., if any file has
+    been added, deleted, modified, renamed or copied but not committed)."""
+    stdout = execute(["git", "status", "--porcelain"])
+    for line in stdout:
+        if re.findall(r"[URMADC]{1}", line[:2]):
+            return True
+    return False
+
+
+def get_head():
+    """Return commit hash of current HEAD."""
+    stdout = execute(["git", "rev-parse", "HEAD"])
+    return stdout.strip('\n')
+
+
+def partition(lst, size):
+    """Partition list @lst into eveni-sized lists of size @size."""
+    return [lst[i::size] for i in range(size)]
+
+
+def init_worker():
+    """Set signal handler to ignore SIGINT."""
+    signal.signal(signal.SIGINT, signal.SIG_IGN)
+
+
+def find_sims(symbol, ignore, defined=[]):
+    """Return a list of max. ten Kconfig symbols that are string-similar to
+    @symbol."""
+    if defined:
+        return difflib.get_close_matches(symbol, set(defined), 10)
+
+    pool = Pool(cpu_count(), init_worker)
+    kfiles = []
+    for gitfile in get_files():
+        if REGEX_FILE_KCONFIG.match(gitfile):
+            kfiles.append(gitfile)
+
+    arglist = []
+    for part in partition(kfiles, cpu_count()):
+        arglist.append((part, ignore))
+
+    for res in pool.map(parse_kconfig_files, arglist):
+        defined.extend(res[0])
+
+    return difflib.get_close_matches(symbol, set(defined), 10)
+
+
+def get_files():
+    """Return a list of all files in the current git directory."""
+    # use 'git ls-files' to get the worklist
+    stdout = execute(["git", "ls-files"])
+    if len(stdout) > 0 and stdout[-1] == "\n":
+        stdout = stdout[:-1]
+
+    files = []
+    for gitfile in stdout.rsplit("\n"):
+        if ".git" in gitfile or "ChangeLog" in gitfile or      \
+                ".log" in gitfile or os.path.isdir(gitfile) or \
+                gitfile.startswith("tools/"):
+            continue
+        files.append(gitfile)
+    return files
+
+
+def check_symbols(ignore):
+    """Find undefined Kconfig symbols and return a dict with the symbol as key
+    and a list of referencing files as value.  Files matching %ignore are not
+    checked for undefined symbols."""
+    pool = Pool(cpu_count(), init_worker)
+    try:
+        return check_symbols_helper(pool, ignore)
+    except KeyboardInterrupt:
+        pool.terminate()
+        pool.join()
+        sys.exit(1)
+
+
+def check_symbols_helper(pool, ignore):
+    """Helper method for check_symbols().  Used to catch keyboard interrupts in
+    check_symbols() in order to properly terminate running worker processes."""
+    source_files = []
+    kconfig_files = []
+    defined_symbols = []
+    referenced_symbols = dict()  # {file: [symbols]}
+
+    for gitfile in get_files():
+        if REGEX_FILE_KCONFIG.match(gitfile):
+            kconfig_files.append(gitfile)
+        else:
+            if ignore and re.match(ignore, gitfile):
+                continue
+            # add source files that do not match the ignore pattern
+            source_files.append(gitfile)
+
+    # parse source files
+    arglist = partition(source_files, cpu_count())
+    for res in pool.map(parse_source_files, arglist):
+        referenced_symbols.update(res)
+
+    # parse kconfig files
+    arglist = []
+    for part in partition(kconfig_files, cpu_count()):
+        arglist.append((part, ignore))
+    for res in pool.map(parse_kconfig_files, arglist):
+        defined_symbols.extend(res[0])
+        referenced_symbols.update(res[1])
+    defined_symbols = set(defined_symbols)
+
+    # inverse mapping of referenced_symbols to dict(symbol: [files])
+    inv_map = dict()
+    for _file, symbols in referenced_symbols.items():
+        for symbol in symbols:
+            inv_map[symbol] = inv_map.get(symbol, set())
+            inv_map[symbol].add(_file)
+    referenced_symbols = inv_map
+
+    undefined = {}  # {symbol: [files]}
+    for symbol in sorted(referenced_symbols):
+        # filter some false positives
+        if symbol == "FOO" or symbol == "BAR" or \
+                symbol == "FOO_BAR" or symbol == "XXX":
+            continue
+        if symbol not in defined_symbols:
+            if symbol.endswith("_MODULE"):
+                # avoid false positives for kernel modules
+                if symbol[:-len("_MODULE")] in defined_symbols:
+                    continue
+            undefined[symbol] = referenced_symbols.get(symbol)
+    return undefined, defined_symbols
+
+
+def parse_source_files(source_files):
+    """Parse each source file in @source_files and return dictionary with source
+    files as keys and lists of references Kconfig symbols as values."""
+    referenced_symbols = dict()
+    for sfile in source_files:
+        referenced_symbols[sfile] = parse_source_file(sfile)
+    return referenced_symbols
+
+
+def parse_source_file(sfile):
+    """Parse @sfile and return a list of referenced Kconfig symbols."""
+    lines = []
+    references = []
+
+    if not os.path.exists(sfile):
+        return references
+
+    with open(sfile, "r", encoding='utf-8', errors='replace') as stream:
+        lines = stream.readlines()
+
+    for line in lines:
+        if "CONFIG_" not in line:
+            continue
+        symbols = REGEX_SOURCE_SYMBOL.findall(line)
+        for symbol in symbols:
+            if not REGEX_FILTER_SYMBOLS.search(symbol):
+                continue
+            references.append(symbol)
+
+    return references
+
+
+def get_symbols_in_line(line):
+    """Return mentioned Kconfig symbols in @line."""
+    return REGEX_SYMBOL.findall(line)
+
+
+def parse_kconfig_files(args):
+    """Parse kconfig files and return tuple of defined and references Kconfig
+    symbols.  Note, @args is a tuple of a list of files and the @ignore
+    pattern."""
+    kconfig_files = args[0]
+    ignore = args[1]
+    defined_symbols = []
+    referenced_symbols = dict()
+
+    for kfile in kconfig_files:
+        defined, references = parse_kconfig_file(kfile)
+        defined_symbols.extend(defined)
+        if ignore and re.match(ignore, kfile):
+            # do not collect references for files that match the ignore pattern
+            continue
+        referenced_symbols[kfile] = references
+    return (defined_symbols, referenced_symbols)
+
+
+def parse_kconfig_file(kfile):
+    """Parse @kfile and update symbol definitions and references."""
+    lines = []
+    defined = []
+    references = []
+
+    if not os.path.exists(kfile):
+        return defined, references
+
+    with open(kfile, "r", encoding='utf-8', errors='replace') as stream:
+        lines = stream.readlines()
+
+    for i in range(len(lines)):
+        line = lines[i]
+        line = line.strip('\n')
+        line = line.split("#")[0]  # ignore comments
+
+        if REGEX_KCONFIG_DEF.match(line):
+            symbol_def = REGEX_KCONFIG_DEF.findall(line)
+            defined.append(symbol_def[0])
+        elif REGEX_KCONFIG_STMT.match(line):
+            line = REGEX_QUOTES.sub("", line)
+            symbols = get_symbols_in_line(line)
+            # multi-line statements
+            while line.endswith("\\"):
+                i += 1
+                line = lines[i]
+                line = line.strip('\n')
+                symbols.extend(get_symbols_in_line(line))
+            for symbol in set(symbols):
+                if REGEX_NUMERIC.match(symbol):
+                    # ignore numeric values
+                    continue
+                references.append(symbol)
+
+    return defined, references
+
+
+def main():
+    try:
+        print_undefined_symbols()
+    except BrokenPipeError:
+        # Python flushes standard streams on exit; redirect remaining output
+        # to devnull to avoid another BrokenPipeError at shutdown
+        devnull = os.open(os.devnull, os.O_WRONLY)
+        os.dup2(devnull, sys.stdout.fileno())
+        sys.exit(1)  # Python exits with error code 1 on EPIPE
+
+
+if __name__ == "__main__":
+    main()
-- 
2.51.0

