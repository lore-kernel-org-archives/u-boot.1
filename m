Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B3EE95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 15:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC4D86D48;
	Sun,  8 Oct 2023 17:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iEV2rtSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B6A286A3C; Sun,  8 Oct 2023 17:46:07 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A5E86CF4
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 17:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a645e54806so643845866b.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696779962; x=1697384762;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fY6FlJfVNoPy6YrmmBZZaj6Y9r9HCEihc5HK1yFhXQQ=;
 b=iEV2rtSHlLSDmzNUFWXE2MoRtTZlCzclS6Wfue9L8q3veZfRqeG82o2A2UwO0Gl4tX
 /2FO8770tkeuc3+ghEHRoxO5F6JItHh2fsS99zUu9O0TPcHOl/OU2CS59Rfp8BTgM0Gh
 kJE3JR9sA0jRSf4f/ieln1clzHOOfhrJJ+6Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696779962; x=1697384762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fY6FlJfVNoPy6YrmmBZZaj6Y9r9HCEihc5HK1yFhXQQ=;
 b=C+GV0HzQo7kcHNxPSeU3JpRJgtrBvdF21MCx0+hHUn1ZLptMQT7OZYz95XylI/7eA7
 55w9YvmgNrzT+f1T8aBUNgXPKThoYvm94zBNUDiXSvqol37HDqEsjY2ZDnrucwTggeS0
 XBGX54dRLOw1xMzlyJ8d2RIiHLgiDmBg8g+WMqXczF6V0QlMMJaAEgbDMTdJgIF3YSKy
 b2zzihq8zmVekgjo9yQdaJul9Xj65nWPJ9abxpe9+6dGyEk5HWbQq6T/UiRFxyn38KAJ
 zkS315Ftw1aFfqUeoyznIiV3Ba5f6qkiKnVNx2hhq6XetVBeaNOuSKrdrh/vXbd6CAr3
 Cs2A==
X-Gm-Message-State: AOJu0YzD881bWXSJiwvve/tCtpiXVjw+/emcV5RxySwSm26+K/YY+ks9
 UTQTiYUOVdkwCCcTHYkg6QnlQuB900/VF0RMDkI=
X-Google-Smtp-Source: AGHT+IFa8uy7If46bkn3X+X8IJdmXe+icpv6wVYCVOnxLTC+HAZ2rhZnjDgcispEGT4zirr8EIZhIA==
X-Received: by 2002:a17:907:7887:b0:9b2:ccd8:2d2c with SMTP id
 ku7-20020a170907788700b009b2ccd82d2cmr11653180ejc.34.1696779962307; 
 Sun, 08 Oct 2023 08:46:02 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-50-102-159.retail.telecomitalia.it. [79.50.102.159])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170906f90b00b009b9aa8fffdasm5623981ejb.131.2023.10.08.08.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 08:46:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v2 4/5] ARM: dts: stm32: support display on
 stm32f469-disco board
Date: Sun,  8 Oct 2023 17:44:56 +0200
Message-ID: <20231008154538.1622772-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
References: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
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

Add support to Orise Tech OTM8009A display on stm32f469-disco board.

It was necessary to retrieve the framebuffer address from the device tree
because the address returned by the video-uclass driver pointed to a memory
area that was not usable.

Furthermore, unlike Linux, the DSI driver requires the LTDC clock to be
properly probed. Hence, the changes made to the DSI node in
stm32f469-disco-u-boot.dtsi.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add DRAM_SIZE macro.
- Fix frame buffer allocation function so that it is backward compatible
  with boards other than the one it was introduced for (i. e. stm32f469-disco).
  Tested on stm32f469-disco and stm32mp157f-dk2 boards.

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  4 +++
 configs/stm32f469-discovery_defconfig    | 13 ++++++++++
 drivers/video/stm32/stm32_ltdc.c         | 31 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index 8e781c5a7b23..47ba9fa4a783 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -92,7 +92,9 @@
 
 &dsi {
 	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
+		 <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>,
 		 <&clk_hse>;
+	clock-names = "pclk", "px_clk", "ref";
 };
 
 &gpioa {
@@ -140,6 +142,8 @@
 };
 
 &ltdc {
+	bootph-all;
+
 	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
 };
 
diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
index 21c5498466cd..85e795e83e7d 100644
--- a/configs/stm32f469-discovery_defconfig
+++ b/configs/stm32f469-discovery_defconfig
@@ -21,6 +21,7 @@ CONFIG_CMD_GPT=y
 # CONFIG_RANDOM_UUID is not set
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
@@ -40,3 +41,15 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_STM32_QSPI=y
+CONFIG_VIDEO=y
+CONFIG_BACKLIGHT_GPIO=y
+CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
+CONFIG_VIDEO_STM32=y
+CONFIG_VIDEO_STM32_DSI=y
+CONFIG_VIDEO_STM32_MAX_XRES=480
+CONFIG_VIDEO_STM32_MAX_YRES=800
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 6fd90e33919d..9054db1d78b3 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -495,6 +495,33 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
 	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
 }
 
+#if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
+static int stm32_ltdc_alloc_fb(struct udevice *dev)
+{
+#define SDRAM_SIZE 0x1000000 /* 128Mbit = 16 Mbyte = 0x1000000 */
+	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	phys_addr_t cpu;
+	dma_addr_t bus;
+	u64 dma_size;
+	int ret;
+
+	ret = dev_get_dma_range(dev, &cpu, &bus, &dma_size);
+	if (ret) {
+		dev_err(dev, "failed to get dma address\n");
+		return ret;
+	}
+
+	uc_plat->base = bus + SDRAM_SIZE - ALIGN(uc_plat->size, uc_plat->align);
+	return 0;
+}
+#else
+static inline int stm32_ltdc_alloc_fb(struct udevice *dev)
+{
+	/* Delegate framebuffer allocation to video-uclass */
+	return 0;
+}
+#endif
+
 static int stm32_ltdc_probe(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
@@ -605,6 +632,10 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	priv->crop_h = timings.vactive.typ;
 	priv->alpha = 0xFF;
 
+	ret = stm32_ltdc_alloc_fb(dev);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "%dx%d %dbpp frame buffer at 0x%lx\n",
 		timings.hactive.typ, timings.vactive.typ,
 		VNBITS(priv->l2bpp), uc_plat->base);
-- 
2.42.0

