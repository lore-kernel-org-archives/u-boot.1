Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433B2C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41B887F06;
	Mon, 11 Mar 2024 16:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FUTATttB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A81787E88; Mon, 11 Mar 2024 16:23:12 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B092787E96
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710170587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlOY4e0WlJ8/1FZCqigGZ7zd6e4lMkUMFpbk7PQ+1Qw=;
 b=FUTATttBal9T94xrF2Lry9u1tQnAia00Ad+3lNMYZavW6vrozsyMfl4/EqLDnK4bo71G8o
 MNgxPK4kW8MPEE3MueAgh7Wc2Bm8P5ruemM0AUDBJA0mr0ci0PfI1YX4mhyE090ITQ720m
 Mx6eFuq6wFQLRXy8rI7OKzKI+zybXt8/rNaNc9+84f/ASHgoGNwDfdlg1qpUhSU7b09Cg5
 Sm0vTYinWNqWUkKoz+sBVPSOv5cQm89LWI/4/ERNN3L8XIV1FdZyqjelLg9gPGiUr6EmOP
 yxUiIce/R6r3+166o/UNfDkXpuPB4M9PFv6BYN/1sKShIte/yrW2CM5YHDrT0w==
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [RFC PATCH 1/3] ARM: dts: at91sam9260: Add modern NAND controller
 nodes
Date: Mon, 11 Mar 2024 16:23:04 +0100
Message-Id: <20240311152306.2358845-2-ada@thorsis.com>
In-Reply-To: <20240311152306.2358845-1-ada@thorsis.com>
References: <20240311152306.2358845-1-ada@thorsis.com>
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

Required for using the new dm enabled nand-controller driver on sam9260
family based boards.  Ported from Linux v6.8.  Node for old NAND driver
binding kept in place for now, so we can change nan controller driver
board by board.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/at91sam9260.dtsi | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/dts/at91sam9260.dtsi b/arch/arm/dts/at91sam9260.dtsi
index 4ea4202737c..c320c82c6dd 100644
--- a/arch/arm/dts/at91sam9260.dtsi
+++ b/arch/arm/dts/at91sam9260.dtsi
@@ -99,6 +99,16 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc@ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
+			matrix: matrix@ffffee00 {
+				compatible = "atmel,at91sam9260-matrix", "syscon";
+				reg = <0xffffee00 0x200>;
+			};
+
 			pmc: pmc@fffffc00 {
 				compatible = "atmel,at91sam9260-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
@@ -575,6 +585,16 @@
 							<AT91_PIOC 13 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PC13 gpio RDY pin pull_up */
 							 AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PC14 gpio enable pin pull_up */
 					};
+
+					pinctrl_nand_rb: nand-rb-0 {
+						atmel,pins =
+							<AT91_PIOC 13 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
+						atmel,pins =
+							 <AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
 				};
 
 				macb {
@@ -1030,6 +1050,33 @@
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
+
+		ebi: ebi@10000000 {
+			compatible = "atmel,at91sam9260-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x80000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000
+				  0x6 0x0 0x70000000 0x10000000
+				  0x7 0x0 0x80000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9260-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
 	};
 
 	i2c@0 {
-- 
2.39.2

