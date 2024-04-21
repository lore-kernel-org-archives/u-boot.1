Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C30C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D3C8836C;
	Mon, 22 Apr 2024 01:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741555;
	bh=9rx3eOGkPR1/gPY3Y6kP47svsSxSz4N0AnbyFIqQvtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OMlC0Inf0ULI6TWOEAodkbUO+dnjSEYiClBwCJTRvloOP72A6dpxETBm1P27cEGcS
	 Gd6ZMVApgcU30s/8ZIRBIX49UWNlzzW90LROmEqxacse5oWaxBGPGwUflJP/da9lu7
	 4PUklf+wubOYGdi0taSAqFx0i5P3Hs+9da+vDv7E3OYcslman5sNswVW60KVzfsivu
	 qcDygPbqCpPkzBM2W9ilzNm8gcUM0V/jyVlTCW83lhBj+tkmyyDBrNOmjriZTfi4sH
	 EAKNP6mHZ2/pG51RanLWwlqPMtlywsqEvRkq/ZivGK+CDE7w9UDfWq0LYJpUIba08o
	 ewdDNS21Fd5yQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 37EC788329;
 Mon, 22 Apr 2024 01:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741550;
 bh=9rx3eOGkPR1/gPY3Y6kP47svsSxSz4N0AnbyFIqQvtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PEcxl+EBBY4PuxUqN8Ur1mWXSe4kj4qWpFbDc4yQnYOmxQO1blt5gNXPaTa9PwgPh
 CXCiLSmcslM/iqlkhFdBMb9uF9o/FQiWKS4MmntAle+IbkRYBGg86of7/Nd5O+KNv5
 NnxKuqrz+L4L7A/ZD18iXoFGELsbhLvBz1TARVonsyw4ik6KcXthPi8ycY3wA9xaOY
 DIGiSuVRF7PwBCfR2ECSEaxFK79H6UJ6BClhHH/2cGZU36mkBmGNOBzFjVGjUEMEkZ
 SYsJx/U3x0UOqvy1X23n6cPxBC2BF76+qeE0VnwKvjlDDEzLzd4nZoODrDlf+Qbh0I
 EycO6VA22CNAw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 10/19] ARM: dts: stm32: Add alternate pinmux for MP13 QSPI pins
Date: Mon, 22 Apr 2024 01:16:56 +0200
Message-ID: <20240421231849.194648-10-marex@denx.de>
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

Add another mux option for QSPI pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 51 +++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index cf070fbd7f7..77a222903de 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -305,6 +305,57 @@
 		};
 	};
 
+	qspi_clk_pins_a: qspi-clk-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 10, AF9)>; /* QSPI_CLK */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+	};
+
+	qspi_clk_sleep_pins_a: qspi-clk-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 10, ANALOG)>; /* QSPI_CLK */
+		};
+	};
+
+	qspi_bk1_pins_a: qspi-bk1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
+				 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
+				 <STM32_PINMUX('D', 11, AF9)>, /* QSPI_BK1_IO2 */
+				 <STM32_PINMUX('H', 7, AF13)>; /* QSPI_BK1_IO3 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	qspi_bk1_sleep_pins_a: qspi-bk1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* QSPI_BK1_IO0 */
+				 <STM32_PINMUX('F', 9, ANALOG)>, /* QSPI_BK1_IO1 */
+				 <STM32_PINMUX('D', 11, ANALOG)>, /* QSPI_BK1_IO2 */
+				 <STM32_PINMUX('H', 7, ANALOG)>; /* QSPI_BK1_IO3 */
+		};
+	};
+
+	qspi_cs1_pins_a: qspi-cs1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 2, AF9)>; /* QSPI_BK1_NCS */
+			bias-pull-up;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	qspi_cs1_sleep_pins_a: qspi-cs1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 2, ANALOG)>; /* QSPI_BK1_NCS */
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins {
 			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-- 
2.43.0

