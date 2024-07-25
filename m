Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF05C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1DB88636;
	Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ITO6hTvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DD088548; Thu, 25 Jul 2024 22:45:34 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB73F884F4
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3daf0e73a5bso195655b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940330; x=1722545130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxAnAZ6fqQhAdImBp1oa5WKCrx2+oZt0LTxNSPanv5M=;
 b=ITO6hTvsmh41ht2UIPbmtD/cbYt41DYjgIZvfZGjsG9tutByVdCR92cktGOIeZZT7S
 Pc1aIkARRMCgBJbCfq/s4CZ6SFOZvzjFBUFHa/0XCQ2t/I7pFuWsr2Qdval4GJjo/VP6
 vYpIlv5ALfG5/TjqIDziUAQuFp6aDnfVDClR0SCsFH6OJji9pAMzPQzpmYEAsiA9FifO
 XH5MDCgMFLPatDyOfvBYAMlvtm4ljF7x9HztwlahJctNK0dal+FHYfsdlAMNbq0Pk5eP
 kWsUtBA5kRKRkt9Xht8ExbQL3z2ixjl/ehAZfTMP19/YdRoY1MskAeWz/C9fvzVQpvMF
 9yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940330; x=1722545130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxAnAZ6fqQhAdImBp1oa5WKCrx2+oZt0LTxNSPanv5M=;
 b=L1lFF2Frk7tfn8HDEQLq3QF9xX24mkAkfSaicVCgxN9/K02w4ySnooZEMOzmxOOvN3
 3yKP2+H8HIGKVKWYE1OJRdrEcN+jPuNkAaoyPCPEt/Tet83ZI/XiAG/VnE81eZwtLDQD
 wJzGYPV737+jeY1JbG05luQnNUC5AQ2CihZiIQSbcF799t+j32T7xMfJV+ufLGQPlTLG
 Hd/wHxFyU29zkbk/Nl/cwr7BlVR8ONYQbTsnYKJwa1SYLIrMmMvagM75qTkjoddxQkA+
 jjVF16vy/G1UxKpg34i4lRHvtzp0p+f6VIShP3Fgz6Tl9q7Uor0nRDc/Ycg2WrVxoeZK
 xH1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcDLK5lTbuqmkmviEh6OKyEbx8LXuYeukPSHspWoADPM2zwkeTaNEkGb+Ib6XKAm1yNDg/un2H+/jh1liQXP57KRXmVg==
X-Gm-Message-State: AOJu0YyjR4mwBVOb/jvkqGDNCwiz3mqdeIkrM5TkG4lEgQLImgCilsrg
 9KR7xW+C5748roYfE0Xd0/7otriWgu8plAhPQWao+H6S1SuLmU5Vi0OClQspa/I=
X-Google-Smtp-Source: AGHT+IGOXq/3ZLO1AOVwX3x6ZAKd72veqKQMPm52XCt+8HdddPe/CJqtKFle27J6Hz1/RrO18rZ5BA==
X-Received: by 2002:a05:6808:1883:b0:3d8:a93a:33bd with SMTP id
 5614622812f47-3db14184235mr3653248b6e.34.1721940329605; 
 Thu, 25 Jul 2024 13:45:29 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1341ebbasm431332b6e.20.2024.07.25.13.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:29 -0700 (PDT)
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
Subject: [PATCH v4 11/38] mmc: dw_mmc: Replace fifoth_val property with
 fifo-depth
Date: Thu, 25 Jul 2024 15:44:53 -0500
Message-Id: <20240725204520.18134-12-semen.protsenko@linaro.org>
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

Replace fifoth_val property with its fifo-depth counterpart in all DW
MMC drivers. fifo-depth is a common property used in upstream Linux
kernel. The FIFOTH register value will be calculated using fifo-depth
value in DW MMC core (dw_mmc.c). This change reduces code duplication in
platform drivers, and pulls common FIFOTH register value calculation
into core dw_mmc driver where it belongs.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/dw_mmc.c          | 21 +++++++++++++--------
 drivers/mmc/exynos_dw_mmc.c   | 10 +++++-----
 drivers/mmc/ftsdc010_mci.h    |  1 -
 drivers/mmc/hi6220_dw_mmc.c   |  7 +++----
 drivers/mmc/nexell_dw_mmc.c   |  5 +----
 drivers/mmc/rockchip_dw_mmc.c |  5 +----
 drivers/mmc/snps_dw_mmc.c     |  6 ++----
 drivers/mmc/socfpga_dw_mmc.c  |  4 ++--
 include/dwmmc.h               |  4 ++--
 9 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 55eb8a54f594..47dcc37c2c7c 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -218,8 +218,6 @@ static unsigned int dwmci_get_timeout(struct mmc *mmc, const unsigned int size)
 static int dwmci_data_transfer_fifo(struct dwmci_host *host,
 				    struct mmc_data *data, u32 mask)
 {
-	const u32 fifo_depth = (((host->fifoth_val & RX_WMARK_MASK) >>
-				 RX_WMARK_SHIFT) + 1) * 2;
 	const u32 int_rx = mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO);
 	const u32 int_tx = mask & DWMCI_INTMSK_TXDR;
 	int ret = 0;
