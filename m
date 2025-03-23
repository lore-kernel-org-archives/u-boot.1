Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ABCC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365E882008;
	Sun, 23 Mar 2025 17:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745734;
	bh=OzH5wCRFJwJi8dUBDLT0luqCbowUzEU2qYWFOh/aI4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G4xlnwSKaquIIl11Jy3u4NyjcFhfySZXEdFbIhwvANFhpIq71VJ4tdfAcIBRGYXAB
	 X2Kuy0uM64z2cRS6iXK4oF2E+rSAzYx0C/ISA08sHm5q27Pjws7mxDDShBPmOy6j8Z
	 F3GqvZ9ZyEiZmy28bKW0wW/fibO6tZea/nwceW6/cKq4su+LXhq2aPIgFPDYMv72wZ
	 F+hSvnKtCCrUH5NFU/SgXGmd74EJM0EiPDFuWYN+v2x5+0UbDuFHdhxqmkCDndGE+3
	 lbK3c3oOpdF3OYnSTLrzk3Ii3qEK1eq+yhw5JjQqsBd8Ldg0kD6mQxcaGpH0w8ghRK
	 yoyFgGa0OF4ow==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E893782163; Sun, 23 Mar 2025 17:02:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22280820E3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WI6cZH5H"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D7B3710290241; Sun, 23 Mar 2025 17:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745727; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=OzH5wCRFJwJi8dUBDLT0luqCbowUzEU2qYWFOh/aI4M=;
 b=WI6cZH5HFbHsAhJA9ncJpaemm1t3CzrTq9KMqoR3N5ukO+DXqNJt/346H7EghHy6JQRkci
 90HwjVPOBBkoLqIV0s8rWDUJoQVzkRgoqIIIs9RefK5cUUBmkxeXQ/s/7U/udh3O1627xu
 JMWA71dUlatPWR5bWmbDix8cV724hWyPVgxTL49ZGFLMgoFRJkUrthMtKwMhzjZLrE3m2c
 mMCNAv1VTSV0xJC65HUNNafpGe1yRqKJ/JtcRtCog8rS9i68xRecFZQW6t+jnSSgLupViE
 qEOkae4RvmN2aWCDwxgdA9GaAENkfG3meYLQKF57hej+uDsWCN5PTxu8qxN0IQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 15/24] clk: imx: Pass struct udevice into
 imx_clk_composite*()
Date: Sun, 23 Mar 2025 16:58:44 +0100
Message-ID: <20250323160107.145749-16-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Pass struct udevice * into imx_clk_composite*() functions, so the
clock core would have access to parent struct udevice *.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk-composite-8m.c |  4 +-
 drivers/clk/imx/clk-imx8mm.c       | 74 +++++++++++++-------------
 drivers/clk/imx/clk-imx8mn.c       | 60 ++++++++++-----------
 drivers/clk/imx/clk-imx8mp.c       | 84 +++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c       | 52 +++++++++---------
 drivers/clk/imx/clk.h              | 14 ++---
 6 files changed, 143 insertions(+), 145 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 64bffa3b181..14c5b92939c 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -151,7 +151,7 @@ const struct clk_ops imx8m_clk_mux_ops = {
 	.set_parent = imx8m_clk_mux_set_parent,
 };
 
