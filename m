Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B3D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BD088FD2;
	Fri, 25 Oct 2024 14:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8BA88FD5; Fri, 25 Oct 2024 14:16:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8720589001
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9FC2339;
 Fri, 25 Oct 2024 05:16:36 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9623F71E;
 Fri, 25 Oct 2024 05:16:04 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, love.kumar@amd.com,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/2] common: memtop: add logic to detect ram_top
Date: Fri, 25 Oct 2024 17:45:46 +0530
Message-Id: <20241025121547.181633-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025121547.181633-1-sughosh.ganu@linaro.org>
References: <20241025121547.181633-1-sughosh.ganu@linaro.org>
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

Add generic logic to determine the ram_top value for boards. Earlier,
this was achieved in an indirect manner through a set of LMB API's.
That has since changed so that the LMB code is available only after
relocation. Replace those LMB calls with a single call to
get_mem_top() to determine the value of ram_top.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 common/Makefile  |   1 +
 common/memtop.c  | 186 +++++++++++++++++++++++++++++++++++++++++++++++
 include/memtop.h |  22 ++++++
 3 files changed, 209 insertions(+)
 create mode 100644 common/memtop.c
 create mode 100644 include/memtop.h

diff --git a/common/Makefile b/common/Makefile
index 2ee5ef9cc6e..35991562a12 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -7,6 +7,7 @@
 ifndef CONFIG_XPL_BUILD
 obj-y += init/
 obj-y += main.o
+obj-y += memtop.o
 obj-y += exports.o
 obj-y += cli_getch.o cli_simple.o cli_readline.o
 obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
