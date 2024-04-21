Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26F6C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766138837C;
	Mon, 22 Apr 2024 01:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741557;
	bh=5CMPIvT57WnnTb5NiGZD0rOq/c+yhP3B5DujMmv3cCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXQbO7lC/J03Nv0SLvnt24UAoWtTXTPj9V9zZeJqXsCWjjvFbp9ENmEZSVYW2Alcb
	 zo+kpuWvn8DmJL0kHAcY0Wsx3JbbkbK89UI0Hsc/Dr25rsmyEsRB5pxllxOGB9pQ5G
	 JrHUB/2pRiTtFNxdr0rzyTVcS6KElDehiBk/Lp3DG5qsMZLs2jNZAhu/r695/Xb+Oi
	 0qaT40Ino1uQqcJ3H1mD20R8AXdrIP5oLkKFzB9nXFl7nAOgyQbOyOIBztchF5XWJw
	 vyaAWJmvxwhtToMab1YlVMgU5AyuQNsYW4l/3TPhA+Kt9/aDQ0ksGI4nuoJyqdAnFv
	 ThPmsEBmcH6JA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA6A988330;
 Mon, 22 Apr 2024 01:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741552;
 bh=5CMPIvT57WnnTb5NiGZD0rOq/c+yhP3B5DujMmv3cCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jPplmbxRi3TSnM7YDAOEWFZzAhjMPLm2X6bRVcnKRKCe9H/kguaYLFMi3gtPGOosJ
 kiP9FxdmwOYT0A1fY7rYwyRIJiXiHl2v3cqKZvtEmx/ngnHMhtPS2li6hm92FqCjiO
 zSMnqJPMNP8+7zNZbv7IFSMjFJCPsAPMgKYizz7OnP67SsksDZE1numO7qNaeTm17s
 qXM8oGcXdCwexMW02wme9xqMasEkMZsNEZ7hjtoo2CtbbqWLb6JdSeSL/Cb+ZjxECG
 +dZd6AxIh6KkQoLwjV3Id4dWG6AFcti+V2l0f2b63SpKPShs0IzQ6ANFNbXsBGwU4P
 RJc9CxBduAeag==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 15/19] ARM: dts: stm32: Add alternate pinmux for MP13 USART1
 pins
Date: Mon, 22 Apr 2024 01:17:01 +0200
Message-ID: <20240421231849.194648-15-marex@denx.de>
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

Add another mux option for USART1 pins, this is used on
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
index 7abd227e69f..dae015a0ddf 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -688,6 +688,36 @@
 		};
 	};
 
+	usart1_pins_b: usart1-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 0, AF7)>; /* USART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 14, AF7)>; /* USART1_RX */
+			bias-pull-up;
+		};
+	};
+
+	usart1_idle_pins_b: usart1-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>; /* USART1_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 14, AF7)>; /* USART1_RX */
+			bias-pull-up;
+		};
+	};
+
+	usart1_sleep_pins_b: usart1-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>, /* USART1_TX */
+				 <STM32_PINMUX('D', 14, ANALOG)>; /* USART1_RX */
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('H', 12, AF1)>, /* USART2_TX */
-- 
2.43.0

