Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B39E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B77A80570;
	Wed,  1 Jan 2025 23:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMbbXuuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626A380511; Wed,  1 Jan 2025 23:12:39 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8DD8039B
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so15199456a91.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769554; x=1736374354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJCMJkb16siNJidhzOLZVJ8OijINYjRwRnA3sULRMzU=;
 b=aMbbXuuNv/FTY2dR7zdosX9YCASjH+K7PJcV8XlYkD6gMJ0n757eUFZG+eUTngWNOK
 MVVNqzl4UFuGhtCEPK22Kk4NVKckrAdhY6pNA6xOtmC4gVO4CTY2wQdr48FkrCW/X4gm
 miJy4/fhBM2H0cWSk73QBDUSsV/NZBSQheP/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769554; x=1736374354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJCMJkb16siNJidhzOLZVJ8OijINYjRwRnA3sULRMzU=;
 b=q7fqs+5A9UZWprVSnui8yRahJZWKjXdpKhI0/Ki17CK9FC/GfdHeLEL9JV2UrS0CPV
 dpPvzcNwJX/iaetvFNa4LIQo10usOrC+BD7e0PP0utKUGTibDho3m45lygS873xNL8Pv
 61WOvnXCNgyf0Re5W7GPTSW2xpeuNReZB0Oc94NrXRkLjR+BEWhGVY39dHRM/FkWQjzw
 M//bnD7CIlv19Z9ZCjhzLgbht4QJ39+Uy8109y+xe8X9nzV4VGcq8tyP03kLdIXOsDLA
 6tM3LaXpRBb4TCbK2fc92GeVPM4lOqIWtYh46fJraQaIEERmVwHDOzSV/xu7XP6cZ4GX
 mFFA==
X-Gm-Message-State: AOJu0Yx3njqXiGZzpXi7R+Mdp73dozlqKfUi43W+dlw0TMpW6BbprmS5
 IyEyvDxygMMELmZoWZLq1ZrjMgSx3q+wWBA4g98OJkt9BcfX0Yt+BOCzxcCQfPor7jrv4RsOwfg
 =
X-Gm-Gg: ASbGncsr4E3w+mzJlD7Xo+XbzTUljC1lv9QgQsLYvSBWR4xqPCPpDjputVZHMNJ5LCf
 ORGhbzTFabQWdXKdTNiD6cltbrzgMxEwg+0lRKeSzzu5PhhtIoETn3EcXp1b2LyG6PjIfAC0mvg
 Q+LgAGMfueR4RO0hxyAW8OUvEHbawmTssBj4LM6lJ+wIngDJlhOOJig+MJZhMsQsJ4t05sU1UO/
 OPlFnjayMperFFu62tuyD1vUuz8gbSqTTl881DHgd4D4hNMoQW1p3A=
X-Google-Smtp-Source: AGHT+IF5Hk3suxL4kb2N6zCEvvYXFFOKz41H8O1AHnDYRL2YkpjOXSPa3PL4v8gQgNmWW/XisKaf5Q==
X-Received: by 2002:a05:6a00:44ce:b0:725:e444:2505 with SMTP id
 d2e1a72fcca58-72abdd4f4admr62901117b3a.4.1735769554338; 
 Wed, 01 Jan 2025 14:12:34 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/67] boot: Update fit_image_get_data() to use abuf
Date: Thu,  2 Jan 2025 11:09:03 +1300
Message-ID: <20250101221003.1944600-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This function uses separate arguments for data and size. Use the new
abuf instead, so that they are paired and in one place. In some cases it
also saves an argument, thus potentially reducing code size.

