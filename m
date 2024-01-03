Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC5C47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CBE879F9;
	Wed,  3 Jan 2024 01:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E15F87A06; Wed,  3 Jan 2024 01:13:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6234287950
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 042991516;
 Tue,  2 Jan 2024 16:14:34 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19A233F5A1;
 Tue,  2 Jan 2024 16:13:46 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 17/19] sunxi: move UART pinmux setup into separate file
Date: Wed,  3 Jan 2024 00:12:37 +0000
Message-Id: <20240103001239.17482-18-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

The code that programs the pinmuxes for the configured UART dominates
the gpio_init() function, and is only needed by SPL code.

Move those lines into a separate function in a new file, that gets
compiled for the SPL only.

That simplifies further cleanup, and helps to separate SPL-only code
from generic code.
To help review, this only copies the code (generating some checkpatch
complaints), further cleanup will be provided in subsequent patches.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Makefile      |   1 +
 arch/arm/mach-sunxi/board.c       | 110 ++------------------------
 arch/arm/mach-sunxi/uart_pinmux.c | 124 ++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 105 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/uart_pinmux.c

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index c15ef01aaad..9a9dffc176f 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -32,6 +32,7 @@ endif
 ifdef CONFIG_SPL_BUILD
 obj-y				+= clock.o
 obj-y				+= spl_pinmux.o
+obj-y				+= uart_pinmux.o
 obj-$(CONFIG_MACH_SUNIV)	+= dram_suniv.o
 obj-$(CONFIG_DRAM_SUN4I)	+= dram_sun4i.o
 obj-$(CONFIG_DRAM_SUN6I)	+= dram_sun6i.o
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 0140b07d32a..dd642c0d2f0 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -75,113 +75,13 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 #endif /* CONFIG_ARM64 */
 
 #ifdef CONFIG_SPL_BUILD
