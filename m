Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92259C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9446680548;
	Mon, 10 Feb 2025 07:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ux6AUfhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D28809D4; Mon, 10 Feb 2025 07:52:14 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5FE3803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170332; x=1770706332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=juqbW6lkGrPWGrI0Zlyi3vsXED4T99xUmNRBK7fFUZg=;
 b=ux6AUfhUPm3iRV6zFvkExFvPmFhWKYf5nmGyopBPVR4FrZdg4quyTT8S
 asL8YNNV47DRUe5JGKbvD7G0GZYXvJotqzPPFKiFo2vV2fkq8xZkQx+V+
 Iu//FtDPTFLZjOgia6+/3P0miEqIjQO6YXHnjQ+sxrXSTio6GAbeQs6Pd
 Eh0uoF1+WQ20oWgOi+mpRxGtwc+YcIF9GhQbxsqHCaMe29wXugDaGyVk6
 SzcAXXpfA/s8YbDLefq4jOKgNE99uIY2nXZaFUNqq0nI1siCWEdlgq73/
 RyGE+uk8oGmrTBMkrrfudwWwKqAAYE4OPV3OeIcSjM0VzUErWk/XpZheA g==;
X-CSE-ConnectionGUID: 14CdqfAISBKFvOtfHNczmA==
X-CSE-MsgGUID: cSstTsZxROCbrK8rXb0eWg==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:52:01 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:51:59 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 4/7] ARM: dts: at91: sam9x60: Add missing pinctrl node
 properties
Date: Mon, 10 Feb 2025 12:21:40 +0530
Message-ID: <20250210065143.313553-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210065143.313553-1-manikandan.m@microchip.com>
References: <20250210065143.313553-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add the missing properties for the pinctrl node and for its
corresponding GPIO bank nodes to align with the Linux DT.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/dts/sam9x60.dtsi | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 97d9c5cefc3..2a31152a0f7 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -212,43 +212,66 @@
 			pinctrl: pinctrl@fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "microchip,sam9x60-pinctrl", "simple-bus";
+				compatible = "microchip,sam9x60-pinctrl", "simple-mfd";
 				ranges = <0xfffff400 0xfffff400 0x800>;
 				reg = <0xfffff400 0x200		/* pioA */
 				       0xfffff600 0x200		/* pioB */
 				       0xfffff800 0x200		/* pioC */
 				       0xfffffa00 0x200>;	/* pioD */
+
+				/* mux-mask corresponding to sam9x60 SoC in TFBGA228L package */
+				atmel,mux-mask = <
+						  /*     A       B       C       */
+						  0xffffffff 0xffe03fff 0xef00019d       /* pioA */
+						  0x03ffffff 0x02fc7e7f 0x00780000       /* pioB */
+						  0xffffffff 0xffffffff 0xf83fffff       /* pioC */
+						  0x003fffff 0x003f8000 0x00000000       /* pioD */
+						  >;
 			};
 
 			pioA: gpio@fffff400 {
 				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffff400 0x200>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 				#gpio-cells = <2>;
 				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 			};
 
 			pioB: gpio@fffff600 {
 				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffff600 0x200>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 				#gpio-cells = <2>;
 				gpio-controller;
+				#gpio-lines = <26>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 			};
 
 			pioC: gpio@fffff800 {
 				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffff800 0x200>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 				#gpio-cells = <2>;
 				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 			};
 
 			pioD: gpio@fffffa00 {
 				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffffa00 0x200>;
+				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 1>;
 				#gpio-cells = <2>;
 				gpio-controller;
+				#gpio-lines = <22>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
 			};
 
-- 
2.25.1

