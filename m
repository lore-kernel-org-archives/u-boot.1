Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5C1EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DEE8691E;
	Fri, 15 Sep 2023 02:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KcUE8VHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852D3868D7; Fri, 15 Sep 2023 02:22:54 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468D980274
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so43182439f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737371; x=1695342171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLP7s8lRLnCpZ9k72Y9kaLhcxWcqIuA0GHhjYP1zhPc=;
 b=KcUE8VHJQRLcPaOKQFng1XJUYc5JhDfK0rDUjR6nMGBQKbmquOEM6Nz+c84/hFffoS
 yRAf6q9MAnY3MMqpkDGFAImkzkJJp9rJMqwdIiErkT55VWLvHBpC00DCK8GZfF1AfN/Y
 sreiAzWsCN0NUKnhwFDDQ8/NcvRyXP+qBozGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737371; x=1695342171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLP7s8lRLnCpZ9k72Y9kaLhcxWcqIuA0GHhjYP1zhPc=;
 b=gfGRI7Jahk/PkEgKNiPjQjj3qA1PDgACFDiBA3a2FsTIUgZAJ5IYHducZQxuDyqp6o
 S9os2vtP2U5ZSmws8TxOUe9vGOqDi2HheckV3GH7NDesmhkPou3Q3lmbwoww9aLeSZbC
 3YIYYORrag3MQz8gBPcTubEHxBa/63ry61gLWcAA4KEthWhuAGH9KuudtZYQElXMFZfr
 uKTodJ/+l9GOtSfV2Osr4cCmfaT/eXtG8hbaW3KYDMPHBxPP1vJORURYGlpkl/taM06K
 ndYtT9Izyykf441y7pVMrJRNj0PeYH3oWGAm2epw5cVlVNfK6zwH8qZk6XRXffi1s+AZ
 8GHw==
X-Gm-Message-State: AOJu0YyenQ/gXYDnCbf1TzbaGyJCAJ8f14xBrfU3MjxiIQcn/KuWzaQc
 YwG7LqWSHWgj3Pta326crmN611tJ/q3VsgnEK7k=
X-Google-Smtp-Source: AGHT+IFRIGHjM5QxzUhTzWuuyw+E38NNlonbAopKFAG9Q14L1+KQBDlEHOzbPQSHgb0p4JuBcRQr7A==
X-Received: by 2002:a05:6602:15c7:b0:792:7ee9:af39 with SMTP id
 f7-20020a05660215c700b007927ee9af39mr4218869iow.9.1694737370886; 
 Thu, 14 Sep 2023 17:22:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/27] moveconfig: Drop unused cleanup options
Date: Thu, 14 Sep 2023 18:22:06 -0600
Message-ID: <20230915002236.798760-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Cleaning up the README and config.h files are not needed now, since we
don't have any CONFIG options to convert. Drop this code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 254 +-------------------------------------------
 1 file changed, 2 insertions(+), 252 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index a6dbda7bd0ea..476603ce1472 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -13,8 +13,6 @@ See doc/develop/moveconfig.rst for documentation.
 from argparse import ArgumentParser
 import collections
 from contextlib import ExitStack
-import copy
-import difflib
 import doctest
 import filecmp
 import fnmatch
@@ -205,102 +203,6 @@ def color_text(color_enabled, color, string):
                            for s in string.split('\n') ])
     return string
 
