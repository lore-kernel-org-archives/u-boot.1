Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922F4C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCDC8872F;
	Mon, 22 Jul 2024 19:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KoRzQJQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683B68863B; Mon, 22 Jul 2024 19:58:04 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AE088669
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d57d8882eeso585591eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671080; x=1722275880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIFlXK4DxyWpvRX0Nfuj/LLHNuWwohRMEDArjMWowkE=;
 b=KoRzQJQaWdwd/Rdhza4ayiqKTywih8fInOZKECo/gpx4kwGQHulARjsgTlmKOtNpEk
 x3dybVABjMZodZ+ZKdoB5/zb8JO0vF2Efxqe9v2BNQNT6tf7OR9T/NGpDSToOZeGMczZ
 mVX/YfURudWjCSrcH14NCb7FBlNVNB+uFNQr/VuhnucctSrvXO1RfmbWgu2mBg3AAU+W
 cLneFPK5RhxvFmUg25CDtl801F+AncOzEwY6KcD7B0Vas8Hg/Hs925dLPPYBH/emkQBf
 YXQKHVJLsc46aBWuJ0+FpOReP5PCrDE849bG1uHLN45JydZ4oqNIk9/2EGzC4Ocki2QN
 aYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671080; x=1722275880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIFlXK4DxyWpvRX0Nfuj/LLHNuWwohRMEDArjMWowkE=;
 b=bi0vev6eY2WQcvjFc4KuWffDXh7YD/VkhB4P80+PZWvJclXjzKaauH8tPujRnDtmH7
 1DSKpA9Ls5Ax8og2icYhTVsTKbbBtWrrNrwKOrlIEn+xPmQNBkwxI91E/pgxN32pV1k0
 6QpIFc4AKCm/Z9IdLJsN/2uImEh7WTCQ3N2sSVxmsv2MV1RVzu0m9LQDKPoI6hFadj8s
 wNRbE9dE0TE2HJlwAuJeu3LNY7A74MLxpUxhq0mUCT9JjQRZn6zURs9F6mfHYBBDGrM5
 c0JN4KVjA310E0Z/FX+O2sBHXrTI7vY6FmMwc+or6uDfAkGkes3+jPCMDQXoOxjdOEl0
 jzHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4bOxljF9ys4KLRmKjjA0kWVKfpmgYrjGrT+hi6s7Rkx1PshCTmn3zKDgvbWgz3SOcRYK9taNGDwQS+Ajt1uaK/NfVnw==
X-Gm-Message-State: AOJu0YxfBkqDndaLtuXdDWZAdwmlG/HILmYHZxdKPobPgfBXZI/7CitQ
 FpKdWjfoYceuxUyYfjAgJSB4W7/QM1VmxsysoOAdaxe1HI3RhOlGL3jnijwnWeA=
X-Google-Smtp-Source: AGHT+IF4jELnOL1WTyPFk6WrmTCenxKxUR1FkcHUVDY6j7KOoZwHoVCCspCM2d4TlpT8t4t1f8W0CQ==
X-Received: by 2002:a05:6820:4c05:b0:5c6:aea8:aae7 with SMTP id
 006d021491bc7-5d564f5ac2bmr10238117eaf.5.1721671079925; 
 Mon, 22 Jul 2024 10:57:59 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aaec665sm1392341eaf.40.2024.07.22.10.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:59 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 25/38] mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
Date: Mon, 22 Jul 2024 12:57:27 -0500
Message-Id: <20240722175740.6985-26-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

Some chips like Exynos4412 have fixed internal CIU clock divider.
Instead of reading it from non-standard "div" dts property, store its
value in the driver internally, in static chip data associated with
corresponding compatible. This makes it possible to avoid using
host->div for storing it, so the latter can be removed safely. Also
create a helper function called exynos_dwmmc_get_ciu_div() for getting
the current div value: in case the fixed div is provided in the chip
data it will be used, otherwise the current div value is being read from
CLKSEL register.

The insights for this change were taken from dw_mmc-exynos.c driver in
Linux kernel.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/ca_dw_mmc.c     |  2 +-
 drivers/mmc/exynos_dw_mmc.c | 43 +++++++++++++++++++++++++------------
 include/dwmmc.h             |  2 --
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/ca_dw_mmc.c b/drivers/mmc/ca_dw_mmc.c
index 54a2ba4795e3..1af5ec0532ea 100644
--- a/drivers/mmc/ca_dw_mmc.c
+++ b/drivers/mmc/ca_dw_mmc.c
@@ -86,7 +86,7 @@ unsigned int ca_dwmci_get_mmc_clock(struct dwmci_host *host, uint freq)
 		clk_div = 1;
 	}
 
