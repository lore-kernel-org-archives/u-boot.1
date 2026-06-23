Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF252CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F1D84A0B;
	Tue, 23 Jun 2026 08:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hl8RGjhE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dE3IZUff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F12849C5; Tue, 23 Jun 2026 08:48:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95608848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6caOX3646651
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IiYLBz0Msfi
 iEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=; b=hl8RGjhEyvtcyja6Pm45FTfdHMc
 R5dBdyT9xQILeu/EDd7KHLB5LFIgVSn19kTGDpK1Y/Hj6gcKWwJ8/SHTiw08ndMb
 zAWRzSQbqGYe8OQbO1x/U5V6uE2LgQ5hHbAP2Y15p6mzEsjc1b6BFNCPJDsmDo0z
 0ZC485TbNG22jcYcc0Q58RLekZVjX16EyiqPpHimkEdqlEae3KBQWOj8SlX3QBpG
 l4c1lm6Wzpk6Cb4QqNlqMj0ncx+pucCfbUXo6hOqdS7Nf6ao402nLvNUewfPEC7O
 ub3whW2HXHla6VAjxS6AXHoYNrlloyrpth/Rvprj3idMHFm4Gg6ViILfmpw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmu3cr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:48:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37c9d82cd57so5484891a91.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197326; x=1782802126; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IiYLBz0MsfiiEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=;
 b=dE3IZUff/BanViBykhlrYqWzLLI3yzWY4CZbXnLO8SdssrwJhppqu2Ni2eBOydt15f
 7rKetOLHUoPFsilH59pz0nfDd075W8xBDN6+uW/28grgwCucYaQnz9JVxfV1fFN88YGp
 GwJ7/q1YglCxQURMEm4cjwxrcsr3hL+57ri/pogYx0ia16ZHcuqExTDsI2eFoNru8bZN
 qkOI1V0AcxhQXvpgyOPaM3b3o54vpcSc+KxE5iqMYNAh9ZAEKD8lxU9k7ftsQRi0UXfm
 mDTVv7tOZyhCzy5BCr8WQ3xGzi0DJD44me9vgvp31Tkr1GJvgzslyAu6lWU2gJmJJI9s
 k+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197326; x=1782802126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IiYLBz0MsfiiEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=;
 b=IcrijXalgKW11Jx4GtSXSuaLI+i+Px6VPgD3m1XA5hoADfqcdgPEUcCZ5t+JSeeOm7
 VvVNiHeHxA+DOm8ykpF4aMqrov0x5jtP2948i0EAn8N8cLmvGLLVGoPG12THodY/8rXh
 RNQOdLk85s8v9+GHCZOhuTubJEhfCmxfPvI4sbgUqYZGHbdQeZIt5XH4QKPQifeVT8X/
 GF/CqpoxNUXOE/t72CCvZw1dLR7tbpoO5ie0DvzGGhtRSwX5UKF9HCGrV54UClXOa25T
 o9ZmdhGeMTczoMi3qKgoQd0UoUVj2y2sJXChiTOq5MeuvWhHWkNAxVtZJag2agn8hdsJ
 MkGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF5pqc4kvcyvZl/hN6b6JDCHXGPaMgJP1qq2coVnxmkU1MC7MyJwMzfcnZC+eYEZt+dz1kr6Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4VJ4G4xh1dbmu79xwEAmjjY9/PCU54f+QljGgRLkgTXeI/cNd
 a3CWFQxOZi+rmHj6LHcG9VxR03RriicDwiOZ1G764eBkftI75IfF57/yhTu1lk4BOmoyg75zAeM
 /FsRv+zhMACGWmnZJBbAzYv1TWCUdmsxzvdOioUwc5RbS9l2ffP6on/wE
X-Gm-Gg: AfdE7cmNPhfcQAV0amBZADWp/h2znsn1XFSKbbiRwonWuiKDk0FVuJXB5txhTJa3OAx
 o+UFoixUjAFbCoELKn9AnKmc/1+RfDExU7890QYfrY9W1jdnwYA0Oe8inheOg4HFgRC+ZFQSKMy
 b4kIn6LkcjDDPHGZQcM9AO0217xWXKvDDyXklZegJum4i3GGpr6L2+FCGtjQof7o/Gv260p11vx
 HVd/LROeDarpCkevED4O/bnmZGShArQEFSfFfSY85+Gll+usaex0azHOb3l3nw4xD7ClXhl8O8K
 m41sLUNC1b88g8DMbuT+B/3rznKeq87aJIyQS0jY2cIdynuYksx+H64m3zobe6ohF1d0NxweAJy
 1McHRU5bgtRptwIaM2dMlUhQOdsxraZ8zvyYCXO01q0oRjBPvV2oUNTUn3b3O4jiuhnfD2iIauD
 QEFfelDtJ5eixGGLzwOtQHhTnmgw6ZmYCyHl4INGy6
X-Received: by 2002:a17:90a:e7c9:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-37dd16ea27bmr1509952a91.8.1782197325911; 
 Mon, 22 Jun 2026 23:48:45 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-37dd16ea27bmr1509918a91.8.1782197325373; 
 Mon, 22 Jun 2026 23:48:45 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:48:44 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 02/11] clk/qcom: add initial clock driver for ipq5210
Date: Tue, 23 Jun 2026 12:17:55 +0530
Message-Id: <20260623064804.3988799-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX/bV/gY33bHD4
 0GLcSGySL+JXr2fh8aiHiPjqjwEYCyvcB3N5SqCtm/MS6Bf0D1gtwyZOz6qciVj+z5Apyih1NkR
 iKJIrjHEQ0JtDN4Af0JJ0WodMC5wMzM=
X-Proofpoint-GUID: PYvRdFK1NvFtJVDwXwVmpgptbjCA2CQ9
X-Proofpoint-ORIG-GUID: PYvRdFK1NvFtJVDwXwVmpgptbjCA2CQ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX7QMjT9vLh9cZ
 ErgkWCbrXMA4MAfRcLJHcK8xKfQ/4e9ni7oEBJdlIAFCThz2mx9SJ7LJjOBJFMt7AHdv3UOU7qj
 6jObmlxLA+gESLHOHElG3wFDwVWf6DJ95ISSKKIqAxoMAAD7PFpP5p7hvshw1SznJbk7TTe2TVy
 4oV+82YlyPEWZpoNbVFJ53Locx1qVv7JgYsc7wrIJTokqmquUmFMPTTasCUsReYOa1m8QwrTEwN
 iQPPZUezaBdg79vBH+efLoKV+fKaS8Q18tRpPLeG5N4X0IYktN0tCMFxG61tQHzgdcLcFIoYpW8
 b0vgVZby3ZgoMYwgezNQMrGvdlGOiyzMmaG9gZcsdCw1jHYVFVAURahxHBj1ZCL3XdHri3HU2RS
 z6xTmXg84cI1oje8v8AgDUGa74Izx83INAGs6uLoNJp1GQ0LAk09BqYAI4mQovt2i+V9fGD5cYm
 dn1mOKQsn01gkcaPw8g==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a3a2c4e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ttnG5VEth79ohM5wMFYA:9 a=EP1mRVKsZveAJn-p:21 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

