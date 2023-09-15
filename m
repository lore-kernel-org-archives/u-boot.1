Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05644EED615
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 16:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5EB786529;
	Fri, 15 Sep 2023 18:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QlXsycYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB058649F; Fri, 15 Sep 2023 18:01:41 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA4D8649F
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbrunet@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so22019805e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694793699; x=1695398499;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa2YXl7a1fYjgn7FU/+M4EKLX2xkiQWUedabj9t1yWE=;
 b=QlXsycYnxeFpFZI9M0BUZ5UyTsRBdAlDwpTWDPxU0NZ6yvPrSTYvcSz9JR5V1ANBtH
 ffnX2pbtYzB6XPmJBz7I3OE/dOq17WZygWAHMql2GZUy2+Tq/SJkR83j3Urrl6vDLfuL
 4BgV0YPPYpmYuYfKbA+FVnmj7qkJTi7ckEH3NS7kf3/ckPH+T0V5befuzsVEJvS3QHy0
 V7E4xHK9FjfpiJr/7H8TIOd3XgEpv5xN6wwpG+7QtYAiKBS6vQvklVkRxhP+lZjdxWzm
 QHP0oIgZS/qQrp9KtIjdw12z7+Ux3RS0VbunSnHI2uKjwUeLPbqV1EMRJ30cR3Y/aYMh
 RZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793699; x=1695398499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sa2YXl7a1fYjgn7FU/+M4EKLX2xkiQWUedabj9t1yWE=;
 b=Tj5QcbQX8aaT9+seLuCeY3DmZ7HWXuF9JFUGul4aq0g9bkh+w1OibRtwi3YDT1ayKp
 926+9b/FDZ0xVjrg5dSPnditLxiZhAeA2u18V5tfluNPMDo46YadL3ciutZ5+otcpRDv
 0f6NHooZeMHx1HmXDwTgCV7dDlrUI2HY58EcFubRnUQ8nASVil3A+XPWXcHIPbRJ53Or
 ptKaHFr8JSnK4+XPVAeNH+Ut/Dx1+p0ho3QPmZFDmzVy66pM6ZoDb2zR3uWWxgUr7VPk
 MgcijSfpl0fWuJr0/DRbJDw9/1oelLsdkKY0AUe2TfmTSmEh/v3kayX99904jTahOE5k
 tD1Q==
X-Gm-Message-State: AOJu0YyeVKFCnE79RQ8SA2KAePerYFXVwGesATiez5RCXORAjNQJeNND
 Bc8EovSB8G8yANy2SpFWAWwZBw==
X-Google-Smtp-Source: AGHT+IEhqi9Qe0q/8HXsXqm42WGNwoJ4tnNKVr0OXgi+vkRtgGZVVDTORekDSjoQRFW4aZvcwatcaQ==
X-Received: by 2002:a5d:6ac8:0:b0:317:6734:c2ae with SMTP id
 u8-20020a5d6ac8000000b003176734c2aemr3801478wrw.11.1694793699016; 
 Fri, 15 Sep 2023 09:01:39 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:cc7c:a70f:b3d:d73b])
 by smtp.googlemail.com with ESMTPSA id
 p7-20020a056000018700b003176aa612b1sm4761766wrx.38.2023.09.15.09.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:01:38 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: [RFT PATCH 1/2] mmc: meson-gx: clean up and align on Linux settings
Date: Fri, 15 Sep 2023 18:01:29 +0200
Message-Id: <20230915160130.352099-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
References: <20230915160130.352099-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
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

* Remove obsolete comments
* Set core phase to 180 regardless of the SoC like Linux
* Enable always-on clock

AML mmc driver has been working okay(ish) for a few years
The purpose of this patch is to bring u-boot closer to what
Linux is doing

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c | 45 ++++++++++++++++----------------------
 drivers/mmc/meson_gx_mmc.h |  9 ++++++--
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index fcf4f03d1e24..c6168792cbae 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -17,13 +17,14 @@
 #include <linux/log2.h>
 #include "meson_gx_mmc.h"
 
