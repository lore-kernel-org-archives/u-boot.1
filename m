Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045C4C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58C987B80;
	Fri,  9 Feb 2024 10:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="cvXpJuaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D0F87E35; Fri,  9 Feb 2024 10:48:20 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D4E87E4F
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1707472098; x=1739008098;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T0eP3W477ZM356NPinMaAggDTxeqseP721oXAdXn7KY=;
 b=cvXpJuaZ4nGrxbO+5aBOAVbdvl9yhAMzsOSdArywVD7pmKvYrLc8fHXm
 DRkvMcOR5+fL/3OMjFMGz8xgPfrVBzSONdPP7U9Q9MEtE1xeWiUeIFcpA
 dRcXsXXoP3dIKhvH1dpySQ3GoECnCKi3q+PhsPDvd2LA1/2koNUUPt30b
 cLrx3CMSnEEHhyBuihgrBMKBvwpdKv6etBooy7GoS+y+ncxsLSJgGA9y/
 40yzTYufnVdr/HWNtLDhisybPsdTNpsPq6gIQCwuH0S9bkbQWNT+17WXK
 1kDKq2CKqLANJy8oPwDiFTC3BOnrFBJz95Y/YDYRaGov1MmEZNFu7c3CM g==;
X-CSE-ConnectionGUID: 66jlKJ8MStW7WWgmZa/VmA==
X-CSE-MsgGUID: SJuxO0xZTgGpyufGXj1tcA==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; d="scan'208";a="16528730"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2024 02:48:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 02:47:48 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 02:47:47 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/4] ARM: dts: at91: sama7g5: add flexcom 10 node
Date: Fri, 9 Feb 2024 11:47:34 +0200
Message-ID: <20240209094737.38347-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209094737.38347-1-mihai.sain@microchip.com>
References: <20240209094737.38347-1-mihai.sain@microchip.com>
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
 arch/arm/dts/sama7g5.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/sama7g5.dtsi b/arch/arm/dts/sama7g5.dtsi
index 746a5ba347..01e880aabe 100644
--- a/arch/arm/dts/sama7g5.dtsi
+++ b/arch/arm/dts/sama7g5.dtsi
@@ -871,6 +871,32 @@
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
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(25)>,
+					<&dma0 AT91_XDMAC_DT_PERID(26)>;
+				dma-names = "rx", "tx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+		};
+
 		flx11: flexcom@e2824000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2824000 0x200>;
-- 
2.43.0

