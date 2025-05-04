Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5769BC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F85A82B16;
	Sun,  4 May 2025 15:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gg3S3+Oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9ED82B27; Sun,  4 May 2025 15:24:53 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B855B82B16
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so7075148a12.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365090; x=1746969890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4xv+kMcXhx+nBjYQKo/KFWsr9iVGHnmTexC3yUG0xs=;
 b=Gg3S3+Oa8lNhnCebxiHCkRu/yfeqSMmWRaOkWlH/ChXPRjCzPYr2mRTn5fPs70GUST
 6+etH6f1d1v+0Anf+UXaFMxcJdFcHq1FSwArxcYXncxlOP+VtuoXXYUd/FNEE9m2YcG+
 vQlWRvAqxgEbF7fQwLGeI76d4eLlkE4ezpib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365090; x=1746969890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4xv+kMcXhx+nBjYQKo/KFWsr9iVGHnmTexC3yUG0xs=;
 b=mlr4YDU/YlaaLEMb8P0eVM/rWNBrLRGV2+WSwRY4pePAloENMFAowRwK/urU5B3KMx
 AMCWW8JruUuiXqypAndG0KsMe+vxkQneSIVtlqinszZaRqR/Y7AAVrBrr/6ldZRIv8md
 V60Dzx0Bj5gxJIImSX3ZJpwxWILVEHXkkg1/3n8PZk4QXOQMVsyNnW92tp/2n8pjqZE+
 2FDVQ3GWuTYrEgh+zutbA4QUg4vq1OQIWaJ/Z7ZSCEsGcNH/gso8XsSQ3kNqcs9qDGdS
 qzH0aL0BXtUwK2wNLjLnwhiW8QqDyzG6mL0DYpW3hiHfVee70zRswnuveOjdPy8MLAF7
 iH2Q==
X-Gm-Message-State: AOJu0YxwzSU6cz0q6bF6HGuIlrRF9eEAklxf2o99tO4lIoDcIxPLmO7q
 MH3eaE7BJuZxodJQeJQ0nPZwomLjHjNXf9Vfhd0J0cocCq1nbEC/h3080sOjOl7ZMT0FLPChRve
 SGLbd0dQ=
X-Gm-Gg: ASbGncsDfUdCSASvB2Ak4srJ57FB9UPZeyuWIayxy10Is5S//c2s3D6SGhXRu+uU+/B
 KRVxXQ4rq6PsYs3U/tbafhRojkYAJjiIZPLeWv+VaEH6wawtL90Wp25E54RSIzfWmmbfXpJ3Qs2
 To+WJqIsyGZgB+CLjEdvjuCvW77R0xwzrGC6raCM6ZP6KQ6R2O/JlWv1LcYSlBFB2Jmow3RUQjP
 awUjtz/R5jGopUJPrYm5vi6JoSLtVSPo3DCnGP9lepU3wOSxSyYNB7yVZbkg8QMVJ+Ih26yqnme
 cwdSSvmZALu6ZY/8ZnXLcpAcABTpircwOFhx
X-Google-Smtp-Source: AGHT+IEH9Tkmn6UXrRQgLjrKqeHG1y3ZU8rMP1rx2CBt4B6jHBsfTNqC0PCxV+f/0pgjHeY7gNpOOQ==
X-Received: by 2002:a17:907:8e12:b0:ac1:dd6f:f26c with SMTP id
 a640c23a62f3a-ad17b83460emr712644566b.46.1746365090233; 
 Sun, 04 May 2025 06:24:50 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/30] patman: Switch over to asyncio
Date: Sun,  4 May 2025 15:23:43 +0200
Message-ID: <20250504132356.2317305-28-sjg@chromium.org>
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

Now that all the pieces are in place, switch over from using an executor
to using asyncio.

While we are here, import defaultdict to avoid needing to specify its
module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |   4 +-
 tools/patman/patchwork.py |   8 +--
 tools/patman/status.py    | 137 ++++++++++++++++++++++++++++----------
 3 files changed, 105 insertions(+), 44 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 47fbbe0cc3f..eee20b9b155 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -789,7 +789,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         """Test Patchwork patches not matching the series"""
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
         with terminal.capture() as (_, err):
-            patches = status.collect_patches(1234, pwork)
+            patches = asyncio.run(status.check_status(1234, pwork))
             status.check_patch_count(0, len(patches))
         self.assertIn('Warning: Patchwork reports 1 patches, series has 0',
                       err.getvalue())
