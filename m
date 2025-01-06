Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E05E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41AA08069D;
	Mon,  6 Jan 2025 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dYZv7wrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC118069D; Mon,  6 Jan 2025 15:33:31 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AAED806E6
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a9cee9d741so102539655ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174006; x=1736778806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aE7jFVZJnLc1TRyiUp5VtRNZISSAsxEqJ9su0EoWegI=;
 b=dYZv7wrsHYsIQGEAt2Jiv3/XGLhMqoOFdJmZBPvBecdYQRWzwoPhhoONYgz5liQYf4
 ihyV1MVe9/38578z0XbC5+DPAaXKbEwkRbApx3/7jqHwUDq2duEB+E9dFBG2xMQPOUiS
 i915yHPMd3rdeX0IICHaiH2Iz+DmxEYtTcXJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174006; x=1736778806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aE7jFVZJnLc1TRyiUp5VtRNZISSAsxEqJ9su0EoWegI=;
 b=AmL1AwnL30kgYb08eqpVNhVppF630s0KF2jiLPPMzHQzMB8FvB4TRkGW19U1rqVhdj
 VJ9fbgtX1NukHbseyXhEWCoDPHXN6pFiPj6gcehhP/fcoqDwpJJcw34KPO9vbZrxIbAx
 FKCyJPxPgoskRwz7sFboHJ3TAO3c8jvxhpa7eGEr2YHx2K8M78h4e7XECgiK0rhTjLYA
 KdmPFG+fWDeRiHOfNmsg38qjZ4mG/6WlJTvOt3Y34VusuUrxPn+OV7/IZ+PyyQB5lz4S
 PrK5mi6mIvFOW8aFAouK8QSLOwRg43SZPnPjjn5l9UQpxwracKC8AVBPbci3t4Vyimy/
 F2pQ==
X-Gm-Message-State: AOJu0YyXIzOJ9kiqqE0sPTnfymn+850++yjNXwCe/DOFQxuoQlFmh9cH
 Y5P7/p/v6D67CkIG2DGX32XipSDaxYwb2CHCqcWA7QhBtywoQ0G8Nt2lUbEVoqUisT1QlTMh+Ps
 =
X-Gm-Gg: ASbGncvx0mB2O6HUWnUIcYGM/vxPIbMbtxGUWGIoBmi2A8BEG0zfk+Fbd2sEtf377b9
 H3ocd1mWfWlokVN5oOD/knvkPki1tH0Js2SBP0ATLZPuzzPp8sF6ikmeIASHl/5phwcN966S+7p
 0ZLTp4J1IoQzcFDXsyXrnz3QePHIDeoivjmsWR0o4S5aCqgOyG3TZiuKp6ZsUKGPhodd39+Jj84
 7mI504m5umF1PBAemq2fkaG6ToZhnxUC7yZnS5/2P2qArXwhcHdd1autH7xUxVbopgHizfuR2tW
 F4e49swlHgZ+88TOBw==
X-Google-Smtp-Source: AGHT+IFE/kl630nsIJKbeJTEz1YID3L7V8nEtd7jFLolHOehN4af1XD8EkTKpbSdWOzbLak1Pelf9g==
X-Received: by 2002:a05:6e02:170e:b0:3ab:8f76:bcfd with SMTP id
 e9e14a558f8ab-3c2d5919d39mr562692055ab.20.1736174006140; 
 Mon, 06 Jan 2025 06:33:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
