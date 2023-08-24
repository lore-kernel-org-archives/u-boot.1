Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1620C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39D186901;
	Thu, 24 Aug 2023 20:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/Y/UXwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C378B8657C; Thu, 24 Aug 2023 20:54:39 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9435A86504
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so1532711fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692903276; x=1693508076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG3JGxVOJ4oE4vmR+dFY1swRScI+A3JsAUK8VaqqxyA=;
 b=g/Y/UXwpkSpvOMptOLy1wlTM5q5wcdeEm3sU/WDQXhZ2re2fBPcayCuB+NR0rLDbWP
 2q/OTR+RY55AIK2j6l5zoq5WfLHmNeeT4p7l/73a2MpnRy1EwtOGFqjbpWVAfstKqXdr
 MFus1IwZBTwFxlA7L6m4ERS3JBbMkP4diJDv4m+WT5JPudr9XH0pXXdyL1YvsiTK0HFH
 dgL7wHGHuA1xEFNNziRc1RQIs/4p6ocZG68xuPcD11m8DK0jHE/zhsksuNg065qCz2gZ
 146nLfL8ANtZOvo5i7M2tfOxupO0ZjoSY+c3CaPsd4ASuc+AJvSf790sa2bZxaeQLnxg
 kLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692903276; x=1693508076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tG3JGxVOJ4oE4vmR+dFY1swRScI+A3JsAUK8VaqqxyA=;
 b=I3mF1YxUuDHVeXM73GlOAFAQLfMZbko3Fkb1/OmK4zyes+/uafOjMB1TNskpZ+0KPc
 1oWmWt3qii5wT+1ifOluRuOZyYjTTT9f0ZO6cfOdDGXyjgiLXetLaLjJgvFV0ZzLRtb2
 37QqwScYUevbPFky0R2FyVgvdqnt3U2ndJC4wuFB9gl82RVOCnRnbhTIY7QADHheZ6KH
 JKcW7h3OrCf3GZlhHSA1TW1OAPnteY4n1al+bn+uRH/J0HxiKGf7Nr6so3Ah0iIIqHLZ
 cnzSdxAW2d3pSEB94GCFOZljw0w7jL0A6qsHvWMV1I9sZkWNcDV//zrU5zrjLPOzUtU4
 r0rA==
X-Gm-Message-State: AOJu0YxGydKPTyW6zX+5Ff1O8R7naxKYGAPU3J1sZuSuBsJXL2wGpqkp
 aFX4GLr6ShG5grfAFl+UUuQGQWfPNJ+SAA==
X-Google-Smtp-Source: AGHT+IH4vMvbB10xk5bh+C2LqzvgnLXs4TsrU2Mqcu4AEu33antqcDGC6lRuQ+zdjhbs2r3oOq1iKA==
X-Received: by 2002:a2e:81c6:0:b0:2bc:eb0d:5cc2 with SMTP id
 s6-20020a2e81c6000000b002bceb0d5cc2mr2004750ljg.9.1692903275634; 
 Thu, 24 Aug 2023 11:54:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 jp23-20020a170906f75700b00989828a42e8sm11166780ejb.154.2023.08.24.11.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:54:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] mmc: tegra: get default-tap and default-trim from
 device tree
Date: Thu, 24 Aug 2023 21:53:32 +0300
Message-Id: <20230824185332.50176-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824185332.50176-1-clamor95@gmail.com>
References: <20230824185332.50176-1-clamor95@gmail.com>
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

