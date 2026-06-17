Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7014CCD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD4184A02;
	Wed, 17 Jun 2026 14:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vroje/z2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EY3i/xpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06394841F2; Wed, 17 Jun 2026 12:19:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1028838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UOCF1703206
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IiYLBz0Msfi
 iEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=; b=Vroje/z29TyPzDDujEkrRdneTXe
 78+zEa5uojTimp8A16sh1MxioGuRz+Vhse62VxdSbC6XkU4QRrrPYSO4si95rl69
 ewGzo80/hmZp7IO3WFSJtWxeuGuSXVRpEiipZV/J7zg0GzaOzbge41iL87egec5q
 wRZhKSBJNj2GCWIqjbJ63IsTYZgrD3L5benkZA35TRbkkOzXqERTjpyln6uDrlPa
 H7cT27+hzkbVByR6uEtzgSzXp0CR9+HkAuBBgnZHt+nOQiAJkKM0Y62JMWNwYOkX
 G+2h+KMfpngQ6Ua6UUuc+V2BqLz7OfXKwf8CGRPgeTmSi1DLkksQTzdVN/Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet2hyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c860544c077so6975435a12.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691555; x=1782296355; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IiYLBz0MsfiiEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=;
 b=EY3i/xpbycdAuot7B3Ige5KbDoD7paZ2UPeZqse+w/idoCoGlGXZQ7H3mWLZEjRvmD
 6iL8W6xVRz3Rgi/vOGs6JBZqVock27lmYlOm5UgVobFwgp+CIBx/2zP1aEVYar28c63k
 ygV55H04gNwmQ+P5c3P5Kxdg2Rdto75CwerZxoDJ8EplA66YvhkrPVoa9HFJVPJMI2SD
 tyeW0y+ZYMMhhzdRADNM9Pbk1cm84kDXAZn/H88WPYg5rc19tF4EB2bndU++M2FgX5LH
 uxLtOzeoWFuSJFV5ir3QDhByzCy19WS2aD4BtZ6q7fs9RsSbc9EDQDxUJc9Kx3EUwsSi
 SSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691555; x=1782296355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IiYLBz0MsfiiEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=;
 b=XPymPF3F50HdVylD7R1ywcxE0XgoXjzH9Vc9eC9nVj0oA2PWXDJ9Voc8TL8F0oouzv
 Re8qd9o2MwwdAZVqSq7APehphNypGSatfxDxoHvnRACq+cErfW9edCVC1UxqeMfE5V76
 qJXW3qA7+PgW9tOaSPce291EpZeuxRfMX8azQGcomAeKn6ETorrTR6N79eHv0lXu7Ebb
 Gs0Sl4aPm5NT2JKNKQw1JKSKc/kva7SgY4LIPM3WG4a8qU+GM3B/73g5sy5L4T1PA+d2
 GX+rmHroqwuNF8jAymfu4kuEsaWwEimyNv179s9/PR8fB8bC1c5ygR2pODLj36wcFIvN
 5opw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ife62orP4klAXLPdkGaErxiyB3ZbgUuxR+Tz3oPrv3+ky3sCzN/nJpg6CnW7w7WCEg+oJh4w=@lists.denx.de
X-Gm-Message-State: AOJu0YyRjOLMchT6NVHb1uxiUV7eDjmhIykRQKWnganeuar708kDTkSU
 39VuzBp8yX5Ao5b7vFNLIeA9Qp8wAvj9kNfarYkw6GIaOTKg7Ig3v5SIabixRN7yXCHbuU/QFNh
 9Ks1TQZAICrLxWfN8zWN1WR95LhT0K49o9agnzyE29YSj/rUNRUbV+XOJ
