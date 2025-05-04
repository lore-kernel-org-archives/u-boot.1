Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD0FC369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52EDA82B18;
	Sun,  4 May 2025 15:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EFRXEPcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CD582B37; Sun,  4 May 2025 15:24:58 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9329E82B48
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so657235166b.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365095; x=1746969895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unasRzU1PAFqrO2SGLhjJjASoOJ+gCiK10lRXBh+kiU=;
 b=EFRXEPcOBDjhEU4JUanrdAWfdIS1HHT/qbvbUvBEJi0jwHt1WE9EZRH6yskykW6DR/
 b+3DI3oLKCkA452BJBqYdPUsOt1dcbKZHZfnkhvMMdG+BRTIus9pxes/e6IbWwaWtb91
 xCPHpk65tJ4Wu0LblBom8fAQTJu8UKfuA43hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365095; x=1746969895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unasRzU1PAFqrO2SGLhjJjASoOJ+gCiK10lRXBh+kiU=;
 b=bx1DI7KoWFX7AaOtmKMVbKjmVk41KASFHsiIlAB7l/pwvAX2oefkMER7Zirx8XeLyo
 iWwl48n/GNp87D0FPNlA1CbdYmXg8jiFRhf5ZsrzdPqwXES4ug1JQlMSBRXh+A4i4wNr
 UoLGokq68UozKVioNIJg9ivNceBibjl96yobBg8eT8MflUEo8sA3KIauRQbT9C5uC3us
 p5aql8Kja9N51xNW/OyPzHJOR9N2kc9JHm5EbIjFjW3HQ5pLayHeMEfXLIa/s6c+aNyV
 5GnjkVZMCTit3+OXlGOkcHuQkPdJXx0UTUpdItcrowRaZ+EEJ81P/+BYVexiziXWtNbF
 2QyA==
X-Gm-Message-State: AOJu0Yy0Ty0RD1iNUXddp75gxHfN4UYl4+xh1Kc3KkJLUlwHnl8DB+YI
 Zy5qupYZ762RAkZ1oUIBiuF2oE8SvKpRPyhJf+WSpvLkTKsJY/aysHvwGXyT43fu+mNIROz+wmy
 GBdGcsno=
X-Gm-Gg: ASbGncukRIqQ+z/6Cn+NGthti8czsfF3LfQXoAuM8+mVsarb+N7cS+KlvHvxcJLmR2Y
 yeQvD++hDNHifiL6JvaDGFvk1fx2LySMg7+pWBjF/UqR8M9H304BrlZSaMyszGNwHnKl629X3fo
 7JP3H1VC01/R2aeYnqddQfTzwIC2cRvmJOfZ/zGW5elug5PTQz1QKeOw/FsvJL05FYMrlOpzAbU
 Rpe1q+DFSwl7K2Qq2qaj7NiuOg8zMUtTouf5P9+0Hcp8IVZu0IIQlVyTDNRK4wBK8JcVVRLPd+b
 PwZBDyg0BC4S2OuyYLSZmECqlHaAumMGMDeo
X-Google-Smtp-Source: AGHT+IEoG0CODc1T1HH/bLl5rKaqXbkLU7TPzlzimRDk2q+G47/qC5Hk5LMxJ/1Vfu9tzu+U3zcalQ==
X-Received: by 2002:a17:907:7f25:b0:ac8:1cf7:7aa7 with SMTP id
 a640c23a62f3a-ad1906550famr479300166b.15.1746365095144; 
 Sun, 04 May 2025 06:24:55 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 30/30] patman: Drop the old status code
Date: Sun,  4 May 2025 15:23:46 +0200
Message-ID: <20250504132356.2317305-31-sjg@chromium.org>
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

Now that we have the new asyncio implementation, drop the unused
ThreadPoolExecutor code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

