Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E3AD46C15
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 00:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F11883BC7;
	Thu, 29 Jan 2026 01:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FF983C29; Thu, 29 Jan 2026 00:59:20 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0180383BB1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 00:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 2369F1F8004F
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 23:59:17 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 76346B1D48A; Wed, 28 Jan 2026 23:59:16 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id B55A9B1D47F;
 Wed, 28 Jan 2026 23:58:38 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH v2 1/3] sunxi: a133: dram: Add NSI arbiter configuration
 support
Date: Thu, 29 Jan 2026 00:57:15 +0100
Message-ID: <20260128235727.1322861-1-contact@paulk.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Jan 2026 01:07:58 +0100
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

From: Paul Kocialkowski <paulk@sys-base.io>

In previous generations of Allwinner SoCs, the memory bus (MBUS) access
arbitration was configured as part of the DRAM top registers. This is no
longer the case starting with the A133, which has a dedicated base
address for the bus arbiter that is now called NSI instead of MBUS.

NSI appears to be a later iteration of MBUS design, with new dedicated
registers that resemble the previous MBUS ones. Despite NSI not being
documented in the manual, the A133 BSP includes a nsi driver with some
description of the registers. Like previous generations, it implements
port arbitration priority for DRAM access and also supports an optional
QoS mode based on bandwidth limits.

Configuring port arbitration priority is especially important to make
sure that critical masters are not starved by other less important
ones. This is especially the case with the display engine that needs
to be able to fetch pixels in time for scanout and can easily be
starved by CPU or GPU access.

This introduces support for the NSI arbiter in the A133 DRAM init
code. The list and order of available ports are highly SoC-specific
and the default config values are set to match the BSP's defaults.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>
---
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  4 ++
 .../include/asm/arch-sunxi/dram_sun50i_a133.h | 36 ++++++++++
 arch/arm/mach-sunxi/dram_sun50i_a133.c        | 67 ++++++++++++++++++-
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index 2a9b086991c3..8e80c520706b 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -16,6 +16,10 @@
 
 #define SUNXI_GIC400_BASE		0x03020000
 
+#ifdef CONFIG_MACH_SUN50I_A133
+#define SUNXI_NSI_BASE			0x03100000
+#endif
+
 #ifdef CONFIG_MACH_SUN50I_H6
 #define SUNXI_DRAM_COM_BASE		0x04002000
 #define SUNXI_DRAM_CTL0_BASE		0x04003000
diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
index a5fc6ad36560..eadec74cc2b6 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
@@ -24,6 +24,42 @@ static inline int ns_to_t(int nanoseconds)
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
+#define SUNXI_NSI_MODE_REG(i)		((i) * 0x200 + 0x10)
+#define SUNXI_NSI_PRI_CFG_REG(i)	((i) * 0x200 + 0x14)
+#define SUNXI_NSI_PRI_CFG_RD(v)		(((v) & 0x3) << 2)
+#define SUNXI_NSI_PRI_CFG_WR(v)		((v) & 0x3)
+#define SUNXI_NSI_PRI_CFG_LOWEST	0
+#define SUNXI_NSI_PRI_CFG_LOW		1
+#define SUNXI_NSI_PRI_CFG_HIGH		2
+#define SUNXI_NSI_PRI_CFG_HIGHEST	3
+#define SUNXI_NSI_IO_CFG_REG(i)		((i) * 0x200 + 0x18)
+#define SUNXI_NSI_IO_CFG_QOS_SEL_OUTPUT	0
+#define SUNXI_NSI_IO_CFG_QOS_SEL_INPUT	1
+#define SUNXI_NSI_ENABLE_REG(i)		((i) * 0x200 + 0xc0)
+
+enum sunxi_nsi_port {
+	SUNXI_NSI_PORT_CPU	= 0,
+	SUNXI_NSI_PORT_GPU,
+	SUNXI_NSI_PORT_SD1,
+	SUNXI_NSI_PORT_MSTG,
+	SUNXI_NSI_PORT_GMAC0,
+	SUNXI_NSI_PORT_GMAC1,
+	SUNXI_NSI_PORT_USB0,
+	SUNXI_NSI_PORT_USB1,
+	SUNXI_NSI_PORT_NDFC,
+	SUNXI_NSI_PORT_DMAC,
+	SUNXI_NSI_PORT_CE,
+	SUNXI_NSI_PORT_DE0,
+	SUNXI_NSI_PORT_DE1,
+	SUNXI_NSI_PORT_VE,
+	SUNXI_NSI_PORT_CSI,
+	SUNXI_NSI_PORT_ISP,
+	SUNXI_NSI_PORT_G2D,
+	SUNXI_NSI_PORT_EINK,
+	SUNXI_NSI_PORT_IOMMU,
+	SUNXI_NSI_PORT_CPUS,
+};
+
 /* MBUS part is largely the same as in H6, except for one special register */
 #define MCTL_COM_UNK_008	0x008
 /* NOTE: This register has the same importance as mctl_ctl->clken in H616 */
diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
index 1496f99624dd..204810aecf2a 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
@@ -69,6 +69,66 @@ static const u8 phy_init[] = {
 };
 #endif
 
+static void nsi_configure_port(unsigned int port, u8 pri, u8 qos_sel)
+{
+	void *base = (void *)SUNXI_NSI_BASE;
+	u32 pri_cfg;
+
+	/* QoS with bandwidth limits is not supported, disable it. */
+	writel(0, base + SUNXI_NSI_MODE_REG(port));
+	writel(0, base + SUNXI_NSI_ENABLE_REG(port));
+
+	/*
+	 * QoS direction selection should not be in use, but set it nevertheless
+	 * to match the BSP behavior (in case it has some other meaning).
+	 */
+	writel(qos_sel, base + SUNXI_NSI_IO_CFG_REG(port));
+
+	/* Port priority is always active. */
+	pri_cfg = SUNXI_NSI_PRI_CFG_RD(pri) | SUNXI_NSI_PRI_CFG_WR(pri);
+
+	writel(pri_cfg, base + SUNXI_NSI_PRI_CFG_REG(port));
+}
+
+#define NSI_CONF(port, pri, qos_sel) \
+	{ SUNXI_NSI_PORT_ ## port, SUNXI_NSI_PRI_CFG_ ## pri, \
+	  SUNXI_NSI_IO_CFG_QOS_SEL_ ## qos_sel }
+
+static void nsi_set_master_priority(void)
+{
+	struct {
+		unsigned int port;
+		u8 pri;
+		u8 qos_sel;
+	} ports[] = {
+		NSI_CONF(CPU,	LOWEST,		INPUT),
+		NSI_CONF(GPU,	LOWEST,		INPUT),
+		NSI_CONF(SD1,	LOWEST,		OUTPUT),
+		NSI_CONF(MSTG,	LOWEST,		OUTPUT),
+		NSI_CONF(GMAC0,	LOWEST,		OUTPUT),
+		NSI_CONF(GMAC1,	LOWEST,		OUTPUT),
+		NSI_CONF(USB0,	LOWEST,		OUTPUT),
+		NSI_CONF(USB1,	LOWEST,		OUTPUT),
+		NSI_CONF(NDFC,	LOWEST,		OUTPUT),
+		NSI_CONF(DMAC,	LOWEST,		OUTPUT),
+		NSI_CONF(CE,	LOWEST,		OUTPUT),
+		NSI_CONF(DE0,	HIGH,		INPUT),
+		NSI_CONF(DE1,	HIGH,		INPUT),
+		NSI_CONF(VE,	LOWEST,		INPUT),
+		NSI_CONF(CSI,	HIGH,		INPUT),
+		NSI_CONF(ISP,	HIGH,		INPUT),
+		NSI_CONF(G2D,	LOWEST,		INPUT),
+		NSI_CONF(EINK,	LOWEST,		OUTPUT),
+		NSI_CONF(IOMMU,	HIGHEST,	INPUT),
+		NSI_CONF(CPUS,	LOWEST,		OUTPUT),
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ports); i++)
+		nsi_configure_port(ports[i].port, ports[i].pri,
+				   ports[i].qos_sel);
+}
+
 static void mctl_clk_init(u32 clk)
 {
 	void * const ccm = (void *)SUNXI_CCM_BASE;
@@ -1184,6 +1244,7 @@ static const struct dram_para para = {
 unsigned long sunxi_dram_init(void)
 {
 	struct dram_config config;
+	unsigned long size;
 
 	/* Writing to undocumented SYS_CFG area, according to user manual. */
 	setbits_le32(0x03000160, BIT(8));
@@ -1200,5 +1261,9 @@ unsigned long sunxi_dram_init(void)
 	      1U << config.bankgrps, 1U << config.ranks,
 	      16U << config.bus_full_width);
 
-	return calculate_dram_size(&config);
+	size = calculate_dram_size(&config);
+
+	nsi_set_master_priority();
+
+	return size;
 }
-- 
2.52.0

