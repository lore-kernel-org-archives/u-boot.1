Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E931C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB9C8857A;
	Thu, 23 May 2024 01:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zws9xw+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7617B88549; Thu, 23 May 2024 01:31:54 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665EF884E5
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-24c39cedc7bso1818202fac.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420706; x=1717025506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBmKxrBDf465st+H7+Gf0C4x1ZTUmhYCkaUi0C7MmVI=;
 b=zws9xw+UwPVV3ns0WbcoQz3oPFcoZT372CGYBZQ1eE1JnoPacW4xSBtrnUIEI6ylyr
 gqfwh/fHUKjikqOHV2US9JMZcIOT3lz0UmM79Bdb6TaFvW0yPEvK+NE04ILYut9GurXG
 G2xtYbDHOR3uU+hioDit0L0OFcBDhHyrct5hHBx84H2nVoaW7buNrjRcLtbjSNt9KcU/
 cNeG3EAHZYMHpOIWo6lcjCSwWSzHKc0vRhCUD0x1jkLRiyX9sEUMWLpAhAhjKGyYlxj/
 7+8cz0IUugZ/S/1r9fEpoPzKBbvPunHXjsjb13YPOef0yo/oQMDh+ubilg7+qS3eE4d9
 A/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420706; x=1717025506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBmKxrBDf465st+H7+Gf0C4x1ZTUmhYCkaUi0C7MmVI=;
 b=W7UxdaL/rM5ucizoIrDqjGBHf01wMpSF/SUqR2LmsdlGcHY/svJFE+HJaFghGhAPe2
 xztB9xiCr4d3vGwenK0jHenjxRwtbr1ZZDlUcWMBbNsHa/F1gsFNJmVxOQoOfO9khGM4
 07WacMqs1mBlt/MiJFsVRBSVU3PbqSpZP7/sWs63u+SCxgib8uiLb644nBRcpGtvuX9e
 u8WFAdpUk+YR09o2WHFU3F4hkGjcZB7BRY36wZ/ehFprfFHlRBzMUhoFggkLEXLiJhtV
 JjBPCaxEBS1jBQSZwDcTCOYC74WbEm54x9lTihzvS1x2UEwYI26SZfqxFDz68GEZKU39
 kBMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzhEqWXSx/kwDvc/M7PEu/PHVHuX9PGcoPCXD26n/15/yZxfN1Pq1eQLl7TvQ7OTXVBehDmKOBbuFhhUYjFZABEgfRCA==
X-Gm-Message-State: AOJu0YwwnxyXr0Hfb1IsBQZh2NoJi/6U+BkFZwdSGRxJvY9IfRBJSkqV
 xZAsbEcqK3kNF/27iF6QcLvEw82Gdoyqr7t23XMo/Z4POZ/JiA9WnOC/asu9SRo=
X-Google-Smtp-Source: AGHT+IFhiL3i43XZQU6p+zQxmszVmEV0nnO5cLvCzl8XRyUexyM8X3athreIkuuyQLyxbk7MG66aHA==
X-Received: by 2002:a05:6870:ec91:b0:24c:4c82:4f15 with SMTP id
 586e51a60fabf-24c68b808f9mr4084989fac.24.1716420706031; 
 Wed, 22 May 2024 16:31:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f121e53cc0sm3238011a34.24.2024.05.22.16.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:45 -0700 (PDT)
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
Subject: [PATCH 12/42] mmc: dw_mmc: Replace fifoth_val property with fifo-depth
Date: Wed, 22 May 2024 18:31:05 -0500
Message-Id: <20240522233135.26835-13-semen.protsenko@linaro.org>
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