@@ -254,8 +252,8 @@ static int dwmci_data_transfer_fifo(struct dwmci_host *host,
 			if (ret < 0)
 				break;
 
-			len = fifo_depth - ((len >> DWMCI_FIFO_SHIFT) &
-					    DWMCI_FIFO_MASK);
+			len = host->fifo_depth - ((len >> DWMCI_FIFO_SHIFT) &
+						  DWMCI_FIFO_MASK);
 			len = min(size, len);
 			for (i = 0; i < len; i++)
 				dwmci_writel(host, DWMCI_DATA, *buf++);
@@ -655,16 +653,23 @@ static int dwmci_set_ios(struct mmc *mmc)
 
 static void dwmci_init_fifo(struct dwmci_host *host)
 {
-	if (!host->fifoth_val) {
+	u32 fifo_thr, fifoth_val;
+
+	if (!host->fifo_depth) {
 		u32 fifo_size;
 
+		/*
+		 * Automatically detect FIFO depth from FIFOTH register.
+		 * Power-on value of RX_WMark is FIFO_DEPTH-1.
+		 */
 		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
 		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
-		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
-				   TX_WMARK(fifo_size / 2);
+		host->fifo_depth = fifo_size;
 	}
 
-	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+	fifo_thr = host->fifo_depth / 2;
+	fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_thr - 1) | TX_WMARK(fifo_thr);
+	dwmci_writel(host, DWMCI_FIFOTH, fifoth_val);
 }
 
 static void dwmci_init_dma(struct dwmci_host *host)
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index a51f762988da..377c9e6d90b9 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -150,8 +150,8 @@ static int do_dwmci_init(struct dwmci_host *host)
 	return exynos_dwmci_core_init(host);
 }
 
