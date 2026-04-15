Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7131FF4198B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765838419C;
	Wed, 15 Apr 2026 14:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="EMtA/wii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CC284119; Wed, 15 Apr 2026 14:05:03 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816E48419C
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PY
 yX9HF2cGo2r2WULwPbWHF2s/9BE0pw9IfILZ4h1xU=; b=EMtA/wii0f5/ZQGoh6
 TyYUXZ03xurQfpV8gqEAy71phqv1Ou2HtDLXzofhAv3cLGsXsAKLLasVq8cLS8po
 6wZXJF4r7xCSKvgcccP99EQGeGGiP6DplJj2XOM/1IeUAqtlSFpaFy3QTUQlNoy2
 iCfwUm7N/2oCWHIiDghxnjuGE=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3RcLJft9p2XkzFA--.19463S6; 
 Wed, 15 Apr 2026 20:04:44 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com
Cc: Du Huanpeng <u74147@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v7 4/7] mips: loongson: ls1c300 board support
Date: Wed, 15 Apr 2026 20:04:10 +0800
Message-ID: <20260415120425.5792-5-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415120425.5792-1-sgdfkk@163.com>
References: <20260415120425.5792-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3RcLJft9p2XkzFA--.19463S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFW8Xr47Xr1xXF15uryDKFg_yoW7tryrpr
 n2kF4rGr48Jw47GrZ3uFyDWFn0yw4kuFWUuFnFgr1rAr97Aa18CFnIya13try3XrWkJrW8
 ZF93WF4akFWDXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2WlkUUUUU=
X-Originating-IP: [240e:3b0:4805:31e::3001]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbC5xwpgGnfftyJSAAA3H
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

From: Du Huanpeng <u74147@gmail.com>

- 64MiB SDRAM K9F1G08
- 4MiB spi flash
- ethernet DM9161CEP
- UART2 console

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 board/loongson/ls1c300-eval/Kconfig     | 12 ++++++
 board/loongson/ls1c300-eval/MAINTAINERS |  7 ++++
 board/loongson/ls1c300-eval/Makefile    |  3 ++
 board/loongson/ls1c300-eval/board.c     | 19 +++++++++
 configs/ls1c300_defconfig               | 52 +++++++++++++++++++++++++
 include/configs/ls1c300.h               | 38 ++++++++++++++++++
 6 files changed, 131 insertions(+)
 create mode 100644 board/loongson/ls1c300-eval/Kconfig
 create mode 100644 board/loongson/ls1c300-eval/MAINTAINERS
 create mode 100644 board/loongson/ls1c300-eval/Makefile
 create mode 100644 board/loongson/ls1c300-eval/board.c
 create mode 100644 configs/ls1c300_defconfig
 create mode 100644 include/configs/ls1c300.h

