Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD4DC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA1884B44;
	Thu, 16 Jul 2026 08:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kiBTvH/u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L+eId7ZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5322C84C39; Thu, 16 Jul 2026 08:29:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1178284ACE
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wI4w1451622
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SXt2zgr/SAX
 t0RaRM/ahD+jpsqUYMjBrKfKDBn4Z7Ps=; b=kiBTvH/uLsZkVreclTlJ1DuEBhN
 Y2lSmZsbmV/UwxEmunbLniYMdkNU4XTV2iSU46t/sswnC/+m06Hn2dWLa39ppZiB
 psB3A9B/uBQncPtcnWnQ0UTocIf00CvNQaqPk/lrB76J/mcaYgD3WtKK/h3piS+Q
 0/uiTA8VO0y6V68i831EBQSlbLOuRvzvvN3z9+llzybpLDzebaw//bUso39R29ek
 L+QuEyvdhS4Zblfbzoe/brexrz7h4udezi/fzHEpMf5Q3O0XcL6VLr4HL7Qxz0xE
 7txi3aXvaWW0EkWyVyacKleszC7Qlb4m12sAQm/zDJ7sxItxh4ZkMBMphfw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecnyaysw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:29:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so4547313a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784183362; x=1784788162; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SXt2zgr/SAXt0RaRM/ahD+jpsqUYMjBrKfKDBn4Z7Ps=;
 b=L+eId7ZShIWc5JiQyDPKJiLprpPlIf/CZ/NBaxZXugSPX8kuaaermZ2Xz1u9AIaCgZ
 sJIW0iAvT8ul8bl/0NqL1l2SolJcsf0D7iY7qk6G8UxZzFodqVZCRWw6eWYrL37vDUqV
 t68gwKiXga/PteTues2blCTKY02x4D/xcNxwQVQYvCSydIMMgeo6x9n+RoYHI/qTyU/D
 fpaORuaOE99GrnSzzsjacVgCPnqPU0HLJaSNtJ8RlbpHL0Gq7JD/ygGSaOtEul3KXVxY
 v9mNqK3t77CrxFI3b/FXYkHew/B6aABZa7GbGhC+cweP+GjVXpCnwS1Nrx9++jMvopf0
 QgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784183362; x=1784788162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SXt2zgr/SAXt0RaRM/ahD+jpsqUYMjBrKfKDBn4Z7Ps=;
 b=GbD3IOc1ZDVMociDU8KdlkQtoP1I8IwLI64R+8JGESfnoNTS3wTTHU2cOLKmCDVniY
 xMcti5Q1csVq5RbiGfA0XExqV1nXX6krzcaCjnsHCNw5VvXeB5B++WOtNwxE8b94PWoH
 Uexoan7x7tXlomBbpHZT+KFHhmRgVwofb9aET7T8UJ5rWm5rg73TL8NRYBJPADJH/Q83
 1gNHEYHH62PU2g4DWt2LPhuo3X7s+niXVsNDmYOwpft5BcGaNJSIBUK1H0KFvhpVfRWZ
 c/oYtVX8ayb9z9cYNZ6jbDHK4G5IULj6VBPkJzzclpI7y9ITKrFgMhnqMldsr9yRo4OW
 xZdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF1vhImy6HYyerWI4xvecET91iWVpiSWnAy1qxyPg+VtUQzY1aLIHyhAiKsOa/pKK15xeKryU=@lists.denx.de
X-Gm-Message-State: AOJu0YxY652j2wF3Vj8UZEuEKXoWDcvqSQA0PA/z0pjmbfpcrG7NqWY4
 ++pGIIQar5FYhD01Lyeoaw5Y5ToNfE5AztVmxHGWhlb2rIXqjgGjnIQAe6WiYFzjSNclPj8JyWt
 j8C8U9QhXM5TB9VowT5RHSwjJVBdmMGiZIcycXXH0FnEWQ3j57BRRdm4U
X-Gm-Gg: AfdE7ck3OkGdV6vCI2k3mltcdzpbshvJ4ET2noHjECL/GN3EDgKWY79XQk05bDuj4zw
 wW1nMbuB3FtXoGM+yzMnSqw/KINDeJICFzRio/+juDZIFTrndsUM1KleK71RrsBD9OlkyNotUE2
 YOjbuJ1em24M/2aSp3fcj3uyY6OaZdYHkxGZrEXrRkNAzdRzXgkCYkNE0nmib6nD+Z5FL8bWodj
 PvWdpGfG0AmumSfglXEkrdjsPzmrUQrWFtj3ro2EspTb61BmRqrYucthekI5KRdW0IB+z1T6wwk
 fvKTJLJMRVq7dAqyceLEEKXmtuBPiZHZAS581FKEtfiKsnPNa7soimWEZzh8toq0Q285cJw9hao
 nyJrSklQIySkqrn+/kyt/TUyFTDzb/WyNrE5e793ZzHEC3j2mW4hEeZwfD/QHP5LA35yrx7RDqh
 wbXaIkabElvjXO/lk=
X-Received: by 2002:a05:6a21:a383:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c36c1b60b6mr6634628637.32.1784183362302; 
 Wed, 15 Jul 2026 23:29:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:a383:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c36c1b60b6mr6634586637.32.1784183361732; 
 Wed, 15 Jul 2026 23:29:21 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c08eesm9895966eec.21.2026.07.15.23.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 23:29:21 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
X-Google-Original-From: Badhrinath S <badhrina@qti.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Thu, 16 Jul 2026 11:53:15 +0530
Message-Id: <20260716062318.4121929-2-badhrina@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
References: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NSBTYWx0ZWRfX+PWmp+uB6fge
 dJtVSkFy1p3Oz7jSujR0Ibq7TDCBl5pATAQR4DOvAOaHtdWsc+6J68FuCOOA7w4gcNJYU8yZbFn
 yYHZTxdYfhX11k1cdg7O9xPxr6xLvyY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NSBTYWx0ZWRfX2Ax/hJrpLyo/
 H7qS8QQxi4vBxSF+y2ISUsW9W9WVHHSPZyEbBjwKUEpvEmbXBxnaFKsUwAJO8R+0I5h1FJi4Ono
 IXK2f+0d0U0aFWhj+EAgBsry4OZYiNDKE/r4XdxUV/qxAtTfoM5P47+z1X057lYo6mQeC6qITz7
 Dt/MD8F1vn0i8EtJ1Q4OSo7WuR3CdC0xUSzzopvDGGuNxOr+XkUixGP5xrckMIozcE5j/qzP9sK
 J5GBbMC0BI1kRIQBwCHl3sXKhE0gxTEC47M2z4I8mI+qd2K12TWwSnT3bvVY3LMa8sQXy2e9lWl
 7RRnMbwE6xJ73Vo/sed+6e1C2wCPzaW8w/VjuQiMYEgG4DmJoB5zUMGFaOFTV/o0zk0qstGzqr3
 AY87F+C8IWvmXPT9glTpIKpTX7GnSLaIsMe3V/hzykP30/zagasp5KHfdl5oMG1gmH+7kpBrnWq
 D/zlInFRWXKqmtX99qg==
X-Proofpoint-ORIG-GUID: 0_x1l2RdgkC0JmmfUYHl3tpcGt6PBSKd
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a587a43 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=BRLJlIkkg0oSNjNo:21 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 0_x1l2RdgkC0JmmfUYHl3tpcGt6PBSKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160065
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

From: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

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

