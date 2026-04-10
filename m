Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1187AF44857
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAEF841CD;
	Fri, 10 Apr 2026 14:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lr3dmVVT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VOkFWOt4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6E684106; Fri, 10 Apr 2026 11:12:52 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0E283DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A75cA81729914
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EeMcpicEVGz
 26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=; b=lr3dmVVTFu0xsnsktGV4nfH28zf
 m/eLOhnjPbAn9BwRZFAxD5wX1BWkbAwQNvgYLDbvelng3oJlbGa+qxemgwpXSCtu
 XBf+KD9SfXk10XnhDVcUfn44KjlHUScx9pVDRFU/IiyAbT/M7SuvjPMml8i4wQko
 hTHbA+H4syWUe11x3jUmMG8SLlkqpRA0WPvIjYksjo8+XAOvfvapqmONapt+GdAF
 UyWNeGdiRTmSBDrt9me6qSPIS7gomW7Hz5LxDzRtHXN0oYjBg31ym1O3u96t3qTp
 U98KQrWqfoSDrHAr+ieOV0j0dMrme4dURULFd+5puvEo5vODxZfwki4CUzg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxkjmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354490889b6so2956637a91.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812367; x=1776417167; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EeMcpicEVGz26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=;
 b=VOkFWOt4ku5hWZb6TIDqvIB/T6Q6vAiz6uV8/hlsT8L0c5z9KziMFdU2r2pVQnZlm7
 W1QNMhbpUYuZ/nru4MaVngzpKCgEFk/SohM43vr4+2W1BGHxyVhfcct+U/aDZOcnt5qH
 +EhrF+C1A2E0ULeApqDaHoRq3tTGYdXGKUPUoD5JCbiWTXKjSLGvxO0EjHLFGXfISFYW
 T6IJoEoUwCTI4jwkPeIOc+LafcYCt3doyIXZOdTbm2JIoVQos0HwUYi7hCqrndfhtsUm
 Y3eTEyPxJdnGPczIyZfEkTswDi1FIU5IWaamBNC/BhLUmJtpiJy6N2cY7IK5bZ8NQvCk
 kiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812367; x=1776417167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EeMcpicEVGz26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=;
 b=Ed0nUXDEG1qMtv1uLpkFu2CPB0d2mL9LHzbpAIiFMJx5T86xBIF3vPvNpqSqgXP+5a
 EsDawfpp/rD5LHX+dSRssDhHqO3a5nDf3nBQAXbtiWMX0CT48gQezPf7nfh+h+JshyH5
 37rS4Txae/hK9A6+AslCRVJ65XJ/NiAgebPr7ndsKlA/7OkXGwbgO94J2R62FGsfuWYr
 8o9Le++RIt01HTWucLUguJvVxaIhlT/35QkKk1hTBo0J7D1e7bzPnJHo8wlCxTNzYJSL
 LYrA4Vvja+6OQtdFuqlZPO5qq6GXoSqDbz7inGeooS6Z/b5G7grc8N6SICWFUD4IIe2D
 X1Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfl6VFg+mP/RnnC2WvLmrspg0gdKWzt6GDYxdOwTXyZXnjCql435u9xs9uwmsPj6we0SLGNpE=@lists.denx.de
X-Gm-Message-State: AOJu0YxFMDyrPjXOnQqf8yStOzQK04iDZ1lh8TpbiYS1+xo4eL0Cm0BN
 qo4VKtSxrk7AbA+UsFIMQy0WJGzj/Ezu0Kz6l2/slz2wtYoFKE3FajewTEKQT5lNWcWwvu1zJiP
 XZMNXivDRpb3M+ZhMnHJdXmU/tXOlKU5fb3I6bJWfZsxQuuYWU29YpH1p
X-Gm-Gg: AeBDiesLh6Qjjs98GW3v/+xXil/8zs8duLknTHaYbYYicWHMwNejzvyU/XrsHgrzR4K
 BHMY2ASu6VCZNC4AK5az1eomNdTo8pVAQZNMRd/Dn3roJYo3iSTFjzrNh/56fYgjmMjZ8nMpqDH
 iNHw7ckY0eP6f2E8oEmkg7WRn827REf3UGzKmAEkEOoqvNuCduPESOmoI69aBgZ2C4zgtlfpw7q
 OJoBNWwnlb1xefDGzY0aN9B0w7RoZNK3usYWvDlbIpZZECbaF/8CtglJSDIK0EPoPZCd9TrIJQ2
 R3Aw8Z0Bbv9Gz+sQoEC0lHXqVG8+zvh4WhbA1z93o3cXd/aovMc5Un/B//m8uVpDUgrF24o57pT
 GCfaz9X9VLiJXClNNOexs16Iwb+ald4Oq3n9F13dJiYs2SUBLyeGIZxbU2u+i3lyQSnfc8TTPch
 sJPw6/O2gjni5SRuQ4MdJa6iT8bngjJ8RP5+LzihOd4H7KfOwkcFw=
X-Received: by 2002:a17:90b:3dc7:b0:35c:8ac:ef74 with SMTP id
 98e67ed59e1d1-35e42747d34mr2628457a91.6.1775812367106; 
 Fri, 10 Apr 2026 02:12:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3dc7:b0:35c:8ac:ef74 with SMTP id
 98e67ed59e1d1-35e42747d34mr2628432a91.6.1775812366564; 
 Fri, 10 Apr 2026 02:12:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:12:46 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 3/9] clk/qcom: add initial clock driver for ipq5210
Date: Fri, 10 Apr 2026 14:41:48 +0530
Message-Id: <20260410091154.1001021-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yMfynA8gIV7jOSbfrSq9LBTl6JepTWUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX6aop5qHer3nx
 UysnpD/XzBF1jSUuQ5/jlq9W/Mrauf3X5B3FWvADyQDXo4ED0OHKvcEJgJVo0xYHQ5H17Ty6DCG
 Lsh7GepBx8CZmJKjiJlOrfI4aL9fCu7gKOWaiGvBh+CVmBE5XtvgxarWliCc4MKVnhpHLSbTqS8
 T/vP0V8v3ugCVR/Jbq10tsN5B6w/laaj5f0wAXJjROuzqOaeHXq21FTacEJ70yMSZP9ZksVAsJN
 iB6QcTC23QX4Km+QrpIby1QF0cytFw7uR2Qg5op/nyx2KivjnKBJoRuvUSvoZuS+YvzYKdAUDnj
 CCYV9J/cx5NfpM2BFh6jketpAwv+C9BOb3p1sF7fgzfkEa76VEYT2sml+pFb5vaWp1tuL/O9XVI
 923mrn/8Mze9RLqUmzuIiloVR0GGGXdxDOb2RsJ3j8CcRt8bMl0W33cN+V9LUCfMBMea4l7E/W2
 rF7NqtAcxGKjgGcTw1w==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d8bf0f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ttnG5VEth79ohM5wMFYA:9 a=tjWZ8NC-rebGB_hs:21 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: yMfynA8gIV7jOSbfrSq9LBTl6JepTWUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100081
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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

