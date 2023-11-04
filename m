Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074F9C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3E787084;
	Sat,  4 Nov 2023 17:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HbSpA0zG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E1486F50; Sat,  4 Nov 2023 17:25:37 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC0386F50
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 17:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7a6830df017so100067939f.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699115132; x=1699719932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sirnUu/7qRWsc7Eoh45I5dDM3BEXdQkR49ka4KEUWSE=;
 b=HbSpA0zGOquJiUnclCUIP9Il7039F6/E4TuAZ3zkiqb+/K8etG9J2ddqjrpOZVYjz5
 fwaPx1ieXGsLY9qf1WXNRDecESV6naeumTSsGQhobAMiaoOFBu76QokJLb/Ro/7XPDy+
 4dDqb/wFP8AaqH4ycPI8C7K8g24kntNv+JgO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699115132; x=1699719932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sirnUu/7qRWsc7Eoh45I5dDM3BEXdQkR49ka4KEUWSE=;
 b=Xq0pmOJan/NhDHBX5588sJ20t7HIUbp6qGgqGfGFI39TA4joBMp20h+hLKLkCZrera
 /+fuE64JO9/J8GtSHIP5OkwY5tZroyVvq9g2BX7w/CpPFxhvEkLMrv8b5gYTQBlUERue
 0hQc/85Ft/MLYMvDQqVx/YZA8Zz82ZYnHA5xe/+jp0OEQItI9BeMge91LRsoVBXS2jYk
 m/v7+s/ce25HoTT02dbJ1W7FrkSKzTLwMThJIKib8Tkp1ld/TLnI4ZUDWTljdZ/2sQg/
 q+ZnMyQMV4YiuyatvNdjn2gahgnUKlCMtWe3INzFbpcwnvzdeoBmIFV5uumbDugDxQaf
 opCg==
X-Gm-Message-State: AOJu0Yx0HYDaEXv0+LnkGFAxJYNhmLU3rfJGxnQZTbqlI8lbqcJtbtGJ
 WtAk8+qbwY3Lk5bVo3pPc+HTBQ+I59fxtFQ2UK/hqQ==
X-Google-Smtp-Source: AGHT+IHELjrcdabAz3SuHL4bBQlQ95/v2LEwgxnCio7MeP1fV5ZNejkchX2hPVeKEkHOZbYV8hFelQ==
X-Received: by 2002:a6b:c84d:0:b0:7ab:4faa:cb3 with SMTP id
 y74-20020a6bc84d000000b007ab4faa0cb3mr27191950iof.16.1699115132235; 
 Sat, 04 Nov 2023 09:25:32 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a028784000000b0042bb296863asm1119013jai.56.2023.11.04.09.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 09:25:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/5] patman: Split out arg parsing into its own file
Date: Sat,  4 Nov 2023 10:25:20 -0600
Message-ID: <20231104162527.1736401-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

Move this code into a separate cmdline module, as is done with the
other tools.

Use the same HAS_TESTS check as buildman

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 116 +-----------------------------
 tools/patman/cmdline.py  | 147 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 113 deletions(-)
 create mode 100644 tools/patman/cmdline.py

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 197ac1aad103..0e559b5810be 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -6,7 +6,6 @@
 
 """See README for more information"""
 
-from argparse import ArgumentParser
 try:
     import importlib.resources
 except ImportError:
@@ -23,128 +22,19 @@ if __name__ == "__main__":
     sys.path.append(os.path.join(our_path, '..'))
 
 # Our modules
+from patman import cmdline
 from patman import control
 from patman import func_test
-from patman import gitutil
-from patman import project
-from patman import settings
 from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
