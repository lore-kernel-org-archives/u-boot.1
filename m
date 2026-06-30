Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE9FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DF584B04;
	Tue, 30 Jun 2026 14:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDLPOf0u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fG+oFn4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCB484A73; Tue, 30 Jun 2026 10:09:24 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F97884A35
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CJQj1008539
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FZAe7gXFWAVCCycx0RmC2DXHy1AJAMJb7eOv4jKmsck=; b=iDLPOf0u2dfkuLg9
 4/4Hzk7rax7JXaBb/UyZERJFdJ3TyiqDG7GYattdPlCa2DD/2anAJrp2GnphIxQs
 2yjW9wuBCNXJYtC3+3tLH35JXsC4jaqsO9JWMtvEpeSToITkAkPonrvE8Tz3wfwT
 CB9tuZP/3cMMw2+K79MGPYXcBWNTDUN2HIv2QiCpGPn9731TW1qR48EbbFssA3jC
 jqp4/yJ8NLv2DjiHlCX5t0qSEWRNqICC+6Ak16GZCAt09Ehqo5sGO1om8GHwl9Av
 28Sx0SYFSQNCab4QGeG61Y+P5Dgg4SSsEcUWEJ5wyXKsZLrgaBAe7rkZ72KyxVg7
 aOJLwQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw926sd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30eec544cc2so210161eec.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782806960; x=1783411760; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FZAe7gXFWAVCCycx0RmC2DXHy1AJAMJb7eOv4jKmsck=;
 b=fG+oFn4KLEQtIVaoFjtkQscKqwKYtRxpaZfoj4Kzml3fE1Cf5TjwsA1dNvBPnsj3aX
 aWeA3K4dQi0Y+gURIiuhT0Nb3iYnvKWa1BhtPXNdjC0Z52h9acI2DP5Coze0b0hRH5D3
 PN0SwQmundTp9ZqiW1ufcrs6tZg1nVG/Unbg1psEOer/hoTvki5qyFdAtgxvzcIywXAB
 c4PjMy7nahptZn2rNz/8e/dYSGoZHIT1cAnYwbE9/BAzy6oAxlN4ER2FNTnTDJJoE1sc
 rmhZE/CznVBfoHfswMIY3cogdMOJq7s/hhNKo8ii8KM3qDZOwMNB7q8+oNncWv/+KxWP
 mpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806960; x=1783411760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FZAe7gXFWAVCCycx0RmC2DXHy1AJAMJb7eOv4jKmsck=;
 b=S2GPTCpYdPx9ZtUPMI22/VIzT7G+wQfumf7qftkI3wmVgOLwdccnYjCXkedPQKk2Ev
 1ErcboDGK9xEnlLEMRCzD136NoN9PefHQGUOCjcWus1rd2r2s1EwdoMfBGZv3rllejUV
 vlAEZOFirHWzb87uwikM5t44J1Kt5IA5r2DrsNCa+IsS/5TUA6y4uifPa8j14ns8lxrh
 agPEHfONRlyvLbIEl7IJopDW/PfoR30aeLe38JA+F4JaSSaASWHpedL7CgwWEbj5bi7F
 /oJXbNuEWGKGTw76M3Mo3P4aNb2xQgtyzwwLd0ToFfoMY+KgoSQf+lKejO3DrGd1iUno
 eTZg==
X-Gm-Message-State: AOJu0YxT27xSY6fJ3DBt4HMaDcVzTMoIo3Jj/pOCfN0HHNc1w2CbifwP
 TwbSyMD72O5B7p//aTHhRu20x4V1kQIbyb0zvuOXGM++pcifuC11nJj4SIjgGw8auFQJBf1ETTd
 aT9u2aPcmt3AzCwN+hOXQ3fzYXo1r3c1kATXrbNRjILpLKudaHH+c1Hjq
X-Gm-Gg: AfdE7cmNJLvGtHeDdJ88ZVVlolA52IpOh2B7FgUZ4mMABczEBKZXvLO7KmhaLIrHEt6
 RBxYnH7LUXeoDTYKDRYPUSVjALCT3jw6+W7MnxgrdKzfLDNXsfr6SN0djoqs/tyZxoTWJhzt3Ua
 S/QXGKaFIo37IuLXoqPZI3s8G7qHY3aNJj9MruqluVPRXgWI7hCt9gKBID+2Rz8b2rf7DevkNGY
 Q5eXoPub1GgFBE8B7uVRnZSo1dpfIUW7gJWboLH2rQitC6vk3kOZMssv/V6q5UYZX1AUUS2HFTK
 lGSdNanREVxcYGB1BLku4Wdve6fs5S/rdKSWax0Huc+sm+74ouInk/dmYnlqKAzR6dnZk9LTvSn
 Y+/Qlaud8bEETpg/nihSyWj6rkIMqizJY+4ec6DyVpburfHXJBYhFopHVn8YTG/QpoZkiyFHob0
 jOQm/y5DpCqD3d/2W9cQOooLUhjtUiZ9g4SiJw1nR9
X-Received: by 2002:a05:7300:fd13:b0:30c:8656:6db0 with SMTP id
 5a478bee46e88-30ee136b8bdmr1787338eec.27.1782806959674; 
 Tue, 30 Jun 2026 01:09:19 -0700 (PDT)
X-Received: by 2002:a05:7300:fd13:b0:30c:8656:6db0 with SMTP id
 5a478bee46e88-30ee136b8bdmr1787293eec.27.1782806959161; 
 Tue, 30 Jun 2026 01:09:19 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:09:18 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:24 +0530
Subject: [PATCH v7 02/11] clk/qcom: add initial clock driver for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-2-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfXw4JiZqeWvjOA
 aQqqk9M7MoCb6CIDUw2lI8bU+PuFDFv9necAZo3sF6m8zIMWZqNJM4KL7Tljk4ikKx4m1/RNEId
 Ch54HlIlKq0uaGL7lgvSOkrD2ROsrEc=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4379b0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=ttnG5VEth79ohM5wMFYA:9
 a=kiZGP_w1ogyo4Ob3:21 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: -ExMSlOxNRD-7t9ulF-YaN5wxwtppxLK
X-Proofpoint-ORIG-GUID: -ExMSlOxNRD-7t9ulF-YaN5wxwtppxLK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX8sfO6VGg+wuG
 7XMxkxj9alR7TolQK4UBzwxu8BWbkJq/2qSmfNwik/7ZSLO73DfP47usviqkH+2CSq8AS9rPyj4
 +MvPgD1FqpcpUVhgPAp4KSaPmj798WFjFrWZKLQmSYlmWVUhBc0zLaZR6g6giXSSmsXQT7uqekr
 SVbP9cmV4yT+HibsDYx1nnCv37m2lHvdYF0DxdNEfInSYi0f7PUQutqLO14yY7Gsw/RMSqogY9o
 Cj7AC5m/lg2dkkSd/CsaCfG11R1T7yRP2akNEjjnmZ1KsQJCg6+uCuiWNdqZ3w7e8YQG2APohvg
 M1znpCLVAmBjiffGrQxSWf/BxDUNEibvJNyoCFm2avcYcafoQWy+mia13h0KPuwnagjaqaG1jlY
 bNPy9tbyrb7QLZKbi8OLvZj/CeIg6EcTULJmjPU3PR3gs+bFIob+C+y6JzgTqosc7Trk68Kkvui
 unJGmY4hlE7ktzXYl5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 ++++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 98 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

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

