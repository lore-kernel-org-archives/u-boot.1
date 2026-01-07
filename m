Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5508D0D16D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E440840B0;
	Wed,  7 Jan 2026 21:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EtTTaP9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB21840D7; Wed,  7 Jan 2026 21:19:31 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E40839A5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34e90f7b49cso1607544a91.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817166; x=1768421966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Itdr/1ukzYUTTGedwYGPos9Pz8nwG5kinScyDnqcHlU=;
 b=EtTTaP9PwhBW6xA5xRoIHopdNlHW4IHETdl0t4p/99PBlctmpHYcFi5XbbboLul70k
 07F8FoX9b4v7nzeA1WdkkLKmpfEE6tEOd287o1vVzqiXW6U/3jtu85VhUPwN4aAkdm9U
 gV57whZYqSyaoJVlsYsdGnhwDwGG+vSXvHP/U/0SVXTjhuikREpIHx5eKemqpZ7D2I9t
 p1OoFzU5/Yf38IrtVhBk/4glrcspY3KU4UHv9AKq7g/Jl2wnveioswEu/57G2w4Thczq
 2rK3T1GH7OH3CJQCT2hTZsl6xQyry6IfNwyE2rPW7PD1hSirScGV3mwG+9l9ptXwRosg
 G2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817166; x=1768421966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Itdr/1ukzYUTTGedwYGPos9Pz8nwG5kinScyDnqcHlU=;
 b=e/j2oiseBCnTg3DpGlN+XHfwxV8VLvPQpYnZyphhgn5y8zpQkVVcCCpylTkjun2qFO
 nqfkg4PnYUc+V+JAW9zecknRMM5Rb25c0FFClpj5M5pUiJg7osgzTNzAH4dWLLoEOUqz
 Lra6thNgqOX3TEX2d3BOAVplpN8v+UqeewuJMZu3dq5WDyVmWw4wiBEry5NGuhnJq1Ro
 QkXLdHIA3urbzzN03EAMM/mdeDoNMGOBzcVkWsbaSjNaM+DK3czojqJwTBJe2kpoL8lR
 Kq5qstEaP/z3UiOWCeejthOxWuED4XB/YvpoVcLJo/5TLrlvt6oaDJ1xKBjHn7roR4b8
 vZXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0JT+VXD7bx0FDQb7MqZvd4W4QcbkB6ZG+9zmKAhLWs8qrd5L3AgPEwIrRv2gfqQkjAU2IE5s=@lists.denx.de
X-Gm-Message-State: AOJu0YzsDnLHMgEbZ15SCJ55fLhDdVRIKv2n0TNVKYRXUitd05w/IZOs
 hiZNjDTzAWL5/e4R8kYBoAq8xFlDeIrXgpUliDUIgO4C0VG27qglD16d
X-Gm-Gg: AY/fxX4GSmdPLNk9gUdAegE0O976cqcPQfq4Cyfv+tZnghlJDLC6ejNv21mBLe/ksgZ
 WEtURL/TxEw3bkcZfJ4lQ1ziwiQS9tAQ8TjiwMb6xEPZKWVabXy2jnvXjZL030N9U0falqugjeP
 mt6guRzeCIx4A4gK4ZAIrOpZtSagEsFXRN6oIrmjPvBuF2cdiLq4MABOlLUq/HF2ti7QRAWBKsO
 Xo41dBVyvY6wZB8jR95E1540nUwGEEFQ2n9+U4ZN7pfcXN8hFggaXo8ZbgvVy4RbEyF3TLe3CPv
 UbC5wbf0kYsANTIvwfJoRwaZ4ozimMWSaFhOK6OoZ0NqLcgBGKSpJHvTs3RrYfd6Eg2OBXPe8y5
 YBN0gYA3EuJhezzLEEJ+Rmr2ggIaGVPoXWyn7TuIQHJXE7Zg9u/C0oTRV8pdyJLAmj6QOAF5sK4
 crhRNqxB7FjYxpqvPcwe7GXjYDSfMX076+Q7/LWU5HZ1uAhBkrZVuZti2wNrZPRZ/NTx0PAtx7z
 Gs92QLXElUS8H7POwIHFoNHJhjF/FMd
X-Google-Smtp-Source: AGHT+IG4LbQNVTbM8YqHrbdsMQeemlTCLzSSqg/0BgrN2vKnQEcMmJLoKOCmqdXFFFH52VbZsQg05w==
X-Received: by 2002:a17:90b:2f90:b0:34e:5516:6655 with SMTP id
 98e67ed59e1d1-34f68c4f92bmr3082914a91.9.1767817165736; 
 Wed, 07 Jan 2026 12:19:25 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:25 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v6 6/8] board: Add QEMU m68k virt board support
Date: Wed,  7 Jan 2026 20:18:35 +0000
Message-ID: <20260107201838.3448806-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:37 +0100
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
Changes in v6:
- Move bootinfo parsing logic to a helper function called in
  board_early_init_f.
