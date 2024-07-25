Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF7EC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A5A88585;
	Thu, 25 Jul 2024 22:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="saHpOj+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA7088609; Thu, 25 Jul 2024 22:45:43 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8B088599
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d9dbbaa731so172078b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940340; x=1722545140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/Ea6ucmu4BNaMXb/iQjPm7+dfFKyLqVIq9Zyi01YvI=;
 b=saHpOj+yJNjjULMbuCYL4km1Z1dLPZ/WMVzxn7mfDOtZKAQnpMXH6qCvc/vuaqbNfn
 b1bFQdVmaDoYQVgUeNNuG3+qXZKT+YmmWkwwtWJHopzZLDMCJB8+JgcmpR+XXivOwP8v
 NA+3xzDdxl3U2/bI5oGgwmERrnMAVBGCa7UR1105Cb4D2wogyS+b0/xlYXFXHXYdgO4I
 loE/kVq5VGM4JO2EvAb4PCKKFstOswY8NdzFq0ViztLSPG7iCzMJP75ks19QJVURlTQn
 nuAnJwtkRjB/+w7/jHrDhheObbhz5I5RqOzrck5HSPT8ms6RsBnSTN7skjyYOHCe2ew+
 eHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940340; x=1722545140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/Ea6ucmu4BNaMXb/iQjPm7+dfFKyLqVIq9Zyi01YvI=;
 b=koD4m//GF2CpyULBkMt+1R5dwEEuLHXUjmjy8IpskzfRdO7dTvj+Bc73PzxSAAV5mJ
 05TvhdmqXghf1mX8uoJkjhX2O+XqeQjw0eQH3pbN8GDtaE7oweV5TU1WWxJw7JYaIqJW
 N9iHYueIWnSlbTtzHjhastzBjxwguo1oGS8F6bLABeEqmKuhK8Hl22ZcBh7Inl1njcD2
 ZzGE700m3Wg4tyajiSs8OkRX+fmGZnO3IsCinFNvL0pTdmHiG7AHUQuyTwiWQd+s/dwz
 B2W9rZKqCYUTzE1j+1Mo6nlHXss10QqQUzglFOW04b58HQ5plwY7sTD9W2nN+FSTMdcx
 qfhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSBxsCbP1rBFJFynj8cccxLkSFzr+dwmK6Q8kTq+GpAQLGKRLSHAZ43EP2efKqrnDrWGcOJqdtEhYPzn6l/T9vh19k0A==
X-Gm-Message-State: AOJu0YzZC7CeUJL8/xoJzF0KyaYoY37VJKI7yVXG2ZkqIZDJXc+m+N5x
 UGYoj9hOlOCntP3l8WAXJzsYVlIEgsXwvT+Ww6N6869lUrgxzfjX3OW89pTv734=
X-Google-Smtp-Source: AGHT+IFWN1OCbjrGcyMzJdfmy5BWZAANx4bYx13mPPFZwG9FFFfcMzUU1TRxdTTUzmd/q7U9Bw9I6Q==
X-Received: by 2002:a05:6808:158f:b0:3d9:dbdb:cdac with SMTP id
 5614622812f47-3db141d531emr3082067b6e.32.1721940339916; 
 Thu, 25 Jul 2024 13:45:39 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db13523daesm431948b6e.45.2024.07.25.13.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:39 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 25/38] mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
Date: Thu, 25 Jul 2024 15:45:07 -0500
Message-Id: <20240725204520.18134-26-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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
Changes in v4:
  - (none)

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

