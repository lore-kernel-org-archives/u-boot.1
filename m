Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D966C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C430587944;
	Wed, 27 Dec 2023 09:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TE4T24Vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1E087919; Wed, 27 Dec 2023 09:24:20 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD54878F6
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d41555f9dso51553115e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665457; x=1704270257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ci4WXQjlUrchvvYkXNGXLzavD3Juuqp48rgJ1y1HNiE=;
 b=TE4T24VbJMMluCDFREH44XobYZO8zmmdXHw5jM/AGc5W3wqzqvNucolvXNh/Ofy0yK
 rsiYQgc9icjOnGbAvjtj5uFJewGKMFGoQb6j/Vm35PeFWpiVGnaILOzW1xog3D/TOKQp
 WBGKqeGLrW/zrCd+bO/upqRG9u+QG9PlDHyjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665457; x=1704270257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ci4WXQjlUrchvvYkXNGXLzavD3Juuqp48rgJ1y1HNiE=;
 b=mMH8IetYRHCcHX5fJoKE/aB1FB1U3F3z1yvj6HjyEQmLqqgIHPuK+RaYdzU7sOsgdL
 ZC0xbXs1okmtfMsJa9NRNrVd2jGUyRB+BSRP1qw4vx13v92OFhd3GlyrFSvMpYb8gtQv
 lVBlALC37NK9KXwprDnI/nM0LvbrvbzCasbGefxINmsdzSuMb0dOQDb/TH0/0HnyVLZ/
 EKmBJwHUkkeTkmVNgiZPOenABq0vM2VdmLSD1hXeXdUgOifYGPXhhU7n1LjiDdtB21sn
 wrx06eVfjGIXWn6swWarsU2rZn/gttRzVuGyush7ZuiQAumhrQvz9g/2e7PxYpz44pDl
 vWyw==
X-Gm-Message-State: AOJu0YxgW/62rwEqE37ceD2YkbNU935tL6Bl37ws9NH5lkZThvj8FXg0
 yVsZYir92KgFpX0HhcY6YYl8HFR+i4wafQN+jKeffrEqpzyc
X-Google-Smtp-Source: AGHT+IEHLs3pvHzbgR4RX+1oPocD4nblrYPvuf8Af3Qy3WUBSH3ZGO3NmZlhXDVoZS5JqRATSbds1Q==
X-Received: by 2002:a05:600c:37cb:b0:40d:5f2f:1565 with SMTP id
 m11-20020a05600c37cb00b0040d5f2f1565mr187604wmr.23.1703665457409; 
 Wed, 27 Dec 2023 00:24:17 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.org>
Subject: [PATCH 5/9] arm: at91: dts: Sort at91 rules
Date: Wed, 27 Dec 2023 08:24:01 +0000
Message-Id: <20231227082405.2202246-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227082405.2202246-1-sjg@chromium.org>
References: <20231227082405.2202246-1-sjg@chromium.org>
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

Sort the AT91 devicetree rules so they are ordered by CONFIG

Move all of the at91 rules over to use SoC-specific Kconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 73 +++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e3e030a9fb6..09465e32c0d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1179,8 +1179,6 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += keystone-k2hk-evm.dtb \
 	keystone-k2g-generic.dtb \
 	keystone-k2g-ice.dtb
 
-dtb-$(CONFIG_AT91SAM9RL) += at91sam9rlek.dtb
-
 dtb-$(CONFIG_AT91SAM9260) += \
 	at91sam9260ek.dtb \
 	at91sam9260-smartweb.dtb \
@@ -1195,12 +1193,16 @@ dtb-$(CONFIG_AT91SAM9G20) += \
 	at91sam9g20ek.dtb \
 	at91sam9g20ek_2mmc.dtb
 
-dtb-$(CONFIG_AT91SAM9M10G45) += at91sam9m10g45ek.dtb
-
 dtb-$(CONFIG_AT91SAM9G45) += \
 	at91sam9g45-corvus.dtb \
 	at91sam9g45-gurnard.dtb \
 
