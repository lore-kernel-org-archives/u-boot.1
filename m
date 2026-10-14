Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B2BCC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04D1060728;
	Wed, 14 Oct 2026 08:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wHk5DTvTLFVQ; Wed, 14 Oct 2026 08:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F093F607CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967229;
	b=dZ6jcOjINbo+whq5ghN5ueZjTsl9w3hSCmudVYWL2dtqwIFYhPoUTJdulaS2FJIzuc+a
	 AvDPvXo+XShbs+caenOReIBMXtFuWzsNwwqYt4bfPNK82ursGmGLOH0e1ZTm1zroEGnBZ
	 mf47vseGNq5hXmCVXywX8odrgbBsEgcMbzLbLkKcDwTVndVxWn1m3tcrGuEbdB2lEnRS/
	 BDDILubdYayXG/hcrtArbVNi1MBOUH9pXP89vYjHMzvNaw4d691cZK1EaTaAb/vHRFnQ8
	 KKg8SCeL8TY6O0wjj8kKYEhy6v8uBzpBFvHXyjUygqi52dgCk3zL/kvMhQaN1Nfd/Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=05/YbaOIENnR53JPCt/Vqo+pZxqHDQrY+/6CMWw4uJE=;
	b=VurLBSHJuVK5mLFjZZV1jsZs57BV03kOuJZ8wdkL7AU66zRsEW41Tq41IlJ5uGbKMuFp
	 7jhqwgt0bWoQEh2qD5nUr02kukbA2Lt4lY7TuemR+2Z3zCI6YXoRE+L7g/YXaSj+TF7QS
	 zljnLamWhs4HLIeFctzGO8pkSafcYuPwxQrUKrSoWjDdtYWdyYYVWQjMnfk+eIjX6usD7
	 5PFYQ+HCY6Xu+PlDnDKuQ21bo2MarJ8ah8a5kpISuREqrRWppJad1g+Qxk6h4Uh0pSc9X
	 Rwsa2QvBSj3nWmJ9y6esq1RUr9mOZ3rl5CWrZeJbDGij6SAC1vqtLgyS3DSaahFho7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967229;
	bh=05/YbaOIENnR53JPCt/Vqo+pZxqHDQrY+/6CMWw4uJE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v0VETYBAVvnO8mqFWS/ZL1FAo093mJDm9plW/O5i+kUjRzTQtRWmfFu4OttDxJ8p9
	 /3dpWP+hrV26kf3jdPGq0o+DYlnrMqRHa5s6VhE6x3nCX0eEaMx+KnrOtePrar6pyl
	 tBFX+moyy2KR1ZU0wuzDR6xfFClUEKHbKqqeOSgKWBq3sOsPRbW/jD/MG+TVZ6suzo
	 gMATFm1+eeZ7LFNn2Lh7bKdUYwINuLR3/uXYWLhSgQZHRP9C/wSwRzoj1LCuVvwIoL
	 OfYh4wtx/Qx4gEkNtc1IIy4qykResZGFm2rB3EviY+/Wv8J+w9R70yCdvYIiCVhQi3
	 NOXHfmN05JB8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F093F607CA;
	Wed, 14 Oct 2026 08:40:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69BCC235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B8DF4061E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pp4y89OWhq3Z for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70D3640606
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967226;
 b=XAj3dRnVvfRnjgkE15SKQBz9VDqTjyoi+MKr1eoNfLmWQ7bXaOymabpL0tWEuGf8DT+Q
 JyxIFw+grGRqqjQeVghZZw/aA8gqUZeWRr9GsPNnS6XbHc89Ee2UHxrasstGxe2TTARun
 rprxsezRS4bJ2p2bmQypTMLpe9Ey2ln/NfeNlMc0tofwPiQwkebU//YymIuv/kq5rx0xO
 aH4MzJcSJgo3alGZDgHPS6JJfUx305RpizUigo/tUvWOAnOwkDQsPwkNfBjdoMnXN0Wlr
 wK3iAETXCeoNME9WXClKeoMWpLp0lhGUzglH5UCf7rEXxvyFENSonfb/LW8EZczM0sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967226;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=05/YbaOIENnR53JPCt/Vqo+pZxqHDQrY+/6CMWw4uJE=;
 b=L8C2ixU08wNi8KOEnPGgIqh8OLd2kZyOZS/m5m6rU1jq0U8LfbRE+u/Gb0gGY9VUuJqn
 PoT+P3bQ7uIC6jotPjHpJBzQmZnYBKy+hwm531Kydsdd/d8rj5TOOXFJ9yOQbthpfwU8k
 uE3Rtbc4bjJSEvsmRu+LQvbDKMeD4KvPBud57zh797GWLiCgBRybv6RJq9D7jEou0jmgL
 unc6Nvyfc6XSR5Ryi1etKCTheHQJWxjbmnHpdYZ/ue2h0aMRyGwEqqA8Uvc7dGciB8ssW
 tiz9maxHGnhqig0eod9lkrPca9Ufo8yjR4xWuJgYcEx1wtLcE/4upbDroYZl8I+R4OQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70D3640606
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:26 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuX9-000000005g7-0NDm;
 Wed, 14 Oct 2026 08:40:23 +0000
