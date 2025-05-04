Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266BBC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F64582AE7;
	Sun,  4 May 2025 15:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LWH/ad3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2086182AE1; Sun,  4 May 2025 15:24:44 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AD082A4B
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so576532066b.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365080; x=1746969880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDLepDgx2S8hvN9qjgYwvO+tECot99jmTO87Ru9lpYc=;
 b=LWH/ad3HseGD7DMDmd80rtaZVw6G0wY/ug9nDNrtkRMZOHboJDR0ZKYOhFZk/LKjCt
 BM1D94/E5Pl6P01mfFuquU3NROShbJFo4e30hjHb21obp9CPMpazsKVQsNNc36cI1ndB
 PXWYLY1aN2K3Rn63mlo3hsPdISQKrzk4vRukg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365080; x=1746969880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDLepDgx2S8hvN9qjgYwvO+tECot99jmTO87Ru9lpYc=;
 b=W9wiIrvuHnIJ3wQt6pS+GlnmPw88uTa5TMmEdIGwIAXnTryeOLUOsQ+ECOPs0X4rqa
 GVRVfpzNMAuYtuGZEBsb+voy4ixCWYjyo94OjRi/1L2EJ+xVkO5NQGxKKaplD22r9EDs
 BBcuuHjcxO5IoodSndxwX+4A3EtJSAnBFhfRdgDXNC5A3rkv2VKK9HWXLJ0QX9pCyvXp
 lO8ZTMEFPaq7R7YzYmby8Enhx8ibboVbWPmhPFqWg96ll9k30G/PeMRFUK50gdZTR8r6
 O6Hpvbq8XjzLc8myvJdHTTve2NGxx+xLrb74UU8r3Do1nwkMU4JC/ZmoDJmzfIbigc+X
 a7bA==
X-Gm-Message-State: AOJu0YxP45KoRRxwHMi51TikepgP7zXpCqyYp7r3vNaYpQ2A5LFj751p
 Apz1dlJdJ1au1eUMEVU/BvjdVvMk853Asy3ewuclLbxKJ8FNDasYRvNKYX4uFAc+L3KIYbr7fW5
 ctJ3f9UY=
X-Gm-Gg: ASbGnct+8Xtf9UwKYW5AtwTe0kAcjqEMR8XYVHFXKu1P0w3AgAg4xdKXYmVaInd1im3
 w2+daQSnInVWlTrB3MELabeZ/v4tvw9OiIKQ62Z7CFnqtf+17Vea9Jowx+40xtt7+XC7wcRuIjR
 9nfgqAoSxaR66hSk3Z6EFZ7ajR5S9V51CFpDEMk4uitlkj3IsGg+AKZ+QUMwogKKs89R6oHpiBm
 eHmxivD2zxLCGjiNz9NFdIdQLR4YukvmzBuusFS3AnNnUpvvnRO3j6k9fIWTFxdP+XaSP8jK8Z4
 wP5sLNa0Ud7ig+ouh3ZK5LnSfRMJYEJ75QpM
X-Google-Smtp-Source: AGHT+IH5t7bDSfzM8JFGRb2DpOxVHvCn96WV2NT/XyNL9IJMN+AlIEfliewmlaVYnpN5Hzj8nko3vw==
X-Received: by 2002:a17:906:dc89:b0:ac7:391a:e157 with SMTP id
 a640c23a62f3a-ad1a4b1f4camr341380566b.58.1746365080239; 
 Sun, 04 May 2025 06:24:40 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/30] patman: Split out the processing of
 find_new_responses()
Date: Sun,  4 May 2025 15:23:37 +0200
Message-ID: <20250504132356.2317305-22-sjg@chromium.org>
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

This function does patchwork calls and then processes the results. Move
the processing out so we can (later) test it separately.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/status.py | 74 +++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/tools/patman/status.py b/tools/patman/status.py
index cb049f5d996..ed4cca6f724 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -35,6 +35,51 @@ def to_int(vals):
     return out
 
 
+def process_reviews(content, comment_data, base_rtags):
+    """Process and return review data
+
+    Args:
+        content (str): Content text of the patch itself - see pwork.get_patch()
+        comment_data (list of dict): Comments for the patch - see
+            pwork._get_patch_comments()
+        base_rtags (dict): base review tags (before any comments)
+            key: Response tag (e.g. 'Reviewed-by')
+            value: Set of people who gave that response, each a name/email
+                string
+
+    Return: tuple:
+        dict: new review tags (noticed since the base_rtags)
+            key: Response tag (e.g. 'Reviewed-by')
+            value: Set of people who gave that response, each a name/email
+                string
+        list of patchwork.Review: reviews received on the patch
+    """
+    pstrm = patchstream.PatchStream.process_text(content, True)
+    rtags = collections.defaultdict(set)
+    for response, people in pstrm.commit.rtags.items():
+        rtags[response].update(people)
+
+    reviews = []
+    for comment in comment_data:
+        pstrm = patchstream.PatchStream.process_text(comment['content'], True)
+        if pstrm.snippets:
+            submitter = comment['submitter']
+            person = f"{submitter['name']} <{submitter['email']}>"
+            reviews.append(patchwork.Review(person, pstrm.snippets))
+        for response, people in pstrm.commit.rtags.items():
+            rtags[response].update(people)
+
+    # Find the tags that are not in the commit
+    new_rtags = collections.defaultdict(set)
+    for tag, people in rtags.items():
+        for who in people:
+            is_new = (tag not in base_rtags or
+                      who not in base_rtags[tag])
+            if is_new:
+                new_rtags[tag].add(who)
+    return new_rtags, reviews
+
+
 def compare_with_series(series, patches):
     """Compare a list of patches with a series it came from
 
@@ -175,33 +220,10 @@ def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, url,
 
     # Get the content for the patch email itself as well as all comments
     data = rest_api(url, 'patches/%s/' % patch.id)
-    pstrm = PatchStream.process_text(data['content'], True)
+    comment_data = rest_api(url, 'patches/%s/comments/' % patch.id)
 
-    rtags = collections.defaultdict(set)
-    for response, people in pstrm.commit.rtags.items():
-        rtags[response].update(people)
-
-    data = rest_api(url, 'patches/%s/comments/' % patch.id)
-
-    reviews = []
-    for comment in data:
-        pstrm = PatchStream.process_text(comment['content'], True)
-        if pstrm.snippets:
-            submitter = comment['submitter']
-            person = '%s <%s>' % (submitter['name'], submitter['email'])
-            reviews.append(patchwork.Review(person, pstrm.snippets))
-        for response, people in pstrm.commit.rtags.items():
-            rtags[response].update(people)
-
-    # Find the tags that are not in the commit
-    new_rtags = collections.defaultdict(set)
-    base_rtags = cmt.rtags
-    for tag, people in rtags.items():
-        for who in people:
-            is_new = (tag not in base_rtags or
-                      who not in base_rtags[tag])
-            if is_new:
-                new_rtags[tag].add(who)
+    new_rtags, reviews = process_reviews(data['content'], comment_data,
+                                         cmt.rtags)
     new_rtag_list[seq] = new_rtags
     review_list[seq] = reviews
 
-- 
2.43.0

