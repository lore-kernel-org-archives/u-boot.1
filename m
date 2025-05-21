Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D10C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4F582E31;
	Wed, 21 May 2025 11:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k7hnI8vK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38AB82D59; Wed, 21 May 2025 11:45:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022A482E08
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XIpl024754
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yxg4qXNubyo
 1HYLSwYOIwEtjnL4SiObEgBhQ6j42pkQ=; b=k7hnI8vKhR/0/xzjzMWpq5JL3Uh
 AKt1CRNLEz2u8chx0MTDWt3b9mD09BtH8C8i4qryOdLC2hljT7DToF0bW30+7VgU
 9/B8hqaxovPMYjdAx3vYuDEZXU2tVQqYg+FupF1w1xxGXbbtL9B2QDRDlW5d30K1
 qdvNXmUqcN+vtcJSai2vjxQD9H/t9g0hJM1amQwSuFQZ0+T5Vg939n7vu7KHLtkZ
 i9CRrctGGzsvFCOPvTNsRfdGrLcwqtuD0NsCt3NiIolK3eXkZ6OX0ZjtnQGjmJ/V
 s8y/6Fu+qvcfvIUhtDmJAuND1Hn8S7+bREJdqo0YiGcRT5jpQS3a/pp6O+w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4tdbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-30ed6bd1b4cso4947010a91.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820706; x=1748425506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxg4qXNubyo1HYLSwYOIwEtjnL4SiObEgBhQ6j42pkQ=;
 b=d7jZUEffjjYAGg20xqtjYEUqVa7aeEUr9W3BzIO0mW96V3a4YLKf5mMiNoEtnJwzEg
 VmqRHCXU1Ha9pqCHZTUceXe10MDyIufUkWGC4BlUXRTy9c1vOsm2ZesD/J7ceSzFG2vv
 MsYkUSmXGoIUatFg5YAr+ePkpeNMCGy3T+psPZO60ee4nLZwfc/D177Br1Wt9RWcEJSJ
 FRjKjcPUb7qVJ2xdB/lGgzHX5crQzVbyEfMJEcPfJznpoMkZtIw7vHmBm/aILvm+1hcA
 fw9JWaC3w8b7qdbPFP7gv3U/P/UAC6pYy4CwHeU5pyUDlBLi9nqGZ1mmqH/KIVz5WnM8
 0OkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpdO8HHDBz4W02LgrrNHrr8daUmAvSYCgN0jGrsq/xh2zIkAQhNGNzqAoCfqTf5B3ZNwyKri8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1mEzvZHudXUnHxHWjp3KVq9NJfZzkulYf4WAQA/2KVQfssgA/
 CeEklX3578iNv8h+3ildwEm3OrRzDDioYz4udPsUoB0ssAYBgfy0lAb0zDXFxOsWrdI0gOFyDC3
 XxtPN2FJaNq9gwwZlv47SYBth5xqVWohjTWSvGZco7l7OwvM+2cBg2RNS
X-Gm-Gg: ASbGncu6kVOEwz1hV18JwGG4R/PCcYi0Mca/3VsPS58T7WXcSGuL4sH5sPDU8WWE05s
 jiFCnckxPOJMVKBqX1/6X8k3NwzW8jo8FrtTyyAgNYmi6EIwcOyfzvl5g0Kj8/Ptz1uAwqNNVz8
 yBOi0lis0KuT2yHl9qA8jxoTnyjVHeziXiw++tC57CR2WkvuCItBdN2rjnDwmY9VYJJxpJM6vIs
 nyBSmkK7XBcumylq5/h39YZkcW3CZqUfeTcH82xpDyz0UOAmYYjVjwG2LQ3dBkReAyyfs47C67j
 pE+cS6oa6qAlUnqFRK/AVIFYNHAnn1j3tXQ17dGmiy4sICSU7Z6a/KKf7mROQtw6cNQKbJvknKc
 cfMmEeES8afcgilhEDqcUFxnBPwSdY2Qc9z8rN4zS
X-Received: by 2002:a17:90b:5407:b0:309:f53c:b0a0 with SMTP id
 98e67ed59e1d1-30e83225857mr29144100a91.24.1747820705902; 
 Wed, 21 May 2025 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFMRbCXgAzl46zsVAgxcxCC6BRzG7w+ZiYv2mCJOPr1668XMbkLCUu9QuU5IEJ2F49coyaxg==
X-Received: by 2002:a17:90b:5407:b0:309:f53c:b0a0 with SMTP id
 98e67ed59e1d1-30e83225857mr29144062a91.24.1747820705397; 
 Wed, 21 May 2025 02:45:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:45:04 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
