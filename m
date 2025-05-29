Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C35AC5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AFCF8309C;
	Thu, 29 May 2025 17:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PEyvLBXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49558309D; Thu, 29 May 2025 17:49:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C59D8309A
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1b1n005029
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6p+BtT2KUZL
 +LTwMBueVn+x9RDJyQvsnCXdqKNN3Pvc=; b=PEyvLBXd/fLOnrpvBBUtYiSZSri
 hJJhmQWsMS3fnIoT9uPhwigxjGnq87PmRMN9Xp0shy4nRlvAQWu/NNgLwyrwTcte
 jTx8iOOe0ew5Qc/MNQ43s6XCpT6VEEVph6zFfxo+CD17EJQvhcJFZXO4cUo4rGBe
 DsC5jzusDE04ahZkBrgOurLO8jvyU8wvWAFtRRI92QAfAgfBAOmPXfqmiaxpqes9
 Yzi76K78enWPoF6HAwnY+RynsTPSgy0yPDcQeCnwzVA5zVHxU877ilESDyum/RBp
 hPaeQnEzfxI8W4G4CXaWkNb5i0+lK9dS3BvkhuZkJMtuPoJgz+GGjTkn7Nw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek62c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22aa75e6653so12528915ad.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533795; x=1749138595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6p+BtT2KUZL+LTwMBueVn+x9RDJyQvsnCXdqKNN3Pvc=;
 b=JmietCwy0Wnuqie09Nai0IIfKTvXrdLy1svVq9YSJ9ZOW2Tt5XCKnt09HyH15PDE/F
 I3q0HIazuVUxHJvqiF9nCUvJkpvROjFeCRDzPAdiOR9bsWPt/za+hGaNoB8Axo6gzQz/
 MMmh7ZFX9soukcEeSfLVQIfDLqrnOKBUkNzVmdrgPu2u1sKv355zWkBEpSNweD0iZJrr
 dsy2RYVvScpRavIrBleUdX5zWyhy8lEYteZzNmchBtvHZ2i6zTUoJsGp8qiqK9rwGGwy
 LomDxdo9KM7uMRvy0ZnUAwAhO0ktGZChpRlYLs65QnpI53ajkgzj4mt1WP4qpQD/7XKp
 5y/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN0k2FZDsOiVU4fWv9wGcJPvdVrRcQByCKJhRI2pdydzjHjuaf486Q0dQ/cbIVQAZAccKsFF0=@lists.denx.de
X-Gm-Message-State: AOJu0YwQrdp4ldSsqKDqDGLz9rhD2KWkijEpxEpM79UAIis+51PryTau
 NJ1RG4We1icN0asO+0zx6YQSmBuH4GNoIoGnhdchI3eCZ7OR0XardHQs7f30uhY7HGjGPrUcZ9b
 6NBfkdOpr+ILn0IsGJ+xevDSLk/y3s8SCCtuA82sOgcWTbACCaNjtApBA
X-Gm-Gg: ASbGnctcliUeT7CpUuKvIgOM97gyk5LCRX+L3vs3amw7nDmtXZ2ifs/0ZendeLrFbSh
 U0IJ+o14Fu2kg9KKEYeFYSJi+Vd+6ND6JMSlQ9GLrX3TDdHkcxgM/1kk+jnruWEk51M1QM9C33n
 CnHDr8yuAmSLDz/VHDjXpzlKG9rhLi21Sq8rSjZCtmYamdmg18i9LGuZuPQZzdWhImlHjRPV8VE
 v7Av9CevR9RUNL6SjB+XX5Xqx3hhxWg1Kqps4X6US/zhfrMm0EtsYA4VqtqdEsRq3/619b6ZsGJ
 +2m5q2yQjtNAlJ4e7eCkBWcCsRwqqnH+0CzDX7FmYRUTpau8A7tHXH3XjFue3z1VqNUo25emv3x
 MRdATiz7nASGn81zXPMlq/YqAA1s=
X-Received: by 2002:a17:903:8cb:b0:234:c8ec:51b5 with SMTP id
 d9443c01a7336-23529a16fc9mr1275595ad.53.1748533794892; 
 Thu, 29 May 2025 08:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk93iPW0JxCbgmntoitDbUrqi77xE6BlOH5dpqJJlbwcAJW+mdp5YXljBs2c4+eHmdQDw7tQ==
X-Received: by 2002:a17:903:8cb:b0:234:c8ec:51b5 with SMTP id
 d9443c01a7336-23529a16fc9mr1275125ad.53.1748533794422; 
 Thu, 29 May 2025 08:49:54 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:49:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
Date: Thu, 29 May 2025 21:19:28 +0530
Message-Id: <20250529154931.1879976-4-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=68388224 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=i6UvY8dM9ONR_HjL1zAA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NithWs8VKNZGEgfGVwtWUA5gBoYcqsdt
X-Proofpoint-GUID: NithWs8VKNZGEgfGVwtWUA5gBoYcqsdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NCBTYWx0ZWRfX9MjNk2SfsE5M
 y7TC7DJU4TJRqDeDTFRlWT7/oiE068ROj1sdcR8Onuh1wWe8zbRlvAG1zR3PjBfiFQfl/H/V6LZ
 3u+D4V9CgXsINc2jaBvkzm1riSwmXQKJl43WQDbH/+inU/GxM4N/D99uFVp0mUnhojhInos4Ocr
 Qy8VClxd4bgeECmDvdYHss3Zlrti8x+gGuh2HD9ygNAcveKd8101dVnIYHhAX0pfHGRuSijNXUH
 D2+0qb5NZ7f8+/dj22/Q0q8YhA0ChaXH3rThNZ0dfBAZKg400iIt6SmtEMTb1TIFRGG5BxkZOFO
 TdS4QFXxaGydX5V3yBCOErErYUjnLgWAh+SvWGOYndHPxOF5onitURTy7Zm/CzKOpA4u3reBYFy
 d3HLMBnxPipqfzqmHaqSQDzg0kzfZWjvOLtyjSKd+Y/nXUjtjSxBBvwxNP/g31sw/+VRTUaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290154
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

* Port Linux's gcc-qcs8300.c driver to U-Boot for basic bring-up.

* Enable QCS8300 clocks in qcom_defconfig.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
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

