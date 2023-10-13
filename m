Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D1FCDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 03:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0625D86AE6;
	Fri, 13 Oct 2023 05:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihNhq0YI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1D186E06; Fri, 13 Oct 2023 05:08:22 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496AE86E2F
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.cournoyer@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-773ac11de71so105193885a.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 20:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697166403; x=1697771203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/64RQ3oOSIjpICAK8uGcVvS7yjdjD4LNDilh+sd3tSI=;
 b=ihNhq0YIJIcWkQIvv3wHkpY0/TPlmuT3+CGXNa7TvZNUT0BydyhcfRcJiRfZ2ohnWm
 uSmP5cg5xLAKNJ6DM0MhlPHwj5kuzsE8Gsc+wE7Z0WKhxFv4jkVEcaMI0TbzW7fqv+iK
 5DcjiQt5g2fBpiJVPKl4Jw36tB81oOpD1WuSMFkIOsmjho8RawN1hSHU/rhrCbYb3v6t
 EH2pUeNaC4lKFYNAgcwS1lf9HFZIMH2tIG6Mu80qzQlDci/qtM7bDzYBMx9B3PIn5/0F
 9u9IufxaE4LVQLyeyBwoZJMLOyUIOwQ+efwCMgqo+3NibZnre+P/jtat9uPJjXfPRpSM
 Mcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697166403; x=1697771203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/64RQ3oOSIjpICAK8uGcVvS7yjdjD4LNDilh+sd3tSI=;
 b=d1uJXoUmT8gEUHglr1aFY1VL/ulscdJ9MwztTmYnrJI+Z5BuKJURB51yeaAH1d4SYc
 7puwCuvTpaI3ebyd1sKG5wdvtZjqdq43jjtCd4konKk3ahb0cjqnYesWvwUJWNuIjwsr
 6QmLQaEndujsfxa3MY8lpg+iwbHZmNb6aM1clLNpplnOKI91bDoQakuzTIj27v5f+bmL
 y7j6NfCL8BUVZTmtCAURqpfxlxbV9i7NiQVTuthMNAH3qE2lG27UKWyZUC4bmh9hTBzb
 XEkLk+EiTR/BvzxGia69BmPND+nS3BChmnOBB6Ol6Jus6VLAVyZpyfrjn1r9DXe0LUUk
 AqHw==
X-Gm-Message-State: AOJu0Yy9Qt06YnDqrMqKnHtdM+hEbG/9qq/gkte/ILKJmaQ1ybgrH+5E
 y0skch3wl45yJRGbBGsUuD5oCIh4Nm4xbw==
X-Google-Smtp-Source: AGHT+IE7HdfJWpBRvHJyd/xVanOEodtE5Z0Ia1KtFo7GIt98vLXuOa1+chKrR5PcbI7lvhzEN6RPMg==
X-Received: by 2002:a05:620a:254b:b0:775:6f44:5c1c with SMTP id
 s11-20020a05620a254b00b007756f445c1cmr28573878qko.60.1697166402657; 
 Thu, 12 Oct 2023 20:06:42 -0700 (PDT)
Received: from localhost.localdomain (dsl-10-128-66.b2b2c.ca. [72.10.128.66])
 by smtp.gmail.com with ESMTPSA id
 z10-20020ae9c10a000000b0077423f849c3sm294222qki.24.2023.10.12.20.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 20:06:42 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: u-boot@lists.denx.de
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] patman: Add a 'keep_change_id' setting
Date: Thu, 12 Oct 2023 23:06:24 -0400
Message-ID: <20231013030633.7191-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013011924.23877-1-maxim.cournoyer@gmail.com>
References: <20231013011924.23877-1-maxim.cournoyer@gmail.com>
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

A Change-Id can be useful for traceability purposes, and some projects
may wish to have them preserved.  This change makes it configurable
via a new 'keep_change_id' setting.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---

