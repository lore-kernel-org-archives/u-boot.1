Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B41CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7317848E3;
	Sat, 16 May 2026 03:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7510884884; Sat, 16 May 2026 01:38:51 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBB48480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO26x-000000004kD-1c91; Fri, 15 May 2026 23:38:31 +0000
Date: Sat, 16 May 2026 00:38:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v5 6/8] test: boot: add runtime unit test for
 fit_verity_build_cmdline()
Message-ID: <b5d9335da9534c173e0e5c6a39863cbd3072f2d0.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1778887196.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Sat, 16 May 2026 03:04:00 +0200
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

Add test/boot/fit_verity.c with four tests that construct FIT blobs
in memory and exercise fit_verity_build_cmdline().

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: no changes
v4: no changes
v3: replace literal property name strings with the FIT_VERITY_*_PROP
v2: new patch
---
 test/boot/Makefile     |   1 +
 test/boot/fit_verity.c | 306 +++++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c          |   2 +
 3 files changed, 309 insertions(+)
 create mode 100644 test/boot/fit_verity.c

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 89538d4f0a6..d98f212b243 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -15,6 +15,7 @@ endif
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_$(PHASE_)CMDLINE) += bootm.o
 endif
+obj-$(CONFIG_$(PHASE_)FIT_VERITY) += fit_verity.o
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 ifdef CONFIG_OF_LIVE
diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
new file mode 100644
index 00000000000..8011459a1cb
--- /dev/null
+++ b/test/boot/fit_verity.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for FIT dm-verity cmdline generation
+ *
+ * Copyright 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <image.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define FIT_VERITY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fit_verity)
+
+/* FIT blob buffer size — generous to avoid FDT_ERR_NOSPACE */
+#define FIT_BUF_SIZE	4096
+
+/* Test digest (32 bytes = sha256) */
+static const u8 test_digest[32] = {
+	0x8e, 0x67, 0x91, 0x63, 0x7f, 0x93, 0xcb, 0xb8,
+	0x1f, 0xc4, 0x52, 0x99, 0xe2, 0x03, 0xcb, 0xe8,
+	0x5c, 0xa2, 0xe4, 0x7a, 0x38, 0xf5, 0x05, 0x1b,
+	0xdd, 0xee, 0xce, 0x92, 0xd7, 0xb1, 0xc9, 0xf9,
+};
+
+/* Test salt (32 bytes) */
+static const u8 test_salt[32] = {
+	0xaa, 0x7b, 0x11, 0xf8, 0xdb, 0x8f, 0xe2, 0xe5,
+	0xbf, 0xd4, 0xec, 0xa1, 0xd1, 0x8a, 0x22, 0xb5,
+	0xde, 0x7e, 0xa3, 0x9d, 0x2e, 0x1b, 0x93, 0xbb,
+	0x72, 0x72, 0xce, 0x0c, 0x6c, 0xa3, 0xcc, 0x8e,
+};
+
+/**
+ * build_verity_fit() - construct a minimal FIT blob with dm-verity metadata
+ * @buf:		output buffer (at least FIT_BUF_SIZE bytes)
+ * @num_loadables:	number of filesystem loadables to create (1 or 2)
+ *
+ * Builds a FIT blob containing:
+ *  - /images/rootfsN  with type="filesystem" and a dm-verity subnode
+ *  - /configurations/conf-1  referencing the loadable(s)
+ *
+ * Return: configuration node offset, or -ve on error
+ */
+static int build_verity_fit(void *buf, int num_loadables)
+{
+	int images_node, conf_node, confs_node, img_node, verity_node;
+	fdt32_t val;
+	int ret, i;
+	char name[32];
+	/*
+	 * Build the loadables string list. FDT stringlists are concatenated
+	 * NUL-terminated strings. E.g. "rootfs0\0rootfs1\0"
+	 */
+	char loadables[128];
+	int loadables_len = 0;
+
+	ret = fdt_create_empty_tree(buf, FIT_BUF_SIZE);
+	if (ret)
+		return ret;
+
+	/* /images */
+	images_node = fdt_add_subnode(buf, 0, "images");
+	if (images_node < 0)
+		return images_node;
+
+	for (i = 0; i < num_loadables; i++) {
+		snprintf(name, sizeof(name), "rootfs%d", i);
+
+		img_node = fdt_add_subnode(buf, images_node, name);
+		if (img_node < 0)
+			return img_node;
+
+		ret = fdt_setprop_string(buf, img_node, FIT_TYPE_PROP,
+					 "filesystem");
+		if (ret)
+			return ret;
+
+		verity_node = fdt_add_subnode(buf, img_node,
+					      FIT_VERITY_NODENAME);
+		if (verity_node < 0)
+			return verity_node;
+
+		ret = fdt_setprop_string(buf, verity_node,
+					 FIT_VERITY_ALGO_PROP, "sha256");
+		if (ret)
+			return ret;
+
+		val = cpu_to_fdt32(4096);
+		ret = fdt_setprop(buf, verity_node, FIT_VERITY_DBS_PROP,
+				  &val, sizeof(val));
+		if (ret)
+			return ret;
+
+		ret = fdt_setprop(buf, verity_node, FIT_VERITY_HBS_PROP,
+				  &val, sizeof(val));
+		if (ret)
+			return ret;
+
+		val = cpu_to_fdt32(100);
+		ret = fdt_setprop(buf, verity_node, FIT_VERITY_NBLK_PROP,
+				  &val, sizeof(val));
+		if (ret)
+			return ret;
+
+		val = cpu_to_fdt32(100);
+		ret = fdt_setprop(buf, verity_node, FIT_VERITY_HBLK_PROP,
+				  &val, sizeof(val));
+		if (ret)
+			return ret;
+
+		ret = fdt_setprop(buf, verity_node, FIT_VERITY_DIGEST_PROP,
+				  test_digest, sizeof(test_digest));
+		if (ret)
+			return ret;
+
+		ret = fdt_setprop(buf, verity_node, FIT_VERITY_SALT_PROP,
+				  test_salt, sizeof(test_salt));
+		if (ret)
+			return ret;
+
+		/* Append to loadables stringlist */
+		loadables_len += snprintf(loadables + loadables_len,
+					  sizeof(loadables) - loadables_len,
+					  "%s", name) + 1;
+	}
+
+	/* /configurations/conf-1 */
+	confs_node = fdt_add_subnode(buf, 0, "configurations");
+	if (confs_node < 0)
+		return confs_node;
+
+	conf_node = fdt_add_subnode(buf, confs_node, "conf-1");
+	if (conf_node < 0)
+		return conf_node;
+
+	ret = fdt_setprop(buf, conf_node, FIT_LOADABLE_PROP,
+			  loadables, loadables_len);
+	if (ret)
+		return ret;
+
+	return conf_node;
+}
+
+/* Test: single dm-verity loadable produces correct cmdline fragments */
+static int fit_verity_test_single(struct unit_test_state *uts)
+{
+	char buf[FIT_BUF_SIZE];
+	struct bootm_headers images;
+	int conf_noffset;
+
+	conf_noffset = build_verity_fit(buf, 1);
+	ut_assert(conf_noffset >= 0);
+
+	memset(&images, 0, sizeof(images));
+	ut_assertok(fit_verity_build_cmdline(buf, conf_noffset, &images));
+
+	/* dm_mod_create should contain the target spec for rootfs0 */
+	ut_assertnonnull(images.dm_mod_create);
+	ut_assert(strstr(images.dm_mod_create, "rootfs0,,,"));
+	ut_assert(strstr(images.dm_mod_create, "verity 1"));
+	ut_assert(strstr(images.dm_mod_create, "/dev/fit0"));
+	ut_assert(strstr(images.dm_mod_create, "4096 4096 100 100"));
+	ut_assert(strstr(images.dm_mod_create, "sha256"));
+	/* Check hex-encoded digest prefix */
+	ut_assert(strstr(images.dm_mod_create, "8e6791637f93cbb8"));
+	/* Check hex-encoded salt prefix */
+	ut_assert(strstr(images.dm_mod_create, "aa7b11f8db8fe2e5"));
+
+	/* dm_mod_waitfor should reference /dev/fit0 */
+	ut_assertnonnull(images.dm_mod_waitfor);
+	ut_asserteq_str("/dev/fit0", images.dm_mod_waitfor);
+
+	fit_verity_free(&images);
+	ut_assertnull(images.dm_mod_create);
+	ut_assertnull(images.dm_mod_waitfor);
+
+	return 0;
+}
+FIT_VERITY_TEST(fit_verity_test_single, 0);
+
+/* Test: FIT with no dm-verity subnode returns 0, pointers stay NULL */
+static int fit_verity_test_no_verity(struct unit_test_state *uts)
+{
+	char buf[FIT_BUF_SIZE];
+	struct bootm_headers images;
+	int conf_node, images_node, img_node, confs_node;
+	int ret;
+
+	ret = fdt_create_empty_tree(buf, FIT_BUF_SIZE);
+	ut_assertok(ret);
+
+	images_node = fdt_add_subnode(buf, 0, "images");
+	ut_assert(images_node >= 0);
+
+	img_node = fdt_add_subnode(buf, images_node, "rootfs");
+	ut_assert(img_node >= 0);
+	ut_assertok(fdt_setprop_string(buf, img_node, FIT_TYPE_PROP,
+				       "filesystem"));
+	/* No dm-verity subnode */
+
+	confs_node = fdt_add_subnode(buf, 0, "configurations");
+	ut_assert(confs_node >= 0);
+	conf_node = fdt_add_subnode(buf, confs_node, "conf-1");
+	ut_assert(conf_node >= 0);
+	ut_assertok(fdt_setprop_string(buf, conf_node, FIT_LOADABLE_PROP,
+				       "rootfs"));
+
+	memset(&images, 0, sizeof(images));
+	ut_asserteq(0, fit_verity_build_cmdline(buf, conf_node, &images));
+	ut_assertnull(images.dm_mod_create);
+	ut_assertnull(images.dm_mod_waitfor);
+
+	return 0;
+}
+FIT_VERITY_TEST(fit_verity_test_no_verity, 0);
+
+/* Test: two dm-verity loadables produce combined cmdline */
+static int fit_verity_test_two_loadables(struct unit_test_state *uts)
+{
+	char buf[FIT_BUF_SIZE];
+	struct bootm_headers images;
+	int conf_noffset;
+
+	conf_noffset = build_verity_fit(buf, 2);
+	ut_assert(conf_noffset >= 0);
+
+	memset(&images, 0, sizeof(images));
+	ut_assertok(fit_verity_build_cmdline(buf, conf_noffset, &images));
+
+	/* Both targets should appear, separated by ";" */
+	ut_assertnonnull(images.dm_mod_create);
+	ut_assert(strstr(images.dm_mod_create, "rootfs0,,,"));
+	ut_assert(strstr(images.dm_mod_create, ";rootfs1,,,"));
+	ut_assert(strstr(images.dm_mod_create, "/dev/fit0"));
+	ut_assert(strstr(images.dm_mod_create, "/dev/fit1"));
+
+	/* dm_mod_waitfor should list both devices */
+	ut_assertnonnull(images.dm_mod_waitfor);
+	ut_assert(strstr(images.dm_mod_waitfor, "/dev/fit0"));
+	ut_assert(strstr(images.dm_mod_waitfor, "/dev/fit1"));
+
+	fit_verity_free(&images);
+	return 0;
+}
+FIT_VERITY_TEST(fit_verity_test_two_loadables, 0);
+
+/* Test: invalid block size (not power of two) returns -EINVAL */
+static int fit_verity_test_bad_blocksize(struct unit_test_state *uts)
+{
+	char buf[FIT_BUF_SIZE];
+	struct bootm_headers images;
+	int images_node, conf_node, confs_node, img_node, verity_node;
+	fdt32_t val;
+	int ret;
+
+	ret = fdt_create_empty_tree(buf, FIT_BUF_SIZE);
+	ut_assertok(ret);
+
+	images_node = fdt_add_subnode(buf, 0, "images");
+	ut_assert(images_node >= 0);
+
+	img_node = fdt_add_subnode(buf, images_node, "rootfs");
+	ut_assert(img_node >= 0);
+	ut_assertok(fdt_setprop_string(buf, img_node, FIT_TYPE_PROP,
+				       "filesystem"));
+
+	verity_node = fdt_add_subnode(buf, img_node, FIT_VERITY_NODENAME);
+	ut_assert(verity_node >= 0);
+
+	ut_assertok(fdt_setprop_string(buf, verity_node,
+				       FIT_VERITY_ALGO_PROP, "sha256"));
+
+	/* 3000 is not a power of two */
+	val = cpu_to_fdt32(3000);
+	ut_assertok(fdt_setprop(buf, verity_node, FIT_VERITY_DBS_PROP,
+				&val, sizeof(val)));
+	val = cpu_to_fdt32(4096);
+	ut_assertok(fdt_setprop(buf, verity_node, FIT_VERITY_HBS_PROP,
+				&val, sizeof(val)));
+
+	val = cpu_to_fdt32(100);
+	ut_assertok(fdt_setprop(buf, verity_node, FIT_VERITY_NBLK_PROP,
+				&val, sizeof(val)));
+	ut_assertok(fdt_setprop(buf, verity_node, FIT_VERITY_HBLK_PROP,
+				&val, sizeof(val)));
+
+	ut_assertok(fdt_setprop(buf, verity_node, FIT_VERITY_DIGEST_PROP,
+				test_digest, sizeof(test_digest)));
+	ut_assertok(fdt_setprop(buf, verity_node, FIT_VERITY_SALT_PROP,
+				test_salt, sizeof(test_salt)));
+
+	confs_node = fdt_add_subnode(buf, 0, "configurations");
+	ut_assert(confs_node >= 0);
+	conf_node = fdt_add_subnode(buf, confs_node, "conf-1");
+	ut_assert(conf_node >= 0);
+	ut_assertok(fdt_setprop_string(buf, conf_node, FIT_LOADABLE_PROP,
+				       "rootfs"));
+
+	memset(&images, 0, sizeof(images));
+	ut_asserteq(-EINVAL, fit_verity_build_cmdline(buf, conf_node, &images));
+	ut_assertnull(images.dm_mod_create);
+	ut_assertnull(images.dm_mod_waitfor);
+
+	return 0;
+}
+FIT_VERITY_TEST(fit_verity_test_bad_blocksize, 0);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 44e5fdfdaa6..d1b376f617c 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -59,6 +59,7 @@ SUITE_DECL(env);
 SUITE_DECL(exit);
 SUITE_DECL(fdt);
 SUITE_DECL(fdt_overlay);
+SUITE_DECL(fit_verity);
 SUITE_DECL(font);
 SUITE_DECL(hush);
 SUITE_DECL(lib);
@@ -86,6 +87,7 @@ static struct suite suites[] = {
 	SUITE(exit, "shell exit and variables"),
 	SUITE(fdt, "fdt command"),
 	SUITE(fdt_overlay, "device tree overlays"),
+	SUITE(fit_verity, "FIT dm-verity cmdline generation"),
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(lib, "library functions"),
-- 
2.54.0
