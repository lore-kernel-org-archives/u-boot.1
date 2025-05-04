Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7127AC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0823882ACF;
	Sun,  4 May 2025 15:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H3KE9Gyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B05282ACB; Sun,  4 May 2025 15:24:42 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8EB082AC4
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso691708266b.2
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365079; x=1746969879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3CilNtbNURLGoGQg0BabJCYoHi4PMvjuPDTF1B5h/U=;
 b=H3KE9Gyr34meoelpsOzk1Uu4kOf0U08GFjaoqS8a5vMYCdqrl2FmxiKOiZyz/hNigd
 ZFjHA1SjA0RhBr9XQRXCHrZOzel50LL/6LKaqdiG7iazltUEneM7ir6X2sNj8xwHMFWf
 NJ2kC/14blsBqWaXEj2jtgS2hJ+J42hALnaHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365079; x=1746969879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3CilNtbNURLGoGQg0BabJCYoHi4PMvjuPDTF1B5h/U=;
 b=r7jmXJm2g9s6ZeJ6AGmvKKnebehwI/QtjJn/IMNRQqfg9FUtDPYZt3U2Ho7/LdGdrp
 HhxPqu198kyLdys99SiUA4thSl9KOnhEA70nvNV2+lghNP9M/KCH3xNL1V5hiEKTE6AO
 r7kva4/b8r16jLtPgUCkgDLTbjDCyx8xJfEebKVkmDNF3oLxWWzw6BA0RtrMvRCtAMV6
 m5/6bnDNcF+L0zHynjuuGbJqH4+kupc/dyWwj2v2pKMery0l0/FsfzQY7IlLQAxido6A
 50F82r3QAMHg8C1vf/UtLCwFqxSjaMOzMt4XRuS3DtrGXHepDjDO+5pYdAGUWXb+5XAN
 +mZw==
X-Gm-Message-State: AOJu0YwyxPlp6aU++tFFSJ+MmiwYkXDCXwDw2Tceyu3vahDgDWS8Y4B4
 Lx3uvEOFOpu8181p552ryuEdCuSV37YQ7ZIxDlkY4NeUoYN18rZ6ecQGb5qX4UhhgwHqcW9XNru
 /JTN62IM=
X-Gm-Gg: ASbGncuzxdBXFyFZrvTURjrmVV7qokdNSuL/aM1nHJJpoAax9ggmlBM7LjF8NUWroxA
 PeFiflf0J/J5U4nipucYuppdSq/MSYa86xWtsd/aY2VyKiOjNpxzrYmzKpqs26tOGiA7RWUEjrf
 ckA1/Wuy9Ms/dw/9ul5/2J2GpdZnIMu/IQneZHSY3pQPY9o45cNnl9ZGWQYvH1Hai6wg7MJ86kR
 HeZ1Vln7UKK2pRfJFH93dflKTPG0x2UwatiMi6ls37196DZIyLwwj4JG5Xp7b6xer6OwUaRX2ER
 5X0KtLHGgMkBykc/5Ha4xzxZYs1137+Utewr
X-Google-Smtp-Source: AGHT+IEI94RejjxLQYvHuey7drnxLPi35geJOy2U+wulMlkY2ldFaE9AZp/M+huLVONs+b7RGwQV/w==
X-Received: by 2002:a17:907:2d25:b0:ac7:391b:e688 with SMTP id
 a640c23a62f3a-ad1a4b7c2e9mr358012566b.58.1746365078696; 
 Sun, 04 May 2025 06:24:38 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/30] patman: Split up check_and_show_status()
Date: Sun,  4 May 2025 15:23:36 +0200
Message-ID: <20250504132356.2317305-21-sjg@chromium.org>
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

This function has three phases:

- collecting things from patchwork
- doing some processing
- showing the results to the user / creating a branch

Refactor into two functions so we can eventually have the patchwork part
fully separated out.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |   5 +-
 tools/patman/status.py    | 107 +++++++++++++++++++++++++++++++-------
 2 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 31ba708ab87..ea96c508fa2 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -790,7 +790,8 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         series = Series()
 
         with terminal.capture() as (_, err):
-            status.collect_patches(series, 1234, None, self._fake_patchwork)
+            patches = status.collect_patches(1234, None, self._fake_patchwork)
+            status.check_patch_count(0, len(patches))
         self.assertIn('Warning: Patchwork reports 1 patches, series has 0',
                       err.getvalue())
 
@@ -799,7 +800,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         series = Series()
         series.commits = [Commit('abcd')]
 
