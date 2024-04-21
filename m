Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4DCC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F18788347;
	Mon, 22 Apr 2024 01:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741562;
	bh=KHqoLPWy7lPhgtX1+o91KaWPps7myP9e0P2L3Ny94Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtUTX2GqGkdtkMENT9HHHtB5KH3ElGLGIK8t9eWV4IQ+iSfCTJ/oo/mMNiQPOzKfG
	 5yuI2KDLN7HV7Zsgzaik3cuvd3Ti+EzveoOXIb0T2obid8/ZGvuTBKl9rb3ODRs6uc
	 5UTvDhS6NxvW/jFJqqkdwrfFGYDDWJu00ThJLu1xchEtEjhMBuQzD5/r3c8b2QCdgC
	 PfNAEvhXqFYlbCrsC3Bu9osFbqVs4ivQMYHvxI2e59UgtJ0/qvgmFu8HFFcPG9O5e+
	 uZWz0Lw9ZwyeAsjkkd4CQAEf6sOHGAu6ntvZXt6ouXWLUuDHGBjbgFaWk/GQhZAR9y
	 4uTAsWrDs08XQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 88AE28831F;
 Mon, 22 Apr 2024 01:19:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741552;
 bh=KHqoLPWy7lPhgtX1+o91KaWPps7myP9e0P2L3Ny94Ko=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D/vPeIwETAGdKLzYyF3ERMfFOwRupQgZncSUUReItO/BoqWaugspf3pboWvNMshed
 aoBjQQ94g6bR0sr9bu4L2BNQXtVi64rZ2l1Tzdih/QP06b8LalrH1IWXKWi+GRnzx6
 n1Q7wn7ICDqPn9feSFcABzdCKtINCsrJEdAD38OOgvI4RqoihcO7JU/ykFrdw8Wx7f
 YL/8Kp6S/GruZydkrxX1XQuGmXIh3bfMvEle5ZiS8WWnyVjHg6t1Bi4HIP+7YpcaHs
 xnbZ365ZkmFYZ3Rl8aN88MYp9xYsknaF8Aug6kt2gbUnS4IgObE7dhCQt1TxqIZFEz
 Sb5nIdUfFD/bQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 17/19] ARM: dts: stm32: Add alternate pinmux for MP13 UART4
 pins
Date: Mon, 22 Apr 2024 01:17:03 +0200
Message-ID: <20240421231849.194648-17-marex@denx.de>
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

Add another mux option for UART4 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 65f91265a4d..7014c7a6d23 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -617,6 +617,36 @@
 		};
 	};
 
+	uart4_pins_b: uart4-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 9, AF8)>; /* UART4_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 8, AF8)>; /* UART4_RX */
+			bias-pull-up;
+		};
+	};
+
+	uart4_idle_pins_b: uart4-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 9, ANALOG)>; /* UART4_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 8, AF8)>; /* UART4_RX */
+			bias-pull-up;
+		};
+	};
+
+	uart4_sleep_pins_b: uart4-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 9, ANALOG)>, /* UART4_TX */
+				 <STM32_PINMUX('D', 8, ANALOG)>; /* UART4_RX */
+		};
+	};
+
 	uart8_pins_a: uart8-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
-- 
2.43.0

