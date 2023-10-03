Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD1AE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E9A8721E;
	Tue,  3 Oct 2023 08:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BG1b/HvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3320887206; Tue,  3 Oct 2023 08:34:05 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F6F8720E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50336768615so622946e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314842; x=1696919642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG3JGxVOJ4oE4vmR+dFY1swRScI+A3JsAUK8VaqqxyA=;
 b=BG1b/HvLrGFEMm66QUUFZ+Wd3078b2Z0EnkpTVCVWdtriLq4fQcIyuyvrCwp/Ow+Tz
 da8Evi15mbwcQuVsGMlqXxK4fkzht7cXG021oEu0uTBZolAlG01rmufi/ZIjbiKsDqys
 HEmhl0ZSzEX2jDJSAfyTqK3lUEyGlHSppN3P32uDsklY0K1HAQRGcXHefFhDeKSIOXOO
 sJrycWbdO8LTEqnDGNozaY6UpecBUCQpkICWTMRUzqt9zlP/KL4NfeaiUSWffZcgJDd1
 V489X2WybgESLwwIeCNrBYB15NJT50bJhhxgWQpXDrAAmAPwfQlZhc17kchFx5WSkxAu
 yyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314842; x=1696919642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tG3JGxVOJ4oE4vmR+dFY1swRScI+A3JsAUK8VaqqxyA=;
 b=sgzv4YCHaWInqCrFVTL+BdHKh5u/mla+2P0nRWnoWWWqaQAXzwBo8FKTy1KTTii6KE
 Mg7ExC9VORDctPEIcGqStQ7h93/RvUy9KMs9qTxFW+C91FSU7o/+k01OHwIgnYJeE0ji
 1Be6kJexrroxA22E493+QcSX757hQqZtQHrIfCSuMyYMsAOOQvbiaBiNE4H5bfyqdRY4
 H8Vuk7jwLXSJtaeahtrS9uGcOlCCEAOYwKOVrYCeahVgLjSYWDW2Gyksb01l7mbXuxGr
 R66CPHvbRsiZkXkxZQv8aGMkQZVzBIwUDYWiOaB1T2s5rM3lGdcKc7NKRq0an9BhcOrA
 Z6kw==
X-Gm-Message-State: AOJu0YxAviOrV4xam0p45vO6Y+yGDG20hNEJVhZ89buko9aksJqUpfLN
 9CsP2gRLz6uVPl7iDZTbkl8=
X-Google-Smtp-Source: AGHT+IGepQpBITQ/4G8yPAdxQ38U4R2U/f1pyMlQNRZrepHR7Vma1s5ORZkf5ja7jsaPR+NzxMmRrA==
X-Received: by 2002:a05:6512:ea1:b0:503:2642:435e with SMTP id
 bi33-20020a0565120ea100b005032642435emr12638217lfb.66.1696314842082; 
 Mon, 02 Oct 2023 23:34:02 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac2520a000000b0050309ea3a62sm75769lfl.277.2023.10.02.23.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:34:01 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 2/2] mmc: tegra: get default-tap and default-trim from
 device tree
Date: Tue,  3 Oct 2023 09:33:52 +0300
Message-Id: <20231003063352.42660-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063352.42660-1-clamor95@gmail.com>
References: <20231003063352.42660-1-clamor95@gmail.com>
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

Default-tap and default-trim values are used for eMMC setup
mostly on T114+ devices. As for now, those values are hardcoded
for T210 and ignored for all other Tegra generations. Fix this
by passing tap and trim values from dts.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 +++----
 drivers/mmc/tegra_mmc.c                     | 52 +++++++++++----------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/tegra_mmc.h b/arch/arm/include/asm/arch-tegra/tegra_mmc.h
