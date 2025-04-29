Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D95BC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E540782A4D;
	Tue, 29 Apr 2025 15:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fkjWgeRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88CC782A4D; Tue, 29 Apr 2025 15:25:10 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0451282A65
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3feaedb39e9so1895177b6e.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933104; x=1746537904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIcF1OrJBMRrJusIkCR+gWvKqAs4KnqRngmEqvQDPGk=;
 b=fkjWgeRxkBAjFRhlCq4HoOUDyV9fvUTD0Wl/7yBL74dKOaS9QZ7JVpGx2ynmcNiHVZ
 qoQY2HjaGOTSzcp9rd1+xco28H6tC/SYUpGJbOBicsVZCj/Zv/8SI8y9jGhfoXjmbz6C
 RIiA6qmsfBHGcm3Sl8a0GdXdfbhyKdWPYOu+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933104; x=1746537904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIcF1OrJBMRrJusIkCR+gWvKqAs4KnqRngmEqvQDPGk=;
 b=wCVzb0LwSzNYBeYbv4wGgUuBxRNwxm7z53DLZBBehmWEm16muJMPU1okdzqS1F+Z6z
 zR8v/DKixcNvKJAFxBdVS20tK3ynKI1T4bytd01MB6o9DldBG/IWPVWjUH3MUxZbUbbu
 29g+jn8YRZicqQpKo7Xs5ifvZEOe+6S7PmQzyExe0bF1+POFz61bzMhhJjYypxCYyjWZ
 rSGRhfccVYK9Em8bpt7lLuuGrMfUjtPlAI/fgzB21GsIt9hGV5xKY2vDvHYXSNfuFZFk
 FT0WHE7A0BIjml//aI7LkyesE0RkEMkVEnBADK24DcgX1FlkhBRzDc+GsgIaOiwoAjlm
 IhRA==
X-Gm-Message-State: AOJu0YypdAXaCGAqdl2BnoeVsM/NBhrUrzRuUQo9EvV1gg5wHUIphCj4
 mJTMvCkdMdRcw3sq21mOmx/iiva/96jgl4SOtk455IwVRtg1j/0kjgCyRDug09f5H8pSjQwgw0s
 =
X-Gm-Gg: ASbGnctFylMTRS+2Ygfg+5itdYsLtdwTnwCD9S9ScJvMSDHVMciu7ofNta9+L1t7zyj
 OBqKO6OgAxW8ud/7qa5LlNXrPo/4rJug2Xy/kj7iMrnuhl8ltY7DvQ865eMQ08yTzShm7fWW4pK
 nO5V8tJ+QQH+9H1HvRnYkjcg5wMYKjFUBk/TgvhhBzNcYGBR45gDEdlsKwzHvhhT6a5ItSpmIt2
 Gv6pDpkF/m03ynJOfRvLBAQlR0EkWu7kgpGLovKcD/QZk1pWMIlsSVuUp5vjPVGljOBuyZFO6um
 e07DAb7BgXY+haI0LggV+z3G5RlbW0wW84OTQZRE8st602emDyZJxanUKCPZ/S7lzLUDGJnGMle
 ikg==
X-Google-Smtp-Source: AGHT+IEr0Q/9ECtRfKOAh1vom0Ck/afUb8Rbxa9cI1dpi5B7oIm6rjHAhwmsTyV7YD7IMohEZHWgjg==
X-Received: by 2002:a05:6808:3843:b0:3f8:498c:9ef7 with SMTP id
 5614622812f47-401fd7c5dc9mr7968295b6e.24.1745933103602; 
 Tue, 29 Apr 2025 06:25:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:25:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/30] patman: Switch over to asyncio
Date: Tue, 29 Apr 2025 07:22:24 -0600
Message-ID: <20250429132239.251756-28-sjg@chromium.org>
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

Now that all the pieces are in place, switch over from using an executor
to using asyncio.

While we are here, import defaultdict to avoid needing to specify its
module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

