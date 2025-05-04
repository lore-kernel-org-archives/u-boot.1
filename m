Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371AC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD9082977;
	Sun,  4 May 2025 15:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KYpIPdpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD2A82AB2; Sun,  4 May 2025 15:24:32 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5A682A4B
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so676402366b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365068; x=1746969868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2zzBwaa00vtEr2Lr6ZHjlM8XvKfevjNEfckO2QuEtk=;
 b=KYpIPdpAJoKyPR39KxY8sgGiop4t1md57PrPeg+UXw53cD+PmzS8kh0BjgEA/Dm6Ua
 c1bk7DfxmEvqPNHkHt+NUhR7VV7f3khzYDH9MBGDRaOZtOrVcyHo4ew+f/sPqF5RK2bU
 guVsVX3xIHobBfTA7E5HhaxswDwOfhM+TjdGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365068; x=1746969868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2zzBwaa00vtEr2Lr6ZHjlM8XvKfevjNEfckO2QuEtk=;
 b=wPhGPzBz1SFuug5LHpDgVYBIUgGgwjhnp/fMFRcIm3+xWauU8y6zh+1iaSmiwBGnAZ
 MYwls04ybLewgwYkD8BY09BA9xver6qxAqJ1bRR4LCKF7Uy7xbIjrZIrPuUfhLE75mU4
 wBaJgEZq4BJ1p5R153ps9Q8e0xZ4ecLwYN4lP2it10nb9TgmCXuVkzeGMH0jjxn5R2sW
 t9L+NVxJiBYowThwam0zKj5G4CqOX9pSZg/X6HzWNcsGV0yY8OxaL3aqmTpXFh248R26
 ULPYYPcwQhQMD/mRWyoKpSXfk32RLle/YgXKKTtYCrlgYEY3vL38nO8XLVdQRRzFLD9D
 yPZg==
X-Gm-Message-State: AOJu0YyRJfpW2N4lyc0A1PGLv9nUKOh8ppUG9dCzmhfGo8ix0eC5nebl
 8q/ssx/WJi+pehDN6nVNbsPP5EpXEGZTuwie0XTWWfVl9aQ/+c5nqU2D8K+s/UhLMJWN0J2MsJh
 Pu0OBVn0=
X-Gm-Gg: ASbGnct7Tnn85lytY4kzaRnjdOOCcFW3eT5nlqudg9CJmdvlmHjFPl81WVQbi1HeBwV
 yEzTlL0msB4Uz9ylXFfR3q8qmB3eC12bZUuY+aJCoe7j+nEu35Q3Deg652xZ6GRMVYcCc87A6XW
 aj3NezVL/fs6DjJw2AayFLAppbbHn9fJ3Y/SCm+1qrWWb6XaKZAxTQgwqtgmz4ZPBW9x1SWwFgX
 e7Wd7MogEqUzXActt3l8vk18l+0FlbduS2FxkjgLQijuCeIBX6+mSUJiVx4JgUvwYO9xDdEmBBY
 hiK5hERT2gSDEAITbiXKOAvMiYGfqrRbHKwIM57UwHW89Pg=
X-Google-Smtp-Source: AGHT+IEDEJ3cfLEOW/I+8Z2TaEvFbH4lT2q6Toz2H1KEUJ3r5As5twlhYz0KPUpw/O6+3Ltaj+hpqw==
X-Received: by 2002:a17:906:fb95:b0:ad1:aca0:9f38 with SMTP id
 a640c23a62f3a-ad1aca09fc1mr202493766b.29.1746365068131; 
 Sun, 04 May 2025 06:24:28 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/30] patman: Move code for sending into its own module
Date: Sun,  4 May 2025 15:23:30 +0200
Message-ID: <20250504132356.2317305-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

The control module includes much of the implementation of patman's
'send' feature. As a first step to separating this out, move the sending
code into its own file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/__main__.py  |   2 +-
 tools/patman/control.py   | 161 +---------------------------------
 tools/patman/func_test.py |   7 +-
 tools/patman/send.py      | 179 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 161 deletions(-)
 create mode 100644 tools/patman/send.py

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 1d1eaa19125..4e20761ae3a 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -15,10 +15,10 @@ our_path = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(our_path, '..'))
 
 # Our modules
