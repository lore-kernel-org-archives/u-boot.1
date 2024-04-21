Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91203C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35CE88327;
	Mon, 22 Apr 2024 01:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741549;
	bh=EIfow5wR5nqshuDqwcrrMetKOfImBOC4o20zLi5kyls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=arnskIDirwJsNCKGH89SRebD7kio82ZP+8232V1PEotvotugf19l+mSttghAGKpj3
	 usvRNVPqgHmZwiazfmyXAI5xl5c3lOrqH3M0+4z8OSFcgHfFcdgFkVSzKHw4i6N19l
	 h/+bqELoLVEfHOFMjjiu267ic9P09/SiNY3pyBJg73C4SQnXVUF9OFR42b2u7fBb4A
	 JUXp/nEwy/nacV4wZx3BFME2XoGuEesqWSkiiqCSdTGkpC03fXfu2Qn2jay36olK0b
	 jeHeoltxehhcJJvRtzCJyqKRkd0Dmx4UFhohA465UVLm9qW5c3USBgoNibPJ3I99V8
	 jccOtjZlpybPw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DF9AF880AE;
 Mon, 22 Apr 2024 01:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741548;
 bh=EIfow5wR5nqshuDqwcrrMetKOfImBOC4o20zLi5kyls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XeHtGZcTE5XqF9ABtN7zbehlm3PIgQwXMXw1haYrRmgaKxpZYyey92gI5xBmnhjLX
 FHFJxapFcHgWu890tSj2ULh9bP9cwb9+T44iTGkVqluRET4nM31PEXMX+Km/SJEeyR
 NOChO7rUyWZP+mAl+/OJlN55PC8lxXAw7QzNXQmePDtjcUNKP/BtqFKc5hGEHq42UP
 UvZ7Xy5VuMO4axClj6niOI1FpkcY81IVpX38xw43G32/YHDgVcqdIa6NidLfAnrkhz
 KuFIp+q+XBjBxsJTPhWJj2KKvwYPCtDF5SOVmJIqAmDSnvaDmpIWURJVGTcqycruUU
 HfwZ0VzPo17iQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 03/19] ARM: dts: stm32: Add alternate pinmux for MP13 ETH1 pins
Date: Mon, 22 Apr 2024 01:16:49 +0200
Message-ID: <20240421231849.194648-3-marex@denx.de>
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

Add another mux option for ETH1 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 396fb6eee84..c709d64edcc 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -26,6 +26,52 @@
 		};
 	};
 
+	eth1_rgmii_pins_a: eth1-rgmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('E', 5, AF10)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('B', 11, AF11)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('C', 1, AF11)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('A', 2, AF11)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 2, AF11)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('B', 0, AF11)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('B', 1, AF11)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 7, AF11)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('D', 7, AF10)>; /* ETH_RGMII_RX_CLK */
+			bias-disable;
+		};
+
+	};
+
+	eth1_rgmii_sleep_pins_a: eth1-rgmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('E', 5, ANALOG)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 2, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('B', 0, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('B', 1, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('A', 7, ANALOG)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('D', 7, ANALOG)>; /* ETH_RGMII_RX_CLK */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.43.0

