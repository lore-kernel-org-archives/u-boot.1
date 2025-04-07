Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099F2C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9321182E25;
	Mon,  7 Apr 2025 12:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mYFrO/gf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F07C82CE7; Mon,  7 Apr 2025 12:52:19 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D935382E25
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so3899449b3a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023135; x=1744627935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o05CNkrknchzyUAM1qAlhvth7MEAgKTosWfQywOMKfc=;
 b=mYFrO/gfj6rNQUPla0HCYv6JIKBPRMCwBhb26zV9hTk+KMRwLSqYexw5Ztc6m5LKZl
 ASL3HaIn72DLvrXVl2tfwcIJKXo8/21v3jplTED2piAFXqM51NpA8ekB4JRo204vn6CB
 vBR3UoKkSHvKccFIPAizDFPkNQ2J3hhRPlVwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023135; x=1744627935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o05CNkrknchzyUAM1qAlhvth7MEAgKTosWfQywOMKfc=;
 b=lBBcDJMMstxQtqTxpuwn6UPU4HB31R/AdwpsD4SuYKBPvszNLirjYpFe2fewhqHQ3h
 aVBL4kwVcOZh7GarBiXccFuPc1QsAy5dCjRPIvDcH01WGwFbXT3Am05T+UYRkDOdPBRA
 xaFzDkww8WwJrnVwZbMi4jHIrTfAgBzx7SIBAN4N6Rx/B9ogfOCpKJAU64cQ7W2mqRnF
 zQNW7ypPALyldN7oA9lJ5I1YJF9mKEZKRA85BL8avcBf+iEo1nOAOV2fXNJd1eTS4EQ8
 wxZ51kQTOwFRNGHNWp7x9zLckiSutZjE8yPlDoK6oCIbmUjO2AkXBp2wsTpwlKpvfA4o
 B28w==
X-Gm-Message-State: AOJu0YxwJWycmRRVR+i6raqsQ/iZTTT/QtGAeipadu0zYoyomwbDYzj+
 VxwG+DoGQXcZSICPWL2vykwZZ/k4iAOIVl4YFQg5pty+0IHL1hCoW8IHIn+2RYpUUTWOmjCmbr2
 FCQ==
X-Gm-Gg: ASbGncvXgjSJaJF+v3HD2iBHXcaqjVx+rjxcsmkONwWYRgYKrgqoM1IC9b1yMnHL0Hy
 bI/SkN8KZO9cpkp5AL4r/IkMBjOgk6e9Ewhi+2nG28Aj6XI/becMJqIwFCd7rmAlzLjCCm2ylAK
 +i2nhSXGaxvjP4clq9yixpHH9ipCeeATWcKFRkVKVjb0MjslRa00KBx/ibr7DWF4SormT2ku++o
 Gyl+oWNCbR15X4ZHeCS6Xd1ACsGOZoERSy9C0Ia93rkitVQ2Ow/pX2SB2UxwfeN4LLlWhuja5ZM
 1dsccTx47iSSffE9h1t7KVVQ4+lXt0D2XE8YdQ==
X-Google-Smtp-Source: AGHT+IGBdEc1NweosG7Ip3qc3daDRMJps7ymO0qqI4kqVLvl4XihWEibP/J2XOhOVWKmMw/I52fWWA==
X-Received: by 2002:a05:6a00:a89:b0:737:e73:f64b with SMTP id
 d2e1a72fcca58-739e48c6f91mr15342964b3a.1.1744023134709; 
 Mon, 07 Apr 2025 03:52:14 -0700 (PDT)
Received: from chromium.org ([205.220.129.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm8138736b3a.41.2025.04.07.03.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:52:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] patman: Untangle settings from gitutil
Date: Mon,  7 Apr 2025 22:51:43 +1200
Message-ID: <20250407105151.689453-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407105151.689453-1-sjg@chromium.org>
References: <20250407105151.689453-1-sjg@chromium.org>
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

The gitutil module is supposed to be independent from patman but one
piece was missed in the series which separated them.

Move the settings setup out of gitutil

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py       | 4 ++++
 tools/u_boot_pylib/gitutil.py | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index b8a45912058..c1b6e41e2d2 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -13,6 +13,7 @@ import sys
 
 from patman import checkpatch
 from patman import patchstream
+from patman import settings
 from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 
@@ -20,6 +21,9 @@ from u_boot_pylib import terminal
 def setup():
     """Do required setup before doing anything"""
     gitutil.setup()
+    alias_fname = gitutil.get_alias_file()
+    if alias_fname:
+        settings.ReadGitAliases(alias_fname)
 
 
 def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 0376bece3e6..8935b6cc847 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -693,9 +693,6 @@ def setup():
     # Check for a git alias file also
     global USE_NO_DECORATE
 
-    alias_fname = get_alias_file()
-    if alias_fname:
-        settings.ReadGitAliases(alias_fname)
     cmd = log_cmd(None, count=0)
     USE_NO_DECORATE = (command.run_one(*cmd, raise_on_error=False)
                        .return_code == 0)
-- 
2.43.0

