Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18E8C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B48C878FA;
	Wed, 27 Dec 2023 09:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i2tZuzcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525EA87661; Wed, 27 Dec 2023 09:24:19 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64834878C1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d5ab2f9f1so11075125e9.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665456; x=1704270256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjACThfoG+oKZE6ZBcCk/4ypnVMwXQXHmEMQZDq4J4E=;
 b=i2tZuzcQknD2zYqlauLmwgayMOOtJJ7frgLmzoJT/x65zrBEorE41gEaYyFBOpxTcK
 IYjhcQm2wODVvvanlTFE7fRef3RW4rjzX2Id2jNGnOuyGKlWsYQDDVdDD3QXdeWaYlbk
 SdIZWc3lcAyK0rXQ3uHoBQr3bYfvPGbR7ztGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665456; x=1704270256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjACThfoG+oKZE6ZBcCk/4ypnVMwXQXHmEMQZDq4J4E=;
 b=GKqAiOku8TvBiGD+dSjhcfXzhGlMD6dSOKeM9yElv5TOeqAl1iCkADOWrKEPb+QifT
 CzMvLhxhapxl70qBZXYY0DA7GejwxVK08akrDWQs8/i7EIgK+BzTc/7gYQnHgb72Lrpq
 9KejELxP85EYcZ8eF8pw1dALnqzbX15UlKbtzPAyBN9d3urAMVB2cB1Y+YrSKyTTQCPG
 hzxwB0IbH1I0CfPqU6PzFEUgHHCfMmOzsAIlqAx/ZibXpqmWD6d9V1M0QVfFzjc/RdUV
 DQZt6BxwecGv3T8x8lSMk60Lw9J/EZbxmyP4956nm3lELxj9rKuiwuBCtNCj09OAJelH
 QKoQ==
X-Gm-Message-State: AOJu0YydxvgbBoJyA53k1ej0FFFv8mfEINvbJ6F9OMfsl/uJSNRKpNJR
 hkZVy9UcPWLS2aMpwxfPtCeg5+h6QB5adXbn1dYe6hu5m9Ac
X-Google-Smtp-Source: AGHT+IECqq+iJwJk2VNuEiF0PRH1x/RnrOKrBv/q9nFEWT8o9pepjZ+/IXG+XRfQfqucKaETg7ScIg==
X-Received: by 2002:a05:600c:5022:b0:40d:5c14:baec with SMTP id
 n34-20020a05600c502200b0040d5c14baecmr577374wmr.264.1703665456793; 
 Wed, 27 Dec 2023 00:24:16 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.org>
Subject: [PATCH 4/9] arm: at91: dts: Complete conversion of dts build rules
Date: Wed, 27 Dec 2023 08:24:00 +0000
Message-Id: <20231227082405.2202246-5-sjg@chromium.org>
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

Move all of the at91 rules over to use SoC-specific Kconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 92 ++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 59 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d8af3c26b27..e3e030a9fb6 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-$(CONFIG_TARGET_SMARTWEB) += at91sam9260-smartweb.dtb
-dtb-$(CONFIG_TARGET_TAURUS) += at91sam9g20-taurus.dtb
-dtb-$(CONFIG_TARGET_CORVUS) += at91sam9g45-corvus.dtb
-dtb-$(CONFIG_TARGET_GURNARD) += at91sam9g45-gurnard.dtb
-
 dtb-$(CONFIG_TARGET_SMDKC100) += s5pc1xx-smdkc100.dtb
 dtb-$(CONFIG_TARGET_S5P_GONI) += s5pc1xx-goni.dtb
 dtb-$(CONFIG_ARCH_EXYNOS4) += exynos4210-origen.dtb \
@@ -1184,48 +1179,45 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += keystone-k2hk-evm.dtb \
 	keystone-k2g-generic.dtb \
 	keystone-k2g-ice.dtb
 
-dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
-
-dtb-$(CONFIG_TARGET_PM9261) += at91sam9261ek.dtb
-
-dtb-$(CONFIG_TARGET_PM9263) += at91sam9263ek.dtb
-
-dtb-$(CONFIG_TARGET_MEESC) += at91sam9263ek.dtb
-
-dtb-$(CONFIG_TARGET_AT91SAM9263EK) += at91sam9263ek.dtb
-
-dtb-$(CONFIG_TARGET_AT91SAM9RLEK) += at91sam9rlek.dtb
+dtb-$(CONFIG_AT91SAM9RL) += at91sam9rlek.dtb
 
 dtb-$(CONFIG_AT91SAM9260) += \
+	at91sam9260ek.dtb \
+	at91sam9260-smartweb.dtb \
 	at91sam9260ek.dtb
 
+dtb-$(CONFIG_AT91SAM9261) += at91sam9261ek.dtb
+
+dtb-$(CONFIG_AT91SAM9263) += at91sam9263ek.dtb
+
 dtb-$(CONFIG_AT91SAM9G20) += \