Changes in v2:
- Add missing argument to send parser
- Correctly propagate args.keep_change_id

 tools/patman/__main__.py        |  2 ++
 tools/patman/control.py         | 12 +++++++++---
 tools/patman/patchstream.py     | 17 ++++++++++++-----
 tools/patman/patman.rst         | 11 ++++++-----
 tools/patman/test_checkpatch.py | 16 ++++++++++++++++
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 8eba5d3486..197ac1aad1 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -103,6 +103,8 @@ send.add_argument('--no-signoff', action='store_false', dest='add_signoff',
                   default=True, help="Don't add Signed-off-by to patches")
 send.add_argument('--smtp-server', type=str,
                   help="Specify the SMTP server to 'git send-email'")
+send.add_argument('--keep-change-id', action='store_true',
+                  help='Preserve Change-Id tags in patches to send.')
 
 send.add_argument('patchfiles', nargs='*')
 
diff --git a/tools/patman/control.py b/tools/patman/control.py
index 916ddf8fcf..b292da9dc2 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -16,11 +16,14 @@ from patman import gitutil
 from patman import patchstream
 from u_boot_pylib import terminal
 
+
 def setup():
     """Do required setup before doing anything"""
     gitutil.setup()
 
-def prepare_patches(col, branch, count, start, end, ignore_binary, signoff):
+
+def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
+                    keep_change_id=False):
     """Figure out what patches to generate, then generate them
 
     The patch files are written to the current directory, e.g. 0001_xxx.patch
@@ -35,6 +38,7 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff):
         end (int): End patch to use (0=last one in series, 1=one before that,
             etc.)
         ignore_binary (bool): Don't generate patches for binary files
+        keep_change_id (bool): Preserve the Change-Id tag.
 
     Returns:
         Tuple:
@@ -59,11 +63,12 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff):
         branch, start, to_do, ignore_binary, series, signoff)
 
     # Fix up the patch files to our liking, and insert the cover letter
-    patchstream.fix_patches(series, patch_files)
+    patchstream.fix_patches(series, patch_files, keep_change_id)
     if cover_fname and series.get('cover'):
         patchstream.insert_cover_letter(cover_fname, series, to_do)
     return series, cover_fname, patch_files
 
+
 def check_patches(series, patch_files, run_checkpatch, verbose, use_tree):
     """Run some checks on a set of patches
 
@@ -166,7 +171,8 @@ def send(args):
     col = terminal.Color()
     series, cover_fname, patch_files = prepare_patches(
         col, args.branch, args.count, args.start, args.end,
-        args.ignore_binary, args.add_signoff)
+        args.ignore_binary, args.add_signoff,
+        keep_change_id=args.keep_change_id)
     ok = check_patches(series, patch_files, args.check_patch,
                        args.verbose, args.check_patch_use_tree)
 
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index f91669a940..e2e2a83e67 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -68,6 +68,7 @@ STATE_PATCH_SUBJECT = 1     # In patch subject (first line of log for a commit)
 STATE_PATCH_HEADER = 2      # In patch header (after the subject)
 STATE_DIFFS = 3             # In the diff part (past --- line)
 
+
 class PatchStream:
     """Class for detecting/injecting tags in a patch or series of patches
 
@@ -76,7 +77,7 @@ class PatchStream:
     unwanted tags or inject additional ones. These correspond to the two
     phases of processing.
     """
-    def __init__(self, series, is_log=False):
+    def __init__(self, series, is_log=False, keep_change_id=False):
         self.skip_blank = False          # True to skip a single blank line
         self.found_test = False          # Found a TEST= line
         self.lines_after_test = 0        # Number of lines found after TEST=
@@ -86,6 +87,7 @@ class PatchStream:
         self.section = []                # The current section...END section
         self.series = series             # Info about the patch series
         self.is_log = is_log             # True if indent like git log
+        self.keep_change_id = keep_change_id  # True to keep Change-Id tags
         self.in_change = None            # Name of the change list we are in
         self.change_version = 0          # Non-zero if we are in a change list
         self.change_lines = []           # Lines of the current change
@@ -452,6 +454,8 @@ class PatchStream:
 
         # Detect Change-Id tags
         elif change_id_match:
+            if self.keep_change_id:
+                out = [line]
             value = change_id_match.group(1)
             if self.is_log:
                 if self.commit.change_id:
