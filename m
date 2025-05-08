Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF4DC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53704829EF;
	Thu,  8 May 2025 09:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TcAeIgss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408AE829CD; Thu,  8 May 2025 09:29:25 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6648059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so4461675e9.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689361; x=1747294161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKcQ2IN/2gqUwJgai59isc7FkorFV94ymGCMuejmZSY=;
 b=TcAeIgss7E5yTVJNvtqR5gono7FRrRYuirR9ezN7HsXfyqCoaqS/LCthit4A40Y9fr
 kAicAGVUA1pAqQGTlUyLTPt1upjKagj3WAfDePWYaBmRdc35HnGCxNvJk03DmDnJhdci
 vfCNU+yioDYTcvYt9PP1FeITgbFIj6A58BzyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689361; x=1747294161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKcQ2IN/2gqUwJgai59isc7FkorFV94ymGCMuejmZSY=;
 b=b3ajr527dc2UJxzihKqZRWT07wTfzURxpuiBIk6zzngrmj+3UcOKEPfd+RSX4McUIu
 +Sv3qxjoS0QXmoU4ZhgyGYqb+p2O99pmbtmnk30d6L5dpDMTnRfM8JypVvPM14ArOqEf
 hwOKhJMi5sgCRnDFs3QqQAVzbV98mZa9jKnxivCOay+0Gjj78huaUIXTwS45eb39nz/2
 mK0hy8zZAZu24QF3R3s2e7lUmGe9UcRW/295bLncpk5Vk/DrelaGT3g4gJGS3Kggr6n3
 +l32I0z5+kDEV0ADv38OvVGyR/XCFrpfM3ItRmWP4o3yNneK47dAk245OJxc8aMpxpr+
 uhvQ==
X-Gm-Message-State: AOJu0Yz1tK/0VZuocgqaZHJQzS1s39nsveQkE6/NG3+fpkco+OTcGPwJ
 TYziahxH6BiDLXL2Oc0tWkj5Rj0tdpV0yO8MtDVBs9en3BGNiQttBWEZ730m1nWjZwSZ4YQIBHB
 m3g0cP2RsID89
X-Gm-Gg: ASbGncuAP9xJ6Lk1OXxMhe+h9t6DwjBFLjlQVyhJfMEPwlXtTP9IJIOxuXOyqvFlj8B
 rNxt1ffLc06jmm311y8hUeO1BrULrjfiJH2YfxOXRIjRGsNMf+nxHJEZ9yqxPIBbqqx/A5J7Otx
 0VYvmF7Y1PiVkdd42EzoCKE3I+a9D8t1dhEaPL6pmH1lf/T7cNx+9F8qncqBp5OBQj4uSd3BWm+
 2QUaidRi2+Bi48pICbk6PIpBJb20AWztj81yTRRLDAuUUEteeI3xtzrfUVv0rN7DWteck3Dh5Y1
 AD74TRGd9vbuRaoLNr732BA35qjBHrTZMPJMpw==
X-Google-Smtp-Source: AGHT+IGY06b5SUWq4qrpRVxwJkHhxiuqqcpX7L9B7VzpYshnfF6NYoi5w8F1BhtufkzjqerQOR+Nsw==
X-Received: by 2002:a05:600c:46d3:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-442d02e4f5emr20158665e9.2.1746689361469; 
 Thu, 08 May 2025 00:29:21 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/20] patman: Allow setting the current directory when sending
Date: Thu,  8 May 2025 09:28:29 +0200
Message-ID: <20250508072907.207175-6-sjg@chromium.org>
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

Plumb a current-working-directory (cwd) through from send all the way to
the command gitutil libraries. This will allow better testing of this
functionality, since we can use a test directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/checkpatch.py  | 12 ++++++++----
 tools/patman/patchstream.py | 14 ++++++++++----
 tools/patman/send.py        | 33 +++++++++++++++++++--------------
 tools/patman/series.py      | 13 ++++++++-----
 4 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/tools/patman/checkpatch.py b/tools/patman/checkpatch.py
index 2975881705c..5df06b1095a 100644
--- a/tools/patman/checkpatch.py
+++ b/tools/patman/checkpatch.py
@@ -187,7 +187,8 @@ def check_patch_parse(checkpatch_output, verbose=False):
     return result
 
 
