Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD24C25B7D
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C30928859A;
	Thu, 23 May 2024 01:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YJZhXVIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58456885B6; Thu, 23 May 2024 01:32:06 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704A688582
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c99aec9598so2878418b6e.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420719; x=1717025519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVZjnsTBktbiyyGF1ZIr1VHss5LEPFxyM9ht7HU14tw=;
 b=YJZhXVIHJMIRr95YJ4OczyFSQpFkZuaR2oQGRSeGkakoXnm4ex9ZhpughM+ulHzHR9
 m2MTjx+PAqBzkQqPk/2IImFbn9S+epzcliK+YpSdj/1jz/h+Tdvxv23FFoEfsOkoJWkL
 bSUHEG75qa0X0jFRZg3U0Lm5Ymxy7Y2jsEfYE9akfQwSR5MKRspUomRaNh7+qokbIZTX
 EPXOrVUtQMyOz7e3LIXvODWcCKWA+CC3gwWfdwaCi2EUN3tvLTigQkINEwgg4U64Yz7i
 weUCZMfrJUmMQ4jyWXv1HXX42NCTSXhn64qO0+jDJyDO2UQ/ohcVySfQC+UsRa3hg03F
 bSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420719; x=1717025519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVZjnsTBktbiyyGF1ZIr1VHss5LEPFxyM9ht7HU14tw=;
 b=RILjlpiW8nokapyJMh/e4UamiwtIa1g3mxYbuebZHdHnGDQKpAI5rBwfKUr4jcBW0k
 fxFQnAExOL73BedHMV+t59l+KX3WvYMR1XDWe9BcigT35GKKN2K9KconS16jQSEnm8vv
 gon92fiIHmU1vX5Ot+VzTrW2xUdoOh2YR3cFSFF6K1lMxkcUerWxh/lxoHXtfd7qKWqd
 Komv1LbRVYKlmM7ptlpbzpet3cbhyD1EejDBTgUU+FJLLx7Q0voIwKnyRtzkE73QUKyZ
 CR238m1yfRNZOspT35wo4rO95a05yqxEO33DNjmvRBD2vU/8Pr4a6zhfUyhEPUK+M+mI
 flWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN80B77qtkmQMjcg6j+BbKegl6ATmWrfAINfj50UMByQiCp57bDfvJnLiTiRUXHLbYcgr8LbPH5Uf1GQnv78p2WZlFdA==
X-Gm-Message-State: AOJu0YwU35MsBYpBHpuesrj12m/nBl2G104QmTp+VMd/OSdAbB5+IvVg
 XTAxWNih/JsB3mxv71TmZa3Fw58Ob/709kmwgrxeDxO6hMrLluBe+QJshCrDfzA=
X-Google-Smtp-Source: AGHT+IGoNhZY26A5QtwnfJV37By5BaH4HHynS6ITLWu1M4OwG8DaCm1YBpq1rypXeofUQmN0WMFXYA==
X-Received: by 2002:a05:6808:138d:b0:3c9:6b77:da7 with SMTP id
 5614622812f47-3cdb64c6f97mr4129363b6e.21.1716420719192; 
 Wed, 22 May 2024 16:31:59 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c9935bb5afsm4697604b6e.10.2024.05.22.16.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 26/42] mmc: exynos_dw_mmc: Abstract CLKSEL register
Date: Wed, 22 May 2024 18:31:19 -0500
Message-Id: <20240522233135.26835-27-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
index 788587b622ca..edf8fbc7d734 100644
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
@@ -229,6 +236,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	int err = 0;
 	u32 div, timing[2];
 
+	priv->chip = (struct exynos_dwmmc_variant *)dev_get_driver_data(dev);
+
 #if CONFIG_IS_ENABLED(CPU_V7A)
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

