Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F6C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9328387EDD;
	Mon, 26 Feb 2024 13:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="irVFnUUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A09387E95; Mon, 26 Feb 2024 11:10:00 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C37B87D6F
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q8SLcF030158; Mon, 26 Feb 2024 10:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=T7T3I0MvqSKyFCZNjE5b52RFgQuCX3AGwr3jBCj7kAk=; b=ir
 VFnUUaAUmmpOEuRTrTejx3InBV4ibVhsVmLr/UiH5rVqzJ3Yegt32Jffb3aUxpTT
 6GJRaU6d5WMhxzmI8nMK8v/nxHxfl51WSQMMcToYz0ibqOyxEys/oXfEjVotqoTA
 j/rTt8UZJX0zQX/SikG6mdDywvHt3h6huXOx5cEo/734332zrXDWYYc0JrhuJpRf
 7GhmPXa/+Vst5fodyI8Ln024/GO6i0xrRDL+7zb7QKom+HN6hDBctJ9Ov0PhaDnc
 eqPybhhrc8XaWbDVnRQBELSMoPcOLQwe2/bLqPHGZtoVfhtkd1gdNrEvW2wWRIK1
 vVmVnlC0RkK79GmHLekg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxkrjud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA91pE007577
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:01 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:08:53 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, "Mathieu
 Othacehe" <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Sean Anderson <seanga2@gmail.com>, "Simon
 Glass" <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 01/10] mach-snapdragon: Add support for IPQ9574
Date: Mon, 26 Feb 2024 15:37:58 +0530
Message-ID: <20240226100807.1095607-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226100807.1095607-1-quic_varada@quicinc.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: RTM0N8h9MbddqveYy0Y_9iW4v-SABfud
X-Proofpoint-GUID: RTM0N8h9MbddqveYy0Y_9iW4v-SABfud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260076
X-Mailman-Approved-At: Mon, 26 Feb 2024 13:01:24 +0100
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

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/ipq9574-default.dts              |  167 +++
 arch/arm/dts/ipq9574-rdp433-mht-phy.dts       |  208 +++
 arch/arm/dts/ipq9574.dtsi                     |  771 ++++++++++
 .../include/mach/sysmap-ipq9574.h             |  252 ++++
 arch/arm/mach-snapdragon/init_ipq9574.c       |   81 +
 board/qualcomm/ipq9574/Kconfig                |   15 +
 board/qualcomm/ipq9574/Makefile               |    4 +
 board/qualcomm/ipq9574/board_init.c           |  326 ++++
 board/qualcomm/ipq9574/ipq9574.c              |  170 +++
 board/qualcomm/ipq9574/ipq9574.h              |   75 +
 board/qualcomm/ipq9574/u-boot-x32.lds         |  250 ++++
 board/qualcomm/ipq9574/u-boot-x64.lds         |  188 +++
 drivers/clk/qcom/clock-ipq9574.c              | 1320 +++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-ipq9574.c        |   77 +
 include/configs/ipq9574.h                     |  111 ++
 include/dt-bindings/clock/gcc-ipq9574.h       |  156 ++
 include/dt-bindings/net/qti-ipqsoc.h          |   20 +
 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h  |   19 +
 include/dt-bindings/reset/ipq9574-reset.h     |   54 +
 20 files changed, 4266 insertions(+)
 create mode 100644 arch/arm/dts/ipq9574-default.dts
 create mode 100644 arch/arm/dts/ipq9574-rdp433-mht-phy.dts
 create mode 100644 arch/arm/dts/ipq9574.dtsi
 create mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
 create mode 100644 arch/arm/mach-snapdragon/init_ipq9574.c
 create mode 100644 board/qualcomm/ipq9574/Kconfig
 create mode 100644 board/qualcomm/ipq9574/Makefile
 create mode 100644 board/qualcomm/ipq9574/board_init.c
 create mode 100644 board/qualcomm/ipq9574/ipq9574.c
 create mode 100644 board/qualcomm/ipq9574/ipq9574.h
 create mode 100644 board/qualcomm/ipq9574/u-boot-x32.lds
 create mode 100644 board/qualcomm/ipq9574/u-boot-x64.lds
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 include/configs/ipq9574.h
 create mode 100644 include/dt-bindings/clock/gcc-ipq9574.h
 create mode 100644 include/dt-bindings/net/qti-ipqsoc.h
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
 create mode 100644 include/dt-bindings/reset/ipq9574-reset.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d9725030d5..8931dfa2aa 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1523,6 +1523,8 @@ dtb-$(CONFIG_ARCH_QEMU) += qemu-arm.dtb qemu-arm64.dtb
 dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
 				corstone1000-fvp.dtb
 
+dtb-$(CONFIG_TARGET_IPQ9574) += ipq9574-rdp433-mht-phy.dtb
+
 include $(srctree)/scripts/Makefile.dts
 
 targets += $(dtb-y)
