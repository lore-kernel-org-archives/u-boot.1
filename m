Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D15C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3AB88C6E;
	Thu,  2 May 2024 03:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sPIRxKwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3D688C74; Thu,  2 May 2024 03:32:42 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A95A88C10
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-439884be4efso46707151cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613557; x=1715218357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQbU8Xka+mS6atPKNcBlZjA97j+PxJsQobbeRdQhosg=;
 b=sPIRxKwrdmPSQWbZkj491P2u/kn1/NzugWkHD9TLS7n+C1Q9dpxjC+UhUsNWrB9nIN
 7tKXJ2FghO3rrKmMVdTBC+ytPu1GjVu7vEGZM5pW3pREWtu7IKdKaQKuVWClo8KGo7Uc
 RAzzc8xjmiY1VniFYG5WT6ObQ1sFKQJG+5QNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613557; x=1715218357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQbU8Xka+mS6atPKNcBlZjA97j+PxJsQobbeRdQhosg=;
 b=rSxFR3kUdbJedXkOehkgJ/FZ90xuSfvNAoY91Iauvm4YoEVBiVs3U5MI9CpZ8Kd37B
 EDdbzcw70CFlMwxWVp79kVecSYohL6XVpnsO0aJo7Ai9O67zsv2a/62HAMEaEIgp+QF+
 nH1BT7mGAoW317zBQyBpVSWCbN5I3IVEY6mIJpcGZQ7fYWVlRBRVgXPgB7Fy1eTfWMeq
 O3/j9UwxaNs9sBY/hIG3M2ElyZZTnlBAjFkc4w/fp9LsjX8zInPPBAZWcs+7UIq5qHUv
 89j8zNxeuynSUblFqEeo4gJRNb396YQHArouzar+yEw7pHBmaMC8gzazhp6eUvfNAP/H
 2b7g==
X-Gm-Message-State: AOJu0Yy3gYqDL54QJ0VoohsLyoSFK4oAHxOYomE57SbkNyqGMhpEMgd3
 wEZRERFqNQ9KTBpR3RnWzbHQsw9Y0hkjS3kpiwFDbS7d3C2F92f+bZRRVs9ATlfwtR8+/Wx5CR+
 I7kTeJSRB
X-Google-Smtp-Source: AGHT+IFpboL42G0NBNCLqxftbeN22X+E3JMTEY6xlxJtnPodYOIFxD3wCIawTlr24tWCM6AvrIeJ5w==
X-Received: by 2002:a05:622a:5290:b0:43c:78d1:ee2d with SMTP id
 dr16-20020a05622a529000b0043c78d1ee2dmr5176803qtb.23.1714613557216; 
 Wed, 01 May 2024 18:32:37 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 36/81] input: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:53 -0600
Message-Id: <20240502013138.2383421-36-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/input/apple_spi_kbd.c   | 1 -
 drivers/input/button_kbd.c      | 1 -
 drivers/input/cros_ec_keyb.c    | 1 -
 drivers/input/i8042.c           | 1 -
 drivers/input/input.c           | 2 +-
 drivers/input/key_matrix.c      | 1 -
 drivers/input/keyboard-uclass.c | 1 -
 drivers/input/tegra-kbc.c       | 2 +-
 8 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/apple_spi_kbd.c b/drivers/input/apple_spi_kbd.c
index 7cf12f453a30..5b30cec2dcb9 100644
--- a/drivers/input/apple_spi_kbd.c
+++ b/drivers/input/apple_spi_kbd.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <keyboard.h>
 #include <spi.h>
diff --git a/drivers/input/button_kbd.c b/drivers/input/button_kbd.c
index c73d3b18be9c..0a917ac8b995 100644
--- a/drivers/input/button_kbd.c
+++ b/drivers/input/button_kbd.c
@@ -4,7 +4,6 @@
  */
 
 #include <stdlib.h>
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <input.h>
diff --git a/drivers/input/cros_ec_keyb.c b/drivers/input/cros_ec_keyb.c
index c4853463739b..0917ee20fedc 100644
--- a/drivers/input/cros_ec_keyb.c
+++ b/drivers/input/cros_ec_keyb.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2012 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <cros_ec.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/input/i8042.c b/drivers/input/i8042.c
index e6070ca01529..9bf21053cf06 100644
--- a/drivers/input/i8042.c
+++ b/drivers/input/i8042.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_KEYBOARD
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <errno.h>
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8a6506e7c6f9..3f146fb07e6d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -6,13 +6,13 @@
  * (C) Copyright 2004 DENX Software Engineering, Wolfgang Denk, wd@denx.de
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <env.h>
 #include <errno.h>
 #include <log.h>
 #include <stdio_dev.h>
+#include <time.h>
 #include <input.h>
 #ifdef CONFIG_DM_KEYBOARD
 #include <keyboard.h>
diff --git a/drivers/input/key_matrix.c b/drivers/input/key_matrix.c
index e2fb2e170787..2e631660c880 100644
--- a/drivers/input/key_matrix.c
+++ b/drivers/input/key_matrix.c
@@ -6,7 +6,6 @@
  * (C) Copyright 2004 DENX Software Engineering, Wolfgang Denk, wd@denx.de
  */
 
-#include <common.h>
 #include <dm.h>
 #include <key_matrix.h>
 #include <log.h>
diff --git a/drivers/input/keyboard-uclass.c b/drivers/input/keyboard-uclass.c
index aefc8e825e20..df9ee8f7d659 100644
--- a/drivers/input/keyboard-uclass.c
+++ b/drivers/input/keyboard-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_KEYBOARD
 
-#include <common.h>
 #include <dm.h>
 #include <keyboard.h>
 #include <log.h>
diff --git a/drivers/input/tegra-kbc.c b/drivers/input/tegra-kbc.c
index d4741a76663e..fc13975d4f0f 100644
--- a/drivers/input/tegra-kbc.c
+++ b/drivers/input/tegra-kbc.c
@@ -4,7 +4,6 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <input.h>
@@ -13,6 +12,7 @@
 #include <log.h>
 #include <stdio_dev.h>
 #include <tegra-kbc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
-- 
2.34.1