X-Gm-Gg: Acq92OFEymtlqFMzyTO3zAgpftyO1uQNx6+qJKfkk8bQtWL2FEbxiSoqgyps0d9Y8+t
 t0TL5OEIaIoBm/JvJ5vuIDQlClHn9zOLTsonKPcAOBIMSAVCOE7WL0Y5MMHS1DCpSoUZDWcGzOR
 MYov/a35EN1jXwd5upgoldOip6mA1qLMxwYwzy6nLgj+tof/VJawOtU9wegXtWBhoactr7/eO/b
 nbUKS75N8OsyjCXtfaC2Vs4sBBO39q8GnkESTn8tyinblMTgOalOw2vI67pP4LmQp6w9/5/EiAp
 jDiJ4kYpOs1cGimCSWNuNfKpTBFEuvgbohOwJ4zzAGA5KBK+PYuK1DjAEH4OUcYcBudf74jZwe8
 ppvZIo0ySnROf2jdwQK6SJBbAf6KXCzZxNhHYwtBM5EE+pqEoCe0vWIfj8cAWkEC9eUhqs7aEta
 vY3zYUGHU0vkfBFti23MeD9mSnYmqoZ3fFdumsxZIJ
X-Received: by 2002:a05:6a00:3284:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-8452452b1e2mr3187490b3a.21.1781691555159; 
 Wed, 17 Jun 2026 03:19:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:3284:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-8452452b1e2mr3187425b3a.21.1781691554502; 
 Wed, 17 Jun 2026 03:19:14 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:19:13 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 04/13] clk/qcom: add initial clock driver for ipq5210
Date: Wed, 17 Jun 2026 15:48:03 +0530
Message-Id: <20260617101812.299586-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qau_78xpZ5bhupBc3xuovhBF0_yNTVdM
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a3274a3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ttnG5VEth79ohM5wMFYA:9 a=EP1mRVKsZveAJn-p:21 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: qau_78xpZ5bhupBc3xuovhBF0_yNTVdM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX8rRqhPxfzbsN
 6fQddHDE8IYssG5j/rWwnzbao7EgMXiT4XQyOrHxRjmXWOOWHNGlq87L1WQLw7sAphi/h8V6+ox
 FGZ4KyPXUodYTFNnin6px6FuW9TfCRK4FvUtPKshLQmLRYtNp4K5F14QsHjbP8LzCLZgSDf3H8l
 ryDOpXa3hO5RPPmjfX6Ww9y1S+P5uBCm8+saoGpYdybsqonp1o/tJv/G+IrbSYugF5pnfxrIiL/
 S7QjY3JxOB/GH9/LTLxqgOuQFxmnj6TNapprsh4mrV0koHud7/I7ZyEuxQ6EfRPLJFfh1doTnv2
 dNfO7n0WRUIr98uWkdBHUQ2CDxOae/7AVnHNjyE17qGnLpGcjddbPfrD3Q+wi9UsLNGelP2P5ID
 vrJ+ZEvWSONaSqqOF2SqeUu5VWYAfevbew5t6vTcc5+GPdAddc/NqnBb6zVsO4BhroVPSVh2IRb
 r3qEEIGItqnPmOZGCUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXzRehhLubVyq8
 HOHRVVCNDYwNCT5jB67OngOOVKIK/wTv651KyErInIgj4Z5cnf6ivBHN/V5rD0xlyuCzQWfOLb8
 t4t9dTQFDL+Eqe3p3FfzbPfRMOhDGz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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
v4: Add comment for using cbcr_reg instead of reg
    Return error in ipq5210_enable() for failures
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 98 ++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0a2ce55aaa2..03eace6d8d8 100644
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
index b96d61b603e..845587a23cd 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
new file mode 100644
index 00000000000..2e6037b6410
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5210.c
@@ -0,0 +1,98 @@
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
+#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
+#include "clock-qcom.h"
+
+static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	/*
+	 * Since GATE_CLK is deprecated and GATE_CLK_POLLED is being used
+	 * use 'cbcr_reg' instead of 'reg'.
+	 */
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
+		return -ENOENT;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
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

