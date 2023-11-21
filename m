Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02FCC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1283387602;
	Tue, 21 Nov 2023 20:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YbY6c5j2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FCD875FB; Tue, 21 Nov 2023 18:10:08 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2CA87663
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso29929315e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586587; x=1701191387; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8QZ4BW+zxSbvqE1g0Ii6vhmEIZUvLgdB36qMaxFqJUs=;
 b=YbY6c5j2yUHIw+FNeZQpTKmIRe0U0O7L3rGbJS77Ql2ecRilGo6zq5V6hiQSA8julD
 NUx5sE6ofuMP8/YXdmWm7PB2w9rwz8h5mT0u4Ysn7B2pLJGv0Uejvpz3apocezjj+mxu
 cjb1w6/rqmJc5JbvUMUNqsp7ajS5izyxBsTg6SsdJIkxFx/9Sm7S3F4buMzdyRJ0k4AF
 GlMzVRNZjhcVVkeGo3CGC2rCgoJFtUHsYyEkaCJdpVrIlX4Ra4dwm1q5Ma7RhM5khTnc
 STGnT08/EUO7BzG4WRr+EsdAlLSLsk3QcvH1xbXEi78uw61WkkOk+OLDEd12FMHwzyJg
 5orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586587; x=1701191387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QZ4BW+zxSbvqE1g0Ii6vhmEIZUvLgdB36qMaxFqJUs=;
 b=aDKJh3Uox/LdZz50zi9NgabGNRgNNSpEfUbpLg9YfQKQqO8bRzjcU4MUpWHdjUqMO8
 td9w2V6e02mUMhzFsnRXnuC8nu7I48frZbYOnOzIbQnciWmkDCDg/mpnSi9LnMQ5Hir7
 SGTUGu10T1zdRiloANCo0Tqlt4kQXWmbVcXB8FYuz2+ro8P8hhV8UKQb7e/2QDkMeiQZ
 G+l6IivVJZe/YkUlfzWnKhLEtuLUICEHAboF1e7RNum8alKydaHSuJxOJZd1d4z2LyxS
 Ls0H/0KFuSiJbI9Bj4udVyq4s5Y7AhgIpPa93TIwZ6V2BzNqsyUuv5gvogwQG29HiqZL
 HEvg==
X-Gm-Message-State: AOJu0YwbkespNVYYo0ua4fz818vpyRDN5/YBX5CH09qwwY39aex5XENx
 ROAyAdZz7TjD/qqiL9iQfycSgA==
X-Google-Smtp-Source: AGHT+IF/ajxknCYOp3pr++OcaPZ0wNilSDaE3xqurkP/yuTf/AKNoaug8tarFeN4lCIZeBd6Up7YQg==
X-Received: by 2002:a05:600c:1d23:b0:40a:4c7e:6f3e with SMTP id
 l35-20020a05600c1d2300b0040a4c7e6f3emr8863747wms.21.1700586586086; 
 Tue, 21 Nov 2023 09:09:46 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:45 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:40 +0000
Subject: [PATCH 17/21] dts: sdm845: import DT from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-17-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=214056;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=B32hTmCZPRhUa9ZSp0sHDxCRBo56UoyqRD+vibH2JCM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ+6eO/l5dvUkqzSdMj4c3T/NVYrjmMXPquhake5/b
 feP/73ZUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACayPpeRYe9xkUDPBX7Ho/U7
 nK/H3OoKetFhpnE+Zgq/jPLmgN3fGxgZVsl7Kos825r0552f1NoJRZ/8nW9/+vfyyZJ/MZeZa1i
 V+AE=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Tue, 21 Nov 2023 20:46:01 +0100
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

With driver support improved, replace the u-boot specific devicetrees
for SDM845 targets with the Linux DT for the same. The devicetree and
include files are pulled in directly from Linux 6.5-rc5 and should be
kept in-sync as needed, not modified.

Adjust the dragonboard845c and starqltechn DTS files to support these
changes.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard845c-uboot.dtsi         |   26 -
 arch/arm/dts/dragonboard845c.dts                |   23 +-
 arch/arm/dts/pm8998.dtsi                        |  130 +
 arch/arm/dts/sdm845.dtsi                        | 5850 ++++++++++++++++++++++-
 arch/arm/dts/starqltechn-uboot.dtsi             |   27 -
 arch/arm/dts/starqltechn.dts                    |   34 +-
 include/dt-bindings/clock/qcom,camcc-sdm845.h   |  116 +
 include/dt-bindings/clock/qcom,dispcc-sdm845.h  |   56 +
 include/dt-bindings/clock/qcom,gpucc-sdm845.h   |   24 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h   |   15 +
 include/dt-bindings/clock/qcom,rpmh.h           |   37 +
 include/dt-bindings/clock/qcom,videocc-sdm845.h |   35 +
 include/dt-bindings/dma/qcom-gpi.h              |   11 +
 include/dt-bindings/firmware/qcom,scm.h         |   18 +
 include/dt-bindings/iio/qcom,spmi-vadc.h        |  300 ++
 include/dt-bindings/interconnect/qcom,osm-l3.h  |   15 +
 include/dt-bindings/interconnect/qcom,sdm845.h  |  150 +
 include/dt-bindings/phy/phy-qcom-qusb2.h        |   37 +
 include/dt-bindings/power/qcom-rpmpd.h          |  412 ++
 include/dt-bindings/reset/qcom,sdm845-aoss.h    |   17 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h     |   22 +
 include/dt-bindings/soc/qcom,apr.h              |   28 +
 include/dt-bindings/soc/qcom,rpmh-rsc.h         |   14 +
 23 files changed, 7223 insertions(+), 174 deletions(-)

diff --git a/arch/arm/dts/dragonboard845c-uboot.dtsi b/arch/arm/dts/dragonboard845c-uboot.dtsi
deleted file mode 100644
index 775f45c0149f..000000000000
--- a/arch/arm/dts/dragonboard845c-uboot.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * U-Boot addition to handle Qualcomm Robotics RB3 Development Platform
- * (dragonboard845c) pins
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-/
-{
-	soc {
-		bootph-all;
-
-		serial@a84000 {
-			bootph-all;
-		};
-
-		clock-controller@100000 {
-			bootph-all;
-		};
-
-		pinctrl@3400000 {
-			bootph-all;
-		};
-	};
-};
diff --git a/arch/arm/dts/dragonboard845c.dts b/arch/arm/dts/dragonboard845c.dts
index 054f253eb32a..5e2ef761473c 100644
--- a/arch/arm/dts/dragonboard845c.dts
+++ b/arch/arm/dts/dragonboard845c.dts
@@ -9,12 +9,11 @@
 /dts-v1/;
 
 #include "sdm845.dtsi"
