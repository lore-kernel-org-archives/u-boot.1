Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F544D5B873
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 03:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C3A8915D;
	Tue, 29 Oct 2024 04:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4558389167; Tue, 29 Oct 2024 04:39:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3124E89112
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 04:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3014713D5;
 Mon, 28 Oct 2024 20:40:10 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA143F66E;
 Mon, 28 Oct 2024 20:39:38 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Janne Grunau <janne@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH] apple: dart: add logic to allocate dva addresses
Date: Tue, 29 Oct 2024 09:09:15 +0530
Message-Id: <20241029033915.423211-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Apple IOMMU driver uses LMB API's to allocate virtual addresses
for IO devices. These virtual addresses fall in the first 4GB address
range. Currently, the driver obtains these virtual addresses through
the LMB API's. This no longer works with the global LMB map. Add a
function apple_dart_dvaalloc() which mimics what was being done by the
LMB allocation function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Note: I have only build tested this on the m1 defconfig.

 drivers/iommu/apple_dart.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 611ac7cd6de..8e2acf50a06 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -6,7 +6,6 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <iommu.h>
-#include <lmb.h>
 #include <memalign.h>
 #include <asm/io.h>
 
@@ -75,6 +74,7 @@ struct apple_dart_priv {
 
 	dma_addr_t dvabase;
 	dma_addr_t dvaend;
+	dma_addr_t dvaalloc;
 
 	int nsid;
 	int nttbr;
@@ -109,6 +109,21 @@ static void apple_dart_t8110_flush_tlb(struct apple_dart_priv *priv)
 		continue;
 }
 
+static dma_addr_t apple_dart_dvaalloc(struct udevice *dev, phys_size_t size)
+{
+	dma_addr_t dva;
+	struct apple_dart_priv *priv = dev_get_priv(dev);
+
+	dva = priv->dvaalloc - size;
+	dva &= ~(DART_PAGE_SIZE - 1);
+
+	assert(dva > priv->dvabase);
+
+	priv->dvaalloc = dva;
+
+	return priv->dvaalloc;
+}
+
 static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
 {
 	struct apple_dart_priv *priv = dev_get_priv(dev);
@@ -123,7 +138,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
 	off = (phys_addr_t)addr - paddr;
 	psize = ALIGN(size + off, DART_PAGE_SIZE);
 
-	dva = lmb_alloc(psize, DART_PAGE_SIZE);
+	dva = apple_dart_dvaalloc(dev, psize);
 
 	idx = dva / DART_PAGE_SIZE;
 	for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
@@ -158,8 +173,6 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
 	flush_dcache_range((unsigned long)&priv->l2[idx],
 			   (unsigned long)&priv->l2[idx + i]);
 	priv->flush_tlb(priv);
-
-	lmb_free(dva, psize);
 }
 
 static struct iommu_ops apple_dart_ops = {
@@ -211,8 +224,7 @@ static int apple_dart_probe(struct udevice *dev)
 
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
-
-	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
+	priv->dvaalloc = priv->dvaend;
 
 	/* Disable translations. */
 	for (sid = 0; sid < priv->nsid; sid++)
-- 
2.34.1

