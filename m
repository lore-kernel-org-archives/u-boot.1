Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C615CD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D4F8432A;
	Fri,  1 May 2026 00:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="1kZilvMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16F284198; Fri,  1 May 2026 00:33:46 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803478432A
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=D64yMnijWbHgGWDWA/CqZFKx5yQYF/sP68dY4oYva+8=;
 b=1kZilvMAipPhhX/1fQoCGDduRHy3lmjutX5OCP2l0aupUc81+61l3+rHyfDzbVNCYEcx5pwOZbLSJGaD+k5byh5Lq3XhsFzDRxnkYhG7plpsp/mr3VuDQNYcBjvD93WpuaM3DBx5wFP2l3L/1u2vNjDf3pocXk99tcpzNQOTZBY=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Fri, 1 May 2026 00:33:44 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/6] sunxi: add SPC setup for R528/T113 secure boot handoff
Date: Fri,  1 May 2026 00:33:02 +0200
Message-ID: <20260430223319.2663939-4-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430223319.2663939-1-lukas.schmid@netcube.li>
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
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

The R528/T113 family protects peripheral access through the SPC, and
also uses security switch registers in the CCU, PRCM and DMA
controller.

Configure these blocks during early platform init so Linux can access
the peripherals after U-Boot hands off control when booting in secure
mode. Add an R528/T113-specific SPC init step alongside the existing
early security controller setup, allow non-secure DMA access there, and
switch the CCU and PRCM buses to non-secure access in clock_init_sec().

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 arch/arm/cpu/armv7/sunxi/Makefile             |  1 +
 arch/arm/cpu/armv7/sunxi/spc.c                | 20 ++++++++++++++
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  | 27 +++++++++++++++++++
 arch/arm/include/asm/arch-sunxi/sys_proto.h   |  8 ++++++
 arch/arm/mach-sunxi/board.c                   |  1 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  8 ++++++
 6 files changed, 65 insertions(+)
 create mode 100644 arch/arm/cpu/armv7/sunxi/spc.c

diff --git a/arch/arm/cpu/armv7/sunxi/Makefile b/arch/arm/cpu/armv7/sunxi/Makefile
index 0624e93efde..bc19f6a203c 100644
--- a/arch/arm/cpu/armv7/sunxi/Makefile
+++ b/arch/arm/cpu/armv7/sunxi/Makefile
@@ -8,6 +8,7 @@
 
 obj-$(CONFIG_MACH_SUN6I)	+= tzpc.o
 obj-$(CONFIG_MACH_SUN8I_H3)	+= tzpc.o
+obj-$(CONFIG_MACH_SUN8I_R528)	+= spc.o
 
 obj-$(CONFIG_MACH_SUN6I)	+= sram.o
 obj-$(CONFIG_MACH_SUN8I)	+= sram.o
diff --git a/arch/arm/cpu/armv7/sunxi/spc.c b/arch/arm/cpu/armv7/sunxi/spc.c
new file mode 100644
index 00000000000..bdecfaa1b4b
--- /dev/null
+++ b/arch/arm/cpu/armv7/sunxi/spc.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2015 Chen-Yu Tsai <wens@csie.org>
+ * (C) Copyright 2026 Lukas Schmid <lukas.schmid@netcube.li>
+ */
+
+#include <asm/io.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/sys_proto.h>
+
+void spc_init(void)
+{
+	struct sunxi_spc *spc = (struct sunxi_spc *)SUNXI_SPC_BASE;
+	int i;
+
+	for (i = 0; i < SUNXI_SPC_NUM_PORTS; i++)
+		writel(SUNXI_SPC_DECPORT_MASK, &spc->decport[i].set);
+
+	writel(SUNXI_DMA_SEC_MASK, SUNXI_DMA_BASE + SUNXI_DMA_SEC_REG);
+}
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index bcfdc0a41c5..7a4d25e6e78 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -7,6 +7,7 @@
 #ifndef _SUNXI_CPU_SUNXI_NCAT2_H
 #define _SUNXI_CPU_SUNXI_NCAT2_H
 