+void uart_pinmux_setup(void);
+
 static int gpio_init(void)
 {
-	__maybe_unused uint val;
-#if CONFIG_CONS_INDEX == 1 && defined(CONFIG_UART0_PORT_F)
-#if defined(CONFIG_MACH_SUN4I) || \
-    defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-	/* disable GPB22,23 as uart0 tx,rx to avoid conflict */
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(22), SUNXI_GPIO_INPUT);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(23), SUNXI_GPIO_INPUT);
-#endif
-#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN5I) || \
-    defined(CONFIG_MACH_SUN7I) || defined(CONFIG_MACH_SUN8I_R40) || \
-    defined(CONFIG_MACH_SUN9I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPF(2), SUNXI_GPF_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPF(4), SUNXI_GPF_UART0);
-#else
-	sunxi_gpio_set_cfgpin(SUNXI_GPF(2), SUN8I_GPF_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPF(4), SUN8I_GPF_UART0);
-#endif
-	sunxi_gpio_set_pull(SUNXI_GPF(4), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUNIV)
-	sunxi_gpio_set_cfgpin(SUNXI_GPE(0), SUNIV_GPE_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPE(1), SUNIV_GPE_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPE(1), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && (defined(CONFIG_MACH_SUN4I) || \
-				 defined(CONFIG_MACH_SUN7I) || \
-				 defined(CONFIG_MACH_SUN8I_R40))
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(22), SUN4I_GPB_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(23), SUN4I_GPB_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPB(23), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN5I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(19), SUN5I_GPB_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(20), SUN5I_GPB_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPB(20), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN6I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(20), SUN6I_GPH_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(21), SUN6I_GPH_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPH(21), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A33)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN8I_A33_GPB_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN8I_A33_GPB_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUNXI_H3_H5)
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(4), SUN8I_H3_GPA_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(5), SUN8I_H3_GPA_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPA(5), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN50I_GPB_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_GPB_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I_H6)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H6_GPH_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H6_GPH_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I_H616)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H616_GPH_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H616_GPH_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A83T)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_V3S)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN9I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(12), SUN9I_GPH_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(13), SUN9I_GPH_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPH(13), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_R528)
-	sunxi_gpio_set_cfgpin(SUNXI_GPE(2), 6);
-	sunxi_gpio_set_cfgpin(SUNXI_GPE(3), 6);
-	sunxi_gpio_set_pull(SUNXI_GPE(3), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUNIV)
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPE_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPE_UART0);
-	sunxi_gpio_set_pull(SUNXI_GPA(3), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN5I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
-	sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I_H3)
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);
-	sunxi_gpio_set_pull(SUNXI_GPA(1), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN8I_GPB_UART2);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN8I_GPB_UART2);
-	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 4 && defined(CONFIG_MACH_SUN8I_R528)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), 7);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), 7);
-	sunxi_gpio_set_pull(SUNXI_GPB(7), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 5 && defined(CONFIG_MACH_SUN8I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(2), SUN8I_GPL_R_UART);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(3), SUN8I_GPL_R_UART);
-	sunxi_gpio_set_pull(SUNXI_GPL(3), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN8I) && \
-				!defined(CONFIG_MACH_SUN8I_R40)
-	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), SUN8I_GPG_UART1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), SUN8I_GPG_UART1);
-	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
-#else
-#error Unsupported console port number. Please fix pin mux settings in board.c
-#endif
+	u32 val;
+
+	uart_pinmux_setup();
 
 	/*
 	 * Update PIO power bias configuration by copying the hardware
diff --git a/arch/arm/mach-sunxi/uart_pinmux.c b/arch/arm/mach-sunxi/uart_pinmux.c
new file mode 100644
index 00000000000..af5ecc4fb3c
--- /dev/null
+++ b/arch/arm/mach-sunxi/uart_pinmux.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 Arm Ltd.
+ * (C) Copyright 2012-2013 Henrik Nordstrom <henrik@henriknordstrom.net>
+ * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ * (C) Copyright 2007-2011
+ *     Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ *     Tom Cubie <tangliang@allwinnertech.com>
+ *
+ * Code to setup the UART pinmux configuration in the SPL, which lacks
+ * the DT to look this up properly.
+ */
+
+#include <asm/gpio.h>
+#include <config.h>
+#include <sunxi_gpio.h>
+
+void uart_pinmux_setup(void)
+{
+#if CONFIG_CONS_INDEX == 1 && defined(CONFIG_UART0_PORT_F)
+#if defined(CONFIG_MACH_SUN4I) || \
+    defined(CONFIG_MACH_SUN7I) || \
+    defined(CONFIG_MACH_SUN8I_R40)
+	/* disable GPB22,23 as uart0 tx,rx to avoid conflict */
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(22), SUNXI_GPIO_INPUT);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(23), SUNXI_GPIO_INPUT);
+#endif
+#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN5I) || \
+    defined(CONFIG_MACH_SUN7I) || defined(CONFIG_MACH_SUN8I_R40) || \
+    defined(CONFIG_MACH_SUN9I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPF(2), SUNXI_GPF_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPF(4), SUNXI_GPF_UART0);
+#else
+	sunxi_gpio_set_cfgpin(SUNXI_GPF(2), SUN8I_GPF_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPF(4), SUN8I_GPF_UART0);
+#endif
+	sunxi_gpio_set_pull(SUNXI_GPF(4), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUNIV)
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(0), SUNIV_GPE_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(1), SUNIV_GPE_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPE(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && (defined(CONFIG_MACH_SUN4I) || \
+				 defined(CONFIG_MACH_SUN7I) || \
+				 defined(CONFIG_MACH_SUN8I_R40))
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(22), SUN4I_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(23), SUN4I_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(23), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN5I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(19), SUN5I_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(20), SUN5I_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(20), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN6I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(20), SUN6I_GPH_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(21), SUN6I_GPH_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPH(21), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A33)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN8I_A33_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN8I_A33_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUNXI_H3_H5)
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(4), SUN8I_H3_GPA_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(5), SUN8I_H3_GPA_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPA(5), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN50I_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I_H6)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H6_GPH_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H6_GPH_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I_H616)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H616_GPH_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H616_GPH_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A83T)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_V3S)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN9I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(12), SUN9I_GPH_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(13), SUN9I_GPH_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPH(13), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_R528)
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(2), 6);
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(3), 6);
+	sunxi_gpio_set_pull(SUNXI_GPE(3), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUNIV)
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPE_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPE_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPA(3), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN5I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
+	sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I_H3)
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);
+	sunxi_gpio_set_pull(SUNXI_GPA(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN8I_GPB_UART2);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN8I_GPB_UART2);
+	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 4 && defined(CONFIG_MACH_SUN8I_R528)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), 7);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), 7);
+	sunxi_gpio_set_pull(SUNXI_GPB(7), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 5 && defined(CONFIG_MACH_SUN8I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(2), SUN8I_GPL_R_UART);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(3), SUN8I_GPL_R_UART);
+	sunxi_gpio_set_pull(SUNXI_GPL(3), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN8I) && \
+				!defined(CONFIG_MACH_SUN8I_R40)
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), SUN8I_GPG_UART1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), SUN8I_GPG_UART1);
+	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
+#else
+#error Unsupported console port number. Please fix pin mux settings in board.c
+#endif
+}
-- 
2.35.8

