Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4D8CD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE9088C87;
	Thu,  5 Sep 2024 10:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A9C88BF2; Thu,  5 Sep 2024 10:28:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 82DCB88C51
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83F61FEC;
 Thu,  5 Sep 2024 01:29:03 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9145F3F66E;
 Thu,  5 Sep 2024 01:28:34 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 01/16] lmb: add versions of the lmb API with flags
Date: Thu,  5 Sep 2024 13:57:56 +0530
Message-Id: <20240905082811.1585467-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
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
 include/lmb.h |  6 ++++++
 lib/lmb.c     | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/lmb.h b/include/lmb.h
index fc2daaa7bf..45a06c3b99 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -86,8 +86,13 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
 		       enum lmb_flags flags);
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
+phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
+phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
+				 phys_addr_t max_addr, uint flags);
 phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
+				 uint flags);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 /**
@@ -103,6 +108,7 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
 int lmb_is_reserved_flags(phys_addr_t addr, int flags);
 
 long lmb_free(phys_addr_t base, phys_size_t size);
+long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
 
 void lmb_dump_all(void);
 void lmb_dump_all_force(void);
diff --git a/lib/lmb.c b/lib/lmb.c
index 3ed570fb29..da6a1595cc 100644
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
@@ -530,6 +530,17 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 				    rgn[i].flags);
 }
 
+long lmb_free(phys_addr_t base, phys_size_t size)
+{
+	return __lmb_free(base, size);
+}
+
+long lmb_free_flags(phys_addr_t base, phys_size_t size,
+		    __always_unused uint flags)
+{
+	return __lmb_free(base, size);
+}
+
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
@@ -613,6 +624,12 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
 }
 
+phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
+{
+	return __lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
+				flags);
+}
+
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
@@ -626,6 +643,20 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 	return alloc;
 }
 
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
@@ -660,6 +691,12 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 	return __lmb_alloc_addr(base, size, LMB_NONE);
 }
 
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

