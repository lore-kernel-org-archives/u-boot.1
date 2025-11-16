Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B3CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D8F839DE;
	Sun, 16 Nov 2025 15:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6CF283A3D; Sun, 16 Nov 2025 15:44:57 +0100 (CET)
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D39839D5
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id B54303415D0;
 Sun, 16 Nov 2025 14:44:49 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:43:52 +0000
Subject: [PATCH 01/11] sunxi: sun60i: initial support for A733 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-1-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5019; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=ha+uhTabjDTj+axxVpQ5TNW5me8CQ5qc38LNG5nYTdE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeM4gqLAGjtqYLj2tps2VzEOoFytfnkCUpnry
 9RodRWjAYSJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjOF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277YzCD/9r7H+52pXvvqPJGy
 4uWu/eEZqdOcqdRJOuYsIZeQBXetB0maKj1ALCytUxODsHUvdqG6LZ9JU08xYgPPvVEZ58NRF0E
 arPIts+uoTvJ6PTRCsb9PblA91jOXWkEAVJchiumViMg/gmkWMTNEMSOlWrxC6+mEmu5TtxDwe2
 v+vV6t4Kfm7Z5Ctk79OVWoOHs3K1QjQOtITQ/Q3vYYReXTwixSKzaVTMASx5TyAOZGBItz6NN3u
 I/JsC9n9E7LO7Jy6KCNkXrGpR6SY8uWRPCMaYq7HAIBEW9Gxz1/xdMRORUFaMUzZaIlnSSKju0D
 qL4cYtrfnKH2OVGuFEjhNOwLN48yV58qZrEPpo9Kpxygb6hus1CgCcGf0D/oDR31Gj6DZcKS/ZC
 IUo6vvtIsV4bkqCZFD6e0gqFs77TJs2q/yMdEd7LVbGBd2I1gCMQfiAA5kAQ+2fmkwFoTx0RksZ
 Gzm6rOBU/XqBIEsuJS0g18p5v6DvCkR5MIS2QOYwTyT+GrKpeC7nsjEqc0F8bMR9ck5dj1LHxqx
 3r2T8DmxspZaQhibdKhTf/GHYv/ShI9TumYUUD+akmg0I70RK0KPeW08fib1wBq8Ni6JT6x+Yp1
 MfZQrC51sVQqk6erlp+nzJECFt54PMfcS9RR9OlpfyuhWjiFF0oqzGCgLJrW68ca8Obw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add basic support for Allwinner A733 SoC.

- Include some basic register definitions
- Introduce a new SUN60I A733 Kconfig option
- Ssetup RVBAR register properly according to docs
- Config max DDR size 16GB

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_a733.h | 41 ++++++++++++++++++++++++
 arch/arm/mach-sunxi/Kconfig                      | 12 +++++++
 arch/arm/mach-sunxi/cpu_info.c                   |  2 ++
 include/configs/sun60i.h                         | 11 +++++++
 4 files changed, 66 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_a733.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_a733.h
new file mode 100644
index 00000000000..3c0a03c85cb
--- /dev/null
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_a733.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _SUNXI_CPU_SUNXI_A733_H
+#define _SUNXI_CPU_SUNXI_A733_H
+
+#define SUNXI_CCM_BASE			0x02002000
+
+#define SUNXI_WDT_BASE			0x02050000
+#define SUNXI_TIMER_BASE		0x02052000
+
+#define SUNXI_TWI0_BASE			0x02510000
+#define SUNXI_TWI1_BASE			0x02511000
+#define SUNXI_TWI2_BASE			0x02512000
+#define SUNXI_TWI3_BASE			0x02513000
+
+#define SUNXI_SRAMC_BASE		0x03000000
+/* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
+#define SUNXI_SIDC_BASE			0x03006000
+#define SUNXI_SID_BASE			0x03006200
+#define SUNXI_GIC400_BASE		0x03020000
+
+#define SUNXI_MMC0_BASE			0x04020000
+#define SUNXI_MMC1_BASE			0x04021000
+#define SUNXI_MMC2_BASE			0x04022000
+
+#define SUNXI_PRCM_BASE			0x07010000
+#define SUNXI_R_WDOG_BASE		0x07020400
+#define SUNXI_R_CPUCFG_BASE		0x07050000
+#define SUNXI_R_TWI_BASE		0x07083000
+#define SUNXI_RTC_BASE			0x07090000
+
+#define SUNXI_CPUCFG_BASE		0x08815000 // FIXME
+#define SUNXI_CPU_PLL_CFG_BASE		0x08870000
+
+#ifndef __ASSEMBLY__
+void sunxi_board_init(void);
+void sunxi_reset(void);
+int sunxi_get_sid(unsigned int *sid);
+#endif
+
+#endif /* _SUNXI_CPU_SUNXI_A733_H */
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..c0b4fdaa370 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -215,6 +215,7 @@ config SUNXI_SRAM_ADDRESS
 	hex
 	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
 	default 0x44000 if MACH_SUN55I_A523
