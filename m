Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B941EED616
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 21:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0552840EE;
	Thu,  1 Jan 2026 22:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FMvO+2OB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567FE83C40; Thu,  1 Jan 2026 18:54:56 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E551683BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso153428345ad.3
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767290092; x=1767894892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sY/t5MK2ZiHAASL99wDkSQAXekgClLc/+z7klFcMpw=;
 b=FMvO+2OBWBZyud9vVkZVJduZYdtY7s24VyYqwRo8xKZ5htEsE+4S4VmENkX0SdKFVW
 JsoLvey1ZCMtZ8ly3A5fiT0RCjLhaeuqRYBMsqQXB23azY03kpAZnT2swwf47RU5H7gA
 8EQh9uKxYMZa+3qvaCO+TnQp10oWC2RyZGGTdZ3iC3A1djf3nRskPZtU0QWfkDKOFiyL
 Tec2wZjMDDEKvPbQSvxUoebdxfWgh82VpFYGwGNQUI1PM0U/X5QAecb2+xKbEHb/jwf8
 2MZMorYiJpsyJ/FIV+b0KO5HQgXBz0lpGNyf2xCviI8lDZQpS0/j+4K9D4DYJ+KS3fDI
 CULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767290092; x=1767894892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7sY/t5MK2ZiHAASL99wDkSQAXekgClLc/+z7klFcMpw=;
 b=c3zYufUJR5SWOcgxugAEYACjkzkP5GXOX4gxDD+pTqWBA4c0vX41BWZVfPEAYa8ZKl
 SUIXW9772jgTDSCIAtAtCQjrz0XJ5zHnmD5bFnvI6TGPWxusUPXBagNWBojoYWw54xLp
 bM3ZXj7/0IIM9PeMD4KD+cG3Osc8MDM+ukaNMl20EeLjgkgS2e/VVeJs/ZyfPQPE+uAu
 ZqwS6H2RqMlEQ3Hmnsp0+hPOLS05XxpjK37CzAxjhSa6eBL1jdc7y7Xt2+faNRXiyYBC
 pRXzK1xPonrEW8ybveY0JjwPoe+tpgwZXK7tkNxiTg1ux+CHpYcq+0u9An+3d1BnAy7Q
 vdRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBE4glMyPRsNlwOXlk1VwBbxAqrevEWsWwuun/IGPYGyQ8A/H9EIzXNHjVPKLGNCqW2rtVQc=@lists.denx.de
X-Gm-Message-State: AOJu0YxnuEntYtVCpS+r6o6NexvoV/LSEuEiS3lnMc/Etnw63ATcCBof
 u14gEOwMBkrfBjEMj4klm1mBqS3LctGYw9IDgFbKvUndOe7wfY7qAx0Z
X-Gm-Gg: AY/fxX6lHEemziWtqLgr2YfpN976ga+S55xf8DA7bI1RrV8ZDq/lkW0YuzSTBrhzuW9
 yer1ztr9VZmUaoZwGPHO5SoNtEKrU4yp72tBm/14Ll697FgkUCVfrdgmW2zJuTAjohBjLExGDaL
 OoigCSFRRFW03Qwll+HTM9JAta+30/EL3Bga6YOOZrAdbbijquxa6+XT5bsOVTc0mzNNwPCyR0K
 5OarpLdDLR33Vq6QClyZS51LDDi+5rQooRSFs8GExYqyd54mbImnh0qELOU7Df718wGru4MRAeR
 v6yqefFH8Wbt6d8Z0LHot69kvWQ2w3+xp1+CjYx1/NhYkalaFt+mL2a4ZxGrtMpKX8lYJEya/WZ
 EfdufIZA13uoZ/6qjjN+qG4Ki8C6t/eDg2qdHZLK/C6EXBkjs2OmspdrAjBYWC1IMZPTtZXOXe8
 X9ETbLK8ddwy4ohytVeJsowoekjOXXYhAMfTtf6Osp9gde6aRUxVzIXyl0Dra1WxhBkS1w+9m+Y
 LEvolIpqsMiq0sGvKmSR1HhmreqjpTQ
X-Google-Smtp-Source: AGHT+IFb1LNsdq1JlAsyZDemOMwat6MIGSVPQP/hZzuZIfVhX2QfhKY0PRwoaC9vw2MuwIqturQxRQ==
X-Received: by 2002:a17:903:910:b0:29e:9e97:ca70 with SMTP id
 d9443c01a7336-2a2f232774fmr331698565ad.25.1767290092317; 
 Thu, 01 Jan 2026 09:54:52 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3a8770e66sm40000615ad.42.2026.01.01.09.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:54:52 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 5/6] board: Add QEMU m68k virt board support
Date: Thu,  1 Jan 2026 17:54:19 +0000
Message-ID: <20260101175420.4118024-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260101175420.4118024-1-visitorckw@gmail.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Jan 2026 22:15:35 +0100
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
No changes in v4.

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

