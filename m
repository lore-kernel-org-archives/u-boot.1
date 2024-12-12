Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948EEE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3B6801FE;
	Thu, 12 Dec 2024 14:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m50raif6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B1+YBxif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B139E80209; Thu, 12 Dec 2024 14:40:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC138008A
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y8DBZ6vVZz9st4;
 Thu, 12 Dec 2024 14:40:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qefoQxEFkVQvFRBJl57WZPx+LforRfmbXXVz11q7yJI=;
 b=m50raif6B9YwcAjyNl1nJ3DsIo+6cDbtyapr84qHiYxU2qehfVuLlIhYogQJF+VWKBKmAs
 Jgi8RHtVn6uMsPW5rdj5RVW4P1VkXNg3H1BE89DOeCM42CQyl4jnu6voijO4LaXXZZ6/wO
 FxBrWwRbSsAfJQLetfhcHy0kuQ4UUs2siZF/GkAp2Eqtc9pmPxpj0b1nCQXEoifxiI9ik6
 KZ1R5CcsPS2VWG7fRcBkqPNNfWEsGjVh07+Y7I1gMkwyTNRpGu/QoDTYOa1oNPn/EG00uZ
 BpqvTqSax53rp8BAh44jbDsh1FT5ruwDxoibWXRVvFLxCMaAJSFzw+2S+nPgew==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qefoQxEFkVQvFRBJl57WZPx+LforRfmbXXVz11q7yJI=;
 b=B1+YBxif6WSYHubrAs/PmvfoAycKoF5yHQ1axZKV9I6A3A+iIRlv9WkMRVq06HjDM+AVfC
 agV0KRRjeogTkZcWIfejhrxd7MpfEAOGY2ul3nNbQT++/vT1Xah3A4RM4wA/09SJQw5C/I
 cu+IO/WBNXuTNLgB0Tk2aP5STk6xi9THdF5KaDFVoKUTCH+8zIGrL+u3ZFS2xG0XKO6vB+
 KEcRimSLeJiCaJHtQbJhV3jxWpdw3N59aS4UKC6UWmYcZNNEk6vJBeQwkFj2w5BeTaGaRu
 S2O9sFyYrjor4c3dV1BpdjvrycPCn3gHT8ScfhdLYegmKLPdW5YfeYufCqI2fA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: renesas: Split R-Car Gen3 and Gen4 common board
 code
Date: Thu, 12 Dec 2024 14:38:27 +0100
Message-ID: <20241212134025.84612-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hfdiejy6jj7w9ief7xitnjthwn5yro4s
X-MBO-RS-ID: 8724df94d82cf2acc30
X-Rspamd-Queue-Id: 4Y8DBZ6vVZz9st4
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

Split common board code for R-Car Gen3 and Gen4 into separate files.
The R-Car Gen3 board code contains fixups specific to TFA which are
no longer required on R-Car Gen4, keep those fixups in its own file
so they would not interfere with Gen4.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/beacon/beacon-rzg2m/Makefile      |   2 +-
 board/hoperun/hihope-rzg2/Makefile      |   2 +-
 board/renesas/condor/Makefile           |   2 +-
 board/renesas/draak/Makefile            |   2 +-
 board/renesas/eagle/Makefile            |   2 +-
 board/renesas/ebisu/Makefile            |   2 +-
 board/renesas/rcar-common/common.c      | 174 ----------------------
 board/renesas/rcar-common/gen3-common.c | 185 ++++++++++++++++++++++++
 board/renesas/rcar-common/gen4-common.c |  14 ++
 board/renesas/salvator-x/Makefile       |   2 +-
 board/renesas/ulcb/Makefile             |   2 +-
 board/renesas/v3hsk/Makefile            |   2 +-
 board/renesas/v3msk/Makefile            |   2 +-
 board/silinux/ek874/Makefile            |   2 +-
 14 files changed, 210 insertions(+), 185 deletions(-)
 create mode 100644 board/renesas/rcar-common/gen3-common.c