-def check_patch(fname, verbose=False, show_types=False, use_tree=False):
+def check_patch(fname, verbose=False, show_types=False, use_tree=False,
+                cwd=None):
     """Run checkpatch.pl on a file and parse the results.
 
     Args:
@@ -196,6 +197,7 @@ def check_patch(fname, verbose=False, show_types=False, use_tree=False):
             parsed
         show_types: Tell checkpatch to show the type (number) of each message
         use_tree (bool): If False we'll pass '--no-tree' to checkpatch.
+        cwd (str): Path to use for patch files (None to use current dir)
 
     Returns:
         namedtuple containing:
@@ -217,7 +219,8 @@ def check_patch(fname, verbose=False, show_types=False, use_tree=False):
         args.append('--no-tree')
     if show_types:
         args.append('--show-types')
-    output = command.output(*args, fname, raise_on_error=False)
+    output = command.output(*args, os.path.join(cwd or '', fname),
+                            raise_on_error=False)
 
     return check_patch_parse(output, verbose)
 
@@ -240,7 +243,7 @@ def get_warning_msg(col, msg_type, fname, line, msg):
     line_str = '' if line is None else '%d' % line
     return '%s:%s: %s: %s\n' % (fname, line_str, msg_type, msg)
 
-def check_patches(verbose, args, use_tree):
+def check_patches(verbose, args, use_tree, cwd):
     '''Run the checkpatch.pl script on each patch'''
     error_count, warning_count, check_count = 0, 0, 0
     col = terminal.Color()
@@ -248,7 +251,8 @@ def check_patches(verbose, args, use_tree):
     with concurrent.futures.ThreadPoolExecutor(max_workers=16) as executor:
         futures = []
         for fname in args:
-            f = executor.submit(check_patch, fname, verbose, use_tree=use_tree)
+            f = executor.submit(check_patch, fname, verbose, use_tree=use_tree,
+                                cwd=cwd)
             futures.append(f)
 
         for fname, f in zip(args, futures):
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 7a695c37c27..3ec06a6b5f5 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -792,7 +792,7 @@ def get_metadata_for_test(text):
     return series
 
 def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False,
-              insert_base_commit=False):
+              insert_base_commit=False, cwd=None):
     """Fix up a patch file, by adding/removing as required.
 
     We remove our tags from the patch file, insert changes lists, etc.
@@ -807,10 +807,12 @@ def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False,
         cmt (Commit): Commit object for this patch file
         keep_change_id (bool): Keep the Change-Id tag.
         insert_base_commit (bool): True to add the base commit to the end
+        cwd (str): Directory containing filename, or None for current
 
     Return:
         list: A list of errors, each str, or [] if all ok.
     """
+    fname = os.path.join(cwd or '', fname)
     handle, tmpname = tempfile.mkstemp()
     outfd = os.fdopen(handle, 'w', encoding='utf-8')
     infd = open(fname, 'r', encoding='utf-8')
@@ -827,7 +829,8 @@ def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False,
     shutil.move(tmpname, fname)
     return cmt.warn
 
-def fix_patches(series, fnames, keep_change_id=False, insert_base_commit=False):
+def fix_patches(series, fnames, keep_change_id=False, insert_base_commit=False,
+                cwd=None):
     """Fix up a list of patches identified by filenames
 
     The patch files are processed in place, and overwritten.
@@ -837,6 +840,7 @@ def fix_patches(series, fnames, keep_change_id=False, insert_base_commit=False):
         fnames (:type: list of str): List of patch files to process
         keep_change_id (bool): Keep the Change-Id tag.
         insert_base_commit (bool): True to add the base commit to the end
