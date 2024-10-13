Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E5BCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 10:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E6088ECB;
	Sun, 13 Oct 2024 12:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8ED88EC9; Sun, 13 Oct 2024 12:55:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3246E88C7C
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F5D51007;
 Sun, 13 Oct 2024 03:56:14 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E653F71E;
 Sun, 13 Oct 2024 03:55:41 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 01/15] lmb: add versions of the lmb API with flags
Date: Sun, 13 Oct 2024 16:25:08 +0530
Message-Id: <20241013105522.391414-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013105522.391414-1-sughosh.ganu@linaro.org>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
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

The LMB module is to be used as a backend for allocating and freeing
up memory requested from other modules like EFI. These memory requests
are different from the typical LMB reservations in that memory
required by the EFI module cannot be overwritten, or re-requested. Add
versions of the LMB API functions with flags for allocating and
freeing up memory. The caller can then use these API's for specifying
the type of memory that is required. For now, these functions will be
used by the EFI memory module.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 include/lmb.h | 56 +++++++++++++++++++++++++++++++++
 lib/lmb.c     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/include/lmb.h b/include/lmb.h
index aee2f9fcda..0e8426f437 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -90,6 +90,50 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
 phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
+/**
+ * lmb_alloc_flags() - Allocate memory region with specified attributes
+ * @size: Size of the region requested
+ * @align: Alignment of the memory region requested
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags);
+
+/**
+ * lmb_alloc_base_flags() - Allocate specified memory region with specified attributes
+ * @size: Size of the region requested
+ * @align: Alignment of the memory region requested
+ * @max_addr: Maximum address of the requested region
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter. The max_addr parameter is used to specify the maximum address
+ * below which the requested region should be allocated.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
+				 phys_addr_t max_addr, uint flags);
+
+/**
+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
+ * @base: Base Address requested
+ * @size: Size of the region requested
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter. The base parameter is used to specify the base address
+ * of the requested region.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
+				 uint flags);
+
 /**
  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
  *
@@ -102,6 +146,18 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
  */
 int lmb_is_reserved_flags(phys_addr_t addr, int flags);
 
+/**
+ * lmb_free_flags() - Free up a region of memory
+ * @base: Base Address of region to be freed
+ * @size: Size of the region to be freed
+ * @flags: Memory region attributes
+ *
+ * Free up a region of memory.
+ *
+ * Return: 0 if successful, -1 on failure
+ */
+long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
+
 long lmb_free(phys_addr_t base, phys_size_t size);
 
 void lmb_dump_all(void);
diff --git a/lib/lmb.c b/lib/lmb.c
index 380d92a671..a38537af9c 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -479,7 +479,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return lmb_add_region(lmb_rgn_lst, base, size);
 }
 
-long lmb_free(phys_addr_t base, phys_size_t size)
+static long __lmb_free(phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *rgn;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
@@ -530,6 +530,27 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 				    rgn[i].flags);
 }
 
+long lmb_free(phys_addr_t base, phys_size_t size)
+{
+	return __lmb_free(base, size);
+}
+
+/**
+ * lmb_free_flags() - Free up a region of memory
+ * @base: Base Address of region to be freed
+ * @size: Size of the region to be freed
+ * @flags: Memory region attributes
+ *
+ * Free up a region of memory.
+ *
+ * Return: 0 if successful, -1 on failure
+ */
+long lmb_free_flags(phys_addr_t base, phys_size_t size,
+		    __always_unused uint flags)
+{
+	return __lmb_free(base, size);
+}
+
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
@@ -613,6 +634,23 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
 }
 
+/**
+ * lmb_alloc_flags() - Allocate memory region with specified attributes
+ * @size: Size of the region requested
+ * @align: Alignment of the memory region requested
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
+{
+	return __lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
+				flags);
+}
+
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
@@ -626,6 +664,33 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 	return alloc;
 }
 
+/**
+ * lmb_alloc_base_flags() - Allocate specified memory region with specified attributes
+ * @size: Size of the region requested
+ * @align: Alignment of the memory region requested
+ * @max_addr: Maximum address of the requested region
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter. The max_addr parameter is used to specify the maximum address
+ * below which the requested region should be allocated.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
+				 phys_addr_t max_addr, uint flags)
+{
+	phys_addr_t alloc;
+
+	alloc = __lmb_alloc_base(size, align, max_addr, flags);
+
+	if (alloc == 0)
+		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
+		       (ulong)size, (ulong)max_addr);
+
+	return alloc;
+}
+
 static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				    enum lmb_flags flags)
 {
@@ -660,6 +725,24 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 	return __lmb_alloc_addr(base, size, LMB_NONE);
 }
 
+/**
+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
+ * @base: Base Address requested
+ * @size: Size of the region requested
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter. The base parameter is used to specify the base address
+ * of the requested region.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
+				 uint flags)
+{
+	return __lmb_alloc_addr(base, size, flags);
+}
+
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
-- 
2.34.1

