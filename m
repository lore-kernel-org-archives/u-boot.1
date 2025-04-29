Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAE7C3ABAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885BD82AA8;
	Tue, 29 Apr 2025 15:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bkDbQ3Nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FED682AC1; Tue, 29 Apr 2025 15:25:16 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69B08283E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f8ae3ed8f4so4161214b6e.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933111; x=1746537911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fi0BnmchFDOCb71FSzlYPvrbyVLpKwN7v3twXbmRcjA=;
 b=bkDbQ3Nvp+qwv5i+YhhcTCHErMu1CfRMtnUN69eZuuDNUcA+I1+inCrOBCQraEpqpq
 F2hLsVKPNVUcovZ8uSdEnAj4E+mqhTLM32m42NeikR8Ix9axi0g5XduGOL2Ue+aV8yDI
 VtjBnuUrWLflKARcHoQcoAFzBfzH1be3pRszk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933111; x=1746537911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fi0BnmchFDOCb71FSzlYPvrbyVLpKwN7v3twXbmRcjA=;
 b=Ct//X8fn0T69TWPPJYxrizN3jyduuZ6FS1KCytZ8fo3VGHTi8SBjkscT6iCgmTLWSv
 Xxf449HmXrofaANhn590Jc7r30f6i+aHM8ZxqW1b95kvGpsowT0eFOaOSJ4qp9kLbfol
 xmWRUKTU9P9cPZtzYXcBoIzMw7XqtNrCl278ii54XAsW2MuTPldIvmPw5QV15kRZZZM2
 aphZmJqZS2LbTvwtVGvCi/OVjiW1DZ+HS1YE8HKvwZPPMZICO8yHSKmLojNCXIqNgKH7
 r2rqj4uBf2R82drbuP/7Rtlh9/J8epKnLJcpIynNuqnNw6wDQmaE2UItHnFn2MzQI4ZU
 QyVw==
X-Gm-Message-State: AOJu0YzuTJyOXjDns/7A52xpFSO/ddAjFcSkCWnon3T12+fXz7y4lO4c
 KIWjVbkqdrR4kVyGWHJ0PsS1H7Rngz6nQkX3Mj2T4WrBZ8qKah4FWCpnY9h1fdJwQJfMAjAXl00
 =
X-Gm-Gg: ASbGnctmEMaz2Va6hdIg926N6ys5k2rKzGFskSEfMoAPJib29J4yupyTaGqX60NMW5N
 D3eN+derE6h0v20IhQVMKcHvD9esMULTmPGKMw5ElmmBrFKuD2SOVqG50VEPzrQJ1JAJqctGuwC
 3tgJCMDwZFvyY8aExRrdXPxjTkLnHYmqfdBnajB2KNVVYj+zrZPuh6YwJ7VOqh2ngDaHR7Zzbdo
 abhYBLKNf8mqB+Y1d0n8lIlvXuu1DRwVsCqbABexJ3n0+eO+0VNY4JfGwSruUWNdfu2RcaELdem
 g7kQ9/IBqtlMH2WnU4Akw/QQ6fLMgfLPDMrFLxNo+Jjwc/fc2Ood1nixsxJ0NmHchIIa86D3S2S
 Ytg==
X-Google-Smtp-Source: AGHT+IFD1wMErefvvcrwWv8zYSmCnD4MV1Cn5sE5BAR6omxpeCiXci9JmkRJcfyLKcWIHa5XAelpiQ==
X-Received: by 2002:a05:6808:1b90:b0:401:e67c:b3be with SMTP id
 5614622812f47-402115506f8mr1699638b6e.4.1745933111559; 
 Tue, 29 Apr 2025 06:25:11 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:25:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 29/30] patman: Use a pager when outputting status
Date: Tue, 29 Apr 2025 07:22:26 -0600
Message-ID: <20250429132239.251756-30-sjg@chromium.org>
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

The pager makes it easier to review large number of comments. Add it
around the output.

Patman normally sends multiple concurrent requests to the patchwork
server, as this is faster. Provide an option to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/status.py | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/patman/status.py b/tools/patman/status.py
index f5be51461e7..dfc0f29faa4 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -382,22 +382,25 @@ def do_show_status(patches, series, branch, show_comments, col,
     new_rtag_list = [None] * count
     review_list = [None] * count
 
-    patch_for_commit, _, warnings = compare_with_series(series, compare)
-    for warn in warnings:
-        tout.do_output(tout.WARNING if warnings_on_stderr else tout.INFO, warn)
-
-    for seq, pw_patch in enumerate(patches):
-        compare[seq].patch = pw_patch
-
-    for i in range(count):
-        pat = patch_for_commit.get(i)
-        if pat:
-            patch_data = pat.patch.data
-            comment_data = pat.patch.comments
-            new_rtag_list[i], review_list[i] = process_reviews(
-                patch_data['content'], comment_data, series.commits[i].rtags)
-    num_to_add = _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
-                   review_list, col)
+    with terminal.pager():
+        patch_for_commit, _, warnings = compare_with_series(series, compare)
+        for warn in warnings:
+            tout.do_output(tout.WARNING if warnings_on_stderr else tout.INFO,
+                           warn)
+
+        for seq, pw_patch in enumerate(patches):
+            compare[seq].patch = pw_patch
+
+        for i in range(count):
+            pat = patch_for_commit.get(i)
+            if pat:
+                patch_data = pat.patch.data
+                comment_data = pat.patch.comments
+                new_rtag_list[i], review_list[i] = process_reviews(
+                    patch_data['content'], comment_data,
+                    series.commits[i].rtags)
+        num_to_add = _do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
+                       review_list, col)
     return num_to_add, new_rtag_list, patches
 
 
-- 
2.43.0