-struct clk *imx8m_clk_composite_flags(const char *name,
+struct clk *imx8m_clk_composite_flags(struct udevice *dev, const char *name,
 				      const char * const *parent_names,
 				      int num_parents, void __iomem *reg,
 				      unsigned long flags)
@@ -187,7 +187,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 	gate->reg = reg;
 	gate->bit_idx = PCG_CGC_SHIFT;
 
-	clk = clk_register_composite(NULL, name,
+	clk = clk_register_composite(dev, name,
 				     parent_names, num_parents,
 				     &mux->clk, &imx8m_clk_mux_ops, &div->clk,
 				     &imx8m_clk_composite_divider_ops,
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 30762666754..c9d6954ac75 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -300,71 +300,69 @@ static int imx8mm_clk_probe(struct udevice *dev)
 				base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MM_CLK_AHB,
-	       imx8m_clk_composite_critical("ahb", imx8mm_ahb_sels,
+	       imx8m_clk_composite_critical(dev, "ahb", imx8mm_ahb_sels,
 					    base + 0x9000));
 	clk_dm(IMX8MM_CLK_IPG_ROOT,
 	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MM_CLK_NAND_USDHC_BUS,
-	       imx8m_clk_composite_critical("nand_usdhc_bus",
+	       imx8m_clk_composite_critical(dev, "nand_usdhc_bus",
 					    imx8mm_nand_usdhc_sels,
 					    base + 0x8900));
 	clk_dm(IMX8MM_CLK_USB_BUS,
-		imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
+		imx8m_clk_composite(dev, "usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
 
 	/* IP */
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
 	clk_dm(IMX8MM_CLK_PCIE1_CTRL,
-	       imx8m_clk_composite("pcie1_ctrl", imx8mm_pcie1_ctrl_sels,
+	       imx8m_clk_composite(dev, "pcie1_ctrl", imx8mm_pcie1_ctrl_sels,
 				   base + 0xa300));
 	clk_dm(IMX8MM_CLK_PCIE1_PHY,
-	       imx8m_clk_composite("pcie1_phy", imx8mm_pcie1_phy_sels,
+	       imx8m_clk_composite(dev, "pcie1_phy", imx8mm_pcie1_phy_sels,
 				   base + 0xa380));
 	clk_dm(IMX8MM_CLK_PCIE1_AUX,
-	       imx8m_clk_composite("pcie1_aux", imx8mm_pcie1_aux_sels,
+	       imx8m_clk_composite(dev, "pcie1_aux", imx8mm_pcie1_aux_sels,
 				   base + 0xa400));
 #endif
 	clk_dm(IMX8MM_CLK_USDHC1,
-	       imx8m_clk_composite("usdhc1", imx8mm_usdhc1_sels,
+	       imx8m_clk_composite(dev, "usdhc1", imx8mm_usdhc1_sels,
 				   base + 0xac00));
 	clk_dm(IMX8MM_CLK_USDHC2,
-	       imx8m_clk_composite("usdhc2", imx8mm_usdhc2_sels,
+	       imx8m_clk_composite(dev, "usdhc2", imx8mm_usdhc2_sels,
 				   base + 0xac80));
 	clk_dm(IMX8MM_CLK_I2C1,
-	       imx8m_clk_composite("i2c1", imx8mm_i2c1_sels, base + 0xad00));
+	       imx8m_clk_composite(dev, "i2c1", imx8mm_i2c1_sels, base + 0xad00));
 	clk_dm(IMX8MM_CLK_I2C2,
-	       imx8m_clk_composite("i2c2", imx8mm_i2c2_sels, base + 0xad80));
+	       imx8m_clk_composite(dev, "i2c2", imx8mm_i2c2_sels, base + 0xad80));
 	clk_dm(IMX8MM_CLK_I2C3,
-	       imx8m_clk_composite("i2c3", imx8mm_i2c3_sels, base + 0xae00));
+	       imx8m_clk_composite(dev, "i2c3", imx8mm_i2c3_sels, base + 0xae00));
 	clk_dm(IMX8MM_CLK_I2C4,
-	       imx8m_clk_composite("i2c4", imx8mm_i2c4_sels, base + 0xae80));
-
+	       imx8m_clk_composite(dev, "i2c4", imx8mm_i2c4_sels, base + 0xae80));
 	clk_dm(IMX8MM_CLK_UART1,
-	       imx8m_clk_composite("uart1", imx8mm_uart1_sels, base + 0xaf00));
+	       imx8m_clk_composite(dev, "uart1", imx8mm_uart1_sels, base + 0xaf00));
 	clk_dm(IMX8MM_CLK_UART2,
-	       imx8m_clk_composite("uart2", imx8mm_uart2_sels, base + 0xaf80));
+	       imx8m_clk_composite(dev, "uart2", imx8mm_uart2_sels, base + 0xaf80));
 	clk_dm(IMX8MM_CLK_UART3,
-	       imx8m_clk_composite("uart3", imx8mm_uart3_sels, base + 0xb000));
+	       imx8m_clk_composite(dev, "uart3", imx8mm_uart3_sels, base + 0xb000));
 	clk_dm(IMX8MM_CLK_UART4,
-	       imx8m_clk_composite("uart4", imx8mm_uart4_sels, base + 0xb080));
+	       imx8m_clk_composite(dev, "uart4", imx8mm_uart4_sels, base + 0xb080));
 	clk_dm(IMX8MM_CLK_UART1_ROOT,
-	       imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
+	       imx_clk_gate4(dev, "uart1_root_clk", "uart1", base + 0x4490, 0));
 	clk_dm(IMX8MM_CLK_UART2_ROOT,
-	       imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
+	       imx_clk_gate4(dev, "uart2_root_clk", "uart2", base + 0x44a0, 0));
 	clk_dm(IMX8MM_CLK_UART3_ROOT,
-	       imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
+	       imx_clk_gate4(dev, "uart3_root_clk", "uart3", base + 0x44b0, 0));
 	clk_dm(IMX8MM_CLK_UART4_ROOT,
-	       imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
-
+	       imx_clk_gate4(dev, "uart4_root_clk", "uart4", base + 0x44c0, 0));
 	clk_dm(IMX8MM_CLK_WDOG,
-	       imx8m_clk_composite("wdog", imx8mm_wdog_sels, base + 0xb900));
+	       imx8m_clk_composite(dev, "wdog", imx8mm_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MM_CLK_USDHC3,
-	       imx8m_clk_composite("usdhc3", imx8mm_usdhc3_sels,
+	       imx8m_clk_composite(dev, "usdhc3", imx8mm_usdhc3_sels,
 				   base + 0xbc80));
 	clk_dm(IMX8MM_CLK_USB_CORE_REF,
-		imx8m_clk_composite("usb_core_ref", imx8mm_usb_core_sels, base + 0xb100));
+		imx8m_clk_composite(dev, "usb_core_ref", imx8mm_usb_core_sels, base + 0xb100));
 	clk_dm(IMX8MM_CLK_USB_PHY_REF,
-		imx8m_clk_composite("usb_phy_ref", imx8mm_usb_phy_sels, base + 0xb180));
+		imx8m_clk_composite(dev, "usb_phy_ref", imx8mm_usb_phy_sels, base + 0xb180));
 	clk_dm(IMX8MM_CLK_I2C1_ROOT,
 	       imx_clk_gate4(dev, "i2c1_root_clk", "i2c1", base + 0x4170, 0));
 	clk_dm(IMX8MM_CLK_I2C2_ROOT,
@@ -393,28 +391,28 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_XPL_BUILD
 	clk_dm(IMX8MM_CLK_ENET_AXI,
-	       imx8m_clk_composite("enet_axi", imx8mm_enet_axi_sels,
+	       imx8m_clk_composite(dev, "enet_axi", imx8mm_enet_axi_sels,
 				   base + 0x8880));
 	clk_dm(IMX8MM_CLK_ENET_REF,
-	       imx8m_clk_composite("enet_ref", imx8mm_enet_ref_sels,
+	       imx8m_clk_composite(dev, "enet_ref", imx8mm_enet_ref_sels,
 	       base + 0xa980));
 	clk_dm(IMX8MM_CLK_ENET_TIMER,
-	       imx8m_clk_composite("enet_timer", imx8mm_enet_timer_sels,
+	       imx8m_clk_composite(dev, "enet_timer", imx8mm_enet_timer_sels,
 	       base + 0xaa00));
 	clk_dm(IMX8MM_CLK_ENET_PHY_REF,
-	       imx8m_clk_composite("enet_phy", imx8mm_enet_phy_sels,
+	       imx8m_clk_composite(dev, "enet_phy", imx8mm_enet_phy_sels,
 	       base + 0xaa80));
 	clk_dm(IMX8MM_CLK_ENET1_ROOT,
 	       imx_clk_gate4(dev, "enet1_root_clk", "enet_axi",
 	       base + 0x40a0, 0));
 	clk_dm(IMX8MM_CLK_PWM1,
-	       imx8m_clk_composite("pwm1", imx8mm_pwm1_sels, base + 0xb380));
+	       imx8m_clk_composite(dev, "pwm1", imx8mm_pwm1_sels, base + 0xb380));
 	clk_dm(IMX8MM_CLK_PWM2,
-	       imx8m_clk_composite("pwm2", imx8mm_pwm2_sels, base + 0xb400));
+	       imx8m_clk_composite(dev, "pwm2", imx8mm_pwm2_sels, base + 0xb400));
 	clk_dm(IMX8MM_CLK_PWM3,
-	       imx8m_clk_composite("pwm3", imx8mm_pwm3_sels, base + 0xb480));
+	       imx8m_clk_composite(dev, "pwm3", imx8mm_pwm3_sels, base + 0xb480));
 	clk_dm(IMX8MM_CLK_PWM4,
-	       imx8m_clk_composite("pwm4", imx8mm_pwm4_sels, base + 0xb500));
+	       imx8m_clk_composite(dev, "pwm4", imx8mm_pwm4_sels, base + 0xb500));
 	clk_dm(IMX8MM_CLK_PWM1_ROOT,
 	       imx_clk_gate4(dev, "pwm1_root_clk", "pwm1", base + 0x4280, 0));
 	clk_dm(IMX8MM_CLK_PWM2_ROOT,
@@ -432,11 +430,11 @@ static int imx8mm_clk_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(DM_SPI)
 	clk_dm(IMX8MM_CLK_ECSPI1,
-	       imx8m_clk_composite("ecspi1", imx8mm_ecspi1_sels, base + 0xb280));
+	       imx8m_clk_composite(dev, "ecspi1", imx8mm_ecspi1_sels, base + 0xb280));
 	clk_dm(IMX8MM_CLK_ECSPI2,
-	       imx8m_clk_composite("ecspi2", imx8mm_ecspi2_sels, base + 0xb300));
+	       imx8m_clk_composite(dev, "ecspi2", imx8mm_ecspi2_sels, base + 0xb300));
 	clk_dm(IMX8MM_CLK_ECSPI3,
-	       imx8m_clk_composite("ecspi3", imx8mm_ecspi3_sels, base + 0xc180));
+	       imx8m_clk_composite(dev, "ecspi3", imx8mm_ecspi3_sels, base + 0xc180));
 
 	clk_dm(IMX8MM_CLK_ECSPI1_ROOT,
 	       imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
@@ -448,7 +446,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(NXP_FSPI)
 	clk_dm(IMX8MM_CLK_QSPI,
-	       imx8m_clk_composite("qspi", imx8mm_qspi_sels, base + 0xab80));
+	       imx8m_clk_composite(dev, "qspi", imx8mm_qspi_sels, base + 0xab80));
 	clk_dm(IMX8MM_CLK_QSPI_ROOT,
 	       imx_clk_gate4(dev, "qspi_root_clk", "qspi", base + 0x42f0, 0));
 #endif
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index a8ccc97f096..18621fc1226 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -297,57 +297,57 @@ static int imx8mn_clk_probe(struct udevice *dev)
 				base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MN_CLK_AHB,
-	       imx8m_clk_composite_critical("ahb", imx8mn_ahb_sels,
+	       imx8m_clk_composite_critical(dev, "ahb", imx8mn_ahb_sels,
 					    base + 0x9000));
 	clk_dm(IMX8MN_CLK_IPG_ROOT,
 	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MN_CLK_ENET_AXI,
-	       imx8m_clk_composite("enet_axi", imx8mn_enet_axi_sels,
+	       imx8m_clk_composite(dev, "enet_axi", imx8mn_enet_axi_sels,
 				   base + 0x8880));
 	clk_dm(IMX8MN_CLK_NAND_USDHC_BUS,
-	       imx8m_clk_composite_critical("nand_usdhc_bus",
+	       imx8m_clk_composite_critical(dev, "nand_usdhc_bus",
 					    imx8mn_nand_usdhc_sels,
 					    base + 0x8900));
 	clk_dm(IMX8MN_CLK_USB_BUS,
-		imx8m_clk_composite("usb_bus", imx8mn_usb_bus_sels, base + 0x8b80));
+		imx8m_clk_composite(dev, "usb_bus", imx8mn_usb_bus_sels, base + 0x8b80));
 
 	/* IP */
 	clk_dm(IMX8MN_CLK_USDHC1,
-	       imx8m_clk_composite("usdhc1", imx8mn_usdhc1_sels,
+	       imx8m_clk_composite(dev, "usdhc1", imx8mn_usdhc1_sels,
 				   base + 0xac00));
 	clk_dm(IMX8MN_CLK_USDHC2,
-	       imx8m_clk_composite("usdhc2", imx8mn_usdhc2_sels,
+	       imx8m_clk_composite(dev, "usdhc2", imx8mn_usdhc2_sels,
 				   base + 0xac80));
 	clk_dm(IMX8MN_CLK_I2C1,
-	       imx8m_clk_composite("i2c1", imx8mn_i2c1_sels, base + 0xad00));
+	       imx8m_clk_composite(dev, "i2c1", imx8mn_i2c1_sels, base + 0xad00));
 	clk_dm(IMX8MN_CLK_I2C2,
-	       imx8m_clk_composite("i2c2", imx8mn_i2c2_sels, base + 0xad80));
+	       imx8m_clk_composite(dev, "i2c2", imx8mn_i2c2_sels, base + 0xad80));
 	clk_dm(IMX8MN_CLK_I2C3,
-	       imx8m_clk_composite("i2c3", imx8mn_i2c3_sels, base + 0xae00));
+	       imx8m_clk_composite(dev, "i2c3", imx8mn_i2c3_sels, base + 0xae00));
 	clk_dm(IMX8MN_CLK_I2C4,
-	       imx8m_clk_composite("i2c4", imx8mn_i2c4_sels, base + 0xae80));
+	       imx8m_clk_composite(dev, "i2c4", imx8mn_i2c4_sels, base + 0xae80));
 	clk_dm(IMX8MN_CLK_UART1,
-	       imx8m_clk_composite("uart1", imx8mn_uart1_sels, base + 0xaf00));
+	       imx8m_clk_composite(dev, "uart1", imx8mn_uart1_sels, base + 0xaf00));
 	clk_dm(IMX8MN_CLK_UART2,
-	       imx8m_clk_composite("uart2", imx8mn_uart2_sels, base + 0xaf80));
+	       imx8m_clk_composite(dev, "uart2", imx8mn_uart2_sels, base + 0xaf80));
 	clk_dm(IMX8MN_CLK_UART3,
-	       imx8m_clk_composite("uart3", imx8mn_uart3_sels, base + 0xb000));
+	       imx8m_clk_composite(dev, "uart3", imx8mn_uart3_sels, base + 0xb000));
 	clk_dm(IMX8MN_CLK_UART4,
-	       imx8m_clk_composite("uart4", imx8mn_uart4_sels, base + 0xb080));
+	       imx8m_clk_composite(dev, "uart4", imx8mn_uart4_sels, base + 0xb080));
 	clk_dm(IMX8MN_CLK_WDOG,
-	       imx8m_clk_composite("wdog", imx8mn_wdog_sels, base + 0xb900));
+	       imx8m_clk_composite(dev, "wdog", imx8mn_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MN_CLK_USDHC3,
-	       imx8m_clk_composite("usdhc3", imx8mn_usdhc3_sels,
+	       imx8m_clk_composite(dev, "usdhc3", imx8mn_usdhc3_sels,
 				   base + 0xbc80));
 	clk_dm(IMX8MN_CLK_NAND,
-	       imx8m_clk_composite("nand", imx8mn_nand_sels, base + 0xab00));
+	       imx8m_clk_composite(dev, "nand", imx8mn_nand_sels, base + 0xab00));
 	clk_dm(IMX8MN_CLK_QSPI,
-	       imx8m_clk_composite("qspi", imx8mn_qspi_sels, base + 0xab80));
+	       imx8m_clk_composite(dev, "qspi", imx8mn_qspi_sels, base + 0xab80));
 	clk_dm(IMX8MN_CLK_USB_CORE_REF,
-		imx8m_clk_composite("usb_core_ref", imx8mn_usb_core_sels, base + 0xb100));
+		imx8m_clk_composite(dev, "usb_core_ref", imx8mn_usb_core_sels, base + 0xb100));
 	clk_dm(IMX8MN_CLK_USB_PHY_REF,
-		imx8m_clk_composite("usb_phy_ref", imx8mn_usb_phy_sels, base + 0xb180));
+		imx8m_clk_composite(dev, "usb_phy_ref", imx8mn_usb_phy_sels, base + 0xb180));
 
 	clk_dm(IMX8MN_CLK_I2C1_ROOT,
 	       imx_clk_gate4(dev, "i2c1_root_clk", "i2c1", base + 0x4170, 0));
