Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337B2C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071A980BA6;
	Sun,  9 Feb 2025 03:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gR1wnZ3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0343680834; Sun,  9 Feb 2025 03:02:52 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960B880050
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-855190e244bso32573439f.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066567; x=1739671367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWBct0TUypFIs4rQ6hBz0GVPQ+wrZqljgDWQyiTl3s8=;
 b=gR1wnZ3iFl51YGYSSHjhVw7hJPoWllAoMNXnv/9FAMSPjcRAtMKv21fiuo8g7RbhHR
 wr9kFkGlCmbS0gpB2Y7UkZvWrRLZ4JeJPbiKG7H1VoxSb800xPqYVXzcv9ZeO5NVnmFi
 Wmj8giSI3R28R47F9WPjvaapeEwwVlxagt7j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066567; x=1739671367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWBct0TUypFIs4rQ6hBz0GVPQ+wrZqljgDWQyiTl3s8=;
 b=vzX6zCaOzTrFUjiYzCBZSEnViEslvBY7kPPa243lxO5OIRwS6gSXqhhSP9CyuG6HUl
 Jj5pl98Pn35fmtV9FHpIygeXY1jfOsJpk73TFl6xa6XVc8YfuiMyGKsiOImKNAlxRusB
 IlrVc+UtVpIn1k6YeMmvnAFVqSxeZ9frVB/xK/AE3y7u0OUxnRHxjDP+QviFaNWpNVNg
 to0JwnWtGcF+0/AMu4rF1bshW0Ej9lOVMCv6eGN/T7LWm/vLW5RGD7mclrTbD6XP5DCz
 x9G4xI9Mto8zgDmm9Vexeh8DTp/xd09x3V80TX9tjcBoUYWt3gZTV99lJTq3slTZpWsw
 0ZNg==
X-Gm-Message-State: AOJu0YyECxDBJwIluN03ENchKSrPFJDJMQJn000RZ6faiMp6HW9KIXF+
 wWQarnN6QtzKC5/niW2j8KZZPIE2lL3VNt2Ac3uwa9NgjY1HDDVpyVawIcc55dT81vd4+3I5Rto
 =
X-Gm-Gg: ASbGncvkrr886q5KEHeAOUKneUoD0pBvdbgv92ecDrLCzmvJTribOSEebiixlR/26qG
 5z8NWcsKBZ85/Aw+X/MrA5NnMgM0VKmR5M48i/ZH8xxnTZTrekItMAeDO2Tkf3aGYpXZi1M2EOn
 /stz9njACW+Debxu+yW73fEkk7sQqTSUnlCIMuumiJR1Kn2yh8iHQM0WcuTp9RTJA56RAEGtF2k
 V0UBS7jU5An2TZ656apABerFrbjtEkn2UMwPU9WybKopIbQmmv5ldQHw/hTw7QOCBw8JwqxqM9e
 EbCa0AXGFn+xwA4l2ZVGV6vxMC6gCANR4wxhxetIldrKLqgozMmL
X-Google-Smtp-Source: AGHT+IF8LmdSnUT59Q5rsVej09fqG1RRRHNf4ePFyMMeFRfa3bxkrJXpMFUDbVhQZEOOW9emY8LfWQ==
X-Received: by 2002:a05:6602:3713:b0:83e:418c:8a28 with SMTP id
 ca18e2360f4ac-854fd8b32c6mr895227939f.7.1739066566009; 
 Sat, 08 Feb 2025 18:02:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 23/29] efi: arm: Adjust how the monitor length is calculated
Date: Sat,  8 Feb 2025 19:01:22 -0700
Message-ID: <20250209020136.4108987-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

Adjust the conditions to support the EFI app when running on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Put the EFI-app case first in setup_mon_len(), for clarity

 common/board_f.c | 6 +++---
 common/board_r.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 8baaa2341a3..5b9203fec18 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -261,7 +261,9 @@ static int init_func_i2c(void)
 
 static int setup_mon_len(void)
 {
-#if defined(CONFIG_ARCH_NEXELL)
+#if defined(CONFIG_EFI_APP)
+	gd->mon_len = (ulong)_end - (ulong)image_base;
+#elif defined(CONFIG_ARCH_NEXELL)
 	gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
 #elif defined(__ARM__) || defined(__MICROBLAZE__)
 	gd->mon_len = (ulong)__bss_end - (ulong)_start;
@@ -270,8 +272,6 @@ static int setup_mon_len(void)
 #elif defined(CONFIG_SANDBOX)
 	/* gcc does not provide _init in crti.o on RISC-V */
 	gd->mon_len = 0;
-#elif defined(CONFIG_EFI_APP)
-	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
 	gd->mon_len = CONFIG_SYS_MONITOR_LEN;
 #elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
diff --git a/common/board_r.c b/common/board_r.c
index c4545e9b483..3fa2d44402e 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -124,7 +124,9 @@ __weak int fixup_cpu(void)
 
 static int initr_reloc_global_data(void)
 {
-#ifdef __ARM__
+#if defined(CONFIG_EFI_APP)
+	monitor_flash_len = (ulong)_end - (ulong)image_base;
+#elif defined __ARM__
 	monitor_flash_len = _end - __image_copy_start;
 #elif defined(CONFIG_RISCV)
 	monitor_flash_len = (ulong)_end - (ulong)_start;
-- 
2.43.0

