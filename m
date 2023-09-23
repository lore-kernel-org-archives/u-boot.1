Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD90FCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D833386B53;
	Sat, 23 Sep 2023 21:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CfWLfKmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E12086ACA; Sat, 23 Sep 2023 21:44:38 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EEDE869EB
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fb64b5265so33069539f.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498274; x=1696103074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8HAmsB2r8n1arHTlMdMxcYm9/R01HAg8w9q776lD7Y=;
 b=CfWLfKmWfi7goq0LZ0A8bZZvFgYfWsJHVMXiAa443O/iseX/1j/ZOpu45WbbcPprs3
 tM4QKq+mSIWX/mGRGAQjRXZS7/mFT7n/25B11ND4tRQyrvo7ErW21kFl0aBrSiUUaoqB
 Nfpn4ovm0n4vH4EgrF0jFTgqcsTMY79vIIig8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498274; x=1696103074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8HAmsB2r8n1arHTlMdMxcYm9/R01HAg8w9q776lD7Y=;
 b=vBJRDsTa7jMrDerX7azftmR18fAVAp89M5Zl8IMGxAkfnbFobKrmhL6j0jnpoOgj2l
 cxZ9taZe/oeVcbusXPIdz9oGSdnV3VofcvC8s3lmB+gVoIu8+zb4JXiwU286dLqt85Xl
 XIC2VHs5JOGhQ3S26wOPV6znP6+euaSM5o7njxrLvfrqPPol7+NZCNyjeo1LsE/rt/03
 ZJkF60Uxjicaju7oIxFXV2XdKL6bdHq4Ck1WXrN5NwyqBhe6ekqE05CegX2KOWR4ZPQL
 4W5D9GrexqkXdcqNOCk+3dmAdw4ld9JcGces7BKRk92tI6Xb4i4uoKVqpApqu2eZppDb
 mkmw==
X-Gm-Message-State: AOJu0YzAM4R4yrh/YbUJsLBnKkNOTQ+HJKWSbazCJAM82EwRsxYskbMI
 31EP1DgcrJYcNJ+Am6GDZ0BqtrHqi2su3PD4RIw=
X-Google-Smtp-Source: AGHT+IGTCNVGIJFTuTspqpt8Wywq8QsMKFHgWRYAnljEdIqZi+iODheH4FGOJXeCNcKd0v/4hpU6PA==
X-Received: by 2002:a05:6602:324e:b0:792:9416:9c7f with SMTP id
 z14-20020a056602324e00b0079294169c7fmr2591876ioy.9.1695498273674; 
 Sat, 23 Sep 2023 12:44:33 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 04/27] moveconfig: Drop unused cleanup options
Date: Sat, 23 Sep 2023 13:43:53 -0600
Message-ID: <20230923194424.1739224-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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
2.42.0.515.g380fc7ccd1-goog