- Remove hardcoded MMIO address macros; use values parsed from
  bootinfo.
- Use the new sysreset driver via U_BOOT_DRVINFO.
- Use SZ_16M macro for default RAM size.
- Update header include order to match coding style.
- Fix blank line formatting in checkboard().

 arch/m68k/Kconfig                     |   9 ++
 board/emulation/qemu-m68k/Kconfig     |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS |   8 ++
 board/emulation/qemu-m68k/Makefile    |   5 ++
 board/emulation/qemu-m68k/qemu-m68k.c | 117 ++++++++++++++++++++++++++
 configs/qemu-m68k_defconfig           |  20 +++++
 doc/board/emulation/index.rst         |   1 +
 doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
 include/configs/qemu-m68k.h           |  18 ++++
 9 files changed, 229 insertions(+)
 create mode 100644 board/emulation/qemu-m68k/Kconfig
 create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
 create mode 100644 board/emulation/qemu-m68k/Makefile
 create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
 create mode 100644 configs/qemu-m68k_defconfig
 create mode 100644 doc/board/emulation/qemu-m68k.rst
 create mode 100644 include/configs/qemu-m68k.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index f5c0dc037b4..774b119cb4b 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -194,6 +194,14 @@ config TARGET_STMARK2
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
@@ -222,6 +230,7 @@ source "board/freescale/m5329evb/Kconfig"
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
index 00000000000..d3527aee112
--- /dev/null
+++ b/board/emulation/qemu-m68k/qemu-m68k.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <config.h>
+#include <goldfish_rtc.h>
+#include <goldfish_timer.h>
+#include <goldfish_tty.h>
+#include <init.h>
+#include <qemu_virt_ctrl.h>
+#include <serial.h>
+#include <asm-generic/sections.h>
+#include <asm/bootinfo.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <dm/platdata.h>
+#include <linux/errno.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct goldfish_tty_plat serial_plat;
+static struct goldfish_rtc_plat rtc_plat;
+static struct goldfish_timer_plat timer_plat;
+static struct qemu_virt_ctrl_plat reset_plat;
+
+/*
+ * Theoretical limit derivation:
+ * Max Bootinfo Size (Standard Page) = 4096 bytes
+ * Min Record Size (Tag + Size)      = 4 bytes
+ * Max Records = 4096 / 4 = 1024
+ */
+#define MAX_BOOTINFO_RECORDS  1024
+
+static void parse_bootinfo(void)
+{
+	struct bi_record *record;
+	ulong addr;
+	int loops = 0;
+
+	/* QEMU places bootinfo after _end, aligned to 2 bytes */
+	addr = (ulong)&_end;
+	addr = ALIGN(addr, 2);
+
+	record = (struct bi_record *)addr;
+
+	if (record->tag != BI_MACHTYPE)
+		return;
+
+	while (record->tag != BI_LAST) {
+		phys_addr_t base = record->data[0];
+
+		if (++loops > MAX_BOOTINFO_RECORDS)
+			panic("Bootinfo loop exceeded");
+
+		switch (record->tag) {
+		case BI_VIRT_GF_TTY_BASE:
+			serial_plat.reg = base;
+			break;
+		case BI_VIRT_GF_RTC_BASE:
+			rtc_plat.reg = base;
+			timer_plat.reg = base;
+			break;
+		case BI_VIRT_CTRL_BASE:
+			reset_plat.reg = base;
+			break;
+		case BI_MEMCHUNK:
+			gd->ram_size = record->data[1];
+			break;
+		}
+		record = (struct bi_record *)((ulong)record + record->size);
+	}
+}
+
+int board_early_init_f(void)
+{
+	parse_bootinfo();
+
+	return 0;
+}
+
+int checkboard(void)
+{
+	puts("Board: QEMU m68k virt\n");
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	/* Default: 16MB */
+	if (!gd->ram_size)
+		gd->ram_size = SZ_16M;
+
+	return 0;
+}
+
+U_BOOT_DRVINFO(goldfish_rtc) = {
+	.name = "rtc_goldfish",
+	.plat = &rtc_plat,
+};
+
+U_BOOT_DRVINFO(goldfish_timer) = {
+	.name = "goldfish_timer",
+	.plat = &timer_plat,
+};
+
+U_BOOT_DRVINFO(goldfish_serial) = {
+	.name = "serial_goldfish",
+	.plat = &serial_plat,
+};
+
+U_BOOT_DRVINFO(sysreset_qemu_virt_ctrl) = {
+	.name = "sysreset_qemu_virt_ctrl",
+	.plat = &reset_plat,
+};
diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
new file mode 100644
index 00000000000..d667791d93b
--- /dev/null
+++ b/configs/qemu-m68k_defconfig
@@ -0,0 +1,20 @@
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
+CONFIG_CMD_POWEROFF=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_GOLDFISH=y
+CONFIG_DM_SERIAL=y
+CONFIG_SERIAL_GOLDFISH=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_QEMU_VIRT_CTRL=y
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
2.52.0.457.g6b5491de43-goog

