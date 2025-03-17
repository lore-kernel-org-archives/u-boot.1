Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEBCC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8D0810F4;
	Mon, 17 Mar 2025 09:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EB58141E; Mon, 17 Mar 2025 09:34:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3F9188058A
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 850FC13D5;
 Mon, 17 Mar 2025 01:34:44 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3BD53F673;
 Mon, 17 Mar 2025 01:34:32 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 3/8] fdt: add support for adding pmem nodes
Date: Mon, 17 Mar 2025 14:03:57 +0530
Message-Id: <20250317083402.412310-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317083402.412310-1-sughosh.ganu@linaro.org>
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
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

From: Masahisa Kojima <kojima.masahisa@socionext.com>

One of the problems an OS may face, when running in EFI, is that
a mounted ISO, after calling ExitBootServices goes away, if that ISO
is resident in RAM memory as a ramdisk.

ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
don't have anything in place for DTs. Linux and device trees have support
for persistent memory devices. So add a function that can inject a pmem
node in a DT, so we can pass information on the ramdisk the OS.

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V8:
* Re-word the commit message to indicate that the ramdisk information
  is being passed to the OS through pmem node
* Change the type of addr and size parameters to the
  fdt_fixup_pmem_region() as u64
* Rename the first parameter of fdt_fixup_pmem_region() as fdt instead
  of blob
* Modify the format specifier of snprintf() call in
  fdt_fixup_pmem_region() accordingly
* Remove pmem_start and pmem_size array variables in
  fdt_fixup_pmem_region()
* s/pmem_node/node_name/g
* Do not initialise node_name variable

 boot/fdt_support.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 include/fdt_support.h | 14 ++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 49efeec3681..92f2f534ee0 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -18,6 +18,7 @@
 #include <dm/ofnode.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <asm/global_data.h>
 #include <asm/unaligned.h>
 #include <linux/libfdt.h>
@@ -464,7 +465,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
 	do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
 }
 
-#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
 /*
  * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
  */
@@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
 	return p - (char *)buf;
 }
 
+#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
 #if CONFIG_NR_DRAM_BANKS > 4
 #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
 #else
@@ -2222,3 +2223,39 @@ int fdt_valid(struct fdt_header **blobp)
 	}
 	return 1;
 }
+
+int fdt_fixup_pmem_region(void *fdt, u64 pmem_start, u64 pmem_size)
+{
+	char node_name[32];
+	int nodeoffset, len;
+	int err;
+	u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
+
+	if (!IS_ALIGNED(pmem_start, SZ_2M) ||
+	    !IS_ALIGNED(pmem_start + pmem_size, SZ_2M)) {
+		printf("Start and end address must be 2MiB aligned\n");
+		return -1;
+	}
+
+	snprintf(node_name, sizeof(node_name), "pmem@%llx", pmem_start);
+	nodeoffset = fdt_find_or_add_subnode(fdt, 0, node_name);
+	if (nodeoffset < 0)
+		return nodeoffset;
+
+	err = fdt_setprop_string(fdt, nodeoffset, "compatible", "pmem-region");
+	if (err)
+		return err;
+	err = fdt_setprop_empty(fdt, nodeoffset, "volatile");
+	if (err)
+		return err;
+
+	len = fdt_pack_reg(fdt, tmp, &pmem_start, &pmem_size, 1);
+	err = fdt_setprop(fdt, nodeoffset, "reg", tmp, len);
+	if (err < 0) {
+		printf("WARNING: could not set pmem %s %s.\n", "reg",
+		       fdt_strerror(err));
+		return err;
+	}
+
+	return 0;
+}
diff --git a/include/fdt_support.h b/include/fdt_support.h
index f0ad2e6b365..049190cf3d7 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -471,6 +471,20 @@ int fdt_valid(struct fdt_header **blobp);
  */
 int fdt_get_cells_len(const void *blob, char *nr_cells_name);
 
+/**
+ * fdt_fixup_pmem_region() - add a pmem node on the device tree
+ *
+ * This functions adds/updates a pmem node to the device tree.
+ * Usually used with EFI installers to preserve installer
+ * images
+ *
+ * @fdt:	device tree provided by caller
+ * @addr:	start address of the pmem node
+ * @size:	size of the memory of the pmem node
+ * Return:	0 on success or < 0 on failure
+ */
+int fdt_fixup_pmem_region(void *fdt, u64 pmem_start, u64 pmem_size);
+
 #endif /* !USE_HOSTCC */
 
 #ifdef USE_HOSTCC
-- 
2.34.1

