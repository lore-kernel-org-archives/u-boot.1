Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E70EE83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1799F83C72;
	Mon, 16 Feb 2026 22:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48B283D3D; Mon, 16 Feb 2026 22:23:22 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4C083DEB
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs63a-000000002kb-2j5o; Mon, 16 Feb 2026 21:23:02 +0000
Date: Mon, 16 Feb 2026 21:22:59 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: [RFC PATCH 11/20] test: boot: add image_loader unit tests
Message-ID: <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:23:42 +0100
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

Add unit tests for the image_loader framework covering its core
logic with a mock storage backend:

- map() allocates, reads and records a region
- map() returns cached pointer for already-mapped range
- map() returns correct offset within a larger region
- map() re-reads when extending a region to a larger size
- map_to() reads to a specified address and records it
- lookup() returns NULL for unmapped ranges
- alloc_ptr advances with correct alignment
- map() returns NULL when the translation table is full
- cleanup() calls backend and resets state
- map() with multiple disjoint regions
- read beyond image size returns error

Also fix IMAGE_LOADER_MAX_REGIONS Kconfig to depend on IMAGE_LOADER
and default to 16 unconditionally (the previous 'default 0' fallback
caused the regions array to be zero-sized when IMAGE_LOADER was
enabled after initial defconfig generation).

Register the new 'image_loader' test suite in test/cmd_ut.c so it
can be run via 'ut image_loader'.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig             |   4 +-
 test/boot/Makefile       |   2 +
 test/boot/image_loader.c | 429 +++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c            |   2 +
 4 files changed, 435 insertions(+), 2 deletions(-)
 create mode 100644 test/boot/image_loader.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 1f870c7d251..efc06f3cd1a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1179,8 +1179,8 @@ config IMAGE_LOADER
 
 config IMAGE_LOADER_MAX_REGIONS
 	int "Maximum number of mapped regions in image loader"
-	default 16 if IMAGE_LOADER
-	default 0
+	depends on IMAGE_LOADER
+	default 16
 	help
 	  Maximum number of distinct image regions that can be mapped
 	  into RAM simultaneously. 16 is sufficient for typical FIT
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 89538d4f0a6..6fd349a65bc 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -23,3 +23,5 @@ endif
 obj-$(CONFIG_BOOTMETH_VBE) += vbe_fixup.o
 
 obj-$(CONFIG_UPL) += upl.o
