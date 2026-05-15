Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F6CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CA0848B8;
	Sat, 16 May 2026 03:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B747884884; Sat, 16 May 2026 01:38:17 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404CA8480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO26N-000000004gi-3p2C; Fri, 15 May 2026 23:37:56 +0000
Date: Sat, 16 May 2026 00:37:52 +0100
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
Subject: [PATCH v5 2/8] boot: fit: support generating DM verity cmdline
 parameters
Message-ID: <5acb1323c0d2405fce89a2a66b979084b4587bb0.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Add fit_verity_build_cmdline(): when a FILESYSTEM loadable carries a
dm-verity subnode, construct the dm-mod.create= kernel cmdline parameter
from the verity metadata (block-size, data-blocks, algo, root-hash,
salt) and append it to bootargs.

Also add dm-mod.waitfor=/dev/fit0[,/dev/fitN] for each dm-verity device
so the kernel waits for the underlying FIT block device to appear before
setting up device-mapper targets. This is needed when the block driver
probes late, e.g. because it depends on NVMEM calibration data.

The dm-verity target references /dev/fitN where N is the loadable's
index in the configuration -- matching the order Linux's FIT block
driver assigns block devices.  hash-start-block is read directly from
the FIT dm-verity node; mkimage ensures its value equals num-data-blocks
by invoking veritysetup with --no-superblock.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: no changes
v4: no changes
v3:
 * use unsigned int for data_block_size and hash_block_size
 * replace printf() with log_err() for the "broken dm-verity metadata"
v2:
 * use is_power_of_2() for pre-boot sanity check
 * let fit_verity_build_cmdline() return 0 on success
 * add comment explaining why bootm_start() calls fit_verity_free()
---
 boot/Kconfig       |  20 +++
 boot/bootm.c       |  13 ++
 boot/image-board.c |   5 +
 boot/image-fit.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++
 include/image.h    |  80 ++++++++++-
 5 files changed, 454 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..e1114aea843 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -142,6 +142,26 @@ config FIT_CIPHER
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
 	  and in the u-boot support of the FIT image.
 
+config FIT_VERITY
+	bool "dm-verity boot parameter generation from FIT metadata"
+	depends on FIT && OF_LIBFDT
+	help
+	  When a FIT configuration contains loadable sub-images of type
+	  IH_TYPE_FILESYSTEM with a dm-verity subnode, this option enables
+	  building the dm-mod.create= and dm-mod.waitfor= kernel
+	  command-line parameters from the verity metadata
+	  (data-block-size, hash-block-size, num-data-blocks,
+	  hash-start-block, algorithm, digest, salt) stored in the FIT.
+
+	  The generated parameters reference /dev/fitN block devices that
+	  Linux's uImage.FIT block driver assigns to loadable sub-images.
+
+	  During FIT parsing (BOOTM_STATE_FINDOTHER), verity cmdline
+	  fragments are stored in struct bootm_headers and automatically
+	  appended to the bootargs environment variable during
+	  BOOTM_STATE_OS_PREP.  This works from both the bootm command
+	  and BOOTSTD bootmeths.
+
 config FIT_VERBOSE
 	bool "Show verbose messages when FIT images fail"
 	help
diff --git a/boot/bootm.c b/boot/bootm.c
index 4836d6b2d41..d6a54a49fce 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -243,6 +243,13 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 
 static int bootm_start(void)
 {
+	/*
+	 * Free dm-verity allocations from a prior boot attempt before
+	 * zeroing the structure. The pointers are guaranteed to be valid
+	 * or NULL: .bss is zero-initialised, and memset() below zeroes
+	 * them again after every boot.
+	 */
+	fit_verity_free(&images);
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
 
@@ -1071,6 +1078,12 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 		/* For Linux OS do all substitutions at console processing */
 		if (images->os.os == IH_OS_LINUX)
 			flags = BOOTM_CL_ALL;
+		ret = fit_verity_apply_bootargs(images);
+		if (ret) {
+			printf("dm-verity bootargs failed (err=%d)\n", ret);
+			ret = CMD_RET_FAILURE;
+			goto err;
+		}
 		ret = bootm_process_cmdline_env(flags);
 		if (ret) {
 			printf("Cmdline setup failed (err=%d)\n", ret);
diff --git a/boot/image-board.c b/boot/image-board.c
index 005d60caf5c..265f29d44ff 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -810,6 +810,11 @@ int boot_get_loadable(struct bootm_headers *images)
 
 			fit_loadable_process(img_type, img_data, img_len);
 		}
+
+		fit_img_result = fit_verity_build_cmdline(buf, conf_noffset,
+							  images);
+		if (fit_img_result < 0)
+			return fit_img_result;
 		break;
 	default:
 		printf("The given image format is not supported (corrupt?)\n");
diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..906b75216b2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -21,8 +21,11 @@
 extern void *aligned_alloc(size_t alignment, size_t size);
 #else
 #include <linux/compiler.h>
+#include <linux/log2.h>
 #include <linux/sizes.h>
+#include <env.h>
 #include <errno.h>
+#include <hexdump.h>
 #include <log.h>
 #include <mapmem.h>
 #include <asm/io.h>
@@ -243,6 +246,39 @@ static void fit_image_print_data(const void *fit, int noffset, const char *p,
 	}
 }
 
