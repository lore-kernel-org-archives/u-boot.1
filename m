Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56587C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 10:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A29811A7;
	Mon, 27 Jan 2025 11:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="XUP25XZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6029D811A6; Mon, 27 Jan 2025 11:10:22 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA5F80FF7
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 11:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1152fbf31=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1737972620; x=1769508620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OiRGm5f256EVN0SjMAialkO7JagwpX0SEhi83gAGXFc=;
 b=XUP25XZwg/fTyEP4EDMM7Fjne9bd8ck8nwCqi3WKgwSVZmo0ymwZxIhQ
 Q2W0qlmBto5uAnBltj1PeMwKP1CvGw5mvwXjghdeRyI003bUmTBeeV5wQ
 nUAz7sFEAThjAtDpDVkSkBa17iMrBePSmiB7E0XTclxrzFf8Onid08cPE
 LjKiWvX8boNyfUr45ZbVsX8UlX0b5+w1Q3PMFhRAkp0AlPu7AF1iTMd5C
 ustnSk4kTrIGATUXo197t7zZ28Ed5EWnVWY9g1ERKNEEhulI0uja5UMrK
 94TVvRs/BWypBZdgyMWLHOhXFo0If7hvGr0lh0JCgB/c26lenMsOMdel1 A==;
X-CSE-ConnectionGUID: mWwd5UYvQK6ftQELQTXH+Q==
X-CSE-MsgGUID: m+MeOcNGTI+Z4YmW7bk/9g==
X-IronPort-AV: E=Sophos;i="6.13,238,1732604400"; d="scan'208";a="204473296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jan 2025 03:10:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Jan 2025 03:09:40 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 27 Jan 2025 03:09:37 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 1/7] ARM: dts: at91: sam9x60: Add AIC node
Date: Mon, 27 Jan 2025 15:39:24 +0530
Message-ID: <20250127100930.108377-2-manikandan.m@microchip.com>
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

Add Advanced Interrupt Controller node and define it as interrupt
parent in sam9x60 SoC DT.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/dts/sam9x60.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 3b684fc63d5..fdc3ad0fdcb 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -17,6 +17,7 @@
 /{
 	model = "Microchip SAM9X60 SoC";
 	compatible = "microchip,sam9x60";
+	interrupt-parent = <&aic>;
 
 	aliases {
 		serial0 = &dbgu;
@@ -199,6 +200,14 @@
 				reg = <0xffffea00 0x100>;
 			};
 
+			aic: interrupt-controller@fffff100 {
+				compatible = "microchip,sam9x60-aic";
+				reg = <0xfffff100 0x100>;
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				atmel,external-irqs = <31>;
+			};
+
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-- 
2.25.1

