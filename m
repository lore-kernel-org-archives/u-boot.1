Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF78C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B168291D;
	Thu,  8 May 2025 09:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUFtSAY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B4D82AAF; Thu,  8 May 2025 09:29:49 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DD082AA4
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso3833515e9.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689385; x=1747294185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSnWWn8oxwhDuN204ZQiVjO7IsoDK2Vue/KG0Gih2VM=;
 b=MUFtSAY4n7bBCEgdED/5vKkJKSX6SqeOpgZOhU8zLm5hLUYjRyrZOLdKDdp6OwSWt2
 RJfLBasxR5IxcZVxkJ+qFWEoqCTWRyjsOqBGTSpITFKZfa/gPi+c42hri2WG+dgaYCTV
 +NAuGy4ATSOFQEwLAfwnbQo/v7L6Temwi7rM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689385; x=1747294185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSnWWn8oxwhDuN204ZQiVjO7IsoDK2Vue/KG0Gih2VM=;
 b=f9Or0kPT+ZKv71rRLm1JBuUHvxQSPMZZjfNYjxAeRXYkOrXs6y3xKLW0kPUoGdHzlD
 xK342NQZ99MZgwBhpJl5oanoSOGfHw1m3LhjNbkOFd8vp6N8xl3kFb3sHDCFJFSCNYj5
 WbKDulqXOjDss4zdWugUv334sgzp870GcYsSBljU8Dz/G+mSiA98DJ4yBfYdowBmD+sO
 3uerrzz6KD9fEzNSuKyp1C0vXMqqExKPqAtQXSLgTyq9UG83Uc2ivmdkBek5zDYAlwNP
 ZYCSjaXGy5j8STXzcZ1pY8GmfvPdawA2Kdh4E5rbZ1oWrD+cbkxXDC08gJQG825i17qY
 1cpw==
X-Gm-Message-State: AOJu0YwNaH9yVoWxoOCUF0k/FJY7LTg3S5/U3vBwSBy+bsNtGdrO/ccB
 irtUg8r8Ws0jZnY1Utw2wwRYmKNcI4WbJkXWqcCyvTbkpRAXKvirTURhXivOQV/4SCkelSCdjsh
 5nmGfNUQpO96d
X-Gm-Gg: ASbGncso1X2RjVbOHqzzSlyCkqKcSFvg6m1gHFlF7+V2bE1Otzq4j+jd4XCp28TuCfL
 q1Ao+3n3+ZEa4WQAQZdfzC3qwd5eKXIOOvdewxtua8Zr/atn268nF6QgAwGXefGyFZh77of4qVh
 4zIz80Xvr67kJhgpJu3IeDWj+u89gxBXvgft0JwVh0LiNN+6ewkhH4jdcnWurCAB3MSc5Ofqj1v
 KWIIOzCGyZldDiRUUJOuOqXVFvZ5QLj6Y8tgFWpLnmsQhrj/gZ48Oj6ArQkWUTtJhQ24tQFaIKx
 rBh5akial7wBfj7+2hdOtipL6jT56zyzjPhgzQ==
X-Google-Smtp-Source: AGHT+IF0673+ZR/aIIbv0GWriFbiDyoqsFQt9+TRRYdGxR6Jhzt7W29gKEButid3dtcWdOU4q44PKg==
X-Received: by 2002:a05:600c:5298:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-442d02ed370mr22070125e9.10.1746689385003; 
 Thu, 08 May 2025 00:29:45 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/20] patman: Move arguments for sent into the correct parser
Date: Thu,  8 May 2025 09:28:41 +0200
Message-ID: <20250508072907.207175-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Most of the arguments for the main parser are actually arguments for the
'send' parser. Move them there, in a separate function.

Fix a pylint warning for -D and the imports while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 124 +++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 52 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index cb4e68c7cd8..912d488ff74 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -13,78 +13,102 @@ import os
 import pathlib
 import sys
 
-from patman import project
 from u_boot_pylib import gitutil
+from patman import project
 from patman import settings
 
 PATMAN_DIR = pathlib.Path(__file__).parent
 HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
 
 
-def add_send_subparser(subparsers):
-    """Add the 'send' subparser
-
-    Args:
-        subparsers (argparse action): Subparser parent
+def add_send_args(par):
+    """Add arguments for the 'send' command
 
