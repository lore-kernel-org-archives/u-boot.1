Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED73E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5ED83E72;
	Mon, 16 Feb 2026 22:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8FB83DC9; Mon, 16 Feb 2026 22:23:12 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00EF83E60
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs63S-000000002k2-3JyJ; Mon, 16 Feb 2026 21:22:54 +0000
Date: Mon, 16 Feb 2026 21:22:51 +0000
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
Subject: [RFC PATCH 10/20] cmd: bootm: accept storage device as image source
Message-ID: <5b30234322e3efdc4efb4c1e2b312418bc3e90a4.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:23:19 +0100
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

Extend the bootm command to accept a storage device type keyword as
the first argument:

    bootm mmc <dev>:<part>    - boot from MMC/SD/eMMC partition
    bootm mtd <name>          - boot from MTD partition
    bootm ubi <volume>        - boot from UBI volume

When a known device-type keyword is found, an image_loader is
constructed using the corresponding backend and stored in
images.loader. The rest of the bootm flow proceeds unchanged:
boot_get_kernel() uses image_loader_map() for format detection and
FDT structure loading, then fit_image_load() uses the on-demand
storage path for sub-image data.

If the first argument does not match a device-type keyword (i.e. it
looks like a hex address, or is absent), images.loader remains NULL
and the existing in-memory path is taken -- full backward compatibility.

The #config suffix follows the same convention as existing bootm FIT
config selection. Multiple # suffixes can be chained to select a
base config and one or more device-tree overlays:

    bootm mmc 0:4#config-1#overlay-wifi#overlay-lcd
    bootm mtd firmware#config-1

Gated by CONFIG_BOOTM_STORAGE.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig    |  13 +++++
 boot/bootm.c    |  62 +++++++++++++++++---
 cmd/bootm.c     | 148 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/bootm.h |   2 +
 4 files changed, 212 insertions(+), 13 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 89832014af6..1f870c7d251 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1211,6 +1211,19 @@ config IMAGE_LOADER_UBI
 	  framework. Auto-attaches the UBI device from the device tree
 	  if not already attached.
 
+config BOOTM_STORAGE
+	bool "Allow bootm to load images directly from storage"
+	depends on CMDLINE && FIT && IMAGE_LOADER
+	help
+	  Extends the bootm command to accept "mmc <dev>:<part>",
+	  "mtd <name>", or "ubi <volume>" as the image source instead
+	  of a RAM address. Sub-images (kernel, FDT, ramdisk, etc.)
+	  are loaded from storage on demand; filesystem sub-images are
+	  never read.
+
+	  Requires at least one IMAGE_LOADER backend to be enabled
+	  (IMAGE_LOADER_BLK, IMAGE_LOADER_MTD, or IMAGE_LOADER_UBI).
+
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
 	select CMDLINE
diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8c..67d161f6e3a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -13,6 +13,7 @@
 #include <env.h>
 #include <errno.h>
 #include <fdt_support.h>
+#include <image-loader.h>
 #include <irq_func.h>
 #include <lmb.h>
 #include <log.h>
@@ -146,7 +147,22 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 
 	/* check image type, for FIT images get FIT kernel node */
 	*os_data = *os_len = 0;
-	buf = map_sysmem(img_addr, 0);
+	if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader) {
+		/*
+		 * Storage path: read enough bytes to detect the image
+		 * format. genimg_get_kernel_addr_fit() above still
+		 * parsed any #config / :subimage suffix so the FIT
+		 * selection variables are populated.
+		 */
+		buf = image_loader_map(images->loader, 0, 64);
+		if (!buf) {
+			puts("Cannot read image header from storage\n");
+			return -EIO;
+		}
+		img_addr = map_to_sysmem(buf);
+	} else {
+		buf = map_sysmem(img_addr, 0);
+	}
 	switch (genimg_get_format(buf)) {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	case IMAGE_FORMAT_LEGACY:
@@ -192,6 +208,20 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 #endif
 #if CONFIG_IS_ENABLED(FIT)
 	case IMAGE_FORMAT_FIT:
+		if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader) {
+			/*
+			 * Extend the mapping to cover the full FIT
+			 * FDT structure so all metadata is accessible.
+			 */
+			size_t fdt_sz = fdt_totalsize(buf);
+
+			buf = image_loader_map(images->loader, 0, fdt_sz);
+			if (!buf) {
+				puts("Cannot read FIT header from storage\n");
+				return -ENOMEM;
+			}
+			img_addr = map_to_sysmem(buf);
+		}
 		os_noffset = fit_image_load(images, img_addr,
 				&fit_uname_kernel, &fit_uname_config,
 				IH_ARCH_DEFAULT, IH_TYPE_KERNEL,
@@ -991,11 +1021,21 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	 * Work through the states and see how far we get. We stop on
 	 * any error.
 	 */
-	if (states & BOOTM_STATE_START)
+	if (states & BOOTM_STATE_START) {
 		ret = bootm_start();
+		/*
+		 * bootm_start() zeroes the global images struct. Restore
+		 * the loader pointer so the storage-backed path works.
+		 */
+		if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && bmi->loader)
+			images->loader = bmi->loader;
+	}
 
