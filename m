Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C090C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552488833A;
	Mon, 22 Apr 2024 01:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741553;
	bh=aMuG9tdoVV/rqf2ShuJT3uJSbfvsDRksu5YcVwrRTmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cin9K2B2GHd8AsLeITFNENxovNVtfl1xYyNCK4yDqUL+3VbJn5H9NkkdiPTFMMIF+
	 hMiOiMFsAnSRiTs6VR8lRMnkuI2oiB36d6CsfIcLyd9S6fKkAExelNJUv1z03+25Zb
	 ny4842meqekQ2UEtRimLb2pXOx6QuUFGoZzZom05gHsWcUn5YQmsymLw/GzW0yf0MI
	 GPk0a0Cn8pSalTnrsanu6xVqm9AVGf7srbPLLf+Jqet9EHdp3NiBURxY81dJj2+XCg
	 PPGMZYqsriklt8APFyk4ThensTUcL+RKuUO2FH0kfDatwaip4Ce3gf51UsLl+AempO
	 07MXWSK1pXtwA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3AC8D8830D;
 Mon, 22 Apr 2024 01:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741548;
 bh=aMuG9tdoVV/rqf2ShuJT3uJSbfvsDRksu5YcVwrRTmQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cQDXcSTDRkbLHGaQJT78qjCRa3dsJStpKtrx++b6hzxKO9x5xecu1+503Kw4fVCzp
 X7sOjbSJvb9Dm4hhuag171cL94odtrE1I1Z1TOmYuh8Q0LS2lusp7lcFF4BheAEtjR
 jmY68pyFJ0Ftal8CrX7ZElFjsORmcbmJr1YVu6LlPZlTO4JiheIkri0qqaXlagGrxO
 IzmQAX0Sv8/tOQjPEEwvK6CBQQRA/z2CY3ec5v7tmOH5WrwMJS6GIsjky8ui0yf66w
 AeRXJ+s7TXu1jfSWSuneG3NeE0Nb1T9M9IaN5oTGQBCESaWaHsraJgLEnltjkCO1vY
 FgiSDM60ykzug==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/19] ARM: dts: stm32: Add alternate pinmux for MP13 ETH2 pins
Date: Mon, 22 Apr 2024 01:16:50 +0200
Message-ID: <20240421231849.194648-4-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240421231849.194648-1-marex@denx.de>
References: <20240421231849.194648-1-marex@denx.de>
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

Add another mux option for ETH2 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index c709d64edcc..899f0f98e1a 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -72,6 +72,51 @@
 		};
 	};
 
+	eth2_rgmii_pins_a: eth2-rgmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, AF11)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('G', 11, AF10)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('G', 1, AF10)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('E', 6, AF11)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('F', 6, AF11)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('G', 3, AF10)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('B', 6, AF11)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 5, AF10)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 4, AF11)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('E', 2, AF10)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 6, AF12)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('A', 8, AF11)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 12, AF11)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('H', 11, AF11)>; /* ETH_RGMII_RX_CLK */
+			bias-disable;
+		};
+	};
+
+	eth2_rgmii_sleep_pins_a: eth2-rgmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, ANALOG)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('F', 6, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('B', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('F', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 12, ANALOG)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('H', 11, ANALOG)>; /* ETH_RGMII_RX_CLK */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.43.0