@@ -393,25 +393,25 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_XPL_BUILD
 	clk_dm(IMX8MN_CLK_ENET_REF,
-	       imx8m_clk_composite("enet_ref", imx8mn_enet_ref_sels,
+	       imx8m_clk_composite(dev, "enet_ref", imx8mn_enet_ref_sels,
 	       base + 0xa980));
 	clk_dm(IMX8MN_CLK_ENET_TIMER,
-	       imx8m_clk_composite("enet_timer", imx8mn_enet_timer_sels,
+	       imx8m_clk_composite(dev, "enet_timer", imx8mn_enet_timer_sels,
 	       base + 0xaa00));
 	clk_dm(IMX8MN_CLK_ENET_PHY_REF,
-	       imx8m_clk_composite("enet_phy", imx8mn_enet_phy_sels,
+	       imx8m_clk_composite(dev, "enet_phy", imx8mn_enet_phy_sels,
 	       base + 0xaa80));
 	clk_dm(IMX8MN_CLK_ENET1_ROOT,
 	       imx_clk_gate4(dev, "enet1_root_clk", "enet_axi",
 	       base + 0x40a0, 0));
 	clk_dm(IMX8MN_CLK_PWM1,
-	       imx8m_clk_composite("pwm1", imx8mn_pwm1_sels, base + 0xb380));
+	       imx8m_clk_composite(dev, "pwm1", imx8mn_pwm1_sels, base + 0xb380));
 	clk_dm(IMX8MN_CLK_PWM2,
-	       imx8m_clk_composite("pwm2", imx8mn_pwm2_sels, base + 0xb400));
+	       imx8m_clk_composite(dev, "pwm2", imx8mn_pwm2_sels, base + 0xb400));
 	clk_dm(IMX8MN_CLK_PWM3,
-	       imx8m_clk_composite("pwm3", imx8mn_pwm3_sels, base + 0xb480));
+	       imx8m_clk_composite(dev, "pwm3", imx8mn_pwm3_sels, base + 0xb480));
 	clk_dm(IMX8MN_CLK_PWM4,
-	       imx8m_clk_composite("pwm4", imx8mn_pwm4_sels, base + 0xb500));
+	       imx8m_clk_composite(dev, "pwm4", imx8mn_pwm4_sels, base + 0xb500));
 	clk_dm(IMX8MN_CLK_PWM1_ROOT,
 	       imx_clk_gate4(dev, "pwm1_root_clk", "pwm1", base + 0x4280, 0));
 	clk_dm(IMX8MN_CLK_PWM2_ROOT,
@@ -424,11 +424,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(DM_SPI)
 	clk_dm(IMX8MN_CLK_ECSPI1,
-	       imx8m_clk_composite("ecspi1", imx8mn_ecspi1_sels, base + 0xb280));
+	       imx8m_clk_composite(dev, "ecspi1", imx8mn_ecspi1_sels, base + 0xb280));
 	clk_dm(IMX8MN_CLK_ECSPI2,
-	       imx8m_clk_composite("ecspi2", imx8mn_ecspi2_sels, base + 0xb300));
+	       imx8m_clk_composite(dev, "ecspi2", imx8mn_ecspi2_sels, base + 0xb300));
 	clk_dm(IMX8MN_CLK_ECSPI3,
-	       imx8m_clk_composite("ecspi3", imx8mn_ecspi3_sels, base + 0xc180));
+	       imx8m_clk_composite(dev, "ecspi3", imx8mn_ecspi3_sels, base + 0xc180));
 	clk_dm(IMX8MN_CLK_ECSPI1_ROOT,
 	       imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
 	clk_dm(IMX8MN_CLK_ECSPI2_ROOT,
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 718ba095bef..5768504e7c9 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -266,52 +266,52 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_A53_CG, imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3));
 
