Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDAC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1F08834A;
	Mon, 22 Apr 2024 01:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741556;
	bh=nY+1bKRrHXnoJwEnnPFBGs5t/hpiCW6mcQo9xEQnoqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzO3LQY4IjBLBHdM/k/BQIIhvecKTFOrArzsIApDpXDKjZ5qHiGj2yih+WejekS30
	 jwz2Vw63Y2aoboqjQw1TxxE7Jh1hdLxdS6hveQWoFXt1mWwPG8mz+Av0YWf2QxgPlk
	 LNMtSrkacOxnJ7P59eMgcbIgiot2xmNbddOKFr1B1elLhmekj6IziHIdIqb7I8qXMx
	 Z5beA/b1QVdzhsGQYVHnKmPIjtwR0yzM+kBLVmAOCORuNd63mx1U/dXq6OBbzco5Uf
	 /D/esfnlCQe9y3df0aGdMPtbvUF8LEZnxHRsiUGSn4HHgiV2DOIp4vJ+l/XOnxl1Xg
	 3mOjmazGvnJag==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 39A8188333;
 Mon, 22 Apr 2024 01:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741551;
 bh=nY+1bKRrHXnoJwEnnPFBGs5t/hpiCW6mcQo9xEQnoqs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z4Li3dTfDb65NkK9gsK7Ogq6e0RlahWlIHRMErEJCr0NTAGpSfzCa8aIUQwoMQg3m
 rdzJZBNKwt3Mqq9MUo1+dVrbxGYo2pWlHvuYr3IUjAQQk25+5e3Nol9Gb+yV/L/rcU
 TaO6YVzEFqsGygzimqG6H5GdPa84JKWg6hsCpRb0J7XN8gNY5aqSMVl5cdg4wf+GQJ
 GUdNrOQfsHAyvHsuXa3dEnKgE4uXb+/8d3QvvbAi310+INJWK1Cj8lzgoA9/zUCinY
 xSmL/+0opHHK73KEky0GGAvzuj2OfOP3PHMAc34zaPSIOc63zJrr6ImXK0iSoIbtFi
 RjZMlKdkkbRSg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 13/19] ARM: dts: stm32: Add alternate pinmux for MP13 SPI2 pins
Date: Mon, 22 Apr 2024 01:16:59 +0200
Message-ID: <20240421231849.194648-13-marex@denx.de>
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

Add another mux option for SPI2 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index c6967e82b5d..17acd2850d3 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -511,6 +511,29 @@
 		};
 	};
 
+	spi2_pins_a: spi2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>, /* SPI2_SCK */
+				 <STM32_PINMUX('H', 10, AF6)>; /* SPI2_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 5, AF5)>; /* SPI2_MISO */
+			bias-disable;
+		};
+	};
+
+	spi2_sleep_pins_a: spi2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* SPI2_SCK */
+				 <STM32_PINMUX('B', 5, ANALOG)>, /* SPI2_MISO */
+				 <STM32_PINMUX('H', 10, ANALOG)>; /* SPI2_MOSI */
+		};
+	};
+
 	spi5_pins_a: spi5-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('H', 7, AF6)>, /* SPI5_SCK */
-- 
2.43.0

