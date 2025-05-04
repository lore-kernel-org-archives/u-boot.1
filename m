Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EA3C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4F882AF6;
	Sun,  4 May 2025 15:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="njcW46mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD61E82B5B; Sun,  4 May 2025 15:24:56 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C156282B33
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so536096066b.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365094; x=1746969894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYhWxSAmj6RqG/2SLSQG7Rhzu0FMaZMM75LE5uyBbmc=;
 b=njcW46mbM/ylWqvnaxfR+B6JBOlc2WK9kDjGNVZaLCVQaYRtbJLM1lBFmyIq8lSbxf
 XJt9MPGYBqim4QuT3saDt+SkinTLtv1Et151uUVkpx5aAWoHKD8NvMnnE2Rg48zwAbuY
 HgLNYnD0R2IK+aHQX2VgaA+kwTKDUIf7X4UUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365094; x=1746969894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYhWxSAmj6RqG/2SLSQG7Rhzu0FMaZMM75LE5uyBbmc=;
 b=Frc9sc9W8RKz3dptF5DHNxZPdGiWRXS7A6+kVkNRxZrKoI2yERfovExQkNMuU7XuYM
 2yHRLeplEys4Cv8cX64pTDdJot7lDnAmSIsFRzR949Y3AxEAdSkab1CaCkMHtk6UvCQs
 05jHKsqhPnl4Y5BTuZMuiexQHoKsKPwSr2Sa+Rr6y21Vbdi2NgFMpfeBuxvgTote3QU6
 YSZDSL+OGHqF6NmFTOy8AYq9iFWMJt23dZWePXv4eEeRd0hgMiLEPmju0Jr/8gOLANCl
 eP4YrgFS9Qwypj1mShrX7N0tQQ3yNMIbFD9tTWCmyqqX6H/hPcSySfOht2G4upTrQaiJ
 3caw==
X-Gm-Message-State: AOJu0YySCDwCGVs+qg+9pUWHEoXLO2mHFCyqhpQ01Bw6D7ntOzmnIIOh
 iUiNzKc7NGlP+Mdf3ni8dvIjGTJcU0SO6dEbDiDxiU8SP+CjJQuk0aHd5IfJdzWgQ6ZsJrOZ7V4
 g4xtq+DE=
X-Gm-Gg: ASbGncu2uXF3vwMPeQmMMlhhgYs7mEF6VCO7B0aJ5GPt+WqmGCf+GdklhF1qYvYcifs
 dVVl20ktnVfHsIwFYaCjTNm+idDoTS2BNUte79I1U5+Xyp1quYSlchgbGFbe/7fFx5OaUsVn33M
 Bbq9xlW+lhnSZxQge/cp1CIbs91rfmQbEBtmim7mICQhD23tmHyVnWq+bPD2DEtglz4XUvzyIzo
 rS5LNjpTAci+RYtmpZQffRv8f9WHRLjmzD2NEzLvBvx9VaJdZzrH1xZa/rAvxiYU0RN06+Q0Yqt
 9ih+dqvXsSEtJTGKYq1uf84S62AaQNKdbgDd
X-Google-Smtp-Source: AGHT+IFU9Mu9nPhAQ7OCTnf+NvkPcStQSaeHK3JrfJ/H3bZtXoXzo6rBvyFD1aOMcF5rl72NUrls7Q==
X-Received: by 2002:a17:907:97cf:b0:ace:3643:1959 with SMTP id
 a640c23a62f3a-ad1a4897410mr342843666b.7.1746365093752; 
 Sun, 04 May 2025 06:24:53 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 29/30] patman: Use a pager when outputting status
Date: Sun,  4 May 2025 15:23:45 +0200
Message-ID: <20250504132356.2317305-30-sjg@chromium.org>
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

The pager makes it easier to review large number of comments. Add it
around the output.

Patman normally sends multiple concurrent requests to the patchwork
server, as this is faster. Provide an option to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

