Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0015CC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D72C88363;
	Mon, 22 Apr 2024 01:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741555;
	bh=9ZV+ir3GagK098jToaqgdpSN3v7O35N8sPpGTFqBz5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yDXhg2/c4RoBQq+iADfiuPG9QRJSF4jELtYQaQla+fpDfURpSR8HDW2fBrOoOdAVX
	 x8MlMl49coAVnc40Lv3P8PJovqIvoHcjAChYzfgJxmHQDk758zrjJw0xflSczFwNjv
	 7yM33/iXrf7KIvF7PHqiD1iJ0+XyHBxxosmnxIW54D+TSiSUO1N+Wfu/pOdEQtkS0R
	 2Zfbk0qgXirPcvNQlK1eTPgo7RA2kjgVU/5dEGQWX0S+V2RJYOgUQqp5/gk55PC7Lz
	 BuIWSjTD4Yt0ToVCkuC2ZFLFjeyfOAUY7hKEd+SwXxWCPXgtzn7inaUjfG91rbMHaW
	 sA3OTo36mrHtw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA31E88324;
 Mon, 22 Apr 2024 01:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741550;
 bh=9ZV+ir3GagK098jToaqgdpSN3v7O35N8sPpGTFqBz5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xl1+iqmJXe8izw3sPYAIZUoJeeDLUm2iHOfghyZKOXPePCqeHmDAB8Mi3D/hcg8Zr
 QZep+MYb5oEprWkt1UGDOIRN4axyhIRHGT/tZ+tnU3Uf9hFbVkilQgy71tq1bqaJkd
 nUJuIdt/3c5KKKlcFQzFPmTHvr1N1EzknFk/f8xIvC3+SJUxPb8RMktT+HIKf0lFNp
 Zo1Ruj49lDHAgZpSttYmVEKDsJUJIHgrCU9cHS056ARRbF+PYMNoQQ3D6eFftIhZm/
 3NQN1BiMzVM6xxziJbXx/xNE3CxI2OZsRcBbEr24I1rGqYiXIpLqFku8tUzEQzPYk1
 N2OvISdfFrmMA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/19] ARM: dts: stm32: Add alternate pinmux for MP13 PWM13
 pins
Date: Mon, 22 Apr 2024 01:16:55 +0200
Message-ID: <20240421231849.194648-9-marex@denx.de>
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

Add another mux option for PWM13 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index d19408f19f9..cf070fbd7f7 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -275,6 +275,21 @@
 		};
 	};
 
+	pwm13_pins_a: pwm13-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 6, AF9)>; /* TIM13_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm13_sleep_pins_a: pwm13-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 6, ANALOG)>; /* TIM13_CH1 */
+		};
+	};
+
 	pwm14_pins_a: pwm14-0 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 9, AF9)>; /* TIM14_CH1 */
-- 
2.43.0

