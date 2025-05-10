Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C19C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F6382A8D;
	Sat, 10 May 2025 13:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F+JlxooG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1E58070C; Sat, 10 May 2025 13:06:13 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D52882A8B
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-ad221e3e5a2so215612866b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875169; x=1747479969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGIXBh7KeRPUr1pqooPAR/KsLLISjyHoYI1+EtuCPL4=;
 b=F+JlxooGDA3V5imV4r+AKoaAjKwO923MQEP/GdjzwbL+2dgYJolBpx6dc6uElDy9w8
 nd6BRbxEQfqjsyPcw0a0IH05dectqqYVMwn81aPA4uTkJDxJ4TqVCc0/Ya2kOcO6ui89
 C+HgsRoGlSj8MPJ5rQuyD4m+EBzMMknmR+rMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875169; x=1747479969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGIXBh7KeRPUr1pqooPAR/KsLLISjyHoYI1+EtuCPL4=;
 b=UobHyOiNf/+8ZEoYZ9Rg8cUk7M1GHxZaLzl9a8hvpzdUucXxWPyHGTK8I+lCeugD9Z
 qEQwOWfeBC1wTB3vQaqOP/Cd1vNfvShxwPlvMeSSYRmtq4EW5BGQjsvKuFnx2cxqYfcz
 ys5UyDRK77nYOQg2QL/U0s9gFBBkDKM2y/ufobxLKILIx6QT5GasbbR2I79yZvHerM1t
 qvhe0YZhXbQwo+0Ihy8x3i1d52wtHNL6gtR9RjHNZkaViqGzVvkPIKzq5mznGJ8rIUv4
 0myuz7Z3dFbQj27jTTKMkDaTA06PxiXnlD/HroMJ+di+ch3SqXiMfBlWNeZOYW1bjw7R
 /0ww==
X-Gm-Message-State: AOJu0Yyj7SZzx4COB64XBgXap/hEYmIjuMTfo+EaLnok2tX4gz322u9g
 BsJr3GT+mE2GY50UHI8kMx1719pei9UYDYjfgE+hcNpkmSsshCMNo8tQxHZ4L+falqXWKZ5mhwZ
 BdErtzHuzFFmL
X-Gm-Gg: ASbGnctjTZQmXwxzlGoJhbx/tlNSkO7LfLaaxiuFIE0jITvf2nl0Z2sjE0VmSQ50YX0
 ds3YeB/sB3CSMZZLbXm/tI6Tspynxlfdwqb3aUOULLqsSmjpoQ/m2rdqUGx4KkiGIBoOGA33ADs
 YUu1pOWZxIZ6IxH899Ah9O5oVzqP0m7zYhFfRA4+Ws8BMfshpTlEjF1GymaE3JwxZ5zCAUozeSO
 yoUz9qe7E2VYIEkbdQTSSjrbk3cS6q4i94qhSVZlOdCuzoh0MXMPJYgzKMpIXm+HwI6zroqo8JM
 8x6EDrxVjCIPdsTcA29JH16EwBVgdj07AYRTu2qj6oAi7PA=
X-Google-Smtp-Source: AGHT+IHvJ8tZFYL/uptnFKXT/hRlvBV49KN4MGzmgXHcCTx7LLdewmEP7wlD+THTHQlXRiP0pClxaw==
X-Received: by 2002:a17:907:2cc3:b0:acb:b28b:ccd with SMTP id
 a640c23a62f3a-ad219170e31mr627038166b.46.1746875169422; 
 Sat, 10 May 2025 04:06:09 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/25] patman: Update status command support cover-letter info
Date: Sat, 10 May 2025 13:05:05 +0200
Message-ID: <20250510110535.1453745-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Add support to the status module for reading and supporting cover
letters, including comments. Plumb this through to the patchwork module.
The actual support in the latter is not yet integrated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 16 +++++----
 tools/patman/patchwork.py | 15 ++++++---
 tools/patman/status.py    | 71 ++++++++++++++++++++++++++-------------
 3 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 2faff8019f6..d029181765c 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -669,7 +669,8 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
         with terminal.capture() as (_, err):
             loop = asyncio.get_event_loop()
-            patches = loop.run_until_complete(status.check_status(1234, pwork))
+            _, patches = loop.run_until_complete(status.check_status(1234,
+                                                                     pwork))
             status.check_patch_count(0, len(patches))
         self.assertIn('Warning: Patchwork reports 1 patches, series has 0',
                       err.getvalue())
