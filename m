Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9440FFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 13:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16F0842C7;
	Thu, 30 Apr 2026 15:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iKBHjy6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E6B8063E; Thu, 30 Apr 2026 15:58:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 78D32803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50BD632C5;
 Thu, 30 Apr 2026 06:58:41 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A820E3F7B4;
 Thu, 30 Apr 2026 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777557526; bh=drWJpcSE0TJcdgZ7vlQSxAWArtbiJCMXBwRn1bvPmw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iKBHjy6JZRmicJsCA62Twj3XuO1tTyKwIqbE4Z6vTZ/n2JfeI6P/Doa5znWhhXeGQ
 MxvcF2wX7aYyAaZiQxBX93gDpLpXjjEvRAAREle85SnVrqdYyqKHEGXsWDze8+/Xfi
 unBKwiimiweyqsyVlwqEl2Wc66EWofDHtiOwFPZ8=
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <paulk@sys-base.io>,
	u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/2] sunxi: A133: dram: Add NSI arbiter configuration
 support
Date: Thu, 30 Apr 2026 15:58:38 +0200
Message-ID: <20260430135838.3438728-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430135838.3438728-1-andre.przywara@arm.com>
References: <20260430135838.3438728-1-andre.przywara@arm.com>
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

From: Paul Kocialkowski <contact@paulk.fr>

The Allwinner DRAM controllers contains logic to assign priorities to
various DRAM DMA masters. Configuring this DRAM port arbitration priority
correctly is important to make sure that critical masters are not starved
by other less important ones. This is especially the case with the display
engine that needs to be able to fetch pixels in time for scanout and can
easily be starved by CPU or GPU access.

Add support for configuring the NSI arbiter in the A133 DRAM init code,
using the recently refactored NSI code already used on the A523.
The list and order of available ports are highly SoC-specific and the
default config values are set to match the BSP's defaults.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
[Andre: using new generic NSI function]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>
---
 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  4 ++
 .../include/asm/arch-sunxi/dram_sun50i_a133.h | 23 ++++++++++
 arch/arm/mach-sunxi/Makefile                  |  2 +-
 arch/arm/mach-sunxi/dram_sun50i_a133.c        | 43 ++++++++++++++++++-
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index b0f2d3f4656..c31437f9acc 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -17,6 +17,10 @@
 
 #define SUNXI_GIC400_BASE		0x03020000
 
+#ifdef CONFIG_MACH_SUN50I_A133
+#define SUNXI_NSI_BASE			0x03100000
+#endif
+
 #ifdef CONFIG_MACH_SUN50I_H6
 #define SUNXI_DRAM_COM_BASE		0x04002000
 #define SUNXI_DRAM_CTL0_BASE		0x04003000
diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
index 01f2214cd15..1e8e0f7ab96 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
@@ -24,6 +24,29 @@ static inline int ns_to_t(int nanoseconds)
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
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
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 3ef0113ea43..30cce7d1784 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o dram_dw_helpers.o
 obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_timings/
 obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o dram_dw_helpers.o
 obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
-obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
+obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o sunxi_nsi.o
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
 obj-$(CONFIG_MACH_SUN55I_A523)	+= dram_sun55i_a523.o dram_dw_helpers.o sunxi_nsi.o
 obj-$(CONFIG_DRAM_SUN55I_A523)	+= dram_timings/
diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
index ca3e2513c69..433044e1e2b 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
@@ -21,6 +21,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/prcm.h>
+#include <asm/arch/sunxi_nsi.h>
 #include <asm/io.h>
 #include <init.h>
 #include <linux/bitops.h>
@@ -69,6 +70,41 @@ static const u8 phy_init[] = {
 };
 #endif
 
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
@@ -1205,6 +1241,7 @@ static const struct dram_para para = {
 unsigned long sunxi_dram_init(void)
 {
 	struct dram_config config;
+	unsigned long size;
 
 	/* Writing to undocumented SYS_CFG area, according to user manual. */
 	setbits_le32(0x03000160, BIT(8));
@@ -1221,5 +1258,9 @@ unsigned long sunxi_dram_init(void)
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
2.43.0

