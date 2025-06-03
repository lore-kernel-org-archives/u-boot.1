Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435D2C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 05:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7E6829B2;
	Tue,  3 Jun 2025 07:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="hqWxIEtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE7B82045; Tue,  3 Jun 2025 07:07:30 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB96481E06
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 07:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2426dda6b=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1748927247; x=1780463247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fkt3G1quOYZInKTqErG2GeUtPGnzWLVuGqKsMKpni2c=;
 b=hqWxIEtOnAgrdx/+q+zHXQsUVbuCEOKpWmIp0Jp65PxBtuneDZKqMDF6
 VdewJGEbE6L/AwFyccfqOpcKOKEevVwOhFYGzCq7Hjtyoh3HFwH4Yu+w/
 veJzsJCnEGLqJ0Zln4zJqMSFvFc/mTSpTqTVhdEwlXKfVJGYfiXN9TjIQ
 Mm4ehgpSpp/hhJAbmQlyLE8tHufWJ/LqnwDvguxoJOWO1LKboQOT2pqda
 2PmYbTrkG3NrhFCvplHZ50VcYnn/gCAmJFqk1zQr+UeTNItqN9JchirM5
 MIXxy7dJXR8V8jIM/87eNxQ0CAF8284NmODJSjvgcPLOdozUUsviaAjQC g==;
X-CSE-ConnectionGUID: +NE9MtRQQNiKu5EdIbgrNA==
X-CSE-MsgGUID: T16UsZvVQsaxipBf+PuBEA==
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="41891734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Jun 2025 22:07:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 2 Jun 2025 22:07:05 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 2 Jun 2025 22:06:59 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <Oliver.Gaskell@analog.com>,
 <malysagreg@gmail.com>, <nathan.morrison@timesys.com>,
 <mkorpershoek@kernel.org>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <sebastian.reichel@collabora.com>,
 <duje.mihanovic@skole.hr>, <sumit.garg@kernel.org>,
 <patrice.chotard@foss.st.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v6 7/9] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
Date: Tue, 3 Jun 2025 10:35:54 +0530
Message-ID: <20250603050556.80851-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603050556.80851-1-manikandan.m@microchip.com>
References: <20250603050556.80851-1-manikandan.m@microchip.com>
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
 .../dts/at91-sam9x75_curiosity-u-boot.dtsi    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi

diff --git a/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
new file mode 100644
index 00000000000..94585ee0232
--- /dev/null
+++ b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
@@ -0,0 +1,95 @@
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

