Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C81C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A08E88621;
	Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fZv1UzUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE2D8859B; Thu, 25 Jul 2024 22:45:34 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B8E88548
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70938328a0aso163460a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940330; x=1722545130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a40G8u2EgFrHAXbrmp88TxBHu1vZu19Kz53BjR3d9mY=;
 b=fZv1UzUKXTIS993+bXWkfm0ilAgnUpyPDPifFK3YoTO+6BXHx5NV/N5kO/ZfM2MM9F
 wTo33PcSgjM33vjycZnzqnhfpuNZPUUP1ryeNROkmTx86Ea24s+H7XR1mutwgvshYUac
 SCDov+GESFysJ5tIRk3VSnQFK6vqxIi2ebkGjrqszF3L725Eqb+qj38srtGBRyK7M1nA
 3FtcTs8KQXhDBE1G7FpnisjzxxX0a0Mn7W8dRgIukBGybGFM11eOQQY2cq7wZtUWSZVp
 FnMY/9jUlpRQbHTfXhyCpbpjPeK2bzQFjc4HlORMgQwLXMsFlRIm33mhs8b1DFwigTNH
 fh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940330; x=1722545130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a40G8u2EgFrHAXbrmp88TxBHu1vZu19Kz53BjR3d9mY=;
 b=iFUDGSgAj8qq3yNr2y+Qhv4rhFi0IoiFvMMPZGH+pup2pRmalEW3aB6d2LRdzwhxFO
 A9Gu1G9yg7WC7Ltjd16sZDGsfrKyEg9bo4b+G84d9qD4PuES48pMaNOOqa592BhG/c5X
 c0+Ycl6OC98Pb6VVm/nJNN//PjUlL7rKdBFk38sQTturIlGS6/tOPkjXjj7DcLmPTQBm
 YIMe4aMcrNxZDwVx0v9/FQDMZ9vjDMXcqjV454zJQ5xE8Fg+FyiC0KnPPtoWqpB2bvWx
 BZwzNwt63CEyymVEzhwswASBZUP5XxaDD1bNFDgT6BRFpljnxfnj2mHu56dErRtfQaMP
 HIAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCeDRgNpf2Q7Vevcvrk3otd5VYRrpnF+vQIbkOHJNW1Q+s05iLe9/aCjOEs4/VKKQcU/jCo4HkMr69AE3G5vMnRNsJaw==
X-Gm-Message-State: AOJu0Yw6rFRVS7Gvgqw5GK7FYyRsmOI9FuqLk/M9EHePMypJzkV2kT0a
 jwDhQ8+XtXkr/1vr48FcJ6HZJWFbIHFHMIrGBPxnvGjwDDAFQI8nrcRZ9oMxKrU=
X-Google-Smtp-Source: AGHT+IFInEfUD+iAsDEg4TwTV4RPSYSVyKa4eGU81JSHyIxUhfc8VnIkWoCAJEkX+dQ7D7FfM91//Q==
X-Received: by 2002:a05:6830:6993:b0:709:2fa3:1329 with SMTP id
 46e09a7af769-70932247385mr3607070a34.18.1721940330319; 
 Thu, 25 Jul 2024 13:45:30 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093050a6d9sm457584a34.9.2024.07.25.13.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:30 -0700 (PDT)
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
Subject: [PATCH v4 12/38] mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
Date: Thu, 25 Jul 2024 15:44:54 -0500
Message-Id: <20240725204520.18134-13-semen.protsenko@linaro.org>
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

