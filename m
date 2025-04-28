Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E706C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F0D82145;
	Mon, 28 Apr 2025 21:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YZCp2Lhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA348210E; Mon, 28 Apr 2025 21:24:38 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50223820F6
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so56042985ad.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868273; x=1746473073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUTu9sdvjQ7FF6Zjm8DSC6RJjMx8vh/W1Q0khGCKIFU=;
 b=YZCp2Lhpjjw/pKNdDa/AwmMeFPgADthh/NkJHVi3xUM75NCYm8k318kIBSDmyPxi7Z
 J1kG/KcodjGI0Xb96HmlvkI1BxQNVZTy3/7q3qNp/yZoL7rNi7lVCJtNuog+K9xvdYsQ
 jHSsxiaAQBBZWL+Ys0xu9H8hk5NsBkpzqR5PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868273; x=1746473073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUTu9sdvjQ7FF6Zjm8DSC6RJjMx8vh/W1Q0khGCKIFU=;
 b=G6Vgws4VNXiAMpKZFuYXTtEpEck8lL6PEsQZLT+FJ2m9w5/GC8wbSeQfHdYnos3nfe
 Ur7b3fnsaz/Doypvt/XDHuM+wO1Npm0aZVTmrxbvioWSZPC2wihkcSyNd+x0nKYVEWfO
 MEzdr1h2x3ePAkrrCc9pCw164vUoh0MNaCNBNsEpqsGQhlymFOX8YCZ2FqExX+RGnsH+
 GBiF0gdoE8xUN4q3Rzm4rYPKwRb53aeA+RTatsx+wtJQcyQ0XhqijWWaeUAV9B2dBPQD
 yWjDn1BkyaBSfXq1WyErjPpWyCdOrdrWDPSjAPFkcEy8kf3jy9pJOgrqlrKbkv03CezR
 5rVw==
X-Gm-Message-State: AOJu0YxYoU2PHBM2dQ/j3lU6OXHr6VDq1MiK48LErAkpBs5Wb5yICMNG
 KyfwirSiYEnl1SOuw9upaHXgW6ihld3cQfIzoqwvjahHR57TDz1XpSUPeQjCVWfIadsbHhcjh4w
 =
X-Gm-Gg: ASbGncvrnzFRXluWl88wF8l/Hocn0OOLZ7DA7DLyS9XC0ziBS7EW8qlTHx4u24K/4kl
 KYYYUAD6gM2Y3d5Ru2fz3guC82O9QwdwCJH5inzWQUNyxHsVcMWC1r/pB/aH25fJ3+xuJOBQ34E
 mBAdC2FrrIfX9geaEb0TpEGHJaU8CV8oJOqndXqzg+SPEgm0xwPoX4YcsTJtgJkvr6zeG5xwkFP
 5MnEYyLXwODOqgy46staN5t6y0iUM6YTpAnYutmvQNNch3eO4qDc9rpEQPsaIF2DFjpGpVpZ2+1
 zsAhcKk5OGDD7EYmz6cly9qf3GkqYylFhROYm8pkh8JQZJTI6InO9fTBhbUMP4SCOoqKVVt6IPY
 I+MsWwuMpmd74
X-Google-Smtp-Source: AGHT+IFEI0WPDjsJozOhlzfkIR9g/0IwBel4yjn3jSqtBMUqCkTmVZfXHOrNJz5fr+vh528MSew+7A==
X-Received: by 2002:a17:903:32cc:b0:223:4bd6:3863 with SMTP id
 d9443c01a7336-22de5eca4afmr12625865ad.10.1745868273600; 
 Mon, 28 Apr 2025 12:24:33 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db4dbdb4bsm87037295ad.92.2025.04.28.12.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:33 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 02/17] clk: qcom: Add driver for sc7180
Date: Mon, 28 Apr 2025 12:24:09 -0700
Message-ID: <20250428192427.3877612-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sc7180.c | 153 ++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sc7180.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c969a..f310fd0d78f6 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -111,6 +111,14 @@ config CLK_QCOM_SM8650
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
index e13fc8c10717..ddca98950d47 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
diff --git a/drivers/clk/qcom/clock-sc7180.c b/drivers/clk/qcom/clock-sc7180.c
new file mode 100644
index 000000000000..e5b9c4f46f41
--- /dev/null
+++ b/drivers/clk/qcom/clock-sc7180.c
@@ -0,0 +1,153 @@
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
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x52008, BIT(22)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x52008, BIT(24)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, 1),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x1200c, 1),
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