+dtb-$(CONFIG_AT91SAM9M10G45) += at91sam9m10g45ek.dtb
+
+dtb-$(CONFIG_AT91SAM9N12) += at91sam9n12ek.dtb
+
+dtb-$(CONFIG_AT91SAM9RL) += at91sam9rlek.dtb
+
 dtb-$(CONFIG_AT91SAM9X5) += \
 	at91sam9g25-gardena-smart-gateway.dtb \
 	at91sam9g15ek.dtb	\
@@ -1209,16 +1211,40 @@ dtb-$(CONFIG_AT91SAM9X5) += \
 	at91sam9x25ek.dtb	\
 	at91sam9x35ek.dtb
 
-dtb-$(CONFIG_SAM9X60) += \
-	at91-sam9x60_curiosity.dtb \
-	sam9x60ek.dtb
-
-dtb-$(CONFIG_AT91SAM9N12) += at91sam9n12ek.dtb
-
 dtb-$(CONFIG_AT91SAM9XE) += \
 	ethernut5.dtb \
 	usb_a9263.dtb
 
+dtb-$(CONFIG_SAMA7G5) += \
+	at91-sama7g5ek.dtb
+
+dtb-$(CONFIG_SAMA5D2) += \
+	at91-kstr-sama5d27.dtb \
+	at91-sama5d2_ptc_ek.dtb \
+	at91-sama5d2_xplained.dtb \
+	at91-sama5d27_giantboard.dtb \
+	at91-sama5d27_som1_ek.dtb   \
+	at91-sama5d27_wlsom1_ek.dtb \
+	at91-sama5d29_curiosity.dtb \
+	at91-sama5d2_icp.dtb
+
+dtb-$(CONFIG_SAMA5D3) += \
+	at91-sama5d3_xplained.dtb \
+	sama5d31ek.dtb \
+	sama5d33ek.dtb \
+	sama5d34ek.dtb \
+	sama5d35ek.dtb \
+	sama5d36ek.dtb \
+	sama5d36ek_cmp.dtb
+
+dtb-$(CONFIG_SAMA5D4) += \
+	at91-sama5d4ek.dtb \
+	at91-sama5d4_xplained.dtb
+
+dtb-$(CONFIG_SAM9X60) += \
+	at91-sam9x60_curiosity.dtb \
+	sam9x60ek.dtb
+
 dtb-$(CONFIG_TARGET_OMAP3_LOGIC) += \
 	logicpd-som-lv-35xx-devkit.dtb \
 	logicpd-som-lv-37xx-devkit.dtb \
@@ -1247,33 +1273,6 @@ dtb-$(CONFIG_TARGET_OMAP4_SDP4430) += \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb
 
-dtb-$(CONFIG_SAMA7G5) += \
-	at91-sama7g5ek.dtb
-
-dtb-$(CONFIG_SAMA5D2) += \
-	at91-kstr-sama5d27.dtb \
-	at91-sama5d2_ptc_ek.dtb \
-	at91-sama5d2_xplained.dtb \
-	at91-sama5d27_giantboard.dtb \
-	at91-sama5d27_som1_ek.dtb   \
-	at91-sama5d27_wlsom1_ek.dtb \
-	at91-sama5d29_curiosity.dtb \
-	at91-sama5d2_icp.dtb
-
-dtb-$(CONFIG_SAMA5D3) += \
-	at91-sama5d3_xplained.dtb \
-	sama5d31ek.dtb \
-	sama5d33ek.dtb \
-	sama5d34ek.dtb \
-	sama5d35ek.dtb \
-	sama5d36ek.dtb \
-	sama5d36ek_cmp.dtb
-
-dtb-$(CONFIG_SAMA5D4) += \
-	at91-sama5d4ek.dtb \
-	at91-sama5d4_xplained.dtb \
-	at91-vinco.dtb
-
 dtb-$(CONFIG_ARCH_BCM283X) += \
 	bcm2835-rpi-a.dtb \
 	bcm2835-rpi-a-plus.dtb \
-- 
2.34.1