-	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
-		ret = bootm_pre_load(bmi->addr_img);
+	if (!ret && (states & BOOTM_STATE_PRE_LOAD)) {
+		/* Pre-load verification is not applicable to storage boot */
+		if (!IS_ENABLED(CONFIG_BOOTM_STORAGE) || !images->loader)
+			ret = bootm_pre_load(bmi->addr_img);
+	}
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(bmi->cmd_name, bmi->addr_img);
@@ -1003,8 +1043,11 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
 		ulong img_addr;
 
-		img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
-			: image_load_addr;
+		if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader)
+			img_addr = images->os.start;
+		else
+			img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
+				: image_load_addr;
 		ret = bootm_find_other(img_addr, bmi->conf_ramdisk,
 				       bmi->conf_fdt);
 	}
@@ -1097,8 +1140,13 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 
 	/* Now run the OS! We hope this doesn't return */
-	if (!ret && (states & BOOTM_STATE_OS_GO))
+	if (!ret && (states & BOOTM_STATE_OS_GO)) {
+		/* Release storage backend before jumping — no return expected */
+		if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader)
+			image_loader_cleanup(images->loader);
+
 		ret = boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn);
+	}
 
 	/* Deal with any fallout */
 err:
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 2c5aea26d98..6c26dd8e36d 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <errno.h>
 #include <image.h>
+#include <image-loader.h>
 #include <malloc.h>
 #include <nand.h>
 #include <asm/byteorder.h>
@@ -132,14 +133,123 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 /* bootm - boot application image from image in memory */
 /*******************************************************************/
 
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+/**
+ * bootm_init_loader() - Try to parse a storage device spec from argv
+ *
+ * If argv[0] is a known device-type keyword ("mmc", "mtd", "ubi"),
+ * initialise @ldr as the corresponding backend and return the number
+ * of argv entries consumed. The optional #config[#overlay...] suffix
+ * is stripped from the device spec and returned via @conf_name.
+ *
+ * @ldr:       loader to initialise
+ * @argc:      argument count (after removing the "bootm" verb)
+ * @argv:      argument vector
+ * @conf_name: on output, points to the #config string (incl. '#') or NULL
+ * Return: number of argv entries consumed (>0), 0 if no storage keyword
+ *         was found, or negative errno on init failure
+ */
+static int bootm_init_loader(struct image_loader *ldr,
+			     int argc, char *const argv[],
+			     const char **conf_name)
+{
+	const char *devtype;
+	char *devspec;
+	char *hash;
+	int ret;
+
+	if (argc < 2)
+		return 0;
+
+	devtype = argv[0];
+	devspec = (char *)argv[1];
+	*conf_name = NULL;
+
+	/* Locate the first '#' — its meaning depends on the backend */
+	hash = strchr(devspec, '#');
+
+	if (IS_ENABLED(CONFIG_IMAGE_LOADER_BLK) &&
+	    !strcmp(devtype, "mmc")) {
+		/*
+		 * Block device specs use '#' for partition names when no ':'
+		 * precedes it (e.g. "0#kernel"). Only treat the first '#'
+		 * as the FIT config separator when ':' appears before it
+		 * (e.g. "0:4#config-1"), otherwise the first '#' is the
+		 * partition name and a second '#' starts the config
+		 * (e.g. "0#kernel#config-1").
+		 */
+		char *colon = strchr(devspec, ':');
+
+		if (!(colon && hash && colon < hash) && hash)
+			hash = strchr(hash + 1, '#');
+		if (hash) {
+			*conf_name = hash;
+			*hash = '\0';
+		}
+		ret = image_loader_init_blk(ldr, "mmc", devspec);
+		if (hash)
+			*hash = '#';
+	} else if (IS_ENABLED(CONFIG_IMAGE_LOADER_MTD) &&
+		   !strcmp(devtype, "mtd")) {
+		if (hash) {
+			*conf_name = hash;
+			*hash = '\0';
+		}
+		ret = image_loader_init_mtd(ldr, devspec);
+		if (hash)
+			*hash = '#';
+	} else if (IS_ENABLED(CONFIG_IMAGE_LOADER_UBI) &&
+		   !strcmp(devtype, "ubi")) {
+		if (hash) {
+			*conf_name = hash;
+			*hash = '\0';
+		}
+		ret = image_loader_init_ubi(ldr, devspec);
+		if (hash)
+			*hash = '#';
+	} else {
+		return 0;   /* not a storage keyword */
+	}
+
+	if (ret) {
+		printf("Failed to init %s loader: %d\n", devtype, ret);
+		return ret;
+	}
+
+	return 2;   /* consumed: keyword + device-spec */
+}
+#endif
+
 int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
 	int ret;
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+	struct image_loader ldr = {};
+	const char *conf_name = NULL;
+	int consumed = 0;
+#endif
 
 	/* determine if we have a sub command */
 	argc--; argv++;
