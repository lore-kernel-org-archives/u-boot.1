Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47A9C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB058883F;
	Thu, 25 Jul 2024 22:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q9iu748L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B11188599; Thu, 25 Jul 2024 22:45:51 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171A18863E
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db13410adfso169867b6e.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940347; x=1722545147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ix4IK7FRWBNKNDuDV+PLj0LmMNAY8rZDUVuOqiCEbI=;
 b=q9iu748LiMSpOACbX+IUArfRz0+IhfNyBcRmAd1T4F4uPoMF9Je9l2sM9LamnJk6OL
 4MkWVv/rxDsQhQEQ0zJeoJdz5zCH5UFdfIYZDqAiEmcRjFlG1M5Gfh8gBLpX2vjuABX/
 jXXrtDH5pjk0e8UN2+cNmzwUJ86CzFAuxL5Qu1tyPDM1E+l/Ob60Z8Ykc19C0/AXe+JX
 JwaPW86swK7+UJmEfTOtJx5doZZZLlOCGTnjZeJGupOFcxY3l+d+lw54QhLA6LGDtHuP
 rfwwtiw6hpnxHC2YE4mocfuFHkOeaS3nAHbqaEulQodSHfBt7HQM6sNKzrv1WTmJwCkh
 0m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940347; x=1722545147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ix4IK7FRWBNKNDuDV+PLj0LmMNAY8rZDUVuOqiCEbI=;
 b=dpJ2B0bxhLCX5A0a/hgqWurMPkJoP96pbvA5YTbvFui7JTeoEPp5p6U5EXKIInQ0ep
 xQTWlHlBxbYoyFCKeFFO3Z2A9zmfq1B0xsbw2gUBDInXocPywamkVcpvMOawJjhUcEN+
 YET6RLuuezdKBfYshwS/IbKlhWToJNwY/gSMYSaA9fdqXdyHGoHVSR5kFq9sFwz17nkU
 xOlvyNAjIZ5oUafYdXALZx+nqESIvzFXKRdVPN3lK0zeekMovwxWfpJ8RLQiqdNg0xP8
 pPN7IR9EM248HqmcyTzYkwBvB8IX886yUwVEg3pV++KHw5bp5QuhZNGUImeYoQti4iXq
 p5zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvJW270pqjQKlTeIY4Rt1pbI9jpW/068OHdk8rx0k+mSWjG8RxJhsB1eBnu8jeZQqYjzNXsvafTSGNxnEK/mM+3nbnSw==
X-Gm-Message-State: AOJu0YxCApouSJ67J9l7b4cfAFQBOlKR+G+wNQNvWBOcDh+KSZLJCvfp
 dm9DjGZx+KDWGfnAq4USkdyLL/mgq5ef/SAEjhKILc0arBGaezupzaQkpYTkpPQ=
X-Google-Smtp-Source: AGHT+IG+seH68nsqkE3mTEOWh7sG6z0dLAzX/47hP1c6wvx0goQDtPHPujzz5Nx93oMovJfBYVddyA==
X-Received: by 2002:a05:6808:1597:b0:3d9:38e2:5392 with SMTP id
 5614622812f47-3db14183ce5mr3237268b6e.36.1721940346875; 
 Thu, 25 Jul 2024 13:45:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1351d859sm429765b6e.39.2024.07.25.13.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:46 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 35/38] mmc: exynos_dw_mmc: Improve coding style
Date: Thu, 25 Jul 2024 15:45:17 -0500
Message-Id: <20240725204520.18134-36-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

Fix most of checkpatch warnings and other obvious style issues.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 arch/arm/mach-exynos/include/mach/dwmmc.h | 36 +++++++++++++----------
 drivers/mmc/exynos_dw_mmc.c               | 26 ++++++----------
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
index 7cb71be0d9fd..75d84988b7d6 100644
--- a/arch/arm/mach-exynos/include/mach/dwmmc.h
+++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
@@ -7,24 +7,28 @@
 #ifndef __ASM_ARM_ARCH_DWMMC_H
 #define __ASM_ARM_ARCH_DWMMC_H
 
-#define DWMCI_CLKSEL		0x09C
-#define DWMCI_CLKSEL64		0x0a8
-#define DWMCI_SET_SAMPLE_CLK(x)	(x)
-#define DWMCI_SET_DRV_CLK(x)	((x) << 16)
-#define DWMCI_SET_DIV_RATIO(x)	((x) << 24)
+#include <linux/bitops.h>
 
-#define EMMCP_MPSBEGIN0		0x1200
-#define EMMCP_SEND0		0x1204
-#define EMMCP_CTRL0		0x120C
+#define DWMCI_CLKSEL			0x09c
+#define DWMCI_CLKSEL64			0x0a8
+#define DWMCI_SET_SAMPLE_CLK(x)		(x)
+#define DWMCI_SET_DRV_CLK(x)		((x) << 16)
+#define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
 
