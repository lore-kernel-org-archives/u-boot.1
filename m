Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1A9C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 009F5405CC;
	Tue, 25 Aug 2026 15:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id meo33_hriV7q; Tue, 25 Aug 2026 15:59:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673583;
	bh=VEiez0J/uvgsx7+56ATIA1LhkAhdpurDPAxCxiASn4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CTiWoiT5LHIAcFzAPg4pkRoAkNLLln4ywscDrZqtRgmrv1ZvbTK316O86ZUjvVzIN
	 0GOgQF5piw7SilMJNYLGfMnQsAdNQeC3qDKzJTccmB7DqLMpTy8M1PAuOSZVoplBXB
	 pfI0tiRqO2kATKgRu6zfoBXLukO5oJ5NjIuNFkvr3wQJFpcvVEmo4FE0fMhwwDmafA
	 qWWCm+4Ef2FovJfw6OxMqfRePSg6tu/chw/yt2S5b2KCcu2gIRLKNSuWU0tvUU5vSs
	 6rKTvP7W9dT9QmS9Er+9wCyPSOv+LTwMPRYmm2Q5qC4vybpLFLd3hg9XVYXPaw7Ni6
	 x2/3TrV+uWNdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC8F8405E6;
	Tue, 25 Aug 2026 15:59:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 158773DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07D3D80CD8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_RfYOKgUVO1 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:59:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAD9980B21
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:40 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytYo-000000003vC-2fO9; Tue, 25 Aug 2026 15:59:38 +0000
Date: Tue, 25 Aug 2026 16:59:35 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 08/11] boot: fit: support on-demand loading in
 fit_image_load()
Message-ID: <df85b50d1cc68aa4f31a662e0026f93d8fcabc91.1787673209.git.daniel@makrotopia.org>
References: <cover.1787673209.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787673209.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Integrate storage-backed image loading transparently into the existing
FIT flow so that all verification, decompression, and copy-to-load-
address code runs unchanged for both RAM-backed and storage-backed
images.

Hook imagemap into fit_image_get_data(): when gd->imagemap is set and
the sub-image uses external data, call imagemap_map() to bring the
payload into RAM instead of returning the unmapped fit + offset
pointer. Every existing caller, including fit_image_verify() called
from fit_image_select(), transparently gets valid data without any
changes to the authentication path.

For uncompressed sub-images with a known load address, pre-populate
the translation table via imagemap_map_to() before verification runs.
This loads data directly to the final RAM destination; when
fit_image_get_data() is later called, the translation table hit
returns the same pointer, achieving zero-copy. Compressed images or
those without a load address fall through to the lazy imagemap_map()
path.

Filesystem sub-images protected by dm-verity are returned early and
stay on storage, as the kernel verifies them at block level.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootm.c     |  70 +++++++++++++++++++++++++++---
 boot/image-fit.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/bootm.h  |   2 +
 include/image.h  |   2 +
 4 files changed, 174 insertions(+), 9 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 3bce8586834..22b0394599a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -14,6 +14,7 @@
 #include <env.h>
 #include <errno.h>
 #include <fdt_support.h>
+#include <imagemap.h>
 #include <irq_func.h>
 #include <lmb.h>
 #include <log.h>
@@ -147,7 +148,22 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 
 	/* check image type, for FIT images get FIT kernel node */
 	*os_data = *os_len = 0;
-	buf = map_sysmem(img_addr, 0);
+	if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
+		/*
+		 * Storage path: read enough bytes to detect the image
+		 * format. genimg_get_kernel_addr_fit() above still
+		 * parsed any #config / :subimage suffix so the FIT
+		 * selection variables are populated.
+		 */
+		buf = imagemap_map(images->imagemap, 0, 64);
+		if (IS_ERR(buf)) {
+			puts("Cannot read image header from storage\n");
+			return PTR_ERR(buf);
+		}
+		img_addr = map_to_sysmem(buf);
+	} else {
+		buf = map_sysmem(img_addr, 0);
+	}
 	switch (genimg_get_format(buf)) {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	case IMAGE_FORMAT_LEGACY:
@@ -193,6 +209,20 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 #endif
 #if CONFIG_IS_ENABLED(FIT)
 	case IMAGE_FORMAT_FIT:
+		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
+			/*
+			 * Extend the mapping to cover the full FIT
+			 * FDT structure so all metadata is accessible.
+			 */
+			size_t fdt_sz = fdt_totalsize(buf);
+
+			buf = imagemap_map(images->imagemap, 0, fdt_sz);
+			if (IS_ERR(buf)) {
+				puts("Cannot read FIT header from storage\n");
+				return PTR_ERR(buf);
+			}
+			img_addr = map_to_sysmem(buf);
+		}
 		os_noffset = fit_image_load(images, img_addr,
 				&fit_uname_kernel, &fit_uname_config,
 				IH_ARCH_DEFAULT, IH_TYPE_KERNEL,
@@ -1033,11 +1063,21 @@ int bootm_run_states(struct bootm_info *bmi, int states)
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
+		if (IS_ENABLED(CONFIG_IMAGEMAP) && bmi->imagemap)
+			images->imagemap = bmi->imagemap;
+	}
 
