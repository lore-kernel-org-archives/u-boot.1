Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA861125807
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB542840DE;
	Wed, 11 Mar 2026 14:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="OUmvJZRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEF383F6D; Wed, 11 Mar 2026 09:41:44 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9893D83F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jd
 PrqiOU0OTOq18JjyiYT7EaDZwERqJuebFFvDcGjZ0=; b=OUmvJZRbvo+wORWYx/
 pYjHAXOMYlj6ClUOY3u2ZIFT2EFUrC8eOn3Gc6RUOoSkd10JEcSO1rxm40h1UAvc
 5cIsyzsrBxqwSM1xXfYpYcz/nRZwG2t62QtYrLKcS/PSQpagYkpVi+PS2ICDfdPK
 nPJNCYlpdkpD0+24SWmnZqr/4=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S6; 
 Wed, 11 Mar 2026 16:41:32 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 4/7] mips: loongson: ls1c300 board support
Date: Wed, 11 Mar 2026 16:41:26 +0800
Message-ID: <20260311084129.12809-5-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311084129.12809-1-sgdfkk@163.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFW8Xr47Xr1xXF15uryDKFg_yoW7tr43pr
 n2kF4rGr48tw47GrZ3uFyDWFn0yw4kuFWUuFnFqr1rAr97Aa18CFnIya13try3XrWkJrW8
 ZF93WF4akFWDXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFzuAUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCvx2A12mxKr3pdAAA3n
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:15:12 +0100
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

Links:
https://dfgh.top/loongson
Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 board/loongson/ls1c300-eval/Kconfig     | 12 ++++++
 board/loongson/ls1c300-eval/MAINTAINERS |  7 ++++
 board/loongson/ls1c300-eval/Makefile    |  3 ++
 board/loongson/ls1c300-eval/board.c     | 19 +++++++++
 configs/ls1c300_defconfig               | 52 +++++++++++++++++++++++++
 include/configs/ls1c300.h               | 36 +++++++++++++++++
 6 files changed, 129 insertions(+)
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
index 00000000000..8d834333ea8
--- /dev/null
+++ b/include/configs/ls1c300.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Gao Weijie <weijie.gao@mediatek.com>
+ * based on: include/configs/mt7628.h
+ * Copyright (C) 2022-2026 Du Huanpeng <u74147@gmail.com>
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
+#define CFG_SYS_NS16550_CLK		66000000
+#define CFG_SYS_NS16550_COM1		0xbfe44000
+#define CFG_SYS_NS16550_COM2		0xbfe48000
+#define CFG_SYS_NS16550_COM3		0xbfe4c000
+#define CFG_SYS_NS16550_COM4		0xbfe4c400
+#define CFG_SYS_NS16550_COM5		0xbfe4c500
+#define CFG_SYS_NS16550_COM6		0xbfe4c600
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