-	clk_dm(IMX8MP_CLK_HSIO_AXI, imx8m_clk_composite("hsio_axi", imx8mp_hsio_axi_sels, base + 0x8380));
-	clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical("main_axi", imx8mp_main_axi_sels, base + 0x8800));
-	clk_dm(IMX8MP_CLK_ENET_AXI, imx8m_clk_composite_critical("enet_axi", imx8mp_enet_axi_sels, base + 0x8880));
-	clk_dm(IMX8MP_CLK_NAND_USDHC_BUS, imx8m_clk_composite_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900));
-	clk_dm(IMX8MP_CLK_NOC, imx8m_clk_composite_critical("noc", imx8mp_noc_sels, base + 0x8d00));
-	clk_dm(IMX8MP_CLK_NOC_IO, imx8m_clk_composite_critical("noc_io", imx8mp_noc_io_sels, base + 0x8d80));
+	clk_dm(IMX8MP_CLK_HSIO_AXI, imx8m_clk_composite(dev, "hsio_axi", imx8mp_hsio_axi_sels, base + 0x8380));
+	clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical(dev, "main_axi", imx8mp_main_axi_sels, base + 0x8800));
+	clk_dm(IMX8MP_CLK_ENET_AXI, imx8m_clk_composite_critical(dev, "enet_axi", imx8mp_enet_axi_sels, base + 0x8880));
+	clk_dm(IMX8MP_CLK_NAND_USDHC_BUS, imx8m_clk_composite_critical(dev, "nand_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900));
+	clk_dm(IMX8MP_CLK_NOC, imx8m_clk_composite_critical(dev, "noc", imx8mp_noc_sels, base + 0x8d00));
+	clk_dm(IMX8MP_CLK_NOC_IO, imx8m_clk_composite_critical(dev, "noc_io", imx8mp_noc_io_sels, base + 0x8d80));
 
-	clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical("ahb_root", imx8mp_ahb_sels, base + 0x9000));
+	clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical(dev, "ahb_root", imx8mp_ahb_sels, base + 0x9000));
 
 	clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2("ipg_root", "ahb_root", base + 0x9080, 0, 1));
 
