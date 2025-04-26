Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35BAC369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D7B82063;
	Sat, 26 Apr 2025 19:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="aWsJzFoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF4D8209F; Sat, 26 Apr 2025 19:03:42 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7FC81E0F
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C203725E9B;
 Sat, 26 Apr 2025 19:03:39 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNlLnN1TsL3x; Sat, 26 Apr 2025 19:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745687019; bh=uDwUH2IxTHAgVkaxLj0zMZSdTpCSyYKOghprwoiFavc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aWsJzFoz8DS6W9RzF43ITZ82nw4vts/3GlNmmgDb5ImZqBAIK6JbNWObNBnDQgCDi
 yiuGU9IZEe0Tr+sAV+/MrkHxCr0UW58TqFyQtaIREvXOleCCRLrsU3EdX1utffhL38
 fpBzq8gn8emlHlihRTTiG6kaC30iO7wqYnxxe8qtJzRLpingxGxDFpX9CHGuBVmI/w
 XFWHEnWU/uWLcLxNF1kVsCeDH70upj6TJXaimWkE9cYQ6cMey53Yk7EZytWPcyepST
 suZd3W5mMAGjHB9Rpjs0J/oMVPxooQ2rLXDIla6dQwtMX33LHSvGmbnSIz6w4qw56t
 /nriI9XngkXAg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 09/10] board: thead: licheepi4a: Enable SPL support
Date: Sat, 26 Apr 2025 17:03:20 +0000
Message-ID: <20250426170322.35601-1-ziyao@disroot.org>
In-Reply-To: <20250426165704.35523-1-ziyao@disroot.org>
References: <20250426165704.35523-1-ziyao@disroot.org>
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

Adjust Kconfig and defconfig and add SPL initialization code for
Lichee Pi 4A. Then enable SPL support which we've added for TH1520 SoC
earlier. The board devicetree is changed to use TH1520 binman
configuration to generate bootable images.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520-lichee-pi-4a.dts |  1 +
 board/thead/th1520_lpi4a/Kconfig       |  5 +--
 board/thead/th1520_lpi4a/Makefile      |  1 +
 board/thead/th1520_lpi4a/spl.c         | 48 ++++++++++++++++++++++++++
 configs/th1520_lpi4a_defconfig         | 18 ++++++++++
 5 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 board/thead/th1520_lpi4a/spl.c

diff --git a/arch/riscv/dts/th1520-lichee-pi-4a.dts b/arch/riscv/dts/th1520-lichee-pi-4a.dts
index a1248b2ee3a..49af88b7adf 100644
--- a/arch/riscv/dts/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/dts/th1520-lichee-pi-4a.dts
@@ -4,6 +4,7 @@
  */
 
 #include "th1520-lichee-module-4a.dtsi"
+#include "thead-th1520-binman.dtsi"
 
 / {
 	model = "Sipeed Lichee Pi 4A";
diff --git a/board/thead/th1520_lpi4a/Kconfig b/board/thead/th1520_lpi4a/Kconfig
index 622246127c1..f139d5ff2bb 100644
--- a/board/thead/th1520_lpi4a/Kconfig
+++ b/board/thead/th1520_lpi4a/Kconfig
@@ -11,7 +11,7 @@ config SYS_VENDOR
 	default "thead"
 
 config SYS_CPU
-	default "generic"
+	default "th1520"
 
 config SYS_CONFIG_NAME
 	default "th1520_lpi4a"
@@ -22,7 +22,7 @@ config TEXT_BASE
 	default 0x01c00000 if RISCV_SMODE
 
 config SPL_TEXT_BASE
-	default 0x08000000
+	default 0xffe0000000
 
 config SPL_OPENSBI_LOAD_ADDR
 	default 0x80000000
@@ -30,6 +30,7 @@ config SPL_OPENSBI_LOAD_ADDR
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
 	select ARCH_EARLY_INIT_R
+	select THEAD_TH1520
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if RISCV_SMODE
diff --git a/board/thead/th1520_lpi4a/Makefile b/board/thead/th1520_lpi4a/Makefile
index 9671b3bbb0b..a7ddfc48d40 100644
--- a/board/thead/th1520_lpi4a/Makefile
+++ b/board/thead/th1520_lpi4a/Makefile
@@ -3,3 +3,4 @@
 # Copyright (c) 2023, Yixun Lan <dlan@gentoo.org>
 
 obj-y += board.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/thead/th1520_lpi4a/spl.c b/board/thead/th1520_lpi4a/spl.c
new file mode 100644
index 00000000000..25dfa387c36
--- /dev/null
+++ b/board/thead/th1520_lpi4a/spl.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Yao Zi <ziyao@disroot.org>
+ */
+
+#include <asm/io.h>
+#include <asm/spl.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/spl.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <hang.h>
+#include <spl.h>
+
+u32 spl_boot_device(void)
+{
+	/*
+	 * We don't bother to load proper U-Boot from an external device as
+	 * it fits in the integrated SRAM nicely.
+	 */
+	return BOOT_DEVICE_RAM;
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret = spl_early_init();
+	struct udevice *dev;
+
+	if (ret)
+		panic("spl_early_init() failed %d\n", ret);
+
+	preloader_console_init();
+
+	/*
+	 * Manually bind CPU ahead of time to make sure in-core timers are
+	 * available in SPL.
+	 */
+	ret = uclass_get_device(UCLASS_CPU, 0, &dev);
+	if (ret)
+		panic("failed to bind CPU: %d\n", ret);
+
+	spl_dram_init();
+
+	icache_enable();
+	dcache_enable();
+
+	th1520_invalidate_pmp();
+}
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index d13c97463a8..b19dc009fde 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -90,3 +90,21 @@ CONFIG_ZLIB_UNCOMPRESS=y
 CONFIG_BZIP2=y
 CONFIG_ZSTD=y
 CONFIG_LIB_RATIONAL=y
+CONFIG_SPL=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_LOAD_FIT_ADDRESS=0xffe0040000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xffe0170000
+CONFIG_SPL_BSS_START_ADDR=0xffe0160000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_SPL_THEAD_TH1520_DDR=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_MMC_y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x10000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x400000
-- 
2.49.0

