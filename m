Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FECC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D3B88B21;
	Thu,  8 Aug 2024 05:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MhdGZVSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDD688A7A; Thu,  8 Aug 2024 05:14:57 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F03889EF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5af743b8fso301903eaf.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086894; x=1723691694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vfc42k2rGmzaMHGyVMMMb8hxPUv2/prCKnyN6JqV2UQ=;
 b=MhdGZVSU1+OeEVgLlaUHejIfbYCGCmydIRPHsCmTR3lNFFcAbKN19Jr75tiU9Gy65q
 T914ThaG/ZQOC8KUreT5P3vpND75Azlw0SvKJJxo1ydKbrbkSopPS9povOCUABqhGFJG
 icOF1ipYeySqyh5/EQxAuXhgtvoJf+u1IE5vtMwdw3udB5aOp+ENPDX4ooz4llTBTNOC
 HaiupAwIikiZkcTgVCcQpzfdKWRt0XkIkzHOv0+wKj8W1lDKkS32kjbILC3WZoEZzDpU
 kBRhJQV++FTN41AHLPfetKUJx3gbv9By/vOcG2/dcqFJHxrmJVdcCIaP6bYlqGA8e0SA
 aMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086894; x=1723691694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vfc42k2rGmzaMHGyVMMMb8hxPUv2/prCKnyN6JqV2UQ=;
 b=PEospr/AoxBqw++zsPhwqqKeVTEenanSj6GH8BMwgx6v1VndwDvHxoNwefRVdHiqGs
 dUwaneyT7J8KEXcab7S5eEOUyUb1BnrKAbEa318u07w5wh2VLgEquU189ousFy6h1mRq
 91m4uAxOBZYzd9d5SU5+3i6/O/KbzH0t/9lDvWrNmvgE8zWMNoIotPHo85aieG3SqAN9
 d3+EgCoU3+VVyNt7EhfYCTZ+pvz59jIqv6szz5z/DeK6ysOfrchPkK+L3wColfG7DmDc
 Og1BeAFlhgu290pHrHxLrPBBPe0c7y76sIA1WVM2cQyxjvNS0BAyFx3wHJvAQjkLC6Bo
 IB7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4mMDIlirTIK68py5HOD0Wftu4/Opbi9uMQ4AT3v0jJQ14t88FoM5Fo5pHGXuuQJ+0q7pq/WYgAcemvIBt8oYyOcFCOA==
X-Gm-Message-State: AOJu0YybLKdz97Ql7mmRIF6u+q5WzFRfnUwewz8mW8uTWXt0S58D6SFn
 jKYKmgwF/8/0h0Vlj5HPaoPRO+Al5rrt9akiUie3Vw7DtLtl0iwlN4tJ9Vl8OOA=
X-Google-Smtp-Source: AGHT+IGzh4f3f42DaqbkgdFElWWppBaFBcnY7feL8OgB2iBLChaYcJCELRwSoQnD9q6uNfBaB7zcxg==
X-Received: by 2002:a05:6820:2015:b0:5d8:4845:1a4e with SMTP id
 006d021491bc7-5d855757b7cmr955476eaf.0.1723086893865; 
 Wed, 07 Aug 2024 20:14:53 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d7625e9b97sm3557272eaf.34.2024.08.07.20.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:53 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 12/38] mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
Date: Wed,  7 Aug 2024 22:14:18 -0500
Message-Id: <20240808031444.9619-13-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

