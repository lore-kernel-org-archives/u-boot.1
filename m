Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0097EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 16:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A09BA869C5;
	Sun, 20 Aug 2023 18:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Uzyp1y2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE8F86932; Sun, 20 Aug 2023 18:24:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4364586A0F
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 18:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so345189866b.3
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1692548690; x=1693153490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M+0bDMv7y1bManA0WwHVCJ4esmff4eVaMiBWsimTQ5U=;
 b=Uzyp1y2XVshpnosLXE8DqlO42t9m6CUmqnKAaP1H8cbXfIHm6b4NWDKnFuAXxvLjxi
 rL15vGkLqhwS4HODM/o6k2VSS810th6IXKdm6yU5T4thGrqVTOtgx4e6/Fomxkpllcaq
 kNxSeKuG2gtwJ9DvrkH0vu9wcB3FRPBG95JpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692548690; x=1693153490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+0bDMv7y1bManA0WwHVCJ4esmff4eVaMiBWsimTQ5U=;
 b=kWzy0qbm5d0I0Kw0DHh484QrSwMHJHTEOqWRzIBSEuR+aU9SRhIsM7qO5KcLot1b7T
 FZuRwSf3SFAqd/EijoJP4slGCCGkrhu+sO/8jdRpLqS2yYAU5aX2kt6z1iaw1kKIr4BQ
 e6m+OKfIuq71Z6opaVa4tTTDVhfhBrr0LcIxUGuZPcZ059GYCgZydtSyUVelexP549uF
 04fkQ7iQAz2C80kbVchcdcZY5aoWMFbPFCO4fcklm0xWtLpp9UB8fhdevInYmgmv3HPO
 OcQA392i8CnrcVe1e39Ruj1b/14E0gcq33YOZaxILIC/wUtnhcv8pPG4BZi/voB8GByp
 9zrQ==
X-Gm-Message-State: AOJu0YzAIvmGKtTmllV6HP6y4Le8b3mYIpLvC1ZI/XiLg3oWpmFzNgUk
 kjxDGi243/329EHYclWKm9NQXoNVm5ZmZLTu1qdv9g==
X-Google-Smtp-Source: AGHT+IF1iYCAXgnyoofnd5pgBsdPhMjFPf5hVYCl60a2NjAs0CVpL1jEUNg4Z+KZPfpJt5emsZ4ROw==
X-Received: by 2002:a17:906:315b:b0:988:9b29:5653 with SMTP id
 e27-20020a170906315b00b009889b295653mr3170869eje.77.1692548690398; 
 Sun, 20 Aug 2023 09:24:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-80-180-23-204.pool80180.interbusiness.it. [80.180.23.204])
 by smtp.gmail.com with ESMTPSA id
 sd20-20020a170906ce3400b0096f6a131b9fsm4844859ejb.23.2023.08.20.09.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 09:24:49 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 yannick fertre <yannick.fertre@st.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/3] configs: stm32f746-disco: limit resolution to 480x272
Date: Sun, 20 Aug 2023 18:24:44 +0200
Message-Id: <20230820162446.616442-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
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

The patch fixes the y-resolution, which was causing the creation of a
framebuffer larger than actually needed, resulting in memory waste.

Fixes: cc1b0e7b8e55b ("board: Add display to STM32F746 SoC discovery board")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 configs/stm32f746-disco_defconfig     | 2 +-
 configs/stm32f746-disco_spl_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/stm32f746-disco_defconfig b/configs/stm32f746-disco_defconfig
index bb98ee307a6e..8403679d7fa6 100644
--- a/configs/stm32f746-disco_defconfig
+++ b/configs/stm32f746-disco_defconfig
@@ -59,7 +59,7 @@ CONFIG_VIDEO=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_MAX_XRES=480
-CONFIG_VIDEO_STM32_MAX_YRES=640
+CONFIG_VIDEO_STM32_MAX_YRES=272
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_VIDEO_BMP_RLE8=y
diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
index 84aaec1e3390..50c2a36784af 100644
--- a/configs/stm32f746-disco_spl_defconfig
+++ b/configs/stm32f746-disco_spl_defconfig
@@ -85,7 +85,7 @@ CONFIG_VIDEO=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_MAX_XRES=480
-CONFIG_VIDEO_STM32_MAX_YRES=640
+CONFIG_VIDEO_STM32_MAX_YRES=272
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_VIDEO_BMP_RLE8=y
-- 
2.34.1

