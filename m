Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598E2E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 05:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF70C80658;
	Thu,  9 Jan 2025 06:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="d1v8QmqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA9C80655; Thu,  9 Jan 2025 06:26:37 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED26480613
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 06:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5090G0nd011176;
 Thu, 9 Jan 2025 05:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w/dalewYOhR7d/gPAWpEwdOTBLp7Sw8ivkn9v4pFOUA=; b=d1v8QmqD4FHoRkXm
 dUhXe8Vu3LM+3ak4dMnBn4xDY2oDmNi45GpyQgXtsfUD9i0fL57eYsIXUzO9eDTS
 I7OUdI6GrvJBFADzpwMxmXRLEOAuoEz/VKeaoEPi43CMZ5CcxtccjcEIV2+JtKed
 2HlAPznVReLUu9pSTBC58QjzqWrznQpoI4/WUbmBG+AYVsyFpSP2PSR0Kl/Nkol2
 AdyC2D+/kT9SwAevbHeMy+LIAndByB83m1MTc3n52JBBqfTLCrf1w2gA3RhUIb3H
 hp+WLLYiZlblJ/pPNit4J61nF0JpekVJj6fRqqMTN/mVRQSpykkkNwOn0wMs6Abu
 zRt7ng==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4423rqrk9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 05:26:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5095QJL0017708
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 9 Jan 2025 05:26:19 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 21:26:14 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <andersson@kernel.org>,
 <quic_tengfan@quicinc.com>, <konradybcio@kernel.org>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v2 3/6] clk/qcom: add initial clock driver for qcs9100
Date: Thu, 9 Jan 2025 10:55:42 +0530
Message-ID: <20250109052545.2921502-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109052545.2921502-1-quic_varada@quicinc.com>
References: <20250109052545.2921502-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: k3iQBn0e4Wok7MQaXIRdwE-XBB8frZnc
X-Proofpoint-ORIG-GUID: k3iQBn0e4Wok7MQaXIRdwE-XBB8frZnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090042
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

Add initial set of clocks and resets for enabling U-Boot on QCS9100
based Ride platforms.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add 'Reviewed-by: Neil Armstrong'
---
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-sa8775p.c | 142 +++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sa8775p.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d76fca5dba4..ad5797ab85e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -103,6 +103,14 @@ config CLK_QCOM_SC7280
 	  on the Snapdragon SC7280 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SA8775P
+        bool "Qualcomm SA8775 GCC"
+        select CLK_QCOM
+        help
+          Say Y here to enable support for the Global Clock Controller
+          on the Snapdragon SA8775 SoC. This driver supports the clocks
+          and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ab33f1c5faf..01b541af329 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
 obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
 obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
new file mode 100644
index 00000000000..e31f24ed4f0
--- /dev/null
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm sa8775p
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+
+static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return rate;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
+		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sa8775p_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
+};
+
+static int sa8775p_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, sa8775p_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sa8775p_gcc_resets[] = {
+	[GCC_CAMERA_BCR] = { 0x32000 },
+	[GCC_DISPLAY1_BCR] = { 0xC7000 },
+	[GCC_DISPLAY_BCR] = { 0x33000 },
+	[GCC_EMAC0_BCR] = { 0xB6000 },
+	[GCC_EMAC1_BCR] = { 0xB4000 },
+	[GCC_GPU_BCR] = { 0x7D000 },
+	[GCC_MMSS_BCR] = { 0x17000 },
+	[GCC_PCIE_0_BCR] = { 0xa9000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0xBF000 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0xBF008 },
+	[GCC_PCIE_0_PHY_BCR] = { 0xAD144 },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0xBF00C },
+	[GCC_PCIE_1_BCR] = { 0x77000 },
+	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0xAE084 },
+	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0xAE090 },
+	[GCC_PCIE_1_PHY_BCR] = { 0xAE08C },
+	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0xAE094 },
+	[GCC_PDM_BCR] = { 0x3F000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x23000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x24000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x2A000 },
+	[GCC_QUPV3_WRAPPER_3_BCR] = { 0xC4000 },
+	[GCC_SDCC1_BCR] = { 0x20000 },
+	[GCC_TSCSS_BCR] = { 0x21000 },
+	[GCC_UFS_CARD_BCR] = { 0x81000 },
+	[GCC_UFS_PHY_BCR] = { 0x83000 },
+};
+
+static const struct qcom_power_map sa8775p_gdscs[] = {
+	[UFS_PHY_GDSC] = { 0x83004 },
+	[USB30_PRIM_GDSC] = { 0x1B004 },
+};
+
+static struct msm_clk_data sa8775_gcc_data = {
+	.resets = sa8775p_gcc_resets,
+	.num_resets = ARRAY_SIZE(sa8775p_gcc_resets),
+	.clks = sa8775p_clks,
+	.num_clks = ARRAY_SIZE(sa8775p_clks),
+
+	.power_domains = sa8775p_gdscs,
+	.num_power_domains = ARRAY_SIZE(sa8775p_gdscs),
+
+	.enable = sa8775p_enable,
+	.set_rate = sa8775p_set_rate,
+};
+
+static const struct udevice_id gcc_sa8775p_of_match[] = {
+	{
+		.compatible = "qcom,sa8775p-gcc",
+		.data = (ulong)&sa8775_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sa8775p) = {
+	.name		= "gcc_sa8775p",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sa8775p_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

