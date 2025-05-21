Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED1C3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40FD982DB7;
	Wed, 21 May 2025 05:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mofUUELn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB3882D59; Wed, 21 May 2025 05:53:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AE982D6B
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGdq3A028016
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BkTVyqzf3F6
 eSoHWsev2Y0qg/B84C60thK7d7xbVRBc=; b=mofUUELnHyIlFhXViaNKsBpfKE7
 GPSB5wG7jRSD+nWYi3eUwEDpedKNF9ayQp+W07rlOQgOwVldxfTiKrJ0judf1ztX
 7lQujy2ZC4DUWNt0SFrw7nipGJaf7yI5n1iqSqRp3wYQ0tdl3iJ0ZbPyx0BEPayp
 Bemo9hzqRDtO5pLzr+AaEUpMkR0E7ua5ub17lQ/+HQypfoNToM1r0sr/PgNH8Abe
 wgTCQ157K3dRXY4Q3smxovy8cUwtfIsYM6xj8w7EAqbPP37usnas7W9ixj7Ej7bn
 KZKeQJnhZFhUs3fvkZtL21bUD2fXyezX6uooUyb6a44yGuZ/OMbyafIbucA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf41ef2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7377139d8b1so5433397b3a.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799628; x=1748404428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkTVyqzf3F6eSoHWsev2Y0qg/B84C60thK7d7xbVRBc=;
 b=du54V8//tf+3qli2DBDAcYMgPsOTznarPTCZvt9VlY+0A9gA+X+/fhosB6BULc9dE6
 GZCwi8yjJ9AAQHSohJXh/KPYTVbBqsbReFkU3mR+GoDn8Juw1I+k/yhfpxmS+LlIGJ4k
 odXawB7PYVhYTlo6BD/SOIJCr4aXFdvaaJN2xN3UInjYoYxMYZqEnHsOuCggE+biZn2w
 //LR5ZqR/5tjkVnljCbYOLFIDvwiO8aorAPGlIpSnWS923ivogpZ4UTJkBE7r/MbVO7i
 Tg6OIMpA709cbMtJXaFuyGRWA72d00GKKvCBlQkccNN1XgiOJw9Pbhxq1A+nFTe81fIa
 p00A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrF51Oc3HStNxKNF8+JqUuULVxRnS+Ke9h3ptldnGlYzdoExSL4poF4GAGK6bBa8O/+Sc5r6k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzfaa9lX1T+C0iCm2hatdL8UOE+TtJeG2W4PJ+H/o43pVePdo/9
 wc+MSk+Vg0l7R6t7ROEv/tHRPESRjcCsz6dqlZFxcKBYg2eoYLxnGA0795RRpzEInL+WARxYeUL
 1WlGXw/g+kVXd4BlT3UyLKCZ8JliIZY7gQFkxjm2jN/l3V8F3GmKIVLSJ
X-Gm-Gg: ASbGncvtJNNW++Fu8zjrsZsyr5PGhZjIr7UOODhqBdnCSa1ckLm9XLbzSURNogF2+bC
 jK0naCKUy8BKtSNjPGPQmxvVzZCPj8qFn4hfdcGQ13LfRHigGKNh6HJv9cuepIazCdnUBYkjKVP
 Fo/TvUecAUsWyEiQzh/7gEFPX06CebasqpslcUOJ+RKlBNnSncJ2LoduAghXXk0H6CPZMgw+OFr
 sCgG8ZMeiJewgqwOhzXhf9bJqKfxAp5hY6w6xxXUrkmb9Ca1dkI8WJWo4euHjJHuswv3wtSAB8g
 QidZMnHXRvXho7CK6oZwFxWEQFmywby76HwEP78V8RJ/VBjzV+y8fEAolKJ3PFGYe0/RDluOTzh
 YyjavdE91HVeR1Yo53EnbOgTWzPhgVg4=
X-Received: by 2002:a05:6a00:ae1c:b0:742:b3a6:db10 with SMTP id
 d2e1a72fcca58-742b3a6dc2bmr20568696b3a.18.1747799628343; 
 Tue, 20 May 2025 20:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvTMcN+yZHVwbihu8qKOEFDWLdGKwESypC5E0SHQVblvaeqhztZbky7fuycsjgQ2Q3tHIUDA==
X-Received: by 2002:a05:6a00:ae1c:b0:742:b3a6:db10 with SMTP id
 d2e1a72fcca58-742b3a6dc2bmr20568655b3a.18.1747799627850; 
 Tue, 20 May 2025 20:53:47 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97395adsm8601675b3a.75.2025.05.20.20.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:53:47 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 3/5] clk/qcom: qcs615: Add GCC clock driver for QCS615