+#define SUNXI_SPC_BASE			0x02000800
 #define SUNXI_CCM_BASE			0x02001000
 #define SUNXI_TIMER_BASE		0x02050000
 
@@ -16,6 +17,7 @@
 #define SUNXI_TWI3_BASE			0x02502C00
 
 #define SUNXI_SRAMC_BASE		0x03000000
+#define SUNXI_DMA_BASE			0x03002000
 /* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
 #define SUNXI_SIDC_BASE			0x03006000
 #define SUNXI_SID_BASE			0x03006200
@@ -50,7 +52,32 @@
 
 #define SUNXI_CPU_PLL_CFG_BASE		0x08817000
 
+#ifdef CONFIG_MACH_SUN8I_R528
+#define SUNXI_CCM_SEC_SWITCH_REG        (SUNXI_CCM_BASE + 0x0f00)
+#define SUNXI_CCM_SEC_SWITCH_NONSEC	0x7
+#define SUNXI_PRCM_SEC_SWITCH_REG       (SUNXI_PRCM_BASE + 0x0290)
+#define SUNXI_PRCM_SEC_SWITCH_NONSEC	0x1
+#define SUNXI_SPC_DECPORT_STA_REG(p)    (SUNXI_SPC_BASE + 0x0000 + 0x10 * (p))
+#define SUNXI_SPC_DECPORT_SET_REG(p)    (SUNXI_SPC_BASE + 0x0004 + 0x10 * (p))
+#define SUNXI_SPC_DECPORT_CLR_REG(p)    (SUNXI_SPC_BASE + 0x0008 + 0x10 * (p))
+#define SUNXI_SPC_NUM_PORTS             13
+#define SUNXI_SPC_DECPORT_MASK		0xffffffff
+#define SUNXI_DMA_SEC_REG		0x20
+#define SUNXI_DMA_SEC_MASK		0xffff
+#endif
+
 #ifndef __ASSEMBLY__
+struct sunxi_spc_decport {
+	u32 status;
+	u32 set;
+	u32 clear;
+	u32 reserved;
+};
+
+struct sunxi_spc {
+	struct sunxi_spc_decport decport[SUNXI_SPC_NUM_PORTS];
+};
+
 void sunxi_board_init(void);
 void sunxi_reset(void);
 int sunxi_get_sid(unsigned int *sid);
diff --git a/arch/arm/include/asm/arch-sunxi/sys_proto.h b/arch/arm/include/asm/arch-sunxi/sys_proto.h
index 6f70753e948..a006e592f83 100644
--- a/arch/arm/include/asm/arch-sunxi/sys_proto.h
+++ b/arch/arm/include/asm/arch-sunxi/sys_proto.h
@@ -18,6 +18,14 @@ bool sunxi_get_unique_sid(unsigned int *sid);
 /* Build legacy-compatible SID-derived locally administered MAC address. */
 bool sunxi_get_sid_mac_addr(int index, u8 mac[6]);
 
+#ifdef CONFIG_MACH_SUN8I_R528
+void spc_init(void);
+#else
+static inline void spc_init(void)
+{
+}
+#endif
+
 /* return_to_fel() - Return to BROM from SPL
  *
  * This returns back into the BROM after U-Boot SPL has performed its initial
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..4d98d350cbe 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -475,6 +475,7 @@ void board_init_f(ulong dummy)
 
 	/* Enable non-secure access to some peripherals */
 	tzpc_init();
+	spc_init();
 
 	timer_init();
 	clock_init();
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 80004f13a1e..217d47c8770 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -74,6 +74,14 @@ void clock_init_safe(void)
 	}
 }
 
+void clock_init_sec(void)
+{
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		writel(SUNXI_CCM_SEC_SWITCH_NONSEC, SUNXI_CCM_SEC_SWITCH_REG);
+		writel(SUNXI_PRCM_SEC_SWITCH_NONSEC, SUNXI_PRCM_SEC_SWITCH_REG);
+	}
+}
+
 void clock_init_uart(void)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
-- 
2.47.3


