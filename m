Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0716EC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 05:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0F081F69;
	Thu, 30 Jan 2025 06:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="p8JCgIQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7808E817C4; Thu, 30 Jan 2025 06:38:36 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1B880C65
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TMkpOc012401;
 Thu, 30 Jan 2025 05:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wJEKwmZPP78XLEoQaiiakDEblW5v0PinqAYSI5zwrSc=; b=p8JCgIQx9ZSPK/cu
 XoKR7zfXeqrv1FyHXs7dyxm+653XBFBuvXkAWUPsI22dJLX/7+nRW3ax+kBq+ZAe
 I+zud9EvJ+X3iOUs+ZCVd1VQOSDlE43v4tda1QJ5QcbvI5bs4WPsaW5MXf0npTvO
 NfA+xCs2ClSBuzF338f91BrxXSLNJGoRrx5T3iGczauRb0PofowobZ3+yrgUkdQ3
 AxnCi+H4ITl9jwfEEtBWHX8pol83zKLCYeSjXZUy3/EcL841oxikXlNfKwCape05
 gFmvYL75uJm6MC0rvi2bryJP74dXuGx2ac+Og/34X2d/7ORXiFaXCLeyMfW1KxSs
 pd7FKA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fwe28kp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 05:38:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U5cMCx010477
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 05:38:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 21:38:17 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <pbrobinson@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <robert.marko@sartura.hr>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v2 2/6] clk/qcom: add initial clock driver for ipq9574
Date: Thu, 30 Jan 2025 11:07:47 +0530
Message-ID: <20250130053751.3148614-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130053751.3148614-1-quic_varada@quicinc.com>
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: YMuzGDkRKjVQM_DOYhhfz8Rnt9dpgX4R
X-Proofpoint-GUID: YMuzGDkRKjVQM_DOYhhfz8Rnt9dpgX4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300041
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

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Combined driver file and makefile/kconfig changes into one patch
---
 drivers/clk/qcom/Kconfig         |   8 +++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-ipq9574.c | 100 +++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    |   1 +
 4 files changed, 110 insertions(+)
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
index 0000000000..06f2d2dd45
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm ipq9574
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
+static int ipq9574_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	//printk("--> %s: %d\n", __func__, clk->id);
+	switch (clk->id) {
+	case GCC_BLSP1_UART3_APPS_CLK:
+		clk_enable_cbc(priv->base + GCC_BLSP1_UART3_APPS_CBCR);
+		break;
+	case GCC_BLSP1_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_BLSP1_AHB_CBCR);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		clk_enable_cbc(priv->base + GCC_SDCC1_AHB_CBCR);
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_cbc(priv->base + GCC_SDCC1_APPS_CBCR);
+		break;
+	case GCC_SDCC1_ICE_CORE_CLK:
+		clk_enable_cbc(priv->base + GCC_SDCC1_ICE_CORE_CBCR);
+		break;
+	default:
+		return -EINVAL;
+	}
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