+from u_boot_pylib import test_util
 from u_boot_pylib import tout
 from patman import cmdline
 from patman import control
-from u_boot_pylib import test_util
 
 
 def run_patman():
diff --git a/tools/patman/control.py b/tools/patman/control.py
index a050bd2f551..c33ca821aa6 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -24,6 +24,7 @@ from u_boot_pylib import terminal
 from u_boot_pylib import tools
 from patman import checkpatch
 from patman import patchstream
+from patman import send
 
 
 def setup():
@@ -31,169 +32,15 @@ def setup():
     gitutil.setup()
 
 
-def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
-                    keep_change_id=False):
-    """Figure out what patches to generate, then generate them
-
-    The patch files are written to the current directory, e.g. 0001_xxx.patch
-    0002_yyy.patch
-
-    Args:
-        col (terminal.Color): Colour output object
-        branch (str): Branch to create patches from (None = current)
-        count (int): Number of patches to produce, or -1 to produce patches for
-            the current branch back to the upstream commit
-        start (int): Start partch to use (0=first / top of branch)
-        end (int): End patch to use (0=last one in series, 1=one before that,
-            etc.)
-        ignore_binary (bool): Don't generate patches for binary files
-        keep_change_id (bool): Preserve the Change-Id tag.
-
-    Returns:
-        Tuple:
-            Series object for this series (set of patches)
-            Filename of the cover letter as a string (None if none)
-            patch_files: List of patch filenames, each a string, e.g.
-                ['0001_xxx.patch', '0002_yyy.patch']
-    """
-    if count == -1:
-        # Work out how many patches to send if we can
-        count = (gitutil.count_commits_to_branch(branch) - start)
-
-    if not count:
-        str = 'No commits found to process - please use -c flag, or run:\n' \
-              '  git branch --set-upstream-to remote/branch'
-        sys.exit(col.build(col.RED, str))
-
-    # Read the metadata from the commits
-    to_do = count - end
-    series = patchstream.get_metadata(branch, start, to_do)
-    cover_fname, patch_files = gitutil.create_patches(
-        branch, start, to_do, ignore_binary, series, signoff)
-
-    # Fix up the patch files to our liking, and insert the cover letter
-    patchstream.fix_patches(series, patch_files, keep_change_id,
-                            insert_base_commit=not cover_fname)
-    if cover_fname and series.get('cover'):
-        patchstream.insert_cover_letter(cover_fname, series, to_do)
-    return series, cover_fname, patch_files
-
-
-def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
-    """Run some checks on a set of patches
-
-    This santiy-checks the patman tags like Series-version and runs the patches
-    through checkpatch
-
-    Args:
-        series (Series): Series object for this series (set of patches)
-        patch_files (list): List of patch filenames, each a string, e.g.
-            ['0001_xxx.patch', '0002_yyy.patch']
-        run_checkpatch (bool): True to run checkpatch.pl
-        verbose (bool): True to print out every line of the checkpatch output as
-            it is parsed
-        use_tree (bool): If False we'll pass '--no-tree' to checkpatch.
-
-    Returns:
-        bool: True if the patches had no errors, False if they did
-    """
-    # Do a few checks on the series
-    series.DoChecks()
-
-    # Check the patches
-    if run_checkpatch:
-        ok = checkpatch.check_patches(verbose, patch_files, use_tree)
-    else:
-        ok = True
-    return ok
-
-
-def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
-                  ignore_bad_tags, add_maintainers, get_maintainer_script, limit,
-                  dry_run, in_reply_to, thread, smtp_server):
-    """Email patches to the recipients
-
-    This emails out the patches and cover letter using 'git send-email'. Each
-    patch is copied to recipients identified by the patch tag and output from
-    the get_maintainer.pl script. The cover letter is copied to all recipients
-    of any patch.
-
-    To make this work a CC file is created holding the recipients for each patch
-    and the cover letter. See the main program 'cc_cmd' for this logic.
-
-    Args:
-        col (terminal.Color): Colour output object
-        series (Series): Series object for this series (set of patches)
-        cover_fname (str): Filename of the cover letter as a string (None if
-            none)
-        patch_files (list): List of patch filenames, each a string, e.g.
-            ['0001_xxx.patch', '0002_yyy.patch']
-        process_tags (bool): True to process subject tags in each patch, e.g.
-            for 'dm: spi: Add SPI support' this would be 'dm' and 'spi'. The
-            tags are looked up in the configured sendemail.aliasesfile and also
-            in ~/.patman (see README)
-        its_a_go (bool): True if we are going to actually send the patches,
-            False if the patches have errors and will not be sent unless
-            @ignore_errors
-        ignore_bad_tags (bool): True to just print a warning for unknown tags,
-            False to halt with an error
-        add_maintainers (bool): Run the get_maintainer.pl script for each patch
-        get_maintainer_script (str): The script used to retrieve which
-            maintainers to cc
-        limit (int): Limit on the number of people that can be cc'd on a single
-            patch or the cover letter (None if no limit)
-        dry_run (bool): Don't actually email the patches, just print out what
-            would be sent
-        in_reply_to (str): If not None we'll pass this to git as --in-reply-to.
-            Should be a message ID that this is in reply to.
-        thread (bool): True to add --thread to git send-email (make all patches
-            reply to cover-letter or first patch in series)
-        smtp_server (str): SMTP server to use to send patches (None for default)
-    """
-    cc_file = series.MakeCcFile(process_tags, cover_fname, not ignore_bad_tags,
-                                add_maintainers, limit, get_maintainer_script)
-
-    # Email the patches out (giving the user time to check / cancel)
-    cmd = ''
-    if its_a_go:
-        cmd = gitutil.email_patches(
-            series, cover_fname, patch_files, dry_run, not ignore_bad_tags,
-            cc_file, in_reply_to=in_reply_to, thread=thread,
-            smtp_server=smtp_server)
-    else:
-        print(col.build(col.RED, "Not sending emails due to errors/warnings"))
-
-    # For a dry run, just show our actions as a sanity check
-    if dry_run:
-        series.ShowActions(patch_files, cmd, process_tags)
-        if not its_a_go:
-            print(col.build(col.RED, "Email would not be sent"))
-
-    os.remove(cc_file)
-
-def send(args):
+def do_send(args):
     """Create, check and send patches by email
 
     Args:
         args (argparse.Namespace): Arguments to patman
     """
     setup()