-	return SD_SCLK_MAX / clk_div / (host->div + 1);
+	return SD_SCLK_MAX / clk_div;
 }
 
 static int ca_dwmmc_of_to_plat(struct udevice *dev)
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index fd2ced3d711d..b5c8f592c7e8 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -23,6 +23,8 @@
 #define	DWMMC_MMC0_SDR_TIMING_VAL	0x03030001
 #define	DWMMC_MMC2_SDR_TIMING_VAL	0x03020001
 
+#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
+
 #ifdef CONFIG_DM_MMC
 #include <dm.h>
 DECLARE_GLOBAL_DATA_PTR;
@@ -36,6 +38,7 @@ struct exynos_mmc_plat {
 /* Chip specific data */
 struct exynos_dwmmc_variant {
 	u32 clksel;		/* CLKSEL register offset */
+	u8 div;			/* (optional) fixed clock divider value: 0..7 */
 };
 
 /* Exynos implmentation specific drver private data */
@@ -126,12 +129,18 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 	return 0;
 }
 
-unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
+/**
+ * exynos_dwmmc_get_ciu_div - Get internal clock divider value
+ * @host: MMC controller object
+ *
+ * Returns: Divider value, in range of 1..8
+ */
+static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
-	unsigned long sclk;
-	int8_t clk_div;
-	int err;
+
+	if (priv->chip->div)
+		return priv->chip->div + 1;
 
 	/*
 	 * Since SDCLKIN is divided inside controller by the DIVRATIO
@@ -139,9 +148,17 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	 * clock value to calculate the CLKDIV value.
 	 * as per user manual:cclk_in = SDCLKIN / (DIVRATIO + 1)
 	 */
-	clk_div = ((dwmci_readl(host, priv->chip->clksel) >> DWMCI_DIVRATIO_BIT)
-			& DWMCI_DIVRATIO_MASK) + 1;
+	return ((dwmci_readl(host, priv->chip->clksel) >> DWMCI_DIVRATIO_BIT)
+				& DWMCI_DIVRATIO_MASK) + 1;
+}
 
+unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
+{
+	unsigned long sclk;
+	u8 clk_div;
+	int err;
+
+	clk_div = exynos_dwmmc_get_ciu_div(host);
 	err = exynos_dwmmc_get_sclk(host, &sclk);
 	if (err) {
 		printf("DWMMC%d: failed to get clock rate (%d)\n",
@@ -149,11 +166,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 		return 0;
 	}
 
-	/*
-	 * Assume to know divider value.
-	 * When clock unit is broken, need to set "host->div"
-	 */
-	return sclk / clk_div / (host->div + 1);
+	return sclk / clk_div;
 }
 
 static void exynos_dwmci_board_init(struct dwmci_host *host)
@@ -270,8 +283,10 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	/* Extract the timing info from the node */
-	div = dev_read_u32_default(dev, "samsung,dw-mshc-ciu-div", 0);
+	if (priv->chip->div)
+		div = priv->chip->div;
+	else
+		div = dev_read_u32_default(dev, "samsung,dw-mshc-ciu-div", 0);
 	err = dev_read_u32_array(dev, "samsung,dw-mshc-sdr-timing", timing, 2);
 	if (err) {
 		printf("DWMMC%d: Can't get sdr-timings\n", host->dev_index);
@@ -292,7 +307,6 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
-	host->div = dev_read_u32_default(dev, "div", 0);
 
 	return 0;
 }
@@ -333,6 +347,7 @@ static int exynos_dwmmc_bind(struct udevice *dev)
 
 static const struct exynos_dwmmc_variant exynos4_drv_data = {
 	.clksel	= DWMCI_CLKSEL,
+	.div	= EXYNOS4412_FIXED_CIU_CLK_DIV - 1,
 };
 
 static const struct exynos_dwmmc_variant exynos5_drv_data = {
diff --git a/include/dwmmc.h b/include/dwmmc.h
index a99b2f3bf0cc..8c2500da9efe 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -184,7 +184,6 @@ struct dwmci_idmac_regs {
  * @caps:	Capabilities - see MMC_MODE_...
  * @clock:	Current clock frequency (after internal divider), Hz
  * @bus_hz:	Bus speed in Hz, if @get_mmc_clk() is NULL
- * @div:	Arbitrary clock divider value for use by controller
  * @dev_index:	Arbitrary device index for use by controller
  * @dev_id:	Arbitrary device ID for use by controller
  * @buswidth:	Bus width in bits (8 or 4)
@@ -205,7 +204,6 @@ struct dwmci_host {
 	unsigned int caps;
 	unsigned int clock;
 	unsigned int bus_hz;
-	unsigned int div;
 	int dev_index;
 	int dev_id;
 	int buswidth;
-- 
2.39.2

