Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE127C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141B188556;
	Thu, 23 May 2024 01:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ADdraYum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8636F88540; Thu, 23 May 2024 01:31:52 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901DC8850E
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c9d70d93dbso2644449b6e.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420707; x=1717025507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UrEdzZheG5Be/mwPYH3VZWShK99VOgRMzabo5T8EoM=;
 b=ADdraYum2jmfSbh+lBP09lE8BDuIxYomGlVq7rdbaOvhnW0feCCH5Ow88TRgzvwZVw
 kc99UJYTYQtelWUJOv3soKJNkcrKLyCQ24cOTdhTuHXpHGtrbX7AWsWuusYkelAtgqli
 liEOTEW3dYmIWLcakWCwhOravP6g7EZTuQjXStOC145BgaNL7UWYGZwm16RKPxbM1uXv
 STteKSgt0X/H5aX96Yt9vhLQnj5N613PTvZN9Th6HS0/Ft8q2rRBrN9sK2lJz2dWlKol
 KP9f4ZcZvDnrvAf3kPuzS9BfwdrFY+MC3MvU2++VctN1iH3/yGKqU6XcjqxJYRFQhV08
 G/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420707; x=1717025507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UrEdzZheG5Be/mwPYH3VZWShK99VOgRMzabo5T8EoM=;
 b=ivTblUz8nMjxrz5vz9NLAzwuXeQK+NEqQwp0CBn6XShkO4rb2A7u5tNxoh7DWbEflN
 +9ZgP4PSTNF3qwoisBSUgmHyfehT7pAITO00zYubXy2YBVKN0wercIZ4zymJOGTIDDqo
 5DiJaQvIKP7Rg/YrzSo+GRYQBmvgBMbFspD76vWiFvjZdji5lh6n5I6dt8e2nkNFjA2A
 3XpiWxbfyLIbFi01KcKeGWUf+5KM2F9GFUz0tZGUF81iPI6q/0XWJtKX/0O8mA/J1rLO
 NsTWpPe7K3SaxzxEw5tflo+A1Xh9R4jeq9tI99rkyAS11aJCDoDB11PTAHnpY8HBuiW6
 04+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUali9vr1c3QAOnWzCHruGqJhEjjfVY4u2hkXNTLHTcLpaPmL4O/S+fL7/vZspW//RNej/pLromy1ykzh9Tj65yXYXBFw==
X-Gm-Message-State: AOJu0YxOyKUBQDZOL0ni8Y/6kZiBDSB/4NDMvKWiRGJtvfNGHb1JHnVo
 91rlY22yG3qgI3aHu0Nkr+Fhzb1jW7sfh8ZbywozZs4Y0e7rbZouiqu9muC0mco=
X-Google-Smtp-Source: AGHT+IGAoW3nh1OWj7PKUBaBM8mOjfPWgt951r1R4OX6uQa30iw/i70WepOPcWl1yU2S4RgGVtyt4Q==
X-Received: by 2002:a05:6870:d38a:b0:24c:53a6:3a2b with SMTP id
 586e51a60fabf-24c68afa132mr3700320fac.20.1716420706899; 
 Wed, 22 May 2024 16:31:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24c596e1aa3sm897568fac.52.2024.05.22.16.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:46 -0700 (PDT)
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
Subject: [PATCH 13/42] mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
Date: Wed, 22 May 2024 18:31:06 -0500
Message-Id: <20240522233135.26835-14-semen.protsenko@linaro.org>
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

Rework kernel-doc comments in dwmmc.h header so it's actually possible
to generate a proper documentation from it usin scripts/kernel-doc
script, with no errors.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

