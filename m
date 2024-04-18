Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D053C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF09A88682;
	Thu, 18 Apr 2024 19:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B4B88682; Thu, 18 Apr 2024 19:56:23 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AA688691
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rxVzc-00EXDl-Al;
 Thu, 18 Apr 2024 17:56:16 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 1/3] clk: imx8mm: Add support for PCIe clocks
Date: Thu, 18 Apr 2024 10:56:10 -0700
Message-Id: <20240418175612.4068609-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for PCIe clocks required to enable PCIe support on
iMX8MM SoC.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: no changes
---
 drivers/clk/imx/clk-imx8mm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b5c253e49663..c2f01b385201 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -66,6 +66,15 @@ static const char *imx8mm_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_
 static const char *imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
 					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
 
+static const char *imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m", "sys_pll1_266m",
+					       "sys_pll1_800m", "sys_pll2_500m", "sys_pll2_333m", "sys_pll3_out", };
+
+static const char *imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m", "clk_ext1", "clk_ext2",
+					      "clk_ext3", "clk_ext4", "sys_pll1_400m", };
+
+static const char *imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m", "sys_pll3_out",
+					      "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_160m", "sys_pll1_200m", };
+
 #ifndef CONFIG_SPL_BUILD
 static const char *imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
 					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
@@ -256,6 +265,15 @@ static int imx8mm_clk_probe(struct udevice *dev)
 		imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
 
 	/* IP */
+	clk_dm(IMX8MM_CLK_PCIE1_CTRL,
+	       imx8m_clk_composite("pcie1_ctrl", imx8mm_pcie1_ctrl_sels,
+				   base + 0xa300));
+	clk_dm(IMX8MM_CLK_PCIE1_PHY,
+	       imx8m_clk_composite("pcie1_phy", imx8mm_pcie1_phy_sels,
+				   base + 0xa380));
+	clk_dm(IMX8MM_CLK_PCIE1_AUX,
+	       imx8m_clk_composite("pcie1_aux", imx8mm_pcie1_aux_sels,
+				   base + 0xa400));
 	clk_dm(IMX8MM_CLK_USDHC1,
 	       imx8m_clk_composite("usdhc1", imx8mm_usdhc1_sels,
 				   base + 0xac00));
@@ -339,6 +357,9 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
 #endif
 
+	clk_dm(IMX8MM_CLK_PCIE1_ROOT,
+	       imx_clk_gate4("pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0));
+
 #if CONFIG_IS_ENABLED(DM_SPI)
 	clk_dm(IMX8MM_CLK_ECSPI1,
 	       imx8m_clk_composite("ecspi1", imx8mm_ecspi1_sels, base + 0xb280));
-- 
2.25.1

