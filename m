Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D4FC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 19:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D30814BD;
	Thu, 27 Feb 2025 20:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ezpkR0n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37C2814B6; Thu, 27 Feb 2025 20:27:42 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D76D814BD
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 20:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85592116ca4so105526239f.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740684458; x=1741289258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ru0K3O85JxFt6Ey/Ei5mKZsZfAQa87Mxu8VnkyG4S4=;
 b=ezpkR0n4i1RzzeSslobFY6Lqu5TH0n9R391TIV9bkLo6V9korlK7vK3C8r3ETf/L/F
 1Pu1c4KqW4O23aXShjZrg4MGuR33YJHBiKm/NueOGrDoxYTSxNVwT+v+V6AP2KC7p+ig
 LFynkQYKXBjtrE7CkfOPUK3ZJmnx2t1o8QO0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740684458; x=1741289258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Ru0K3O85JxFt6Ey/Ei5mKZsZfAQa87Mxu8VnkyG4S4=;
 b=FNhJhv01yynFptcAxf0XkaoCd0Cy+D9ZO3iZivQiVf7v9EP18qmTn3+N6I7sQ2UD3y
 eD4FJM0x8E9TsQVJbf/Juihsaxr1d5jWt3RhHOmA3SMic+Bo5KIfMawwHndc2nzVf5Aq
 eHfXbPicdR0RyG6xdbvzxAbedAEHtzvdPdjCXyaa2S37IaygVqS/A60faVYH6GH741gt
 l+Yu9yxy5oq1jcA3NHpNAfDrqHqsJjCrjGHAXnJlowBXHGrRkO4j0CJshH/IO9z2w4Me
 7xlgUKmb12aGNnqQ538ovVm6ZYzRkBDd2eDDZbi46rfKdpe+1W6SzKKNHUM93zeHVI/U
 yReQ==
X-Gm-Message-State: AOJu0Yzl+7U/eckmOoL6qu+/Y8BKUVvDUPw40k546nTPT/NUWG56FHKt
 49Y2E1Kl5XQUhC8RI6pGG2LXYcYFnuXI3RWh1uDPdwkfauLeZoDwHMpRLHxFnh0wJCoBsvetQkk
 =
X-Gm-Gg: ASbGnctL7RVWeK6s37omGAENS97aIOkkt4I8v9City563yW5e26sbphNuN4tPOyC6wi
 f5c1ghKbYAtTOWOHDecbMt1CQWVza9Ww+jkXeqTuvoPKU3gySR7KXU1A1DBlUfeueOl6pW1FsLY
 +B2vLyB1q8RN0oym74w9q9IaMuEP4Pm1NZHaknUMukgm0c045E4mKHz/u6faizCXHEqy5erOCDj
 xEidSfLwrMawJjPS9h4Y83OGN7RQUoB/Xzrduru9891SIIyTZz3JwyfSCeRTflMq+wUkgF2wZb7
 qghFSN7i+NETlvEGkxYDQm/Dvs73BfBAKPWUcP01bLYlNOC8uA7QdSA+byWYPlg=
X-Google-Smtp-Source: AGHT+IHKMEGvDCiUlDuFS6TiJwJP1TJ9YhuMzHsVObmUIqpyyk0Y3i5kvPzQ3JIQFypBoHq9DVI/Tg==
X-Received: by 2002:a05:6e02:1fe5:b0:3d3:e287:3e7a with SMTP id
 e9e14a558f8ab-3d3e6f70760mr5292085ab.19.1740684458081; 
 Thu, 27 Feb 2025 11:27:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061c7019bsm498229173.59.2025.02.27.11.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 11:27:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] patman: Show the base commit and branch
Date: Thu, 27 Feb 2025 12:27:30 -0700
Message-ID: <20250227192735.406389-1-sjg@chromium.org>
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

It is helpful to know which commit patches are based on, even if that
commit might not be available to readers. Add a tag for this in the
cover letter.

Also add the local-branch name since that may be useful to the writer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py     | 19 ++++++++++++++++++-
 tools/patman/patchstream.py   | 15 +++++++++++++--
 tools/patman/series.py        |  2 ++
 tools/u_boot_pylib/gitutil.py | 27 ++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index bf333dc557b..44eba2cdbb7 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -216,6 +216,8 @@ class TestFunctional(unittest.TestCase):
 
         text = self._get_text('test01.txt')
         series = patchstream.get_metadata_for_test(text)
+        series.base_commit = Commit('1a44532')
+        series.branch = 'mybranch'
         cover_fname, args = self._create_patches_for_test(series)
         get_maintainer_script = str(pathlib.Path(__file__).parent.parent.parent
                                     / 'get_maintainer.pl') + ' --norolestats'