diff --git a/board/loongson/ls1c300-eval/Kconfig b/board/loongson/ls1c300-eval/Kconfig
new file mode 100644
index 00000000000..e427570a836
--- /dev/null
+++ b/board/loongson/ls1c300-eval/Kconfig
@@ -0,0 +1,12 @@
+if BOARD_LS1C300
+
+config SYS_BOARD
+	default "ls1c300-eval"
+
+config SYS_VENDOR
+	default "loongson"
+
+config SYS_CONFIG_NAME
+	default "ls1c300"
+
+endif
diff --git a/board/loongson/ls1c300-eval/MAINTAINERS b/board/loongson/ls1c300-eval/MAINTAINERS
new file mode 100644
index 00000000000..d3498b18e2b
--- /dev/null
+++ b/board/loongson/ls1c300-eval/MAINTAINERS
@@ -0,0 +1,7 @@
+LS1C300_EVAL BOARD
+M:	Du Huanpeng <u74147@gmail.com>
+S:	Maintained
+F:	board/loongson/ls1c300-eval/
+F:	include/configs/ls1c300.h
+F:	configs/ls1c300_defconfig
+F:	arch/mips/dts/ls1c300-eval.dts
diff --git a/board/loongson/ls1c300-eval/Makefile b/board/loongson/ls1c300-eval/Makefile
new file mode 100644
index 00000000000..db129c5abae
--- /dev/null
+++ b/board/loongson/ls1c300-eval/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += board.o
diff --git a/board/loongson/ls1c300-eval/board.c b/board/loongson/ls1c300-eval/board.c
new file mode 100644
index 00000000000..0eb5df1dc7b
--- /dev/null
+++ b/board/loongson/ls1c300-eval/board.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <mach/serial.h>
+
+#if defined(CONFIG_DEBUG_UART_BOARD_INIT)
+
+#define UART2_RX	36
+#define UART2_TX	37
+#define AFUNC		2
+
+void board_debug_uart_init(void)
+{
+	gpio_set_alternate(UART2_TX, AFUNC);
+	gpio_set_alternate(UART2_RX, AFUNC);
+}
+#endif
diff --git a/configs/ls1c300_defconfig b/configs/ls1c300_defconfig
new file mode 100644
index 00000000000..22d6f18cac4
--- /dev/null
+++ b/configs/ls1c300_defconfig
@@ -0,0 +1,52 @@
+CONFIG_MIPS=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="ls1c300-eval"
+CONFIG_DM_RESET=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_TEXT_BASE=0xbfc00000
+CONFIG_SPL_BSS_START_ADDR=0x80010000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_LOAD_ADDR=0x80010000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=3000
+CONFIG_SPL_SIZE_LIMIT=0x100000
+CONFIG_SPL=y
+CONFIG_ARCH_LSMIPS=y
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_ROM_EXCEPTION_VECTORS=y
+CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_FIT=y
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_LOGLEVEL=9
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x10000
+CONFIG_SPL_PAD_TO=0
+CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_NOR_SUPPORT=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_CLK=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_OF_EMBED=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK_CCF=y
+# CONFIG_INPUT is not set
+# CONFIG_POWER is not set
+CONFIG_CONS_INDEX=2
+CONFIG_SPL_SYS_NS16550_SERIAL=y
+CONFIG_SYS_NS16550_REG_SIZE=-1
+CONFIG_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_SYSRESET_WATCHDOG_AUTO=y
+CONFIG_WDT_LOONGSON=y
+# CONFIG_GZIP is not set
diff --git a/include/configs/ls1c300.h b/include/configs/ls1c300.h
new file mode 100644
index 00000000000..488d1c40330
--- /dev/null
+++ b/include/configs/ls1c300.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Gao Weijie <weijie.gao@mediatek.com>
+ * based on: include/configs/mt7628.h
+ * Copyright (C) 2022-2023 Du Huanpeng <u74147@gmail.com>
+ */
+
+#ifndef __CONFIG_LS1C300_H__
+#define __CONFIG_LS1C300_H__
+
+#define CFG_SYS_SDRAM_BASE		0x80200000
+#define CFG_SYS_INIT_SP_OFFSET		0x2000
+
+/* SPL */
+#if defined(CONFIG_SPL_BUILD)
+
+/* Serial SPL */
+#if defined(CONFIG_SPL_SERIAL)
+#define CFG_SYS_NS16550_CLK		66000000
+#define CFG_SYS_NS16550_COM1		0xbfe44000
+#define CFG_SYS_NS16550_COM2		0xbfe48000
+#define CFG_SYS_NS16550_COM3		0xbfe4c000
+#define CFG_SYS_NS16550_COM4		0xbfe4c400
+#define CFG_SYS_NS16550_COM5		0xbfe4c500
+#define CFG_SYS_NS16550_COM6		0xbfe4c600
+#endif
+
+#define CFG_MALLOC_F_ADDR		0x80100000	/* FIXME: find a proper place */
+#define CFG_SYS_UBOOT_BASE		0xbd000000
+
+#endif
+
+/* Serial common */
+#define CFG_SYS_BAUDRATE_TABLE	{ 9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600 }
+
+#endif /* __CONFIG_LS1C300_H__ */
-- 
2.43.0

