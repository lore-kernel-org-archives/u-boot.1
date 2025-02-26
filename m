Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471E1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A20810F2;
	Wed, 26 Feb 2025 07:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="TJquUj/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87313810EB; Wed, 26 Feb 2025 07:46:02 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2212980FDD
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMXJXp015801;
 Wed, 26 Feb 2025 06:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wwz158HzJKOUOOO7eqfIgJYvxhSbuxcztMA3/PXAiCY=; b=TJquUj/mnncsdPkE
 dJhIBaYI9Kxqbd2gh2tFtoVhBmxfpT+4vlU1IqgKfaJUukrZERRtFsE4H38biuXU
 DZOrsRRIf0EV4pSyqKHmXn6aqcbM+leIHWebBZTIL5X/G0al8ROGIdWO+AT4KVwf
 4H5xsgRw7cauxUwctmq2YClX1AABjD6wh9KCvX0aP1eG8M7vZ3Blmk4v0pyWjgjn
 smVgrOo3oXuVtfoBJR+pgdrTLP1Qhbh5a6Z/c+LDOoVKLaTh6ieWNTE/41Jh7u7S
 zGmeWQiAIBtVq9Vr7tTvO0PFBRNqcCQidX8x9gOLaHLI6fe8hNqu2OMA7c0sPYc3
 EG/opg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnh0sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6jmo7009235
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:45:43 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v6 5/7] pinctrl: qcom: Add ipq9574 pinctrl driver
Date: Wed, 26 Feb 2025 12:15:03 +0530
Message-ID: <20250226064505.1178054-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226064505.1178054-1-quic_varada@quicinc.com>
References: <20250226064505.1178054-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: t2sxVLQItV9s52GfHbAGbLebh8hGR_Xx
X-Proofpoint-ORIG-GUID: t2sxVLQItV9s52GfHbAGbLebh8hGR_Xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260052
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

Add pinctrl driver for the TLMM block found in the ipq9574 SoC.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add 'Reviewed-by: Caleb Connolly'
    Remove 'special_pins_start' struct msm_pinctrl_data ipq9574_data
