Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79ADC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F1188636;
	Mon, 22 Jul 2024 19:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QTswfDU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C032088005; Mon, 22 Jul 2024 19:57:55 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBBD885C4
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70360eeb7d2so2292928a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671069; x=1722275869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aUcQOokL3xqy+2RQdZCNrjA8SK63j9nZZpmOhUjF74=;
 b=QTswfDU43Kglxw7LlOiXNCrcKkmqwjBcEyW6Oc6M3X7B7SshQaXChtN2MqCqfMiYPn
 SnnG8/Vv2en6fZBpmspbLS6rakcFX30zvT6+hPLFRMNhRwDy6L3JhsD7lCeKAWnxUcld
 D5FTxZx6jjuXt2X115OO07uuTTsafiIxU9S0xwhbvyf3ncy1Cny4rxZ5kc4vgAhNZm9d
 UfkqypU4pcPPlqiJ7Sq3U0a2/XAMWmYDP/tOQs28OZCKVWVmO26aDckBP//sThqvE1iY
 //MGDEdKm2enwguIuBTbU720UTszfm2YerkDFMuTwF+MqKLOjJt+SZS66S0zAxwx91+D
 T8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671069; x=1722275869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aUcQOokL3xqy+2RQdZCNrjA8SK63j9nZZpmOhUjF74=;
 b=bzwYeaMt4WLXvADpKYDCA08kFvD2kAFB/9C904uXCK8loNzmSQ0WB7T1BGG4I5p4vP
 JcoIIH/59L54xfv6k9ODilS6PR+7JZ7D/z6x5zJosf48A0OJ2QhwadZ+xVO5G12ceOcd
 ODRpjKxzZXy4SzmplxwJIUOF8KsiI/ah3Ft0wggDSm+qaHHTLgCZcbVwkYtpZ7on0gtK
 A/PzW+XxVLzt2I8WgYWgbiZFkk3hfaCDS7T11rgxL8avyMvsun+WQxhpnCxL6yHJYn1O
 Ooceo/KaUxIYR/fK/95n2GdIP2gvdIo5wcboKmuiCE8JiOLR5c6wjaH1yHIL9hC8vHux
 Oz+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPHQG/1E74cH6cu4rTE6QpoRm15zdNoXUGd2ytdVdo+BT7iCYU3n/sF5pQcBbGtZXOa8scgPxik072w1EAIyuZyME3Rg==
X-Gm-Message-State: AOJu0YwBxcC0kun1OPzV7nkPh4wBn7PqF5Kdezm6tsQKkIidxamm8qZ9
 NKV8mucZy04TjNfWL5paN5ByqpVPo3NsfNWPCN3jhBMS6QhLRlrMeB9a9OqzL4E=
X-Google-Smtp-Source: AGHT+IH6PoD+gw2637nIL+ROFsngyhvOvIRjwxjlWekUcXDJpy5vZY/4XXlDXyq0lyqqmHy/hWMcPQ==
X-Received: by 2002:a05:6830:6f81:b0:703:783a:dad5 with SMTP id
 46e09a7af769-709009d69b7mr12198291a34.27.1721671069537; 
 Mon, 22 Jul 2024 10:57:49 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60d73a8sm1665316a34.41.2024.07.22.10.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:49 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 11/38] mmc: dw_mmc: Replace fifoth_val property with
 fifo-depth
Date: Mon, 22 Jul 2024 12:57:13 -0500
Message-Id: <20240722175740.6985-12-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

