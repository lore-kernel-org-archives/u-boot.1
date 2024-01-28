Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E7C47DA9
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D766C87F68;
	Sun, 28 Jan 2024 16:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AyMQfoc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B94087EE4; Sun, 28 Jan 2024 16:55:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDFC587EEA
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNGHT3yPzz9sf0;
 Sun, 28 Jan 2024 16:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dhmk5eRm3wNcvraJmcBYmo3mmsX/x+RPHG7ER2AeFNs=;
 b=AyMQfoc2zL+e3TWmVE6zYfNBAwFoXVV6ZPZAqtDamU8a4rzGhQMMZ741/1LmbuoTWWnaYN
 gEfu+TgMxLoTAyY7hUWX9hUKqqCGXd3cRtapCPkYJhFSDLzR1pdTbF/qDrh7iFNgna1UJx
 DDxrkRGcUYXnplnBOst2gkhn+XnyiOt9lr6+o2HckXehOOlCU2KEB30GBBNeR2gEE3qXMg
 rI9fDLNHApHjc/Ka7jzJoAmdtCDrEkZ91J6HhcpJtBVdBxr4GTxVlFmLx/LoVf/ecZs5kj
 8TLhgVEwhhdpVdM5jZ6UI1FzYSAMNMeDoip9kNfE4rb4jvnumWmPafjzlVCcjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Lukasz Majewski <lukma@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 03/11] clk: renesas: Add R8A779H0 V4M clock tables
Date: Sun, 28 Jan 2024 16:52:01 +0100
Message-ID: <20240128155458.56712-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 89e5998ec8b33898e3c
X-MBO-RS-META: hun68mq8gggw1exqgdahcu6kby7ygrun
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add clock tables for R8A779H0 V4M SoC.

The current version is imported from:
https://lore.kernel.org/linux-renesas-soc/c678ef7164e3777fa91572f72e47ef385cea64b8.1706194617.git.geert+renesas@glider.be/
The current version still contains PLL7 extras from the
previous version to provide ethernet support in U-Boot.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sean Anderson <seanga2@gmail.com>
---
V2: Partly update to version submitted to Linux kernel upstream
---
 drivers/clk/renesas/Kconfig             |   6 +
 drivers/clk/renesas/Makefile            |   1 +
 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 293 ++++++++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.h     |   1 +
 4 files changed, 301 insertions(+)
 create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 927d62cf99a..e9296ed9fe2 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -151,6 +151,12 @@ config CLK_R8A779G0
 	help
 	  Enable this to support the clocks on Renesas R8A779G0 SoC.
 
+config CLK_R8A779H0
+	bool "Renesas R8A779H0 clock driver"
+	depends on CLK_RCAR_GEN3
+	help
+	  Enable this to support the clocks on Renesas R8A779H0 SoC.
+
 config CLK_R9A06G032
 	bool "Renesas R9A06G032 clock driver"
 	depends on CLK_RENESAS
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index df7e225e9ca..6c742553091 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_CLK_R8A77995) += r8a77995-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779A0) += r8a779a0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779F0) += r8a779f0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779G0) += r8a779g0-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A779H0) += r8a779h0-cpg-mssr.o
 obj-$(CONFIG_CLK_R9A06G032) += r9a06g032-clocks.o
 obj-$(CONFIG_CLK_RZG2L) += rzg2l-cpg.o
 obj-$(CONFIG_CLK_R9A07G044) += r9a07g044-cpg.o