-        patches = status.collect_patches(series, 1234, None,
+        patches = status.collect_patches(1234, None,
                                          self._fake_patchwork)
         self.assertEqual(1, len(patches))
         patch = patches[0]
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 57786e496be..cb049f5d996 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -108,22 +108,20 @@ def call_rest_api(url, subpath):
         raise ValueError("Could not read URL '%s'" % full_url)
     return response.json()
 
-def collect_patches(series, series_id, url, rest_api=call_rest_api):
+def collect_patches(series_id, url, rest_api=call_rest_api):
     """Collect patch information about a series from patchwork
 
     Uses the Patchwork REST API to collect information provided by patchwork
     about the status of each patch.
 
     Args:
-        series (Series): Series object corresponding to the local branch
-            containing the series
         series_id (str): Patch series ID number
         url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
         rest_api (function): API function to call to access Patchwork, for
             testing
 
     Returns:
-        list: List of patches sorted by sequence number, each a Patch object
+        list of Patch: List of patches sorted by sequence number
 
     Raises:
         ValueError: if the URL could not be read or the web page does not follow
@@ -134,10 +132,6 @@ def collect_patches(series, series_id, url, rest_api=call_rest_api):
     # Get all the rows, which are patches
     patch_dict = data['patches']
     count = len(patch_dict)
-    num_commits = len(series.commits)
-    if count != num_commits:
-        tout.warning('Warning: Patchwork reports %d patches, series has %d' %
-                     (count, num_commits))
 
     patches = []
 
@@ -300,9 +294,7 @@ def create_branch(series, new_rtag_list, branch, dest_branch, overwrite,
             [parent.target])
     return num_added
 
-def check_and_show_status(series, series_id, branch, dest_branch, force,
-                          show_comments, url, rest_api=call_rest_api,
-                          test_repo=None):
+def check_status(series, series_id, url, rest_api=call_rest_api):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
@@ -311,17 +303,24 @@ def check_and_show_status(series, series_id, branch, dest_branch, force,
     Args:
         series (Series): Series object for the existing branch
         series_id (str): Patch series ID number
-        branch (str): Existing branch to update, or None
-        dest_branch (str): Name of new branch to create, or None
-        force (bool): True to force overwriting dest_branch if it exists
-        show_comments (bool): True to show the comments on each patch
         url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
         rest_api (function): API function to call to access Patchwork, for
             testing
-        test_repo (pygit2.Repository): Repo to use (use None unless testing)
+
+    Return:
+        tuple:
+            list of Patch: List of patches sorted by sequence number
+            dict: Patches for commit
+                key: Commit number (0...n-1)
+                value: Patch object for that commit
+            list of dict: review tags:
+                key: Response tag (e.g. 'Reviewed-by')
+                value: Set of people who gave that response, each a name/email
+                    string
+            list for each patch, each a:
+                list of Review objects for the patch
     """
-    patches = collect_patches(series, series_id, url, rest_api)
-    col = terminal.Color()
+    patches = collect_patches(series_id, url, rest_api)
     count = len(series.commits)
     new_rtag_list = [None] * count
     review_list = [None] * count
@@ -340,7 +339,23 @@ def check_and_show_status(series, series_id, branch, dest_branch, force,
     for fresponse in futures:
         if fresponse:
             raise fresponse.exception()
+    return patches, patch_for_commit, new_rtag_list, review_list
+
+
+def check_patch_count(num_commits, num_patches):
+    """Check the number of commits and patches agree
+
+    Args:
+        num_commits (int): Number of commits
+        num_patches (int): Number of patches
+    """
+    if num_patches != num_commits:
+        tout.warning(f'Warning: Patchwork reports {num_patches} patches, '
+                     f'series has {num_commits}')
 
+
+def do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
+                   review_list, col):
     num_to_add = 0
     for seq, cmt in enumerate(series.commits):
         patch = patch_for_commit.get(seq)
@@ -364,6 +379,35 @@ def check_and_show_status(series, series_id, branch, dest_branch, force,
                         terminal.tprint('    %s' % line,
                                        colour=col.MAGENTA if quoted else None)
                     terminal.tprint()
+    return num_to_add
+
+
+def show_status(series, branch, dest_branch, force, patches, patch_for_commit,
+                show_comments, new_rtag_list, review_list, test_repo=None):
+    """Show status to the user and allow a branch to be written
+
+    Args:
+        series (Series): Series object for the existing branch
+        branch (str): Existing branch to update, or None
+        dest_branch (str): Name of new branch to create, or None
+        force (bool): True to force overwriting dest_branch if it exists
+        patches (list of Patch): Patches sorted by sequence number
+        patch_for_commit (dict): Patches for commit
+            key: Commit number (0...n-1)
+            value: Patch object for that commit
+        show_comments (bool): True to show patch comments
+        new_rtag_list (list of dict) review tags for each patch:
+            key: Response tag (e.g. 'Reviewed-by')
+            value: Set of people who gave that response, each a name/email
+                string
+        review_list (list of list): list for each patch, each a:
+            list of Review objects for the patch
+        test_repo (pygit2.Repository): Repo to use (use None unless testing)
+    """
+    col = terminal.Color()
+    check_patch_count(len(series.commits), len(patches))
+    num_to_add = do_show_status(series, patch_for_commit, show_comments,
+                                new_rtag_list, review_list, col)
 
     terminal.tprint("%d new response%s available in patchwork%s" %
                    (num_to_add, 's' if num_to_add != 1 else '',
@@ -371,8 +415,31 @@ def check_and_show_status(series, series_id, branch, dest_branch, force,
                     else ' (use -d to write them to a new branch)'))
 
     if dest_branch:
-        num_added = create_branch(series, new_rtag_list, branch,
-                                  dest_branch, force, test_repo)
+        num_added = create_branch(series, new_rtag_list, branch, dest_branch,
+                                  force, test_repo)
         terminal.tprint(
             "%d response%s added from patchwork into new branch '%s'" %
             (num_added, 's' if num_added != 1 else '', dest_branch))
+
+
+def check_and_show_status(series, link, branch, dest_branch, force,
+                          show_comments, url, rest_api=call_rest_api,
+                          test_repo=None):
+    """Read the series status from patchwork and show it to the user
+
+    Args:
+        series (Series): Series object for the existing branch
+        link (str): Patch series ID number
+        branch (str): Existing branch to update, or None
+        dest_branch (str): Name of new branch to create, or None
+        force (bool): True to force overwriting dest_branch if it exists
+        show_comments (bool): True to show patch comments
+        url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
+        rest_api (function): API function to call to access Patchwork, for
+            testing
+        test_repo (pygit2.Repository): Repo to use (use None unless testing)
+    """
+    patches, patch_for_commit, new_rtag_list, review_list = check_status(
+        series, link, url, rest_api)
+    show_status(series, branch, dest_branch, force, patches, patch_for_commit,
+                show_comments, new_rtag_list, review_list, test_repo)
-- 
2.43.0