@@ -678,7 +679,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         """Test handling a single patch in Patchwork"""
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
         loop = asyncio.get_event_loop()
-        patches = loop.run_until_complete(status.check_status(1234, pwork))
+        _, patches = loop.run_until_complete(status.check_status(1234, pwork))
         self.assertEqual(1, len(patches))
         patch = patches[0]
         self.assertEqual('1', patch.id)
@@ -928,7 +929,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         terminal.set_print_test_mode()
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
         status.check_and_show_status(series, '1234', None, None, False, False,
-                                     pwork)
+                                     False, pwork)
         itr = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
@@ -1041,8 +1042,9 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
 
         terminal.set_print_test_mode()
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork3)
-        status.check_and_show_status(series, '1234', branch, dest_branch,
-                                     False, False, pwork, repo)
+        status.check_and_show_status(
+            series, '1234', branch, dest_branch, False, False, False, pwork,
+            repo)
         lines = terminal.get_print_test_lines()
         self.assertEqual(12, len(lines))
         self.assertEqual(
@@ -1244,8 +1246,8 @@ Reviewed-by: %s
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
-        status.check_and_show_status(series, '1234', None, None, False, True,
-                                     pwork)
+        status.check_and_show_status(
+            series, '1234', None, None, False, True, False, pwork)
         itr = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index 47d7be28fdf..afafb97ffed 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -388,16 +388,20 @@ class Patchwork:
 
         return Patch(patch_id, state, data, comment_data)
 
-    async def series_get_state(self, client, link, read_comments):
+    async def series_get_state(self, client, link, read_comments,
+                               read_cover_comments):
         """Sync the series information against patchwork, to find patch status
 
         Args:
             client (aiohttp.ClientSession): Session to use
             link (str): Patchwork series ID
             read_comments (bool): True to read the comments on the patches
+            read_cover_comments (bool): True to read the comments on the cover
+                letter
 
         Return: tuple:
-            list of Patch objects
+            COVER object, or None if none or not read_cover_comments
+            list of PATCH objects
         """
         data = await self.get_series(client, link)
         patch_list = list(data['patches'])
@@ -407,7 +411,7 @@ class Patchwork:
         if read_comments:
             # Returns a list of Patch objects
             tasks = [self._get_patch_status(client, patch_list[i]['id'])
-                                            for i in range(count)]
+                     for i in range(count)]
 
             patch_status = await asyncio.gather(*tasks)
             for patch_data, status in zip(patch_list, patch_status):
@@ -422,4 +426,7 @@ class Patchwork:
         if self._show_progress:
             terminal.print_clear()
 
-        return patches
+        # TODO: Implement this
+        cover = None
+
+        return cover, patches
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 74d05624226..967fef3ad6e 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -74,7 +74,7 @@ def compare_with_series(series, patches):
 
     Args:
         series (Series): Series to compare against
-        patches (:type: list of Patch): list of Patch objects to compare with
+        patches (list of Patch): list of Patch objects to compare with
 
     Returns:
         tuple
@@ -224,18 +224,20 @@ def check_patch_count(num_commits, num_patches):
                      f'series has {num_commits}')
 
 
-def do_show_status(patches, series, branch, show_comments, col,
-                    warnings_on_stderr=True):
+def do_show_status(series, cover, patches, show_comments, show_cover_comments,
+                   col, warnings_on_stderr=True):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
     them to show what is new compared to the local series.
 
     Args:
-        patches (list of Patch): Patch objects in the series
         series (Series): Series object for the existing branch
-        branch (str): Existing branch to update, or None
+        cover (COVER): Cover letter info, or None if none
+        patches (list of Patch): Patches sorted by sequence number
         show_comments (bool): True to show the comments on each patch
+        show_cover_comments (bool): True to show the comments on the
+            letter
         col (terminal.Colour): Colour object
 
     Return: tuple:
