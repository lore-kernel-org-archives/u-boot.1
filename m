Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734B606A334
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vahq8Yn5;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XuxW0Qw0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 953F3407FB;
	Thu,  5 Nov 2026 14:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZjofz12RHu0; Thu,  5 Nov 2026 14:06:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 678E44073B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887580;
	b=bWYME7/A8WHHxsd1xf1OSBlalDnQqVAXG3Gwxd9v7KkDMbz8YHg25BpVi/Gec0OP5cWJ
	 CRXptOk4oX4yQaSPnfJWhIYMcCQ8YxxXvw8E1xlq9xllsnnDkLcvHHOlXJS3xqxXw2RU+
	 u6Zr4eqAM7klLAOoQqYSQFoc75wZb6lOdI7KdrPLfOttINHBYrO9zXrvKjC4IjFO8FFr4
	 MzdjMMMgF7wFVPuRCn9uq92CejlWYDjHaEyYFNPlNA7wFMBoVxBbyOJQM8HC51x+V5Cxi
	 ADOFRqw1wfRN2Uww3N01uqCYaC9sJs84gEXdhsPMtTaYCI3OMrsAQ2nwXtTlracO1SQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OeZEp4tkz4+Ena98VBhVyTBfnT86Mm1iu93gzrLYzrk=;
	b=tHNSLeGnkTdG0chVBpafLWxPAQ/pa8sDdI3P9Y2zN7lHEZgZMRYkRBmyMlk4aOQwLkWl
	 gmmNjc83Y4BGMwxs4XgK1mKKATdoRe1c6SxdHmr8o396sJDRMTKihxklFAFWX3lPI1gax
	 sE8J9/2XPHRkLdyRk2SV56Ogb+dC3EOZ06zKSay2JC84DUqsw4quyIriWtxJ/dEieL/xn
	 93gw8Uncwd40v7vbAUNffahorEUW38T0e+5K0C0D8eGSjLNGJENrneMDcH6XgEfko9IEH
	 xy9h/KP4WLO8otpe3qhv9CZ7imnzZWdjXUD8Ta/48zJ/PxlEvuuWGgBrCPO26/8n5Yw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887580;
	bh=OeZEp4tkz4+Ena98VBhVyTBfnT86Mm1iu93gzrLYzrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vahq8Yn5bpYIPSpvcuYrIN0yDSdK+xydHpmqV+UWVsZSqMIk/SWR2jhhZWrkVATkl
	 iwxy+iDMrEBOx0ob2i2dnRrA3szL6iJ4i4YAA4GZb/InryW6+ul+2BGemQjf/Gg+xH
	 2RydqYYFwpKIWgNRsyYfpf1YaoyouQnppgcEpj7MpuUXIuWUBKtKr2kt+jSOZIY1uX
	 lVLyOK6k/sj+p231al0AC5NonBU2tanG/v60lJF1trbhWwFZ9w2+qzwmmUyXccEWN8
	 5sWBwslg73MCrOXGu069zBroJfW1OZTA5vU2iYpFL2VuZSAOvPNpaZgi2lOcysBQsb
	 wFMW8XTzBHCwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 678E44073B;
	Thu,  5 Nov 2026 14:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D58234D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B75060855
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xg62u6GREn7H for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8C8F60847
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=XuxW0Qw0
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8C8F60847
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6A6BDC6915B;
 Thu,  5 Nov 2026 14:06:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 477995FF85;
 Thu,  5 Nov 2026 14:06:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9883E103291F9; Thu,  5 Nov 2026 15:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793887569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=OeZEp4tkz4+Ena98VBhVyTBfnT86Mm1iu93gzrLYzrk=;
 b=XuxW0Qw0EV4NF55qWPATWkJfqypiG+C5FeFPmtfinegsKm0QnwvJDMFqBjLMFmnuTkXGWf
 mqDxnSq8WvgGao50HKbazXEP4q1A/40n5PhS+9xGIMdjWEQ0IdLJyyOaq6rMj4LiwGFxnu
 AM5HYoc94ddCD49Gcu9kYG/cZiwPwl5lV/GEUUNwF4gSwOaxAZSxf/AScRB7nzipDP/TiI
 PSp9k4Y8pGc0LA78qOvi8+TtOJDikWH1EQw0ljitxBbhOKB4rOedd0k1gIUvwCJCJLkicY
 BR2aSHE5mt+WGhxF4X9mJ5MJMFkBkl9r9WIApLCmSChFB8KYg0+bKvvmi7CEgA==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Thu, 05 Nov 2026 15:05:57 +0100
Subject: [PATCH RESEND 2/3] board: beagle: Add BeagleV-Ahead board support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dev-tprrt-beaglev-ahead-spl-v1-2-ba7472d69ebf@bootlin.com>
References: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
In-Reply-To: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the BeagleBoard.org BeagleV-Ahead, based on the T-Head
TH1520 SoC with 4 GB of LPDDR4X.

