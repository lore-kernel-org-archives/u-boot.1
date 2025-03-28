Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9CBC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133C181E1C;
	Fri, 28 Mar 2025 14:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ec0eO4B+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9473E81DCC; Fri, 28 Mar 2025 14:02:36 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5D881E1C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d59c8f0979so8993955ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743166951; x=1743771751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XgWFz4vRXEAC8rI3b9hwDW791xM8IyRaWX94UOkdlHQ=;
 b=Ec0eO4B+gOza1BEsQko2b+G7ulsfn1EEhp2BWn8ddt5Wm3b4ppXM+vnkI3olP8us/D
 GfkBlLxqjz60Eg/kSlcEuMro//TsBZ3G55aGsde/OqvOYtfw61D3Bww5tCaskPfbVD5l
 zTDyYl8EpviDG0YjXHKGq1fsXcFKTEOv9ChYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743166951; x=1743771751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XgWFz4vRXEAC8rI3b9hwDW791xM8IyRaWX94UOkdlHQ=;
 b=M9xCaRwsOI05/XD8O9qo0J1bsnZyQ/LRgGcZtGOtBR+RQg9w3cRQiACTG9YHwKiZwH
 Ljp+eCkYxY57ZV6OCPENiSCfk1X+0Fy1K9sm3dy+k09psucKCTkEo9UDOendiQvPqP7B
 nLrGXOqt3hkuLWrW+9ytxEAzyUud2zPUMmaCIx6viHsNTj/Q/dlXiAD/asmbUYWIoKza
 rU0kPYF8Sxv2XgsXAbaoeT4UVRIrIcpRWvBgiuXfdTC1iOXRjDI5dVHbvHDJW9S3a32a
 v4bGCKTWAwfyBNtgZoqUwwkQbo2dXlyA4t/s6YWswyVDySMi4pDQx4hF+j8K7WIj9bl+
 Bdwg==
X-Gm-Message-State: AOJu0Yy4/nv3fygooW8BfbVqvUFiXm4gT0bx80vNdaP/nq/cNTM6rn8g
 2bu+KeuCOIn06bK0zjtKRGiPrV/Q3JsbdFkuku9yTlQO8C4ZT/+QBURnZiUFV7WxqNKEV2wOXlY
 =
X-Gm-Gg: ASbGncsGRlnM7zqPjBLPWprBs/RiiV3Zjm8ujoCqQctjyeMOoiS25w+FfyHwtG1FPjQ
 sW1bU7uii+kqqoYEoXK2zRw2/asEiLqOPjJKZzRtUoj3erVTfQc1ob0G4iUDc/IlBaDRgUTYhfN
 ZaewL9cG3aHkrPoahGzybFEBzXk6SCh49asUkyXNGMUC+RzQh6gakxA1c73xe0NhPPeNkb57bps
 D4bzMBr+So3NN+XuTGViUEwRJ8LFbYOjoJ7Pi8qbzC2hCibUiBbcSPmj4s4lZI7BEOROnbzIwsP
 +c4s0uelTvuKevhcN7VZyg7zqARgO7vhrx/nB8nPSpp8G8MH8XeHWlUqYaEGAEYEBsk+mgg0l/n
 x1n+x7Q==
X-Google-Smtp-Source: AGHT+IGFvmH+bvG1KVLSrJ8jFjdQQPChMS2xoZ9Lh/SHj94bAHAzDXwwxgEOSt82EyRWBDnrP/MOgg==
X-Received: by 2002:a05:6e02:32c6:b0:3d4:6ed4:e0a with SMTP id
 e9e14a558f8ab-3d5d6f42d76mr24316225ab.4.1743166950707; 
 Fri, 28 Mar 2025 06:02:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d5d5a630c8sm4547065ab.15.2025.03.28.06.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:02:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] patman: Show base commit on each patch when no cover letter
Date: Fri, 28 Mar 2025 07:02:20 -0600
Message-ID: <20250328130225.2607974-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

If a series is sent without a cover letter, there is no indication of
the base commit. Add support for this, since single patches of small
series may not always have a cover letter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py     |  3 ++-
 tools/patman/func_test.py   | 30 ++++++++++++++++++++++++++++++
 tools/patman/patchstream.py | 28 +++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index fb5a4246ced..b8a45912058 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -63,7 +63,8 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
         branch, start, to_do, ignore_binary, series, signoff)
 
     # Fix up the patch files to our liking, and insert the cover letter
-    patchstream.fix_patches(series, patch_files, keep_change_id)
+    patchstream.fix_patches(series, patch_files, keep_change_id,
+                            insert_base_commit=not cover_fname)
     if cover_fname and series.get('cover'):
         patchstream.insert_cover_letter(cover_fname, series, to_do)
     return series, cover_fname, patch_files
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 44eba2cdbb7..720746e21f5 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -357,6 +357,31 @@ Changes in v2:
                 expected = expected.splitlines()
                 self.assertEqual(expected, lines[start:(start+len(expected))])
 