Date: Wed, 21 May 2025 09:23:22 +0530
Message-Id: <20250521035324.1182833-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNSBTYWx0ZWRfXwJfSY+9MCVuq
 q3d5oEIU4x/YRzPncyi/PLmjYSQb7i9wyxlPVctfzDPx8LCyt2qBqyFGKenBHucpFlsPD4AG65A
 YMfy/xNY5KAPktEYVxPRhKlfTX+KuMt0t7lcnqfjWaBaj9Ok/wnV9laurZtWh8yQR/4z3bY8jhh
 GFEwkDWdrQTdNelFeriRpcck+iT2rXbnZswwqo+JBAQkfJ603eJNXJtrEbUpIlYjAtaAU8Ir4lG
 p9WFRIq61gWIJPs2AllINDSrelDjYHmOGZF/QJiFhkCohYxgHR2PadSJ+YXCORx2e9UuOcrvoqs
 AJcxGq9jgP/99+FCf63QKS3pVVioFQS7/Iko89bXZESPCK+s9B5eXDmuFyBEZd5YXTj9xZMNHQu
 wex1M2R/C+WqZkdCFi0keZtHK+ko9kpiCdn7gqzio9svHWBjiYuefN+b763P6ObQmFkSRyK6
X-Proofpoint-GUID: _APVBJYXcFbm6LP089o3h2QdP9IMKvc7
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=682d4e4d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=240JKWVrdINMfe09_TgA:9
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _APVBJYXcFbm6LP089o3h2QdP9IMKvc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210035
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

Port Linux's gcc-qcs615.c driver to U-Boot for basic bring-up.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Replaced the "1" with BIT(0) in GATE_CLK()
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-qcs615.c | 163 ++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-qcs615.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c969..eaac4a97376 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_QCS404
 	  on the Snapdragon QCS404 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_QCS615
+        bool "Qualcomm QCS615 GCC"
+        select CLK_QCOM
+        help
+          Say Y here to enable support for the Global Clock Controller
+          on the Snapdragon QCS615 SoC. This driver supports the clocks
+          and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SA8775P
 	bool "Qualcomm SA8775 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e13fc8c1071..8f749487246 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
new file mode 100644
index 00000000000..4700baba8c9
--- /dev/null
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm qcs615
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
+#include <dt-bindings/clock/qcom,qcs615-gcc.h>
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
+
+#define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
+#define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
+#define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
+#define GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT BIT(13)
+#define GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT BIT(14)
+#define GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT BIT(15)
+
+#define GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT BIT(22)
+#define GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT BIT(23)
+#define GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT BIT(24)
+#define GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT BIT(25)
+#define GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT BIT(26)
+#define GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT BIT(27)
+
+static ulong qcs615_set_rate(struct clk *clk, ulong rate)
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
+				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk qcs615_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0)),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x5200c, GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x5200c, GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x5200c, GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x5200c, GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x5200c, GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x5200c, GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x5200c, GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
+	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
+	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0))
+};
+
+static int qcs615_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, qcs615_clks[clk->id].name);
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
+static const struct qcom_reset_map qcs615_gcc_resets[] = {
+	[GCC_EMAC_BCR] = { 0x6000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0xd000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0xd004 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB2_PHY_SEC_BCR] = { 0x50018 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50020 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x5001c },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB20_SEC_BCR] = { 0xa6000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x50000 },
+	[GCC_SDCC1_BCR] = { 0x12000 },
+	[GCC_SDCC2_BCR] = { 0x14000 }
+};
+
+static const struct qcom_power_map qcs615_gdscs[] = {
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
+};
+
+static struct msm_clk_data sa8775_gcc_data = {
+	.resets = qcs615_gcc_resets,
+	.num_resets = ARRAY_SIZE(qcs615_gcc_resets),
+	.clks = qcs615_clks,
+	.num_clks = ARRAY_SIZE(qcs615_clks),
+
+	.power_domains = qcs615_gdscs,
+	.num_power_domains = ARRAY_SIZE(qcs615_gdscs),
+
+	.enable = qcs615_enable,
+	.set_rate = qcs615_set_rate,
+};
+
+static const struct udevice_id gcc_qcs615_of_match[] = {
+	{
+		.compatible = "qcom,qcs615-gcc",
+		.data = (ulong)&sa8775_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_qcs615) = {
+	.name		= "gcc_qcs615",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_qcs615_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

