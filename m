Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B7BC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613E188BC8;
	Thu,  8 Aug 2024 05:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sRVoHnvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0057B88A87; Thu,  8 Aug 2024 05:15:06 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C78C88AFF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70945a007f0so245640a34.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086903; x=1723691703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6YDJBIvcCFAl4slfQa3e+M/r3XTbUp34q0bDWEj3So=;
 b=sRVoHnvFsnnn5LH7TdkHe9FBa93KLgHrTQ+9VMrOaawEY2vZA5iCEkMf8C0KiQrrQ/
 iLQbj/7EWpkOx8DHRWjHyYxS2AF36QdfvP4jPqql7pzw/dCMBE2FRv/XzUUCtbZpdMgW
 17GNA4fju7BxsXepp2jUpw3BWG4hCQbjccDhjXNmfNxMKyszO0w6FN1jhF5UXREmw5x9
 Tl4mQ6uV26kkdAscZfCna6X9z4ChuLmNCTqJsHKhrilKuSFkKfkoEWfSabYVHeBbPUra
 xgn5O5kpqFYEE69dqrg7Qj+J8gdrMc/OOYPKxYfa662XBPtz9BaAfXW5i6899QOrtZwk
 IEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086903; x=1723691703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6YDJBIvcCFAl4slfQa3e+M/r3XTbUp34q0bDWEj3So=;
 b=a/mQRn6qOqsC+fcFmsJZI6N7v4gxgh9s89q8njsR2nSMsCu0tTr8ZkMj8Z353LNN7R
 +4jbylHysH4ryq4Ur9L1ZSOmyHdlZVOzsK1ecZNwsuMNe6AhuCWfq5nNKffU6yoV2hL0
 Ndf5L15XeWZ4FoItOi/0Am/UVtklGBNVINdol+qlLAIrDcnFPCw+yZXeNsDVoBcacmZ9
 5UObZdJ74RIUBGMT7xih9O64giV4jVKnFRgJnkXFb5iVdJUydxGC1jvcociv3c6NzPPq
 uwvcaQxc/RdjI3amWgtkRQe8Jt/vX7WD5JjkjCS8C19zz/MflDtMmUM57Gb8o3Mmbes7
 ZFJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1EG7ok8oshlf1/vkqlbQ8FKbLGP8ZHYwoZrLEltXEITsxw4zaf8Gclxh8xd8n+olaQ1BJkWEGd2cHsjNEq5CC3li70A==
X-Gm-Message-State: AOJu0YxQ/t2arMILbZ+0A2+Rxz5pDDiPixvNNeQGN9vMw9gd4GhnFTeT
 RpuAnpZNrVWvv90+vOZTFuzqBdzXd+5PzG/caTxR0cB/XspnzA++YPK71+ERLR8=
X-Google-Smtp-Source: AGHT+IEQLoL/uM/2rLejkOmnzst9AfWkMJRsmKj6ZU4y3G1busyY9D3TgpfzKsvmhZajE0J+XLikRg==
X-Received: by 2002:a05:6830:6608:b0:703:b0e9:d951 with SMTP id
 46e09a7af769-70b4fc2e66cmr675014a34.6.1723086902844; 
 Wed, 07 Aug 2024 20:15:02 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a7693dbsm5175702a34.72.2024.08.07.20.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:02 -0700 (PDT)
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
Subject: [PATCH v5 24/38] mmc: exynos_dw_mmc: Abstract CLKSEL register
Date: Wed,  7 Aug 2024 22:14:30 -0500
Message-Id: <20240808031444.9619-25-semen.protsenko@linaro.org>
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

CLKSEL register offset may vary between different Exynos chips, e.g. on
ARM64 vs ARM32 chips. Provide a way to specify its offset value for each
compatible instead of hard-coding its value in read/write calls.

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

 drivers/mmc/exynos_dw_mmc.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 4108af47e518..fd2ced3d711d 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -33,6 +33,11 @@ struct exynos_mmc_plat {
 };
 #endif
 
+/* Chip specific data */
+struct exynos_dwmmc_variant {
+	u32 clksel;		/* CLKSEL register offset */
+};
+
 /* Exynos implmentation specific drver private data */
 struct dwmci_exynos_priv_data {
 #ifdef CONFIG_DM_MMC
@@ -40,6 +45,7 @@ struct dwmci_exynos_priv_data {
 #endif
 	struct clk clk;
 	u32 sdr_timing;
+	const struct exynos_dwmmc_variant *chip;
 };
 
 static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
@@ -115,13 +121,14 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
-	dwmci_writel(host, DWMCI_CLKSEL, priv->sdr_timing);
+	dwmci_writel(host, priv->chip->clksel, priv->sdr_timing);
 
 	return 0;
 }
 
 unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 {
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 	unsigned long sclk;
 	int8_t clk_div;
 	int err;
@@ -132,7 +139,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	 * clock value to calculate the CLKDIV value.
 	 * as per user manual:cclk_in = SDCLKIN / (DIVRATIO + 1)
 	 */
-	clk_div = ((dwmci_readl(host, DWMCI_CLKSEL) >> DWMCI_DIVRATIO_BIT)
+	clk_div = ((dwmci_readl(host, priv->chip->clksel) >> DWMCI_DIVRATIO_BIT)
 			& DWMCI_DIVRATIO_MASK) + 1;
 
 	err = exynos_dwmmc_get_sclk(host, &sclk);
@@ -229,6 +236,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	int err = 0;
 	u32 div, timing[2];
 
+	priv->chip = (struct exynos_dwmmc_variant *)dev_get_driver_data(dev);
+
 #ifdef CONFIG_CPU_V7A
 	const void *blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
@@ -322,9 +331,22 @@ static int exynos_dwmmc_bind(struct udevice *dev)
 	return dwmci_bind(dev, &plat->mmc, &plat->cfg);
 }
 
+static const struct exynos_dwmmc_variant exynos4_drv_data = {
+	.clksel	= DWMCI_CLKSEL,
+};
+
+static const struct exynos_dwmmc_variant exynos5_drv_data = {
+	.clksel	= DWMCI_CLKSEL,
+};
+
 static const struct udevice_id exynos_dwmmc_ids[] = {
-	{ .compatible = "samsung,exynos4412-dw-mshc" },
-	{ .compatible = "samsung,exynos-dwmmc" },
+	{
+		.compatible	= "samsung,exynos4412-dw-mshc",
+		.data		= (ulong)&exynos4_drv_data,
+	}, {
+		.compatible	= "samsung,exynos-dwmmc",
+		.data		= (ulong)&exynos5_drv_data,
+	},
 	{ }
 };
 
-- 
2.39.2

