Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD856C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F5D8846D;
	Mon, 10 Jun 2024 03:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bmfmN4Xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C741884BF; Mon, 10 Jun 2024 03:12:39 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7F5883DA
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-254c8e27c80so263204fac.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981955; x=1718586755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGYMSBlkj16uuveSb0a3b24lmBLhTYkV3djbSlPO19o=;
 b=bmfmN4XelCL+KR2XFgSr0iEWmjbeUltRaIFwJeJ/Ww4GNVpzj/qgoEgW6Roem7g5Ni
 PRtcGnn6TPofXAk7/PAHmLmnArC81lxZDdJbjKt69aqzQghMRqMKEVCPXlONcz6ExvtJ
 0o+Rk7pZEb+28hTBkJKJW8g3D3rukr7TH1qsjsXOFhikTh8SsuEjxG4YYZtId5+b/qbG
 Mo8SD4T7Yp49/MYtgRN4Lpf/1FZOZ403Zp50ChZn23PCLz6ZuB9T+hmtg+t1HguqlLHc
 qdc7zGIHfXH+CMPDJLgW8LMkpeOAB136wZNulu2X0ZH4xMtZqhVGVV8/CowUZz+jLIuR
 gEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981955; x=1718586755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGYMSBlkj16uuveSb0a3b24lmBLhTYkV3djbSlPO19o=;
 b=dzwLSd/PGavEUJcXRBx38kbMCTXgoOP/XdwthvsOPBJ5NHMicZR0N/8M58Z934fiHq
 y9N1VDLinNmR+wefHXXF3+uLhIsPjYoJ978/ipcQvOcVxmtfoBVS1vAhtGe7ZscD3NWg
 2u0HzSRHR0fLJc2YfScQQ5mUKLB4N1Bb1w8zyppudsCeeLZtnwAjCJvRVMPQksc8LqRp
 drOlkR5vkVBK1WhcthH2+GRt15IuV3C+f6Hn3zD+AuclY/keze76zPQ9jk5wdpQnV+9u
 7QKxkU2tSd3d5WhnTshe9bZRsNWdjAm1PAhMbnTnpj5SyInko5Jw5zn+IRFaivaW6UYp
 BV9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDiCvA2loBSG2BVCd2lc47j8J7qJPpMTLsZxtWlJI5dvWdOQBkPxvLlGxv+3DaoKQvbwsLGIyAiqSQDMEKsEyEtLge0A==
X-Gm-Message-State: AOJu0YzhdlrQ2L5rNLBzGEO0LnmvSwIuoJ6QiAVz9MLSI68dKD0TMyvG
 NTfDibeaZp6kONooQ5AH6g4rAiDhDHMTSsZbb7BiS6RmbB4FxwJzpyONp2cIeQU=
X-Google-Smtp-Source: AGHT+IHcOqBhu3oMf+i4yk6s0XBkrLF+wRR2TFkHr+29Hfrfsf2F07dNQzWSo7GHMhNupntIp0Cp9w==
X-Received: by 2002:a05:6870:a2cc:b0:254:8ca4:a18f with SMTP id
 586e51a60fabf-2548ca5a1c8mr6320497fac.29.1717981955332; 
 Sun, 09 Jun 2024 18:12:35 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254ab072356sm694925fac.53.2024.06.09.18.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:35 -0700 (PDT)
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
Subject: [PATCH v2 12/40] mmc: dw_mmc: Replace fifoth_val property with
 fifo-depth
Date: Sun,  9 Jun 2024 20:11:58 -0500
Message-Id: <20240610011226.4050-13-semen.protsenko@linaro.org>
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
index 7aa3dbbe83ad..8af665a00222 100644
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
@@ -656,16 +654,23 @@ static int dwmci_set_ios(struct mmc *mmc)
 
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