@@ -763,7 +767,7 @@ def get_metadata_for_test(text):
     pst.finalise()
     return series
 
-def fix_patch(backup_dir, fname, series, cmt):
+def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False):
     """Fix up a patch file, by adding/removing as required.
 
     We remove our tags from the patch file, insert changes lists, etc.
@@ -776,6 +780,7 @@ def fix_patch(backup_dir, fname, series, cmt):
         fname (str): Filename to patch file to process
         series (Series): Series information about this patch set
         cmt (Commit): Commit object for this patch file
+        keep_change_id (bool): Keep the Change-Id tag.
 
     Return:
         list: A list of errors, each str, or [] if all ok.
@@ -783,7 +788,7 @@ def fix_patch(backup_dir, fname, series, cmt):
     handle, tmpname = tempfile.mkstemp()
     outfd = os.fdopen(handle, 'w', encoding='utf-8')
     infd = open(fname, 'r', encoding='utf-8')
-    pst = PatchStream(series)
+    pst = PatchStream(series, keep_change_id=keep_change_id)
     pst.commit = cmt
     pst.process_stream(infd, outfd)
     infd.close()
@@ -795,7 +800,7 @@ def fix_patch(backup_dir, fname, series, cmt):
     shutil.move(tmpname, fname)
     return cmt.warn
 
-def fix_patches(series, fnames):
+def fix_patches(series, fnames, keep_change_id=False):
     """Fix up a list of patches identified by filenames
 
     The patch files are processed in place, and overwritten.
@@ -803,6 +808,7 @@ def fix_patches(series, fnames):
     Args:
         series (Series): The Series object
         fnames (:type: list of str): List of patch files to process
+        keep_change_id (bool): Keep the Change-Id tag.
     """
     # Current workflow creates patches, so we shouldn't need a backup
     backup_dir = None  #tempfile.mkdtemp('clean-patch')
@@ -811,7 +817,8 @@ def fix_patches(series, fnames):
         cmt = series.commits[count]
         cmt.patch = fname
         cmt.count = count
-        result = fix_patch(backup_dir, fname, series, cmt)
+        result = fix_patch(backup_dir, fname, series, cmt,
+                           keep_change_id=keep_change_id)
         if result:
             print('%d warning%s for %s:' %
                   (len(result), 's' if len(result) > 1 else '', fname))
diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index 038b651ee8..a8b317eed6 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -371,11 +371,12 @@ Series-process-log: sort, uniq
     Separate each tag with a comma.
 
 Change-Id:
-    This tag is stripped out but is used to generate the Message-Id
-    of the emails that will be sent. When you keep the Change-Id the
-    same you are asserting that this is a slightly different version
-    (but logically the same patch) as other patches that have been
-    sent out with the same Change-Id.
+    This tag is used to generate the Message-Id of the emails that
+    will be sent. When you keep the Change-Id the same you are
+    asserting that this is a slightly different version (but logically
+    the same patch) as other patches that have been sent out with the
+    same Change-Id. The Change-Id tag line is removed from outgoing
+    patches, unless the `keep_change_id` settings is set to `True`.
 
 Various other tags are silently removed, like these Chrome OS and
 Gerrit tags::
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index a8bb364e42..59a53ef8ca 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -160,6 +160,22 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
 
         rc = os.system('diff -u %s %s' % (inname, expname))
         self.assertEqual(rc, 0)
+        os.remove(inname)
+
+        # Test whether the keep_change_id settings works.
+        inhandle, inname = tempfile.mkstemp()
+        infd = os.fdopen(inhandle, 'w', encoding='utf-8')
+        infd.write(data)
+        infd.close()
+
+        patchstream.fix_patch(None, inname, series.Series(), com,
+                              keep_change_id=True)
+
+        with open(inname, 'r') as f:
+            content = f.read()
+            self.assertIn(
+                'Change-Id: I80fe1d0c0b7dd10aa58ce5bb1d9290b6664d5413',
+                content)
 
         os.remove(inname)
         os.remove(expname)

base-commit: f9a47ac8d97da2b3aaf463f268a9a872a8d921df
-- 
2.41.0