Date: Wed, 14 Oct 2026 09:40:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 10/11] boot: build the imagemap pointers only when enabled
Message-ID: <adbf35ed13c45830dcc36e05d667b37e6a2017db.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

struct bootm_headers and struct bootm_info carry an imagemap pointer
whatever the configuration, so every board pays for it with the feature
off, and each use site has to spell out an IS_ENABLED() test beside the
NULL check.

Compile the two fields under CONFIG_IMAGEMAP and reach them through
bootm_imagemap(), bootm_set_imagemap() and bootm_info_imagemap(), which
fold to NULL and to nothing when it is off.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootm.c     | 28 ++++++++++++++--------------
 boot/image-fit.c | 12 ++++++------
 include/bootm.h  | 17 +++++++++++++++++
 include/image.h  | 31 +++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 67df647d176..8d3fabab39b 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -151,14 +151,14 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 
 	/* check image type, for FIT images get FIT kernel node */
 	*os_data = *os_len = 0;
-	if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
+	if (bootm_imagemap(images)) {
 		/*
 		 * Storage path: read enough bytes to detect the image
 		 * format. genimg_get_kernel_addr_fit() above still
 		 * parsed any #config / :subimage suffix so the FIT
 		 * selection variables are populated.
 		 */
-		buf = imagemap_map(images->imagemap, 0,
+		buf = imagemap_map(bootm_imagemap(images), 0,
 				   sizeof(struct legacy_img_hdr));
 		if (IS_ERR(buf)) {
 			puts("Cannot read image header from storage\n");
@@ -213,14 +213,14 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 #endif
 #if CONFIG_IS_ENABLED(FIT)
 	case IMAGE_FORMAT_FIT:
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
+		if (bootm_imagemap(images)) {
 			/*
 			 * Extend the mapping to cover the full FIT
 			 * FDT structure so all metadata is accessible.
 			 */
 			size_t fdt_sz = fdt_totalsize(buf);
 
-			buf = imagemap_map(images->imagemap, 0, fdt_sz);
+			buf = imagemap_map(bootm_imagemap(images), 0, fdt_sz);
 			if (IS_ERR(buf)) {
 				puts("Cannot read FIT header from storage\n");
 				return PTR_ERR(buf);
@@ -286,7 +286,7 @@ static int bootm_start(struct udevice *imagemap)
 	fit_verity_free(&images);
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
-	images.imagemap = imagemap;
+	bootm_set_imagemap(&images, imagemap);
 
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_START, "bootm_start");
 	images.state = BOOTM_STATE_START;
@@ -1200,11 +1200,11 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	 * any error.
 	 */
 	if (states & BOOTM_STATE_START)
-		ret = bootm_start(bmi->imagemap);
+		ret = bootm_start(bootm_info_imagemap(bmi));
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD)) {
 		/* Pre-load verification is not applicable to storage boot */
-		if (!IS_ENABLED(CONFIG_IMAGEMAP) || !images->imagemap)
+		if (!bootm_imagemap(images))
 			ret = bootm_pre_load(bmi->addr_img);
 	}
 
@@ -1214,7 +1214,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
 		ulong img_addr;
 
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap)
+		if (bootm_imagemap(images))
 			img_addr = images->os.start;
 		else
 			img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
@@ -1318,9 +1318,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* Now run the OS! We hope this doesn't return */
 	if (!ret && (states & BOOTM_STATE_OS_GO)) {
 		/* Release storage backend before jumping - no return expected */
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
-			imagemap_cleanup(images->imagemap);
-			images->imagemap = NULL;
+		if (bootm_imagemap(images)) {
+			imagemap_cleanup(bootm_imagemap(images));
+			bootm_set_imagemap(images, NULL);
 		}
 
 		ret = boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn);
@@ -1329,9 +1329,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* Deal with any fallout */
 err:
 	/* Clean up imagemap on error (not reached on successful boot) */
-	if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
-		imagemap_cleanup(images->imagemap);
-		images->imagemap = NULL;
+	if (bootm_imagemap(images)) {
+		imagemap_cleanup(bootm_imagemap(images));
+		bootm_set_imagemap(images, NULL);
 	}
 
 	if (iflag)
diff --git a/boot/image-fit.c b/boot/image-fit.c
index f02ac58d733..a461dc8f215 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1164,10 +1164,10 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 			}
 			*data = fit + offset;
 #if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