Move the prototype to the header file while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/sec_firmware.c  | 11 +++--
 arch/arm/mach-k3/r5/sysfw-loader.c |  9 +++-
 arch/x86/lib/bootm.c               |  7 ++-
 boot/image-board.c                 | 11 +++--
 boot/image-fit.c                   | 71 +++++++++++-------------------
 cmd/ximg.c                         | 13 +++---
 common/splash_source.c             | 11 ++---
 common/update.c                    |  7 +--
 include/image.h                    | 19 +++++++-
 lib/abuf.c                         | 11 ++++-
 tools/fit_image.c                  |  8 ++--
 11 files changed, 94 insertions(+), 84 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index e3f8a6dcd60..555ab50625a 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -83,8 +83,6 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 {
 	phys_addr_t sec_firmware_loadable_addr = 0;
 	int conf_node_off, ld_node_off, images;
-	const void *data;
-	size_t size;
 	const char *name, *str, *type;
 	ulong load;
 	int len;
@@ -114,6 +112,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 
 	for (str = name; str && ((str - name) < len);
 	     str = strchr(str, '\0') + 1) {
+		struct abuf buf;
+
 		printf("%s: '%s'\n", type, str);
 		ld_node_off = fdt_subnode_offset(sec_firmware_img, images, str);
 		if (ld_node_off < 0) {
@@ -128,8 +128,7 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 			return -EINVAL;
 		}
 
-		if (fit_image_get_data(sec_firmware_img, ld_node_off,
-				       &data, &size)) {
+		if (fit_image_get_data(sec_firmware_img, ld_node_off, &buf)) {
 			printf("SEC Loadable: Can't get subimage data/size");
 			return -ENOENT;
 		}
@@ -147,9 +146,9 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 		/* Copy loadable to secure memory and flush dcache */
 		debug("%s copied to address 0x%p\n",
 		      FIT_LOADABLE_PROP, (void *)sec_firmware_loadable_addr);
-		memcpy((void *)sec_firmware_loadable_addr, data, size);
+		memcpy((void *)sec_firmware_loadable_addr, buf.data, buf.size);
 		flush_dcache_range(sec_firmware_loadable_addr,
-				   sec_firmware_loadable_addr + size);
+				   sec_firmware_loadable_addr + buf.size);
 
 		/* Populate loadable address only for Trusted OS */
 		if (!strcmp(str, "trustedOS@1")) {
diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
index f0ad7559b97..ca98d310450 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -117,7 +117,14 @@ static int fit_get_data_by_name(const void *fit, int images, const char *name,
 	if (node_offset < 0)
 		return -ENOENT;
 
-	return fit_image_get_data(fit, node_offset, addr, size);
+	ret = fit_image_get_data(fit, node_offset, &buf);
+	if (ret)
+		return ret;
+
+	*addr = buf.data;
+	*size = buf.size;
+
+	return 0;
 }
 
 static void k3_start_system_controller(int rproc_id, bool rproc_loaded,
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 2a7933cdaf8..bbd8ee7870f 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -106,13 +106,16 @@ static int boot_prep_linux(struct bootm_headers *images)
 		is_zimage = 1;
 #if defined(CONFIG_FIT)
 	} else if (images->fit_uname_os && is_zimage) {
+		struct abuf buf;
+
 		ret = fit_image_get_data(images->fit_hdr_os,
-					 images->fit_noffset_os,
-					 (const void **)&data, &len);
+					 images->fit_noffset_os, &buf);
 		if (ret) {
 			puts("Can't get image data/size!\n");
 			goto error;
 		}
+		data = buf.data;
+		len = buf.size;
 		is_zimage = 1;
 #endif
 	}
diff --git a/boot/image-board.c b/boot/image-board.c
index 8e6b2974dcf..f8083fcb3f9 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -964,9 +964,7 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 			const char *confname, char **datap, uint *lenp)
 {
 	const struct legacy_img_hdr *hdr;
-	const void *fit_data;
 	const void *fit_hdr;
-	size_t fit_len;
 	int noffset;
 	int verify;
 	ulong len;
@@ -1024,6 +1022,8 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 		if (!IS_ENABLED(CONFIG_FIT)) {
 			goto exit_image_format;
 		} else {
+			struct abuf abuf;
+
 			fit_hdr = buf;
 			if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
 				puts("Bad FIT image format\n");
@@ -1087,14 +1087,13 @@ fallback:
 			}
 
 			/* get script subimage data address and length */
-			if (fit_image_get_data(fit_hdr, noffset, &fit_data,
-					       &fit_len)) {
+			if (fit_image_get_data(fit_hdr, noffset, &abuf)) {
 				puts("Could not find script subimage data\n");
 				return 1;
 			}
 
-			data = (u32 *)fit_data;
-			len = (ulong)fit_len;
+			data = abuf.data;
+			len = abuf.size;
 		}
 		break;
 	default:
diff --git a/boot/image-fit.c b/boot/image-fit.c
index e9b4152eb84..8e69a3e1897 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -475,9 +475,8 @@ void fit_image_print(const void *fit, int image_noffset, const char *p)
 {
 	char *desc;
 	uint8_t type, arch, os, comp = IH_COMP_NONE;
-	size_t size;
 	ulong load, entry;
-	const void *data;
+	struct abuf buf;
 	int noffset;
 	int ndepth;
 	int ret;
@@ -510,24 +509,21 @@ void fit_image_print(const void *fit, int image_noffset, const char *p)
 	fit_image_get_comp(fit, image_noffset, &comp);
 	printf("%s  Compression:  %s\n", p, genimg_get_comp_name(comp));
 
-	ret = fit_image_get_data(fit, image_noffset, &data, &size);
+	ret = fit_image_get_data(fit, image_noffset, &buf);
 
 	if (!tools_build()) {
 		printf("%s  Data Start:   ", p);
-		if (ret) {
+		if (ret)
 			printf("unavailable\n");
-		} else {
-			void *vdata = (void *)data;
-
-			printf("0x%08lx\n", (ulong)map_to_sysmem(vdata));
-		}
+		else
+			printf("0x%08lx\n", abuf_addr(&buf));
 	}
 
 	printf("%s  Data Size:    ", p);
 	if (ret)
 		printf("unavailable\n");
 	else
-		genimg_print_size(size);
+		genimg_print_size(buf.size);
 
 	/* Remaining, type dependent properties */
 	if ((type == IH_TYPE_KERNEL) || (type == IH_TYPE_STANDALONE) ||
@@ -1017,24 +1013,7 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 	return 0;
 }
 
-/**
- * fit_image_get_data - get data and its size including
- *				 both embedded and external data
- * @fit: pointer to the FIT format image header
- * @noffset: component image node offset
- * @data: double pointer to void, will hold data property's data address
- * @size: pointer to size_t, will hold data property's data size
- *
- * fit_image_get_data() finds data and its size including
- * both embedded and external data. If the property is found
- * its data start address and size are returned to the caller.
- *
- * returns:
- *     0, on success
- *     otherwise, on failure
- */
-int fit_image_get_data(const void *fit, int noffset, const void **data,
-		       size_t *size)
+int fit_image_get_data(const void *fit, int noffset, struct abuf *buf)
 {
 	bool external_data = false;
 	int offset;
@@ -1056,16 +1035,10 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 	if (external_data) {
 		debug("External Data\n");
 		ret = fit_image_get_data_size(fit, noffset, &len);
-		if (!ret) {
-			*data = fit + offset;
-			*size = len;
-		}
+		if (!ret)
+			abuf_init_const(buf, fit + offset, len);
 	} else {
-		struct abuf buf;
-
-		ret = fit_image_get_emb_data(fit, noffset, &buf);
-		*data = buf.data;
-		*size = buf.size;
+		ret = fit_image_get_emb_data(fit, noffset, buf);
 	}
 
 	return ret;
@@ -1410,9 +1383,8 @@ error:
 int fit_image_verify(const void *fit, int image_noffset)
 {
 	const char *name = fit_get_name(fit, image_noffset, NULL);
-	const void	*data;
-	size_t		size;
 	char		*err_msg = "";
+	struct abuf buf;
 
 	if (IS_ENABLED(CONFIG_FIT_SIGNATURE) && strchr(name, '@')) {
 		/*
@@ -1423,13 +1395,13 @@ int fit_image_verify(const void *fit, int image_noffset)
 		goto err;
 	}
 	/* Get image data and data length */
-	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
+	if (fit_image_get_data(fit, image_noffset, &buf)) {
 		err_msg = "Can't get image data/size";
 		goto err;
 	}
 
 	return fit_image_verify_with_data(fit, image_noffset, gd_fdt_blob(),
-					  data, size);
+					  buf.data, buf.size);
 
 err:
 	printf("error!\n%s in '%s' image node\n", err_msg,
@@ -1739,8 +1711,8 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 		const char *kfdt_name;
 		int kfdt_noffset, compat_noffset;
 		const char *cur_fdt_compat;
+		struct abuf buf;
 		int len;
-		size_t sz;
 		int i;
 
 		if (ndepth > 1)
@@ -1772,10 +1744,11 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 			}
 
 			/* search in this config's kernel FDT */
-			if (fit_image_get_data(fit, kfdt_noffset, &fdt, &sz)) {
+			if (fit_image_get_data(fit, kfdt_noffset, &buf)) {
 				debug("Failed to get fdt \"%s\".\n", kfdt_name);
 				continue;
 			}
+			fdt = buf.data;
 
 			compat_noffset = 0;  /* search kFDT under root node */
 		}
@@ -1923,6 +1896,7 @@ int fit_conf_get_prop_node(const void *fit, int noffset, const char *prop_name,
 static int fit_get_data_tail(const void *fit, int noffset,
 			     const void **data, size_t *size)
 {
+	struct abuf buf;
 	char *desc;
 
 	if (noffset < 0)
@@ -1931,12 +1905,15 @@ static int fit_get_data_tail(const void *fit, int noffset,
 	if (!fit_image_verify(fit, noffset))
 		return -EINVAL;
 
-	if (fit_image_get_data(fit, noffset, data, size))
+	if (fit_image_get_data(fit, noffset, &buf))
 		return -ENOENT;
 
 	if (!fit_get_desc(fit, noffset, &desc))
 		printf("%s\n", desc);
 
+	*data = buf.data;
+	*size = buf.size;
+
 	return 0;
 }
 
@@ -2047,6 +2024,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *fit_uname;
 	const char *fit_uname_config;
 	const char *fit_base_uname_config;
+	struct abuf abuf;
 	const void *fit;
 	void *buf;
 	void *loadbuf;
@@ -2187,12 +2165,15 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL_OK);
 
 	/* get image data address and length */
-	if (fit_image_get_data(fit, noffset, (const void **)&buf, &size)) {
+	if (fit_image_get_data(fit, noffset, &abuf)) {
 		printf("Could not find %s subimage data!\n", prop_name);
 		bootstage_error(bootstage_id + BOOTSTAGE_SUB_GET_DATA);
 		return -ENOENT;
 	}
 
+	buf = abuf.data;
+	size = abuf.size;
+
 	/* Decrypt data before uncompress/move */
 	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
diff --git a/cmd/ximg.c b/cmd/ximg.c
index 29d7c3279b3..ad85806fdcb 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -44,8 +44,6 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	const char	*uname = NULL;
 	const void*	fit_hdr;
 	int		noffset;
-	const void	*fit_data;
-	size_t		fit_len;
 #endif
 #ifdef CONFIG_GZIP
 	uint		unc_len = CONFIG_SYS_XIMG_LEN;
@@ -122,7 +120,9 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		break;
 #endif
 #if defined(CONFIG_FIT)
-	case IMAGE_FORMAT_FIT:
+	case IMAGE_FORMAT_FIT: {
+		struct abuf buf;
+
 		if (uname == NULL) {
 			puts("No FIT subimage unit name\n");
 			return 1;
@@ -161,7 +161,7 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		/* get subimage/external data address and length */
-		if (fit_image_get_data(fit_hdr, noffset, &fit_data, &fit_len)) {
+		if (fit_image_get_data(fit_hdr, noffset, &buf)) {
 			puts("Could not find script subimage data\n");
 			return 1;
 		}
@@ -169,9 +169,10 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		if (fit_image_get_comp(fit_hdr, noffset, &comp))
 			comp = IH_COMP_NONE;
 
-		data = (ulong)fit_data;
-		len = (ulong)fit_len;
+		data = abuf_addr(&buf);
+		len = buf.size;
 		break;
+	}
 #endif
 	default:
 		puts("Invalid image type for imxtract\n");
diff --git a/common/splash_source.c b/common/splash_source.c
index 9972a1b2a08..95a88731c31 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -347,8 +347,6 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	int res;
 	int node_offset;
 	const char *splash_file;
-	const void *internal_splash_data;
-	size_t internal_splash_size;
 	int external_splash_addr;
 	int external_splash_size;
 	bool is_splash_external = false;
@@ -356,6 +354,7 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	const u32 *fit_header;
 	u32 fit_size;
 	const size_t header_size = sizeof(struct legacy_img_hdr);
+	struct abuf buf;
 
 	/* Read in image header */
 	res = splash_storage_read_raw(location, bmp_load_addr, header_size);
@@ -395,11 +394,9 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	}
 
 	/* Extract the splash data from FIT */
-	if (!fit_image_get_data(fit_header, node_offset, &internal_splash_data,
-				&internal_splash_size))
-		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data,
-			internal_splash_size);
-	else {
+	if (!fit_image_get_emb_data(fit_header, node_offset, &buf)) {
+		memmove((void *)(uintptr_t)bmp_load_addr, buf.data, buf.size);
+	} else {
 		printf("Failed to get splash image from FIT\n");
 		return -ENODATA;
 	}
diff --git a/common/update.c b/common/update.c
index 6801b49479d..6d0b979cc97 100644
--- a/common/update.c
+++ b/common/update.c
@@ -6,6 +6,7 @@
  *             Bartlomiej Sieka <tur@semihalf.com>
  */
 
+#include <abuf.h>
 #include <cpu_func.h>
 #include <image.h>
 #include <linux/printk.h>
@@ -198,15 +199,15 @@ static int update_flash(ulong addr_source, ulong addr_first, ulong size)
 static int update_fit_getparams(const void *fit, int noffset, ulong *addr,
 						ulong *fladdr, ulong *size)
 {
-	const void *data;
+	struct abuf buf;
 
-	if (fit_image_get_data(fit, noffset, &data, (size_t *)size))
+	if (fit_image_get_data(fit, noffset, &buf))
 		return 1;
 
 	if (fit_image_get_load(fit, noffset, (ulong *)fladdr))
 		return 1;
 
-	*addr = (ulong)data;
+	*addr = abuf_addr(&buf);
 
 	return 0;
 }
diff --git a/include/image.h b/include/image.h
index 29ac7a69ae9..19f5a7b2d83 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1220,8 +1220,23 @@ int fit_image_get_data_position(const void *fit, int noffset,
 int fit_image_get_data_size(const void *fit, int noffset, int *data_size);
 int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size);
-int fit_image_get_data(const void *fit, int noffset, const void **data,
-		       size_t *size);
+
+/**
+ * fit_image_get_data() - Get a node's data and size
+ *
+ * @fit: pointer to the FIT format image header
+ * @noffset: component image node offset
+ * @buf: returns data (inited by this function)
+ *
+ * fit_image_get_data_and_size() finds data and its size including
+ * both embedded and external data. If the property is found
+ * its data start address and size are returned to the caller.
+ *
+ * returns:
+ *     0, on success
+ *     otherwise, on failure
+ */
+int fit_image_get_data(const void *fit, int noffset, struct abuf *buf);
 
 /**
  * fit_get_data_node() - Get verified image data for an image
diff --git a/lib/abuf.c b/lib/abuf.c
index 61adf7fc6b1..1999b2c1f5f 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -21,18 +21,25 @@ void abuf_set(struct abuf *abuf, void *data, size_t size)
 	abuf->size = size;
 }
 
-#ifndef USE_HOSTCC
 void abuf_map_sysmem(struct abuf *abuf, ulong addr, size_t size)
 {
+#ifdef USE_HOSTCC
+	abuf_set(abuf, (void *)addr, size);
+#else
 	abuf_set(abuf, map_sysmem(addr, size), size);
+#endif
 }
 
 ulong abuf_addr(const struct abuf *abuf)
 {
+#ifdef USE_HOSTCC
+	return (ulong)abuf->data;
+#else
 	return map_to_sysmem(abuf->data);
+#endif
 }
 
-#else
+#ifdef USE_HOSTCC
 /* copied from lib/string.c for convenience */
 static char *memdup(const void *src, size_t len)
 {
diff --git a/tools/fit_image.c b/tools/fit_image.c
index caed8d5f901..dfcfa66afa7 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -15,6 +15,7 @@
 
 #include "imagetool.h"
 #include "fit_common.h"
+#include <abuf.h>
 #include "mkimage.h"
 #include <image.h>
 #include <string.h>
@@ -871,19 +872,18 @@ static int fit_image_extract(
 	int image_noffset,
 	const char *file_name)
 {
-	const void *file_data;
-	size_t file_size = 0;
+	struct abuf buf;
 	int ret;
 
 	/* get the data address and size of component at offset "image_noffset" */
-	ret = fit_image_get_data(fit, image_noffset, &file_data, &file_size);
+	ret = fit_image_get_data(fit, image_noffset, &buf);
 	if (ret) {
 		fprintf(stderr, "Could not get component information\n");
 		return ret;
 	}
 
 	/* save the "file_data" into the file specified by "file_name" */
-	return imagetool_save_subimage(file_name, (ulong) file_data, file_size);
+	return imagetool_save_subimage(file_name, abuf_addr(&buf), buf.size);
 }
 
 /**
-- 
2.43.0

