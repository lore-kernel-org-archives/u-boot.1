Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9AFD6E2DD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166DD83734;
	Thu, 18 Dec 2025 20:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EU90k2Ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1FFA800AB; Thu, 18 Dec 2025 19:53:35 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480CA8003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 19:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso681045a91.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766084012; x=1766688812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLtlbXtUwx7TwQOkOrSQlwTN8yGlnIs4PVkEFEMKuMg=;
 b=EU90k2EeWo6OYAWl9J98QykBLumRZ7/x96KuZH5wmOrQd9qqOYYIpWwOywMbTHXyc2
 Axk6wkFaRx4tHZ7RfUsoBODl447FEknmpKZ3kdhTj3bh0IuVpHo1tJ+nYBbCG1VX5+hv
 SYrMZfYtZ80Q8/K0uBo3m22WtDcMHNEayOmAjcgXQRlJBHAiazf2BKMScpNANV3wj+mD
 nNcV1OrGCx3yMknIYtD7XTAQ0UcN64rvvLKvuIHMtO/Ddl3YIxOA5Ll9OHjTCd/g3gsU
 aIV/UNoHOo937w9tiQS4Z2HaWqxUU9BsqePfDL9zZMkGBIAWI/2xt4JkEyvJPZcHceKa
 BCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084012; x=1766688812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLtlbXtUwx7TwQOkOrSQlwTN8yGlnIs4PVkEFEMKuMg=;
 b=LZNdjxUKX1D1PISzsjnDwSTLJ3gaYM23kebLzj4x158Is81zpwrzSB+awL+nLmZPMb
 6FaLgq4Igfk3NxJS7Rg60Cvam3ZDgpL1vJm+uKfKuiFOfkXTdfw/tQdhPr/7tCFw8ben
 jIaBM2GQKjzwEh26wMjar4ZbHFgTlbqD/eKXEeu44/2PFCHlpTkd2fZ1VztOTbi4ZZO4
 5hrqAZwkanfcjcRsZb0xWAO2NDBRE1VbldQvu3bjOrO2uCfqKLSLJLkRxkgBvMBYzeZk
 IuvNdxhlFNPBTG85ASkAfzMFWOX2FsucGuz3CqNF8SZCLkwaya+M77o95xCJCj+ytroL
 xPZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw09Df3+hoLHXZYCaCp49M3h5J4ievOzvkcDSh0xCNTqchGLwltwafUyz7elDBWGQRdbBuzO4=@lists.denx.de
X-Gm-Message-State: AOJu0YwSk1YwKMj7318ra7XRIJ6e9GFITMst/crwLFz0TzKp1ryptA18
 JlZu8KoTatHuYaHQd8c/d1g5f+dpLCC+h3s8jYAFTuQP40Y+XJhZqePb
X-Gm-Gg: AY/fxX5rt4mC2AMwZeX14rhXO4wlYPmDHOZJYsliLYJxR54O9MfTDLent3Rbx4qKIdR
 AeAGjBDjldT2mfrP+MYcbgWsVUCouFc7saU2Dsq3mJ/Wn0tRQKYIUqjo9q5FEXEaheHjahiwC6Q
 XH7zeM7ad2bH39x7FHwnHJ/RgzEDRGNfTeTlKBibmpDF9HIkZmpcG/QzUpFZBWs5Hp0Gj0DHre3
 V43Bj44dm1JBINg9G3ZeufxVOw/trnF8IzyMe+JjjDJZADoyDBd3aC0TfWHRTBVQIhQ8hEEmF1l
 KrtwH+fAleBdJwNrIkiBSGcZNvERfDwsyKjvBIkqsSFfyuJCry7Hk1EJ0ws9FQRWI8S64frzUFh
 7wZETxWsLOce52TCnh21T65buCKSahg7HHF06WdAFnhY7F+Z31aYfOYgU4lKbIj5bI1yF2yukWL
 0new36CSckajqyem8MgJpShrsVYoDnmG6kUk3lQMQ4lPpSaqR6xJZX0gpryAhnrNtNTDuGtPmm1
 VRNSCdl+dUoPUWRBTM2yQ==
X-Google-Smtp-Source: AGHT+IHonXkpuObOZf1WcyiU49TdnKxvZrW/1jpuDzlmJovPu7sCaoisN+rDY6hEYvJRuhIb0bGdVg==
X-Received: by 2002:a17:90b:37c3:b0:340:be4d:a718 with SMTP id
 98e67ed59e1d1-34e92113213mr314922a91.7.1766084011571; 
 Thu, 18 Dec 2025 10:53:31 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d65653sm3136275a91.5.2025.12.18.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:53:31 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/3] board: Add QEMU m68k virt board support
