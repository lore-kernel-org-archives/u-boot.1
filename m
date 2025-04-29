Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54267C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F1382A2F;
	Tue, 29 Apr 2025 15:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXSlrDQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B746B82A8D; Tue, 29 Apr 2025 15:24:58 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877D482145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72a4793d4e2so4421794a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933095; x=1746537895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsHBMR8NyUItIbd+8c+C5ptWrf7VddnyV/IwQjX+qG0=;
 b=kXSlrDQlj01pH3RR8zornFBxxlgyBGWl1Ldl1j8QPKc4DM/z1mfFBhVotGsqf4J42P
 6kkxI6qBMC74fjGfKqTDjHzn+rYHPJ9an060M2Gex+JTNNnyAZdEEGdH2th1XvFmdbpf
 dyVMWyNcbYzxvnIV9LQPMAMgDyXckkSEXoP1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933095; x=1746537895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsHBMR8NyUItIbd+8c+C5ptWrf7VddnyV/IwQjX+qG0=;
 b=FS/uxW0J7maDNLZ4Wy0b5fNwbsWw7rYRB8EPqDZsfzqpVa5+5rOsK2KrkoshVJV0xy
 gXFtaAsRq3Oe1wWM+mVfiWcdU96z9sjKGdhUCDEQEnofImpFm5s3gZvhQGgIxB3iNAZB
 STNdZu+n3MneRShdYMjcSdY2tfVnsL5yZ5DDKXq5VNUPvnLez9MoMay+gCZ23lFhnBVV
 SLnluwed8mWEej14ychwbspVvYNjsfiwYNvg5hr7k4sZGLICMdmy6kFTiP0CPf9K5vzZ
 6Ct0qrV5J5iEB32o6zQa4hWbm6pMthFaBxus+I15rbvR3eHFmJBRTTB3WfaCpaakWaBP
 YYhg==
X-Gm-Message-State: AOJu0Yydv/ZLJ+NZFzc2Pis8oHiWNo8OIEHdfoTcU0pbaCH2fVpGnSQb
 T6+OpkwHrNdOSA/xQAU6k9EHo720WTLQz09WPVjzw67kVVG606nkhjiaCNo8OGlkZO+9aouRu2g
 =
X-Gm-Gg: ASbGncss3mVY71V8po4NxuP5mG39bBdwCmcoYmRbGEC5fZ7rc0A6J+rGJQAJResesqb
 K7Gpwvsz3DKIAKaN91RTEPFAersedBrDrgsPuJkRqJ2kn/0ob68AjADGxrBIEhI0GSZlw9v7Xvi
 C0HPM5mWVPEMNlPJmlkVMZbCZMNriklVa1mJkWqa/nz/ipGCh7mo2pYqOLWM+rCnmkrCwKr/WLy
 8fJpvlfDMMfJ7n6a/abswI7XSZ5jwBM8Ew7NdpJIsNas7VcaOnpUvZ5nxps/dHU0DhkY7Yj9oX3
 FE1hoqMW9lpHUTF0LaWFYTQWgUaC/pNT2HmZ2Ve4XUeagvweXoVhrvM4J/E//fagcq0S3NOLJoe
 wbg==
X-Google-Smtp-Source: AGHT+IExp0tb0a39iJDVuKPkcx08zqCQURrRrShLH7CLvcrnqxPZssUOY3j/3GJ9PA3PEeQA0yAytQ==
X-Received: by 2002:a05:6830:3704:b0:72b:8aec:fbd4 with SMTP id
 46e09a7af769-730897050b2mr2117414a34.3.1745933094733; 
 Tue, 29 Apr 2025 06:24:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/30] patman: Add more information to Patch
Date: Tue, 29 Apr 2025 07:22:22 -0600
Message-ID: <20250429132239.251756-26-sjg@chromium.org>
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

The cover letter has some information on each patch, so allow this to be
stored in the Patch object.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchwork.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index 3ec266f073e..8b0968c5765 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -52,8 +52,10 @@ class Patch(dict):
         raw_subject (str): Raw patch subject
         subject (str): Patch subject with [..] part removed (same as commit
             subject)
+        data (dict or None): Patch data:
     """
-    def __init__(self, pid):
+    def __init__(self, pid, state=None, data=None, comments=None,
+                 series_data=None):
         super().__init__()
         self.id = pid  # Use 'id' to match what the Rest API provides
         self.seq = None
@@ -62,6 +64,11 @@ class Patch(dict):
         self.version = None
         self.raw_subject = None
         self.subject = None
+        self.state = state
+        self.data = data
+        self.comments = comments
+        self.series_data = series_data
+        self.name = None
 
     # These make us more like a dictionary
     def __setattr__(self, name, value):
-- 
2.43.0

