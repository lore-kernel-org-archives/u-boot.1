Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6135CC27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACE588578;
	Fri,  7 Jun 2024 20:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5F38855C; Fri,  7 Jun 2024 20:55:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E39D388578
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8AE31480;
 Fri,  7 Jun 2024 11:55:33 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEC303F792;
 Fri,  7 Jun 2024 11:55:06 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 30/31] temp: cmd: efi_mem: add a command to test efi
 alloc/free
Date: Sat,  8 Jun 2024 00:22:39 +0530
Message-Id: <20240607185240.1892031-31-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Not for committing.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 cmd/Makefile     |   1 +
 cmd/efi_memory.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 cmd/efi_memory.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 87133cc27a..35fcc4af5a 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-y += help.o
 obj-y += panic.o
 obj-y += version.o
+obj-y += efi_memory.o
 
 # command
 obj-$(CONFIG_CMD_ARMFFA) += armffa.o
diff --git a/cmd/efi_memory.c b/cmd/efi_memory.c
new file mode 100644
index 0000000000..52ddcb7146
--- /dev/null
+++ b/cmd/efi_memory.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Allocate and Free EFI memory
+ *
+ *  Copyright (c) 2024 Linaro Limited
+ */
+
+#include <command.h>
+#include <efi_loader.h>
+#include <lmb.h>
+#include <vsprintf.h>
+
+#include <linux/types.h>
+
+static int do_efi_mem_free(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char * const argv[])
+{
+	uint64_t addr = 0, size = 0;
+	efi_uintn_t pages;
+	efi_status_t status;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	argc--; argv++;
+
+	size = simple_strtoul(argv[0], NULL, 16);
+	if (!size) {
+		printf("Enter valid size for free in Hex\n");
+		return CMD_RET_USAGE;
+	}
+
+	
+	addr = simple_strtoul(argv[1], NULL, 16);
+	if (!addr) {
+		printf("Enter a valid address in Hex\n");
+		return CMD_RET_USAGE;
+	}
+
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+
+	status = efi_free_pages(addr, pages);
+	if (status != EFI_SUCCESS) {
+		printf("Unable to free memory, error (%#lx)\n", status);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_efi_mem_alloc(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char * const argv[])
+{
+	enum efi_allocate_type type;
+	uint64_t addr = 0, size = 0;
+	efi_uintn_t pages;
+	efi_status_t status;
+	bool max = false;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	argc--; argv++;
+
+	if (!strcmp("max", argv[0])) {
+		if (argc != 3)
+			return CMD_RET_USAGE;
+
+		max = true;
+		argv++;
+		argc--;
+	}
+
+	size = simple_strtoul(argv[0], NULL, 16);
+	if (!size) {
+		printf("Enter valid size for allocation in Hex\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (max || argc == 2) {
+		addr = simple_strtoul(argv[1], NULL, 16);
+		if (!addr) {
+			printf("Enter a valid address in Hex\n");
+			return CMD_RET_USAGE;
+		}
+	}
+
+	if (max)
+		type = EFI_ALLOCATE_MAX_ADDRESS;
+	else if (addr)
+		type = EFI_ALLOCATE_ADDRESS;
+	else
+		type = EFI_ALLOCATE_ANY_PAGES;
+
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+	status = efi_allocate_pages(type, EFI_BOOT_SERVICES_DATA, pages,
+				    &addr);
+	if (status != EFI_SUCCESS) {
+		printf("efi_allocate_pages failed %lx\n", status);
+		return CMD_RET_FAILURE;
+	} else {
+		printf("Address returned %#llx\n", addr);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static struct cmd_tbl cmd_efi_mem_sub[] = {
+	U_BOOT_CMD_MKENT(alloc, 3, 0, do_efi_mem_alloc,
+		"", ""),
+	U_BOOT_CMD_MKENT(free, 2, 0, do_efi_mem_free,
+		"", ""),
+};
+
+static int do_efi_mem(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	struct cmd_tbl *cp;
+	efi_status_t r;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	argc--; argv++;
+
+	/* Initialize UEFI subsystem */
+	r = efi_init_obj_list();
+	if (r != EFI_SUCCESS) {
+		printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+		       r & ~EFI_ERROR_MASK);
+		return CMD_RET_FAILURE;
+	}
+
+	cp = find_cmd_tbl(argv[0], cmd_efi_mem_sub,
+			  ARRAY_SIZE(cmd_efi_mem_sub));
+	if (!cp)
+		return CMD_RET_USAGE;
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+U_BOOT_LONGHELP(efi_mem,
+	"Functions to allocate and free memory\n"
+	"\n"
+	"efi_mem alloc <size> [addr]\n"
+	"efi_mem alloc max <size> <max-addr>\n"
+	"efi_mem free <size> <addr>\n"
+	"\n"
+);
+
+U_BOOT_CMD(
+	efi_mem, CONFIG_SYS_MAXARGS, 0, do_efi_mem,
+	"Allocate and free EFI memory",
+	efi_mem_help_text
+);
-- 
2.34.1

