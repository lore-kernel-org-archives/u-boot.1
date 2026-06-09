Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26281CD8CA7
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 09:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 997AD83FEC;
	Tue,  9 Jun 2026 11:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAca0vII";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PBj8M/JO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CBE84704; Tue,  9 Jun 2026 11:19:52 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173BE8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6599JDhE1816027
 for <u-boot@lists.denx.de>; Tue, 9 Jun 2026 09:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5ETz4b+/E9/
 TqZqWEIu8cGlYcbziK8HUpgnA/5WQbTg=; b=hAca0vIIsaOv6Z7MgCr/eMSDGTl
 20NhCCTEufWFr/pnV/8g5f6ORi2IXBzv35tqA4bwPUz8r3LHo0KVXj36qyM4pic+
 44p9ODYOwtt+xy7scr93sVB/Jk5ngWEEd+mtgg3V4/zVy82xXjeqaFeMAvFrQL0f
 0XFvK04YShCQ2UIRHUEjtrZiiZEBToa9NZ/h6Va0lvpVQ3EmVilMfKU8zBCzgM8p
 KNBDNbS0uw7d5d4to+6R0gT+wugXGTKTHjXoU5JDKqDqzyRl8bUqREg3GjkfOsCI
 /7V7brewNs1ESngKoH3/i3tps4pyC9AyrGIazMOoxNuHw3f6PDF/IAi6aWg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jr09x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:19:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36bcfce8a33so4884802a91.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780996787; x=1781601587; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ETz4b+/E9/TqZqWEIu8cGlYcbziK8HUpgnA/5WQbTg=;
 b=PBj8M/JO3N6lJhFzidjZde9XUjqBUhKjlMOu+Q0tU3R0vp4ju88BZQ/747mHv8aAig
 r8BXOAK+VEMEVADaaSfS06RCZi+e60EEw2lCppMjzNC8vlXfD+dY58jNJnqb2wxx9wwT
 vkA5T2632JxKer9o1jY2BOlyhQ9A4Rw0AfG/zDM8qrzhyC8oS8e1ijBrd6z2cvTJG/x2
 iHki1eTfZZ3HLIMlcOH1PiU3o8lHJJejyMEeEEVx6qSSKuJpn2FmhcGnv1og6jLuUM7r
 H2fKm33ZsUomg/KCfwFNjO6cC5bh6Q+hiSIJftfGZ4QDwZs4AZ/qTUq34y+ntAzhm0FF
 YHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996787; x=1781601587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ETz4b+/E9/TqZqWEIu8cGlYcbziK8HUpgnA/5WQbTg=;
 b=YiEr/35PY8TV9Sj6VxYW6KEvdKyjxr4Apk5PzNdeIrdaaMV3dT2q39OvN2ChKzk+av
 sbMBYySdGZ++75C9ficibXV0m36fkZ/ujr3kxeR6Fxd4PK1Uv7ZGk8VL2n0U4BFGpK0R
 4y7y1+iibCaqwgRn//Od7FBDkQsibVW/TS3Cdrt2OmIv47hli196KSPJMzvKX2Emr2+i
 IDtbf38vlWeLjSDxJThU84KGV6RsUtVtbiVsOVOBgAymkq5tZOazKQC/FZJk/YFVC+tG
 ypP0brATdtTPUrv2OzYGK+xB6zkvj4BF1KF/B7likEHqLGAnltnrDaVGnUxPl77p9qzG
 cmmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8imwGvwmDEls9Y9lFCielYZNskZ1wcJGscspWktJvoW7tE0Jg/jlysmVGC5CuXd7ZI2qnXHBk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9bdiQRzqkiMTb/g5nSwjKP2tL86jBAYvp3+I/zQ8XhdoMAQvE
 J2yeBWgAIo9AbzpetVuPvOpplP4UutRNRr/IGq/NW6o+Sesg/I0Z/TTBGK1EhAyT6rTBVpxdxM9
 oZWIzmgZEM6PhTVwpeqsZiqI1t/aVxUmQFAMj56wmRDrLtkU+owlkVMf0
X-Gm-Gg: Acq92OGMU3DHfTpIMvKCXPes3dFO5FdG0LLJz15+aKydQD9IsJiq5M7a5d+/0/S8BEN
 OJy19z1SS4RDEVqkGD8PJjjyT9ojzLv82NP3Ge8AESdbs5vxflwQx/oOZlD6dKLEYsTDBbR25rc
 3IYpawjCKYw9cqm4kEzxFGXgZNl8fqO7S2eGCSOB+tOTu7+peX9c92MrukVXEPncKBuN/3c1un0
 6K1Mb/HJjC/q8T1GwhC4Sxy4l3sCJjFxyKxDGOMznn4The4P6Q20OAtxPn3ytje/3Jeh/yoiPPn
 dW/R5LSvOiGpoHq6xjY8P+CHYBoUbcp8sk5MMrSNalFeb7l71/jA8ZMAXF9Bgo3vRy6Hw7sMj+E
 9zAEw4zrIsDUEF6+MS5uDrOlpB4PQqHIZW8e0Gy7b94mi927e1VDgQChdatILHqy8cTYRXTxkOB
 2HC2BDr2u1QePOqfU1SieO3AkMf+j9LUUgQtO2nqWrg1EQamze2zI8
