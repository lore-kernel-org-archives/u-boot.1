Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F23C5AD49
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27A682BD6;
	Sat, 31 May 2025 05:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzTKDzuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 826D682C65; Sat, 31 May 2025 05:20:35 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C722982B6B
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UKr1IK008059
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=m0WjP0g3Icw
 yAD+MzLFZw/hRqe9e3LmIwGjVeLZumYc=; b=JzTKDzuWVVUEHR+dq65BdUWmH5J
 sOKx8lzlOOop1NJ9D76mYrRPAhgMUX3ZOvuVH5K1FnVZqx40CVkVX235TIpWwzsk
 8GKdupfsjiM7KUhLlBtK0du0rJCyYpRu/GrceC8vqBUrBXuI8JHnTtyrTGbHDuEg
 y2r1etQ1rIxJQNkOzl3OBnHkmdvOdco32pfdWiPYGMLFtKmd299Qvz3DGjjsblLj
 tLMiLxtWvnbxFxP67JyDAsMI7PaCMCgbACV3hoT8Gi7WTHgUuUmo2vGDRZifegPm
 gqOGIdyPxPe2MqyZm1gwnmoeW3+3zfFVXzxiWy4EQohTys1o0yybYb7mr0w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whufbeqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-747a9ef52a4so3771118b3a.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661630; x=1749266430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0WjP0g3IcwyAD+MzLFZw/hRqe9e3LmIwGjVeLZumYc=;
 b=u+HXsz3J4svqMUX3kCrBmk5RRJQa5lUK1eecgvediSyk/lhoYGgAOiEzkbuXXWT1GU
 MUTYBIkJdA2zuCYielfTs6qX8s73s2batnfHsSBMH2jXSF2CHchjygGiDyCwBN8zXudw
 XPT7gwK9MBlwxymJmWoVt0t0dLW3AEdScVYVzhKtA8qFaH6ah0lgCL2TGjUkqa8L+/cv
 wTyzvmrA4YZG3Exgsw7UTFp1mlVjBEJnOWTMuHxYRISbyT+cW0aklBWnc+tM41jg3Giw
 fJ/dMRfr5piatRWXVulbvQLFDmZv7tS8BEihh/C99i4bA6Sv80A3l5Q5MEOENqOw7UCQ
 heOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0lI9bnU0b/Owu7lfg1gdFhCi7/w3VwHb1JyYO1fQ85ek1bXJA1dBRyQupYG8ZeqB5xQ4y61s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/QwjODGLpabUtaLtIXLeXR4ER5O+ZhHiWA+vp/43UAUH/5sYg
 G/nK92FHkwb3mpBJ2QbAEWfIOYQAHCLkvUXChtp/2lRmb96ywhou6q4CTMG0sss2gunM8WlZEDI
 MS5KFW82hV5UTm+0Y+WA8sXSQsOCIQcjPHHq+Y0vXxkjX6xMWtUongQz6
X-Gm-Gg: ASbGncsKZbXkM/o+4rYabf6OIzd6wP0+4ieuyfI17i1bf6CZ/Y35CpPDknTSJV891R4
 qgK8yImu97meKdDwkwZys20QQeD+h7DegjP2ByZ80DdN9rSbIiyqjFqrj4/ykREI5GUtHOt9dYC
 yetCLLLlOI309XHfvvKwr/vz6kYfTFh+7+ZegrbSKsIcBuGdGJBmUDyr0jvyM8XHRSPfHVkOJ6d
 sB9zb/M0dZ3Rm8CY7pgnEkYk5AIhcg9wBIY0D8rh2TdxfUdrEoWJ0IQg60pSRjjYxoXnVori2vh
 HLXS880iWaGWwMYsouS8YLeeZmOoft+wX9V8Ik91SYhFZPGl1KIhfc062tBmY/KiS8c6f+rc9rG
 12metvacBt63yXLfQ3YvigWu8RPBtptI0bIekFEcVxwCoPRMyLRE=
X-Received: by 2002:a05:6a00:138e:b0:740:a879:4f7b with SMTP id
 d2e1a72fcca58-747c1c2f096mr6356119b3a.18.1748661629957; 
 Fri, 30 May 2025 20:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqIiQbfGc+mwzZTOQI3489iYgbsx4wBArcH/yvul8i9VtQxIE4oU05S7EVX6qhJ3VJIm7flA==
X-Received: by 2002:a05:6a00:138e:b0:740:a879:4f7b with SMTP id
 d2e1a72fcca58-747c1c2f096mr6356098b3a.18.1748661629553; 
 Fri, 30 May 2025 20:20:29 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:28 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
Date: Sat, 31 May 2025 08:50:05 +0530
Message-Id: <20250531032008.3083716-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=683a757e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=i6UvY8dM9ONR_HjL1zAA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2PcstxJx2gp4Mz2TGyL730EiIXgTZHDX
X-Proofpoint-GUID: 2PcstxJx2gp4Mz2TGyL730EiIXgTZHDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfX6rqKZE7PVtUN
 dKF11w9yNQ4uVIzV0dqsGYCVUqXjtmhWZ3NUf3ET1ZOL117jcePDpa62GK9C99NwORx61CA2xan
 x7IEC2clFlotGHEhE+dFgYMzYyEEUUl6YY31YFceLbt66JIOMKFO+X6NPZh2nRhMJMhZKwtSgi+
 1fta+3YuIVyOzbER8SpkkegQOUYZWI/WttZC/jUKc5SEjHdCqcWBxNo5JIKkfSY6RoObSHhphYX
 5U7/lvCoVB/MHdqKC1wM+DkYqHzLtcVs8sYunueqYI6HJYZOXDyPB7W8Z5NL4QFzIyKElCL0IbO
 ZEDwKC18tGHic78gYOYC17HW0MEBrgB+7UtzJ37CA8nomiJXDp2XcEAbjKgOrV6KlkwQsRrGJhi
 nb2bEEMvLkGTYrv1iLbBvlCELNRttmzmLs7PXf4jh4poxYwsuxcVFl7YuwQVQL6SxQVddM1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310026
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
v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

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

