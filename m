Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFDC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CFB81120;
	Thu, 27 Feb 2025 10:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="dEP8SDfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42222810F1; Thu, 27 Feb 2025 10:37:25 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0236A81110
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=14638ef94=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1740649040; x=1772185040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j+1xO1NhbjsxMeqNnimztD70HXpgKNd7LqRqAdnSt3Y=;
 b=dEP8SDfgVCBw7rw8CRcQQkwhUyeoU8/VMVdGveSDaJMul9kkVe19SPfu
 ZSNJX/LUL0jshSkki74t5fufSqdwRys+q9fAIrEwJ/UnSA5T4PywoCMxa
 whQ2rDXF13CE3hRJHh77MlIlP2fNES88RrCsvvZs5XKDOAIjssIAL9gL5
 OuUFomVOXgMuQROMZrj9kyr2Hs8KN1eoG9k3WEtoR6AHenqenGXEjrPXo
 IWQXbdWXl91dZhPsBA5XuyniRHg7UhteQNG13N0JVWbzC2XvE4RfgJ7VU
 K4H6Cpe24BADXvr6UkOgQG4f0Cf9iNeN/NUbd/6yKCNbGZPuU8gsHCqyA Q==;
X-CSE-ConnectionGUID: bV6+ASJCStaOcqKgVwxBjA==
X-CSE-MsgGUID: 5HiieeLNQ6OLFJTqXYR7Lg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732604400"; d="scan'208";a="269591731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2025 02:37:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 02:37:05 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 02:36:57 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, 
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>, 
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <nicolas.ferre@microchip.com>, <mihai.sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 6/8] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
Date: Thu, 27 Feb 2025 15:05:57 +0530
Message-ID: <20250227093559.797618-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227093559.797618-1-manikandan.m@microchip.com>
References: <20250227093559.797618-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Since the SoC and board DT are already available in dts/upstream,
add the difference from upstream DTS to at91-sam9x75_curiosity-u-boot.dtsi

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../dts/at91-sam9x75_curiosity-u-boot.dtsi    | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi

diff --git a/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
new file mode 100644
index 00000000000..dc4fef950ec
--- /dev/null
+++ b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sam9x75_curiosity-u-boot.dtsi - Device Tree file for SAM9X75
+ * CURIOSITY board.
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
+ */
+
+/ {
+	cpus {
+		cpu@0 {
+			clocks = <&pmc PMC_TYPE_CORE 25>, <&pmc PMC_TYPE_CORE 17>, <&main_xtal>;
+			clock-names = "cpu", "master", "xtal";
+		};
+	};
+
+	clocks {
+		slow_rc_osc: slow_rc_osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <18500>;
+		};
+
+		main_rc: main_rc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		bootph-all;
+
+		apb {
+			bootph-all;
+
+			pinctrl {
+				bootph-all;
+			};
+		};
+	};
+
+	chosen {
+		bootph-all;
+	};
+};
+
+&clk32k {
+	bootph-all;
+	clocks = <&slow_rc_osc>, <&slow_xtal>;
+};
+
+&dbgu {
+	bootph-all;
+};
+
+&gmac {
+	compatible = "microchip,sam9x7-gem", "cdns,sama7g5-gem";
+};
+
+&main_rc {
+	bootph-all;
+};
+
+&main_xtal {
+	bootph-all;
+};
+
+&pinctrl_dbgu_default {
+	bootph-all;
+};
+
+&pinctrl_sdmmc0_default {
+	bootph-all;
+};
+
+&pioA {
+	bootph-all;
+};
+
+&pioB {
+	bootph-all;
+};
+
+&pit64b0 {
+	bootph-all;
+};
+
+&pmc {
+	bootph-all;
+	clocks = <&clk32k 1>, <&clk32k 0>, <&main_xtal>, <&main_rc>;
+	clock-names = "td_slck", "md_slck", "main_xtal", "main_rc";
+};
+
+&sdmmc0 {
+	bootph-all;
+};
+
+&slow_xtal {
+	bootph-all;
+};
+
+&slow_rc_osc {
+	bootph-all;
+};
-- 
2.25.1

