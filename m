Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD6EE4991
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79A683FAC;
	Tue, 30 Dec 2025 17:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fLDmVr9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1ED383F70; Tue, 30 Dec 2025 17:01:48 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1782E83F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso11847019b3a.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110504; x=1767715304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1Hmgs1SIt3t8sZvEx43lt/wrYmRE34pfvZtK4nDoIg=;
 b=fLDmVr9PYqf6BMyJhSHhXNGOyiQDnVfxt0LppodxDb4cKvfrzTZD9oK2Z16t4FFHGr
 mmbV6jtT1TBfrPLvayfhCENEstN36KNVq8NKeuFnYNheDDArUenhhIPrtCrgwiR98Vj1
 IstRFMxHSgqi5+rfdsk7BmUUFq06kb5m8tNWMRN5UFO342LxpG1OtHWR624SPiEQyJNS
 Ia1GYtl1qBTJFMYkBTMBHqczQQEGQDjA/0SU7wcQStFXJGg1h5MuH7WrAC+fS9+OG9GX
 y6lLPfeYphQyzloJyV7kL8ctzusna9/fT8zyoecBN/KXs3AdH0dXhfOltUlXCUAu3wso
 YBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110504; x=1767715304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A1Hmgs1SIt3t8sZvEx43lt/wrYmRE34pfvZtK4nDoIg=;
 b=NCHW7PuGdoflIGT669OeDUpGCkZ02NKlbSto9/+p5MJcuP95/JUuUxVmARDUR0igmh
 Us1+8RZyHR8UXIYYVQem6JhuluPGl1E9X2HzbdikrIWCFLPxCCddUItIXz8jjHwJeD0m
 40D8x463FPL176eXUfO9ahJ4J0G9sVttL6mNxqF5IH31+oPjyEJ35M0kYFv4J0YwCDQ3
 dGUETrX2BTzKLVnuxN6yQZM11nUNfLmjCa6PjTI1NxWFlhGDq/1zZiyCRQBHCpOFcbc6
 zlAohK4TK7pCW3VxNLEoTWZmWFShnWslDQd4QziXfaSuPRJa6Mh5BMcE3L4cCZ4OLvB5
 Y/oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUOtE3iwgFvmzXTCZSyiidT/8MW5dMe7GT3uC1k/7zw0gERqPvodMrlGGWuvCnLxgaHTH5z0I=@lists.denx.de
X-Gm-Message-State: AOJu0YyQWx2jasXsZ2qc661criBYSx9REY/8BxYBK0lpoXPJdvPdE9So
 gAncJyjlxx5Oj89zYciZ9iRQfSpKFnvqEDD3P0N1OE022yv4N2e6Lzb0
X-Gm-Gg: AY/fxX7yyNA/aL8qyZSdaO+2To3sNnMmVOAPe8/IFxZN2uKh1gtBySWLEXy2Jr1PDea
 kWMo3yw5tco6aW9yR3/B31v+xEiOOl1acQEgI56ghbAML8lSV5iCVUPIr+3TzmqA2YM9vN+k0P9
 tsFKNhSHFuwhwCKtNbG+ecn1URX2w5YakU7ALnxncKmz2Jk0jzdr32GvjlSCXyu2zSkUZ3GcbTh
 q/AcNoBW16oZjUcQ7UkGTAFFuaoDDPIgrNDAETIgFR4eWnALscYVL7DNYsLRMjIxx1S2xzgaAf8
 EK2C1r3f78tmZP1oaGsUEm3oGOX2G3kHpFms0QSEC/b1CdOpJ834uHR6y9DOZqaGmogfV4eUDvV
 PMMu2j2HlL0a0mxrgWoncEfxbNXV82YrTsyopQfJmtJJJWrDlkk7isCZRI0LgQlZvdXvA6Yz0rZ
 Y2y3h1nfjPR3JgNGPLqgUuxQPgNR0kCk7c79FFAvgmat7RZdA6XVSNYa8wfGzkrKL9lwElyY1/e
 05O3W6fFsPebTWrWNQt8g==
X-Google-Smtp-Source: AGHT+IG1rLhKMfxONHbA6nUQRA/l1Y36GTxntLM/5Oluz+M2qsAcom6YY9LFFxHh5FZFHvX1Tf6PCg==
X-Received: by 2002:a05:6a20:3c8f:b0:34f:4459:a68 with SMTP id
 adf61e73a8af0-376a88cb3c2mr26545118637.27.1767110504205; 
 Tue, 30 Dec 2025 08:01:44 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c8a2sm28558883a12.6.2025.12.30.08.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:01:43 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 5/6] board: Add QEMU m68k virt board support
Date: Tue, 30 Dec 2025 16:01:11 +0000
Message-ID: <20251230160112.3045527-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230160112.3045527-1-visitorckw@gmail.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Dec 2025 17:55:53 +0100
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
---
Changes in v3:
- Enable Goldfish RTC and timer support.
- Add safety loop limit to dram_init bootinfo parsing.
- Use ALIGN() macro for address alignment.
- Update documentation.

 arch/m68k/Kconfig                     |   8 ++
 board/emulation/qemu-m68k/Kconfig     |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS |   8 ++
 board/emulation/qemu-m68k/Makefile    |   5 ++
 board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
 configs/qemu-m68k_defconfig           |  16 ++++
 doc/board/emulation/index.rst         |   1 +
 doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
 include/configs/qemu-m68k.h           |  18 ++++
 9 files changed, 222 insertions(+)
 create mode 100644 board/emulation/qemu-m68k/Kconfig
 create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
 create mode 100644 board/emulation/qemu-m68k/Makefile
 create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
 create mode 100644 configs/qemu-m68k_defconfig
 create mode 100644 doc/board/emulation/qemu-m68k.rst
 create mode 100644 include/configs/qemu-m68k.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index de7c673c376..605ae5ec20c 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -183,6 +183,13 @@ config TARGET_STMARK2
         select CF_DSPI
         select M54418
 
+config TARGET_QEMU_M68K
+    bool "Support QEMU m68k virt"
+    select M68040
+    help
+      This target supports the QEMU m68k virtual machine (-M virt).
+      It simulates a Motorola 68040 CPU with Goldfish peripherals.
+
 endchoice
 
 config SYS_CPU
@@ -208,6 +215,7 @@ source "board/freescale/m5329evb/Kconfig"
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

