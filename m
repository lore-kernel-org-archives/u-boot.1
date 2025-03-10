Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8118C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 11:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78DF0814A4;
	Mon, 10 Mar 2025 12:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24405811DF; Mon, 10 Mar 2025 12:58:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 43B5C8175D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 12:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 316681516;
 Mon, 10 Mar 2025 04:58:28 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93FD83F5A1;
 Mon, 10 Mar 2025 04:58:13 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v7 3/8] fdt: add support for adding pmem nodes
Date: Mon, 10 Mar 2025 17:27:45 +0530
Message-Id: <20250310115750.1019051-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
References: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
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

One of the problems OS installers face, when running in EFI, is that
the mounted ISO after calling ExitBootServices goes away. For some
distros this is a problem since they rely on finding some core packages
before continuing the installation. Distros have works around this --
e.g Fedora has a special kernel command line parameter called
inst.stage2 [0].

ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
don't have anything in place for DTs. Linux and device trees have support
for persistent memory devices. So add a function that can inject a pmem
node in a DT, so we can use it when launhing OS installers with EFI.

[0]
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V6: None

 boot/fdt_support.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 include/fdt_support.h | 14 ++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 49efeec3681..e20b9759138 100644
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
@@ -2222,3 +2223,41 @@ int fdt_valid(struct fdt_header **blobp)
 	}
 	return 1;
 }
+
+int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
+{
+	u64 pmem_start[2] = { 0 };
+	u64 pmem_size[2] = { 0 };
+	char pmem_node[32] = {0};
+	int nodeoffset, len;
+	int err;
+	u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
+
+	if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
+		printf("Start and end address must be 2MiB aligned\n");
+		return -1;
+	}
+
+	snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
+	nodeoffset = fdt_find_or_add_subnode(blob, 0, pmem_node);
+	if (nodeoffset < 0)
+		return nodeoffset;
+
+	err = fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-region");
+	if (err)
+		return err;
+	err = fdt_setprop_empty(blob, nodeoffset, "volatile");
+	if (err)
+		return err;
+	pmem_start[0] = addr;
+	pmem_size[0] = size;
+	len = fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);
+	err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
+	if (err < 0) {
+		printf("WARNING: could not set pmem %s %s.\n", "reg",
+		       fdt_strerror(err));
+		return err;
+	}
+
+	return 0;
+}
diff --git a/include/fdt_support.h b/include/fdt_support.h
index f0ad2e6b365..b72cd2920de 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -507,4 +507,18 @@ void fdt_fixup_pstore(void *blob);
  */
 int fdt_kaslrseed(void *blob, bool overwrite);
 
+/**
+ * fdt_fixup_pmem_region() - add a pmem node on the device tree
+ *
+ * This functions adds/updates a pmem node to the device tree.
+ * Usually used with EFI installers to preserve installer
+ * images
+ *
+ * @blob:	device tree provided by caller
+ * @addr:	start address of the pmem node
+ * @size:	size of the memory of the pmem node
+ * Return:	0 on success or < 0 on failure
+ */
+int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
+
 #endif /* ifndef __FDT_SUPPORT_H */
-- 
2.34.1

