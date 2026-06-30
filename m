Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695CEC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AD684AD4;
	Tue, 30 Jun 2026 03:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="TCE0tnce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D05684AD4; Tue, 30 Jun 2026 03:19:44 +0200 (CEST)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF0D84AD3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-13b2b92b0bfso429720c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782380; x=1783387180;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hs+XoK7KsQprknTDMKG7bBseNjuI8vJnMUv0wYyUsVw=;
 b=TCE0tnce1JK3yAihbgQ/4g5VJe0K+UqlyKLL5AAZ3JQwxPJqQukfHFJhMGM99WMoFh
 Ylj6KtXSfEGMvd3LpI61FiiDJ4+dh1cJWk87d2rcjVQh9To+5xLcUAyu6UdUBJ2kW8cr
 9m2+wPEJ1X4/jjspCZsApKFSkiyhDLZW9HVWWUsPtRPGFGaCUkP4Tr6UYsCBWDj2jrJS
 oC+GkLZMUacUlH6ISo5dsnZC0jkPY7wfd0cX0v94n9UmBpkhVZC276oouydtfLwS+Ud0
 6PPJ9Wvi+Pejfe8/BmvUXXGrUSbQJVbRCghDN9sS7oW0KjrL/NRsiI3Tz4CPufMhH3wH
 SBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782380; x=1783387180;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hs+XoK7KsQprknTDMKG7bBseNjuI8vJnMUv0wYyUsVw=;
 b=DmFXar+TwiW5wSB0Rzg7CzeZSGLkxNugufiYZW2S9yIvvSp9cL8Ap7OgqzHZd2jUaT
 Kd+lr5GNkasamLCd32RfyDw8OyZ7lNM5Vwcv+j/a406ZNaII4Di4s4uCDMGALihPK8vG
 Ka4jGEA/Ehj1aad8UTXyfVpL3xnIBomQ5eYrjL8vcj79gxFP60FIP+kAJG+ALMrSTddO
 dcMIWlJoNYCjLRnSW/qgId4qIYA6/yNTEwAQ6YB1mp3h1hxMjxak0zQLInwhWtYY5kIk
 9nyjsYo2pu36Yy1LH42mzm2PjZUbMVa51MC4e2cGU4KROGSen5ePTB50YVd+rHuF4/7Y
 P3YA==
X-Gm-Message-State: AOJu0YyFxzT63S6B0khEulbzIpAMicS6rOAFxvLIUDyBzoLEy6EKtuEi
 OwAz/LkHdGRRhmCjZFEr6ABhfsXxqHQ44GFyYvzYRBsTdNouaERH9WNMoiAXwZSRmgI=
X-Gm-Gg: AfdE7clmQlaSCEJbLEdfkQ1nRGf4/oohHYCyclDJZSsJavSz0N3l3FSJCJRmNR37fye
 8Xze4SpSgR48N+Co8iPvB6iivnx70Lgbq3DKzboxXHCXOVCmDXT5BVvKUfVvfWTinCHcoyIWwaz
 uvSLzaT2qcohmuImnc92rOG7BBgqWlT4ENqaIwJqsJUxIb/DkPqr6EjT2eCQZkdf1m3MdNzZecv
 +BT/t3YGrAhl2EwqnpPL2S0mOpFCKGhtDfNB2Mm4A4/ZQLu/tmlXSu2C8/OAvXYPvrMYafexvB4
 Xr+KHBOtKFC+4+gCZ+zkEKARjGOTIQffc3uFZhFSIzWbWuuvgAzwTvycreMNZDdWrse54Bf/LzF
 eR5kDiQ3oXzA58NW3A2GVZlu0IOosbDH4e6nosTgBIApKi6gQ7GLQmsx+tQutSpFBZHV4d1LDhf
 +mzNY4qDbrkh//ONRwpyyZOR2srHVwvrRwDKCrxwwhEJdjfDBf5CeAyXm7AmS4ChdgxYIpdPfdt
 1LAPn1vR+OKMt/0k/KSvciWcM0avpwoxiIDkwbJwhB8sGGHY4rf5+kgqEhMRXtC
X-Received: by 2002:a05:7022:3d10:b0:137:ae1d:5b58 with SMTP id
 a92af1059eb24-13b2a1848d9mr921953c88.20.1782782380129; 
 Mon, 29 Jun 2026 18:19:40 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:39 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:05 +0800
Subject: [PATCH v5 04/14] clk: spacemit: k1: prune SPL clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-4-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

From: Guodong Xu <guodong@riscstar.com>

K1 SPL runs from on-chip SRAM with a small pre-relocation malloc heap.
Registering the full K1 clock tree would not fit, so split the tree on
CONFIG_SPL_BUILD: the SPL build registers only the subset SPL needs
(currently UART, SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC
ancestors); the non-SPL build keeps the full tree.