-#define MPSCTRL_SECURE_READ_BIT		(0x1<<7)
-#define MPSCTRL_SECURE_WRITE_BIT	(0x1<<6)
-#define MPSCTRL_NON_SECURE_READ_BIT	(0x1<<5)
-#define MPSCTRL_NON_SECURE_WRITE_BIT	(0x1<<4)
-#define MPSCTRL_USE_FUSE_KEY		(0x1<<3)
-#define MPSCTRL_ECB_MODE		(0x1<<2)
-#define MPSCTRL_ENCRYPTION		(0x1<<1)
-#define MPSCTRL_VALID			(0x1<<0)
+/* Protector Register */
+#define DWMCI_EMMCP_BASE		0x1000
+#define EMMCP_MPSBEGIN0			(DWMCI_EMMCP_BASE + 0x0200)
+#define EMMCP_SEND0			(DWMCI_EMMCP_BASE + 0x0204)
+#define EMMCP_CTRL0			(DWMCI_EMMCP_BASE + 0x020c)
+
+#define MPSCTRL_SECURE_READ_BIT		BIT(7)
+#define MPSCTRL_SECURE_WRITE_BIT	BIT(6)
+#define MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
+#define MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
+#define MPSCTRL_USE_FUSE_KEY		BIT(3)
+#define MPSCTRL_ECB_MODE		BIT(2)
+#define MPSCTRL_ENCRYPTION		BIT(1)
+#define MPSCTRL_VALID			BIT(0)
 
 /* CLKSEL Register */
 #define DWMCI_DIVRATIO_BIT		24
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index a9e240fd91d6..c8bf89d6d355 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -45,7 +45,7 @@ struct exynos_dwmmc_variant {
 	u32 quirks;		/* quirk flags - see DWMCI_QUIRK_... */
 };
 
-/* Exynos implmentation specific drver private data */
+/* Exynos implementation specific driver private data */
 struct dwmci_exynos_priv_data {
 #ifdef CONFIG_DM_MMC
 	struct dwmci_host host;
@@ -121,10 +121,7 @@ static int exynos_dwmmc_set_sclk(struct dwmci_host *host, unsigned long rate)
 	return 0;
 }
 
-/*
- * Function used as callback function to initialise the
- * CLKSEL register for every mmc channel.
- */
+/* Configure CLKSEL register with chosen timing values */
 static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
@@ -163,7 +160,7 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
 				& DWMCI_DIVRATIO_MASK) + 1;
 }
 
-unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
+static unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 {
 	unsigned long sclk;
 	u8 clk_div;
@@ -204,7 +201,6 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 			     MPSCTRL_NON_SECURE_WRITE_BIT | MPSCTRL_VALID);
 	}
 
-	/* Set to timing value at initial time */
 	if (priv->sdr_timing)
 		exynos_dwmci_clksel(host);
 }
@@ -214,8 +210,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
-	int err = 0;
 	u32 div, timing[2];
+	int err;
 
 	priv->chip = (struct exynos_dwmmc_variant *)dev_get_driver_data(dev);
 
@@ -223,9 +219,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	const void *blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
 
-	/* Extract device id for each mmc channel */
+	/* Obtain device ID for current MMC channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
-
 	host->dev_index = dev_read_u32_default(dev, "index", host->dev_id);
 	if (host->dev_index == host->dev_id)
 		host->dev_index = host->dev_id - PERIPH_ID_SDMMC0;
@@ -241,10 +236,6 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 		host->dev_index = 2; /* SD card */
 #endif
 
-	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
-
-	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
 	if (!host->ioaddr) {
 		printf("DWMMC%d: Can't get base address\n", host->dev_index);
@@ -255,17 +246,17 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 		div = priv->chip->div;
 	else
 		div = dev_read_u32_default(dev, "samsung,dw-mshc-ciu-div", 0);
+
 	err = dev_read_u32_array(dev, "samsung,dw-mshc-sdr-timing", timing, 2);
 	if (err) {
 		printf("DWMMC%d: Can't get sdr-timings\n", host->dev_index);
 		return -EINVAL;
 	}
-
 	priv->sdr_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
 			   DWMCI_SET_DRV_CLK(timing[1]) |
 			   DWMCI_SET_DIV_RATIO(div);
 
-	/* sdr_timing didn't assigned anything, use the default value */
+	/* sdr_timing wasn't set, use the default value */
 	if (!priv->sdr_timing) {
 		if (host->dev_index == 0)
 			priv->sdr_timing = DWMMC_MMC0_SDR_TIMING_VAL;
@@ -284,6 +275,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 				   DWMCI_SET_DIV_RATIO(div);
 	}
 
+	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
 
@@ -396,8 +388,8 @@ U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.of_match	= exynos_dwmmc_ids,
 	.of_to_plat	= exynos_dwmmc_of_to_plat,
 	.bind		= exynos_dwmmc_bind,
-	.ops		= &dm_dwmci_ops,
 	.probe		= exynos_dwmmc_probe,
+	.ops		= &dm_dwmci_ops,
 	.priv_auto	= sizeof(struct dwmci_exynos_priv_data),
 	.plat_auto	= sizeof(struct exynos_mmc_plat),
 };
-- 
2.39.2

