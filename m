Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3603C83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E469E86908;
	Sun,  3 Sep 2023 22:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B+Nsti+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9E286900; Sun,  3 Sep 2023 22:49:00 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F219800D2
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bcf2de59cso125399666b.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774136; x=1694378936;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeGBw8SoAlnOF4owog5lqgWJnNfmEVMkIxCmD9KDQRs=;
 b=B+Nsti+oDoi3y2l6eFULcT5o4849BwbHve9HozTdoz39xUhCEu6ywiFoQinrA+J5pX
 zNkBESeIHPeK/g8i8fndO+/lGSDHZ3Ogjx6teSqz9v9UZvNOfe4WXGRFDhTgFqH6YOE+
 Iprsv1F73BuxrR3dKOL88ZhiOLHLEq4qosc/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774136; x=1694378936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeGBw8SoAlnOF4owog5lqgWJnNfmEVMkIxCmD9KDQRs=;
 b=dWGBl29jAE0jU9hjfbeIQEwMST3GVQcqDkJRN+xVthb3c/OqL+I0UazZACU1MFNDAn
 m7V5m0xMbFf69Unca6b3j05lGDzSitflswiLm8E5JZ+jDyQnu973oE1+ngu3Y31mRmqV
 QcZ6hoeAP6ExVTZuMtoRBN65Tx/gOew98jt3t8et7uVSOHz+0OwcnGEv43zTzhNO8mXS
 2fB/e31NXYVEPmavZd1t1uQw2UIuLF1thqFID3ECvT6u7ZsQuTrPGHnz99iPnVoc64Oo
 Ip+KGJhDKyzoXwKnbQlchjpWaSqgav9Xder/4AOidEWutgQqSFxjROSOVZD7mgug37/D
 Jkdg==
X-Gm-Message-State: AOJu0YznZDwyo9w4eOGRLAgayDq4yvZrmCVVQEJS+dUfdtymScOipeen
 2jSdIuGWPesXoPcImE5c+TTz9pYQCNvmD33mndC0nw==
X-Google-Smtp-Source: AGHT+IFLLzFtr1LEESWZqGn7kGrycHr5D+rwvymDG+RgkntAaPG/bKNYo4C6p5MO71WjajDpP66INw==
X-Received: by 2002:a17:906:7691:b0:9a5:c8ad:20be with SMTP id
 o17-20020a170906769100b009a5c8ad20bemr4821194ejm.4.1693774136499; 
 Sun, 03 Sep 2023 13:48:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 03/10] ARM: dts: stm32: add CAN support on stm32f746
Date: Sun,  3 Sep 2023 22:48:42 +0200
Message-Id: <20230903204849.660722-4-dario.binacchi@amarulasolutions.com>
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

commit 0920ccdf41e3078a4dd2567eb905ea154bc826e6 Linux upstream.

Add support for bxcan (Basic eXtended CAN controller) to STM32F746. The
chip contains three CAN peripherals, CAN1 and CAN2 in dual peripheral
configuration and CAN3 in single peripheral configuration:
- Dual CAN peripheral configuration:
  * CAN1: Primary bxCAN for managing the communication between a secondary
    bxCAN and the 512-byte SRAM memory.
  * CAN2: Secondary bxCAN with no direct access to the SRAM memory.
  This means that the two bxCAN cells share the 512-byte SRAM memory and
  CAN2 can't be used without enabling CAN1.
- Single CAN peripheral configuration:
  * CAN3: Primary bxCAN with dedicated Memory Access Controller unit and
    512-byte SRAM memory.

 -------------------------------------------------------------------------
| features | CAN1              | CAN2               | CAN 3               |
 -------------------------------------------------------------------------
| SRAM     | 512-byte shared between CAN1 & CAN2    | 512-byte            |
 -------------------------------------------------------------------------
| Filters  | 26 filters shared between CAN1 & CAN2  | 14 filters          |
 -------------------------------------------------------------------------

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/all/20230427204540.3126234-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

 arch/arm/dts/stm32f746.dtsi | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/dts/stm32f746.dtsi b/arch/arm/dts/stm32f746.dtsi
index c97b3d0d07db..dc5c257fb5fb 100644
--- a/arch/arm/dts/stm32f746.dtsi
+++ b/arch/arm/dts/stm32f746.dtsi
@@ -221,6 +221,23 @@
 			status = "disabled";
 		};
 
+		can3: can@40003400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40003400 0x200>;
+			interrupts = <104>, <105>, <106>, <107>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+			st,gcan = <&gcan3>;
+			status = "disabled";
+		};
+
+		gcan3: gcan@40003600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40003600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
@@ -301,6 +318,36 @@
 			status = "disabled";
 		};
 
+		can1: can@40006400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006400 0x200>;
+			interrupts = <19>, <20>, <21>, <22>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
+			st,can-primary;
+			st,gcan = <&gcan1>;
+			status = "disabled";
+		};
+
+		gcan1: gcan@40006600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40006600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
+		};
+
+		can2: can@40006800 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006800 0x200>;
+			interrupts = <63>, <64>, <65>, <66>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN2)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN2)>;
+			st,can-secondary;
+			st,gcan = <&gcan1>;
+			status = "disabled";
+		};
+
 		cec: cec@40006c00 {
 			compatible = "st,stm32-cec";
 			reg = <0x40006C00 0x400>;
-- 
2.34.1

