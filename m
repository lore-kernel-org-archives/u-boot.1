Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63026CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639E3880E0;
	Mon,  8 Apr 2024 15:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uqSdQbKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 014C9880DD; Mon,  8 Apr 2024 15:07:22 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A138799C
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso4467483a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581638; x=1713186438; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s2cCAkhdTEX0o9yqLnhnZYEvt1lh0csbMhAA6U28fb8=;
 b=uqSdQbKUiDW/P1v4knEqSR4RGu3kMAohAD78ojQ+L5GUlmuqlaRJr49DYtmmJbw4+W
 6ZU2M/sW7dD7ebbOnujJPLp+lZtXelG+5usKDW1vM9Xn9Ndi/JvSh0hMuN09moL5pk1p
 f2tZ6VFo/AfAfUakZQuc5VbhSmrLob/g69+1UM1Nrbd4TbcBeMmrfzzpGI1PT+w3LbmC
 IaxZq7cU2Qp8j+ESKuQW8qjtcTRRXgptfvC0N3xEgHT7+DuC0qpc+kN6+FmTW8ZwGZUY
 +U+/iYXBtE7iGz8Nk0QuESgeQovrezqFYqNASImJrvvDizP11QmSi7dUXKjLRupRECwk
 lyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581638; x=1713186438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2cCAkhdTEX0o9yqLnhnZYEvt1lh0csbMhAA6U28fb8=;
 b=LsN42ANBmxfhXdkdTo5wjGvnK8nvGjT/jPuNZnM1HFYm72QXkGhdHO+4sZsceglMYB
 gFNh5aClKs23ysiFx07olo4xFApLODmE6KXav+3Vaw567u+x3EyZBJ/9M5xHs8hXDivk
 1TsQk3EnQs8l4LM6sFtgg7kT1bt7rDIgcRms11KXitPrP63kYI8sto8fkN58KR9c0vrX
 bhnaAt27y5QbglM7BfRU+O8bHztt3kyclXOt2L2aJHWGnnz6amDWtqHrbbyOeYr3UipF
 ZnXdb+aejXpLNVOd3QUfIwtRKoFp/5JJxDntUzQw/YOuhAkVJ8wk3qWDuG/le+1ZLg+k
 9c3w==
X-Gm-Message-State: AOJu0YydbkdMYNUltHrXCxYVlHc3b04mzrJ+jAa7GYH5vXg87XjHICcj
 R2QoLUcVJcT/PyJ/Y1LEZqKhe5hL0tJYkMvaXm1YUFsizXSb+EZkTnR0Qn6dktU=
X-Google-Smtp-Source: AGHT+IE1NUIMDiuYwRIt34IZ5NQoZRxx4oa56MYJ1Dr/PLbqFMTS0p2g+RvihX6l/P6ii4yCuiKdmw==
X-Received: by 2002:a17:906:b78e:b0:a51:bcca:eff6 with SMTP id
 dt14-20020a170906b78e00b00a51bccaeff6mr4064080ejb.37.1712581637806; 
 Mon, 08 Apr 2024 06:07:17 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906338a00b00a51ce37a708sm1998981eja.94.2024.04.08.06.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:07:17 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:06:51 +0200
