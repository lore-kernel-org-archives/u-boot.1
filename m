Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846B1C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1EC82107;
	Sun, 23 Mar 2025 17:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745729;
	bh=QLMEPq9lneiS7b1tdLfmC2vep6EzhgLjRRkZFqY7gUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v212DmaZtCA3fDk15+f+aQphgYAZX+Pu2GXCJkHcw2zLXKwCHq6J/5qHokvbZJaWU
	 q37iiD4kzGHXQyJzqEWyqm6wLETBtvH/9YMK7trvEUKyqETRNdTJz4evoA2IEROUdP
	 57+a6HgBhuZjAUoN4iYETk3vCZiysLn58AlUrdusjv47McQ5d/o5yoPYiNg3cINUAq
	 121w/ltE9yLQpSzkYbh4wZJhQpwwb+mo2NcenGWoU4E06ZqoSAvDx9DiFSv6u+xhij
	 oELXVMxLvubYJpYabN3XbBQVTlszMqto0Z5gNnyLVHxVT0Yf2YsnKi9gAqvh83Xedj
	 jVx7h0V6mzsNA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BB98210E; Sun, 23 Mar 2025 17:02:06 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FB481CFD
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cG+nj7Ky"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1EE09102A4AFB; Sun, 23 Mar 2025 17:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745723; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=QLMEPq9lneiS7b1tdLfmC2vep6EzhgLjRRkZFqY7gUY=;
 b=cG+nj7KyeVDlPnwbgQ283AXX024YQWqr7QR/fEQgdGs/m+ubBJoJOZSzeqQZRZcLxlmncB
 UYARpyjdSxW5nlv4ID8XxVsWXSzYmK4gwGEzZj//h5/QiMI+AF7aUL3HYH/e4YhQfsmepq
 aesRR3ts4d3jrhWVFICNH9eGt+QLcZw+A0zAuaJhcisk87sdcuRGGjUYTyN6fAm5ELjuyA
 3sNa16nuErjxc7fdOdffPXTbbFzpHipD7dLfJ7kyVWgTUW+n6FNkmvN6H1enWL23yVuFax
 V0Lt7HQ84GSq0AsJoh8XrWfca+JLUEz6zLuqTh9ngOhLC007CxXRTN1tGsboiA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 11/24] clk: imx: Pass struct udevice into imx_clk_gate*()
Date: Sun, 23 Mar 2025 16:58:40 +0100
Message-ID: <20250323160107.145749-12-marex@denx.de>
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

Pass struct udevice * into imx_clk_gate*() functions, so the
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
 drivers/clk/imx/clk-imx6q.c     | 32 +++++------
 drivers/clk/imx/clk-imx8mm.c    | 56 ++++++++++----------
 drivers/clk/imx/clk-imx8mn.c    | 66 +++++++++++------------
 drivers/clk/imx/clk-imx8mp.c    | 94 ++++++++++++++++-----------------
 drivers/clk/imx/clk-imx8mq.c    | 72 ++++++++++++-------------
 drivers/clk/imx/clk-imxrt1020.c |  8 +--
 drivers/clk/imx/clk-imxrt1050.c | 14 ++---
 drivers/clk/imx/clk.h           | 28 +++++-----
 8 files changed, 187 insertions(+), 183 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 92b79a3a02c..d9eb43d82be 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -60,7 +60,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PLL6,
 	       imx_clk_pllv3(IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
-	       imx_clk_gate("pll6_enet", "pll6", base + 0xe0, 13));
+	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
 	/* CCM clocks */
 	base = dev_read_addr_ptr(dev);
@@ -115,25 +115,25 @@ static int imx6q_clk_probe(struct udevice *dev)
 	}
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
-	       imx_clk_gate2("ecspi1", "ecspi_root", base + 0x6c, 0));
+	       imx_clk_gate2(dev, "ecspi1", "ecspi_root", base + 0x6c, 0));
 	clk_dm(IMX6QDL_CLK_ECSPI2,
-	       imx_clk_gate2("ecspi2", "ecspi_root", base + 0x6c, 2));
+	       imx_clk_gate2(dev, "ecspi2", "ecspi_root", base + 0x6c, 2));
 	clk_dm(IMX6QDL_CLK_ECSPI3,
-	       imx_clk_gate2("ecspi3", "ecspi_root", base + 0x6c, 4));
+	       imx_clk_gate2(dev, "ecspi3", "ecspi_root", base + 0x6c, 4));
 	clk_dm(IMX6QDL_CLK_ECSPI4,
-	       imx_clk_gate2("ecspi4", "ecspi_root", base + 0x6c, 6));
+	       imx_clk_gate2(dev, "ecspi4", "ecspi_root", base + 0x6c, 6));
 	clk_dm(IMX6QDL_CLK_UART_IPG,
-	       imx_clk_gate2("uart_ipg", "ipg", base + 0x7c, 24));
+	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
 	clk_dm(IMX6QDL_CLK_UART_SERIAL,
-	       imx_clk_gate2("uart_serial", "uart_serial_podf",  base + 0x7c, 26));
+	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",  base + 0x7c, 26));
 	clk_dm(IMX6QDL_CLK_USDHC1,
-	       imx_clk_gate2("usdhc1", "usdhc1_podf", base + 0x80, 2));
+	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMX6QDL_CLK_USDHC2,
-	       imx_clk_gate2("usdhc2", "usdhc2_podf", base + 0x80, 4));
+	       imx_clk_gate2(dev, "usdhc2", "usdhc2_podf", base + 0x80, 4));
 	clk_dm(IMX6QDL_CLK_USDHC3,
-	       imx_clk_gate2("usdhc3", "usdhc3_podf", base + 0x80, 6));
+	       imx_clk_gate2(dev, "usdhc3", "usdhc3_podf", base + 0x80, 6));
 	clk_dm(IMX6QDL_CLK_USDHC4,
-	       imx_clk_gate2("usdhc4", "usdhc4_podf", base + 0x80, 8));
+	       imx_clk_gate2(dev, "usdhc4", "usdhc4_podf", base + 0x80, 8));
 
 	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
 	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2, periph_pre_sels,
