Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66C6CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AFB84957;
	Thu,  4 Jun 2026 14:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDFHiwKS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TcIycKk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA328486D; Thu,  4 Jun 2026 11:32:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A340084868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6543na6k1993494
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IiYLBz0Msfi
 iEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=; b=hDFHiwKSxC6WyYNXCQbcZvfMD5L
 xWZNuuXSF6iRUvwlUBZQr261hog7WXMcxMi60PaveqB9nuB1FCOvW6vWTmLdBgnj
 M11hJdXBjQPxumFiejEr1sxXnf0uBCxcuQYFhbMzBbEDB90Cm77Z7UAavjBDoP2J
 CvLV6XjkEmGNN8BZ28/8T65zuOCOqqUQpw+kE0V9CkljkUpI6yGH8Tx9SZrPYf8i
 Rjy477+mGVxLDSrx/NDUk2g0gOiUO9VNdHCh9wqKzlZ7ZOJLWX7vr4hR2qQqRGub
 cA8Ye922YEvYuCziy+X5T/O9glW/sIvG7lbe7fl6fSj6QgQeZMXQg+5XHDw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8pty69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:32:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d992fa39eso668548a91.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565555; x=1781170355; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IiYLBz0MsfiiEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=;
 b=TcIycKk3tJhocRJqxDKR/T86+wqLwzDrelv0ucQdvdwYRnGNruUaVuSS0QmL4U2adO
 y2LrxboOIxqc+wEtiYuMBZSfgZRgmrL1kGF9Rb8yp/whFQ3NHAjwrLjMcvgTBKUYfPpu
 GOmY6F9+0V8KvEhGhHiUhzQqVfEuYQdVxxP4l5QTVhMBmYbmSpL7m5t2qbxottPSedUg
 2bNQ62rgbJuqAZD8kq5GyBFKBT3wDpUsS25lfWNvkGKlz0Ad+Qn12wz8VXrt8FypgzNe
 Tw9EybWK6rlOnJsXPuKLNJnatAwjj2fgs6dK9HcjarDO2kHC0c3ponPD6ZYUbtIpYG0B
 pRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565555; x=1781170355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IiYLBz0MsfiiEMhhkow0/dj4GsKXwzLLlbaYAWggCdQ=;
 b=QWQBfuJPgJ2zP5JTjsyIVxxoyYTkJw83xdmGOudEgQrqGdeMWflREED2ShLzCKvIu/
 fr49FJoDdKQWQblnZ03K/2NOFdyOVmQWcktNBh1j5zpLFYjXEHcilTtnXyGs+dOAQrxZ
 CqpTDOmSn06MKKPjvJ/fDJYduilPuX3A92XC6lXp8HL4DaP+tDFMGDEDQniohGeYDQRc
 gen630mLjRXobqQ9olc/ffXtbXCim2/xyFn/IfowKDbKvJpQ3dXgH5Mrsmbr5deQPuwF
 BFXgtxNm9o9rP+TMUODwalAF5xwNWcZhG2k/6CoWjrL7fuf6YtD4MG5gCuMSaEvQ5HtL
 grPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vrr2bNAC/t6YPuLgKvNiRj57Ekca6nac/eB45YBDWIV+eUctFACo7U9vS+WSaDws1Bm0npYk=@lists.denx.de
X-Gm-Message-State: AOJu0YzdPxTlcYOonYBtPHG4g6vE+IQm1tumPcEP+hRGjMG98dyuCbSb
 gPlcTtHqmIqywuYTrq8AzUy6xrXYV9LUq/LQxWYrXwsoTatf4CfcDYiw1eZhgEB+usarivc07q5
 2Ob956PT2f+5xMeKwIVnBRZ3FwUfwurOfihzqCAgABv7k2ozqcGok1p0D
X-Gm-Gg: Acq92OG8YUWDAZa+hATAnJ9yH9dtphAiCXvnjky+kDnVc+UCv+2xVuh9jnMR1dZWHCh
 Etu+iI+KDsST1m/UyS322X5SpHYH90CfGkPeihO1axEdi+S1uSRrCWU4zZTfrp+SCfjRebUaeFe
 ARk0nF14K4IGGzJglBi3qMVo0Am7hjJqtg3A56nBc97OTi/sUv6D7a2d64CNKOA0bc4bIoHra7Y
 Ccz45j07j0U4q/4V39iux+pTlzq24S/TTJzKl5GR9x2x/74FZIDdlfblbczJMtejgVOfmCVLGw5
 CHs6fjLOMSO0fUFbVXMJkrvjlbk14hGBnAEqZyd4n54La7A6oNjPlKoXzxrHhlhSky95ZyiL4xu
 4+MParj+sc33nMtjJx3Jt5+x4XePePXFpbCS76oFxs9kgaEnWTzloNXID4YxKILQJdLuDdWHqgg
 GwwU/Tc8a52aP25fROyZOAhk0Ssd4NxXRUS8/IkFVSPQzeznuZb2zRl6FdtkK5BQ==
X-Received: by 2002:a05:6a21:1fc3:b0:3aa:3fbf:d0a3 with SMTP id
 adf61e73a8af0-3b49798ab1dmr8652367637.47.1780565554996; 
 Thu, 04 Jun 2026 02:32:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:1fc3:b0:3aa:3fbf:d0a3 with SMTP id
 adf61e73a8af0-3b49798ab1dmr8652319637.47.1780565554579; 
 Thu, 04 Jun 2026 02:32:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:32:34 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 04/13] clk/qcom: add initial clock driver for ipq5210
Date: Thu,  4 Jun 2026 15:01:23 +0530
Message-Id: <20260604093132.757583-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7ZX1Nelpvol0izaDNVgxUNOgG_fVwjla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX2AujOdCx4Hp7
 JbdU3ku6LTE4LmtY2Ysc81sIRcKUWrEl1KSOjasLLKUhSNTvC+td9NxHgZTgWDHqISLhBIWzYqT
 Cg4f98n6fBfgKxZPrw46fR6VGko3bvlFqgWQNy2SEbaJxVciNVKdpIifYTD6RYnN/tc1lYRNNBM
 6Kdjcw2dGVZ8piafbfLkxlQywTa7I+vLkNZeUyltAm712CxpvfaLwSz+5g5679E7YBr5SkmL49s
 6bn63xuT2FUrWtwCHGVNxw18KOhMHc1qv1wQgM1B1X8EWtkB5cvk7ewJMbd9oIVLfdt4LoGDxHS
 8mUlVTxUCOhXL3tRKhCr6iO9t6dFF2ZDlPIHF+o3+AmXBbWFGU/Aw3J2/nDpc2eJBH42c9BnHSA
 PCHw+0WSPSJP8apgusM/8AkIbavqC4tXSxD9jdboB+gxoLPIXpLboZ7hLwCR/G9xP1Lafu9OZr5
 2pXIMYphwqnj7MYw/9g==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a214634 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ttnG5VEth79ohM5wMFYA:9 a=EP1mRVKsZveAJn-p:21 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 7ZX1Nelpvol0izaDNVgxUNOgG_fVwjla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

