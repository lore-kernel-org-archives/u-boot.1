Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568ADC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A42780977;
	Wed, 26 Feb 2025 07:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="af//5O5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4966D80FF0; Wed, 26 Feb 2025 07:45:54 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90C880FDD
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWiBk003230;
 Wed, 26 Feb 2025 06:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PsgeLolbNSNIiA+vQ8jxBoN0YCN5gw3kZ+ysMvd2jlg=; b=af//5O5bVO3nSb2i
 4+ptcqXq4EhUjly3scXZJLMWkBrpK69axe8aYvpCSvWgBU4lWID8j7YUqIVOZs/H
 CJrJ104QDT0EQ7Cge9/Yc0LFHWUcWfm9AnxoffDO75CrzMTcrZVRhLeML+HdMHcj
 Hrb/lP8fYsJeZ58ftxoOwQTrISIv9lpPr1FkQjitd6Zux1asLzejsYfmsEnW/4HE
 lxRK1MNOGYnx/zcrxApatmiu3jWf5Mf56tUwu8vw8zJiexuJPtNaCeRknkRGYt8U
 THTTosXdGH9S0Vc0zrWRXNpiY8L0aeATWtEAjfPHVEnzVM/Db3i5yhxFZE2ifqDz
 3rDE3Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prjh099-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6jbig009027
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:45:32 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v6 3/7] clk/qcom: add initial clock driver for ipq9574
Date: Wed, 26 Feb 2025 12:15:01 +0530
Message-ID: <20250226064505.1178054-4-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZIDQTHQ6ZcnJj4dHvL6nSI3j_LzI9BIr
X-Proofpoint-GUID: ZIDQTHQ6ZcnJj4dHvL6nSI3j_LzI9BIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Add initial set of clocks and resets for enabling U-Boot on ipq9574
based RDP platforms.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Use qcom_gate_clk_en(priv, clk->id) instead of switch case for
    each clock individually

v3: Use gate clk framework

v2: Combined driver file and makefile/kconfig changes into one patch
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq9574.c | 94 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    |  1 +
 4 files changed, 104 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index cb867acc48..3ea01f3c96 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1bc0f15005..e13fc8c107 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
new file mode 100644
index 0000000000..b0af403605
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm ipq9574
+ *
+ * (C) Copyright 2025 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_BLSP1_AHB_CBCR			0x1004
+#define GCC_BLSP1_UART3_APPS_CMD_RCGR		0x402C
+#define GCC_BLSP1_UART3_APPS_CBCR		0x4054
+
+#define GCC_SDCC1_APPS_CBCR			0x3302C
+#define GCC_SDCC1_AHB_CBCR			0x33034
+#define GCC_SDCC1_APPS_CMD_RCGR			0x33004
+#define GCC_SDCC1_ICE_CORE_CBCR			0x33030
+
+static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_BLSP1_UART3_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_BLSP1_UART3_APPS_CMD_RCGR,
+				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
+				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
+		return rate;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct gate_clk ipq9574_clks[] = {
+	GATE_CLK(GCC_BLSP1_UART3_APPS_CLK,	 0x4054, 0x00000001),
+	GATE_CLK(GCC_BLSP1_AHB_CLK,		 0x1004, 0x00000001),
+	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
+	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
+};
+
+static int ipq9574_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	debug("%s: clk %s\n", __func__, ipq9574_clks[clk->id].name);
+
+	if (!ipq9574_clks[clk->id].reg)
+		return -EINVAL;
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map ipq9574_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq9574_gcc_data = {
+	.resets = ipq9574_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
+	.enable = ipq9574_enable,
+	.set_rate = ipq9574_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9574_of_match[] = {
+	{
+		.compatible = "qcom,ipq9574-gcc",
+		.data = (ulong)&ipq9574_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq9574) = {
+	.name		= "gcc_ipq9574",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9574_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index ff336dea39..e038dc421e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -11,6 +11,7 @@
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
+#define CFG_CLK_SRC_GPLL2 (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
-- 
2.34.1

