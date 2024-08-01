Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0183DC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 03:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8DA88AD7;
	Thu,  1 Aug 2024 05:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86BE588AE1; Thu,  1 Aug 2024 05:39:29 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5D988ACA
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 05:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5A111A0C5B;
 Thu,  1 Aug 2024 05:39:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5509E1A06FC;
 Thu,  1 Aug 2024 05:39:26 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 AC1BC1820F59; Thu,  1 Aug 2024 11:39:24 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de,
 seanga2@gmail.com, xypron.glpk@gmx.de
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 01/14] clk: imx8m: register ARM A53 core clock
Date: Thu,  1 Aug 2024 11:59:46 +0800
Message-Id: <20240801035959.43115-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240801035959.43115-1-Zhiqiang.Hou@nxp.com>
References: <20240801035959.43115-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Register ARM A53 core clock for i.MX 8M Mini, Nano and Plus, preparing
for enabling the 'cpu' command, which depends on this to print CPU core
frequency.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V5:
 - Made the i.MX8M core clock CLK_IS_CRITICAL.

 drivers/clk/imx/clk-imx8mm.c | 8 ++++++++
 drivers/clk/imx/clk-imx8mn.c | 8 ++++++++
 drivers/clk/imx/clk-imx8mp.c | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index e538f047b3..a91c6767fa 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -21,6 +21,8 @@ static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_se
 static const char * const sys_pll2_bypass_sels[] = {"sys_pll2", "sys_pll2_ref_sel", };
 static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
 
+static const char * const imx8mm_arm_core_sels[] = {"arm_a53_src", "arm_pll_out", };
+
 static const char * const imx8mm_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
@@ -417,6 +419,12 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
 #endif
 
+	clk_dm(IMX8MM_CLK_ARM,
+	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
+				  imx8mm_arm_core_sels,
+				  ARRAY_SIZE(imx8mm_arm_core_sels),
+				  CLK_IS_CRITICAL));
+
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 8911e342f1..125215e84f 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -23,6 +23,8 @@ static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_se
 static const char * const sys_pll2_bypass_sels[] = {"sys_pll2", "sys_pll2_ref_sel", };
 static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
 
+static const char * const imx8mn_arm_core_sels[] = {"arm_a53_src", "arm_pll_out", };
+
 static const char * const imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
@@ -403,6 +405,12 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
 #endif
 
+	clk_dm(IMX8MN_CLK_ARM,
+	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
+				  imx8mn_arm_core_sels,
+				  ARRAY_SIZE(imx8mn_arm_core_sels),
+				  CLK_IS_CRITICAL));
+
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 6b18483c81..34d91cd688 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -21,6 +21,8 @@ static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_se
 static const char * const sys_pll2_bypass_sels[] = {"sys_pll2", "sys_pll2_ref_sel", };
 static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
 
+static const char * const imx8mp_arm_core_sels[] = {"arm_a53_src", "arm_pll_out", };
+
 static const char * const imx8mp_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
@@ -354,6 +356,12 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 
+	clk_dm(IMX8MP_CLK_ARM,
+	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
+				  imx8mp_arm_core_sels,
+				  ARRAY_SIZE(imx8mp_arm_core_sels),
+				  CLK_IS_CRITICAL));
+
 	return 0;
 }
 
-- 
2.17.1

