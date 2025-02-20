Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352DCC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BAC80FD0;
	Thu, 20 Feb 2025 22:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nBFt2kxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF2A8001F; Thu, 20 Feb 2025 21:59:07 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7364A806FE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c92c857aso25412005ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085144; x=1740689944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbILxfp/2D+ToZHKKDsc6kytcN7N8YFW2PicobXdsW0=;
 b=nBFt2kxQgyZD2xko3mV9xNfIOrHmpL1B6+FMPRsXi5Ri/VJ7K35BE5p9K+AHAl1Rq7
 +A4ZCK1FmUJgYBtju7Vg0lAx2sRbTZRdfGwtw32jFWLnPNUqtF0lxhNZz6MH1CFz+30Q
 Wce9r0eYYPmUh38Wkh89oDVKpJG/L1pe7DhV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085144; x=1740689944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbILxfp/2D+ToZHKKDsc6kytcN7N8YFW2PicobXdsW0=;
 b=R8boeBwopJrzvG+mBxAF2HLMMFMx/1nemmzNPWZf+ihgHnEMXWEGrjusUtiYgiIrQf
 LJ+/oJUwj/Y0AI4YFcDdrdJ3WtiRx9OEU2rLZG2b26GpuTz5eXYTGlH7TX3bd/SwPkHk
 k6w4J4Bp5sZ+3biosX+64opn5sdqSMoymb6WfJcRYPviGa9S2/N6HkDQ7OOJNFvZx+9o
 Ul0y0oAfJFk+U6iwvUP5GpYgWzfY7UGDsc/FnsS0V4FQ76TSnjpHz1NmshwcGRSTug73
 WavqpqV+q855Q6jIjIXKs6M0NLYhPDSbjk4Z2d4p/0E9k0Ugew2Qn5Z2ZJSytHwOVohw
 YmBw==
X-Gm-Message-State: AOJu0YxqS7NajrmjcWFpPOtrHcd2dhR2ksDJ0lr7qARWxqoreL3vUkXt
 7kNwzmoJKcLXNmddvylD1mV/j9Lq8kvbu+oxrAlcTjUxC+aKvFgB1Uvf1bDe7YCst8wcxrGZFmQ
 =
X-Gm-Gg: ASbGncvP5uPSgLu6FbBBF0sZC0r4subYlVOH1f0Me8BtpJuQbndYTD4yw0XPrhlfuf5
 ZgC2VGlv4/qRPjQFF/9os7AEPR7FE5S9zhEcc1B/kBzQoHT9v3jQXdtBZmlud2lF5qUJLuEzNzw
 EVGsvcNkorliQ02OmeV/dF6wJ5sTxGw4DHMf3qujKOrEEW/17OkiJA9rEHMi7o5Mma0gazTEaYk
 G/Lz3MIh9Fkh7NQrUFLFmkgs/Ue0rp38LP+RmH8i8p94M4Koe/1m0y6z4rxL+tlvUBJWXNnrT1T
 UHmoQe152kYuNCHJC1kcAjODMx9l/ZoqVl4q6gn75RgBheqMFDCX8lE=
X-Google-Smtp-Source: AGHT+IFWwz6GyvlBo1MQ4vDH32Ri7POPViVKV7Cq8aRozJuyaggXxpaLlAzhMbkyxFGYGVSItaexIg==
X-Received: by 2002:a17:902:d4cf:b0:21f:6546:9adc with SMTP id
 d9443c01a7336-2218c3f4333mr77683215ad.13.1740085143746; 
 Thu, 20 Feb 2025 12:59:03 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-732575e055dsm12569294b3a.68.2025.02.20.12.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:03 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 01/12] clk: qcom: Add driver for sc7180
Date: Thu, 20 Feb 2025 12:58:43 -0800
Message-ID: <20250220205900.3127680-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

The clks are already configured properly by coreboot on sc7180, but this
is good enough to make the MMC and USB drivers work.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sc7180.c | 150 ++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sc7180.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d76fca5dba41..c680829ad986 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -95,6 +95,14 @@ config CLK_QCOM_SM8650
 	  on the Snapdragon SM8650 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SC7180
+	bool "Qualcomm SC7180 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SC7180 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SC7280
 	bool "Qualcomm SC7280 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ab33f1c5faf9..4b7217f01ce3 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
diff --git a/drivers/clk/qcom/clock-sc7180.c b/drivers/clk/qcom/clock-sc7180.c
new file mode 100644
index 000000000000..b91c0f38c8f7
--- /dev/null
+++ b/drivers/clk/qcom/clock-sc7180.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm sc7180
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf034
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf01c
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s3_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	{ }
+};
+
+static ulong sc7180_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S2_CLK: /* UART8 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x18278,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return rate;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		/* DT has 150000000 but this is actually rounded to 200000000 */
+		WARN(rate != 150000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     3, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		clk_rcg_set_rate(priv->base, 0xf060, 0, 0);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		/* TODO: Actually set a rate here */
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sc7180_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x502c, 1),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x8201c, 1),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, 1),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, 1),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x18274, 1),
+};
+
+static int sc7180_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, sc7180_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sc7180_gcc_resets[] = {
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x26000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x26004 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct qcom_power_map sc7180_gdscs[] = {
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
+};
+
+static struct msm_clk_data sc7180_gcc_data = {
+	.resets = sc7180_gcc_resets,
+	.num_resets = ARRAY_SIZE(sc7180_gcc_resets),
+	.clks = sc7180_clks,
+	.num_clks = ARRAY_SIZE(sc7180_clks),
+
+	.power_domains = sc7180_gdscs,
+	.num_power_domains = ARRAY_SIZE(sc7180_gdscs),
+
+	.enable = sc7180_enable,
+	.set_rate = sc7180_set_rate,
+};
+
+static const struct udevice_id gcc_sc7180_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sc7180",
+		.data = (ulong)&sc7180_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sc7180) = {
+	.name		= "gcc_sc7180",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sc7180_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
Sent by a computer, using git, on the internet