+#include "pm8998.dtsi"
 
 / {
 	model = "Thundercomm Dragonboard 845c";
 	compatible = "thundercomm,db845c", "qcom,sdm845";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -23,26 +22,12 @@
 	aliases {
 		serial0 = &uart9;
 	};
-
-	memory {
-		device_type = "memory";
-		reg = <0 0x80000000 0 0xfdfa0000>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	soc: soc {
-		serial@a84000 {
-			status = "okay";
-		};
-	};
 };
 
 &pm8998_resin {
 	status = "okay";
 };
 
-#include "dragonboard845c-uboot.dtsi"
+&uart9 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/pm8998.dtsi b/arch/arm/dts/pm8998.dtsi
new file mode 100644
index 000000000000..695d79116cde
--- /dev/null
+++ b/arch/arm/dts/pm8998.dtsi
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/* Copyright 2018 Google LLC. */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		pm8998-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8998_temp>;
+
+			trips {
+				pm8998_alert0: pm8998-alert0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pm8998_lsid0: pmic@0 {
+		compatible = "qcom,pm8998", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8998_pon: pon@800 {
+			compatible = "qcom,pm8998-pon";
+
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pm8998_pwrkey: pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+
+			pm8998_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		pm8998_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8998_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8998_coincell: charger@2800 {
+			compatible = "qcom,pm8998-coincell", "qcom,pm8941-coincell";
+			reg = <0x2800>;
+
+			status = "disabled";
+		};
+
+		pm8998_adc: adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			adc-chan@6 {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
+		};
+
+		pm8998_adc_tm: adc-tm@3400 {
+			compatible = "qcom,spmi-adc-tm-hc";
+			reg = <0x3400>;
+			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm8998_gpios: gpio@c000 {
+			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8998_gpios 0 0 26>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+	};
+
+	pm8998_lsid1: pmic@1 {
+		compatible = "qcom,pm8998", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index 96c9749a52c0..a18884bdacdf 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -1,119 +1,5811 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Qualcomm SDM845 chip device tree source
- *
- * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
+ * SDM845 SoC device tree source
  *
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copied from Linux @ 6.5-rc5
  */
 
-/dts-v1/;
-
+#include <dt-bindings/clock/qcom,camcc-sdm845.h>
+#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
-#include "skeleton64.dtsi"
+#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
+#include <dt-bindings/clock/qcom,lpass-sdm845.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,videocc-sdm845.h>
+#include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/reset/qcom,sdm845-aoss.h>
+#include <dt-bindings/reset/qcom,sdm845-pdc.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
-	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+		i2c14 = &i2c14;
+		i2c15 = &i2c15;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi4 = &spi4;
+		spi5 = &spi5;
+		spi6 = &spi6;
+		spi7 = &spi7;
+		spi8 = &spi8;
+		spi9 = &spi9;
+		spi10 = &spi10;
+		spi11 = &spi11;
+		spi12 = &spi12;
+		spi13 = &spi13;
+		spi14 = &spi14;
+		spi15 = &spi15;
+	};
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <38400000>;
+			clock-output-names = "xo_board";
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+		};
+	};
+
+	cpus: cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+				L3_0: l3-cache {
+					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
+				};
+			};
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_100>;
+			L2_100: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_200>;
+			L2_200: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			#cooling-cells = <2>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
+			next-level-cache = <&L2_300>;
+			L2_300: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <442>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_400>;
+			L2_400: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <442>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_500>;
+			L2_500: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <442>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_600>;
+			L2_600: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <442>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_700>;
+			L2_700: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+
+				core4 {
+					cpu = <&CPU4>;
+				};
+
+				core5 {
+					cpu = <&CPU5>;
+				};
+
+				core6 {
+					cpu = <&CPU6>;
+				};
+
+				core7 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		cpu_idle_states: idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <350>;
+				exit-latency-us = <461>;
+				min-residency-us = <1890>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <264>;
+				exit-latency-us = <621>;
+				min-residency-us = <952>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x4100c244>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9987>;
+			};
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-sdm845", "qcom,scm";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0x80000000 0 0>;
+	};
+
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <800000 4800000>;
+		};
+
+		cpu0_opp2: opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			opp-peak-kBps = <800000 4800000>;
+		};
+
+		cpu0_opp3: opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-peak-kBps = <800000 6451200>;
+		};
+
+		cpu0_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <800000 6451200>;
+		};
+
+		cpu0_opp5: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <800000 7680000>;
+		};
+
+		cpu0_opp6: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-peak-kBps = <1804000 9216000>;
+		};
+
+		cpu0_opp7: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <1804000 9216000>;
+		};
+
+		cpu0_opp8: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <1804000 10444800>;
+		};
+
+		cpu0_opp9: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-peak-kBps = <1804000 11980800>;
+		};
+
+		cpu0_opp10: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <1804000 11980800>;
+		};
+
+		cpu0_opp11: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <2188000 13516800>;
+		};
+
+		cpu0_opp12: opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-peak-kBps = <2188000 15052800>;
+		};
+
+		cpu0_opp13: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <2188000 16588800>;
+		};
+
+		cpu0_opp14: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			opp-peak-kBps = <3072000 18124800>;
+		};
+
+		cpu0_opp15: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <3072000 19353600>;
+		};
+
+		cpu0_opp16: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <4068000 19353600>;
+		};
+
+		cpu0_opp17: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			opp-peak-kBps = <4068000 20889600>;
+		};
+
+		cpu0_opp18: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			opp-peak-kBps = <4068000 22425600>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <800000 4800000>;
+		};
+
+		cpu4_opp2: opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			opp-peak-kBps = <800000 4800000>;
+		};
+
+		cpu4_opp3: opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-peak-kBps = <1804000 4800000>;
+		};
+
+		cpu4_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <1804000 4800000>;
+		};
+
+		cpu4_opp5: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <1804000 4800000>;
+		};
+
+		cpu4_opp6: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-peak-kBps = <1804000 4800000>;
+		};
+
+		cpu4_opp7: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <2188000 9216000>;
+		};
+
+		cpu4_opp8: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <2188000 9216000>;
+		};
+
+		cpu4_opp9: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-peak-kBps = <2188000 9216000>;
+		};
+
+		cpu4_opp10: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <3072000 9216000>;
+		};
+
+		cpu4_opp11: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <3072000 11980800>;
+		};
+
+		cpu4_opp12: opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <4068000 11980800>;
+		};
+
+		cpu4_opp13: opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <4068000 11980800>;
+		};
+
+		cpu4_opp14: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <4068000 15052800>;
+		};
+
+		cpu4_opp15: opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <4068000 15052800>;
+		};
+
+		cpu4_opp16: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <5412000 15052800>;
+		};
+
+		cpu4_opp17: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <5412000 15052800>;
+		};
+
+		cpu4_opp18: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			opp-peak-kBps = <5412000 19353600>;
+		};
+
+		cpu4_opp19: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			opp-peak-kBps = <6220000 19353600>;
+		};
+
+		cpu4_opp20: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <6220000 19353600>;
+		};
+
+		cpu4_opp21: opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-peak-kBps = <7216000 19353600>;
+		};
+
+		cpu4_opp22: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-peak-kBps = <7216000 20889600>;
+		};
+
+		cpu4_opp23: opp-2092800000 {
+			opp-hz = /bits/ 64 <2092800000>;
+			opp-peak-kBps = <7216000 20889600>;
+		};
+
+		cpu4_opp24: opp-2169600000 {
+			opp-hz = /bits/ 64 <2169600000>;
+			opp-peak-kBps = <7216000 20889600>;
+		};
+
+		cpu4_opp25: opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			opp-peak-kBps = <7216000 20889600>;
+		};
+
+		cpu4_opp26: opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			opp-peak-kBps = <7216000 20889600>;
+		};
+
+		cpu4_opp27: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <7216000 22425600>;
+		};
+
+		cpu4_opp28: opp-2476800000 {
+			opp-hz = /bits/ 64 <2476800000>;
+			opp-peak-kBps = <7216000 22425600>;
+		};
+
+		cpu4_opp29: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			opp-peak-kBps = <7216000 22425600>;
+		};
+
+		cpu4_opp30: opp-2649600000 {
+			opp-hz = /bits/ 64 <2649600000>;
+			opp-peak-kBps = <7216000 22425600>;
+		};
+
+		cpu4_opp31: opp-2745600000 {
+			opp-hz = /bits/ 64 <2745600000>;
+			opp-peak-kBps = <7216000 25497600>;
+		};
+
+		cpu4_opp32: opp-2803200000 {
+			opp-hz = /bits/ 64 <2803200000>;
+			opp-peak-kBps = <7216000 25497600>;
+		};
+	};
+
+	dsi_opp_table: opp-table-dsi {
+		compatible = "operating-points-v2";
+
+		opp-19200000 {
+			opp-hz = /bits/ 64 <19200000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-180000000 {
+			opp-hz = /bits/ 64 <180000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-328580000 {
+			opp-hz = /bits/ 64 <328580000>;
+			required-opps = <&rpmhpd_opp_svs_l1>;
+		};
+
+		opp-358000000 {
+			opp-hz = /bits/ 64 <358000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
+	qspi_opp_table: opp-table-qspi {
+		compatible = "operating-points-v2";
+
+		opp-19200000 {
+			opp-hz = /bits/ 64 <19200000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
+	qup_opp_table: opp-table-qup {
+		compatible = "operating-points-v2";
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-128000000 {
+			opp-hz = /bits/ 64 <128000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci: psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: power-domain-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: hyp-mem@85700000 {
+			reg = <0 0x85700000 0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: xbl-mem@85e00000 {
+			reg = <0 0x85e00000 0 0x100000>;
+			no-map;
+		};
+
+		aop_mem: aop-mem@85fc0000 {
+			reg = <0 0x85fc0000 0 0x20000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x85fe0000 0 0x20000>;
+			no-map;
+		};
+
+		smem@86000000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x86000000 0 0x200000>;
+			no-map;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
+		tz_mem: tz@86200000 {
+			reg = <0 0x86200000 0 0x2d00000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs@88f00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0x88f00000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		qseecom_mem: qseecom@8ab00000 {
+			reg = <0 0x8ab00000 0 0x1400000>;
+			no-map;
+		};
+
+		camera_mem: camera-mem@8bf00000 {
+			reg = <0 0x8bf00000 0 0x500000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: gpu@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@8c500000 {
+			reg = <0 0x8c500000 0 0x1a00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: wlan-msa@8df00000 {
+			reg = <0 0x8df00000 0 0x100000>;
+			no-map;
+		};
+
+		mpss_region: mpss@8e000000 {
+			reg = <0 0x8e000000 0 0x7800000>;
+			no-map;
+		};
+
+		venus_mem: venus@95800000 {
+			reg = <0 0x95800000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp@95d00000 {
+			reg = <0 0x95d00000 0 0x800000>;
+			no-map;
+		};
+
+		mba_region: mba@96500000 {
+			reg = <0 0x96500000 0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: slpi@96700000 {
+			reg = <0 0x96700000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: spss@97b00000 {
+			reg = <0 0x97b00000 0 0x100000>;
+			no-map;
+		};
+
+		mdata_mem: mpss-metadata {
+			alloc-ranges = <0 0xa0000000 0 0x20000000>;
+			size = <0 0x4000>;
+			no-map;
+		};
+
+		cont_splash_mem: framebuffer@9d400000 {
+			reg = <0 0x9d400000 0 0x2400000>;
+			no-map;
+		};
+
+		fastrpc_mem: fastrpc {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
+			alignment = <0x0 0x400000>;
+			size = <0x0 0x1000000>;
+			reusable;
+		};
+	};
+
+	adsp_pas: remoteproc-adsp {
+		compatible = "qcom,sdm845-adsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		memory-region = <&adsp_mem>;
+
+		qcom,qmp = <&aoss_qmp>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+			label = "lpass";
+			qcom,remote-pid = <2>;
+			mboxes = <&apss_shared 8>;
+
+			apr {
+				compatible = "qcom,apr-v2";
+				qcom,glink-channels = "apr_audio_svc";
+				qcom,domain = <APR_DOMAIN_ADSP>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				qcom,intents = <512 20>;
+
+				service@3 {
+					reg = <APR_SVC_ADSP_CORE>;
+					compatible = "qcom,q6core";
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+				};
+
+				q6afe: service@4 {
+					compatible = "qcom,q6afe";
+					reg = <APR_SVC_AFE>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					q6afedai: dais {
+						compatible = "qcom,q6afe-dais";
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6asm: service@7 {
+					compatible = "qcom,q6asm";
+					reg = <APR_SVC_ASM>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					q6asmdai: dais {
+						compatible = "qcom,q6asm-dais";
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#sound-dai-cells = <1>;
+						iommus = <&apps_smmu 0x1821 0x0>;
+					};
+				};
+
+				q6adm: service@8 {
+					compatible = "qcom,q6adm";
+					reg = <APR_SVC_ADM>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					q6routing: routing {
+						compatible = "qcom,q6adm-routing";
+						#sound-dai-cells = <0>;
+					};
+				};
+
+				q6mvm: apr-service@9 {
+					compatible = "qcom,q6mvm";
+					reg = <APR_SVC_ADSP_MVM>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					status = "disabled";
+
+					q6voicedai: dais {
+						compatible = "qcom,q6voice-dais";
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6cvs: apr-service@a {
+					compatible = "qcom,q6cvs";
+					reg = <APR_SVC_ADSP_CVS>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					status = "disabled";
+				};
+
+				q6cvp: apr-service@b {
+					compatible = "qcom,q6cvp";
+					reg = <APR_SVC_ADSP_CVP>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					status = "disabled";
+				};
+			};
+
+			fastrpc {
+				compatible = "qcom,fastrpc";
+				qcom,glink-channels = "fastrpcglink-apps-dsp";
+				label = "adsp";
+				qcom,non-secure-domain;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				compute-cb@3 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <3>;
+					iommus = <&apps_smmu 0x1823 0x0>;
+				};
+
+				compute-cb@4 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <4>;
+					iommus = <&apps_smmu 0x1824 0x0>;
+				};
+			};
+		};
+	};
+
+	cdsp_pas: remoteproc-cdsp {
+		compatible = "qcom,sdm845-cdsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		memory-region = <&cdsp_mem>;
+
+		qcom,qmp = <&aoss_qmp>;
+
+		qcom,smem-states = <&cdsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>;
+			label = "turing";
+			qcom,remote-pid = <5>;
+			mboxes = <&apss_shared 4>;
+			fastrpc {
+				compatible = "qcom,fastrpc";
+				qcom,glink-channels = "fastrpcglink-apps-dsp";
+				label = "cdsp";
+				qcom,non-secure-domain;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				compute-cb@1 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <1>;
+					iommus = <&apps_smmu 0x1401 0x30>;
+				};
+
+				compute-cb@2 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <2>;
+					iommus = <&apps_smmu 0x1402 0x30>;
+				};
+
+				compute-cb@3 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <3>;
+					iommus = <&apps_smmu 0x1403 0x30>;
+				};
+
+				compute-cb@4 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <4>;
+					iommus = <&apps_smmu 0x1404 0x30>;
+				};
+
+				compute-cb@5 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <5>;
+					iommus = <&apps_smmu 0x1405 0x30>;
+				};
+
+				compute-cb@6 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <6>;
+					iommus = <&apps_smmu 0x1406 0x30>;
+				};
+
+				compute-cb@7 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <7>;
+					iommus = <&apps_smmu 0x1407 0x30>;
+				};
+
+				compute-cb@8 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <8>;
+					iommus = <&apps_smmu 0x1408 0x30>;
+				};
+			};
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apss_shared 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lpass {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apss_shared 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apss_shared 14>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+		interrupts = <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apss_shared 26>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		slpi_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		slpi_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
 		compatible = "simple-bus";
 
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sdm845";
-			reg = <0x100000 0x1f0000>;
+			reg = <0 0x00100000 0 0x1f0000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>,
+				 <&pcie0_lane>,
+				 <&pcie1_lane>;
+			clock-names = "bi_tcxo",
+				      "bi_tcxo_ao",
+				      "sleep_clk",
+				      "pcie_0_pipe_clk",
+				      "pcie_1_pipe_clk";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 		};
 
-		tlmm: pinctrl@3400000 {
-			compatible = "qcom,sdm845-pinctrl";
-			reg = <0x3400000 0xc00000>;
-			gpio-count = <150>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 150>;
+		qfprom@784000 {
+			compatible = "qcom,sdm845-qfprom", "qcom,qfprom";
+			reg = <0 0x00784000 0 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 
-			/* DEBUG UART */
-			qup_uart9: qup-uart9-default {
-				pins = "GPIO_4", "GPIO_5";
-				function = "qup9";
+			qusb2p_hstx_trim: hstx-trim-primary@1eb {
+				reg = <0x1eb 0x1>;
+				bits = <1 4>;
 			};
+
+			qusb2s_hstx_trim: hstx-trim-secondary@1eb {
+				reg = <0x1eb 0x2>;
+				bits = <6 4>;
+			};
+		};
+
+		rng: rng@793000 {
+			compatible = "qcom,prng-ee";
+			reg = <0 0x00793000 0 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		gpi_dma0: dma-controller@800000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sdm845-gpi-dma";
+			reg = <0 0x00800000 0 0x60000>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <13>;
+			dma-channel-mask = <0xfa>;
+			iommus = <&apps_smmu 0x0016 0x0>;
+			status = "disabled";
+		};
+
+		qupv3_id_0: geniqup@8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0 0x008c0000 0 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>;
+			interconnect-names = "qup-core";
+			status = "disabled";
+
+			i2c0: i2c@880000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00880000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi0: spi@880000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00880000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart0: serial@880000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00880000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c1: i2c@884000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00884000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi1: spi@884000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00884000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart1: serial@884000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00884000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c2: i2c@888000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00888000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi2: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00888000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart2: serial@888000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00888000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c3: i2c@88c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x0088c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi3: spi@88c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0088c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart3: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x0088c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c4: i2c@890000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00890000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi4: spi@890000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00890000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart4: serial@890000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00890000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c5: i2c@894000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00894000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi5: spi@894000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00894000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart5: serial@894000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00894000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c6: i2c@898000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi6: spi@898000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart6: serial@898000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c7: i2c@89c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x0089c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				status = "disabled";
+			};
+
+			spi7: spi@89c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0089c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart7: serial@89c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x0089c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+		};
+
+		gpi_dma1: dma-controller@a00000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sdm845-gpi-dma";
+			reg = <0 0x00a00000 0 0x60000>;
+			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <13>;
+			dma-channel-mask = <0xfa>;
+			iommus = <&apps_smmu 0x06d6 0x0>;
+			status = "disabled";
 		};
 
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x00ac0000 0x6000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			reg = <0 0x00ac0000 0 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x6c3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>;
+			interconnect-names = "qup-core";
+			status = "disabled";
 
-			uart9: serial@a84000 {
-				compatible = "qcom,geni-debug-uart";
-				reg = <0xa84000 0x4000>;
+			i2c8: i2c@a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a80000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi8: spi@a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a80000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart8: serial@a80000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a80000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c9: i2c@a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_uart9>;
+				pinctrl-0 = <&qup_i2c9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi9: spi@a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a84000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart9: serial@a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0 0x00a84000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a88000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi10: spi@a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a88000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart10: serial@a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a88000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c11: i2c@a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi11: spi@a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart11: serial@a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c12: i2c@a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a90000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi12: spi@a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a90000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart12: serial@a90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a90000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c13: i2c@a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a94000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi13: spi@a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a94000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart13: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a94000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c14: i2c@a98000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a98000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c14_default>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi14: spi@a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a98000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi14_default>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart14: serial@a98000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a98000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart14_default>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c15: i2c@a9c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a9c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c15_default>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				status = "disabled";
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+			};
+
+			spi15: spi@a9c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a9c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi15_default>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			uart15: serial@a9c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a9c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart15_default>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
 			};
 		};
 
-		spmi@c440000 {
+		llcc: system-cache-controller@1100000 {
+			compatible = "qcom,sdm845-llcc";
+			reg = <0 0x01100000 0 0x45000>, <0 0x01180000 0 0x50000>,
+			      <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+			      <0 0x01300000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
+			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		dma@10a2000 {
+			compatible = "qcom,sdm845-dcc", "qcom,dcc";
+			reg = <0x0 0x010a2000 0x0 0x1000>,
+			      <0x0 0x010ae000 0x0 0x2000>;
+		};
+
+		pmu@114a000 {
+			compatible = "qcom,sdm845-llcc-bwmon";
+			reg = <0 0x0114a000 0 0x1000>;
+			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc SLAVE_EBI1 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect path bandwidth taken from
+				 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
+				 * interconnect.  This also matches the
+				 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
+				 * bus width: 4 bytes) from msm-4.9 downstream
+				 * kernel.
+				 */
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <5412000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
+		pmu@1436400 {
+			compatible = "qcom,sdm845-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x01436400 0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect path bandwidth taken from
+				 * cpu4_opp_table bandwidth for OSM L3
+				 * interconnect.  This also matches the OSM L3
+				 * from bandwidth table of qcom,cpu4-l3lat-mon
+				 * (qcom,core-dev-table, bus width: 16 bytes)
+				 * from msm-4.9 downstream kernel.
+				 */
+				opp-0 {
+					opp-peak-kBps = <4800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <9216000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <15052800>;
+				};
+				opp-3 {
+					opp-peak-kBps = <20889600>;
+				};
+				opp-4 {
+					opp-peak-kBps = <25497600>;
+				};
+			};
+		};
+
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-sdm845";
+			reg = <0 0x01c00000 0 0x2000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60100000 0 0x100000>,
+			      <0 0x01c07000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "config", "mhi";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0xd00000>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			iommu-map = <0x0   &apps_smmu 0x1c10 0x1>,
+				    <0x100 &apps_smmu 0x1c11 0x1>,
+				    <0x200 &apps_smmu 0x1c12 0x1>,
+				    <0x300 &apps_smmu 0x1c13 0x1>,
+				    <0x400 &apps_smmu 0x1c14 0x1>,
+				    <0x500 &apps_smmu 0x1c15 0x1>,
+				    <0x600 &apps_smmu 0x1c16 0x1>,
+				    <0x700 &apps_smmu 0x1c17 0x1>,
+				    <0x800 &apps_smmu 0x1c18 0x1>,
+				    <0x900 &apps_smmu 0x1c19 0x1>,
+				    <0xa00 &apps_smmu 0x1c1a 0x1>,
+				    <0xb00 &apps_smmu 0x1c1b 0x1>,
+				    <0xc00 &apps_smmu 0x1c1c 0x1>,
+				    <0xd00 &apps_smmu 0x1c1d 0x1>,
+				    <0xe00 &apps_smmu 0x1c1e 0x1>,
+				    <0xf00 &apps_smmu 0x1c1f 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sdm845-qmp-pcie-phy";
+			reg = <0 0x01c06000 0 0x18c>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
+				 <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie0_lane: phy@1c06200 {
+				reg = <0 0x01c06200 0 0x128>,
+				      <0 0x01c06400 0 0x1fc>,
+				      <0 0x01c06800 0 0x218>,
+				      <0 0x01c06600 0 0x70>;
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk";
+			};
+		};
+
+		pcie1: pci@1c08000 {
+			compatible = "qcom,pcie-sdm845";
+			reg = <0 0x01c08000 0 0x2000>,
+			      <0 0x40000000 0 0xf1d>,
+			      <0 0x40000f20 0 0xa8>,
+			      <0 0x40100000 0 0x100000>,
+			      <0 0x01c0c000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "config", "mhi";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+
+			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+				 <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_CLKREF_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ref",
+				      "tbu";
+
+			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
+				    <0x100 &apps_smmu 0x1c01 0x1>,
+				    <0x200 &apps_smmu 0x1c02 0x1>,
+				    <0x300 &apps_smmu 0x1c03 0x1>,
+				    <0x400 &apps_smmu 0x1c04 0x1>,
+				    <0x500 &apps_smmu 0x1c05 0x1>,
+				    <0x600 &apps_smmu 0x1c06 0x1>,
+				    <0x700 &apps_smmu 0x1c07 0x1>,
+				    <0x800 &apps_smmu 0x1c08 0x1>,
+				    <0x900 &apps_smmu 0x1c09 0x1>,
+				    <0xa00 &apps_smmu 0x1c0a 0x1>,
+				    <0xb00 &apps_smmu 0x1c0b 0x1>,
+				    <0xc00 &apps_smmu 0x1c0c 0x1>,
+				    <0xd00 &apps_smmu 0x1c0d 0x1>,
+				    <0xe00 &apps_smmu 0x1c0e 0x1>,
+				    <0xf00 &apps_smmu 0x1c0f 0x1>;
+
+			resets = <&gcc GCC_PCIE_1_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_1_GDSC>;
+
+			phys = <&pcie1_lane>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@1c0a000 {
+			compatible = "qcom,sdm845-qhp-pcie-phy";
+			reg = <0 0x01c0a000 0 0x800>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_CLKREF_CLK>,
+				 <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie1_lane: phy@1c06200 {
+				reg = <0 0x01c0a800 0 0x800>,
+				      <0 0x01c0a800 0 0x800>,
+				      <0 0x01c0b800 0 0x400>;
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clock-output-names = "pcie_1_pipe_clk";
+			};
+		};
+
+		mem_noc: interconnect@1380000 {
+			compatible = "qcom,sdm845-mem-noc";
+			reg = <0 0x01380000 0 0x27200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@14e0000 {
+			compatible = "qcom,sdm845-dc-noc";
+			reg = <0 0x014e0000 0 0x400>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sdm845-config-noc";
+			reg = <0 0x01500000 0 0x5080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sdm845-system-noc";
+			reg = <0 0x01620000 0 0x18080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sdm845-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sdm845-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f300>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sdm845-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0 0x01d84000 0 0x2500>,
+			      <0 0x01d90000 0 0x8000>;
+			reg-names = "std", "ice";
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			power-domains = <&gcc UFS_PHY_GDSC>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			iommus = <&apps_smmu 0x100 0xf>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk",
+				"ice_core_clk";
+			clocks =
+				<&gcc GCC_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_UFS_PHY_AHB_CLK>,
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				<&rpmhcc RPMH_CXO_CLK>,
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
+				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 300000000>;
+
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sdm845-qmp-ufs-phy";
+			reg = <0 0x01d87000 0 0x18c>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clock-names = "ref",
+				      "ref_aux";
+			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+			status = "disabled";
+
+			ufs_mem_phy_lanes: phy@1d87400 {
+				reg = <0 0x01d87400 0 0x108>,
+				      <0 0x01d87600 0 0x1e0>,
+				      <0 0x01d87c00 0 0x1dc>,
+				      <0 0x01d87800 0 0x108>,
+				      <0 0x01d87a00 0 0x1e0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rpmhcc RPMH_CE_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x704 0x1>,
+				 <&apps_smmu 0x706 0x1>,
+				 <&apps_smmu 0x714 0x1>,
+				 <&apps_smmu 0x716 0x1>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,crypto-v5.4";
+			reg = <0 0x01dfa000 0 0x6000>;
+			clocks = <&gcc GCC_CE1_AHB_CLK>,
+				 <&gcc GCC_CE1_AXI_CLK>,
+				 <&rpmhcc RPMH_CE_CLK>;
+			clock-names = "iface", "bus", "core";
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x704 0x1>,
+				 <&apps_smmu 0x706 0x1>,
+				 <&apps_smmu 0x714 0x1>,
+				 <&apps_smmu 0x716 0x1>;
+		};
+
+		ipa: ipa@1e40000 {
+			compatible = "qcom,sdm845-ipa";
+
+			iommus = <&apps_smmu 0x720 0x0>,
+				 <&apps_smmu 0x722 0x0>;
+			reg = <0 0x01e40000 0 0x7000>,
+			      <0 0x01e47000 0 0x2000>,
+			      <0 0x01e04000 0 0x2c000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects = <&aggre2_noc MASTER_IPA 0 &mem_noc SLAVE_EBI1 0>,
+					<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
+			interconnect-names = "memory",
+					     "imem",
+					     "config";
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+
+			status = "disabled";
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0 0x01f40000 0 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr_regs_1: syscon@1f60000 {
+			compatible = "qcom,sdm845-tcsr", "syscon";
+			reg = <0 0x01f60000 0 0x20000>;
+		};
+
+		tlmm: pinctrl@3400000 {
+			compatible = "qcom,sdm845-pinctrl";
+			reg = <0 0x03400000 0 0xc00000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 151>;
+			wakeup-parent = <&pdc_intc>;
+
+			cci0_default: cci0-default-state {
+				/* SDA, SCL */
+				pins = "gpio17", "gpio18";
+				function = "cci_i2c";
+
+				bias-pull-up;
+				drive-strength = <2>; /* 2 mA */
+			};
+
+			cci0_sleep: cci0-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio17", "gpio18";
+				function = "cci_i2c";
+
+				drive-strength = <2>; /* 2 mA */
+				bias-pull-down;
+			};
+
+			cci1_default: cci1-default-state {
+				/* SDA, SCL */
+				pins = "gpio19", "gpio20";
+				function = "cci_i2c";
+
+				bias-pull-up;
+				drive-strength = <2>; /* 2 mA */
+			};
+
+			cci1_sleep: cci1-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio19", "gpio20";
+				function = "cci_i2c";
+
+				drive-strength = <2>; /* 2 mA */
+				bias-pull-down;
+			};
+
+			qspi_clk: qspi-clk-state {
+				pins = "gpio95";
+				function = "qspi_clk";
+			};
+
+			qspi_cs0: qspi-cs0-state {
+				pins = "gpio90";
+				function = "qspi_cs";
+			};
+
+			qspi_cs1: qspi-cs1-state {
+				pins = "gpio89";
+				function = "qspi_cs";
+			};
+
+			qspi_data0: qspi-data0-state {
+				pins = "gpio91";
+				function = "qspi_data";
+			};
+
+			qspi_data1: qspi-data1-state {
+				pins = "gpio92";
+				function = "qspi_data";
+			};
+
+			qspi_data23: qspi-data23-state {
+				pins = "gpio93", "gpio94";
+				function = "qspi_data";
+			};
+
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup0";
+			};
+
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio17", "gpio18";
+				function = "qup1";
+			};
+
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio27", "gpio28";
+				function = "qup2";
+			};
+
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio41", "gpio42";
+				function = "qup3";
+			};
+
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio89", "gpio90";
+				function = "qup4";
+			};
+
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio85", "gpio86";
+				function = "qup5";
+			};
+
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins = "gpio45", "gpio46";
+				function = "qup6";
+			};
+
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio93", "gpio94";
+				function = "qup7";
+			};
+
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins = "gpio65", "gpio66";
+				function = "qup8";
+			};
+
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup9";
+			};
+
+			qup_i2c10_default: qup-i2c10-default-state {
+				pins = "gpio55", "gpio56";
+				function = "qup10";
+			};
+
+			qup_i2c11_default: qup-i2c11-default-state {
+				pins = "gpio31", "gpio32";
+				function = "qup11";
+			};
+
+			qup_i2c12_default: qup-i2c12-default-state {
+				pins = "gpio49", "gpio50";
+				function = "qup12";
+			};
+
+			qup_i2c13_default: qup-i2c13-default-state {
+				pins = "gpio105", "gpio106";
+				function = "qup13";
+			};
+
+			qup_i2c14_default: qup-i2c14-default-state {
+				pins = "gpio33", "gpio34";
+				function = "qup14";
+			};
+
+			qup_i2c15_default: qup-i2c15-default-state {
+				pins = "gpio81", "gpio82";
+				function = "qup15";
+			};
+
+			qup_spi0_default: qup-spi0-default-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "qup0";
+			};
+
+			qup_spi1_default: qup-spi1-default-state {
+				pins = "gpio17", "gpio18", "gpio19", "gpio20";
+				function = "qup1";
+			};
+
+			qup_spi2_default: qup-spi2-default-state {
+				pins = "gpio27", "gpio28", "gpio29", "gpio30";
+				function = "qup2";
+			};
+
+			qup_spi3_default: qup-spi3-default-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "qup3";
+			};
+
+			qup_spi4_default: qup-spi4-default-state {
+				pins = "gpio89", "gpio90", "gpio91", "gpio92";
+				function = "qup4";
+			};
+
+			qup_spi5_default: qup-spi5-default-state {
+				pins = "gpio85", "gpio86", "gpio87", "gpio88";
+				function = "qup5";
+			};
+
+			qup_spi6_default: qup-spi6-default-state {
+				pins = "gpio45", "gpio46", "gpio47", "gpio48";
+				function = "qup6";
+			};
+
+			qup_spi7_default: qup-spi7-default-state {
+				pins = "gpio93", "gpio94", "gpio95", "gpio96";
+				function = "qup7";
+			};
+
+			qup_spi8_default: qup-spi8-default-state {
+				pins = "gpio65", "gpio66", "gpio67", "gpio68";
+				function = "qup8";
+			};
+
+			qup_spi9_default: qup-spi9-default-state {
+				pins = "gpio6", "gpio7", "gpio4", "gpio5";
+				function = "qup9";
+			};
+
+			qup_spi10_default: qup-spi10-default-state {
+				pins = "gpio55", "gpio56", "gpio53", "gpio54";
+				function = "qup10";
+			};
+
+			qup_spi11_default: qup-spi11-default-state {
+				pins = "gpio31", "gpio32", "gpio33", "gpio34";
+				function = "qup11";
+			};
+
+			qup_spi12_default: qup-spi12-default-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "qup12";
+			};
+
+			qup_spi13_default: qup-spi13-default-state {
+				pins = "gpio105", "gpio106", "gpio107", "gpio108";
+				function = "qup13";
+			};
+
+			qup_spi14_default: qup-spi14-default-state {
+				pins = "gpio33", "gpio34", "gpio31", "gpio32";
+				function = "qup14";
+			};
+
+			qup_spi15_default: qup-spi15-default-state {
+				pins = "gpio81", "gpio82", "gpio83", "gpio84";
+				function = "qup15";
+			};
+
+			qup_uart0_default: qup-uart0-default-state {
+				qup_uart0_tx: tx-pins {
+					pins = "gpio2";
+					function = "qup0";
+				};
+
+				qup_uart0_rx: rx-pins {
+					pins = "gpio3";
+					function = "qup0";
+				};
+			};
+
+			qup_uart1_default: qup-uart1-default-state {
+				qup_uart1_tx: tx-pins {
+					pins = "gpio19";
+					function = "qup1";
+				};
+
+				qup_uart1_rx: rx-pins {
+					pins = "gpio20";
+					function = "qup1";
+				};
+			};
+
+			qup_uart2_default: qup-uart2-default-state {
+				qup_uart2_tx: tx-pins {
+					pins = "gpio29";
+					function = "qup2";
+				};
+
+				qup_uart2_rx: rx-pins {
+					pins = "gpio30";
+					function = "qup2";
+				};
+			};
+
+			qup_uart3_default: qup-uart3-default-state {
+				qup_uart3_tx: tx-pins {
+					pins = "gpio43";
+					function = "qup3";
+				};
+
+				qup_uart3_rx: rx-pins {
+					pins = "gpio44";
+					function = "qup3";
+				};
+			};
+
+			qup_uart3_4pin: qup-uart3-4pin-state {
+				qup_uart3_4pin_cts: cts-pins {
+					pins = "gpio41";
+					function = "qup3";
+				};
+
+				qup_uart3_4pin_rts_tx: rts-tx-pins {
+					pins = "gpio42", "gpio43";
+					function = "qup3";
+				};
+
+				qup_uart3_4pin_rx: rx-pins {
+					pins = "gpio44";
+					function = "qup3";
+				};
+			};
+
+			qup_uart4_default: qup-uart4-default-state {
+				qup_uart4_tx: tx-pins {
+					pins = "gpio91";
+					function = "qup4";
+				};
+
+				qup_uart4_rx: rx-pins {
+					pins = "gpio92";
+					function = "qup4";
+				};
+			};
+
+			qup_uart5_default: qup-uart5-default-state {
+				qup_uart5_tx: tx-pins {
+					pins = "gpio87";
+					function = "qup5";
+				};
+
+				qup_uart5_rx: rx-pins {
+					pins = "gpio88";
+					function = "qup5";
+				};
+			};
+
+			qup_uart6_default: qup-uart6-default-state {
+				qup_uart6_tx: tx-pins {
+					pins = "gpio47";
+					function = "qup6";
+				};
+
+				qup_uart6_rx: rx-pins {
+					pins = "gpio48";
+					function = "qup6";
+				};
+			};
+
+			qup_uart6_4pin: qup-uart6-4pin-state {
+				qup_uart6_4pin_cts: cts-pins {
+					pins = "gpio45";
+					function = "qup6";
+					bias-pull-down;
+				};
+
+				qup_uart6_4pin_rts_tx: rts-tx-pins {
+					pins = "gpio46", "gpio47";
+					function = "qup6";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				qup_uart6_4pin_rx: rx-pins {
+					pins = "gpio48";
+					function = "qup6";
+					bias-pull-up;
+				};
+			};
+
+			qup_uart7_default: qup-uart7-default-state {
+				qup_uart7_tx: tx-pins {
+					pins = "gpio95";
+					function = "qup7";
+				};
+
+				qup_uart7_rx: rx-pins {
+					pins = "gpio96";
+					function = "qup7";
+				};
+			};
+
+			qup_uart8_default: qup-uart8-default-state {
+				qup_uart8_tx: tx-pins {
+					pins = "gpio67";
+					function = "qup8";
+				};
+
+				qup_uart8_rx: rx-pins {
+					pins = "gpio68";
+					function = "qup8";
+				};
+			};
+
+			qup_uart9_default: qup-uart9-default-state {
+				qup_uart9_tx: tx-pins {
+					pins = "gpio4";
+					function = "qup9";
+				};
+
+				qup_uart9_rx: rx-pins {
+					pins = "gpio5";
+					function = "qup9";
+				};
+			};
+
+			qup_uart10_default: qup-uart10-default-state {
+				qup_uart10_tx: tx-pins {
+					pins = "gpio53";
+					function = "qup10";
+				};
+
+				qup_uart10_rx: rx-pins {
+					pins = "gpio54";
+					function = "qup10";
+				};
+			};
+
+			qup_uart11_default: qup-uart11-default-state {
+				qup_uart11_tx: tx-pins {
+					pins = "gpio33";
+					function = "qup11";
+				};
+
+				qup_uart11_rx: rx-pins {
+					pins = "gpio34";
+					function = "qup11";
+				};
+			};
+
+			qup_uart12_default: qup-uart12-default-state {
+				qup_uart12_tx: tx-pins {
+					pins = "gpio51";
+					function = "qup0";
+				};
+
+				qup_uart12_rx: rx-pins {
+					pins = "gpio52";
+					function = "qup0";
+				};
+			};
+
+			qup_uart13_default: qup-uart13-default-state {
+				qup_uart13_tx: tx-pins {
+					pins = "gpio107";
+					function = "qup13";
+				};
+
+				qup_uart13_rx: rx-pins {
+					pins = "gpio108";
+					function = "qup13";
+				};
+			};
+
+			qup_uart14_default: qup-uart14-default-state {
+				qup_uart14_tx: tx-pins {
+					pins = "gpio31";
+					function = "qup14";
+				};
+
+				qup_uart14_rx: rx-pins {
+					pins = "gpio32";
+					function = "qup14";
+				};
+			};
+
+			qup_uart15_default: qup-uart15-default-state {
+				qup_uart15_tx: tx-pins {
+					pins = "gpio83";
+					function = "qup15";
+				};
+
+				qup_uart15_rx: rx-pins {
+					pins = "gpio84";
+					function = "qup15";
+				};
+			};
+
+			quat_mi2s_sleep: quat-mi2s-sleep-state {
+				pins = "gpio58", "gpio59";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			quat_mi2s_active: quat-mi2s-active-state {
+				pins = "gpio58", "gpio59";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+				output-high;
+			};
+
+			quat_mi2s_sd0_sleep: quat-mi2s-sd0-sleep-state {
+				pins = "gpio60";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			quat_mi2s_sd0_active: quat-mi2s-sd0-active-state {
+				pins = "gpio60";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			quat_mi2s_sd1_sleep: quat-mi2s-sd1-sleep-state {
+				pins = "gpio61";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			quat_mi2s_sd1_active: quat-mi2s-sd1-active-state {
+				pins = "gpio61";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			quat_mi2s_sd2_sleep: quat-mi2s-sd2-sleep-state {
+				pins = "gpio62";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			quat_mi2s_sd2_active: quat-mi2s-sd2-active-state {
+				pins = "gpio62";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			quat_mi2s_sd3_sleep: quat-mi2s-sd3-sleep-state {
+				pins = "gpio63";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			quat_mi2s_sd3_active: quat-mi2s-sd3-active-state {
+				pins = "gpio63";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+		};
+
+		mss_pil: remoteproc@4080000 {
+			compatible = "qcom,sdm845-mss-pil";
+			reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended =
+				<&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+				 <&gcc GCC_PRNG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "bus", "mem", "gpll0_mss",
+				      "snoc_axi", "mnoc_axi", "prng", "xo";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+			reset-names = "mss_restart", "pdc_reset";
+
+			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
+
+			power-domains = <&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>,
+					<&rpmhpd SDM845_MSS>;
+			power-domain-names = "cx", "mx", "mss";
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
+			glink-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apss_shared 12>;
+			};
+		};
+
+		gpucc: clock-controller@5090000 {
+			compatible = "qcom,sdm845-gpucc";
+			reg = <0 0x05090000 0 0x9000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+		};
+
+		slpi_pas: remoteproc@5c00000 {
+			compatible = "qcom,sdm845-slpi-pas";
+			reg = <0 0x5c00000 0 0x4000>;
+
+			interrupts-extended = <&intc GIC_SPI 494 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+						"handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			power-domains = <&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&slpi_mem>;
+
+			qcom,smem-states = <&slpi_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>;
+				label = "dsps";
+				qcom,remote-pid = <3>;
+				mboxes = <&apss_shared 24>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "sdsp";
+					qcom,non-secure-domain;
+					qcom,vmids = <QCOM_SCM_VMID_HLOS QCOM_SCM_VMID_MSS_MSA
+						      QCOM_SCM_VMID_SSC_Q6 QCOM_SCM_VMID_ADSP_Q6>;
+					memory-region = <&fastrpc_mem>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@0 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <0>;
+					};
+				};
+			};
+		};
+
+		stm@6002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0 0x06002000 0 0x1000>,
+			      <0 0x16280000 0 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@6041000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06041000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel0_in7: endpoint {
+						remote-endpoint = <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6043000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06043000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in2>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@5 {
+					reg = <5>;
+					funnel2_in5: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6045000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06045000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint = <&etf_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&funnel0_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&funnel2_out>;
+					};
+				};
+			};
+		};
+
+		replicator@6046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0 0x06046000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					replicator_out: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint = <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etf@6047000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x06047000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etr@6048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x06048000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out>;
+					};
+				};
+			};
+		};
+
+		etm@7040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07040000 0 0x1000>;
+
+			cpu = <&CPU0>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@7140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07140000 0 0x1000>;
+
+			cpu = <&CPU1>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@7240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07240000 0 0x1000>;
+
+			cpu = <&CPU2>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@7340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07340000 0 0x1000>;
+
+			cpu = <&CPU3>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		etm@7440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07440000 0 0x1000>;
+
+			cpu = <&CPU4>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in4>;
+					};
+				};
+			};
+		};
+
+		etm@7540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07540000 0 0x1000>;
+
+			cpu = <&CPU5>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in5>;
+					};
+				};
+			};
+		};
+
+		etm@7640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07640000 0 0x1000>;
+
+			cpu = <&CPU6>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in6>;
+					};
+				};
+			};
+		};
+
+		etm@7740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07740000 0 0x1000>;
+
+			cpu = <&CPU7>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@7800000 { /* APSS Funnel */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x07800000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					apss_funnel_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					apss_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					apss_funnel_in3: endpoint {
+						remote-endpoint =
+						  <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					apss_funnel_in4: endpoint {
+						remote-endpoint =
+						  <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					apss_funnel_in5: endpoint {
+						remote-endpoint =
+						  <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					apss_funnel_in6: endpoint {
+						remote-endpoint =
+						  <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					apss_funnel_in7: endpoint {
+						remote-endpoint =
+						  <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@7810000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x07810000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel2_in5>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					apss_merge_funnel_in: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_out>;
+					};
+				};
+			};
+		};
+
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0xa0 0xf>;
+			power-domains = <&rpmhpd SDM845_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-9600000 {
+					opp-hz = /bits/ 64 <9600000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-201500000 {
+					opp-hz = /bits/ 64 <201500000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
+		qspi: spi@88df000 {
+			compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
+			reg = <0 0x088df000 0 0x600>;
+			iommus = <&apps_smmu 0x160 0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+				 <&gcc GCC_QSPI_CORE_CLK>;
+			clock-names = "iface", "core";
+			power-domains = <&rpmhpd SDM845_CX>;
+			operating-points-v2 = <&qspi_opp_table>;
+			status = "disabled";
+		};
+
+		slim: slim-ngd@171c0000 {
+			compatible = "qcom,slim-ngd-v2.1.0";
+			reg = <0 0x171c0000 0 0x2c000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+
+			iommus = <&apps_smmu 0x1806 0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		lmh_cluster1: lmh@17d70800 {
+			compatible = "qcom,sdm845-lmh";
+			reg = <0 0x17d70800 0 0x400>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU4>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@17d78800 {
+			compatible = "qcom,sdm845-lmh";
+			reg = <0 0x17d78800 0 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU0>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		usb_1_hsphy: phy@88e2000 {
+			compatible = "qcom,sdm845-qusb2-phy", "qcom,qusb2-v2-phy";
+			reg = <0 0x088e2000 0 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			nvmem-cells = <&qusb2p_hstx_trim>;
+		};
+
+		usb_2_hsphy: phy@88e3000 {
+			compatible = "qcom,sdm845-qusb2-phy", "qcom,qusb2-v2-phy";
+			reg = <0 0x088e3000 0 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+
+			nvmem-cells = <&qusb2s_hstx_trim>;
+		};
+
+		usb_1_qmpphy: phy@88e9000 {
+			compatible = "qcom,sdm845-qmp-usb3-dp-phy";
+			reg = <0 0x088e9000 0 0x18c>,
+			      <0 0x088e8000 0 0x38>,
+			      <0 0x088ea000 0 0x40>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
+			reset-names = "phy", "common";
+
+			usb_1_ssphy: usb3-phy@88e9200 {
+				reg = <0 0x088e9200 0 0x128>,
+				      <0 0x088e9400 0 0x200>,
+				      <0 0x088e9c00 0 0x218>,
+				      <0 0x088e9600 0 0x128>,
+				      <0 0x088e9800 0 0x200>,
+				      <0 0x088e9a00 0 0x100>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+
+			dp_phy: dp-phy@88ea200 {
+				reg = <0 0x088ea200 0 0x200>,
+				      <0 0x088ea400 0 0x200>,
+				      <0 0x088eaa00 0 0x200>,
+				      <0 0x088ea600 0 0x200>,
+				      <0 0x088ea800 0 0x200>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		usb_2_qmpphy: phy@88eb000 {
+			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
+			reg = <0 0x088eb000 0 0x18c>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3_PHY_SEC_BCR>;
+			reset-names = "phy", "common";
+
+			usb_2_ssphy: phy@88eb200 {
+				reg = <0 0x088eb200 0 0x128>,
+				      <0 0x088eb400 0 0x1fc>,
+				      <0 0x088eb800 0 0x218>,
+				      <0 0x088eb600 0 0x70>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_uni_phy_pipe_clk_src";
+			};
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0 0x0a6f8800 0 0x400>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			interconnects = <&aggre2_noc MASTER_USB3_0 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			usb_1_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a600000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x740 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		usb_2: usb@a8f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0 0x0a8f8800 0 0x400>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_SEC_GDSC>;
+
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+
+			interconnects = <&aggre2_noc MASTER_USB3_1 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			usb_2_dwc3: usb@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a800000 0 0xcd00>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x760 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_2_hsphy>, <&usb_2_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		venus: video-codec@aa00000 {
+			compatible = "qcom,sdm845-venus-v2";
+			reg = <0 0x0aa00000 0 0xff000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&videocc VENUS_GDSC>,
+					<&videocc VCODEC0_GDSC>,
+					<&videocc VCODEC1_GDSC>,
+					<&rpmhpd SDM845_CX>;
+			power-domain-names = "venus", "vcodec0", "vcodec1", "cx";
+			operating-points-v2 = <&venus_opp_table>;
+			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+			clock-names = "core", "iface", "bus",
+				      "vcodec0_core", "vcodec0_bus",
+				      "vcodec1_core", "vcodec1_bus";
+			iommus = <&apps_smmu 0x10a0 0x8>,
+				 <&apps_smmu 0x10b0 0x0>;
+			memory-region = <&venus_mem>;
+			interconnects = <&mmss_noc MASTER_VIDEO_P0 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_VENUS_CFG 0>;
+			interconnect-names = "video-mem", "cpu-cfg";
+
+			status = "disabled";
+
+			video-core0 {
+				compatible = "venus-decoder";
+			};
+
+			video-core1 {
+				compatible = "venus-encoder";
+			};
+
+			venus_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-320000000 {
+					opp-hz = /bits/ 64 <320000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-380000000 {
+					opp-hz = /bits/ 64 <380000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+
+				opp-533000097 {
+					opp-hz = /bits/ 64 <533000097>;
+					required-opps = <&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,sdm845-videocc";
+			reg = <0 0x0ab00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		camss: camss@acb3000 {
+			compatible = "qcom,sdm845-camss";
+
+			reg = <0 0x0acb3000 0 0x1000>,
+				<0 0x0acba000 0 0x1000>,
+				<0 0x0acc8000 0 0x1000>,
+				<0 0x0ac65000 0 0x1000>,
+				<0 0x0ac66000 0 0x1000>,
+				<0 0x0ac67000 0 0x1000>,
+				<0 0x0ac68000 0 0x1000>,
+				<0 0x0acaf000 0 0x4000>,
+				<0 0x0acb6000 0 0x4000>,
+				<0 0x0acc4000 0 0x4000>;
+			reg-names = "csid0",
+				"csid1",
+				"csid2",
+				"csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csiphy3",
+				"vfe0",
+				"vfe1",
+				"vfe_lite";
+
+			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "csid0",
+				"csid1",
+				"csid2",
+				"csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csiphy3",
+				"vfe0",
+				"vfe1",
+				"vfe_lite";
+
+			power-domains = <&clock_camcc IFE_0_GDSC>,
+				<&clock_camcc IFE_1_GDSC>,
+				<&clock_camcc TITAN_TOP_GDSC>;
+
+			clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&clock_camcc CAM_CC_CPAS_AHB_CLK>,
+				<&clock_camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_0_CSID_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CSID_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_1_CSID_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CSID_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_LITE_CSID_CLK>,
+				<&clock_camcc CAM_CC_IFE_LITE_CSID_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY0_CLK>,
+				<&clock_camcc CAM_CC_CSI0PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI0PHYTIMER_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY1_CLK>,
+				<&clock_camcc CAM_CC_CSI1PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI1PHYTIMER_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY2_CLK>,
+				<&clock_camcc CAM_CC_CSI2PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI2PHYTIMER_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY3_CLK>,
+				<&clock_camcc CAM_CC_CSI3PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI3PHYTIMER_CLK_SRC>,
+				<&gcc GCC_CAMERA_AHB_CLK>,
+				<&gcc GCC_CAMERA_AXI_CLK>,
+				<&clock_camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&clock_camcc CAM_CC_SOC_AHB_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_AXI_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_1_AXI_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_LITE_CLK>,
+				<&clock_camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+				<&clock_camcc CAM_CC_IFE_LITE_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				"cpas_ahb",
+				"cphy_rx_src",
+				"csi0",
+				"csi0_src",
+				"csi1",
+				"csi1_src",
+				"csi2",
+				"csi2_src",
+				"csiphy0",
+				"csiphy0_timer",
+				"csiphy0_timer_src",
+				"csiphy1",
+				"csiphy1_timer",
+				"csiphy1_timer_src",
+				"csiphy2",
+				"csiphy2_timer",
+				"csiphy2_timer_src",
+				"csiphy3",
+				"csiphy3_timer",
+				"csiphy3_timer_src",
+				"gcc_camera_ahb",
+				"gcc_camera_axi",
+				"slow_ahb_src",
+				"soc_ahb",
+				"vfe0_axi",
+				"vfe0",
+				"vfe0_cphy_rx",
+				"vfe0_src",
+				"vfe1_axi",
+				"vfe1",
+				"vfe1_cphy_rx",
+				"vfe1_src",
+				"vfe_lite",
+				"vfe_lite_cphy_rx",
+				"vfe_lite_src";
+
+			iommus = <&apps_smmu 0x0808 0x0>,
+				 <&apps_smmu 0x0810 0x8>,
+				 <&apps_smmu 0x0c08 0x0>,
+				 <&apps_smmu 0x0c10 0x8>;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+
+				port@2 {
+					reg = <2>;
+				};
+
+				port@3 {
+					reg = <3>;
+				};
+			};
+		};
+
+		cci: cci@ac4a000 {
+			compatible = "qcom,sdm845-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0x0ac4a000 0 0x4000>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&clock_camcc TITAN_TOP_GDSC>;
+
+			clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&clock_camcc CAM_CC_SOC_AHB_CLK>,
+				<&clock_camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&clock_camcc CAM_CC_CPAS_AHB_CLK>,
+				<&clock_camcc CAM_CC_CCI_CLK>,
+				<&clock_camcc CAM_CC_CCI_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				"soc_ahb",
+				"slow_ahb_src",
+				"cpas_ahb",
+				"cci",
+				"cci_src";
+
+			assigned-clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&clock_camcc CAM_CC_CCI_CLK>;
+			assigned-clock-rates = <80000000>, <37500000>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci0_default &cci1_default>;
+			pinctrl-1 = <&cci0_sleep &cci1_sleep>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		clock_camcc: clock-controller@ad00000 {
+			compatible = "qcom,sdm845-camcc";
+			reg = <0 0x0ad00000 0 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+		};
+
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,sdm845-mdss";
+			reg = <0 0x0ae00000 0 0x1000>;
+			reg-names = "mdss";
+
+			power-domains = <&dispcc MDSS_GDSC>;
+
+			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface", "core";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interconnects = <&mmss_noc MASTER_MDP0 0 &mem_noc SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_MDP1 0 &mem_noc SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+
+			iommus = <&apps_smmu 0x880 0x8>,
+			         <&apps_smmu 0xc80 0x8>;
+
+			status = "disabled";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,sdm845-dpu";
+				reg = <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				clocks = <&gcc GCC_DISP_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "gcc-bus", "iface", "bus", "core", "vsync";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&dp_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+						dpu_intf2_out: endpoint {
+							remote-endpoint = <&mdss_dsi1_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-19200000 {
+						opp-hz = /bits/ 64 <19200000>;
+						required-opps = <&rpmhpd_opp_min_svs>;
+					};
+
+					opp-171428571 {
+						opp-hz = /bits/ 64 <171428571>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-344000000 {
+						opp-hz = /bits/ 64 <344000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-430000000 {
+						opp-hz = /bits/ 64 <430000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dp: displayport-controller@ae90000 {
+				status = "disabled";
+				compatible = "qcom,sdm845-dp";
+
+				reg = <0 0x0ae90000 0 0x200>,
+				      <0 0x0ae90200 0 0x200>,
+				      <0 0x0ae90400 0 0x600>,
+				      <0 0x0ae90a00 0 0x600>,
+				      <0 0x0ae91000 0 0x600>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+				clock-names = "core_iface", "core_aux", "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+				assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
+				phys = <&dp_phy>;
+				phy-names = "dp";
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						dp_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dp_out: endpoint { };
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@ae94000 {
+				compatible = "qcom,sdm845-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0 0x0ae94000 0 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
+
+				phys = <&mdss_dsi0_phy>;
+
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@ae94400 {
+				compatible = "qcom,dsi-phy-10nm";
+				reg = <0 0x0ae94400 0 0x200>,
+				      <0 0x0ae94600 0 0x280>,
+				      <0 0x0ae94a00 0 0x1e0>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+
+			mdss_dsi1: dsi@ae96000 {
+				compatible = "qcom,sdm845-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0 0x0ae96000 0 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK1_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC1_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
+
+				phys = <&mdss_dsi1_phy>;
+
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dsi1_in: endpoint {
+							remote-endpoint = <&dpu_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdss_dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi1_phy: phy@ae96400 {
+				compatible = "qcom,dsi-phy-10nm";
+				reg = <0 0x0ae96400 0 0x200>,
+				      <0 0x0ae96600 0 0x280>,
+				      <0 0x0ae96a00 0 0x10e>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+		};
+
+		gpu: gpu@5000000 {
+			compatible = "qcom,adreno-630.2", "qcom,adreno";
+
+			reg = <0 0x05000000 0 0x40000>, <0 0x509e000 0 0x10>;
+			reg-names = "kgsl_3d0_reg_memory", "cx_mem";
+
+			/*
+			 * Look ma, no clocks! The GPU clocks and power are
+			 * controlled entirely by the GMU
+			 */
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+
+			interconnects = <&mem_noc MASTER_GFX3D 0 &mem_noc SLAVE_EBI1 0>;
+			interconnect-names = "gfx-mem";
+
+			status = "disabled";
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-710000000 {
+					opp-hz = /bits/ 64 <710000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <7216000>;
+				};
+
+				opp-675000000 {
+					opp-hz = /bits/ 64 <675000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <7216000>;
+				};
+
+				opp-596000000 {
+					opp-hz = /bits/ 64 <596000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-520000000 {
+					opp-hz = /bits/ 64 <520000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-414000000 {
+					opp-hz = /bits/ 64 <414000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-342000000 {
+					opp-hz = /bits/ 64 <342000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <2724000>;
+				};
+
+				opp-257000000 {
+					opp-hz = /bits/ 64 <257000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <1648000>;
+				};
+			};
+		};
+
+		adreno_smmu: iommu@5040000 {
+			compatible = "qcom,sdm845-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
+			reg = <0 0x05040000 0 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+			         <&gcc GCC_GPU_CFG_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
+		gmu: gmu@506a000 {
+			compatible = "qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
+
+			reg = <0 0x0506a000 0 0x30000>,
+			      <0 0x0b280000 0 0x10000>,
+			      <0 0x0b480000 0 0x10000>;
+			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+			         <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "gmu", "cxo", "axi", "memnoc";
+
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx", "gx";
+
+			iommus = <&adreno_smmu 5>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			status = "disabled";
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sdm845-dispcc";
+			reg = <0 0x0af00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi1_phy 0>,
+				 <&mdss_dsi1_phy 1>,
+				 <&dp_phy 0>,
+				 <&dp_phy 1>;
+			clock-names = "bi_tcxo",
+				      "gcc_disp_gpll0_clk_src",
+				      "gcc_disp_gpll0_div_clk_src",
+				      "dsi0_phy_pll_out_byteclk",
+				      "dsi0_phy_pll_out_dsiclk",
+				      "dsi1_phy_pll_out_byteclk",
+				      "dsi1_phy_pll_out_dsiclk",
+				      "dp_link_clk_divsel_ten",
+				      "dp_vco_divided_clk_src_mux";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		pdc_intc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x30000>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
+		pdc_reset: reset-controller@b2e0000 {
+			compatible = "qcom,sdm845-pdc-global";
+			reg = <0 0x0b2e0000 0 0x20000>;
+			#reset-cells = <1>;
+		};
+
+		tsens0: thermal-sensor@c263000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c263000 0 0x1ff>, /* TM */
+			      <0 0x0c222000 0 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c265000 0 0x1ff>, /* TM */
+			      <0 0x0c223000 0 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		aoss_reset: reset-controller@c2a0000 {
+			compatible = "qcom,sdm845-aoss-cc";
+			reg = <0 0x0c2a0000 0 0x31000>;
+			#reset-cells = <1>;
+		};
+
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0 0x0c300000 0 0x400>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#clock-cells = <0>;
+
+			cx_cdev: cx {
+				#cooling-cells = <2>;
+			};
+
+			ebi_cdev: ebi {
+				#cooling-cells = <2>;
+			};
+		};
+
+		sram@c3f0000 {
+			compatible = "qcom,sdm845-rpmh-stats";
+			reg = <0 0x0c3f0000 0 0x400>;
+		};
+
+		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0xc440000 0x1100>,
-			      <0xc600000 0x2000000>,
-			      <0xe600000 0x100000>;
-			reg-names = "core", "chnls", "obsrvr";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
+			reg = <0 0x0c440000 0 0x1100>,
+			      <0 0x0c600000 0 0x2000000>,
+			      <0 0x0e600000 0 0x100000>,
+			      <0 0x0e700000 0 0xa0000>,
+			      <0 0x0c40a000 0 0x26000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
 
-			qcom,revid@100 {
-				compatible = "qcom,qpnp-revid";
-				reg = <0x100 0x100>;
+		sram@146bf000 {
+			compatible = "qcom,sdm845-imem", "syscon", "simple-mfd";
+			reg = <0 0x146bf000 0 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0 0x146bf000 0x1000>;
+
+			status = "disabled";
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
+			reg = <0 0x15000000 0 0x80000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		lpasscc: clock-controller@17014000 {
+			compatible = "qcom,sdm845-lpasscc";
+			reg = <0 0x17014000 0 0x1f004>, <0 0x17300000 0 0x200>;
+			reg-names = "cc", "qdsp6ss";
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		gladiator_noc: interconnect@17900000 {
+			compatible = "qcom,sdm845-gladiator-noc";
+			reg = <0 0x17900000 0 0xd080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		watchdog@17980000 {
+			compatible = "qcom,apss-wdt-sdm845", "qcom,kpss-wdt";
+			reg = <0 0x17980000 0 0x1000>;
+			clocks = <&sleep_clk>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		apss_shared: mailbox@17990000 {
+			compatible = "qcom,sdm845-apss-shared";
+			reg = <0 0x17990000 0 0x1000>;
+			#mbox-cells = <1>;
+		};
+
+		apps_rsc: rsc@179c0000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0 0x179c0000 0 0x10000>,
+			      <0 0x179d0000 0 0x10000>,
+			      <0 0x179e0000 0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
+
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
 			};
 
-			pmic0: pm8998@0 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x0 0x1>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-
-				pm8998_pon: pon@800 {
-					compatible = "qcom,pm8998-pon";
-
-					reg = <0x800 0x100>;
-					mode-bootloader = <0x2>;
-					mode-recovery = <0x1>;
-
-					pm8998_pwrkey: pwrkey {
-						compatible = "qcom,pm8941-pwrkey";
-						debounce = <15625>;
-						bias-pull-up;
-					};
-
-					pm8998_resin: resin {
-						compatible = "qcom,pm8941-resin";
-						debounce = <15625>;
-						bias-pull-up;
-						status = "disabled";
-					};
-				};
-
-				pm8998_gpios: pm8998_gpios@c000 {
-					compatible = "qcom,pm8998-gpio";
-					reg = <0xc000 0x1a00>;
-					gpio-controller;
-					gpio-ranges = <&pm8998_gpios 0 0 26>;
-					#gpio-cells = <2>;
-				};
+			rpmhcc: clock-controller {
+				compatible = "qcom,sdm845-rpmh-clk";
+				#clock-cells = <1>;
+				clock-names = "xo";
+				clocks = <&xo_board>;
 			};
 
-			pmic1: pm8998@1 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x1 0x0>;
-				#address-cells = <0x2>;
-				#size-cells = <0x0>;
+			rpmhpd: power-controller {
+				compatible = "qcom,sdm845-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp10 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+		};
+
+		intc: interrupt-controller@17a00000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0 0x17a00000 0 0x10000>,     /* GICD */
+			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			msi-controller@17a40000 {
+				compatible = "arm,gic-v3-its";
+				msi-controller;
+				#msi-cells = <1>;
+				reg = <0 0x17a40000 0 0x20000>;
+				status = "disabled";
+			};
+		};
+
+		slimbam: dma-controller@17184000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			qcom,controlled-remotely;
+			reg = <0 0x17184000 0 0x2a000>;
+			num-channels = <31>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x1806 0x0>;
+		};
+
+		timer@17c90000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0 0x17c90000 0 0x1000>;
+
+			frame@17ca0000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17ca0000 0x1000>,
+				      <0x17cb0000 0x1000>;
+			};
+
+			frame@17cc0000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17cc0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17cd0000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17cd0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17ce0000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17ce0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17cf0000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17cf0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17d00000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17d00000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17d10000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17d10000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		osm_l3: interconnect@17d41000 {
+			compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
+			reg = <0 0x17d41000 0 0x1400>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
+		cpufreq_hw: cpufreq@17d43000 {
+			compatible = "qcom,sdm845-cpufreq-hw", "qcom,cpufreq-hw";
+			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
+
+		wifi: wifi@18800000 {
+			compatible = "qcom,wcn3990-wifi";
+			status = "disabled";
+			reg = <0 0x18800000 0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			clock-names = "cxo_ref_clk_pin";
+			clocks = <&rpmhcc RPMH_RF_CLK2>;
+			interrupts =
+				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x0040 0x1>;
+		};
+	};
+
+	sound: sound {
+	};
+
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				cpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				cpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				cpu3_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu4-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cpu4_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu5-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				cpu5_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu6-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				cpu6_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu7-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				cpu7_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				aoss0_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cluster0_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster0_crit: cluster0_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				cluster1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster1_crit: cluster1_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		gpu-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				gpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		aoss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 0>;
+
+			trips {
+				aoss1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				q6_modem_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				mem_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				wlan_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-hvx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 5>;
+
+			trips {
+				camera_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		video-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				video_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				modem_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
 			};
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
diff --git a/arch/arm/dts/starqltechn-uboot.dtsi b/arch/arm/dts/starqltechn-uboot.dtsi
deleted file mode 100644
index 55c6d18412ba..000000000000
--- a/arch/arm/dts/starqltechn-uboot.dtsi
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * U-Boot addition to handle Samsung S9 SM-G9600 (starqltechn) pins
- *
- * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
- *
- */
-
-/
-{
-	framebuffer@9D400000 {
-		bootph-all;
-	};
-	soc {
-		bootph-all;
-		serial@a84000 {
-			bootph-all;
-		};
-		clock-controller@100000 {
-			bootph-all;
-		};
-		pinctrl@3400000 {
-			bootph-all;
-		};
-	};
-};
-
diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index 0842e19adb60..3c0f42c9774b 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -9,31 +9,23 @@
 /dts-v1/;
 
 #include "sdm845.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+#include "pm8998.dtsi"
 
 / {
 	model = "Samsung S9 (SM-G9600)";
 	compatible = "qcom,sdm845-mtp", "qcom,sdm845", "qcom,mtp";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	chosen {
-		stdout-path = "serial0:921600n8";
-	};
 
 	aliases {
 		serial0 = &uart9;
 	};
 
-	memory {
-		device_type = "memory";
-		reg = <0 0x80000000 0 0xfe1bffff>;
+	chosen {
+		stdout-path = "serial0:921600n8";
 	};
 
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0xfe1bffff>;
 	};
 
 	framebuffer: framebuffer@9D400000 {
@@ -44,12 +36,6 @@
 		stride = <(1440 * 4)>;
 		format = "a8r8g8b8";
 	};
-
-	soc: soc {
-		serial@a84000 {
-			status = "okay";
-		};
-	};
 };
 
 &pm8998_resin {
@@ -57,12 +43,14 @@
 };
 
 &tlmm {
-	muic_i2c: muic-i2c-n {
-		pins = "GPIO_33", "GPIO_34";
+	muic-i2c-n {
+		pins = "gpio33", "gpio34";
 		drive-strength = <0x2>;
 		function = "gpio";
 		bias-disable;
 	};
 };
 
-#include "starqltechn-uboot.dtsi"
+&uart9 {
+	status = "okay";
+};
diff --git a/include/dt-bindings/clock/qcom,camcc-sdm845.h b/include/dt-bindings/clock/qcom,camcc-sdm845.h
new file mode 100644
index 000000000000..4f7a2d2320bf
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,camcc-sdm845.h
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_CAM_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_CAM_CC_SDM845_H
+
+/* CAM_CC clock registers */
+#define CAM_CC_BPS_AHB_CLK				0
+#define CAM_CC_BPS_AREG_CLK				1
+#define CAM_CC_BPS_AXI_CLK				2
+#define CAM_CC_BPS_CLK					3
+#define CAM_CC_BPS_CLK_SRC				4
+#define CAM_CC_CAMNOC_ATB_CLK				5
+#define CAM_CC_CAMNOC_AXI_CLK				6
+#define CAM_CC_CCI_CLK					7
+#define CAM_CC_CCI_CLK_SRC				8
+#define CAM_CC_CPAS_AHB_CLK				9
+#define CAM_CC_CPHY_RX_CLK_SRC				10
+#define CAM_CC_CSI0PHYTIMER_CLK				11
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC			12
+#define CAM_CC_CSI1PHYTIMER_CLK				13
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC			14
+#define CAM_CC_CSI2PHYTIMER_CLK				15
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC			16
+#define CAM_CC_CSI3PHYTIMER_CLK				17
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC			18
+#define CAM_CC_CSIPHY0_CLK				19
+#define CAM_CC_CSIPHY1_CLK				20
+#define CAM_CC_CSIPHY2_CLK				21
+#define CAM_CC_CSIPHY3_CLK				22
+#define CAM_CC_FAST_AHB_CLK_SRC				23
+#define CAM_CC_FD_CORE_CLK				24
+#define CAM_CC_FD_CORE_CLK_SRC				25
+#define CAM_CC_FD_CORE_UAR_CLK				26
+#define CAM_CC_ICP_APB_CLK				27
+#define CAM_CC_ICP_ATB_CLK				28
+#define CAM_CC_ICP_CLK					29
+#define CAM_CC_ICP_CLK_SRC				30
+#define CAM_CC_ICP_CTI_CLK				31
+#define CAM_CC_ICP_TS_CLK				32
+#define CAM_CC_IFE_0_AXI_CLK				33
+#define CAM_CC_IFE_0_CLK				34
+#define CAM_CC_IFE_0_CLK_SRC				35
+#define CAM_CC_IFE_0_CPHY_RX_CLK			36
+#define CAM_CC_IFE_0_CSID_CLK				37
+#define CAM_CC_IFE_0_CSID_CLK_SRC			38
+#define CAM_CC_IFE_0_DSP_CLK				39
+#define CAM_CC_IFE_1_AXI_CLK				40
+#define CAM_CC_IFE_1_CLK				41
+#define CAM_CC_IFE_1_CLK_SRC				42
+#define CAM_CC_IFE_1_CPHY_RX_CLK			43
+#define CAM_CC_IFE_1_CSID_CLK				44
+#define CAM_CC_IFE_1_CSID_CLK_SRC			45
+#define CAM_CC_IFE_1_DSP_CLK				46
+#define CAM_CC_IFE_LITE_CLK				47
+#define CAM_CC_IFE_LITE_CLK_SRC				48
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK			49
+#define CAM_CC_IFE_LITE_CSID_CLK			50
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC			51
+#define CAM_CC_IPE_0_AHB_CLK				52
+#define CAM_CC_IPE_0_AREG_CLK				53
+#define CAM_CC_IPE_0_AXI_CLK				54
+#define CAM_CC_IPE_0_CLK				55
+#define CAM_CC_IPE_0_CLK_SRC				56
+#define CAM_CC_IPE_1_AHB_CLK				57
+#define CAM_CC_IPE_1_AREG_CLK				58
+#define CAM_CC_IPE_1_AXI_CLK				59
+#define CAM_CC_IPE_1_CLK				60
+#define CAM_CC_IPE_1_CLK_SRC				61
+#define CAM_CC_JPEG_CLK					62
+#define CAM_CC_JPEG_CLK_SRC				63
+#define CAM_CC_LRME_CLK					64
+#define CAM_CC_LRME_CLK_SRC				65
+#define CAM_CC_MCLK0_CLK				66
+#define CAM_CC_MCLK0_CLK_SRC				67
+#define CAM_CC_MCLK1_CLK				68
+#define CAM_CC_MCLK1_CLK_SRC				69
+#define CAM_CC_MCLK2_CLK				70
+#define CAM_CC_MCLK2_CLK_SRC				71
+#define CAM_CC_MCLK3_CLK				72
+#define CAM_CC_MCLK3_CLK_SRC				73
+#define CAM_CC_PLL0					74
+#define CAM_CC_PLL0_OUT_EVEN				75
+#define CAM_CC_PLL1					76
+#define CAM_CC_PLL1_OUT_EVEN				77
+#define CAM_CC_PLL2					78
+#define CAM_CC_PLL2_OUT_EVEN				79
+#define CAM_CC_PLL3					80
+#define CAM_CC_PLL3_OUT_EVEN				81
+#define CAM_CC_SLOW_AHB_CLK_SRC				82
+#define CAM_CC_SOC_AHB_CLK				83
+#define CAM_CC_SYS_TMR_CLK				84
+
+/* CAM_CC Resets */
+#define TITAN_CAM_CC_CCI_BCR				0
+#define TITAN_CAM_CC_CPAS_BCR				1
+#define TITAN_CAM_CC_CSI0PHY_BCR			2
+#define TITAN_CAM_CC_CSI1PHY_BCR			3
+#define TITAN_CAM_CC_CSI2PHY_BCR			4
+#define TITAN_CAM_CC_MCLK0_BCR				5
+#define TITAN_CAM_CC_MCLK1_BCR				6
+#define TITAN_CAM_CC_MCLK2_BCR				7
+#define TITAN_CAM_CC_MCLK3_BCR				8
+#define TITAN_CAM_CC_TITAN_TOP_BCR			9
+
+/* CAM_CC GDSCRs */
+#define BPS_GDSC					0
+#define IPE_0_GDSC					1
+#define IPE_1_GDSC					2
+#define IFE_0_GDSC					3
+#define IFE_1_GDSC					4
+#define TITAN_TOP_GDSC					5
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,dispcc-sdm845.h b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
new file mode 100644
index 000000000000..4016fd1d5b46
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_DISP_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_DISP_CC_SDM845_H
+
+/* DISP_CC clock registers */
+#define DISP_CC_MDSS_AHB_CLK					0
+#define DISP_CC_MDSS_AXI_CLK					1
+#define DISP_CC_MDSS_BYTE0_CLK					2
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				4
+#define DISP_CC_MDSS_BYTE1_CLK					5
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				7
+#define DISP_CC_MDSS_ESC0_CLK					8
+#define DISP_CC_MDSS_ESC0_CLK_SRC				9
+#define DISP_CC_MDSS_ESC1_CLK					10
+#define DISP_CC_MDSS_ESC1_CLK_SRC				11
+#define DISP_CC_MDSS_MDP_CLK					12
+#define DISP_CC_MDSS_MDP_CLK_SRC				13
+#define DISP_CC_MDSS_MDP_LUT_CLK				14
+#define DISP_CC_MDSS_PCLK0_CLK					15
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				16
+#define DISP_CC_MDSS_PCLK1_CLK					17
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				18
+#define DISP_CC_MDSS_ROT_CLK					19
+#define DISP_CC_MDSS_ROT_CLK_SRC				20
+#define DISP_CC_MDSS_RSCC_AHB_CLK				21
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				22
+#define DISP_CC_MDSS_VSYNC_CLK					23
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				24
+#define DISP_CC_PLL0						25
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				26
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				27
+#define DISP_CC_MDSS_DP_AUX_CLK					28
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC				29
+#define DISP_CC_MDSS_DP_CRYPTO_CLK				30
+#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC				31
+#define DISP_CC_MDSS_DP_LINK_CLK				32
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC				33
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK				34
+#define DISP_CC_MDSS_DP_PIXEL1_CLK				35
+#define DISP_CC_MDSS_DP_PIXEL1_CLK_SRC				36
+#define DISP_CC_MDSS_DP_PIXEL_CLK				37
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC				38
+
+/* DISP_CC Reset */
+#define DISP_CC_MDSS_RSCC_BCR					0
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,gpucc-sdm845.h b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
new file mode 100644
index 000000000000..9690d901b50a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_CX_GMU_CLK			0
+#define GPU_CC_CXO_CLK				1
+#define GPU_CC_GMU_CLK_SRC			2
+#define GPU_CC_PLL1				3
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_CX_BCR			0
+#define GPUCC_GPU_CC_GMU_BCR			1
+#define GPUCC_GPU_CC_XO_BCR			2
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,lpass-sdm845.h b/include/dt-bindings/clock/qcom,lpass-sdm845.h
new file mode 100644
index 000000000000..659050846f61
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+
+#define LPASS_Q6SS_AHBM_AON_CLK				0
+#define LPASS_Q6SS_AHBS_AON_CLK				1
+#define LPASS_QDSP6SS_XO_CLK				2
+#define LPASS_QDSP6SS_SLEEP_CLK				3
+#define LPASS_QDSP6SS_CORE_CLK				4
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
new file mode 100644
index 000000000000..0a7d1be0d124
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved. */
+
+
+#ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
+#define _DT_BINDINGS_CLK_MSM_RPMH_H
+
+/* RPMh controlled clocks */
+#define RPMH_CXO_CLK				0
+#define RPMH_CXO_CLK_A				1
+#define RPMH_LN_BB_CLK2				2
+#define RPMH_LN_BB_CLK2_A			3
+#define RPMH_LN_BB_CLK3				4
+#define RPMH_LN_BB_CLK3_A			5
+#define RPMH_RF_CLK1				6
+#define RPMH_RF_CLK1_A				7
+#define RPMH_RF_CLK2				8
+#define RPMH_RF_CLK2_A				9
+#define RPMH_RF_CLK3				10
+#define RPMH_RF_CLK3_A				11
+#define RPMH_IPA_CLK				12
+#define RPMH_LN_BB_CLK1				13
+#define RPMH_LN_BB_CLK1_A			14
+#define RPMH_CE_CLK				15
+#define RPMH_QPIC_CLK				16
+#define RPMH_DIV_CLK1				17
+#define RPMH_DIV_CLK1_A				18
+#define RPMH_RF_CLK4				19
+#define RPMH_RF_CLK4_A				20
+#define RPMH_RF_CLK5				21
+#define RPMH_RF_CLK5_A				22
+#define RPMH_PKA_CLK				23
+#define RPMH_HWKM_CLK				24
+#define RPMH_QLINK_CLK				25
+#define RPMH_QLINK_CLK_A			26
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,videocc-sdm845.h b/include/dt-bindings/clock/qcom,videocc-sdm845.h
new file mode 100644
index 000000000000..1b868165e8ce
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,videocc-sdm845.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_VIDEO_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_VIDEO_CC_SDM845_H
+
+/* VIDEO_CC clock registers */
+#define VIDEO_CC_APB_CLK		0
+#define VIDEO_CC_AT_CLK			1
+#define VIDEO_CC_QDSS_TRIG_CLK		2
+#define VIDEO_CC_QDSS_TSCTR_DIV8_CLK	3
+#define VIDEO_CC_VCODEC0_AXI_CLK	4
+#define VIDEO_CC_VCODEC0_CORE_CLK	5
+#define VIDEO_CC_VCODEC1_AXI_CLK	6
+#define VIDEO_CC_VCODEC1_CORE_CLK	7
+#define VIDEO_CC_VENUS_AHB_CLK		8
+#define VIDEO_CC_VENUS_CLK_SRC		9
+#define VIDEO_CC_VENUS_CTL_AXI_CLK	10
+#define VIDEO_CC_VENUS_CTL_CORE_CLK	11
+#define VIDEO_PLL0			12
+
+/* VIDEO_CC Resets */
+#define VIDEO_CC_VENUS_BCR		0
+#define VIDEO_CC_VCODEC0_BCR		1
+#define VIDEO_CC_VCODEC1_BCR		2
+#define VIDEO_CC_INTERFACE_BCR		3
+
+/* VIDEO_CC GDSCRs */
+#define VENUS_GDSC			0
+#define VCODEC0_GDSC			1
+#define VCODEC1_GDSC			2
+
+#endif
diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/qcom-gpi.h
new file mode 100644
index 000000000000..ebda2a37f52a
--- /dev/null
+++ b/include/dt-bindings/dma/qcom-gpi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright (c) 2020, Linaro Ltd.  */
+
+#ifndef __DT_BINDINGS_DMA_QCOM_GPI_H__
+#define __DT_BINDINGS_DMA_QCOM_GPI_H__
+
+#define QCOM_GPI_SPI		1
+#define QCOM_GPI_UART		2
+#define QCOM_GPI_I2C		3
+
+#endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */
diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/firmware/qcom,scm.h
new file mode 100644
index 000000000000..d1dc09e72923
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom,scm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+#define _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+
+#define QCOM_SCM_VMID_HLOS		0x3
+#define QCOM_SCM_VMID_SSC_Q6		0x5
+#define QCOM_SCM_VMID_ADSP_Q6		0x6
+#define QCOM_SCM_VMID_MSS_MSA		0xF
+#define QCOM_SCM_VMID_WLAN		0x18
+#define QCOM_SCM_VMID_WLAN_CE		0x19
+#define QCOM_SCM_VMID_NAV		0x2B
+
+#endif
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
new file mode 100644
index 000000000000..08adfe25964c
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_H
+
+/* Voltage ADC channels */
+#define VADC_USBIN				0x00
+#define VADC_DCIN				0x01
+#define VADC_VCHG_SNS				0x02
+#define VADC_SPARE1_03				0x03
+#define VADC_USB_ID_MV				0x04
+#define VADC_VCOIN				0x05
+#define VADC_VBAT_SNS				0x06
+#define VADC_VSYS				0x07
+#define VADC_DIE_TEMP				0x08
+#define VADC_REF_625MV				0x09
+#define VADC_REF_1250MV				0x0a
+#define VADC_CHG_TEMP				0x0b
+#define VADC_SPARE1				0x0c
+#define VADC_SPARE2				0x0d
+#define VADC_GND_REF				0x0e
+#define VADC_VDD_VADC				0x0f
+
+#define VADC_P_MUX1_1_1				0x10
+#define VADC_P_MUX2_1_1				0x11
+#define VADC_P_MUX3_1_1				0x12
+#define VADC_P_MUX4_1_1				0x13
+#define VADC_P_MUX5_1_1				0x14
+#define VADC_P_MUX6_1_1				0x15
+#define VADC_P_MUX7_1_1				0x16
+#define VADC_P_MUX8_1_1				0x17
+#define VADC_P_MUX9_1_1				0x18
+#define VADC_P_MUX10_1_1			0x19
+#define VADC_P_MUX11_1_1			0x1a
+#define VADC_P_MUX12_1_1			0x1b
+#define VADC_P_MUX13_1_1			0x1c
+#define VADC_P_MUX14_1_1			0x1d
+#define VADC_P_MUX15_1_1			0x1e
+#define VADC_P_MUX16_1_1			0x1f
+
+#define VADC_P_MUX1_1_3				0x20
+#define VADC_P_MUX2_1_3				0x21
+#define VADC_P_MUX3_1_3				0x22
+#define VADC_P_MUX4_1_3				0x23
+#define VADC_P_MUX5_1_3				0x24
+#define VADC_P_MUX6_1_3				0x25
+#define VADC_P_MUX7_1_3				0x26
+#define VADC_P_MUX8_1_3				0x27
+#define VADC_P_MUX9_1_3				0x28
+#define VADC_P_MUX10_1_3			0x29
+#define VADC_P_MUX11_1_3			0x2a
+#define VADC_P_MUX12_1_3			0x2b
+#define VADC_P_MUX13_1_3			0x2c
+#define VADC_P_MUX14_1_3			0x2d
+#define VADC_P_MUX15_1_3			0x2e
+#define VADC_P_MUX16_1_3			0x2f
+
+#define VADC_LR_MUX1_BAT_THERM			0x30
+#define VADC_LR_MUX2_BAT_ID			0x31
+#define VADC_LR_MUX3_XO_THERM			0x32
+#define VADC_LR_MUX4_AMUX_THM1			0x33
+#define VADC_LR_MUX5_AMUX_THM2			0x34
+#define VADC_LR_MUX6_AMUX_THM3			0x35
+#define VADC_LR_MUX7_HW_ID			0x36
+#define VADC_LR_MUX8_AMUX_THM4			0x37
+#define VADC_LR_MUX9_AMUX_THM5			0x38
+#define VADC_LR_MUX10_USB_ID			0x39
+#define VADC_AMUX_PU1				0x3a
+#define VADC_AMUX_PU2				0x3b
+#define VADC_LR_MUX3_BUF_XO_THERM		0x3c
+
+#define VADC_LR_MUX1_PU1_BAT_THERM		0x70
+#define VADC_LR_MUX2_PU1_BAT_ID			0x71
+#define VADC_LR_MUX3_PU1_XO_THERM		0x72
+#define VADC_LR_MUX4_PU1_AMUX_THM1		0x73
+#define VADC_LR_MUX5_PU1_AMUX_THM2		0x74
+#define VADC_LR_MUX6_PU1_AMUX_THM3		0x75
+#define VADC_LR_MUX7_PU1_AMUX_HW_ID		0x76
+#define VADC_LR_MUX8_PU1_AMUX_THM4		0x77
+#define VADC_LR_MUX9_PU1_AMUX_THM5		0x78
+#define VADC_LR_MUX10_PU1_AMUX_USB_ID		0x79
+#define VADC_LR_MUX3_BUF_PU1_XO_THERM		0x7c
+
+#define VADC_LR_MUX1_PU2_BAT_THERM		0xb0
+#define VADC_LR_MUX2_PU2_BAT_ID			0xb1
+#define VADC_LR_MUX3_PU2_XO_THERM		0xb2
+#define VADC_LR_MUX4_PU2_AMUX_THM1		0xb3
+#define VADC_LR_MUX5_PU2_AMUX_THM2		0xb4
+#define VADC_LR_MUX6_PU2_AMUX_THM3		0xb5
+#define VADC_LR_MUX7_PU2_AMUX_HW_ID		0xb6
+#define VADC_LR_MUX8_PU2_AMUX_THM4		0xb7
+#define VADC_LR_MUX9_PU2_AMUX_THM5		0xb8
+#define VADC_LR_MUX10_PU2_AMUX_USB_ID		0xb9
+#define VADC_LR_MUX3_BUF_PU2_XO_THERM		0xbc
+
+#define VADC_LR_MUX1_PU1_PU2_BAT_THERM		0xf0
+#define VADC_LR_MUX2_PU1_PU2_BAT_ID		0xf1
+#define VADC_LR_MUX3_PU1_PU2_XO_THERM		0xf2
+#define VADC_LR_MUX4_PU1_PU2_AMUX_THM1		0xf3
+#define VADC_LR_MUX5_PU1_PU2_AMUX_THM2		0xf4
+#define VADC_LR_MUX6_PU1_PU2_AMUX_THM3		0xf5
+#define VADC_LR_MUX7_PU1_PU2_AMUX_HW_ID		0xf6
+#define VADC_LR_MUX8_PU1_PU2_AMUX_THM4		0xf7
+#define VADC_LR_MUX9_PU1_PU2_AMUX_THM5		0xf8
+#define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
+#define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
+
+/* ADC channels for SPMI PMIC5 */
+
+#define ADC5_REF_GND				0x00
+#define ADC5_1P25VREF				0x01
+#define ADC5_VREF_VADC				0x02
+#define ADC5_VREF_VADC5_DIV_3			0x82
+#define ADC5_VPH_PWR				0x83
+#define ADC5_VBAT_SNS				0x84
+#define ADC5_VCOIN				0x85
+#define ADC5_DIE_TEMP				0x06
+#define ADC5_USB_IN_I				0x07
+#define ADC5_USB_IN_V_16			0x08
+#define ADC5_CHG_TEMP				0x09
+#define ADC5_BAT_THERM				0x0a
+#define ADC5_BAT_ID				0x0b
+#define ADC5_XO_THERM				0x0c
+#define ADC5_AMUX_THM1				0x0d
+#define ADC5_AMUX_THM2				0x0e
+#define ADC5_AMUX_THM3				0x0f
+#define ADC5_AMUX_THM4				0x10
+#define ADC5_AMUX_THM5				0x11
+#define ADC5_GPIO1				0x12
+#define ADC5_GPIO2				0x13
+#define ADC5_GPIO3				0x14
+#define ADC5_GPIO4				0x15
+#define ADC5_GPIO5				0x16
+#define ADC5_GPIO6				0x17
+#define ADC5_GPIO7				0x18
+#define ADC5_SBUx				0x99
+#define ADC5_MID_CHG_DIV6			0x1e
+#define ADC5_OFF				0xff
+
+/* 30k pull-up1 */
+#define ADC5_BAT_THERM_30K_PU			0x2a
+#define ADC5_BAT_ID_30K_PU			0x2b
+#define ADC5_XO_THERM_30K_PU			0x2c
+#define ADC5_AMUX_THM1_30K_PU			0x2d
+#define ADC5_AMUX_THM2_30K_PU			0x2e
+#define ADC5_AMUX_THM3_30K_PU			0x2f
+#define ADC5_AMUX_THM4_30K_PU			0x30
+#define ADC5_AMUX_THM5_30K_PU			0x31
+#define ADC5_GPIO1_30K_PU			0x32
+#define ADC5_GPIO2_30K_PU			0x33
+#define ADC5_GPIO3_30K_PU			0x34
+#define ADC5_GPIO4_30K_PU			0x35
+#define ADC5_GPIO5_30K_PU			0x36
+#define ADC5_GPIO6_30K_PU			0x37
+#define ADC5_GPIO7_30K_PU			0x38
+#define ADC5_SBUx_30K_PU			0x39
+
+/* 100k pull-up2 */
+#define ADC5_BAT_THERM_100K_PU			0x4a
+#define ADC5_BAT_ID_100K_PU			0x4b
+#define ADC5_XO_THERM_100K_PU			0x4c
+#define ADC5_AMUX_THM1_100K_PU			0x4d
+#define ADC5_AMUX_THM2_100K_PU			0x4e
+#define ADC5_AMUX_THM3_100K_PU			0x4f
+#define ADC5_AMUX_THM4_100K_PU			0x50
+#define ADC5_AMUX_THM5_100K_PU			0x51
+#define ADC5_GPIO1_100K_PU			0x52
+#define ADC5_GPIO2_100K_PU			0x53
+#define ADC5_GPIO3_100K_PU			0x54
+#define ADC5_GPIO4_100K_PU			0x55
+#define ADC5_GPIO5_100K_PU			0x56
+#define ADC5_GPIO6_100K_PU			0x57
+#define ADC5_GPIO7_100K_PU			0x58
+#define ADC5_SBUx_100K_PU			0x59
+
+/* 400k pull-up3 */
+#define ADC5_BAT_THERM_400K_PU			0x6a
+#define ADC5_BAT_ID_400K_PU			0x6b
+#define ADC5_XO_THERM_400K_PU			0x6c
+#define ADC5_AMUX_THM1_400K_PU			0x6d
+#define ADC5_AMUX_THM2_400K_PU			0x6e
+#define ADC5_AMUX_THM3_400K_PU			0x6f
+#define ADC5_AMUX_THM4_400K_PU			0x70
+#define ADC5_AMUX_THM5_400K_PU			0x71
+#define ADC5_GPIO1_400K_PU			0x72
+#define ADC5_GPIO2_400K_PU			0x73
+#define ADC5_GPIO3_400K_PU			0x74
+#define ADC5_GPIO4_400K_PU			0x75
+#define ADC5_GPIO5_400K_PU			0x76
+#define ADC5_GPIO6_400K_PU			0x77
+#define ADC5_GPIO7_400K_PU			0x78
+#define ADC5_SBUx_400K_PU			0x79
+
+/* 1/3 Divider */
+#define ADC5_GPIO1_DIV3				0x92
+#define ADC5_GPIO2_DIV3				0x93
+#define ADC5_GPIO3_DIV3				0x94
+#define ADC5_GPIO4_DIV3				0x95
+#define ADC5_GPIO5_DIV3				0x96
+#define ADC5_GPIO6_DIV3				0x97
+#define ADC5_GPIO7_DIV3				0x98
+#define ADC5_SBUx_DIV3				0x99
+
+/* Current and combined current/voltage channels */
+#define ADC5_INT_EXT_ISENSE			0xa1
+#define ADC5_PARALLEL_ISENSE			0xa5
+#define ADC5_CUR_REPLICA_VDS			0xa7
+#define ADC5_CUR_SENS_BATFET_VDS_OFFSET		0xa9
+#define ADC5_CUR_SENS_REPLICA_VDS_OFFSET	0xab
+#define ADC5_EXT_SENS_OFFSET			0xad
+
+#define ADC5_INT_EXT_ISENSE_VBAT_VDATA		0xb0
+#define ADC5_INT_EXT_ISENSE_VBAT_IDATA		0xb1
+#define ADC5_EXT_ISENSE_VBAT_VDATA		0xb2
+#define ADC5_EXT_ISENSE_VBAT_IDATA		0xb3
+#define ADC5_PARALLEL_ISENSE_VBAT_VDATA		0xb4
+#define ADC5_PARALLEL_ISENSE_VBAT_IDATA		0xb5
+
+#define ADC5_MAX_CHANNEL			0xc0
+
+/* ADC channels for ADC for PMIC7 */
+
+#define ADC7_REF_GND				0x00
+#define ADC7_1P25VREF				0x01
+#define ADC7_VREF_VADC				0x02
+#define ADC7_DIE_TEMP				0x03
+
+#define ADC7_AMUX_THM1				0x04
+#define ADC7_AMUX_THM2				0x05
+#define ADC7_AMUX_THM3				0x06
+#define ADC7_AMUX_THM4				0x07
+#define ADC7_AMUX_THM5				0x08
+#define ADC7_AMUX_THM6				0x09
+#define ADC7_GPIO1				0x0a
+#define ADC7_GPIO2				0x0b
+#define ADC7_GPIO3				0x0c
+#define ADC7_GPIO4				0x0d
+
+#define ADC7_CHG_TEMP				0x10
+#define ADC7_USB_IN_V_16			0x11
+#define ADC7_VDC_16				0x12
+#define ADC7_CC1_ID				0x13
+#define ADC7_VREF_BAT_THERM			0x15
+#define ADC7_IIN_FB				0x17
+
+/* 30k pull-up1 */
+#define ADC7_AMUX_THM1_30K_PU			0x24
+#define ADC7_AMUX_THM2_30K_PU			0x25
+#define ADC7_AMUX_THM3_30K_PU			0x26
+#define ADC7_AMUX_THM4_30K_PU			0x27
+#define ADC7_AMUX_THM5_30K_PU			0x28
+#define ADC7_AMUX_THM6_30K_PU			0x29
+#define ADC7_GPIO1_30K_PU			0x2a
+#define ADC7_GPIO2_30K_PU			0x2b
+#define ADC7_GPIO3_30K_PU			0x2c
+#define ADC7_GPIO4_30K_PU			0x2d
+#define ADC7_CC1_ID_30K_PU			0x33
+
+/* 100k pull-up2 */
+#define ADC7_AMUX_THM1_100K_PU			0x44
+#define ADC7_AMUX_THM2_100K_PU			0x45
+#define ADC7_AMUX_THM3_100K_PU			0x46
+#define ADC7_AMUX_THM4_100K_PU			0x47
+#define ADC7_AMUX_THM5_100K_PU			0x48
+#define ADC7_AMUX_THM6_100K_PU			0x49
+#define ADC7_GPIO1_100K_PU			0x4a
+#define ADC7_GPIO2_100K_PU			0x4b
+#define ADC7_GPIO3_100K_PU			0x4c
+#define ADC7_GPIO4_100K_PU			0x4d
+#define ADC7_CC1_ID_100K_PU			0x53
+
+/* 400k pull-up3 */
+#define ADC7_AMUX_THM1_400K_PU			0x64
+#define ADC7_AMUX_THM2_400K_PU			0x65
+#define ADC7_AMUX_THM3_400K_PU			0x66
+#define ADC7_AMUX_THM4_400K_PU			0x67
+#define ADC7_AMUX_THM5_400K_PU			0x68
+#define ADC7_AMUX_THM6_400K_PU			0x69
+#define ADC7_GPIO1_400K_PU			0x6a
+#define ADC7_GPIO2_400K_PU			0x6b
+#define ADC7_GPIO3_400K_PU			0x6c
+#define ADC7_GPIO4_400K_PU			0x6d
+#define ADC7_CC1_ID_400K_PU			0x73
+
+/* 1/3 Divider */
+#define ADC7_GPIO1_DIV3				0x8a
+#define ADC7_GPIO2_DIV3				0x8b
+#define ADC7_GPIO3_DIV3				0x8c
+#define ADC7_GPIO4_DIV3				0x8d
+
+#define ADC7_VPH_PWR				0x8e
+#define ADC7_VBAT_SNS				0x8f
+
+#define ADC7_SBUx				0x94
+#define ADC7_VBAT_2S_MID			0x96
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bindings/interconnect/qcom,osm-l3.h
new file mode 100644
index 000000000000..61ef649ae565
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
+
+#define MASTER_OSM_L3_APPS	0
+#define SLAVE_OSM_L3		1
+
+#define MASTER_EPSS_L3_APPS	0
+#define SLAVE_EPSS_L3_SHARED	1
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,sdm845.h b/include/dt-bindings/interconnect/qcom,sdm845.h
new file mode 100644
index 000000000000..67b500e24915
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdm845.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SDM845 interconnect IDs
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDM845_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SDM845_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_TSIF			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_UFS_CARD			4
+#define MASTER_UFS_MEM			5
+#define MASTER_PCIE_0			6
+#define SLAVE_A1NOC_SNOC		7
+#define SLAVE_SERVICE_A1NOC		8
+#define SLAVE_ANOC_PCIE_A1NOC_SNOC	9
+#define MASTER_QUP_1			10
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_CNOC_A2NOC		2
+#define MASTER_CRYPTO			3
+#define MASTER_IPA			4
+#define MASTER_PCIE_1			5
+#define MASTER_QDSS_ETR			6
+#define MASTER_USB3_0			7
+#define MASTER_USB3_1			8
+#define SLAVE_A2NOC_SNOC		9
+#define SLAVE_ANOC_PCIE_SNOC		10
+#define SLAVE_SERVICE_A2NOC		11
+#define MASTER_QUP_2			12
+
+#define MASTER_SPDM			0
+#define MASTER_TIC			1
+#define MASTER_SNOC_CNOC		2
+#define MASTER_QDSS_DAP			3
+#define SLAVE_A1NOC_CFG			4
+#define SLAVE_A2NOC_CFG			5
+#define SLAVE_AOP			6
+#define SLAVE_AOSS			7
+#define SLAVE_CAMERA_CFG		8
+#define SLAVE_CLK_CTL			9
+#define SLAVE_CDSP_CFG			10
+#define SLAVE_RBCPR_CX_CFG		11
+#define SLAVE_CRYPTO_0_CFG		12
+#define SLAVE_DCC_CFG			13
+#define SLAVE_CNOC_DDRSS		14
+#define SLAVE_DISPLAY_CFG		15
+#define SLAVE_GLM			16
+#define SLAVE_GFX3D_CFG			17
+#define SLAVE_IMEM_CFG			18
+#define SLAVE_IPA_CFG			19
+#define SLAVE_CNOC_MNOC_CFG		20
+#define SLAVE_PCIE_0_CFG		21
+#define SLAVE_PCIE_1_CFG		22
+#define SLAVE_PDM			23
+#define SLAVE_SOUTH_PHY_CFG		24
+#define SLAVE_PIMEM_CFG			25
+#define SLAVE_PRNG			26
+#define SLAVE_QDSS_CFG			27
+#define SLAVE_BLSP_2			28
+#define SLAVE_BLSP_1			29
+#define SLAVE_SDCC_2			30
+#define SLAVE_SDCC_4			31
+#define SLAVE_SNOC_CFG			32
+#define SLAVE_SPDM_WRAPPER		33
+#define SLAVE_SPSS_CFG			34
+#define SLAVE_TCSR			35
+#define SLAVE_TLMM_NORTH		36
+#define SLAVE_TLMM_SOUTH		37
+#define SLAVE_TSIF			38
+#define SLAVE_UFS_CARD_CFG		39
+#define SLAVE_UFS_MEM_CFG		40
+#define SLAVE_USB3_0			41
+#define SLAVE_USB3_1			42
+#define SLAVE_VENUS_CFG			43
+#define SLAVE_VSENSE_CTRL_CFG		44
+#define SLAVE_CNOC_A2NOC		45
+#define SLAVE_SERVICE_CNOC		46
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_MEM_NOC_CFG		2
+
+#define MASTER_APPSS_PROC		0
+#define MASTER_GNOC_CFG			1
+#define SLAVE_GNOC_SNOC			2
+#define SLAVE_GNOC_MEM_NOC		3
+#define SLAVE_SERVICE_GNOC		4
+
+#define MASTER_TCU_0			0
+#define MASTER_MEM_NOC_CFG		1
+#define MASTER_GNOC_MEM_NOC		2
+#define MASTER_MNOC_HF_MEM_NOC		3
+#define MASTER_MNOC_SF_MEM_NOC		4
+#define MASTER_SNOC_GC_MEM_NOC		5
+#define MASTER_SNOC_SF_MEM_NOC		6
+#define MASTER_GFX3D			7
+#define SLAVE_MSS_PROC_MS_MPU_CFG	8
+#define SLAVE_MEM_NOC_GNOC		9
+#define SLAVE_LLCC			10
+#define SLAVE_MEM_NOC_SNOC		11
+#define SLAVE_SERVICE_MEM_NOC		12
+#define MASTER_LLCC			13
+#define SLAVE_EBI1			14
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_HF0		1
+#define MASTER_CAMNOC_HF1		2
+#define MASTER_CAMNOC_SF		3
+#define MASTER_MDP0			4
+#define MASTER_MDP1			5
+#define MASTER_ROTATOR			6
+#define MASTER_VIDEO_P0			7
+#define MASTER_VIDEO_P1			8
+#define MASTER_VIDEO_PROC		9
+#define SLAVE_MNOC_SF_MEM_NOC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+#define MASTER_CAMNOC_HF0_UNCOMP	13
+#define MASTER_CAMNOC_HF1_UNCOMP	14
+#define MASTER_CAMNOC_SF_UNCOMP		15
+#define SLAVE_CAMNOC_UNCOMP		16
+
+#define MASTER_SNOC_CFG			0
+#define MASTER_A1NOC_SNOC		1
+#define MASTER_A2NOC_SNOC		2
+#define MASTER_GNOC_SNOC		3
+#define MASTER_MEM_NOC_SNOC		4
+#define MASTER_ANOC_PCIE_SNOC		5
+#define MASTER_PIMEM			6
+#define MASTER_GIC			7
+#define SLAVE_APPSS			8
+#define SLAVE_SNOC_CNOC			9
+#define SLAVE_SNOC_MEM_NOC_GC		10
+#define SLAVE_SNOC_MEM_NOC_SF		11
+#define SLAVE_IMEM			12
+#define SLAVE_PCIE_0			13
+#define SLAVE_PCIE_1			14
+#define SLAVE_PIMEM			15
+#define SLAVE_SERVICE_SNOC		16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_TCU			18
+
+#endif
diff --git a/include/dt-bindings/phy/phy-qcom-qusb2.h b/include/dt-bindings/phy/phy-qcom-qusb2.h
new file mode 100644
index 000000000000..5c5e4d800cac
--- /dev/null
+++ b/include/dt-bindings/phy/phy-qcom-qusb2.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_PHY_QUSB2_H_
+#define _DT_BINDINGS_QCOM_PHY_QUSB2_H_
+
+/* PHY HSTX TRIM bit values (24mA to 15mA) */
+#define QUSB2_V2_HSTX_TRIM_24_0_MA		0x0
+#define QUSB2_V2_HSTX_TRIM_23_4_MA		0x1
+#define QUSB2_V2_HSTX_TRIM_22_8_MA		0x2
+#define QUSB2_V2_HSTX_TRIM_22_2_MA		0x3
+#define QUSB2_V2_HSTX_TRIM_21_6_MA		0x4
+#define QUSB2_V2_HSTX_TRIM_21_0_MA		0x5
+#define QUSB2_V2_HSTX_TRIM_20_4_MA		0x6
+#define QUSB2_V2_HSTX_TRIM_19_8_MA		0x7
+#define QUSB2_V2_HSTX_TRIM_19_2_MA		0x8
+#define QUSB2_V2_HSTX_TRIM_18_6_MA		0x9
+#define QUSB2_V2_HSTX_TRIM_18_0_MA		0xa
+#define QUSB2_V2_HSTX_TRIM_17_4_MA		0xb
+#define QUSB2_V2_HSTX_TRIM_16_8_MA		0xc
+#define QUSB2_V2_HSTX_TRIM_16_2_MA		0xd
+#define QUSB2_V2_HSTX_TRIM_15_6_MA		0xe
+#define QUSB2_V2_HSTX_TRIM_15_0_MA		0xf
+
+/* PHY PREEMPHASIS bit values */
+#define QUSB2_V2_PREEMPHASIS_NONE		0
+#define QUSB2_V2_PREEMPHASIS_5_PERCENT		1
+#define QUSB2_V2_PREEMPHASIS_10_PERCENT		2
+#define QUSB2_V2_PREEMPHASIS_15_PERCENT		3
+
+/* PHY PREEMPHASIS-WIDTH bit values */
+#define QUSB2_V2_PREEMPHASIS_WIDTH_FULL_BIT	0
+#define QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT	1
+
+#endif
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
new file mode 100644
index 000000000000..7f4e2983a4c5
--- /dev/null
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
+#define _DT_BINDINGS_POWER_QCOM_RPMPD_H
+
+/* SA8775P Power Domain Indexes */
+#define SA8775P_CX	0
+#define SA8775P_CX_AO	1
+#define SA8775P_DDR	2
+#define SA8775P_EBI	3
+#define SA8775P_GFX	4
+#define SA8775P_LCX	5
+#define SA8775P_LMX	6
+#define SA8775P_MMCX	7
+#define SA8775P_MMCX_AO	8
+#define SA8775P_MSS	9
+#define SA8775P_MX	10
+#define SA8775P_MX_AO	11
+#define SA8775P_MXC	12
+#define SA8775P_MXC_AO	13
+#define SA8775P_NSP0	14
+#define SA8775P_NSP1	15
+#define SA8775P_XO	16
+
+/* SDM670 Power Domain Indexes */
+#define SDM670_MX	0
+#define SDM670_MX_AO	1
+#define SDM670_CX	2
+#define SDM670_CX_AO	3
+#define SDM670_LMX	4
+#define SDM670_LCX	5
+#define SDM670_GFX	6
+#define SDM670_MSS	7
+
+/* SDM845 Power Domain Indexes */
+#define SDM845_EBI	0
+#define SDM845_MX	1
+#define SDM845_MX_AO	2
+#define SDM845_CX	3
+#define SDM845_CX_AO	4
+#define SDM845_LMX	5
+#define SDM845_LCX	6
+#define SDM845_GFX	7
+#define SDM845_MSS	8
+
+/* SDX55 Power Domain Indexes */
+#define SDX55_MSS	0
+#define SDX55_MX	1
+#define SDX55_CX	2
+
+/* SDX65 Power Domain Indexes */
+#define SDX65_MSS	0
+#define SDX65_MX	1
+#define SDX65_MX_AO	2
+#define SDX65_CX	3
+#define SDX65_CX_AO	4
+#define SDX65_MXC	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6350_CX	0
+#define SM6350_GFX	1
+#define SM6350_LCX	2
+#define SM6350_LMX	3
+#define SM6350_MSS	4
+#define SM6350_MX	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6375_VDDCX		0
+#define SM6375_VDDCX_AO	1
+#define SM6375_VDDCX_VFL	2
+#define SM6375_VDDMX		3
+#define SM6375_VDDMX_AO	4
+#define SM6375_VDDMX_VFL	5
+#define SM6375_VDDGX		6
+#define SM6375_VDDGX_AO	7
+#define SM6375_VDD_LPI_CX	8
+#define SM6375_VDD_LPI_MX	9
+
+/* SM8150 Power Domain Indexes */
+#define SM8150_MSS	0
+#define SM8150_EBI	1
+#define SM8150_LMX	2
+#define SM8150_LCX	3
+#define SM8150_GFX	4
+#define SM8150_MX	5
+#define SM8150_MX_AO	6
+#define SM8150_CX	7
+#define SM8150_CX_AO	8
+#define SM8150_MMCX	9
+#define SM8150_MMCX_AO	10
+
+/* SA8155P is a special case, kept for backwards compatibility */
+#define SA8155P_CX	SM8150_CX
+#define SA8155P_CX_AO	SM8150_CX_AO
+#define SA8155P_EBI	SM8150_EBI
+#define SA8155P_GFX	SM8150_GFX
+#define SA8155P_MSS	SM8150_MSS
+#define SA8155P_MX	SM8150_MX
+#define SA8155P_MX_AO	SM8150_MX_AO
+
+/* SM8250 Power Domain Indexes */
+#define SM8250_CX	0
+#define SM8250_CX_AO	1
+#define SM8250_EBI	2
+#define SM8250_GFX	3
+#define SM8250_LCX	4
+#define SM8250_LMX	5
+#define SM8250_MMCX	6
+#define SM8250_MMCX_AO	7
+#define SM8250_MX	8
+#define SM8250_MX_AO	9
+
+/* SM8350 Power Domain Indexes */
+#define SM8350_CX	0
+#define SM8350_CX_AO	1
+#define SM8350_EBI	2
+#define SM8350_GFX	3
+#define SM8350_LCX	4
+#define SM8350_LMX	5
+#define SM8350_MMCX	6
+#define SM8350_MMCX_AO	7
+#define SM8350_MX	8
+#define SM8350_MX_AO	9
+#define SM8350_MXC	10
+#define SM8350_MXC_AO	11
+#define SM8350_MSS	12
+
+/* SM8450 Power Domain Indexes */
+#define SM8450_CX	0
+#define SM8450_CX_AO	1
+#define SM8450_EBI	2
+#define SM8450_GFX	3
+#define SM8450_LCX	4
+#define SM8450_LMX	5
+#define SM8450_MMCX	6
+#define SM8450_MMCX_AO	7
+#define SM8450_MX	8
+#define SM8450_MX_AO	9
+#define SM8450_MXC	10
+#define SM8450_MXC_AO	11
+#define SM8450_MSS	12
+
+/* SM8550 Power Domain Indexes */
+#define SM8550_CX	0
+#define SM8550_CX_AO	1
+#define SM8550_EBI	2
+#define SM8550_GFX	3
+#define SM8550_LCX	4
+#define SM8550_LMX	5
+#define SM8550_MMCX	6
+#define SM8550_MMCX_AO	7
+#define SM8550_MX	8
+#define SM8550_MX_AO	9
+#define SM8550_MXC	10
+#define SM8550_MXC_AO	11
+#define SM8550_MSS	12
+#define SM8550_NSP	13
+
+/* QDU1000/QRU1000 Power Domain Indexes */
+#define QDU1000_EBI	0
+#define QDU1000_MSS	1
+#define QDU1000_CX	2
+#define QDU1000_MX	3
+
+/* SC7180 Power Domain Indexes */
+#define SC7180_CX	0
+#define SC7180_CX_AO	1
+#define SC7180_GFX	2
+#define SC7180_MX	3
+#define SC7180_MX_AO	4
+#define SC7180_LMX	5
+#define SC7180_LCX	6
+#define SC7180_MSS	7
+
+/* SC7280 Power Domain Indexes */
+#define SC7280_CX	0
+#define SC7280_CX_AO	1
+#define SC7280_EBI	2
+#define SC7280_GFX	3
+#define SC7280_MX	4
+#define SC7280_MX_AO	5
+#define SC7280_LMX	6
+#define SC7280_LCX	7
+#define SC7280_MSS	8
+
+/* SC8180X Power Domain Indexes */
+#define SC8180X_CX	0
+#define SC8180X_CX_AO	1
+#define SC8180X_EBI	2
+#define SC8180X_GFX	3
+#define SC8180X_LCX	4
+#define SC8180X_LMX	5
+#define SC8180X_MMCX	6
+#define SC8180X_MMCX_AO	7
+#define SC8180X_MSS	8
+#define SC8180X_MX	9
+#define SC8180X_MX_AO	10
+
+/* SC8280XP Power Domain Indexes */
+#define SC8280XP_CX		0
+#define SC8280XP_CX_AO		1
+#define SC8280XP_DDR		2
+#define SC8280XP_EBI		3
+#define SC8280XP_GFX		4
+#define SC8280XP_LCX		5
+#define SC8280XP_LMX		6
+#define SC8280XP_MMCX		7
+#define SC8280XP_MMCX_AO	8
+#define SC8280XP_MSS		9
+#define SC8280XP_MX		10
+#define SC8280XP_MXC		12
+#define SC8280XP_MX_AO		11
+#define SC8280XP_NSP		13
+#define SC8280XP_QPHY		14
+#define SC8280XP_XO		15
+
+/* SDM845 Power Domain performance levels */
+#define RPMH_REGULATOR_LEVEL_RETENTION		16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
+#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
+#define RPMH_REGULATOR_LEVEL_SVS		128
+#define RPMH_REGULATOR_LEVEL_SVS_L0		144
+#define RPMH_REGULATOR_LEVEL_SVS_L1		192
+#define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_NOM		256
+#define RPMH_REGULATOR_LEVEL_NOM_L0		288
+#define RPMH_REGULATOR_LEVEL_NOM_L1		320
+#define RPMH_REGULATOR_LEVEL_NOM_L2		336
+#define RPMH_REGULATOR_LEVEL_TURBO		384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
+#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
+
+/* MDM9607 Power Domains */
+#define MDM9607_VDDCX		0
+#define MDM9607_VDDCX_AO	1
+#define MDM9607_VDDCX_VFL	2
+#define MDM9607_VDDMX		3
+#define MDM9607_VDDMX_AO	4
+#define MDM9607_VDDMX_VFL	5
+
+/* MSM8226 Power Domain Indexes */
+#define MSM8226_VDDCX		0
+#define MSM8226_VDDCX_AO	1
+#define MSM8226_VDDCX_VFC	2
+
+/* MSM8939 Power Domains */
+#define MSM8939_VDDMDCX		0
+#define MSM8939_VDDMDCX_AO	1
+#define MSM8939_VDDMDCX_VFC	2
+#define MSM8939_VDDCX		3
+#define MSM8939_VDDCX_AO	4
+#define MSM8939_VDDCX_VFC	5
+#define MSM8939_VDDMX		6
+#define MSM8939_VDDMX_AO	7
+
+/* MSM8916 Power Domain Indexes */
+#define MSM8916_VDDCX		0
+#define MSM8916_VDDCX_AO	1
+#define MSM8916_VDDCX_VFC	2
+#define MSM8916_VDDMX		3
+#define MSM8916_VDDMX_AO	4
+
+/* MSM8909 Power Domain Indexes */
+#define MSM8909_VDDCX		MSM8916_VDDCX
+#define MSM8909_VDDCX_AO	MSM8916_VDDCX_AO
+#define MSM8909_VDDCX_VFC	MSM8916_VDDCX_VFC
+#define MSM8909_VDDMX		MSM8916_VDDMX
+#define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
+
+/* MSM8917 Power Domain Indexes */
+#define MSM8917_VDDCX		0
+#define MSM8917_VDDCX_AO	1
+#define MSM8917_VDDCX_VFL	2
+#define MSM8917_VDDMX		3
+#define MSM8917_VDDMX_AO	4
+
+/* MSM8937 Power Domain Indexes */
+#define MSM8937_VDDCX		MSM8917_VDDCX
+#define MSM8937_VDDCX_AO	MSM8917_VDDCX_AO
+#define MSM8937_VDDCX_VFL	MSM8917_VDDCX_VFL
+#define MSM8937_VDDMX		MSM8917_VDDMX
+#define MSM8937_VDDMX_AO	MSM8917_VDDMX_AO
+
+/* QM215 Power Domain Indexes */
+#define QM215_VDDCX		MSM8917_VDDCX
+#define QM215_VDDCX_AO		MSM8917_VDDCX_AO
+#define QM215_VDDCX_VFL		MSM8917_VDDCX_VFL
+#define QM215_VDDMX		MSM8917_VDDMX
+#define QM215_VDDMX_AO		MSM8917_VDDMX_AO
+
+/* MSM8953 Power Domain Indexes */
+#define MSM8953_VDDMD		0
+#define MSM8953_VDDMD_AO	1
+#define MSM8953_VDDCX		2
+#define MSM8953_VDDCX_AO	3
+#define MSM8953_VDDCX_VFL	4
+#define MSM8953_VDDMX		5
+#define MSM8953_VDDMX_AO	6
+
+/* MSM8976 Power Domain Indexes */
+#define MSM8976_VDDCX		0
+#define MSM8976_VDDCX_AO	1
+#define MSM8976_VDDCX_VFL	2
+#define MSM8976_VDDMX		3
+#define MSM8976_VDDMX_AO	4
+#define MSM8976_VDDMX_VFL	5
+
+/* MSM8994 Power Domain Indexes */
+#define MSM8994_VDDCX		0
+#define MSM8994_VDDCX_AO	1
+#define MSM8994_VDDCX_VFC	2
+#define MSM8994_VDDMX		3
+#define MSM8994_VDDMX_AO	4
+#define MSM8994_VDDGFX		5
+#define MSM8994_VDDGFX_VFC	6
+
+/* MSM8996 Power Domain Indexes */
+#define MSM8996_VDDCX		0
+#define MSM8996_VDDCX_AO	1
+#define MSM8996_VDDCX_VFC	2
+#define MSM8996_VDDMX		3
+#define MSM8996_VDDMX_AO	4
+#define MSM8996_VDDSSCX		5
+#define MSM8996_VDDSSCX_VFC	6
+
+/* MSM8998 Power Domain Indexes */
+#define MSM8998_VDDCX		0
+#define MSM8998_VDDCX_AO	1
+#define MSM8998_VDDCX_VFL	2
+#define MSM8998_VDDMX		3
+#define MSM8998_VDDMX_AO	4
+#define MSM8998_VDDMX_VFL	5
+#define MSM8998_SSCCX		6
+#define MSM8998_SSCCX_VFL	7
+#define MSM8998_SSCMX		8
+#define MSM8998_SSCMX_VFL	9
+
+/* QCS404 Power Domains */
+#define QCS404_VDDMX		0
+#define QCS404_VDDMX_AO		1
+#define QCS404_VDDMX_VFL	2
+#define QCS404_LPICX		3
+#define QCS404_LPICX_VFL	4
+#define QCS404_LPIMX		5
+#define QCS404_LPIMX_VFL	6
+
+/* SDM660 Power Domains */
+#define SDM660_VDDCX		0
+#define SDM660_VDDCX_AO		1
+#define SDM660_VDDCX_VFL	2
+#define SDM660_VDDMX		3
+#define SDM660_VDDMX_AO		4
+#define SDM660_VDDMX_VFL	5
+#define SDM660_SSCCX		6
+#define SDM660_SSCCX_VFL	7
+#define SDM660_SSCMX		8
+#define SDM660_SSCMX_VFL	9
+
+/* SM6115 Power Domains */
+#define SM6115_VDDCX		0
+#define SM6115_VDDCX_AO		1
+#define SM6115_VDDCX_VFL	2
+#define SM6115_VDDMX		3
+#define SM6115_VDDMX_AO		4
+#define SM6115_VDDMX_VFL	5
+#define SM6115_VDD_LPI_CX	6
+#define SM6115_VDD_LPI_MX	7
+
+/* SM6125 Power Domains */
+#define SM6125_VDDCX		0
+#define SM6125_VDDCX_AO		1
+#define SM6125_VDDCX_VFL	2
+#define SM6125_VDDMX		3
+#define SM6125_VDDMX_AO		4
+#define SM6125_VDDMX_VFL	5
+
+/* QCM2290 Power Domains */
+#define QCM2290_VDDCX		0
+#define QCM2290_VDDCX_AO	1
+#define QCM2290_VDDCX_VFL	2
+#define QCM2290_VDDMX		3
+#define QCM2290_VDDMX_AO	4
+#define QCM2290_VDDMX_VFL	5
+#define QCM2290_VDD_LPI_CX	6
+#define QCM2290_VDD_LPI_MX	7
+
+/* RPM SMD Power Domain performance levels */
+#define RPM_SMD_LEVEL_RETENTION       16
+#define RPM_SMD_LEVEL_RETENTION_PLUS  32
+#define RPM_SMD_LEVEL_MIN_SVS         48
+#define RPM_SMD_LEVEL_LOW_SVS         64
+#define RPM_SMD_LEVEL_SVS             128
+#define RPM_SMD_LEVEL_SVS_PLUS        192
+#define RPM_SMD_LEVEL_NOM             256
+#define RPM_SMD_LEVEL_NOM_PLUS        320
+#define RPM_SMD_LEVEL_TURBO           384
+#define RPM_SMD_LEVEL_TURBO_NO_CPR    416
+#define RPM_SMD_LEVEL_TURBO_HIGH      448
+#define RPM_SMD_LEVEL_BINNING         512
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sdm845-aoss.h b/include/dt-bindings/reset/qcom,sdm845-aoss.h
new file mode 100644
index 000000000000..476c5fc873b6
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sdm845-aoss.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_AOSS_SDM_845_H
+#define _DT_BINDINGS_RESET_AOSS_SDM_845_H
+
+#define AOSS_CC_MSS_RESTART	0
+#define AOSS_CC_CAMSS_RESTART	1
+#define AOSS_CC_VENUS_RESTART	2
+#define AOSS_CC_GPU_RESTART	3
+#define AOSS_CC_DISPSS_RESTART	4
+#define AOSS_CC_WCSS_RESTART	5
+#define AOSS_CC_LPASS_RESTART	6
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sdm845-pdc.h b/include/dt-bindings/reset/qcom,sdm845-pdc.h
new file mode 100644
index 000000000000..03a0c0eb8147
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sdm845-pdc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_PDC_SDM_845_H
+#define _DT_BINDINGS_RESET_PDC_SDM_845_H
+
+#define PDC_APPS_SYNC_RESET	0
+#define PDC_SP_SYNC_RESET	1
+#define PDC_AUDIO_SYNC_RESET	2
+#define PDC_SENSORS_SYNC_RESET	3
+#define PDC_AOP_SYNC_RESET	4
+#define PDC_DEBUG_SYNC_RESET	5
+#define PDC_GPU_SYNC_RESET	6
+#define PDC_DISPLAY_SYNC_RESET	7
+#define PDC_COMPUTE_SYNC_RESET	8
+#define PDC_MODEM_SYNC_RESET	9
+#define PDC_WLAN_RF_SYNC_RESET	10
+#define PDC_WPSS_SYNC_RESET	11
+
+#endif
diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
new file mode 100644
index 000000000000..006362400c0f
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,apr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_QCOM_APR_H
+#define __DT_BINDINGS_QCOM_APR_H
+
+/* Domain IDs */
+#define APR_DOMAIN_SIM		0x1
+#define APR_DOMAIN_PC		0x2
+#define APR_DOMAIN_MODEM	0x3
+#define APR_DOMAIN_ADSP		0x4
+#define APR_DOMAIN_APPS		0x5
+#define APR_DOMAIN_MAX		0x6
+
+/* ADSP service IDs */
+#define APR_SVC_ADSP_CORE	0x3
+#define APR_SVC_AFE		0x4
+#define APR_SVC_VSM		0x5
+#define APR_SVC_VPM		0x6
+#define APR_SVC_ASM		0x7
+#define APR_SVC_ADM		0x8
+#define APR_SVC_ADSP_MVM	0x09
+#define APR_SVC_ADSP_CVS	0x0A
+#define APR_SVC_ADSP_CVP	0x0B
+#define APR_SVC_USM		0x0C
+#define APR_SVC_LSM		0x0D
+#define APR_SVC_VIDC		0x16
+#define APR_SVC_MAX		0x17
+
+#endif /* __DT_BINDINGS_QCOM_APR_H */
diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
new file mode 100644
index 000000000000..868f998ea998
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_QCOM_RPMH_RSC_H__
+#define __DT_QCOM_RPMH_RSC_H__
+
+#define SLEEP_TCS	0
+#define WAKE_TCS	1
+#define ACTIVE_TCS	2
+#define CONTROL_TCS	3
+
+#endif /* __DT_QCOM_RPMH_RSC_H__ */

-- 
2.42.1

