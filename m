Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560B7C79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD64E83F2A;
	Mon,  5 Jan 2026 19:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KYZQYy8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C4183DEE; Mon,  5 Jan 2026 17:53:12 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0EF083E21
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so1085055ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631977; x=1768236777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPTT9Vgle7LHSXphyLjFg8HQhBpHy2dqbUr666f5YQ4=;
 b=KYZQYy8CbOj4qDHwhA4lYn5e0rjRt8ccMCCZGKusJS/kp04PN+bWvq2CZeld1CJHyI
 RXB5x0rqsZkbOqIGlY3SzjOByCqFaDcvDf/yqIlUavdB7ta7KI84TFwBzsw/ztwiHff8
 W4RurgBzFqECm6D3JtISgU/kMTG9430pzdMg/fgTt25s7hq9FupaJhjRxtL6VqeAz6ut
 y26ZAE3BaDU+xpXrtcw6Fj5AFAgv1cS0vka0n7cYWLS3InoZ9Mw9eZ0SkxFd4MR+fy9Z
 Caap23ccKilN/8Is/fPVHGOxgwrBbsA2aTaQccJuMoJ2V82CQbyFBsbzgHzekSLicMCF
 hc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631977; x=1768236777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPTT9Vgle7LHSXphyLjFg8HQhBpHy2dqbUr666f5YQ4=;
 b=cT90SbvlPdhTMW33Pf1W7kcX+fyd8mBfVqc5vW4PX2AmRyesZUH/LRimKmWjHcbNiL
 NPiBChttkV9b5QGQ3dlueoUUbCVY0Q9w4xR584WfJw8lPufFYavUa9r8Ajir5soNNhww
 w5RjKsuFhjqM/6TV7d9tufZ5Nf07CmpFy3E+tGZyV5qvljjP5+222NTz8T0omFi6B94A
 0D4sI7nyABgJIGH2ZpVpuioJKwi2lawR+s5TpqCL/9Gme9R3z1IFb0Yz9EEnPginqBd7
 1GdCUZjPp5rC9UntifcjwPNIk9hePtKC0d58u4FN1ntQSRUqDiSQ/IrxfKoaBB8ZJfLh
 LU0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1QAY6RDI/r49dE6mwRldM4ggapEw802Jouq4iouajNKPgK2hPWy/J6oiVfnR14PsQmJOUxDg=@lists.denx.de
X-Gm-Message-State: AOJu0YyFxyV10AhMI82lMA1TSle9EQMxS5OvYY9eqOzR4AKyfKzgH9Ie
 fHBFjt/R0Yk1Zbp2E+S15I443JW4gI249eVq3qnan8XW3goJyy47nVuF1vfAvQ==
X-Gm-Gg: AY/fxX6Rx/OXnZD8+OzfQJKvhZN/YlaCj5Mofclsn1IQZG7MO336jOZaOJ3UIQW/aSu
 3jmtGI+lf4p9zTjk09npmeKdYWnJQpmG/l+PkNnw+BeWI8uVpyMI1u9lLBACuL0a9gA3/MCYGcb
 9fhwMnTXZt4j2TpLsuA0Cl/XMMCEo4nrGjaBc+Zi5C4/Y4u8r8nRo5OuUfHc71tgDBdnCJdXXgM
 56Aj2OYRTzCMBfoIvcLZlzOcxDTzHu5lMxv1tood+w0g5eJHDR2sdkY4UlRox6Oze6Yp3u7zRRX
 E9mX4AfRPgae1ROylsLtc3V6qsZSLdpDzRAZzzONQxbXqgXOSZVAxqhd4Xdb3qk4EGeWFE748zJ
 6vj/Jeh2tVZRq860FBcs9fY+KVx0Z+4bBHExZMiqB7UG0L6j2/dZTJuO19XwlYyeDDVDkB5P+i9
 IorXN/OaM+dduhk1GWJV8FXd7TkJhUM6DPcSGa7AJVHqpCVCxEq5b11HNBzufHUQEpTMjvEQXYC
 07xvJGsEPvsH131YiPiBA==
X-Google-Smtp-Source: AGHT+IGN9nP23GWk+zR0yeHvAu8lTkz6xY90vVDkOveT/0GLureDTuplkJM7wiNzUm1PEn66TnE8xA==
X-Received: by 2002:a17:902:c402:b0:2a0:c84f:412c with SMTP id
 d9443c01a7336-2a3e2d37362mr3267365ad.57.1767631976989; 
 Mon, 05 Jan 2026 08:52:56 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:52:56 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 5/7] board: Add QEMU m68k virt board support
Date: Mon,  5 Jan 2026 16:52:19 +0000
Message-ID: <20260105165221.1816070-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260105165221.1816070-1-visitorckw@gmail.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:16 +0100
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

