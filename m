Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F54F8A16F
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501518421D;
	Thu, 16 Apr 2026 15:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1mIjVCU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXg4L2w+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FD0841D5; Thu, 16 Apr 2026 07:40:14 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DFE83C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1huMO862148
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EeMcpicEVGz
 26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=; b=G1mIjVCUHF+jz6jZQ9a3siJDH9i
 F0urvDZTvOiGNgF6rrmS+fQANT58UysZXNArr1PXi3VzVnsavjtI6AN3aDa4q4U8
 rZwjrEeubPRaTHmkuG4sZ5BmGMQbUR0s4MJb7jcSP0lQpyqA2dSeIxvE7b2N8sPE
 XgNiGtqFYAy6mywjXzn/DSCf1KawnVXh3ewFufekkZTxy/sApnZ5GELAtF76bXIC
 +9kdjgMfRnx4TywD5jPGnLRkMlov8LA79whThA4vCkseJ77idN/3pUXHGBg2Kx2q
 q0lm69RNHB9DJyilfS5MVHm+kSUVL+Vytr9W6KbF5e/7eQkCNS+KT7Hpryg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd0eae38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:40:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b465bf993cso36383875ad.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318008; x=1776922808; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EeMcpicEVGz26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=;
 b=CXg4L2w+L02LLuh4o90UFqEwBlivWgIVeENkhP/PfsVBOX5LphYOF6hdNwfDUe4a4O
 yIYdcXlFYCGcEqWuRQ7mMyO0c0nNMfvXEPSPFT8rP1s7Qcy4IrhrxOnPhDUGxF+4G57L
 TG5vG2hv78D3e+1SHOBaJ1ZcHgp2UTC/qGPuAYNQWVnIDA6y6DDws4OoGyfxs96YxxnF
 qDUBtpd7A/W0aOjUC8zyUFvnb4xW7QlbWxuPaUlrJhnGEzGcNGiPoPIK2uTASqZgBS5p
 9GxV00NBMTUjaVTqivAuP4WKvKorUdSwg1bBCOql+yNoxL0DBwT57gJgSHw1dO7/zzNx
 72xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318008; x=1776922808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EeMcpicEVGz26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=;
 b=eQAIyB+Hwer+e0dZUL0ln1xTmIKw26UDCdDCjLA12AywQ2EKg3l2rq/EVjXZkthn46
 piaAvGjGVPU7m/NoK+ymSaEMYdhDtsI5nK9E3E1zt1Re1koRteJLaMfMpktZ38XwlMqu
 GfMwA1zD3nZnEN+2WbbF8NXv57EH2TIL/tI/FijzcSn4XRLkFkqRbPYmSBIuArISxPnm
 1g5Ar0KWFDegQMoAbjSYnrL8BTYM4HhN9zkz3g0VcvkV+h0+6JCnnM8zl7W0QBbJ1Tkh
 +f29QUAnVoijS6rk/fmzgMMLbA0k588j4rB89eXo0nPaEA5DJtZnBllZ/F2cR2MqTgG8
 pgtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KJwEc+8ZgoPBBNZ9l9xOFPdd9jntcEJEgTiiOIVKS/gOktBuJIorvnuQZS57IFQynxmEOeKk=@lists.denx.de
X-Gm-Message-State: AOJu0YwBIpDD+LLcWGfqFZab+A9Ou7Resqp25ks/4e7JDIXSk/dPXjf0
 BlQtndjMbPuwZAaEZGOKsbkx7v4KL0AdVh6tCjfwp196CQe7mAu3Sb3RALAr0or7k2Dt+koUeJa
 24f42lpCibJ0hEEwNVKG87KDjv2A0iVPnhIf1Ji3EdCh5HRflXmlCsXO2
X-Gm-Gg: AeBDieuvx+y1lITp0HddhCkwMbQJlyQ12hOawiyZs9W6yWO/RSGYOLiC3wwk2JhNyD5
 B8eCBgDeDkcH2L2Wr7s/bm7113igQe86p2cWCipFFuMAezMIxVGJa5I8uVUVmCn+QzbaHpJBEkh
 2SZeZoiPliq0Ad0nIbhIbsYECavCcLNmcFo93CPF35yoqy42LQNfNfbzrUTM/OYLq6L7+Ei9iz8
 PSGioe2PN/av7B70k6Rx/UXzASOhTQ7pvQCBhujaP2yiF94bSsDQB37ff/iZ6MHJuPdzhZX4z+1
 lVIK2p27q6ea5L0ycKNfE4WlPYCfPtED6NaCQ5qADUjzdxGRoU/fnkPSYQWTawMExnZdh0326+k
 dXX3x18AMK20FafAi5nTh/XnLdqWVwk59bj2aVzsAq7aJx5fshGNW57vNyfeiA09QTRGbSsFAhy
 ArFebuJNjuxpbdAugEZ/dBJtf/KHhcY7ZXXJ+MNci/wFuxBxjQG5E=