+    def test_base_commit(self):
+        """Test adding a base commit with no cover letter"""
+        orig_text = self._get_text('test01.txt')
+        pos = orig_text.index('commit 5ab48490f03051875ab13d288a4bf32b507d76fd')
+        text = orig_text[:pos]
+        series = patchstream.get_metadata_for_test(text)
+        series.base_commit = Commit('1a44532')
+        series.branch = 'mybranch'
+        cover_fname, args = self._create_patches_for_test(series)
+        self.assertFalse(cover_fname)
+        with capture_sys_output() as out:
+            patchstream.fix_patches(series, args, insert_base_commit=True)
+        self.assertEqual('Cleaned 1 patch\n', out[0].getvalue())
+        lines = tools.read_file(args[0], binary=False).splitlines()
+        pos = lines.index('-- ')
+
+        # We expect these lines at the end:
+        # -- (with trailing space)
+        # 2.7.4
+        # (empty)
+        # base-commit: xxx
+        # branch: xxx
+        self.assertEqual('base-commit: 1a44532', lines[pos + 3])
+        self.assertEqual('branch: mybranch', lines[pos + 4])
+
     def make_commit_with_file(self, subject, body, fname, text):
         """Create a file and add it to the git repo with a new commit
 
@@ -527,6 +552,11 @@ complicated as possible''')
             self.assertEqual(f'base-commit: {base}', lines[0])
             self.assertEqual('branch: second', lines[1])
 
+            # Make sure that the base-commit is not present when it is in the
+            # cover letter
+            for fname in patch_files:
+                self.assertNotIn(b'base-commit:', tools.read_file(fname))
+
             # Check that it can skip patches at the end
             with capture_sys_output() as _:
                 _, cover_fname, patch_files = control.prepare_patches(
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 156c1ad0e32..7a695c37c27 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -76,8 +76,13 @@ class PatchStream:
     are interested in. We can also process a patch file in order to remove
     unwanted tags or inject additional ones. These correspond to the two
     phases of processing.
+
+    Args:
+        keep_change_id (bool): Keep the Change-Id tag
+        insert_base_commit (bool): True to add the base commit to the end
     """
-    def __init__(self, series, is_log=False, keep_change_id=False):
+    def __init__(self, series, is_log=False, keep_change_id=False,
+                 insert_base_commit=False):
         self.skip_blank = False          # True to skip a single blank line
         self.found_test = False          # Found a TEST= line
         self.lines_after_test = 0        # Number of lines found after TEST=
@@ -103,6 +108,7 @@ class PatchStream:
         self.recent_quoted = collections.deque([], 5)
         self.recent_unquoted = queue.Queue()
         self.was_quoted = None
+        self.insert_base_commit = insert_base_commit
 
     @staticmethod
     def process_text(text, is_comment=False):
@@ -658,6 +664,13 @@ class PatchStream:
                     outfd.write(line + '\n')
                     self.blank_count = 0
         self.finalise()
+        if self.insert_base_commit:
+            if self.series.base_commit:
+                print(f'base-commit: {self.series.base_commit.hash}',
+                      file=outfd)
+            if self.series.branch:
+                print(f'branch: {self.series.branch}', file=outfd)
+
 
 def insert_tags(msg, tags_to_emit):
     """Add extra tags to a commit message
@@ -778,7 +791,8 @@ def get_metadata_for_test(text):
     pst.finalise()
     return series
 
-def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False):
+def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False,
+              insert_base_commit=False):
     """Fix up a patch file, by adding/removing as required.
 
     We remove our tags from the patch file, insert changes lists, etc.
@@ -792,6 +806,7 @@ def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False):
         series (Series): Series information about this patch set
         cmt (Commit): Commit object for this patch file
         keep_change_id (bool): Keep the Change-Id tag.
+        insert_base_commit (bool): True to add the base commit to the end
 
     Return:
         list: A list of errors, each str, or [] if all ok.
@@ -799,7 +814,8 @@ def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False):
     handle, tmpname = tempfile.mkstemp()
     outfd = os.fdopen(handle, 'w', encoding='utf-8')
     infd = open(fname, 'r', encoding='utf-8')
-    pst = PatchStream(series, keep_change_id=keep_change_id)
+    pst = PatchStream(series, keep_change_id=keep_change_id,
+                      insert_base_commit=insert_base_commit)
     pst.commit = cmt
     pst.process_stream(infd, outfd)
     infd.close()
@@ -811,7 +827,7 @@ def fix_patch(backup_dir, fname, series, cmt, keep_change_id=False):
     shutil.move(tmpname, fname)
     return cmt.warn
 
-def fix_patches(series, fnames, keep_change_id=False):
+def fix_patches(series, fnames, keep_change_id=False, insert_base_commit=False):
     """Fix up a list of patches identified by filenames
 
     The patch files are processed in place, and overwritten.
@@ -820,6 +836,7 @@ def fix_patches(series, fnames, keep_change_id=False):
         series (Series): The Series object
         fnames (:type: list of str): List of patch files to process
         keep_change_id (bool): Keep the Change-Id tag.
+        insert_base_commit (bool): True to add the base commit to the end
     """
     # Current workflow creates patches, so we shouldn't need a backup
     backup_dir = None  #tempfile.mkdtemp('clean-patch')
@@ -829,7 +846,8 @@ def fix_patches(series, fnames, keep_change_id=False):
         cmt.patch = fname
         cmt.count = count
         result = fix_patch(backup_dir, fname, series, cmt,
-                           keep_change_id=keep_change_id)
+                           keep_change_id=keep_change_id,
+                           insert_base_commit=insert_base_commit)
         if result:
             print('%d warning%s for %s:' %
                   (len(result), 's' if len(result) > 1 else '', fname))
-- 
2.43.0

base-commit: fa90deeb571c463b979f83c52fa9e954044dc1d2
branch: pat
