Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C4C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961E0885CC;
	Mon, 22 Jul 2024 19:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="caFXcEmq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B770D88617; Mon, 22 Jul 2024 19:57:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769C8884AC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70445bb3811so2118796a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671070; x=1722275870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inU69zmT+ZdhaRf86kD0MC5f2+AEmq7litunUhr5UBg=;
 b=caFXcEmqFxWy5j8+1H264Un9lw0cSVZyECl5c49abrQxw1KvG9+zWuTAKsiqbKzVzT
 aDVETAYIBsbresJntQeI2S+Eo1uXB9ufoe0NS3MaH/ptTcazCrkWhu+2ZxK/XFIJ7Lkz
 8L2adG7NwiQBkR8OOGhZO6FFH+WpfdJe7jt3iTqiBhN1aLxOJ/q6ANsK6iueIPtYU+iQ
 b4guvb5GOgZIkYGTjLzGnVziDz0znfGREJm19kg5GI7hX2uGxKmccPD4huOSA0pzyRUx
 ZrujtKyn/h3MX0C01PIXMOvqnP9Uoe8Exb8iohMr8zincrTo9kEi/Uueo1kCkTdIBQgg
 AXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671070; x=1722275870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inU69zmT+ZdhaRf86kD0MC5f2+AEmq7litunUhr5UBg=;
 b=HLNSX338wRIx8zjbH2ZIcHZrFxLv1zgOtJVDCYfodKVqD39BWVMH5jnZncmIyNgTmI
 SDaxAxMaLzsn1yTRMU8vULSbIfTo/uUYeeCDgsgIoETqna7SaTSwcSIRJhf+j2cU5REV
 pRZO/IgWUB1jzd06abkjUm7vRJ2LxLt8Q22hZWcmGs1WUkMswaZKglViUhsiYgf9jyKi
 Xr/ubsnz5TAWOw2RiBUp/SeAvcIsIU7se/2a2giscQyLVLFm/pg3jQChbLt3HHFNGauk
 JjVIaQ0F+rKd1sAQrlxcXeDN9f1NETncqxUJFj8h6ivUmRXlqj135Yt2Lg4adrGDQI3v
 Srlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyCobSfg1buW+Sglq/z4th6qTiQBgR0oqas49zTgqkJwty4D4RXC4eJNaB/TJxHsy2O0tULTV0+2iN4WhVIQgujW+ZBQ==
X-Gm-Message-State: AOJu0YwHa4HUv9lOcJ3nbHj7rXQhQF3+AZKt1EaXUvUlCwMGz4QPV6yO
 ynBiP75g1VRqickxDIYL7afVWv+lNH7r3IXUfDp+a7wmKZIQLQtAxuJWn3axgf0=
X-Google-Smtp-Source: AGHT+IEYX45AwQagnUQxHdgg9LUIl7P/Vax+xLLQ9jbYFryGeVJSTqDhRPQ1YWUbA2v7gzU+B/J1bw==
X-Received: by 2002:a05:6830:dc3:b0:704:45b7:8ffc with SMTP id
 46e09a7af769-709009d29a4mr6121591a34.32.1721671070189; 
 Mon, 22 Jul 2024 10:57:50 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aad1958sm1384450eaf.35.2024.07.22.10.57.49
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
Subject: [PATCH v3 12/38] mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
Date: Mon, 22 Jul 2024 12:57:14 -0500
Message-Id: <20240722175740.6985-13-semen.protsenko@linaro.org>
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

Rework kernel-doc comments in dwmmc.h header so it's actually possible
to generate a proper documentation from it usin scripts/kernel-doc
script, with no errors.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

