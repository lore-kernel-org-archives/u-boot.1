Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ADAC47258
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 01:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECAC4879FB;
	Wed, 24 Jan 2024 02:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQqnwAMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC6687A23; Wed, 24 Jan 2024 02:55:14 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B001D8795B
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 02:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d720c7fc04so28033795ad.2
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 17:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706061310; x=1706666110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RDbS5jjTb5xR7vUqyhKaViIHkey6De3s3s/PtA5a5mM=;
 b=DQqnwAMhXjk9M4W02taqq9TafSROgqqVsXAGybJfPY8F/yaJAZ30Lb/4+ceopv4Poi
 jPCZ1nkHQnXf+8FZe9tE4jqsuLiy/tkgsAxaBF2Gn9a244T/NYxdVu6T1SgVBnHAIh1t
 hHa0tzW0D7of840r1huBpM9Gkw7O5UHpzPoSb+VDAkyjLQIPV3K0Xa1inS9bHCW2rKcZ
 JeIdXCW7E4ohrUY4okJiH2w9CVGrwjjYcbasTCrW7w2bTBxMrZ138YSmqOmj66XAC+Gf
 j1hI5L9E7kgIn3OY6+mb4nsvXMp6tukIOCb2FuMsKb2jdBCIYynk88X3VbkZ5KhCB+pe
 ClGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706061310; x=1706666110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDbS5jjTb5xR7vUqyhKaViIHkey6De3s3s/PtA5a5mM=;
 b=fxopKmLTOSH2/mYccIzXXTJKtqbtqm9cmInl9p9J3WVKHu5E2j3Z0yUrHc9KBmNrwR
 DoQadNIheDg3uK9qfnyds3jxW4U2wKFnOrpvVxi8d67H8KM4TQbZW1w4kax3E8gPPIBI
 YbdwZy8JhRsEDmzEc9MOVdk8U03Mf9vPiFoCvkZjUrur3W5fWWkdu9RNSulp39qHCKau
 a3zgr2lBk7cCAlC9X6VSj8ECzNCvV2YNtrdQTZgSD+E2nEGSaYAu7CXqnzjGhnACNn5G
 pWnduta4LVII1Z6e+K0lEyCP31dpUvfI3CEcfqfi1AO28MKuW63kSSvLMYHoXJx3m4Qt
 lP5Q==
X-Gm-Message-State: AOJu0YzAk58hie+C7E2YngL6sYIhfxAzVAkxR0LJeCZHhpfvy5Qi3h7h
 s42JJ6HKc87S3FwiBQK9EuKRWYLMvWB3/DZkxGL4KWEAClhgORFI
X-Google-Smtp-Source: AGHT+IH8oSwUV2+CzLbq/CfBUZEChQJkn3+Peis/HKbuY2QWHNmFGXGwDvp4esUwxuNNzzMmUr9hgA==
X-Received: by 2002:a17:902:ea94:b0:1d7:55e2:ebec with SMTP id
 x20-20020a170902ea9400b001d755e2ebecmr112378plb.26.1706061309875; 
 Tue, 23 Jan 2024 17:55:09 -0800 (PST)
Received: from localhost.localdomain ([180.217.145.110])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a170903304200b001d706912d1esm9290201pla.225.2024.01.23.17.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 17:55:09 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: nuvoton: modify npcm8xx reset property
Date: Wed, 24 Jan 2024 09:54:51 +0800
Message-Id: <20240124015451.1780852-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Change reset method from generic to reset driver

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi |  2 +
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi | 71 ++++++++----------------
 2 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index 1694ef8849..db7517cc9b 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/reset/nuvoton,npcm8xx-reset.h>
 
 / {
 	#address-cells = <2>;
@@ -152,6 +153,7 @@
 				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk NPCM8XX_CLK_APB5>;
 				clock-names = "clk_apb5";
+				resets = <&rstc NPCM8XX_RESET_IPSRST2 NPCM8XX_RESET_PSPI2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index 4c6d5bed44..bc047d4b44 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -20,34 +20,7 @@
 			compatible = "nuvoton,npcm845-reset", "syscon",
 				"simple-mfd";
 			reg = <0x0 0xf0801000 0x0 0xC4>;
-			rstc1: reset-controller1 {
-				compatible = "syscon-reset";
-				#reset-cells = <1>;
-				regmap = <&rstc>;
-				offset = <NPCM8XX_RESET_IPSRST1>;
-				mask = <0xFFFFFFFF>;
-			};
-			rstc2: reset-controller2 {
-				compatible = "syscon-reset";
-				#reset-cells = <1>;
-				regmap = <&rstc>;
-				offset = <NPCM8XX_RESET_IPSRST2>;
-				mask = <0xFFFFFFFF>;
-			};
-			rstc3: reset-controller3 {
-				compatible = "syscon-reset";
-				#reset-cells = <1>;
-				regmap = <&rstc>;
-				offset = <NPCM8XX_RESET_IPSRST3>;
-				mask = <0xFFFFFFFF>;
-			};
-			rstc4: reset-controller4 {
-				compatible = "syscon-reset";
-				#reset-cells = <1>;
-				regmap = <&rstc>;
-				offset = <NPCM8XX_RESET_IPSRST4>;
-				mask = <0xFFFFFFFF>;
-			};
+			#reset-cells = <2>;
 		};
 
 		clk: clock-controller@f0801000 {
@@ -70,7 +43,7 @@
 			clock-names = "stmmaceth";
 			pinctrl-names = "default";
 			pinctrl-0 = <&rg1mdio_pins>;
-			resets = <&rstc2 NPCM8XX_RESET_GMAC1>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST2 NPCM8XX_RESET_GMAC1>;
 			status = "disabled";
 		};
 
