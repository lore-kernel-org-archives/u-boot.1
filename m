Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22CFC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1484988077;
	Mon,  8 Apr 2024 15:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i60J4DHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3155787A80; Mon,  8 Apr 2024 15:07:19 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3771987B89
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso6699205a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581635; x=1713186435; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qhysnYfZC0moZlJkrtxWBogSrgv8EIpW6TLK/IAPHfw=;
 b=i60J4DHfRpxrWEh+KvKAw82hATYOKVfsjQ3pgz5vl9EE5XwzJMGd7O0ZbS7YkpHLzR
 MLDGMwo2X1RWFjfnUqgifOxaPZiJ5RQZOE1tT8wxymx2l0qgQpS9Brzu4R/4CXi7YjKM
 sTlXOmRRy5XQkxPXOI4CtY69l9buOEP4Hk02Mpshdx2obBUKbgxic+dr+mPbigmGUCqh
 ppxsfcPNuBrEJxs37lQa7vTAig2xzNMxjbht94MYDvN99Ijddm0iEfxzL4cudxjCG1UA
 XWQm1QeHPsuIqafSoa5Y04mBZ2U7vCrkdE/HWwI9N2f7tqsA4KLieEwLo/nCYKDIq0Pe
 QBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581635; x=1713186435;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhysnYfZC0moZlJkrtxWBogSrgv8EIpW6TLK/IAPHfw=;
 b=LRw4p+ZX4UJnCH91z6YfE+U3fxr+zoQDJbS0YIw20Eb9m2Ds6UoKXBki7Sepr5NbuE
 RqpUfnz0Z5kJKi+b8zrhV93kM32V6gVnHWar/awnt1tgk1p7WLJGnaoYRfyQJv3kagOp
 I0OBga9kRID1yhpui5HwwYFwWchajYET9/4WhksNFIxMOZTqoB06Qv4SvR+RM/HxX28y
 VjXPB1gDpQzfSlTsxLGld36CvO1+Ox/wQvc6WRuCwUPQYN43oaD4ZJLpOGI8Qnt8VbX4
 +Gd9U+30OYtW0qaXXMSoM5VzM8GzI0OsjLfyRc6ZkQiSxv4uc0CO4EhCPN1/ICLb1TlL
 TznA==
X-Gm-Message-State: AOJu0Yy4ssg4Ud4UBSN5LIMnEpO/XrVEeOt/SZYYJXJ+lwDaw04ZThLA
 IJY/ZYzZQDjeOl33CZVnKz8MNEoj2xNuBTCUs/craE3Ye1xN4FssskHgv9xSH+I=
X-Google-Smtp-Source: AGHT+IFs5C0cHPFoeBqHF663sYKeo4Cfg1j6xR4ZRPYsfes8+4IzZpBjQTSpWCy6CyEkDUd9lwHQxw==
X-Received: by 2002:a17:907:6094:b0:a51:d1f6:3943 with SMTP id
 ht20-20020a170907609400b00a51d1f63943mr2562040ejc.56.1712581635600; 
 Mon, 08 Apr 2024 06:07:15 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906338a00b00a51ce37a708sm1998981eja.94.2024.04.08.06.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:07:15 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:06:49 +0200
Subject: [PATCH 1/4] clk/qcom: add driver for qcm2290 GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-1-2db1d3658660@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9079;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=OVUC4gp/Pd4caD5awGiK4wd3gzDYSPq50fblb18Wq8U=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+wBdY9mn69Cxc/rqeKyhD/s07PaPif3NvPPT
 IecIAdVHt6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsAQAKCRAFgzErGV9k
 tjSUEACDsF8HRNGBrjxRx0EZui2yoh9rNHaV+Mg08Zxh+niiVr/G0c+isnu8gj+y09QR2otnglN
 TiyNK41jYbKBHcsp5GNkyJOcStVFSQrvK1Tu05SqCkgbs8nv2Z0rmuIlT+0acog68psloq/yZwZ
 nsUa3N0Yi2QH3kfV66r/zWzFgxOSD/st3DOixOGjOO8MUGRZ0WqO+iS+vqbeqJ1+3JY1u9fhzAV
 xCMRcMwyMArpP+lfqrpyYTz0PB3eVEXP4RWi+x+VaO8eSFeSVWZXG1KLISD5oLc/42VQnJSdTXZ
 axmNQN7Q3aaReOoCUr1TWf58S+bXu+YuAOuhVfBZU4qIT1y0nHps/CH1pDTO3PXVJZRI0tXT9y7
 lU6hkVgpIsTwl4QViNZVLU5R3gTu/S33CAHSh+9ETaxU9Dn55s6DMfqPbXdElRBfSrtzkmxkw4I
 UYZp3B07hplSDn7wCvvrRZJbX619ocnaNb9GdgnGJq+qvhZ28audhNlxzHpjMYnWq3b30mdDT0z
 N8K44tl99UMDy3ETsY1Y9C+e1tUKFNurJKNSKU8nrZXupH8IVxZA/BwODOHeLAEPdGPVCPiiBq/
 r4Kr+eGhv/g9gGXpedDgBJponEXX/IvSaEdnAstOgRrQkc0edcPF2TSgT92HMS7qWpmiX6+QJfX
 kQidRHEIvLBC57g==
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

