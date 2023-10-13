Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB8CCDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 02:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6FC86B36;
	Fri, 13 Oct 2023 03:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5G4WUls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A1D86AE6; Fri, 13 Oct 2023 03:20:12 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20BE86E08
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 03:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.cournoyer@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66d122e0c85so9062896d6.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 18:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697159981; x=1697764781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a0OFeL+8jyuRyQ3j+NubMB/kGQvOb2s3Exa0yF/FGJ4=;
 b=J5G4WUls1IzK1KMoTCbXvQdzh17Muifo6tXqDuZ9U8GYL4DTLxApiZrV8VlzQmAC4A
 eGddfUdLg/nfMHu2lqzXxsu55oZa/pGDDk1OQSeKTpdA4y9keYYtxbFv2bUygJrRz8eb
 8vr7AjrEr3bnt/MJGhM6cD+jNelXRpTNBsJpm0kU6W07qCJaVQ8/ywNGAcwoO5dIy7hn
 jcmqBEJyW9q+DtP6Ns6r8mNQvubhwYxPlIP9NdAmqdXKAVuzxNZ0x7sRfz/vIyc7Ib65
 SqGxFOuqiL6dwBo1TRSyihAibGfm/zuozcx9OA5gz06yxFh9pXnAzsRlPpwNT2PP1A/b
 egHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697159981; x=1697764781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0OFeL+8jyuRyQ3j+NubMB/kGQvOb2s3Exa0yF/FGJ4=;
 b=GD14wuFEEDuxx2Ll+mmYbD8VJOoWhxobqTil2n44HkR/SJnJQQaqapX+BkKEfxe6xY
 dyInPQUb9SoXUgxiowRvqA9158PiCT1bNkd7vffEyZjLnWY1pBGg7/pyvk9JI9/YUKJk
 8M7pDUb0HF9yyt9ozpa0dS+HIsefdo7bKb8oQJtWIH9PpbuOkG5yDOVc2wxD5YTFxpH0
 3TkY0qj/ONolZPEbnj29r9lTHSJhWAZx9l53Ib0nHE9HGLGvE6TPs2fz0D4WfXm8yQ3n
 C2HkLyd0jPgQkvMg3izayljmI83EpHkgrilIznTk0G3KC5iSjlPDo+q3nEkqXF7YnJi1
 jDbA==
X-Gm-Message-State: AOJu0YzYtUVcTEld4wgI2UpVvRtzR6PApcnNdeUyqto38BXkAaamuxJz
 dLiqB2NGMr87tekcMfZBdJWpWZbNFcc6XQ==
X-Google-Smtp-Source: AGHT+IHy9u30hEyUg0mf4a7Zj+xF/vQw06UCLF+CYSYtnpkJip2omVwupw7XET6sCmwg078WDafoQQ==
X-Received: by 2002:a0c:f44d:0:b0:66d:403:41c with SMTP id
 h13-20020a0cf44d000000b0066d0403041cmr6387525qvm.21.1697159981294; 
 Thu, 12 Oct 2023 18:19:41 -0700 (PDT)
Received: from localhost.localdomain (dsl-10-128-66.b2b2c.ca. [72.10.128.66])
 by smtp.gmail.com with ESMTPSA id
 ef14-20020a0562140a6e00b00655d711180dsm260090qvb.17.2023.10.12.18.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 18:19:40 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: u-boot@lists.denx.de
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] patman: Add a 'keep_change_id' setting
Date: Thu, 12 Oct 2023 21:19:15 -0400
Message-ID: <20231013011924.23877-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.41.0
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

 tools/patman/control.py         |  9 +++++++--
 tools/patman/patchstream.py     | 17 ++++++++++++-----
 tools/patman/patman.rst         | 11 ++++++-----
 tools/patman/test_checkpatch.py | 16 ++++++++++++++++
 4 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index 916ddf8fcf..29383551ed 100644
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
 
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index f91669a940..4188d0ed35 100644
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
+                           keep_change_id=False)
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

