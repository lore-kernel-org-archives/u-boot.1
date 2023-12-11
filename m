Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8693C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 22:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D847C877D7;
	Mon, 11 Dec 2023 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pL/dghcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97DD0877CC; Mon, 11 Dec 2023 23:07:04 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634D0877D7
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 23:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a00c200782dso664203566b.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702332420; x=1702937220;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZieAwOD2NNljHe77pz/k/wqxwTnG1bIiBYPuEc4BHQ=;
 b=pL/dghcZrDK/d+hidPPV8K0kPQq+T3MgTYlrVBuE6xTljLfZcaVNoaf7DYPJPXccTw
 xt9Kp6ibffvMTtAiYwgiU8FFUGOFpXPGmO88NPqG9gYGLrTxs6Lu5aWohQ0dQsVOum8X
 fwW4UmLsSispCAPKJPW48NP5kiOBT5M+2S/BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332420; x=1702937220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZieAwOD2NNljHe77pz/k/wqxwTnG1bIiBYPuEc4BHQ=;
 b=qduLGfHT4s3iKHHl8hiCt0PfF8dWnDC7V5QPZZGac+JGo+9v4HdsgSzMB1S09dYDj8
 9M6iUYqPybtwvPnw5D6nC4WUd6B+kbr2eBr0XjW3CyFqF3h7B9UDOvhYkwiI7l7CcZt4
 ghpmw0hOwjh+LMp8po5z7pziImRrPgQ7j3yiYUBOC1dINUEVp4/7DLPdgDqqlhX+rR3t
 Pbzd8oQOHz6e5DZ/Az71PR8iLVoBmeJRU+oNy+RwqMH+tZYoPAjlqLG8/kT03O/itI2W
 3zp6PgQ38sWwsPf0YBYnSehx1/X5Wm0fgDPFRHGHDw4ef1ycebkPkBnQW7J2ntZDLGGK
 PEsA==
X-Gm-Message-State: AOJu0YyJiVVXWj5xNfPXGmIfvLbHaTFATJsso/fr35t4lw1XqHOtmAnI
 yuYENAlqWAKw3YBomeBoqYmMtMk3+unPewxUKY6iWw==
X-Google-Smtp-Source: AGHT+IFj2wKp0lwxcvqay2Gf96MoWEkBLeUQef556gHD4jhkfZyv2lIXbcK6Xb7aY5POlJ3Gz//eJQ==
X-Received: by 2002:a17:907:7b82:b0:a19:d40a:d22c with SMTP id
 ne2-20020a1709077b8200b00a19d40ad22cmr1518218ejc.248.1702332420654; 
 Mon, 11 Dec 2023 14:07:00 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a170907a38d00b00a1f78048f08sm4568276ejc.146.2023.12.11.14.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 14:07:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 5/6] board: stm32f469-disco: add support to display
Date: Mon, 11 Dec 2023 23:05:55 +0100
Message-ID: <20231211220643.1073606-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
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

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v3:
- Replace SDRAM_SIZE constant with global data gd->ram_size.

Changes in v2:
- Add DRAM_SIZE macro.
- Fix frame buffer allocation function so that it is backward compatible
  with boards other than the one it was introduced for (i. e. stm32f469-disco).
  Tested on stm32f469-disco and stm32mp157f-dk2 boards.

 configs/stm32f469-discovery_defconfig | 13 +++++++++++
 drivers/video/stm32/stm32_ltdc.c      | 31 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

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
index 6fd90e33919d..4f60ba8ebeeb 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -495,6 +495,33 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
 	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
 }
 
+#if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
+static int stm32_ltdc_alloc_fb(struct udevice *dev)
+{
+	u32 sdram_size = gd->ram_size;
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
+	uc_plat->base = bus + sdram_size - ALIGN(uc_plat->size, uc_plat->align);
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
2.43.0