-    col = terminal.Color()
-    series, cover_fname, patch_files = prepare_patches(
-        col, args.branch, args.count, args.start, args.end,
-        args.ignore_binary, args.add_signoff,
-        keep_change_id=args.keep_change_id)
-    ok = check_patches(series, patch_files, args.check_patch,
-                       args.verbose, args.check_patch_use_tree)
-
-    ok = ok and gitutil.check_suppress_cc_config()
+    send.send(args)
 
-    its_a_go = ok or args.ignore_errors
-    email_patches(
-        col, series, cover_fname, patch_files, args.process_tags,
-        its_a_go, args.ignore_bad_tags, args.add_maintainers,
-        args.get_maintainer_script, args.limit, args.dry_run,
-        args.in_reply_to, args.thread, args.smtp_server)
 
 def patchwork_status(branch, count, start, end, dest_branch, force,
                      show_comments, url):
@@ -278,7 +125,7 @@ def do_patman(args):
             # If we are not processing tags, no need to warning about bad ones
             if not args.process_tags:
                 args.ignore_bad_tags = True
-            send(args)
+            do_send(args)
 
     ret_code = 0
     try:
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 85e7b475d90..b3145612f9f 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -20,6 +20,7 @@ from patman.commit import Commit
 from patman import control
 from patman import patchstream
 from patman.patchstream import PatchStream
+from patman import send
 from patman.series import Series
 from patman import settings
 from u_boot_pylib import gitutil