X-Received: by 2002:a05:6a20:6a1d:b0:39b:98e3:6a30 with SMTP id
 adf61e73a8af0-39fe4052400mr28916963637.51.1776318007570; 
 Wed, 15 Apr 2026 22:40:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1d:b0:39b:98e3:6a30 with SMTP id
 adf61e73a8af0-39fe4052400mr28916925637.51.1776318007026; 
 Wed, 15 Apr 2026 22:40:07 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:40:06 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 02/10] clk/qcom: add initial clock driver for ipq5210
Date: Thu, 16 Apr 2026 11:09:20 +0530
Message-Id: <20260416053928.2834699-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P0f_ryAbKrHAF7bEpZaSWQhOKUDu00kr
X-Proofpoint-ORIG-GUID: P0f_ryAbKrHAF7bEpZaSWQhOKUDu00kr
X-Authority-Analysis: v=2.4 cv=GP441ONK c=1 sm=1 tr=0 ts=69e07639 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ttnG5VEth79ohM5wMFYA:9 a=tjWZ8NC-rebGB_hs:21 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX6kbUngYQ7zAi
 +NlM8dksBa/KymbKhQqyQhhGxtrEg6zkmotfxIE03hP5NJ/vo5QFArzTmrqICxak5j+rvZS4zzF
 1JJtem1wRKlWV9/EIgMhjr8NmSe0xgrGUKFlYgtfl49v4r87+mGDyAY9cYCuNRYHSwxWnE9B4A4
 xy41vwgKsgD4wasM55pa15xn0K6yXM6RVLKxJ1y0r5u8n+8PSyWvgIkAuOgjEja/W/9D//8o6KQ
 eVeibp0ZoIrmV7ZgxrbGi65PSHlEmTxXDHo0EL0JNOrRFAMPYBWc9KpchBZst4tQQh+bv+jC/UF
 +Olb1RSXl7gZTxUfhMM7HINgz4D/EukMFdAKhNo0mpc25WgiVNBMDR20Sl7PxYRZaDH1U7v5xMt
 ercmLo6o0XVnQtBEgY+XyVZbEGXO8xYka7RLegmWKJcPXDFdlWaiccK89A8ftUwfLvl7MhsvkII
 P3w2gSO2LxXnxAe4BYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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

Add initial set of clocks and resets for enabling U-Boot on ipq5210
based RDP platforms.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 97 ++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8504ed5d656..a0a8778d5f0 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ5210 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 82a5b166196..7116be963e7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
new file mode 100644
index 00000000000..f0a6ee8711d
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5210.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm IPQ5210
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dm/device-internal.h>
+#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
+#include "clock-qcom.h"
+
+static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 2, 217, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 6, 25, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rate;
+}
+
+static const struct gate_clk ipq5210_clks[] = {
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE1_CLK,	0x05020, BIT(0),	0x05004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x3303c, BIT(0),	0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x3302c, BIT(0),	0x33004),
+	GATE_CLK_POLLED(GCC_IM_SLEEP_CLK,	0x34020, BIT(0),	0x34020),
+};
+
+static int ipq5210_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map ipq5210_gcc_resets[] = {
+	[GCC_SDCC_BCR]			= {0x33000, 0},
+	[GCC_USB0_PHY_BCR]		= {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR]		= {0x2c070, 0},
+	[GCC_QUSB2_0_PHY_BCR]		= {0x2c068, 0},
+	[GCC_USB_BCR]			= {0x2c000, 0},
+};
+
+static struct msm_clk_data ipq5210_gcc_data = {
+	.resets = ipq5210_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq5210_gcc_resets),
+	.clks = ipq5210_clks,
+	.num_clks = ARRAY_SIZE(ipq5210_clks),
+	.enable = ipq5210_enable,
+	.set_rate = ipq5210_set_rate,
+};
+
+static const struct udevice_id gcc_ipq5210_of_match[] = {
+	{
+		.compatible = "qcom,ipq5210-gcc",
+		.data = (ulong)&ipq5210_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq5210) = {
+	.name		= "gcc_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq5210_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

