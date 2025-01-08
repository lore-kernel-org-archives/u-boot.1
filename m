Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520EAE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9727380646;
	Wed,  8 Jan 2025 16:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="G8J40wni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C57800DF; Wed,  8 Jan 2025 13:00:54 +0100 (CET)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CA480040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 13:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1736337644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsEU43LRxC8CW+TaXWYmJPKTakvuEc4RcchOSlwcALk=;
 b=G8J40wniuEJTuxggatEcDk5D4lFZg5+VV1TkkMndgS5SCQ2sMhxJ6UNOFGKV8H0vW/+Cf9
 JEuffVAEHXCb9ll8Rsgrds3oKzNosuCm+h8vQj10k7au9RobgOxBJvgiJt9zgX+zTb+k6v
 1M803MFAuZmb1YtHpqL1zGWRBDSZNm5F0iHWBkUxSsQt9hvC1R4H6sRJogU5qAOysO2F/e
 tuAGLUB286QR+390DT9BaEPFSF1goySOe/8rrZ3DwYlhlfl1RyGvYyO1Fd2n+0aVKwjgmt
 tk5uoGKLqkVVaAJ7C6CoP2ftGz0vs8WFpggjWC+G+VvMQe1WAMmBr2rBMk7UAg==
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH 4/4] drivers: clk: qcom: Add SDM630/660 GCC driver
Date: Wed,  8 Jan 2025 14:59:11 +0300
Message-ID: <20250108115911.4163437-4-alexeymin@postmarketos.org>
In-Reply-To: <20250108115911.4163437-1-alexeymin@postmarketos.org>
References: <20250108115911.4163437-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:48:26 +0100
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

Add driver for Global Clock Controller used in Qualcomm
SDM630/660 SoCs.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sdm660.c | 180 ++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sdm660.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d76fca5dba41..29767ab256f3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_QCS404
 	  on the Snapdragon QCS404 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SDM660
+	bool "Qualcomm SDM630/660 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon 630/660 SoCs. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SDM845
 	bool "Qualcomm SDM845 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ab33f1c5faf9..3065ba90cb7a 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -3,6 +3,7 @@
 # (C) Copyright 2023 Linaro
 
 obj-y += clock-qcom.o
+obj-$(CONFIG_CLK_QCOM_SDM660) += clock-sdm660.o
 obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