@@ -552,7 +553,7 @@ complicated as possible''')
             self.assertEqual(2, gitutil.count_commits_to_branch(None))
             col = terminal.Color()
             with terminal.capture() as _:
-                _, cover_fname, patch_files = control.prepare_patches(
+                _, cover_fname, patch_files = send.prepare_patches(
                     col, branch=None, count=-1, start=0, end=0,
                     ignore_binary=False, signoff=True)
             self.assertIsNone(cover_fname)
@@ -561,7 +562,7 @@ complicated as possible''')
             # Check that it can detect a different branch
             self.assertEqual(3, gitutil.count_commits_to_branch('second'))
             with terminal.capture() as _:
-                series, cover_fname, patch_files = control.prepare_patches(
+                series, cover_fname, patch_files = send.prepare_patches(
                     col, branch='second', count=-1, start=0, end=0,
                     ignore_binary=False, signoff=True)
             self.assertIsNotNone(cover_fname)
@@ -580,7 +581,7 @@ complicated as possible''')
 
             # Check that it can skip patches at the end
             with terminal.capture() as _:
-                _, cover_fname, patch_files = control.prepare_patches(
+                _, cover_fname, patch_files = send.prepare_patches(
                     col, branch='second', count=-1, start=0, end=1,
                     ignore_binary=False, signoff=True)
             self.assertIsNotNone(cover_fname)
diff --git a/tools/patman/send.py b/tools/patman/send.py
new file mode 100644
index 00000000000..66f3c4eb952
--- /dev/null
+++ b/tools/patman/send.py
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 Google LLC
+#
+"""Handles the 'send' subcommand
+"""
+
+import os
+import sys
+
+from patman import checkpatch
+from patman import patchstream
+from u_boot_pylib import gitutil
+from u_boot_pylib import terminal
+
+
+def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
+    """Run some checks on a set of patches
+
+    This santiy-checks the patman tags like Series-version and runs the patches
+    through checkpatch
+
+    Args:
+        series (Series): Series object for this series (set of patches)
+        patch_files (list): List of patch filenames, each a string, e.g.
+            ['0001_xxx.patch', '0002_yyy.patch']
+        run_checkpatch (bool): True to run checkpatch.pl
+        verbose (bool): True to print out every line of the checkpatch output as
+            it is parsed
+        use_tree (bool): If False we'll pass '--no-tree' to checkpatch.
+
+    Returns:
+        bool: True if the patches had no errors, False if they did
+    """
+    # Do a few checks on the series
+    series.DoChecks()
+
+    # Check the patches
+    if run_checkpatch:
+        ok = checkpatch.check_patches(verbose, patch_files, use_tree)
+    else:
+        ok = True
+    return ok
+
+
+def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
+                  ignore_bad_tags, add_maintainers, get_maintainer_script, limit,
+                  dry_run, in_reply_to, thread, smtp_server):
+    """Email patches to the recipients
+
+    This emails out the patches and cover letter using 'git send-email'. Each
+    patch is copied to recipients identified by the patch tag and output from
+    the get_maintainer.pl script. The cover letter is copied to all recipients
+    of any patch.
+
+    To make this work a CC file is created holding the recipients for each patch
+    and the cover letter. See the main program 'cc_cmd' for this logic.
+
+    Args:
+        col (terminal.Color): Colour output object
+        series (Series): Series object for this series (set of patches)
+        cover_fname (str): Filename of the cover letter as a string (None if
+            none)
+        patch_files (list): List of patch filenames, each a string, e.g.
+            ['0001_xxx.patch', '0002_yyy.patch']
+        process_tags (bool): True to process subject tags in each patch, e.g.
+            for 'dm: spi: Add SPI support' this would be 'dm' and 'spi'. The
+            tags are looked up in the configured sendemail.aliasesfile and also
+            in ~/.patman (see README)
+        its_a_go (bool): True if we are going to actually send the patches,
+            False if the patches have errors and will not be sent unless
+            @ignore_errors
+        ignore_bad_tags (bool): True to just print a warning for unknown tags,
+            False to halt with an error
+        add_maintainers (bool): Run the get_maintainer.pl script for each patch
+        get_maintainer_script (str): The script used to retrieve which
+            maintainers to cc
+        limit (int): Limit on the number of people that can be cc'd on a single
+            patch or the cover letter (None if no limit)
+        dry_run (bool): Don't actually email the patches, just print out what
+            would be sent
+        in_reply_to (str): If not None we'll pass this to git as --in-reply-to.
+            Should be a message ID that this is in reply to.
+        thread (bool): True to add --thread to git send-email (make all patches
+            reply to cover-letter or first patch in series)
+        smtp_server (str): SMTP server to use to send patches (None for default)
+    """
+    cc_file = series.MakeCcFile(process_tags, cover_fname, not ignore_bad_tags,
+                                add_maintainers, limit, get_maintainer_script)
+
+    # Email the patches out (giving the user time to check / cancel)
+    cmd = ''
+    if its_a_go:
+        cmd = gitutil.email_patches(
+            series, cover_fname, patch_files, dry_run, not ignore_bad_tags,
+            cc_file, in_reply_to=in_reply_to, thread=thread,
+            smtp_server=smtp_server)
+    else:
+        print(col.build(col.RED, "Not sending emails due to errors/warnings"))
+
+    # For a dry run, just show our actions as a sanity check
+    if dry_run:
+        series.ShowActions(patch_files, cmd, process_tags)
+        if not its_a_go:
+            print(col.build(col.RED, "Email would not be sent"))
+
+    os.remove(cc_file)
+
+
+def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
+                    keep_change_id=False):
+    """Figure out what patches to generate, then generate them
+
+    The patch files are written to the current directory, e.g. 0001_xxx.patch
+    0002_yyy.patch
+
+    Args:
+        col (terminal.Color): Colour output object
+        branch (str): Branch to create patches from (None = current)
+        count (int): Number of patches to produce, or -1 to produce patches for
+            the current branch back to the upstream commit
+        start (int): Start partch to use (0=first / top of branch)
+        end (int): End patch to use (0=last one in series, 1=one before that,
+            etc.)
+        ignore_binary (bool): Don't generate patches for binary files
+        keep_change_id (bool): Preserve the Change-Id tag.
+
+    Returns:
+        Tuple:
+            Series object for this series (set of patches)
+            Filename of the cover letter as a string (None if none)
+            patch_files: List of patch filenames, each a string, e.g.
+                ['0001_xxx.patch', '0002_yyy.patch']
+    """
+    if count == -1:
+        # Work out how many patches to send if we can
+        count = (gitutil.count_commits_to_branch(branch) - start)
+
+    if not count:
+        str = 'No commits found to process - please use -c flag, or run:\n' \
+              '  git branch --set-upstream-to remote/branch'
+        sys.exit(col.build(col.RED, str))
+
+    # Read the metadata from the commits
+    to_do = count - end
+    series = patchstream.get_metadata(branch, start, to_do)
+    cover_fname, patch_files = gitutil.create_patches(
+        branch, start, to_do, ignore_binary, series, signoff)
+
+    # Fix up the patch files to our liking, and insert the cover letter
+    patchstream.fix_patches(series, patch_files, keep_change_id,
+                            insert_base_commit=not cover_fname)
+    if cover_fname and series.get('cover'):
+        patchstream.insert_cover_letter(cover_fname, series, to_do)
+    return series, cover_fname, patch_files
+
+
+def send(args):
+    """Create, check and send patches by email
+
+    Args:
+        args (argparse.Namespace): Arguments to patman
+    """
+    col = terminal.Color()
+    series, cover_fname, patch_files = prepare_patches(
+        col, args.branch, args.count, args.start, args.end,
+        args.ignore_binary, args.add_signoff,
+        keep_change_id=args.keep_change_id)
+    ok = check_patches(series, patch_files, args.check_patch,
+                       args.verbose, args.check_patch_use_tree)
+
+    ok = ok and gitutil.check_suppress_cc_config()
+
+    its_a_go = ok or args.ignore_errors
+    email_patches(
+        col, series, cover_fname, patch_files, args.process_tags,
+        its_a_go, args.ignore_bad_tags, args.add_maintainers,
+        args.get_maintainer_script, args.limit, args.dry_run,
+        args.in_reply_to, args.thread, args.smtp_server)
-- 
2.43.0