-			if (images.imagemap) {
+			if (bootm_imagemap(&images)) {
 				void *mapped;
 
-				mapped = imagemap_lookup(images.imagemap,
+				mapped = imagemap_lookup(bootm_imagemap(&images),
 							 offset, len);
 				if (mapped)
 					*data = mapped;
@@ -2246,11 +2246,11 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	    !fit_image_get_load(fit, noffset, &img_load)) {
 		dst = map_sysmem(img_load, data_sz);
 
-		mapped = imagemap_map_to(images->imagemap, data_off, data_sz,
+		mapped = imagemap_map_to(bootm_imagemap(images), data_off, data_sz,
 					 dst);
 		unmap_sysmem(dst);
 	} else {
-		mapped = imagemap_map(images->imagemap, data_off, data_sz);
+		mapped = imagemap_map(bootm_imagemap(images), data_off, data_sz);
 	}
 
 	return IS_ERR(mapped) ? PTR_ERR(mapped) : 0;
@@ -2365,7 +2365,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	 * On-demand storage: pre-load external-data payloads into RAM (or leave
 	 * dm-verity filesystems on storage) before fit_image_select() verifies.
 	 */
-	if (CONFIG_IS_ENABLED(IMAGEMAP) && !tools_build() && images->imagemap) {
+	if (!tools_build() && bootm_imagemap(images)) {
 		bool early = false;
 
 		ret = fit_image_load_storage(images, fit, noffset, load_op,
@@ -2490,7 +2490,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 
 		/* A storage-backed image was read straight to its load address */
-		if (!images->imagemap || data != load)
+		if (!bootm_imagemap(images) || data != load)
 			printf("   Loading %s from 0x%08lx to 0x%08lx\n",
 			       prop_name, data, load);
 	} else {
diff --git a/include/bootm.h b/include/bootm.h
index d1aac3d44df..ce13ce3dc61 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -52,12 +52,29 @@ struct bootm_info {
 	const char *conf_fdt;
 	bool boot_progress;
 	struct bootm_headers *images;
+#if CONFIG_IS_ENABLED(IMAGEMAP)
 	struct udevice *imagemap;
+#endif
 	const char *cmd_name;
 	int argc;
 	char *const *argv;
 };
 
+/**
+ * bootm_info_imagemap() - Get the storage loader a boot was asked to use
+ *
+ * @bmi: Boot info
+ * Return: the imagemap device, or NULL to boot an image already in RAM
+ */
+static inline struct udevice *bootm_info_imagemap(struct bootm_info *bmi)
+{
+#if CONFIG_IS_ENABLED(IMAGEMAP)
+	return bmi->imagemap;
+#else
+	return NULL;
+#endif
+}
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
diff --git a/include/image.h b/include/image.h
index 5248ca98d41..14189581646 100644
--- a/include/image.h
+++ b/include/image.h
@@ -412,7 +412,9 @@ struct bootm_headers {
 
 	int		verify;		/* env_get("verify")[0] != 'n' */
 
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
 	struct udevice *imagemap;	/* on-demand storage loader, or NULL */
+#endif
 
 #define BOOTM_STATE_START	0x00000001
 #define BOOTM_STATE_FINDOS	0x00000002
@@ -432,6 +434,35 @@ struct bootm_headers {
 
 extern struct bootm_headers images;
 
+/**
+ * bootm_imagemap() - Get the on-demand storage loader in use, if any
+ *
+ * @images: Images being booted
+ * Return: the imagemap device, or NULL when the image is already in RAM
+ */
+static inline struct udevice *bootm_imagemap(struct bootm_headers *images)
+{
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
+	return images->imagemap;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * bootm_set_imagemap() - Record the on-demand storage loader to read through
+ *
+ * @images: Images being booted
+ * @imagemap: The imagemap device, or NULL for an image already in RAM
+ */
+static inline void bootm_set_imagemap(struct bootm_headers *images,
+				      struct udevice *imagemap)
+{
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
+	images->imagemap = imagemap;
+#endif
+}
+
 /*
  * Some systems (for example LWMON) have very short watchdog periods;
  * we must make sure to split long operations like memmove() or
-- 
2.56.0
