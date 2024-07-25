Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C4C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 08:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8767E887CA;
	Thu, 25 Jul 2024 10:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF089889EF; Thu, 25 Jul 2024 10:16:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3114887CA
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 10:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68FD520236A;
 Thu, 25 Jul 2024 10:16:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04AFA200538;
 Thu, 25 Jul 2024 10:16:10 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 6AD9C180222B; Thu, 25 Jul 2024 16:16:08 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] clk: imx8m: register ARM A55 core clock
Date: Thu, 25 Jul 2024 16:36:55 +0800
Message-Id: <20240725083655.24486-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
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

Register ARM A55 core clock for i.MX 8M Mini, Nano and Plus.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 6 ++++++
 drivers/clk/imx/clk-imx8mn.c | 7 +++++++
 drivers/clk/imx/clk-imx8mp.c | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index e538f047b3..8d98fbaaa9 100644
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
@@ -417,6 +419,10 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
 #endif
 
+	clk_dm(IMX8MM_CLK_ARM,
+	       imx_clk_mux2("arm_core", base + 0x9880, 24, 1,
+			    imx8mm_arm_core_sels,
+			    ARRAY_SIZE(imx8mm_arm_core_sels)));
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 8911e342f1..3de03e1f3b 100644
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
@@ -403,6 +405,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
 #endif
 
+	clk_dm(IMX8MN_CLK_ARM,
+	       imx_clk_mux2("arm_core", base + 0x9880, 24, 1,
+			    imx8mn_arm_core_sels,
+			    ARRAY_SIZE(imx8mn_arm_core_sels)));
+
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 6b18483c81..32ea60f11e 100644
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
@@ -354,6 +356,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 
+	clk_dm(IMX8MP_CLK_ARM,
+	       imx_clk_mux2("arm_core", base + 0x9880, 24, 1,
+			    imx8mp_arm_core_sels,
+			    ARRAY_SIZE(imx8mp_arm_core_sels)));
+
 	return 0;
 }
 
-- 
2.17.1

