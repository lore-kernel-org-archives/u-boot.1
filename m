Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD0CC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C2C88004;
	Tue, 27 Feb 2024 14:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="kSq93NsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D5087FF5; Tue, 27 Feb 2024 14:44:29 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CEC887FFE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709041466; x=1740577466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M29itKFpeAJl+QjVdKV4s393ixV+RayH9uW27SBwnOQ=;
 b=kSq93NsM4QJiEYk+oX21/Yc9NiAJNLTblD+WRBnqluAImUYW12/pMYUx
 FIqkD3YVg8M8nJhn07isbBDH5ixZ3DBxNVNXKHIRcG7Ab/p9MlOkpcdyA
 tPUoifDZ8impb0a6AC23RJ4vgPqWWmxx9u+kPYLHxvOmYB2LGE9oG4wcd
 /7KZE08kJ2TVSF0dXVh+8G3L5KKcsK3J4+PgWJ2YQBU6JK2T1kVMcGoO9
 WdaGxSu2DJUsutv/Bu1yJ5Z2oEdi5JJqsJQmqXlzeZgb1D73Lncl7C85i
 bu1OJLid9+gJfb1mROWGLUyKltYGy9tr8tauXYGVNrkLoSlhaU5PsD094 w==;
X-CSE-ConnectionGUID: rMT+by1bQ1ie1abVCT+3tw==
X-CSE-MsgGUID: fegOosOATUe84vvDpbdBkQ==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; d="scan'208";a="17418741"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2024 06:44:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:44:09 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:44:08 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 1/4] ARM: dts: at91: sama7g5: Add flexcom 10 node
Date: Tue, 27 Feb 2024 15:44:00 +0200
Message-ID: <20240227134403.10686-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227134403.10686-1-mihai.sain@microchip.com>
References: <20240227134403.10686-1-mihai.sain@microchip.com>
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

Add flexcom 10 node for usage on the SAMA7G54 Curiosity board.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/dts/sama7g5.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/dts/sama7g5.dtsi b/arch/arm/dts/sama7g5.dtsi
index 746a5ba347..a17c58cbfc 100644
--- a/arch/arm/dts/sama7g5.dtsi
+++ b/arch/arm/dts/sama7g5.dtsi
@@ -871,6 +871,30 @@
 			};
 		};
 
+		flx10: flexcom@e2820000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe2820000 0x200>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 48>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe2820000 0x800>;
+			status = "disabled";
+
+			i2c10: i2c@600 {
+				compatible = "microchip,sama7g5-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 48>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(26)>,
+					<&dma0 AT91_XDMAC_DT_PERID(25)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
 		flx11: flexcom@e2824000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2824000 0x200>;
-- 
2.44.0