Rework kernel-doc comments in dwmmc.h header so it's actually possible
to generate a proper documentation from it usin scripts/kernel-doc
script, with no errors.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 include/dwmmc.h | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/dwmmc.h b/include/dwmmc.h
index 7bb456e792b4..77c8989148a1 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -182,6 +182,7 @@ struct dwmci_idmac_regs {
  * @ioaddr:	Base I/O address of controller
  * @quirks:	Quick flags - see DWMCI_QUIRK_...
  * @caps:	Capabilities - see MMC_MODE_...
+ * @clock:	Current clock frequency (after internal divider), Hz
  * @bus_hz:	Bus speed in Hz, if @get_mmc_clk() is NULL
  * @div:	Arbitrary clock divider value for use by controller
  * @dev_index:	Arbitrary device index for use by controller
@@ -190,6 +191,10 @@ struct dwmci_idmac_regs {
  * @fifo_depth:	Depth of FIFO, bytes (or 0 for automatic detection)
  * @mmc:	Pointer to generic MMC structure for this device
  * @priv:	Private pointer for use by controller
+ * @clksel:	(Optional) Platform function to run when speed/width is changed
+ * @board_init:	(Optional) Platform function to run on init
+ * @cfg:	Internal MMC configuration, for !CONFIG_BLK cases
+ * @fifo_mode:	Use FIFO mode (not DMA) to read and write data
  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not
  * @regs:	Registers that can vary for different DW MMC block versions
  */
@@ -210,9 +215,12 @@ struct dwmci_host {
 
 	int (*clksel)(struct dwmci_host *host);
 	void (*board_init)(struct dwmci_host *host);
-
 	/**
-	 * Get / set a particular MMC clock frequency
+	 * @get_mmc_clk: (Optional) Platform function to get/set a particular
+	 * MMC clock frequency
+	 *
+	 * @host:	DWMMC host
+	 * @freq:	Frequency the host is trying to achieve
 	 *
 	 * This is used to request the current clock frequency of the clock
 	 * that drives the DWMMC peripheral. The caller will then use this
@@ -220,16 +228,12 @@ struct dwmci_host {
 	 * required MMC bus clock frequency. If you want to handle the
 	 * clock external to DWMMC, use @freq to select the frequency and
 	 * return that value too. Then DWMMC will put itself in bypass mode.
-	 *
-	 * @host:	DWMMC host
-	 * @freq:	Frequency the host is trying to achieve
 	 */
 	unsigned int (*get_mmc_clk)(struct dwmci_host *host, uint freq);
 #ifndef CONFIG_BLK
 	struct mmc_config cfg;
 #endif
 
-	/* use fifo mode to read and write data */
 	bool fifo_mode;
 	bool dma_64bit_address;
 	const struct dwmci_idmac_regs *regs;
@@ -267,6 +271,10 @@ static inline u8 dwmci_readb(struct dwmci_host *host, int reg)
 #ifdef CONFIG_BLK
 /**
  * dwmci_setup_cfg() - Set up the configuration for DWMMC
+ * @cfg:	Configuration structure to fill in (generally &plat->mmc)
+ * @host:	DWMMC host
+ * @max_clk:	Maximum supported clock speed in Hz (e.g. 150000000)
+ * @min_clk:	Minimum supported clock speed in Hz (e.g. 400000)
  *
  * This is used to set up a DWMMC device when you are using CONFIG_BLK.
  *
@@ -291,28 +299,23 @@ static inline u8 dwmci_readb(struct dwmci_host *host, int reg)
  *	struct rockchip_mmc_plat *plat = dev_get_plat(dev);
  *
  * See rockchip_dw_mmc.c for an example.
- *
- * @cfg:	Configuration structure to fill in (generally &plat->mmc)
- * @host:	DWMMC host
- * @max_clk:	Maximum supported clock speed in HZ (e.g. 150000000)
- * @min_clk:	Minimum supported clock speed in HZ (e.g. 400000)
  */
 void dwmci_setup_cfg(struct mmc_config *cfg, struct dwmci_host *host,
 		u32 max_clk, u32 min_clk);
 
 /**
  * dwmci_bind() - Set up a new MMC block device
+ * @dev:	Device to set up
+ * @mmc:	Pointer to mmc structure (normally &plat->mmc)
+ * @cfg:	Empty configuration structure (generally &plat->cfg). This is
+ *		normally all zeroes at this point. The only purpose of passing
+ *		this in is to set mmc->cfg to it.
  *
  * This is used to set up a DWMMC block device when you are using CONFIG_BLK.
  * It should be called from your driver's bind() method.
  *
  * See rockchip_dw_mmc.c for an example.
  *
- * @dev:	Device to set up
- * @mmc:	Pointer to mmc structure (normally &plat->mmc)
- * @cfg:	Empty configuration structure (generally &plat->cfg). This is
- *		normally all zeroes at this point. The only purpose of passing
- *		this in is to set mmc->cfg to it.
  * Return: 0 if OK, -ve if the block device could not be created
  */
 int dwmci_bind(struct udevice *dev, struct mmc *mmc, struct mmc_config *cfg);
@@ -320,12 +323,12 @@ int dwmci_bind(struct udevice *dev, struct mmc *mmc, struct mmc_config *cfg);
 #else
 /**
  * add_dwmci() - Add a new DWMMC interface
+ * @host:	DWMMC host structure
+ * @max_clk:	Maximum supported clock speed in Hz (e.g. 150000000)
+ * @min_clk:	Minimum supported clock speed in Hz (e.g. 400000)
  *
  * This is used when you are not using CONFIG_BLK. Convert your driver over!
  *
- * @host:	DWMMC host structure
- * @max_clk:	Maximum supported clock speed in HZ (e.g. 150000000)
- * @min_clk:	Minimum supported clock speed in HZ (e.g. 400000)
  * Return: 0 if OK, -ve on error
  */
 int add_dwmci(struct dwmci_host *host, u32 max_clk, u32 min_clk);
-- 
2.39.2

