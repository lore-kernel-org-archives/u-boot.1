Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0D2C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E948855C;
	Fri,  7 Jun 2024 20:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464A48857E; Fri,  7 Jun 2024 20:55:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1F8E588445
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F348F1480;
 Fri,  7 Jun 2024 11:55:36 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C723F792;
 Fri,  7 Jun 2024 11:55:09 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 31/31] temp: cmd: efi: add a command to dump EFI memory map
Date: Sat,  8 Jun 2024 00:22:40 +0530
Message-Id: <20240607185240.1892031-32-sughosh.ganu@linaro.org>
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

Add a command to dump the EFI memory map.

Not for committing.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 cmd/Makefile                |  1 +
 cmd/efi_map_dump.c          | 28 ++++++++++++++++++++++++++++
 include/efi_loader.h        |  2 ++
 lib/efi_loader/efi_memory.c | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 cmd/efi_map_dump.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 35fcc4af5a..315046def6 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -11,6 +11,7 @@ obj-y += help.o
 obj-y += panic.o
 obj-y += version.o
 obj-y += efi_memory.o
+obj-y += efi_map_dump.o
 
 # command
 obj-$(CONFIG_CMD_ARMFFA) += armffa.o
diff --git a/cmd/efi_map_dump.c b/cmd/efi_map_dump.c
new file mode 100644
index 0000000000..f2a5932767
--- /dev/null
+++ b/cmd/efi_map_dump.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Allocate and Free EFI memory
+ *
+ *  Copyright (c) 2024 Linaro Limited
+ */
+
+#include <command.h>
+#include <efi_loader.h>
+
+static int do_efi_map_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+//	printf("%s: argc => %d\n", __func__, argc);
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	dump_efi_memory_map();
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(
+	efi_map_dump, 1, 0, do_efi_map_dump,
+	"Dump the EFI memory map",
+	""
+);
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9600941aa3..40f894f182 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -791,6 +791,8 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 				uint32_t *descriptor_version);
 /* Adds a range into the EFI memory map */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
+/* Dump the contents of the EFI memory map */
+void dump_efi_memory_map(void);
 /* Adds a conventional range into the EFI memory map */
 efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
 					     u64 ram_top);
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 93244161b0..7ab1b86140 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -47,6 +47,8 @@ static LIST_HEAD(efi_mem);
 void *efi_bounce_buffer;
 #endif
 
+static uint64_t desc_get_end(struct efi_mem_desc *desc);
+
 /**
  * struct efi_pool_allocation - memory block allocated from pool
  *
@@ -118,6 +120,36 @@ static int lmb_mem_map_update_sync(void *ctx, struct event *event)
 EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
 #endif /* MEM_MAP_UPDATE_NOTIFY */
 
+static void dump_efi_mem_desc(struct efi_mem_desc *desc)
+{
+	u64 end;
+
+	end = desc_get_end(desc);
+
+	printf("-----------------------------------\n");
+	printf("Memory Range   [0x%llx - 0x%llx]\n",
+	       desc->physical_start, end);
+	printf("Num Pages      [0x%llx]\n", desc->num_pages);
+	printf("Memory Type    [0x%x]\n", desc->type);
+	printf("Attribute      [0x%llx]\n", desc->attribute);
+	printf("-----------------------------------\n");
+}
+
+void dump_efi_memory_map(void)
+{
+	struct list_head *lhandle;
+
+	list_for_each(lhandle, &efi_mem) {
+		struct efi_mem_list *lmem;
+		struct efi_mem_desc *desc;
+
+		lmem = list_entry(lhandle, struct efi_mem_list, link);
+		desc = &lmem->desc;
+
+		dump_efi_mem_desc(desc);
+	}
+}
+
 /**
  * checksum() - calculate checksum for memory allocated from pool
  *
-- 
2.34.1

