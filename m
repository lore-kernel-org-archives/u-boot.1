Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81DDC3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 01:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3CA8269F;
	Sun, 11 May 2025 03:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FAF82A36; Sun, 11 May 2025 03:10:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D469882952
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 03:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544182696;
 Sat, 10 May 2025 18:10:05 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EDA23F58B;
 Sat, 10 May 2025 18:10:15 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 3/6] arm64: dts: allwinner: a100: Add CPU Operating
 Performance Points table
Date: Sun, 11 May 2025 02:10:00 +0100
Message-ID: <20250511011003.15654-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250511011003.15654-1-andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
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

Add an Operating Performance Points table for the CPU cores to
enable Dynamic Voltage & Frequency Scaling on the A100.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
[masterr3c0rd@epochal.quest: fix typos in -cpu-opp, use compatible]
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Link: https://patch.msgid.link/20241031070232.1793078-14-masterr3c0rd@epochal.quest
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

[ upstream commit: a8181e6861fec3068f393d77ff81b2aaf4ea4203 ]
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts |  5 ++
 .../arm64/allwinner/sun50i-a100-cpu-opp.dtsi  | 90 +++++++++++++++++++
 .../src/arm64/allwinner/sun50i-a100.dtsi      |  8 ++
 3 files changed, 103 insertions(+)
 create mode 100644 dts/upstream/src/arm64/allwinner/sun50i-a100-cpu-opp.dtsi

diff --git a/dts/upstream/src/arm64/allwinner/sun50i-a100-allwinner-perf1.dts b/dts/upstream/src/arm64/allwinner/sun50i-a100-allwinner-perf1.dts
index a387bccdcef..a7e3be0155a 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/dts/upstream/src/arm64/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-a100.dtsi"
+#include "sun50i-a100-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -38,6 +39,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &pio {
 	vcc-pb-supply = <&reg_dcdc1>;
 	vcc-pc-supply = <&reg_eldo1>;
diff --git a/dts/upstream/src/arm64/allwinner/sun50i-a100-cpu-opp.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-a100-cpu-opp.dtsi
new file mode 100644
index 00000000000..c6a2efa037d
--- /dev/null
+++ b/dts/upstream/src/arm64/allwinner/sun50i-a100-cpu-opp.dtsi
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
+// Copyright (c) 2020 ShuoSheng Huang <huangshuosheng@allwinnertech.com>
+
+/ {
+	cpu_opp_table: opp-table-cpu {
+		compatible = "allwinner,sun50i-a100-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		opp-shared;
+
+		opp-408000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <408000000>;
+
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+		};
+
+		opp-600000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <600000000>;
+
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+		};
+
+		opp-816000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <816000000>;
+
+			opp-microvolt-speed0 = <940000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+		};
+
+		opp-1080000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1080000000>;
+
+			opp-microvolt-speed0 = <1020000>;
+			opp-microvolt-speed1 = <980000>;
+			opp-microvolt-speed2 = <950000>;
+		};
+
+		opp-1200000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1200000000>;
+
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed1 = <1020000>;
+			opp-microvolt-speed2 = <1000000>;
+		};
+
+		opp-1320000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1320000000>;
+
+			opp-microvolt-speed0 = <1160000>;
+			opp-microvolt-speed1 = <1060000>;
+			opp-microvolt-speed2 = <1030000>;
+		};
+
+		opp-1464000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1464000000>;
+
+			opp-microvolt-speed0 = <1180000>;
+			opp-microvolt-speed1 = <1180000>;
+			opp-microvolt-speed2 = <1130000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
diff --git a/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi
index a24adba201a..f9f6fea03b7 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi
+++ b/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi
@@ -23,6 +23,7 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu1: cpu@1 {
@@ -30,6 +31,7 @@
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu2: cpu@2 {
@@ -37,6 +39,7 @@
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu3: cpu@3 {
@@ -44,6 +47,7 @@
 			device_type = "cpu";
 			reg = <0x3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 	};
 
@@ -175,6 +179,10 @@
 			ths_calibration: calib@14 {
 				reg = <0x14 8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@1c {
+				reg = <0x1c 0x2>;
+			};
 		};
 
 		watchdog@30090a0 {
-- 
2.46.3

