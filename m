Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5481BC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 06:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8AD380FEC;
	Mon, 17 Mar 2025 07:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="WwzqFi5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6477281A0E; Mon, 17 Mar 2025 07:57:59 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB7880FEC
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1648c5b74=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1742194676; x=1773730676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j+1xO1NhbjsxMeqNnimztD70HXpgKNd7LqRqAdnSt3Y=;
 b=WwzqFi5Dlw8Mjw/XSEMAyH2WzoH737UPuiZ048ifiw+JnicPPv1+IOjh
 MWHKK9qrRV4+XAjtyD2BZCi7jBEl6JUlMlJcUPIe1VrVK9TMqk5BFlOyU
 igGHMkH8K+L7Dl9NAU5QsmLDTTBDDpDyQXPG363dOvwnHYdx3q81Am5bh
 9bd7cr/XfxsSLtlCulmdVDSFp2MEBfNsd+Nt4TZOS6OYMrRwXzUALUpnP
 Jy94zwN13kIyUs6CNNlOjZnDXRBL4nyB0zuNfO7D6APGcKG6Ahd68fiFh
 9aeqRWHnsitIxLvLgKxUbGeOIshNkOqSvKpQ9H4p8AkxQrGqcqXW/Bz5X g==;
X-CSE-ConnectionGUID: Sws07wq8RW+JT7IS8AtykQ==
X-CSE-MsgGUID: cRmEaOcBTYainixszzf71g==
X-IronPort-AV: E=Sophos;i="6.14,253,1736838000"; d="scan'208";a="39670427"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Mar 2025 23:57:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Mar 2025 23:57:14 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 16 Mar 2025 23:57:07 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v4 6/8] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
Date: Mon, 17 Mar 2025 12:26:07 +0530
Message-ID: <20250317065609.55071-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317065609.55071-1-manikandan.m@microchip.com>
References: <20250317065609.55071-1-manikandan.m@microchip.com>
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

