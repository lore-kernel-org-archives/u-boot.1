Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D723606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D8ST5uxx;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=YQw8wAdn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 767CD60F41;
	Fri, 13 Nov 2026 02:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fVh9ogBcNaha; Fri, 13 Nov 2026 02:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C844560F0C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537287;
	b=SCN4V3H3l1gMK81ukqDWESZxGQ1TMvRHQz6Jb5/SXXxJAWWszBaS4hyb2+kiUOQLl/2h
	 PgbSaG8D6jmBHXdpSd01dI9YoAeQ1BT0fOruubuLR/HVuMuWmD2kXR+hqAnuVV8uCtVl+
	 KnLcep2JlD0gnYxO2/6duSxj6CSeq1rjoL/2uX1i3TBdcltcGYLgdVZA+jCHFrq9XJ5vR
	 thYs/zNhxT+6i0GfLsJxMaOMDhZ/weQAZO6Z1E5E7SI3NuVhtYU5Z1q665DccoZv0ZOPl
	 IctyjVHFDebFoTyNc0Dzdct6RhaVQ9KyS9BEBexJwIoMcNokKKBIdu154E9kdFVdT7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X8rulxYsqdPT8sV6u2PDOl/7WI0LSM8/kD6whQtc/Q0=;
	b=QZYXSB5hz522oBToWii7rNNxqBElVXeHozRDBP02MFCYNjhNnYzlXSSljGqQVuVJsw8q
	 1wmLTldJBKwXxmWCOSfMqY4HwDKZi06M0P/tlZ2IGdauHfpqKSzzuGOe7o2LpC4WP1da9
	 AtT2zas8A6+IUnvTZxN5X7x8nvHftkAKFRl/bBr6T12oto3fpNat2d+rh29bFa8IjTTyy
	 PD9I4Gf2bXvPW0/EcXXnUQoTWAGxtngWlBJfuLaM0GAcFsPCEQ+2ScaJp48j8ZMBgUnj1
	 tZKi5y+Fig9/9o8TR1cLMo1Q5GM8JbAM88/LYr8pCpvM/vgAOBWuCTlQroCe2po0K9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537286;
	bh=X8rulxYsqdPT8sV6u2PDOl/7WI0LSM8/kD6whQtc/Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D8ST5uxx2dFrcilNur64CYO0wPmS7PglqcUzzlWtSybjwAqGisoIWmaNPaCBXgkF4
	 sp8Jk1VOgfgt/nNPyqjwsOMqutXarcSN0Vi6V2Xb/PZ6C4C95ZUjFfHaEKv6HEm1Xg
	 zvvGRmmhCVCetO9f6qD30coDpwj4JQK1YRoiL4hfVMgncmyBxAATEjeDGdKl34IoWl
	 tf4zW1hkwb0lJNkLbFqS2j7tky75SLIOUxNJmOot9iWDF+KmVcYgLZmitujEAYn6Fe
	 drG+X/KXZIqeCO2sZVkgpqgAzIYq7Xp9IciDFdtBRKP4rbkleqV6xaDAQlqyw+e10y
	 dhO4K7D+8lEIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C844560F0C;
	Fri, 13 Nov 2026 02:34:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08DE6F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF17040D7C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9utZrZq03BMx for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:34:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C47240D44
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=YQw8wAdn
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C47240D44
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:42 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id E92F84C8C7;
 Fri, 13 Nov 2026 13:34:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8rulxYsqdPT8sV6u2PDOl/7WI0LSM8/kD6whQtc/Q0=;
 b=YQw8wAdnbQX5qvGKtB1HhhgXobmAWzjlkmt2gdnbGOSDRAcWUQ4zkT5vzMcZ6tewJ+LXOA
 wFAKCBF90UKgdzMwCIeOqCNqAYRsSgcybZaMyKLV502H6yQmvbm+CvGiYgUt9pz57roFUl
 qVe3Iam5k1KBcEYRgRKU6KN26DrHcJCvB50q1Xp7ZUeCjt28WNmVNjqA01e2N3XPt8m1Ks
 kDPH/hkKM7gEXe7So9X4IZUJ4eR9AGoIC+CsHNzU1jQWaAVgIe0ECWEtxQv35Tfj1mQyel
 ActE9SMuDY2Vcd89kHIXhAMnTrpsVAlUXmcqiiR7b1nUjlesWjUGE1m+kxN0Sg==