@@ -797,7 +797,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
     def test_status_read_patch(self):
         """Test handling a single patch in Patchwork"""
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
-        patches = status.collect_patches(1234, pwork)
+        patches = asyncio.run(status.check_status(1234, pwork))
         self.assertEqual(1, len(patches))
         patch = patches[0]
         self.assertEqual('1', patch.id)
diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index 8b0968c5765..2b7734bbfe4 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -9,6 +9,7 @@ import asyncio
 import re
 
 import aiohttp
+from u_boot_pylib import terminal
 
 # Number of retries
 RETRIES = 3
@@ -188,13 +189,6 @@ class Patchwork:
                     if i == RETRIES:
                         raise
 
-    async def session_request(self, subpath):
-        async with aiohttp.ClientSession() as client:
-            return await self._request(client, subpath)
-
-    def request(self, subpath):
-        return asyncio.run(self.session_request(subpath))
-
     @staticmethod
     def for_testing(func):
         """Get an instance to use for testing
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 8fc2a50b426..f5be51461e7 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -8,18 +8,18 @@ Allows creation of a new branch based on the old but with the review tags
 collected from patchwork.
 """
 
+import asyncio
 from collections import defaultdict
 import concurrent.futures
 from itertools import repeat
 
+import aiohttp
 import pygit2
-import requests
 
 from u_boot_pylib import terminal
 from u_boot_pylib import tout
 from patman import patchstream
 from patman import patchwork
-from patman.patchstream import PatchStream
 
 
 def to_int(vals):
@@ -292,7 +292,7 @@ def create_branch(series, new_rtag_list, branch, dest_branch, overwrite,
             [parent.target])
     return num_added
 
-def check_status(series, series_id, pwork):
+def _check_status(series, series_id, pwork):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
@@ -349,7 +349,59 @@ def check_patch_count(num_commits, num_patches):
                      f'series has {num_commits}')
 
 
-def do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
+def do_show_status(patches, series, branch, show_comments, col,
+                    warnings_on_stderr=True):
+    """Check the status of a series on Patchwork
+
+    This finds review tags and comments for a series in Patchwork, displaying
+    them to show what is new compared to the local series.
+
+    Args:
+        patches (list of Patch): Patch objects in the series
+        series (Series): Series object for the existing branch
+        branch (str): Existing branch to update, or None
+        show_comments (bool): True to show the comments on each patch
+        col (terminal.Colour): Colour object
+
+    Return: tuple:
+        int: Number of new review tags to add
+        list: List of review tags to add, one item for each commit, each a
+                dict:
+            key: Response tag (e.g. 'Reviewed-by')
+            value: Set of people who gave that response, each a name/email
+                string
+        list of PATCH objects
+    """
+    compare = []
+    for pw_patch in patches:
+        patch = patchwork.Patch(pw_patch.id)
+        patch.parse_subject(pw_patch.series_data['name'])
+        compare.append(patch)
+
+    count = len(series.commits)
+    new_rtag_list = [None] * count
+    review_list = [None] * count
+
+    patch_for_commit, _, warnings = compare_with_series(series, compare)
+    for warn in warnings:
+        tout.do_output(tout.WARNING if warnings_on_stderr else tout.INFO, warn)
+
+    for seq, pw_patch in enumerate(patches):
+        compare[seq].patch = pw_patch
+
+    for i in range(count):
+        pat = patch_for_commit.get(i)
+        if pat:
+            patch_data = pat.patch.data
+            comment_data = pat.patch.comments
+            new_rtag_list[i], review_list[i] = process_reviews(
+                patch_data['content'], comment_data, series.commits[i].rtags)
+    num_to_add = _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
+                   review_list, col)
+    return num_to_add, new_rtag_list, patches
+
+
+def _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
                    review_list, col):
     num_to_add = 0
     for seq, cmt in enumerate(series.commits):
@@ -367,19 +419,24 @@ def do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
         num_to_add += show_responses(col, new_rtags, indent, True)
         if show_comments:
             for review in review_list[seq]:
-                terminal.tprint('Review: %s' % review.meta, colour=col.RED)
+                terminal.tprint('Review: %s' % review.meta, colour=col.RED,
+                                col=col)
                 for snippet in review.snippets:
                     for line in snippet:
                         quoted = line.startswith('>')