Add support for the QEMU 'virt' machine on the m68k architecture. This
board emulates a generic machine based on the Motorola 68040 CPU
equipped with Goldfish virtual peripherals.

Introduce the necessary board configuration and initialization
infrastructure. The implementation includes logic to parse the QEMU
bootinfo interface, enabling dynamic detection of system RAM size to
adapt to the virtual machine's configuration.

Enable the Goldfish TTY driver for serial console output. Additionally,
enable Goldfish RTC and timer drivers to support real-time clock
functionality and nanosecond-resolution delays. Include comprehensive
documentation covering build instructions and usage examples.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Daniel Palmer <daniel@0x0f.com>
---
Changes in v5:
- Rebase on u-boot/next branch.
- Add 'imply CMD_DM' to TARGET_QEMU_M68K.

 arch/m68k/Kconfig                     |   9 ++
 board/emulation/qemu-m68k/Kconfig     |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS |   8 ++
 board/emulation/qemu-m68k/Makefile    |   5 ++
 board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
 configs/qemu-m68k_defconfig           |  16 ++++
 doc/board/emulation/index.rst         |   1 +
 doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
 include/configs/qemu-m68k.h           |  18 ++++
 9 files changed, 223 insertions(+)
 create mode 100644 board/emulation/qemu-m68k/Kconfig
 create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
 create mode 100644 board/emulation/qemu-m68k/Makefile
 create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
 create mode 100644 configs/qemu-m68k_defconfig
 create mode 100644 doc/board/emulation/qemu-m68k.rst
 create mode 100644 include/configs/qemu-m68k.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index de7c673c376..0cf632729da 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -183,6 +183,14 @@ config TARGET_STMARK2
         select CF_DSPI
         select M54418
 
+config TARGET_QEMU_M68K
+    bool "Support QEMU m68k virt"
+    select M68040
+    imply CMD_DM
+    help
+      This target supports the QEMU m68k virtual machine (-M virt).
+      It simulates a Motorola 68040 CPU with Goldfish peripherals.
+
 endchoice
 
 config SYS_CPU
@@ -208,6 +216,7 @@ source "board/freescale/m5329evb/Kconfig"
 source "board/freescale/m5373evb/Kconfig"
 source "board/sysam/amcore/Kconfig"
 source "board/sysam/stmark2/Kconfig"
+source "board/emulation/qemu-m68k/Kconfig"
 
 config M68K_QEMU
 	bool "Build with workarounds for incomplete QEMU emulation"