Date: Thu, 18 Dec 2025 18:52:52 +0000
Message-ID: <20251218185252.957388-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
In-Reply-To: <20251218185252.957388-1-visitorckw@gmail.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 20:05:51 +0100
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
 arch/m68k/Kconfig                     |  8 +++
 board/emulation/qemu-m68k/Kconfig     | 12 ++++
 board/emulation/qemu-m68k/MAINTAINERS | 10 ++++
 board/emulation/qemu-m68k/Makefile    |  5 ++
 board/emulation/qemu-m68k/qemu-m68k.c | 84 +++++++++++++++++++++++++++
 configs/qemu-m68k_defconfig           | 17 ++++++
 doc/board/emulation/qemu-m68k.rst     | 38 ++++++++++++
 include/configs/qemu-m68k.h           | 18 ++++++
 8 files changed, 192 insertions(+)
 create mode 100644 board/emulation/qemu-m68k/Kconfig
 create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
 create mode 100644 board/emulation/qemu-m68k/Makefile
 create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
 create mode 100644 configs/qemu-m68k_defconfig
 create mode 100644 doc/board/emulation/qemu-m68k.rst
 create mode 100644 include/configs/qemu-m68k.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index a41c375f6be..afc21dc2bc3 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -179,6 +179,13 @@ config TARGET_STMARK2
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
@@ -207,6 +214,7 @@ source "board/freescale/m5329evb/Kconfig"
 source "board/freescale/m5373evb/Kconfig"
 source "board/sysam/amcore/Kconfig"
 source "board/sysam/stmark2/Kconfig"
+source "board/emulation/qemu-m68k/Kconfig"
 
 config M68K_QEMU
 	bool "Build with workarounds for incomplete QEMU emulation"
diff --git a/board/emulation/qemu-m68k/Kconfig b/board/emulation/qemu-m68k/Kconfig
new file mode 100644
index 00000000000..e4001d67288
--- /dev/null
+++ b/board/emulation/qemu-m68k/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_QEMU_M68K
+
+config SYS_BOARD
+    default "qemu-m68k"
+
+config SYS_VENDOR
+    default "emulation"
+
+config SYS_CONFIG_NAME
+    default "qemu-m68k"
+
+endif
diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu-m68k/MAINTAINERS
new file mode 100644
index 00000000000..c2f4cc40a56
--- /dev/null
+++ b/board/emulation/qemu-m68k/MAINTAINERS
@@ -0,0 +1,10 @@
+QEMU M68K VIRT BOARD
+M:  Kuan-Wei Chiu <visitorckw@gmail.com>
+S:  Maintained
+F:  board/emulation/qemu-m68k/
+F:  board/emulation/common/
+F:  include/configs/qemu-m68k.h
+F:  configs/qemu-m68k_defconfig
+F:  arch/m68k/cpu/m68040/
+F:  arch/m68k/include/asm/bootinfo.h
+F:  doc/board/emulation/qemu-m68k.rst
diff --git a/board/emulation/qemu-m68k/Makefile b/board/emulation/qemu-m68k/Makefile
new file mode 100644
index 00000000000..036b7596c18
--- /dev/null
+++ b/board/emulation/qemu-m68k/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+obj-y += qemu-m68k.o
diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
new file mode 100644
index 00000000000..92da828eed3
--- /dev/null
+++ b/board/emulation/qemu-m68k/qemu-m68k.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <config.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm-generic/sections.h>
+#include <linux/errno.h>
+#include <asm/io.h>
+#include <dm/platdata.h>
+#include <serial.h>
+#include <goldfish_tty.h>
+#include <asm/bootinfo.h>
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
index 00000000000..765ed9b7424
--- /dev/null
+++ b/configs/qemu-m68k_defconfig
@@ -0,0 +1,17 @@
+CONFIG_M68K=y
+CONFIG_TARGET_QEMU_M68K=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_SYS_LOAD_ADDR=0x00000000
+CONFIG_SYS_MONITOR_LEN=262144
+CONFIG_SYS_BOOTM_LEN=0x1000000
+CONFIG_SYS_MALLOC_LEN=0x20000
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_BAUDRATE=115200
+
+# CONFIG_OF_CONTROL is not set
+CONFIG_DM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SERIAL_GOLDFISH=y
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SYS_LDSCRIPT="arch/m68k/cpu/m68040/u-boot.lds"
+CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
new file mode 100644
index 00000000000..19898e17cfc
--- /dev/null
+++ b/doc/board/emulation/qemu-m68k.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0+
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
index 00000000000..90f59c7b850
--- /dev/null
+++ b/include/configs/qemu-m68k.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
2.52.0.322.g1dd061c0dc-goog