X-GPT-Reason: The message is classified as legitimate personal/professional
 correspondence. The sender's domain (d-silva.org) matches the
 recipient's domain (d-silva.org), and the content is a technical
 software patch description (Linux kernel/driver development) which
 is consistent with a professional developer's mailbox. There are
 no phishing indicators, no urgency/fear tactics, no suspicious URLs,
 and the "Signed-off-by" signature aligns with standard open-source
 development practices.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 22/26] phy: sunxi: Add Allwinner A733 Cadence Combo PHY driver
Date: Fri, 13 Nov 2026 13:32:32 +1100
Message-ID: <20261113023236.569054-23-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a UCLASS_PHY driver for the Allwinner A733 (sun60i) SerDes subsystem
and Cadence Combo PHY 1 in PCIe mode, handling clock/reset enablement,
analog tuning, and PLL lock polling.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/include/asm/arch-sunxi/clock.h     |   1 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c       |  68 +++++
 board/sunxi/board.c                         |   4 +
 drivers/clk/sunxi/clk_a733.c                |   6 +
 drivers/phy/allwinner/Kconfig               |   8 +
 drivers/phy/allwinner/Makefile              |   1 +
 drivers/phy/allwinner/phy-sun60i-combophy.c | 293 ++++++++++++++++++++
 7 files changed, 381 insertions(+)
 create mode 100644 drivers/phy/allwinner/phy-sun60i-combophy.c

diff --git a/arch/arm/include/asm/arch-sunxi/clock.h b/arch/arm/include/asm/arch-sunxi/clock.h
index fcc8966cb0b..444870997d6 100644
--- a/arch/arm/include/asm/arch-sunxi/clock.h
+++ b/arch/arm/include/asm/arch-sunxi/clock.h
@@ -35,6 +35,7 @@ void clock_set_de_mod_clock(u32 *clk_cfg, unsigned int hz);
 void clock_init_safe(void);
 void clock_init_sec(void);
 void clock_init_uart(void);
+void sunxi_a733_pcie_soc_init(void);
 #endif
 
 #endif /* _SUNXI_CLOCK_H */
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 517fdcb56ea..21ba3491919 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -331,3 +331,71 @@ unsigned int clock_get_pll6(void)
 
 	return 24000000U * n / m / div1 / div2;
 }