@@ -149,15 +149,15 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_IPG_PER,
 	       imx_clk_divider("ipg_per", "ipg", base + 0x1c, 0, 6));
 	clk_dm(IMX6QDL_CLK_I2C1,
-	       imx_clk_gate2("i2c1", "ipg_per", base + 0x70, 6));
+	       imx_clk_gate2(dev, "i2c1", "ipg_per", base + 0x70, 6));
 	clk_dm(IMX6QDL_CLK_I2C2,
-	       imx_clk_gate2("i2c2", "ipg_per", base + 0x70, 8));
+	       imx_clk_gate2(dev, "i2c2", "ipg_per", base + 0x70, 8));
 	clk_dm(IMX6QDL_CLK_I2C3,
-	       imx_clk_gate2("i2c3", "ipg_per", base + 0x70, 10));
+	       imx_clk_gate2(dev, "i2c3", "ipg_per", base + 0x70, 10));
 	clk_dm(IMX6QDL_CLK_PWM1,
-	       imx_clk_gate2("pwm1", "ipg_per", base + 0x78, 16));
+	       imx_clk_gate2(dev, "pwm1", "ipg_per", base + 0x78, 16));
 
-	clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2("enet", "ipg", base + 0x6c, 10));
+	clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor("enet_ref", "pll6_enet", 1, 1));
 
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 54eaff273d0..30762666754 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -232,19 +232,19 @@ static int imx8mm_clk_probe(struct udevice *dev)
 
 	/* PLL out gate */
 	clk_dm(IMX8MM_DRAM_PLL_OUT,
-	       imx_clk_gate("dram_pll_out", "dram_pll_bypass",
+	       imx_clk_gate(dev, "dram_pll_out", "dram_pll_bypass",
 			    base + 0x50, 13));
 	clk_dm(IMX8MM_ARM_PLL_OUT,
-	       imx_clk_gate("arm_pll_out", "arm_pll_bypass",
+	       imx_clk_gate(dev, "arm_pll_out", "arm_pll_bypass",
 			    base + 0x84, 11));
 	clk_dm(IMX8MM_SYS_PLL1_OUT,
-	       imx_clk_gate("sys_pll1_out", "sys_pll1_bypass",
+	       imx_clk_gate(dev, "sys_pll1_out", "sys_pll1_bypass",
 			    base + 0x94, 11));
 	clk_dm(IMX8MM_SYS_PLL2_OUT,
-	       imx_clk_gate("sys_pll2_out", "sys_pll2_bypass",
+	       imx_clk_gate(dev, "sys_pll2_out", "sys_pll2_bypass",
 			    base + 0x104, 11));
 	clk_dm(IMX8MM_SYS_PLL3_OUT,
-	       imx_clk_gate("sys_pll3_out", "sys_pll3_bypass",
+	       imx_clk_gate(dev, "sys_pll3_out", "sys_pll3_bypass",
 			    base + 0x114, 11));
 
 	/* SYS PLL fixed output */
@@ -294,7 +294,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3,
 			    imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels)));
 	clk_dm(IMX8MM_CLK_A53_CG,
-	       imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
+	       imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MM_CLK_A53_DIV,
 	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
@@ -366,29 +366,29 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MM_CLK_USB_PHY_REF,
 		imx8m_clk_composite("usb_phy_ref", imx8mm_usb_phy_sels, base + 0xb180));
 	clk_dm(IMX8MM_CLK_I2C1_ROOT,
-	       imx_clk_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0));
+	       imx_clk_gate4(dev, "i2c1_root_clk", "i2c1", base + 0x4170, 0));
 	clk_dm(IMX8MM_CLK_I2C2_ROOT,
-	       imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
+	       imx_clk_gate4(dev, "i2c2_root_clk", "i2c2", base + 0x4180, 0));
 	clk_dm(IMX8MM_CLK_I2C3_ROOT,
-	       imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
+	       imx_clk_gate4(dev, "i2c3_root_clk", "i2c3", base + 0x4190, 0));
 	clk_dm(IMX8MM_CLK_I2C4_ROOT,
-	       imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
+	       imx_clk_gate4(dev, "i2c4_root_clk", "i2c4", base + 0x41a0, 0));
 	clk_dm(IMX8MM_CLK_OCOTP_ROOT,
-	       imx_clk_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0));
+	       imx_clk_gate4(dev, "ocotp_root_clk", "ipg_root", base + 0x4220, 0));
 	clk_dm(IMX8MM_CLK_USDHC1_ROOT,
-	       imx_clk_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
+	       imx_clk_gate4(dev, "usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
 	clk_dm(IMX8MM_CLK_USDHC2_ROOT,
-	       imx_clk_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
+	       imx_clk_gate4(dev, "usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
 	clk_dm(IMX8MM_CLK_WDOG1_ROOT,
-	       imx_clk_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0));
+	       imx_clk_gate4(dev, "wdog1_root_clk", "wdog", base + 0x4530, 0));
 	clk_dm(IMX8MM_CLK_WDOG2_ROOT,
-	       imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0));
+	       imx_clk_gate4(dev, "wdog2_root_clk", "wdog", base + 0x4540, 0));
 	clk_dm(IMX8MM_CLK_WDOG3_ROOT,
-	       imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0));
+	       imx_clk_gate4(dev, "wdog3_root_clk", "wdog", base + 0x4550, 0));
 	clk_dm(IMX8MM_CLK_USDHC3_ROOT,
-	       imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
+	       imx_clk_gate4(dev, "usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 	clk_dm(IMX8MM_CLK_USB1_CTRL_ROOT,
-		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
+		imx_clk_gate4(dev, "usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_XPL_BUILD
@@ -405,7 +405,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("enet_phy", imx8mm_enet_phy_sels,
 	       base + 0xaa80));
 	clk_dm(IMX8MM_CLK_ENET1_ROOT,
-	       imx_clk_gate4("enet1_root_clk", "enet_axi",
+	       imx_clk_gate4(dev, "enet1_root_clk", "enet_axi",
 	       base + 0x40a0, 0));
 	clk_dm(IMX8MM_CLK_PWM1,
 	       imx8m_clk_composite("pwm1", imx8mm_pwm1_sels, base + 0xb380));
@@ -416,18 +416,18 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MM_CLK_PWM4,
 	       imx8m_clk_composite("pwm4", imx8mm_pwm4_sels, base + 0xb500));
 	clk_dm(IMX8MM_CLK_PWM1_ROOT,
-	       imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
+	       imx_clk_gate4(dev, "pwm1_root_clk", "pwm1", base + 0x4280, 0));
 	clk_dm(IMX8MM_CLK_PWM2_ROOT,
-	       imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
+	       imx_clk_gate4(dev, "pwm2_root_clk", "pwm2", base + 0x4290, 0));
 	clk_dm(IMX8MM_CLK_PWM3_ROOT,
-	       imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
+	       imx_clk_gate4(dev, "pwm3_root_clk", "pwm3", base + 0x42a0, 0));
 	clk_dm(IMX8MM_CLK_PWM4_ROOT,
-	       imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
+	       imx_clk_gate4(dev, "pwm4_root_clk", "pwm4", base + 0x42b0, 0));
 #endif
 
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
 	clk_dm(IMX8MM_CLK_PCIE1_ROOT,
-	       imx_clk_gate4("pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0));
+	       imx_clk_gate4(dev, "pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0));
 #endif
 
 #if CONFIG_IS_ENABLED(DM_SPI)
@@ -439,18 +439,18 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("ecspi3", imx8mm_ecspi3_sels, base + 0xc180));
 
 	clk_dm(IMX8MM_CLK_ECSPI1_ROOT,
-	       imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
+	       imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
 	clk_dm(IMX8MM_CLK_ECSPI2_ROOT,
-	       imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
+	       imx_clk_gate4(dev, "ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
 	clk_dm(IMX8MM_CLK_ECSPI3_ROOT,
-	       imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
+	       imx_clk_gate4(dev, "ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
 #endif
 
 #if CONFIG_IS_ENABLED(NXP_FSPI)
 	clk_dm(IMX8MM_CLK_QSPI,
 	       imx8m_clk_composite("qspi", imx8mm_qspi_sels, base + 0xab80));
 	clk_dm(IMX8MM_CLK_QSPI_ROOT,
-	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
+	       imx_clk_gate4(dev, "qspi_root_clk", "qspi", base + 0x42f0, 0));
 #endif
 
 	clk_dm(IMX8MM_CLK_ARM,
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index dbc94ff9450..a8ccc97f096 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -224,19 +224,19 @@ static int imx8mn_clk_probe(struct udevice *dev)
 
 	/* PLL out gate */
 	clk_dm(IMX8MN_DRAM_PLL_OUT,
-	       imx_clk_gate("dram_pll_out", "dram_pll_bypass",
+	       imx_clk_gate(dev, "dram_pll_out", "dram_pll_bypass",
 			    base + 0x50, 13));
 	clk_dm(IMX8MN_ARM_PLL_OUT,
-	       imx_clk_gate("arm_pll_out", "arm_pll_bypass",
+	       imx_clk_gate(dev, "arm_pll_out", "arm_pll_bypass",
 			    base + 0x84, 11));
 	clk_dm(IMX8MN_SYS_PLL1_OUT,
-	       imx_clk_gate("sys_pll1_out", "sys_pll1_bypass",
+	       imx_clk_gate(dev, "sys_pll1_out", "sys_pll1_bypass",
 			    base + 0x94, 11));
 	clk_dm(IMX8MN_SYS_PLL2_OUT,
-	       imx_clk_gate("sys_pll2_out", "sys_pll2_bypass",
+	       imx_clk_gate(dev, "sys_pll2_out", "sys_pll2_bypass",
 			    base + 0x104, 11));
 	clk_dm(IMX8MN_SYS_PLL3_OUT,
-	       imx_clk_gate("sys_pll3_out", "sys_pll3_bypass",
+	       imx_clk_gate(dev, "sys_pll3_out", "sys_pll3_bypass",
 			    base + 0x114, 11));
 
 	/* SYS PLL fixed output */
@@ -291,7 +291,7 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3,
 			    imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels)));
 	clk_dm(IMX8MN_CLK_A53_CG,
-	       imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
+	       imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MN_CLK_A53_DIV,
 	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
@@ -350,45 +350,45 @@ static int imx8mn_clk_probe(struct udevice *dev)
 		imx8m_clk_composite("usb_phy_ref", imx8mn_usb_phy_sels, base + 0xb180));
 
 	clk_dm(IMX8MN_CLK_I2C1_ROOT,
-	       imx_clk_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0));
+	       imx_clk_gate4(dev, "i2c1_root_clk", "i2c1", base + 0x4170, 0));
 	clk_dm(IMX8MN_CLK_I2C2_ROOT,
-	       imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
+	       imx_clk_gate4(dev, "i2c2_root_clk", "i2c2", base + 0x4180, 0));
 	clk_dm(IMX8MN_CLK_I2C3_ROOT,
-	       imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
+	       imx_clk_gate4(dev, "i2c3_root_clk", "i2c3", base + 0x4190, 0));
 	clk_dm(IMX8MN_CLK_I2C4_ROOT,
-	       imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
+	       imx_clk_gate4(dev, "i2c4_root_clk", "i2c4", base + 0x41a0, 0));
 	clk_dm(IMX8MN_CLK_OCOTP_ROOT,
-	       imx_clk_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0));
+	       imx_clk_gate4(dev, "ocotp_root_clk", "ipg_root", base + 0x4220, 0));
 	clk_dm(IMX8MN_CLK_USDHC1_ROOT,
-	       imx_clk_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
+	       imx_clk_gate4(dev, "usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
 	clk_dm(IMX8MN_CLK_USDHC2_ROOT,
-	       imx_clk_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
+	       imx_clk_gate4(dev, "usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
 	clk_dm(IMX8MN_CLK_WDOG1_ROOT,
-	       imx_clk_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0));
+	       imx_clk_gate4(dev, "wdog1_root_clk", "wdog", base + 0x4530, 0));
 	clk_dm(IMX8MN_CLK_WDOG2_ROOT,
-	       imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0));
+	       imx_clk_gate4(dev, "wdog2_root_clk", "wdog", base + 0x4540, 0));
 	clk_dm(IMX8MN_CLK_WDOG3_ROOT,
-	       imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0));
+	       imx_clk_gate4(dev, "wdog3_root_clk", "wdog", base + 0x4550, 0));
 	clk_dm(IMX8MN_CLK_USDHC3_ROOT,
-	       imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
+	       imx_clk_gate4(dev, "usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 	clk_dm(IMX8MN_CLK_QSPI_ROOT,
-	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
+	       imx_clk_gate4(dev, "qspi_root_clk", "qspi", base + 0x42f0, 0));
 	clk_dm(IMX8MN_CLK_NAND_ROOT,
-	       imx_clk_gate2_shared2("nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand));
+	       imx_clk_gate2_shared2(dev, "nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand));
 	clk_dm(IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK,
-	       imx_clk_gate2_shared2("nand_usdhc_rawnand_clk",
+	       imx_clk_gate2_shared2(dev, "nand_usdhc_rawnand_clk",
 				     "nand_usdhc_bus", base + 0x4300, 0,
 				     &share_count_nand));
 	clk_dm(IMX8MN_CLK_UART1_ROOT,
-	       imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
+	       imx_clk_gate4(dev, "uart1_root_clk", "uart1", base + 0x4490, 0));
 	clk_dm(IMX8MN_CLK_UART2_ROOT,
-	       imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
+	       imx_clk_gate4(dev, "uart2_root_clk", "uart2", base + 0x44a0, 0));
 	clk_dm(IMX8MN_CLK_UART3_ROOT,
-	       imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
+	       imx_clk_gate4(dev, "uart3_root_clk", "uart3", base + 0x44b0, 0));
 	clk_dm(IMX8MN_CLK_UART4_ROOT,
-	       imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
+	       imx_clk_gate4(dev, "uart4_root_clk", "uart4", base + 0x44c0, 0));
 	clk_dm(IMX8MN_CLK_USB1_CTRL_ROOT,
-		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
+		imx_clk_gate4(dev, "usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_XPL_BUILD
@@ -402,7 +402,7 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("enet_phy", imx8mn_enet_phy_sels,
 	       base + 0xaa80));
 	clk_dm(IMX8MN_CLK_ENET1_ROOT,
-	       imx_clk_gate4("enet1_root_clk", "enet_axi",
+	       imx_clk_gate4(dev, "enet1_root_clk", "enet_axi",
 	       base + 0x40a0, 0));
 	clk_dm(IMX8MN_CLK_PWM1,
 	       imx8m_clk_composite("pwm1", imx8mn_pwm1_sels, base + 0xb380));
@@ -413,13 +413,13 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_PWM4,
 	       imx8m_clk_composite("pwm4", imx8mn_pwm4_sels, base + 0xb500));
 	clk_dm(IMX8MN_CLK_PWM1_ROOT,
-	       imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
+	       imx_clk_gate4(dev, "pwm1_root_clk", "pwm1", base + 0x4280, 0));
 	clk_dm(IMX8MN_CLK_PWM2_ROOT,
-	       imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
+	       imx_clk_gate4(dev, "pwm2_root_clk", "pwm2", base + 0x4290, 0));
 	clk_dm(IMX8MN_CLK_PWM3_ROOT,
-	       imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
+	       imx_clk_gate4(dev, "pwm3_root_clk", "pwm3", base + 0x42a0, 0));
 	clk_dm(IMX8MN_CLK_PWM4_ROOT,
-	       imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
+	       imx_clk_gate4(dev, "pwm4_root_clk", "pwm4", base + 0x42b0, 0));
 #endif
 
 #if CONFIG_IS_ENABLED(DM_SPI)
@@ -430,11 +430,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_ECSPI3,
 	       imx8m_clk_composite("ecspi3", imx8mn_ecspi3_sels, base + 0xc180));
 	clk_dm(IMX8MN_CLK_ECSPI1_ROOT,
-	       imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
+	       imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
 	clk_dm(IMX8MN_CLK_ECSPI2_ROOT,
-	       imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
+	       imx_clk_gate4(dev, "ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
 	clk_dm(IMX8MN_CLK_ECSPI3_ROOT,
-	       imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
+	       imx_clk_gate4(dev, "ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
 #endif
 
 	clk_dm(IMX8MN_CLK_ARM,
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 4b916bef7a1..718ba095bef 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -222,11 +222,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags(dev, "sys_pll2_bypass", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags(dev, "sys_pll3_bypass", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT));
 
-	clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13));
-	clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11));
-	clk_dm(IMX8MP_SYS_PLL1_OUT, imx_clk_gate("sys_pll1_out", "sys_pll1_bypass", base + 0x94, 11));
-	clk_dm(IMX8MP_SYS_PLL2_OUT, imx_clk_gate("sys_pll2_out", "sys_pll2_bypass", base + 0x104, 11));
-	clk_dm(IMX8MP_SYS_PLL3_OUT, imx_clk_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11));
+	clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate(dev, "dram_pll_out", "dram_pll_bypass", base + 0x50, 13));
+	clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate(dev, "arm_pll_out", "arm_pll_bypass", base + 0x84, 11));
+	clk_dm(IMX8MP_SYS_PLL1_OUT, imx_clk_gate(dev, "sys_pll1_out", "sys_pll1_bypass", base + 0x94, 11));
+	clk_dm(IMX8MP_SYS_PLL2_OUT, imx_clk_gate(dev, "sys_pll2_out", "sys_pll2_bypass", base + 0x104, 11));
+	clk_dm(IMX8MP_SYS_PLL3_OUT, imx_clk_gate(dev, "sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11));
 
 	clk_dm(IMX8MP_SYS_PLL1_40M, imx_clk_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20));
 	clk_dm(IMX8MP_SYS_PLL1_80M, imx_clk_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10));
@@ -263,7 +263,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMX8MP_CLK_A53_SRC, imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3, imx8mp_a53_sels, ARRAY_SIZE(imx8mp_a53_sels)));
-	clk_dm(IMX8MP_CLK_A53_CG, imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
+	clk_dm(IMX8MP_CLK_A53_CG, imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MP_CLK_HSIO_AXI, imx8m_clk_composite("hsio_axi", imx8mp_hsio_axi_sels, base + 0x8380));
@@ -316,47 +316,47 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
 	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags(dev, "dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
 
-	clk_dm(IMX8MP_CLK_DRAM1_ROOT, imx_clk_gate4_flags("dram1_root_clk", "dram_core_clk", base + 0x4050, 0, CLK_IS_CRITICAL));
-	clk_dm(IMX8MP_CLK_ECSPI1_ROOT, imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
-	clk_dm(IMX8MP_CLK_ECSPI2_ROOT, imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
-	clk_dm(IMX8MP_CLK_ECSPI3_ROOT, imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
-	clk_dm(IMX8MP_CLK_ENET1_ROOT, imx_clk_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0));
-	clk_dm(IMX8MP_CLK_GPIO1_ROOT, imx_clk_gate4("gpio1_root_clk", "ipg_root", base + 0x40b0, 0));
-	clk_dm(IMX8MP_CLK_GPIO2_ROOT, imx_clk_gate4("gpio2_root_clk", "ipg_root", base + 0x40c0, 0));
-	clk_dm(IMX8MP_CLK_GPIO3_ROOT, imx_clk_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0));
-	clk_dm(IMX8MP_CLK_GPIO4_ROOT, imx_clk_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0));
-	clk_dm(IMX8MP_CLK_GPIO5_ROOT, imx_clk_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0));
-	clk_dm(IMX8MP_CLK_I2C1_ROOT, imx_clk_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0));
-	clk_dm(IMX8MP_CLK_I2C2_ROOT, imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
-	clk_dm(IMX8MP_CLK_I2C3_ROOT, imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
-	clk_dm(IMX8MP_CLK_I2C4_ROOT, imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
-	clk_dm(IMX8MP_CLK_PCIE_ROOT, imx_clk_gate4("pcie_root_clk", "pcie_aux", base + 0x4250, 0));
-	clk_dm(IMX8MP_CLK_PWM1_ROOT, imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
-	clk_dm(IMX8MP_CLK_PWM2_ROOT, imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
-	clk_dm(IMX8MP_CLK_PWM3_ROOT, imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
-	clk_dm(IMX8MP_CLK_PWM4_ROOT, imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
-	clk_dm(IMX8MP_CLK_QOS_ROOT, imx_clk_gate4("qos_root_clk", "ipg_root", base + 0x42c0, 0));
-	clk_dm(IMX8MP_CLK_QOS_ENET_ROOT, imx_clk_gate4("qos_enet_root_clk", "ipg_root", base + 0x42e0, 0));
-	clk_dm(IMX8MP_CLK_QSPI_ROOT, imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
-	clk_dm(IMX8MP_CLK_I2C5_ROOT, imx_clk_gate2("i2c5_root_clk", "i2c5", base + 0x4330, 0));
-	clk_dm(IMX8MP_CLK_I2C6_ROOT, imx_clk_gate2("i2c6_root_clk", "i2c6", base + 0x4340, 0));
-	clk_dm(IMX8MP_CLK_SIM_ENET_ROOT, imx_clk_gate4("sim_enet_root_clk", "enet_axi", base + 0x4400, 0));
-	clk_dm(IMX8MP_CLK_ENET_QOS_ROOT, imx_clk_gate4("enet_qos_root_clk", "sim_enet_root_clk", base + 0x43b0, 0));
-	clk_dm(IMX8MP_CLK_UART1_ROOT, imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
-	clk_dm(IMX8MP_CLK_UART2_ROOT, imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
-	clk_dm(IMX8MP_CLK_UART3_ROOT, imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
-	clk_dm(IMX8MP_CLK_UART4_ROOT, imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
-	clk_dm(IMX8MP_CLK_USB_ROOT, imx_clk_gate2("usb_root_clk", "hsio_axi", base + 0x44d0, 0));
-	clk_dm(IMX8MP_CLK_USB_SUSP, imx_clk_gate2("usb_suspend_clk", "clock-osc-24m", base + 0x44d0, 0));
-	clk_dm(IMX8MP_CLK_USB_PHY_ROOT, imx_clk_gate4("usb_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0));
-	clk_dm(IMX8MP_CLK_USDHC1_ROOT, imx_clk_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
-	clk_dm(IMX8MP_CLK_USDHC2_ROOT, imx_clk_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
-	clk_dm(IMX8MP_CLK_WDOG1_ROOT, imx_clk_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0));
-	clk_dm(IMX8MP_CLK_WDOG2_ROOT, imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0));
-	clk_dm(IMX8MP_CLK_WDOG3_ROOT, imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0));
-	clk_dm(IMX8MP_CLK_HSIO_ROOT, imx_clk_gate4("hsio_root_clk", "ipg_root", base + 0x45c0, 0));
-
-	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
+	clk_dm(IMX8MP_CLK_DRAM1_ROOT, imx_clk_gate4_flags(dev, "dram1_root_clk", "dram_core_clk", base + 0x4050, 0, CLK_IS_CRITICAL));
+	clk_dm(IMX8MP_CLK_ECSPI1_ROOT, imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
+	clk_dm(IMX8MP_CLK_ECSPI2_ROOT, imx_clk_gate4(dev, "ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
+	clk_dm(IMX8MP_CLK_ECSPI3_ROOT, imx_clk_gate4(dev, "ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
+	clk_dm(IMX8MP_CLK_ENET1_ROOT, imx_clk_gate4(dev, "enet1_root_clk", "enet_axi", base + 0x40a0, 0));
+	clk_dm(IMX8MP_CLK_GPIO1_ROOT, imx_clk_gate4(dev, "gpio1_root_clk", "ipg_root", base + 0x40b0, 0));
+	clk_dm(IMX8MP_CLK_GPIO2_ROOT, imx_clk_gate4(dev, "gpio2_root_clk", "ipg_root", base + 0x40c0, 0));
+	clk_dm(IMX8MP_CLK_GPIO3_ROOT, imx_clk_gate4(dev, "gpio3_root_clk", "ipg_root", base + 0x40d0, 0));
+	clk_dm(IMX8MP_CLK_GPIO4_ROOT, imx_clk_gate4(dev, "gpio4_root_clk", "ipg_root", base + 0x40e0, 0));
+	clk_dm(IMX8MP_CLK_GPIO5_ROOT, imx_clk_gate4(dev, "gpio5_root_clk", "ipg_root", base + 0x40f0, 0));
+	clk_dm(IMX8MP_CLK_I2C1_ROOT, imx_clk_gate4(dev, "i2c1_root_clk", "i2c1", base + 0x4170, 0));
+	clk_dm(IMX8MP_CLK_I2C2_ROOT, imx_clk_gate4(dev, "i2c2_root_clk", "i2c2", base + 0x4180, 0));
+	clk_dm(IMX8MP_CLK_I2C3_ROOT, imx_clk_gate4(dev, "i2c3_root_clk", "i2c3", base + 0x4190, 0));
+	clk_dm(IMX8MP_CLK_I2C4_ROOT, imx_clk_gate4(dev, "i2c4_root_clk", "i2c4", base + 0x41a0, 0));
+	clk_dm(IMX8MP_CLK_PCIE_ROOT, imx_clk_gate4(dev, "pcie_root_clk", "pcie_aux", base + 0x4250, 0));
+	clk_dm(IMX8MP_CLK_PWM1_ROOT, imx_clk_gate4(dev, "pwm1_root_clk", "pwm1", base + 0x4280, 0));
+	clk_dm(IMX8MP_CLK_PWM2_ROOT, imx_clk_gate4(dev, "pwm2_root_clk", "pwm2", base + 0x4290, 0));
+	clk_dm(IMX8MP_CLK_PWM3_ROOT, imx_clk_gate4(dev, "pwm3_root_clk", "pwm3", base + 0x42a0, 0));
+	clk_dm(IMX8MP_CLK_PWM4_ROOT, imx_clk_gate4(dev, "pwm4_root_clk", "pwm4", base + 0x42b0, 0));
+	clk_dm(IMX8MP_CLK_QOS_ROOT, imx_clk_gate4(dev, "qos_root_clk", "ipg_root", base + 0x42c0, 0));
+	clk_dm(IMX8MP_CLK_QOS_ENET_ROOT, imx_clk_gate4(dev, "qos_enet_root_clk", "ipg_root", base + 0x42e0, 0));
+	clk_dm(IMX8MP_CLK_QSPI_ROOT, imx_clk_gate4(dev, "qspi_root_clk", "qspi", base + 0x42f0, 0));
+	clk_dm(IMX8MP_CLK_I2C5_ROOT, imx_clk_gate2(dev, "i2c5_root_clk", "i2c5", base + 0x4330, 0));
+	clk_dm(IMX8MP_CLK_I2C6_ROOT, imx_clk_gate2(dev, "i2c6_root_clk", "i2c6", base + 0x4340, 0));
+	clk_dm(IMX8MP_CLK_SIM_ENET_ROOT, imx_clk_gate4(dev, "sim_enet_root_clk", "enet_axi", base + 0x4400, 0));
+	clk_dm(IMX8MP_CLK_ENET_QOS_ROOT, imx_clk_gate4(dev, "enet_qos_root_clk", "sim_enet_root_clk", base + 0x43b0, 0));
+	clk_dm(IMX8MP_CLK_UART1_ROOT, imx_clk_gate4(dev, "uart1_root_clk", "uart1", base + 0x4490, 0));
+	clk_dm(IMX8MP_CLK_UART2_ROOT, imx_clk_gate4(dev, "uart2_root_clk", "uart2", base + 0x44a0, 0));
+	clk_dm(IMX8MP_CLK_UART3_ROOT, imx_clk_gate4(dev, "uart3_root_clk", "uart3", base + 0x44b0, 0));
+	clk_dm(IMX8MP_CLK_UART4_ROOT, imx_clk_gate4(dev, "uart4_root_clk", "uart4", base + 0x44c0, 0));
+	clk_dm(IMX8MP_CLK_USB_ROOT, imx_clk_gate2(dev, "usb_root_clk", "hsio_axi", base + 0x44d0, 0));
+	clk_dm(IMX8MP_CLK_USB_SUSP, imx_clk_gate2(dev, "usb_suspend_clk", "clock-osc-24m", base + 0x44d0, 0));
+	clk_dm(IMX8MP_CLK_USB_PHY_ROOT, imx_clk_gate4(dev, "usb_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0));
+	clk_dm(IMX8MP_CLK_USDHC1_ROOT, imx_clk_gate4(dev, "usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
+	clk_dm(IMX8MP_CLK_USDHC2_ROOT, imx_clk_gate4(dev, "usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
+	clk_dm(IMX8MP_CLK_WDOG1_ROOT, imx_clk_gate4(dev, "wdog1_root_clk", "wdog", base + 0x4530, 0));
+	clk_dm(IMX8MP_CLK_WDOG2_ROOT, imx_clk_gate4(dev, "wdog2_root_clk", "wdog", base + 0x4540, 0));
+	clk_dm(IMX8MP_CLK_WDOG3_ROOT, imx_clk_gate4(dev, "wdog3_root_clk", "wdog", base + 0x4550, 0));
+	clk_dm(IMX8MP_CLK_HSIO_ROOT, imx_clk_gate4(dev, "hsio_root_clk", "ipg_root", base + 0x45c0, 0));
+
+	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4(dev, "usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 
 	clk_dm(IMX8MP_CLK_ARM,
 	       imx_clk_mux2_flags(dev, "arm_core", base + 0x9880, 24, 1,
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index dc9b7d56815..782dd39a300 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -239,38 +239,38 @@ static int imx8mq_clk_probe(struct udevice *dev)
 
 	/* PLL out gate */
 	clk_dm(IMX8MQ_DRAM_PLL_OUT,
-	       imx_clk_gate("dram_pll_out", "dram_pll_ref_sel",
+	       imx_clk_gate(dev, "dram_pll_out", "dram_pll_ref_sel",
 			    base + 0x60, 13));
 	clk_dm(IMX8MQ_ARM_PLL_OUT,
-	       imx_clk_gate("arm_pll_out", "arm_pll_bypass",
+	       imx_clk_gate(dev, "arm_pll_out", "arm_pll_bypass",
 			    base + 0x28, 11));
 	clk_dm(IMX8MQ_GPU_PLL_OUT,
-	       imx_clk_gate("gpu_pll_out", "gpu_pll_bypass",
+	       imx_clk_gate(dev, "gpu_pll_out", "gpu_pll_bypass",
 			    base + 0x18, 11));
 	clk_dm(IMX8MQ_VPU_PLL_OUT,
-	       imx_clk_gate("vpu_pll_out", "vpu_pll_bypass",
+	       imx_clk_gate(dev, "vpu_pll_out", "vpu_pll_bypass",
 			    base + 0x20, 11));
 	clk_dm(IMX8MQ_AUDIO_PLL1_OUT,
-	       imx_clk_gate("audio_pll1_out", "audio_pll1_bypass",
+	       imx_clk_gate(dev, "audio_pll1_out", "audio_pll1_bypass",
 			    base + 0x0, 11));
 	clk_dm(IMX8MQ_AUDIO_PLL2_OUT,
-	       imx_clk_gate("audio_pll2_out", "audio_pll2_bypass",
+	       imx_clk_gate(dev, "audio_pll2_out", "audio_pll2_bypass",
 			    base + 0x8, 11));
 	clk_dm(IMX8MQ_VIDEO_PLL1_OUT,
-	       imx_clk_gate("video_pll1_out", "video_pll1_bypass",
+	       imx_clk_gate(dev, "video_pll1_out", "video_pll1_bypass",
 			    base + 0x10, 11));
 
 	clk_dm(IMX8MQ_SYS1_PLL_OUT,
-	       imx_clk_gate("sys_pll1_out", "sys1_pll",
+	       imx_clk_gate(dev, "sys_pll1_out", "sys1_pll",
 			    base + 0x30, 11));
 	clk_dm(IMX8MQ_SYS2_PLL_OUT,
-	       imx_clk_gate("sys_pll2_out", "sys2_pll",
+	       imx_clk_gate(dev, "sys_pll2_out", "sys2_pll",
 			    base + 0x3c, 11));
 	clk_dm(IMX8MQ_SYS3_PLL_OUT,
-	       imx_clk_gate("sys_pll3_out", "sys3_pll",
+	       imx_clk_gate(dev, "sys_pll3_out", "sys3_pll",
 			    base + 0x48, 11));
 	clk_dm(IMX8MQ_VIDEO2_PLL_OUT,
-	       imx_clk_gate("video_pll2_out", "video_pll2_ref_sel",
+	       imx_clk_gate(dev, "video_pll2_out", "video_pll2_ref_sel",
 			    base + 0x54, 11));
 
 	/* SYS PLL fixed output */
@@ -340,7 +340,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 				 ARRAY_SIZE(pllout_monitor_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MQ_CLK_MON_CLK2_OUT,
-	       imx_clk_gate4("pllout_monitor_clk2", "pllout_monitor_sel", base + 0x74, 4));
+	       imx_clk_gate4(dev, "pllout_monitor_clk2", "pllout_monitor_sel", base + 0x74, 4));
 
 	base = dev_read_addr_ptr(dev);
 	if (!base) {
@@ -352,7 +352,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3,
 			    imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels)));
 	clk_dm(IMX8MQ_CLK_A53_CG,
-	       imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
+	       imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MQ_CLK_A53_DIV,
 	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
@@ -424,49 +424,49 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("ecspi3", imx8mq_ecspi3_sels, base + 0xc180));
 
 	clk_dm(IMX8MQ_CLK_ECSPI1_ROOT,
-	       imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
+	       imx_clk_gate4(dev, "ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
 	clk_dm(IMX8MQ_CLK_ECSPI2_ROOT,
-	       imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
+	       imx_clk_gate4(dev, "ecspi2_root_clk", "ecspi2", base + 0x4080, 0));
 	clk_dm(IMX8MQ_CLK_ECSPI3_ROOT,
-	       imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
+	       imx_clk_gate4(dev, "ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
 	clk_dm(IMX8MQ_CLK_I2C1_ROOT,
-	       imx_clk_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0));
+	       imx_clk_gate4(dev, "i2c1_root_clk", "i2c1", base + 0x4170, 0));
 	clk_dm(IMX8MQ_CLK_I2C2_ROOT,
-	       imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
+	       imx_clk_gate4(dev, "i2c2_root_clk", "i2c2", base + 0x4180, 0));
 	clk_dm(IMX8MQ_CLK_I2C3_ROOT,
-	       imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
+	       imx_clk_gate4(dev, "i2c3_root_clk", "i2c3", base + 0x4190, 0));
 	clk_dm(IMX8MQ_CLK_I2C4_ROOT,
-	       imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
+	       imx_clk_gate4(dev, "i2c4_root_clk", "i2c4", base + 0x41a0, 0));
 	clk_dm(IMX8MQ_CLK_UART1_ROOT,
-	       imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
+	       imx_clk_gate4(dev, "uart1_root_clk", "uart1", base + 0x4490, 0));
 	clk_dm(IMX8MQ_CLK_UART2_ROOT,
-	       imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
+	       imx_clk_gate4(dev, "uart2_root_clk", "uart2", base + 0x44a0, 0));
 	clk_dm(IMX8MQ_CLK_UART3_ROOT,
-	       imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
+	       imx_clk_gate4(dev, "uart3_root_clk", "uart3", base + 0x44b0, 0));
 	clk_dm(IMX8MQ_CLK_UART4_ROOT,
-	       imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
+	       imx_clk_gate4(dev, "uart4_root_clk", "uart4", base + 0x44c0, 0));
 	clk_dm(IMX8MQ_CLK_OCOTP_ROOT,
-	       imx_clk_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0));
+	       imx_clk_gate4(dev, "ocotp_root_clk", "ipg_root", base + 0x4220, 0));
 	clk_dm(IMX8MQ_CLK_USDHC1_ROOT,
-	       imx_clk_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
+	       imx_clk_gate4(dev, "usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
 	clk_dm(IMX8MQ_CLK_USDHC2_ROOT,
-	       imx_clk_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
+	       imx_clk_gate4(dev, "usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
 	clk_dm(IMX8MQ_CLK_WDOG1_ROOT,
-	       imx_clk_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0));
+	       imx_clk_gate4(dev, "wdog1_root_clk", "wdog", base + 0x4530, 0));
 	clk_dm(IMX8MQ_CLK_WDOG2_ROOT,
-	       imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0));
+	       imx_clk_gate4(dev, "wdog2_root_clk", "wdog", base + 0x4540, 0));
 	clk_dm(IMX8MQ_CLK_WDOG3_ROOT,
-	       imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0));
+	       imx_clk_gate4(dev, "wdog3_root_clk", "wdog", base + 0x4550, 0));
 	clk_dm(IMX8MQ_CLK_QSPI_ROOT,
-	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
+	       imx_clk_gate4(dev, "qspi_root_clk", "qspi", base + 0x42f0, 0));
 	clk_dm(IMX8MQ_CLK_USB1_CTRL_ROOT,
-	       imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
+	       imx_clk_gate4(dev, "usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 	clk_dm(IMX8MQ_CLK_USB2_CTRL_ROOT,
-	       imx_clk_gate4("usb2_ctrl_root_clk", "usb_bus", base + 0x44e0, 0));
+	       imx_clk_gate4(dev, "usb2_ctrl_root_clk", "usb_bus", base + 0x44e0, 0));
 	clk_dm(IMX8MQ_CLK_USB1_PHY_ROOT,
-	       imx_clk_gate4("usb1_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0));
+	       imx_clk_gate4(dev, "usb1_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0));
 	clk_dm(IMX8MQ_CLK_USB2_PHY_ROOT,
-	       imx_clk_gate4("usb2_phy_root_clk", "usb_phy_ref", base + 0x4500, 0));
+	       imx_clk_gate4(dev, "usb2_phy_root_clk", "usb_phy_ref", base + 0x4500, 0));
 
 	clk_dm(IMX8MQ_CLK_ENET_REF,
 	       imx8m_clk_composite("enet_ref", imx8mq_enet_ref_sels,
@@ -478,7 +478,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("enet_phy", imx8mq_enet_phy_sels,
 				   base + 0xaa80));
 	clk_dm(IMX8MQ_CLK_ENET1_ROOT,
-	       imx_clk_gate4("enet1_root_clk", "enet_axi",
+	       imx_clk_gate4(dev, "enet1_root_clk", "enet_axi",
 			     base + 0x40a0, 0));
 
 	clk_dm(IMX8MQ_CLK_DRAM_ALT_ROOT,
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index 16fc3bcdb3e..40cba218c29 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -116,13 +116,13 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 			       base + 0x14, 16, 3));
 
 	clk_dm(IMXRT1020_CLK_USDHC1,
-	       imx_clk_gate2("usdhc1", "usdhc1_podf", base + 0x80, 2));
+	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMXRT1020_CLK_USDHC2,
-	       imx_clk_gate2("usdhc2", "usdhc2_podf", base + 0x80, 4));
+	       imx_clk_gate2(dev, "usdhc2", "usdhc2_podf", base + 0x80, 4));
 	clk_dm(IMXRT1020_CLK_LPUART1,
-	       imx_clk_gate2("lpuart1", "lpuart_podf", base + 0x7c, 24));
+	       imx_clk_gate2(dev, "lpuart1", "lpuart_podf", base + 0x7c, 24));
 	clk_dm(IMXRT1020_CLK_SEMC,
-	       imx_clk_gate2("semc", "semc_podf", base + 0x74, 4));
+	       imx_clk_gate2(dev, "semc", "semc_podf", base + 0x74, 4));
 
 #ifdef CONFIG_XPL_BUILD
 	struct clk *clk, *clk1;
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 5f37915f593..71d5fa8a90e 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -167,19 +167,19 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 			       base + 0x18, 23, 3));
 
 	clk_dm(IMXRT1050_CLK_USDHC1,
-	       imx_clk_gate2("usdhc1", "usdhc1_podf", base + 0x80, 2));
+	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMXRT1050_CLK_USDHC2,
-	       imx_clk_gate2("usdhc2", "usdhc2_podf", base + 0x80, 4));
+	       imx_clk_gate2(dev, "usdhc2", "usdhc2_podf", base + 0x80, 4));
 	clk_dm(IMXRT1050_CLK_LPUART1,
-	       imx_clk_gate2("lpuart1", "lpuart_podf", base + 0x7c, 24));
+	       imx_clk_gate2(dev, "lpuart1", "lpuart_podf", base + 0x7c, 24));
 	clk_dm(IMXRT1050_CLK_SEMC,
-	       imx_clk_gate2("semc", "semc_podf", base + 0x74, 4));
+	       imx_clk_gate2(dev, "semc", "semc_podf", base + 0x74, 4));
 	clk_dm(IMXRT1050_CLK_LCDIF_APB,
-	       imx_clk_gate2("lcdif", "lcdif_podf", base + 0x70, 28));
+	       imx_clk_gate2(dev, "lcdif", "lcdif_podf", base + 0x70, 28));
 	clk_dm(IMXRT1050_CLK_LCDIF_PIX,
-	       imx_clk_gate2("lcdif_pix", "lcdif", base + 0x74, 10));
+	       imx_clk_gate2(dev, "lcdif_pix", "lcdif", base + 0x74, 10));
 	clk_dm(IMXRT1050_CLK_USBOH3,
-	       imx_clk_gate2("usboh3", "pll3_usb_otg", base + 0x80, 0));
+	       imx_clk_gate2(dev, "usboh3", "pll3_usb_otg", base + 0x80, 0));
 
 	struct clk *clk, *clk1;
 
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6f964f2679f..d2122977e47 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -87,14 +87,15 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 			  const char *parent_name, void __iomem *base,
 			  u32 div_mask);
 
-static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
-					void __iomem *reg, u8 shift)
+static inline struct clk *imx_clk_gate2(struct udevice *dev, const char *name,
+					const char *parent, void __iomem *reg,
+					u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, 0x3, 0, NULL);
 }
 
-static inline struct clk *imx_clk_gate2_shared(const char *name,
+static inline struct clk *imx_clk_gate2_shared(struct udevice *dev, const char *name,
 					       const char *parent,
 					       void __iomem *reg, u8 shift,
 					       unsigned int *share_count)
@@ -103,7 +104,7 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 				  shift, 0x3, 0, share_count);
 }
 
-static inline struct clk *imx_clk_gate2_shared2(const char *name,
+static inline struct clk *imx_clk_gate2_shared2(struct udevice *dev, const char *name,
 						const char *parent,
 						void __iomem *reg, u8 shift,
 						unsigned int *share_count)
@@ -113,7 +114,7 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 				  share_count);
 }
 
-static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
+static inline struct clk *imx_clk_gate4(struct udevice *dev, const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent,
@@ -121,7 +122,7 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 			reg, shift, 0x3, 0, NULL);
 }
 
-static inline struct clk *imx_clk_gate4_flags(const char *name,
+static inline struct clk *imx_clk_gate4_flags(struct udevice *dev, const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned long flags)
 {
@@ -215,22 +216,25 @@ static inline struct clk *imx_clk_mux2(struct udevice *dev, const char *name, vo
 			reg, shift, width, 0);
 }
 
-static inline struct clk *imx_clk_gate(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
+static inline struct clk *imx_clk_gate(struct udevice *dev, const char *name,
+				       const char *parent, void __iomem *reg,
+				       u8 shift)
 {
 	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, 0, NULL);
 }
 
-static inline struct clk *imx_clk_gate_flags(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, unsigned long flags)
+static inline struct clk *imx_clk_gate_flags(struct udevice *dev, const char *name,
+					     const char *parent, void __iomem *reg,
+					     u8 shift, unsigned long flags)
 {
 	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
 			shift, 0, NULL);
 }
 
-static inline struct clk *imx_clk_gate3(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
+static inline struct clk *imx_clk_gate3(struct udevice *dev, const char *name,
+					const char *parent, void __iomem *reg,
+					u8 shift)
 {
 	return clk_register_gate(NULL, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-- 
2.47.2

