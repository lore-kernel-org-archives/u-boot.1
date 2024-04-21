Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64A6C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFDA8834E;
	Mon, 22 Apr 2024 01:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741554;
	bh=WdAbyvBmmEtSOWF+JIoSimAr4G3Li8qVJuTl2fYUbnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xah7QFUgA4rMqvOuBqE0/pFxYb1Y8yRJZ3Lif9lm587n5KZgmS7Gl6vqTCkZAUrZp
	 05zIoMQ2YH5c8t8qwSvDoBtHRPHRcMJp0K9pWrn1EzZ0k+WKvxxgqhFtmL5D0w5VAt
	 VEvMVrJFmCqEdTdh7fzvOSRmsG4RhhI415k3QQgHslObGT1vefA1GOsPTg5wvHxVUq
	 4WJjjm/OLriCPXSrWvQro4z4h9rUmTr6xKIY4ZcCRoHaIqdXnmKmcynlA+UGZqLwJM
	 tZWL7E0eCNhVggOGAx17YBWK5PB27tevQ/aLXXUbMu446B20gh8HNS+TJzzjbMHaho
	 PKm51TR071E5A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DCFA888311;
 Mon, 22 Apr 2024 01:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741549;
 bh=WdAbyvBmmEtSOWF+JIoSimAr4G3Li8qVJuTl2fYUbnc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LVgeeLlKLQ1CyofLTa4AUA5VmqiVavKPiAYo/oIk2VVGmHIVIaoz/7j/qk95Rm02d
 +Hpt55WB7HWhy3N2JDiQznEVl4XH62bmB5HJ+jqs7yDHPaZlJKHl2H3OT0DDj/DeVk
 jN52iAF8jb0j40nZ01qt9H8PQfOw/3cnDCNXZrctE418IM1iMXJyWzFAjMDgw/JMJT
 y07zbAbUHnm7SzIT86PvV9xNoUI4klmcPm6XizvFD5PRgV8O2FejOJ5xF+bhj62lTh
 qZ1OdenwhvxyolWb7vQGFsZxNHXkqYD37kk2cSWzRfTLSSkuqkUFWPTcZrqQTaT6RW
 VcaCN1/Vz0DIQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 06/19] ARM: dts: stm32: Add alternate pinmux for MP13 MCAN1
 pins
Date: Mon, 22 Apr 2024 01:16:52 +0200
Message-ID: <20240421231849.194648-6-marex@denx.de>
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

Add another mux option for MCAN1 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index cfbae71efc7..b38174504ff 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -168,6 +168,26 @@
 		};
 	};
 
+	m_can1_pins_a: m-can1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 10, AF9)>; /* CAN1_TX */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 0, AF9)>; /* CAN1_RX */
+			bias-disable;
+		};
+	};
+
+	m_can1_sleep_pins_a: m_can1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 10, ANALOG)>, /* CAN1_TX */
+				 <STM32_PINMUX('D', 0, ANALOG)>; /* CAN1_RX */
+		};
+	};
+
 	mcp23017_pins_a: mcp23017-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G', 12, GPIO)>;
-- 
2.43.0

