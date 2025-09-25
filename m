Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAC3CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 13:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D063280107;
	Thu, 25 Sep 2025 15:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jd+GbLjc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OvXmgjee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF27809A5; Thu, 25 Sep 2025 15:42:34 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AAAE8004F
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cXZdz0hRSz9sWs;
 Thu, 25 Sep 2025 15:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758807751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=97Z5NwoEwZuqTzoOmCgD0o+gs5FNZva3oiKsU8hy/lE=;
 b=jd+GbLjcWFmgPaI/JNhw/pyMsgAc9QLDK/PC1mN6XeG0XkXp+IvEWdrqKTvyTwa6lA1udT
 EsqKbF6cVtwgp7nqexw+dCcOpbo0fVep511LjTHrHUd5ncQuuox2x11ALn/97c8xJ8DWP6
 Pd0Ctu9hxB0rebtjCvXpMBtVVWFmVuR50jHlkgNDQ+MTg4nz3XOXBwf/iGM/jNnv6k/Ota
 +k4XVmMBQOddtcz315eCGKl+xa7eg477z3q57cq+Z/BExRR4gee+BfSYNBkzB7iMd0mlEe
 LQtz1VA6SOlt30TA6yfB0scFPPoDt9WSkiqAkRu+6x7LMp41/Y3jwbx06p0tIg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758807749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=97Z5NwoEwZuqTzoOmCgD0o+gs5FNZva3oiKsU8hy/lE=;
 b=OvXmgjeeEKJXCt6+uYENJdq5tn32onIAmWEfF4BEgytHznCF3mNt/O+AVT/8sIfuLA3WDz
 RRwbMc3nfVxnzjLkUf2epLPwfX2xWR4Ewgu8kW35d/2Kc2QUgSCBNbtVgrLz8ePYYB+X4a
 t1lfdaS+zNMWiMC9KfEvaVfVh+dD2wLIivuYYL9vi6U4kysjs2DxEk4tfVS683dFLM6DSK
 gcdbt59KOJcgCm/FOgKYoqf+OBnbshknvToDWBmk+WJ9zVqes+iyKa1y9a3CnbRRihXsst
 4CdWidzK5HrIJEYt8NNNp1ndCuI9ZDyRcBoMQRoEtzbtBpUCTF2bH06HSuo2vQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Revert "tools: mkimage: detect overlapping load regions in
 FIT configurations"
Date: Thu, 25 Sep 2025 15:41:43 +0200
Message-ID: <20250925134212.59709-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 606088193d7a34dbedd
X-MBO-RS-META: sxrwrmx1fra33ncr35epnny13nh4iaqd
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

This reverts commit 588094f2c8ec9a4f7d2dcda11ffae8db8462149c.

This introduces warnings on valid fitImages which do not set load
address for fdt-1 DT node. This is valid, because DT can be loaded
to suitable location as determined by the fitImage loader.

Warning: not able to get `load` of node 'fdt-1'

Furthermore, do not add C++ style comments into C code.

Either send a fix or apply this revert.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Carlos López" <carlos.lopezr4096@gmail.com>
Cc: Aristo Chen <jj251510319013@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 tools/fit_image.c | 90 +----------------------------------------------
 tools/mkimage.c   |  3 +-
 2 files changed, 2 insertions(+), 91 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 12f4cdb2875..10849733816 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -22,20 +22,6 @@
 #include <version.h>
 #include <u-boot/crc.h>
 
-struct fit_region {
-	ulong load;
-	ulong size;
-	const char *name;
-};
-
-static int regions_overlap(const struct fit_region *a, const struct fit_region *b)
-{
-	ulong a_end = a->load + a->size;
-	ulong b_end = b->load + b->size;
-
-	return !(a_end <= b->load || b_end <= a->load);
-}
-
 static struct legacy_img_hdr header;
 
 static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
@@ -837,12 +823,9 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	}
 
 	fdt_for_each_subnode(node, fdt, confs) {
-		struct fit_region *regions = NULL;
-		unsigned int img_count = 0;
-		unsigned int regions_allocated = 0;
 		const char *conf_name = fdt_get_name(fdt, node, NULL);
 
-		for (unsigned int i = 0; i < ARRAY_SIZE(props); i++) {
+		for (int i = 0; i < ARRAY_SIZE(props); i++) {
 			int count = fdt_stringlist_count(fdt, node, props[i]);
 
 			if (count < 0)
@@ -863,79 +846,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 					ret = FDT_ERR_NOTFOUND;
 					goto err_munmap;
 				}
-
-				ulong img_load = 0;
-				int img_size = 0;
-
-				if (fit_image_get_load(fdt, img, &img_load)) {
-					fprintf(stderr,
-						"Warning: not able to get `load` of node '%s'\n",
-						img_name);
-					// Skip checking the components that do not have a
-					// definition for `load`
-					continue;
-				}
-				const char *img_data = fdt_getprop(fdt, img,
-								   FIT_DATA_PROP,
-								   &img_size);
-
-				if (!img_data || !img_size)
-					continue;
-
-				// Check if we've already added this image to avoid duplicates
-				for (unsigned int k = 0; k < img_count; k++) {
-					if (!strcmp(regions[k].name, img_name))
-						goto next_node;
-				}
-
-				// Expand regions array if needed
-				if (img_count >= regions_allocated) {
-					unsigned int new_size = regions_allocated ?
-								regions_allocated * 2 : 8;
-					struct fit_region *new_regions = realloc(regions,
-							new_size * sizeof(struct fit_region));
-					if (!new_regions) {
-						fprintf(stderr,
-							"Failed to allocate memory for regions in config %s\n",
-							fdt_get_name(fdt, node, NULL));
-						free(regions);
-						ret = -ENOMEM;
-						goto err_munmap;
-					}
-					regions = new_regions;
-					regions_allocated = new_size;
-				}
-
-				regions[img_count].load = img_load;
-				regions[img_count].size = img_size;
-				regions[img_count].name = img_name;
-				img_count++;
-next_node:;
-			}
-		}
-
-		// Check for overlap within this config only
-		for (unsigned int i = 0; i < img_count; i++) {
-			for (unsigned int j = i + 1; j < img_count; j++) {
-				if (regions_overlap(&regions[i], &regions[j])) {
-					fprintf(stderr,
-						"[Config: %s] Error: Overlap detected:\n"
-						"  - %s: [0x%lx - 0x%lx]\n"
-						"  - %s: [0x%lx - 0x%lx]\n",
-						fdt_get_name(fdt, node, NULL),
-						regions[i].name, regions[i].load,
-						regions[i].load + regions[i].size,
-						regions[j].name, regions[j].load,
-						regions[j].load + regions[j].size);
-					ret = FDT_ERR_BADSTRUCTURE;
-					free(regions);
-					goto err_munmap;
-				}
 			}
 		}
-
-		// Clean up allocated memory for this configuration
-		free(regions);
 	}
 
 	munmap(old_fdt, sbuf.st_size);
diff --git a/tools/mkimage.c b/tools/mkimage.c
index e96fb7e42db..12183270776 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -533,8 +533,7 @@ int main(int argc, char **argv)
 			retval = tparams->fflag_handle(&params);
 
 		if (retval != EXIT_SUCCESS) {
-			if (retval == FDT_ERR_NOTFOUND ||
-			    retval == FDT_ERR_BADSTRUCTURE) {
+			if (retval == FDT_ERR_NOTFOUND) {
 				// Already printed error, exit cleanly
 				exit(EXIT_FAILURE);
 			}
-- 
2.51.0

