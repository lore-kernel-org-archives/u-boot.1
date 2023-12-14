Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B604C4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BBA87B76;
	Thu, 14 Dec 2023 19:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BEFRYPQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1EF087B66; Thu, 14 Dec 2023 19:17:08 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B3E87B63
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d33574f64eso84960197b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577824; x=1703182624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UU454ur/74lNTYiD6v6uP9amtLxmJdEI2b6odX810Wk=;
 b=BEFRYPQ0unM/5cBQNjvV1TPAWcKo2XSHfm3s1dvCxaDkAf//90CLRHv1oDbBtIU/UR
 +n7mrA5KGJsMd+NiL6i59dKp9gi4B4tSxiPT2TEFIc5/6uLIQqFFhS4wAzYLUT44zvQs
 jm+SvvanoOwMU2jrRQ+cF+uFOf2Ow3aBHjwz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577824; x=1703182624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UU454ur/74lNTYiD6v6uP9amtLxmJdEI2b6odX810Wk=;
 b=H4WDkJQbzruYjHUATWLagu2DHPoT4lmbHrS+92qLNFuiC9vfY9Aam5U8URx/CGGbEs
 T6fZnqftmO/7CBBc42wHSq/41nr4lGoUC9aZk9S6PNZPrEzvwoqaX/AEAH/mQ5Mmrt9M
 hEd6Llvm7UOaMPiY94sI18yBuAVKLg2dvzfiyv9B3mZiq1ZvU94ukLYTh9JuIhb/KnUH
 2ozwMvV+i2RVyaH2BfBAEkmj1GLqCWle6CIL0d+o93OwDV14uxT/kjDLu+4YwT1cBmtG
 fBgKiVV2QYQANPXywBMnqNxk0vh3Hqao0VI35k5fartxpTn+fWEFiRjNo+7v7Q0ccqu6
 v+NA==
X-Gm-Message-State: AOJu0YxyXVBai+MPUwNa8X92cjjpEYD9i7itWdlYfU/k3j9QKjPkWD/O
 0zbQCPYeDuHE8rAAfnUo1ayZJoFinNuBOlckyQs=
X-Google-Smtp-Source: AGHT+IGUdr0ME74PbMapOr40o2OEsVEqYPODlsRFZfDyx8Ih4rWbolH8ERxmr0Zjrnh3+kFzN0WDlw==
X-Received: by 2002:a81:8106:0:b0:5d7:1940:b398 with SMTP id
 r6-20020a818106000000b005d71940b398mr9698990ywf.100.1702577824119; 
 Thu, 14 Dec 2023 10:17:04 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 06/16] global: Remove duplicate common.h inclusions
Date: Thu, 14 Dec 2023 13:16:48 -0500
Message-Id: <20231214181658.3359902-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
index e23f9af20da0..1d0c157d5394 100644
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
index 89907cbbb02a..9b3d5a94817f 100644
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

