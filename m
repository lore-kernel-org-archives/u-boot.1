Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E81CC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6B68836D;
	Mon, 22 Apr 2024 01:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741555;
	bh=PZdARcIAB9Cb/BxPza9hujDQ1QS5htUq+GfFYgbd5FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O9CcKqfnlJuoNj8DPDcJzCYP0ILT+NXyI2OuOUQQwLEzAam5BliG5LfM+rr31NFa1
	 DZ+Z9eGMIVSmZoGPJgNzyqpVYsEPGblnEsrqVpdk62LwyaR9oMPjvTFFHu3or2pWyc
	 fNlmCg86xIi+ACcUhKzh1wQveTrWdD0nmg8AajOeg3icaiqqlcl3Uq8McEk9xj69KJ
	 L4uzdwsIR5xCrrdsWqMIUGJQ2D5d6uYX2PJoCHd3qDB7sFxvGUUAWgvlxZhMVJkvUp
	 S9DOfjCjnIL5HF8ELd9fATBJ12tgDXFD2bChyQFnENOjCeuYAotXipzhlI3oS4dS3e
	 feeR6VSJai2Tw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8A8488832E;
 Mon, 22 Apr 2024 01:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741550;
 bh=PZdARcIAB9Cb/BxPza9hujDQ1QS5htUq+GfFYgbd5FU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=w6XnUHlkhUh9D0OsD4D8YjYpY5Ukc7TiT5G/aENIfpmkzUvtS+ZrD4azEtE2taWc8
 QcBkT0rb/kfb2x72rdXnnfAP502lFUlYn5DVx2LjOJU93tz37Zt2lKgzPSq1iZpvLZ
 x4lh12u4PB26i8dRJD0MJstzGAkIRqs0N2NL2Se2p0k1HGkYP7akz3ec+51PZEWQQz
 tXGhzwGUn7xDvOVpbW/9t2INtLqrrjfszkqKIB6aXLkZNZBQMmHUz+JZGVAsFz+5l3
 sHLVPyEWLHbhRYsvle1pGtpml9MmnL79XYEQzbCAFY4wCGxwG8VllnlN1l8l4fz/2K
 5Fem3HX79Idpg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 11/19] ARM: dts: stm32: Add alternate pinmux for MP13 SAI1 pins
Date: Mon, 22 Apr 2024 01:16:57 +0200
Message-ID: <20240421231849.194648-11-marex@denx.de>
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

Add another mux option for SAI1 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 77a222903de..f2b41104a58 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -356,6 +356,38 @@
 		};
 	};
 
+	sai1a_pins_a: sai1a-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 4, AF12)>, /* SAI1_SCK_A */
+				 <STM32_PINMUX('D', 6, AF6)>, /* SAI1_SD_A */
+				 <STM32_PINMUX('E', 11, AF6)>; /* SAI1_FS_A */
+			slew-rate = <0>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	sai1a_sleep_pins_a: sai1a-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 4, ANALOG)>, /* SAI1_SCK_A */
+				 <STM32_PINMUX('D', 6, ANALOG)>, /* SAI1_SD_A */
+				 <STM32_PINMUX('E', 11, ANALOG)>; /* SAI1_FS_A */
+		};
+	};
+
+	sai1b_pins_a: sai1b-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 0, AF6)>; /* SAI1_SD_B */
+			bias-disable;
+		};
+	};
+
+	sai1b_sleep_pins_a: sai1b-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 0, ANALOG)>; /* SAI1_SD_B */
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins {
 			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-- 
2.43.0

