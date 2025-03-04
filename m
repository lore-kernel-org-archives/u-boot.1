Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F767C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A4381545;
	Tue,  4 Mar 2025 12:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="et1AdoiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028F4817C4; Tue,  4 Mar 2025 12:01:59 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF890814BD
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249jp34019644;
 Tue, 4 Mar 2025 11:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Rgx23+vuJH94yZ4Cv4uKjmjwNqr56MZmwTlcPAMoD8=; b=et1AdoiUBesL2DkF
 l8oND9Y41C9AqO6ASj7cOP8TmyIr9LJPcOqmKnOfU2gJZyuQih+BUmbt3YCnzM8r
 4MkpCWAKXEEzwFw9VQx7dXoryfDXXuYzTXscFTaTB/ELpFX7FQV0gY0OwERu2nDT
 NWvjEYv8kAKVpbvN9ufCTxbsrx84+Z3Ai8LKW5FoSwCcN1Ha4lFHM5PRd22qAAXf
 7EDpHY9U7a2W+S3QkXSxRjh7JFD9LhMTTo1EfTnWvVOnY4iC7P34HQrfEwgs0LFi
 q6m5LcOqZG19pkoPvesQELeEZuqrxhQBkZ7OC101sjl9i5qCKv4r2O+fkC7wF2Lk
 PQwEnQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t1m92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:01:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524B1RCC007875
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 4 Mar 2025 11:01:27 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:01:21 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>, <sjg@chromium.org>,
 <robert.marko@sartura.hr>, <dmitry.baryshkov@linaro.org>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 1/6] arm64: dts: qcom: ipq5424: Add USB controller and phy
 nodes
Date: Tue, 4 Mar 2025 16:31:00 +0530
Message-ID: <20250304110105.2762124-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304110105.2762124-1-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: i075D_V08veU6gicIgJIX7YDB0mNBrEB
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c6dd87 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=KFO15AfCROCJetwNLh0A:9
 a=RVmHIydaz68A:10 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: i075D_V08veU6gicIgJIX7YDB0mNBrEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040093
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

The IPQ5424 SoC has both USB2.0 and USB3.0 controllers. The USB3.0
can connect to either of USB2.0 or USB3.0 phy and operate in the
respective mode.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241118052839.382431-7-quic_varada@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: 113d52bdc820da14dc0694bb5c57b3cda7ceea30 ]

(cherry picked from commit 7009a69e9e1f4d76e2ae247c1a2a40515ed6831b)
---
 .../src/arm64/qcom/ipq5424-rdp466.dts         | 169 ++++++
 dts/upstream/src/arm64/qcom/ipq5424.dtsi      | 507 ++++++++++++++++++
 2 files changed, 676 insertions(+)
 create mode 100644 dts/upstream/src/arm64/qcom/ipq5424-rdp466.dts
 create mode 100644 dts/upstream/src/arm64/qcom/ipq5424.dtsi