The TH1520 SoC support and the devicetree are already upstream, so only
a board directory, a U-Boot devicetree include and a defconfig are
needed. As on the Lichee Pi 4A, the SPL is loaded into SRAM through
fastboot and starts OpenSBI and U-Boot from a FIT generated by binman.

The board has a single rank of memory, so the DDR firmware must be built
from lpddr4x-3733-singlerank.lua instead of the dual rank configuration
used by the Lichee Pi 4A.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 arch/riscv/Kconfig                              |   9 ++
 arch/riscv/dts/th1520-beaglev-ahead-u-boot.dtsi |  32 +++++++
 board/beagle/beaglev_ahead/Kconfig              |  43 +++++++++
 board/beagle/beaglev_ahead/MAINTAINERS          |   8 ++
 board/beagle/beaglev_ahead/Makefile             |   7 ++
 board/beagle/beaglev_ahead/board.c              |  14 +++
 board/beagle/beaglev_ahead/spl.c                |  51 +++++++++++
 configs/beaglev_ahead_defconfig                 | 110 ++++++++++++++++++++++++
 include/configs/beaglev_ahead.h                 |  20 +++++
 9 files changed, 294 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6c..20bf9b54d652 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -20,6 +20,14 @@ config TARGET_BANANAPI_F3
 config TARGET_BEAGLEBOARD_BEAGLEVFIRE
 	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
 
+config TARGET_BEAGLEV_AHEAD
+	bool "Support BeagleBoard BeagleV-Ahead Board (based on T-Head TH1520)"
+	select SYS_CACHE_SHIFT_6
+	help
+	  The BeagleBoard.org BeagleV-Ahead is a single board computer based on
+	  the T-Head TH1520 SoC (4x Xuantie C910), with 4 GB of LPDDR4X and
+	  16 GB of eMMC.
+
 config TARGET_K230_CANMV
 	bool "Support K230 CanMV Board"
 
@@ -109,6 +117,7 @@ config SPL_ZERO_MEM_BEFORE_USE
 source "board/andestech/ae350/Kconfig"
 source "board/andestech/voyager/Kconfig"
 source "board/aspeed/ibex_ast2700/Kconfig"
+source "board/beagle/beaglev_ahead/Kconfig"
 source "board/beagle/beaglev_fire/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