Add a clock driver for the QCM2290 SoC which is used in the QRB2210 RB1
board.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-qcm2290.c | 192 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    |   3 +
 4 files changed, 204 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8dae635ac2c1..d7dfe4c0d5fc 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -30,8 +30,16 @@ config CLK_QCOM_IPQ4019
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon QCM2290 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCS404
 	bool "Qualcomm QCS404 GCC"
 	select CLK_QCOM
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index cb179fdac583..83aa8a920348 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -6,5 +6,6 @@ obj-y += clock-qcom.o
 obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
new file mode 100644
index 000000000000..c78705cb8cf1
--- /dev/null
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm qcm2290
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
+#include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+
+#include "clock-qcom.h"
+
+#define QUPV3_WRAP0_S4_CMD_RCGR 0x1f608
+#define SDCC2_APPS_CLK_CMD_RCGR 0x1e00c
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{}
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0), // 6.5, 1, 4
+	{}
+};
+
+static const struct pll_vote_clk gpll7_clk = {
+	.status = 0x7000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(7),
+};
+
+static const struct gate_clk qcm2290_clks[] = {
+	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a084, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x7900c, 0x00000200),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_CLK, 0x7900c, 0x00000100),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x7900c, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x7900c, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x7900c, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x7900c, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x7900c, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x7900c, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x7900c, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x7900c, 0x00000080),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x38008, 0x00000001),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x38004, 0x00000001),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, 0x00000001),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x1e008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x1e004, 0x00000001),
+	GATE_CLK(GCC_SYS_NOC_CPUSS_AHB_CLK, 0x79004, 0x00000001),
+	GATE_CLK(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a080, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x9f000, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, 0x00000001),
+};
+
+static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	debug("%s: clk %s rate %lu\n", __func__, clk->dev->name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S4_CLK: /*UART2*/
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     16);
+		return 0;
+	case GCC_SDCC2_APPS_CLK:
+		/* Enable GPLL7 so we can point SDCC2_APPS_CLK_SRC RCG at it */
+		clk_enable_gpll0(priv->base, &gpll7_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		WARN(freq->src != CFG_CLK_SRC_GPLL7,
+		     "SDCC2_APPS_CLK_SRC not set to GPLL7, requested rate %lu\n",
+		     rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     8);
+		return freq->freq;
+	case GCC_SDCC1_APPS_CLK:
+		/* The firmware turns this on for us and always sets it to this rate */
+		return 384000000;
+	default:
+		return 0;
+	}
+}
+
+static int qcm2290_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, qcm2290_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map qcm2290_gcc_resets[] = {
+	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
+	[GCC_CAMSS_TFE_BCR] = { 0x52000 },
+	[GCC_CAMSS_TOP_BCR] = { 0x58000 },
+	[GCC_GPU_BCR] = { 0x36000 },
+	[GCC_MMSS_BCR] = { 0x17000 },
+	[GCC_PDM_BCR] = { 0x20000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x1f000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_SDCC1_BCR] = { 0x38000 },
+	[GCC_SDCC2_BCR] = { 0x1e000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
+	[GCC_VCODEC0_BCR] = { 0x58094 },
+	[GCC_VENUS_BCR] = { 0x58078 },
+	[GCC_VIDEO_INTERFACE_BCR] = { 0x6e000 },
+};
+
+static const struct qcom_power_map qcm2290_gdscs[] = {
+	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
+};
+
+static struct msm_clk_data qcm2290_gcc_data = {
+	.resets = qcm2290_gcc_resets,
+	.num_resets = ARRAY_SIZE(qcm2290_gcc_resets),
+	.clks = qcm2290_clks,
+	.num_clks = ARRAY_SIZE(qcm2290_clks),
+	.power_domains = qcm2290_gdscs,
+	.num_power_domains = ARRAY_SIZE(qcm2290_gdscs),
+
+	.enable = qcm2290_enable,
+	.set_rate = qcm2290_set_rate,
+};
+
+static const struct udevice_id gcc_qcm2290_of_match[] = {
+	{
+		.compatible = "qcom,gcc-qcm2290",
+		.data = (ulong)&qcm2290_gcc_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_qcm2290) = {
+	.name = "gcc_qcm2290",
+	.id = UCLASS_NOP,
+	.of_match = gcc_qcm2290_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index a7f833a4b6dd..ec524157df2b 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -8,8 +8,11 @@
 #include <asm/io.h>
 
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
+#define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
+#define CFG_CLK_SRC_GPLL6 (4 << 8)
+#define CFG_CLK_SRC_GPLL7 (3 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
 
 #define RCG_CFG_REG		0x4

-- 
2.44.0