+        cwd (str): Directory containing the patch files, or None for current
     """
     # Current workflow creates patches, so we shouldn't need a backup
     backup_dir = None  #tempfile.mkdtemp('clean-patch')
@@ -847,7 +851,7 @@ def fix_patches(series, fnames, keep_change_id=False, insert_base_commit=False):
         cmt.count = count
         result = fix_patch(backup_dir, fname, series, cmt,
                            keep_change_id=keep_change_id,
-                           insert_base_commit=insert_base_commit)
+                           insert_base_commit=insert_base_commit, cwd=cwd)
         if result:
             print('%d warning%s for %s:' %
                   (len(result), 's' if len(result) > 1 else '', fname))
@@ -857,14 +861,16 @@ def fix_patches(series, fnames, keep_change_id=False, insert_base_commit=False):
         count += 1
     print('Cleaned %d patch%s' % (count, 'es' if count > 1 else ''))
 
-def insert_cover_letter(fname, series, count):
+def insert_cover_letter(fname, series, count, cwd=None):
     """Inserts a cover letter with the required info into patch 0
 
     Args:
         fname (str): Input / output filename of the cover letter file
         series (Series): Series object
         count (int): Number of patches in the series
+        cwd (str): Directory containing filename, or None for current
     """
+    fname = os.path.join(cwd or '', fname)
     fil = open(fname, 'r')
     lines = fil.readlines()
     fil.close()
diff --git a/tools/patman/send.py b/tools/patman/send.py
index d9ef445a4f5..a2db3cff07f 100644
--- a/tools/patman/send.py
+++ b/tools/patman/send.py
@@ -15,7 +15,7 @@ from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 
 
-def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
+def check_patches(series, patch_files, run_checkpatch, verbose, use_tree, cwd):
     """Run some checks on a set of patches
 
     This santiy-checks the patman tags like Series-version and runs the patches
@@ -29,6 +29,7 @@ def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
         verbose (bool): True to print out every line of the checkpatch output as
             it is parsed
         use_tree (bool): If False we'll pass '--no-tree' to checkpatch.
+        cwd (str): Path to use for patch files (None to use current dir)
 
     Returns:
         bool: True if the patches had no errors, False if they did
@@ -38,7 +39,7 @@ def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
 
     # Check the patches
     if run_checkpatch:
-        ok = checkpatch.check_patches(verbose, patch_files, use_tree)
+        ok = checkpatch.check_patches(verbose, patch_files, use_tree, cwd)
     else:
         ok = True
     return ok
@@ -46,7 +47,7 @@ def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
 
 def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
                   ignore_bad_tags, add_maintainers, get_maintainer_script, limit,
-                  dry_run, in_reply_to, thread, smtp_server):
+                  dry_run, in_reply_to, thread, smtp_server, cwd=None):
     """Email patches to the recipients
 
     This emails out the patches and cover letter using 'git send-email'. Each
@@ -85,18 +86,19 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
         thread (bool): True to add --thread to git send-email (make all patches
             reply to cover-letter or first patch in series)
         smtp_server (str): SMTP server to use to send patches (None for default)
+        cwd (str): Path to use for patch files (None to use current dir)
     """
     cc_file = series.MakeCcFile(process_tags, cover_fname, not ignore_bad_tags,
                                 add_maintainers, limit, get_maintainer_script,
-                                settings.alias)
+                                settings.alias, cwd)
 
     # Email the patches out (giving the user time to check / cancel)
     cmd = ''
     if its_a_go:
         cmd = gitutil.email_patches(
             series, cover_fname, patch_files, dry_run, not ignore_bad_tags,
-            cc_file, settings.alias, in_reply_to=in_reply_to, thread=thread,
-            smtp_server=smtp_server)
+            cc_file, alias=settings.alias, in_reply_to=in_reply_to,
+            thread=thread, smtp_server=smtp_server, cwd=cwd)
     else:
         print(col.build(col.RED, "Not sending emails due to errors/warnings"))
 
@@ -110,7 +112,7 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
 
 
 def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
