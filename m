Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4A7E8FDBE
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE1683B27;
	Sat, 27 Dec 2025 00:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pv9oaDX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3691839FA; Fri, 26 Dec 2025 18:54:36 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69EA7838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo8349773b3a.2
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766771673; x=1767376473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvdAIoZJCjAYVL2gh/7iLWqPBJF8cbBnVLtHG+PLSX8=;
 b=Pv9oaDX9sP5RoklhKoKAEoFPLe2EVxYorV/Jh8tOtU/ks/d3UxzxbAELlCzYkyjhTx
 aYKRnelnTf3OppCETIZlIbwRNCvVxhtj6iHdEtIOjzgT5EKNp7b5kMSibVd4uYAT19h3
 WtxGneRjeUzW0RPUX7T/jY6jZc/hluzSaMygvZHWZn7LJP9oeQjK3NR/xj6E7n3nueLI
 uYWTjezku69+FTeayXsIDgx7yOpvMgf3V5NevP1agvm6RyRuVojtrJRxszYunFK0zNni
 j9Ws6B1Z4QsIO2bJ0dyFFeI4Mx8MY6Ew0Lvnv96OZW95t5h+pxmPZKxuo38AfHztop2Q
 p1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771673; x=1767376473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GvdAIoZJCjAYVL2gh/7iLWqPBJF8cbBnVLtHG+PLSX8=;
 b=v7kdsxfw1rM05Cr3ZkaXbYdcsyP9X0hXuC3ZMNmW2oGijYNYco4UHcBNFftGfzc7j/
 A8srl4/9VZcavG9n7yDjVVurp5evvgTf0qO8+PTQmI/ocR7InI0xW8OcufScvnxRwxcl
 Avr63ziAP+KNq51efdYg1zPKAgqzja5xVWkANbPZyuWxSyE6Y0Qj51Iio0LL7/OZdzlo
 Zt6Y0g4UMMQkC7AiskdtejXpQInb5UpGRjFo45h3LLpW+QH7kf2w45I8xzVpHwpI85XF
 OYCf3PzejqZ6krJuO9zNGXF9KRqafhqKYf0YX/5acs1hXecx0I5K3YpA4oSLgQlRascz
 rAWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBSD9qEqtp/f3s2eSb1yOB63vmExwmd+rwNW2sZKNSj6nWlkAcjsW6vyZ3L9ZISmOEG3FY534=@lists.denx.de
X-Gm-Message-State: AOJu0YwrIixpJ2uVHiohlq70ozCuysjHoaYEj/oeNFb3Mf2Z0zJSa1yk
 1MAEKvuV7OWrcaz3KIkzTR1SJ6pkfw7xzWWHPK4t+aNzoii4BOUyd18p
X-Gm-Gg: AY/fxX5IhB11ROI4GZCCVTUefY/6zoiekR+Qf0tUQSRjoC/a/H9efngVJJcmmmCnyBv
 qp3sOeCDOPUG3G2pUrNB0f+JX6xPIepSf5K5XZMqE5gdnNl9o6x1ee2BPIKYfZ05VjZ7sMYjQjk
 hNui8E0YyTQwM1Dfs6PqMnb9EAZv1RsSsy8bq8YMoO9ldLFyFVmNEvRyVfE1bzfi8v/AOJNEduM
 vJ/5teJUHLEq7acO3OCdwsLumYjute9JNvpd5656dPQ0mprwdW4o3LvGa7UPTjWOtFNlEvrtw6g
 9EAR6LcOvnj3em8rsErnh+h+wHsrEFeH6yQlB0WFiFU2oQygVXeYKVHwGGZ1x0S47tArT1/7bvp
 kN9bZd8744yGQn8EwpDqlBGW3U18SkuyjnunNuwdoodxpXOxzFi6Fz8Hrl8GwP14s5iqx0vOgI4
 eQqPLe/hQRBE564ZoKyIvn14YAMR4Cvd9iNBZ+f/sA/fCxXwEJ2SWfMoiVt1SeSXEK9JD+htZ2I
 J6Cd6diXQ0ENOU8uF6Jtg==
X-Google-Smtp-Source: AGHT+IFTgZcrMzn1117BSzjVuZcVjdYQhoyvpPvt5ABUlwdl3alWHtFhhQ04as/TTlqAB8pOS50OIA==
X-Received: by 2002:a05:6a00:340b:b0:7aa:81fc:a83a with SMTP id
 d2e1a72fcca58-7ff657a107emr23270257b3a.6.1766771672843; 
 Fri, 26 Dec 2025 09:54:32 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a0595sm22463704b3a.44.2025.12.26.09.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:54:32 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 3/4] board: Add QEMU m68k virt board support
Date: Fri, 26 Dec 2025 17:53:59 +0000
Message-ID: <20251226175400.1154417-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251226175400.1154417-1-visitorckw@gmail.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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

Enable the Goldfish TTY driver to provide a serial console, which
facilitates interaction when running QEMU with the -nographic option.
Additionally, include comprehensive documentation covering build
instructions and usage examples to guide users in deploying U-Boot
within the virtualization environment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Update SPDX license identifier to GPL-2.0-or-later.
- Sort header inclusions alphabetically.
- Fix tabs vs spaces in MAINTAINERS.
- Add qemu-m68k entry to doc/board/emulation/index.rst.
- Regenerate defconfig using make savedefconfig.

 arch/m68k/Kconfig                     |  8 +++
 board/emulation/qemu-m68k/Kconfig     | 12 ++++
 board/emulation/qemu-m68k/MAINTAINERS |  8 +++
 board/emulation/qemu-m68k/Makefile    |  5 ++
 board/emulation/qemu-m68k/qemu-m68k.c | 84 +++++++++++++++++++++++++++
 configs/qemu-m68k_defconfig           | 12 ++++
 doc/board/emulation/index.rst         |  1 +
 doc/board/emulation/qemu-m68k.rst     | 38 ++++++++++++
 include/configs/qemu-m68k.h           | 18 ++++++
 9 files changed, 186 insertions(+)
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
index 00000000000..89e66050bb9
--- /dev/null
+++ b/board/emulation/qemu-m68k/qemu-m68k.c
@@ -0,0 +1,84 @@
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
+#include <goldfish_tty.h>
+#include <init.h>
+#include <linux/errno.h>
+#include <serial.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* QEMU Virt Machine Hardware Map */
+#define VIRT_GF_TTY_MMIO_BASE  0xff008000
+#define VIRT_CTRL_MMIO_BASE    0xff009000
+#define VIRT_CTRL_RESET        0x01
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
+
+	/* Default: 16MB */
+	gd->ram_size = 0x01000000;
+
+	/* QEMU places bootinfo after _end, aligned to 2 bytes */
+	addr = (ulong)&_end;
+	if (addr & 1)
+		addr++;
+
+	record = (struct bi_record *)addr;
+
+	if (record->tag != BI_MACHTYPE)
+		return 0;
+
+	while (record->tag != BI_LAST) {
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
index 00000000000..db6c9b1c771
--- /dev/null
+++ b/configs/qemu-m68k_defconfig
@@ -0,0 +1,12 @@
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
+CONFIG_DM_SERIAL=y
+CONFIG_SERIAL_GOLDFISH=y
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
index 00000000000..36e51e8107f
--- /dev/null
+++ b/doc/board/emulation/qemu-m68k.rst
@@ -0,0 +1,38 @@
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

