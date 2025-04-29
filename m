Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD1DC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2963D828F8;
	Tue, 29 Apr 2025 15:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TvthKYb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE96A82145; Tue, 29 Apr 2025 15:24:46 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9A9828F8
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72bc3987a05so3427794a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933082; x=1746537882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4SHAy7wYYYUiLiCEueoe0QA+a/DdxVjcoJOSosVswk=;
 b=TvthKYb6yLhNVikvpLg2gZJUhuB904/3BqDkYNd0rNnut1NI0AKJ2AQQZGklyLd+mO
 p9LEqXa3v8NQf1twwL4mWXF1W6M0CMQ5j1Rk1yYcRW39XguoO/+93Iec+Hq41ADL3ocI
 paAR7Yf2MHT57P7qzjZKP/gU3ux45ALRbv7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933082; x=1746537882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4SHAy7wYYYUiLiCEueoe0QA+a/DdxVjcoJOSosVswk=;
 b=FrJH6RNuR0Ux3zaqSAI9UedlFsJqB8y0kmqFD6niJ5cODxPUY584ZJWd9RlKVF6okp
 Dw4JP8N5Fwx7TXnIz5VvHzkP5JE8oBbeLPvDxQRVDsDnA8zx5ietwamN+WXHj7yphKDF
 0wrcENWXmnPuojyk1vs16vAg4LR+b/whEkhaJWp7SM/IdCz5MfO3lJx1TDzCfNpXDLzW
 H/QrWmiSzeAaOQiiJmMuDQgrpmE7XIs95kOUQRmLGrwDRfoENjq4o7L+o2LYikCC25Pe
 Py11ASxMwzOU25Sre7EsYzFZVnVfam45Nlfm8f0+MCjbAUO+QyE9JvY7VVFyT5nTIKBC
 dErA==
X-Gm-Message-State: AOJu0Yz5B2+ZXeOU1m9WWpc4BOeG4XKUarSvaFMHqTaTTEg8s/qX4OAt
 zoO5QtbRBaZ1DU6QcV0vC84HQD2zSnAkzxjVGWeLVMJraq3lRnXY4FkTdm69muqJ7NHERpO/B+s
 =
X-Gm-Gg: ASbGncv+Qd/dHEERsMQ8A80LGAuLVlfrlF9+Ks1GkzhW+KGBjM5wZpIAk3myH04xnRe
 CyOSVkxa1ITHJbl7uNFmfsXuA3MJaTut1P77O3b03NSk50MVpUItie1XJq/vnzsMTqsMloL0VOs
 DmBx7sVpaia3FyAy61klQgepMrqraBfE5cvEpXfeOAqdeckDCALN+soufZAqLV915/yEJbPvZTC
 tto9FHoIJzmKZ5tzyKEkNIJRWSbusCRremQIaCMXaUPyLcl6iMR7Xb/BfuZi7MxCRcgzrKVJDRA
 wKnGKBBfBbK1nTNTdS8OIjAAFn+gMnQ/EKXYkJvSbf9vw3c03wP8dZyVR/vCB3o+RMXGbClZYE/
 v0w==
X-Google-Smtp-Source: AGHT+IHvsr9UqKINpnvfURHtI3FFRN08ZZinBDhXyqHOYZem8/XgEOwA6CWSu43LwY2dtft2c2b5IA==
X-Received: by 2002:a05:6830:628d:b0:72b:7d40:5fe2 with SMTP id
 46e09a7af769-73089917ca6mr1635746a34.12.1745933082186; 
 Tue, 29 Apr 2025 06:24:42 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/30] patman: Split out the processing of find_new_responses()
Date: Tue, 29 Apr 2025 07:22:18 -0600
Message-ID: <20250429132239.251756-22-sjg@chromium.org>
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

This function does patchwork calls and then processes the results. Move
the processing out so we can (later) test it separately.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

