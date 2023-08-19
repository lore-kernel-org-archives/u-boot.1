Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F23EE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 15:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FC987012;
	Sat, 19 Aug 2023 17:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r9MHqpIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA0A86F7A; Sat, 19 Aug 2023 17:35:15 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B371387000
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 17:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so241906466b.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692459312; x=1693064112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVG4jMR5E9BkTo87iPmFp6En1ZQGdzWo1lwohssY+H4=;
 b=r9MHqpIqzlqRGmarycqVpten920LN3c9aGppdYGSbpyMhscsDb3N31eRU6VznWWO0J
 rQr20ntstLtapPrSt5fWq5WKj1VYcm2zo4WB4UyCC+lQoJBY4flU6D5Jr0OjgR2uV95S
 2eJ845ToXOLH9A6oMVkrRx20PDDLaozJjH4T2GazkUkeX+/kBYin1huHSu5BcYMU2hKY
 pB5chwh7E2aw30bsSSmi0B23qEQynACNWX5PupGOELU2QaVt1cQyD/g5mgTYaj6vA97a
 gcHfMG+4DPfJJ+CxGkem38bmG8MXVJMOy5KDnRxSL/8Y1CUxTDjNfl0umQ3WS6B2UHHm
 JHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692459312; x=1693064112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVG4jMR5E9BkTo87iPmFp6En1ZQGdzWo1lwohssY+H4=;
 b=Wg7ox++CNwWbGGRhsktYpBB1RStc/hdUhqn97eCOX17vLsnQjAC4E+hAEoDlhKDxG1
 Wfi9op9RvceFp/cuoo22OP9QHdKCKAWpXB4LPGTNFn6/4kH2OwNS75TqxMDhhMBqW81B
 r+kzLMmIq/RfvbK72+5ZZD8TmIOuM38ggVZtbi74+zhnBXoLNcNz6k2E9PY7ovpBkW5f
 HJo9KKRb7s26Z9L/Uaj3yZDpRcaWkJ4YZNDlJqDEBsBhfH3MZ57/vmf6UYxCOTmqdGxy
 mR3uWTz98fKf1cJzUY55po+cjq2ZNNwtbx3Q4o+n2jivZt193jjx9YWU+rUkSVIy8130
 ks9A==
X-Gm-Message-State: AOJu0YyQljq7M7AX9iXg/Th58b6BaUjMw+t0MMoyHyg+1NPVjGGsXhqH
 +MoavAiJmv8Z/FRjh3uJvdo=
X-Google-Smtp-Source: AGHT+IH92VzNauvG7Ut7aIa38wDXhlGXpIaQnKVXXpjY17B59eKPr1w0EMqGlkJWbhbH/EU78mQ7JA==
X-Received: by 2002:a17:906:76d5:b0:99e:23a:d01b with SMTP id
 q21-20020a17090676d500b0099e023ad01bmr1685364ejn.19.1692459312184; 
 Sat, 19 Aug 2023 08:35:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 pv21-20020a170907209500b009829dc0f2a0sm2839737ejb.111.2023.08.19.08.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 08:35:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] mmc: tegra: get default-tap and default-trim from
 device tree
Date: Sat, 19 Aug 2023 18:35:01 +0300
Message-Id: <20230819153501.77245-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819153501.77245-1-clamor95@gmail.com>
References: <20230819153501.77245-1-clamor95@gmail.com>
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

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF701T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 ++++----
 drivers/mmc/tegra_mmc.c                     | 46 ++++++++++-----------
 2 files changed, 30 insertions(+), 33 deletions(-)

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
index f76fee3ea0..7627800261 100644
--- a/drivers/mmc/tegra_mmc.c
+++ b/drivers/mmc/tegra_mmc.c
@@ -37,6 +37,9 @@ struct tegra_mmc_priv {
 	unsigned int version;	/* SDHCI spec. version */
 	unsigned int clock;	/* Current clock (MHz) */
 	int mmc_id;		/* peripheral id */
+
+	u32 tap_value;
+	u32 trim_value;
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
 
@@ -588,6 +566,21 @@ static void tegra_mmc_reset(struct tegra_mmc_priv *priv, struct mmc *mmc)
 
 	/* Make sure SDIO pads are set up */
 	tegra_mmc_pad_init(priv);
+
+	if (priv->tap_value || priv->trim_value) {
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
@@ -742,6 +735,9 @@ static int tegra_mmc_probe(struct udevice *dev)
 	if (dm_gpio_is_valid(&priv->pwr_gpio))
 		dm_gpio_set_value(&priv->pwr_gpio, 1);
 
+	priv->tap_value = dev_read_u32_default(dev, "nvidia,default-tap", 0);
+	priv->trim_value = dev_read_u32_default(dev, "nvidia,default-trim", 0);
+
 	upriv->mmc = &plat->mmc;
 
 	return tegra_mmc_init(dev);
-- 
2.39.2

