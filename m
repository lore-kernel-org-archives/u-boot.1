Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEE51073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638528418C;
	Wed,  8 Apr 2026 14:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzS152s4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N95y1NKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29F7838BB; Wed,  8 Apr 2026 11:12:30 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE95580433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387VRh51259200
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EeMcpicEVGz
 26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=; b=kzS152s4Jb0HJaVZXA+nj2LqOgm
 ndWPZvE3LJEZqyZ6kOrkaPJbOvn0MxI9TpZQ5HywTg2HCZou1yhuZUv2WKz9xVr+
 AQd2QW31b1LfihhKrLgeXwfRj2v5K3EgLpdIym7CV60EeyxWO7nrMFuAXtg8weZ5
 uvEkKa8jtMQqloJAiJLvrAyNxfXhOtg0+6gCwPWmOjAosA24gaeVIH0FvzjplhEJ
 HqKsei+2uCs8bNSnunnoGeEODadSaO9L+eOkTYir31kaciizuiVbMM0Q/VdREYXr
 1v36za8UC7+df7V4pGvIaTuJ8/OEFv9H42cty7wLnkxSNiqQjmG3JkC2FRw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttsswh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:12:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b0c92ff4ebso77797405ad.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639544; x=1776244344; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeMcpicEVGz26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=;
 b=N95y1NKntS9w6nk3IVk+UO9QEWBSwhT1qkTs2oYhi9TPkEG71wwIi9Nfcf0Mh7u+de
 oKO0c7vcLX4bBIpPgKulgCudJbLuqtDYg2JbsEW7qE+I90FbMDe+JacMq2RFvLKwkzoa
 AkEYzIRQ4O3M7p2VwksZp3WZ4hQD2NR9KZqcxMONOs0Ij4f+tGMLhO0l8mISHRLsO3yi
 e477WJJLzVT8q09WjNOuw4e3cY5U0qfDfiACAt0+jy+JKlXK/25ITdEVi+hAAaDnZzqN
 Z3c3hSF5OkJ2G4OAAVVvF+BXIvb5XHiztV2MaOgZ6qB6Dsmuav9Dti+Q4wUQYENft6AR
 A+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639544; x=1776244344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EeMcpicEVGz26VJ4q6kUTiEUTbBHjltnzjtT0vSHomI=;
 b=Bjxzvx4ZgaaBvJRImzADKBFYHlkZXs/EtMZluV5aCxMowbfcVrbRgLWfGmV8X+2424
 D4MZ/VKVsREZdEMsnFZSHaiyTCoPBM6YeSeYc/6SV1zYIAmq6ySE+w81LTXvST9oqH2t
 426Ays1+BptTqqIS9O8f26Oh1bIWoYTXTVJxFCNyMn8yQ5QcTHFvc4S9LgNryElsxTsX
 0sgaMi6B4/EtRnnDPIAcjCGDunF+nwWDbWzHPQg2fr7l2Doa/jAiYyPsBtFyEvbImqD0
 6R6MItsONRpgPVyOzuO1XCy5399BCqAwiFhq3Cpvui4lpFCJCth1H2Lw2iHTnNcHm960
 Frvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnbIfzEGEocpVyqXM0+92FZ+cySB2b92DtZIo3MXzjhmzog1q/Bo9wK7qBQkHAxqPbgbCkXTM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2/bQXBmusrHHGsdLe6H0a7Uidwp+EegwjyKPI3HsZcWEXY4rR
 anuq+Pcl6rychZxk9dbEGW6nYoIs8zuFiwDKvfuzf3C5PclqwjAW7THHug/QNF1KZRNqNLfxMlj
 xFL9Ix97X06TSdFB9Npz5jTeLpVJW79wfoKHpdV8s3a1k7KUysRcPS6YO
X-Gm-Gg: AeBDievuSQjKHJ17h4jk5DwoI/kt9bD33OZ1J9laKQeyWPb5blc/kPfUgGXE9anz+zH
 5u53p8WURVNYfG55UTFTKl6uB9WUdv9egg5gsVl34TdKe1ANFLkVKgMxLED7ljRod5qVGAJVpyz
 3ODDogkp3kjoqw/DufZ/KPNkIWnXz7wFZnrRETRffygkFDpSIqRbKyn4VAI3x32oMFjCssto4hc
 ueCaDflsMg9HPLiCs77eOizlKkpJOjIfb2J7Mn24EwGczs3wN+M2xIfBKSesstFkeKjap05QU7a
 euChdDdoPex5O3odJdpSJslnWrRpIIj6Wl4sfw1mch4RFQ6Evup6nbGlr6Xii6eBYqZz4m67bnh
 yunLsweXbor3jkbWfwwV5aup12UbbFUJ/ICzwFNEoaV8I/SZgKKcYZI2vxUHkuA2/iNMGYN2M4j
 P6dWATW3/ZeQdJ3Uzh+pcpmO+xbKwsjLc8qxWShcNCaq8yAj9pk4I=
X-Received: by 2002:a17:903:1ac3:b0:2b0:673a:7c85 with SMTP id
 d9443c01a7336-2b2818ee1f6mr208653415ad.37.1775639543684; 
 Wed, 08 Apr 2026 02:12:23 -0700 (PDT)
X-Received: by 2002:a17:903:1ac3:b0:2b0:673a:7c85 with SMTP id
 d9443c01a7336-2b2818ee1f6mr208653085ad.37.1775639543178; 
 Wed, 08 Apr 2026 02:12:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:12:22 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 3/9] clk/qcom: add initial clock driver for ipq5210
Date: Wed,  8 Apr 2026 14:41:30 +0530
Message-Id: <20260408091136.2794546-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: z4U50w1F7BW2PaDmiJNYQFbPBIkf93DV
X-Proofpoint-GUID: z4U50w1F7BW2PaDmiJNYQFbPBIkf93DV
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d61bf8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ttnG5VEth79ohM5wMFYA:9 a=tjWZ8NC-rebGB_hs:21 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX3OLZc4jfbkB0
 4dW5jK1QelYuyKWwPrKp6ylOE4AN/UnbyrP2rvfkXYY2cq9F+JBZUFC8+Em7Ms+XxHB7riH2ogE
 GeVROrZ0W2bIwqquypg+/rRqFEqEAJGvF5GhTJCYOgEwk01aROSdqYqTAt95zf//QjgzfuCCKe9
 oe4LskaWiSdH2D3RpePkw/LPAHK9zqHSca6FzybPr4pR6glY3iQQsenv6XstxzEj6Ai20ikATSr
 smJlL9MbQBA7sVMGl7SYtKr1WE18zT8YXuMgIuKzxsWwbZpc7TU02DBX5KC8EaXgUPU5Sun1Jfw
 wvNFn+H0XOTeIE+mPwbPiOCGFSTeuBjKaZxH4RD55tqdWUYpWTyb2WkImYSMVwlr40Glvh5iXR0
 Hml/TK9RitkB/umBVyePIN3S+i9xSRSIHtpQftzBcWDcTuriLzvNArAqvQKRmJ/7Pxad9MtrMM7
 J8siUVedUuZyW+SUIcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