Date: Mon,  6 Jan 2025 07:32:13 -0700
Message-Id: <20250106143229.3023771-18-sjg@chromium.org>
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

 arch/arm/cpu/armv8/sec_firmware.c  | 12 +++++-----
 arch/arm/mach-k3/r5/sysfw-loader.c | 11 +++++++++-
 arch/x86/lib/bootm.c               |  7 ++++--
 boot/image-fit.c                   | 35 +++++++++++-------------------
 common/spl/spl_fit.c               |  8 ++++---
 common/splash_source.c             | 11 ++++------
 include/image.h                    | 20 +++++++++++++++--
 tools/Makefile                     |  3 ++-
 tools/image-host.c                 | 23 ++++++++++----------
 9 files changed, 74 insertions(+), 56 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index b7c73f288bd..e768859acfb 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -83,10 +83,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 {
 	phys_addr_t sec_firmware_loadable_addr = 0;
 	int conf_node_off, ld_node_off, images;
-	const void *data;
-	size_t size;
-	ulong load;
 	const char *name, *str, *type;
+	ulong load;
 	int len;
 
 	conf_node_off = fit_conf_get_node(sec_firmware_img, NULL);
@@ -114,6 +112,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 
 	for (str = name; str && ((str - name) < len);
 	     str = strchr(str, '\0') + 1) {
+		struct abuf buf;
+
 		printf("%s: '%s'\n", type, str);
 		ld_node_off = fdt_subnode_offset(sec_firmware_img, images, str);
 		if (ld_node_off < 0) {
@@ -129,7 +129,7 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 		}
 
 		if (fit_image_get_emb_data(sec_firmware_img, ld_node_off,
-					   &data, &size)) {
+					   &buf)) {
 			printf("SEC Loadable: Can't get subimage data/size");
 			return -ENOENT;
 		}
@@ -147,9 +147,9 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
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
index c323d2f78f8..1895fb385a5 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -110,12 +110,21 @@ static int fit_get_data_by_name(const void *fit, int images, const char *name,
 				const void **addr, size_t *size)
 {
 	int node_offset;
+	struct abuf buf;
+	int ret;
 
 	node_offset = fdt_subnode_offset(fit, images, name);
 	if (node_offset < 0)
 		return -ENOENT;
 
-	return fit_image_get_emb_data(fit, node_offset, addr, size);
+	ret = fit_image_get_emb_data(fit, node_offset, &buf);
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
index 3305560aa06..16980c15081 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -106,13 +106,16 @@ static int boot_prep_linux(struct bootm_headers *images)
 		is_zimage = 1;
 #if defined(CONFIG_FIT)
 	} else if (images->fit_uname_os && is_zimage) {
+		struct abuf buf;
+
 		ret = fit_image_get_emb_data(images->fit_hdr_os,
-					     images->fit_noffset_os,
-					     (const void **)&data, &len);
+					     images->fit_noffset_os, &buf);
 		if (ret) {
 			puts("Can't get image data/size!\n");
 			goto error;
 		}
+		data = buf.data;
+		len = buf.size;
 		is_zimage = 1;
 #endif
 	}
diff --git a/boot/image-fit.c b/boot/image-fit.c
index e9653452eae..e9b4152eb84 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -33,6 +33,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
 
+#include <abuf.h>
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
@@ -901,34 +902,20 @@ int fit_image_get_entry(const void *fit, int noffset, ulong *entry)
 	return fit_image_get_address(fit, noffset, FIT_ENTRY_PROP, entry);
 }
 
-/**
- * fit_image_get_emb_data - get data property and its size for a given component image node
- * @fit: pointer to the FIT format image header
- * @noffset: component image node offset
- * @data: double pointer to void, will hold data property's data address
- * @size: pointer to size_t, will hold data property's data size
- *
- * fit_image_get_emb_data() finds data property in a given component image node.
- * If the property is found its data start address and size are returned to
- * the caller.
- *
- * returns:
- *     0, on success
- *     -1, on failure
- */
-int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
-			   size_t *size)
+int fit_image_get_emb_data(const void *fit, int noffset, struct abuf *buf)
 {
+	const void *data;
 	int len;
 
-	*data = fdt_getprop(fit, noffset, FIT_DATA_PROP, &len);
-	if (*data == NULL) {
+	data = fdt_getprop(fit, noffset, FIT_DATA_PROP, &len);
+	if (!data) {
 		fit_get_debug(fit, noffset, FIT_DATA_PROP, len);
-		*size = 0;
+		abuf_init(buf);
 		return -1;
 	}
 
-	*size = len;
+	abuf_init_const(buf, data, len);
+
 	return 0;
 }
 
@@ -1074,7 +1061,11 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 			*size = len;
 		}
 	} else {
-		ret = fit_image_get_emb_data(fit, noffset, data, size);
+		struct abuf buf;
+
+		ret = fit_image_get_emb_data(fit, noffset, &buf);
+		*data = buf.data;
+		*size = buf.size;
 	}
 
 	return ret;
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 097c731d9a3..172153b75c2 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -214,7 +214,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	void *src;
 	ulong overhead;
 	uint8_t image_comp = -1, type = -1;
