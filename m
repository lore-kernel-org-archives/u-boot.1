Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D71BC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55BB87DC2;
	Tue, 30 Jan 2024 14:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RlVdJxDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BADC587DD2; Tue, 30 Jan 2024 14:06:37 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC1E87D8E
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6L8E076167;
 Tue, 30 Jan 2024 07:06:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706619981;
 bh=vLZ6Tu7drtYav5QULYXTXhOrbl1isQnJxxSmajcXb5o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RlVdJxDQVYhLABZUOn1YDUnuL0yZBRmBXzEReAk7LgsF7G2xjdEB9VrX7Y+mJW9N0
 b/agbV84sYbb0P1AMTx02wX6+3V7ffQ1D+Z+0+kguwA1dhLjjhtBE4CKNzIlY5GMQz
 z+a8DIvcu+oRypIU4HJveehfNDCWEfYJHMsc4XaM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UD6LLg129749
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 07:06:21 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 07:06:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 07:06:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6LoT121196;
 Tue, 30 Jan 2024 07:06:21 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 02/11] board: ti: common: Introduce a common fdt ops library
Date: Tue, 30 Jan 2024 07:06:06 -0600
Message-ID: <20240130130615.670783-3-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130130615.670783-1-nm@ti.com>
References: <20240130130615.670783-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Introduce a common fdt operations library for basic device tree
operations that are common between various boards.

The first library to introduce here is the capability to set up
fdtfile as a standard variable as part of board identification rather
than depend on scripted ifdeffery.

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V3:
- none other than picking up reviews.

V2: https://lore.kernel.org/r/20240109191506.3820908-2-nm@ti.com

 board/ti/common/Kconfig   | 12 ++++++++
 board/ti/common/Makefile  |  1 +
 board/ti/common/fdt_ops.c | 64 +++++++++++++++++++++++++++++++++++++++
 board/ti/common/fdt_ops.h | 42 +++++++++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 board/ti/common/fdt_ops.c
 create mode 100644 board/ti/common/fdt_ops.h

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 49edd98014ab..de44e4de2115 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -49,3 +49,15 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_SPI
 	imply CMD_TIME
 	imply CMD_USB if USB
+
+config TI_FDT_FOLDER_PATH
+	string "Location of Folder path where dtb is present"
+	default "ti/davinci" if ARCH_DAVINCI
+	default "ti/keystone" if ARCH_KEYSTONE
+	default "ti/omap" if ARCH_OMAP2PLUS
+	default "ti" if ARCH_K3
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
+	help
+	   Folder path for kernel device tree default.
+	   This is used along with fdtfile path to locate the kernel
+	   device tree blob.
diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index 26bf12e2e6d5..5ac361ba7fcf 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -3,3 +3,4 @@
 
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
 obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
+obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
diff --git a/board/ti/common/fdt_ops.c b/board/ti/common/fdt_ops.c
new file mode 100644
index 000000000000..eb917be9e0da
--- /dev/null
+++ b/board/ti/common/fdt_ops.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Library to support FDT file operations which are common
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <env.h>
+#include <vsprintf.h>
+#include "fdt_ops.h"
+
+void ti_set_fdt_env(const char *board_name, struct ti_fdt_map *fdt_map)
+{
+	char *fdt_file_name = NULL;
+	char fdtfile[TI_FDT_FILE_MAX];
+
+	if (board_name) {
+		while (fdt_map) {
+			/* Check for NULL terminator in the list */
+			if (!fdt_map->board_name)
+				break;
+			if (!strncmp(fdt_map->board_name, board_name, TI_BOARD_NAME_MAX)) {
+				fdt_file_name = fdt_map->fdt_file_name;
+				break;
+			}
+			fdt_map++;
+		}
+	}
+
+	/* match not found OR null board_name */
+	if (!fdt_file_name) {
+		/*
+		 * Prioritize CONFIG_DEFAULT_FDT_FILE - if that is not defined,
+		 * or is empty, then use CONFIG_DEFAULT_DEVICE_TREE
+		 */
+#ifdef CONFIG_DEFAULT_FDT_FILE
+		if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
+			snprintf(fdtfile, sizeof(fdtfile), "%s/%s",
+				 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_FDT_FILE);
+		} else
+#endif
+		{
+			snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
+				 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
+		}
+	} else {
+		snprintf(fdtfile, sizeof(fdtfile), "%s/%s", CONFIG_TI_FDT_FOLDER_PATH,
+			 fdt_file_name);
+	}
+
+	env_set("fdtfile", fdtfile);
+
+	/*
+	 * XXX: DEPRECATION WARNING: 2 u-boot versions (2024.10).
+	 *
+	 * Maintain compatibility with downstream scripts that may be using
+	 * name_fdt
+	 */
+	if (board_name)
+		env_set("name_fdt", fdtfile);
+	/* Also set the findfdt legacy script to warn users to stop using this */
+	env_set("findfdt",
+		"echo WARN: fdtfile already set. Stop using findfdt in script");
+}
diff --git a/board/ti/common/fdt_ops.h b/board/ti/common/fdt_ops.h
new file mode 100644
index 000000000000..5d304994fb6e
--- /dev/null
+++ b/board/ti/common/fdt_ops.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Library to support common device tree manipulation for TI EVMs
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#ifndef __FDT_OPS_H
+#define __FDT_OPS_H
+
+#define TI_BOARD_NAME_MAX 20
+#define TI_FDT_FILE_MAX 200
+
+/**
+ *  struct ti_fdt_map - mapping of device tree blob name to board name
+ *  @board_name: board_name up to TI_BOARD_NAME_MAX long
+ *  @fdt_file_name: device tree blob name as described by kernel
+ */
+struct ti_fdt_map {
+	const char *board_name;
+	char *fdt_file_name;
+};
+
+/**
+ * ti_set_fdt_env  - Find the correct device tree file name based on the
+ * board name and set 'fdtfile' env variable with correct folder
+ * structure appropriate to the architecture and Linux kernel's
+ * 'make install_dtbs' conventions. This function is invoked typically
+ * as part of board_late_init.
+ *
+ * fdt name is picked by:
+ * a) If a board name match is found, use the match
+ * b) If not, CONFIG_DEFAULT_FDT_FILE (Boot OS device tree) if that is defined
+ *    and not null
+ * c) If not, Use CONFIG_DEFAULT_DEVICE_TREE (DT control for bootloader)
+ *
+ * @board_name: match to search with (max of TI_BOARD_NAME_MAX chars)
+ * @fdt_map: NULL terminated array of device tree file name matches.
+ */
+void ti_set_fdt_env(const char *board_name, struct ti_fdt_map *fdt_map);
+
+#endif /* __FDT_OPS_H */
-- 
2.43.0

