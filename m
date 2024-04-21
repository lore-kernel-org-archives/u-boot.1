Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA578C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735BD88354;
	Mon, 22 Apr 2024 01:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741554;
	bh=0ty7NCmqc2BPJFeBGg6+tuBDdKGKmnR9Cv2jaqhym/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y5d4fu9o9nTHaz7VpC4R0JkscXEYDZ5lNOqqZXa4czoviWEHTyt4TqvROXUakU7vY
	 3f9vS0HSbUqTZRy2A0mZh048S1MmrESa/TUvOQYNDReXwNxXd4abBM67dFtxuaYjoz
	 yJUvs+O+8sMG6WEYloXXbAFp0MHrKRrwn527YIE6yFT9ZTt4RyJwB/b+bN6cxI5nTD
	 UhLC/T702c7pf6Y6aDpl7n8DKv91acZ4UJMyTO6PzKtBYZfHpU69zVyCZnBnTyhWMF
	 MQKweIOGrd5FW4vDFSru/Vqn58rdULv8E6GvkAT9/rcNF9uSWXsEwRi1VkXx19RrGy
	 mcUFveFq6z1TQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3A48388317;
 Mon, 22 Apr 2024 01:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741549;
 bh=0ty7NCmqc2BPJFeBGg6+tuBDdKGKmnR9Cv2jaqhym/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VeF9x8b5AMCvpGdkKJYKRF9HeSwtIagp/fZ0TiWMP2jn0rSgb69TL5196XPesyuFa
 aybPkwGw529ifmo5v0caAXthElGgPFoSHs1noQzbGVFq8pqGZMeqAds2FS5NbguL/7
 FEzi5tsi13sW2CxSVwL5e/GSj8gqtZ+fXnDlvcZrOqRozSE4u7JA04OkZRk8JmOg5Y
 lSRCg08q+fEl9Gh8mKQtx2oh18bfb1swTW14QJdh+BGlVDD5B9avEoelSu+bjDzpQi
 LUmlrPyGVQioBW4i6nFXUESbKCp9dyL0DypWDlFPZbkMWMaawe+BJByV8noiOA5yXj
 l2b5zU86MbL1g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 07/19] ARM: dts: stm32: Add alternate pinmux for MP13 MCAN2
 pins
Date: Mon, 22 Apr 2024 01:16:53 +0200
Message-ID: <20240421231849.194648-7-marex@denx.de>
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

Add another mux option for MCAN2 pins, this is used on
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
index b38174504ff..b58bf6c0024 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -188,6 +188,26 @@
 		};
 	};
 
+	m_can2_pins_a: m-can2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 0, AF9)>; /* CAN2_TX */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 0, AF9)>; /* CAN2_RX */
+			bias-disable;
+		};
+	};
+
+	m_can2_sleep_pins_a: m_can2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 0, ANALOG)>, /* CAN2_TX */
+				 <STM32_PINMUX('E', 0, ANALOG)>; /* CAN2_RX */
+		};
+	};
+
 	mcp23017_pins_a: mcp23017-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G', 12, GPIO)>;
-- 
2.43.0