@@ -245,7 +247,6 @@ def do_show_status(patches, series, branch, show_comments, col,
             key: Response tag (e.g. 'Reviewed-by')
             value: Set of people who gave that response, each a name/email
                 string
-        list of PATCH objects
     """
     compare = []
     for pw_patch in patches:
@@ -274,13 +275,26 @@ def do_show_status(patches, series, branch, show_comments, col,
                 new_rtag_list[i], review_list[i] = process_reviews(
                     patch_data['content'], comment_data,
                     series.commits[i].rtags)
-        num_to_add = _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
-                       review_list, col)
-    return num_to_add, new_rtag_list, patches
+        num_to_add = _do_show_status(
+            series, cover, patch_for_commit, show_comments,
+            show_cover_comments, new_rtag_list, review_list, col)
+
+    return num_to_add, new_rtag_list
 
 
-def _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
-                   review_list, col):
+def _do_show_status(series, cover, patch_for_commit, show_comments,
+                    show_cover_comments, new_rtag_list, review_list, col):
+    if cover and show_cover_comments:
+        terminal.tprint(f'Cov {cover.name}', colour=col.BLACK, col=col,
+                        bright=False, back=col.YELLOW)
+        for seq, comment in enumerate(cover.comments):
+            submitter = comment['submitter']
+            person = '%s <%s>' % (submitter['name'], submitter['email'])
+            terminal.tprint(f"From: {person}: {comment['date']}",
+                            colour=col.RED, col=col)
+            print(comment['content'])
+            print()
+
     num_to_add = 0
     for seq, cmt in enumerate(series.commits):
         patch = patch_for_commit.get(seq)
@@ -309,26 +323,29 @@ def _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
     return num_to_add
 
 
-def show_status(series, branch, dest_branch, force, patches, show_comments,
-                test_repo=None):
+def show_status(series, branch, dest_branch, force, cover, patches,
+                show_comments, show_cover_comments, test_repo=None):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
     them to show what is new compared to the local series.
 
     Args:
+        client (aiohttp.ClientSession): Session to use
         series (Series): Series object for the existing branch
         branch (str): Existing branch to update, or None
         dest_branch (str): Name of new branch to create, or None
         force (bool): True to force overwriting dest_branch if it exists
+        cover (COVER): Cover letter info, or None if none
         patches (list of Patch): Patches sorted by sequence number
         show_comments (bool): True to show the comments on each patch
+        show_cover_comments (bool): True to show the comments on the letter
         test_repo (pygit2.Repository): Repo to use (use None unless testing)
     """
     col = terminal.Color()
     check_patch_count(len(series.commits), len(patches))
-    num_to_add, new_rtag_list, _ = do_show_status(
-        patches, series, branch, show_comments, col)
+    num_to_add, new_rtag_list = do_show_status(
+        series, cover, patches, show_comments, show_cover_comments, col)
 
     if not dest_branch and num_to_add:
         msg = ' (use -d to write them to a new branch)'
@@ -346,7 +363,8 @@ def show_status(series, branch, dest_branch, force, patches, show_comments,
             f"from patchwork into new branch '{dest_branch}'")
 
 
-async def check_status(link, pwork, read_comments=False):
+async def check_status(link, pwork, read_comments=False,
+                       read_cover_comments=False):
     """Set up an HTTP session and get the required state
 
     Args:
@@ -354,16 +372,18 @@ async def check_status(link, pwork, read_comments=False):
         pwork (Patchwork): Patchwork object to use for reading
         read_comments (bool): True to read comments and state for each patch
 
-    Return: tuple:
-        list of Patch objects
+        Return: tuple:
+            COVER object, or None if none or not read_cover_comments
+            list of PATCH objects
     """
     async with aiohttp.ClientSession() as client:
-        patches = await pwork.series_get_state(client, link, read_comments)
-    return patches
+        return await pwork.series_get_state(client, link, read_comments,
+                                             read_cover_comments)
 
 
 def check_and_show_status(series, link, branch, dest_branch, force,
-                          show_comments, pwork, test_repo=None):
+                          show_comments, show_cover_comments, pwork,
+                          test_repo=None):
     """Read the series status from patchwork and show it to the user
 
     Args:
@@ -373,10 +393,13 @@ def check_and_show_status(series, link, branch, dest_branch, force,
         dest_branch (str): Name of new branch to create, or None
         force (bool): True to force overwriting dest_branch if it exists
         show_comments (bool): True to show the comments on each patch
+        show_cover_comments (bool): True to show the comments on the letter
         pwork (Patchwork): Patchwork object to use for reading
         test_repo (pygit2.Repository): Repo to use (use None unless testing)
     """
-    patches = asyncio.run(check_status(link, pwork, True))
+    loop = asyncio.get_event_loop()
+    cover, patches = loop.run_until_complete(check_status(
+        link, pwork, True, show_cover_comments))
 
-    show_status(series, branch, dest_branch, force, patches, show_comments,
-                test_repo=test_repo)
+    show_status(series, branch, dest_branch, force, cover, patches,
+                show_comments, show_cover_comments, test_repo=test_repo)
-- 
2.43.0

