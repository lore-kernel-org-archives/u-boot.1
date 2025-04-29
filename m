Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721EEC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C57C98298E;
	Tue, 29 Apr 2025 15:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dw4UdEKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5927882A1C; Tue, 29 Apr 2025 15:24:22 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1D28215E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72ec58e45baso3669507a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933058; x=1746537858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9C+wbdouUgV9766KdV+pblZ1Vq55r3dh83dDElJxJs=;
 b=dw4UdEKrkBkw42r+45kSfAAJP749FINcZeS6XfMQUiHAx+jF9oXAZ0aUMCK89oIsRa
 0qPFQrPIzIgaepYmVpQNeqXsEkNQCycM6ex66GglWJhFYNdLm7VBqi2FXJosDjfJfozV
 xNXhT1RVUrFmLReYvE5HG/s6s2UFooU/cLaKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933058; x=1746537858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9C+wbdouUgV9766KdV+pblZ1Vq55r3dh83dDElJxJs=;
 b=d/dY4w7PObyPrJttqT5Dab7Ic9t27EkUD9jZw5y6l8znQmJ1jOD1aiO4wvU4XM0X4R
 NtXh78omb2+c3vWn1uNfGTik8MCqpgb1mh0QUxA9fB3Rv1MAkFPp4rZwCE4vK/nESTxU
 q/wA+GOOh0/Pr6vxF467gozBqP4sQJObV0nE9AtiwT/T5+WpoKQrfhksoPpQZ7VAJp9B
 1QbulUGqr3NbM0QsspyzJ2h1chP3x6Fga2j/I6ys9uRlvYXSna5To47vViU1uCMHKK0R
 weqgUyV3pv8LZsGlFMV1+9CVzBuUswD0jx/YWQYg138Gcn9ibL58eMpD1r7Tj6pgjYBD
 7Cpg==
X-Gm-Message-State: AOJu0YxdAdkU0YzqFmQFS++kHGXQAwArBBUoErbk5m5bQsu7mIDOwIbm
 PDMim3VAV1yG2/GWOTK5v6dCLIdpxTAP2RXQRo+i+s3z6c6UxfpwFvXCviYPpF5TvjRAz4LHvGk
 =
X-Gm-Gg: ASbGnctRE1WJrElCfphWCZUrWyM+AFDaKCpfQKxy0RMTffG+/cOiiS87GB9/O7upOXP
 ybT9Ll5mpQKfeF7ns/+8gDNomQu5iuydq8u0Fi2j6K0Xh65/l6LVauXOpiTSEX+TKC/Y1CwWXqo
 IpC8hcbijg1CCWonvgSEBzdfRIw8YacJAWlNTj/v0ryO5iGHdt5aLai4d6MnwIZu2CBuZKLBcYm
 xc9fuO35/WTksERVw+HltHxP3yx55t/9nyBUJGWEu/WOp7KsPjMPjlLFiFCL0vK6MAhjxURCXR/
 YeHWL8kHm2FN3CG7iWjd8wRtb7vf3hKrjuh50pHBEtEzsNv6reHmkys8SYUBQ2UX/3sRQxedgNw
 K8Q==
X-Google-Smtp-Source: AGHT+IFTXg6UOAhQLBByqePRP8+o8crP0qcorJHTC5MLD3mfLOQyU191msMCHfBqn1iw59caPndJ6g==
X-Received: by 2002:a05:6830:54:b0:72b:823c:8f66 with SMTP id
 46e09a7af769-7306519ae23mr6609151a34.9.1745933057657; 
 Tue, 29 Apr 2025 06:24:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/30] patman: Move code for sending into its own module
Date: Tue, 29 Apr 2025 07:22:11 -0600
Message-ID: <20250429132239.251756-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