-    Return:
-        ArgumentParser: send subparser
+    Arguments:
+        par (ArgumentParser): Parser to add to
     """
-    send = subparsers.add_parser(
-        'send', help='Format, check and email patches (default command)')
-    send.add_argument(
+    par.add_argument(
+        '-c', '--count', dest='count', type=int, default=-1,
+        help='Automatically create patches from top n commits')
+    par.add_argument(
+        '-e', '--end', type=int, default=0,
+        help='Commits to skip at end of patch list')
+    par.add_argument(
         '-i', '--ignore-errors', action='store_true',
         dest='ignore_errors', default=False,
         help='Send patches email even if patch errors are found')
-    send.add_argument(
+    par.add_argument(
         '-l', '--limit-cc', dest='limit', type=int, default=None,
         help='Limit the cc list to LIMIT entries [default: %(default)s]')
-    send.add_argument(
+    par.add_argument(
         '-m', '--no-maintainers', action='store_false',
         dest='add_maintainers', default=True,
         help="Don't cc the file maintainers automatically")
-    send.add_argument(
+    par.add_argument(
         '--get-maintainer-script', dest='get_maintainer_script', type=str,
         action='store',
         default=os.path.join(gitutil.get_top_level(), 'scripts',
                              'get_maintainer.pl') + ' --norolestats',
         help='File name of the get_maintainer.pl (or compatible) script.')
-    send.add_argument(
-        '-n', '--dry-run', action='store_true', dest='dry_run',
-        default=False, help="Do a dry run (create but don't email patches)")
-    send.add_argument('-r', '--in-reply-to', type=str, action='store',
-                      help="Message ID that this series is in reply to")
-    send.add_argument('-t', '--ignore-bad-tags', action='store_true',
-                      default=False,
-                      help='Ignore bad tags / aliases (default=warn)')
-    send.add_argument('-T', '--thread', action='store_true', dest='thread',
-                      default=False, help='Create patches as a single thread')
-    send.add_argument(
-        '--cc-cmd', dest='cc_cmd', type=str, action='store',
-        default=None, help='Output cc list for patch file (used by git)')
-    send.add_argument('--no-binary', action='store_true', dest='ignore_binary',
-                      default=False,
-                      help="Do not output contents of changes in binary files")
-    send.add_argument('--no-check', action='store_false', dest='check_patch',
-                      default=True,
-                      help="Don't check for patch compliance")
-    send.add_argument(
+    par.add_argument(
+        '-r', '--in-reply-to', type=str, action='store',
+        help="Message ID that this series is in reply to")
+    par.add_argument(
+        '-s', '--start', dest='start', type=int, default=0,
+        help='Commit to start creating patches from (0 = HEAD)')
+    par.add_argument(
+        '-t', '--ignore-bad-tags', action='store_true', default=False,
+        help='Ignore bad tags / aliases (default=warn)')
+    par.add_argument(
+        '--no-binary', action='store_true', dest='ignore_binary',
+        default=False,
+        help="Do not output contents of changes in binary files")
+    par.add_argument(
+        '--no-check', action='store_false', dest='check_patch', default=True,
+        help="Don't check for patch compliance")
+    par.add_argument(
         '--tree', dest='check_patch_use_tree', default=False,
         action='store_true',
         help=("Set `tree` to True. If `tree` is False then we'll pass "
               "'--no-tree' to checkpatch (default: tree=%(default)s)"))
-    send.add_argument('--no-tree', dest='check_patch_use_tree',
-                      action='store_false', help="Set `tree` to False")
-    send.add_argument(
+    par.add_argument(
+        '--no-tree', dest='check_patch_use_tree', action='store_false',
+        help="Set `tree` to False")
+    par.add_argument(
         '--no-tags', action='store_false', dest='process_tags', default=True,
         help="Don't process subject tags as aliases")
-    send.add_argument('--no-signoff', action='store_false', dest='add_signoff',
-                      default=True, help="Don't add Signed-off-by to patches")
-    send.add_argument('--smtp-server', type=str,
-                      help="Specify the SMTP server to 'git send-email'")
-    send.add_argument('--keep-change-id', action='store_true',
-                      help='Preserve Change-Id tags in patches to send.')
+    par.add_argument(
+        '--no-signoff', action='store_false', dest='add_signoff',
+        default=True, help="Don't add Signed-off-by to patches")
+    par.add_argument(
+        '--smtp-server', type=str,
+        help="Specify the SMTP server to 'git send-email'")
+    par.add_argument(
+        '--keep-change-id', action='store_true',
+        help='Preserve Change-Id tags in patches to send.')
 
+
+def add_send_subparser(subparsers):
+    """Add the 'send' subparser
+
+    Args:
+        subparsers (argparse action): Subparser parent
+
+    Return:
+        ArgumentParser: send subparser
+    """
+    send = subparsers.add_parser(
+        'send', help='Format, check and email patches (default command)')
+    send.add_argument(
+        '-b', '--branch', type=str,
+        help="Branch to process (by default, the current branch)")
+    send.add_argument(
+        '-n', '--dry-run', action='store_true', dest='dry_run',
+        default=False, help="Do a dry run (create but don't email patches)")
+    send.add_argument(
+        '--cc-cmd', dest='cc_cmd', type=str, action='store',
+        default=None, help='Output cc list for patch file (used by git)')
+    add_send_args(send)
     send.add_argument('patchfiles', nargs='*')
     return send
 
@@ -123,13 +147,8 @@ def setup_parser():
         run first.'''
 
     parser = argparse.ArgumentParser(epilog=epilog)
-    parser.add_argument('-b', '--branch', type=str,
-        help="Branch to process (by default, the current branch)")
-    parser.add_argument('-c', '--count', dest='count', type=int,
-        default=-1, help='Automatically create patches from top n commits')
-    parser.add_argument('-e', '--end', type=int, default=0,
-        help='Commits to skip at end of patch list')
-    parser.add_argument('-D', '--debug', action='store_true',
+    parser.add_argument(
+        '-D', '--debug', action='store_true',
         help='Enabling debugging (provides a full traceback on error)')
     parser.add_argument(
         '-N', '--no-capture', action='store_true',
@@ -140,8 +159,9 @@ def setup_parser():
     parser.add_argument('-P', '--patchwork-url',
                         default='https://patchwork.ozlabs.org',
                         help='URL of patchwork server [default: %(default)s]')
-    parser.add_argument('-s', '--start', dest='start', type=int,
-        default=0, help='Commit to start creating patches from (0 = HEAD)')
+    parser.add_argument(
+        '-T', '--thread', action='store_true', dest='thread',
+        default=False, help='Create patches as a single thread')
     parser.add_argument(
         '-v', '--verbose', action='store_true', dest='verbose', default=False,
         help='Verbose output of errors and warnings')
-- 
2.43.0

