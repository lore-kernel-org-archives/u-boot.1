Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFC8C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F6C8855E;
	Mon, 10 Jun 2024 03:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LAVavca8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFB6884AA; Mon, 10 Jun 2024 03:12:49 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008A48851B
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f977acff19so721740a34.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981966; x=1718586766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MofZ8uRp4MGIF+shM0f3Ad8dOPdSi82Tdfncbe2tGpA=;
 b=LAVavca8hr6ktOZlhn6scqXP/8vIdXZ+wPpI8LBch6ruVQAGvCmJK/ksTCXcj+TKbA
 npoIwCpBqeLhEhKUXvKXja4yIpy2TV3L/0beZyEpK9P2ewfzuFtY75+MmhBwNBTQNNsU
 bR0lFmFmk3/SgtukTOkH1UOJNNZGzcEjdSB8HxbSjeXdUKl9ap0SMP6cWc4xomr/J2VJ
 25din1KnMTqW/sEGLQkFjwnUxY7a70aW6AL8e0Z/0m5SLj/PpHXpo72ltHNRc02YwJXL
 P9znKYN3XRQVmuZ2eBuZ3WJw5x6fwgMWexyy0MCYQisuXU8+OjIdI2omSrr7OAu25MlJ
 65rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981966; x=1718586766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MofZ8uRp4MGIF+shM0f3Ad8dOPdSi82Tdfncbe2tGpA=;
 b=L8ScIREMFJ0h6IKdvcmr/9uCok1tdDp8ECbTQhN4+uN18e4nnbRIEPITJEkC9HSVYV
 Z5M34guQr9MhGLL3M4JF1QL3NNcivOv2LFxLg2DS1qE0caxpcmEhbeQEJb8fViklZdIp
 tQuGV2kxQ49LfXi5P4OIVPQ4T+UMlNqC+xfujtRvXW3TfxwXm7I9Ml6h8lzsPhJE6Apd
 yScNACEl784dui+MYg2R43nRtxikS/9SAgnpYxIMWqU/zqdpuZAbYJmmSWIcXCDoLQiQ
 nIPZTQaxzV9cWtR95C8Wuc2VAteGgSrlrb34Vtkpwl7GOR0yjKUgEPHBrwOiDzdUvmpm
 Er3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaV9c0hcNvZwSI+RMttXPSj4xbIefWy9nk3Jx83P4xhIZjDQEbKprq/MoN3qR5uJSZnkK+haIje6I2ElBOMzIWIfy9+Q==
X-Gm-Message-State: AOJu0Yx+IisHVQ7/dvAdM3XrYomp8bBzRz/GR+dWyYb5bLGPVDm+tjFO
 0bJePlm9JewsCRFzAGlZ0dzjQxrzPzTtuZ9KcC4R1eFxru84G7wGb9Od79hRcKM=
X-Google-Smtp-Source: AGHT+IEetduDyYWNyjs3NXkkJLVQ1QGjHR/Wpyv3bSrjzQSMFhSvCPgH1AKgjqFmSI1hayI3RTjDOg==
X-Received: by 2002:a05:6830:4393:b0:6f9:bcb5:6e90 with SMTP id
 46e09a7af769-6f9bcb57488mr1529299a34.15.1717981965826; 
 Sun, 09 Jun 2024 18:12:45 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f988a89d3esm616915a34.0.2024.06.09.18.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:45 -0700 (PDT)
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
Subject: [PATCH v2 26/40] mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
Date: Sun,  9 Jun 2024 20:12:12 -0500
Message-Id: <20240610011226.4050-27-semen.protsenko@linaro.org>
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
index 901cfc635418..098468f56e87 100644
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
@@ -271,8 +284,10 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
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
@@ -293,7 +308,6 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 
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