+
+#ifndef CONFIG_XPL_BUILD
+#ifdef CONFIG_MACH_SUN60I_A733
+#define A733_RTC_XO_CTRL1_OFF		0x016c
+#define A733_RTC_XO_CLK_OUT_EN		(BIT(9) | BIT(8) | BIT(5) | BIT(4))
+#define A733_CCU_MBUS_CLK_REG		0x0574
+#define A733_CCU_MBUS_MAT_CLK_GATE_REG	0x0580
+#define A733_CCU_MBUS_MAT_SERDES_EN	(BIT(31) | BIT(30) | BIT(25) | BIT(24))
+#define A733_CCU_MBUS_SERDES_GATE_REG	0x0584
+#define A733_CCU_MBUS_SERDES_CFG_REG	0x0588
+#define A733_CCU_MBUS_CLK_CFG0_REG	0x058c
+#define A733_CCU_MBUS_CLK_CFG1_REG	0x05b4
+#define A733_CCU_PCIE_AXI_SLV_REG	0x1384
+#define A733_CCU_SERDES_PHY_CFG_REG	0x13c0
+#define A733_CCU_CM_PCIE0_MODE_REG	0x1b28
+
+#define A733_SYS_PLL_CTRL_REG		0x02001540UL
+#define A733_SYS_PLL_BGR_REG		0x0200154cUL
+#define A733_NSI_BASE			0x02020000UL
+#define A733_NSI_PORT_STRIDE		0x200UL
+#define A733_NSI_NUM_PORTS		16
+#define A733_PCIE_ITS_AXI_REG		0x08868020UL
+
+/*
+ * Configure SoC-level RTC DCXO feed, CCU muxes/dividers, MBUS/SYS_PLL gates,
+ * PCIe ITS AXI bridge, and NSI QoS not yet modeled by U-Boot's gate-only
+ * sunxi CCU/RTC/NSI drivers.
+ */
+void sunxi_a733_pcie_soc_init(void)
+{
+	void *const rtc = (void *)(ulong)SUNXI_RTC_BASE;
+	void *const ccm = (void *)(ulong)SUNXI_CCM_BASE;
+	int p;
+
+	/* Enable RTC DCXO clock feed to Combo PHY without clobbering siblings */
+	setbits_le32(rtc + A733_RTC_XO_CTRL1_OFF, A733_RTC_XO_CLK_OUT_EN);
+
+	/* Configure PCIe/SerDes CCU muxes/dividers and MBUS/NSI gating */
+	writel(0x82000000, ccm + A733_CCU_PCIE_AXI_SLV_REG); /* 400 MHz */
+	writel(0x81000005, ccm + A733_CCU_SERDES_PHY_CFG_REG); /* 100 MHz */
+	writel(0x00020001, ccm + A733_CCU_CM_PCIE0_MODE_REG);
+	writel(0x00010002, ccm + A733_CCU_MBUS_CLK_REG);
+	setbits_le32(ccm + A733_CCU_MBUS_MAT_CLK_GATE_REG,
+		     A733_CCU_MBUS_MAT_SERDES_EN);
+	writel(0x00010001, ccm + A733_CCU_MBUS_SERDES_GATE_REG);
+	writel(0x81000000, ccm + A733_CCU_MBUS_SERDES_CFG_REG);
+	setbits_le32(ccm + A733_CCU_MBUS_CLK_CFG0_REG, 0x00010007);
+	setbits_le32(ccm + A733_CCU_MBUS_CLK_CFG1_REG, 0x00010007);
+
+	writel(0xc0000000, (void *)(ulong)A733_SYS_PLL_CTRL_REG);
+	writel(0x00010001, (void *)(ulong)A733_SYS_PLL_BGR_REG);
+
+	/* Configure NSI interconnect QoS & bandwidth across ports 0..15 */
+	for (p = 0; p < A733_NSI_NUM_PORTS; p++) {
+		void *port = (void *)(ulong)(A733_NSI_BASE +
+					     A733_NSI_PORT_STRIDE * p);
+
+		writel(0x00000001, port + 0x0c);
+		writel(0x00000001, port + 0x18);
+		writel(0x000003e8, port + 0x28);
+		writel(0x000000ff, port + 0x2c);
+		writel(0x00000001, port + 0xcc);
+	}
+
+	writel(0x00ff00ff, (void *)(ulong)A733_PCIE_ITS_AXI_REG);
+}
+#endif
+#endif
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 5a5229c7068..6b4140ace7d 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -235,6 +235,10 @@ int board_init(void)
 
 	eth_init_board();
 
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733) &&
+	    IS_ENABLED(CONFIG_PCIE_DW_SUNXI))
+		sunxi_a733_pcie_soc_init();
+
 	return 0;
 }
 