diff --git a/dts/upstream/src/arm64/qcom/ipq5424-rdp466.dts b/dts/upstream/src/arm64/qcom/ipq5424-rdp466.dts
new file mode 100644
index 0000000000..b6e4bb3328
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/ipq5424-rdp466.dts
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * IPQ5424 RDP466 board device tree source
+ *
+ * Copyright (c) 2024 The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq5424.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ5424 RDP466";
+	compatible = "qcom,ipq5424-rdp466", "qcom,ipq5424";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	vreg_misc_3p3: regulator-usb-3p3 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-name = "usb_hs_vdda_3p3";
+	};
+
+	vreg_misc_1p8: regulator-usb-1p8 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-name = "vdda_1p8_usb";
+	};
+
+	vreg_misc_0p925: regulator-usb-0p925 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <925000>;
+		regulator-max-microvolt = <925000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-name = "vdd_core_usb";
+	};
+};
+
+&dwc_0 {
+	dr_mode = "host";
+};
+
+&dwc_1 {
+	dr_mode = "host";
+};
+
+&qusb_phy_0 {
+	vdd-supply = <&vreg_misc_0p925>;
+	vdda-pll-supply = <&vreg_misc_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_misc_3p3>;
+
+	status = "okay";
+};
+
+&qusb_phy_1 {
+	vdd-supply = <&vreg_misc_0p925>;
+	vdda-pll-supply = <&vreg_misc_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_misc_3p3>;
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&spi0 {
+	pinctrl-0 = <&spi0_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&ssphy_0 {
+	vdda-pll-supply = <&vreg_misc_1p8>;
+	vdda-phy-supply = <&vreg_misc_0p925>;
+
+	status = "okay";
+};
+
+&tlmm {
+	spi0_default_state: spi0-default-state {
+		clk-pins {
+			pins = "gpio6";
+			function = "spi0_clk";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+
+		cs-pins {
+			pins = "gpio7";
+			function = "spi0_cs";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		miso-pins {
+			pins = "gpio8";
+			function = "spi0_miso";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+
+		mosi-pins {
+			pins = "gpio9";
+			function = "spi0_mosi";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+	};
+
+	sdc_default_state: sdc-default-state {
+		clk-pins {
+			pins = "gpio5";
+			function = "sdc_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "gpio4";
+			function = "sdc_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			function = "sdc_data";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <24000000>;
+};
+
diff --git a/dts/upstream/src/arm64/qcom/ipq5424.dtsi b/dts/upstream/src/arm64/qcom/ipq5424.dtsi
new file mode 100644
index 0000000000..3ab2ffa10f
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/ipq5424.dtsi
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ5424 device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,ipq5424-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5424-gcc.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&intc>;
+
+	clocks {
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		xo_board: xo-board-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+
+				l3_0: l3-cache {
+					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
+				};
+			};
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			enable-method = "psci";
+			reg = <0x100>;
+			next-level-cache = <&l2_100>;
+
+			l2_100: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			enable-method = "psci";
+			reg = <0x200>;
+			next-level-cache = <&l2_200>;
+
+			l2_200: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			enable-method = "psci";
+			reg = <0x300>;
+			next-level-cache = <&l2_300>;
+
+			l2_300: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-dsu {
+		compatible = "arm,dsu-pmu";
+		interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		tz@8a600000 {
+			reg = <0x0 0x8a600000 0x0 0x200000>;
+			no-map;
+		};
+
+		smem@8a800000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x8a800000 0x0 0x32000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 3>;
+		};
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+
+		rng: rng@4c3000 {
+			compatible = "qcom,ipq5424-trng", "qcom,trng";
+			reg = <0 0x004c3000 0 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		system-cache-controller@800000 {
+			compatible = "qcom,ipq5424-llcc";
+			reg = <0 0x00800000 0 0x200000>;
+			reg-names = "llcc0_base";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,ipq5424-tlmm";
+			reg = <0 0x01000000 0 0x300000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 50>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			uart1_pins: uart1-state {
+				pins = "gpio43", "gpio44";
+				function = "uart1";
+				drive-strength = <8>;
+				bias-pull-up;
+			};
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,ipq5424-gcc";
+			reg = <0 0x01800000 0 0x40000>;
+			clocks = <&xo_board>,
+				 <&sleep_clk>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0 0x01905000 0 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		qupv3: geniqup@1ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0 0x01ac0000 0 0x2000>;
+			ranges;
+			clocks = <&gcc GCC_QUPV3_AHB_MST_CLK>,
+				 <&gcc GCC_QUPV3_AHB_SLV_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			uart1: serial@1a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0 0x01a84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_UART1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			spi0: spi@1a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x01a90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_SPI0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi1: spi@1a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x01a94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_SPI1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		sdhc: mmc@7804000 {
+			compatible = "qcom,ipq5424-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x07804000 0 0x1000>, <0 0x07805000 0 0x1000>;
+			reg-names = "hc", "cqhci";
+
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
+
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@f200000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0xf200000 0 0x10000>, /* GICD */
+			      <0 0xf240000 0 0x80000>; /* GICR * 4 regions */
+			#interrupt-cells = <0x3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			mbi-ranges = <672 128>;
+			msi-controller;
+		};
+
+		watchdog@f410000 {
+			compatible = "qcom,apss-wdt-ipq5424", "qcom,kpss-wdt";
+			reg = <0 0x0f410000 0 0x1000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sleep_clk>;
+		};
+
+		qusb_phy_1: phy@71000 {
+			compatible = "qcom,ipq5424-qusb2-phy";
+			reg = <0 0x00071000 0 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
+				<&xo_board>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2_1_PHY_BCR>;
+			status = "disabled";
+		};
+
+		usb2: usb2@1e00000 {
+			compatible = "qcom,ipq5424-dwc3", "qcom,dwc3";
+			reg = <0 0x01ef8800 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB1_MASTER_CLK>,
+				 <&gcc GCC_USB1_SLEEP_CLK>,
+				 <&gcc GCC_USB1_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_CNOC_USB_CLK>;
+
+			clock-names = "core",
+				      "sleep",
+				      "mock_utmi",
+				      "iface",
+				      "cfg_noc";
+
+			assigned-clocks = <&gcc GCC_USB1_MASTER_CLK>,
+					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <200000000>,
+					       <24000000>;
+
+			interrupts-extended = <&intc GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
+
+			resets = <&gcc GCC_USB1_BCR>;
+			qcom,select-utmi-as-pipe-clk;
+			status = "disabled";
+
+			dwc_1: usb@1e00000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x01e00000 0 0xe000>;
+				clocks = <&gcc GCC_USB1_MOCK_UTMI_CLK>;
+				clock-names = "ref";
+				interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_1>;
+				phy-names = "usb2-phy";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+			};
+		};
+
+		qusb_phy_0: phy@7b000 {
+			compatible = "qcom,ipq5424-qusb2-phy";
+			reg = <0 0x0007b000 0 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+				<&xo_board>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+			status = "disabled";
+		};
+
+		ssphy_0: phy@7d000 {
+			compatible = "qcom,ipq5424-qmp-usb3-phy";
+			reg = <0 0x0007d000 0 0xa00>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB0_AUX_CLK>,
+				 <&xo_board>,
+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB0_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+
+			resets = <&gcc GCC_USB0_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "usb0_pipe_clk";
+
+			status = "disabled";
+		};
+
+		usb3: usb3@8a00000 {
+			compatible = "qcom,ipq5424-dwc3", "qcom,dwc3";
+			reg = <0 0x08af8800 0 0x400>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB0_MASTER_CLK>,
+				 <&gcc GCC_USB0_SLEEP_CLK>,
+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_CNOC_USB_CLK>;
+
+			clock-names = "core",
+				      "sleep",
+				      "mock_utmi",
+				      "iface",
+				      "cfg_noc";
+
+			assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <200000000>,
+					       <24000000>;
+
+			interrupts-extended = <&intc GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
+
+			resets = <&gcc GCC_USB_BCR>;
+			status = "disabled";
+
+			dwc_0: usb@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x08a00000 0 0xcd00>;
+				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+				clock-names = "ref";
+				interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_0>, <&ssphy_0>;
+				phy-names = "usb2-phy", "usb3-phy";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				snps,dis-u1-entry-quirk;
+				snps,dis-u2-entry-quirk;
+			};
+		};
+
+		timer@f420000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0 0xf420000 0 0x1000>;
+			ranges = <0 0 0 0x10000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			frame@f421000 {
+				reg = <0xf421000 0x1000>,
+				      <0xf422000 0x1000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <0>;
+			};
+
+			frame@f423000 {
+				reg = <0xf423000 0x1000>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <1>;
+				status = "disabled";
+			};
+
+			frame@f425000 {
+				reg = <0xf425000 0x1000>,
+				      <0xf426000 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <2>;
+				status = "disabled";
+			};
+
+			frame@f427000 {
+				reg = <0xf427000 0x1000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <3>;
+				status = "disabled";
+			};
+
+			frame@f429000 {
+				reg = <0xf429000 0x1000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <4>;
+				status = "disabled";
+			};
+
+			frame@f42b000 {
+				reg = <0xf42b000 0x1000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <5>;
+				status = "disabled";
+			};
+
+			frame@f42d000 {
+				reg = <0xf42d000 0x1000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <6>;
+				status = "disabled";
+			};
+		};
+
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
-- 
2.34.1

