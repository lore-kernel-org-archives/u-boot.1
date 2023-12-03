Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBA2C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49586877B1;
	Sun,  3 Dec 2023 14:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="f9PzoruR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="URk0DBNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD1D87661; Sun,  3 Dec 2023 14:17:17 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1CA875EB
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SjnQM2z0qz9sWt;
 Sun,  3 Dec 2023 14:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxnkmC/Q3h6n3tTaRd4zMfUYnF9HCyz3Ni2nLD3GKH4=;
 b=f9PzoruRr8DhmBY9NqrmFbBZpWV/4CWl6L3ZYuQfrHbgeae8IcLp4QehB8ljn9VXpwi+ag
 IvbNGKerpyYclGpU3Qmmfv8K+535L8Ce5+gmootIHqXTdlGO6JjK5RXH0doJgTJCAzPJyR
 csnoyxmPseS85CNeRpWc3lC1Mun9ZuzoJGlucZn/LF6/ZgsGvOf+oRS0EjP2sVLLkItIlU
 cFNeRDIBYwyjDqyHedJfAJazIwWqU8377GUQHEe8hP+XNSk00SH1gy1TA+QTrMbhGlimUB
 O54+JVdlabgJiGn/lOQEUtVhAYZ+Jm2u0SxrCWtkbJn3ppit9rj/C1PQVuGp/Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxnkmC/Q3h6n3tTaRd4zMfUYnF9HCyz3Ni2nLD3GKH4=;
 b=URk0DBNef0mK3F7TH4VEwGWnZ/Foe4IuUVsBJmXQbfACtm2uzH3pa8OGpMcpnpmKY/nnt+
 mlOjJQy8OVDMri8KiqpsSKzIgLDTrUI8ed5p6wy81zpq6JtKYKHJpxn0bTIBm97JgiAp54
 36IuJejNajlkLNqFY1payMundQimZSoRkDieUZ/AMOZlWPz3jxyVHn5Wnb361Z61tNR+dq
 kicArwvWLl+R9+KHSRFrPcEGLdG49J4a1ugLxG2+gzuzcqp2hFGVOxoE0Y+OlAhOjfLJB5
 lHT9vsqFU84FIcSKCZWCQGjhoAd5W6UNdghb2727fl06TpYQGfzknyWguKKlCw==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/12] ARM: dts: renesas: Synchronize R-Car R8A779F0 S4 DTs
 with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:24 +0100
Message-ID: <20231203131635.119191-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 106d228fc4a2c0fe0ed
X-MBO-RS-META: 5sesp87ke6fibyithrkksxw3qw7gixoy
X-Rspamd-Queue-Id: 4SjnQM2z0qz9sWt
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

Synchronize R-Car R8A779F0 S4 DTs with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a779f0-spider-cpu.dtsi | 22 +++++++++++++++++++++-
 arch/arm/dts/r8a779f0-spider.dts      |  2 +-
 arch/arm/dts/r8a779f0.dtsi            | 17 ++++++++++++++++-
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/r8a779f0-spider-cpu.dtsi b/arch/arm/dts/r8a779f0-spider-cpu.dtsi
index dd8e0e15952..5cbde8e8fcd 100644
--- a/arch/arm/dts/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm/dts/r8a779f0-spider-cpu.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Spider CPU board
  *
@@ -6,6 +6,8 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
 #include "r8a779f0.dtsi"
 
 / {
@@ -22,6 +24,24 @@
 		stdout-path = "serial0:1843200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-7 {
+			gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <7>;
+		};
+
+		led-8 {
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <8>;
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
diff --git a/arch/arm/dts/r8a779f0-spider.dts b/arch/arm/dts/r8a779f0-spider.dts
index 7aac3f4d319..f139cc4feb3 100644
--- a/arch/arm/dts/r8a779f0-spider.dts
+++ b/arch/arm/dts/r8a779f0-spider.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the Spider CPU and BreakOut boards
  *
diff --git a/arch/arm/dts/r8a779f0.dtsi b/arch/arm/dts/r8a779f0.dtsi
index 1d5426e6293..ecdd5a523fa 100644
--- a/arch/arm/dts/r8a779f0.dtsi
+++ b/arch/arm/dts/r8a779f0.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Source for the R-Car S4-8 (R8A779F0) SoC
  *
@@ -466,6 +466,21 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		intc_ex: interrupt-controller@e61c0000 {
+			compatible = "renesas,intc-ex-r8a779f0", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_CORE R8A779F0_CLK_CL16M>;
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+		};
+
 		tmu0: timer@e61e0000 {
 			compatible = "renesas,tmu-r8a779f0", "renesas,tmu";
 			reg = <0 0xe61e0000 0 0x30>;
-- 
2.42.0

