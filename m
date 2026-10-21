Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796E606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ROxgW/0w
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11AB04087B;
	Wed, 21 Oct 2026 14:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id anHD5eoX9egx; Wed, 21 Oct 2026 14:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9123408A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591814;
	b=sjOIlnUVXY5Sc6KEovPPIDgzlhCX1UNpM2fHql6Z1p/xSwH+4sfaATPNgCjxwjeQxrNS
	 1ltTHcOfsDupxE+Pwp8YsVcVxhJIHkGCNq1z6jkgSj0In5zvg3OdqsQdt/S+f9GsTWvaS
	 vl8YF2mZQ9tsXZkOz/iLZoJUNHNQg3zMZ8nTg71xk3gDEw/cuSHzQJF6tvSOG/LBvBe2j
	 6hHKR3sI2Odd8On9NNmEJ4Qk6H3u9RRZ+gMKqjLof2EvMggt/Rz69aXJRO74ewU3eT99C
	 iKex+6ok3eV5T80QplMN6vVLjQVJ5gJYjgrMYPjRf1kOhc/Une1Vx5nHOj9PQVbMnpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YtqGcV85K+XdmsW+z7XiCaqlJN5+2DvPc8y+je1FCmA=;
	b=fdEFwhsGtHRIhG6cLGW/FMAApt98djyUyOj2VTLzpD5AOYerlrETOPO8QYUDQeOgQxS6
	 0RjsqMREEDubhp/LT5yzv4FfwIBCFLJDFHWR/RA3DH1naTXslJtfEzGKVHie9hsfupwXx
	 eanTzOWxJ7cSHAPQmkEe4hqFd5EbPm5NmwJtOWdzymi7TzxDRM2b7dQugt6lo/FM1uXTb
	 48bWCuoRacJUbSxBfKQ6dOJi5oJjW8ms8myuqCYvf4q0y1ahhPkAGXpuz/zTuCHSkE8/e
	 aKJJrnbZXr+t2H5pwEQ7z99APj24FdAGZVG32lK8zDvXS/Bb2AaMUlo3sNYneI27hgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591814;
	bh=YtqGcV85K+XdmsW+z7XiCaqlJN5+2DvPc8y+je1FCmA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROxgW/0w4peenWjfLg79Im2+l8RtUqO4eBtXLz6bo9r1C+CYSDxss0klTIYW71XHa
	 b43yjjyqWC7zCHenk/fSV3suGe5kSD4Ox5zplvRz85iqsQS7Zh3IL6UYdkE/h25dDq
	 WuFW5cIbyG1SIkl9L++E/2TZ3BCPTROJtgVhvLWBctgjlOToOBKgZjbdgGrskdFB4K
	 wBxzI1ctHbQgYyg/EWVBskNwMVlGsaaAFeyaDogYjpRuHVdCAx5I8QRfT5aagTJ4za
	 /madAtm4CHtR5MUCatD36kPZNVN4pt7yHKLP7kIG+7pHbqSOh0FVNXQtnjVL3gS8eZ
	 sSOirsEgV+4sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9123408A1;
	Wed, 21 Oct 2026 14:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09DD03A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 076C38119D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ueuBNi_z3ca3 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5FC58118E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591812;
 b=V/iHkM/lqCvTvvEWPez49DpdPtCT+wFuD8afm/KeIwrQL6cezFFyL5esr4j/BWsA8rJx
 g4n+vzzp9y+sYO2aFR/jMPKbI8KAybgFd2raN2tN564DPynuBF6NAflYZDmxGJW98WoV8
 X8MYpMGLDv6Gr8Nd/y/Q47eMrfZyaJCWukgh6LC8Fk7N30kc4IYlVu41gDvi6XOVQO1wX
 HqTHbu3Buqatk72U3472rBhpyt9RUj9wOpgDL1HQkrqtIWFAlhP8DJRUiWO2+ZMlpITab
 b9dQy1pTG4kxWfCUqX7NwG4kSLDW8fHFVmEZNhaDJkaGW7XyiL0CdHN7jDS0+BEZRUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591812;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=YtqGcV85K+XdmsW+z7XiCaqlJN5+2DvPc8y+je1FCmA=;
 b=MtfbTFA/69eYO/ZDfdCHVWLNQKDby51xz+LblSoV4uQzaACJmU53Gu8R922YmaQR+JlE
 m89zNv1Rs+IHjMwCLixwYZSLSGBIJ0rMZYpfR8J3Iqz9ckLxQYdCob3u6sfA/IsspUHq8
 ifSUV+9eqVZ2FUsG39tFs7G6S+q/rGG+QD4CYuyIfQdMEMzhK5AkQ80zK03scfSAbA6DD
 czhor2QZ+iJMewQWuJAzxH6uq+Uxf1bONlBemkQwcWLhSPd8T23DS5aOo9HqGazbKOvoa
 9lN45YZgBrXlcEd8WMBuJqFSs0uEr4bg3XX+zE0iwQyM/P67t5+nWeQ3ni2xKh2+j2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5FC58118E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:11 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxy-0000000028h-3GKQ;
 Wed, 21 Oct 2026 14:10:08 +0000
Date: Wed, 21 Oct 2026 15:10:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 10/11] boot: build the imagemap pointers only when enabled
Message-ID: <1df57ba95b7802357450a76812dbc410390bd138.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct bootm_headers and struct bootm_info carry an imagemap pointer
whatever the configuration, so every board pays for it with the feature
off, and each use site has to spell out an IS_ENABLED() test beside the
NULL check.