-	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
-		ret = bootm_pre_load(bmi->addr_img);
+	if (!ret && (states & BOOTM_STATE_PRE_LOAD)) {
+		/* Pre-load verification is not applicable to storage boot */
+		if (!IS_ENABLED(CONFIG_IMAGEMAP) || !images->imagemap)
+			ret = bootm_pre_load(bmi->addr_img);
+	}
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(bmi->cmd_name, bmi->addr_img);
@@ -1045,8 +1085,11 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
 		ulong img_addr;
 
-		img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
-			: image_load_addr;
+		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap)
+			img_addr = images->os.start;
+		else
+			img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
+				: image_load_addr;
 		ret = bootm_find_other(img_addr, bmi->conf_ramdisk,
 				       bmi->conf_fdt);
 	}
@@ -1145,11 +1188,24 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 
 	/* Now run the OS! We hope this doesn't return */
-	if (!ret && (states & BOOTM_STATE_OS_GO))
+	if (!ret && (states & BOOTM_STATE_OS_GO)) {
+		/* Release storage backend before jumping - no return expected */
+		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
+			imagemap_cleanup(images->imagemap);
+			images->imagemap = NULL;
+		}
+
 		ret = boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn);
+	}
 
 	/* Deal with any fallout */
 err:
+	/* Clean up imagemap on error (not reached on successful boot) */
+	if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
+		imagemap_cleanup(images->imagemap);
+		images->imagemap = NULL;
+	}
+
 	if (iflag)
 		enable_interrupts();
 
diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..baaa1f13547 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -26,6 +26,7 @@ extern void *aligned_alloc(size_t alignment, size_t size);
 #include <env.h>
 #include <errno.h>
 #include <hexdump.h>
+#include <imagemap.h>
 #include <log.h>
 #include <mapmem.h>
 #include <asm/io.h>
