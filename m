Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105A9C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E85E8321B;
	Mon,  7 Jul 2025 17:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="gW7R4A/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A39283121; Mon,  7 Jul 2025 13:42:43 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9CFB830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2768a2b95=Varshini.Rajendran@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751888561; x=1783424561;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hl8fjDLWwoPhSKxHb59lJN8fXSQUpucDuxmLspH+IwQ=;
 b=gW7R4A/hB+193WEnmBOL+sqMtG/Rk/NKP8s0tikSAyjEVaYigFnAGv16
 wAGl4KH1AE3aBCeK5Y1h02IrsSYEbSvhQP4E8+05QDPZmaUnL8uKDIEY1
 wk9Nr/loOkI46vU/9MT6+A7a770I40ddP53MzjyRSj9ZTBDv13h8sQQdI
 bgulJSosIXcovIOeNoa8tH4MoHes5AHilJdbfmd6uU6NUeoYsU9fHljCo
 zLo2SzoRxcVrRtaiiSYXPCcdvNU8C4KaaI8blr/oyOEiQRHnNyg7YCicO
 tunlA8nVFsQBSrZ8hmM52ES2xKe2jnHfhNUd5zKO/1Pw+dyPOs84d09qC A==;
X-CSE-ConnectionGUID: /qwYxraSSkyhpAAbAES/lg==
X-CSE-MsgGUID: /jUeVGb+TKCIp4uEOtrS2A==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="44272048"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Jul 2025 04:42:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 04:41:58 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 7 Jul 2025 04:41:57 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <varshini.rajendran@microchip.com>,
 <Ryan.Wanner@microchip.com>, <u-boot@lists.denx.de>
Subject: [PATCH 4/6] ARM: dts: at91: sama7d65-curiosity: Add DT tweaks for
 sama7d65-curiosity board
Date: Mon, 7 Jul 2025 17:05:54 +0530
Message-ID: <20250707113554.4133291-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
References: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 07 Jul 2025 17:54:47 +0200
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add u-boot device tree and tweaks for sama7d65-curiosity board on top of
the upstream DTS files in dts/upstream.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
[varshini.rajendran@microchip.com: align with Linux DT and add tweaks]
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../dts/at91-sama7d65_curiosity-u-boot.dtsi   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi

diff --git a/arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi
new file mode 100644
index 00000000000..343f10cdf9a
--- /dev/null
+++ b/arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ *  at91-sama7d65_curiosity-u-boot.dtsi - Device Tree Include file for
+ *  SAMA7D65 CURIOSITY.
+ *
+ *  Copyright (c) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ *  Author: Ryan Wanner <ryan.wanner@microchip.com>
+ */
+
+/{
+	aliases {
+		serial0 = &uart6;
+	};
+
+	chosen {
+		bootph-all;
+	};
+
+	clocks {
+		slow_rc_osc: slow_rc_osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+	};
+
+	cpus {
+		cpu@0 {
+			clocks = <&pmc PMC_TYPE_CORE 8>, <&pmc PMC_TYPE_CORE 26>, <&main_xtal>;
+			clock-names = "cpu", "master", "xtal";
+		};
+	};
+
+	soc {
+		bootph-all;
+	};
+};
+
+&clk32k {
+	clocks = <&slow_rc_osc>, <&slow_xtal>;
+};
+
+&main_xtal {
+	bootph-all;
+};
+
+&pioa {
+	bootph-all;
+};
+
+&pinctrl_uart6_default {
+	bootph-all;
+};
+
+&pit64b0 {
+	bootph-all;
+};
+
+&pmc {
+	bootph-all;
+};
+
+&sdmmc1 {
+	assigned-clock-parents = <&pmc PMC_TYPE_CORE 27>; /* MCK1 div */
+	microchip,sdcal-inverted;
+	no-1-8-v;
+};
+
+&slow_rc_osc {
+	bootph-all;
+};
+
+&slow_xtal {
+	bootph-all;
+};
+
+&uart6 {
+	bootph-all;
+};
-- 
2.45.2

