Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084AFC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DA4875CC;
	Wed, 22 Nov 2023 14:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n7IMZt11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6803875B2; Wed, 22 Nov 2023 14:12:01 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACB686C31
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-db3fd3e971cso797702276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658716; x=1701263516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=E8WIlJV7muZSySw2twiGmLmx2R+WNIeLg5nBHvKYYTw=;
 b=n7IMZt11iAcwpg+wqVJ6MvsqZgpbRWG04/yb9ytNbdOLOi6aMVjXtW/KiOQ53rspV0
 giP5PDqncvcFSNvqwv19zqZd0YiL3+e3c3PlRfoXQNiKIJ/0KawE7BL7rd/oqQBmVISL
 tv+KXVDu9hUdUbqGZv7IEXkmNpE72PP42k6ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658716; x=1701263516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8WIlJV7muZSySw2twiGmLmx2R+WNIeLg5nBHvKYYTw=;
 b=rMccGHmH31+9hJqaKMHIikK9BIAZbT3WieWtwuvRuDOW2dWV1jOO2iW9P/1/fhciU4
 uOMxinel4b49r6tLTN/LFziTfoVnj/JmV5hf2dxN3+klvMJ212m1r8k41E0B8o8wwO4u
 5hS+9uTK3kvdA7i1t0sHJsOcBSEHt+kiKjakRWtWI2hnP2ai9wE+CYqPmh572fGo/BFl
 stj/EkgLPs8m+TEwJRyaE5vRE/I/3JYmkS+ocXxNcwavZyhjEea7c7SUROOfzzpiaAbi
 aOPyRHnlsO5HDADEG0+nAQNSq69zZxxpPzfaoIgr+LPEku/RupL5GQ5qhyqEsLKdYCPk
 RvJw==
X-Gm-Message-State: AOJu0Yzg2r59f6PPyHBgL0bQeU3cy4JsDY5/HV2HeppOtSAtCM6/Cy0s
 SGx3o+gC+SZ3o8ENXFMzuEBf5ju1sVaeenGYD4bI6Q==
X-Google-Smtp-Source: AGHT+IG7NGClopnC3VKGcTpnktAAedFFEFXktIoAlh4d11eBdZl6ijXF9bbNRz1DmUeSOzlE3l4CxA==
X-Received: by 2002:a25:abe4:0:b0:da0:3d48:aa68 with SMTP id
 v91-20020a25abe4000000b00da03d48aa68mr1833368ybi.50.1700658716034; 
 Wed, 22 Nov 2023 05:11:56 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.11.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:11:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 01/11] global: Remove duplicate common.h inclusions
Date: Wed, 22 Nov 2023 08:11:44 -0500
Message-Id: <20231122131154.2444690-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

These files include <common.h> twice. Start by removing the second
inclusion of the file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/data_modul/common/common.c          | 1 -
 board/grinn/liteboard/board.c             | 1 -
 board/toradex/colibri_imx7/colibri_imx7.c | 1 -
 board/wandboard/wandboard.c               | 1 -
 drivers/gpio/gpio-aspeed.c                | 1 -
 drivers/spi/fsl_dspi.c                    | 1 -
 drivers/video/exynos/exynos_dp.c          | 1 -
 7 files changed, 7 deletions(-)

diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index bf9a11472d11..4f308dad2e4d 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -12,7 +12,6 @@
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/iomux-v3.h>
-#include <common.h>
 #include <dm/uclass.h>
 #include <hang.h>
 #include <i2c_eeprom.h>
diff --git a/board/grinn/liteboard/board.c b/board/grinn/liteboard/board.c
index 48392c48e5cc..cf1d7cee9252 100644
--- a/board/grinn/liteboard/board.c
+++ b/board/grinn/liteboard/board.c
@@ -20,7 +20,6 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/io.h>
-#include <common.h>
 #include <env.h>
 #include <fsl_esdhc_imx.h>
 #include <linux/sizes.h>
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index f0356af0082b..3c4a14148719 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -16,7 +16,6 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/platform_data/serial_mxc.h>
 #include <fdt_support.h>
diff --git a/board/wandboard/wandboard.c b/board/wandboard/wandboard.c
index 48914450a294..8be62c86695d 100644
--- a/board/wandboard/wandboard.c
+++ b/board/wandboard/wandboard.c
@@ -28,7 +28,6 @@
 #include <env.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
-#include <common.h>
 #include <miiphy.h>
 #include <netdev.h>
 #include <phy.h>
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2c5415c671d1..1c3d18796b3a 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -11,7 +11,6 @@
 #include <asm/gpio.h>
 
 #include <config.h>
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/io.h>
diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index f8ec268812ca..041abe57e355 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -14,7 +14,6 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
-#include <common.h>
 #include <log.h>
 #include <spi.h>
 #include <malloc.h>
diff --git a/drivers/video/exynos/exynos_dp.c b/drivers/video/exynos/exynos_dp.c
index a532d5ae1abb..59838da6c926 100644
--- a/drivers/video/exynos/exynos_dp.c
+++ b/drivers/video/exynos/exynos_dp.c
@@ -7,7 +7,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <common.h>
 #include <display.h>
 #include <fdtdec.h>
 #include <log.h>
-- 
2.34.1

