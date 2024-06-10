Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44CBC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7683884FA;
	Mon, 10 Jun 2024 03:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ubX/BJg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E9588413; Mon, 10 Jun 2024 03:12:40 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A8F88468
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-254c56efe06so266310fac.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981956; x=1718586756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UrEdzZheG5Be/mwPYH3VZWShK99VOgRMzabo5T8EoM=;
 b=ubX/BJg52MDm0yMhk9jUw+pEmD6l2+Om2K4hXba6M7i2adWSw/Rt9xl189tLL6X5Mw
 ratshDVIgFF6blzYuPMjOKsuR11AvB/EfhZ2jJBRCjBrrIMHNmKV9TyBwqajFUvk1so0
 +aRRvL8P56Cd63EkgGiGSoBHYLgFpNVQM1FAtxsZwAgAKNrbigZleaFJFCcfdaJtAqt/
 LIZJpRSoFE981Nw/epBN5K/NXybsTn/0vwTkKMKn5nQjT8UXsPdKE7wqYwy7EHb5SfL5
 CKGpnEqYJdBGI5cM9+SUYInlNpKnN46IVoUPpe6lA/LfZvZWgGnVXYRY6Yen9bZrcugD
 O65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981956; x=1718586756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UrEdzZheG5Be/mwPYH3VZWShK99VOgRMzabo5T8EoM=;
 b=L2har0VvzAouFVzX2ZWqcy9ba93lsQlNiaXT4FGkV/clz1kbwqd7FeaP9IEpOjdU41
 +NycxO4qb6Z6P76Zz6mKyJ0aLWEg/Rwm78+56QGS2gUl02lGJFS2A0JakrwCnYTXowib
 h7a2cTutcxQstwJGUBvq1y5CiqKtPiiuqHln+v7vMSPOnm8Qp5sKQYEqsAKQgDYKPf+C
 0gc0RLABaPcCwfnTV9fpKsgvqZn205+wJhIHNBna4lMSg//5RUvVC1AXka0G1X3HLwQb
 hKZBSoniY+qULjFhw9mG2D9WnRdlggMi2vTHkOjVJC3fkL2uUovNOZ7Ot4xThAMzhjq7
 GJ9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/mCbotgSpbLejalGJLsIJyA2UQ04TnV6jYSlVz7MrQcSKKORdZcnRBjl9IFIltZUMywDisbG7WyH69u8nWV+mEOu5lA==
X-Gm-Message-State: AOJu0YwGhZmRit9f3Vvr4dLW4KZOdFuZtrKsSSCZ/OWFDOWlM/Z+3FwH
 JFbps0ScfFYyRmu1jZkQYDhWRP18tUlbm3iYnU9gz6ZvbHlD7jW0sIiX1+OU1s8=
X-Google-Smtp-Source: AGHT+IHRiVLTqTz3vX32GW8qXfsjZOiArL3iZCFWPtq91OL9cocPGvDPBrVjmdW6l4zWHpyFL3N3JA==
X-Received: by 2002:a05:6870:ae81:b0:24f:d9b2:b4a with SMTP id
 586e51a60fabf-25464443e36mr8674419fac.10.1717981956013; 
 Sun, 09 Jun 2024 18:12:36 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254bf960c44sm392364fac.37.2024.06.09.18.12.35
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
Subject: [PATCH v2 13/40] mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
Date: Sun,  9 Jun 2024 20:11:59 -0500
Message-Id: <20240610011226.4050-14-semen.protsenko@linaro.org>
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

