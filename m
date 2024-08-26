Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF24C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0AF88A31;
	Mon, 26 Aug 2024 14:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC7188A31; Mon, 26 Aug 2024 14:00:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B25AE88A5F
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55996DA7;
 Mon, 26 Aug 2024 05:00:44 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727A63F762;
 Mon, 26 Aug 2024 05:00:14 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 03/27] lmb: staticize __lmb_alloc_base()
Date: Mon, 26 Aug 2024 17:29:16 +0530
Message-Id: <20240826115940.3233167-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
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

The __lmb_alloc_base() function is only called from within the lmb
module. Moreover, the lmb_alloc() and lmb_alloc_base() API's are good
enough for the allocation API calls. Make the __lmb_alloc_base()
function static.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 include/lmb.h |  2 --
 lib/lmb.c     | 39 ++++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 6c50d93e83..7b87181b9e 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -112,8 +112,6 @@ long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base,
 phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			   phys_addr_t max_addr);
-phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
-			     phys_addr_t max_addr);
 phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
 
diff --git a/lib/lmb.c b/lib/lmb.c
index adc3abd5b4..4d39c0d1f9 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -435,30 +435,13 @@ static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 	return (i < rgn->cnt) ? i : -1;
 }
 
-phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
-{
-	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
-}
-
-phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
-{
-	phys_addr_t alloc;
-
-	alloc = __lmb_alloc_base(lmb, size, align, max_addr);
-
-	if (alloc == 0)
-		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
-		       (ulong)size, (ulong)max_addr);
-
-	return alloc;
-}
-
 static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 {
 	return addr & ~(size - 1);
 }
 
-phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
+static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
+				    ulong align, phys_addr_t max_addr)
 {
 	long i, rgn;
 	phys_addr_t base = 0;
@@ -499,6 +482,24 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phy
 	return 0;
 }
 
+phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
+{
+	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
+}
+
+phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
+{
+	phys_addr_t alloc;
+
+	alloc = __lmb_alloc_base(lmb, size, align, max_addr);
+
+	if (alloc == 0)
+		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
+		       (ulong)size, (ulong)max_addr);
+
+	return alloc;
+}
+
 /*
  * Try to allocate a specific address range: must be in defined memory but not
  * reserved
-- 
2.34.1