-static int exynos_dwmci_get_config(const void *blob, int node,
-				   struct dwmci_host *host,
+static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
+				   int node, struct dwmci_host *host,
 				   struct dwmci_exynos_priv_data *priv)
 {
 	int err = 0;
@@ -200,7 +200,7 @@ static int exynos_dwmci_get_config(const void *blob, int node,
 			priv->sdr_timing = DWMMC_MMC2_SDR_TIMING_VAL;
 	}
 
-	host->fifoth_val = fdtdec_get_int(blob, node, "fifoth_val", 0);
+	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 	host->bus_hz = fdtdec_get_int(blob, node, "bus_hz", 0);
 	host->div = fdtdec_get_int(blob, node, "div", 0);
 
@@ -216,8 +216,8 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	struct dwmci_host *host = &priv->host;
 	int err;
 
-	err = exynos_dwmci_get_config(gd->fdt_blob, dev_of_offset(dev), host,
-				      priv);
+	err = exynos_dwmci_get_config(dev, gd->fdt_blob, dev_of_offset(dev),
+				      host, priv);
 	if (err)
 		return err;
 	err = do_dwmci_init(host);
diff --git a/drivers/mmc/ftsdc010_mci.h b/drivers/mmc/ftsdc010_mci.h
index 782d92be2f5f..36187cfa04f6 100644
--- a/drivers/mmc/ftsdc010_mci.h
+++ b/drivers/mmc/ftsdc010_mci.h
@@ -28,7 +28,6 @@ struct ftsdc010_chip {
 	int dev_index;
 	int dev_id;
 	int buswidth;
-	u32 fifoth_val;
 	struct mmc *mmc;
 	void *priv;
 	bool fifo_mode;
diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
index c68a9157bfcc..0302f5c296b9 100644
--- a/drivers/mmc/hi6220_dw_mmc.c
+++ b/drivers/mmc/hi6220_dw_mmc.c
@@ -36,7 +36,7 @@ struct hi6220_dwmmc_priv_data {
 struct hisi_mmc_data {
 	unsigned int clock;
 	bool use_fifo;
-	u32 fifoth_val;
+	u32 fifo_depth;
 };
 
 static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
@@ -125,7 +125,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
 	host->mmc = &plat->mmc;
 
 	host->fifo_mode = mmc_data->use_fifo;
-	host->fifoth_val = mmc_data->fifoth_val;
+	host->fifo_depth = mmc_data->fifo_depth;
 	host->mmc->priv = &priv->host;
 	upriv->mmc = host->mmc;
 	host->mmc->dev = dev;
@@ -158,8 +158,7 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
 static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
 	.clock = 50000000,
 	.use_fifo = false,
-	// FIFO depth is 256
-	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
+	.fifo_depth = 256,
 };
 
 static const struct udevice_id hi6220_dwmmc_ids[] = {
diff --git a/drivers/mmc/nexell_dw_mmc.c b/drivers/mmc/nexell_dw_mmc.c
index 2e1ce54c7d50..80df617e07e9 100644
--- a/drivers/mmc/nexell_dw_mmc.c
+++ b/drivers/mmc/nexell_dw_mmc.c
@@ -186,10 +186,7 @@ static int nexell_dwmmc_probe(struct udevice *dev)
 	struct dwmci_host *host = &priv->host;
 	struct udevice *pwr_dev __maybe_unused;
 
-	host->fifoth_val = MSIZE(0x2) |
-		RX_WMARK(priv->fifo_size / 2 - 1) |
-		TX_WMARK(priv->fifo_size / 2);
-
+	host->fifo_depth = priv->fifo_size;
 	host->fifo_mode = priv->fifo_mode;
 
 	dwmci_setup_cfg(&plat->cfg, host, priv->max_freq, priv->min_freq);
diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 1a10b7057a47..b2a46a95481c 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -138,10 +138,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 #endif
-	host->fifoth_val = MSIZE(0x2) |
-		RX_WMARK(priv->fifo_depth / 2 - 1) |
-		TX_WMARK(priv->fifo_depth / 2);
-
+	host->fifo_depth = priv->fifo_depth;
 	host->fifo_mode = priv->fifo_mode;
 
 #if CONFIG_IS_ENABLED(MMC_PWRSEQ)
diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 9bdbe5070b1d..f30331e51f7e 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -81,7 +81,7 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
 	host->ioaddr = dev_read_addr_ptr(dev);
 
 	/*
-	 * If fifo-depth is unset don't set fifoth_val - we will try to
+	 * If fifo-depth is unset don't set fifo_depth - we will try to
 	 * auto detect it.
 	 */
 	ret = dev_read_u32(dev, "fifo-depth", &fifo_depth);
@@ -89,9 +89,7 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
 		if (fifo_depth < FIFO_MIN || fifo_depth > FIFO_MAX)
 			return -EINVAL;
 
-		host->fifoth_val = MSIZE(0x2) |
-				   RX_WMARK(fifo_depth / 2 - 1) |
-				   TX_WMARK(fifo_depth / 2);
+		host->fifo_depth = fifo_depth;
 	}
 
 	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index f738019b8357..3147d3019c0a 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -134,8 +134,8 @@ static int socfpga_dwmmc_of_to_plat(struct udevice *dev)
 	 * We only have one dwmmc block on gen5 SoCFPGA.
 	 */
 	host->dev_index = 0;
-	host->fifoth_val = MSIZE(0x2) |
-		RX_WMARK(fifo_depth / 2 - 1) | TX_WMARK(fifo_depth / 2);
+
+	host->fifo_depth = fifo_depth;
 	priv->drvsel = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
 				       "drvsel", 3);
 	priv->smplsel = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
diff --git a/include/dwmmc.h b/include/dwmmc.h
index de18fda68ac8..7bb456e792b4 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -187,7 +187,7 @@ struct dwmci_idmac_regs {
  * @dev_index:	Arbitrary device index for use by controller
  * @dev_id:	Arbitrary device ID for use by controller
  * @buswidth:	Bus width in bits (8 or 4)
- * @fifoth_val:	Value for FIFOTH register (or 0 to leave unset)
+ * @fifo_depth:	Depth of FIFO, bytes (or 0 for automatic detection)
  * @mmc:	Pointer to generic MMC structure for this device
  * @priv:	Private pointer for use by controller
  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not
@@ -204,7 +204,7 @@ struct dwmci_host {
 	int dev_index;
 	int dev_id;
 	int buswidth;
-	u32 fifoth_val;
+	u32 fifo_depth;
 	struct mmc *mmc;
 	void *priv;
 
-- 
2.39.2