@@ -308,6 +310,8 @@ Simon Glass (2):
 --\x20
 2.7.4
 
+base-commit: 1a44532
+branch: mybranch
 '''
         lines = open(cover_fname, encoding='utf-8').read().splitlines()
         self.assertEqual(
@@ -511,12 +515,18 @@ complicated as possible''')
             # Check that it can detect a different branch
             self.assertEqual(3, gitutil.count_commits_to_branch('second'))
             with capture_sys_output() as _:
-                _, cover_fname, patch_files = control.prepare_patches(
+                series, cover_fname, patch_files = control.prepare_patches(
                     col, branch='second', count=-1, start=0, end=0,
                     ignore_binary=False, signoff=True)
             self.assertIsNotNone(cover_fname)
             self.assertEqual(3, len(patch_files))
 
+            cover = tools.read_file(cover_fname, binary=False)
+            lines = cover.splitlines()[-2:]
+            base = repo.lookup_reference('refs/heads/base').target
+            self.assertEqual(f'base-commit: {base}', lines[0])
+            self.assertEqual('branch: second', lines[1])
+
             # Check that it can skip patches at the end
             with capture_sys_output() as _:
                 _, cover_fname, patch_files = control.prepare_patches(
@@ -524,6 +534,13 @@ complicated as possible''')
                     ignore_binary=False, signoff=True)
             self.assertIsNotNone(cover_fname)
             self.assertEqual(2, len(patch_files))
+
+            cover = tools.read_file(cover_fname, binary=False)
+            lines = cover.splitlines()[-2:]
+            base2 = repo.lookup_reference('refs/heads/second')
+            ref = base2.peel(pygit2.GIT_OBJ_COMMIT).parents[0].parents[0].id
+            self.assertEqual(f'base-commit: {ref}', lines[0])
+            self.assertEqual('branch: second', lines[1])
         finally:
             os.chdir(orig_dir)
 
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 490d382045b..156c1ad0e32 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -755,8 +755,12 @@ def get_metadata(branch, start, count):
     Returns:
         Series: Object containing information about the commits.
     """
-    return get_metadata_for_list(
-        '%s~%d' % (branch if branch else 'HEAD', start), None, count)
+    top = f"{branch if branch else 'HEAD'}~{start}"
+    series = get_metadata_for_list(top, None, count)
+    series.base_commit = commit.Commit(gitutil.get_hash(f'{top}~{count}'))
+    series.branch = branch or gitutil.get_branch()
+    series.top = top
+    return series
 
 def get_metadata_for_test(text):
     """Process metadata from a file containing a git log. Used for tests
@@ -868,4 +872,11 @@ def insert_cover_letter(fname, series, count):
             out = series.MakeChangeLog(None)
             line += '\n' + '\n'.join(out)
         fil.write(line)
+
+    # Insert the base commit and branch
+    if series.base_commit:
+        print(f'base-commit: {series.base_commit.hash}', file=fil)
+    if series.branch:
+        print(f'branch: {series.branch}', file=fil)
+
     fil.close()
diff --git a/tools/patman/series.py b/tools/patman/series.py
index d7f2f010f5d..b73e9c58de4 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -42,6 +42,8 @@ class Series(dict):
         self.notes = []
         self.changes = {}
         self.allow_overwrite = False
+        self.base_commit = None
+        self.branch = None
 
         # Written in MakeCcFile()
         #  key: name of patch file
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 6d6a7eedecc..c13e532231c 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -689,13 +689,38 @@ def setup():
                        .return_code == 0)
 
 
+def get_hash(spec):
+    """Get the hash of a commit
+
+    Args:
+        spec (str): Git commit to show, e.g. 'my-branch~12'
+
+    Returns:
+        str: Hash of commit
+    """
+    return command.output_one_line('git', 'show', '-s', '--pretty=format:%H',
+                                   spec)
+
+
 def get_head():
     """Get the hash of the current HEAD
 
     Returns:
         Hash of HEAD
     """
-    return command.output_one_line('git', 'show', '-s', '--pretty=format:%H')
+    return get_hash('HEAD')
+
+
+def get_branch():
+    """Get the branch we are currently on
+
+    Return:
+        str: branch name, or None if none
+    """
+    out = command.output_one_line('git', 'rev-parse', '--abbrev-ref', 'HEAD')
+    if out == 'HEAD':
+        return None
+    return out
 
 
 if __name__ == "__main__":
-- 
2.43.0