Subject: [PATCH 3/4] clk/qcom: add driver for sm8250 GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-3-2db1d3658660@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13567;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dUvLu/Upi9LFeR1YE0uuT0WeIDdqOlRJyFWHzIwjH1w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+wBzJ3c/YgWi02IOBsNXu1VbhhawswPhgHWO
 tT8FwWyriuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsAQAKCRAFgzErGV9k
 th3mD/9CSuHJD2iKPuo0Gq74Njcq70fQ+Rx7KjlNbb/b617/9u/1v1p3KeNXuJVrwVtZoLCT580
 fCL9MSBrG19atb++tRRx7EIP7s57sWH8DpZNQS6mrTvUbs32IrhNS+F0tD8c/Ga2CHUep+Aj8DJ
 ZrNEdCFuvhacSSrTONnVmvImpVXXelkRxqafL+GVqiG6qvPturN42QYMsX5dsiii0mGlHgNxn/V
 cKH4kAO4FBpb024uJyw4GN2w12Bjt06+f1vTL/QkOfsbVeIL/sSpj0iFLPGj5xLWWuyJPQeHzOj
 4zBJ79xVWDQzw2wj63MvCovGtDFMfixEWgOo9acLy4yFG775vepkS3iJ5F4gpGBylaT3uClrXbP
 uJNzI2WXTjuMre02wWP6T5s7JV8ZLxL6wNO0Hr/9EUKPFLt2MgbL+pvuUKYrwTsCTgs/CkBJ33y
 0Fo7rY+yGjTcaGqDoWj+AJhKe23Y8aQz4R7Q0VKCDjp/S+G5rsJk0ZEFvb80FpwDWlZVgJebmgX
 4WnYz3WMq9d+50Uddw0cCZtkH3tnl5Hc34ZM2OINYWQkyVUREHzDPEV12kIpnEMoQCSDAkmMO9N
 vAdDEoQrIGQXulBIF5PqgvY5cIu+2CGJt09abd/t4adBq8bdl2V8YPn/PN4MTyqFHekb2ftmbFY
 HU8RUDrk+CCaVVA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a clock driver for the SM8250 SoC. This driver can enable necessary
clocks for UART, UFS, USB, and MMC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-qcom.h   |   1 +
 drivers/clk/qcom/clock-sm8250.c | 282 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 292 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6afa62e19879..d4bd8c7e6ba6 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -62,7 +62,15 @@ config CLK_QCOM_SM6115
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM6115 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SM8250
+	bool "Qualcomm SM8250 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SM8250 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index d38c5a9fb849..f7fc8b9a70f5 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index ec524157df2b..cc170d8e3f9e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -9,8 +9,9 @@
 
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
+#define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
 #define CFG_CLK_SRC_GPLL7 (3 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
