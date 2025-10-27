Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF77CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EB383955;
	Mon, 27 Oct 2025 18:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b5RDO5fm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yfW2KuWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4EA183923; Mon, 27 Oct 2025 18:22:29 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D298384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwL0z2LHJz9tHV;
 Mon, 27 Oct 2025 18:22:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761585747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jHQufF6hciW9HtEXnsAqA1+6JMReK3mZMgx6fYYKKyg=;
 b=b5RDO5fmToK8duWjQYaGjG4hvA7nfnDT6x+bk2tUbupBGkkfmClQR6lWGXiOciNjMxnf7l
 ENnLdzclJdaed8SEe/MovydHwEaPwayh4Vq0wUL/kUoMS20IceMlHmU0FuCSlUylQs0Mza
 Cr0/0GRgFISl2MlbEA2Zml4M2ULE+KKYjmC76C6Jc1ZSivAtXj2xI+OVWpdWqe4y9RpKCY
 Kt73vZN3eXY/pBBPZLbJycT6fMTTCoJ6msmTdZRmbQWqxZljXP9EIBaTso/jb0GVcYszS6
 1paRKIHP7Dzf6VVrllZLzw7TQ9vwuJVcgIQVGGLbkih4H3JBKUEQIO7sILhWwQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=yfW2KuWJ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761585745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jHQufF6hciW9HtEXnsAqA1+6JMReK3mZMgx6fYYKKyg=;
 b=yfW2KuWJnsj60bK97mmd+y7VIMdvgdTqhXPZ55+zb3w4U7zrSU8z68cNz4b+axDd7GAp2W
 ASJLku4dtj5j3FUE4srbMGr7oNdFmluQjFYwTo/8wdQmcOVgBKCzd8NTduSp6U7PiRAtoC
 TENAh5VLsnM0gTI6xIeo82UgGDsrQK9dE6eV07a8h+fMQdleoBGzMa+QHAn8tPz5JyQt8N
 PnYWgkrZct09cuj875tA6k+5OHZxZsAlkhXknUQ26Zqp/gW8dPUYXHfRcGLKU42FbxCqoy
 UqzYy/XdSyX0QE3l+ihl5eUCwXUMuaHeQHPANq8dfuRD/qtQVxm+AuyOgMHCgQ==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: renesas: Add Renesas R-Car Gen5 infrastructure
Date: Mon, 27 Oct 2025 18:21:14 +0100
Message-ID: <20251027172219.30437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dd8efadef4af8ac5750
X-MBO-RS-META: 1cxcmmtghyectorgktcfdoo4e39tf11t
X-Rspamd-Queue-Id: 4cwL0z2LHJz9tHV
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add initial changes to support Renesas R-Car Gen5 SoC.

Introduce Kconfig entries, architecture headers and PRR IDs for Renesas
R-Car Gen5 and R-Car X5H R8A78000 SoC. Add Makefile change to produce
u-boot-elf.srec with correct offset for installation tooling. Update
MAINTAINERS entry to cover both r8a77nnn and r8a78nnn .

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[ Marek: - Drop "config TEXT_BASE" , use PIE instead , update Makefile accordingly
         - Adjust commit message, clean up header slightly. ]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Makefile                                      |  9 ++++
 arch/arm/mach-renesas/Kconfig                 |  5 +++
 arch/arm/mach-renesas/Kconfig.64              |  1 +
 arch/arm/mach-renesas/Kconfig.rcar5           | 12 +++++
 arch/arm/mach-renesas/Makefile                |  1 +
 arch/arm/mach-renesas/cpu_info-rcar.c         |  8 +++-
 arch/arm/mach-renesas/cpu_info.c              |  1 +
 .../include/mach/rcar-gen5-base.h             | 44 +++++++++++++++++++
 arch/arm/mach-renesas/include/mach/renesas.h  |  3 ++
 board/renesas/MAINTAINERS                     |  2 +-
 10 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-renesas/Kconfig.rcar5
 create mode 100644 arch/arm/mach-renesas/include/mach/rcar-gen5-base.h

