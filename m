Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A1DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392B687813;
	Tue, 12 Dec 2023 17:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="SFhM0DqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2476A871DE; Tue, 12 Dec 2023 17:04:46 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C553877FE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1rD5FA-000BXR-BN; Tue, 12 Dec 2023 17:04:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702397079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sn2WwVfmJNogDJWKBUw81J3X7DS1OnQyNcy0u98Zo8A=;
 b=SFhM0DqOzEkdBjoMmILcqwb4tsyE+i/COznqwG0zQnMfRofu9LY2/pmplrcUTrpRcjFwFN
 zcpPMsLO1R/a99oWDIUsKoHfRe0ctQQetABQQZPdTbHXU42kBeZ4jq+OYHX7fDS0Zf7aB4
 S4zx3K8E60pRvtAVknK0VzDOKzcFtJAcBAIhFi6/6rNnaViSwIv7EiNMTUozMEI9j1FL90
 h923d7yVXde1/FoqtSfTzz/H9v9+8ENDJ9/zOxPWsPSbg0xiE5pkTjgo/ltsTf57411umh
 QSGsPHwWXzN4XuC82eT9ijbBtdmaCg/pOwfxmeqfXjiYdxEC35osNonaYAeUhA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 2/4] ARM: dts: at91: sama5d2: Port ebi/nand nodes from linux
Date: Tue, 12 Dec 2023 17:04:21 +0100
Message-Id: <20231212160423.44290-3-ada@thorsis.com>
In-Reply-To: <20231212160423.44290-1-ada@thorsis.com>
References: <20231212160423.44290-1-ada@thorsis.com>
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

Required for using the new DM based atmel nand driver.
Ported from Linux v6.7-rc4.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/sama5d2.dtsi | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index c28a544da6f..0dbacade3b6 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -34,6 +34,15 @@
 		#size-cells = <1>;
 		bootph-all;
 
+		nfc_sram: sram@100000 {
+			compatible = "mmio-sram";
+			no-memory-wc;
+			reg = <0x00100000 0x2400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x00100000 0x2400>;
+		};
+
 		usb1: ohci@400000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00400000 0x100000>;
@@ -50,6 +59,32 @@
 			status = "disabled";
 		};
 
+		ebi: ebi@10000000 {
+			compatible = "atmel,sama5d3-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&hsmc>;
+			reg = <0x10000000 0x10000000
+			       0x60000000 0x30000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x60000000 0x10000000
+				  0x2 0x0 0x70000000 0x10000000
+				  0x3 0x0 0x80000000 0x10000000>;
+			clocks = <&h32ck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,sama5d3-nand-controller";
+				atmel,nfc-sram = <&nfc_sram>;
+				atmel,nfc-io = <&nfc_io>;
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		sdmmc0: sdio-host@a0000000 {
 			compatible = "atmel,sama5d2-sdhci";
 			reg = <0xa0000000 0x300>;
@@ -66,6 +101,11 @@
 			status = "disabled";
 		};
 
+		nfc_io: nfc-io@c0000000 {
+			compatible = "atmel,sama5d3-nfc-io", "syscon";
+			reg = <0xc0000000 0x8000000>;
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -657,6 +697,22 @@
 				};
 			};
 
+			hsmc: hsmc@f8014000 {
+				compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";
+				reg = <0xf8014000 0x1000>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 6>;
+				clocks = <&hsmc_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pmecc: ecc-engine@f8014070 {
+					compatible = "atmel,sama5d2-pmecc";
+					reg = <0xf8014070 0x490>,
+					      <0xf8014500 0x200>;
+				};
+			};
+
 			uart0: serial@f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x100>;
-- 
2.39.2