-epilog = '''Create patches from commits in a branch, check them and email them
-as specified by tags you place in the commits. Use -n to do a dry run first.'''
-
-parser = ArgumentParser(epilog=epilog)
-parser.add_argument('-b', '--branch', type=str,
-    help="Branch to process (by default, the current branch)")
-parser.add_argument('-c', '--count', dest='count', type=int,
-    default=-1, help='Automatically create patches from top n commits')
-parser.add_argument('-e', '--end', type=int, default=0,
-    help='Commits to skip at end of patch list')
-parser.add_argument('-D', '--debug', action='store_true',
-    help='Enabling debugging (provides a full traceback on error)')
-parser.add_argument('-p', '--project', default=project.detect_project(),
-                    help="Project name; affects default option values and "
-                    "aliases [default: %(default)s]")
-parser.add_argument('-P', '--patchwork-url',
-                    default='https://patchwork.ozlabs.org',
-                    help='URL of patchwork server [default: %(default)s]')
-parser.add_argument('-s', '--start', dest='start', type=int,
-    default=0, help='Commit to start creating patches from (0 = HEAD)')
-parser.add_argument('-v', '--verbose', action='store_true', dest='verbose',
-                    default=False, help='Verbose output of errors and warnings')
-parser.add_argument('-H', '--full-help', action='store_true', dest='full_help',
-                    default=False, help='Display the README file')
-
-subparsers = parser.add_subparsers(dest='cmd')
-send = subparsers.add_parser(
-    'send', help='Format, check and email patches (default command)')
-send.add_argument('-i', '--ignore-errors', action='store_true',
-       dest='ignore_errors', default=False,
-       help='Send patches email even if patch errors are found')
-send.add_argument('-l', '--limit-cc', dest='limit', type=int, default=None,
-       help='Limit the cc list to LIMIT entries [default: %(default)s]')
-send.add_argument('-m', '--no-maintainers', action='store_false',
-       dest='add_maintainers', default=True,
-       help="Don't cc the file maintainers automatically")
-send.add_argument(
-    '--get-maintainer-script', dest='get_maintainer_script', type=str,
-    action='store',
-    default=os.path.join(gitutil.get_top_level(), 'scripts',
-                         'get_maintainer.pl') + ' --norolestats',
-    help='File name of the get_maintainer.pl (or compatible) script.')
-send.add_argument('-n', '--dry-run', action='store_true', dest='dry_run',
-       default=False, help="Do a dry run (create but don't email patches)")
-send.add_argument('-r', '--in-reply-to', type=str, action='store',
-                  help="Message ID that this series is in reply to")
-send.add_argument('-t', '--ignore-bad-tags', action='store_true',
-                  default=False,
-                  help='Ignore bad tags / aliases (default=warn)')
-send.add_argument('-T', '--thread', action='store_true', dest='thread',
-                  default=False, help='Create patches as a single thread')
-send.add_argument('--cc-cmd', dest='cc_cmd', type=str, action='store',
-       default=None, help='Output cc list for patch file (used by git)')
-send.add_argument('--no-binary', action='store_true', dest='ignore_binary',
-                  default=False,
-                  help="Do not output contents of changes in binary files")
-send.add_argument('--no-check', action='store_false', dest='check_patch',
-                  default=True,
-                  help="Don't check for patch compliance")
-send.add_argument('--tree', dest='check_patch_use_tree', default=False,
-                  action='store_true',
-                  help=("Set `tree` to True. If `tree` is False then we'll "
-                  "pass '--no-tree' to checkpatch (default: tree=%(default)s)"))
-send.add_argument('--no-tree', dest='check_patch_use_tree',
-                  action='store_false', help="Set `tree` to False")
-send.add_argument('--no-tags', action='store_false', dest='process_tags',
-                  default=True, help="Don't process subject tags as aliases")
-send.add_argument('--no-signoff', action='store_false', dest='add_signoff',
-                  default=True, help="Don't add Signed-off-by to patches")
-send.add_argument('--smtp-server', type=str,
-                  help="Specify the SMTP server to 'git send-email'")
-send.add_argument('--keep-change-id', action='store_true',
-                  help='Preserve Change-Id tags in patches to send.')
-
-send.add_argument('patchfiles', nargs='*')
-
-# Only add the 'test' action if the test data files are available.
-if os.path.exists(func_test.TEST_DATA_DIR):
-    test_parser = subparsers.add_parser('test', help='Run tests')
-    test_parser.add_argument('testname', type=str, default=None, nargs='?',
-                             help="Specify the test to run")
-
-status = subparsers.add_parser('status',
-                               help='Check status of patches in patchwork')
-status.add_argument('-C', '--show-comments', action='store_true',
-                    help='Show comments from each patch')
-status.add_argument('-d', '--dest-branch', type=str,
-                    help='Name of branch to create with collected responses')
-status.add_argument('-f', '--force', action='store_true',
-                    help='Force overwriting an existing branch')
-
-# Parse options twice: first to get the project and second to handle
-# defaults properly (which depends on project)
-# Use parse_known_args() in case 'cmd' is omitted
-argv = sys.argv[1:]
-args, rest = parser.parse_known_args(argv)
-if hasattr(args, 'project'):
-    settings.Setup(parser, args.project)
-    args, rest = parser.parse_known_args(argv)
-
-# If we have a command, it is safe to parse all arguments
-if args.cmd:
-    args = parser.parse_args(argv)
-else:
-    # No command, so insert it after the known arguments and before the ones
-    # that presumably relate to the 'send' subcommand
-    nargs = len(rest)
-    argv = argv[:-nargs] + ['send'] + rest
-    args = parser.parse_args(argv)
 
 if __name__ != "__main__":
     pass
 