---
 drivers/pinctrl/qcom/Kconfig           |   7 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c | 226 +++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index d3eb699855..26ef59b938 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -27,6 +27,13 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 Pinctrl"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select PINCTRL_QCOM
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 06d3c95f93..0253687fab 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq9574.c b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
new file mode 100644
index 0000000000..ce09072ae3
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pinctrl driver for Qualcomm ipq9574
+ *
+ * (C) Copyright 2025 Linaro Ltd.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq9574_functions {
+	msm_mux_blsp0_spi,
+	msm_mux_blsp0_uart,
+	msm_mux_blsp1_i2c,
+	msm_mux_blsp1_spi,
+	msm_mux_blsp1_uart,
+	msm_mux_blsp2_i2c,
+	msm_mux_blsp2_spi,
+	msm_mux_blsp2_uart,
+	msm_mux_blsp3_i2c,
+	msm_mux_blsp3_spi,
+	msm_mux_blsp3_uart,
+	msm_mux_blsp4_i2c,
+	msm_mux_blsp4_spi,
+	msm_mux_blsp4_uart,
+	msm_mux_blsp5_i2c,
+	msm_mux_blsp5_uart,
+	msm_mux_gpio,
+	msm_mux_mdc,
+	msm_mux_mdio,
+	msm_mux_pcie0_clk,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk,
+	msm_mux_pcie1_wake,
+	msm_mux_pcie2_clk,
+	msm_mux_pcie2_wake,
+	msm_mux_pcie3_clk,
+	msm_mux_pcie3_wake,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_sdc_data,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_rclk,
+	msm_mux_NA,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(blsp0_spi),
+	MSM_PIN_FUNCTION(blsp0_uart),
+	MSM_PIN_FUNCTION(blsp1_i2c),
+	MSM_PIN_FUNCTION(blsp1_spi),
+	MSM_PIN_FUNCTION(blsp1_uart),
+	MSM_PIN_FUNCTION(blsp2_i2c),
+	MSM_PIN_FUNCTION(blsp2_spi),
+	MSM_PIN_FUNCTION(blsp2_uart),
+	MSM_PIN_FUNCTION(blsp3_i2c),
+	MSM_PIN_FUNCTION(blsp3_spi),
+	MSM_PIN_FUNCTION(blsp3_uart),
+	MSM_PIN_FUNCTION(blsp4_i2c),
+	MSM_PIN_FUNCTION(blsp4_spi),
+	MSM_PIN_FUNCTION(blsp4_uart),
+	MSM_PIN_FUNCTION(blsp5_i2c),
+	MSM_PIN_FUNCTION(blsp5_uart),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(mdc),
+	MSM_PIN_FUNCTION(mdio),
+	MSM_PIN_FUNCTION(pcie0_clk),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pcie2_clk),
+	MSM_PIN_FUNCTION(pcie2_wake),
+	MSM_PIN_FUNCTION(pcie3_clk),
+	MSM_PIN_FUNCTION(pcie3_wake),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_rclk),
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq9574_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(1, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(2, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(3, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(4, sdc_cmd, qspi_cs, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(5, sdc_clk, qspi_clk, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(6, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(7, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(8, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(9, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(10, sdc_rclk, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(11, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(12, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(13, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(14, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(15, blsp3_spi, blsp3_i2c, blsp3_uart, NA, NA, NA, NA, NA, NA),
+	PINGROUP(16, blsp3_spi, blsp3_i2c, blsp3_uart, NA, NA, NA, NA, NA, NA),
+	PINGROUP(17, blsp3_spi, blsp3_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(18, blsp3_spi, blsp3_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(19, blsp3_spi, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(20, blsp3_spi, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(21, blsp3_spi, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(22, pcie0_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(23, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(24, pcie0_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(25, pcie1_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(26, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(27, pcie1_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(28, pcie2_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(29, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(30, pcie2_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, pcie3_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(33, pcie3_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(34, blsp2_uart, blsp2_i2c, blsp2_spi, blsp1_uart, NA, NA, NA, NA, NA),
+	PINGROUP(35, blsp2_uart, blsp2_i2c, blsp2_spi, blsp1_uart, NA, NA, NA, NA, NA),
+	PINGROUP(36, blsp1_uart, blsp1_i2c, blsp2_spi, NA, NA, NA, NA, NA, NA),
+	PINGROUP(37, blsp1_uart, blsp1_i2c, blsp2_spi, NA, NA, NA, NA, NA, NA),
+	PINGROUP(38, mdc, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(39, mdio, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(40, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(41, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(42, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(43, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(44, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(45, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(46, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(47, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(48, blsp5_i2c, blsp5_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(49, blsp5_i2c, blsp5_uart, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(50, blsp4_uart, blsp4_i2c, blsp4_spi, NA, NA, NA, NA, NA, NA),
+	PINGROUP(51, blsp4_uart, blsp4_i2c, blsp4_spi, NA, NA, NA, NA, NA, NA),
+	PINGROUP(52, blsp4_uart, blsp4_spi, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(53, blsp4_uart, blsp4_spi, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(54, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(55, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(56, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(57, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(58, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(59, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(60, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(61, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(62, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(63, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(64, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
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
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq9574_get_function_mux(unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq9574_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	debug("Can't find requested function for pin:selector %u:%u\n",
+	      pin, selector);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq9574_data = {
+	.pin_data = {
+		.pin_count = 65,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq9574_get_function_name,
+	.get_function_mux = ipq9574_get_function_mux,
+	.get_pin_name = ipq9574_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq9574-tlmm", .data = (ulong)&ipq9574_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq9574) = {
+	.name		= "pinctrl_ipq9574",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

