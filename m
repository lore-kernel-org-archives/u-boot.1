Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A863DC3ABCB
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2A882162;
	Wed, 14 May 2025 06:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DK3bmfG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D2580107; Wed, 14 May 2025 06:42:43 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA7882A33
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E3UXuH006197
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3+uciq+Nq20
 XrdTGw91stTLtbGW9GC85/RNgyOgYv0Y=; b=DK3bmfG03oidSZ6YhxjPBrYZG6V
 ESHoA7pXe2b4Xn+DS2J4BRuhKB30ZqXuhEidLPcNYsRIOGRBWU+DIggLOHpiz/du
 cPQ8WA6BPBwz7c/2fQWfqhxMAOeCIVjY4Xb+cccRfW5F6FEUki5RsDRVy+gX3Bkj
 6PqMURM4ZB8FGXh02NpX/Nzs/0vCGcUp3/UKpLivCSs5r18UIk5owdvM85KWJuvp
 HEDRqBcTYzDFiDWPM/+xC/J97Ql7lHM1gD11Y8s0eVeCbGUlCkKg6+jb2XOBnpWm
 6wKOIna8QgRGvL29xDtj8+2LMjbYIDhHrbGL7hahZPG70q/TDhlExQMV1Qg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnsbxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b20755ac243so461559a12.1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197758; x=1747802558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+uciq+Nq20XrdTGw91stTLtbGW9GC85/RNgyOgYv0Y=;
 b=avoDQtMlD9/vkq93lOcb1mPf6emDnmANaOw/6Z0Xu9sVBz9AE1Kb2Um0bVUkq56oXP
 dud7jSTwakrfIigIOYB7Q0hiRMQn6juRKJGoTasOoiflAlmXrWIPFtlrpn0sj/onfIJ/
 JoVaV7cR8PmEyAKIIUFN0O3zkV2/XgGbQXUNcFjX3kIEjLCc2jJweyMa0FYtCrNL5KzK
 iwWMqFme1aTx257xdNvCeFuE2ftmBlku1crD775rCgmswUw81rn6Ilqk9R21ucj5b7Gb
 iNjgSqE/JcLdhQPX/pMLs5tjggeW5h9sEC+SzUf30WkrUoXzs9W8Xs3bVbXXcuPoQ0XT
 eGpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlYtdj+D3V2e047WgT7EH6KjoMbXnZyDZAXvzxfW02PdtM2WEmlWhFnrJLqV6t5xjQW/j5R6Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxKQzUN+uc3tzETrRpte4wUnNFPKw5nnDvu4vfyLOlH1tzUTP4q
 vrpiIppYwK0j4exbx1biV0Wef9hI8rsJoQYQyboCKIAg8o0VUjdzOM4HEDhHNxPwCE9w/87p7MM
 zF6gHQFn4MmXL6uBQfV3jSRzrnnu+LYMlLlA8AkY+lszuDHx3MshF
X-Gm-Gg: ASbGncsVRXxgVIsbZSVFe92aUUj35reR2UpQl+GkzVE4BbAc4lHVq37dIL4QgaLNsaZ
 wqFMHuWjN3IjEHQsvYLLIB+0TCWv8XW88Xvuqj2dlJmBCaC/LkiEWlg/Ew8qsKcmKV5TfBoJGbx
 4f0kf74Pplzg8Iy+p2aopLleGYEFyba/pI1ZAicRCwnNNCOii/jmWk5GqYUAYTQzgATjr9lyZ/p
 DGlJmyg+boea/3O+G4t45fQVnRS1TaKF2u//K2JGevW7ViyJCagURYMbNX0WwCKCWpX0APIMFsv
 KD8FXumG5nDd1oXRJRId/1mTHuXPn1ClZsd17eVOBrSgSDxkFr1AvZS6fxNzabV8edUY5SJl78T
 H6DExYn4479n7ZQ8ox9S1BOtXFPf6mHJL7Om5AVMX
X-Received: by 2002:a05:6a20:244b:b0:1f3:323e:3743 with SMTP id
 adf61e73a8af0-215fdf68417mr3054702637.12.1747197758370; 
 Tue, 13 May 2025 21:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBc2wp5URCzCVw6kZv7kNHz8OuMGJMc/nrjqTsWqExxxJlEGWymzdLvdgn3GQxbKerdmJRmQ==
X-Received: by 2002:a05:6a20:244b:b0:1f3:323e:3743 with SMTP id
 adf61e73a8af0-215fdf68417mr3054660637.12.1747197757907; 
 Tue, 13 May 2025 21:42:37 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:37 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
Date: Wed, 14 May 2025 10:12:09 +0530
Message-Id: <20250514044212.1422714-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pPl20dcPuq5EtpFm7AirSKYt3EnTmPe_
X-Proofpoint-ORIG-GUID: pPl20dcPuq5EtpFm7AirSKYt3EnTmPe_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfX1CuPzKgSOFQa
 qA7mM9vfkXEokFlSvvuWJYUQfGChmrSSrEVw/LCTH1Q5l++UeLtakBuoWg/6xkAFIf/JKKch6LQ
 jrxJxwDdeIenxlvXoqaY/3lHC2m/6uaJjsgiyB4pNcsBrI842vMEJStuM/wC+wse+GGwr/u6SwR
 j4OBFJpxgHPbYmrnDRl6ju1yGZONI+UyOZcX5rOxOodzLIcmLvGOPxaVv7eDuOWmyGVx11Eb4qR
 DtePjFofURys5a+WAOn60CbnTGP6kSSzAN42Fq77AkCEFRYLlv0csIAV6ORTb4vlzTcZtvK8g2v
 Voa7x4o4A5xoSboPpnMkHQc8htnGvncx4vDzoZy4BMoEWy7LDOHDzJwUUv2yaSiyAULzYqPECva
 mKxHqYwmytowHIXapGcTDUiOU2XI1Ia4ebPRvpFzlyGoY+QOqMkOCPoifDWOXDDUEnJ/Xu8I
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=68241f3f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=i6UvY8dM9ONR_HjL1zAA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140039
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
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
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