+static __maybe_unused void fit_image_print_dm_verity(const void *fit,
+						     int noffset,
+						     const char *p)
+{
+#if defined(USE_HOSTCC) || CONFIG_IS_ENABLED(FIT_VERITY)
+	const char *algo;
+	const uint8_t *bin;
+	int len, i;
+
+	algo = fdt_getprop(fit, noffset, FIT_VERITY_ALGO_PROP, NULL);
+	if (algo)
+		printf("%s  Verity algo:  %s\n", p, algo);
+
+	bin = fdt_getprop(fit, noffset, FIT_VERITY_DIGEST_PROP,
+			  &len);
+	if (bin && len > 0) {
+		printf("%s  Verity hash:  ", p);
+		for (i = 0; i < len; i++)
+			printf("%02x", bin[i]);
+		printf("\n");
+	}
+
+	bin = fdt_getprop(fit, noffset, FIT_VERITY_SALT_PROP,
+			  &len);
+	if (bin && len > 0) {
+		printf("%s  Verity salt:  ", p);
+		for (i = 0; i < len; i++)
+			printf("%02x", bin[i]);
+		printf("\n");
+	}
+#endif
+}
+
 /**
  * fit_image_print_verification_data() - prints out the hash/signature details
  * @fit: pointer to the FIT format image header
@@ -271,6 +307,11 @@ static void fit_image_print_verification_data(const void *fit, int noffset,
 				strlen(FIT_SIG_NODENAME))) {
 		fit_image_print_data(fit, noffset, p, "Sign");
 	}
+#if defined(USE_HOSTCC) || CONFIG_IS_ENABLED(FIT_VERITY)
+	else if (!strcmp(name, FIT_VERITY_NODENAME)) {
+		fit_image_print_dm_verity(fit, noffset, p);
+	}
+#endif
 }
 
 /**
@@ -2642,3 +2683,299 @@ out:
 	return fdt_noffset;
 }
 #endif
+
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(FIT_VERITY)
+
+static const char *const verity_opt_props[] = {
+	FIT_VERITY_OPT_RESTART,
+	FIT_VERITY_OPT_PANIC,
+	FIT_VERITY_OPT_RERR,
+	FIT_VERITY_OPT_PERR,
+	FIT_VERITY_OPT_ONCE,
+};
+
+/**
+ * fit_verity_build_target() - build one dm-verity target specification
+ * @fit:	pointer to the FIT blob
+ * @img_noffset:	image node offset containing the dm-verity subnode
+ * @loadable_idx:	index of this loadable (for /dev/fitN)
+ * @uname:	unit name of the image
+ * @separator:	true if a ";" prefix is needed (not the first target)
+ * @buf:	output buffer, or NULL to measure only
+ * @bufsize:	size of @buf (ignored when @buf is NULL)
+ *
+ * Parses all dm-verity properties from the image's ``dm-verity`` child
+ * node and writes (or measures) a dm target specification string of the
+ * form used by the ``dm-mod.create`` kernel parameter.
+ *
+ * Return: number of characters that would be written (excluding '\0'),
+ *	    or -ve errno on error (e.g. missing mandatory property)
+ */
+static int fit_verity_build_target(const void *fit, int img_noffset,
+				   int loadable_idx, const char *uname,
+				   bool separator, char *buf, int bufsize)
+{
+	const char *algorithm;
+	const u8 *digest_raw, *salt_raw;
+	const fdt32_t *val;
+	char *digest_hex = NULL, *salt_hex = NULL, *opt_buf = NULL;
+	int verity_node;
+	unsigned int data_block_size, hash_block_size;
+	int num_data_blocks, hash_start_block;
+	u64 data_sectors;
+	int digest_len, salt_len;
+	int opt_count, opt_off, opt_buf_size;
+	int len;
+	int i;
+
+	verity_node = fdt_subnode_offset(fit, img_noffset, FIT_VERITY_NODENAME);
+	if (verity_node < 0)
+		return -ENOENT;
+
+	/* Mandatory u32 properties */
+	val = fdt_getprop(fit, verity_node, FIT_VERITY_DBS_PROP, NULL);
+	if (!val)
+		return -EINVAL;
+	data_block_size = fdt32_to_cpu(*val);
+
+	val = fdt_getprop(fit, verity_node, FIT_VERITY_HBS_PROP, NULL);
+	if (!val)
+		return -EINVAL;
+	hash_block_size = fdt32_to_cpu(*val);
+
+	val = fdt_getprop(fit, verity_node, FIT_VERITY_NBLK_PROP, NULL);
+	if (!val)
+		return -EINVAL;
+	num_data_blocks = fdt32_to_cpu(*val);
+
+	val = fdt_getprop(fit, verity_node, FIT_VERITY_HBLK_PROP, NULL);
+	if (!val)
+		return -EINVAL;
+	hash_start_block = fdt32_to_cpu(*val);
+
+	if (data_block_size < 512U || !is_power_of_2(data_block_size) ||
+	    hash_block_size < 512U || !is_power_of_2(hash_block_size) ||
+	    !num_data_blocks)
+		return -EINVAL;
+
+	/* Mandatory string */
+	algorithm = fdt_getprop(fit, verity_node, FIT_VERITY_ALGO_PROP, NULL);
+	if (!algorithm)
+		return -EINVAL;
+
+	/* Mandatory byte arrays */
+	digest_raw = fdt_getprop(fit, verity_node, FIT_VERITY_DIGEST_PROP,
+				 &digest_len);
+	if (!digest_raw || digest_len <= 0)
+		return -EINVAL;
+
+	salt_raw = fdt_getprop(fit, verity_node, FIT_VERITY_SALT_PROP,
+			       &salt_len);
+	if (!salt_raw || salt_len <= 0)
+		return -EINVAL;
+
+	/* Hex-encode digest and salt into dynamically sized buffers */
+	digest_hex = malloc(digest_len * 2 + 1);
+	salt_hex = malloc(salt_len * 2 + 1);
+	if (!digest_hex || !salt_hex) {
+		len = -ENOMEM;
+		goto out;
+	}
+	*bin2hex(digest_hex, digest_raw, digest_len) = '\0';
+	*bin2hex(salt_hex, salt_raw, salt_len) = '\0';
+
+	data_sectors = (u64)num_data_blocks * ((u64)data_block_size / 512);
+
+	/* Compute space needed for optional boolean properties */
+	opt_buf_size = 1; /* NUL terminator */
+	for (i = 0; i < ARRAY_SIZE(verity_opt_props); i++)
+		opt_buf_size += strlen(verity_opt_props[i]) + 1;
+	opt_buf = malloc(opt_buf_size);
+	if (!opt_buf) {
+		len = -ENOMEM;
+		goto out;
+	}
+
+	/* Collect optional boolean properties */
+	opt_count = 0;
+	opt_off = 0;
+	opt_buf[0] = '\0';
+	for (i = 0; i < ARRAY_SIZE(verity_opt_props); i++) {
+		if (fdt_getprop(fit, verity_node,
+				verity_opt_props[i], NULL)) {
+			const char *s = verity_opt_props[i];
+			int slen = strlen(s);
+
+			if (opt_off)
+				opt_buf[opt_off++] = ' ';
+			/* Copy with hyphen-to-underscore conversion */
+			while (slen-- > 0) {
+				opt_buf[opt_off++] =
+					(*s == '-') ? '_' : *s;
+				s++;
+			}
+			opt_buf[opt_off] = '\0';
+			opt_count++;
+		}
+	}
+
+	/* Emit (or measure) the target spec */
+	len = snprintf(buf, buf ? bufsize : 0,
+		       "%s%s,,, ro,0 %llu verity 1 /dev/fit%d /dev/fit%d %u %u %d %d %s %s %s",
+		       separator ? ";" : "", uname,
+		       (unsigned long long)data_sectors, loadable_idx, loadable_idx,
+		       data_block_size, hash_block_size,
+		       num_data_blocks, hash_start_block,
+		       algorithm, digest_hex, salt_hex);
+	if (opt_count) {
+		int extra = snprintf(buf ? buf + len : NULL,
+				     buf ? bufsize - len : 0,
+				     " %d %s", opt_count, opt_buf);
+		len += extra;
+	}
+
+out:
+	free(digest_hex);
+	free(salt_hex);
+	free(opt_buf);
+	return len;
+}
+
+int fit_verity_build_cmdline(const void *fit, int conf_noffset,
+			     struct bootm_headers *images)
+{
+	int images_noffset;
+	int dm_create_len = 0, dm_waitfor_len = 0;
+	char *dm_create = NULL, *dm_waitfor = NULL;
+	const char *uname;
+	int loadable_idx;
+	int found = 0;
+	int ret = 0;
+
+	images_noffset = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_noffset < 0)
+		return 0;
+
+	for (loadable_idx = 0;
+	     (uname = fdt_stringlist_get(fit, conf_noffset,
+					 FIT_LOADABLE_PROP,
+					 loadable_idx, NULL));
+	     loadable_idx++) {
+		int img_noffset, need;
+		u8 img_type;
+		char *tmp;
+
+		img_noffset = fdt_subnode_offset(fit, images_noffset, uname);
+		if (img_noffset < 0)
+			continue;
+
+		if (fit_image_get_type(fit, img_noffset, &img_type) ||
+		    img_type != IH_TYPE_FILESYSTEM)
+			continue;
+
+		/* Measure first, then allocate and write */
+		need = fit_verity_build_target(fit, img_noffset,
+					       loadable_idx, uname,
+					       found > 0, NULL, 0);
+		if (need == -ENOENT)
+			continue;	/* no dm-verity subnode -- fine */
+		if (need < 0) {
+			log_err("FIT: broken dm-verity metadata in '%s'\n",
+				uname);
+			ret = need;
+			goto err;
+		}
+
+		tmp = realloc(dm_create, dm_create_len + need + 1);
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		dm_create = tmp;
+		fit_verity_build_target(fit, img_noffset, loadable_idx,
+					uname, found > 0,
+					dm_create + dm_create_len,
+					need + 1);
+		dm_create_len += need;
+
+		/* Grow dm_waitfor buffer */
+		need = snprintf(NULL, 0, "%s/dev/fit%d",
+				dm_waitfor_len ? "," : "",
+				loadable_idx);
+		tmp = realloc(dm_waitfor, dm_waitfor_len + need + 1);
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		dm_waitfor = tmp;
+		sprintf(dm_waitfor + dm_waitfor_len, "%s/dev/fit%d",
+			dm_waitfor_len ? "," : "",
+			loadable_idx);
+		dm_waitfor_len += need;
+
+		found++;
+	}
+
+	if (found) {
+		/* Transfer ownership to the bootm_headers */
+		images->dm_mod_create = dm_create;
+		images->dm_mod_waitfor = dm_waitfor;
+	} else {
+		free(dm_create);
+		free(dm_waitfor);
+	}
+
+	return 0;
+
+err:
+	free(dm_create);
+	free(dm_waitfor);
+	return ret;
+}
+
+/**
+ * fmt used by both the measurement and the actual write of bootargs.
+ * Shared to guarantee they stay in sync.
+ */
+#define VERITY_BOOTARGS_FMT	"%s%sdm-mod.create=\"%s\" dm-mod.waitfor=\"%s\""
+
+int fit_verity_apply_bootargs(const struct bootm_headers *images)
+{
+	const char *existing;
+	char *newargs;
+	int len;
+
+	if (!images->dm_mod_create)
+		return 0;
+
+	existing = env_get("bootargs");
+	if (!existing)
+		existing = "";
+
+	/* Measure */
+	len = snprintf(NULL, 0, VERITY_BOOTARGS_FMT,
+		       existing, existing[0] ? " " : "",
+		       images->dm_mod_create, images->dm_mod_waitfor);
+
+	newargs = malloc(len + 1);
+	if (!newargs)
+		return -ENOMEM;
+
+	snprintf(newargs, len + 1, VERITY_BOOTARGS_FMT,
+		 existing, existing[0] ? " " : "",
+		 images->dm_mod_create, images->dm_mod_waitfor);
+
+	env_set("bootargs", newargs);
+	free(newargs);
+
+	return 0;
+}
+
+void fit_verity_free(struct bootm_headers *images)
+{
+	free(images->dm_mod_create);
+	free(images->dm_mod_waitfor);
+	images->dm_mod_create = NULL;
+	images->dm_mod_waitfor = NULL;
+}
+#endif /* FIT_VERITY */
diff --git a/include/image.h b/include/image.h
index 482446a8115..fe2361a667e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -396,7 +396,19 @@ struct bootm_headers {
 	ulong		cmdline_start;
 	ulong		cmdline_end;
 	struct bd_info		*kbd;
-#endif
+
+#if CONFIG_IS_ENABLED(FIT_VERITY)
+	/*
+	 * dm-verity kernel command-line fragments, populated during FIT
+	 * parsing by fit_verity_build_cmdline().  Bootmeths can check
+	 * fit_verity_active() between bootm states, and
+	 * fit_verity_apply_bootargs() appends these to the "bootargs"
+	 * env var during BOOTM_STATE_OS_PREP.
+	 */
+	char *dm_mod_create;
+	char *dm_mod_waitfor;
+#endif /* FIT_VERITY */
+#endif /* !USE_HOSTCC */
 
 	int		verify;		/* env_get("verify")[0] != 'n' */
 
@@ -756,6 +768,72 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		   int arch, int image_ph_type, int bootstage_id,
 		   enum fit_load_op load_op, ulong *datap, ulong *lenp);
 
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(FIT_VERITY)
+/**
+ * fit_verity_build_cmdline() - build dm-verity cmdline from FIT metadata
+ * @fit:		pointer to the FIT blob
+ * @conf_noffset:	configuration node offset in @fit
+ * @images:		bootm headers; dm_mod_create / dm_mod_waitfor are
+ *			populated on success
+ *
+ * Called automatically from boot_get_loadable() during FIT parsing.
+ * For each IH_TYPE_FILESYSTEM loadable with a dm-verity subnode,
+ * builds the corresponding dm target specification.
+ *
+ * Return: 0 on success, -ve errno on error
+ */
+int fit_verity_build_cmdline(const void *fit, int conf_noffset,
+			     struct bootm_headers *images);
+
+/**
+ * fit_verity_apply_bootargs() - append dm-verity params to bootargs env
+ * @images:	bootm headers with dm-verity cmdline fragments
+ *
+ * Called from BOOTM_STATE_OS_PREP before bootm_process_cmdline_env().
+ *
+ * Return: 0 on success, -ve errno on error
+ */
+int fit_verity_apply_bootargs(const struct bootm_headers *images);
+
+/**
+ * fit_verity_active() - check whether dm-verity targets were found
+ * @images:	bootm headers
+ *
+ * Return: true if at least one dm-verity target was built
+ */
+static inline bool fit_verity_active(const struct bootm_headers *images)
+{
+	return !!images->dm_mod_create;
+}
+
+/**
+ * fit_verity_free() - free dm-verity cmdline allocations
+ * @images:	bootm headers
+ */
+void fit_verity_free(struct bootm_headers *images);
+
+#else /* !FIT_VERITY */
+
+static inline int fit_verity_build_cmdline(const void *fit, int conf_noffset,
+					   struct bootm_headers *images)
+{
+	return 0;
+}
+
+static inline int fit_verity_apply_bootargs(const struct bootm_headers *images)
+{
+	return 0;
+}
+
+static inline bool fit_verity_active(const struct bootm_headers *images)
+{
+	return false;
+}
+
+static inline void fit_verity_free(struct bootm_headers *images) {}
+
+#endif /* FIT_VERITY */
+
 /**
  * image_locate_script() - Locate the raw script in an image
  *
-- 
2.54.0