diff --git a/drivers/clk/sunxi/clk_a733.c b/drivers/clk/sunxi/clk_a733.c
index 5c942fd5d58..4b0aaa7ab2b 100644
--- a/drivers/clk/sunxi/clk_a733.c
+++ b/drivers/clk/sunxi/clk_a733.c
@@ -20,6 +20,7 @@ static const struct ccu_clk_gate a733_gates[] = {
 	[CLK_APB_UART]		= GATE_DUMMY,
 
 	[CLK_MBUS_GMAC0]	= GATE(0x05e4, BIT(11)),
+	[CLK_MBUS_SERDES]	= GATE(0x0584, BIT(0)),
 	[CLK_BUS_CE]		= GATE(0x0ac4, BIT(0)),
 
 	[CLK_MMC0]		= GATE(0x0d00, BIT(31)),
@@ -71,6 +72,9 @@ static const struct ccu_clk_gate a733_gates[] = {
 	[CLK_BUS_OHCI1]		= GATE(0x130c, BIT(0)),
 	[CLK_BUS_EHCI1]		= GATE(0x130c, BIT(4)),
 
+	[CLK_SERDES_PHY]	= GATE(0x13c0, BIT(31)),
+	[CLK_AHB_SERDES]	= GATE(0x13c4, BIT(0)),
+
 	[CLK_GMAC0_PHY]		= GATE(0x1410, BIT(31)),
 	[CLK_BUS_GMAC0]		= GATE(0x141c, BIT(0)),
 };
@@ -120,6 +124,8 @@ static const struct ccu_reset a733_resets[] = {
 	[RST_BUS_OHCI1]		= RESET(0x130c, BIT(16)),
 	[RST_BUS_EHCI1]		= RESET(0x130c, BIT(20)),
 
+	[RST_BUS_SERDES]	= RESET(0x13c4, BIT(16)),
+
 	[RST_BUS_GMAC0]		= RESET(0x141c, BIT(16)),
 	[RST_BUS_GMAC0_AXI]	= RESET(0x141c, BIT(17)),
 };
diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index bb0bd8d5f81..a408634e35b 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -33,3 +33,11 @@ config PHY_SUN50I_USB3
 	help
 	  Enable this to support the USB3 transceiver that is part of
 	  Allwinner sun50i SoCs.
+
+config PHY_SUN60I_COMBOPHY
+	bool "Allwinner sun60i A733 Combo PHY driver"
+	depends on MACH_SUN60I_A733
+	select PHY
+	help
+	  Enable this to support the Cadence Combo PHY (PCIe / USB3)
+	  on Allwinner sun60i (A733) SoCs.
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index f2b60ce1a64..84c653db53a 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
+obj-$(CONFIG_PHY_SUN60I_COMBOPHY)	+= phy-sun60i-combophy.o
diff --git a/drivers/phy/allwinner/phy-sun60i-combophy.c b/drivers/phy/allwinner/phy-sun60i-combophy.c
new file mode 100644
index 00000000000..0e3128ab0ed
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun60i-combophy.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner A733 (sun60i) Cadence Combo PHY driver
+ *
+ * Copyright (c) 2026 Armbian Project
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dt-bindings/phy/phy.h>
+#include <generic-phy.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <reset.h>
+#include <asm/io.h>
+
+/* SerDes subsystem register offsets (relative to serdes base) */
+#define SERDES_PCIE_BGR_REG		0x0004
+#define SERDES_PCIE_BGR_DEASSERT	(BIT(18) | BIT(17) | BIT(16) | \
+					 BIT(1) | BIT(0))
+#define SERDES_CTRL0_REG		0x0010
+#define SERDES_CTRL0_PCIE_EN		BIT(0)
+#define SERDES_PCIE_APP_SUB_CTRL_REG	0x0020
+#define SERDES_PCIE_APP_CLK_EN		BIT(0)
+#define SERDES_CTRL1_REG		0x00f0
+#define SERDES_CTRL1_PCIE_MODE		(BIT(29) | BIT(10))
+#define SERDES_PCIE_ITS_TAGT_ADDR_REG	0x0220
+#define SERDES_PCIE_ITS_TAGT_DEFAULT	0x00000345
+#define SERDES_AXI2TO1_TH_REG		0x0300
+#define SERDES_AXI2TO1_TH_DEFAULT	0x00ff00ff
+#define SERDES_COMB1_PIPE_REG		0x6c44
+#define SERDES_COMB1_PIPE_PCIE_SEL	BIT(0)
+
+/* Combo PHY1 Top register offsets (serdes base + 0x2000) */
+#define COMBOPHY_TOP_OFFSET		0x2000
+#define COMBOPHY_LINK_RST_REG		0x0000
+#define COMBOPHY_LINK_RST_N		BIT(0)
+#define COMBOPHY_CLK_CTRL_REG		0x0004
+#define COMBOPHY_CLK_REF_EN		(BIT(24) | BIT(20) | BIT(0))
+#define COMBOPHY_CLK_PIPE_OUT_EN	BIT(28)
+#define COMBOPHY_LANE0_RST_REG		0x0100
+#define COMBOPHY_LANE0_PCIE_RST_N	BIT(0)
+#define COMBOPHY_PLL_STATUS_REG		0x0900
+#define COMBOPHY_PLL_LOCK_BIT		BIT(0)
+
+/* Combo PHY1 Analog register offsets */
+#define COMBOPHY_ANALOG_TX_CTRL0	0x0098
+#define COMBOPHY_ANALOG_TX_CTRL1	0x00a0
+#define COMBOPHY_ANALOG_TX_CTRL2	0x00a8
+#define COMBOPHY_ANALOG_TX_CTRL3	0x00d8
+#define COMBOPHY_ANALOG_TX_IDLE_MODE	0x0002
+#define COMBOPHY_ANALOG_TX_POST_PLL	0x0270
+#define COMBOPHY_ANALOG_TX_EN_BIT	BIT(4)
+#define COMBOPHY_ANALOG_EXT_OFFSET	0x18000
+
+struct sun60i_combophy_priv {
+	void __iomem *serdes_base;
+	void __iomem *top_base;
+	void __iomem *phy_base;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk rsts;
+};
+
+struct phy_reg_val {
+	u32 off;
+	u16 val;
+};
+
+/*
+ * Vendor-characterized Cadence Combo PHY analog/PLL/CDR register tuning table
+ * for PCIe Gen3 (8.0 GT/s) operation on Allwinner A733.
+ */
+static const struct phy_reg_val cphy_analog_regs[] = {
+	{ 0x44, 0x1a },
+	{ 0x54, 0x34 }, { 0x58, 0xda },
+	{ 0x64, 0x34 }, { 0x68, 0xda },
+	{ 0xc8, 0x82 }, { 0xca, 0x82 },
+	{ 0xe8, 0x1a },
+	{ 0x208, 0x20 }, { 0x20a, 0x7 },
+	{ 0x218, 0x20 }, { 0x21a, 0x7 },
+	{ 0x228, 0x30c }, { 0x22a, 0x7 },
+	{ 0x248, 0x7 }, { 0x24a, 0x3 }, { 0x24c, 0xf }, { 0x250, 0x132 },
+	{ 0x8180, 0x208 }, { 0x8184, 0x9c },
+	{ 0x10088, 0x1a }, { 0x1008a, 0x82 },
+	{ 0x10098, 0x1a }, { 0x1009a, 0x82 },
+	{ 0x8246, 0xa28 },
+	{ 0x128, 0x4 }, { 0x148, 0x4 }, { 0x1a8, 0x4 },
+	{ 0x348, 0x509 }, { 0x368, 0x509 }, { 0x388, 0x509 },
+	{ 0x34a, 0xf00 }, { 0x36a, 0xf00 }, { 0x38a, 0xf00 },
+	{ 0x34c, 0xf08 }, { 0x36c, 0xf08 }, { 0x38c, 0xf08 },
+	{ 0x120, 0x180 }, { 0x140, 0x133 }, { 0x1a0, 0x133 },
+	{ 0x122, 0x9d8a }, { 0x142, 0xb13b }, { 0x1a2, 0xb13b },
+	{ 0x124, 0x2 }, { 0x144, 0x2 }, { 0x1a4, 0x2 },
+	{ 0x126, 0x102 }, { 0x146, 0xce }, { 0x1a6, 0xce },
+	{ 0x340, 0x22 }, { 0x360, 0x22 }, { 0x380, 0x22 },
+	{ 0x130, 0x1 }, { 0x150, 0x1 }, { 0x1b0, 0x1 },
+	{ 0x132, 0x45f }, { 0x152, 0x2f0 }, { 0x1b2, 0x399 },
+	{ 0x134, 0x6b }, { 0x154, 0x68 }, { 0x1b4, 0x68 },
+	{ 0x136, 0x4 }, { 0x156, 0x4 }, { 0x1b6, 0x4 },
+	{ 0x108, 0x104 }, { 0x188, 0x104 },
+	{ 0x10a, 0x5 }, { 0x18a, 0x5 },
+	{ 0x10c, 0x337 }, { 0x18c, 0x337 },
+	{ 0x110, 0x3dbe }, { 0x190, 0x3dbe },
+	{ 0x104, 0x3 }, { 0x184, 0x3 },
+	{ 0x138, 0x14 }, { 0x1b8, 0x14 },
+	{ 0x13c, 0x192 }, { 0x1bc, 0x192 },
+	{ 0x13e, 0x6 }, { 0x1be, 0x6 },
+	{ 0x103c0, 0x0 },
+	{ 0x102e2, 0x19 }, { 0x102e4, 0x19 },
+	{ 0x103fe, 0x1 },
+};
+
+static int sun60i_combophy_xlate(struct phy *phy,
+				 struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	if (args->args[0] != PHY_TYPE_PCIE) {
+		dev_err(phy->dev, "Unsupported PHY type %u\n", args->args[0]);
+		return -EINVAL;
+	}
+
+	phy->id = args->args[0];
+
+	return 0;
+}
+
+static int sun60i_combophy_init(struct phy *phy)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(phy->dev);
+	int ret;
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
+		return ret;
+
+	ret = reset_deassert_bulk(&priv->rsts);
+	if (ret) {
+		clk_disable_bulk(&priv->clks);
+		return ret;
+	}
+
+	/* Configure SerDes subsystem for PCIe */
+	writel(SERDES_PCIE_BGR_DEASSERT, priv->serdes_base + SERDES_PCIE_BGR_REG);
+	writel(SERDES_CTRL0_PCIE_EN, priv->serdes_base + SERDES_CTRL0_REG);
+	writel(SERDES_PCIE_APP_CLK_EN,
+	       priv->serdes_base + SERDES_PCIE_APP_SUB_CTRL_REG);
+	writel(SERDES_CTRL1_PCIE_MODE, priv->serdes_base + SERDES_CTRL1_REG);
+	writel(SERDES_COMB1_PIPE_PCIE_SEL,
+	       priv->serdes_base + SERDES_COMB1_PIPE_REG);
+	writel(SERDES_PCIE_ITS_TAGT_DEFAULT,
+	       priv->serdes_base + SERDES_PCIE_ITS_TAGT_ADDR_REG);
+	writel(SERDES_AXI2TO1_TH_DEFAULT,
+	       priv->serdes_base + SERDES_AXI2TO1_TH_REG);
+
+	return 0;
+}
+
+static int sun60i_combophy_exit(struct phy *phy)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(phy->dev);
+
+	reset_assert_bulk(&priv->rsts);
+	clk_disable_bulk(&priv->clks);
+
+	return 0;
+}
+
+static int sun60i_combophy_power_on(struct phy *phy)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(phy->dev);
+	u32 val;
+	int i, ret;
+
+	writel(COMBOPHY_CLK_REF_EN, priv->top_base + COMBOPHY_CLK_CTRL_REG);
+
+	for (i = 0; i < ARRAY_SIZE(cphy_analog_regs); i++)
+		writew(cphy_analog_regs[i].val,
+		       priv->phy_base + cphy_analog_regs[i].off);
+
+	writew(COMBOPHY_ANALOG_TX_IDLE_MODE,
+	       priv->phy_base + COMBOPHY_ANALOG_TX_CTRL0);
+	writew(COMBOPHY_ANALOG_TX_IDLE_MODE,
+	       priv->phy_base + COMBOPHY_ANALOG_TX_CTRL2);
+	writew(COMBOPHY_ANALOG_TX_IDLE_MODE,
+	       priv->phy_base + COMBOPHY_ANALOG_TX_CTRL3);
+
+	/* Deassert link & lane 0 reset with Lane 0 Mode = PCIe */
+	writel(COMBOPHY_LINK_RST_N, priv->top_base + COMBOPHY_LINK_RST_REG);
+	writel(COMBOPHY_LANE0_PCIE_RST_N,
+	       priv->top_base + COMBOPHY_LANE0_RST_REG);
+
+	ret = readl_poll_timeout(priv->top_base + COMBOPHY_PLL_STATUS_REG, val,
+				 (val & COMBOPHY_PLL_LOCK_BIT), 50000);
+	if (ret) {
+		dev_err(phy->dev, "Combo PHY PLL lock timeout (val=0x%08x)\n",
+			val);
+		return ret;
+	}
+
+	/* Post PLL lock setup */
+	writew(COMBOPHY_ANALOG_TX_POST_PLL,
+	       priv->phy_base + COMBOPHY_ANALOG_TX_CTRL1);
+	writew(readw(priv->phy_base + COMBOPHY_ANALOG_TX_CTRL0) |
+	       COMBOPHY_ANALOG_TX_EN_BIT,
+	       priv->phy_base + COMBOPHY_ANALOG_TX_CTRL0);
+	writew(0x0001, priv->phy_base + COMBOPHY_ANALOG_EXT_OFFSET);
+	writel(COMBOPHY_CLK_REF_EN | COMBOPHY_CLK_PIPE_OUT_EN,
+	       priv->top_base + COMBOPHY_CLK_CTRL_REG);
+
+	return 0;
+}
+
+static int sun60i_combophy_power_off(struct phy *phy)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(phy->dev);
+
+	writel(0x0, priv->top_base + COMBOPHY_LANE0_RST_REG);
+	writel(0x0, priv->top_base + COMBOPHY_LINK_RST_REG);
+
+	return 0;
+}
+
+static int sun60i_combophy_of_to_plat(struct udevice *dev)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(dev);
+
+	priv->serdes_base = dev_read_addr_name_ptr(dev, "serdes");
+	if (!priv->serdes_base)
+		return -EINVAL;
+
+	priv->top_base = priv->serdes_base + COMBOPHY_TOP_OFFSET;
+
+	priv->phy_base = dev_read_addr_name_ptr(dev, "phy");
+	if (!priv->phy_base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sun60i_combophy_probe(struct udevice *dev)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret)
+		return ret;
+
+	ret = reset_get_bulk(dev, &priv->rsts);
+	if (ret) {
+		clk_release_bulk(&priv->clks);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sun60i_combophy_remove(struct udevice *dev)
+{
+	struct sun60i_combophy_priv *priv = dev_get_priv(dev);
+
+	reset_release_bulk(&priv->rsts);
+	clk_release_bulk(&priv->clks);
+
+	return 0;
+}
+
+static const struct phy_ops sun60i_combophy_ops = {
+	.of_xlate	= sun60i_combophy_xlate,
+	.init		= sun60i_combophy_init,
+	.exit		= sun60i_combophy_exit,
+	.power_on	= sun60i_combophy_power_on,
+	.power_off	= sun60i_combophy_power_off,
+};
+
+static const struct udevice_id sun60i_combophy_ids[] = {
+	{ .compatible = "allwinner,sun60i-a733-combophy" },
+	{ }
+};
+
+U_BOOT_DRIVER(sun60i_combophy) = {
+	.name		= "sun60i_combophy",
+	.id		= UCLASS_PHY,
+	.of_match	= sun60i_combophy_ids,
+	.ops		= &sun60i_combophy_ops,
+	.of_to_plat	= sun60i_combophy_of_to_plat,
+	.probe		= sun60i_combophy_probe,
+	.remove		= sun60i_combophy_remove,
+	.priv_auto	= sizeof(struct sun60i_combophy_priv),
+};
-- 
2.53.0