+args = cmdline.parse_args()
+
 if not args.debug:
     sys.tracebacklimit = 0
 
diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
new file mode 100644
index 000000000000..d6496c0cb780
--- /dev/null
+++ b/tools/patman/cmdline.py
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2023 Google LLC
+#
+
+"""Handles parsing of buildman arguments
+
+This creates the argument parser and uses it to parse the arguments passed in
+"""
+
+import argparse
+import os
+import pathlib
+import sys
+
+from patman import gitutil
+from patman import project
+from patman import settings
+
+PATMAN_DIR = pathlib.Path(__file__).parent
+HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
+
+def parse_args():
+    """Parse command line arguments from sys.argv[]
+
+    Returns:
+        tuple containing:
+            options: command line options
+            args: command lin arguments
+    """
+    epilog = '''Create patches from commits in a branch, check them and email
+        them as specified by tags you place in the commits. Use -n to do a dry
+        run first.'''
+
+    parser = argparse.ArgumentParser(epilog=epilog)
+    parser.add_argument('-b', '--branch', type=str,
+        help="Branch to process (by default, the current branch)")
+    parser.add_argument('-c', '--count', dest='count', type=int,
+        default=-1, help='Automatically create patches from top n commits')
+    parser.add_argument('-e', '--end', type=int, default=0,
+        help='Commits to skip at end of patch list')
+    parser.add_argument('-D', '--debug', action='store_true',
+        help='Enabling debugging (provides a full traceback on error)')
+    parser.add_argument('-p', '--project', default=project.detect_project(),
+                        help="Project name; affects default option values and "
+                        "aliases [default: %(default)s]")
+    parser.add_argument('-P', '--patchwork-url',
+                        default='https://patchwork.ozlabs.org',
+                        help='URL of patchwork server [default: %(default)s]')
+    parser.add_argument('-s', '--start', dest='start', type=int,
+        default=0, help='Commit to start creating patches from (0 = HEAD)')
+    parser.add_argument(
+        '-v', '--verbose', action='store_true', dest='verbose', default=False,
+        help='Verbose output of errors and warnings')
+    parser.add_argument(
+        '-H', '--full-help', action='store_true', dest='full_help',
+        default=False, help='Display the README file')
+
+    subparsers = parser.add_subparsers(dest='cmd')
+    send = subparsers.add_parser(
+        'send', help='Format, check and email patches (default command)')
+    send.add_argument('-i', '--ignore-errors', action='store_true',
+           dest='ignore_errors', default=False,
+           help='Send patches email even if patch errors are found')
+    send.add_argument('-l', '--limit-cc', dest='limit', type=int, default=None,
+           help='Limit the cc list to LIMIT entries [default: %(default)s]')
+    send.add_argument('-m', '--no-maintainers', action='store_false',
+           dest='add_maintainers', default=True,
+           help="Don't cc the file maintainers automatically")
+    send.add_argument(
+        '--get-maintainer-script', dest='get_maintainer_script', type=str,
+        action='store',
+        default=os.path.join(gitutil.get_top_level(), 'scripts',
+                             'get_maintainer.pl') + ' --norolestats',
+        help='File name of the get_maintainer.pl (or compatible) script.')
+    send.add_argument('-n', '--dry-run', action='store_true', dest='dry_run',
+           default=False, help="Do a dry run (create but don't email patches)")
+    send.add_argument('-r', '--in-reply-to', type=str, action='store',
+                      help="Message ID that this series is in reply to")
+    send.add_argument('-t', '--ignore-bad-tags', action='store_true',
+                      default=False,
+                      help='Ignore bad tags / aliases (default=warn)')
+    send.add_argument('-T', '--thread', action='store_true', dest='thread',
+                      default=False, help='Create patches as a single thread')
+    send.add_argument('--cc-cmd', dest='cc_cmd', type=str, action='store',
+           default=None, help='Output cc list for patch file (used by git)')
+    send.add_argument('--no-binary', action='store_true', dest='ignore_binary',
+                      default=False,
+                      help="Do not output contents of changes in binary files")
+    send.add_argument('--no-check', action='store_false', dest='check_patch',
+                      default=True,
+                      help="Don't check for patch compliance")
+    send.add_argument(
+        '--tree', dest='check_patch_use_tree', default=False,
+        action='store_true',
+        help=("Set `tree` to True. If `tree` is False then we'll pass "
+              "'--no-tree' to checkpatch (default: tree=%(default)s)"))
+    send.add_argument('--no-tree', dest='check_patch_use_tree',
+                      action='store_false', help="Set `tree` to False")
+    send.add_argument(
+        '--no-tags', action='store_false', dest='process_tags', default=True,
+        help="Don't process subject tags as aliases")
+    send.add_argument('--no-signoff', action='store_false', dest='add_signoff',
+                      default=True, help="Don't add Signed-off-by to patches")
+    send.add_argument('--smtp-server', type=str,
+                      help="Specify the SMTP server to 'git send-email'")
+    send.add_argument('--keep-change-id', action='store_true',
+                      help='Preserve Change-Id tags in patches to send.')
+
+    send.add_argument('patchfiles', nargs='*')
+
+    # Only add the 'test' action if the test data files are available.
+    if HAS_TESTS:
+        test_parser = subparsers.add_parser('test', help='Run tests')
+        test_parser.add_argument('testname', type=str, default=None, nargs='?',
+                                 help="Specify the test to run")
+
+    status = subparsers.add_parser('status',
+                                   help='Check status of patches in patchwork')
+    status.add_argument('-C', '--show-comments', action='store_true',
+                        help='Show comments from each patch')
+    status.add_argument(
+        '-d', '--dest-branch', type=str,
+        help='Name of branch to create with collected responses')
+    status.add_argument('-f', '--force', action='store_true',
+                        help='Force overwriting an existing branch')
+
+    # Parse options twice: first to get the project and second to handle
+    # defaults properly (which depends on project)
+    # Use parse_known_args() in case 'cmd' is omitted
+    argv = sys.argv[1:]
+    args, rest = parser.parse_known_args(argv)
+    if hasattr(args, 'project'):
+        settings.Setup(parser, args.project)
+        args, rest = parser.parse_known_args(argv)
+
+    # If we have a command, it is safe to parse all arguments
+    if args.cmd:
+        args = parser.parse_args(argv)
+    else:
+        # No command, so insert it after the known arguments and before the ones
+        # that presumably relate to the 'send' subcommand
+        nargs = len(rest)
+        argv = argv[:-nargs] + ['send'] + rest
+        args = parser.parse_args(argv)
+
+    return args
-- 
2.42.0.869.gea05f2083d-goog

