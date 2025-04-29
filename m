Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A02C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9CB8272A;
	Tue, 29 Apr 2025 15:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAQZq8tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A90282145; Tue, 29 Apr 2025 15:25:04 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D888291D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c40235c34so1765116a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933100; x=1746537900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eilGowQGNdmbyF5+GKtbIeoMWW6q9RqLczrN93Azess=;
 b=hAQZq8tjwxR6mevvx3Y0uO5u+w18/zi7xLRUwVx2od2mTxacw0ELbYmNue+cCBzlMJ
 1LyraxYN8YmqOlP8uL+KX+Drgopo0DOr5F5HRuMfQbu2cW06EvIZlkDPdnsEkrXbfpBt
 0tVmlSEIeb/kDQzMNQOuf8pKpeGF5PhpeLLqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933100; x=1746537900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eilGowQGNdmbyF5+GKtbIeoMWW6q9RqLczrN93Azess=;
 b=ga+e3U/V3k+T0Z21EukZLcSrYQPOfe4Ko/BKsXjaDTKmy6aLFV/CFyvi85zNPth6PW
 0+u8zO+4pph+Yu7VTg2hwjI5YNvwWoF1ydcw+X1QPYmUvOMIsti67UmpxkUf/oWSPiLs
 8OSMZ9bc2r/UdH2pB3yXqT7Igmzsx90f0c9MiUxILsnByfbTAjLCgCNp/ZvutnGl0+NN
 eOVEUnlDHpBLNpzpCm7cXjeG4SuWfeB5kCiHOjbubv5qV7HD1EqxElk10QhWg2QDRI4F
 beQ4l+76oBzmm9TRrWLmIJs2fWQMqjHqWOIZtvOvFTCzebzMxmvvcY12265NPCOwRUZF
 qMxw==
X-Gm-Message-State: AOJu0Yy0I7yTqFfkCnsf89Vsf2swvZfSSJaASQLXUOF5JW+adytevYUr
 PHDf4Gxfi7q4/CocUALOt2aXG7mHN3CvX53WlquagfFhwI8XRMA6RlyUBwjorD70DetMNduoT2U
 =
X-Gm-Gg: ASbGnct6VsVIHLD2AqrMopV2maqilxFSRBpxEQKx/XYQZp4K9IqwPBGzamzAA2vB16J
 liZfYUpuDgbgYMTC2WaB8AftrKaHaABAZEOVMSzcgN8bJh3ayK+AUW8eSbvA/WuYw69ts7/0V8q
 YSdB9moOsmx5HbDxb5YPmi8RtAN+3YE6gkUSMy6Jm63Pbt1LctYHsnwVWJwk7ZbVzunstTrNbAa
 cDnQDtRAsiFsC8vKurtakrU7Twqzzw1cyWiRVp9R9eWnneNfB5Jz36vCJ/SzYxAORaJBqovRr81
 IKP51/1juoXCM2DwYluJZDtKJRYKMyiktca9+kpYDWBICi3BpQfyBlyTCu6LU/ONBJpJtU5sfEa
 KdIfd7KFUg5GM
X-Google-Smtp-Source: AGHT+IH9mgcP/1mXYcaqN+D90OoKQphwNAHSy8+LYJHDuW+kX8mR4riGbazus5rIfsAconRzxzf4kw==
X-Received: by 2002:a05:6830:d84:b0:727:423c:95ea with SMTP id
 46e09a7af769-730652634c1mr7722647a34.19.1745933099683; 
 Tue, 29 Apr 2025 06:24:59 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/30] patman: Use defaultdict directly
Date: Tue, 29 Apr 2025 07:22:23 -0600
Message-ID: <20250429132239.251756-27-sjg@chromium.org>
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

Import defaultdict to avoid needing to specify its module in multiple
places. Fix an extra blank line while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/status.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/patman/status.py b/tools/patman/status.py
index c114a432bf3..8fc2a50b426 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -8,7 +8,7 @@ Allows creation of a new branch based on the old but with the review tags
 collected from patchwork.
 """
 
-import collections
+from collections import defaultdict
 import concurrent.futures
 from itertools import repeat
 
@@ -55,7 +55,7 @@ def process_reviews(content, comment_data, base_rtags):
         list of patchwork.Review: reviews received on the patch
     """
     pstrm = patchstream.PatchStream.process_text(content, True)
-    rtags = collections.defaultdict(set)
+    rtags = defaultdict(set)
     for response, people in pstrm.commit.rtags.items():
         rtags[response].update(people)
 
@@ -70,7 +70,7 @@ def process_reviews(content, comment_data, base_rtags):
             rtags[response].update(people)
 
     # Find the tags that are not in the commit
-    new_rtags = collections.defaultdict(set)
+    new_rtags = defaultdict(set)
     for tag, people in rtags.items():
         for who in people:
             is_new = (tag not in base_rtags or
@@ -115,7 +115,6 @@ def compare_with_series(series, patches):
             warnings.append("Cannot find patch for commit %d ('%s')" %
                             (seq + 1, cmt.subject))
 
-
     # Check the names match
     commit_for_patch = {}
     all_commits = set(series.commits)
-- 
2.43.0