diff --git a/common/memtop.c b/common/memtop.c
new file mode 100644
index 00000000000..579daa89136
--- /dev/null
+++ b/common/memtop.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+#include <fdt_support.h>
+#include <fdtdec.h>
+#include <memtop.h>
+
+#include <asm/types.h>
+
+#define MEM_RGN_COUNT	16
+
+struct region {
+	phys_addr_t base;
+	phys_size_t size;
+};
+
+struct mem_region {
+	struct region rgn[MEM_RGN_COUNT];
+	uint count;
+};
+
+static void add_mem_region(struct mem_region *mem_rgn, phys_addr_t base,
+			   phys_size_t size)
+{
+	long i;
+
+	for (i = mem_rgn->count; i >= 0; i--) {
+		if (i && base < mem_rgn->rgn[i - 1].base) {
+			mem_rgn->rgn[i] = mem_rgn->rgn[i - 1];
+		} else {
+			mem_rgn->rgn[i].base = base;
+			mem_rgn->rgn[i].size = size;
+			break;
+		}
+	}
+
+	mem_rgn->count++;
+}
+
+static void mem_regions_init(struct mem_region *mem)
+{
+	uint i;
+
+	mem->count = 0;
+	for (i = 0; i < MEM_RGN_COUNT; i++) {
+		mem->rgn[i].base = 0;
+		mem->rgn[i].size = 0;
+	}
+}
+
+static int fdt_add_reserved_regions(struct mem_region *free_mem,
+				    struct mem_region *reserved_mem,
+				    void *fdt_blob)
+{
+	u64 addr, size;
+	int i, total, ret;
+	int nodeoffset, subnode;
+	struct fdt_resource res;
+
+	if (fdt_check_header(fdt_blob) != 0)
+		return -1;
+
+	/* process memreserve sections */
+	total = fdt_num_mem_rsv(fdt_blob);
+	assert_noisy(total < MEM_RGN_COUNT);
+	for (i = 0; i < total; i++) {
+		if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
+			continue;
+		add_mem_region(reserved_mem, addr, size);
+	}
+
+	i = 0;
+	/* process reserved-memory */
+	nodeoffset = fdt_subnode_offset(fdt_blob, 0, "reserved-memory");
+	if (nodeoffset >= 0) {
+		subnode = fdt_first_subnode(fdt_blob, nodeoffset);
+		while (subnode >= 0) {
+			/* check if this subnode has a reg property */
+			ret = fdt_get_resource(fdt_blob, subnode, "reg", 0,
+					       &res);
+			if (!ret && fdtdec_get_is_enabled(fdt_blob, subnode)) {
+				addr = res.start;
+				size = res.end - res.start + 1;
+				assert_noisy(i < MEM_RGN_COUNT);
+				add_mem_region(reserved_mem, addr, size);
+			}
+
+			subnode = fdt_next_subnode(fdt_blob, subnode);
+			++i;
+		}
+	}
+
+	return 0;
+}
+
+static long addrs_overlap(phys_addr_t base1, phys_size_t size1,
+			  phys_addr_t base2, phys_size_t size2)
+{
+	const phys_addr_t base1_end = base1 + size1 - 1;
+	const phys_addr_t base2_end = base2 + size2 - 1;
+
+	return ((base1 <= base2_end) && (base2 <= base1_end));
+}
+
+static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
+				 phys_size_t size)
+{
+	unsigned long i;
+	struct region *rgn = mem_rgn->rgn;
+
+	for (i = 0; i < mem_rgn->count; i++) {
+		phys_addr_t rgnbase = rgn[i].base;
+		phys_size_t rgnsize = rgn[i].size;
+
+		if (addrs_overlap(base, size, rgnbase, rgnsize))
+			break;
+	}
+
+	return (i < mem_rgn->count) ? i : -1;
+}
+
+static int find_ram_top(struct mem_region *free_mem,
+			struct mem_region *reserved_mem, phys_size_t size)
+{
+	long i, rgn;
+	phys_addr_t base = 0;
+	phys_addr_t res_base;
+
+	for (i = free_mem->count - 1; i >= 0; i--) {
+		phys_addr_t rgnbase = free_mem->rgn[i].base;
+		phys_size_t rgnsize = free_mem->rgn[i].size;
+
+		if (rgnsize < size)
+			continue;
+
+		base = rgnbase + rgnsize - size;
+		while (base && rgnbase <= base) {
+			rgn = region_overlap_check(reserved_mem, base, size);
+			if (rgn < 0)
+				return base;
+
+			res_base = reserved_mem->rgn[rgn].base;
+			if (res_base < size)
+				break;
+			base = res_base - size;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * get_mem_top() - Compute the value of ram_top
+ * @ram_start:	Start of RAM
+ * @ram_size:	RAM size
+ * @size:	Minimum RAM size requested
+ * @fdt:	FDT blob
+ *
+ * The function computes the top address of RAM memory that can be
+ * used by U-Boot. This is being done by going through the list of
+ * reserved memory regions specified in the devicetree blob passed
+ * to the function. The logic used here is derived from the lmb
+ * allocation function.
+ *
+ * Return: address of ram top on success, 0 on failure
+ */
+phys_addr_t get_mem_top(phys_addr_t ram_start, phys_size_t ram_size,
+			phys_size_t size, void *fdt)
+{
+	int i;
+	struct mem_region free_mem;
+	struct mem_region reserved_mem;
+
+	mem_regions_init(&free_mem);
+	mem_regions_init(&reserved_mem);
+
+	add_mem_region(&free_mem, ram_start, ram_size);
+
+	i = fdt_add_reserved_regions(&free_mem, &reserved_mem, fdt);
+	if (i < 0)
+		return 0;
+
+	return find_ram_top(&free_mem, &reserved_mem, size);
+}
diff --git a/include/memtop.h b/include/memtop.h
new file mode 100644
index 00000000000..28f62e24ea7
--- /dev/null
+++ b/include/memtop.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+/**
+ * get_mem_top() - Compute the value of ram_top
+ * @ram_start:	Start of RAM
+ * @ram_size:	RAM size
+ * @size:	Minimum RAM size requested
+ * @fdt:	FDT blob
+ *
+ * The function computes the top address of RAM memory that can be
+ * used by U-Boot. This is being done by going through the list of
+ * reserved memory regions specified in the devicetree blob passed
+ * to the function. The logic used here is derived from the lmb
+ * allocation function.
+ *
+ * Return: address of ram top on success, 0 on failure
+ */
+phys_addr_t get_mem_top(phys_addr_t ram_start, phys_size_t ram_size,
+			phys_size_t size, void *fdt);
-- 
2.34.1