diff --git a/arch/arm/dts/ipq9574-default.dts b/arch/arm/dts/ipq9574-default.dts
new file mode 100644
index 0000000000..501c9492df
--- /dev/null
+++ b/arch/arm/dts/ipq9574-default.dts
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574.dtsi"
+
+/ {
+	config_name = "config-default";
+
+	aliases {
+		console = &blsp1_uart2_console;
+		uart2 = &blsp1_uart3_additional;
+		sdhci = &mmc;
+	};
+
+	soc: soc {
+		tlmm: pinctrl@1000000 {
+
+			sdhci_pinmux: mmc {
+				pinconfig;
+				emmc_data {
+					pins = "GPIO_0", "GPIO_1", "GPIO_2",
+						"GPIO_3", "GPIO_6", "GPIO_7",
+						"GPIO_8", "GPIO_9";
+					function = "sdc";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+
+				emmc_cmd{
+					pins = "GPIO_4";
+					function = "sdc";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+
+				emmc_clk{
+					pins = "GPIO_5";
+					function = "sdc";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				emmc_rclk{
+					pins = "GPIO_10";
+					function = "sdc";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-down;
+				};
+			};
+
+			qspi_pinmux: nand {
+				qspi_data {
+					pins = "GPIO_0", "GPIO_1", "GPIO_2",
+						"GPIO_3";
+					function = "qspi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				qspi_cs_n {
+					pins = "GPIO_4";
+					function = "qspi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				qspi_clk {
+					pins = "GPIO_5";
+					function = "qspi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+			};
+
+			serial_pinmux: uart {
+				data {
+					pins = "GPIO_34", "GPIO_35";
+					function = "blsp0_uart0";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+
+			serial_pinmux2: uart2 {
+				data {
+					pins = "GPIO_17", "GPIO_18";
+					function = "blsp1_uart2";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+			};
+
+			blsp1_spi_pinmux: blsp1_spi_pins {
+				blsp0_spi_clk {
+					pins = "GPIO_11";
+					function = "blsp0_spi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				blsp0_spi_mosi {
+					pins = "GPIO_14";
+					function = "blsp0_spi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				blsp0_spi_miso {
+					pins = "GPIO_13";
+					function = "blsp0_spi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				blsp0_spi_cs {
+					pins = "GPIO_12";
+					function = "blsp0_spi";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+
+			};
+		};
+
+		blsp1_uart2_console: serial@78B1000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&serial_pinmux>;
+			status = "okay";
+		};
+
+		blsp1_uart3_additional: serial@78B2000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&serial_pinmux2>;
+			status = "okay";
+		};
+
+		blsp1_spi: spi@78b5000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi_pinmux>;
+			cs-gpios = <&tlmm 12 0>;
+			force-cs;
+			status = "okay";
+
+			mx25u25635f@0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+			};
+		};
+
+		nand: nand-controller@79B0000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&qspi_pinmux>;
+			//status = "okay";
+			status = "disabled";
+		};
+
+		mmc: sdhci@7800000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhci_pinmux>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/dts/ipq9574-rdp433-mht-phy.dts b/arch/arm/dts/ipq9574-rdp433-mht-phy.dts
new file mode 100644
index 0000000000..085b169e57
--- /dev/null
+++ b/arch/arm/dts/ipq9574-rdp433-mht-phy.dts
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-default.dts"
+
+/ {
+	config_name = "config@al02-c7", "config@rdp433-mht-phy", "config-rdp433-mht-phy";
+
+	soc: soc {
+		tlmm: pinctrl@1000000 {
+
+			mdio_pinmux: mdio {
+				mdc {
+					pins = "GPIO_38";
+					function = "mdc";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-disable;
+				};
+
+				mdio {
+					pins = "GPIO_39";
+					function = "mdio";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+
+			phy_rst_pinmux: phy_rst {
+				qti_8x8x_rst {
+					pins = "GPIO_60";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+
+				qti_aquantia_rst {
+					pins = "GPIO_36";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+
+			blsp3_i2c_pinmux: blsp3_i2c_pins {
+				blsp3_scl {
+					pins = "GPIO_15";
+					function = "blsp3_i2c_scl";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+
+				blsp3_sda {
+					pins = "GPIO_16";
+					function = "blsp3_i2c_sda";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+
+			pcie1_x1_pinmux: pci_pins {
+				pci_rst {
+					pins = "GPIO_26";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+
+			pcie2_x2_pinmux: pci_pins {
+				pci_rst {
+					pins = "GPIO_29";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+
+			pcie3_x2_pinmux: pci_pins {
+				pci_rst {
+					pins = "GPIO_32";
+					drive-strength = <DRIVE_STRENGTH_8MA>;
+					bias-pull-up;
+				};
+			};
+		};
+
+		blsp3_i2c: i2c@78B8000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp3_i2c_pinmux>;
+			status = "okay";
+		};
+
+		qmp_ssphy_0: ssphy@7D000 {
+			status = "okay";
+		};
+
+		qusb2_phy_0: qusb2@7B000 {
+			status = "okay";
+		};
+
+		usb0: usb@8af8800 {
+			status = "okay";
+
+			dwc3@8a00000 {
+				phys = <&qusb2_phy_0>, <&qmp_ssphy_0>;
+				phy-names = "usb2-phy", "usb3-phy";
+				maximum-speed = "super-speed";
+			};
+		};
+
+		mdio: mdio@90000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mdio_pinmux>;
+			status = "okay";
+
+			phy0: phy@1 {
+				phy-reset-gpio = <&tlmm 60 0>;
+				reg = <1>;
+				phy_id = <QCA8x8x_PHY_TYPE>;
+				id = <1>;
+				uniphy_id = <0>;
+				uniphy_type = <0>;
+				xgmac;
+			};
+
+			phy1: phy@2 {
+				reg = <2>;
+				phy_id = <QCA8x8x_PHY_TYPE>;
+				id = <2>;
+				uniphy_id = <0>;
+				uniphy_type = <0>;
+				xgmac;
+			};
+
+			phy2: phy@3 {
+				reg = <3>;
+				phy_id = <QCA8x8x_PHY_TYPE>;
+				id = <3>;
+				uniphy_id = <0>;
+				uniphy_type = <0>;
+				xgmac;
+			};
+
+			phy3: phy@4 {
+				reg = <4>;
+				phy_id = <QCA8x8x_PHY_TYPE>;
+				id = <4>;
+				uniphy_id = <0>;
+				uniphy_type = <0>;
+				xgmac;
+			};
+
+			phy4: phy@8 {
+				phy-reset-gpio = <&tlmm 36 0>;
+				reg = <8>;
+				phy_id = <AQ_PHY_TYPE>;
+				phy-mode = "usxgmii";
+				id = <5>;
+				uniphy_id = <1>;
+				uniphy_type = <1>;
+				xgmac;
+			};
+
+			phy5: phy@0 {
+				reg = <0>;
+				phy_id = <AQ_PHY_TYPE>;
+				phy-mode = "usxgmii";
+				id = <6>;
+				uniphy_id = <2>;
+				uniphy_type = <0>;
+				xgmac;
+			};
+		};
+
+		ethernet: nss-switch {
+			pinctrl-names = "default";
+			pinctrl-0 = <&phy_rst_pinmux>;
+			phy-handle0 = <&phy0>;
+			phy-handle1 = <&phy1>;
+			phy-handle2 = <&phy2>;
+			phy-handle3 = <&phy3>;
+			phy-handle4 = <&phy4>;
+			phy-handle5 = <&phy5>;
+			status = "okay";
+		};
+
+		pcie1_x1: pci@10000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie1_x1_pinmux>;
+			status = "okay";
+			perst_gpio = <&tlmm 26 0>;
+		};
+
+		pcie2_x2: pci@20000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie2_x2_pinmux>;
+			status = "okay";
+			perst_gpio = <&tlmm 29 0>;
+		};
+
+		pcie3_x2: pci@18000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie3_x2_pinmux>;
+			status = "okay";
+			perst_gpio = <&tlmm 32 0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/ipq9574.dtsi b/arch/arm/dts/ipq9574.dtsi
new file mode 100644
index 0000000000..d2d59bcc9c
--- /dev/null
+++ b/arch/arm/dts/ipq9574.dtsi
@@ -0,0 +1,771 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "skeleton64.dtsi"
+#include <dt-bindings/pinctrl/pinctrl-ipqsoc.h>
+#include <dt-bindings/clock/gcc-ipq9574.h>
+#include <dt-bindings/reset/ipq9574-reset.h>
+#include <dt-bindings/net/qti-ipqsoc.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+
+	model = "Qualcomm Technologies, Inc. IPQ9574";
+	compatible = "qti,ipq9574";
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		tz_mem: tz@4A600000 {
+			reg = <0x4A600000 0x400000>;
+			no-map;
+		};
+
+		smem_mem: smem_region@4AA00000 {
+			reg = <0x4AA00000 0x100000>;
+			no-map;
+		};
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		bootph-all;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qti,ipq9574-pinctrl";
+			reg = <0x1000000 0x300000>;
+			gpio-controller;
+			gpio-count = <64>;
+			gpio-bank-name="soc";
+			#gpio-cells = <2>;
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qti,gcc-ipq9574";
+			reg = <0x1800000 0x80000>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		nss: clock-controller@39B00000 {
+			compatible = "qti,gcc-ipq5332";
+			reg = <0x39B00000 0x80000>;
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			#clock-cells = <1>;
+		};
+
+		reset: gcc-reset@1800000 {
+			compatible = "qti,gcc-reset-ipq9574";
+			reg = <0x1800000 0x80000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		nss_reset: nss-reset@39B00000 {
+			compatible = "qti,gcc-reset-ipqsoc";
+			reg = <0x39B00000 0x80000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		blsp_dma: dma@7884000 {
+			compatible = "qti,bam-v1.7.0";
+			reg = <0x07884000 0x1d000>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			#dma-cells = <6>;
+			status = "okay";
+		};
+
+		blsp1_uart2_console: serial@78B1000 {
+			compatible = "qcom,msm-uartdm-v1.4";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x78B1000 0x200>;
+			clock = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			bit-rate = <0xFF>;
+			status = "okay";
+		};
+
+		blsp1_uart3_additional: serial@78B2000 {
+			compatible = "qcom,msm-uartdm-v1.4";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x78B2000 0x200>;
+			clock = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			bit-rate = <0xFF>;
+			status = "okay";
+		};
+
+		blsp1_spi: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b5000 0x600>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>;
+			dma-names = "tx", "rx";
+			dmas = <&blsp_dma 12 1 16 0 0xFFFF 16>,
+			     <&blsp_dma 13 2 16 0 0xFFFF 16>;
+			status = "disabled";
+		};
+
+		blsp0_i2c: i2c@78B5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078B5000 0x600>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP0_I2C_APPS_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency  = <400000>;
+			assigned-clocks = <&gcc GCC_BLSP1_QUP0_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c: i2c@78B6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078B6000 0x600>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency  = <400000>;
+			assigned-clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c: i2c@78B7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078B7000 0x600>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency  = <400000>;
+			assigned-clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp3_i2c: i2c@78B8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078B8000 0x600>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency  = <400000>;
+			assigned-clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp4_i2c: i2c@78B9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078B9000 0x600>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency  = <400000>;
+			assigned-clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp5_i2c: i2c@78BA000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078BA000 0x600>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency  = <400000>;
+			assigned-clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		nand: nand-controller@79B0000 {
+			compatible = "qti,spi-nand-v2.1.1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x79B0000 0x10000>;
+			assigned-clocks = <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			assigned-clock-rates = <200000000>;
+			clock-names = "qpic-io-macro-clk";
+			clocks = <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			bam_reg = <0x07984000>;
+			status_pipe = <3>;
+			status_pipe_grp = <0>;
+			read_pipe = <1>;
+			read_pipe_grp = <0>;
+			write_pipe = <0>;
+			write_pipe_grp = <0>;
+			cmd_pipe = <2>;
+			cmd_pipe_grp = <1>;
+			serial_training;
+			status = "okay";
+		};
+
+		mmc: sdhci@7800000 {
+			compatible = "qti,sdhci-msm-v5";
+			reg = <0x7804000 0x1000 0x7805000 0x1000>;
+			reg-names = "hc_mem", "cmdq_mem";
+			resets = <&gcc GCC_SDCC1_BCR>;
+			reset-names = "bcr_rst";
+			clock = <&gcc GCC_SDCC1_APPS_CLK>,
+				<&gcc GCC_SDCC1_AHB_CLK>;
+			clock-frequency = <200000000>;
+			max-frequency = <200000000>;
+			sdhci-caps-mask = <0x0 0x04000000>;
+			sdhci-caps = <0x0 0x04000000>;
+			bus-width = <0x8>;
+			index = <0x0>;
+			non-removable;
+			mmc-ddr-1_8v;
+			bus_pwr_off_rst;
+			status = "okay";
+		};
+
+		qmp_ssphy_0: ssphy@7D000 {
+			compatible = "qti,ipq9574-qmp-usb3-phy";
+			reg = <0x7D000 0x1C4>, <0x7D200 0x130>,
+			    <0x7D400 0x200>, <0x7D800 0x1F8>;
+			reg-names = "com_base", "tx_base",
+				"rx_base", "pcs_base";
+			clocks = <&gcc GCC_USB0_PIPE_CLK>;
+			#phy-cells = <0>;
+			resets =  <&reset GCC_USB0_PHY_BCR>,
+			       <&reset GCC_USB3PHY_0_PHY_BCR>;
+			status = "disabled";
+		};
+
+		qusb2_phy_0: qusb2@7B000 {
+			compatible = "qti,ipq9574-qusb2-phy";
+			reg = <0x07B000 0x180>;
+			#phy-cells = <0>;
+			resets = <&reset GCC_QUSB2_0_PHY_BCR>;
+			status = "disabled";
+		};
+
+		usb0: usb@8af8800 {
+			compatible = "qti,dwc3-ipq";
+			reg = <0x8af8800 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
+				<&gcc GCC_USB0_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB0_AUX_CLK>;
+			assigned-clock-rates = <200000000>,
+				<24000000>,
+				<24000000>;
+			clocks = <&gcc GCC_USB0_MASTER_CLK>,
+				<&gcc GCC_ANOC_USB_AXI_CLK>,
+				<&gcc GCC_SNOC_USB_CLK>,
+				<&gcc GCC_USB0_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB0_SLEEP_CLK>,
+				<&gcc GCC_USB0_AUX_CLK>,
+				<&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+			resets = <&reset GCC_USB_BCR>;
+			ranges;
+			qti,quirk-ref-clk-per = <0x0a40c010>;
+			qti,quirk-ref-clk-adj = <0x0a87f0a0>;
+			status = "disabled";
+
+			dwc3@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x8a00000 0xf8000>;
+				dr_mode = "host";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+			};
+		};
+
+		mdio: mdio@90000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "qcom,ipq4019-mdio";
+			reg = <0x90000 0x64>;
+			status = "disabled";
+		};
+
+		eth_switch: nss-switch {
+			compatible = "qti,ipq-nss-switch";
+			reg = <0x3ab00000 0xEF800 0x3A000000 0x1000000
+				0x7A00000 0x10000>;
+			reg-names = "edma_hw", "ppe_base", "uniphy_base";
+			assigned-clocks = <&gcc GCC_NSSNOC_MEMNOC_BFDCD_CLK>,
+					<&gcc GCC_QDSS_AT_CLK>,
+					<&nss NSS_CC_CFG_CLK>,
+					<&nss NSS_CC_PPE_CLK>,
+					<&gcc GCC_UNIPHY_SYS_CLK>,
+					<&gcc GCC_PCNOC_BFDCD_CLK>,
+					<&gcc GCC_SYSTEM_NOC_BFDCD_CLK>;
+			assigned-clock-rates = <533000000>, <239000000>,
+						<100000000>,<353000000>,
+						<24000000>, <100000000>,
+						<343000000>;
+			clocks = <&gcc GCC_MEM_NOC_NSSNOC_CLK>,
+				<&gcc GCC_NSSCFG_CLK>,
+				<&gcc GCC_NSSNOC_ATB_CLK>,
+				<&gcc GCC_NSSNOC_MEM_NOC_1_CLK>,
+				<&gcc GCC_NSSNOC_MEMNOC_CLK>,
+				<&gcc GCC_NSSNOC_QOSGEN_REF_CLK>,
+				<&gcc GCC_NSSNOC_TIMEOUT_REF_CLK>,
+				<&nss GCC_CMN_12GPLL_AHB_CLK>,
+				<&nss GCC_CMN_12GPLL_SYS_CLK>,
+				<&gcc GCC_UNIPHY0_SYS_CLK>,
+				<&gcc GCC_UNIPHY0_AHB_CLK>,
+				<&gcc GCC_UNIPHY1_SYS_CLK>,
+				<&gcc GCC_UNIPHY1_AHB_CLK>,
+				<&gcc GCC_UNIPHY2_SYS_CLK>,
+				<&gcc GCC_UNIPHY2_AHB_CLK>,
+				<&gcc GCC_MDIO_AHB_CLK>,
+				<&gcc GCC_NSSNOC_SNOC_CLK>,
+				<&gcc GCC_NSSNOC_SNOC_1_CLK>,
+				<&gcc GCC_MEM_NOC_SNOC_AXI_CLK>,
+				<&nss NSS_CC_NSS_CSR_CLK>,
+				<&nss NSS_CC_NSSNOC_NSS_CSR_CLK>,
+				<&nss NSS_CC_PORT1_MAC_CLK>,
+				<&nss NSS_CC_PORT2_MAC_CLK>,
+				<&nss NSS_CC_PORT3_MAC_CLK>,
+				<&nss NSS_CC_PORT4_MAC_CLK>,
+				<&nss NSS_CC_PORT5_MAC_CLK>,
+				<&nss NSS_CC_PORT6_MAC_CLK>,
+				<&nss NSS_CC_PPE_SWITCH_IPE_CLK>,
+				<&nss NSS_CC_PPE_SWITCH_CLK>,
+				<&nss NSS_CC_PPE_SWITCH_CFG_CLK>,
+				<&nss NSS_CC_PPE_EDMA_CLK>,
+				<&nss NSS_CC_PPE_EDMA_CFG_CLK>,
+				<&nss NSS_CC_CRYPTO_PPE_CLK>,
+				<&nss NSS_CC_NSSNOC_PPE_CLK>,
+				<&nss NSS_CC_NSSNOC_PPE_CFG_CLK>,
+				<&nss NSS_CC_PPE_SWITCH_BTQ_CLK>,
+				<&nss NSS_CC_PORT1_RX_CLK>,
+				<&nss NSS_CC_PORT1_TX_CLK>,
+				<&nss NSS_CC_PORT2_RX_CLK>,
+				<&nss NSS_CC_PORT2_TX_CLK>,
+				<&nss NSS_CC_PORT3_RX_CLK>,
+				<&nss NSS_CC_PORT3_TX_CLK>,
+				<&nss NSS_CC_PORT4_RX_CLK>,
+				<&nss NSS_CC_PORT4_TX_CLK>,
+				<&nss NSS_CC_PORT5_RX_CLK>,
+				<&nss NSS_CC_PORT5_TX_CLK>,
+				<&nss NSS_CC_PORT6_RX_CLK>,
+				<&nss NSS_CC_PORT6_TX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT1_RX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT1_TX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT2_RX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT2_TX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT3_RX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT3_TX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT4_RX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT4_TX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT5_RX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT5_TX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT6_RX_CLK>,
+				<&nss NSS_CC_UNIPHY_PORT6_TX_CLK>,
+				<&nss UNIPHY0_NSS_RX_CLK>,
+				<&nss UNIPHY0_NSS_TX_CLK>,
+				<&nss UNIPHY1_NSS_RX_CLK>,
+				<&nss UNIPHY1_NSS_TX_CLK>,
+				<&nss UNIPHY2_NSS_RX_CLK>,
+				<&nss UNIPHY2_NSS_TX_CLK>;
+
+			clock-names = "gcc_mem_noc_nssnoc_clk",
+				"gcc_nsscfg_clk",
+				"gcc_nssnoc_atb_clk",
+				"gcc_nssnoc_mem_noc_1_clk",
+				"gcc_nssnoc_memnoc_clk",
+				"gcc_nssnoc_qosgen_ref_clk",
+				"gcc_nssnoc_timeout_ref_clk",
+				"gcc_cmn_12gpll_ahb_clk",
+				"gcc_cmn_12gpll_sys_clk",
+				"gcc_uniphy0_sys_clk",
+				"gcc_uniphy0_ahb_clk",
+				"gcc_uniphy1_sys_clk",
+				"gcc_uniphy1_ahb_clk",
+				"gcc_uniphy2_sys_clk",
+				"gcc_uniphy2_ahb_clk",
+				"gcc_mdio_ahb_clk",
+				"gcc_nssnoc_snoc_clk",
+				"gcc_nssnoc_snoc_1_clk",
+				"gcc_mem_noc_snoc_axi_clk",
+				"nss_cc_nss_csr_clk",
+				"nss_cc_nssnoc_nss_csr_clk",
+				"nss_cc_port1_mac_clk",
+				"nss_cc_port2_mac_clk",
+				"nss_cc_port3_mac_clk",
+				"nss_cc_port4_mac_clk",
+				"nss_cc_port5_mac_clk",
+				"nss_cc_port6_mac_clk",
+				"nss_cc_ppe_switch_ipe_clk",
+				"nss_cc_ppe_switch_clk",
+				"nss_cc_ppe_switch_cfg_clk",
+				"nss_cc_ppe_edma_clk",
+				"nss_cc_ppe_edma_cfg_clk",
+				"nss_cc_crypto_ppe_clk",
+				"nss_cc_nssnoc_ppe_clk",
+				"nss_cc_nssnoc_ppe_cfg_clk",
+				"nss_cc_ppe_switch_btq_clk",
+				"nss_cc_port1_rx_clk",
+				"nss_cc_port1_tx_clk",
+				"nss_cc_port2_rx_clk",
+				"nss_cc_port2_tx_clk",
+				"nss_cc_port3_rx_clk",
+				"nss_cc_port3_tx_clk",
+				"nss_cc_port4_rx_clk",
+				"nss_cc_port4_tx_clk",
+				"nss_cc_port5_rx_clk",
+				"nss_cc_port5_tx_clk",
+				"nss_cc_port6_rx_clk",
+				"nss_cc_port6_tx_clk",
+				"nss_cc_uniphy_port1_rx_clk",
+				"nss_cc_uniphy_port1_tx_clk",
+				"nss_cc_uniphy_port2_rx_clk",
+				"nss_cc_uniphy_port2_tx_clk",
+				"nss_cc_uniphy_port3_rx_clk",
+				"nss_cc_uniphy_port3_tx_clk",
+				"nss_cc_uniphy_port4_rx_clk",
+				"nss_cc_uniphy_port4_tx_clk",
+				"nss_cc_uniphy_port5_rx_clk",
+				"nss_cc_uniphy_port5_tx_clk",
+				"nss_cc_uniphy_port6_rx_clk",
+				"nss_cc_uniphy_port6_tx_clk",
+				"uniphy0_nss_rx_clk",
+				"uniphy0_nss_tx_clk",
+				"uniphy1_nss_rx_clk",
+				"uniphy1_nss_tx_clk",
+				"uniphy2_nss_rx_clk",
+				"uniphy2_nss_tx_clk";
+
+			resets = <&reset GCC_UNIPHY0_SOFT_RESET>,
+				<&reset GCC_UNIPHY1_SOFT_RESET>,
+				<&reset GCC_UNIPHY2_SOFT_RESET>,
+				<&reset GCC_UNIPHY0_XPCS_RESET>,
+				<&reset GCC_UNIPHY1_XPCS_RESET>,
+				<&reset GCC_UNIPHY2_XPCS_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT1_TX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT1_RX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT2_TX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT2_RX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT3_TX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT3_RX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT4_TX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT4_RX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT5_TX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT5_RX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT6_TX_RESET>,
+				<&nss_reset NSS_CC_UNIPHY_PORT6_RX_RESET>,
+				<&nss_reset NSS_CC_PORT1_TX_RESET>,
+				<&nss_reset NSS_CC_PORT1_RX_RESET>,
+				<&nss_reset NSS_CC_PORT2_TX_RESET>,
+				<&nss_reset NSS_CC_PORT2_RX_RESET>,
+				<&nss_reset NSS_CC_PORT3_TX_RESET>,
+				<&nss_reset NSS_CC_PORT3_RX_RESET>,
+				<&nss_reset NSS_CC_PORT4_TX_RESET>,
+				<&nss_reset NSS_CC_PORT4_RX_RESET>,
+				<&nss_reset NSS_CC_PORT5_TX_RESET>,
+				<&nss_reset NSS_CC_PORT5_RX_RESET>,
+				<&nss_reset NSS_CC_PORT6_TX_RESET>,
+				<&nss_reset NSS_CC_PORT6_RX_RESET>,
+				<&nss_reset NSS_CC_PPE_EDMA_RESET>,
+				<&nss_reset NSS_CC_PPE_CFG_RESET>,
+				<&nss_reset NSS_CC_PORT1_MAC_RESET>,
+				<&nss_reset NSS_CC_PORT2_MAC_RESET>,
+				<&nss_reset NSS_CC_PORT3_MAC_RESET>,
+				<&nss_reset NSS_CC_PORT4_MAC_RESET>,
+				<&nss_reset NSS_CC_PORT5_MAC_RESET>,
+				<&nss_reset NSS_CC_PORT6_MAC_RESET>;
+
+			reset-names = "uniphy0_srst", "uniphy1_srst",
+					"uniphy2_srst", "uniphy0_xrst",
+					"uniphy1_xrst", "uniphy2_xrst",
+					"uniphy_port1_tx", "uniphy_port1_rx",
+					"uniphy_port2_tx", "uniphy_port2_rx",
+					"uniphy_port3_tx", "uniphy_port3_rx",
+					"uniphy_port4_tx", "uniphy_port4_rx",
+					"uniphy_port5_tx", "uniphy_port5_rx",
+					"uniphy_port6_tx", "uniphy_port6_rx",
+					"nss_cc_port1_tx",
+					"nss_cc_port1_rx",
+					"nss_cc_port2_tx",
+					"nss_cc_port2_rx",
+					"nss_cc_port3_tx",
+					"nss_cc_port3_rx",
+					"nss_cc_port4_tx",
+					"nss_cc_port4_rx",
+					"nss_cc_port5_tx",
+					"nss_cc_port5_rx",
+					"nss_cc_port6_tx",
+					"nss_cc_port6_rx",
+					"nss_cc_ppe_edma_reset",
+					"nss_cc_ppe_cfg_reset",
+					"nss_cc_port1_mac",
+					"nss_cc_port2_mac",
+					"nss_cc_port3_mac",
+					"nss_cc_port4_mac",
+					"nss_cc_port5_mac",
+					"nss_cc_port6_mac";
+			tdm_offset = <0xc000>;
+			tdm_mode = <0>;
+			no_tdm_reg = <118>;
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@84000 {
+			compatible = "qti,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0x00084000 0x1bc>, /* Serdes PLL */
+				<0x00084200 0x16c>, /* Serdes Tx0 */
+				<0x00084400 0x200>, /* Serdes Rx0 */
+				<0x00084800 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				<0x00084c00 0x0f4>; /* pcs_misc */
+
+			clocks = <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>,
+				 <&gcc GCC_PCIE0_PIPE_CLK>;
+
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		pcie1_phy: phy@fc000 {
+			compatible = "qti,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0x000fc000 0x1bc>, /* Serdes PLL */
+				<0x000fc200 0x16c>, /* Serdes Tx0 */
+				<0x000fc400 0x200>, /* Serdes Rx0 */
+				<0x000fc800 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				<0x000fcc00 0x0f4>; /* pcs_misc */
+
+			clocks = <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>,
+				 <&gcc GCC_PCIE1_PIPE_CLK>;
+
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		pcie2_phy: phy@8c000 {
+			compatible = "qti,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x0008c000 0x1bc>, /* Serdes PLL */
+				<0x0008c200 0x16c>, /* Serdes Tx0 */
+				<0x0008c400 0x200>, /* Serdes Rx0 */
+				<0x0008d000 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				<0x0008c600 0x16c>, /* Serdes Tx1 */
+				<0x0008c800 0x200>, /* Serdes Rx1 */
+				<0x0008d400 0x0f8>; /* pcs_misc */
+
+			clocks = <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
+				 <&gcc GCC_PCIE2_PIPE_CLK>;
+
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		pcie3_phy: phy@f4000 {
+			compatible = "qti,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x000f4000 0x1bc>, /* Serdes PLL */
+				<0x000f4200 0x16c>, /* Serdes Tx0 */
+				<0x000f4400 0x200>, /* Serdes Rx0 */
+				<0x000f5000 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				<0x000f4600 0x16c>, /* Serdes Tx1 */
+				<0x000f4800 0x200>, /* Serdes Rx1 */
+				<0x000f5400 0x0f8>; /* pcs_misc */
+
+			clocks = <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
+				 <&gcc GCC_PCIE3_PIPE_CLK>;
+
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		pcie0_x1: pci@28000000 {
+			compatible = "qti,dw-pcie-ipq9574";
+			reg = <0x28000000 0xf1d>,
+				<0x28000F20 0xa8>,
+				<0x28001000 0x1000>,
+				<0x00080000 0x4000>,
+				<0x28100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			num-lanes = <1>;
+			id = <0>;
+			gen = <3>;
+
+			clocks = <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
+
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>,
+					  <&gcc GCC_PCIE0_AXI_M_CLK>,
+					  <&gcc GCC_PCIE0_AXI_S_CLK>,
+					  <&gcc GCC_PCIE0_RCHNG_CLK>;
+			assigned-clock-rates = <20000000>,
+					       <240000000>,
+					       <240000000>,
+					       <100000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x81000000 0 0x28200000 0x28200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x28300000 0x28300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			phys = <&pcie0_phy PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			status = "disabled";
+			device_type = "pci";
+		};
+
+		pcie1_x1: pci@10000000 {
+			compatible = "qti,dw-pcie-ipq9574";
+			reg = <0x10000000 0xf1d>,
+				<0x10000F20 0xa8>,
+				<0x10001000 0x1000>,
+				<0x000F8000 0x4000>,
+				<0x10100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			num-lanes = <1>;
+			id = <1>;
+			gen = <3>;
+
+			clocks = <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
+
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>,
+					  <&gcc GCC_PCIE1_AXI_M_CLK>,
+					  <&gcc GCC_PCIE1_AXI_S_CLK>,
+					  <&gcc GCC_PCIE1_RCHNG_CLK>;
+			assigned-clock-rates = <20000000>,
+					       <240000000>,
+					       <240000000>,
+					       <100000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x81000000 0 0x10200000 0x10200000
+				0 0x00100000   /* downstream I/O */
+				0x82000000 0 0x10300000 0x10300000
+				0 0x07d00000>; /* non-prefetchable memory */
+
+			phys = <&pcie1_phy PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			status = "disabled";
+			device_type = "pci";
+		};
+
+		pcie2_x2: pci@20000000 {
+			compatible = "qti,dw-pcie-ipq9574";
+			reg = <0x20000000 0xf1d>,
+				<0x20000F20 0xa8>,
+				<0x20001000 0x1000>,
+				<0x00088000 0x4000>,
+				<0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			num-lanes = <2>;
+			id = <2>;
+			gen = <3>;
+
+			clocks = <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>;
+
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>,
+					  <&gcc GCC_PCIE2_AXI_M_CLK>,
+					  <&gcc GCC_PCIE2_AXI_S_CLK>,
+					  <&gcc GCC_PCIE2_RCHNG_CLK>;
+			assigned-clock-rates = <20000000>,
+					       <342857143>,
+					       <240000000>,
+					       <100000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x81000000 0 0x20200000 0x20200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x20300000 0x20300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			phys = <&pcie2_phy PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			status = "disabled";
+		};
+
+		pcie3_x2: pci@18000000 {
+			compatible = "qti,dw-pcie-ipq9574";
+			reg = <0x18000000 0xf1d>,
+				<0x18000F20 0xa8>,
+				<0x18001000 0x1000>,
+				<0x000F0000 0x4000>,
+				<0x18100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			num-lanes = <2>;
+			id = <3>;
+			gen = <3>;
+
+			clocks = <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_PCIE3_AUX_CLK>,
+				 <&gcc GCC_PCIE3_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>;
+
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>,
+					  <&gcc GCC_PCIE3_AXI_M_CLK>,
+					  <&gcc GCC_PCIE3_AXI_S_CLK>,
+					  <&gcc GCC_PCIE3_RCHNG_CLK>;
+			assigned-clock-rates = <20000000>,
+					       <342857143>,
+					       <240000000>,
+					       <100000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x81000000 0 0x18200000 0x18200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x18300000 0x18300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			phys = <&pcie3_phy PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h b/arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
new file mode 100644
index 0000000000..441f702ee5
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
@@ -0,0 +1,252 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#ifndef _MACH_SYSMAP_IPQ9574_H
+#define _MACH_SYSMAP_IPQ9574_H
+
+#define SDCC1_SRC_SEL_GPLL2_OUT_MAIN	BIT(9)
+#define SDCC1_SRC_SEL_GPLL0_OUT_MAIN	BIT(8)
+#define PCIE_SRC_SEL_UNSUSED_GND	BIT(8)
+#define PCIE_SRC_SEL_GPLL4_OUT_MAIN	BIT(9)
+#define PCIE_SRC_SEL_GPLL0_OUT_MAIN	BIT(8)
+
+/* BLSP UART clock register */
+#define BLSP1_AHB_CBCR			0x01004
+#define BLSP1_UART1_BCR			0x02028
+#define APCS_CLOCK_BRANCH_ENA_VOTE	0x0B004
+
+#define BLSP1_UART_BCR(id)		(BLSP1_UART1_BCR + (0x1000 * (id)))
+
+#define BLSP1_UART_APPS_CMD_RCGR(id)	(BLSP1_UART_BCR(id) + 0x04)
+#define BLSP1_UART_APPS_CFG_RCGR(id)	(BLSP1_UART_BCR(id) + 0x08)
+#define BLSP1_UART_APPS_M(id)		(BLSP1_UART_BCR(id) + 0x0c)
+#define BLSP1_UART_APPS_N(id)		(BLSP1_UART_BCR(id) + 0x10)
+#define BLSP1_UART_APPS_D(id)		(BLSP1_UART_BCR(id) + 0x14)
+#define BLSP1_UART_APPS_CBCR(id)	(BLSP1_UART_BCR(id) + 0x18)
+
+/* Uart clock control registers */
+#define BLSP1_UART2_BCR			(0x3028)
+#define BLSP1_UART2_APPS_CBCR		(0x3040)
+#define BLSP1_UART2_APPS_CMD_RCGR	(0x302C)
+#define BLSP1_UART2_APPS_CFG_RCGR	(0x3030)
+#define BLSP1_UART2_APPS_M		(0x3034)
+#define BLSP1_UART2_APPS_N		(0x3038)
+#define BLSP1_UART2_APPS_D		(0x303C)
+
+/* SD controller clock control registers */
+#define SDCC1_BCR			(0x33000)
+#define SDCC1_APPS_CMD_RCGR		(0x33004)
+#define SDCC1_APPS_CFG_RCGR		(0x33008)
+#define SDCC1_APPS_M			(0x3300C)
+#define SDCC1_APPS_N			(0x33010)
+#define SDCC1_APPS_D			(0x33014)
+#define SDCC1_APPS_CBCR			(0x3302C)
+#define SDCC1_AHB_CBCR			(0x33034)
+
+/* BLSP QUP SPI clock register */
+#define BLSP1_QUP1_SPI_BCR		0x02000
+
+#define BLSP1_QUP_SPI_BCR(id)		(BLSP1_QUP1_SPI_BCR + (0x1000 * (id)))
+
+#define BLSP1_QUP_SPI_APPS_CMD_RCGR(id)	(BLSP1_QUP_SPI_BCR(id) + 0x04)
+#define BLSP1_QUP_SPI_APPS_CFG_RCGR(id)	(BLSP1_QUP_SPI_BCR(id) + 0x08)
+#define BLSP1_QUP_SPI_APPS_M(id)	(BLSP1_QUP_SPI_BCR(id) + 0x0c)
+#define BLSP1_QUP_SPI_APPS_N(id)	(BLSP1_QUP_SPI_BCR(id) + 0x10)
+#define BLSP1_QUP_SPI_APPS_D(id)	(BLSP1_QUP_SPI_BCR(id) + 0x14)
+#define BLSP1_QUP_SPI_APPS_CBCR(id)	(BLSP1_QUP_SPI_BCR(id) + 0x20)
+
+#define BLSP1_QUP_SPI_SRC_SEL_XO			(0 << 8)
+#define BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN		BIT(8)
+
+/* BLSP QUP I2C clock register */
+#define BLSP1_QUP0_I2C_BCR		0x02000
+
+#define BLSP1_QUP_I2C_BCR(id)		(BLSP1_QUP0_I2C_BCR + (0x1000 * (id)))
+
+#define BLSP1_QUP_I2C_APPS_CMD_RCGR(id)	(BLSP1_QUP_I2C_BCR(id) + 0x18)
+#define BLSP1_QUP_I2C_APPS_CFG_RCGR(id)	(BLSP1_QUP_I2C_BCR(id) + 0x1C)
+#define BLSP1_QUP_I2C_APPS_CBCR(id)	(BLSP1_QUP_I2C_BCR(id) + 0x24)
+
+#define BLSP1_QUP_I2C_50M_DIV_VAL	(0x1F << 0)
+#define BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN		BIT(8)
+
+/* USB clock control registers */
+#define GCC_USB0_MASTER_CMD_RCGR			(0x2C004)
+#define GCC_USB0_MASTER_CFG_RCGR			(0x2C008)
+#define GCC_USB0_MOCK_UTMI_CMD_RCGR			(0x2C02C)
+#define GCC_USB0_MOCK_UTMI_CFG_RCGR			(0x2C030)
+#define GCC_USB0_MOCK_UTMI_M				(0x2C034)
+#define GCC_USB0_MOCK_UTMI_N				(0x2C038)
+#define GCC_USB0_MOCK_UTMI_D				(0x2C03C)
+#define GCC_USB0_AUX_CMD_RCGR				(0x2C018)
+#define GCC_USB0_AUX_CFG_RCGR				(0x2C01C)
+#define GCC_USB0_AUX_M					(0x2C020)
+#define GCC_USB0_AUX_N					(0x2C024)
+#define GCC_USB0_AUX_D					(0x2C028)
+
+#define USB0_MASTER_SRC_SEL_GPLL0_OUT_MAIN		BIT(8)
+#define USB0_MOCK_UTMI_SRC_SEL_XO			(0 << 8)
+#define USB0_AUX_SRC_SEL_XO				(0 << 8)
+
+#define GCC_USB0_MASTER_CBCR				(0x2C044)
+#define GCC_USB0_AUX_CBCR				(0x2C048)
+#define GCC_USB0_MOCK_UTMI_CBCR				(0x2C04C)
+#define GCC_USB0_PIPE_CBCR				(0x2C054)
+#define GCC_USB0_SLEEP_CBCR				(0x2C058)
+#define GCC_USB0_PHY_CFG_AHB_CBCR			(0x2C05C)
+#define GCC_SNOC_USB_CBCR				(0x2E058)
+#define GCC_ANOC_USB_AXI_CBCR				(0x2E084)
+
+/* GCC clock control registers */
+#define GCC_NSSNOC_ATB_CBCR				(0x17014)
+#define GCC_NSSNOC_QOSGEN_REF_CBCR			(0x1701C)
+#define GCC_NSSNOC_TIMEOUT_REF_CBCR			(0x17020)
+#define GCC_NSSNOC_MEMNOC_CBCR				(0x17024)
+#define GCC_NSSNOC_SNOC_CBCR				(0x17028)
+#define GCC_NSSCFG_CBCR					(0x1702C)
+#define GCC_MDIO_AHB_CBCR				(0x17040)
+#define GCC_UNIPHY0_SYS_CBCR				(0x17048)
+#define GCC_UNIPHY0_AHB_CBCR				(0x1704C)
+#define GCC_UNIPHY_SYS_CBCR(id)		(GCC_UNIPHY0_SYS_CBCR + (0x10 * (id)))
+#define GCC_UNIPHY_AHB_CBCR(id)		(GCC_UNIPHY0_AHB_CBCR + (0x10 * (id)))
+#define GCC_NSSNOC_SNOC_1_CBCR				(0x1707C)
+#define GCC_NSSNOC_MEM_NOC_1_CBCR			(0x17084)
+#define GCC_UNIPHY_SYS_CMD_RCGR				(0x17090)
+#define GCC_UNIPHY_SYS_CFG_RCGR				(0x17094)
+#define GCC_MEM_NOC_NSSNOC_CBCR				(0x19014)
+#define GCC_MEM_NOC_SNOC_AXI_CBCR			(0x19018)
+#define GCC_CMN_12GPLL_AHB_CBCR				(0x3A004)
+#define GCC_CMN_12GPLL_SYS_CBCR				(0x3A008)
+
+#define GCC_NSSNOC_MEMNOC_BFDCD_CMD_RCGR		(0x17004)
+#define GCC_NSSNOC_MEMNOC_BFDCD_CFG_RCGR		(0x17008)
+#define GCC_QDSS_AT_CMD_RCGR				(0x2D004)
+#define GCC_QDSS_AT_CFG_RCGR				(0x2D008)
+#define GCC_SYSTEM_NOC_BFDCD_CMD_RCGR			(0x2E004)
+#define GCC_SYSTEM_NOC_BFDCD_CFG_RCGR			(0x2E008)
+#define GCC_PCNOC_BFDCD_CMD_RCGR			(0x31004)
+#define GCC_PCNOC_BFDCD_CFG_RCGR			(0x31008)
+
+#define GCC_NSSNOC_MEMNOC_BFDCD_SRC_SEL_GPLL0_OUT_MAIN	BIT(8)
+#define GCC_QDSS_AT_SRC_SEL_GPLL0_OUT_MAIN		BIT(8)
+#define GCC_PCNOC_BFDCD_SRC_SEL_GPLL0_OUT_MAIN		BIT(8)
+#define GCC_SYSTEM_NOC_BFDCD_SRC_SEL_GPLL4_OUT_MAIN	BIT(9)
+
+/* NSS clock control registers */
+#define NSS_CC_PORT1_RX_CBCR				(0x281A0)
+#define NSS_CC_PORT1_TX_CBCR				(0x281A4)
+#define NSS_CC_PORT_RX_CBCR(id)		(NSS_CC_PORT1_RX_CBCR + (8 * ((id) - 1)))
+#define NSS_CC_PORT_TX_CBCR(id)		(NSS_CC_PORT1_TX_CBCR + (8 * ((id) - 1)))
+#define NSS_CC_NSS_CSR_CBCR				(0x281D0)
+#define NSS_CC_NSSNOC_NSS_CSR_CBCR			(0x281D4)
+#define NSS_CC_PPE_SWITCH_IPE_CBCR			(0x2822C)
+#define NSS_CC_PPE_SWITCH_CBCR				(0x28230)
+#define NSS_CC_PPE_SWITCH_CFG_CBCR			(0x28234)
+#define NSS_CC_PPE_EDMA_CBCR				(0x28238)
+#define NSS_CC_PPE_EDMA_CFG_CBCR			(0x2823C)
+#define NSS_CC_CRYPTO_PPE_CBCR				(0x28240)
+#define NSS_CC_NSSNOC_PPE_CBCR				(0x28244)
+#define NSS_CC_NSSNOC_PPE_CFG_CBCR			(0x28248)
+#define NSS_CC_PORT1_MAC_CBCR				(0x2824C)
+#define NSS_CC_PORT_MAC_CBCR(id)	(NSS_CC_PORT1_MAC_CBCR + (4 * ((id) - 1)))
+#define NSS_CC_PPE_SWITCH_BTQ_CBCR			(0x2827C)
+#define NSS_CC_UNIPHY_PORT1_RX_CBCR			(0x28904)
+#define NSS_CC_UNIPHY_PORT1_TX_CBCR			(0x28908)
+#define NSS_CC_UNIPHY_PORT_RX_CBCR(id)	(NSS_CC_UNIPHY_PORT1_RX_CBCR + (0x8 * ((id) - 1)))
+#define NSS_CC_UNIPHY_PORT_TX_CBCR(id)	(NSS_CC_UNIPHY_PORT1_TX_CBCR + (0x8 * ((id) - 1)))
+
+#define NSS_CC_CFG_CMD_RCGR				(0x28104)
+#define NSS_CC_CFG_CFG_RCGR				(0x28108)
+#define NSS_CC_PORT1_RX_CMD_RCGR			(0x28110)
+#define NSS_CC_PORT1_RX_CFG_RCGR			(0x28114)
+#define NSS_CC_PORT1_RX_DIV_CDIVR			(0x28118)
+#define NSS_CC_PORT1_TX_CMD_RCGR			(0x2811C)
+#define NSS_CC_PORT1_TX_CFG_RCGR			(0x28120)
+#define NSS_CC_PORT1_TX_DIV_CDIVR			(0x28124)
+#define NSS_CC_PORT_RX_CMD_RCGR(id)	(NSS_CC_PORT1_RX_CMD_RCGR + (0x18 * ((id) - 1)))
+#define NSS_CC_PORT_RX_CFG_RCGR(id)	(NSS_CC_PORT1_RX_CFG_RCGR + (0x18 * ((id) - 1)))
+#define NSS_CC_PORT_RX_DIV_CDIVR(id)	(NSS_CC_PORT1_RX_DIV_CDIVR + (0x18 * ((id) - 1)))
+#define NSS_CC_PORT_TX_CMD_RCGR(id)	(NSS_CC_PORT1_TX_CMD_RCGR + (0x18 * ((id) - 1)))
+#define NSS_CC_PORT_TX_CFG_RCGR(id)	(NSS_CC_PORT1_TX_CFG_RCGR + (0x18 * ((id) - 1)))
+#define NSS_CC_PORT_TX_DIV_CDIVR(id)	(NSS_CC_PORT1_TX_DIV_CDIVR + (0x18 * ((id) - 1)))
+#define NSS_CC_PPE_CMD_RCGR				(0x28204)
+#define NSS_CC_PPE_CFG_RCGR				(0x28208)
+
+#define NSS_CC_CFG_SRC_SEL_GCC_GPLL0_OUT_AUX		BIT(9)
+#define NSS_CC_PPE_SRC_SEL_BIAS_PLL_UBI_NC_CLK		BIT(8)
+#define NSS_CC_PORT1_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK	BIT(9)
+#define NSS_CC_PORT1_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK	(3 << 8)
+#define NSS_CC_PORT5_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK	(2 << 8)
+#define NSS_CC_PORT5_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK	(3 << 8)
+#define NSS_CC_PORT5_RX_SRC_SEL_UNIPHY1_NSS_RX_CLK	(4 << 8)
+#define NSS_CC_PORT5_TX_SRC_SEL_UNIPHY1_NSS_TX_CLK	(5 << 8)
+#define NSS_CC_PORT6_RX_SRC_SEL_UNIPHY2_NSS_RX_CLK	(2 << 8)
+#define NSS_CC_PORT6_TX_SRC_SEL_UNIPHY2_NSS_TX_CLK	(3 << 8)
+
+#define CLK_1_25_MHZ			(1250000UL)
+#define CLK_2_5_MHZ			(2500000UL)
+#define CLK_12_5_MHZ			(12500000UL)
+#define CLK_25_MHZ			(25000000UL)
+#define CLK_78_125_MHZ			(78125000UL)
+#define CLK_50_MHZ			(50000000UL)
+#define CLK_125_MHZ			(125000000UL)
+#define CLK_156_25_MHZ			(156250000UL)
+#define CLK_312_5_MHZ			(312500000UL)
+
+/*
+ * QTI SPI NAND clock
+ */
+#define GCC_QPIC_IO_MACRO_CMD_RCGR	(0x32004)
+#define GCC_QPIC_IO_MACRO_CFG_RCGR      (0x32008)
+#define GCC_QPIC_IO_MACRO_CBCR          (0x3200C)
+
+#define IO_MACRO_CLK_320_MHZ            (320000000)
+#define IO_MACRO_CLK_266_MHZ            (266000000)
+#define IO_MACRO_CLK_228_MHZ            (228000000)
+#define IO_MACRO_CLK_200_MHZ            (200000000)
+#define IO_MACRO_CLK_100_MHZ            (100000000)
+#define IO_MACRO_CLK_24_MHZ		(24000000)
+
+#define GCC_QPIC_IO_MACRO_SRC_SEL_XO_CLK		(0 << 8)
+#define GCC_QPIC_IO_MACRO_SRC_SEL_GPLL0_OUT_MAIN	BIT(8)
+
+/*
+ * PCI clock
+ */
+#define GCC_PCIE_BASE				0x28000
+#define GCC_PCIE_OFFSET(id, off)		(GCC_PCIE_BASE + \
+						 ((id) * 0x1000) + (off))
+
+#define GCC_PCIE_AUX_CMD_RCGR			(GCC_PCIE_BASE + 0x4)
+#define GCC_PCIE_AUX_CFG_RCGR			(GCC_PCIE_BASE + 0x8)
+#define GCC_PCIE_AUX_M				(GCC_PCIE_BASE + 0xc)
+#define GCC_PCIE_AUX_N				(GCC_PCIE_BASE + 0x10)
+#define GCC_PCIE_AUX_D				(GCC_PCIE_BASE + 0x14)
+
+#define GCC_PCIE_AXI_M_CMD_RCGR(id)		GCC_PCIE_OFFSET(id, 0x18)
+#define GCC_PCIE_AXI_M_CFG_RCGR(id)		GCC_PCIE_OFFSET(id, 0x1C)
+#define GCC_PCIE_AXI_S_CMD_RCGR(id)		GCC_PCIE_OFFSET(id, 0x20)
+#define GCC_PCIE_AXI_S_CFG_RCGR(id)		GCC_PCIE_OFFSET(id, 0x24)
+#define GCC_PCIE_RCHNG_CMD_RCGR(id)		GCC_PCIE_OFFSET(id, 0x28)
+#define GCC_PCIE_RCHNG_CFG_RCGR(id)		GCC_PCIE_OFFSET(id, 0x2C)
+#define GCC_PCIE_AHB_CBCR(id)			GCC_PCIE_OFFSET(id, 0x30)
+#define GCC_PCIE_AUX_CBCR(id)			GCC_PCIE_OFFSET(id, 0x34)
+#define GCC_PCIE_AXI_M_CBCR(id)			GCC_PCIE_OFFSET(id, 0x38)
+#define GCC_PCIE_AXI_S_CBCR(id)			GCC_PCIE_OFFSET(id, 0x3C)
+#define GCC_PCIE_AXI_S_BRIDGE_CBCR(id)		GCC_PCIE_OFFSET(id, 0x40)
+#define GCC_PCIE_PIPE_CBCR(id)			GCC_PCIE_OFFSET(id, 0x44)
+
+#define GCC_SNOC_PCIE0_1LANE_S_CBCR		0x2E048
+#define GCC_SNOC_PCIE1_1LANE_S_CBCR		0x2E04C
+#define GCC_SNOC_PCIE2_2LANE_S_CBCR		0x2E050
+#define GCC_SNOC_PCIE3_2LANE_S_CBCR		0x2E054
+#define GCC_ANOC_PCIE0_1LANE_M_CBCR		0x2E07C
+#define GCC_ANOC_PCIE2_2LANE_M_CBCR		0x2E080
+#define GCC_ANOC_PCIE1_1LANE_M_CBCR		0x2E08C
+#define GCC_ANOC_PCIE3_2LANE_M_CBCR		0x2E090
+#endif
diff --git a/arch/arm/mach-snapdragon/init_ipq9574.c b/arch/arm/mach-snapdragon/init_ipq9574.c
new file mode 100644
index 0000000000..bf8da1f9d1
--- /dev/null
+++ b/arch/arm/mach-snapdragon/init_ipq9574.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <asm/cache.h>
+#include <asm/system.h>
+#include <asm/u-boot.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define UBOOT_CACHE_SETUP		0x100e
+#define GEN_CACHE_SETUP			0x101e
+
+int arch_setup_dest_addr(void)
+{
+	gd->relocaddr = CONFIG_TEXT_BASE;
+	gd->reloc_off = gd->relocaddr - CONFIG_TEXT_BASE;
+
+	return 0;
+}
+
+int arm_reserve_mmu(void)
+{
+	/* reserve TLB table */
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = CONFIG_TEXT_BASE + gd->mon_len;
+	gd->arch.tlb_addr += (0x10000 - 1);
+	gd->arch.tlb_addr &= ~(0x10000 - 1);
+
+	return 0;
+}
+
+int mach_cpu_init(void)
+{
+	gd->flags |= GD_FLG_SKIP_RELOC;
+
+	return 0;
+}
+
+int arch_cpu_init(void)
+{
+	u32 val;
+
+	if (IS_ENABLED(CONFIG_ARM64))
+		return 0;
+
+	/* Read SCTLR */
+	asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r" (val));
+	/* set the cp15 barrier enable bit */
+	val |= 0x20;
+	/* write back to SCTLR */
+	asm volatile ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
+
+	return 0;
+}
+
+#if !CONFIG_IS_ENABLED(ARM64)
+void dram_bank_mmu_setup(int bank)
+{
+	struct bd_info *bd = gd->bd;
+	int i;
+
+	/* bd->bi_dram is available only after relocation */
+	if ((gd->flags & GD_FLG_RELOC) == 0)
+		return;
+
+	debug("%s: bank: %d\n", __func__, bank);
+	for (i = bd->bi_dram[bank].start >> 20;
+		i < (bd->bi_dram[bank].start + bd->bi_dram[bank].size) >> 20;
+		i++) {
+		/* Set XN bit for all dram regions except uboot code region */
+		if ((i >= (CONFIG_TEXT_BASE >> 20)) &&
+		    (i < ((CONFIG_TEXT_BASE + 0x100000) >> 20)))
+			set_section_dcache(i, UBOOT_CACHE_SETUP);
+		else
+			set_section_dcache(i, GEN_CACHE_SETUP);
+	}
+}
+#endif
diff --git a/board/qualcomm/ipq9574/Kconfig b/board/qualcomm/ipq9574/Kconfig
new file mode 100644
index 0000000000..f9f107dcf6
--- /dev/null
+++ b/board/qualcomm/ipq9574/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_IPQ9574
+
+config SYS_BOARD
+	default "ipq9574"
+
+config SYS_VENDOR
+	default "qualcomm"
+
+config SYS_SOC
+	default "ipq9574"
+
+config SYS_CONFIG_NAME
+	default "ipq9574"
+
+endif
diff --git a/board/qualcomm/ipq9574/Makefile b/board/qualcomm/ipq9574/Makefile
new file mode 100644
index 0000000000..36f24f5fbb
--- /dev/null
+++ b/board/qualcomm/ipq9574/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	+= ipq9574.o
+obj-y	+= board_init.o
diff --git a/board/qualcomm/ipq9574/board_init.c b/board/qualcomm/ipq9574/board_init.c
new file mode 100644
index 0000000000..009f84b2bb
--- /dev/null
+++ b/board/qualcomm/ipq9574/board_init.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2013, 2015-2017, 2020 The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Based on smem.c from lk.
+ *
+ * Copyright (c) 2009, Google Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *  * Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *  * Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
+ * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <asm/byteorder.h>
+#include <asm/armv8/mmu.h>
+#include <mach/dram.h>
+#include <memalign.h>
+#include <fdtdec.h>
+#include <mmc.h>
+#include <sdhci.h>
+#include <command.h>
+#include <env.h>
+#include <env_internal.h>
+#include <linux/delay.h>
+#include <part.h>
+#include <dm.h>
+#include <smem.h>
+#include "ipq9574.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+u32 g_board_machid;
+u32 g_load_addr;
+
+struct udevice *smem;
+
+__weak void ipq_uboot_fdt_fixup(void)
+{
+}
+
+__weak void set_flash_secondary_type(uint32_t flash_type)
+{
+}
+
+void *smem_get_item(unsigned int item)
+{
+	int ret;
+	struct udevice *smem_tmp;
+	const char *name = "smem";
+	size_t size;
+	unsigned long reloc_flag = (gd->flags & GD_FLG_RELOC);
+
+	if (reloc_flag == 0)
+		ret = uclass_get_device_by_name(UCLASS_SMEM, name, &smem_tmp);
+	else if (!smem)
+		ret = uclass_get_device_by_name(UCLASS_SMEM, name, &smem);
+
+	if (ret < 0) {
+		printf("Failed to find SMEM node. Check device tree %d\n", ret);
+		return 0;
+	}
+
+	return smem_get(reloc_flag ? smem : smem_tmp, -1, item, &size);
+}
+
+int board_init(void)
+{
+	u32 *flash_type;
+	u32 *flash_chip_select;
+	u32 *primary_mibib;
+	u32 *flash_index;
+	u32 *flash_block_size;
+	u32 *flash_density;
+
+	gd->bd->bi_boot_params = BOOT_PARAMS_ADDR;
+
+	gd->bd->bi_arch_number = g_board_machid;
+
+	flash_type = smem_get_item(SMEM_BOOT_FLASH_TYPE);
+
+	if (!flash_type) {
+		printf("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	flash_index = smem_get_item(SMEM_BOOT_FLASH_INDEX);
+
+	if (!flash_index) {
+		printf("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	flash_chip_select = smem_get_item(SMEM_BOOT_FLASH_CHIP_SELECT);
+
+	if (!flash_chip_select) {
+		printf("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	flash_block_size = smem_get_item(SMEM_BOOT_FLASH_BLOCK_SIZE);
+
+	if (!flash_block_size) {
+		printf("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	flash_density = smem_get_item(SMEM_BOOT_FLASH_DENSITY);
+
+	if (!flash_density) {
+		printf("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	primary_mibib = smem_get_item(SMEM_PARTITION_TABLE_OFFSET);
+	if (IS_ERR_OR_NULL(primary_mibib)) {
+		debug("Failed to get SMEM item: SMEM_PARTITION_TABLE_OFFSET\n");
+		primary_mibib = NULL;
+	}
+
+	if (SZ_256M == gd->ram_size && CONFIG_SYS_LOAD_ADDR > SZ_256M)
+		g_load_addr = CFG_SYS_SDRAM_BASE + SZ_64M;
+	else
+		g_load_addr = CONFIG_SYS_LOAD_ADDR;
+
+	return 0;
+}
+
+/*
+ * This function is called in the very beginning.
+ * Retrieve the machtype info from SMEM and map the board specific
+ * parameters. Shared memory region at Dram address
+ * contains the machine id/ board type data polulated by SBL.
+ */
+int board_early_init_f(void)
+{
+	union ipq_platform *pt;
+
+	if (IPQ_CONFIG_SMEM_VERSION_C) {
+		pt = smem_get_item(SMEM_HW_SW_BUILD_ID);
+		if (IS_ERR_OR_NULL(pt)) {
+			debug("Failed to get SMEM item: SMEM_HW_SW_BUILD_ID\n");
+			return -ENODEV;
+		}
+
+		g_board_machid = ((pt->v1.hw_platform << 24) |
+				  ((SOCINFO_VERSION_MAJOR(pt->v1.platform_version)) << 16) |
+				  ((SOCINFO_VERSION_MINOR(pt->v1.platform_version)) << 8) |
+				  (pt->v1.hw_platform_subtype));
+	} else {
+		struct smem_machid_info *machid_info;
+
+		machid_info = smem_get_item(SMEM_MACHID_INFO_LOCATION);
+		if (IS_ERR_OR_NULL(machid_info)) {
+			debug("Failed to get SMEM item: SMEM_MACHID_INFO_LOCATION\n");
+			return -ENODEV;
+		}
+
+		g_board_machid = machid_info->machid;
+	}
+
+	return 0;
+}
+
+int board_fix_fdt(void *rw_fdt_blob)
+{
+	ipq_uboot_fdt_fixup();
+	return 0;
+}
+
+int embedded_dtb_select(void)
+{
+	int rescan;
+
+	if (IS_ENABLED(CONFIG_DTB_RESELECT))
+		fdtdec_resetup(&rescan);
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	return msm_fixup_memory(NULL);
+}
+
+void *env_sf_get_env_addr(void)
+{
+	return NULL;
+}
+
+int part_get_info_efi_by_name(const char *name, struct disk_partition *info)
+{
+	struct blk_desc *mmc_dev;
+	int ret = -1;
+	int i;
+
+	mmc_dev = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+
+	if (mmc_dev->type == DEV_TYPE_UNKNOWN)
+		goto done;
+
+	for (i = 1; i < GPT_ENTRY_NUMBERS; i++) {
+		ret = part_get_info_efi(mmc_dev, i, info);
+		if (ret != 0) {
+			/* no more entries in table */
+			goto done;
+		}
+		if (strcmp(name, (const char *)info->name) == 0) {
+			/* matched */
+			ret = 0;
+			goto done;
+		}
+	}
+done:
+	return ret;
+}
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	int ret;
+	u32 *flash_type;
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	flash_type = smem_get_item(SMEM_BOOT_FLASH_TYPE);
+	if (!flash_type) {
+		printf("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	if (*flash_type == SMEM_BOOT_SPI_FLASH) {
+		ret = ENVL_SPI_FLASH;
+	} else if (*flash_type == SMEM_BOOT_MMC_FLASH) {
+		ret = ENVL_MMC;
+	} else if ((*flash_type == SMEM_BOOT_QSPI_NAND_FLASH) ||
+		   (*flash_type == SMEM_BOOT_NAND_FLASH)) {
+		ret = ENVL_NAND;
+	} else {
+		ret = ENVL_NOWHERE;
+	}
+
+	return ret;
+}
+
+int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+{
+	int ret;
+	struct disk_partition disk_info;
+
+	ret = part_get_info_efi_by_name("0:APPSBLENV", &disk_info);
+
+	if (!ret)
+		*env_addr = (u32)disk_info.start * disk_info.blksz;
+
+	return ret;
+}
+
+__weak void board_cache_init(void)
+{
+	icache_enable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_enable();
+}
+
+void enable_caches(void)
+{
+	int i;
+	u8 bidx = 0;
+
+	/* Now Update the real DDR size based on Board configuration */
+	for (i = 0; IS_ENABLED(CONFIG_ARM64) &&
+	     (mem_map[i].size || mem_map[i].attrs); i++) {
+		if (mem_map[i].size == 0x0UL) {
+			if (!bidx)	/* For DDR bank 0 */
+				mem_map[i].size = gd->ram_top - mem_map[i].virt;
+			else	/* For remaining DDR banks */
+				mem_map[i].size = gd->bd->bi_dram[bidx].size;
+			bidx++;
+		}
+	}
+
+	board_cache_init();
+
+	if (!IS_ENABLED(CONFIG_MULTI_DTB_FIT_NO_COMPRESSION) && gd->new_fdt) {
+		memcpy(gd->new_fdt, gd->fdt_blob, fdt_totalsize(gd->fdt_blob));
+		flush_cache((ulong)gd->new_fdt,
+			    ALIGN(fdt_totalsize(gd->fdt_blob),
+				  ARCH_DMA_MINALIGN));
+		gd->fdt_blob = gd->new_fdt;
+	}
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
diff --git a/board/qualcomm/ipq9574/ipq9574.c b/board/qualcomm/ipq9574/ipq9574.c
new file mode 100644
index 0000000000..b3b85a864e
--- /dev/null
+++ b/board/qualcomm/ipq9574/ipq9574.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <cpu_func.h>
+#include <asm/cache.h>
+#include <configs/ipq9574.h>
+#include <asm/global_data.h>
+#include <jffs2/load_kernel.h>
+#include <mtd_node.h>
+#include <sysreset.h>
+#include <linux/psci.h>
+#include <asm/armv8/mmu.h>
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include "ipq9574.h"
+
+#define CMN_BLK_ADDR			0x0009B780
+#define FREQUENCY_MASK			0xfffffdf0
+#define INTERNAL_48MHZ_CLOCK		0x7
+#define PORT_WRAPPER_MAX		0xFF
+#define FIT_CONFIG_NAME_MAX_LEN		128
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void reset_cpu(void)
+{
+	psci_sys_reset(SYSRESET_COLD);
+}
+
+int print_cpuinfo(void)
+{
+	return 0;
+}
+
+void lowlevel_init(void)
+{
+}
+
+void ipq_uboot_fdt_fixup(uint32_t machid)
+{
+	int ret, len = 0, config_nos = 0;
+	char config[FIT_CONFIG_NAME_MAX_LEN];
+	char *config_list[6] = { NULL };
+
+	switch (machid) {
+	case MACH_TYPE_IPQ9574_DB_AL01_C2:
+		config_list[config_nos++] = "config@db-al01-c2";
+		config_list[config_nos++] = "config-db-al01-c2";
+		break;
+	case MACH_TYPE_IPQ9574_DB_AL02_C2:
+		config_list[config_nos++] = "config@db-al02-c2";
+		config_list[config_nos++] = "config-db-al02-c2";
+		break;
+	case MACH_TYPE_IPQ9574_RDP455_C11:
+		config_list[config_nos++] = "config@al02-c11";
+		config_list[config_nos++] = "config@rdp455-c11";
+		config_list[config_nos++] = "config-rdp455-c11";
+		break;
+	case MACH_TYPE_IPQ9574_RDP455_C12:
+		config_list[config_nos++] = "config@al02-c12";
+		config_list[config_nos++] = "config@rdp455-c12";
+		config_list[config_nos++] = "config-rdp455-c12";
+		break;
+	}
+
+	if (config_nos) {
+		while (config_nos--) {
+			strlcpy(&config[len], config_list[config_nos],
+				FIT_CONFIG_NAME_MAX_LEN - len);
+			len += strnlen(config_list[config_nos],
+				       FIT_CONFIG_NAME_MAX_LEN) + 1;
+			if (len > FIT_CONFIG_NAME_MAX_LEN) {
+				printf("skipping uboot fdt fixup err: config name len overflow\n");
+				return;
+			}
+		}
+
+		/* Open in place with a new length. */
+		ret = fdt_open_into(gd->fdt_blob, (void *)gd->fdt_blob,
+				    fdt_totalsize(gd->fdt_blob) + len);
+		if (ret)
+			printf("uboot-fdt-fixup: Cannot expand FDT: %s\n",
+			       fdt_strerror(ret));
+
+		ret = fdt_setprop((void *)gd->fdt_blob, 0, "config_name",
+				  config, len);
+		if (ret)
+			printf("uboot-fdt-fixup: unable to set config_name(%d)\n", ret);
+	}
+}
+
+void ipq_config_cmn_clock(void)
+{
+	unsigned int reg_val;
+	/*
+	 * Init CMN clock for ethernet
+	 */
+	reg_val = readl(CMN_BLK_ADDR + 4);
+	reg_val = (reg_val & FREQUENCY_MASK) | INTERNAL_48MHZ_CLOCK;
+	writel(reg_val, CMN_BLK_ADDR + 0x4);
+	reg_val = readl(CMN_BLK_ADDR);
+	reg_val = reg_val | 0x40;
+	writel(reg_val, CMN_BLK_ADDR);
+	mdelay(1);
+	reg_val = reg_val & (~0x40);
+	writel(reg_val, CMN_BLK_ADDR);
+	mdelay(1);
+	writel(0xbf, CMN_BLK_ADDR);
+	mdelay(1);
+	writel(0xff, CMN_BLK_ADDR);
+	mdelay(1);
+}
+
+int get_soc_hw_version(void)
+{
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(ARM64)
+/*
+ * Set XN (PTE_BLOCK_PXN | PTE_BLOCK_UXN)bit for all dram regions
+ * and Peripheral block except uboot code region
+ */
+static struct mm_region ipq9574_mem_map[] = {
+	{
+		/* Peripheral block */
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = CFG_SYS_SDRAM_BASE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+
+	}, {
+		/* DDR region upto u-boot CONFIG_TEXT_BASE */
+		.virt = CFG_SYS_SDRAM_BASE,
+		.phys = CFG_SYS_SDRAM_BASE,
+		.size = CONFIG_TEXT_BASE - CFG_SYS_SDRAM_BASE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DDR region U-boot text base */
+		.virt = CONFIG_TEXT_BASE,
+		.phys = CONFIG_TEXT_BASE,
+		.size = IPQ9574_UBOOT_TEXT_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/*
+		 * DDR region after u-boot text base
+		 * added dummy 0xBAD0FF5EUL,
+		 * will update the actual DDR limit
+		 */
+		.virt = CONFIG_TEXT_BASE + IPQ9574_UBOOT_TEXT_SIZE,
+		.phys = CONFIG_TEXT_BASE + IPQ9574_UBOOT_TEXT_SIZE,
+		.size = 0x0UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = ipq9574_mem_map;
+#endif
diff --git a/board/qualcomm/ipq9574/ipq9574.h b/board/qualcomm/ipq9574/ipq9574.h
new file mode 100644
index 0000000000..4e1a22eabb
--- /dev/null
+++ b/board/qualcomm/ipq9574/ipq9574.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IPQ9574_H_
+#define _IPQ9574_H_
+
+#include <configs/ipq9574.h>
+#include <asm/u-boot.h>
+#include <part.h>
+#include <blk.h>
+
+/* MACH IDs for various RDPs */
+#define MACH_TYPE_IPQ9574_RDP417		0x8050000
+#define MACH_TYPE_IPQ9574_RDP418		0x8050001
+#define MACH_TYPE_IPQ9574_RDP418_EMMC		0x8050101
+#define MACH_TYPE_IPQ9574_RDP437		0x8050201
+#define MACH_TYPE_IPQ9574_RDP433		0x8050301
+#define MACH_TYPE_IPQ9574_RDP449		0x8050501
+#define MACH_TYPE_IPQ9574_RDP433_MHT_PHY	0x8050601
+#define MACH_TYPE_IPQ9574_RDP453		0x8050701
+#define MACH_TYPE_IPQ9574_RDP454		0x8050801
+#define MACH_TYPE_IPQ9574_RDP433_MHT_SWT	0x8050901
+#define MACH_TYPE_IPQ9574_RDP467		0x8051301
+#define MACH_TYPE_IPQ9574_RDP455_C11		0x8050A01
+#define MACH_TYPE_IPQ9574_RDP455_C12		0x8050B01
+#define MACH_TYPE_IPQ9574_RDP459		0x8050C01
+#define MACH_TYPE_IPQ9574_RDP457		0x8050E01
+#define MACH_TYPE_IPQ9574_RDP456		0x8050F01
+#define MACH_TYPE_IPQ9574_RDP458		0x8050102
+#define MACH_TYPE_IPQ9574_RDP469		0x8051001
+#define MACH_TYPE_IPQ9574_RDP461		0x8051201
+#define MACH_TYPE_IPQ9574_RDP475		0x8050003
+#define MACH_TYPE_IPQ9574_RDP476		0x8050004
+#define MACH_TYPE_IPQ9574_DB_AL01_C1		0x1050000
+#define MACH_TYPE_IPQ9574_DB_AL01_C2		0x1050100
+#define MACH_TYPE_IPQ9574_DB_AL01_C3		0x1050200
+#define MACH_TYPE_IPQ9574_DB_AL02_C1		0x1050001
+#define MACH_TYPE_IPQ9574_DB_AL02_C2		0x1050101
+#define MACH_TYPE_IPQ9574_DB_AL02_C3		0x1050201
+
+/* Crashdump Magic registers & values */
+#define TCSR_BOOT_MISC_REG			((u32 *)0x193D100)
+
+#define DLOAD_MAGIC_COOKIE			0x10
+#define DLOAD_DISABLED				0x40
+#define DLOAD_ENABLE				BIT(4)
+#define DLOAD_DISABLE				(~BIT(4))
+#define CRASHDUMP_RESET				BIT(11)
+
+/* DT Fixup nodes */
+#define LINUX_5_4_NAND_DTS_NODE		"/soc/nand@79b0000/"
+#define LINUX_5_4_MMC_DTS_NODE		"/soc/sdhci@7804000/"
+#define LINUX_5_4_USB_DTS_NODE		"/soc/usb3@8A00000/dwc3@8A00000/"
+#define LINUX_5_4_USB_DR_MODE_FIXUP	"/soc/usb3@8A00000/dwc3@8A00000%dr_mode%?peripheral"
+#define LINUX_5_4_USB_MAX_SPEED_FIXUP	"/soc/usb3@8A00000/dwc3@8A00000%maximum-speed%?high-speed"
+
+#define LINUX_6_x_NAND_DTS_NODE		"/soc@0/nand@79b0000/"
+#define LINUX_6_x_MMC_DTS_NODE		"/soc@0/mmc@7804000/"
+#define LINUX_6_x_USB_DTS_NODE		"/soc@0/usb3@8a00000/usb@8a00000/"
+#define LINUX_6_x_USB_DR_MODE_FIXUP	"/soc@0/usb3@8a00000/usb@8a00000%dr_mode%?peripheral"
+#define LINUX_6_x_USB_MAX_SPEED_FIXUP	"/soc@0/usb3@8a00000/usb@8a00000%maximum-speed%?high-speed"
+
+#define LINUX_RSVD_MEM_DTS_NODE		"/reserved-memory/"
+#define STATUS_OK			"status%?okay"
+#define STATUS_DISABLED			"status%?disabled"
+
+#define IPQ_CONFIG_SMEM_VERSION_C	1
+
+int part_get_info_efi(struct blk_desc *dev_desc, int part,
+		      struct disk_partition *info);
+extern struct mm_region *mem_map;
+
+#endif /* _IPQ9574_H_ */
diff --git a/board/qualcomm/ipq9574/u-boot-x32.lds b/board/qualcomm/ipq9574/u-boot-x32.lds
new file mode 100644
index 0000000000..87552a144a
--- /dev/null
+++ b/board/qualcomm/ipq9574/u-boot-x32.lds
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2004-2008 Texas Instruments
+ *
+ * (C) Copyright 2002
+ * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
+ */
+
+#include <config.h>
+#include <asm/psci.h>
+
+OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+ENTRY(_start)
+SECTIONS
+{
+#ifndef CONFIG_CMDLINE
+	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
+#endif
+#if defined(CONFIG_ARMV7_SECURE_BASE) && defined(CONFIG_ARMV7_NONSEC)
+	/*
+	 * If CONFIG_ARMV7_SECURE_BASE is true, secure code will not
+	 * bundle with u-boot, and code offsets are fixed. Secure zone
+	 * only needs to be copied from the loading address to
+	 * CONFIG_ARMV7_SECURE_BASE, which is the linking and running
+	 * address for secure code.
+	 *
+	 * If CONFIG_ARMV7_SECURE_BASE is undefined, the secure zone will
+	 * be included in u-boot address space, and some absolute address
+	 * were used in secure code. The absolute addresses of the secure
+	 * code also needs to be relocated along with the accompanying u-boot
+	 * code.
+	 *
+	 * So DISCARD is only for CONFIG_ARMV7_SECURE_BASE.
+	 */
+	/DISCARD/ : { *(.rel._secure*) }
+#endif
+	. = 0x00000000;
+
+	. = ALIGN(4);
+	.text :
+	{
+		*(.__image_copy_start)
+		*(.vectors)
+		CPUDIR/start.o (.text*)
+	}
+
+	/* This needs to come before *(.text*) */
+	.__efi_runtime_start : {
+		*(.__efi_runtime_start)
+	}
+
+	.efi_runtime : {
+		*(.text.efi_runtime*)
+		*(.rodata.efi_runtime*)
+		*(.data.efi_runtime*)
+	}
+
+	.__efi_runtime_stop : {
+		*(.__efi_runtime_stop)
+	}
+
+	.text_rest :
+	{
+		*(.text*)
+	}
+
+#ifdef CONFIG_ARMV7_NONSEC
+
+	/* Align the secure section only if we're going to use it in situ */
+	.__secure_start
+#ifndef CONFIG_ARMV7_SECURE_BASE
+		ALIGN(CONSTANT(COMMONPAGESIZE))
+#endif
+	: {
+		KEEP(*(.__secure_start))
+	}
+
+#ifndef CONFIG_ARMV7_SECURE_BASE
+#define __ARMV7_SECURE_BASE
+#define __ARMV7_PSCI_STACK_IN_RAM
+#else
+#define __ARMV7_SECURE_BASE	CONFIG_ARMV7_SECURE_BASE
+#endif
+
+	.secure_text __ARMV7_SECURE_BASE :
+		AT(ADDR(.__secure_start) + SIZEOF(.__secure_start))
+	{
+		*(._secure.text)
+	}
+
+	.secure_data : AT(LOADADDR(.secure_text) + SIZEOF(.secure_text))
+	{
+		*(._secure.data)
+	}
+
+#ifdef CONFIG_ARMV7_PSCI
+	.secure_stack ALIGN(ADDR(.secure_data) + SIZEOF(.secure_data),
+			    CONSTANT(COMMONPAGESIZE)) (NOLOAD) :
+#ifdef __ARMV7_PSCI_STACK_IN_RAM
+		AT(ADDR(.secure_stack))
+#else
+		AT(LOADADDR(.secure_data) + SIZEOF(.secure_data))
+#endif
+	{
+		KEEP(*(.__secure_stack_start))
+
+		/* Skip addresses for stack */
+		. = . + CONFIG_ARMV7_PSCI_NR_CPUS * ARM_PSCI_STACK_SIZE;
+
+		/* Align end of stack section to page boundary */
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+
+		KEEP(*(.__secure_stack_end))
+
+#ifdef CONFIG_ARMV7_SECURE_MAX_SIZE
+		/*
+		 * We are not checking (__secure_end - __secure_start) here,
+		 * as these are the load addresses, and do not include the
+		 * stack section. Instead, use the end of the stack section
+		 * and the start of the text section.
+		 */
+		ASSERT((. - ADDR(.secure_text)) <= CONFIG_ARMV7_SECURE_MAX_SIZE,
+		       "Error: secure section exceeds secure memory size");
+#endif
+	}
+
+#ifndef __ARMV7_PSCI_STACK_IN_RAM
+	/* Reset VMA but don't allocate space if we have secure SRAM */
+	. = LOADADDR(.secure_stack);
+#endif
+
+#endif
+
+	.__secure_end : AT(ADDR(.__secure_end)) {
+		*(.__secure_end)
+		LONG(0x1d1071c);	/* Must output something to reset LMA */
+	}
+#endif
+
+	. = ALIGN(4);
+	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
+
+	. = ALIGN(4);
+	.data : {
+		*(.data*)
+	}
+
+	. = ALIGN(4);
+
+	. = .;
+
+	. = ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
+	}
+
+	. = ALIGN(4);
+
+	.efi_runtime_rel_start :
+	{
+		*(.__efi_runtime_rel_start)
+	}
+
+	.efi_runtime_rel : {
+		*(.rel*.efi_runtime)
+		*(.rel*.efi_runtime.*)
+	}
+
+	.efi_runtime_rel_stop :
+	{
+		*(.__efi_runtime_rel_stop)
+	}
+
+	. = ALIGN(4);
+
+	.image_copy_end :
+	{
+		*(.__image_copy_end)
+	}
+
+	.rel_dyn_start :
+	{
+		*(.__rel_dyn_start)
+	}
+
+	.rel.dyn : {
+		*(.rel*)
+	}
+
+	.rel_dyn_end :
+	{
+		*(.__rel_dyn_end)
+	}
+
+	_image_binary_end = .;
+
+	/*
+	 * Deprecated: this MMU section is used by pxa at present but
+	 * should not be used by new boards/CPUs.
+	 */
+	. = ALIGN(4096);
+	.mmutable : {
+		*(.mmutable)
+	}
+
+/*
+ * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
+ * __bss_base and __bss_limit are for linker only (overlay ordering)
+ */
+
+	.bss_start : {
+		KEEP(*(.__bss_start));
+		__bss_base = .;
+	}
+
+	.bss __bss_base (OVERLAY) : {
+		*(.bss*)
+		 . = ALIGN(4);
+		 __bss_limit = .;
+	}
+
+	.bss_end __bss_limit (OVERLAY) : {
+		KEEP(*(.__bss_end));
+	}
+
+	. = ALIGN(4096);
+	.end :
+	{
+		*(.__end)
+	}
+
+	.dtb : {
+		. = . + 0x1000;
+	}
+
+#ifdef NONCACHED_MEM_REGION_ADDR
+	. = NONCACHED_MEM_REGION_ADDR;
+	.noncached_mem : {
+		. = . + NONCACHED_MEM_REGION_SIZE;
+	}
+#endif
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu*) }
+}
diff --git a/board/qualcomm/ipq9574/u-boot-x64.lds b/board/qualcomm/ipq9574/u-boot-x64.lds
new file mode 100644
index 0000000000..e25f252498
--- /dev/null
+++ b/board/qualcomm/ipq9574/u-boot-x64.lds
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2013
+ * David Feng <fenghua@phytium.com.cn>
+ *
+ * (C) Copyright 2002
+ * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
+ */
+
+#include <config.h>
+#include <asm/psci.h>
+
+OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+OUTPUT_ARCH(aarch64)
+ENTRY(_start)
+SECTIONS
+{
+#ifdef CONFIG_ARMV8_SECURE_BASE
+	/DISCARD/ : { *(.rela._secure*) }
+#endif
+	. = 0x00000000;
+
+	. = ALIGN(8);
+	.text :
+	{
+		*(.__image_copy_start)
+		CPUDIR/start.o (.text*)
+	}
+
+	/* This needs to come before *(.text*) */
+	.efi_runtime : {
+                __efi_runtime_start = .;
+		*(.text.efi_runtime*)
+		*(.rodata.efi_runtime*)
+		*(.data.efi_runtime*)
+                __efi_runtime_stop = .;
+	}
+
+	.text_rest :
+	{
+		*(.text*)
+	}
+
+#ifdef CONFIG_ARMV8_PSCI
+	.__secure_start :
+#ifndef CONFIG_ARMV8_SECURE_BASE
+		ALIGN(CONSTANT(COMMONPAGESIZE))
+#endif
+	{
+		KEEP(*(.__secure_start))
+	}
+
+#ifndef CONFIG_ARMV8_SECURE_BASE
+#define __ARMV8_SECURE_BASE
+#define __ARMV8_PSCI_STACK_IN_RAM
+#else
+#define __ARMV8_SECURE_BASE	CONFIG_ARMV8_SECURE_BASE
+#endif
+	.secure_text __ARMV8_SECURE_BASE :
+		AT(ADDR(.__secure_start) + SIZEOF(.__secure_start))
+	{
+		*(._secure.text)
+		. = ALIGN(8);
+		__secure_svc_tbl_start = .;
+		KEEP(*(._secure_svc_tbl_entries))
+		__secure_svc_tbl_end = .;
+	}
+
+	.secure_data : AT(LOADADDR(.secure_text) + SIZEOF(.secure_text))
+	{
+		*(._secure.data)
+	}
+
+	.secure_stack ALIGN(ADDR(.secure_data) + SIZEOF(.secure_data),
+			    CONSTANT(COMMONPAGESIZE)) (NOLOAD) :
+#ifdef __ARMV8_PSCI_STACK_IN_RAM
+		AT(ADDR(.secure_stack))
+#else
+		AT(LOADADDR(.secure_data) + SIZEOF(.secure_data))
+#endif
+	{
+		KEEP(*(.__secure_stack_start))
+
+		. = . + CONFIG_ARMV8_PSCI_NR_CPUS * ARM_PSCI_STACK_SIZE;
+
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+
+		KEEP(*(.__secure_stack_end))
+	}
+
+#ifndef __ARMV8_PSCI_STACK_IN_RAM
+	. = LOADADDR(.secure_stack);
+#endif
+
+	.__secure_end : AT(ADDR(.__secure_end)) {
+		KEEP(*(.__secure_end))
+		LONG(0x1d1071c);	/* Must output something to reset LMA */
+	}
+#endif
+
+	. = ALIGN(8);
+	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
+
+	. = ALIGN(8);
+	.data : {
+		*(.data*)
+	}
+
+	. = ALIGN(8);
+
+	. = .;
+
+	. = ALIGN(8);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
+	}
+
+	. = ALIGN(8);
+
+	.efi_runtime_rel : {
+                __efi_runtime_rel_start = .;
+		*(.rel*.efi_runtime)
+		*(.rel*.efi_runtime.*)
+                __efi_runtime_rel_stop = .;
+	}
+
+	. = ALIGN(8);
+
+	.image_copy_end :
+	{
+		*(.__image_copy_end)
+	}
+
+	. = ALIGN(8);
+
+	.rel_dyn_start :
+	{
+		*(.__rel_dyn_start)
+	}
+
+	.rela.dyn : {
+		*(.rela*)
+	}
+
+	.rel_dyn_end :
+	{
+		*(.__rel_dyn_end)
+	}
+
+	. = ALIGN(8);
+
+	.bss_start : {
+		KEEP(*(.__bss_start));
+	}
+
+	.bss : {
+		*(.bss*)
+		 . = ALIGN(8);
+	}
+
+	.bss_end : {
+		KEEP(*(.__bss_end));
+	}
+
+	_end = .;
+
+	.dtb : {
+		. = . + 0x1000;
+	}
+
+#ifdef NONCACHED_MEM_REGION_ADDR
+	. = NONCACHED_MEM_REGION_ADDR;
+	.noncached_mem : {
+		. = . + NONCACHED_MEM_REGION_SIZE;
+	}
+#endif
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu*) }
+
+#ifdef CONFIG_LINUX_KERNEL_IMAGE_HEADER
+#include "linux-kernel-image-header-vars.h"
+#endif
+}
diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
new file mode 100644
index 0000000000..526c14767f
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -0,0 +1,1320 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for QTI IPQ9574
+ *
+ * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dm/device-internal.h>
+#include <mach/sysmap-ipq9574.h>
+#include <dt-bindings/clock/gcc-ipq9574.h>
+
+#include "clock-qcom.h"
+
+/*UNIPHY status register*/
+#define QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB     0xA4024
+
+#define UNIPHY_0_DISABLE_BIT                    23
+#define UNIPHY_1_DISABLE_BIT                    24
+#define UNIPHY_2_DISABLE_BIT                    25
+
+/* GPLL0 clock control registers */
+#define GPLL0_STATUS_ACTIVE BIT(31)
+
+static struct vote_clk gcc_blsp1_ahb_clk = {
+	.cbcr_reg = BLSP1_AHB_CBCR,
+	.ena_vote = APCS_CLOCK_BRANCH_ENA_VOTE,
+	.vote_bit = BIT(4) | BIT(2) | BIT(1),
+};
+
+static const struct bcr_regs sdc_regs = {
+	.cfg_rcgr = SDCC1_APPS_CFG_RCGR,
+	.cmd_rcgr = SDCC1_APPS_CMD_RCGR,
+	.M = SDCC1_APPS_M,
+	.N = SDCC1_APPS_N,
+	.D = SDCC1_APPS_D,
+};
+
+static const struct bcr_regs uart0_regs = {
+	.cfg_rcgr = BLSP1_UART_APPS_CFG_RCGR(0),
+	.cmd_rcgr = BLSP1_UART_APPS_CMD_RCGR(0),
+	.M = BLSP1_UART_APPS_M(0),
+	.N = BLSP1_UART_APPS_N(0),
+	.D = BLSP1_UART_APPS_D(0),
+};
+
+static const struct bcr_regs uart1_regs = {
+	.cfg_rcgr = BLSP1_UART_APPS_CFG_RCGR(1),
+	.cmd_rcgr = BLSP1_UART_APPS_CMD_RCGR(1),
+	.M = BLSP1_UART_APPS_M(1),
+	.N = BLSP1_UART_APPS_N(1),
+	.D = BLSP1_UART_APPS_D(1),
+};
+
+static const struct bcr_regs uart2_regs = {
+	.cfg_rcgr = BLSP1_UART_APPS_CFG_RCGR(2),
+	.cmd_rcgr = BLSP1_UART_APPS_CMD_RCGR(2),
+	.M = BLSP1_UART_APPS_M(2),
+	.N = BLSP1_UART_APPS_N(2),
+	.D = BLSP1_UART_APPS_D(2),
+};
+
+static const struct bcr_regs uart3_regs = {
+	.cfg_rcgr = BLSP1_UART_APPS_CFG_RCGR(3),
+	.cmd_rcgr = BLSP1_UART_APPS_CMD_RCGR(3),
+	.M = BLSP1_UART_APPS_M(3),
+	.N = BLSP1_UART_APPS_N(3),
+	.D = BLSP1_UART_APPS_D(3),
+};
+
+static const struct bcr_regs uart4_regs = {
+	.cfg_rcgr = BLSP1_UART_APPS_CFG_RCGR(4),
+	.cmd_rcgr = BLSP1_UART_APPS_CMD_RCGR(4),
+	.M = BLSP1_UART_APPS_M(4),
+	.N = BLSP1_UART_APPS_N(4),
+	.D = BLSP1_UART_APPS_D(4),
+};
+
+static const struct bcr_regs uart5_regs = {
+	.cfg_rcgr = BLSP1_UART_APPS_CFG_RCGR(5),
+	.cmd_rcgr = BLSP1_UART_APPS_CMD_RCGR(5),
+	.M = BLSP1_UART_APPS_M(5),
+	.N = BLSP1_UART_APPS_N(5),
+	.D = BLSP1_UART_APPS_D(5),
+};
+
+static const struct bcr_regs qup1_spi_regs = {
+	.cfg_rcgr = BLSP1_QUP_SPI_APPS_CFG_RCGR(0),
+	.cmd_rcgr = BLSP1_QUP_SPI_APPS_CMD_RCGR(0),
+	.M = BLSP1_QUP_SPI_APPS_M(0),
+	.N = BLSP1_QUP_SPI_APPS_N(0),
+	.D = BLSP1_QUP_SPI_APPS_D(0),
+};
+
+static const struct bcr_regs qup2_spi_regs = {
+	.cfg_rcgr = BLSP1_QUP_SPI_APPS_CFG_RCGR(1),
+	.cmd_rcgr = BLSP1_QUP_SPI_APPS_CMD_RCGR(1),
+	.M = BLSP1_QUP_SPI_APPS_M(1),
+	.N = BLSP1_QUP_SPI_APPS_N(1),
+	.D = BLSP1_QUP_SPI_APPS_D(1),
+};
+
+static const struct bcr_regs qup3_spi_regs = {
+	.cfg_rcgr = BLSP1_QUP_SPI_APPS_CFG_RCGR(2),
+	.cmd_rcgr = BLSP1_QUP_SPI_APPS_CMD_RCGR(2),
+	.M = BLSP1_QUP_SPI_APPS_M(2),
+	.N = BLSP1_QUP_SPI_APPS_N(2),
+	.D = BLSP1_QUP_SPI_APPS_D(2),
+};
+
+static const struct bcr_regs qup4_spi_regs = {
+	.cfg_rcgr = BLSP1_QUP_SPI_APPS_CFG_RCGR(3),
+	.cmd_rcgr = BLSP1_QUP_SPI_APPS_CMD_RCGR(3),
+	.M = BLSP1_QUP_SPI_APPS_M(3),
+	.N = BLSP1_QUP_SPI_APPS_N(3),
+	.D = BLSP1_QUP_SPI_APPS_D(3),
+};
+
+static const struct bcr_regs qup5_spi_regs = {
+	.cfg_rcgr = BLSP1_QUP_SPI_APPS_CFG_RCGR(4),
+	.cmd_rcgr = BLSP1_QUP_SPI_APPS_CMD_RCGR(4),
+	.M = BLSP1_QUP_SPI_APPS_M(4),
+	.N = BLSP1_QUP_SPI_APPS_N(4),
+	.D = BLSP1_QUP_SPI_APPS_D(4),
+};
+
+static const struct bcr_regs qup6_spi_regs = {
+	.cfg_rcgr = BLSP1_QUP_SPI_APPS_CFG_RCGR(5),
+	.cmd_rcgr = BLSP1_QUP_SPI_APPS_CMD_RCGR(5),
+	.M = BLSP1_QUP_SPI_APPS_M(5),
+	.N = BLSP1_QUP_SPI_APPS_N(5),
+	.D = BLSP1_QUP_SPI_APPS_D(5),
+};
+
+static const struct bcr_regs pci_aux_regs = {
+	.cfg_rcgr = GCC_PCIE_AUX_CFG_RCGR,
+	.cmd_rcgr = GCC_PCIE_AUX_CMD_RCGR,
+	.M = GCC_PCIE_AUX_M,
+	.N = GCC_PCIE_AUX_N,
+	.D = GCC_PCIE_AUX_D,
+};
+
+static const struct bcr_regs qup0_i2c_regs = {
+	.cfg_rcgr = BLSP1_QUP_I2C_APPS_CFG_RCGR(0),
+	.cmd_rcgr = BLSP1_QUP_I2C_APPS_CMD_RCGR(0),
+};
+
+static const struct bcr_regs qup1_i2c_regs = {
+	.cfg_rcgr = BLSP1_QUP_I2C_APPS_CFG_RCGR(1),
+	.cmd_rcgr = BLSP1_QUP_I2C_APPS_CMD_RCGR(1),
+};
+
+static const struct bcr_regs qup2_i2c_regs = {
+	.cfg_rcgr = BLSP1_QUP_I2C_APPS_CFG_RCGR(2),
+	.cmd_rcgr = BLSP1_QUP_I2C_APPS_CMD_RCGR(2),
+};
+
+static const struct bcr_regs qup3_i2c_regs = {
+	.cfg_rcgr = BLSP1_QUP_I2C_APPS_CFG_RCGR(3),
+	.cmd_rcgr = BLSP1_QUP_I2C_APPS_CMD_RCGR(3),
+};
+
+static const struct bcr_regs qup4_i2c_regs = {
+	.cfg_rcgr = BLSP1_QUP_I2C_APPS_CFG_RCGR(4),
+	.cmd_rcgr = BLSP1_QUP_I2C_APPS_CMD_RCGR(4),
+};
+
+static const struct bcr_regs qup5_i2c_regs = {
+	.cfg_rcgr = BLSP1_QUP_I2C_APPS_CFG_RCGR(5),
+	.cmd_rcgr = BLSP1_QUP_I2C_APPS_CMD_RCGR(5),
+};
+
+static const struct bcr_regs_v2 gcc_nssnoc_memnoc_bfdcd_regs = {
+	.cfg_rcgr = GCC_NSSNOC_MEMNOC_BFDCD_CFG_RCGR,
+	.cmd_rcgr = GCC_NSSNOC_MEMNOC_BFDCD_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 gcc_qdss_at_regs = {
+	.cfg_rcgr = GCC_QDSS_AT_CFG_RCGR,
+	.cmd_rcgr = GCC_QDSS_AT_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 gcc_uniphy_sys_regs = {
+	.cfg_rcgr = GCC_UNIPHY_SYS_CFG_RCGR,
+	.cmd_rcgr = GCC_UNIPHY_SYS_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 gcc_pcnoc_bfdcd_regs = {
+	.cfg_rcgr = GCC_PCNOC_BFDCD_CFG_RCGR,
+	.cmd_rcgr = GCC_PCNOC_BFDCD_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 gcc_system_noc_bfdcd_regs = {
+	.cfg_rcgr = GCC_SYSTEM_NOC_BFDCD_CFG_RCGR,
+	.cmd_rcgr = GCC_SYSTEM_NOC_BFDCD_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 nss_cc_cfg_regs = {
+	.cfg_rcgr = NSS_CC_CFG_CFG_RCGR,
+	.cmd_rcgr = NSS_CC_CFG_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 nss_cc_ppe_regs = {
+	.cfg_rcgr = NSS_CC_PPE_CFG_RCGR,
+	.cmd_rcgr = NSS_CC_PPE_CMD_RCGR,
+};
+
+static const struct bcr_regs_v2 gcc_qpic_io_macro_regs = {
+	.cfg_rcgr = GCC_QPIC_IO_MACRO_CFG_RCGR,
+	.cmd_rcgr = GCC_QPIC_IO_MACRO_CMD_RCGR,
+};
+
+static const struct bcr_regs gcc_pcie0_axi_m_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_M_CFG_RCGR(0),
+	.cmd_rcgr = GCC_PCIE_AXI_M_CMD_RCGR(0),
+};
+
+static const struct bcr_regs gcc_pcie1_axi_m_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_M_CFG_RCGR(1),
+	.cmd_rcgr = GCC_PCIE_AXI_M_CMD_RCGR(1),
+};
+
+static const struct bcr_regs gcc_pcie2_axi_m_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_M_CFG_RCGR(2),
+	.cmd_rcgr = GCC_PCIE_AXI_M_CMD_RCGR(2),
+};
+
+static const struct bcr_regs gcc_pcie3_axi_m_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_M_CFG_RCGR(3),
+	.cmd_rcgr = GCC_PCIE_AXI_M_CMD_RCGR(3),
+};
+
+static const struct bcr_regs gcc_pcie0_axi_s_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_S_CFG_RCGR(0),
+	.cmd_rcgr = GCC_PCIE_AXI_S_CMD_RCGR(0),
+};
+
+static const struct bcr_regs gcc_pcie1_axi_s_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_S_CFG_RCGR(1),
+	.cmd_rcgr = GCC_PCIE_AXI_S_CMD_RCGR(1),
+};
+
+static const struct bcr_regs gcc_pcie2_axi_s_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_S_CFG_RCGR(2),
+	.cmd_rcgr = GCC_PCIE_AXI_S_CMD_RCGR(2),
+};
+
+static const struct bcr_regs gcc_pcie3_axi_s_regs = {
+	.cfg_rcgr = GCC_PCIE_AXI_S_CFG_RCGR(3),
+	.cmd_rcgr = GCC_PCIE_AXI_S_CMD_RCGR(3),
+};
+
+static const struct bcr_regs gcc_pcie0_rchng_regs = {
+	.cfg_rcgr = GCC_PCIE_RCHNG_CFG_RCGR(0),
+	.cmd_rcgr = GCC_PCIE_RCHNG_CMD_RCGR(0),
+};
+
+static const struct bcr_regs gcc_pcie1_rchng_regs = {
+	.cfg_rcgr = GCC_PCIE_RCHNG_CFG_RCGR(1),
+	.cmd_rcgr = GCC_PCIE_RCHNG_CMD_RCGR(1),
+};
+
+static const struct bcr_regs gcc_pcie2_rchng_regs = {
+	.cfg_rcgr = GCC_PCIE_RCHNG_CFG_RCGR(2),
+	.cmd_rcgr = GCC_PCIE_RCHNG_CMD_RCGR(2),
+};
+
+static const struct bcr_regs gcc_pcie3_rchng_regs = {
+	.cfg_rcgr = GCC_PCIE_RCHNG_CFG_RCGR(3),
+	.cmd_rcgr = GCC_PCIE_RCHNG_CMD_RCGR(3),
+};
+
+static const struct bcr_regs_v2 nss_cc_port1_rx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_RX_CFG_RCGR(1),
+	.cmd_rcgr = NSS_CC_PORT_RX_CMD_RCGR(1),
+	.div_cdivr = NSS_CC_PORT_RX_DIV_CDIVR(1),
+};
+
+static const struct bcr_regs_v2 nss_cc_port1_tx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_TX_CFG_RCGR(1),
+	.cmd_rcgr = NSS_CC_PORT_TX_CMD_RCGR(1),
+	.div_cdivr = NSS_CC_PORT_TX_DIV_CDIVR(1),
+};
+
+static const struct bcr_regs_v2 nss_cc_port2_rx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_RX_CFG_RCGR(2),
+	.cmd_rcgr = NSS_CC_PORT_RX_CMD_RCGR(2),
+	.div_cdivr = NSS_CC_PORT_RX_DIV_CDIVR(2),
+};
+
+static const struct bcr_regs_v2 nss_cc_port2_tx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_TX_CFG_RCGR(2),
+	.cmd_rcgr = NSS_CC_PORT_TX_CMD_RCGR(2),
+	.div_cdivr = NSS_CC_PORT_TX_DIV_CDIVR(2),
+};
+
+static const struct bcr_regs_v2 nss_cc_port3_rx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_RX_CFG_RCGR(3),
+	.cmd_rcgr = NSS_CC_PORT_RX_CMD_RCGR(3),
+	.div_cdivr = NSS_CC_PORT_RX_DIV_CDIVR(3),
+};
+
+static const struct bcr_regs_v2 nss_cc_port3_tx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_TX_CFG_RCGR(3),
+	.cmd_rcgr = NSS_CC_PORT_TX_CMD_RCGR(3),
+	.div_cdivr = NSS_CC_PORT_TX_DIV_CDIVR(3),
+};
+
+static const struct bcr_regs_v2 nss_cc_port4_rx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_RX_CFG_RCGR(4),
+	.cmd_rcgr = NSS_CC_PORT_RX_CMD_RCGR(4),
+	.div_cdivr = NSS_CC_PORT_RX_DIV_CDIVR(4),
+};
+
+static const struct bcr_regs_v2 nss_cc_port4_tx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_TX_CFG_RCGR(4),
+	.cmd_rcgr = NSS_CC_PORT_TX_CMD_RCGR(4),
+	.div_cdivr = NSS_CC_PORT_TX_DIV_CDIVR(4),
+};
+
+static const struct bcr_regs_v2 nss_cc_port5_rx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_RX_CFG_RCGR(5),
+	.cmd_rcgr = NSS_CC_PORT_RX_CMD_RCGR(5),
+	.div_cdivr = NSS_CC_PORT_RX_DIV_CDIVR(5),
+};
+
+static const struct bcr_regs_v2 nss_cc_port5_tx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_TX_CFG_RCGR(5),
+	.cmd_rcgr = NSS_CC_PORT_TX_CMD_RCGR(5),
+	.div_cdivr = NSS_CC_PORT_TX_DIV_CDIVR(5),
+};
+
+static const struct bcr_regs_v2 nss_cc_port6_rx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_RX_CFG_RCGR(6),
+	.cmd_rcgr = NSS_CC_PORT_RX_CMD_RCGR(6),
+	.div_cdivr = NSS_CC_PORT_RX_DIV_CDIVR(6),
+};
+
+static const struct bcr_regs_v2 nss_cc_port6_tx_regs = {
+	.cfg_rcgr = NSS_CC_PORT_TX_CFG_RCGR(6),
+	.cmd_rcgr = NSS_CC_PORT_TX_CMD_RCGR(6),
+	.div_cdivr = NSS_CC_PORT_TX_DIV_CDIVR(6),
+};
+
+static const struct bcr_regs usb0_mock_utmi_regs = {
+	.cfg_rcgr = GCC_USB0_MOCK_UTMI_CFG_RCGR,
+	.cmd_rcgr = GCC_USB0_MOCK_UTMI_CMD_RCGR,
+	.M = GCC_USB0_MOCK_UTMI_M,
+	.N = GCC_USB0_MOCK_UTMI_N,
+	.D = GCC_USB0_MOCK_UTMI_D,
+};
+
+static const struct bcr_regs usb0_aux_regs = {
+	.cfg_rcgr = GCC_USB0_AUX_CFG_RCGR,
+	.cmd_rcgr = GCC_USB0_AUX_CMD_RCGR,
+	.M = GCC_USB0_AUX_M,
+	.N = GCC_USB0_AUX_N,
+	.D = GCC_USB0_AUX_D,
+};
+
+static const struct bcr_regs usb0_master_regs = {
+	.cfg_rcgr = GCC_USB0_MASTER_CFG_RCGR,
+	.cmd_rcgr = GCC_USB0_MASTER_CMD_RCGR,
+};
+
+static int calc_div_for_nss_port_clk(struct clk *clk, ulong rate,
+				     int *div, int *cdiv)
+{
+	int pclk_rate = clk_get_parent_rate(clk);
+
+	if (pclk_rate == CLK_125_MHZ) {
+		switch (rate) {
+		case CLK_2_5_MHZ:
+			*div = 9;
+			*cdiv = 9;
+			break;
+		case CLK_25_MHZ:
+			*div = 9;
+			break;
+		case CLK_125_MHZ:
+			*div = 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else if (pclk_rate == CLK_312_5_MHZ) {
+		switch (rate) {
+		case CLK_1_25_MHZ:
+			*div = 19;
+			*cdiv = 24;
+			break;
+		case CLK_12_5_MHZ:
+			*div = 9;
+			*cdiv = 4;
+			break;
+		case CLK_78_125_MHZ:
+			*div = 7;
+			break;
+		case CLK_125_MHZ:
+			*div = 4;
+			break;
+		case CLK_156_25_MHZ:
+			*div = 3;
+			break;
+		case CLK_312_5_MHZ:
+			*div = 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int msm_set_parent(struct clk *clk, struct clk *parent)
+{
+	assert(clk);
+	assert(parent);
+	clk->dev->parent = parent->dev;
+	dev_set_uclass_priv(parent->dev, parent);
+	return 0;
+}
+
+ulong msm_get_rate(struct clk *clk)
+{
+	switch (clk->id) {
+	case GCC_BLSP1_QUP0_I2C_APPS_CLK:
+	case GCC_BLSP1_QUP1_I2C_APPS_CLK:
+	case GCC_BLSP1_QUP2_I2C_APPS_CLK:
+	case GCC_BLSP1_QUP3_I2C_APPS_CLK:
+	case GCC_BLSP1_QUP4_I2C_APPS_CLK:
+	case GCC_BLSP1_QUP5_I2C_APPS_CLK:
+		clk->rate = CLK_50_MHZ;
+		break;
+	}
+
+	return (ulong)clk->rate;
+}
+
+ulong ipq9574_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	int ret = 0, src, div = 0, cdiv = 0;
+	struct clk *pclk = NULL;
+
+	switch (clk->id) {
+	case GCC_BLSP1_UART0_APPS_CLK:
+		/* UART: 115200 */
+		clk_rcg_set_rate_mnd(priv->base, &uart0_regs, 0, 36, 15625,
+				     SDCC1_SRC_SEL_GPLL0_OUT_MAIN, 16);
+		break;
+	case GCC_BLSP1_UART1_APPS_CLK:
+		/* UART: 115200 */
+		clk_rcg_set_rate_mnd(priv->base, &uart1_regs, 0, 36, 15625,
+				     SDCC1_SRC_SEL_GPLL0_OUT_MAIN, 16);
+		break;
+	case GCC_BLSP1_UART2_APPS_CLK:
+		/* UART: 115200 */
+		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 36, 15625,
+				     SDCC1_SRC_SEL_GPLL0_OUT_MAIN, 16);
+		break;
+	case GCC_BLSP1_UART3_APPS_CLK:
+		/* UART: 115200 */
+		clk_rcg_set_rate_mnd(priv->base, &uart3_regs, 0, 36, 15625,
+				     SDCC1_SRC_SEL_GPLL0_OUT_MAIN, 16);
+		break;
+	case GCC_BLSP1_UART4_APPS_CLK:
+		/* UART: 115200 */
+		clk_rcg_set_rate_mnd(priv->base, &uart4_regs, 0, 36, 15625,
+				     SDCC1_SRC_SEL_GPLL0_OUT_MAIN, 16);
+		break;
+	case GCC_BLSP1_UART5_APPS_CLK:
+		/* UART: 115200 */
+		clk_rcg_set_rate_mnd(priv->base, &uart5_regs, 0, 36, 15625,
+				     SDCC1_SRC_SEL_GPLL0_OUT_MAIN, 16);
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		/* SDCC1: 200MHz */
+		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 6, 0, 0,
+				     SDCC1_SRC_SEL_GPLL2_OUT_MAIN, 8);
+		break;
+	case GCC_BLSP1_QUP1_SPI_APPS_CLK:
+		/* QUP1 SPI APPS CLK: 50MHz */
+		clk_rcg_set_rate_mnd(priv->base, &qup1_spi_regs, 16, 0, 0,
+				     BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN, 8);
+		break;
+	case GCC_BLSP1_QUP2_SPI_APPS_CLK:
+		/* QUP2 SPI APPS CLK: 50MHz */
+		clk_rcg_set_rate_mnd(priv->base, &qup2_spi_regs, 16, 0, 0,
+				     BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN, 8);
+		break;
+	case GCC_BLSP1_QUP3_SPI_APPS_CLK:
+		/* QUP3 SPI APPS CLK: 50MHz */
+		clk_rcg_set_rate_mnd(priv->base, &qup3_spi_regs, 16, 0, 0,
+				     BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN, 8);
+		break;
+	case GCC_BLSP1_QUP4_SPI_APPS_CLK:
+		/* QUP4 SPI APPS CLK: 50MHz */
+		clk_rcg_set_rate_mnd(priv->base, &qup4_spi_regs, 16, 0, 0,
+				     BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN, 8);
+		break;
+	case GCC_BLSP1_QUP5_SPI_APPS_CLK:
+		/* QUP5 SPI APPS CLK: 50MHz */
+		clk_rcg_set_rate_mnd(priv->base, &qup5_spi_regs, 16, 0, 0,
+				     BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN, 8);
+		break;
+	case GCC_BLSP1_QUP6_SPI_APPS_CLK:
+		/* QUP6 SPI APPS CLK: 50MHz */
+		clk_rcg_set_rate_mnd(priv->base, &qup6_spi_regs, 16, 0, 0,
+				     BLSP1_QUP_SPI_SRC_SEL_GPLL0_OUT_MAIN, 8);
+		break;
+	case GCC_UNIPHY_SYS_CLK:
+		clk_rcg_set_rate_v2(priv->base, &gcc_uniphy_sys_regs, 1, 0, 0);
+		break;
+	case GCC_PCNOC_BFDCD_CLK:
+		clk_rcg_set_rate_v2(priv->base, &gcc_pcnoc_bfdcd_regs, 15, 0,
+				    GCC_PCNOC_BFDCD_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_SYSTEM_NOC_BFDCD_CLK:
+		clk_rcg_set_rate_v2(priv->base, &gcc_system_noc_bfdcd_regs, 6,
+				    0,
+				    GCC_SYSTEM_NOC_BFDCD_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_NSSNOC_MEMNOC_BFDCD_CLK:
+		clk_rcg_set_rate_v2(priv->base, &gcc_nssnoc_memnoc_bfdcd_regs,
+				    2, 0,
+				    GCC_NSSNOC_MEMNOC_BFDCD_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_QDSS_AT_CLK:
+		clk_rcg_set_rate_v2(priv->base, &gcc_qdss_at_regs, 9, 0,
+				    GCC_QDSS_AT_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_QPIC_IO_MACRO_CLK:
+		src = GCC_QPIC_IO_MACRO_SRC_SEL_GPLL0_OUT_MAIN;
+		cdiv = 0;
+		switch (rate) {
+		case IO_MACRO_CLK_24_MHZ:
+			src = GCC_QPIC_IO_MACRO_SRC_SEL_XO_CLK;
+			div = 0;
+			break;
+		case IO_MACRO_CLK_100_MHZ:
+			div = 15;
+			break;
+		case IO_MACRO_CLK_200_MHZ:
+			div = 7;
+			break;
+		case IO_MACRO_CLK_228_MHZ:
+			div = 6;
+			break;
+		case IO_MACRO_CLK_266_MHZ:
+			div = 5;
+			break;
+		case IO_MACRO_CLK_320_MHZ:
+			div = 4;
+			break;
+		default:
+			return -EINVAL;
+		}
+		clk_rcg_set_rate_v2(priv->base, &gcc_qpic_io_macro_regs,
+				    div, cdiv, src);
+		break;
+	case GCC_BLSP1_QUP0_I2C_APPS_CLK:
+		/* QUP0 I2C APPS CLK: 50MHz */
+		clk_rcg_set_rate(priv->base, &qup0_i2c_regs,
+				 BLSP1_QUP_I2C_50M_DIV_VAL,
+				 BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_BLSP1_QUP1_I2C_APPS_CLK:
+		/* QUP1 I2C APPS CLK: 50MHz */
+		clk_rcg_set_rate(priv->base, &qup1_i2c_regs,
+				 BLSP1_QUP_I2C_50M_DIV_VAL,
+				 BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_BLSP1_QUP2_I2C_APPS_CLK:
+		/* QUP2 I2C APPS CLK: 50MHz */
+		clk_rcg_set_rate(priv->base, &qup2_i2c_regs,
+				 BLSP1_QUP_I2C_50M_DIV_VAL,
+				 BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_BLSP1_QUP3_I2C_APPS_CLK:
+		/* QUP3 I2C APPS CLK: 50MHz */
+		clk_rcg_set_rate(priv->base, &qup3_i2c_regs,
+				 BLSP1_QUP_I2C_50M_DIV_VAL,
+				 BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_BLSP1_QUP4_I2C_APPS_CLK:
+		/* QUP4 I2C APPS CLK: 50MHz */
+		clk_rcg_set_rate(priv->base, &qup4_i2c_regs,
+				 BLSP1_QUP_I2C_50M_DIV_VAL,
+				 BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_BLSP1_QUP5_I2C_APPS_CLK:
+		/* QUP5 I2C APPS CLK: 50MHz */
+		clk_rcg_set_rate(priv->base, &qup5_i2c_regs,
+				 BLSP1_QUP_I2C_50M_DIV_VAL,
+				 BLSP1_QUP_I2C_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_PCIE_AUX_CLK:
+		/* PCIE AUX CLK: 20MHZ */
+		clk_rcg_set_rate_mnd(priv->base, &pci_aux_regs, 10, 1, 4,
+				     PCIE_SRC_SEL_UNSUSED_GND, 16);
+		break;
+	case GCC_PCIE0_AXI_M_CLK:
+		/* PCIE0_AXI_M_CLK: 240MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie0_axi_m_regs, 9,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE1_AXI_M_CLK:
+		/* PCIE1_AXI_M_CLK: 240MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie1_axi_m_regs, 9,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE2_AXI_M_CLK:
+		/* PCIE2_AXI_M_CLK: 342MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie2_axi_m_regs, 6,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE3_AXI_M_CLK:
+		/* PCIE3_AXI_M_CLK: 342MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie3_axi_m_regs, 6,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE0_AXI_S_CLK:
+		/* PCIE0_AXI_S_CLK: 240MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie0_axi_s_regs, 9,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE1_AXI_S_CLK:
+		/* PCIE1_AXI_S_CLK: 240MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie1_axi_s_regs, 9,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE2_AXI_S_CLK:
+		/* PCIE2_AXI_S_CLK: 240MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie2_axi_s_regs, 9,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE3_AXI_S_CLK:
+		/* PCIE3_AXI_S_CLK: 240MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie3_axi_s_regs, 9,
+				 PCIE_SRC_SEL_GPLL4_OUT_MAIN);
+		break;
+	case GCC_PCIE0_RCHNG_CLK:
+		/* PCIE0_RCHNG_CLK: 100MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie0_rchng_regs, 15,
+				 PCIE_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_PCIE1_RCHNG_CLK:
+		/* PCIE1_RCHNG_CLK: 100MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie1_rchng_regs, 15,
+				 PCIE_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_PCIE2_RCHNG_CLK:
+		/* PCIE2_RCHNG_CLK: 100MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie2_rchng_regs, 15,
+				 PCIE_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_PCIE3_RCHNG_CLK:
+		/* PCIE3_RCHNG_CLK: 100MHZ */
+		clk_rcg_set_rate(priv->base, &gcc_pcie3_rchng_regs, 15,
+				 PCIE_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_USB0_MASTER_CLK:
+		clk_rcg_set_rate(priv->base, &usb0_master_regs, 4,
+				 USB0_MASTER_SRC_SEL_GPLL0_OUT_MAIN);
+		break;
+	case GCC_USB0_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, &usb0_mock_utmi_regs, 0, 0, 0,
+				     USB0_MOCK_UTMI_SRC_SEL_XO, 8);
+		break;
+	case GCC_USB0_AUX_CLK:
+		clk_rcg_set_rate_mnd(priv->base, &usb0_aux_regs, 0, 0, 0,
+				     USB0_AUX_SRC_SEL_XO, 16);
+		break;
+
+		/*
+		 * NSS controlled clock
+		 */
+	case NSS_CC_CFG_CLK:
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_cfg_regs, 15, 0,
+				    NSS_CC_CFG_SRC_SEL_GCC_GPLL0_OUT_AUX);
+		break;
+	case NSS_CC_PPE_CLK:
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_ppe_regs, 1, 0,
+				    NSS_CC_PPE_SRC_SEL_BIAS_PLL_UBI_NC_CLK);
+		break;
+	case NSS_CC_PORT1_RX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port1_rx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK);
+		break;
+	case NSS_CC_PORT1_TX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port1_tx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK);
+		break;
+	case NSS_CC_PORT2_RX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port2_rx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK);
+		break;
+	case NSS_CC_PORT2_TX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port2_tx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK);
+		break;
+	case NSS_CC_PORT3_RX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port3_rx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK);
+		break;
+	case NSS_CC_PORT3_TX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port3_tx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK);
+		break;
+	case NSS_CC_PORT4_RX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port4_rx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK);
+		break;
+	case NSS_CC_PORT4_TX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port4_tx_regs, div,
+				    cdiv,
+				    NSS_CC_PORT1_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK);
+		break;
+	case NSS_CC_PORT5_RX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+
+		pclk = clk_get_parent(clk);
+		if (!pclk) {
+			ret = -ENODEV;
+			break;
+		}
+
+		if (pclk->id == UNIPHY0_NSS_RX_CLK) {
+			src = NSS_CC_PORT5_RX_SRC_SEL_UNIPHY0_NSS_RX_CLK;
+		} else if (pclk->id == UNIPHY1_NSS_RX_CLK) {
+			src = NSS_CC_PORT5_RX_SRC_SEL_UNIPHY1_NSS_RX_CLK;
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port5_rx_regs, div,
+				    cdiv, src);
+		break;
+	case NSS_CC_PORT5_TX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+
+		pclk = clk_get_parent(clk);
+		if (!pclk) {
+			ret = -ENODEV;
+			break;
+		}
+
+		if (pclk->id == UNIPHY0_NSS_TX_CLK) {
+			src = NSS_CC_PORT5_TX_SRC_SEL_UNIPHY0_NSS_TX_CLK;
+		} else if (pclk->id == UNIPHY1_NSS_TX_CLK) {
+			src = NSS_CC_PORT5_TX_SRC_SEL_UNIPHY1_NSS_TX_CLK;
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port5_tx_regs, div,
+				    cdiv, src);
+		break;
+	case NSS_CC_PORT6_RX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port6_rx_regs,
+				    div, cdiv,
+				    NSS_CC_PORT6_RX_SRC_SEL_UNIPHY2_NSS_RX_CLK);
+		break;
+	case NSS_CC_PORT6_TX_CLK:
+		ret = calc_div_for_nss_port_clk(clk, rate, &div, &cdiv);
+		if (ret < 0)
+			return ret;
+		clk_rcg_set_rate_v2(priv->base, &nss_cc_port6_tx_regs,
+				    div, cdiv,
+				    NSS_CC_PORT6_TX_SRC_SEL_UNIPHY2_NSS_TX_CLK);
+		break;
+
+	case UNIPHY0_NSS_RX_CLK:
+	case UNIPHY0_NSS_TX_CLK:
+	case UNIPHY1_NSS_RX_CLK:
+	case UNIPHY1_NSS_TX_CLK:
+	case UNIPHY2_NSS_RX_CLK:
+	case UNIPHY2_NSS_TX_CLK:
+		if (rate == CLK_125_MHZ)
+			clk->rate = CLK_125_MHZ;
+		else if (rate == CLK_312_5_MHZ)
+			clk->rate = CLK_312_5_MHZ;
+		else
+			ret = -EINVAL;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+int ipq9574_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_BLSP1_AHB_CLK:
+		clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
+		break;
+	case GCC_BLSP1_QUP1_SPI_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_SPI_APPS_CBCR(0));
+		break;
+	case GCC_BLSP1_QUP2_SPI_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_SPI_APPS_CBCR(1));
+		break;
+	case GCC_BLSP1_QUP3_SPI_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_SPI_APPS_CBCR(2));
+		break;
+	case GCC_BLSP1_QUP4_SPI_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_SPI_APPS_CBCR(3));
+		break;
+	case GCC_BLSP1_QUP5_SPI_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_SPI_APPS_CBCR(4));
+		break;
+	case GCC_BLSP1_QUP6_SPI_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_SPI_APPS_CBCR(5));
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_cbc(priv->base + SDCC1_APPS_CBCR);
+		break;
+	case GCC_MEM_NOC_NSSNOC_CLK:
+		clk_enable_cbc(priv->base + GCC_MEM_NOC_NSSNOC_CBCR);
+		break;
+	case GCC_NSSCFG_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSCFG_CBCR);
+		break;
+	case GCC_NSSNOC_ATB_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_ATB_CBCR);
+		break;
+	case GCC_NSSNOC_MEM_NOC_1_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_MEM_NOC_1_CBCR);
+		break;
+	case GCC_NSSNOC_MEMNOC_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_MEMNOC_CBCR);
+		break;
+	case GCC_NSSNOC_QOSGEN_REF_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_QOSGEN_REF_CBCR);
+		break;
+	case GCC_NSSNOC_TIMEOUT_REF_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_TIMEOUT_REF_CBCR);
+		break;
+	case GCC_CMN_12GPLL_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_CMN_12GPLL_AHB_CBCR);
+		break;
+	case GCC_CMN_12GPLL_SYS_CLK:
+		clk_enable_cbc(priv->base + GCC_CMN_12GPLL_SYS_CBCR);
+		break;
+	case GCC_UNIPHY0_SYS_CLK:
+		if (readl(QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB) &
+		    BIT(UNIPHY_0_DISABLE_BIT))
+			break;
+		clk_enable_cbc(priv->base + GCC_UNIPHY_SYS_CBCR(0));
+		break;
+	case GCC_UNIPHY0_AHB_CLK:
+		if (readl(QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB) &
+		    BIT(UNIPHY_0_DISABLE_BIT))
+			break;
+		clk_enable_cbc(priv->base + GCC_UNIPHY_AHB_CBCR(0));
+		break;
+	case GCC_UNIPHY1_SYS_CLK:
+		if (readl(QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB) &
+		    BIT(UNIPHY_1_DISABLE_BIT))
+			break;
+		clk_enable_cbc(priv->base + GCC_UNIPHY_SYS_CBCR(1));
+		break;
+	case GCC_UNIPHY1_AHB_CLK:
+		if (readl(QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB) &
+		    BIT(UNIPHY_1_DISABLE_BIT))
+			break;
+		clk_enable_cbc(priv->base + GCC_UNIPHY_AHB_CBCR(1));
+		break;
+	case GCC_UNIPHY2_SYS_CLK:
+		if (readl(QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB) &
+		    BIT(UNIPHY_2_DISABLE_BIT))
+			break;
+		clk_enable_cbc(priv->base + GCC_UNIPHY_SYS_CBCR(2));
+		break;
+	case GCC_UNIPHY2_AHB_CLK:
+		if (readl(QFPROM_CORR_FEATURE_CONFIG_ROW2_MSB) &
+		    BIT(UNIPHY_2_DISABLE_BIT))
+			break;
+		clk_enable_cbc(priv->base + GCC_UNIPHY_AHB_CBCR(2));
+		break;
+	case GCC_MDIO_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_MDIO_AHB_CBCR);
+		break;
+	case GCC_NSSNOC_SNOC_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_SNOC_CBCR);
+		break;
+	case GCC_NSSNOC_SNOC_1_CLK:
+		clk_enable_cbc(priv->base + GCC_NSSNOC_SNOC_1_CBCR);
+		break;
+	case GCC_MEM_NOC_SNOC_AXI_CLK:
+		clk_enable_cbc(priv->base + GCC_MEM_NOC_SNOC_AXI_CBCR);
+		break;
+	case GCC_QPIC_IO_MACRO_CLK:
+		clk_enable_cbc(priv->base + GCC_QPIC_IO_MACRO_CBCR);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		clk_enable_cbc(priv->base + SDCC1_AHB_CBCR);
+		break;
+	case GCC_BLSP1_QUP0_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_I2C_APPS_CBCR(0));
+		break;
+	case GCC_BLSP1_QUP1_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_I2C_APPS_CBCR(1));
+		break;
+	case GCC_BLSP1_QUP2_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_I2C_APPS_CBCR(2));
+		break;
+	case GCC_BLSP1_QUP3_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_I2C_APPS_CBCR(3));
+		break;
+	case GCC_BLSP1_QUP4_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_I2C_APPS_CBCR(4));
+		break;
+	case GCC_BLSP1_QUP5_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP_I2C_APPS_CBCR(5));
+		break;
+	case GCC_PCIE0_AUX_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AUX_CBCR(0));
+		break;
+	case GCC_PCIE1_AUX_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AUX_CBCR(1));
+		break;
+	case GCC_PCIE2_AUX_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AUX_CBCR(2));
+		break;
+	case GCC_PCIE3_AUX_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AUX_CBCR(3));
+		break;
+	case GCC_PCIE0_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AHB_CBCR(0));
+		break;
+	case GCC_PCIE1_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AHB_CBCR(1));
+		break;
+	case GCC_PCIE2_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AHB_CBCR(2));
+		break;
+	case GCC_PCIE3_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AHB_CBCR(3));
+		break;
+	case GCC_PCIE0_AXI_M_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_M_CBCR(0));
+		break;
+	case GCC_PCIE1_AXI_M_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_M_CBCR(1));
+		break;
+	case GCC_PCIE2_AXI_M_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_M_CBCR(2));
+		break;
+	case GCC_PCIE3_AXI_M_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_M_CBCR(3));
+		break;
+	case GCC_PCIE0_AXI_S_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_CBCR(0));
+		break;
+	case GCC_PCIE1_AXI_S_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_CBCR(1));
+		break;
+	case GCC_PCIE2_AXI_S_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_CBCR(2));
+		break;
+	case GCC_PCIE3_AXI_S_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_CBCR(3));
+		break;
+	case GCC_PCIE0_AXI_S_BRIDGE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_BRIDGE_CBCR(0));
+		break;
+	case GCC_PCIE1_AXI_S_BRIDGE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_BRIDGE_CBCR(1));
+		break;
+	case GCC_PCIE2_AXI_S_BRIDGE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_BRIDGE_CBCR(2));
+		break;
+	case GCC_PCIE3_AXI_S_BRIDGE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_AXI_S_BRIDGE_CBCR(3));
+		break;
+	case GCC_PCIE0_PIPE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_PIPE_CBCR(0));
+		break;
+	case GCC_PCIE1_PIPE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_PIPE_CBCR(1));
+		break;
+	case GCC_PCIE2_PIPE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_PIPE_CBCR(2));
+		break;
+	case GCC_PCIE3_PIPE_CLK:
+		clk_enable_cbc(priv->base + GCC_PCIE_PIPE_CBCR(3));
+		break;
+	case GCC_SNOC_PCIE0_1LANE_S_CLK:
+		clk_enable_cbc(priv->base + GCC_SNOC_PCIE0_1LANE_S_CBCR);
+		break;
+	case GCC_SNOC_PCIE1_1LANE_S_CLK:
+		clk_enable_cbc(priv->base + GCC_SNOC_PCIE1_1LANE_S_CBCR);
+		break;
+	case GCC_SNOC_PCIE2_2LANE_S_CLK:
+		clk_enable_cbc(priv->base + GCC_SNOC_PCIE2_2LANE_S_CBCR);
+		break;
+	case GCC_SNOC_PCIE3_2LANE_S_CLK:
+		clk_enable_cbc(priv->base + GCC_SNOC_PCIE3_2LANE_S_CBCR);
+		break;
+	case GCC_ANOC_PCIE0_1LANE_M_CLK:
+		clk_enable_cbc(priv->base + GCC_ANOC_PCIE0_1LANE_M_CBCR);
+		break;
+	case GCC_ANOC_PCIE1_1LANE_M_CLK:
+		clk_enable_cbc(priv->base + GCC_ANOC_PCIE1_1LANE_M_CBCR);
+		break;
+	case GCC_ANOC_PCIE2_2LANE_M_CLK:
+		clk_enable_cbc(priv->base + GCC_ANOC_PCIE2_2LANE_M_CBCR);
+		break;
+	case GCC_ANOC_PCIE3_2LANE_M_CLK:
+		clk_enable_cbc(priv->base + GCC_ANOC_PCIE3_2LANE_M_CBCR);
+		break;
+	case GCC_USB0_MASTER_CLK:
+		clk_enable_cbc(priv->base + GCC_USB0_MASTER_CBCR);
+		break;
+	case GCC_USB0_MOCK_UTMI_CLK:
+		clk_enable_cbc(priv->base + GCC_USB0_MOCK_UTMI_CBCR);
+		break;
+	case GCC_USB0_AUX_CLK:
+		clk_enable_cbc(priv->base + GCC_USB0_AUX_CBCR);
+		break;
+	case GCC_USB0_PIPE_CLK:
+		clk_enable_cbc(priv->base + GCC_USB0_PIPE_CBCR);
+		break;
+	case GCC_USB0_SLEEP_CLK:
+		clk_enable_cbc(priv->base + GCC_USB0_SLEEP_CBCR);
+		break;
+	case GCC_SNOC_USB_CLK:
+		clk_enable_cbc(priv->base + GCC_SNOC_USB_CBCR);
+		break;
+	case GCC_ANOC_USB_AXI_CLK:
+		clk_enable_cbc(priv->base + GCC_ANOC_USB_AXI_CBCR);
+		break;
+	case GCC_USB0_PHY_CFG_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_USB0_PHY_CFG_AHB_CBCR);
+		break;
+	case GCC_BLSP1_UART0_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_UART_APPS_CBCR(0));
+		break;
+	case GCC_BLSP1_UART1_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_UART_APPS_CBCR(1));
+		break;
+	case GCC_BLSP1_UART2_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_UART_APPS_CBCR(2));
+		break;
+	case GCC_BLSP1_UART3_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_UART_APPS_CBCR(3));
+		break;
+	case GCC_BLSP1_UART4_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_UART_APPS_CBCR(4));
+		break;
+	case GCC_BLSP1_UART5_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_UART_APPS_CBCR(5));
+		break;
+		/*
+		 * NSS controlled clock
+		 */
+	case NSS_CC_NSS_CSR_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_NSS_CSR_CBCR);
+		break;
+	case NSS_CC_NSSNOC_NSS_CSR_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_NSSNOC_NSS_CSR_CBCR);
+		break;
+	case NSS_CC_PORT1_MAC_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_MAC_CBCR(1));
+		break;
+	case NSS_CC_PORT2_MAC_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_MAC_CBCR(2));
+		break;
+	case NSS_CC_PORT3_MAC_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_MAC_CBCR(3));
+		break;
+	case NSS_CC_PORT4_MAC_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_MAC_CBCR(4));
+		break;
+	case NSS_CC_PORT5_MAC_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_MAC_CBCR(5));
+		break;
+	case NSS_CC_PORT6_MAC_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_MAC_CBCR(6));
+		break;
+	case NSS_CC_PPE_SWITCH_IPE_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PPE_SWITCH_IPE_CBCR);
+		break;
+	case NSS_CC_PPE_SWITCH_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PPE_SWITCH_CBCR);
+		break;
+	case NSS_CC_PPE_SWITCH_CFG_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PPE_SWITCH_CFG_CBCR);
+		break;
+	case NSS_CC_PPE_EDMA_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PPE_EDMA_CBCR);
+		break;
+	case NSS_CC_PPE_EDMA_CFG_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PPE_EDMA_CFG_CBCR);
+		break;
+	case NSS_CC_CRYPTO_PPE_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_CRYPTO_PPE_CBCR);
+		break;
+	case NSS_CC_NSSNOC_PPE_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_NSSNOC_PPE_CBCR);
+		break;
+	case NSS_CC_NSSNOC_PPE_CFG_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_NSSNOC_PPE_CFG_CBCR);
+		break;
+	case NSS_CC_PPE_SWITCH_BTQ_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PPE_SWITCH_BTQ_CBCR);
+		break;
+	case NSS_CC_PORT1_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_RX_CBCR(1));
+		break;
+	case NSS_CC_PORT1_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_TX_CBCR(1));
+		break;
+	case NSS_CC_PORT2_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_RX_CBCR(2));
+		break;
+	case NSS_CC_PORT2_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_TX_CBCR(2));
+		break;
+	case NSS_CC_PORT3_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_RX_CBCR(3));
+		break;
+	case NSS_CC_PORT3_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_TX_CBCR(3));
+		break;
+	case NSS_CC_PORT4_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_RX_CBCR(4));
+		break;
+	case NSS_CC_PORT4_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_TX_CBCR(4));
+		break;
+	case NSS_CC_PORT5_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_RX_CBCR(5));
+		break;
+	case NSS_CC_PORT5_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_TX_CBCR(5));
+		break;
+	case NSS_CC_PORT6_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_RX_CBCR(6));
+		break;
+	case NSS_CC_PORT6_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_PORT_TX_CBCR(6));
+		break;
+	case NSS_CC_UNIPHY_PORT1_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_RX_CBCR(1));
+		break;
+	case NSS_CC_UNIPHY_PORT1_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_TX_CBCR(1));
+		break;
+	case NSS_CC_UNIPHY_PORT2_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_RX_CBCR(2));
+		break;
+	case NSS_CC_UNIPHY_PORT2_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_TX_CBCR(2));
+		break;
+	case NSS_CC_UNIPHY_PORT3_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_RX_CBCR(3));
+		break;
+	case NSS_CC_UNIPHY_PORT3_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_TX_CBCR(3));
+		break;
+	case NSS_CC_UNIPHY_PORT4_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_RX_CBCR(4));
+		break;
+	case NSS_CC_UNIPHY_PORT4_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_TX_CBCR(4));
+		break;
+	case NSS_CC_UNIPHY_PORT5_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_RX_CBCR(5));
+		break;
+	case NSS_CC_UNIPHY_PORT5_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_TX_CBCR(5));
+		break;
+	case NSS_CC_UNIPHY_PORT6_RX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_RX_CBCR(6));
+		break;
+	case NSS_CC_UNIPHY_PORT6_TX_CLK:
+		clk_enable_cbc(priv->base + NSS_CC_UNIPHY_PORT_TX_CBCR(6));
+		break;
+
+	case UNIPHY0_NSS_RX_CLK:
+	case UNIPHY0_NSS_TX_CLK:
+	case UNIPHY1_NSS_RX_CLK:
+	case UNIPHY1_NSS_TX_CLK:
+	case UNIPHY2_NSS_RX_CLK:
+	case UNIPHY2_NSS_TX_CLK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#include <dt-bindings/reset/ipq9574-reset.h>
+static const struct qcom_reset_map ipq9574_gcc_resets[] = {
+	[GCC_SDCC1_BCR] = { 0x33000, 0 },
+	[GCC_UNIPHY0_SOFT_RESET] = { 0x17050, 0 },
+	[GCC_UNIPHY1_SOFT_RESET] = { 0x17060, 0 },
+	[GCC_UNIPHY2_SOFT_RESET] = { 0x17070, 0 },
+	[GCC_UNIPHY0_XPCS_RESET] = { 0x17050, 2 },
+	[GCC_UNIPHY1_XPCS_RESET] = { 0x17060, 2 },
+	[GCC_UNIPHY2_XPCS_RESET] = { 0x17070, 2 },
+	[NSS_CC_PPE_BTQ_RESET] = { 0x28A08, 20 },
+	[NSS_CC_PPE_IPE_RESET] = { 0x28A08, 19 },
+	[NSS_CC_PPE_RESET] = { 0x28A08, 18 },
+	[NSS_CC_PPE_CFG_RESET] = { 0x28A08, 17 },
+	[NSS_CC_PPE_EDMA_RESET] = { 0x28A08, 16 },
+	[NSS_CC_PPE_EDMA_CFG_RESET] = { 0x28A08, 15 },
+	[NSS_CC_PORT1_MAC_RESET] = { 0x28A08, 11 },
+	[NSS_CC_PORT2_MAC_RESET] = { 0x28A08, 10 },
+	[NSS_CC_PORT3_MAC_RESET] = { 0x28A08, 9 },
+	[NSS_CC_PORT4_MAC_RESET] = { 0x28A08, 8 },
+	[NSS_CC_PORT5_MAC_RESET] = { 0x28A08, 7 },
+	[NSS_CC_PORT6_MAC_RESET] = { 0x28A08, 6 },
+	[NSS_CC_UNIPHY_PORT1_RX_RESET] = { 0x28A24, 23 },
+	[NSS_CC_UNIPHY_PORT1_TX_RESET] = { 0x28A24, 22 },
+	[NSS_CC_UNIPHY_PORT2_RX_RESET] = { 0x28A24, 21 },
+	[NSS_CC_UNIPHY_PORT2_TX_RESET] = { 0x28A24, 20 },
+	[NSS_CC_UNIPHY_PORT3_RX_RESET] = { 0x28A24, 19 },
+	[NSS_CC_UNIPHY_PORT3_TX_RESET] = { 0x28A24, 18 },
+	[NSS_CC_UNIPHY_PORT4_RX_RESET] = { 0x28A24, 17 },
+	[NSS_CC_UNIPHY_PORT4_TX_RESET] = { 0x28A24, 16 },
+	[NSS_CC_UNIPHY_PORT5_RX_RESET] = { 0x28A24, 15 },
+	[NSS_CC_UNIPHY_PORT5_TX_RESET] = { 0x28A24, 14 },
+	[NSS_CC_UNIPHY_PORT6_RX_RESET] = { 0x28A24, 13 },
+	[NSS_CC_UNIPHY_PORT6_TX_RESET] = { 0x28A24, 12 },
+	[NSS_CC_PORT1_RX_RESET] = { 0x28A24, 11 },
+	[NSS_CC_PORT1_TX_RESET] = { 0x28A24, 10 },
+	[NSS_CC_PORT2_RX_RESET] = { 0x28A24, 9 },
+	[NSS_CC_PORT2_TX_RESET] = { 0x28A24, 8 },
+	[NSS_CC_PORT3_RX_RESET] = { 0x28A24, 7 },
+	[NSS_CC_PORT3_TX_RESET] = { 0x28A24, 6 },
+	[NSS_CC_PORT4_RX_RESET] = { 0x28A24, 5 },
+	[NSS_CC_PORT4_TX_RESET] = { 0x28A24, 4 },
+	[NSS_CC_PORT5_RX_RESET] = { 0x28A24, 3 },
+	[NSS_CC_PORT5_TX_RESET] = { 0x28A24, 2 },
+	[NSS_CC_PORT6_RX_RESET] = { 0x28A24, 1 },
+	[NSS_CC_PORT6_TX_RESET] = { 0x28A24, 0 },
+	[GCC_USB_BCR] = { 0x2C000, 0 },
+	[GCC_QUSB2_0_PHY_BCR] = { 0x2C068, 0 },
+	[GCC_USB0_PHY_BCR] = { 0x2C06C, 0 },
+	[GCC_USB3PHY_0_PHY_BCR] = { 0x2C070, 0 },
+};
+
+const struct msm_clk_data ipq9574_clk_gcc_data = {
+	.resets = ipq9574_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
+	.enable = ipq9574_clk_enable,
+	.set_rate = ipq9574_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9574_of_match[] = {
+	{
+		.compatible = "qti,gcc-ipq9574",
+		.data = (ulong)&ipq9574_clk_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(clock_ipq9574) = {
+	.name		= "gcc_ipq9574",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9574_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq9574.c b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
new file mode 100644
index 0000000000..75a48f96fc
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2019 Sartura Ltd.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#include <config.h>
+#include <stdio.h>
+#include <linux/types.h>
+#include <dm/device.h>
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+
+static char pin_name[MAX_PIN_NAME_LEN];
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"gpio", 0},
+	{"blsp0_uart0", 1},
+	{"blsp1_uart2", 2},
+	{"blsp0_spi", 1},
+	{"blsp1_i2c_scl", 2},
+	{"blsp1_i2c_sda", 2},
+	{"blsp2_i2c_scl", 2},
+	{"blsp2_i2c_sda", 2},
+	{"blsp3_i2c_scl", 2},
+	{"blsp3_i2c_sda", 2},
+	{"blsp4_i2c_scl", 2},
+	{"blsp4_i2c_sda", 2},
+	{"blsp5_i2c_scl", 1},
+	{"blsp5_i2c_sda", 1},
+	{"sdc", 1},
+	{"qspi", 2},
+	{"mdio", 1},
+	{"mdc", 1},
+};
+
+static const char *ipq9574_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq9574_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+	return pin_name;
+}
+
+static unsigned int ipq9574_get_function_mux(unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+struct msm_pinctrl_data ipq9574_data = {
+	.pin_data.pin_count = 64,
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq9574_get_function_name,
+	.get_function_mux = ipq9574_get_function_mux,
+	.get_pin_name = ipq9574_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qti,ipq9574-pinctrl", .data = (ulong)&ipq9574_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq9574) = {
+	.name		= "pinctrl_ipq9574",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
diff --git a/include/configs/ipq9574.h b/include/configs/ipq9574.h
new file mode 100644
index 0000000000..b914829d44
--- /dev/null
+++ b/include/configs/ipq9574.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/sizes.h>
+
+#ifndef __ASSEMBLY__
+#include <compiler.h>
+extern u32 g_board_machid;
+extern u32 g_load_addr;
+#endif
+
+/*
+ * Memory layout
+ *
+ * 4000_0000-->	 _____________________  DRAM Base
+ *		|		      |
+ *		|		      |
+ *		|		      |
+ * 4A00_0000--> |_____________________|
+ *		|                     |
+ *		|    STACK - 502KB    |
+ *		|_____________________|
+ *		|		      |
+ *		|      Global Data    |
+ *		|_____________________|
+ *		|		      |
+ *		|      Board Data     |
+ * 4A08_0000--> |_____________________|
+ *		|		      |
+ *		|    HEAP - 1792KB    |
+ *		|      (inc. ENV)     |
+ * 4A24_0000--> |_____________________|
+ *		|		      |
+ *		|    TEXT - 1792KB    |
+ * 4A40_0000--> |_____________________|
+ *		|		      |
+ *		| NONCACHED MEM - 1MB |
+ * 4A50_0000--> |_____________________|
+ *		|                     |
+ *		|                     |
+ * 8000_0000--> |_____________________| DRAM End
+ */
+
+/*
+ * This cannot come from header file. Have calculated this to be 0x4a077e60
+ * and added to configs/ipq9574_mmc_defconfig file
+ *
+ * #define CONFIG_CUSTOM_SYS_INIT_SP_ADDR	(CONFIG_TEXT_BASE -		\
+ *						 CONFIG_SYS_MALLOC_LEN -	\
+ *						 CONFIG_ENV_SIZE -		\
+ *						 0x8000 -			\
+ *						 GENERATED_GBL_DATA_SIZE)
+ */
+
+#define CFG_SYS_BAUDRATE_TABLE		{ 115200, 230400, 460800, 921600 }
+
+#define CFG_SYS_HZ_CLOCK		24000000
+#define CFG_SYS_SDRAM_BASE		0x40000000
+#define CFG_SYS_SDRAM_BASE_MAX_SZ	0xC0000000
+#define KERNEL_START_ADDR		CFG_SYS_SDRAM_BASE
+#define BOOT_PARAMS_ADDR		(CFG_SYS_SDRAM_BASE + 0x100)
+
+#define CFG_CUSTOM_LOAD_ADDR		(g_load_addr)
+
+#define PHY_ANEG_TIMEOUT		100
+#define FDT_HIGH			0x48500000
+
+#define IPQ9574_UBOOT_TEXT_SIZE		0x100000
+#define IPQ9574_UBOOT_END_ADDRESS	(CONFIG_TEXT_BASE + IPQ9574_UBOOT_TEXT_SIZE)
+#define IPQ9574_DDR_SIZE		(0x3UL * SZ_1G)
+#define IPQ9574_DDR_UPPER_SIZE_MAX	(IPQ9574_DDR_SIZE -		\
+					 (CFG_SYS_SDRAM_BASE -		\
+					  IPQ9574_UBOOT_END_ADDRESS))
+
+#define IPQ9574_DDR_LOWER_SIZE		(CONFIG_TEXT_BASE - CFG_SYS_SDRAM_BASE)
+#define ROOT_FS_PART_NAME		"rootfs"
+
+#define NONCACHED_MEM_REGION_ADDR	((IPQ9574_UBOOT_END_ADDRESS + \
+					  SZ_1M - 1) & ~(SZ_1M - 1))
+#define NONCACHED_MEM_REGION_SIZE	SZ_1M
+
+/*
+ * Refer above memory layout,
+ * Non-Cached Memory should not begin at above 0x4A400000 since upcoming
+ * memory regions are being used in the other boot components
+ */
+#if (NONCACHED_MEM_REGION_ADDR > 0x4A400000)
+#error "###: Text Segment overlaps with the Non-Cached Region"
+#endif
+
+#ifdef CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR
+/*
+ * CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR - memory used to decompress multi dtb
+ * NONCACHED_MEM_REGION_ADDR - Non-Cached memory region
+ * both uses same address space. So both should be same.
+ *
+ * Change in CONFIG_TEXT_BASE or CONFIG_TEXT_SIZE various affect this macro.
+ * So, according define the CONFIG_TEXT_BASE and CONFIG_TEXT_SIZE macros.
+ */
+#if (CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR != NONCACHED_MEM_REGION_ADDR)
+#error "###: CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR != NONCACHED_MEM_REGION_ADDR"
+#endif
+#endif
+
+#ifdef CONFIG_IPQ_SMP_CMD_SUPPORT
+#define CFG_NR_CPUS				4
+#endif
+
+#define CFG_EXTRA_ENV_SETTINGS			/* nothing */
diff --git a/include/dt-bindings/clock/gcc-ipq9574.h b/include/dt-bindings/clock/gcc-ipq9574.h
new file mode 100644
index 0000000000..66787c405a
--- /dev/null
+++ b/include/dt-bindings/clock/gcc-ipq9574.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_GCC_IPQ9574_H
+#define _DT_BINDINGS_CLK_GCC_IPQ9574_H
+
+/* GCC controlled clock IDs */
+#define GCC_BLSP1_UART0_APPS_CLK			0
+#define GCC_BLSP1_UART1_APPS_CLK			1
+#define GCC_BLSP1_UART2_APPS_CLK			2
+#define GCC_BLSP1_AHB_CLK				3
+#define GCC_SDCC1_APPS_CLK				4
+#define GCC_SDCC1_AHB_CLK				5
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK			6
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK			7
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK			8
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK			9
+#define GCC_BLSP1_QUP5_SPI_APPS_CLK			10
+#define GCC_BLSP1_QUP6_SPI_APPS_CLK			11
+#define GCC_NSSNOC_MEMNOC_BFDCD_CLK			12
+#define GCC_QDSS_AT_CLK					13
+#define GCC_MEM_NOC_NSSNOC_CLK				14
+#define GCC_NSSCFG_CLK					15
+#define GCC_NSSNOC_ATB_CLK				16
+#define GCC_NSSNOC_MEM_NOC_1_CLK			17
+#define GCC_NSSNOC_MEMNOC_CLK				18
+#define GCC_NSSNOC_QOSGEN_REF_CLK			19
+#define GCC_NSSNOC_TIMEOUT_REF_CLK			20
+#define GCC_UNIPHY_SYS_CLK				21
+#define GCC_PCNOC_BFDCD_CLK				22
+#define GCC_SYSTEM_NOC_BFDCD_CLK			23
+#define GCC_CMN_12GPLL_AHB_CLK				24
+#define GCC_CMN_12GPLL_SYS_CLK				25
+#define GCC_MDIO_AHB_CLK				26
+#define GCC_NSSNOC_SNOC_CLK				27
+#define GCC_NSSNOC_SNOC_1_CLK				28
+#define GCC_MEM_NOC_SNOC_AXI_CLK			29
+#define GCC_UNIPHY0_SYS_CLK				30
+#define GCC_UNIPHY0_AHB_CLK				31
+#define GCC_UNIPHY1_SYS_CLK				32
+#define GCC_UNIPHY1_AHB_CLK				33
+#define GCC_UNIPHY2_SYS_CLK				34
+#define GCC_UNIPHY2_AHB_CLK				35
+#define GCC_QPIC_IO_MACRO_CLK				36
+#define GCC_BLSP1_QUP0_I2C_APPS_CLK			37
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK			38
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK			39
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK			40
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK			41
+#define GCC_BLSP1_QUP5_I2C_APPS_CLK			42
+#define GCC_PCIE_AUX_CLK				43
+#define GCC_PCIE0_AXI_M_CLK				44
+#define GCC_PCIE0_AXI_S_CLK				45
+#define GCC_PCIE0_AHB_CLK				46
+#define GCC_PCIE0_AUX_CLK				47
+#define GCC_PCIE0_RCHNG_CLK				48
+#define GCC_PCIE1_AXI_M_CLK				49
+#define GCC_PCIE1_AXI_S_CLK				50
+#define GCC_PCIE1_AHB_CLK				51
+#define GCC_PCIE1_AUX_CLK				52
+#define GCC_PCIE1_RCHNG_CLK				53
+#define GCC_PCIE2_AXI_M_CLK				54
+#define GCC_PCIE2_AXI_S_CLK				55
+#define GCC_PCIE2_AHB_CLK				56
+#define GCC_PCIE2_AUX_CLK				57
+#define GCC_PCIE2_RCHNG_CLK				58
+#define GCC_PCIE3_AXI_M_CLK				59
+#define GCC_PCIE3_AXI_S_CLK				60
+#define GCC_PCIE3_AHB_CLK				61
+#define GCC_PCIE3_AUX_CLK				62
+#define GCC_PCIE3_RCHNG_CLK				63
+#define GCC_SNOC_PCIE0_1LANE_S_CLK			64
+#define GCC_SNOC_PCIE1_1LANE_S_CLK			65
+#define GCC_SNOC_PCIE2_2LANE_S_CLK			66
+#define GCC_SNOC_PCIE3_2LANE_S_CLK			67
+#define GCC_ANOC_PCIE0_1LANE_M_CLK			68
+#define GCC_ANOC_PCIE1_1LANE_M_CLK			69
+#define GCC_ANOC_PCIE2_2LANE_M_CLK			70
+#define GCC_ANOC_PCIE3_2LANE_M_CLK			71
+#define GCC_PCIE0_AXI_S_BRIDGE_CLK			72
+#define GCC_PCIE1_AXI_S_BRIDGE_CLK			73
+#define GCC_PCIE2_AXI_S_BRIDGE_CLK			74
+#define GCC_PCIE3_AXI_S_BRIDGE_CLK			75
+#define GCC_PCIE0_PIPE_CLK				76
+#define GCC_PCIE1_PIPE_CLK				77
+#define GCC_PCIE2_PIPE_CLK				78
+#define GCC_PCIE3_PIPE_CLK				79
+#define GCC_USB0_MASTER_CLK				80
+#define GCC_USB0_MOCK_UTMI_CLK				81
+#define GCC_USB0_AUX_CLK				82
+#define GCC_USB0_PIPE_CLK				83
+#define GCC_USB0_SLEEP_CLK				84
+#define GCC_SNOC_USB_CLK				85
+#define GCC_ANOC_USB_AXI_CLK				86
+#define GCC_USB0_PHY_CFG_AHB_CLK			87
+#define GCC_BLSP1_UART3_APPS_CLK			88
+#define GCC_BLSP1_UART4_APPS_CLK			89
+#define GCC_BLSP1_UART5_APPS_CLK			90
+
+/* NSS controlled clock IDs */
+#define NSS_CC_CFG_CLK					100
+#define NSS_CC_PPE_CLK					101
+#define NSS_CC_NSS_CSR_CLK				102
+#define NSS_CC_NSSNOC_NSS_CSR_CLK			103
+#define NSS_CC_PORT1_MAC_CLK				104
+#define NSS_CC_PORT2_MAC_CLK				105
+#define NSS_CC_PORT3_MAC_CLK				106
+#define NSS_CC_PORT4_MAC_CLK				107
+#define NSS_CC_PORT5_MAC_CLK				108
+#define NSS_CC_PORT6_MAC_CLK				109
+#define NSS_CC_PPE_SWITCH_IPE_CLK			110
+#define NSS_CC_PPE_SWITCH_CLK				111
+#define NSS_CC_PPE_SWITCH_CFG_CLK			112
+#define NSS_CC_PPE_EDMA_CLK				113
+#define NSS_CC_PPE_EDMA_CFG_CLK				114
+#define NSS_CC_CRYPTO_PPE_CLK				115
+#define NSS_CC_NSSNOC_PPE_CLK				116
+#define NSS_CC_NSSNOC_PPE_CFG_CLK			117
+#define NSS_CC_PPE_SWITCH_BTQ_CLK			118
+#define NSS_CC_PORT1_RX_CLK				119
+#define NSS_CC_PORT1_TX_CLK				120
+#define NSS_CC_PORT2_RX_CLK				121
+#define NSS_CC_PORT2_TX_CLK				122
+#define NSS_CC_PORT3_RX_CLK				123
+#define NSS_CC_PORT3_TX_CLK				124
+#define NSS_CC_PORT4_RX_CLK				125
+#define NSS_CC_PORT4_TX_CLK				126
+#define NSS_CC_PORT5_RX_CLK				127
+#define NSS_CC_PORT5_TX_CLK				128
+#define NSS_CC_PORT6_RX_CLK				129
+#define NSS_CC_PORT6_TX_CLK				130
+#define NSS_CC_UNIPHY_PORT1_RX_CLK			131
+#define NSS_CC_UNIPHY_PORT1_TX_CLK			132
+#define NSS_CC_UNIPHY_PORT2_RX_CLK			133
+#define NSS_CC_UNIPHY_PORT2_TX_CLK			134
+#define NSS_CC_UNIPHY_PORT3_RX_CLK			135
+#define NSS_CC_UNIPHY_PORT3_TX_CLK			136
+#define NSS_CC_UNIPHY_PORT4_RX_CLK			137
+#define NSS_CC_UNIPHY_PORT4_TX_CLK			138
+#define NSS_CC_UNIPHY_PORT5_RX_CLK			139
+#define NSS_CC_UNIPHY_PORT5_TX_CLK			140
+#define NSS_CC_UNIPHY_PORT6_RX_CLK			141
+#define NSS_CC_UNIPHY_PORT6_TX_CLK			142
+
+#define UNIPHY0_NSS_RX_CLK				200
+#define UNIPHY0_NSS_TX_CLK				201
+#define UNIPHY1_NSS_RX_CLK				202
+#define UNIPHY1_NSS_TX_CLK				203
+#define UNIPHY2_NSS_RX_CLK				204
+#define UNIPHY2_NSS_TX_CLK				205
+
+#endif
diff --git a/include/dt-bindings/net/qti-ipqsoc.h b/include/dt-bindings/net/qti-ipqsoc.h
new file mode 100644
index 0000000000..cd60534e3f
--- /dev/null
+++ b/include/dt-bindings/net/qti-ipqsoc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _DT_BINDINGS_QTI_IPQSOC_H
+#define _DT_BINDINGS_QTI_IPQSOC_H
+
+#define QCA8075_PHY_TYPE		0
+#define QCA8081_PHY_TYPE		1
+#define AQ_PHY_TYPE			2
+#define QCA8033_PHY_TYPE		3
+#define SFP_PHY_TYPE			4
+#define SFP10G_PHY_TYPE			5
+#define SFP2_5G_PHY_TYPE		6
+#define SFP1G_PHY_TYPE			7
+#define QCA8x8x_PHY_TYPE		8
+#define QCA8337_SWITCH_TYPE		9
+#define QCA8x8x_SWITCH_TYPE		10
+#define QCA8x8x_BYPASS_TYPE		11
+#define UNUSED_PHY_TYPE			0xFF
+
+#endif
diff --git a/include/dt-bindings/pinctrl/pinctrl-ipqsoc.h b/include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
new file mode 100644
index 0000000000..1a3557f1a8
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_IPQSOC_H
+#define _DT_BINDINGS_PINCTRL_IPQSOC_H
+
+/* GPIO Drive Strength */
+#define DRIVE_STRENGTH_2MA        0
+#define DRIVE_STRENGTH_4MA        1
+#define DRIVE_STRENGTH_6MA        2
+#define DRIVE_STRENGTH_8MA        3
+#define DRIVE_STRENGTH_10MA       4
+#define DRIVE_STRENGTH_12MA       5
+#define DRIVE_STRENGTH_14MA       6
+#define DRIVE_STRENGTH_16MA       7
+
+#endif
diff --git a/include/dt-bindings/reset/ipq9574-reset.h b/include/dt-bindings/reset/ipq9574-reset.h
new file mode 100644
index 0000000000..ee464b7807
--- /dev/null
+++ b/include/dt-bindings/reset/ipq9574-reset.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __IPQ9574_RESET_H__
+#define __IPQ9574_RESET_H__
+
+#define GCC_SDCC1_BCR					0
+#define GCC_UNIPHY0_SOFT_RESET				1
+#define GCC_UNIPHY1_SOFT_RESET				2
+#define GCC_UNIPHY2_SOFT_RESET				3
+#define GCC_UNIPHY0_XPCS_RESET				4
+#define GCC_UNIPHY1_XPCS_RESET				5
+#define GCC_UNIPHY2_XPCS_RESET				6
+#define NSS_CC_PPE_BTQ_RESET				7
+#define NSS_CC_PPE_IPE_RESET				8
+#define NSS_CC_PPE_RESET				9
+#define NSS_CC_PPE_CFG_RESET				10
+#define NSS_CC_PPE_EDMA_RESET				11
+#define NSS_CC_PPE_EDMA_CFG_RESET			12
+#define NSS_CC_UNIPHY_PORT1_RX_RESET			13
+#define NSS_CC_UNIPHY_PORT1_TX_RESET			14
+#define NSS_CC_UNIPHY_PORT2_RX_RESET			15
+#define NSS_CC_UNIPHY_PORT2_TX_RESET			16
+#define NSS_CC_UNIPHY_PORT3_RX_RESET			17
+#define NSS_CC_UNIPHY_PORT3_TX_RESET			18
+#define NSS_CC_UNIPHY_PORT4_RX_RESET			19
+#define NSS_CC_UNIPHY_PORT4_TX_RESET			20
+#define NSS_CC_UNIPHY_PORT5_RX_RESET			21
+#define NSS_CC_UNIPHY_PORT5_TX_RESET			22
+#define NSS_CC_UNIPHY_PORT6_RX_RESET			23
+#define NSS_CC_UNIPHY_PORT6_TX_RESET			24
+#define NSS_CC_PORT1_RX_RESET				25
+#define NSS_CC_PORT1_TX_RESET				26
+#define NSS_CC_PORT2_RX_RESET				27
+#define NSS_CC_PORT2_TX_RESET				28
+#define NSS_CC_PORT3_RX_RESET				29
+#define NSS_CC_PORT3_TX_RESET				30
+#define NSS_CC_PORT4_RX_RESET				31
+#define NSS_CC_PORT4_TX_RESET				32
+#define NSS_CC_PORT5_RX_RESET				33
+#define NSS_CC_PORT5_TX_RESET				34
+#define NSS_CC_PORT6_RX_RESET				35
+#define NSS_CC_PORT6_TX_RESET				36
+#define NSS_CC_PORT1_MAC_RESET				37
+#define NSS_CC_PORT2_MAC_RESET				38
+#define NSS_CC_PORT3_MAC_RESET				39
+#define NSS_CC_PORT4_MAC_RESET				40
+#define NSS_CC_PORT5_MAC_RESET				41
+#define NSS_CC_PORT6_MAC_RESET				42
+#define GCC_USB_BCR					43
+#define GCC_QUSB2_0_PHY_BCR				44
+#define GCC_USB0_PHY_BCR				45
+#define GCC_USB3PHY_0_PHY_BCR				46
+
+#endif
-- 
2.34.1

