Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277C1C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 10:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0C6811DF;
	Mon, 27 Jan 2025 11:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="tuGK3k/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709028118A; Mon, 27 Jan 2025 11:10:24 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0574F81191
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 11:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1152fbf31=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1737972622; x=1769508622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HXKcdSHbq3K3tUs1hFatMYyRxQwoaEDv8DLyfCeUdRY=;
 b=tuGK3k/G1fc4SjgYLdvblaRsxvvQF9N27yIl68D17Eu5vQDPRD6HUunR
 M9lm32Vf0MYOEGoiu+EebAVT2yRt1k3sLTZy3RI0Ta2fsxq/u/LOL6gTo
 SMNC5W6+4zjfMd3LBO/alQ/LENM6KuxtoMnlo+tEO+w42aZV2varSQwsg
 VRly0g+OzxJFJNayBojujfn5gxnIgKUCgYs2uobMtYqRrLvIXSL87AjUi
 ZagWshjI4eMP7a+4+Y1TJfiksAxd39Co8yppEKo3v2yMcXMYK56YEBbMr
 Br6cspYpO0bugDyOnL8IUzrBF1OF6vE2eoLgGVGYUVqY/aohf/pzv+S+D Q==;
X-CSE-ConnectionGUID: mWwd5UYvQK6ftQELQTXH+Q==
X-CSE-MsgGUID: y5V01xEgTIWIHhMaTqWoGQ==
X-IronPort-AV: E=Sophos;i="6.13,238,1732604400"; d="scan'208";a="204473300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jan 2025 03:10:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Jan 2025 03:09:50 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 27 Jan 2025 03:09:48 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 4/7] ARM: dts: at91: sam9x60: Add missing pinctrl node
 properties
Date: Mon, 27 Jan 2025 15:39:27 +0530
Message-ID: <20250127100930.108377-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127100930.108377-1-manikandan.m@microchip.com>
References: <20250127100930.108377-1-manikandan.m@microchip.com>
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
 arch/arm/dts/sam9x60.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 47b65d0ef56..a45e346d4ab 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -212,43 +212,64 @@
 			pinctrl: pinctrl@fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "microchip,sam9x60-pinctrl", "simple-bus";
+				compatible = "microchip,sam9x60-pinctrl", "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
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
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
 			};
 
-- 
2.25.1