diff --git a/board/emulation/qemu-m68k/Kconfig b/board/emulation/qemu-m68k/Kconfig
new file mode 100644
index 00000000000..aae6dfe400f
--- /dev/null
+++ b/board/emulation/qemu-m68k/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_QEMU_M68K
+
+config SYS_BOARD
+	default "qemu-m68k"
+
+config SYS_VENDOR
+	default "emulation"
+
+config SYS_CONFIG_NAME
+	default "qemu-m68k"
+
+endif
diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu-m68k/MAINTAINERS
new file mode 100644
index 00000000000..90414c58465
--- /dev/null
+++ b/board/emulation/qemu-m68k/MAINTAINERS
@@ -0,0 +1,8 @@
+QEMU M68K VIRT BOARD
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	board/emulation/qemu-m68k/
+F:	board/emulation/common/
+F:	include/configs/qemu-m68k.h
+F:	configs/qemu-m68k_defconfig
+F:	doc/board/emulation/qemu-m68k.rst
diff --git a/board/emulation/qemu-m68k/Makefile b/board/emulation/qemu-m68k/Makefile
new file mode 100644
index 00000000000..5cb2886ff5a
--- /dev/null
+++ b/board/emulation/qemu-m68k/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+obj-y += qemu-m68k.o
diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
new file mode 100644
index 00000000000..3b911b95343
--- /dev/null
+++ b/board/emulation/qemu-m68k/qemu-m68k.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <asm-generic/sections.h>
+#include <asm/bootinfo.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <config.h>
+#include <dm/platdata.h>
+#include <goldfish_rtc.h>
+#include <goldfish_timer.h>
+#include <goldfish_tty.h>
+#include <init.h>
+#include <linux/errno.h>
+#include <serial.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* QEMU Virt Machine Hardware Map */
+#define VIRT_GF_RTC_MMIO_BASE  0xff007000
+#define VIRT_GF_TTY_MMIO_BASE  0xff008000
+#define VIRT_CTRL_MMIO_BASE    0xff009000
+#define VIRT_CTRL_RESET        0x01
+
+/*
+ * Theoretical limit derivation:
+ * Max Bootinfo Size (Standard Page) = 4096 bytes
+ * Min Record Size (Tag + Size)      = 4 bytes
+ * Max Records = 4096 / 4 = 1024
+ */
+#define MAX_BOOTINFO_RECORDS  1024
+
+int board_early_init_f(void)
+{
+	return 0;
+}
+
+int checkboard(void)
+{
+	puts("Board: QEMU m68k virt\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	struct bi_record *record;
+	ulong addr;
+	int loops = 0;
+
+	/* Default: 16MB */
+	gd->ram_size = 0x01000000;
+
+	/* QEMU places bootinfo after _end, aligned to 2 bytes */
+	addr = (ulong)&_end;
+	addr = ALIGN(addr, 2);
+
+	record = (struct bi_record *)addr;
+
+	if (record->tag != BI_MACHTYPE)
+		return 0;
+
+	while (record->tag != BI_LAST) {
+		if (++loops > MAX_BOOTINFO_RECORDS)
+			panic("Bootinfo loop exceeded");
+		if (record->tag == BI_MEMCHUNK) {
+			gd->ram_size = record->data[1];
+			break;
+		}
+		record = (struct bi_record *)((ulong)record + record->size);
+	}
+
+	return 0;
+}
+
+void reset_cpu(unsigned long addr)
+{
+	writel(VIRT_CTRL_RESET, VIRT_CTRL_MMIO_BASE);
+	while (1)
+		;
+}
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu(0);
+	return 0;
+}
+
+static const struct goldfish_rtc_plat rtc_plat = {
+	.base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
+};
+
+U_BOOT_DRVINFO(goldfish_rtc) = {
+	.name = "rtc_goldfish",
+	.plat = &rtc_plat,
+};
+
+static const struct goldfish_timer_plat timer_plat = {
+	.base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
+};
+
+U_BOOT_DRVINFO(goldfish_timer) = {
+	.name = "goldfish_timer",
+	.plat = &timer_plat,
+};
+
+static const struct goldfish_tty_plat serial_plat = {
+	.base = (void __iomem *)VIRT_GF_TTY_MMIO_BASE,
+};
+
+U_BOOT_DRVINFO(goldfish_serial) = {
+	.name = "serial_goldfish",
+	.plat = &serial_plat,
+};
diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
new file mode 100644
index 00000000000..f9294218429
--- /dev/null
+++ b/configs/qemu-m68k_defconfig
@@ -0,0 +1,16 @@
+CONFIG_M68K=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SYS_MONITOR_LEN=262144
+CONFIG_SYS_BOOTM_LEN=0x1000000
+CONFIG_SYS_LOAD_ADDR=0x00000000
+CONFIG_TARGET_QEMU_M68K=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_GOLDFISH=y
+CONFIG_DM_SERIAL=y
+CONFIG_SERIAL_GOLDFISH=y
+CONFIG_TIMER=y
+CONFIG_GOLDFISH_TIMER=y
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..4f7c812d493 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -15,6 +15,7 @@ Emulation
    qemu-sbsa
    qemu-x86
    qemu-xtensa
+   qemu-m68k
 
 Also see
 
diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
new file mode 100644
index 00000000000..6c4de54cf6a
--- /dev/null
+++ b/doc/board/emulation/qemu-m68k.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+QEMU m68k
+=========
+
+QEMU for m68k supports a special 'virt' machine designed for emulation and
+virtualization purposes. This document describes how to run U-Boot under it.
+
+The QEMU virt machine models a generic m68k virtual machine with Goldfish
+interfaces. It supports the Motorola 68040 CPU architecture.
+
+Building U-Boot
+---------------
+Set the CROSS_COMPILE environment variable to your m68k toolchain, and run:
+
+.. code-block:: bash
+
+    export CROSS_COMPILE=m68k-linux-gnu-
+    make qemu-m68k_defconfig
+    make
+
+Running U-Boot
+--------------
+The minimal QEMU command line to get U-Boot up and running is:
+
+.. code-block:: bash
+
+    qemu-system-m68k -M virt -cpu m68040 -nographic -kernel u-boot
+
+Note that the `-nographic` option is used to redirect the console to stdio,
+which connects to the emulated Goldfish TTY device.
+
+Hardware Support
+----------------
+The following QEMU virt peripherals are supported in U-Boot:
+
+* Goldfish TTY (Serial Console)
+* Goldfish RTC (Real Time Clock)
diff --git a/include/configs/qemu-m68k.h b/include/configs/qemu-m68k.h
new file mode 100644
index 00000000000..1d8aa92fe80
--- /dev/null
+++ b/include/configs/qemu-m68k.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef __QEMU_M68K_H
+#define __QEMU_M68K_H
+
+/* Memory Configuration */
+#define CFG_SYS_SDRAM_BASE       0x00000000
+
+/*
+ * Initial Stack Pointer:
+ * Place the stack at 4MB offset to avoid overwriting U-Boot code/data.
+ */
+#define CFG_SYS_INIT_SP_ADDR     (CFG_SYS_SDRAM_BASE + 0x400000)
+
+#endif /* __QEMU_M68K_H */
-- 
2.52.0.358.g0dd7633a29-goog