Where surviving SPL CCU definitions reference parent clocks outside
that subset, use "clock-dummy", so framework parent lookups still resolve.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 drivers/clk/spacemit/clk-k1.c | 128 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index 6175cf09500..07adc126ee3 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -44,6 +44,18 @@ static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
 	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_PLL_DEFINE(CLK_PLL1, pll1, pll1, "clock-24m", pll1_rate_tbl,
+	       APBS_PLL1_SWCR1, APBS_PLL1_SWCR3, MPMU_POSR, POSR_PLL1_LOCK,
+	       CLK_SET_RATE_GATE);
+
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D4, pll1_d4, pll1_d4, "pll1", APBS_PLL1_SWCR2,
+		       BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D6, pll1_d6, pll1_d6, "pll1", APBS_PLL1_SWCR2,
+		       BIT(5), 6, 1);
+CCU_FACTOR_GATE_FLAGS_DEFINE(CLK_PLL1_D8, pll1_d8, pll1_d8, "pll1",
+			     APBS_PLL1_SWCR2, BIT(7), 8, 1, CLK_IS_CRITICAL);
+#else
 static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
 	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
 };
@@ -131,9 +143,23 @@ CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D8, pll3_d8, pll3_d8, "pll3", APBS_PLL3_SWCR2,
 CCU_FACTOR_DEFINE(CLK_PLL3_20, pll3_20, pll3_20, "pll3_d8", 20, 1);
 CCU_FACTOR_DEFINE(CLK_PLL3_40, pll3_40, pll3_40, "pll3_d8", 10, 1);
 CCU_FACTOR_DEFINE(CLK_PLL3_80, pll3_80, pll3_80, "pll3_d8", 5, 1);
+#endif
 /* APBS clocks end */
 
 /* MPMU clocks start */
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_GATE_DEFINE(CLK_PLL1_614, pll1_d4_614p4, pll1_d4_614p4, "pll1_d4",
+		MPMU_ACGR, BIT(15), 0);
+CCU_GATE_DEFINE(CLK_PLL1_409P6, pll1_d6_409p6, pll1_d6_409p6, "pll1_d6",
+		MPMU_ACGR, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
+		MPMU_ACGR, BIT(13), 0);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_31P5, pll1_d78_31p5, pll1_d78_31p5,
+		       "pll1_d4", MPMU_ACGR, BIT(6), 39, 2);
+CCU_DDN_DEFINE(CLK_SLOW_UART2, slow_uart2_48, slow_uart2_48,
+	       "pll1_d4_614p4", MPMU_SUCCR_1,
+	       CCU_DDN_MASK(16, 13), 16, CCU_DDN_MASK(0, 13), 0, 2, 0);
+#else
 CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
 		MPMU_ACGR, BIT(13), 0);
 
@@ -251,9 +277,37 @@ CCU_GATE_DEFINE(CLK_WDT_BUS, wdt_bus_clk, wdt_bus_clk, "apb_clk", MPMU_WDTPCR,
 		BIT(0), 0);
 
 CCU_GATE_DEFINE(CLK_RIPC, ripc_clk, ripc_clk, "apb_clk", MPMU_RIPCCR, 0x1, 0);