-                        terminal.tprint('    %s' % line,
-                                       colour=col.MAGENTA if quoted else None)
+                        terminal.tprint(
+                            f'    {line}',
+                            colour=col.MAGENTA if quoted else None, col=col)
                     terminal.tprint()
     return num_to_add
 
 
-def show_status(series, branch, dest_branch, force, patches, patch_for_commit,
-                show_comments, new_rtag_list, review_list, test_repo=None):
-    """Show status to the user and allow a branch to be written
+def show_status(series, branch, dest_branch, force, patches, show_comments,
+                test_repo=None):
+    """Check the status of a series on Patchwork
+
+    This finds review tags and comments for a series in Patchwork, displaying
+    them to show what is new compared to the local series.
 
     Args:
         series (Series): Series object for the existing branch
@@ -387,34 +444,44 @@ def show_status(series, branch, dest_branch, force, patches, patch_for_commit,
         dest_branch (str): Name of new branch to create, or None
         force (bool): True to force overwriting dest_branch if it exists
         patches (list of Patch): Patches sorted by sequence number
-        patch_for_commit (dict): Patches for commit
-            key: Commit number (0...n-1)
-            value: Patch object for that commit
-        show_comments (bool): True to show patch comments
-        new_rtag_list (list of dict) review tags for each patch:
-            key: Response tag (e.g. 'Reviewed-by')
-            value: Set of people who gave that response, each a name/email
-                string
-        review_list (list of list): list for each patch, each a:
-            list of Review objects for the patch
+        show_comments (bool): True to show the comments on each patch
         test_repo (pygit2.Repository): Repo to use (use None unless testing)
     """
     col = terminal.Color()
     check_patch_count(len(series.commits), len(patches))
-    num_to_add = do_show_status(series, patch_for_commit, show_comments,
-                                new_rtag_list, review_list, col)
+    num_to_add, new_rtag_list, _ = do_show_status(
+        patches, series, branch, show_comments, col)
 
-    terminal.tprint("%d new response%s available in patchwork%s" %
-                   (num_to_add, 's' if num_to_add != 1 else '',
-                    '' if dest_branch
-                    else ' (use -d to write them to a new branch)'))
+    if not dest_branch and num_to_add:
+        msg = ' (use -d to write them to a new branch)'
+    else:
+        msg = ''
+    terminal.tprint(
+        f"{num_to_add} new response{'s' if num_to_add != 1 else ''} "
+        f'available in patchwork{msg}')
 
     if dest_branch:
-        num_added = create_branch(series, new_rtag_list, branch, dest_branch,
-                                  force, test_repo)
+        num_added = create_branch(series, new_rtag_list, branch,
+                                  dest_branch, force, test_repo)
         terminal.tprint(
-            "%d response%s added from patchwork into new branch '%s'" %
-            (num_added, 's' if num_added != 1 else '', dest_branch))
+            f"{num_added} response{'s' if num_added != 1 else ''} added "
+            f"from patchwork into new branch '{dest_branch}'")
+
+
+async def check_status(link, pwork, read_comments=False):
+    """Set up an HTTP session and get the required state
+
+    Args:
+        link (str): Patch series ID number
+        pwork (Patchwork): Patchwork object to use for reading
+        read_comments (bool): True to read comments and state for each patch
+
+    Return: tuple:
+        list of Patch objects
+    """
+    async with aiohttp.ClientSession() as client:
+        patches = await pwork.series_get_state(client, link, read_comments)
+    return patches
 
 
 def check_and_show_status(series, link, branch, dest_branch, force,
@@ -427,11 +494,11 @@ def check_and_show_status(series, link, branch, dest_branch, force,
         branch (str): Existing branch to update, or None
         dest_branch (str): Name of new branch to create, or None
         force (bool): True to force overwriting dest_branch if it exists
-        show_comments (bool): True to show patch comments
+        show_comments (bool): True to show the comments on each patch
         pwork (Patchwork): Patchwork object to use for reading
         test_repo (pygit2.Repository): Repo to use (use None unless testing)
     """
-    patches, patch_for_commit, new_rtag_list, review_list = check_status(
-        series, link, pwork)
-    show_status(series, branch, dest_branch, force, patches, patch_for_commit,
-                show_comments, new_rtag_list, review_list, test_repo)
+    patches = asyncio.run(check_status(link, pwork, True))
+
+    show_status(series, branch, dest_branch, force, patches, show_comments,
+                test_repo=test_repo)
-- 
2.43.0

