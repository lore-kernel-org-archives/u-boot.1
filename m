Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9760F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A57383F00;
	Mon, 16 Mar 2026 00:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CB4HSi4M";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VTAY8xOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52ED844BD; Mon, 16 Mar 2026 00:58:04 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F13083D71
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fYwCF3T6xz9tSr;
 Mon, 16 Mar 2026 00:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773619081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t4eOeV8OIZS3iTgDkzUVvojmG3k4y6uVTWVjDjG/ZpU=;
 b=CB4HSi4M0CYB6Ii2NKhLya8jbefjuGlJl6dPwIOfzQK3Fzsg3gRn846tp+s8pj6XGx1EK4
 5K/V5UhJeOFpNrzfjUl1pzlmFN8cVAGupZj+3nH6n98ILXK2s+tOvaa/ZV+ffWKZqcHALB
 Fct0/wn5R5to7FmuGsoUvg3oniEZn0B+msdeWOku0LymWCiMQb5clitedk4o7H4f2A68N0
 2vl9S30Bb14n34rdGCTzYkEb0AUrszmgdt+Ql042MJmIFZqhH6Poz46WkAO5K/5p+q+VLx
 LnusuQEGtlwRg9Mo0odL09LSLkPUDxHDTJA9t5tk2S2ZhNSR66pXiBsfvO0oag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773619079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t4eOeV8OIZS3iTgDkzUVvojmG3k4y6uVTWVjDjG/ZpU=;
 b=VTAY8xOSlG7aX6gZF61hzDgMMc4hT2ADEBa7csKHTr2ATmSfYf5vWRfwHeJU2cZeg0JWw+
 QgrHMI3FHvcakYv0cKnNhEcic/K8dWiYmgsl4aRUzYOLfjNGTrxatGzBks6NR/VxusBBuQ
 5tg1LwoshH/G+r+BRYFK7ecO8NHhaUJQlCewT9TDDwXbh947TvAaBc8PusXd1yqzgL/bJB
 AbxmNKM7wL/fB3YdE4q7RMre0/h1HniGQhJJ7l2JOvWP9VdHSukOPxd2qWaD/YOZm0ydJq
 X2O+eCNQrV/FImSOvTnZNHAHIWaZYFr23/5uFlmReAp0pKzmwZZYOiv7G4PAXQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] dm: Respect dma-ranges size
Date: Mon, 16 Mar 2026 00:57:23 +0100
Message-ID: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4e8f89afc82cb4b2407
X-MBO-RS-META: oh1u4zpiyx3fca8a8d8td4cnaagfb3pp
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

Rework dev_phys_to_bus() and dev_bus_to_phys() to respect the size
of the area specified in dma-ranges DT property. The area outside
of ranges is remapped 1:1, while the area in the ranges is remapped
according to the description in the dma-ranges property.

Adjust the test to test the area within the remapped range, not area
outside the remapped range, which was incorrect.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/core/device.c |  6 +++++-
 include/dm/device.h   | 17 ++++++-----------
 include/phys2bus.h    | 12 +++++++++---
 test/dm/core.c        |  6 +++---
 test/dm/phys2bus.c    |  4 ++--
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 779f371b9d5..d365204ba11 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -473,7 +473,11 @@ static int device_get_dma_constraints(struct udevice *dev)
 		return ret;
 	}
 
-	dev_set_dma_offset(dev, cpu - bus);
+#if CONFIG_IS_ENABLED(DM_DMA)
+	dev->dma_cpu = cpu;
+	dev->dma_bus = bus;
+	dev->dma_size = size;
+#endif
 
 	return 0;
 }