diff --git a/drivers/clk/qcom/clock-sdm660.c b/drivers/clk/qcom/clock-sdm660.c
new file mode 100644
index 000000000000..c4cd49f39a57
--- /dev/null
+++ b/drivers/clk/qcom/clock-sdm660.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm sdm630/660
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <dt-bindings/clock/qcom,gcc-sdm660.h>
+
+#include "clock-qcom.h"
+
+#define GCC_BLSP1_UART2_APPS_CLK_CMD_RCGR 0x1c00c
+#define SDCC1_APPS_CLK_CMD_RCGR 0x1602c
+#define SDCC2_APPS_CLK_CMD_RCGR 0x14010
+
+/* blsp1_uart{1,2}_apps_clk_src share the same frequency table */
+static const struct freq_tbl ftbl_blsp1_uart1_apps_clk_src[] = {
+	F(3686400, CFG_CLK_SRC_GPLL0, 1, 96, 15625),
+	F(7372800, CFG_CLK_SRC_GPLL0, 1, 192, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0, 1, 384, 15625),
+	F(16000000, CFG_CLK_SRC_GPLL0, 5, 2, 15),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(24000000, CFG_CLK_SRC_GPLL0, 5, 1, 5),
+	F(32000000, CFG_CLK_SRC_GPLL0, 1, 4, 75),
+	F(40000000, CFG_CLK_SRC_GPLL0, 15, 0, 0),
+	F(46400000, CFG_CLK_SRC_GPLL0, 1, 29, 375),
+	F(48000000, CFG_CLK_SRC_GPLL0, 12.5, 0, 0),
+	F(51200000, CFG_CLK_SRC_GPLL0, 1, 32, 375),
+	F(56000000, CFG_CLK_SRC_GPLL0, 1, 7, 75),
+	F(58982400, CFG_CLK_SRC_GPLL0, 1, 1536, 15625),
+	F(60000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
+	F(63157895, CFG_CLK_SRC_GPLL0, 9.5, 0, 0),
+	{ }
+};
+
+/*
+ * In Linux's parent_map for this clock ( gcc_parent_map_xo_gpll0_gpll0_early_div_gpll4 ):
+ * { P_GPLL0_EARLY_DIV, 2 }
+ */
+#define CFG_CLK_SRC_GPLL0_EARLY_DIV_SDCC2 (2 << 8)
+
+static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_EARLY_DIV_SDCC2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EARLY_DIV_SDCC2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_EARLY_DIV_SDCC2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL4, 8, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static const struct pll_vote_clk gpll0_clk = {
+	.status = 0,
+	.status_bit = BIT(31),
+	.ena_vote = 0x52000,
+	.vote_bit = BIT(0),
+};
+
+static const struct gate_clk sdm660_clks[] = {
+	GATE_CLK(GCC_BLSP1_AHB_CLK, 0x52004, BIT(17)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x16008, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x16004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1600c, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
+};
+
+static ulong sdm660_gcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *ftbl_entry;
+
+	debug("%s: clk %s rate %lu\n", __func__, sdm660_clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_BLSP1_UART2_APPS_CLK:
+		ftbl_entry = qcom_find_freq(ftbl_blsp1_uart1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_BLSP1_UART2_APPS_CLK_CMD_RCGR,
+				     ftbl_entry->pre_div, ftbl_entry->m, ftbl_entry->n,
+				     ftbl_entry->src, 8);
+		return ftbl_entry->freq;
+	case GCC_SDCC2_APPS_CLK:
+		ftbl_entry = qcom_find_freq(ftbl_sdcc2_apps_clk_src, rate);
+		/* we probably should enable source PLL for the selected frequency */
+		switch (ftbl_entry->src) {
+		case CFG_CLK_SRC_GPLL0:
+			/* enable gpll0 */
+			clk_enable_gpll0(priv->base, &gpll0_clk);
+			break;
+		case CFG_CLK_SRC_GPLL4:
+			/* enable gpll4 */
+			debug("can't use GPLL4 as src for SDCC2_APPS_CLK, req rate: %lu", rate);
+			break;
+		case CFG_CLK_SRC_GPLL0_EARLY_DIV_SDCC2:
+			/* enable gpll0_early */
+			debug("can't use GPLL0_EARLY as src for SDCC2_APPS_CLK, req rate: %lu",
+			      rate);
+			break;
+		}
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     ftbl_entry->pre_div, ftbl_entry->m, ftbl_entry->n,
+				     ftbl_entry->src, 8);
+		return ftbl_entry->freq;
+	case GCC_SDCC1_APPS_CLK:
+		/* The firmware turns this on for us and always sets it to this rate */
+		return 384000000;
+	default:
+		debug("clock-sdm660: set_rate for some unknown clock %lu\n", clk->id);
+		return rate;
+	}
+}
+
+static int sdm660_gcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("unknown clk id %lu\n", clk->id);
+		return 0;
+	}
+
+	debug("enable clk %s\n", sdm660_clks[clk->id].name);
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sdm660_gcc_resets[] = {
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	/*
+	 * Linux dt-bindings (and sdm630 dtsi) don't have the defines for
+	 * (or uses of) GCC_SDCCn_BCR resets, so this won't compile,
+	 * but the hardware exists and their offsets are:
+	 */
+	/* [GCC_SDCC1_BCR] = { 0x16000 }, */
+	/* [GCC_SDCC2_BCR] = { 0x14000 }, */
+	[GCC_USB_20_BCR] = { 0x2f000 },
+	[GCC_USB_30_BCR] = { 0xf000 },
+	[GCC_USB3_PHY_BCR] = { 0x50020 },
+	[GCC_USB3PHY_PHY_BCR] = { 0x50024 },
+};
+
+static const struct qcom_power_map sdm660_gdscs[] = {
+	[USB_30_GDSC] = { .reg = 0xf004, .flags = VOTABLE },
+};
+
+static struct msm_clk_data sdm660_gcc_data = {
+	.resets = sdm660_gcc_resets,
+	.num_resets = ARRAY_SIZE(sdm660_gcc_resets),
+	.clks = sdm660_clks,
+	.num_clks = ARRAY_SIZE(sdm660_clks),
+	.power_domains = sdm660_gdscs,
+	.num_power_domains = ARRAY_SIZE(sdm660_gdscs),
+
+	.enable = sdm660_gcc_enable,
+	.set_rate = sdm660_gcc_set_rate,
+};
+
+static const struct udevice_id gcc_sdm660_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sdm660",
+		.data = (ulong)&sdm660_gcc_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_sdm660) = {
+	.name = "gcc_sdm660",
+	.id = UCLASS_NOP,
+	.of_match = gcc_sdm660_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.45.2

