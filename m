Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D94C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0236F82977;
	Thu,  8 May 2025 14:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JG1uKg32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FC08288D; Thu,  8 May 2025 13:20:23 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276678283E
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484XjL6031067
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=83Y1kE0eZ6U
 4ifqpiK4Qnsu8I+7N0ijOq/yG9f+AMPk=; b=JG1uKg32IItR6SxxsT4mA5xrRo0
 5bSfQAabyiXjw5oPtkUBWvkBRmcXjXf94uT1at/c4fCYY27KCCS6ZJNIu6xh8IdH
 FHqlEh8Haxs2+UAqb1xIJB8Cy1doOjMLH0kqawNf+PZ5pang9roZoy7Ia0TVvCPf
 Le8jBB4no8YXkCv1werU92/AYOkzGTUhimi988YHdOFr7xGg13zIvJatuXCxHRH6
 GxG6jg2SylK8fGVWW8isrNs5Le4NBBxc2PqAfDzJyT1VFAZxJfQB4AGt94XmlvbP
 5XBzpC0q18ECu6hhiAT8YUeCT6kD+y8OyOUmPz4QkwmRAWH9mP0bieACXIw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpgh3p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e327ff362so8538945ad.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703218; x=1747308018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83Y1kE0eZ6U4ifqpiK4Qnsu8I+7N0ijOq/yG9f+AMPk=;
 b=WyFtRf0XexECsv/j85wJ3+nILc8GmBUsPMM2zP83F+2u/Jb/5gfE+gV3Nw5xY6mAjV
 J+tnCuTBvEQrHVvNDvZth72aAbZum9hBXvx3UWLYiTGGFYW+o9/6Eg50kcxkCU+lKTix
 uy9LZcjASLzwaltBcRs5XH9ZpEfOUO1t9jBje2JKv+Wn/EbGzdHg92wQPeTtDWt2RjU+
 QvRHm1aNBAiJ3GDhlPa1yytccn7IJbph8wtdLUric1doFfgaC0kOZBLhCUWJziylLkdu
 8teFCn1NxyyuuMprJE2Xc7jk/u1gki2/6O0bHGNvQ99n6lzk1cRAkvTtFVm42zHlyjq3
 VXTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpahYoemjR3eQd9NhrH/DY8DMbM7Tgtpjvo0V9BIzXjZhPwpINxSt/M6rAF7yRCrCj73g/ofQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyAKyPKQFcYcaoPrYrwOXQnJsXud/XgCs16yTxfxgUdOyzPfXdh
 NVw4dvTAwlQdmvNmpFP0yJcLgB8bevEQ7XpSvFAGU6EFnAtpgRzw5aqAigQxB0xA8EpRSxozZ38
 9romEj0wShT4UuQbAjpfm0uJX2DP6SjPJB+bgVEaklr1h1BB/5DU1
X-Gm-Gg: ASbGncsPtZufIcRgGloTaMst0QbWKSEJnUxyFWdYPW2GaL0Nus7l8AteMLSTs/cqwMZ
 Uk2ZUdF+UUcy60s/Ln37XDXlD1ErceJnYBBBa4E/miJ+d43E9kGbi967yEpSS/WMoUkek6fPapZ
 +CM+oq3QIpIAUjSi2WEGnfXQbTaoGpjzbJmdUrwyHowtDzfrFUtceEjAhAUzc8Qhydl99TLeayy
 Ulr0JwMqpAequooSUlib5oGit2BCRUiCzI0c58F+A7WBLcYzRecOwN3nTDJtmLZvZwvdA417o7U
 J4lApZkUUaNUiDeyi7revONGgXO9rqYMdN17qLCRemTVjcXu3Z09n/YnA/g/EP7QHoIvNFlTRQr
 +UexRJCu+eWV6KSGwZU7cbKCcPKlp3jHNWAVTQq17
X-Received: by 2002:a17:902:d487:b0:224:ab0:9b00 with SMTP id
 d9443c01a7336-22e863c8667mr41079865ad.27.1746703218316; 
 Thu, 08 May 2025 04:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRMt1UcYbBZfxAEba2wGy71pzAQHMWf2p6gEzxJbbbjagufsReRjX1aKEPYkupQ6Pk3xstDA==
X-Received: by 2002:a17:902:d487:b0:224:ab0:9b00 with SMTP id
 d9443c01a7336-22e863c8667mr41079535ad.27.1746703217883; 
 Thu, 08 May 2025 04:20:17 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:16 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
Date: Thu,  8 May 2025 16:49:49 +0530
Message-Id: <20250508111952.2304578-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=681c9373 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Xue-xJELS_RfuzEwONoA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfXwhew95opE2aL
 5XrUcFg9Pwomw168nShfnQMPAbNjFZiVrsYoNcMACRoY6a1nJBkDm9UMyQNCj8/QWuJv48NqPFy
 7UhYvb0D8pN6f66TxU9lJLbXPy1Vnf23e7gcuYCT8t0s+KectDhDE4FcMOZinnhq7dQZ08CUrYz
 IARuaN1DeE/3MoyyKXtIWn1wBKSgICWF1dA527khPJGuf1m1AsGgnIsApbok08yp+vVOcJd4nUH
 lwBgEX/fw/4IIm6OCxJrBwjdTlRf4GGGhJAXmbKNpYrNFVy49LM/muEjKiC27zUO8S5wSy5A/Nj
 f4rPcoSBvsJ5kyCsdLeYE8qilDzLQ/W354ztMhDT7WaWQnsi6nCCB51mnozA0ldMtVuMeD7wsHV
 qsbAKiGoulHI+Yd+fOO+zwCtU5U2dtC25bfeVgGC5kKkKXxbScRSha+zvGAw7GRkBNu0lOf4
X-Proofpoint-GUID: G7jCIePyo03hs1Nz2kW3faEPyKWU4pu1
X-Proofpoint-ORIG-GUID: G7jCIePyo03hs1Nz2kW3faEPyKWU4pu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080094
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-qcs8300.c | 146 +++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c969..a226a787af8 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -63,6 +63,14 @@ config CLK_QCOM_SA8775P
 	  on the Snapdragon SA8775 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_QCS8300
+	bool "Qualcomm QCS8300 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SDM845
 	bool "Qualcomm SDM845 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e13fc8c1071..7e544bc5407 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
new file mode 100644
index 00000000000..f0b9a0b4fd5
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
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),
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