-	clk_dm(IMX8MP_CLK_DRAM_ALT, imx8m_clk_composite("dram_alt", imx8mp_dram_alt_sels, base + 0xa000));
-	clk_dm(IMX8MP_CLK_DRAM_APB, imx8m_clk_composite_critical("dram_apb", imx8mp_dram_apb_sels, base + 0xa080));
-	clk_dm(IMX8MP_CLK_PCIE_AUX, imx8m_clk_composite("pcie_aux", imx8mp_pcie_aux_sels, base + 0xa400));
-	clk_dm(IMX8MP_CLK_I2C5, imx8m_clk_composite("i2c5", imx8mp_i2c5_sels, base + 0xa480));
-	clk_dm(IMX8MP_CLK_I2C6, imx8m_clk_composite("i2c6", imx8mp_i2c6_sels, base + 0xa500));
-	clk_dm(IMX8MP_CLK_ENET_QOS, imx8m_clk_composite("enet_qos", imx8mp_enet_qos_sels, base + 0xa880));
-	clk_dm(IMX8MP_CLK_ENET_QOS_TIMER, imx8m_clk_composite("enet_qos_timer", imx8mp_enet_qos_timer_sels, base + 0xa900));
-	clk_dm(IMX8MP_CLK_ENET_REF, imx8m_clk_composite("enet_ref", imx8mp_enet_ref_sels, base + 0xa980));
-	clk_dm(IMX8MP_CLK_ENET_TIMER, imx8m_clk_composite("enet_timer", imx8mp_enet_timer_sels, base + 0xaa00));
-	clk_dm(IMX8MP_CLK_ENET_PHY_REF, imx8m_clk_composite("enet_phy_ref", imx8mp_enet_phy_ref_sels, base + 0xaa80));
-	clk_dm(IMX8MP_CLK_QSPI, imx8m_clk_composite("qspi", imx8mp_qspi_sels, base + 0xab80));
-	clk_dm(IMX8MP_CLK_USDHC1, imx8m_clk_composite("usdhc1", imx8mp_usdhc1_sels, base + 0xac00));
-	clk_dm(IMX8MP_CLK_USDHC2, imx8m_clk_composite("usdhc2", imx8mp_usdhc2_sels, base + 0xac80));
-	clk_dm(IMX8MP_CLK_I2C1, imx8m_clk_composite("i2c1", imx8mp_i2c1_sels, base + 0xad00));
-	clk_dm(IMX8MP_CLK_I2C2, imx8m_clk_composite("i2c2", imx8mp_i2c2_sels, base + 0xad80));
-	clk_dm(IMX8MP_CLK_I2C3, imx8m_clk_composite("i2c3", imx8mp_i2c3_sels, base + 0xae00));
-	clk_dm(IMX8MP_CLK_I2C4, imx8m_clk_composite("i2c4", imx8mp_i2c4_sels, base + 0xae80));
-
-	clk_dm(IMX8MP_CLK_UART1, imx8m_clk_composite("uart1", imx8mp_uart1_sels, base + 0xaf00));
-	clk_dm(IMX8MP_CLK_UART2, imx8m_clk_composite("uart2", imx8mp_uart2_sels, base + 0xaf80));
-	clk_dm(IMX8MP_CLK_UART3, imx8m_clk_composite("uart3", imx8mp_uart3_sels, base + 0xb000));
-	clk_dm(IMX8MP_CLK_UART4, imx8m_clk_composite("uart4", imx8mp_uart4_sels, base + 0xb080));
-	clk_dm(IMX8MP_CLK_USB_CORE_REF, imx8m_clk_composite("usb_core_ref", imx8mp_usb_core_ref_sels, base + 0xb100));
-	clk_dm(IMX8MP_CLK_USB_PHY_REF, imx8m_clk_composite("usb_phy_ref", imx8mp_usb_phy_ref_sels, base + 0xb180));
-	clk_dm(IMX8MP_CLK_GIC, imx8m_clk_composite_critical("gic", imx8mp_gic_sels, base + 0xb200));
-	clk_dm(IMX8MP_CLK_ECSPI1, imx8m_clk_composite("ecspi1", imx8mp_ecspi1_sels, base + 0xb280));
-	clk_dm(IMX8MP_CLK_ECSPI2, imx8m_clk_composite("ecspi2", imx8mp_ecspi2_sels, base + 0xb300));
-	clk_dm(IMX8MP_CLK_PWM1, imx8m_clk_composite_critical("pwm1", imx8mp_pwm1_sels, base + 0xb380));
-	clk_dm(IMX8MP_CLK_PWM2, imx8m_clk_composite_critical("pwm2", imx8mp_pwm2_sels, base + 0xb400));
-	clk_dm(IMX8MP_CLK_PWM3, imx8m_clk_composite_critical("pwm3", imx8mp_pwm3_sels, base + 0xb480));
-	clk_dm(IMX8MP_CLK_PWM4, imx8m_clk_composite_critical("pwm4", imx8mp_pwm4_sels, base + 0xb500));
-	clk_dm(IMX8MP_CLK_ECSPI3, imx8m_clk_composite("ecspi3", imx8mp_ecspi3_sels, base + 0xc180));
-
-	clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite("wdog", imx8mp_wdog_sels, base + 0xb900));
-	clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite("usdhc3", imx8mp_usdhc3_sels, base + 0xbc80));
+	clk_dm(IMX8MP_CLK_DRAM_ALT, imx8m_clk_composite(dev, "dram_alt", imx8mp_dram_alt_sels, base + 0xa000));
+	clk_dm(IMX8MP_CLK_DRAM_APB, imx8m_clk_composite_critical(dev, "dram_apb", imx8mp_dram_apb_sels, base + 0xa080));
+	clk_dm(IMX8MP_CLK_PCIE_AUX, imx8m_clk_composite(dev, "pcie_aux", imx8mp_pcie_aux_sels, base + 0xa400));
+	clk_dm(IMX8MP_CLK_I2C5, imx8m_clk_composite(dev, "i2c5", imx8mp_i2c5_sels, base + 0xa480));
+	clk_dm(IMX8MP_CLK_I2C6, imx8m_clk_composite(dev, "i2c6", imx8mp_i2c6_sels, base + 0xa500));
+	clk_dm(IMX8MP_CLK_ENET_QOS, imx8m_clk_composite(dev, "enet_qos", imx8mp_enet_qos_sels, base + 0xa880));
+	clk_dm(IMX8MP_CLK_ENET_QOS_TIMER, imx8m_clk_composite(dev, "enet_qos_timer", imx8mp_enet_qos_timer_sels, base + 0xa900));
+	clk_dm(IMX8MP_CLK_ENET_REF, imx8m_clk_composite(dev, "enet_ref", imx8mp_enet_ref_sels, base + 0xa980));
+	clk_dm(IMX8MP_CLK_ENET_TIMER, imx8m_clk_composite(dev, "enet_timer", imx8mp_enet_timer_sels, base + 0xaa00));
+	clk_dm(IMX8MP_CLK_ENET_PHY_REF, imx8m_clk_composite(dev, "enet_phy_ref", imx8mp_enet_phy_ref_sels, base + 0xaa80));
+	clk_dm(IMX8MP_CLK_QSPI, imx8m_clk_composite(dev, "qspi", imx8mp_qspi_sels, base + 0xab80));
+	clk_dm(IMX8MP_CLK_USDHC1, imx8m_clk_composite(dev, "usdhc1", imx8mp_usdhc1_sels, base + 0xac00));
+	clk_dm(IMX8MP_CLK_USDHC2, imx8m_clk_composite(dev, "usdhc2", imx8mp_usdhc2_sels, base + 0xac80));
+	clk_dm(IMX8MP_CLK_I2C1, imx8m_clk_composite(dev, "i2c1", imx8mp_i2c1_sels, base + 0xad00));
+	clk_dm(IMX8MP_CLK_I2C2, imx8m_clk_composite(dev, "i2c2", imx8mp_i2c2_sels, base + 0xad80));
+	clk_dm(IMX8MP_CLK_I2C3, imx8m_clk_composite(dev, "i2c3", imx8mp_i2c3_sels, base + 0xae00));
+	clk_dm(IMX8MP_CLK_I2C4, imx8m_clk_composite(dev, "i2c4", imx8mp_i2c4_sels, base + 0xae80));
+
+	clk_dm(IMX8MP_CLK_UART1, imx8m_clk_composite(dev, "uart1", imx8mp_uart1_sels, base + 0xaf00));
+	clk_dm(IMX8MP_CLK_UART2, imx8m_clk_composite(dev, "uart2", imx8mp_uart2_sels, base + 0xaf80));
+	clk_dm(IMX8MP_CLK_UART3, imx8m_clk_composite(dev, "uart3", imx8mp_uart3_sels, base + 0xb000));
+	clk_dm(IMX8MP_CLK_UART4, imx8m_clk_composite(dev, "uart4", imx8mp_uart4_sels, base + 0xb080));
+	clk_dm(IMX8MP_CLK_USB_CORE_REF, imx8m_clk_composite(dev, "usb_core_ref", imx8mp_usb_core_ref_sels, base + 0xb100));
+	clk_dm(IMX8MP_CLK_USB_PHY_REF, imx8m_clk_composite(dev, "usb_phy_ref", imx8mp_usb_phy_ref_sels, base + 0xb180));
+	clk_dm(IMX8MP_CLK_GIC, imx8m_clk_composite_critical(dev, "gic", imx8mp_gic_sels, base + 0xb200));
+	clk_dm(IMX8MP_CLK_ECSPI1, imx8m_clk_composite(dev, "ecspi1", imx8mp_ecspi1_sels, base + 0xb280));
+	clk_dm(IMX8MP_CLK_ECSPI2, imx8m_clk_composite(dev, "ecspi2", imx8mp_ecspi2_sels, base + 0xb300));
+	clk_dm(IMX8MP_CLK_PWM1, imx8m_clk_composite_critical(dev, "pwm1", imx8mp_pwm1_sels, base + 0xb380));
+	clk_dm(IMX8MP_CLK_PWM2, imx8m_clk_composite_critical(dev, "pwm2", imx8mp_pwm2_sels, base + 0xb400));
+	clk_dm(IMX8MP_CLK_PWM3, imx8m_clk_composite_critical(dev, "pwm3", imx8mp_pwm3_sels, base + 0xb480));
+	clk_dm(IMX8MP_CLK_PWM4, imx8m_clk_composite_critical(dev, "pwm4", imx8mp_pwm4_sels, base + 0xb500));
+	clk_dm(IMX8MP_CLK_ECSPI3, imx8m_clk_composite(dev, "ecspi3", imx8mp_ecspi3_sels, base + 0xc180));
+
+	clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite(dev, "wdog", imx8mp_wdog_sels, base + 0xb900));
+	clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite(dev, "usdhc3", imx8mp_usdhc3_sels, base + 0xbc80));
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
 	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags(dev, "dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 782dd39a300..5faa2d20224 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -361,67 +361,67 @@ static int imx8mq_clk_probe(struct udevice *dev)
 			    imx8mq_a53_core_sels, ARRAY_SIZE(imx8mq_a53_core_sels)));
 
 	clk_dm(IMX8MQ_CLK_AHB,
-	       imx8m_clk_composite_critical("ahb", imx8mq_ahb_sels,
+	       imx8m_clk_composite_critical(dev, "ahb", imx8mq_ahb_sels,
 					    base + 0x9000));
 	clk_dm(IMX8MQ_CLK_IPG_ROOT,
 	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MQ_CLK_ENET_AXI,
-	       imx8m_clk_composite("enet_axi", imx8mq_enet_axi_sels,
+	       imx8m_clk_composite(dev, "enet_axi", imx8mq_enet_axi_sels,
 				   base + 0x8880));
 	clk_dm(IMX8MQ_CLK_NAND_USDHC_BUS,
-	       imx8m_clk_composite_critical("nand_usdhc_bus",
+	       imx8m_clk_composite_critical(dev, "nand_usdhc_bus",
 					    imx8mq_nand_usdhc_sels,
 					    base + 0x8900));
 	clk_dm(IMX8MQ_CLK_USB_BUS,
-	       imx8m_clk_composite("usb_bus", imx8mq_usb_bus_sels, base + 0x8b80));
+	       imx8m_clk_composite(dev, "usb_bus", imx8mq_usb_bus_sels, base + 0x8b80));
 
 	/* DRAM */
 	clk_dm(IMX8MQ_CLK_DRAM_CORE,
 	       imx_clk_mux2(dev, "dram_core_clk", base + 0x9800, 24, 1,
 			    imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels)));
 	clk_dm(IMX8MQ_CLK_DRAM_ALT,
-	       imx8m_clk_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000));
+	       imx8m_clk_composite(dev, "dram_alt", imx8mq_dram_alt_sels, base + 0xa000));
 	clk_dm(IMX8MQ_CLK_DRAM_APB,
-	       imx8m_clk_composite_critical("dram_apb", imx8mq_dram_apb_sels, base + 0xa080));
+	       imx8m_clk_composite_critical(dev, "dram_apb", imx8mq_dram_apb_sels, base + 0xa080));
 
 	/* IP */
 	clk_dm(IMX8MQ_CLK_USDHC1,
-	       imx8m_clk_composite("usdhc1", imx8mq_usdhc1_sels,
+	       imx8m_clk_composite(dev, "usdhc1", imx8mq_usdhc1_sels,
 				   base + 0xac00));
 	clk_dm(IMX8MQ_CLK_USDHC2,
-	       imx8m_clk_composite("usdhc2", imx8mq_usdhc2_sels,
+	       imx8m_clk_composite(dev, "usdhc2", imx8mq_usdhc2_sels,
 				   base + 0xac80));
 	clk_dm(IMX8MQ_CLK_I2C1,
-	       imx8m_clk_composite("i2c1", imx8mq_i2c1_sels, base + 0xad00));
+	       imx8m_clk_composite(dev, "i2c1", imx8mq_i2c1_sels, base + 0xad00));
 	clk_dm(IMX8MQ_CLK_I2C2,
-	       imx8m_clk_composite("i2c2", imx8mq_i2c2_sels, base + 0xad80));
+	       imx8m_clk_composite(dev, "i2c2", imx8mq_i2c2_sels, base + 0xad80));
 	clk_dm(IMX8MQ_CLK_I2C3,
-	       imx8m_clk_composite("i2c3", imx8mq_i2c3_sels, base + 0xae00));
+	       imx8m_clk_composite(dev, "i2c3", imx8mq_i2c3_sels, base + 0xae00));
 	clk_dm(IMX8MQ_CLK_I2C4,
-	       imx8m_clk_composite("i2c4", imx8mq_i2c4_sels, base + 0xae80));
+	       imx8m_clk_composite(dev, "i2c4", imx8mq_i2c4_sels, base + 0xae80));
 	clk_dm(IMX8MQ_CLK_WDOG,
-	       imx8m_clk_composite("wdog", imx8mq_wdog_sels, base + 0xb900));
+	       imx8m_clk_composite(dev, "wdog", imx8mq_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MQ_CLK_UART1,
-	       imx8m_clk_composite("uart1", imx8mq_uart1_sels, base + 0xaf00));
+	       imx8m_clk_composite(dev, "uart1", imx8mq_uart1_sels, base + 0xaf00));
 	clk_dm(IMX8MQ_CLK_UART2,
-	       imx8m_clk_composite("uart2", imx8mq_uart2_sels, base + 0xaf80));
+	       imx8m_clk_composite(dev, "uart2", imx8mq_uart2_sels, base + 0xaf80));
 	clk_dm(IMX8MQ_CLK_UART3,
-	       imx8m_clk_composite("uart3", imx8mq_uart3_sels, base + 0xb000));
+	       imx8m_clk_composite(dev, "uart3", imx8mq_uart3_sels, base + 0xb000));
 	clk_dm(IMX8MQ_CLK_UART4,
-	       imx8m_clk_composite("uart4", imx8mq_uart4_sels, base + 0xb080));
+	       imx8m_clk_composite(dev, "uart4", imx8mq_uart4_sels, base + 0xb080));
 	clk_dm(IMX8MQ_CLK_QSPI,
-	       imx8m_clk_composite("qspi", imx8mq_qspi_sels, base + 0xab80));
+	       imx8m_clk_composite(dev, "qspi", imx8mq_qspi_sels, base + 0xab80));
 	clk_dm(IMX8MQ_CLK_USB_CORE_REF,
-	       imx8m_clk_composite("usb_core_ref", imx8mq_usb_core_sels, base + 0xb100));
+	       imx8m_clk_composite(dev, "usb_core_ref", imx8mq_usb_core_sels, base + 0xb100));
 	clk_dm(IMX8MQ_CLK_USB_PHY_REF,
-	       imx8m_clk_composite("usb_phy_ref", imx8mq_usb_phy_sels, base + 0xb180));
+	       imx8m_clk_composite(dev, "usb_phy_ref", imx8mq_usb_phy_sels, base + 0xb180));
 	clk_dm(IMX8MQ_CLK_ECSPI1,
-	       imx8m_clk_composite("ecspi1", imx8mq_ecspi1_sels, base + 0xb280));
+	       imx8m_clk_composite(dev, "ecspi1", imx8mq_ecspi1_sels, base + 0xb280));
 	clk_dm(IMX8MQ_CLK_ECSPI2,
-	       imx8m_clk_composite("ecspi2", imx8mq_ecspi2_sels, base + 0xb300));
+	       imx8m_clk_composite(dev, "ecspi2", imx8mq_ecspi2_sels, base + 0xb300));
 	clk_dm(IMX8MQ_CLK_ECSPI3,
-	       imx8m_clk_composite("ecspi3", imx8mq_ecspi3_sels, base + 0xc180));
+	       imx8m_clk_composite(dev, "ecspi3", imx8mq_ecspi3_sels, base + 0xc180));
 
 	clk_dm(IMX8MQ_CLK_ECSPI1_ROOT,
 	       imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
@@ -469,13 +469,13 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx_clk_gate4(dev, "usb2_phy_root_clk", "usb_phy_ref", base + 0x4500, 0));
 
 	clk_dm(IMX8MQ_CLK_ENET_REF,
-	       imx8m_clk_composite("enet_ref", imx8mq_enet_ref_sels,
+	       imx8m_clk_composite(dev, "enet_ref", imx8mq_enet_ref_sels,
 				   base + 0xa980));
 	clk_dm(IMX8MQ_CLK_ENET_TIMER,
-	       imx8m_clk_composite("enet_timer", imx8mq_enet_timer_sels,
+	       imx8m_clk_composite(dev, "enet_timer", imx8mq_enet_timer_sels,
 				   base + 0xaa00));
 	clk_dm(IMX8MQ_CLK_ENET_PHY_REF,
-	       imx8m_clk_composite("enet_phy", imx8mq_enet_phy_sels,
+	       imx8m_clk_composite(dev, "enet_phy", imx8mq_enet_phy_sels,
 				   base + 0xaa80));
 	clk_dm(IMX8MQ_CLK_ENET1_ROOT,
 	       imx_clk_gate4(dev, "enet1_root_clk", "enet_axi",
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 22b5d823ff9..1a814d9a386 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -241,20 +241,20 @@ static inline struct clk *imx_clk_gate3(struct udevice *dev, const char *name,
 			reg, shift, 0, NULL);
 }
 
-struct clk *imx8m_clk_composite_flags(const char *name,
+struct clk *imx8m_clk_composite_flags(struct udevice *dev, const char *name,
 		const char * const *parent_names,
 		int num_parents, void __iomem *reg, unsigned long flags);
 
-#define __imx8m_clk_composite(name, parent_names, reg, flags) \
-	imx8m_clk_composite_flags(name, parent_names, \
+#define __imx8m_clk_composite(dev, name, parent_names, reg, flags) \
+	imx8m_clk_composite_flags(dev, name, parent_names, \
 		ARRAY_SIZE(parent_names), reg, \
 		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
-#define imx8m_clk_composite(name, parent_names, reg) \
-	__imx8m_clk_composite(name, parent_names, reg, 0)
+#define imx8m_clk_composite(dev, name, parent_names, reg) \
+	__imx8m_clk_composite(dev, name, parent_names, reg, 0)
 
-#define imx8m_clk_composite_critical(name, parent_names, reg) \
-	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+#define imx8m_clk_composite_critical(dev, name, parent_names, reg) \
+	__imx8m_clk_composite(dev, name, parent_names, reg, CLK_IS_CRITICAL)
 
 struct clk *imx93_clk_composite_flags(const char *name,
 				      const char * const *parent_names,
-- 
2.47.2