Replace fifoth_val property with its fifo-depth counterpart in all DW
MMC drivers. fifo-depth is a common property used in upstream Linux
kernel. The FIFOTH register value will be calculated using fifo-depth
value in DW MMC core (dw_mmc.c). This change reduces code duplication in
platform drivers, and pulls common FIFOTH register value calculation
into core dw_mmc driver where it belongs.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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
index 32e0e730c77b..a1f06931b7ac 100644
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
@@ -643,16 +641,23 @@ static int dwmci_set_ios(struct mmc *mmc)
 
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
index 2f849c43b129..14cb0c05cb55 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -151,8 +151,8 @@ static int do_dwmci_init(struct dwmci_host *host)
 	return exynos_dwmci_core_init(host);
 }
 
-static int exynos_dwmci_get_config(const void *blob, int node,
-				   struct dwmci_host *host,
+static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
+				   int node, struct dwmci_host *host,
 				   struct dwmci_exynos_priv_data *priv)
 {
 	int err = 0;
@@ -201,7 +201,7 @@ static int exynos_dwmci_get_config(const void *blob, int node,
 			priv->sdr_timing = DWMMC_MMC2_SDR_TIMING_VAL;
 	}
 
-	host->fifoth_val = fdtdec_get_int(blob, node, "fifoth_val", 0);
+	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 	host->bus_hz = fdtdec_get_int(blob, node, "bus_hz", 0);
 	host->div = fdtdec_get_int(blob, node, "div", 0);
 
@@ -217,8 +217,8 @@ static int exynos_dwmmc_probe(struct udevice *dev)
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
index dc0210402bd2..e0b473f3f55c 100644
--- a/drivers/mmc/hi6220_dw_mmc.c
+++ b/drivers/mmc/hi6220_dw_mmc.c
@@ -37,7 +37,7 @@ struct hi6220_dwmmc_priv_data {
 struct hisi_mmc_data {
 	unsigned int clock;
 	bool use_fifo;
-	u32 fifoth_val;
+	u32 fifo_depth;
 };
 
 static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
@@ -126,7 +126,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
 	host->mmc = &plat->mmc;
 
 	host->fifo_mode = mmc_data->use_fifo;
-	host->fifoth_val = mmc_data->fifoth_val;
+	host->fifo_depth = mmc_data->fifo_depth;
 	host->mmc->priv = &priv->host;
 	upriv->mmc = host->mmc;
 	host->mmc->dev = dev;
@@ -159,8 +159,7 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
 static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
 	.clock = 50000000,
 	.use_fifo = false,
-	// FIFO depth is 256
-	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
+	.fifo_depth = 256,
 };
 
 static const struct udevice_id hi6220_dwmmc_ids[] = {
diff --git a/drivers/mmc/nexell_dw_mmc.c b/drivers/mmc/nexell_dw_mmc.c
index 2723e4887cf7..aad848ca2825 100644
--- a/drivers/mmc/nexell_dw_mmc.c
+++ b/drivers/mmc/nexell_dw_mmc.c
@@ -187,10 +187,7 @@ static int nexell_dwmmc_probe(struct udevice *dev)
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
index ad4529d6afa8..d52ae9cb6fd8 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -139,10 +139,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
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
index 0134399e3934..4a72f41ef16f 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -82,7 +82,7 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
 	host->ioaddr = dev_read_addr_ptr(dev);
 
 	/*
-	 * If fifo-depth is unset don't set fifoth_val - we will try to
+	 * If fifo-depth is unset don't set fifo_depth - we will try to
 	 * auto detect it.
 	 */
 	ret = dev_read_u32(dev, "fifo-depth", &fifo_depth);
@@ -90,9 +90,7 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
 		if (fifo_depth < FIFO_MIN || fifo_depth > FIFO_MAX)
 			return -EINVAL;
 
-		host->fifoth_val = MSIZE(0x2) |
-				   RX_WMARK(fifo_depth / 2 - 1) |
-				   TX_WMARK(fifo_depth / 2);
+		host->fifo_depth = fifo_depth;
 	}
 
 	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index 387cb8b6b50a..f795472d10f7 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -135,8 +135,8 @@ static int socfpga_dwmmc_of_to_plat(struct udevice *dev)
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

