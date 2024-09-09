Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F96AEDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077FD88EF1;
	Tue, 10 Sep 2024 05:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="OjX/OYr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB5D88DFA; Mon,  9 Sep 2024 17:53:24 +0200 (CEST)
Received: from smtp10.goneo.de (smtp10.goneo.de [IPv6:2001:1640:5::9:7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CE688E12
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 17:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp10.goneo.de (Postfix) with ESMTPS id 84502240627;
 Mon,  9 Sep 2024 17:53:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id CBF4B240615;
 Mon,  9 Sep 2024 17:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1725897198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMF9h013KyDipGXyu7FTAw6/Ed5iftK1QO/SLuqxHGc=;
 b=OjX/OYr3gYVjSaO1juLwSuzAHA1g68fD9jnfk6Dn6ddV1tH+WtDkUqcoCqV8GajPR9brWj
 jkOaPiXlqbB16jZLX3uDuAqvqvzSn6RId14txH2FcPhMhYYfgoGQcq4l3S1wHPBQ0r0PPu
 /zKvyH3CJUMIIVkBlLbsmZUnh8ToT9JRRQUydTIo85LbQ5b4NPX4gY+6jAR6Tdy9MFNCgK
 BQ77nZYCrT9GDTcYYlVE5G31auiuyc+c2Wv2OJnRE7KtETtFH4OtUxUvyiy5gZGj/o/0Uo
 dBCIJhOruNWE+EkMcrCLuQvoMgipJ1Xrq1e210XUARnLhbo3mrqeNAbzbA7pUw==
Received: from thinkarch.lan
 (p200300cbef069810000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::76d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 745872402D8;
 Mon,  9 Sep 2024 17:53:18 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
To: u-boot@lists.denx.de
Cc: Julius Lehmann <lehmanju@devpi.de>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-qcom@groups.io
Subject: [PATCH 1/3] clk: qcom: add driver for SM8150 SoC
Date: Mon,  9 Sep 2024 17:53:10 +0200
Message-ID: <20240909155315.307026-2-lehmanju@devpi.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909155315.307026-1-lehmanju@devpi.de>
References: <20240909155315.307026-1-lehmanju@devpi.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 1680d9
X-Rspamd-UID: de0081
X-Mailman-Approved-At: Tue, 10 Sep 2024 05:19:45 +0200
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

Add clock, reset and power domain driver for SM8150. Driver code is
based on the similar U-Boot drivers. All constants are taken from the
corresponding Linux driver.

This driver supports clock rate setting only debug UART,
RGMII/Ethernet modules and USB controller.

Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---

 drivers/clk/qcom/Kconfig        |   9 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sm8150.c | 298 ++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sm8150.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 45d63c6d6d..4ac50f25f4 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -69,6 +69,7 @@ config CLK_QCOM_SM8250
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8250 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
 
 config CLK_QCOM_SM8550
 	bool "Qualcomm SM8550 GCC"
@@ -86,6 +87,14 @@ config CLK_QCOM_SM8650
 	  on the Snapdragon SM8650 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon 8150 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index dec20e4b59..e1ab3f9bdd 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
 obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
new file mode 100644
index 0000000000..83c8bc335c
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm SM8150
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ *
+ * (C) Copyright 2024 Julius Lehmann <lehmanju@devpi.de>
+ *
+ * Based on U-Boot driver for SM8250. Constants are taken from the Linux driver.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sm8150.h>
+
+#include "clock-qcom.h"
+
+#define EMAC_RGMII_CLK_CMD_RCGR 0x601c
+#define QUPV3_WRAP0_S0_CLK_CMD_RCGR 0x18148
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf01c
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf034
+#define USB30_SEC_MASTER_CLK_CMD_RCGR 0x1001c
+#define USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR 0x10034
+
+static struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x1a000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x52000,
+	.vote_bit = BIT(7),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL0, 1, 16, 75),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac_rgmii_clk_src[] = {
+	F(2500000, CFG_CLK_SRC_CXO, 1, 25, 192),
+	F(5000000, CFG_CLK_SRC_CXO, 1, 25, 96),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(125000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	F(250000000, CFG_CLK_SRC_GPLL7, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(33333333, CFG_CLK_SRC_GPLL0_EVEN, 9, 0, 0),
+	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_mock_utmi_clk_src[] = {
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 15, 0, 0),
+	F(60000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 0, 0),
+	{ }
+};
+
+static ulong sm8150_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S4_CLK: /* UART2 aka debug-uart */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_EMAC_RGMII_CLK:
+		freq = qcom_find_freq(ftbl_gcc_emac_rgmii_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC_RGMII_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_SEC_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_SEC_MOCK_UTMI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB3_SEC_PHY_AUX_CLK_SRC:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sm8150_clks[] = {
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, 0x00000001),
+	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x1007c, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x10078, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
+	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
+	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
+	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AHB_CLK,			0x75010, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AXI_CLK,			0x7500c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_CLKREF_CLK,		0x8c004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK,		0x75058, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK,		0x7508c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK,		0x75018, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750a8, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75014, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75054, 0x00000001),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x77018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770a8, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77014, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77054, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MASTER_CLK,		0x1000c, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK,		0x10014, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK,		0x10010, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_CLKREF_CLK,		0x8c028, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK,		0x1004c, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK,		0x10054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK,		0x10050, 0x00000001),
+	GATE_CLK(GCC_EMAC_AXI_CLK,			0x06010, 0x00000001),
+	GATE_CLK(GCC_EMAC_SLV_AHB_CLK,			0x06014, 0x00000001),
+	GATE_CLK(GCC_EMAC_PTP_CLK,			0x06034, 0x00000001),
+	GATE_CLK(GCC_EMAC_RGMII_CLK,			0x06018, 0x00000001),
+};
+
+static int sm8150_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, sm8150_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_EMAC_RGMII_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	case GCC_AGGRE_USB3_SEC_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_SEC_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_SEC_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
+		break;
+	};
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sm8150_gcc_resets[] = {
+	[GCC_EMAC_BCR] = { 0x6000 },
+	[GCC_GPU_BCR] = { 0x71000 },
+	[GCC_MMSS_BCR] = { 0xb000 },
+	[GCC_NPU_BCR] = { 0x4d000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_1_BCR] = { 0x8d000 },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_PRNG_BCR] = { 0x34000 },
+	[GCC_QSPI_BCR] = { 0x24008 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_CARD_BCR] = { 0x75000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB30_SEC_BCR] = { 0x10000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct qcom_power_map sm8150_gcc_power_domains[] = {
+	[EMAC_GDSC] = { 0x6004 },
+	[PCIE_0_GDSC] = { 0x6b004 },
+	[PCIE_1_GDSC] = { 0x8d004 },
+	[UFS_CARD_GDSC] = { 0x75004 },
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
+	[USB30_SEC_GDSC] = { 0x10004 },
+};
+
+static struct msm_clk_data sm8150_clk_data = {
+	.resets = sm8150_gcc_resets,
+	.num_resets = ARRAY_SIZE(sm8150_gcc_resets),
+	.clks = sm8150_clks,
+	.num_clks = ARRAY_SIZE(sm8150_clks),
+	.power_domains = sm8150_gcc_power_domains,
+	.num_power_domains = ARRAY_SIZE(sm8150_gcc_power_domains),
+
+	.enable = sm8150_clk_enable,
+	.set_rate = sm8150_clk_set_rate,
+};
+
+static const struct udevice_id gcc_sm8150_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sm8150",
+		.data = (ulong)&sm8150_clk_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sm8150) = {
+	.name		= "gcc_sm8150",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sm8150_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.45.2

