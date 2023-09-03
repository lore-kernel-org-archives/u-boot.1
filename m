Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1194EC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909F88693D;
	Sun,  3 Sep 2023 22:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MzZsyCOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58397867E2; Sun,  3 Sep 2023 22:49:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C060868BB
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-991c786369cso125791266b.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774138; x=1694378938;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7MgzMUgLOIoOxHVOIHBX1f8KoDdp05bomfoJMS2h+Q=;
 b=MzZsyCOju45ekHdQxHWmalkgkf8HAIfEDwSy6Gvh09HQdZ5pxIfQSC7XceARWiILfO
 /ly1h7wAy5uAJW77ETUNTQ4sMhy3k6f33v842YcYGAwvmywXP4WTn4qM/j0G0BY6SlTc
 oxODMUb9Yi5oU07ozLY166ayBZY3k0wwZfID4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774138; x=1694378938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7MgzMUgLOIoOxHVOIHBX1f8KoDdp05bomfoJMS2h+Q=;
 b=lN7YemEuECi16mW9hYH4n7CWP2BonlOx9K7R0p/6TOy4fSrBLItGe85SZSJ3zKBrqy
 X0aw4buENbf/4SkNzJjBauUYBvO7/4mZzPIEg8JQWZsdH6E7YDVwIvV4HZnZFnaWnaJH
 tAIj9ymzLg9DHS7EMu8w4NCAUJGerjXcucjWUm1ezcGEyDmuzAqx9agVUyb4A3gI0AGe
 ua1NIkvDuzygXupg6H8Uuc+BN8iqA+1B9SoyRhltt0fYpzE1Bf8OF2ySGuXv9GYUcE+n
 XXgv1oDxKjuIYSPGkde/rLEtgaAdEw8/wO8KAXkPSfczbHLnxdkMJ3Y2KORpwZKYsHr4
 U8uQ==
X-Gm-Message-State: AOJu0YyclB1RY8p6gpiBjmEOV16Avufh9HMDHYWE1gi2MFJaW+UkuNPX
 2IrRDFJyfIbLUpQ8tFL1kpuFbfcBx0pVDy2bgSPbLg==
X-Google-Smtp-Source: AGHT+IFkPVaiHP4mgGp02Yh3rtCCcpTINMxvW8wPiTNv1OzzRWb3emrQJGcy3G7CrBp12ziHbWT0Pg==
X-Received: by 2002:a17:907:7751:b0:9a2:28dc:4168 with SMTP id
 kx17-20020a170907775100b009a228dc4168mr6119502ejc.61.1693774138798; 
 Sun, 03 Sep 2023 13:48:58 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 =?UTF-8?q?Rapha=C3=ABl=20Gallais-Pou?= <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 05/10] ARM: dts: stm32: add pin map for i2c3 controller on
 stm32f7
Date: Sun,  3 Sep 2023 22:48:44 +0200
Message-Id: <20230903204849.660722-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

commit 0637e66f8250c61f75042131fcb7f88ead2ad436 Linux upstream.

Add pin configurations for using i2c3 controller on stm32f7.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
---

 arch/arm/dts/stm32f7-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/stm32f7-pinctrl.dtsi b/arch/arm/dts/stm32f7-pinctrl.dtsi
index 000278ec2c58..607fe42f4f46 100644
--- a/arch/arm/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/dts/stm32f7-pinctrl.dtsi
@@ -172,6 +172,16 @@
 				};
 			};
 
+			i2c3_pins_a: i2c3-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 8, AF4)>, /* I2C3_SDA */
+						 <STM32_PINMUX('H', 7, AF4)>; /* I2C3_SCL */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
 			usbotg_hs_pins_a: usbotg-hs-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
-- 
2.34.1