-                    keep_change_id=False):
+                    keep_change_id=False, cwd=None):
     """Figure out what patches to generate, then generate them
 
     The patch files are written to the current directory, e.g. 0001_xxx.patch
@@ -126,6 +128,7 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
             etc.)
         ignore_binary (bool): Don't generate patches for binary files
         keep_change_id (bool): Preserve the Change-Id tag.
+        cwd (str): Path to use for git operations (None to use current dir)
 
     Returns:
         Tuple:
@@ -147,29 +150,31 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
     to_do = count - end
     series = patchstream.get_metadata(branch, start, to_do)
     cover_fname, patch_files = gitutil.create_patches(
-        branch, start, to_do, ignore_binary, series, signoff)
+        branch, start, to_do, ignore_binary, series, signoff,
+        cwd=cwd)
 
     # Fix up the patch files to our liking, and insert the cover letter
     patchstream.fix_patches(series, patch_files, keep_change_id,
-                            insert_base_commit=not cover_fname)
+                            insert_base_commit=not cover_fname, cwd=cwd)
     if cover_fname and series.get('cover'):
-        patchstream.insert_cover_letter(cover_fname, series, to_do)
+        patchstream.insert_cover_letter(cover_fname, series, to_do, cwd=cwd)
     return series, cover_fname, patch_files
 
 
-def send(args):
+def send(args, cwd=None):
     """Create, check and send patches by email
 
     Args:
         args (argparse.Namespace): Arguments to patman
+        cwd (str): Path to use for git operations
     """
     col = terminal.Color()
     series, cover_fname, patch_files = prepare_patches(
         col, args.branch, args.count, args.start, args.end,
         args.ignore_binary, args.add_signoff,
-        keep_change_id=args.keep_change_id)
+        keep_change_id=args.keep_change_id, cwd=cwd)
     ok = check_patches(series, patch_files, args.check_patch,
-                       args.verbose, args.check_patch_use_tree)
+                       args.verbose, args.check_patch_use_tree, cwd)
 
     ok = ok and gitutil.check_suppress_cc_config()
 
@@ -178,4 +183,4 @@ def send(args):
         col, series, cover_fname, patch_files, args.process_tags,
         its_a_go, args.ignore_bad_tags, args.add_maintainers,
         args.get_maintainer_script, args.limit, args.dry_run,
-        args.in_reply_to, args.thread, args.smtp_server)
+        args.in_reply_to, args.thread, args.smtp_server, cwd=cwd)
diff --git a/tools/patman/series.py b/tools/patman/series.py
index 3ec33e022d0..66839a3dbea 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -245,7 +245,7 @@ class Series(dict):
 
     def GetCcForCommit(self, commit, process_tags, warn_on_error,
                        add_maintainers, limit, get_maintainer_script,
-                       all_skips, alias):
+                       all_skips, alias, cwd):
         """Get the email CCs to use with a particular commit
 
         Uses subject tags and get_maintainers.pl script to find people to cc
@@ -268,6 +268,7 @@ class Series(dict):
             alias (dict): Alias dictionary
                 key: alias
                 value: list of aliases or email addresses
+            cwd (str): Path to use for patch filenames (None to use current dir)
 
         Returns:
             list of str: List of email addresses to cc
@@ -281,8 +282,8 @@ class Series(dict):
         if type(add_maintainers) == type(cc):
             cc += add_maintainers
         elif add_maintainers:
-            cc += get_maintainer.get_maintainer(get_maintainer_script,
-                                                commit.patch)
+            fname = os.path.join(cwd or '', commit.patch)
+            cc += get_maintainer.get_maintainer(get_maintainer_script, fname)
         all_skips |= set(cc) & set(settings.bounces)
         cc = list(set(cc) - set(settings.bounces))
         if limit is not None:
@@ -290,7 +291,8 @@ class Series(dict):
         return cc
 
     def MakeCcFile(self, process_tags, cover_fname, warn_on_error,
-                   add_maintainers, limit, get_maintainer_script, alias):
+                   add_maintainers, limit, get_maintainer_script, alias,
+                   cwd=None):
         """Make a cc file for us to use for per-commit Cc automation
 
         Also stores in self._generated_cc to make ShowActions() faster.
@@ -309,6 +311,7 @@ class Series(dict):
             alias (dict): Alias dictionary
                 key: alias
                 value: list of aliases or email addresses
+            cwd (str): Path to use for patch filenames (None to use current dir)
         Return:
             Filename of temp file created
         """
@@ -324,7 +327,7 @@ class Series(dict):
                 commit.future = executor.submit(
                     self.GetCcForCommit, commit, process_tags, warn_on_error,
                     add_maintainers, limit, get_maintainer_script, all_skips,
-                    alias)
+                    alias, cwd)
 
             # Show progress any commits that are taking forever
             lastlen = 0
-- 
2.43.0