index d6a55764ba..750c7d809e 100644
--- a/arch/arm/include/asm/arch-tegra/tegra_mmc.h
+++ b/arch/arm/include/asm/arch-tegra/tegra_mmc.h
@@ -128,21 +128,22 @@ struct tegra_mmc {
 
 /* SDMMC1/3 settings from SDMMCx Initialization Sequence of TRM */
 #define MEMCOMP_PADCTRL_VREF	7
-#define AUTO_CAL_ENABLE		(1 << 29)
-#define AUTO_CAL_ACTIVE		(1 << 31)
-#define AUTO_CAL_START		(1 << 31)
+#define AUTO_CAL_ENABLE		BIT(29)
+#define AUTO_CAL_ACTIVE		BIT(31)
+#define AUTO_CAL_START		BIT(31)
+
 #if defined(CONFIG_TEGRA210)
 #define AUTO_CAL_PD_OFFSET	(0x7D << 8)
 #define AUTO_CAL_PU_OFFSET	(0 << 0)
-#define IO_TRIM_BYPASS_MASK	(1 << 2)
-#define TRIM_VAL_SHIFT		24
-#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
-#define TAP_VAL_SHIFT		16
-#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
 #else
 #define AUTO_CAL_PD_OFFSET	(0x70 << 8)
 #define AUTO_CAL_PU_OFFSET	(0x62 << 0)
 #endif
 
+#define TRIM_VAL_SHIFT		24
+#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
+#define TAP_VAL_SHIFT		16
+#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
+
 #endif	/* __ASSEMBLY__ */
 #endif	/* __TEGRA_MMC_H_ */
diff --git a/drivers/mmc/tegra_mmc.c b/drivers/mmc/tegra_mmc.c
index f76fee3ea0..d507adbb36 100644
--- a/drivers/mmc/tegra_mmc.c
+++ b/drivers/mmc/tegra_mmc.c
@@ -37,6 +37,9 @@ struct tegra_mmc_priv {
 	unsigned int version;	/* SDHCI spec. version */
 	unsigned int clock;	/* Current clock (MHz) */
 	int mmc_id;		/* peripheral id */
+
+	int tap_value;
+	int trim_value;
 };
 
 static void tegra_mmc_set_power(struct tegra_mmc_priv *priv,
@@ -526,31 +529,6 @@ static void tegra_mmc_pad_init(struct tegra_mmc_priv *priv)
 		printf("%s: Warning: Autocal timed out!\n", __func__);
 		/* TBD: Set CFG2TMC_SDMMC1_PAD_CAL_DRV* regs here */
 	}
-
-#if defined(CONFIG_TEGRA210)
-	u32 tap_value, trim_value;
-
-	/* Set tap/trim values for SDMMC1/3 @ <48MHz here */
-	val = readl(&priv->reg->venspictl);	/* aka VENDOR_SYS_SW_CNTL */
-	val &= IO_TRIM_BYPASS_MASK;
-	if (id == PERIPH_ID_SDMMC1) {
-		tap_value = 4;			/* default */
-		if (val)
-			tap_value = 3;
-		trim_value = 2;
-	} else {				/* SDMMC3 */
-		tap_value = 3;
-		trim_value = 3;
-	}
-
-	val = readl(&priv->reg->venclkctl);
-	val &= ~TRIM_VAL_MASK;
-	val |= (trim_value << TRIM_VAL_SHIFT);
-	val &= ~TAP_VAL_MASK;
-	val |= (tap_value << TAP_VAL_SHIFT);
-	writel(val, &priv->reg->venclkctl);
-	debug("%s: VENDOR_CLOCK_CNTRL = 0x%08X\n", __func__, val);
-#endif	/* T210 */
 #endif	/* T30/T210 */
 }
 
@@ -588,6 +566,22 @@ static void tegra_mmc_reset(struct tegra_mmc_priv *priv, struct mmc *mmc)
 
 	/* Make sure SDIO pads are set up */
 	tegra_mmc_pad_init(priv);
+
+	if (!IS_ERR_VALUE(priv->tap_value) ||
+	    !IS_ERR_VALUE(priv->trim_value)) {
+		u32 val;
+
+		val = readl(&priv->reg->venclkctl);
+
+		val &= ~TRIM_VAL_MASK;
+		val |= (priv->trim_value << TRIM_VAL_SHIFT);
+
+		val &= ~TAP_VAL_MASK;
+		val |= (priv->tap_value << TAP_VAL_SHIFT);
+
+		writel(val, &priv->reg->venclkctl);
+		debug("%s: VENDOR_CLOCK_CNTRL = 0x%08X\n", __func__, val);
+	}
 }
 
 static int tegra_mmc_init(struct udevice *dev)
@@ -742,6 +736,14 @@ static int tegra_mmc_probe(struct udevice *dev)
 	if (dm_gpio_is_valid(&priv->pwr_gpio))
 		dm_gpio_set_value(&priv->pwr_gpio, 1);
 
+	ret = dev_read_u32(dev, "nvidia,default-tap", &priv->tap_value);
+	if (ret)
+		priv->tap_value = ret;
+
+	ret = dev_read_u32(dev, "nvidia,default-trim", &priv->trim_value);
+	if (ret)
+		priv->trim_value = ret;
+
 	upriv->mmc = &plat->mmc;
 
 	return tegra_mmc_init(dev);
-- 
2.39.2

