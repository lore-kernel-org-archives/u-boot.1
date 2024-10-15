Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BE3D216BF
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF5D8880F;
	Tue, 15 Oct 2024 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56664885F4; Tue, 15 Oct 2024 16:54:49 +0200 (CEST)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27D4881FD
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexey@sgainnovations.com
ARC-Seal: i=1; a=rsa-sha256; t=1729004084; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gb6fXhhwNodhEk6ALCXPeBJIj1btDp+q+b0QMVqLJ3zOMkrCDi4aPLepX/8Kt3MjWLxPAfE4I2yZcrh9WnsNK/2ANjCVARzOGbh/48NG/Wy59n4ekbToKhGiN41rX43h+l8vleiRlw1kHZs7i3diVXg3PQRE4N1VMxrulleBe+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729004084;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Jcf+HDuynU/6LI/mvgdNt2quVJwcZRgxsJDyQu/Y21s=; 
 b=bH1JBEwoxDLAbeLX8AqPDjRBFg8Ot4sKl//z4Xk/7cypRmSTYhoTWcgIx8WKdQpYzorfQxv7CDiEsBf5AInTEE29bIC5Lqc+qcGdjHg1yxCTiqIdmdJ8fEQVMriy7VBWzRz+MGa2nLXCXgwRELT56jU5CKcGpG+0dpGpl4kNQhA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=alexey@sgainnovations.com;
 dmarc=pass header.from=<alexey@all4bambi.com>
Received: by mx.zohomail.com with SMTPS id 1729004081842807.105910537354;
 Tue, 15 Oct 2024 07:54:41 -0700 (PDT)
From: Alexey Tsirlin <alexey@all4bambi.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@microchip.com,
	Alexey Tsirlin <alexey@all4bambi.com>
Subject: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside pinctrl
 as in kernel dts
Date: Tue, 15 Oct 2024 17:53:07 +0300
Message-Id: <20241015145307.118784-2-alexey@all4bambi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015145307.118784-1-alexey@all4bambi.com>
References: <20241015145307.118784-1-alexey@all4bambi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 15 Oct 2024 16:58:22 +0200
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

This allows setting the GPIO parameters from device tree, otherwise the
at91_pin_check_config will fail because the priv->nbanks equal to zero

Signed-off-by: Alexey Tsirlin <alexey@all4bambi.com>
---

 arch/arm/dts/sama5d3.dtsi | 111 +++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
index 4c03a302ec..c671ea42f2 100644
--- a/arch/arm/dts/sama5d3.dtsi
+++ b/arch/arm/dts/sama5d3.dtsi
@@ -873,66 +873,67 @@
 							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PE17 periph B, conflicts with A17 */
 					};
 				};
-			};
 
-			pioA: gpio@fffff200 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x100>;
-				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-				bootph-all;
-			};
+				pioA: gpio@fffff200 {
+				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x100>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+					bootph-all;
+				};
 
-			pioB: gpio@fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-				bootph-all;
-			};
+				pioB: gpio@fffff400 {
+				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x100>;
+					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+					bootph-all;
+				};
 
-			pioC: gpio@fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-				bootph-all;
-			};
+				pioC: gpio@fffff600 {
+				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x100>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+					bootph-all;
+				};
 
-			pioD: gpio@fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioD_clk>;
-				bootph-all;
-			};
+				pioD: gpio@fffff800 {
+				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x100>;
+					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioD_clk>;
+					bootph-all;
+				};
+
+				pioE: gpio@fffffa00 {
+				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x100>;
+					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioE_clk>;
+					bootph-all;
+				};
 
-			pioE: gpio@fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioE_clk>;
-				bootph-all;
 			};
 
 			pmc: pmc@fffffc00 {
-- 
2.34.1