+#endif
 /* MPMU clocks end */
 
 /* APBC clocks start */
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static const char * const uart_clk_parents[] = {
+	"clock-dummy",
+	"clock-dummy",
+	"slow_uart2_48",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_UART0, uart0_clk, uart0_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART1_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+
+static const char * const twsi_parents[] = {
+	"pll1_d78_31p5",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+/*
+ * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
+ * Combine functional and bus bits together as a gate to avoid sharing the
+ * write-only register between different clock hardwares.
+ */
+CCU_GATE_DEFINE(CLK_TWSI8, twsi8_clk, twsi8_clk, "pll1_d78_31p5",
+		APBC_TWSI8_CLK_RST, BIT(1) | BIT(0), 0);
+
+#else
 static const char * const uart_clk_parents[] = {
 	"pll1_m3d128_57p6",
 	"slow_uart1_14p74",
@@ -598,9 +652,44 @@ CCU_GATE_DEFINE(CLK_TSEN_BUS, tsen_bus_clk, tsen_bus_clk, "apb_clk",
 
 CCU_GATE_DEFINE(CLK_IPC_AP2AUD_BUS, ipc_ap2aud_bus_clk, ipc_ap2aud_bus_clk,
 		"apb_clk", APBC_IPC_AP2AUD_CLK_RST, BIT(0), 0);
+#endif
 /* APBC clocks end */
 
 /* APMU clocks start */
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static const char * const pmua_aclk_parents[] = {
+	"clock-dummy",
+	"pll1_d8_307p2",
+};
+
+CCU_MUX_DIV_FC_DEFINE(CLK_PMUA_ACLK, pmua_aclk, pmua_aclk, pmua_aclk_parents,
+		      ARRAY_SIZE(pmua_aclk_parents),
+		      APMU_ACLK_CLK_CTRL, APMU_ACLK_CLK_CTRL, 1, 2, BIT(4),
+		      0, 1, 0);
+
+CCU_GATE_DEFINE(CLK_SDH_AXI, sdh_axi_aclk, sdh_axi_aclk, "pmua_aclk",
+		APMU_SDH0_CLK_RES_CTRL, BIT(3), 0);
+
+static const char * const sdh01_parents[] = {
+	"pll1_d6_409p6",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_SDH0, sdh0_clk, sdh0_clk, sdh01_parents,
+				 ARRAY_SIZE(sdh01_parents),
+				 APMU_SDH0_CLK_RES_CTRL,
+				 APMU_SDH0_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+				 BIT(4), 0);
+
+static const char * const sdh2_parents[] = {
+	"pll1_d6_409p6",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_SDH2, sdh2_clk, sdh2_clk, sdh2_parents,
+				 ARRAY_SIZE(sdh2_parents),
+				 APMU_SDH2_CLK_RES_CTRL,
+				 APMU_SDH2_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+				 BIT(4), 0);
+#else
 static const char * const pmua_aclk_parents[] = {
 	"pll1_d10_245p76",
 	"pll1_d8_307p2",
@@ -1082,8 +1171,17 @@ CCU_GATE_DEFINE(CLK_EMAC1_BUS, emac1_bus_clk, emac1_bus_clk, "pmua_aclk",
 CCU_GATE_DEFINE(CLK_EMAC1_PTP, emac1_ptp_clk, emac1_ptp_clk, "pll2_d6",
 		APMU_EMAC1_CLK_RES_CTRL, BIT(15), 0);
 
+#endif
 /* APMU clocks end */
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_pll_clks[] = {
+	&pll1.common.clk,
+	&pll1_d4.common.clk,
+	&pll1_d6.common.clk,
+	&pll1_d8.common.clk,
+};
+#else
 static struct clk *k1_ccu_pll_clks[] = {
 	&pll1.common.clk,
 	&pll2.common.clk,
@@ -1121,6 +1219,7 @@ static struct clk *k1_ccu_pll_clks[] = {
 	&pll3_40.common.clk,
 	&pll3_20.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k1_ccu_pll_data = {
 	.clks		= k1_ccu_pll_clks,
@@ -1128,6 +1227,15 @@ static const struct spacemit_ccu_data k1_ccu_pll_data = {
 	.offset		= K1_PLL_ID,
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_mpmu_clks[] = {
+	&pll1_d4_614p4.common.clk,
+	&pll1_d6_409p6.common.clk,
+	&pll1_d8_307p2.common.clk,
+	&pll1_d78_31p5.common.clk,
+	&slow_uart2_48.common.clk,
+};
+#else
 static struct clk *k1_ccu_mpmu_clks[] = {
 	&pll1_d8_307p2.common.clk,
 	&pll1_d32_76p8.common.clk,
@@ -1167,6 +1275,7 @@ static struct clk *k1_ccu_mpmu_clks[] = {
 	&i2s_bclk.common.clk,
 	&wdt_bus_clk.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
 	.clks		= k1_ccu_mpmu_clks,
@@ -1174,6 +1283,13 @@ static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
 	.offset		= K1_MPMU_ID,
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_apbc_clks[] = {
+	&uart0_clk.common.clk,
+	&twsi2_clk.common.clk,
+	&twsi8_clk.common.clk,
+};
+#else
 static struct clk *k1_ccu_apbc_clks[] = {
 	&uart0_clk.common.clk,
 	&uart2_clk.common.clk,
@@ -1278,6 +1394,7 @@ static struct clk *k1_ccu_apbc_clks[] = {
 	&sspa0_i2s_bclk.common.clk,
 	&sspa1_i2s_bclk.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k1_ccu_apbc_data = {
 	.clks		= k1_ccu_apbc_clks,
@@ -1285,6 +1402,14 @@ static const struct spacemit_ccu_data k1_ccu_apbc_data = {
 	.offset		= K1_APBC_ID,
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_apmu_clks[] = {
+	&pmua_aclk.common.clk,
+	&sdh_axi_aclk.common.clk,
+	&sdh0_clk.common.clk,
+	&sdh2_clk.common.clk,
+};
+#else
 static struct clk *k1_ccu_apmu_clks[] = {
 	&cci550_clk.common.clk,
 	&cpu_c0_hi_clk.common.clk,
@@ -1349,6 +1474,7 @@ static struct clk *k1_ccu_apmu_clks[] = {
 	&v2d_clk.common.clk,
 	&emmc_bus_clk.common.clk,
 };
+#endif
 
 static int clk_k1_enable(struct clk *clk)
 {
@@ -1473,6 +1599,8 @@ static int k1_pll_clk_probe(struct udevice *dev)
 	const struct spacemit_ccu_data *data;
 	int ret;
 
+	clk_register_fixed_rate(NULL, "clock-dummy", 0);
+
 	ret = regmap_init_mem(dev_ofnode(dev), &base_regmap);
 	if (ret)
 		return ret;

-- 
2.51.0