+
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+	/* Try storage device spec before checking for hex/subcommand */
+	consumed = bootm_init_loader(&ldr, argc, argv, &conf_name);
+	if (consumed < 0)
+		return CMD_RET_FAILURE;
+	if (consumed > 0) {
+		ldr.alloc_ptr = image_load_addr;
+		argc -= consumed;
+		argv += consumed;
+	}
+#endif
+
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+	if (argc > 0 && !consumed) {
+#else
 	if (argc > 0) {
+#endif
 		char *endp;
 
 		hextoul(argv[0], &endp);
@@ -156,12 +266,25 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	bootm_init(&bmi);
-	if (argc)
-		bmi.addr_img = argv[0];
-	if (argc > 1)
-		bmi.conf_ramdisk = argv[1];
-	if (argc > 2)
-		bmi.conf_fdt = argv[2];
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+	if (consumed > 0) {
+		bmi.addr_img = conf_name;	/* "#config-1" or NULL */
+		bmi.loader = &ldr;
+		if (argc > 0)
+			bmi.conf_ramdisk = argv[0];
+		if (argc > 1)
+			bmi.conf_fdt = argv[1];
+	} else {
+#else
+	{
+#endif
+		if (argc)
+			bmi.addr_img = argv[0];
+		if (argc > 1)
+			bmi.conf_ramdisk = argv[1];
+		if (argc > 2)
+			bmi.conf_fdt = argv[2];
+	}
 
 	/* set up argc and argv[] since some OSes use them */
 	bmi.argc = argc;
@@ -169,6 +292,11 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	ret = bootm_run(&bmi);
 
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+	if (ldr.read)
+		image_loader_cleanup(&ldr);
+#endif
+
 	return ret ? CMD_RET_FAILURE : 0;
 }
 
@@ -204,6 +332,14 @@ U_BOOT_LONGHELP(bootm,
 	"\taddr#<conf_uname>   - configuration specification\n"
 	"\tUse iminfo command to get the list of existing component\n"
 	"\timages and configurations.\n"
+#endif
+#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
+	"\nAlternatively, boot directly from a storage device:\n"
+	"\tbootm mmc <dev>:<part>[#conf]  - boot from MMC/SD partition\n"
+	"\tbootm mtd <name>[#conf]        - boot from MTD partition\n"
+	"\tbootm ubi <volume>[#conf]      - boot from UBI volume\n"
+	"\tThe #conf suffix selects a FIT configuration; additional\n"
+	"\t#overlay suffixes select device-tree overlays.\n"
 #endif
 	"\nSub-commands to do part of the bootm sequence.  The sub-commands "
 	"must be\n"
diff --git a/include/bootm.h b/include/bootm.h
index 4060cec7fc0..ebc014b3468 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -40,6 +40,7 @@ struct cmd_tbl;
  *	boot_get_fdt() for processing, or NULL for none
  * @boot_progress: true to show boot progress
  * @images: images information
+ * @loader: image loader for storage-backed boot (NULL for in-memory)
  * @cmd_name: command which invoked this operation, e.g. "bootm"
  * @argc: Number of arguments to the command (excluding the actual command).
  *	This is 0 if there are no arguments
@@ -51,6 +52,7 @@ struct bootm_info {
 	const char *conf_fdt;
 	bool boot_progress;
 	struct bootm_headers *images;
+	struct image_loader *loader;
 	const char *cmd_name;
 	int argc;
 	char *const *argv;
-- 
2.53.0