@@ -1140,6 +1141,16 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 				return -EINVAL;
 			}
 			*data = fit + offset;
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
+			if (images.imagemap) {
+				void *mapped;
+
+				mapped = imagemap_lookup(images.imagemap,
+							 offset, len);
+				if (mapped)
+					*data = mapped;
+			}
+#endif
 			*size = len;
 		}
 	} else {
@@ -2140,6 +2151,84 @@ static const char *fit_get_image_type_property(int ph_type)
 	return "unknown";
 }
 
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
+/**
+ * fit_image_load_storage() - Pre-load a sub-image from on-demand storage
+ *
+ * Brings an external-data sub-image into RAM through the imagemap loader before
+ * fit_image_select() runs verification, so the existing verify/copy path sees a
+ * valid RAM pointer.  Uncompressed sub-images with a load address are read
+ * straight to their destination (zero-copy); everything else goes to scratch
+ * RAM.  Filesystem sub-images protected by dm-verity are left on storage and
+ * verified by the kernel at block level; @early is set for those so the caller
+ * returns the node without loading the payload.
+ *
+ * @early is set to true when the caller should stop and return @noffset with an
+ * empty payload.
+ *
+ * Return: 0 to continue, negative errno on failure
+ */
+static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
+				  int noffset, enum fit_load_op load_op,
+				  ulong *datap, ulong *lenp, bool *early)
+{
+	int data_off = 0, data_sz = 0;
+	bool external = false;
+	ulong img_load;
+	u8 img_comp = IH_COMP_NONE;
+	void *mapped;
+
+	if (CONFIG_IS_ENABLED(FIT_VERITY)) {
+		u8 img_type;
+
+		if (!fit_image_get_type(fit, noffset, &img_type) &&
+		    img_type == IH_TYPE_FILESYSTEM &&
+		    fdt_subnode_offset(fit, noffset, "dm-verity") >= 0) {
+			fit_image_print(fit, noffset, "   ");
+			*datap = 0;
+			*lenp = 0;
+			*early = true;
+			return 0;
+		}
+	}
+
+	if (!fit_image_get_data_position(fit, noffset, &data_off)) {
+		external = true;
+	} else if (!fit_image_get_data_offset(fit, noffset, &data_off)) {
+		external = true;
+		data_off += ALIGN(fdt_totalsize(fit), 4);
+	}
+
+	if (!external || fit_image_get_data_size(fit, noffset, &data_sz))
+		return 0;
+
+	if (data_off < 0 || data_sz < 0)
+		return -EINVAL;
+
+	fit_image_get_comp(fit, noffset, &img_comp);
+
+	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
+	    !fit_image_get_load(fit, noffset, &img_load)) {
+		void *dst = map_sysmem(img_load, data_sz);
+
+		mapped = imagemap_map_to(images->imagemap, data_off, data_sz,
+					 dst);
+	} else {
+		mapped = imagemap_map(images->imagemap, data_off, data_sz);
+	}
+
+	return IS_ERR(mapped) ? PTR_ERR(mapped) : 0;
+}
+#else
+static inline int fit_image_load_storage(struct bootm_headers *images,
+					 const void *fit, int noffset,
+					 enum fit_load_op load_op, ulong *datap,
+					 ulong *lenp, bool *early)
+{
+	return 0;
+}
+#endif
+
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
 		   int arch, int ph_type, int bootstage_id,
@@ -2236,6 +2325,21 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
 
+	/*
+	 * On-demand storage: pre-load external-data payloads into RAM (or leave
+	 * dm-verity filesystems on storage) before fit_image_select() verifies.
+	 */
+	if (CONFIG_IS_ENABLED(IMAGEMAP) && !tools_build() && images->imagemap) {
+		bool early = false;
+
+		ret = fit_image_load_storage(images, fit, noffset, load_op,
+					     datap, lenp, &early);
+		if (ret)
+			return ret;
+		if (early)
+			return noffset;
+	}
+
 	ret = fit_image_select(fit, noffset, images->verify);
 	if (ret) {
 		bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
@@ -2349,8 +2453,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 			return -EXDEV;
 		}
 
-		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
-		       prop_name, data, load);
+		if (!CONFIG_IS_ENABLED(IMAGEMAP) || data != load)
+			printf("   Loading %s from 0x%08lx to 0x%08lx\n",
+			       prop_name, data, load);
 	} else {
 		load = data;	/* load address specified but set to 0 */
 	}
diff --git a/include/bootm.h b/include/bootm.h
index f6958be751a..d1aac3d44df 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -40,6 +40,7 @@ struct cmd_tbl;
  *	boot_get_fdt() for processing, or NULL for none
  * @boot_progress: true to show boot progress
  * @images: images information
+ * @imagemap: imagemap device for storage-backed boot (NULL for in-memory)
  * @cmd_name: command which invoked this operation, e.g. "bootm"
  * @argc: Number of arguments to the command (excluding the actual command).
  *	This is 0 if there are no arguments
@@ -51,6 +52,7 @@ struct bootm_info {
 	const char *conf_fdt;
 	bool boot_progress;
 	struct bootm_headers *images;
+	struct udevice *imagemap;
 	const char *cmd_name;
 	int argc;
 	char *const *argv;
diff --git a/include/image.h b/include/image.h
index 6edcb1995bf..f5baec9a516 100644
--- a/include/image.h
+++ b/include/image.h
@@ -412,6 +412,8 @@ struct bootm_headers {
 
 	int		verify;		/* env_get("verify")[0] != 'n' */
 
+	struct udevice *imagemap;	/* on-demand storage loader, or NULL */
+
 #define BOOTM_STATE_START	0x00000001
 #define BOOTM_STATE_FINDOS	0x00000002
 #define BOOTM_STATE_FINDOTHER	0x00000004
-- 
2.55.0
