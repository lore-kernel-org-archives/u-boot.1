Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8459DC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C0882A65;
	Tue, 29 Apr 2025 15:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Onqs/fmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500578296B; Tue, 29 Apr 2025 15:25:19 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E6E82A39
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c14138668so1588516a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933115; x=1746537915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esnZngZUmbknv4yQW8nUYGaYEIT1OPjcqSj1kk7H/YM=;
 b=Onqs/fmgMYBFkrjQThJO6XJkQWfc2qFsdjvczfwDUfLOxbguSj83rV+ORVjV2lP6dk
 msNnMbNhWQ8g4qb8ToCozXW4pryxUT5AGwMXNbOB0qbTrXPUeCdtv6Hd8wBMKG52xWVR
 ke1mLOxR9bMxEKE6rTah8OXmrHjg5uhX6JDjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933115; x=1746537915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esnZngZUmbknv4yQW8nUYGaYEIT1OPjcqSj1kk7H/YM=;
 b=Fmj0Se7i7viMuonPPDMJvQ4XPnliPfBNe7+aLdLExYw9u/AI4VbuLh8ZS6avaE8kNT
 yjvgayEFS+eO/kJ4aKanGrzED1IjsFqIdKg+i+wiDEaDaICVyMIjKL15RH4WNXceOaY+
 PnBtD+IMEvZcULqCWhTJpFnqtvy065d+LWoexoSXTXTNcGA01MXZwqXGvgjJ/tI1N68C
 11u5RV+fgmRvMzswhCHIs5JP8oAh3Ps0q2u6Ymf18RolkRPVWBNCAtOdgWWMpaY8kvDg
 Cn2qRtJ0ic9Ia+AFKqZWbAnbvIbNkPR8s1pgeJqXE/cW61gHK/BLoPwL138N+pZ5Sb1x
 shXQ==
X-Gm-Message-State: AOJu0YycIjMYUfzulhL1a5NlokUDthYwXE1d/CTqqSXjl0bGG9KfDX/M
 lNbh5zpvv9sAy5xoGN6H9r/7as89lknV8LFIBxiRB5AZIUtaKW1j3BQg7MbHZ2M23sll/BtP/3Y
 =
X-Gm-Gg: ASbGncs71WalXU/jZcA8DSDMBJeH0MPIApStvsKvbbno5AJ2uKut+HGRC7U7LiNcdtl
 a1jnmylZhrT5dqo7kAdo12Z+kV5UQL9LGD7pdfvX2crMrd2id8wUlMOYvOgR9xcPFzxr5YuEsiR
 r5rPCLJ5CLddI6nvNAn8hH5NlasfhxiI9A20LmahAHXM/gHv0RknZW1vnO8DBWAcTATOWJaMmgC
 027eW+1MGhxwbgE4hQcn0nL7YJtKwrxmfk4iH/EuM0jHvg3sVEOpJCvvlozll7SzUw1UfgCR+0w
 zY47loAmKuU+Q+Z/nQ3E3H1IbqLSu2Foxtb3Qo3qpmcmKPAZwU8NXsyoA/2agjScFhCpt9qYhB/
 3vw==
X-Google-Smtp-Source: AGHT+IHZe3dqmfTdkk9G4F+WUj/KWL72hMDzOF2Z/rlKlAcn6GeNiE2GMyf0ARg9XVav1ALIrszG/w==
X-Received: by 2002:a05:6830:488e:b0:72a:327:eed3 with SMTP id
 46e09a7af769-73065093b91mr9201501a34.5.1745933115209; 
 Tue, 29 Apr 2025 06:25:15 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:25:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 30/30] patman: Drop the old status code
Date: Tue, 29 Apr 2025 07:22:27 -0600
Message-ID: <20250429132239.251756-31-sjg@chromium.org>
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

Now that we have the new asyncio implementation, drop the unused
ThreadPoolExecutor code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/status.py | 125 -----------------------------------------
 1 file changed, 125 deletions(-)

diff --git a/tools/patman/status.py b/tools/patman/status.py
index dfc0f29faa4..74d05624226 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -22,19 +22,6 @@ from patman import patchstream
 from patman import patchwork
 
 
