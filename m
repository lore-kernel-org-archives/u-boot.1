Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E335BE66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B956893F5;
	Sat, 23 Nov 2024 22:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB710893A5; Sat, 23 Nov 2024 20:57:06 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk
 [IPv6:2a00:1098:84:22e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B582D891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id 328BD407DD;
 Sat, 23 Nov 2024 19:56:37 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] Add a command to find a load address
Date: Sat, 23 Nov 2024 11:55:02 -0800
Message-ID: <20241123195616.305687-4-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

From: Matthew Garrett <mgarrett@aurora.tech>

For systems with more complicated firmware, the firmware memory map may
vary significantly based on a number of factors. This makes it difficult to
pick a hardcoded load address. Add a command for finding an available
address with sufficient room to load the provided path.

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 cmd/Kconfig     |  7 ++++
 cmd/Makefile    |  1 +
 cmd/addr_find.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 cmd/addr_find.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ee85928ca21..5ed6a50121c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -128,6 +128,13 @@ config CMD_ACPI
 	  between the firmware and OS, and is particularly useful when you
 	  want to make hardware changes without the OS needing to be adjusted.
 
+config CMD_ADDR_FIND
+        bool "addr_find"
+	help
+	  This command searches for an unused region of address space
+	  sufficiently large to hold a file. If successful, it sets the
+	  loadaddr variable to this address.
+
 config CMD_ADDRMAP
 	bool "addrmap"
 	depends on ADDR_MAP
diff --git a/cmd/Makefile b/cmd/Makefile
index 16fd8dcd723..38cb7a4aea5 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -15,6 +15,7 @@ obj-y += version.o
 obj-$(CONFIG_CMD_ARMFFA) += armffa.o
 obj-$(CONFIG_CMD_2048) += 2048.o
 obj-$(CONFIG_CMD_ACPI) += acpi.o
+obj-$(CONFIG_CMD_ADDR_FIND) += addr_find.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_AES) += aes.o
 obj-$(CONFIG_CMD_ADC) += adc.o
diff --git a/cmd/addr_find.c b/cmd/addr_find.c
new file mode 100644
index 00000000000..b187337d885
--- /dev/null
+++ b/cmd/addr_find.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Aurora Innovation, Inc. Copyright 2022.
+ *
+ */
+
+#include <blk.h>
+#include <config.h>
+#include <command.h>
+#include <env.h>
+#include <fs.h>
+#include <lmb.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int do_addr_find(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct lmb_region *mem, *reserved;
+	const char *filename;
+	struct lmb lmb;
+	loff_t size;
+	int ret;
+	int i, j;
+
+	if (!gd->fdt_blob) {
+		log_err("No FDT setup\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (fs_set_blk_dev(argv[1], argc >= 3 ? argv[2] : NULL, FS_TYPE_FAT)) {
+		log_err("Can't set block device\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc >= 4) {
+		filename = argv[3];
+	} else {
+		filename = env_get("bootfile");
+		if (!filename) {
+			log_err("No boot file defined\n");
+			return CMD_RET_FAILURE;
+		}
+	}
+
+	ret = fs_size(filename, &size);
+	if (ret != 0) {
+		log_err("Failed to get file size\n");
+		return CMD_RET_FAILURE;
+	}
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	mem = &lmb.memory;
+	reserved = &lmb.reserved;
+
+	for (i = 0; i < mem->cnt; i++) {
+		unsigned long long start, end;
+
+		start = mem->region[i].base;
+		end = mem->region[i].base + mem->region[i].size - 1;
+		if ((start + size) > end)
+			continue;
+		for (j = 0; j < reserved->cnt; j++) {
+			if ((reserved->region[j].base + reserved->region[j].size) < start)
+				continue;
+			if ((start + size) > reserved->region[j].base)
+				start = reserved->region[j].base + reserved->region[j].size;
+		}
+		if ((start + size) <= end) {
+			env_set_hex("loadaddr", start);
+			debug("Set loadaddr to 0x%llx\n", start);
+			return CMD_RET_SUCCESS;
+		}
+	}
+
+	log_err("Failed to find enough RAM for 0x%llx bytes\n", size);
+	return CMD_RET_FAILURE;
+}
+
+U_BOOT_CMD(
+	addr_find, 7, 1, do_addr_find,
+	"find a load address suitable for a file",
+	"<interface> [<dev[:part]>] <filename>\n"
+	"- find a consecutive region of memory sufficiently large to hold\n"
+	"  the file called 'filename' from 'dev' on 'interface'. If\n"
+	"  successful, 'loadaddr' will be set to the located address."
+);
-- 
2.47.0