diff --git a/drivers/clk/renesas/r8a779h0-cpg-mssr.c b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
new file mode 100644
index 00000000000..8bb7b41c787
--- /dev/null
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * r8a779h0 Clock Pulse Generator / Module Standby and Software Reset
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ *
+ * Based on r8a779g0-cpg-mssr.c
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+
+#include <dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h>
+
+#include "renesas-cpg-mssr.h"
+#include "rcar-gen3-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R8A779H0_CLK_R,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+	CLK_EXTALR,
+
+	/* Internal Core Clocks */
+	CLK_MAIN,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL3,
+	CLK_PLL4,
+	CLK_PLL5,
+	CLK_PLL6,
+	CLK_PLL7,
+	CLK_PLL1_DIV2,
+	CLK_PLL2_DIV2,
+	CLK_PLL3_DIV2,
+	CLK_PLL4_DIV2,
+	CLK_PLL4_DIV5,
+	CLK_PLL5_DIV2,
+	CLK_PLL5_DIV4,
+	CLK_PLL6_DIV2,
+	CLK_PLL7_DIV2,
+	CLK_S0,
+	CLK_S0_VIO,
+	CLK_S0_VC,
+	CLK_S0_HSC,
+	CLK_SASYNCPER,
+	CLK_SV_VIP,
+	CLK_SV_IR,
+	CLK_IMPASRC,
+	CLK_IMPBSRC,
+	CLK_VIOSRC,
+	CLK_VCSRC,
+	CLK_SDSRC,
+	CLK_RPCSRC,
+	CLK_OCO,
+
+	/* Module Clocks */
+	MOD_CLK_BASE
+};
+
+static const struct cpg_core_clk r8a779h0_core_clks[] = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal",	CLK_EXTAL),
+	DEF_INPUT("extalr",	CLK_EXTALR),
+
+	/* Internal Core Clocks */
+	DEF_BASE(".main", CLK_MAIN,	CLK_TYPE_GEN4_MAIN,	CLK_EXTAL),
+	DEF_BASE(".pll1", CLK_PLL1,	CLK_TYPE_GEN4_PLL1,	CLK_MAIN),
+	DEF_BASE(".pll2", CLK_PLL2,	CLK_TYPE_GEN4_PLL2,	CLK_MAIN),
+	DEF_BASE(".pll3", CLK_PLL3,	CLK_TYPE_GEN4_PLL3,	CLK_MAIN),
+	DEF_BASE(".pll4", CLK_PLL4,	CLK_TYPE_GEN4_PLL4,	CLK_MAIN),
+	DEF_BASE(".pll5", CLK_PLL5,	CLK_TYPE_GEN4_PLL5,	CLK_MAIN),
+	DEF_BASE(".pll6", CLK_PLL6,	CLK_TYPE_GEN4_PLL6,	CLK_MAIN),
+	DEF_BASE(".pll7", CLK_PLL7,	CLK_TYPE_GEN4_PLL7,	CLK_MAIN),
+
+	DEF_FIXED(".pll1_div2",	CLK_PLL1_DIV2,	CLK_PLL1,	2, 1),
+	DEF_FIXED(".pll2_div2",	CLK_PLL2_DIV2,	CLK_PLL2,	2, 1),
+	DEF_FIXED(".pll3_div2",	CLK_PLL3_DIV2,	CLK_PLL3,	2, 1),
+	DEF_FIXED(".pll4_div2",	CLK_PLL4_DIV2,	CLK_PLL4,	2, 1),
+	DEF_FIXED(".pll4_div5",	CLK_PLL4_DIV5,	CLK_PLL4,	5, 1),
+	DEF_FIXED(".pll5_div2",	CLK_PLL5_DIV2,	CLK_PLL5,	2, 1),
+	DEF_FIXED(".pll5_div4",	CLK_PLL5_DIV4,	CLK_PLL5_DIV2,	2, 1),
+	DEF_FIXED(".pll6_div2",	CLK_PLL6_DIV2,	CLK_PLL6,	2, 1),
+	DEF_FIXED(".pll7_div2",	CLK_PLL7_DIV2,	CLK_PLL7,	2, 1),
+	DEF_FIXED(".s0",	CLK_S0,		CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0_vio",	CLK_S0_VIO,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0_vc",	CLK_S0_VC,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0_hsc",	CLK_S0_HSC,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".sasyncper",	CLK_SASYNCPER,	CLK_PLL5_DIV4,	3, 1),
+	DEF_FIXED(".sv_vip",	CLK_SV_VIP,	CLK_PLL1,	5, 1),
+	DEF_FIXED(".sv_ir",	CLK_SV_IR,	CLK_PLL1,	5, 1),
+	DEF_FIXED(".impasrc",	CLK_IMPASRC,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".impbsrc",	CLK_IMPBSRC,	CLK_PLL1,	4, 1),
+	DEF_FIXED(".viosrc",	CLK_VIOSRC,	CLK_PLL1,	6, 1),
+	DEF_FIXED(".vcsrc",	CLK_VCSRC,	CLK_PLL1,	6, 1),
+	DEF_BASE(".sdsrc",	CLK_SDSRC,	CLK_TYPE_GEN4_SDSRC, CLK_PLL5),
+	DEF_BASE(".rpcsrc",	CLK_RPCSRC,	CLK_TYPE_GEN4_RPCSRC, CLK_PLL5),
+	DEF_RATE(".oco",	CLK_OCO,	32768),
+
+	/* Core Clock Outputs */
+	DEF_GEN4_Z("zc0",	R8A779H0_CLK_ZC0,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 0),
+	DEF_GEN4_Z("zc1",	R8A779H0_CLK_ZC1,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 8),
+	DEF_GEN4_Z("zc2",	R8A779H0_CLK_ZC2,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 32),
+	DEF_GEN4_Z("zc3",	R8A779H0_CLK_ZC3,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 40),
+	DEF_FIXED("s0d2",	R8A779H0_CLK_S0D2,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3",	R8A779H0_CLK_S0D3,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4",	R8A779H0_CLK_S0D4,	CLK_S0,		4, 1),
+	DEF_FIXED("cl16m",	R8A779H0_CLK_CL16M,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_rt",	R8A779H0_CLK_S0D2_RT,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3_rt",	R8A779H0_CLK_S0D3_RT,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4_rt",	R8A779H0_CLK_S0D4_RT,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d6_rt",	R8A779H0_CLK_S0D6_RT,	CLK_S0,		6, 1),
+	DEF_FIXED("cl16m_rt",	R8A779H0_CLK_CL16M_RT,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_per",	R8A779H0_CLK_S0D2_PER,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3_per",	R8A779H0_CLK_S0D3_PER,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4_per",	R8A779H0_CLK_S0D4_PER,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d6_per",	R8A779H0_CLK_S0D6_PER,	CLK_S0,		6, 1),
+	DEF_FIXED("s0d12_per",	R8A779H0_CLK_S0D12_PER,	CLK_S0,		12, 1),
+	DEF_FIXED("s0d24_per",	R8A779H0_CLK_S0D24_PER,	CLK_S0,		24, 1),
+	DEF_FIXED("cl16m_per",	R8A779H0_CLK_CL16M_PER,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_mm",	R8A779H0_CLK_S0D2_MM,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d4_mm",	R8A779H0_CLK_S0D4_MM,	CLK_S0,		4, 1),
+	DEF_FIXED("cl16m_mm",	R8A779H0_CLK_CL16M_MM,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_u3dg",	R8A779H0_CLK_S0D2_U3DG,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d4_u3dg",	R8A779H0_CLK_S0D4_U3DG,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d1_vio",	R8A779H0_CLK_S0D1_VIO,	CLK_S0_VIO,	1, 1),
+	DEF_FIXED("s0d2_vio",	R8A779H0_CLK_S0D2_VIO,	CLK_S0_VIO,	2, 1),
+	DEF_FIXED("s0d4_vio",	R8A779H0_CLK_S0D4_VIO,	CLK_S0_VIO,	4, 1),
+	DEF_FIXED("s0d8_vio",	R8A779H0_CLK_S0D8_VIO,	CLK_S0_VIO,	8, 1),
+	DEF_FIXED("s0d1_vc",	R8A779H0_CLK_S0D1_VC,	CLK_S0_VC,	1, 1),
+	DEF_FIXED("s0d2_vc",	R8A779H0_CLK_S0D2_VC,	CLK_S0_VC,	2, 1),
+	DEF_FIXED("s0d4_vc",	R8A779H0_CLK_S0D4_VC,	CLK_S0_VC,	4, 1),
+	DEF_FIXED("s0d1_hsc",	R8A779H0_CLK_S0D1_HSC,	CLK_S0_HSC,	1, 1),
+	DEF_FIXED("s0d2_hsc",	R8A779H0_CLK_S0D2_HSC,	CLK_S0_HSC,	2, 1),
+	DEF_FIXED("s0d4_hsc",	R8A779H0_CLK_S0D4_HSC,	CLK_S0_HSC,	4, 1),
+	DEF_FIXED("s0d8_hsc",	R8A779H0_CLK_S0D8_HSC,	CLK_S0_HSC,	8, 1),
+	DEF_FIXED("cl16m_hsc",	R8A779H0_CLK_CL16M_HSC,	CLK_S0_HSC,	48, 1),
+	DEF_FIXED("sasyncrt",	R8A779H0_CLK_SASYNCRT,	CLK_PLL5_DIV4,	48, 1),
+	DEF_FIXED("sasyncperd1", R8A779H0_CLK_SASYNCPERD1, CLK_SASYNCPER, 1, 1),
+	DEF_FIXED("sasyncperd2", R8A779H0_CLK_SASYNCPERD2, CLK_SASYNCPER, 2, 1),
+	DEF_FIXED("sasyncperd4", R8A779H0_CLK_SASYNCPERD4, CLK_SASYNCPER, 4, 1),
+	DEF_FIXED("svd1_vip",	R8A779H0_CLK_SVD1_VIP,	CLK_SV_VIP,	1, 1),
+	DEF_FIXED("svd2_vip",	R8A779H0_CLK_SVD2_VIP,	CLK_SV_VIP,	2, 1),
+	DEF_FIXED("svd1_ir",	R8A779H0_CLK_SVD1_IR,	CLK_SV_IR,	1, 1),
+	DEF_FIXED("svd2_ir",	R8A779H0_CLK_SVD2_IR,	CLK_SV_IR,	2, 1),
+	DEF_FIXED("cbfusa",	R8A779H0_CLK_CBFUSA,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cpex",	R8A779H0_CLK_CPEX,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cp",		R8A779H0_CLK_CP,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("impad1",	R8A779H0_CLK_IMPAD1,	CLK_IMPASRC,	1, 1),
+	DEF_FIXED("impad4",	R8A779H0_CLK_IMPAD4,	CLK_IMPASRC,	4, 1),
+	DEF_FIXED("impb",	R8A779H0_CLK_IMPB,	CLK_IMPBSRC,	1, 1),
+	DEF_FIXED("viobusd1",	R8A779H0_CLK_VIOBUSD1,	CLK_VIOSRC,	1, 1),
+	DEF_FIXED("viobusd2",	R8A779H0_CLK_VIOBUSD2,	CLK_VIOSRC,	2, 1),
+	DEF_FIXED("vcbusd1",	R8A779H0_CLK_VCBUSD1,	CLK_VCSRC,	1, 1),
+	DEF_FIXED("vcbusd2",	R8A779H0_CLK_VCBUSD2,	CLK_VCSRC,	2, 1),
+	DEF_DIV6P1("canfd",	R8A779H0_CLK_CANFD,	CLK_PLL5_DIV4,	0x878),
+	DEF_DIV6P1("csi",	R8A779H0_CLK_CSI,	CLK_PLL5_DIV4,	0x880),
+	DEF_FIXED("dsiref",	R8A779H0_CLK_DSIREF,	CLK_PLL5_DIV4,	48, 1),
+	DEF_DIV6P1("dsiext",	R8A779H0_CLK_DSIEXT,	CLK_PLL5_DIV4,	0x884),
+	DEF_DIV6P1("mso",	R8A779H0_CLK_MSO,	CLK_PLL5_DIV4,	0x87c),
+
+	DEF_GEN4_SDH("sd0h",	R8A779H0_CLK_SD0H,	CLK_SDSRC,	   0x870),
+	DEF_GEN4_SD("sd0",	R8A779H0_CLK_SD0,	R8A779H0_CLK_SD0H, 0x870),
+
+	DEF_BASE("rpc",		R8A779H0_CLK_RPC,	CLK_TYPE_GEN4_RPC, CLK_RPCSRC),
+	DEF_BASE("rpcd2",	R8A779H0_CLK_RPCD2,	CLK_TYPE_GEN4_RPCD2, R8A779H0_CLK_RPC),
+
+	DEF_GEN4_OSC("osc",	R8A779H0_CLK_OSC,	CLK_EXTAL,	8),
+	DEF_GEN4_MDSEL("r",	R8A779H0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
+};
+
+static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
+	DEF_MOD("avb0-rgmii0",	211,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("avb1-rgmii1",	212,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("avb2-rgmii2",	213,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("hscif0",	514,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("hscif1",	515,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("hscif2",	516,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("hscif3",	517,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("i2c0",		518,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("i2c1",		519,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("i2c2",		520,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("i2c3",		521,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("rpc-if",	629,	R8A779H0_CLK_RPCD2),
+	DEF_MOD("sdhi0",	706,	R8A779H0_CLK_SD0),
+	DEF_MOD("pfc0",		915,	R8A779H0_CLK_CL16M),
+	DEF_MOD("pfc1",		916,	R8A779H0_CLK_CL16M),
+	DEF_MOD("pfc2",		917,	R8A779H0_CLK_CL16M),
+};
+
+/*
+ * CPG Clock Data
+ */
+/*
+ *   MD	 EXTAL		PLL1	PLL2	PLL3	PLL4	PLL5	PLL6	OSC
+ * 14 13 (MHz)
+ * ------------------------------------------------------------------------
+ * 0  0	 16.66 / 1	x192	x204	x192	x144	x192	x168	/16
+ * 0  1	 20    / 1	x160	x170	x160	x120	x160	x140	/19
+ * 1  0	 Prohibited setting
+ * 1  1	 33.33 / 2	x192	x204	x192	x144	x192	x168	/32
+ */
+#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 13) | \
+					 (((md) & BIT(13)) >> 13))
+
+static const struct rcar_gen4_cpg_pll_config cpg_pll_configs[4] = {
+	/* EXTAL div	PLL1 mult/div	PLL2 mult/div	PLL3 mult/div	PLL4 mult/div	PLL5 mult/div	PLL6 mult/div	OSC prediv */
+	{ 1,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	16,	},
+	{ 1,		160,	1,	200,	1,	160,	1,	200,	1,	160,	1,	140,	1,	19,	},
+	{ 0,		0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	},
+	{ 2,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	32,	},
+};
+
+/*
+ * Note that the only clock left running before booting Linux are now
+ * MFIS, INTC-AP, INTC-EX, SCIF0, HSCIF0 on V4M
+ */
+#define MSTPCR5_INTCAP	BIT(11)
+#define MSTPCR5_HSCIF0	BIT(14)
+#define MSTPCR6_INTCEX	BIT(11)
+#define MSTPCR7_SCIF0	BIT(2)
+
+static const struct mstp_stop_table r8a779h0_mstp_table[] = {
+	{ 0x0FC102A1, 0x0, 0x0, 0x0 },
+	{ 0x00D50020, 0x0, 0x0, 0x0 },
+	{ 0x00003800, 0x0, 0x0, 0x0 },
+	{ 0xF0000000, 0x0, 0x0, 0x0 },
+	{ 0x0000CA01, 0x0, 0x0, 0x0 },
+	{ 0xE63FE100, MSTPCR5_HSCIF0 | MSTPCR5_INTCAP, 0x0, 0x0 },
+	{ 0xF1FF3900, MSTPCR6_INTCEX, 0x0, 0x0 },
+	{ 0xDFF7E6FC, MSTPCR7_SCIF0, 0x0, 0x0 },
+	{ 0x40003FFF, 0x0, 0x0, 0x0 },
+	{ 0x001BBCF8, 0x0, 0x0, 0x0 },
+	{ 0x10000000, 0x0, 0x0, 0x0 },
+	{ 0x00000001, 0x0, 0x0, 0x0 },
+	{ 0xDE000000, 0x0, 0x0, 0x0 },
+	{ 0x00000017, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x00000000, 0x0, 0x0, 0x0 },
+	{ 0x308003C0, 0x0, 0x0, 0x0 },
+	{ 0x402200E6, 0x0, 0x0, 0x0 },
+	{ 0x0C000000, 0x0, 0x0, 0x0 },
+};
+
+static const void *r8a779h0_get_pll_config(const u32 cpg_mode)
+{
+	return &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+}
+
+static const struct cpg_mssr_info r8a779h0_cpg_mssr_info = {
+	.core_clk		= r8a779h0_core_clks,
+	.core_clk_size		= ARRAY_SIZE(r8a779h0_core_clks),
+	.mod_clk		= r8a779h0_mod_clks,
+	.mod_clk_size		= ARRAY_SIZE(r8a779h0_mod_clks),
+	.mstp_table		= r8a779h0_mstp_table,
+	.mstp_table_size	= ARRAY_SIZE(r8a779h0_mstp_table),
+	.reset_node		= "renesas,r8a779h0-rst",
+	.reset_modemr_offset	= CPG_RST_MODEMR0,
+	.extalr_node		= "extalr",
+	.mod_clk_base		= MOD_CLK_BASE,
+	.clk_extal_id		= CLK_EXTAL,
+	.clk_extalr_id		= CLK_EXTALR,
+	.get_pll_config		= r8a779h0_get_pll_config,
+	.reg_layout		= CLK_REG_LAYOUT_RCAR_GEN4,
+};
+
+static const struct udevice_id r8a779h0_cpg_ids[] = {
+	{
+		.compatible	= "renesas,r8a779h0-cpg-mssr",
+		.data		= (ulong)&r8a779h0_cpg_mssr_info
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(clk_r8a779h0) = {
+	.name		= "cpg_r8a779h0",
+	.id		= UCLASS_NOP,
+	.of_match	= r8a779h0_cpg_ids,
+	.bind		= gen3_cpg_bind,
+};
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 370f26c4f0f..7bea09c4827 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -41,6 +41,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN4_PLL5,
 	CLK_TYPE_GEN4_PLL4,
 	CLK_TYPE_GEN4_PLL6,
+	CLK_TYPE_GEN4_PLL7,
 	CLK_TYPE_GEN4_SDSRC,
 	CLK_TYPE_GEN4_SDH,
 	CLK_TYPE_GEN4_SD,
-- 
2.43.0