+	default 0x47000 if MACH_SUN60I_A733
 	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
 	---help---
@@ -228,6 +229,7 @@ config SUNXI_RVBAR_ADDRESS
 	depends on ARM64
 	default 0x08100040 if MACH_SUN50I_A133
 	default 0x08000040 if MACH_SUN55I_A523
+	default 0x08001004 if MACH_SUN60I_A733
 	default 0x09010040 if SUN50I_GEN_H6
 	default 0x017000a0
 	---help---
@@ -339,6 +341,7 @@ config MACH_SUNXI_H3_H5
 config SUNXI_DRAM_MAX_SIZE
 	hex
 	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
+	default 0x400000000 if MACH_SUN60I_A733
 	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
 	default 0x80000000
 
@@ -553,6 +556,13 @@ config MACH_SUN55I_A523
 	select SPL_LOAD_FIT if SPL
 	imply OF_UPSTREAM
 
+config MACH_SUN60I_A733
+	bool "sun60i (Allwinner A733)"
+	select ARM64
+	select FIT
+	select SPL_LOAD_FIT if SPL
+	select SUPPORT_SPL
+
 endchoice
 
 # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
@@ -870,6 +880,7 @@ config SYS_CONFIG_NAME
 	default "sun50i" if MACH_SUN50I_H616
 	default "sun50i" if MACH_SUN50I_A133
 	default "sun55i" if MACH_SUN55I_A523
+	default "sun60i" if MACH_SUN60I_A733
 
 config SYS_BOARD
 	default "sunxi"
@@ -1186,6 +1197,7 @@ config SPL_STACK_R_ADDR
 	default 0x4fe00000 if MACH_SUN50I
 	default 0x4fe00000 if SUN50I_GEN_H6
 	default 0x4fe00000 if SUNXI_GEN_NCAT2
+	default 0x4fe00000 if MACH_SUN60I_A733
 
 config SPL_SPI_SUNXI
 	bool "Support for SPI Flash on Allwinner SoCs in SPL"
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index c3a51d9956e..f0b33bb9097 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -108,6 +108,8 @@ int print_cpuinfo(void)
 	puts("CPU:   Allwinner A133 (SUN50I)\n");
 #elif defined CONFIG_MACH_SUN55I_A523
 	puts("CPU:   Allwinner A523 (SUN55I)\n");
+#elif defined CONFIG_MACH_SUN60I_A733
+	puts("CPU:   Allwinner A733 (SUN60I)\n");
 #else
 #warning Please update cpu_info.c with correct CPU information
 	puts("CPU:   SUNXI Family\n");
diff --git a/include/configs/sun60i.h b/include/configs/sun60i.h
new file mode 100644
index 00000000000..70649366c1c
--- /dev/null
+++ b/include/configs/sun60i.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Placeholder wrapper to allow addressing Allwinner devices with Cortex-A55
+ * cores separately. Please do not add anything in here.
+ */
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/sunxi-common.h>
+
+#endif /* __CONFIG_H */

-- 
2.51.2