@@ -85,7 +58,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&rg2_pins
 					&rg2mdio_pins>;
-			resets = <&rstc2 NPCM8XX_RESET_GMAC2>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST2 NPCM8XX_RESET_GMAC2>;
 			status = "disabled";
 		};
 
@@ -101,7 +74,7 @@
 			pinctrl-0 = <&r1_pins
 					&r1err_pins
 					&r1md_pins>;
-			resets = <&rstc1 NPCM8XX_RESET_GMAC3>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_GMAC3>;
 			status = "disabled";
 		};
 
@@ -117,7 +90,7 @@
 			pinctrl-0 = <&r2_pins
 					&r2err_pins
 					&r2md_pins>;
-			resets = <&rstc1 NPCM8XX_RESET_GMAC4>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_GMAC4>;
 			status = "disabled";
 		};
 
@@ -125,7 +98,7 @@
 			compatible = "nuvoton,npcm845-ehci";
 			reg = <0x0 0xf0828100 0x0 0x1000>;
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstc2 NPCM8XX_RESET_USBH1>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST2 NPCM8XX_RESET_USBH1>;
 			status = "disabled";
 		};
 
@@ -133,21 +106,21 @@
 			compatible = "nuvoton,npcm845-ehci";
 			reg = <0x0 0xf082a100 0x0 0x1000>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstc4 NPCM8XX_RESET_USBH2>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST4 NPCM8XX_RESET_USBH2>;
 			status = "disabled";
 		};
 
 		ohci1: usb@f0829000 {
 			compatible = "nuvoton,npcm845-ohci";
 			reg = <0x0 0xF0829000 0x0 0x1000>;
-			resets = <&rstc2 NPCM8XX_RESET_USBH1>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST2 NPCM8XX_RESET_USBH1>;
 			status = "disabled";
 		};
 
 		ohci2: usb@f082b000 {
 			compatible = "nuvoton,npcm845-ohci";
 			reg = <0x0 0xF082B000 0x0 0x1000>;
-			resets = <&rstc4 NPCM8XX_RESET_USBH2>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST4 NPCM8XX_RESET_USBH2>;
 			status = "disabled";
 		};
 
@@ -160,21 +133,21 @@
 				compatible = "nuvoton,npcm845-usb-phy";
 				#phy-cells = <1>;
 				reg = <1>;
-				resets = <&rstc3 NPCM8XX_RESET_USBPHY1>;
+				resets = <&rstc NPCM8XX_RESET_IPSRST3 NPCM8XX_RESET_USBPHY1>;
 				status = "disabled";
 			};
 			usbphy2: usbphy@2 {
 				compatible = "nuvoton,npcm845-usb-phy";
 				#phy-cells = <1>;
 				reg = <2>;
-				resets = <&rstc3 NPCM8XX_RESET_USBPHY2>;
+				resets = <&rstc NPCM8XX_RESET_IPSRST3 NPCM8XX_RESET_USBPHY2>;
 				status = "disabled";
 			};
 			usbphy3: usbphy@3 {
 				compatible = "nuvoton,npcm845-usb-phy";
 				#phy-cells = <1>;
 				reg = <3>;
-				resets = <&rstc4 NPCM8XX_RESET_USBPHY3>;
+				resets = <&rstc NPCM8XX_RESET_IPSRST4 NPCM8XX_RESET_USBPHY3>;
 				status = "disabled";
 			};
 		};
@@ -186,7 +159,7 @@
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc3 NPCM8XX_RESET_UDC0>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST3 NPCM8XX_RESET_UDC0>;
 			status = "disable";
 		};
 
@@ -197,7 +170,7 @@
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc1 NPCM8XX_RESET_UDC1>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_UDC1>;
 			status = "disable";
 		};
 
@@ -208,7 +181,7 @@
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc1 NPCM8XX_RESET_UDC2>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_UDC2>;
 			status = "disable";
 		};
 
@@ -219,7 +192,7 @@
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc1 NPCM8XX_RESET_UDC3>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_UDC3>;
 			status = "disable";
 		};
 
@@ -230,7 +203,7 @@
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc1 NPCM8XX_RESET_UDC4>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_UDC4>;
 			status = "disable";
 		};
 
@@ -241,7 +214,7 @@
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc1 NPCM8XX_RESET_UDC5>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_UDC5>;
 			status = "disable";
 		};
 
@@ -252,7 +225,7 @@
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc1 NPCM8XX_RESET_UDC6>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST1 NPCM8XX_RESET_UDC6>;
 			status = "disable";
 		};
 
@@ -263,7 +236,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc3 NPCM8XX_RESET_UDC7>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST3 NPCM8XX_RESET_UDC7>;
 			status = "disable";
 		};
 
@@ -274,7 +247,7 @@
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc3 NPCM8XX_RESET_UDC8>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST3 NPCM8XX_RESET_UDC8>;
 			status = "disable";
 		};
 
@@ -285,7 +258,7 @@
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk NPCM8XX_CLK_SU>;
 			clock-names = "clk_usb_bridge";
-			resets = <&rstc3 NPCM8XX_RESET_UDC9>;
+			resets = <&rstc NPCM8XX_RESET_IPSRST3 NPCM8XX_RESET_UDC9>;
 			status = "disable";
 		};
 
-- 
2.25.1

