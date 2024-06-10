Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9006C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8919488591;
	Mon, 10 Jun 2024 03:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fv0Ez2z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27C28858C; Mon, 10 Jun 2024 03:12:56 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61508852E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-24c9f628e71so1992975fac.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981973; x=1718586773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MN7F2uuiONybFzuaLB9fZnd0Psq7QLyOdjeklqJqr6w=;
 b=fv0Ez2z4a3Pe6HsLkMmE1RnzIjFI4eJEF74eHtpgPzNuAbNEFwVw63mH2jf0o0H59w
 3CT3IaleiYlQcg98mtG9dA0Z9wCS/OPgcZvtb1MgId2OPnKF3QoFR1iI2Rg/w4lwZmIB
 0OeN4Iv5UPnfTRcdjX3/UUtjHZClvThx0+CmNRXg424dbYKagupDHzZhrBARFFKxToSe
 AqJNS8mmYxJL+XI/4Ply2TeKOk+z5EhMw6xvRmwE3C3Hlrju1CxI/XcW9Hhuu8sVAhD2
 cTJL8vxraOU38Zsb2ICBeYIURQjlurSb8TwQ/J/ipNZIZAXTXNrwr5VkHzVLttt6WcaN
 OZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981973; x=1718586773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MN7F2uuiONybFzuaLB9fZnd0Psq7QLyOdjeklqJqr6w=;
 b=wOxePXMCi1QgxL1pHhirVvWWYppTmI3cnEalx1Jrf+5kVYg4Fxc0wHm9m3MDclMKwo
 /68SX8rTF4yXbdJmiij9Ava0jxqAxcAshLpq3ehQASV/jBIQrNtlemVure6Eynk4HNuk
 8sFCXi554xTXSqjRCTPeLlnoSARpHGZS3SrZtyB2MfM0lbSXzOiIHeUViGaipJnCZjdI
 jXShqh4ufri2R6CdIZ7evB12RBM5Cs28/XE0KYkQaPiXuXPjafEAqqOBPUuPUi+WX9Z0
 s0XgUyq7+OUBaHmdNZHjoXctp3t9i4qaMQTDdINmn9EI5BIMgVfeIsqnJHSng+K4XjoA
 upvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHsoAa/x9nR5t96FE/7Qlswn9NScpx9qXQeO+mpd/qoVCkvF3w9EugCamyJrJHPRpxeP3lFYp/Bp9+0gQS/DUyZdWBTw==
X-Gm-Message-State: AOJu0Yw9RaqY8HQTnLNbUi0d0+CjPs76uQ9AB6yOp5DWAF/TwxqeuWyh
 o0uoCZUCuM+xtP9kKcVM1vvAnENy61uQQr+pzoISCEMcw1uPGC5ukNs+hPzVr5Ku1V/IPOmClvI
 u
X-Google-Smtp-Source: AGHT+IEMJ+66SFkIrMYnYLOTZYX9wqd7fdCKRVAzLvMNkErXCMq3+liOI1k35Y3zGk5tHK43D48pjA==
X-Received: by 2002:a05:6870:d24b:b0:254:bb5d:468c with SMTP id
 586e51a60fabf-254bb5d483emr2564684fac.21.1717981973460; 
 Sun, 09 Jun 2024 18:12:53 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254480d9c79sm2083990fac.52.2024.06.09.18.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:53 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 37/40] mmc: exynos_dw_mmc: Improve coding style
Date: Sun,  9 Jun 2024 20:12:23 -0500
Message-Id: <20240610011226.4050-38-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

