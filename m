Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307ECC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB35186968;
	Sun,  3 Sep 2023 22:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E5lsSkEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 382A286968; Sun,  3 Sep 2023 22:57:14 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E2E186986
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so1000955a12.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774630; x=1694379430;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1RPpRbwLYLmiDOJCnvll8cHjwgzBnbrRZMoEXzS4is=;
 b=E5lsSkEQtDRHK2SZQ3I6qcVOjClSQ58lp8idyxQILkGm+Jt/FR9A8dqm6j4EB2T/uW
 ZHQdI+TQtlhquB8+37M94xNWssjlhWdY25xTmBYrWjqJp/YvfzDsYjFvHTkZHapGQDpA
 Uo0po47y4ZUe0lMN3AVwcHhy6j4BQS/ecoj68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774630; x=1694379430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1RPpRbwLYLmiDOJCnvll8cHjwgzBnbrRZMoEXzS4is=;
 b=l2jNJAtjJ+125l9cQug77VMvzzk5/+o4dfyKsQvhO6QFMt/1cCvJ7TyHpo5WCcvxT9
 1z9YiKhgIEoTnCYEmwsUC9RvpO+CfykmU9oxiHsoWBcQ/ugPIWK3PfmCwcnGq5k87xsD
 fZdLvbKCBlQto0hid0ADXIMJvPJ11fDIET1/2eHKFs1HL7A71Iqy2RDOjeptd8aus5c3
 WDiQqJFg7wqxUYpcj5gY2bKuK1vlweOMSYpdgaTwi2jfIR+duwoy0HpxnVE4msb2p4Td
 MA3DQeuEQRV6MBWctYC61UDAiZl0/qKufYlHReF/tPkGbtaAemcfAnJMhOpTJzMXyNFo
 mzyA==
X-Gm-Message-State: AOJu0YyuLjuWY9+klFNfNXBRPOWWOCN6q2opYqgpGYjAANLI39SmY7Yn
 ZBlImT2c+cLjo5+oPbQf7Ko+Ijq7/nb58o6jCvBing==
X-Google-Smtp-Source: AGHT+IHypxVhiAGnkpk08S/ROGZ5ryeVoo5AiA2tR2rhI4Ob1jUvkT97Hl1LMmfspZtnEk19pIY/hA==
X-Received: by 2002:aa7:d9c7:0:b0:523:3631:876c with SMTP id
 v7-20020aa7d9c7000000b005233631876cmr5847881eds.18.1693774630676; 
 Sun, 03 Sep 2023 13:57:10 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d9d6000000b0052568bf9411sm4850232eds.68.2023.09.03.13.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:57:10 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 4/5] ARM: dts: stm32: support display on stm32f469-disco
 board
Date: Sun,  3 Sep 2023 22:57:02 +0200
Message-Id: <20230903205703.662080-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
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

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  4 +++
 configs/stm32f469-discovery_defconfig    | 13 +++++++++
 drivers/video/stm32/stm32_ltdc.c         | 37 +++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

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
index 35d18d58be6f..9796b8f2d9a5 100644
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
index f48badc517a8..428b0addc43c 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -494,6 +494,34 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
 	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
 }
 
+#if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
+static int stm32_ltdc_get_fb_addr(struct udevice *dev, ulong *base, uint size,
+				  uint align)
+{
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
+	*base = bus + 0x1000000 - ALIGN(size, align);
+	return 0;
+}
+#else
+static int stm32_ltdc_get_fb_addr(struct udevice *dev, ulong *base, uint size,
+				  uint align)
+{
+	/* Delegate framebuffer allocation to video-uclass */
+	*base = 0;
+	return 0;
+}
+#endif
+
 static int stm32_ltdc_probe(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
@@ -504,7 +532,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	struct display_timing timings;
 	struct clk pclk;
 	struct reset_ctl rst;
-	ulong rate;
+	ulong rate, fb_base;
 	int ret;
 
 	priv->regs = dev_read_addr_ptr(dev);
@@ -604,6 +632,13 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	priv->crop_h = timings.vactive.typ;
 	priv->alpha = 0xFF;
 
+	ret = stm32_ltdc_get_fb_addr(dev, &fb_base, uc_plat->size,
+				     uc_plat->align);
+	if (ret)
+		return ret;
+
+	uc_plat->base = fb_base;
+
 	dev_dbg(dev, "%dx%d %dbpp frame buffer at 0x%lx\n",
 		timings.hactive.typ, timings.vactive.typ,
 		VNBITS(priv->l2bpp), uc_plat->base);
-- 
2.34.1