-bool meson_gx_mmc_is_compatible(struct udevice *dev,
-				enum meson_gx_mmc_compatible family)
-{
-	enum meson_gx_mmc_compatible compat = dev_get_driver_data(dev);
-
-	return compat == family;
-}
+struct meson_gx_mmc_version_data meson_gx_mmc_version[] = {
+	[MMC_COMPATIBLE_V2] = {
+		.clk_always_on = BIT(24),
+	},
+	[MMC_COMPATIBLE_V3] = {
+		.clk_always_on = BIT(28),
+	},
+};
 
 static inline void *get_regbase(const struct mmc *mmc)
 {
@@ -44,13 +45,17 @@ static inline void meson_write(struct mmc *mmc, uint32_t val, int offset)
 
 static void meson_mmc_config_clock(struct mmc *mmc)
 {
+	struct meson_mmc_plat *pdata = mmc->priv;
 	uint32_t meson_mmc_clk = 0;
 	unsigned int clk, clk_src, clk_div;
 
 	if (!mmc->clock)
 		return;
 
-	/* TOFIX This should use the proper clock taken from DT */
+	/* Clk always on */
+	meson_mmc_clk |= pdata->version->clk_always_on;
+	meson_mmc_clk |= CLK_CO_PHASE_180;
+	meson_mmc_clk |= CLK_TX_PHASE_000;
 
 	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
 	if (mmc->clock > 16000000) {
@@ -62,20 +67,6 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	}
 	clk_div = DIV_ROUND_UP(clk, mmc->clock);
 
-	/*
-	 * SM1 SoCs doesn't work fine over 50MHz with CLK_CO_PHASE_180
-	 * If CLK_CO_PHASE_270 is used, it's more stable than other.
-	 * Other SoCs use CLK_CO_PHASE_180 by default.
-	 * It needs to find what is a proper value about each SoCs.
-	 */
-	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
-		meson_mmc_clk |= CLK_CO_PHASE_270;
-	else
-		meson_mmc_clk |= CLK_CO_PHASE_180;
-
-	/* 180 phase tx clock */
-	meson_mmc_clk |= CLK_TX_PHASE_000;
-
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
 	meson_mmc_clk |= clk_div;
@@ -243,6 +234,7 @@ static const struct dm_mmc_ops meson_dm_mmc_ops = {
 
 static int meson_mmc_of_to_plat(struct udevice *dev)
 {
+	enum meson_gx_mmc_compatible compat = dev_get_driver_data(dev);
 	struct meson_mmc_plat *pdata = dev_get_plat(dev);
 	fdt_addr_t addr;
 
@@ -251,6 +243,7 @@ static int meson_mmc_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 
 	pdata->regbase = (void *)addr;
+	pdata->version = &meson_gx_mmc_version[compat];
 
 	return 0;
 }
@@ -277,7 +270,7 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
 			MMC_VDD_31_32 | MMC_VDD_165_195;
 	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
-			MMC_MODE_HS_52MHz | MMC_MODE_HS;
+			 SD_HS | MMC_MODE_HS_52MHz | MMC_MODE_HS;
 	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
 	cfg->f_max = 100000000; /* 100 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
@@ -321,9 +314,9 @@ int meson_mmc_bind(struct udevice *dev)
 }
 
 static const struct udevice_id meson_mmc_match[] = {
-	{ .compatible = "amlogic,meson-gx-mmc", .data = MMC_COMPATIBLE_GX },
-	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_GX },
-	{ .compatible = "amlogic,meson-sm1-mmc", .data = MMC_COMPATIBLE_SM1 },
+	{ .compatible = "amlogic,meson-gx-mmc", .data = MMC_COMPATIBLE_V2 },
+	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_V3 },
+	{ .compatible = "amlogic,meson-sm1-mmc", .data = MMC_COMPATIBLE_V3 },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/mmc/meson_gx_mmc.h b/drivers/mmc/meson_gx_mmc.h
index 8974b78f559d..3ec913d1b5ef 100644
--- a/drivers/mmc/meson_gx_mmc.h
+++ b/drivers/mmc/meson_gx_mmc.h
@@ -10,8 +10,8 @@
 #include <linux/bitops.h>
 
 enum meson_gx_mmc_compatible {
-	MMC_COMPATIBLE_GX,
-	MMC_COMPATIBLE_SM1,
+	MMC_COMPATIBLE_V2,
+	MMC_COMPATIBLE_V3,
 };
 
 #define SDIO_PORT_A			0
@@ -84,7 +84,12 @@ enum meson_gx_mmc_compatible {
 #define MESON_SD_EMMC_CMD_RSP2		0x64
 #define MESON_SD_EMMC_CMD_RSP3		0x68
 
+struct meson_gx_mmc_version_data {
+	uint32_t clk_always_on;
+};
+
 struct meson_mmc_plat {
+	struct meson_gx_mmc_version_data *version;
 	struct mmc_config cfg;
 	struct mmc mmc;
 	void *regbase;
-- 
2.40.1