+
+obj-$(CONFIG_IMAGE_LOADER) += image_loader.o
diff --git a/test/boot/image_loader.c b/test/boot/image_loader.c
new file mode 100644
index 00000000000..dc4b0b4173a
--- /dev/null
+++ b/test/boot/image_loader.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for image_loader framework
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <image-loader.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define IMG_LOADER_TEST(_name, _flags) \
+	UNIT_TEST(_name, _flags, image_loader)
+
+/* Synthetic image size used throughout the tests */
+#define IMAGE_SIZE	4096
+
+/**
+ * struct mock_priv - private data for the mock storage backend
+ *
+ * @image:	pointer to synthetic image data in RAM
+ * @image_size:	size of the synthetic image
+ * @read_count:	number of times .read() was called
+ * @last_off:	offset from the most recent .read() call
+ * @last_size:	size from the most recent .read() call
+ */
+struct mock_priv {
+	const void *image;
+	size_t image_size;
+	int read_count;
+	ulong last_off;
+	ulong last_size;
+};
+
+static int mock_read(struct image_loader *ldr, ulong src, ulong size,
+		     void *dst)
+{
+	struct mock_priv *p = ldr->priv;
+
+	if (src + size > p->image_size)
+		return -EINVAL;
+
+	memcpy(dst, (const char *)p->image + src, size);
+	p->read_count++;
+	p->last_off = src;
+	p->last_size = size;
+
+	return 0;
+}
+
+static void mock_cleanup(struct image_loader *ldr)
+{
+	/* Nothing dynamic to free — just verify it's called */
+}
+
+/**
+ * init_mock_loader() - set up a loader with the mock backend
+ *
+ * @ldr:	loader to initialise
+ * @priv:	mock private data (caller-allocated)
+ * @image:	synthetic image buffer
+ * @image_size:	size of @image
+ * @alloc_base:	RAM address to use as alloc_ptr base
+ */
+static void init_mock_loader(struct image_loader *ldr, struct mock_priv *priv,
+			     const void *image, size_t image_size,
+			     ulong alloc_base)
+{
+	memset(ldr, 0, sizeof(*ldr));
+	memset(priv, 0, sizeof(*priv));
+
+	priv->image = image;
+	priv->image_size = image_size;
+
+	ldr->read = mock_read;
+	ldr->cleanup = mock_cleanup;
+	ldr->priv = priv;
+	ldr->alloc_ptr = alloc_base;
+}
+
+/* Test: map() allocates, reads and records a region */
+static int image_loader_test_map_basic(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p;
+
+	/* Fill image with a recognisable pattern */
+	for (int i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Map a 64-byte region at offset 0 */
+	p = image_loader_map(&ldr, 0, 64);
+	ut_assertnonnull(p);
+	ut_asserteq_mem(image, p, 64);
+	ut_asserteq(1, mock.read_count);
+	ut_asserteq(1, ldr.nr_regions);
+	ut_asserteq(0, (int)ldr.regions[0].img_offset);
+	ut_asserteq(64, (int)ldr.regions[0].size);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_map_basic, 0);
+
+/* Test: map() returns cached pointer for already-mapped range */
+static int image_loader_test_map_cached(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p1, *p2;
+
+	memset(image, 0xaa, IMAGE_SIZE);
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	p1 = image_loader_map(&ldr, 0, 128);
+	ut_assertnonnull(p1);
+	ut_asserteq(1, mock.read_count);
+
+	/* Same range — should return same pointer, no new read */
+	p2 = image_loader_map(&ldr, 0, 128);
+	ut_asserteq_ptr(p1, p2);
+	ut_asserteq(1, mock.read_count);
+
+	/* Subset of the already-mapped range — still cached */
+	p2 = image_loader_map(&ldr, 0, 64);
+	ut_asserteq_ptr(p1, p2);
+	ut_asserteq(1, mock.read_count);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_map_cached, 0);
+
+/* Test: map() returns correct offset within a larger region */
+static int image_loader_test_map_offset(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p1, *p2;
+
+	for (int i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Map a 256-byte region starting at offset 0 */
+	p1 = image_loader_map(&ldr, 0, 256);
+	ut_assertnonnull(p1);
+
+	/* Request a sub-range within the previously mapped region */
+	p2 = image_loader_map(&ldr, 64, 64);
+	ut_assertnonnull(p2);
+	/* p2 should point 64 bytes into p1 */
+	ut_asserteq_ptr((char *)p1 + 64, p2);
+	ut_asserteq_mem(image + 64, p2, 64);
+	/* Only one read should have occurred */
+	ut_asserteq(1, mock.read_count);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_map_offset, 0);
+
+/* Test: map() re-reads when extending a region to a larger size */
+static int image_loader_test_map_extend(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p1, *p2;
+
+	for (int i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Initial small mapping */
+	p1 = image_loader_map(&ldr, 0, 64);
+	ut_assertnonnull(p1);
+	ut_asserteq(1, mock.read_count);
+
+	/* Request larger range at same base — should re-read (extend) */
+	p2 = image_loader_map(&ldr, 0, 256);
+	ut_assertnonnull(p2);
+	ut_asserteq(2, mock.read_count);
+	ut_asserteq_ptr(p1, p2);	/* same RAM base */
+	ut_asserteq_mem(image, p2, 256);
+
+	/* Region count should still be 1 (updated, not added) */
+	ut_asserteq(1, ldr.nr_regions);
+	ut_asserteq(256, (int)ldr.regions[0].size);
+
+	/* alloc_ptr must have advanced past the extended region */
+	ut_assert(ldr.alloc_ptr >= 0x1000000 + 256);
+
+	/*
+	 * Map a new region after the extend — it must not overlap the
+	 * extended first region. This is the exact pattern that bit us
+	 * on real hardware: FIT header at offset 0 extended from 64 to
+	 * 4096, then kernel payload at offset 4096 was allocated at
+	 * alloc_ptr that hadn't been advanced, clobbering the header.
+	 */
+	{
+		void *p3 = image_loader_map(&ldr, 256, 128);
+
+		ut_assertnonnull(p3);
+		ut_asserteq(2, ldr.nr_regions);
+		/* New region must start at or after the extended region end */
+		ut_assert((ulong)map_to_sysmem(p3) >= 0x1000000 + 256);
+		ut_asserteq_mem(image + 256, p3, 128);
+	}
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_map_extend, 0);
+
+/* Test: map_to() reads to a specified address and records it */
+static int image_loader_test_map_to(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	u8 dst[256];
+	void *p;
+
+	for (int i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	p = image_loader_map_to(&ldr, 128, 256, dst);
+	ut_asserteq_ptr(dst, p);
+	ut_asserteq_mem(image + 128, dst, 256);
+	ut_asserteq(1, mock.read_count);
+	ut_asserteq(1, ldr.nr_regions);
+	ut_asserteq(128, (int)ldr.regions[0].img_offset);
+	ut_asserteq(256, (int)ldr.regions[0].size);
+	ut_asserteq_ptr(dst, ldr.regions[0].ram);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_map_to, 0);
+
+/* Test: lookup() returns NULL for unmapped ranges */
+static int image_loader_test_lookup_miss(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p;
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Nothing mapped yet — should return NULL */
+	p = image_loader_lookup(&ldr, 0, 64);
+	ut_assertnull(p);
+
+	/* Map a region at offset 0 */
+	ut_assertnonnull(image_loader_map(&ldr, 0, 64));
+
+	/* Lookup within the mapped region — should succeed */
+	p = image_loader_lookup(&ldr, 0, 32);
+	ut_assertnonnull(p);
+
+	/* Lookup at a different offset — should miss */
+	p = image_loader_lookup(&ldr, 128, 32);
+	ut_assertnull(p);
+
+	/* Lookup extending beyond the mapped region — should miss */
+	p = image_loader_lookup(&ldr, 0, 128);
+	ut_assertnull(p);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_lookup_miss, 0);
+
+/* Test: alloc_ptr advances with correct alignment */
+static int image_loader_test_alloc_advance(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	ulong base = 0x1000000;
+	ulong expected;
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, base);
+
+	/* Map 100 bytes — alloc_ptr should advance to ALIGN(base + 100) */
+	ut_assertnonnull(image_loader_map(&ldr, 0, 100));
+	expected = ALIGN(base + 100, ARCH_DMA_MINALIGN);
+	ut_asserteq(expected, ldr.alloc_ptr);
+
+	/* Map another 200 bytes at a different offset */
+	ut_assertnonnull(image_loader_map(&ldr, 200, 200));
+	expected = ALIGN(expected + 200, ARCH_DMA_MINALIGN);
+	ut_asserteq(expected, ldr.alloc_ptr);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_alloc_advance, 0);
+
+/* Test: map() returns NULL when the translation table is full */
+static int image_loader_test_table_full(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p;
+	int i;
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Fill all region slots with distinct offsets */
+	for (i = 0; i < CONFIG_IMAGE_LOADER_MAX_REGIONS; i++) {
+		p = image_loader_map(&ldr, i * 16, 8);
+		ut_assertnonnull(p);
+	}
+
+	ut_asserteq(CONFIG_IMAGE_LOADER_MAX_REGIONS, ldr.nr_regions);
+
+	/* Next map at a new offset should fail (table full) */
+	p = image_loader_map(&ldr, CONFIG_IMAGE_LOADER_MAX_REGIONS * 16, 8);
+	ut_assertnull(p);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_table_full, 0);
+
+/* Test: cleanup() calls the backend and resets state */
+static int image_loader_test_cleanup(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Map something so nr_regions > 0 */
+	ut_assertnonnull(image_loader_map(&ldr, 0, 64));
+	ut_asserteq(1, ldr.nr_regions);
+
+	image_loader_cleanup(&ldr);
+
+	ut_assertnull(ldr.read);
+	ut_assertnull(ldr.cleanup);
+	ut_assertnull(ldr.priv);
+	ut_asserteq(0, ldr.nr_regions);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_cleanup, 0);
+
+/* Test: map() with multiple disjoint regions */
+static int image_loader_test_multi_region(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p1, *p2, *p3;
+
+	for (int i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	p1 = image_loader_map(&ldr, 0, 64);
+	ut_assertnonnull(p1);
+	p2 = image_loader_map(&ldr, 512, 128);
+	ut_assertnonnull(p2);
+	p3 = image_loader_map(&ldr, 1024, 256);
+	ut_assertnonnull(p3);
+
+	ut_asserteq(3, ldr.nr_regions);
+	ut_asserteq(3, mock.read_count);
+
+	/* Verify data in each region */
+	ut_asserteq_mem(image, p1, 64);
+	ut_asserteq_mem(image + 512, p2, 128);
+	ut_asserteq_mem(image + 1024, p3, 256);
+
+	/* Lookup each region */
+	ut_asserteq_ptr(p1, image_loader_lookup(&ldr, 0, 64));
+	ut_asserteq_ptr(p2, image_loader_lookup(&ldr, 512, 128));
+	ut_asserteq_ptr(p3, image_loader_lookup(&ldr, 1024, 256));
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_multi_region, 0);
+
+/* Test: read beyond image size returns error */
+static int image_loader_test_read_oob(struct unit_test_state *uts)
+{
+	struct image_loader ldr;
+	struct mock_priv mock;
+	u8 image[IMAGE_SIZE];
+	void *p;
+
+	init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
+
+	/* Attempt to map beyond the end of the image */
+	p = image_loader_map(&ldr, IMAGE_SIZE - 32, 64);
+	ut_assertnull(p);
+
+	/* map_to should also fail */
+	u8 dst[64];
+
+	p = image_loader_map_to(&ldr, IMAGE_SIZE - 32, 64, dst);
+	ut_assertnull(p);
+
+	return 0;
+}
+
+IMG_LOADER_TEST(image_loader_test_read_oob, 0);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 44e5fdfdaa6..3b907a12e4e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -71,6 +71,7 @@ SUITE_DECL(optee);
 SUITE_DECL(pci_mps);
 SUITE_DECL(seama);
 SUITE_DECL(setexpr);
+SUITE_DECL(image_loader);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
@@ -98,6 +99,7 @@ static struct suite suites[] = {
 	SUITE(pci_mps, "PCI Express Maximum Payload Size"),
 	SUITE(seama, "seama command parameters loading and decoding"),
 	SUITE(setexpr, "setexpr command"),
+	SUITE(image_loader, "image_loader on-demand storage loading"),
 	SUITE(upl, "Universal payload support"),
 };
 
-- 
2.53.0