-def show_diff(alines, blines, file_path, color_enabled):
-    """Show unidified diff.
-
-    Args:
-       alines (list of str): A list of lines (before)
-       blines (list of str): A list of lines (after)
-       file_path (str): Path to the file
-       color_enabled (bool): Display the diff in color
-    """
-    diff = difflib.unified_diff(alines, blines,
-                                fromfile=os.path.join('a', file_path),
-                                tofile=os.path.join('b', file_path))
-
-    for line in diff:
-        if line.startswith('-') and not line.startswith('--'):
-            print(color_text(color_enabled, COLOR_RED, line))
-        elif line.startswith('+') and not line.startswith('++'):
-            print(color_text(color_enabled, COLOR_GREEN, line))
-        else:
-            print(line)
-
-def extend_matched_lines(lines, matched, pre_patterns, post_patterns,
-                         extend_pre, extend_post):
-    """Extend matched lines if desired patterns are found before/after already
-    matched lines.
-
-    Args:
-      lines (list of str): list of lines handled.
-      matched (list of int): list of line numbers that have been already
-          matched (will be updated by this function)
-      pre_patterns (list of re.Pattern): list of regular expression that should
-          be matched as preamble
-      post_patterns (list of re.Pattern): list of regular expression that should
-          be matched as postamble
-      extend_pre (bool): Add the line number of matched preamble to the matched
-          list
-      extend_post (bool): Add the line number of matched postamble to the
-          matched list
-    """
-    extended_matched = []
-
-    j = matched[0]
-
-    for i in matched:
-        if i == 0 or i < j:
-            continue
-        j = i
-        while j in matched:
-            j += 1
-        if j >= len(lines):
-            break
-
-        for pat in pre_patterns:
-            if pat.search(lines[i - 1]):
-                break
-        else:
-            # not matched
-            continue
-
-        for pat in post_patterns:
-            if pat.search(lines[j]):
-                break
-        else:
-            # not matched
-            continue
-
-        if extend_pre:
-            extended_matched.append(i - 1)
-        if extend_post:
-            extended_matched.append(j)
-
-    matched += extended_matched
-    matched.sort()
-
-def confirm(args, prompt):
-    """Ask the user to confirm something
-
-    Args:
-        args (Namespace ): program arguments
-
-    Returns:
-        bool: True to confirm, False to cancel/stop
-    """
-    if not args.yes:
-        while True:
-            choice = input(f'{prompt} [y/n]: ')
-            choice = choice.lower()
-            print(choice)
-            if choice in ('y', 'n'):
-                break
-
-        if choice == 'n':
-            return False
-
-    return True
-
 def write_file(fname, data):
     """Write data to a file
 
@@ -344,155 +246,6 @@ def read_file(fname, as_lines=True, skip_unicode=False):
             print("Failed on file %s': %s" % (fname, e))
             return None
 
-def cleanup_empty_blocks(header_path, args):
-    """Clean up empty conditional blocks
-
-    Args:
-      header_path (str): path to the cleaned file.
-      args (Namespace): program arguments
-    """
-    pattern = re.compile(r'^\s*#\s*if.*$\n^\s*#\s*endif.*$\n*', flags=re.M)
-    data = read_file(header_path, as_lines=False, skip_unicode=True)
-    if data is None:
-        return
-
-    new_data = pattern.sub('\n', data)
-
-    show_diff(data.splitlines(True), new_data.splitlines(True), header_path,
-              args.color)
-
-    if args.dry_run:
-        return
-
-    if new_data != data:
-        write_file(header_path, new_data)
-
-def cleanup_one_header(header_path, patterns, args):
-    """Clean regex-matched lines away from a file.
-
-    Args:
-      header_path: path to the cleaned file.
-      patterns: list of regex patterns.  Any lines matching to these
-                patterns are deleted.
-      args (Namespace): program arguments
-    """
-    lines = read_file(header_path, skip_unicode=True)
-    if lines is None:
-        return
-
-    matched = []
-    for i, line in enumerate(lines):
-        if i - 1 in matched and lines[i - 1].endswith('\\'):
-            matched.append(i)
-            continue
-        for pattern in patterns:
-            if pattern.search(line):
-                matched.append(i)
-                break
-
-    if not matched:
-        return
-
-    # remove empty #ifdef ... #endif, successive blank lines
-    pattern_if = re.compile(r'#\s*if(def|ndef)?\b') #  #if, #ifdef, #ifndef
-    pattern_elif = re.compile(r'#\s*el(if|se)\b')   #  #elif, #else
-    pattern_endif = re.compile(r'#\s*endif\b')      #  #endif
-    pattern_blank = re.compile(r'^\s*$')            #  empty line
-
-    while True:
-        old_matched = copy.copy(matched)
-        extend_matched_lines(lines, matched, [pattern_if],
-                             [pattern_endif], True, True)
-        extend_matched_lines(lines, matched, [pattern_elif],
-                             [pattern_elif, pattern_endif], True, False)
-        extend_matched_lines(lines, matched, [pattern_if, pattern_elif],
-                             [pattern_blank], False, True)
-        extend_matched_lines(lines, matched, [pattern_blank],
-                             [pattern_elif, pattern_endif], True, False)
-        extend_matched_lines(lines, matched, [pattern_blank],
-                             [pattern_blank], True, False)
-        if matched == old_matched:
-            break
-
-    tolines = copy.copy(lines)
-
-    for i in reversed(matched):
-        tolines.pop(i)
-
-    show_diff(lines, tolines, header_path, args.color)
-
-    if args.dry_run:
-        return
-
-    write_file(header_path, tolines)
-
-def cleanup_headers(configs, args):
-    """Delete config defines from board headers.
-
-    Args:
-      configs: A list of CONFIGs to remove.
-      args (Namespace): program arguments
-    """
-    if not confirm(args, 'Clean up headers?'):
-        return
-
-    patterns = []
-    for config in configs:
-        patterns.append(re.compile(r'#\s*define\s+%s\b' % config))
-        patterns.append(re.compile(r'#\s*undef\s+%s\b' % config))
-
-    for dir in 'include', 'arch', 'board':
-        for (dirpath, dirnames, filenames) in os.walk(dir):
-            if dirpath == os.path.join('include', 'generated'):
-                continue
-            for filename in filenames:
-                if not filename.endswith(('~', '.dts', '.dtsi', '.bin',
-                                          '.elf','.aml','.dat')):
-                    header_path = os.path.join(dirpath, filename)
-                    # This file contains UTF-16 data and no CONFIG symbols
-                    if header_path == 'include/video_font_data.h':
-                        continue
-                    cleanup_one_header(header_path, patterns, args)
-                    cleanup_empty_blocks(header_path, args)
-
-def find_matching(patterns, line):
-    for pat in patterns:
-        if pat.search(line):
-            return True
-    return False
-
-def cleanup_readme(configs, args):
-    """Delete config description in README
-
-    Args:
-      configs: A list of CONFIGs to remove.
-      args (Namespace): program arguments
-    """
-    if not confirm(args, 'Clean up README?'):
-        return
-
-    patterns = []
-    for config in configs:
-        patterns.append(re.compile(r'^\s+%s' % config))
-
-    lines = read_file('README')
-
-    found = False
-    newlines = []
-    for line in lines:
-        if not found:
-            found = find_matching(patterns, line)
-            if found:
-                continue
-
-        if found and re.search(r'^\s+CONFIG', line):
-            found = False
-
-        if not found:
-            newlines.append(line)
-
-    write_file('README', newlines)
-
 def try_expand(line):
     """If value looks like an expression, try expanding it
     Otherwise just return the existing value
@@ -2026,6 +1779,7 @@ doc/develop/moveconfig.rst for documentation.'''
         do_find_config(configs)
         return
 
+    # We are either building the database or forcing a sync of defconfigs
     config_db = {}
     db_queue = queue.Queue()
     t = DatabaseThread(config_db, db_queue)
@@ -2037,13 +1791,9 @@ doc/develop/moveconfig.rst for documentation.'''
     toolchains = toolchain.Toolchains()
     toolchains.GetSettings()
     toolchains.Scan(verbose=False)
-    move_config(toolchains, configs, args, db_queue)
+    move_config(toolchains, [], args, db_queue)
     db_queue.join()
 
-    if configs:
-        cleanup_headers(configs, args)
-        cleanup_readme(configs, args)
-
     if args.commit:
         subprocess.call(['git', 'add', '-u'])
         if configs:
-- 
2.42.0.459.ge4e396fd5e-goog