new file mode 100644
index 000000000000..af10fc116219
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm8250.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm sm8250
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sm8250.h>
+
+#include "clock-qcom.h"
+
+#define GCC_SE12_UART_RCG_REG 0x184D0
+#define GCC_SDCC2_APPS_CLK_SRC_REG 0x1400c
+
+#define APCS_GPLL0_ENA_VOTE 0x79000
+#define APCS_GPLL9_STATUS 0x1c000
+#define APCS_GPLLX_ENA_REG 0x52018
+
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
+#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf064
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s4_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{}
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	{}
+};
+
+static struct pll_vote_clk gpll9_vote_clk = {
+	.status = APCS_GPLL9_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = APCS_GPLLX_ENA_REG,
+	.vote_bit = BIT(9),
+};
+
+static ulong sm8250_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S4_CLK: /*UART2*/
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s4_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     16);
+
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		/* Enable GPLL9 so that we can point SDCC2_APPS_CLK_SRC at it */
+		clk_enable_gpll0(priv->base, &gpll9_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		printf("%s: got freq %u\n", __func__, freq->freq);
+		WARN(freq->src != CFG_CLK_SRC_GPLL9,
+		     "SDCC2_APPS_CLK_SRC not set to GPLL9, requested rate %lu\n",
+		     rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_SRC_REG,
+				     freq->pre_div, freq->m, freq->n,
+				     CFG_CLK_SRC_GPLL9, 8);
+
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sm8250_clks[] = {
+	GATE_CLK(GCC_AGGRE_UFS_CARD_AXI_CLK, 0x750cc, 0x00000001),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, 0x00000001),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x0f080, 0x00000001),
+	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x10080, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x0f07c, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x1007c, 0x00000001),
+	GATE_CLK(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x0b018, 0x00000001),
+	GATE_CLK(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x0b01c, 0x00000001),
+	GATE_CLK(GCC_QMIP_DISP_AHB_CLK, 0x0b020, 0x00000001),
+	GATE_CLK(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x0b010, 0x00000001),
+	GATE_CLK(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x0b014, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x52008, 0x00000200),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_CLK, 0x52008, 0x00000100),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x52008, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x52008, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x52008, 0x00010000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, 0x00020000),
+	GATE_CLK(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x52008, 0x00040000),
+	GATE_CLK(GCC_QUPV3_WRAP1_CORE_CLK, 0x52008, 0x00080000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x52008, 0x00400000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, 0x00800000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x52008, 0x01000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x52008, 0x02000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x52008, 0x04000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x52008, 0x08000000),
+	GATE_CLK(GCC_QUPV3_WRAP2_CORE_2X_CLK, 0x52010, 0x00000008),
+	GATE_CLK(GCC_QUPV3_WRAP2_CORE_CLK, 0x52010, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK, 0x52010, 0x00000010),
+	GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK, 0x52010, 0x00000020),
+	GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK, 0x52010, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK, 0x52010, 0x00000080),
+	GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK, 0x52010, 0x00000100),
+	GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK, 0x52010, 0x00000200),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x52008, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x52008, 0x00000080),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x52008, 0x00100000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x52008, 0x00200000),
+	GATE_CLK(GCC_QUPV3_WRAP_2_M_AHB_CLK, 0x52010, 0x00000004),
+	GATE_CLK(GCC_QUPV3_WRAP_2_S_AHB_CLK, 0x52010, 0x00000002),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, 0x00000001),
+	GATE_CLK(GCC_SDCC4_AHB_CLK, 0x16008, 0x00000001),
+	GATE_CLK(GCC_SDCC4_APPS_CLK, 0x16004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AHB_CLK, 0x75018, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AXI_CLK, 0x75010, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK, 0x75064, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK, 0x7509c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK, 0x75020, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK, 0x750b8, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK, 0x7501c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK, 0x7505c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x0f010, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x0f01c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x0f018, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x10010, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x1001c, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK, 0x10018, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x0f054, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x0f058, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x0f05c, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_CLKREF_EN, 0x8c010, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK, 0x10054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x10058, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK, 0x1005c, 0x00000001),
+};
+
+static int sm8250_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, sm8250_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	case GCC_USB30_SEC_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sm8250_gcc_resets[] = {
+	[GCC_GPU_BCR] = { 0x71000 },
+	[GCC_MMSS_BCR] = { 0xb000 },
+	[GCC_NPU_BWMON_BCR] = { 0x73000 },
+	[GCC_NPU_BCR] = { 0x4d000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
+	[GCC_PCIE_1_BCR] = { 0x8d000 },
+	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0x8e014 },
+	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0x8e020 },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0x8e000 },
+	[GCC_PCIE_2_BCR] = { 0x6000 },
+	[GCC_PCIE_2_LINK_DOWN_BCR] = { 0x1f014 },
+	[GCC_PCIE_2_NOCSR_COM_PHY_BCR] = { 0x1f020 },
+	[GCC_PCIE_2_PHY_BCR] = { 0x1f01c },
+	[GCC_PCIE_2_PHY_NOCSR_COM_PHY_BCR] = { 0x1f028 },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x6f00c },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_PRNG_BCR] = { 0x34000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_CARD_BCR] = { 0x75000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB30_SEC_BCR] = { 0x10000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct qcom_power_map sm8250_gdscs[] = {
+	[PCIE_0_GDSC] = { 0x6b004 },	[PCIE_1_GDSC] = { 0x8d004 },
+	[PCIE_2_GDSC] = { 0x6004 },	[UFS_CARD_GDSC] = { 0x75004 },
+	[UFS_PHY_GDSC] = { 0x77004 },	[USB30_PRIM_GDSC] = { 0xf004 },
+	[USB30_SEC_GDSC] = { 0x10004 },
+};
+
+static struct msm_clk_data qcs404_gcc_data = {
+	.resets = sm8250_gcc_resets,
+	.num_resets = ARRAY_SIZE(sm8250_gcc_resets),
+	.clks = sm8250_clks,
+	.num_clks = ARRAY_SIZE(sm8250_clks),
+	.power_domains = sm8250_gdscs,
+	.num_power_domains = ARRAY_SIZE(sm8250_gdscs),
+
+	.enable = sm8250_enable,
+	.set_rate = sm8250_set_rate,
+};
+
+static const struct udevice_id gcc_sm8250_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sm8250",
+		.data = (ulong)&qcs404_gcc_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_sm8250) = {
+	.name = "gcc_sm8250",
+	.id = UCLASS_NOP,
+	.of_match = gcc_sm8250_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.44.0

