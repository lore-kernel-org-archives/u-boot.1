Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F035C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E2F82A36;
	Tue, 13 May 2025 13:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RoBMQpVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A294E82A55; Tue, 13 May 2025 13:02:49 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B80C82A4D
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8vlCq012183
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Holrrc4L+7e
 x7ULqPiq/8iUJosnwVAgsp5lNWVuQaQw=; b=RoBMQpVh6OurfOW+TUmO+O4OSh6
 1GYaOQQHScub8qeiheUyKXZZxN0MqMmieGuPxW5HXCLOh6WsteLzKffpxZBFTefk
 a8zqte7BoVernUBfjDTyG/TZS2N4wTt00+2OiZT2DPOcRWX2Zz6tynkCS/6X0D0b
 kNRWCzkRndJs6kKiUg/Vuk4mo6ZXHxvVs0LCXF9AEzkSxbIpIAOWTGvuMOxTHg6p
 HuzLsOPjLNa+TLI/xQGfQOlmWjAx1GCx9lCeoTfmNneOkklwUeRH4gG2oO/2In1G
 bzsuq0CzOAloaKkFCm5e6kKb5OcpX7euDJd8aTLPbSfLTWELfVGu8AtidKA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kc3mvan8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e39ff4ad4so72692675ad.3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134164; x=1747738964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Holrrc4L+7ex7ULqPiq/8iUJosnwVAgsp5lNWVuQaQw=;
 b=t+AyKKsvazW92XxhoMcfnxfyBZsfCGuzoi8tldLRE9unYKIXce30VLXBNx0ujTWZfW
 4irZk+mDu1zy6Q9x6PY7rXj8jey2G7G60lkuen90jh0e4UVAwLNR6Uxpvz2fFzCw6q7Z
 Ignf3lDDThMRaXF9pzL9yRfI7fAlxeLeTiK86k4AdBSoZN1+AG5WsPkcB3eFos/ixLy1
 fcyeSK+JlH+8V3tt5d20VqHPJzodkyz7jGNUwEa4pd44nD50dEC5zynu2c6l25gknj/4
 3h5Vt+Mtqc7els66pMggEWpVX4BbZkaUFMkJdMl6cTu1218baXlfKKPHIboB7IcP3hDT
 CljQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNAJGl1fY2w5o01Su7SgdZS7KolmafArJichXkphvZ/M9ZMWs6XOIzziuXWnlQab8jKEUwHkc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp+CUtwKqX8WFX2l+Ndog9rkH4jAWC6cH2PzG0R0GNWXIeP7LO
 pzhEQbNIvY5ZKIJSo4b42MO4uNaQqni367qel8Vm1zVvySm/9my9/JD2wxgucC64JhC7YTN+u8T
 Ua+byCbDFmKOvRzTt4UqtWrmy94YUYe0jtigLyoUnMBKg4gS3lRaw
X-Gm-Gg: ASbGnctSLxU+IUgCcS6Lwyuu4KP/4KhF5y7FnmW1I8nhSbc1i2+ahp9aCvfizEQaW14
 wYthVz3uigL/kWZWRlRuCZlBP8u8wjDnnWhMVSgJ2/mzwoAiuSJxwiil6FTNQm1b1L67k2kG66n
 2nezCKUquGSgA94uPT+QFT67G+cMHM7IaCwrG9Kg5fqRA659ZbeAX6nUTtiJ6GMrb/pBdMFJdDK
 Nna8h2CBPJasG451vcFuSnbth04LbayETPzX9uR9mJHMzJgAladDWab7Qqy5h3bIrHNGPq79Vgu
 1MXAUn/BbpMDvGS8XZNmWZWgSaki5ceJ9xhtaT2NMfg3Z17MEI5YM9g/vzVaWDAHlnGmhNrMPpY
 xbVR+PRascsSRiW/AFoa73brNbkTo6Kc=
X-Received: by 2002:a17:902:d4c9:b0:223:377f:9795 with SMTP id
 d9443c01a7336-22fc895028amr258124215ad.0.1747134164238; 
 Tue, 13 May 2025 04:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE30QSC4+gA7+kYtttaLPeiP4mvRWTdSKF1X2X/C8RP/DWy3yXyO0dxGz74I8yhJaqyNvH/A==
X-Received: by 2002:a17:902:d4c9:b0:223:377f:9795 with SMTP id
 d9443c01a7336-22fc895028amr258123865ad.0.1747134163773; 
 Tue, 13 May 2025 04:02:43 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa11sm78362135ad.254.2025.05.13.04.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:02:43 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 3/5] clk/qcom: qcs615: Add GCC clock driver for QCS615
Date: Tue, 13 May 2025 16:32:11 +0530
Message-Id: <20250513110213.330495-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 11UreuaavNjTSvcyxxSHyqH4c4TU4Mfv
X-Proofpoint-GUID: 11UreuaavNjTSvcyxxSHyqH4c4TU4Mfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNSBTYWx0ZWRfX7ViVZLo6ctRX
 XpYM2WKx9mgPrfYMewYnXGmeyw7x/uQlpkCF9PCLlOrp7j3xUnONBVmpHSEPVEyIzvnyk4NQHtH
 C/OD6Lb8Ko0A2haNozgXt4Tt5CFebPSiizJMg/hnJ3omTNIL4LeBtd2M649QAqpIl4zWR9Ko/qy
 S2+n2qkW7md/bPgqHmeXXxhS6D0pVJyY6GlLPtG1qABHRJkYmDoWNUYMxflVm+JBDKiK5rtolcX
 5DkieHjg3xjuWLCuXuri06UZ1YSy3elnJiAIDK9KErkJeVeD7nl3DH2vOxf/AefrWOjt/6Bc3jv
 SjafHMVMDm3BcOUypBOI6171h5K96CZTSjrlRrn9t8Ec7yVEasOGBP9YRKgfRyw8KnG+kD9Bwkt
 f8ExQ+68A8bOW612HLALgEDNHtGEBdOvrfcucrvGcVlxXXnHv/bMVvW9yqT4+7cv5931Kf+p
X-Authority-Analysis: v=2.4 cv=afhhnQot c=1 sm=1 tr=0 ts=682326d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=240JKWVrdINMfe09_TgA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130105
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

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
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
index 00000000000..161db0eeef5
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
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, 1),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, 1),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, 1),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, 1),
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
+	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, 1),
+	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, 1)
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

