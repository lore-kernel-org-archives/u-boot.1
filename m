Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E80C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A981885A3;
	Thu, 23 May 2024 01:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ze4EMNtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4688E885D0; Thu, 23 May 2024 01:32:07 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4B78852F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-241ad94775eso2960722fac.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420720; x=1717025520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bPB5iVsb6KzOxID/n5oPa03MYxpAV5lI+UKN35eg2Y=;
 b=ze4EMNtOfQ7wVJ4ezqEEPdAo+9/IvY9fra6mtnK9OV+TrXNJ4GiKKGDyZFi8s3rbe0
 LBDE0hewVr/U6HU90fW1qKHMsVqHPn3twayk/lJpNG+qbHQU/5HtDMF02s0xsmFVNlHB
 7OX+GVDo430Yyrbf3vZQZAnZMhLD2JVVTKpUs2hFGZEWOIgdV7/u4dzDJ7a9hAy/jTME
 xypKel6ZhjDPs43mBNqdvWH/+BEUSOcOwh90cR02lRGzeQkGgbh157WJ1ZnBzffMEUzx
 M2gH8q9lzHaXz7n29zjkhB01SK66CF3xzppoKKGcS7I3kp1ZRhSFvl+88ooXiJGRFhPm
 9mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420720; x=1717025520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bPB5iVsb6KzOxID/n5oPa03MYxpAV5lI+UKN35eg2Y=;
 b=OhGkYtGMnIRoIJ1Yzo2EtzD8wQqeLEs6Qac6it/uW2Zo7b6gH/i8rtW430OJSK6QyB
 UFRGKFqWRWdmPgLFqH+RIqdrIPrxjCjoo/q2EfuldCSokoCqEjaUij92BKxIwv3RHVwT
 ODwpyM8R7gtEEgRkeP5IROLDktlzjCNNSTiKTFB/ncZUm2Xl9aXqA3OBO1hnxBXC+4De
 h6qdjHIV/SFXEzCGY4y2crdEcVYgd7aEIejJqCBMsha5IOAah3IWVh+jt09Ydy8KJmC4
 EQSijkqmvJKfRwF975wHgCdHBIeEjdyb9aRDQMH0gmAV07nRrbaL1xR8teuRm298igVY
 UOyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV36tgMO/aCTUxp776FosBitPaN+yvF6xHehe2k07ydpZla9E630+IYn7hR16z7Vj0OvA2SE/IVemkcrWqBlRPJpW8I8w==
X-Gm-Message-State: AOJu0YyCG2t3MiQw5MkQ2G/0FyG3wNdurcJJptpHEePps1dtAe1M5Q/P
 FNJmhXEHSsA6biJ3FzFAMb9cxjazotiT2jaN/C0/ImWjM3D+Bghr6iguI6AfWnc=
X-Google-Smtp-Source: AGHT+IHMsY3PpVsD+9tQq+M8WujoNrSojh0GRtSA7ykwsERi/wmXJPDugXRyDYFpp03F/eos0J8Dnw==
X-Received: by 2002:a05:6870:9692:b0:221:bd93:2940 with SMTP id
 586e51a60fabf-24c68df199bmr4017359fac.27.1716420719933; 
 Wed, 22 May 2024 16:31:59 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f46c9e1e42sm741918a34.80.2024.05.22.16.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:59 -0700 (PDT)
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
Subject: [PATCH 27/42] mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
Date: Wed, 22 May 2024 18:31:20 -0500
Message-Id: <20240522233135.26835-28-semen.protsenko@linaro.org>
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
 drivers/mmc/ca_dw_mmc.c     |  2 +-
 drivers/mmc/exynos_dw_mmc.c | 43 +++++++++++++++++++++++++------------
 include/dwmmc.h             |  2 --
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/ca_dw_mmc.c b/drivers/mmc/ca_dw_mmc.c
index a17ed8c11cbe..342e09d02306 100644
--- a/drivers/mmc/ca_dw_mmc.c
+++ b/drivers/mmc/ca_dw_mmc.c
@@ -87,7 +87,7 @@ unsigned int ca_dwmci_get_mmc_clock(struct dwmci_host *host, uint freq)
 		clk_div = 1;
 	}
 
-	return SD_SCLK_MAX / clk_div / (host->div + 1);
+	return SD_SCLK_MAX / clk_div;
 }
 
 static int ca_dwmmc_of_to_plat(struct udevice *dev)
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index edf8fbc7d734..646302f54ae6 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -24,6 +24,8 @@
 #define	DWMMC_MMC0_SDR_TIMING_VAL	0x03030001
 #define	DWMMC_MMC2_SDR_TIMING_VAL	0x03020001
 
+#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
+
 #ifdef CONFIG_DM_MMC
 #include <dm.h>
 DECLARE_GLOBAL_DATA_PTR;
@@ -37,6 +39,7 @@ struct exynos_mmc_plat {
 /* Chip specific data */
 struct exynos_dwmmc_variant {
 	u32 clksel;		/* CLKSEL register offset */
+	u8 div;			/* (optional) fixed clock divider value: 0..7 */
 };
 
 /* Exynos implmentation specific drver private data */
@@ -127,12 +130,18 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
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
@@ -140,9 +149,17 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
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
@@ -150,11 +167,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
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
@@ -334,6 +348,7 @@ static int exynos_dwmmc_bind(struct udevice *dev)
 
 static const struct exynos_dwmmc_variant exynos4_drv_data = {
 	.clksel	= DWMCI_CLKSEL,
+	.div	= EXYNOS4412_FIXED_CIU_CLK_DIV - 1,
 };
 
 static const struct exynos_dwmmc_variant exynos5_drv_data = {
diff --git a/include/dwmmc.h b/include/dwmmc.h
index e17884ade7e6..c69c7952b930 100644
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