Date: Wed, 21 May 2025 15:14:39 +0530
Message-Id: <20250521094442.3522036-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gGrH2RSu01pr8PdTJXXcYbBpv-Nq63Lv
X-Proofpoint-ORIG-GUID: gGrH2RSu01pr8PdTJXXcYbBpv-Nq63Lv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfX9GqvrFcd/Ut/
 6ANZlUpnQUc7ZSZWV1fmidkT7pdLtqYtt2pKuNGzmHYZkJoLMotmsIYROL9I20UitRi0fZ2IEeX
 Xb3DNNiLgl3/WH4V1CNkzTldtB29c7LG2ChgJxBlmzh9eS7Ok54wRfwFXerswh2ZbUV9EbSbMhi
 jJ1sbdZqx8l+hPOJubFEtUPfYoKUkIy5kEquotczH9f1rxsAl4r48TKTLAr9DPpljEEMMO1ML7s
 o0UdzAgkenCXPGMENDnMz+B02Ga8xFrvhHhzBHQZYXSuOKd8MsIj2bjz6I02KHq/u7ePBa4f61s
 GdYYkz7naPwlnBqV7q6uEpQNWkMrORrG68rMjTwZLjTZPmZrBBaa1x7XvtLqkUN0M+zE70ivWuy
 GJqRfGITNbix2Ua/EdCZgLbMXfvLm3M3VTYKNATi3Inma2kKOhoUbeiQI/ueECtSxvcnsRfn
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682da0a3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=i6UvY8dM9ONR_HjL1zAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210096
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

* Port Linux's gcc-qcs8300.c driver to U-Boot for basic bring-up.

* Enable QCS8300 clocks in qcom_defconfig.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v3:
- Replaced 1s with BIT(0)s in the clock definitions

v2:
- Arranged the configs in Kconfig file in alphabetical order
- Took care of alphabetical order in Makefile
---
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-qcs8300.c | 146 +++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c969..0544556c672 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_QCS404
 	  on the Snapdragon QCS404 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_QCS8300
+	bool "Qualcomm QCS8300 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SA8775P
 	bool "Qualcomm SA8775 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e13fc8c1071..be2ec526cfe 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
new file mode 100644
index 00000000000..cd8aecdf788
--- /dev/null
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,qcs8300-gcc.h>
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+
+static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n",
+		      __func__, priv->data->clks[clk->id].name, rate);
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
+static const struct gate_clk qcs8300_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0)),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0)),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
+};
+
+static int qcs8300_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, qcs8300_clks[clk->id].name);
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
+static const struct qcom_reset_map qcs8300_gcc_resets[] = {
+	[GCC_EMAC0_BCR] = { 0xb6000 },
+	[GCC_PCIE_0_BCR] = { 0xa9000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0xbf000 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0xbf008 },
+	[GCC_PCIE_0_PHY_BCR] = { 0xa9144 },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0xbf00c },
+	[GCC_PCIE_1_BCR] = { 0x77000 },
+	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0xae084 },
+	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0xae090 },
+	[GCC_PCIE_1_PHY_BCR] = { 0xae08c },
+	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0xae094 },
+	[GCC_SDCC1_BCR] = { 0x20000 },
+	[GCC_UFS_PHY_BCR] = { 0x83000 },
+	[GCC_USB20_PRIM_BCR] = { 0x1c000 },
+	[GCC_USB2_PHY_PRIM_BCR] = { 0x5c01c },
+	[GCC_USB2_PHY_SEC_BCR] = { 0x5c020 },
+	[GCC_USB30_PRIM_BCR] = { 0x1b000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x5c008 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x5c000 },
+	[GCC_USB3_PHY_TERT_BCR] = { 0x5c024 },
+	[GCC_USB3_UNIPHY_MP0_BCR] = { 0x5c00c },
+	[GCC_USB3_UNIPHY_MP1_BCR] = { 0x5c010 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x5c004 },
+	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x5c014 },
+	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x5c018 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x76000 },
+	[GCC_VIDEO_BCR] = { 0x34000 },
+};
+
+static const struct qcom_power_map qcs8300_gdscs[] = {
+	[GCC_UFS_PHY_GDSC] = { 0x83004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
+};
+
+static struct msm_clk_data qcs8300_gcc_data = {
+	.resets = qcs8300_gcc_resets,
+	.num_resets = ARRAY_SIZE(qcs8300_gcc_resets),
+	.clks = qcs8300_clks,
+	.num_clks = ARRAY_SIZE(qcs8300_clks),
+
+	.power_domains = qcs8300_gdscs,
+	.num_power_domains = ARRAY_SIZE(qcs8300_gdscs),
+
+	.enable = qcs8300_enable,
+	.set_rate = qcs8300_set_rate,
+};
+
+static const struct udevice_id gcc_qcs8300_of_match[] = {
+	{
+		.compatible = "qcom,qcs8300-gcc",
+		.data = (ulong)&qcs8300_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_qcs8300) = {
+	.name		= "gcc_qcs8300",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_qcs8300_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