diff --git a/board/beacon/beacon-rzg2m/Makefile b/board/beacon/beacon-rzg2m/Makefile
index 9131a92efae..332b41f35c0 100644
--- a/board/beacon/beacon-rzg2m/Makefile
+++ b/board/beacon/beacon-rzg2m/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= beacon-rzg2m.o ../../renesas/rcar-common/common.o
+obj-y	:= beacon-rzg2m.o ../../renesas/rcar-common/gen3-common.o ../../renesas/rcar-common/common.o
diff --git a/board/hoperun/hihope-rzg2/Makefile b/board/hoperun/hihope-rzg2/Makefile
index e989e7aacc5..700e26daa2b 100644
--- a/board/hoperun/hihope-rzg2/Makefile
+++ b/board/hoperun/hihope-rzg2/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= hihope-rzg2.o ../../renesas/rcar-common/common.o
+obj-y	:= hihope-rzg2.o ../../renesas/rcar-common/gen3-common.o ../../renesas/rcar-common/common.o
diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
index cb965cde35f..fe3a2fd3b7a 100644
--- a/board/renesas/condor/Makefile
+++ b/board/renesas/condor/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/common.o
+obj-y	:= ../rcar-common/gen3-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
index 8859cf902ca..3ed7800b0e9 100644
--- a/board/renesas/draak/Makefile
+++ b/board/renesas/draak/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= draak.o ../rcar-common/common.o
+obj-y	:= draak.o ../rcar-common/gen3-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
index 98164b5ea29..3f5fdab1bc2 100644
--- a/board/renesas/eagle/Makefile
+++ b/board/renesas/eagle/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/v3-common.o ../rcar-common/gen3-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
index 283d3a4ae36..8139391029d 100644
--- a/board/renesas/ebisu/Makefile
+++ b/board/renesas/ebisu/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/common.o
+obj-y	:= ../rcar-common/gen3-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index 499c31408f6..4e35e0151c9 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -21,26 +21,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
-extern u64 rcar_atf_boot_args[];
-
-#define FDT_RPC_PATH	"/soc/spi@ee200000"
-
-static void apply_atf_overlay(void *fdt_blob)
-{
-	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
-
-	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
-		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
-}
-
-int fdtdec_board_setup(const void *fdt_blob)
-{
-	apply_atf_overlay((void *)fdt_blob);
-
-	return 0;
-}
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
@@ -58,158 +38,4 @@ int __weak board_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_RCAR_GEN3)
-#define RST_BASE	0xE6160000
-#define RST_CA57RESCNT	(RST_BASE + 0x40)
-#define RST_CA53RESCNT	(RST_BASE + 0x44)
-#define RST_RSTOUTCR	(RST_BASE + 0x58)
-#define RST_CA57_CODE	0xA5A5000F
-#define RST_CA53_CODE	0x5A5A000F
-
-void __weak reset_cpu(void)
-{
-	unsigned long midr, cputype;
-
-	asm volatile("mrs %0, midr_el1" : "=r" (midr));
-	cputype = (midr >> 4) & 0xfff;
-
-	if (cputype == 0xd03)
-		writel(RST_CA53_CODE, RST_CA53RESCNT);
-	else if (cputype == 0xd07)
-		writel(RST_CA57_CODE, RST_CA57RESCNT);
-	else
-		hang();
-}
-#elif defined(CONFIG_RCAR_GEN4)
-#define RST_BASE	0xE6160000 /* Domain0 */
-#define RST_SRESCR0	(RST_BASE + 0x18)
-#define RST_SPRES	0x5AA58000
-
-void __weak reset_cpu(void)
-{
-	writel(RST_SPRES, RST_SRESCR0);
-}
-#else
-#error Neither CONFIG_RCAR_GEN3 nor CONFIG_RCAR_GEN4 are set
-#endif
-
-#if defined(CONFIG_OF_BOARD_SETUP)
-static int is_mem_overlap(void *blob, int first_mem_node, int curr_mem_node)
-{
-	struct fdt_resource first_mem_res, curr_mem_res;
-	int curr_mem_reg, first_mem_reg = 0;
-	int ret;
-
-	for (;;) {
-		ret = fdt_get_resource(blob, first_mem_node, "reg",
-				       first_mem_reg++, &first_mem_res);
-		if (ret) /* No more entries, no overlap found */
-			return 0;
-
-		curr_mem_reg = 0;
-		for (;;) {
-			ret = fdt_get_resource(blob, curr_mem_node, "reg",
-					       curr_mem_reg++, &curr_mem_res);
-			if (ret) /* No more entries, check next tuple */
-				break;
-
-			if (curr_mem_res.end < first_mem_res.start)
-				continue;
-
-			if (curr_mem_res.start >= first_mem_res.end)
-				continue;
-
-			log_debug("Overlap found: 0x%llx..0x%llx / 0x%llx..0x%llx\n",
-				  first_mem_res.start, first_mem_res.end,
-				  curr_mem_res.start, curr_mem_res.end);
-
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static void scrub_duplicate_memory(void *blob)
-{
-	/*
-	 * Scrub duplicate /memory@* node entries here. Some R-Car DTs might
-	 * contain multiple /memory@* nodes, however fdt_fixup_memory_banks()
-	 * either generates single /memory node or updates the first /memory
-	 * node. Any remaining memory nodes are thus potential duplicates.
-	 *
-	 * However, it is not possible to delete all the memory nodes right
-	 * away, since some of those might not be DRAM memory nodes, but some
-	 * sort of other memory. Thus, delete only the memory nodes which are
-	 * in the R-Car3 DBSC ranges.
-	 */
-	int mem = 0, first_mem_node = 0;
-
-	for (;;) {
-		mem = fdt_node_offset_by_prop_value(blob, mem,
-						    "device_type", "memory", 7);
-		if (mem < 0)
-			break;
-		if (!fdtdec_get_is_enabled(blob, mem))
-			continue;
-
-		/* First memory node, patched by U-Boot */
-		if (!first_mem_node) {
-			first_mem_node = mem;
-			continue;
-		}
-
-		/* Check the remaining nodes and delete duplicates */
-		if (!is_mem_overlap(blob, first_mem_node, mem))
-			continue;
-
-		/* Delete duplicate node, start again */
-		fdt_del_node(blob, mem);
-		first_mem_node = 0;
-		mem = 0;
-	}
-}
-
-static void update_rpc_status(void *blob)
-{
-	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
-	int offset, enabled;
-
-	/*
-	 * Check if the DT fragment received from TF-A had its RPC-IF device node
-	 * enabled.
-	 */
-	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
-		return;
-
-	offset = fdt_path_offset(atf_fdt_blob, FDT_RPC_PATH);
-	if (offset < 0)
-		return;
-
-	enabled = fdtdec_get_is_enabled(atf_fdt_blob, offset);
-	if (!enabled)
-		return;
-
-	/*
-	 * Find the RPC-IF device node, and enable it if it has a flash subnode.
-	 */
-	offset = fdt_path_offset(blob, FDT_RPC_PATH);
-	if (offset < 0)
-		return;
-
-	if (fdt_subnode_offset(blob, offset, "flash") < 0)
-		return;
-
-	fdt_status_okay(blob, offset);
-}
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	apply_atf_overlay(blob);
-	scrub_duplicate_memory(blob);
-	update_rpc_status(blob);
-
-	return 0;
-}
-#endif
 #endif
diff --git a/board/renesas/rcar-common/gen3-common.c b/board/renesas/rcar-common/gen3-common.c
new file mode 100644
index 00000000000..4291e1d5bcb
--- /dev/null
+++ b/board/renesas/rcar-common/gen3-common.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * board/renesas/rcar-common/gen3-common.c
+ *
+ * Copyright (C) 2013 Renesas Electronics Corporation
+ * Copyright (C) 2013 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
+ * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+ */
+
+#include <dm.h>
+#include <fdt_support.h>
+#include <hang.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <dm/uclass-internal.h>
+#include <asm/arch/renesas.h>
+#include <linux/libfdt.h>
+
+#ifdef CONFIG_RCAR_64
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
+extern u64 rcar_atf_boot_args[];
+
+#define FDT_RPC_PATH	"/soc/spi@ee200000"
+
+static void apply_atf_overlay(void *fdt_blob)
+{
+	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
+
+	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
+		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
+}
+
+int fdtdec_board_setup(const void *fdt_blob)
+{
+	apply_atf_overlay((void *)fdt_blob);
+
+	return 0;
+}
+
+#define RST_BASE	0xE6160000
+#define RST_CA57RESCNT	(RST_BASE + 0x40)
+#define RST_CA53RESCNT	(RST_BASE + 0x44)
+#define RST_RSTOUTCR	(RST_BASE + 0x58)
+#define RST_CA57_CODE	0xA5A5000F
+#define RST_CA53_CODE	0x5A5A000F
+
+void __weak reset_cpu(void)
+{
+	unsigned long midr, cputype;
+
+	asm volatile("mrs %0, midr_el1" : "=r" (midr));
+	cputype = (midr >> 4) & 0xfff;
+
+	if (cputype == 0xd03)
+		writel(RST_CA53_CODE, RST_CA53RESCNT);
+	else if (cputype == 0xd07)
+		writel(RST_CA57_CODE, RST_CA57RESCNT);
+	else
+		hang();
+}
+
+#if defined(CONFIG_OF_BOARD_SETUP)
+static int is_mem_overlap(void *blob, int first_mem_node, int curr_mem_node)
+{
+	struct fdt_resource first_mem_res, curr_mem_res;
+	int curr_mem_reg, first_mem_reg = 0;
+	int ret;
+
+	for (;;) {
+		ret = fdt_get_resource(blob, first_mem_node, "reg",
+				       first_mem_reg++, &first_mem_res);
+		if (ret) /* No more entries, no overlap found */
+			return 0;
+
+		curr_mem_reg = 0;
+		for (;;) {
+			ret = fdt_get_resource(blob, curr_mem_node, "reg",
+					       curr_mem_reg++, &curr_mem_res);
+			if (ret) /* No more entries, check next tuple */
+				break;
+
+			if (curr_mem_res.end < first_mem_res.start)
+				continue;
+
+			if (curr_mem_res.start >= first_mem_res.end)
+				continue;
+
+			log_debug("Overlap found: 0x%llx..0x%llx / 0x%llx..0x%llx\n",
+				  first_mem_res.start, first_mem_res.end,
+				  curr_mem_res.start, curr_mem_res.end);
+
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void scrub_duplicate_memory(void *blob)
+{
+	/*
+	 * Scrub duplicate /memory@* node entries here. Some R-Car DTs might
+	 * contain multiple /memory@* nodes, however fdt_fixup_memory_banks()
+	 * either generates single /memory node or updates the first /memory
+	 * node. Any remaining memory nodes are thus potential duplicates.
+	 *
+	 * However, it is not possible to delete all the memory nodes right
+	 * away, since some of those might not be DRAM memory nodes, but some
+	 * sort of other memory. Thus, delete only the memory nodes which are
+	 * in the R-Car3 DBSC ranges.
+	 */
+	int mem = 0, first_mem_node = 0;
+
+	for (;;) {
+		mem = fdt_node_offset_by_prop_value(blob, mem,
+						    "device_type", "memory", 7);
+		if (mem < 0)
+			break;
+		if (!fdtdec_get_is_enabled(blob, mem))
+			continue;
+
+		/* First memory node, patched by U-Boot */
+		if (!first_mem_node) {
+			first_mem_node = mem;
+			continue;
+		}
+
+		/* Check the remaining nodes and delete duplicates */
+		if (!is_mem_overlap(blob, first_mem_node, mem))
+			continue;
+
+		/* Delete duplicate node, start again */
+		fdt_del_node(blob, mem);
+		first_mem_node = 0;
+		mem = 0;
+	}
+}
+
+static void update_rpc_status(void *blob)
+{
+	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
+	int offset, enabled;
+
+	/*
+	 * Check if the DT fragment received from TF-A had its RPC-IF device node
+	 * enabled.
+	 */
+	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
+		return;
+
+	offset = fdt_path_offset(atf_fdt_blob, FDT_RPC_PATH);
+	if (offset < 0)
+		return;
+
+	enabled = fdtdec_get_is_enabled(atf_fdt_blob, offset);
+	if (!enabled)
+		return;
+
+	/*
+	 * Find the RPC-IF device node, and enable it if it has a flash subnode.
+	 */
+	offset = fdt_path_offset(blob, FDT_RPC_PATH);
+	if (offset < 0)
+		return;
+
+	if (fdt_subnode_offset(blob, offset, "flash") < 0)
+		return;
+
+	fdt_status_okay(blob, offset);
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	apply_atf_overlay(blob);
+	scrub_duplicate_memory(blob);
+	update_rpc_status(blob);
+
+	return 0;
+}
+#endif
+#endif
diff --git a/board/renesas/rcar-common/gen4-common.c b/board/renesas/rcar-common/gen4-common.c
index 36a51bc4190..2abe9660cf8 100644
--- a/board/renesas/rcar-common/gen4-common.c
+++ b/board/renesas/rcar-common/gen4-common.c
@@ -74,3 +74,17 @@ int board_init(void)
 
 	return 0;
 }
+
+#define RST_BASE	0xE6160000 /* Domain0 */
+#define RST_SRESCR0	(RST_BASE + 0x18)
+#define RST_SPRES	0x5AA58000
+
+void __weak reset_cpu(void)
+{
+	writel(RST_SPRES, RST_SRESCR0);
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
diff --git a/board/renesas/salvator-x/Makefile b/board/renesas/salvator-x/Makefile
index 0fc69ba9de6..fe7c78ef2ff 100644
--- a/board/renesas/salvator-x/Makefile
+++ b/board/renesas/salvator-x/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= salvator-x.o ../rcar-common/common.o
+obj-y	:= salvator-x.o ../rcar-common/gen3-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/ulcb/Makefile b/board/renesas/ulcb/Makefile
index ec2f161feae..c3c2f391e55 100644
--- a/board/renesas/ulcb/Makefile
+++ b/board/renesas/ulcb/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= ulcb.o cpld.o ../rcar-common/common.o
+obj-y	:= ulcb.o cpld.o ../rcar-common/gen3-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
index b29114c7239..ee04f67d986 100644
--- a/board/renesas/v3hsk/Makefile
+++ b/board/renesas/v3hsk/Makefile
@@ -10,6 +10,6 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/v3-common.o ../rcar-common/gen3-common.o ../rcar-common/common.o
 obj-$(CONFIG_SYSRESET)	+= cpld.o
 endif
diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
index f8c4bcdcf9f..63e06a4b5fd 100644
--- a/board/renesas/v3msk/Makefile
+++ b/board/renesas/v3msk/Makefile
@@ -10,6 +10,6 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/v3-common.o ../rcar-common/gen3-common.o ../rcar-common/common.o
 obj-$(CONFIG_SYSRESET)	+= cpld.o
 endif
diff --git a/board/silinux/ek874/Makefile b/board/silinux/ek874/Makefile
index 6917a2418ca..879da9edacf 100644
--- a/board/silinux/ek874/Makefile
+++ b/board/silinux/ek874/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../../renesas/rcar-common/gen3-spl.o
 else
-obj-y	:= ek874.o ../../renesas/rcar-common/common.o
+obj-y	:= ek874.o ../../renesas/rcar-common/gen3-common.o ../../renesas/rcar-common/common.o
 endif
-- 
2.45.2