diff --git a/include/dm/device.h b/include/dm/device.h
index 678cd83c271..7bcf6df2892 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -166,8 +166,9 @@ enum {
  *		When CONFIG_DEVRES is enabled, devm_kmalloc() and friends will
  *		add to this list. Memory so-allocated will be freed
  *		automatically when the device is removed / unbound
- * @dma_offset: Offset between the physical address space (CPU's) and the
- *		device's bus address space
+ * @dma_cpu: DMA physical address space (CPU's)
+ * @dma_bus: DMA device's bus address space
+ * @dma_size: DMA window size
  * @iommu: IOMMU device associated with this device
  */
 struct udevice {
@@ -196,7 +197,9 @@ struct udevice {
 	struct list_head devres_head;
 #endif
 #if CONFIG_IS_ENABLED(DM_DMA)
-	ulong dma_offset;
+	phys_addr_t dma_cpu;
+	dma_addr_t dma_bus;
+	u64 dma_size;
 #endif
 #if CONFIG_IS_ENABLED(IOMMU)
 	struct udevice *iommu;
@@ -272,14 +275,6 @@ static inline __attribute_const__ ofnode dev_ofnode(const struct udevice *dev)
 /* Returns non-zero if the device is active (probed and not removed) */
 #define device_active(dev)	(dev_get_flags(dev) & DM_FLAG_ACTIVATED)
 
-#if CONFIG_IS_ENABLED(DM_DMA)
-#define dev_set_dma_offset(_dev, _offset)	_dev->dma_offset = _offset
-#define dev_get_dma_offset(_dev)		_dev->dma_offset
-#else
-#define dev_set_dma_offset(_dev, _offset)
-#define dev_get_dma_offset(_dev)		0
-#endif
-
 static inline __attribute_const__ int dev_of_offset(const struct udevice *dev)
 {
 #if CONFIG_IS_ENABLED(OF_REAL)
diff --git a/include/phys2bus.h b/include/phys2bus.h
index 866b8b51a8c..80fa88adae1 100644
--- a/include/phys2bus.h
+++ b/include/phys2bus.h
@@ -21,17 +21,23 @@ static inline unsigned long bus_to_phys(unsigned long bus)
 }
 #endif
 
-#if CONFIG_IS_ENABLED(DM)
+#if CONFIG_IS_ENABLED(DM_DMA)
 #include <dm/device.h>
 
 static inline dma_addr_t dev_phys_to_bus(struct udevice *dev, phys_addr_t phys)
 {
-	return phys - dev_get_dma_offset(dev);
+	/* If the PA is in the remap range, apply remap. */
+	if (phys >= dev->dma_cpu && phys < dev->dma_cpu + dev->dma_size)
+		phys -= dev->dma_cpu - dev->dma_bus;
+	return phys;
 }
 
 static inline phys_addr_t dev_bus_to_phys(struct udevice *dev, dma_addr_t bus)
 {
-	return bus + dev_get_dma_offset(dev);
+	/* If the DA is in the remap range, apply remap. */
+	if (bus >= dev->dma_bus && bus < dev->dma_bus + dev->dma_size)
+		bus += dev->dma_cpu - dev->dma_bus;
+	return bus;
 }
 #else
 #define dev_phys_to_bus(_, _addr)	_addr
diff --git a/test/dm/core.c b/test/dm/core.c
index 78ee14af228..bb9f526b064 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -1248,13 +1248,13 @@ static int dm_test_dma_offset(struct unit_test_state *uts)
        node = ofnode_path("/mmio-bus@0");
        ut_assert(ofnode_valid(node));
        ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_BUS, node, &dev));
-       ut_asserteq_64(0, dev->dma_offset);
+       ut_asserteq_64(0, dev->dma_cpu - dev->dma_bus);
 
        /* Device behind a bus with dma-ranges */
        node = ofnode_path("/mmio-bus@0/subnode@0");
        ut_assert(ofnode_valid(node));
        ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &dev));
-       ut_asserteq_64(-0x10000000ULL, dev->dma_offset);
+       ut_asserteq_64(-0x10000000ULL, dev->dma_cpu - dev->dma_bus);
 
        /* This one has no dma-ranges */
        node = ofnode_path("/mmio-bus@1");
@@ -1263,7 +1263,7 @@ static int dm_test_dma_offset(struct unit_test_state *uts)
        node = ofnode_path("/mmio-bus@1/subnode@0");
        ut_assert(ofnode_valid(node));
        ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &dev));
-       ut_asserteq_64(0, dev->dma_offset);
+       ut_asserteq_64(0, dev->dma_cpu - dev->dma_bus);
 
        return 0;
 }
diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
index 0f30c7e37fd..67f33904943 100644
--- a/test/dm/phys2bus.c
+++ b/test/dm/phys2bus.c
@@ -28,8 +28,8 @@ static int dm_test_phys_to_bus(struct unit_test_state *uts)
 	node = ofnode_path("/mmio-bus@0/subnode@0");
 	ut_assert(ofnode_valid(node));
 	ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &dev));
-	ut_asserteq_addr((void*)0x100fffffULL, (void*)dev_phys_to_bus(dev, 0xfffff));
-	ut_asserteq_addr((void*)0xfffffULL, (void*)(ulong)dev_bus_to_phys(dev, 0x100fffff));
+	ut_asserteq_addr((void*)0x1003ffffULL, (void*)dev_phys_to_bus(dev, 0x3ffff));
+	ut_asserteq_addr((void*)0x3ffffULL, (void*)(ulong)dev_bus_to_phys(dev, 0x1003ffff));
 
 	return 0;
 }
-- 
2.51.0

