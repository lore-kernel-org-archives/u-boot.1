Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC645C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1354088C25;
	Thu,  8 Aug 2024 05:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L3Tgegg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3D888C3E; Thu,  8 Aug 2024 05:15:22 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB7388C26
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-260e6dfc701so357159fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086911; x=1723691711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLFXdHGMnWLYnhM9vqaerX9xibelRdBawZDKsXl43no=;
 b=L3Tgegg4y9kBcjDHAoUBC2adutksC91S77Yj0jIfkfizSk06ouIyNMIX4QBl+N/lGI
 AMdeQdrfmP4KVMZ64GiGCLLnBNKT6gljo0Ibdl712+/fXouEvbY1tzixEWsfyAM1yOYD
 DF/XXXeZxUhJoDdqxrIM3efl0pfa1FHz2OnhyxYSiO6WCRQg5B4c/sU7Jaom0ZAL7tTi
 5+mjtTlNm/g9tJ6bW9TWUGgJsmkYakxjuX/WHdQQgUe5Es5NiTO+CIY5DFOC1MoUuYSF
 oJOTZc2baJYrouZoG/fvhFKg7QWIgBI3Cs9yRsPCCS3SjSJo/xtcE/kSGNf3umUbdCyi
 NoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086911; x=1723691711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLFXdHGMnWLYnhM9vqaerX9xibelRdBawZDKsXl43no=;
 b=FQJzvJFINUhi2DagUX1Sh+P4x1Zml5nSdDB5cvsXALeEeBJTtttLYnzUN2g4uIlile
 oChiCGHpO+JFmF6ybNvEeDPOeNkNzhBpfcpBTRDrHBjmphdbb9x+QSIwaIT8T3DPFJqD
 JxVv2gVGhcW6migZinpoAkc8vzHZuxdKwNVl/aie8SJPNFplyiIYvBABfN/uOpZPgPcB
 Y/n/G10NS+Eog6wsE93B8KXgNfys8O/nET8MYOXItI8uGUxgvXaPNo+8pOmZgqsy6HvZ
 zVQVGYArQUcgZdIHrGdqUz79+h/K/a9tSTK2qzgJhpLxpTDFA+uVR/QdviCZtIWlQWFq
 gJqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsODarkNZmk7BhhJxcXMGTteZPCoGAAucbPSxEPJQu2vZWL67i5MCDQcU64aCxJ6LpLy79dRwPapEiFY5FpMqIN2FIkw==
X-Gm-Message-State: AOJu0YwntThoE20wCff88oqfYybcS/UuZfhcSNt5J5fmx4SCg+lHUeSl
 Q+QvPOQPWHzoaKtYnuxHjR8dw1R8ko/PxJk6TvM2XBCnr5l7kZsgPGYDalBcsJI=
X-Google-Smtp-Source: AGHT+IHOUkFvWWdSiO5arzoS3iAONSrXME0obfdJIK1KNEt8ikC2LWbhpa0EFYymDhPtJbxaAR4uWw==
X-Received: by 2002:a05:6870:71c3:b0:261:acf:e964 with SMTP id
 586e51a60fabf-2692b7f270cmr642320fac.48.1723086911047; 
 Wed, 07 Aug 2024 20:15:11 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f1af9sm4379180fac.13.2024.08.07.20.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:10 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 35/38] mmc: exynos_dw_mmc: Improve coding style
Date: Wed,  7 Aug 2024 22:14:41 -0500
Message-Id: <20240808031444.9619-36-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

