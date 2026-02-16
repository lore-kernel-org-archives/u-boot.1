Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE5E83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFB783E62;
	Mon, 16 Feb 2026 22:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B463C83DEB; Mon, 16 Feb 2026 22:23:05 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE148063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs63K-000000002im-0rSp; Mon, 16 Feb 2026 21:22:46 +0000
Date: Mon, 16 Feb 2026 21:22:42 +0000
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
Subject: [RFC PATCH 09/20] boot: fit: support on-demand loading in
 fit_image_load()
Message-ID: <ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org>
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

Add an on-demand loading path to fit_image_load() for use when
images->loader is set (storage-backed boot).

For external-data FIT images, the new path avoids dereferencing
fit + data_offset (which would point into unmapped memory) and
instead:

1. Extracts the data offset and size from FDT properties
   (data-position / data-offset + data-size) -- metadata only,
   no payload access.

2. Returns early for IH_TYPE_FILESYSTEM sub-images, which stay on
   storage and are never loaded into RAM (e.g. squashfs rootfs).

3. Determines the RAM destination:
   - If the sub-image has a load address, loads directly there
     via image_loader_map_to() (zero-copy).
   - Otherwise, allocates scratch RAM via image_loader_map().

4. Verifies the hash/signature in-place using
   fit_image_verify_with_data(), which is address-agnostic.

5. Jumps to the common tail, skipping the normal
   fit_image_get_data() + memcpy() sequence since data is already
   at its final location.

The entire path is gated by 'if (images->loader && external)' and
USE_HOSTCC, so the existing in-memory flow is completely unchanged
when no loader is set or when building host tools.

For inline-data FIT images (no data-position/data-offset), the FDT
structure loaded during format detection already contains all sub-
image data, so the existing path handles them correctly.

Also adds a 'struct image_loader *loader' member to struct
bootm_headers (initialised to NULL).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/image-fit.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/image.h  |  4 ++
 2 files changed, 100 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3ed69b5f7bc..73d3bf7df08 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -24,6 +24,7 @@ extern void *aligned_alloc(size_t alignment, size_t size);
 #include <linux/sizes.h>
 #include <errno.h>
 #include <log.h>
+#include <image-loader.h>
 #include <mapmem.h>
 #include <asm/io.h>
 #include <malloc.h>
@@ -2166,6 +2167,100 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
 
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGE_LOADER)
+	/*
+	 * Storage-backed path: when an image_loader is active and the
+	 * sub-image uses external data, load the payload from storage
+	 * instead of dereferencing fit + data_offset. The FDT structure
+	 * (containing all metadata, hashes, and signatures) is already
+	 * in RAM; only the payload is on storage.
+	 *
+	 * Sequence:
+	 *  1. Print image info (fit_image_select with verify=0)
+	 *  2. Extract data location from FDT properties (no data access)
+	 *  3. Skip IH_TYPE_FILESYSTEM sub-images — they stay on storage
+	 *  4. Determine RAM destination (load address or scratch area)
+	 *  5. Read payload via image_loader_map_to() / image_loader_map()
+	 *  6. Verify hash/signature in-place
+	 *  7. Jump to common tail (FDT validation, output params)
+	 */
+	if (images && images->loader) {
+		int data_off = 0, data_sz = 0;
+		bool external = false;
+		u8 img_type;
+
+		if (!fit_image_get_data_position(fit, noffset, &data_off)) {
+			external = true;
+		} else if (!fit_image_get_data_offset(fit, noffset, &data_off)) {
+			external = true;
+			data_off += ALIGN(fdt_totalsize(fit), 4);
+		}
+
+		if (external && !fit_image_get_data_size(fit, noffset, &data_sz)) {
+			/* Print image info without verifying data */
+			ret = fit_image_select(fit, noffset, 0);
+			if (ret) {
+				bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
+				return ret;
+			}
+
+			/* Skip filesystem images — they stay on storage */
+			if (!fit_image_get_type(fit, noffset, &img_type) &&
+			    img_type == IH_TYPE_FILESYSTEM) {
+				*datap = 0;
+				*lenp = 0;
+				return noffset;
+			}
+
+			len = data_sz;
+			comp = IH_COMP_NONE;
+			fit_image_get_comp(fit, noffset, &comp);
+
+			/* Determine the RAM destination */
+			if (load_op == FIT_LOAD_IGNORED) {
+				loadbuf = image_loader_map(images->loader,
+							   data_off, len);
+			} else if (!fit_image_get_load(fit, noffset, &load)) {
+				printf("   Loading %s from storage to 0x%08lx\n",
+				       prop_name, load);
+				loadbuf = map_sysmem(load, len);
+				loadbuf = image_loader_map_to(images->loader,
+							      data_off, len,
+							      loadbuf);
+			} else if (load_op == FIT_LOAD_REQUIRED) {
+				printf("Can't get %s subimage load address!\n",
+				       prop_name);
+				return -EBADF;
+			} else {
+				loadbuf = image_loader_map(images->loader,
+							   data_off, len);
+			}
+
+			if (!loadbuf) {
+				printf("Failed to load %s from storage\n",
+				       prop_name);
+				return -EIO;
+			}
+
+			load = map_to_sysmem(loadbuf);
+
+			/* Verify hash/signature in-place */
+			if (images->verify) {
+				puts("   Verifying Hash Integrity ... ");
+				if (!fit_image_verify_with_data(fit, noffset,
+								gd_fdt_blob(),
+								loadbuf, len)) {
+					puts("Bad Data Hash\n");
+					return -EACCES;
+				}
+				puts("OK\n");
+			}
+
+			goto storage_loaded;
+		}
+	}
+#endif /* !USE_HOSTCC && CONFIG_IMAGE_LOADER */
+
 	ret = fit_image_select(fit, noffset, images->verify);
 	if (ret) {
 		bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
@@ -2325,6 +2420,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		puts("WARNING: 'compression' nodes for ramdisks are deprecated,"
 		     " please fix your .its file!\n");
 
+storage_loaded:
 	/* verify that image data is a proper FDT blob */
 	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 	    fdt_check_header(loadbuf)) {
diff --git a/include/image.h b/include/image.h
index 34efac6056d..ecb3fec26c0 100644
--- a/include/image.h
+++ b/include/image.h
@@ -345,6 +345,8 @@ struct image_info {
 	uint8_t		arch;			/* CPU architecture */
 };
 
+struct image_loader;
+
 /*
  * Legacy and FIT format headers used by do_bootm() and do_bootm_<os>()
  * routines.
@@ -400,6 +402,8 @@ struct bootm_headers {
 
 	int		verify;		/* env_get("verify")[0] != 'n' */
 
+	struct image_loader *loader;	/* on-demand storage loader, or NULL */
+
 #define BOOTM_STATE_START	0x00000001
 #define BOOTM_STATE_FINDOS	0x00000002
 #define BOOTM_STATE_FINDOTHER	0x00000004
-- 
2.53.0
