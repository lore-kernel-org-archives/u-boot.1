Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651C8C282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCEAC817D3;
	Tue,  4 Mar 2025 12:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="OvF+sM7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E09C814BD; Tue,  4 Mar 2025 12:01:59 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93FA816AB
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524ABe1Q010333;
 Tue, 4 Mar 2025 11:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +UTSBcnw+91WTgizbKKFojk8ZX0FO6v6GE/LPUbDMVk=; b=OvF+sM7HPua3cBF7
 oOcsoypz2qDcVFifWNtWGNb3cK5BJqwF/1T+F9bEHsSiGo7JYzKh7SPEeeLjr223
 F1LWj07EUMsmtbVo2vDIWnKHHBpdWRoYODNzCglSvCg/ynX2Hid6WVSvY3OKWEMV
 ACatRDuEm5uRZ2p3NC5iZqbDw4w90qIdi9qogTN/RkC2ltMzp9gqe1TNydjCvtvT
 TAI9JylSB8GimJff1q/KmpKwPBr3GgTVkh6PVLRqhVT9LLOFv7TDJjq3HR2DErJN
 VSev+saoluqvdbP/TGWsGgnl5Y36eKC+nbdw+LCJVEezkW9c90+xv0+S2VWCTHlI
 4sATFw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6whknn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:01:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524B1fG6000942
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 4 Mar 2025 11:01:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:01:36 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>, <sjg@chromium.org>,
 <robert.marko@sartura.hr>, <dmitry.baryshkov@linaro.org>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 4/6] clk/qcom: add initial clock driver for ipq5424
Date: Tue, 4 Mar 2025 16:31:03 +0530
Message-ID: <20250304110105.2762124-5-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c6dd96 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=ttnG5VEth79ohM5wMFYA:9
 a=onGDOj6ykXjmeViK:21 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tGpJYb2TrUr4y6fL8UXIhLeZuIW2veYf
X-Proofpoint-ORIG-GUID: tGpJYb2TrUr4y6fL8UXIhLeZuIW2veYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
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

Add initial set of clocks and resets for enabling U-Boot on ipq5424
based RDP platforms.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5424.c | 96 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    |  1 +
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq5424.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c96..6c44a6549a 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ5424 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_IPQ9574
 	bool "Qualcomm IPQ9574 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e13fc8c107..3ce31dd167 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/clock-ipq5424.c
new file mode 100644
index 0000000000..40823a30ea
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5424.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm ipq5424
+ *
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq5424-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5424-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_IM_SLEEP_CBCR	0x1834020u
+
+static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_UART1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
+				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
+				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
+		return rate;
+	}
+	return 0;
+}
+
+static const struct gate_clk ipq5424_clks[] = {
+	GATE_CLK(GCC_QUPV3_UART1_CLK, 0x302c, BIT(0)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
+	GATE_CLK(GCC_IM_SLEEP_CLK, 0x34020, BIT(0)),
+};
+
+static int ipq5424_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id >= ARRAY_SIZE(ipq5424_clks) || !ipq5424_clks[clk->id].reg)
+		return -EINVAL;
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map ipq5424_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq5424_gcc_data = {
+	.resets = ipq5424_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq5424_gcc_resets),
+	.clks = ipq5424_clks,
+	.num_clks = ARRAY_SIZE(ipq5424_clks),
+
+	.enable = ipq5424_enable,
+	.set_rate = ipq5424_set_rate,
+};
+
+static const struct udevice_id gcc_ipq5424_of_match[] = {
+	{
+		.compatible = "qcom,ipq5424-gcc",
+		.data = (ulong)&ipq5424_gcc_data,
+	},
+	{ }
+};
+
+static int ipq5424_clk_probe(struct udevice *dev)
+{
+	/* Enable the sleep clock needed for the MMC block reset */
+	writel(BIT(0), GCC_IM_SLEEP_CBCR);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gcc_ipq5424) = {
+	.name		= "gcc_ipq5424",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq5424_of_match,
+	.probe		= ipq5424_clk_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index e038dc421e..2a01fb84a4 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -12,6 +12,7 @@
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2 (2 << 8)
+#define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
-- 
2.34.1

