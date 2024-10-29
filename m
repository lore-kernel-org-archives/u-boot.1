Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED74BD13594
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 07:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65A889182;
	Tue, 29 Oct 2024 08:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40B08910C; Tue, 29 Oct 2024 08:19:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 83302890D1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F6513D5;
 Tue, 29 Oct 2024 00:19:32 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E103F66E;
 Tue, 29 Oct 2024 00:19:00 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Janne Grunau <janne@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 2/2] apple: dart: use driver specific instance of LMB
Date: Tue, 29 Oct 2024 12:48:46 +0530
Message-Id: <20241029071846.514559-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029071846.514559-1-sughosh.ganu@linaro.org>
References: <20241029071846.514559-1-sughosh.ganu@linaro.org>
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

The LMB module is typically used for managing the platform's RAM
memory. RAM memory gets added to the module's memory map, and
subsequently allocated through various LMB API's.

The IOMMU driver for the apple platforms also uses the LMB API's for
allocating device virtual addresses(VA). These addresses are different
from the RAM addresses, and cannot be added to the RAM memory map. Add
a separate instance of LMB memory map for the device VA's, which gets
managed by the IOMMU driver. Use lmb_push() and lmb_pop() functions to
set-up the relevant lmb instance.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 drivers/iommu/apple_dart.c | 67 +++++++++++++++++++++++++++++++++++++-
 include/lmb.h              |  2 ++
 lib/lmb.c                  |  1 -
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 611ac7cd6de..55f60287b0e 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
+#include <alist.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <iommu.h>
@@ -70,6 +71,8 @@
 
 struct apple_dart_priv {
 	void *base;
+	struct lmb apple_dart_lmb;
+	struct lmb ram_lmb;
 	u64 *l1, *l2;
 	int bypass, shift;
 
@@ -87,6 +90,56 @@ struct apple_dart_priv {
 	void (*flush_tlb)(struct apple_dart_priv *priv);
 };
 
+static int apple_dart_lmb_init(struct apple_dart_priv *priv)
+{
+	bool ret;
+	struct lmb *almb = &priv->apple_dart_lmb;
+
+	ret = alist_init(&almb->free_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB free memory\n");
+		return -ENOMEM;
+	}
+
+	ret = alist_init(&almb->used_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB used memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void apple_dart_lmb_uninit(struct apple_dart_priv *priv)
+{
+	struct lmb *almb = &priv->apple_dart_lmb;
+
+	alist_uninit(&almb->free_mem);
+	alist_uninit(&almb->used_mem);
+}
+
+static void apple_dart_lmb_setup(struct apple_dart_priv *priv)
+{
+	struct lmb *almb = &priv->apple_dart_lmb;
+	struct lmb *rlmb = &priv->ram_lmb;
+
+	lmb_push(rlmb);
+
+	lmb_pop(almb);
+}
+
+static void apple_dart_lmb_pop(struct apple_dart_priv *priv)
+{
+	struct lmb *almb = &priv->apple_dart_lmb;
+	struct lmb *rlmb = &priv->ram_lmb;
+
+	lmb_push(almb);
+
+	lmb_pop(rlmb);
+}
+
 static void apple_dart_t8020_flush_tlb(struct apple_dart_priv *priv)
 {
 	dsb();
@@ -123,7 +176,9 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
 	off = (phys_addr_t)addr - paddr;
 	psize = ALIGN(size + off, DART_PAGE_SIZE);
 
+	apple_dart_lmb_setup(priv);
 	dva = lmb_alloc(psize, DART_PAGE_SIZE);
+	apple_dart_lmb_pop(priv);
 
 	idx = dva / DART_PAGE_SIZE;
 	for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
@@ -159,7 +214,9 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
 			   (unsigned long)&priv->l2[idx + i]);
 	priv->flush_tlb(priv);
 
+	apple_dart_lmb_setup(priv);
 	lmb_free(dva, psize);
+	apple_dart_lmb_pop(priv);
 }
 
 static struct iommu_ops apple_dart_ops = {
@@ -173,7 +230,7 @@ static int apple_dart_probe(struct udevice *dev)
 	dma_addr_t addr;
 	phys_addr_t l2;
 	int ntte, nl1, nl2;
-	int sid, i;
+	int sid, i, ret;
 	u32 params2, params4;
 
 	priv->base = dev_read_addr_ptr(dev);
@@ -212,7 +269,13 @@ static int apple_dart_probe(struct udevice *dev)
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
 
+	ret = apple_dart_lmb_init(priv);
+	if (ret)
+		return ret;
+
+	apple_dart_lmb_setup(priv);
 	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
+	apple_dart_lmb_pop(priv);
 
 	/* Disable translations. */
 	for (sid = 0; sid < priv->nsid; sid++)
@@ -294,6 +357,8 @@ static int apple_dart_remove(struct udevice *dev)
 	}
 	priv->flush_tlb(priv);
 
+	apple_dart_lmb_uninit(priv);
+
 	return 0;
 }
 
diff --git a/include/lmb.h b/include/lmb.h
index 72d7093023a..a39b48a9a97 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -14,6 +14,8 @@
  * Copyright (C) 2001 Peter Bergner, IBM Corp.
  */
 
+#define LMB_ALIST_INITIAL_SIZE	4
+
 /**
  * enum lmb_flags - definition of memory region attributes
  * @LMB_NONE: no special request
diff --git a/lib/lmb.c b/lib/lmb.c
index 2960c05abfc..959236f6e5a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -28,7 +28,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define MAP_OP_ADD		(u8)0x3
 
 #define LMB_ALLOC_ANYWHERE	0
-#define LMB_ALIST_INITIAL_SIZE	4
 
 static struct lmb lmb;
 
-- 
2.34.1

