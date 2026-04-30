Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74178CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 13:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B628980433;
	Thu, 30 Apr 2026 15:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mSmgcfT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37C384099; Thu, 30 Apr 2026 15:58:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0C0718063E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD3CD2BC6;
 Thu, 30 Apr 2026 06:58:39 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420B73F7B4;
 Thu, 30 Apr 2026 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777557525; bh=MutLqy9KZffmQ7ohGHiXKCRGLj2Fjx+hy8pXMXys4bs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mSmgcfT20ZIleBlrXS11zki6jkzXXqB89CO6qfp02QJ09G9a/b++lMKXC2Bf+9WpU
 XOaVNfFxq3u7jg+K2xpdfIvCKdWfg7GpQ9jmMxYuAZ0ae4eg94sIrc4OKVyPR2NvJj
 v0dc77gY4Z4iuljMLDZTsYs9J4cX9qk54eoG6mmw=
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <paulk@sys-base.io>,
	u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/2] sunxi: A523: Move NSI init routine into generic
 function
Date: Thu, 30 Apr 2026 15:58:37 +0200
Message-ID: <20260430135838.3438728-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430135838.3438728-1-andre.przywara@arm.com>
References: <20260430135838.3438728-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In previous generations of Allwinner SoCs, the memory bus (MBUS) access
arbitration was configured as part of the DRAM top registers. This is no
longer the case with for instance the A133 or A523, which have a dedicated
base address for the bus arbiter that is now called NSI instead of MBUS.

NSI appears to be a later iteration of MBUS design, with new dedicated
registers that resemble the previous MBUS ones. Despite NSI not being
documented in the manual, the A133 BSP includes a nsi driver with some
description of the registers. Like previous generations, it implements
port arbitration priority for DRAM access and also supports an optional
QoS mode based on bandwidth limits.

In preparation for re-using code for other SoCs, factor out the existing
NSI init routine from the A523 DRAM code, which was a bit ad-hoc and A523
specific, into a separate function, and abstract the settings a bit.
No functional change.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Co-develeoped-by: Paul Kocialkowski <paulk@sys-base.io>
Suggested-by: Jernej Škrabec <jernej.skrabec@gmail.com>
Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>
---
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |  1 +
 .../include/asm/arch-sunxi/dram_sun55i_a523.h | 29 +++++++++++
 arch/arm/include/asm/arch-sunxi/sunxi_nsi.h   | 25 ++++++++++
 arch/arm/mach-sunxi/Makefile                  |  2 +-
 arch/arm/mach-sunxi/dram_sun55i_a523.c        | 49 +++++++++----------
 arch/arm/mach-sunxi/sunxi_nsi.c               | 31 ++++++++++++
 6 files changed, 110 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/sunxi_nsi.h
 create mode 100644 arch/arm/mach-sunxi/sunxi_nsi.c

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index 7cee7efe8b4..fd7d9b22058 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -9,6 +9,7 @@
 
 #define SUNXI_TZPC_BASE			0x02000800
 #define SUNXI_CCM_BASE			0x02001000
+#define SUNXI_NSI_BASE			0x02020000
 #define SUNXI_TIMER_BASE		0x02050000
 
 #define SUNXI_TWI0_BASE			0x02502000
diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h b/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
index 08bfe462856..462d4726a21 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
@@ -20,6 +20,35 @@ enum sunxi_dram_type {
 #define MCTL_COM_UNK_008        0x008
 #define MCTL_COM_MAER0          0x020
 
+enum sunxi_nsi_port {
+	SUNXI_NSI_PORT_GPU      = 0,
+	SUNXI_NSI_PORT_GIC,	= 1,
+	SUNXI_NSI_PORT_USB3,	= 2,
+	SUNXI_NSI_PORT_PCIE,	= 3,
+	SUNXI_NSI_PORT_CE,	= 4,
+	SUNXI_NSI_PORT_NPU,	= 5,
+	SUNXI_NSI_PORT_ISP,	= 6,
+	SUNXI_NSI_PORT_DSP,	= 7,
+	SUNXI_NSI_PORT_G2D,	= 8,
+	SUNXI_NSI_PORT_DI,	= 9,
+	SUNXI_NSI_PORT_IOMMU,	= 10,
+	SUNXI_NSI_PORT_VE_R,	= 11,
+	SUNXI_NSI_PORT_VE_RW,	= 12,
+	SUNXI_NSI_PORT_DE,	= 13,
+	SUNXI_NSI_PORT_CSI,	= 14,
+	SUNXI_NSI_PORT_GMAC0,	= 18,
+	SUNXI_NSI_PORT_GMAC1,	= 19,
+	SUNXI_NSI_PORT_MMC0,	= 20,
+	SUNXI_NSI_PORT_MMC1,	= 21,
+	SUNXI_NSI_PORT_MMC2,	= 22,
+	SUNXI_NSI_PORT_USB0,	= 23,
+	SUNXI_NSI_PORT_USB1,	= 24,
+	SUNXI_NSI_PORT_USB2,	= 25,
+	SUNXI_NSI_PORT_NPD,	= 26,
+	SUNXI_NSI_PORT_DMAC,	= 27,
+	SUNXI_NSI_PORT_DMA,	= 28,
+};
+
 /*
  * Controller registers seems to be the same or at least very similar
  * to those in H6.
diff --git a/arch/arm/include/asm/arch-sunxi/sunxi_nsi.h b/arch/arm/include/asm/arch-sunxi/sunxi_nsi.h
new file mode 100644
index 00000000000..7d41f9318b5
--- /dev/null
+++ b/arch/arm/include/asm/arch-sunxi/sunxi_nsi.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier:	GPL-2.0+
+/*
+ * A133/A523 NSI interconnect register and constant defines
+ *
+ * (C) Copyright 2026 Arm Ltd.
+ */
+
+#ifndef SUNXI_NSI_H__
+#define SUNXI_NSI_H__
+
+#define SUNXI_NSI_PRI_CFG_LOWEST	0
+#define SUNXI_NSI_PRI_CFG_LOW		1
+#define SUNXI_NSI_PRI_CFG_HIGH		2
+#define SUNXI_NSI_PRI_CFG_HIGHEST	3
+
+#define SUNXI_NSI_IO_CFG_QOS_SEL_OUTPUT	0
+#define SUNXI_NSI_IO_CFG_QOS_SEL_INPUT	1
+
+#define NSI_CONF(port, pri, qos_sel) \
+	{ SUNXI_NSI_PORT_ ## port, SUNXI_NSI_PRI_CFG_ ## pri, \
+	  SUNXI_NSI_IO_CFG_QOS_SEL_ ## qos_sel }
+
+void nsi_configure_port(unsigned int port, u8 pri, u8 qos_sel);
+
+#endif /* SUNXI_NSI_H__ */
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 0bee04d660f..3ef0113ea43 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -50,6 +50,6 @@ obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o dram_dw_helpers.o
 obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
-obj-$(CONFIG_MACH_SUN55I_A523)	+= dram_sun55i_a523.o dram_dw_helpers.o
+obj-$(CONFIG_MACH_SUN55I_A523)	+= dram_sun55i_a523.o dram_dw_helpers.o sunxi_nsi.o
 obj-$(CONFIG_DRAM_SUN55I_A523)	+= dram_timings/
 endif
diff --git a/arch/arm/mach-sunxi/dram_sun55i_a523.c b/arch/arm/mach-sunxi/dram_sun55i_a523.c
index 1ffb62863e2..9fb054cea84 100644
--- a/arch/arm/mach-sunxi/dram_sun55i_a523.c
+++ b/arch/arm/mach-sunxi/dram_sun55i_a523.c
@@ -15,6 +15,7 @@
 #include <asm/arch/dram_dw_helpers.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/prcm.h>
+#include <asm/arch/sunxi_nsi.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
@@ -1412,40 +1413,36 @@ static const struct dram_para para = {
 	.tpr10 = CONFIG_DRAM_SUNXI_TPR10,
 };
 
-static void sunxi_nsi_init(void)
+static void nsi_set_master_priority(void)
 {
-	/* IOMMU prio 3 */
-	writel(0x1, 0x02021418);
-	writel(0xf, 0x02021414);
-	/* DE prio 2 */
-	writel(0x1, 0x02021a18);
-	writel(0xa, 0x02021a14);
-	/* VE R prio 2 */
-	writel(0x1, 0x02021618);
-	writel(0xa, 0x02021614);
-	/* VE RW prio 2 */
-	writel(0x1, 0x02021818);
-	writel(0xa, 0x02021814);
-	/* ISP prio 2 */
-	writel(0x1, 0x02020c18);
-	writel(0xa, 0x02020c14);
-	/* CSI prio 2 */
-	writel(0x1, 0x02021c18);
-	writel(0xa, 0x02021c14);
-	/* NPU prio 2 */
-	writel(0x1, 0x02020a18);
-	writel(0xa, 0x02020a14);
+	struct {
+		unsigned int port;
+		u8 pri;
+		u8 qos_sel;
+	} ports[] = {
+		NSI_CONF(NPU,	HIGH,		INPUT),
+		NSI_CONF(ISP,	HIGH,		INPUT),
+		NSI_CONF(IOMMU,	HIGHEST,	INPUT),
+		NSI_CONF(VE_R,	HIGH,		INPUT),
+		NSI_CONF(VE_RW,	HIGH,		INPUT),
+		NSI_CONF(DE,	HIGH,		INPUT),
+		NSI_CONF(CSI,	HIGH,		INPUT),
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ports); i++)
+		nsi_configure_port(ports[i].port, ports[i].pri,
+				   ports[i].qos_sel);
 
 	/* close ra0 autogating */
-	writel(0x0, 0x02023c00);
+	writel(0x0, 0x02023c00);	/* port 30 */
 	/* close ta autogating */
-	writel(0x0, 0x02023e00);
+	writel(0x0, 0x02023e00);	/* port 31 */
 	/* close pcie autogating */
 	writel(0x0, 0x02020600);
 }
 
 static void init_something(void)
-
 {
 	u32 *ptr = (u32 *)0x02000804;
 
@@ -1507,7 +1504,7 @@ unsigned long sunxi_dram_init(void)
 
 	size = mctl_calc_size(&config);
 
-	sunxi_nsi_init();
+	nsi_set_master_priority();
 	init_something();
 
 	return size;
diff --git a/arch/arm/mach-sunxi/sunxi_nsi.c b/arch/arm/mach-sunxi/sunxi_nsi.c
new file mode 100644
index 00000000000..3d7eb43df46
--- /dev/null
+++ b/arch/arm/mach-sunxi/sunxi_nsi.c
@@ -0,0 +1,31 @@
+#include <asm/io.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/sunxi_nsi.h>
+
+#define SUNXI_NSI_MODE_REG(i)		((i) * 0x200 + 0x10)
+#define SUNXI_NSI_PRI_CFG_REG(i)	((i) * 0x200 + 0x14)
+#define SUNXI_NSI_PRI_CFG_RD(v)		(((v) & 0x3) << 2)
+#define SUNXI_NSI_PRI_CFG_WR(v)		((v) & 0x3)
+#define SUNXI_NSI_IO_CFG_REG(i)		((i) * 0x200 + 0x18)
+#define SUNXI_NSI_ENABLE_REG(i)		((i) * 0x200 + 0xc0)
+
+void nsi_configure_port(unsigned int port, u8 pri, u8 qos_sel)
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
-- 
2.43.0

