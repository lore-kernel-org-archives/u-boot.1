Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DD2E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C07C805F7;
	Mon,  6 Jan 2025 15:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IOy81XWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E5880607; Mon,  6 Jan 2025 15:33:36 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8C7806A7
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e12f702dso621634939f.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174011; x=1736778811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx/mspJ7MK9UWSuVqglv/sbT9EKhfn02AJQz+bRSKG8=;
 b=IOy81XWTS/abZpIlumK6O7J1C/y8VGjB8y07mNSRTYHStkbP2iLBFJImPq99co589t
 iNCYdIpT9SqGqcAdZxOM9PAwSCoQGh1f+xs71SknJ90kRfnSFjLBH5TwCPc2QlIA/0vI
 ifgtVEkVAmFarnSKlndWC1VxrJWRmtEBKE8Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174011; x=1736778811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx/mspJ7MK9UWSuVqglv/sbT9EKhfn02AJQz+bRSKG8=;
 b=ogRqlQJZXb+H62pXq0W9TAK+fNoYGZG1NKAqX1P3QGrWiSHaBXsh5jTDCLPMprRPbf
 zancJgw8S98f1+hp+zYXXwgwt1v/ujwUkZQVWHgRNj+ShNZlT8Cia0tHjEGiAJ/mxAG1
 9Y++hR6YAR7oc6MFlTjN6AArUKJhkrTJRiiBIruZwJOWv0+5Yj3+usnp2rROpLgb+EVc
 KVcTYdA5qPXXY2aoXoQMZwNiNzrCoZenAeNuZAQOcp4uMb0i1JNkRnxNESULHUcFfb+s
 I0c0CMTn6aCxq5PIbX34h+ncFgvZw7WsqWsTLhCwB8PpXVUsn7tNdxt1+n3Keo425VOA
 9fqA==
X-Gm-Message-State: AOJu0Yz8EJdB3EXWNoscYYPeSv8nvwccYARE+Cy6Asrg1DFrQXJSCmYE
 RwrS/MaR9+rb8poXMpAj0mKSfKqtko7Do0t2pxlSLrghJTcyR/ep5EGDctK4dS8XoeerbQAsQwo
 =
X-Gm-Gg: ASbGncsb/tpZzUJR2pALzD7qnyMVJkYgaVBKmkQB4k0dK6U5ZCYzYPFtPdoTSGnsPWf
 KSvyRbXvKVO62Cz/bUzkePGwi89QiwOf/eHPAEn5WhSiKBUmm0BB7xxzxM6TOm8DQ8+i4wv3Xiu
 qsPv5Ta6eFRk0kZzVmQrV2BwOu7/GKuAJT6AruE+vJ3jJLR1A0Rke8O2lsZpWGiPwRO47J+9CdE
 cp+q67Ir/dM9bIG56l8W9hnlvZY09DgLkbkMIfxsh2PmLO8ZyHWWZwKs41wgBucPmNdMuZc6y7x
 wob14ap0aJ3rSf0GLQ==
X-Google-Smtp-Source: AGHT+IH16ujLCOWy3fCI5nrjEAFmEfvNX2Q6bo+ViR1RzWJBz+yrWkF3Otc9H0UlRBWaY5vhDz4ysw==
X-Received: by 2002:a05:6e02:20ca:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3c2d514fafdmr505579355ab.18.1736174011352; 
 Mon, 06 Jan 2025 06:33:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/33] boot: Update fit_image_get_data() to use abuf
Date: Mon,  6 Jan 2025 07:32:15 -0700
Message-Id: <20250106143229.3023771-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

(no changes since v1)

 arch/arm/cpu/armv8/sec_firmware.c  | 11 +++--
 arch/arm/mach-k3/r5/sysfw-loader.c |  9 +++-
 arch/x86/lib/bootm.c               |  7 ++-
 boot/image-board.c                 | 11 +++--
 boot/image-fit.c                   | 71 +++++++++++-------------------
 cmd/ximg.c                         | 13 +++---
 common/splash_source.c             |  9 ++--
 common/update.c                    |  7 +--
 include/image.h                    | 19 +++++++-
 lib/abuf.c                         | 11 ++++-
 tools/fit_image.c                  |  8 ++--
 11 files changed, 93 insertions(+), 83 deletions(-)

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
index 2df78a4f2d7..95a88731c31 100644
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
@@ -395,10 +394,8 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	}
 
 	/* Extract the splash data from FIT */
-	if (!fit_image_get_data(fit_header, node_offset, &internal_splash_data,
-				&internal_splash_size)) {
-		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data,
-			internal_splash_size);
+	if (!fit_image_get_emb_data(fit_header, node_offset, &buf)) {
+		memmove((void *)(uintptr_t)bmp_load_addr, buf.data, buf.size);
 	} else {
 		printf("Failed to get splash image from FIT\n");
 		return -ENODATA;
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
2.34.1