-	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
 
@@ -281,14 +280,17 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		      src_ptr, offset, (unsigned long)length);
 		src = src_ptr + overhead;
 	} else {
+		struct abuf buf;
+
 		/* Embedded data */
-		if (fit_image_get_emb_data(fit, node, &data, &length)) {
+		if (fit_image_get_emb_data(fit, node, &buf)) {
 			puts("Cannot get image data/size\n");
 			return -ENOENT;
 		}
+		src = buf.data;
+		length = buf.size;
 		debug("Embedded data: dst=%lx, size=%lx\n", load_addr,
 		      (unsigned long)length);
-		src = (void *)data;	/* cast away const */
 	}
 
 	if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
diff --git a/common/splash_source.c b/common/splash_source.c
index 5ac32a2f995..37648b8b9f3 100644
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
@@ -396,12 +395,10 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 
 	/* Extract the splash data from FIT */
 	/* 1. Test if splash is in FIT internal data. */
-	if (!fit_image_get_emb_data(fit_header, node_offset,
-				    &internal_splash_data,
-				    &internal_splash_size))
-		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data, internal_splash_size);
+	if (!fit_image_get_emb_data(fit_header, node_offset, &buf)) {
+		memmove((void *)(uintptr_t)bmp_load_addr, buf.data, buf.size);
 	/* 2. Test if splash is in FIT external data with fixed position. */
-	else if (!fit_image_get_data_position(fit_header, node_offset, &external_splash_addr))
+	} else if (!fit_image_get_data_position(fit_header, node_offset, &external_splash_addr))
 		is_splash_external = true;
 	/* 3. Test if splash is in FIT external data with offset. */
 	else if (!fit_image_get_data_offset(fit_header, node_offset, &external_splash_addr)) {
diff --git a/include/image.h b/include/image.h
index 12f52919812..29ac7a69ae9 100644
--- a/include/image.h
+++ b/include/image.h
@@ -20,6 +20,7 @@
 #include <stdbool.h>
 
 /* Define this to avoid #ifdefs later on */
+struct abuf;
 struct fdt_region;
 
 #ifdef USE_HOSTCC
@@ -1196,8 +1197,23 @@ int fit_image_get_type(const void *fit, int noffset, uint8_t *type);
 int fit_image_get_comp(const void *fit, int noffset, uint8_t *comp);
 int fit_image_get_load(const void *fit, int noffset, ulong *load);
 int fit_image_get_entry(const void *fit, int noffset, ulong *entry);
-int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
-			   size_t *size);
+
+/**
+ * fit_image_get_emb_data() - get embedded data for a component-image node
+ * @fit: pointer to the FIT format image header
+ * @noffset: component image node offset
+ * @buf: returns data (inited by this function)
+ *
+ * fit_image_get_emb_data() finds data property in a given component image node.
+ * If the property is found its data start address and size are returned to
+ * the caller.
+ *
+ * returns:
+ *     0, on success
+ *     -1, on failure
+ */
+int fit_image_get_emb_data(const void *fit, int noffset, struct abuf *buf);
+
 int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset);
 int fit_image_get_data_position(const void *fit, int noffset,
 				int *data_position);
diff --git a/tools/Makefile b/tools/Makefile
index ee08a9675df..d0adfe1f58d 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -71,7 +71,8 @@ ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_FWU_MDATA_GPT_BLK),)
 hostprogs-y += file2include
 endif
 