+	at91sam9g20-taurus.dtb \
 	at91sam9g20ek.dtb \
 	at91sam9g20ek_2mmc.dtb
 
 dtb-$(CONFIG_AT91SAM9M10G45) += at91sam9m10g45ek.dtb
 
-dtb-$(CONFIG_TARGET_PM9G45) += at91sam9m10g45ek.dtb
+dtb-$(CONFIG_AT91SAM9G45) += \
+	at91sam9g45-corvus.dtb \
+	at91sam9g45-gurnard.dtb \
 
-dtb-$(CONFIG_TARGET_AT91SAM9X5EK) += \
+dtb-$(CONFIG_AT91SAM9X5) += \
+	at91sam9g25-gardena-smart-gateway.dtb \
 	at91sam9g15ek.dtb	\
 	at91sam9g25ek.dtb	\
 	at91sam9g35ek.dtb	\
 	at91sam9x25ek.dtb	\
 	at91sam9x35ek.dtb
 
-dtb-$(CONFIG_TARGET_SAM9X60EK) += sam9x60ek.dtb
-
-dtb-$(CONFIG_TARGET_SAM9X60_CURIOSITY) += at91-sam9x60_curiosity.dtb
-
-dtb-$(CONFIG_TARGET_AT91SAM9N12EK) += at91sam9n12ek.dtb
+dtb-$(CONFIG_SAM9X60) += \
+	at91-sam9x60_curiosity.dtb \
+	sam9x60ek.dtb
 
-dtb-$(CONFIG_TARGET_GARDENA_SMART_GATEWAY_AT91SAM) += \
-	at91sam9g25-gardena-smart-gateway.dtb
+dtb-$(CONFIG_AT91SAM9N12) += at91sam9n12ek.dtb
 
-dtb-$(CONFIG_TARGET_ETHERNUT5) += ethernut5.dtb
-
-dtb-$(CONFIG_TARGET_USB_A9263) += usb_a9263.dtb
+dtb-$(CONFIG_AT91SAM9XE) += \
+	ethernut5.dtb \
+	usb_a9263.dtb
 
 dtb-$(CONFIG_TARGET_OMAP3_LOGIC) += \
 	logicpd-som-lv-35xx-devkit.dtb \
@@ -1255,32 +1247,21 @@ dtb-$(CONFIG_TARGET_OMAP4_SDP4430) += \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb
 
-dtb-$(CONFIG_TARGET_SAMA7G5EK) += \
+dtb-$(CONFIG_SAMA7G5) += \
 	at91-sama7g5ek.dtb
 
-dtb-$(CONFIG_TARGET_SAMA5D2_PTC_EK) += \
-	at91-sama5d2_ptc_ek.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D2_XPLAINED) += \
-	at91-sama5d2_xplained.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D27_SOM1_EK) += \
+dtb-$(CONFIG_SAMA5D2) += \
+	at91-kstr-sama5d27.dtb \
+	at91-sama5d2_ptc_ek.dtb \
+	at91-sama5d2_xplained.dtb \
+	at91-sama5d27_giantboard.dtb \
 	at91-sama5d27_som1_ek.dtb   \
-	at91-sama5d27_giantboard.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D27_WLSOM1_EK) += \
-	at91-sama5d27_wlsom1_ek.dtb
-
-dtb-$(CONFIG_TARGET_KSTR_SAMA5D27) += \
-	at91-kstr-sama5d27.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D2_ICP) += \
+	at91-sama5d27_wlsom1_ek.dtb \
+	at91-sama5d29_curiosity.dtb \
 	at91-sama5d2_icp.dtb
 
-dtb-$(CONFIG_TARGET_SAMA5D29_CURIOSITY) += \
-	at91-sama5d29_curiosity.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D3XEK) += \
+dtb-$(CONFIG_SAMA5D3) += \
+	at91-sama5d3_xplained.dtb \
 	sama5d31ek.dtb \
 	sama5d33ek.dtb \
 	sama5d34ek.dtb \
@@ -1288,16 +1269,9 @@ dtb-$(CONFIG_TARGET_SAMA5D3XEK) += \
 	sama5d36ek.dtb \
 	sama5d36ek_cmp.dtb
 
-dtb-$(CONFIG_TARGET_SAMA5D3_XPLAINED) += \
-	at91-sama5d3_xplained.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D4EK) += \
-	at91-sama5d4ek.dtb
-
-dtb-$(CONFIG_TARGET_SAMA5D4_XPLAINED) += \
-	at91-sama5d4_xplained.dtb
-
-dtb-$(CONFIG_TARGET_VINCO) += \
+dtb-$(CONFIG_SAMA5D4) += \
+	at91-sama5d4ek.dtb \
+	at91-sama5d4_xplained.dtb \
 	at91-vinco.dtb
 
 dtb-$(CONFIG_ARCH_BCM283X) += \
-- 
2.34.1

