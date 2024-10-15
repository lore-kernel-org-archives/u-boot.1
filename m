Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A38BD1D879
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FF988D5C;
	Tue, 15 Oct 2024 17:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E9E88730; Tue, 15 Oct 2024 17:38:32 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E4E2288D97
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27B7175D;
 Tue, 15 Oct 2024 08:38:58 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FD7B3F528;
 Tue, 15 Oct 2024 08:38:26 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 15/15] lmb: replace the double-underscore with
 single-underscore for all functions
Date: Tue, 15 Oct 2024 21:07:17 +0530
Message-Id: <20241015153717.401371-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015153717.401371-1-sughosh.ganu@linaro.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
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

A bunch of static functions in the LMB module have used a
double-undersore for the function names. It was suggested to use a
single-underscore instead, as the double-underscore is usually used
by library functions. Replace the double-underscore with
single-underscore for all functions.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Suggested-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 lib/lmb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index f3a1d8ca256..78fe2d4de7c 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -496,7 +496,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return 0;
 }
 
-static long __lmb_free(phys_addr_t base, phys_size_t size)
+static long _lmb_free(phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *rgn;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
@@ -562,7 +562,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 {
 	long ret;
 
-	ret = __lmb_free(base, size);
+	ret = _lmb_free(base, size);
 	if (ret < 0)
 		return ret;
 
@@ -618,7 +618,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 	return addr & ~(size - 1);
 }
 
-static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
+static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 				    phys_addr_t max_addr, enum lmb_flags flags)
 {
 	u8 op;
@@ -692,15 +692,15 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
  */
 phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
 {
-	return __lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
-				flags);
+	return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
+			       flags);
 }
 
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
 
-	alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
+	alloc = _lmb_alloc_base(size, align, max_addr, LMB_NONE);
 
 	if (alloc == 0)
 		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
@@ -727,7 +727,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 {
 	phys_addr_t alloc;
 
-	alloc = __lmb_alloc_base(size, align, max_addr, flags);
+	alloc = _lmb_alloc_base(size, align, max_addr, flags);
 
 	if (alloc == 0)
 		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
@@ -736,7 +736,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 	return alloc;
 }
 
-static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
+static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				    enum lmb_flags flags)
 {
 	long rgn;
@@ -767,7 +767,7 @@ static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
  */
 phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 {
-	return __lmb_alloc_addr(base, size, LMB_NONE);
+	return _lmb_alloc_addr(base, size, LMB_NONE);
 }
 
 /**
@@ -785,7 +785,7 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
 				 uint flags)
 {
-	return __lmb_alloc_addr(base, size, flags);
+	return _lmb_alloc_addr(base, size, flags);
 }
 
 /* Return number of bytes from a given address that are free */
-- 
2.34.1