diff --git a/Makefile b/Makefile
index 8cddee3c5a9..f90a6b54204 100644
--- a/Makefile
+++ b/Makefile
@@ -1499,6 +1499,15 @@ ifeq ($(CONFIG_POSITION_INDEPENDENT)$(CONFIG_RCAR_GEN3),yy)
 OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000
 endif
 
+ifeq ($(CONFIG_POSITION_INDEPENDENT)$(CONFIG_RCAR_GEN5),yy)
+# The flash_writer tool and previous recovery tools
+# require the SREC load address to be 0x8e30_0000 .
+# The PIE U-Boot build sets the address to 0x0, so
+# override the address back to make u-boot-elf.srec
+# compatible with the recovery tools.
+OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x8e300000
+endif
+
 u-boot-elf.srec: u-boot.elf FORCE
 	$(call if_changed,zobjcopy)
 
diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index d373ab56ce9..05c3760a878 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -46,6 +46,11 @@ config RCAR_GEN4
 	select RCAR_64
 	select PINCTRL_PFC
 
+config RCAR_GEN5
+	bool "Renesas ARM SoCs R-Car Gen5 (64bit)"
+	select RCAR_64
+	select PINCTRL_PFC
+
 config RZA1
 	prompt "Renesas ARM SoCs RZ/A1 (32bit)"
 	select CPU_V7A
diff --git a/arch/arm/mach-renesas/Kconfig.64 b/arch/arm/mach-renesas/Kconfig.64
index b5067d0a8f0..1b1ed88339b 100644
--- a/arch/arm/mach-renesas/Kconfig.64
+++ b/arch/arm/mach-renesas/Kconfig.64
@@ -8,5 +8,6 @@ config OF_LIBFDT_OVERLAY
 
 source "arch/arm/mach-renesas/Kconfig.rcar3"
 source "arch/arm/mach-renesas/Kconfig.rcar4"
+source "arch/arm/mach-renesas/Kconfig.rcar5"
 
 endif
diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
new file mode 100644
index 00000000000..34c0ae8772b
--- /dev/null
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -0,0 +1,12 @@
+if RCAR_GEN5
+
+menu "Select Target SoC"
+
+config R8A78000
+	bool "Renesas SoC R8A78000"
+	select GICV3
+	imply PINCTRL_PFC_R8A78000
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index 9165ceab4a3..c0454fffa48 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RCAR_GEN2) += lowlevel_init_ca15.o cpu_info-rcar.o
 obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o
 obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o memmap-gen3.o
 obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o memmap-gen3.o
+obj-$(CONFIG_RCAR_GEN5) += cpu_info-rcar.o memmap-gen3.o
 obj-$(CONFIG_RZ_G2) += cpu_info-rzg.o
 obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o memmap-rzg2l.o
 
diff --git a/arch/arm/mach-renesas/cpu_info-rcar.c b/arch/arm/mach-renesas/cpu_info-rcar.c
index 74140fd38ab..a6e0b739e55 100644
--- a/arch/arm/mach-renesas/cpu_info-rcar.c
+++ b/arch/arm/mach-renesas/cpu_info-rcar.c
@@ -15,8 +15,12 @@
 
 static u32 renesas_get_prr(void)
 {
-	if (IS_ENABLED(CONFIG_RCAR_64))
-		return readl(0xFFF00044);
+	if (IS_ENABLED(CONFIG_RCAR_64)) {
+		if (IS_ENABLED(CONFIG_RCAR_GEN5))
+			return readl(0x189E0044);
+		else
+			return readl(0xFFF00044);
+	}
 
 	return readl(0xFF000044);
 }
diff --git a/arch/arm/mach-renesas/cpu_info.c b/arch/arm/mach-renesas/cpu_info.c
index 2f9a4374a96..f040d732a51 100644
--- a/arch/arm/mach-renesas/cpu_info.c
+++ b/arch/arm/mach-renesas/cpu_info.c
@@ -72,6 +72,7 @@ static const struct {
 	{ RENESAS_CPU_TYPE_R8A779F0, "R8A779F0" },
 	{ RENESAS_CPU_TYPE_R8A779G0, "R8A779G0" },
 	{ RENESAS_CPU_TYPE_R8A779H0, "R8A779H0" },
+	{ RMOBILE_CPU_TYPE_R8A78000, "R8A78000" },
 	{ 0x0, "CPU" },
 };
 
diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
new file mode 100644
index 00000000000..f9af3ef885a
--- /dev/null
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __ASM_ARCH_RCAR_GEN5_BASE_H
+#define __ASM_ARCH_RCAR_GEN5_BASE_H
+
+/*
+ * R-Car (R8A78000) I/O Addresses
+ */
+#define TMU_BASE		0x1C030000
+
+/* Arm Generic Timer */
+#define CNTCR_BASE		0x1C000FFF /* Region 0 */
+#define CNTFID0			(CNTCR_BASE + 0x020)
+#define CNTCR_EN		BIT(0)
+
+/* Reset */
+#define RST_BASE		0xC1320000 /* Domain0 */
+#define RST_SWSRES1A		(RST_BASE + 0x410)
+#define RST_WDTRSTCR		(RST_BASE + 0x420)
+#define RST_RWDT_RSTMSK		BIT(0)
+#define RST_WWDT_RSTMSK		BIT(2)
+#define RST_RESKCPROT0		(RST_BASE + 0x4F0)
+#define RST_KCPROT_DIS		0xA5A5A501
+
+/* GICv4 */
+/* Distributor Registers */
+#define GICD_BASE		0x38000000
+#define GICR_BASE		(GICR_LPI_BASE)
+
+/* ReDistributor Registers for Control and Physical LPIs */
+#define GICR_LPI_BASE		0x38080000
+#define GICR_WAKER		0x0014
+#define GICR_PWRR		0x0024
+#define GICR_LPI_WAKER		(GICR_LPI_BASE + GICR_WAKER)
+#define GICR_LPI_PWRR		(GICR_LPI_BASE + GICR_PWRR)
+
+/* ReDistributor Registers for SGIs and PPIs */
+#define GICR_SGI_BASE		0x38090000
+#define GICR_IGROUPR0		0x0080
+
+#endif /* __ASM_ARCH_RCAR_GEN5_BASE_H */
diff --git a/arch/arm/mach-renesas/include/mach/renesas.h b/arch/arm/mach-renesas/include/mach/renesas.h
index c69c764adb8..deaeffedef9 100644
--- a/arch/arm/mach-renesas/include/mach/renesas.h
+++ b/arch/arm/mach-renesas/include/mach/renesas.h
@@ -16,6 +16,8 @@
 #include <asm/arch/rcar-gen3-base.h>
 #elif defined(CONFIG_RCAR_GEN4)
 #include <asm/arch/rcar-gen4-base.h>
+#elif defined(CONFIG_RCAR_GEN5)
+#include <asm/arch/rcar-gen5-base.h>
 #elif defined(CONFIG_R7S72100)
 #elif defined(CONFIG_RZG2L)
 #include <asm/arch/rzg2l.h>
@@ -42,6 +44,7 @@
 #define RENESAS_CPU_TYPE_R8A779F0	0x5A
 #define RENESAS_CPU_TYPE_R8A779G0	0x5C
 #define RENESAS_CPU_TYPE_R8A779H0	0x5D
+#define RMOBILE_CPU_TYPE_R8A78000	0x60
 #define RENESAS_CPU_TYPE_R9A07G044L	0x9A070440
 
 #ifndef __ASSEMBLY__
diff --git a/board/renesas/MAINTAINERS b/board/renesas/MAINTAINERS
index 13551cdd2b4..8571bb02576 100644
--- a/board/renesas/MAINTAINERS
+++ b/board/renesas/MAINTAINERS
@@ -6,7 +6,7 @@ N:	grpeach
 N:	r2dplus
 N:	r7s72100
 N:	r8a66597
-N:	r8a77
+N:	r8a7[78]
 N:	r9a0[0-9]g
 N:	rcar
 N:	renesas
-- 
2.51.0