diff --git a/arch/riscv/dts/th1520-beaglev-ahead-u-boot.dtsi b/arch/riscv/dts/th1520-beaglev-ahead-u-boot.dtsi
new file mode 100644
index 000000000000..b5e77bdf9d06
--- /dev/null
+++ b/arch/riscv/dts/th1520-beaglev-ahead-u-boot.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ * Copyright (C) 2026 Thomas Perrot <thomas.perrot@bootlin.com>
+ */
+
+#include "th1520-u-boot.dtsi"
+#include "thead-th1520-binman.dtsi"
+
+&{/memory@0} {
+	bootph-pre-ram;
+};
+
+&clk {
+	bootph-some-ram;
+};
+
+&padctrl0_apsys {
+	bootph-some-ram;
+};
+
+&uart0_pins {
+	bootph-some-ram;
+
+	tx-pins {
+		bootph-some-ram;
+	};
+
+	rx-pins {
+		bootph-some-ram;
+	};
+};
diff --git a/board/beagle/beaglev_ahead/Kconfig b/board/beagle/beaglev_ahead/Kconfig
new file mode 100644
index 000000000000..f0c4fe54678a
--- /dev/null
+++ b/board/beagle/beaglev_ahead/Kconfig
@@ -0,0 +1,43 @@
+if TARGET_BEAGLEV_AHEAD
+
+config ARCH_THEAD
+	bool
+	default y
+
+config SYS_BOARD
+	default "beaglev_ahead"
+
+config SYS_VENDOR
+	default "beagle"
+
+config SYS_CPU
+	default "th1520"
+
+config SYS_CONFIG_NAME
+	default "beaglev_ahead"
+
+config TEXT_BASE
+	default 0x01b00000 if SPL
+	default 0x01c00000 if !RISCV_SMODE
+	default 0x01c00000 if RISCV_SMODE
+
+config SPL_TEXT_BASE
+	default 0xffe0000000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x80000000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select ARCH_EARLY_INIT_R
+	select THEAD_TH1520
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER if RISCV_SMODE
+	imply CMD_CPU
+	imply SMP
+	imply SUPPORT_OF_CONTROL
+	imply OF_CONTROL
+	imply OF_REAL
+
+endif
diff --git a/board/beagle/beaglev_ahead/MAINTAINERS b/board/beagle/beaglev_ahead/MAINTAINERS
new file mode 100644
index 000000000000..7d6a162863b0
--- /dev/null
+++ b/board/beagle/beaglev_ahead/MAINTAINERS
@@ -0,0 +1,8 @@
+BeagleBoard BeagleV-Ahead
+M:	Thomas Perrot <thomas.perrot@bootlin.com>
+S:	Maintained
+F:	arch/riscv/dts/th1520-beaglev-ahead-u-boot.dtsi
+F:	board/beagle/beaglev_ahead/
+F:	configs/beaglev_ahead_defconfig
+F:	doc/board/beagle/beaglev_ahead.rst
+F:	include/configs/beaglev_ahead.h
diff --git a/board/beagle/beaglev_ahead/Makefile b/board/beagle/beaglev_ahead/Makefile
new file mode 100644
index 000000000000..ab3c61a10eca
--- /dev/null
+++ b/board/beagle/beaglev_ahead/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2023, Yixun Lan <dlan@gentoo.org>
+# Copyright (c) 2026, Thomas Perrot <thomas.perrot@bootlin.com>
+
+obj-y += board.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/beagle/beaglev_ahead/board.c b/board/beagle/beaglev_ahead/board.c
new file mode 100644
index 000000000000..32c3f3205078
--- /dev/null
+++ b/board/beagle/beaglev_ahead/board.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023, Yixun Lan <dlan@gentoo.org>
+ * Copyright (c) 2026, Thomas Perrot <thomas.perrot@bootlin.com>
+ */
+
+#include <cpu_func.h>
+
+int board_init(void)
+{
+	enable_caches();
+
+	return 0;
+}
diff --git a/board/beagle/beaglev_ahead/spl.c b/board/beagle/beaglev_ahead/spl.c
new file mode 100644
index 000000000000..d75fa6f3eff7
--- /dev/null
+++ b/board/beagle/beaglev_ahead/spl.c
@@ -0,0 +1,51 @@
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
+	riscv_cpu_setup();
+	th1520_kick_secondary_cores();
+
+	spl_dram_init();
+
+	icache_enable();
+	dcache_enable();
+
+	th1520_invalidate_pmp();
+}
diff --git a/configs/beaglev_ahead_defconfig b/configs/beaglev_ahead_defconfig
new file mode 100644
index 000000000000..1ababbd63f2a
--- /dev/null
+++ b/configs/beaglev_ahead_defconfig
@@ -0,0 +1,110 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="thead/th1520-beaglev-ahead"
+CONFIG_SPL_STACK=0xffe0170000
+CONFIG_SPL_BSS_START_ADDR=0xffe0160000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SPL=y
+CONFIG_TARGET_BEAGLEV_AHEAD=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_SYS_BOOT_GET_CMDLINE=y
+CONFIG_SYS_BOOT_GET_KBD=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+# CONFIG_FIT_FULL_CHECK is not set
+# CONFIG_FIT_PRINT is not set
+CONFIG_SPL_LOAD_FIT_ADDRESS=0xffe0040000
+# CONFIG_BOOTSTD is not set
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTARGS_SUBST=y
+CONFIG_BOOTCOMMAND=""
+CONFIG_DEFAULT_FDT_FILE="thead/th1520-beaglev-ahead.dtb"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+CONFIG_LOG=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x10000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x400000
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SYS_PROMPT="Ahead=> "
+CONFIG_CMD_CONFIG=y
+CONFIG_CMD_LICENSE=y
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_EDITENV is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_CRC32 is not set
+# CONFIG_CMD_MEMORY is not set
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_UNLZ4 is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_SLEEP is not set
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+# CONFIG_BLOCK_CACHE is not set
+CONFIG_DWAPB_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_SNPS=y
+# CONFIG_MTD is not set
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_THEAD=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PINCTRL=y
+# CONFIG_POWER is not set
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_SPL_THEAD_TH1520_DDR=y
+CONFIG_SYS_NS16550=y
+CONFIG_AES=y
+CONFIG_BLAKE2=y
+CONFIG_SHA512=y
+CONFIG_LZ4=y
+CONFIG_LZMA=y
+CONFIG_LZO=y
+CONFIG_ZLIB_UNCOMPRESS=y
+CONFIG_BZIP2=y
+CONFIG_ZSTD=y
+CONFIG_LIB_RATIONAL=y
diff --git a/include/configs/beaglev_ahead.h b/include/configs/beaglev_ahead.h
new file mode 100644
index 000000000000..ac5df86890a3
--- /dev/null
+++ b/include/configs/beaglev_ahead.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Yixun Lan <dlan@gentoo.org>
+ * Copyright (c) 2026 Thomas Perrot <thomas.perrot@bootlin.com>
+ */
+
+#ifndef __BEAGLEV_AHEAD_H
+#define __BEAGLEV_AHEAD_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_NS16550_CLK		100000000
+#define CFG_SYS_SDRAM_BASE		0x00000000
+
+/* Environment options */
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"PS1=[BeagleV-Ahead]# \0"
+
+#endif /* __BEAGLEV_AHEAD_H */

-- 
2.56.0

