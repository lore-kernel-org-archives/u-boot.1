Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F1AC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129FD88555;
	Mon, 10 Jun 2024 03:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aV/zZIWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39538852E; Mon, 10 Jun 2024 03:12:48 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850D4884C5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f9b5bc97baso213354a34.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981965; x=1718586765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ev16xAcSMFowWept2qugSzFkmqI5xwf3UD/q8/LjRVg=;
 b=aV/zZIWFWqn4QvTJvCCFWfio+b9dF8yysHaMOmSE+QCwTqGg9SvCbEtk3l/RS5s1jO
 7blsAtYNz4SiD43bAQfT1Hc0Ws1tjikAJs5NC1a5MwtWtL/ORQkhNOLDLODcsXBeD203
 IURZhusuXaffbMjquRGTR52t4GRPfYstzAMf2bYJmgUMi90tel/UIq5njD9punzz/qf4
 dGgPKAcKAgLKviLJf+0W1Q0FvbhoqN2iZDG/aeTOpJbFkReysHj5Ib6HofMOnbvz5XKY
 jO54xsXGXsnZK7W73AvagULPtilUPNWeSehvUuTdW/7w9NwbKolGr6horHfuNAOlykih
 Z3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981965; x=1718586765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ev16xAcSMFowWept2qugSzFkmqI5xwf3UD/q8/LjRVg=;
 b=NWGxjZoIaadCxso4f7ZmwpYTxcPTWXdFcCOm5hb8WPXTmtIrt4kRmdFJOIdMkaB2qx
 kVofuZmZqxJaFns0buVWssRQy292k9Qez4n/ZbvNIITkaEuR2H+N3sgNgJDej5tuTBIP
 Cq420T7JMaEUsBz2pM+erSvx+dJHzRNpR5GtCtnoEhlktIofrmkdVb1TU5nQyJELwDqp
 ZOTpgvIYHs7arrbRdO4VA4uiAGyqdXN8d6/g4Iw3XKcrlEXs2fEcmBlerMZZ9pXv1yUZ
 wqodQRWCDmTGlOyrT0r4+eyuONrSVZjG2UU7ydxyRupjBbbwTEhxMLrHkADgNi4DRziK
 mdlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ga1NekK/euc7FdIOzhlQvWLrcXYSYff43J2Hd2knLXV47i4gCL/YIrs9B+sZgGHEVMKBbh5MWDk19YhCJh61pQn+Xg==
X-Gm-Message-State: AOJu0YwISTFGPPRARAiUtL+D7SRk5t/IheiFnxpe9Fo6J7jTYeOCOy6d
 axWvXYvhr/RObdvttW095esHj/SS8C/wUfjrNe4OsGNovoUmhCQLZriGqxM9res=
X-Google-Smtp-Source: AGHT+IFfEfnk2wE4e4g514aC0MnhQYowqteqMdc9bsjF3xnnMWRPnwhk+zcEKWzjthoz2Wl/R2fw7w==
X-Received: by 2002:a9d:4d06:0:b0:6f9:5d21:ccb9 with SMTP id
 46e09a7af769-6f95d21ccf2mr6874855a34.38.1717981965178; 
 Sun, 09 Jun 2024 18:12:45 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bad2536b64sm803374eaf.13.2024.06.09.18.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:44 -0700 (PDT)
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
Subject: [PATCH v2 25/40] mmc: exynos_dw_mmc: Abstract CLKSEL register
Date: Sun,  9 Jun 2024 20:12:11 -0500
Message-Id: <20240610011226.4050-26-semen.protsenko@linaro.org>
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

CLKSEL register offset may vary between different Exynos chips, e.g. on
ARM64 vs ARM32 chips. Provide a way to specify its offset value for each
compatible instead of hard-coding its value in read/write calls.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index a6e4d76fb25a..901cfc635418 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -34,6 +34,11 @@ struct exynos_mmc_plat {
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
@@ -41,6 +46,7 @@ struct dwmci_exynos_priv_data {
 #endif
 	struct clk clk;
 	u32 sdr_timing;
+	const struct exynos_dwmmc_variant *chip;
 };
 
 static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
@@ -116,13 +122,14 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
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
@@ -133,7 +140,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	 * clock value to calculate the CLKDIV value.
 	 * as per user manual:cclk_in = SDCLKIN / (DIVRATIO + 1)
 	 */
-	clk_div = ((dwmci_readl(host, DWMCI_CLKSEL) >> DWMCI_DIVRATIO_BIT)
+	clk_div = ((dwmci_readl(host, priv->chip->clksel) >> DWMCI_DIVRATIO_BIT)
 			& DWMCI_DIVRATIO_MASK) + 1;
 
 	err = exynos_dwmmc_get_sclk(host, &sclk);
@@ -230,6 +237,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	int err = 0;
 	u32 div, timing[2];
 
+	priv->chip = (struct exynos_dwmmc_variant *)dev_get_driver_data(dev);
+
 #ifdef CONFIG_CPU_V7A
 	const void *blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
@@ -323,9 +332,22 @@ static int exynos_dwmmc_bind(struct udevice *dev)
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