-def to_int(vals):
-    """Convert a list of strings into integers, using 0 if not an integer
-
-    Args:
-        vals (list): List of strings
-
-    Returns:
-        list: List of integers, one for each input string
-    """
-    out = [int(val) if val.isdigit() else 0 for val in vals]
-    return out
-
-
 def process_reviews(content, comment_data, base_rtags):
     """Process and return review data
 
@@ -133,74 +120,6 @@ def compare_with_series(series, patches):
 
     return patch_for_commit, commit_for_patch, warnings
 
-def collect_patches(series_id, pwork):
-    """Collect patch information about a series from patchwork
-
-    Uses the Patchwork REST API to collect information provided by patchwork
-    about the status of each patch.
-
-    Args:
-        series_id (str): Patch series ID number
-        pwork (Patchwork): Patchwork object to use for reading
-
-    Returns:
-        list of Patch: List of patches sorted by sequence number
-
-    Raises:
-        ValueError: if the URL could not be read or the web page does not follow
-            the expected structure
-    """
-    data = pwork.request('series/%s/' % series_id)
-
-    # Get all the rows, which are patches
-    patch_dict = data['patches']
-    count = len(patch_dict)
-
-    patches = []
-
-    # Work through each row (patch) one at a time, collecting the information
-    warn_count = 0
-    for pw_patch in patch_dict:
-        patch = patchwork.Patch(pw_patch['id'])
-        patch.parse_subject(pw_patch['name'])
-        patches.append(patch)
-    if warn_count > 1:
-        tout.warning('   (total of %d warnings)' % warn_count)
-
-    # Sort patches by patch number
-    patches = sorted(patches, key=lambda x: x.seq)
-    return patches
-
-def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, pwork):
-    """Find new rtags collected by patchwork that we don't know about
-
-    This is designed to be run in parallel, once for each commit/patch
-
-    Args:
-        new_rtag_list (list): New rtags are written to new_rtag_list[seq]
-            list, each a dict:
-                key: Response tag (e.g. 'Reviewed-by')
-                value: Set of people who gave that response, each a name/email
-                    string
-        review_list (list): New reviews are written to review_list[seq]
-            list, each a
-                List of reviews for the patch, each a Review
-        seq (int): Position in new_rtag_list to update
-        cmt (Commit): Commit object for this commit
-        patch (Patch): Corresponding Patch object for this patch
-        pwork (Patchwork): Patchwork object to use for reading
-    """
-    if not patch:
-        return
-
-    # Get the content for the patch email itself as well as all comments
-    data = pwork.request('patches/%s/' % patch.id)
-    comment_data = pwork.request('patches/%s/comments/' % patch.id)
-
-    new_rtags, reviews = process_reviews(data['content'], comment_data,
-                                         cmt.rtags)
-    new_rtag_list[seq] = new_rtags
-    review_list[seq] = reviews
 
 def show_responses(col, rtags, indent, is_new):
     """Show rtags collected
@@ -292,50 +211,6 @@ def create_branch(series, new_rtag_list, branch, dest_branch, overwrite,
             [parent.target])
     return num_added
 
-def _check_status(series, series_id, pwork):
-    """Check the status of a series on Patchwork
-
-    This finds review tags and comments for a series in Patchwork, displaying
-    them to show what is new compared to the local series.
-
-    Args:
-        series (Series): Series object for the existing branch
-        series_id (str): Patch series ID number
-        pwork (Patchwork): Patchwork object to use for reading
-
-    Return:
-        tuple:
-            list of Patch: List of patches sorted by sequence number
-            dict: Patches for commit
-                key: Commit number (0...n-1)
-                value: Patch object for that commit
-            list of dict: review tags:
-                key: Response tag (e.g. 'Reviewed-by')
-                value: Set of people who gave that response, each a name/email
-                    string
-            list for each patch, each a:
-                list of Review objects for the patch
-    """
-    patches = collect_patches(series_id, pwork)
-    count = len(series.commits)
-    new_rtag_list = [None] * count
-    review_list = [None] * count
-
-    patch_for_commit, _, warnings = compare_with_series(series, patches)
-    for warn in warnings:
-        tout.warning(warn)
-
-    patch_list = [patch_for_commit.get(c) for c in range(len(series.commits))]
-
-    with concurrent.futures.ThreadPoolExecutor(max_workers=16) as executor:
-        futures = executor.map(
-            find_new_responses, repeat(new_rtag_list), repeat(review_list),
-            range(count), series.commits, patch_list, repeat(pwork))
-    for fresponse in futures:
-        if fresponse:
-            raise fresponse.exception()
-    return patches, patch_for_commit, new_rtag_list, review_list
-
 
 def check_patch_count(num_commits, num_patches):
     """Check the number of commits and patches agree
-- 
2.43.0

