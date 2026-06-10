Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9103CCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 05:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69C1839A8;
	Wed, 10 Jun 2026 07:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ty/y3LgY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eQKF+I9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2544A80086; Wed, 10 Jun 2026 07:37:17 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9FD839A8
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A2eeTY240975
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QhiLsCAFg0Y
 XuPxBL5XudWP1omdzFN9CNPUStseXFQo=; b=Ty/y3LgYb3GtuReKwIogInyEjDx
 8Ld5V3bqWqxXvGwUWAl3vppJbvgUG0bSZooFN+bpa1cEpp/bdCe6kxJhH5BD7flA
 yr48BdqIFOa/4kgjGzGqvtHXFHgPo+2Q67zmGqEQLMzF+7Bez9aV5nuDYzd+1Rg1
 hHDg7cIf+0tlJZn3sAnIuCYjAYzCtZnON+3YXT05/J1ycN7MtJLmjTPo72YFz/sv
 4GX5QhN+HpXO9hJm5e2isIiFFVm0zxPumFdxyhUK2MHNHPdGnHRLUfA3VCVJvkGC
 MnH+3FmCcAcvHGPvgGMHuEjoGWhYTg9Fjgq8FMc+rKryzY5EXlFiCyILOEA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epukesd73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso6074807a91.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781069832; x=1781674632; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QhiLsCAFg0YXuPxBL5XudWP1omdzFN9CNPUStseXFQo=;
 b=eQKF+I9LRcWGagZMlqsi7vByTcDS/cYsyFMp+AEJSzr6Yw0RJR74/OzNHQ7nUYzVfe
 aoysRovd2NffFe++JkgbOcZBHOeIs9dSk0I4GGkcw7O44gpX6wijmx5HGpTqxhQKkojE
 Um8eTq27eN/V8UX2fYbbelmW0acaFPcVLJSqfaCJQTCHvSZco2gzH3/UztqyBxsxXYj/
 3P52ia1DF/vKMwfLlX6Mx5YHOcZy20qNEH7Y06Jpl4dKjei8LjesvqkiMIA96wPyshf7
 SdIrKNhm3rmtbjDS/A5SqmiZc7ZPQcMCTCk0gdrGe/Iau7Meuo+7Pe9eooQg6tUNoEHt
 sN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781069832; x=1781674632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QhiLsCAFg0YXuPxBL5XudWP1omdzFN9CNPUStseXFQo=;
 b=ABk2oVDuQMxTCLP5ozw+zdsRfgMtsrFQ1rot792mo6mY2z2yxDI4slzXqF73f9czrn
 bDEA+AFc9SVm2Y5kpM/RqGh1isGwBinKJcO4nZgTSpZ4FwVQzU5ggyGFfuU/bMCl5O1g
 iophjSM210D7Ms+56U3SIjusiqBpUMEB+aBVNJw4+1CwISQZ6jungF4zPQcLsrtP+TaW
 s2VqyHb5oxTZL4Cfo2/lwuyALeLnRDas3hGZT+2DLurxe9dCYAaXzy9ZSgZtc62mirGt
 VbsN1xYP2vq887ksLiCp94+iaZ4s+1KcfU3EWFdV5E9XhTxP6AydC+MxwOgwLmfuWEyh
 nlmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9iLBg5GOjtGZHwcW5xzq1oYvEwp4oszyaPk4nJzwPU7+6b97JNZmlBWgQZfxUbARAR/3HkUA=@lists.denx.de
X-Gm-Message-State: AOJu0YzNAYFQpe8EUdGb/GORalZWo2+97DosOoS237OVvpU/2K4dq/di
 94/mQltStHDYhpkI8xBeZs2fpTXplJbmCNa3/6ZhgvnCViHsUvRz56HZrNkaN13waZ7ilodyLhJ
 3OTjb5GEEjE76ErG8bIY1WgLNXe+J+AcFo3MKHp5byW32XuKG5WzO4Y9j
X-Gm-Gg: Acq92OGbYlop/BlBsm7Uo1tEgYV15vcIhuqIajy6KNpMknMpWqWlNyD0eqKgYaNRiit
 bJsSS4IG6RPv1SpUXKtUJLRledAjhu+SLfFGUbhMb1fLHKNwtrx7BHBQ7pOqpHm9oJ+yJUU77mr
 idW+fjBA0bc8q8yAQrIiGwCnEpoI54LS3dIJsJAlUB8ctqI57w1kxrcPJP4/KnCxY70nzPYUDhc
 zw7Mt4yWFNUo3XGJ1Qs0vYPYZlzftW1CJ9KvbBN+2S9Fh8STaaUYmULaa1nNytJjWY34d0SCxfC
 qAtMdY4FeQe1im1z0jPSj7SOil97QQs8w5BDa3qWUY0FarSFfEMh04nd4IlfDdu9hCPfMxUDMj4
 Y3oFOWjjOdJxht9BIUhPYVBJ6Mxp/YSd2Ce0ZxJURD3yrw1Rg8LOoklBcOY+tl3HBiIO1H4IpCh
 FWneK1re6Irx2wWcbHN3+6R652gJ3sWAD1wLz2oweyo12XNs2mJiEN
X-Received: by 2002:a17:90b:3ec6:b0:368:5367:d679 with SMTP id
 98e67ed59e1d1-370eeff5ea4mr26495359a91.9.1781069832170; 
 Tue, 09 Jun 2026 22:37:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec6:b0:368:5367:d679 with SMTP id
 98e67ed59e1d1-370eeff5ea4mr26495337a91.9.1781069831717; 
 Tue, 09 Jun 2026 22:37:11 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-376467bab00sm831918a91.2.2026.06.09.22.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 22:37:11 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 quic_varada@quicinc.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrian@mainlining.org, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Wed, 10 Jun 2026 11:06:52 +0530
Message-Id: <20260610053655.2825589-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MCBTYWx0ZWRfX1ybqQkwISxQ/
 /l4/2qUUTkvPpUd/wbnCs+Ig/UOliLVs81EKqzQpf3BktaBjev0NRFrr77a9vnBdPw6z204wWN9
 1QuZFIelWEHS6N9YZQlEUEsu8DaXAd6/B+wNFyIarI469dYzNua2PQyrvBoHJ/71Y/rUt8xpbhh
 Ajd+zRvOjj+0xcyxlyhSJl0CW502oFnUDhhCIxzc8aHOIWCx1AG6gTDrg5A6StdlTu7Gz6wupU2
 zEBh/u+vaDCNzw7ftP+IqwcZp35u9FbYlsb58ta9A+x9Csj7+ekYBUeM2Ouyt50Z/uv4eQXs5FS
 BMAh+Job6ZPO0yoz2V6/ry9xRkzX8rZnBTZtWiW7D26BcidtH6Jnmpqq8r99vq3Xu4eh9PDKVvR
 ZtT1B3pLH4TmJhDCdmtAvuLizPEmmtb06Jn7z98RTZ/6JIchaN5KSdiO52lNyfqVq/aavrqAnx4
 RfOcqBqC6R6sylbo6sw==
X-Proofpoint-ORIG-GUID: W7btXOnrQBoo5qRQ2Bxbjf8QXEFqoSsu
X-Proofpoint-GUID: W7btXOnrQBoo5qRQ2Bxbjf8QXEFqoSsu
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a28f809 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=L1vh2ecjYAJ_oITB:21 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100050
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

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
Changes in v2:
- Fix SPDX license identifier to GPL-2.0-only (reported by Ferass)

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