X-Received: by 2002:a17:90b:570f:b0:36b:877c:42e5 with SMTP id
 98e67ed59e1d1-37133372f4emr14040701a91.17.1780996787456; 
 Tue, 09 Jun 2026 02:19:47 -0700 (PDT)
X-Received: by 2002:a17:90b:570f:b0:36b:877c:42e5 with SMTP id
 98e67ed59e1d1-37133372f4emr14040668a91.17.1780996787045; 
 Tue, 09 Jun 2026 02:19:47 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf90a32sm22851397a91.1.2026.06.09.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:19:46 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: funderscore@postmarketos.org
Cc: adrian@mainlining.org, aswin.murugan@oss.qualcomm.com,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 casey.connolly@linaro.org, danila@jiaxyga.com,
 david.wronek@mainlining.org, jh80.chung@samsung.com,
 luca.weiss@fairphone.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quic_varada@quicinc.com,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Tue,  9 Jun 2026 14:49:25 +0530
Message-Id: <20260609091928.1564605-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
References: <tg62gv.1na72fsokrnbj@postmarketos.org>
 <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VTDqokO4FHdWbjJxh1cDe8D53Px_wuyt
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a27dab4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=QqeWlPCOr2Yp_u_M:21 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NiBTYWx0ZWRfXwaU/EWgyn9Ne
 qhiAYDzPJeODXViBTbm1coK2nRRX3tFDISsq0ysFPPBeATVHkPk08o9Cyie/PHaDP3cssnd4ysm
 WLOb33xBPX/DOAgvlipxcRQ2hg6OE1tY/+jdnpvBX/UOPZlUY7vGYDYvZu+pd8eFWk8ajNOyIZV
 B1r9Em79YcmarKJOpHsPtjowFV9Q5eZmtm/mRJJRpzzXnsPjsC2ZCLBh11x/8VE4Vk2H1jLYs0z
 B2jrbfgkuT/KYxeQXQLV7UxL7BHzGSkSA8NiePQ3ntkSta81hGsFAPiSCvfJo2pJXRPXBBMRBE4
 NpJn6IGMs1D87PiqGO3AbDkseW1MK3LP17h0UBdh5yMg159G71PoU8Iu9PIXVXFVVpBSVT+XlrA
 aemBoElICAjSt7/5Mg9MWzoNsEYW+DuxztUBRiE8LCG4H4Mef2035ObztNAF1CRfFXFfHj1+aQM
 kS+EtrlXDpdmKNzVeXg==
X-Proofpoint-ORIG-GUID: VTDqokO4FHdWbjJxh1cDe8D53Px_wuyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090086
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

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

Changes in v2:
- Fix SPDX license identifier to GPL-2.0-only (reported by Ferass)

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq9650.c | 95 ++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0a2ce55aaa2f..82c56cf605a8 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
 	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ9650 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_MILOS
 	bool "Qualcomm Milos GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b96d61b603e4..6cf069053743 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_IPQ9650) += clock-ipq9650.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-ipq9650.c b/drivers/clk/qcom/clock-ipq9650.c
new file mode 100644
index 000000000000..cdac71db4e1f
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm ipq9650
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9650-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_IM_SLEEP_CBCR			0x1834020u
+
+static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE6_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
+				     1, 2, 217, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
+				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
+		return rate;
+	}
+	return 0;
+}
+
+static const struct gate_clk ipq9650_clks[] = {
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
+	GATE_CLK(GCC_QUPV3_WRAP_SE6_CLK, 0x04004, BIT(0)),
+};
+
+static int ipq9650_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id >= ARRAY_SIZE(ipq9650_clks) || !ipq9650_clks[clk->id].reg)
+		return -EINVAL;
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map ipq9650_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq9650_gcc_data = {
+	.resets = ipq9650_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9650_gcc_resets),
+	.clks = ipq9650_clks,
+	.num_clks = ARRAY_SIZE(ipq9650_clks),
+
+	.enable = ipq9650_enable,
+	.set_rate = ipq9650_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9650_of_match[] = {
+	{
+		.compatible = "qcom,ipq9650-gcc",
+		.data = (ulong)&ipq9650_gcc_data,
+	},
+	{ }
+};
+
+static int ipq9650_clk_probe(struct udevice *dev)
+{
+	/* Enable the sleep clock needed for the MMC block reset */
+	writel(BIT(0), GCC_IM_SLEEP_CBCR);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gcc_ipq9650) = {
+	.name		= "gcc_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9650_of_match,
+	.probe		= ipq9650_clk_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

