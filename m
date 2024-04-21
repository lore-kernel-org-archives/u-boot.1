Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A52C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9479B88368;
	Mon, 22 Apr 2024 01:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741562;
	bh=vrBqCifnCaBrjg0BD3Vu6IBY4RNG1Zz6Om9NiJHAiIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AH5rjJ6uB19a18lL/kQuEz7ztiSbLBGMhkURj1jv4s4se1B6ksM6mYGgSfqneE9qh
	 ceKzDHlq5OQflAJFWXViyR1QLz0yZ0Hh2THKCQEgZ4y/FBwqQD9ZkoSOrUFKZZDuh6
	 C4OyG1QD2QSNy3k2IM684vlNU2PR/vGHOV7ij0Qun6pZggBgEmFHfbnMlrBmW1rNnx
	 lmNi7uWlrlNypONs83uXtWE87Ts/IzHmLpFjfosQdNVRtJoz4EAL2X9sFB3rEEfDX1
	 aownOfDKR5GvRuoS/WIkxRF8shjFSZKD0USysZraLaRxI5RH3v38NMpZn2R45QiBcJ
	 iScetwDb5hV+A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA4F288326;
 Mon, 22 Apr 2024 01:19:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741553;
 bh=vrBqCifnCaBrjg0BD3Vu6IBY4RNG1Zz6Om9NiJHAiIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qKzkNCkg0M5srg1mP+56J4HLq9U6jbfrcrM+fMIh87ixpvvDePEeF4SGl4UMEqsnM
 dB5V7hKw6pDRQJrTRAVA9St6+Lj+Fqb5CyHfLJ/JMZ5MrVgJeETwkV1zc05uiu3zRF
 0lMHYEwiHylN7k94FLt+k5GyXhL603MEoCohWe2NWNuYfGGLVCzP6CmggKb0l5bjtj
 6FJ6mQGZ4ppNu+GLF2MX1FH8zDUbZcvWcDYjNrMw+Lomd4dN2vPD/w7ZzwMpVn77a/
 U5MjvaEmOQDKC4hi9OAwB79h6Spg49VDRAEy8h6T3+SUVLyyR8TAClBYm5JlnNDv3Z
 kDA9ET+jXz+cw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 18/19] ARM: dts: stm32: Add alternate pinmux for MP13 UART7
 pins
Date: Mon, 22 Apr 2024 01:17:04 +0200
Message-ID: <20240421231849.194648-18-marex@denx.de>
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

Add another mux option for UART7 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 7014c7a6d23..c01d39f03ea 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -647,6 +647,47 @@
 		};
 	};
 
+	uart7_pins_a: uart7-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H', 2, AF8)>, /* UART7_TX */
+				 <STM32_PINMUX('B', 12, AF7)>; /* UART7_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 10, AF7)>, /* UART7_RX */
+				 <STM32_PINMUX('G', 7, AF8)>; /* UART7_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	uart7_idle_pins_a: uart7-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* UART7_TX */
+				 <STM32_PINMUX('G', 7, ANALOG)>; /* UART7_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 12, AF7)>; /* UART7_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('E', 10, AF7)>; /* UART7_RX */
+			bias-disable;
+		};
+	};
+
+	uart7_sleep_pins_a: uart7-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* UART7_TX */
+				 <STM32_PINMUX('B', 12, ANALOG)>, /* UART7_RTS */
+				 <STM32_PINMUX('E', 10, ANALOG)>, /* UART7_RX */
+				 <STM32_PINMUX('G', 7, ANALOG)>; /* UART7_CTS_NSS */
+		};
+	};
+
 	uart8_pins_a: uart8-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
-- 
2.43.0