-FIT_OBJS-y := fit_common.o fit_image.o image-host.o generated/boot/image-fit.o
+FIT_OBJS-y := fit_common.o fit_image.o image-host.o generated/boot/image-fit.o \
+	generated/lib/abuf.o
 FIT_SIG_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := image-sig-host.o generated/boot/image-fit-sig.o
 FIT_CIPHER_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := generated/boot/image-cipher.o
 
diff --git a/tools/image-host.c b/tools/image-host.c
index 007a94f72d5..d428f655591 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -9,6 +9,7 @@
  */
 
 #include "mkimage.h"
+#include <abuf.h>
 #include <bootm.h>
 #include <fdt_region.h>
 #include <image.h>
@@ -509,7 +510,7 @@ int fit_image_write_cipher(void *fit, int image_noffset, int noffset,
 static int
 fit_image_process_cipher(const char *keydir, void *keydest, void *fit,
 			 const char *image_name, int image_noffset,
-			 int node_noffset, const void *data, size_t size,
+			 int node_noffset, struct abuf *buf,
 			 const char *cmdname)
 {
 	struct image_cipher_info info;
@@ -524,7 +525,7 @@ fit_image_process_cipher(const char *keydir, void *keydest, void *fit,
 	if (ret)
 		goto out;
 
-	ret = info.cipher->encrypt(&info, data, size,
+	ret = info.cipher->encrypt(&info, buf->data, buf->size,
 				    &data_ciphered, &data_ciphered_len);
 	if (ret)
 		goto out;
@@ -546,7 +547,7 @@ fit_image_process_cipher(const char *keydir, void *keydest, void *fit,
 	}
 
 	ret = fit_image_write_cipher(fit, image_noffset, node_noffset,
-				     data, size,
+				     buf->data, buf->size,
 				     data_ciphered, data_ciphered_len);
 
  out:
@@ -562,9 +563,8 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 			  const char *cmdname)
 {
 	const char *image_name;
-	const void *data;
-	size_t size;
 	int cipher_node_offset, len;
+	struct abuf buf;
 
 	/* Get image name */
 	image_name = fit_get_name(fit, image_noffset, NULL);
@@ -574,7 +574,7 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	}
 
 	/* Get image data and data length */
-	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
+	if (fit_image_get_emb_data(fit, image_noffset, &buf)) {
 		fprintf(stderr, "Can't get image data/size\n");
 		return -1;
 	}
@@ -605,7 +605,7 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	if (!IMAGE_ENABLE_ENCRYPT || !keydir)
 		return 0;
 	return fit_image_process_cipher(keydir, keydest, fit, image_name,
-		image_noffset, cipher_node_offset, data, size, cmdname);
+		image_noffset, cipher_node_offset, &buf, cmdname);
 }
 
 /**
@@ -649,12 +649,11 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 		const char *cmdname, const char* algo_name)
 {
 	const char *image_name;
-	const void *data;
-	size_t size;
+	struct abuf buf;
 	int noffset;
 
 	/* Get image data and data length */
-	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
+	if (fit_image_get_emb_data(fit, image_noffset, &buf)) {
 		fprintf(stderr, "Can't get image data/size\n");
 		return -1;
 	}
@@ -677,12 +676,12 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 		if (!strncmp(node_name, FIT_HASH_NODENAME,
 			     strlen(FIT_HASH_NODENAME))) {
 			ret = fit_image_process_hash(fit, image_name, noffset,
-						data, size);
+						     buf.data, buf.size);
 		} else if (IMAGE_ENABLE_SIGN && (keydir || keyfile) &&
 			   !strncmp(node_name, FIT_SIG_NODENAME,
 				strlen(FIT_SIG_NODENAME))) {
 			ret = fit_image_process_sig(keydir, keyfile, keydest,
-				fit, image_name, noffset, data, size,
+				fit, image_name, noffset, buf.data, buf.size,
 				comment, require_keys, engine_id, cmdname,
 				algo_name);
 		}
-- 
2.34.1