Compile the two fields under CONFIG_IMAGEMAP and reach them through
bootm_imagemap(), bootm_set_imagemap(), bootm_info_imagemap() and
bootm_info_set_imagemap(), which fold to NULL and to nothing when it
is off.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - Add bootm_info_set_imagemap() alongside the getter, so a future
   caller does not have to spell the ifdef itself.
 - The bootm_info_* accessors now carry the same !defined(USE_HOSTCC)
   guard as bootm_imagemap(); tools/image-host.c pulls in bootm.h.
 - fit_image_load_storage() keeps the device in a local instead of
   calling bootm_imagemap() twice.
 - The imagemap release in the OS-GO and error paths moves into the
   shared bootm_imagemap_cleanup() helper.

 boot/bootm.c     | 44 ++++++++++++++++++++++++++++----------------
 boot/image-fit.c | 13 +++++++------
 include/bootm.h  | 31 +++++++++++++++++++++++++++++++
 include/image.h  | 31 +++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 67df647d176..a15296c8b8d 100644
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
@@ -1186,6 +1186,24 @@ unmap_image:
 	return ret;
 }
 
+/**
+ * bootm_imagemap_cleanup() - release the on-demand storage loader
+ * @images: Boot images being used
+ *
+ * Tears down the imagemap device and clears the pointer, but only when one
+ * was in use. The two call sites (the OS-GO path and the error path) share
+ * this so the release logic lives in one place.
+ */
+static void bootm_imagemap_cleanup(struct bootm_headers *images)
+{
+	struct udevice *imagemap = bootm_imagemap(images);
+
+	if (imagemap) {
+		imagemap_cleanup(imagemap);
+		bootm_set_imagemap(images, NULL);
+	}
+}
+
 int bootm_run_states(struct bootm_info *bmi, int states)
 {
 	struct bootm_headers *images = bmi->images;
@@ -1200,11 +1218,11 @@ int bootm_run_states(struct bootm_info *bmi, int states)
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
 
@@ -1214,7 +1232,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
 		ulong img_addr;
 
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap)
+		if (bootm_imagemap(images))
 			img_addr = images->os.start;
 		else
 			img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
@@ -1318,10 +1336,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* Now run the OS! We hope this doesn't return */
 	if (!ret && (states & BOOTM_STATE_OS_GO)) {
 		/* Release storage backend before jumping - no return expected */
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
-			imagemap_cleanup(images->imagemap);
-			images->imagemap = NULL;
-		}
+		bootm_imagemap_cleanup(images);
 
 		ret = boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn);
 	}
@@ -1329,10 +1344,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* Deal with any fallout */
 err:
 	/* Clean up imagemap on error (not reached on successful boot) */
-	if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
-		imagemap_cleanup(images->imagemap);
-		images->imagemap = NULL;
-	}
+	bootm_imagemap_cleanup(images);
 
 	if (iflag)
 		enable_interrupts();
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 0367331c25d..d104367f91b 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1163,10 +1163,10 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		}
 		*data = fit + offset;
 #if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
-		if (images.imagemap) {
+		if (bootm_imagemap(&images)) {
 			void *mapped;
 
-			mapped = imagemap_lookup(images.imagemap,
+			mapped = imagemap_lookup(bootm_imagemap(&images),
 						 offset, len);
 			if (mapped)
 				*data = mapped;
@@ -2212,6 +2212,7 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	u8 img_comp = IH_COMP_NONE;
 	void *mapped;
 	void *dst;
+	struct udevice *imagemap = bootm_imagemap(images);
 	int ret;
 
 	if (CONFIG_IS_ENABLED(FIT_VERITY)) {
@@ -2242,11 +2243,11 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	    !fit_image_get_load(fit, noffset, &img_load)) {
 		dst = map_sysmem(img_load, data_sz);
 
-		mapped = imagemap_map_to(images->imagemap, data_off, data_sz,
+		mapped = imagemap_map_to(imagemap, data_off, data_sz,
 					 dst);
 		unmap_sysmem(dst);
 	} else {
-		mapped = imagemap_map(images->imagemap, data_off, data_sz);
+		mapped = imagemap_map(imagemap, data_off, data_sz);
 	}
 
 	return IS_ERR(mapped) ? PTR_ERR(mapped) : 0;
@@ -2361,7 +2362,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	 * On-demand storage: pre-load external-data payloads into RAM (or leave
 	 * dm-verity filesystems on storage) before fit_image_select() verifies.
 	 */
-	if (CONFIG_IS_ENABLED(IMAGEMAP) && !tools_build() && images->imagemap) {
+	if (!tools_build() && bootm_imagemap(images)) {
 		bool early = false;
 
 		ret = fit_image_load_storage(images, fit, noffset, load_op,
@@ -2486,7 +2487,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 
 		/* A storage-backed image was read straight to its load address */
-		if (!images->imagemap || data != load)
+		if (!bootm_imagemap(images) || data != load)
 			printf("   Loading %s from 0x%08lx to 0x%08lx\n",
 			       prop_name, data, load);
 	} else {
diff --git a/include/bootm.h b/include/bootm.h
index d1aac3d44df..272583c8471 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -52,12 +52,43 @@ struct bootm_info {
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
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
+	return bmi->imagemap;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * bootm_info_set_imagemap() - Record the storage loader a boot should use
+ *
+ * @bmi: Boot info
+ * @imagemap: The imagemap device, or NULL for an image already in RAM
+ */
+static inline void bootm_info_set_imagemap(struct bootm_info *bmi,
+					   struct udevice *imagemap)
+{
+#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
+	bmi->imagemap = imagemap;
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
