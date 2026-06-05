Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FC2CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C0684944;
	Fri,  5 Jun 2026 14:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0FBKuNU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kE9k2PPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE52084879; Fri,  5 Jun 2026 11:48:23 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B855848BC
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65598l6M3603450
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 09:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5/qKoX8McUd
 M4gbiIHVR93547/uiZm/9KJYOHOY1sUM=; b=a0FBKuNUUQR3GJ6j25J3PwJXlGN
 x028yqD0yD1Q8v2IiKYb/VCqUzPmt+pXnLgrFGKZ8xbz8GLKJuFsm5mI00oPjUMS
 dsbkqOUEV0IFwhlGjkPV3tVHFcM+vvvG0tugCdDOwoED++sqIr89lmbJbgFDqZBi
 cFYrqeYkvTcfWf/dVzm9/0z4ARsPvSSACMlkCRGKdN57YmC8aJSBdbHiOW5+uCjg
 fMGfFQkSuOCFpOrbiPpbYvnsfxTxBil0cC0Rc/I6ebWCNIw+8P/xSJ05gEmnOnrq
 AaaqKJ1QcTEdFONDRSKpx5HoVXpDPCK+3GQrFuanV/JXnwz763NJiqKBRhg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekmhf9rqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:48:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36b9d265308so1415388a91.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780652899; x=1781257699; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5/qKoX8McUdM4gbiIHVR93547/uiZm/9KJYOHOY1sUM=;
 b=kE9k2PPv1ruhE3LSsgMzxjStOX9FwX1F2NAm8GYA/QR+63XUr86b5bREkhPblXVduw
 9MMPAbUrOGUIactGwJWMT0L7m18l/tI3fzLGPxIMnS1zdP6yhiID56oh/ua1Bw/yvtLj
 GJpXU7ZzE2muP0lyCYlFBmM/Jqz+dFANULGyFydIoaDAfsg6VFu+PO0HB9CZxkaYj3Vq
 OXrvzt7b1kHNpkiwHpSh428zm6Z+HIrFv+dSIiifjAFIU6/igA7NfXrDaA2YWqtr8Vnb
 vPVB0TBEC5Ob8H/KXWI4UR79KIYhGCUtRnN5SUGP+PCL8TNNRVWiAyixFdM7ql0v4BWO
 8pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652899; x=1781257699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5/qKoX8McUdM4gbiIHVR93547/uiZm/9KJYOHOY1sUM=;
 b=DDmRy9MThXJqHZ8RI6/eA3wFtyQ2AWcwM3NZpaMdnk1kI1sIP0VtF7EDfJOqrrCO/z
 zFsgxWwHi9fPzIwDfmdnja//Zj78b/kr1eMo/hZR3w6VJ37K+ZLYMKr7jd40XkOjbiEx
 QZu64bskm9zzkT0iFkXRNtOk7oq7d7Cb6JEoHL33vhPQ8e+dPvnfbDH60sxm2UsseYnX
 TdNC6JS0zVjmI6MBNnFaytbwcY4Zp1r1MHMMK0yUhr7/+Mc4fSRJt7VoIqPuWeN/mS3X
 ki+/KDW0D6H2ekQKjwNsHGQI0FLj+E1u/ZfVMW/8ZUejW7VoXKC5XmypILCCfe5doLqH
 1JxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HeQRwy62c7oNCkfxX5kJFJipnTkPgSrLTqHaCuTX35QpA71LcuumiBJKgEUYZF52sPqjVFLg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6WPfiN2m/RkWtOYN8H7Kd4wOuetYuaEDBLWA4186YYWPR4pFg
 7nSbFI/Fd5VBwINIwEzzN8kmA/qLzcpVeoyX8rnxRVwyLy5QNqQvsBMN7v3i2hSnN5ovq0dqn8L
 c+bh2aXuQApx7kAH9Rl1QNzSWsBwhOVazoKkDUodYO0FTuG7QK5yctr0g
X-Gm-Gg: Acq92OG17QtYlp+FXqNIlR2PrjEFgGVVSsbzWvCoX3sgTBTpllRxI3hxfUeAZH1L06w
 o2lR16ISVQEDcLj2fBI7gbVXkeo7sseqn6haOUKhIe9Y9SvVsM5e08dkMwNm0hTDKD0rfLnyyn7
 AylhBmGVEjkzSr3RyhDi+PpsmU7FZzqQGgfxl0/yDyAM2d4uxhs/GaBcXI50Z/TkucO8EuI7o81
 c8lbRM54I+9RaV+4Y0mEYXPICJQHR/wBm1WZ3dSkXBgFrnQANR7UCjeBG1qSK9zLFxuyEBVA2mo
 t3wgD5z2DHlXrmZiy82Lj82s4PGBN2Mx7xEn7zPV9jdEP3Jh+rLbI8W4rsYFL+c9lecxF06CJt3
 Q0aVag20nthMyKhdGzoRETNtTzrb7KMS6/VhRYcXEi3NJOWdAQnH6FtPjtD2OmSSIPxFqQxpAPg
 Qka47Y9iXAXMvKKaRLGeg4XNt8filZiMXajDucvheVVq4rxyLXYH4Z
X-Received: by 2002:a17:90a:d40b:b0:36d:d8fd:4578 with SMTP id
 98e67ed59e1d1-370eee04b97mr2837362a91.11.1780652898831; 
 Fri, 05 Jun 2026 02:48:18 -0700 (PDT)
X-Received: by 2002:a17:90a:d40b:b0:36d:d8fd:4578 with SMTP id
 98e67ed59e1d1-370eee04b97mr2837333a91.11.1780652898362; 
 Fri, 05 Jun 2026 02:48:18 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm6208237a91.9.2026.06.05.02.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:48:17 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Fri,  5 Jun 2026 15:17:58 +0530
Message-Id: <20260605094801.4130128-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
References: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5NCBTYWx0ZWRfX5G5LGEY0JU2H
 MGUhrQFfX4zQPzZ3Va8Y1XoRGzebtUiU5d67lLo2/87kWE6ZsWf2WH5FUpXxbC9t5IGTBloX70C
 5PMRc5/Yfshy84e8iFp2Z56tdM9HWtpDCratB+ioCaPUD5PnTdLG/YLQtIDH0zfa4Oc576nJv7L
 b8+fy9rZapC+tQeOZlF4iv+xiz4ptc+3jb2oUgmodZAbv3UZ7JsQrzgDSk7PRayUIDDcbBH2vjq
 w9fDmMG4ES5p0HoH8an6lSnxvhfduvn9OHareUIrzNcswPTjawRHK8uNuLS8WT8gxVgPFNB30eS
 PBtI52PUJy2qBjoQXZetL+kv/Ul/vEZpz4SonOxHSF7WOrwBxWD0kV66XS9Ul1TK0lyPhaw7zST
 T59WBrHhCbTrgA2i1xwFtWESVqbWQ6Y4Lf9xkKWGp3NpAIIaB2Ij6RndvE7Oe7u3FGHC873OHuw
 pe+bVW/+FPl2pdqwJfg==
X-Proofpoint-ORIG-GUID: IJ85E6pNLWu5UzoWlR8dqrnpvP-d5-8M
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a229b63 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=mXSKdTlMQTHl_la7:21 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: IJ85E6pNLWu5UzoWlR8dqrnpvP-d5-8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050094
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
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
index 000000000000..0079797e63c5
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
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

