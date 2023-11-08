Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FE0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B00E8773B;
	Wed,  8 Nov 2023 17:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/SxUnw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D518749D; Wed,  8 Nov 2023 17:49:20 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3712D876BE
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d9a58f5f33dso7313476276.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462152; x=1700066952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHG1+1cNJMH7DiUj903ORAO8CSZRXA090MQSd4mQk1s=;
 b=C/SxUnw2mrzItIman3sj+AYW9szRmNFuxi0WBXkcx1dS4DQCkQxky+xtg5hR1kdLoo
 FJcT0u325pNcQM5rgI0J84dx7KmsNPAFw6xMl5KY+iPanQkIx5g3O+lZDt2gBgTHizNf
 2vxRMnDAMZEHUOPMuf7A/+U0jUb6RXTiT6KRCs0yrxqd10E750rpB/A5/HlZ8xeyKqfB
 7JHp72mH65W/QTRQO8aPPw2a/0AJWzqNIMW5J8TyeT9RXDqKoeBXHdx7xkebRFOXVl4+
 SRHh1d77gVL/0JYmXyqKtVuaQXAfXed6w0mk9dkGPNsU2imjIyMGZQQja58oibzaquuW
 e1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462152; x=1700066952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHG1+1cNJMH7DiUj903ORAO8CSZRXA090MQSd4mQk1s=;
 b=h9fJC0JXmm24w6Xcc3WRsTopTr2oqySYyXWh9GxUtjNN87UdiCK3a2CYqO8SFb3MxF
 r+NhxLa3V/k/45VabS4LkFLOg5+fx4VDgQTTvZOfTC5OEiZ5yod6lVjAO/4AoA98kcf1
 omX94qL5vEm0YFbAmndnRb+ABMl1bePDaVLCsnH4f9YiL9ssg7LFfBhKJdsui2zL9rF0
 j3X2VASgRL3la+yDy4LLIamfwMuwqaxaq9Xvtoe/187uUbcaYNWmp7MJjnsEWcqFH2/l
 fD1YqP/mCMdcjoYvMasvy+OBuyN3b7v45JwgiYR906gmAr6m8OsCpGx6xpG0rWSwSNBG
 gROA==
X-Gm-Message-State: AOJu0Yx0FSaZ+d8Z99Of2qwaH7Pfn0egunrXNMU70tdXSo088tDce3pS
 XX4N8VMO2luiTZttTzOBkvI=
X-Google-Smtp-Source: AGHT+IEKZUQyDVVFEfU8vwzEJh7/Plzxi1JOTsnVOujYr1r2XJSdcZGP7lqy+M50l8jhWO6S26D+3g==
X-Received: by 2002:a25:ad92:0:b0:d9a:5021:4f34 with SMTP id
 z18-20020a25ad92000000b00d9a50214f34mr2258867ybi.15.1699462151888; 
 Wed, 08 Nov 2023 08:49:11 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 k9-20020a05621414e900b006263a9e7c63sm1234222qvw.104.2023.11.08.08.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:11 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
Subject: [PATCH v7 08/26] spl: Refactor spl_load_info->read to use units of
 bytes
Date: Wed,  8 Nov 2023 11:48:40 -0500
Message-Id: <20231108164858.3497420-9-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

Simplify things a bit for callers of spl_load_info->read by refactoring it
to use units of bytes instead of bl_len. This generally simplifies the
logic, as MMC is the only loader which actually works in sectors. It will
also allow further refactoring to remove the special-case handling of
filename.  spl_load_legacy_img already works in units of bytes (oops) so it
doesn't need to be changed.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v7:
- Reword documentation for spl_load_info

Changes in v6:
- New

 arch/arm/mach-imx/spl_imx_romapi.c | 16 +++-------
 common/spl/spl_fit.c               | 51 +++++++++++++++---------------
 common/spl/spl_imx_container.c     | 45 +++++++++++---------------
 common/spl/spl_mmc.c               | 24 ++++++++------
 common/spl/spl_nand.c              |  8 ++---
 include/spl.h                      | 18 +++++++----
 test/image/spl_load_os.c           | 13 ++++----
 7 files changed, 82 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 93d48e56aca..d7f6cb4b5ba 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -53,16 +53,10 @@ static int is_boot_from_stream_device(u32 boot)
 }
 
 static ulong spl_romapi_read_seekable(struct spl_load_info *load,
-				      ulong sector, ulong count,
+				      ulong offset, ulong byte,
 				      void *buf)
 {
-	u32 pagesize = *(u32 *)load->priv;
-	ulong byte = count * pagesize;
-	u32 offset;
-
-	offset = sector * pagesize;
-
-	return spl_romapi_raw_seekable_read(offset, byte, buf) / pagesize;
+	return spl_romapi_raw_seekable_read(offset, byte, buf);
 }
 
 static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
@@ -109,8 +103,7 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 		memset(&load, 0, sizeof(load));
 		load.bl_len = pagesize;
 		load.read = spl_romapi_read_seekable;
-		load.priv = &pagesize;
-		return spl_load_simple_fit(spl_image, &load, offset / pagesize, header);
+		return spl_load_simple_fit(spl_image, &load, offset, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
@@ -118,9 +111,8 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 		memset(&load, 0, sizeof(load));
 		load.bl_len = pagesize;
 		load.read = spl_romapi_read_seekable;
-		load.priv = &pagesize;
 
-		ret = spl_load_imx_container(spl_image, &load, offset / pagesize);
+		ret = spl_load_imx_container(spl_image, &load, offset);
 	} else {
 		/* TODO */
 		puts("Can't support legacy image\n");
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 6084ead0919..ce7ef0efd0d 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -180,7 +180,7 @@ static int get_aligned_image_offset(struct spl_load_info *info, int offset)
 	if (info->filename)
 		return offset & ~(ARCH_DMA_MINALIGN - 1);
 
-	return offset / info->bl_len;
+	return ALIGN_DOWN(offset, info->bl_len);
 }
 
 static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
@@ -205,7 +205,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 	if (info->filename)
 		return data_size;
 
-	return (data_size + info->bl_len - 1) / info->bl_len;
+	return ALIGN(data_size, info->bl_len);
 }
 
 /**
@@ -222,7 +222,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *
  * Return:	0 on success or a negative error number.
  */
-static int load_simple_fit(struct spl_load_info *info, ulong sector,
+static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			   const struct spl_fit_info *ctx, int node,
 			   struct spl_image_info *image_info)
 {
@@ -234,7 +234,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 	void *load_ptr;
 	void *src;
 	ulong overhead;
-	int nr_sectors;
 	uint8_t image_comp = -1, type = -1;
 	const void *data;
 	const void *fit = ctx->fit;
@@ -291,11 +290,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 		length = len;
 
 		overhead = get_aligned_image_overhead(info, offset);
-		nr_sectors = get_aligned_image_size(info, length, offset);
+		size = get_aligned_image_size(info, length, offset);
 
 		if (info->read(info,
-			       sector + get_aligned_image_offset(info, offset),
-			       nr_sectors, src_ptr) != nr_sectors)
+			       fit_offset +
+			       get_aligned_image_offset(info, offset), size,
+			       src_ptr) != size)
 			return -EIO;
 
 		debug("External data: dst=%p, offset=%x, size=%lx\n",
@@ -380,7 +380,7 @@ __weak int board_spl_fit_append_fdt_skip(const char *name)
 }
 
 static int spl_fit_append_fdt(struct spl_image_info *spl_image,
-			      struct spl_load_info *info, ulong sector,
+			      struct spl_load_info *info, ulong offset,
 			      const struct spl_fit_info *ctx)
 {
 	struct spl_image_info image_info;
@@ -414,7 +414,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 		spl_image->fdt_addr = map_sysmem(image_info.load_addr, size);
 		memcpy(spl_image->fdt_addr, gd->fdt_blob, size);
 	} else {
-		ret = load_simple_fit(info, sector, ctx, node, &image_info);
+		ret = load_simple_fit(info, offset, ctx, node, &image_info);
 		if (ret < 0)
 			return ret;
 
@@ -465,7 +465,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 					      __func__);
 			}
 			image_info.load_addr = (ulong)tmpbuffer;
-			ret = load_simple_fit(info, sector, ctx, node,
+			ret = load_simple_fit(info, offset, ctx, node,
 					      &image_info);
 			if (ret < 0)
 				break;
@@ -642,7 +642,7 @@ static int spl_fit_upload_fpga(struct spl_fit_info *ctx, int node,
 }
 
 static int spl_fit_load_fpga(struct spl_fit_info *ctx,
-			     struct spl_load_info *info, ulong sector)
+			     struct spl_load_info *info, ulong offset)
 {
 	int node, ret;
 
@@ -657,7 +657,7 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 	warn_deprecated("'fpga' property in config node. Use 'loadables'");
 
 	/* Load the image and set up the fpga_image structure */
-	ret = load_simple_fit(info, sector, ctx, node, &fpga_image);
+	ret = load_simple_fit(info, offset, ctx, node, &fpga_image);
 	if (ret) {
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
@@ -667,11 +667,10 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 }
 
 static int spl_simple_fit_read(struct spl_fit_info *ctx,
-			       struct spl_load_info *info, ulong sector,
+			       struct spl_load_info *info, ulong offset,
 			       const void *fit_header)
 {
 	unsigned long count, size;
-	int sectors;
 	void *buf;
 
 	/*
@@ -690,13 +689,13 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 * For FIT with data embedded, data is loaded as part of FIT image.
 	 * For FIT with external data, data is not loaded in this step.
 	 */
-	sectors = get_aligned_image_size(info, size, 0);
-	buf = board_spl_fit_buffer_addr(size, sectors, info->bl_len);
+	size = get_aligned_image_size(info, size, 0);
+	buf = board_spl_fit_buffer_addr(size, size, 1);
 
-	count = info->read(info, sector, sectors, buf);
+	count = info->read(info, offset, size, buf);
 	ctx->fit = buf;
-	debug("fit read sector %lx, sectors=%d, dst=%p, count=%lu, size=0x%lx\n",
-	      sector, sectors, buf, count, size);
+	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
+	      offset, size, buf, count);
 
 	return (count == 0) ? -EIO : 0;
 }
@@ -728,7 +727,7 @@ static int spl_simple_fit_parse(struct spl_fit_info *ctx)
 }
 
 int spl_load_simple_fit(struct spl_image_info *spl_image,
-			struct spl_load_info *info, ulong sector, void *fit)
+			struct spl_load_info *info, ulong offset, void *fit)
 {
 	struct spl_image_info image_info;
 	struct spl_fit_info ctx;
@@ -737,7 +736,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	int index = 0;
 	int firmware_node;
 
-	ret = spl_simple_fit_read(&ctx, info, sector, fit);
+	ret = spl_simple_fit_read(&ctx, info, offset, fit);
 	if (ret < 0)
 		return ret;
 
@@ -752,7 +751,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		return ret;
 
 	if (IS_ENABLED(CONFIG_SPL_FPGA))
-		spl_fit_load_fpga(&ctx, info, sector);
+		spl_fit_load_fpga(&ctx, info, offset);
 
 	/*
 	 * Find the U-Boot image using the following search order:
@@ -782,7 +781,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	}
 
 	/* Load the image and set up the spl_image structure */
-	ret = load_simple_fit(info, sector, &ctx, node, spl_image);
+	ret = load_simple_fit(info, offset, &ctx, node, spl_image);
 	if (ret)
 		return ret;
 
@@ -800,7 +799,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	 * We allow this to fail, as the U-Boot image might embed its FDT.
 	 */
 	if (os_takes_devicetree(spl_image->os)) {
-		ret = spl_fit_append_fdt(spl_image, info, sector, &ctx);
+		ret = spl_fit_append_fdt(spl_image, info, offset, &ctx);
 		if (ret < 0 && spl_image->os != IH_OS_U_BOOT)
 			return ret;
 	}
@@ -823,7 +822,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			continue;
 
 		image_info.load_addr = 0;
-		ret = load_simple_fit(info, sector, &ctx, node, &image_info);
+		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
 		if (ret < 0) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
@@ -837,7 +836,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			debug("Loadable is %s\n", genimg_get_os_name(os_type));
 
 		if (os_takes_devicetree(os_type)) {
-			spl_fit_append_fdt(&image_info, info, sector, &ctx);
+			spl_fit_append_fdt(&image_info, info, offset, &ctx);
 			spl_image->fdt_addr = image_info.fdt_addr;
 		}
 
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 1cc51782766..ad89a99fb23 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -19,11 +19,10 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
 					  int image_index,
-					  u32 container_sector)
+					  ulong container_offset)
 {
 	struct boot_img_t *images;
-	ulong sector;
-	u32 sectors;
+	ulong offset, overhead, size;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -39,16 +38,14 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 		return NULL;
 	}
 
-	sectors = ALIGN(images[image_index].size, info->bl_len) /
-		info->bl_len;
-	sector = images[image_index].offset / info->bl_len +
-		container_sector;
+	size = ALIGN(images[image_index].size, info->bl_len);
+	offset = images[image_index].offset + container_offset;
 
-	debug("%s: container: %p sector: %lu sectors: %u\n", __func__,
-	      container, sector, sectors);
-	if (info->read(info, sector, sectors,
-		       map_sysmem(images[image_index].dst,
-				  images[image_index].size)) != sectors) {
+	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
+	      container, offset, size);
+	if (info->read(info, offset, size,
+		       map_sysmem(images[image_index].dst - overhead,
+				  images[image_index].size)) != size) {
 		printf("%s wrong\n", __func__);
 		return NULL;
 	}
@@ -62,15 +59,13 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 }
 
 static int read_auth_container(struct spl_image_info *spl_image,
-			       struct spl_load_info *info, ulong sector)
+			       struct spl_load_info *info, ulong offset)
 {
 	struct container_hdr *container = NULL;
 	u16 length;
-	u32 sectors;
 	int i, size, ret = 0;
 
 	size = ALIGN(CONTAINER_HDR_ALIGNMENT, info->bl_len);
-	sectors = size / info->bl_len;
 
 	/*
 	 * It will not override the ATF code, so safe to use it here,
@@ -80,9 +75,9 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	if (!container)
 		return -ENOMEM;
 
-	debug("%s: container: %p sector: %lu sectors: %u\n", __func__,
-	      container, sector, sectors);
-	if (info->read(info, sector, sectors, container) != sectors) {
+	debug("%s: container: %p offset: %lu size: %u\n", __func__,
+	      container, offset, size);
+	if (info->read(info, offset, size, container) != size) {
 		ret = -EIO;
 		goto end;
 	}
@@ -104,17 +99,15 @@ static int read_auth_container(struct spl_image_info *spl_image,
 
 	if (length > CONTAINER_HDR_ALIGNMENT) {
 		size = ALIGN(length, info->bl_len);
-		sectors = size / info->bl_len;
 
 		free(container);
 		container = malloc(size);
 		if (!container)
 			return -ENOMEM;
 
-		debug("%s: container: %p sector: %lu sectors: %u\n",
-		      __func__, container, sector, sectors);
-		if (info->read(info, sector, sectors, container) !=
-		    sectors) {
+		debug("%s: container: %p offset: %lu size: %u\n",
+		      __func__, container, offset, size);
+		if (info->read(info, offset, size, container) != size) {
 			ret = -EIO;
 			goto end;
 		}
@@ -129,7 +122,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	for (i = 0; i < container->num_images; i++) {
 		struct boot_img_t *image = read_auth_image(spl_image, info,
 							   container, i,
-							   sector);
+							   offset);
 
 		if (!image) {
 			ret = -EINVAL;
@@ -154,7 +147,7 @@ end:
 }
 
 int spl_load_imx_container(struct spl_image_info *spl_image,
-			   struct spl_load_info *info, ulong sector)
+			   struct spl_load_info *info, ulong offset)
 {
-	return read_auth_container(spl_image, info, sector);
+	return read_auth_container(spl_image, info, offset);
 }
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 3d7551a7dae..9f41ea648ce 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -62,12 +62,14 @@ static int mmc_load_legacy(struct spl_image_info *spl_image,
 	return 0;
 }
 
-static ulong h_spl_load_read(struct spl_load_info *load, ulong sector,
-			     ulong count, void *buf)
+static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+			     ulong size, void *buf)
 {
-	struct mmc *mmc = load->priv;
+	struct blk_desc *bd = load->priv;
+	lbaint_t sector = off >> bd->log2blksz;
+	lbaint_t count = size >> bd->log2blksz;
 
-	return blk_dread(mmc_get_blk_desc(mmc), sector, count, buf);
+	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
 static __maybe_unused unsigned long spl_mmc_raw_uboot_offset(int part)
@@ -105,21 +107,23 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
-		load.priv = mmc;
+		load.priv = bd;
 		load.filename = NULL;
-		load.bl_len = mmc->read_bl_len;
+		load.bl_len = bd->blksz;
 		load.read = h_spl_load_read;
-		ret = spl_load_simple_fit(spl_image, &load, sector, header);
+		ret = spl_load_simple_fit(spl_image, &load,
+					  sector << bd->log2blksz, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
-		load.priv = mmc;
+		load.priv = bd;
 		load.filename = NULL;
-		load.bl_len = mmc->read_bl_len;
+		load.bl_len = bd->blksz;
 		load.read = h_spl_load_read;
 
-		ret = spl_load_imx_container(spl_image, &load, sector);
+		ret = spl_load_imx_container(spl_image, &load,
+					     sector << bd->log2blksz);
 	} else {
 		ret = mmc_load_legacy(spl_image, bootdev, mmc, sector, header);
 	}
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 9a5a5ffa04a..1fcc89fa660 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -49,14 +49,12 @@ static ulong spl_nand_fit_read(struct spl_load_info *load, ulong offs,
 	ulong sector;
 
 	sector = *(int *)load->priv;
-	offs *= load->bl_len;
-	size *= load->bl_len;
 	offs = sector + nand_spl_adjust_offset(sector, offs - sector);
 	err = nand_spl_load_image(offs, size, dst);
 	if (err)
 		return 0;
 
-	return size / load->bl_len;
+	return size;
 }
 
 static ulong spl_nand_legacy_read(struct spl_load_info *load, ulong offs,
@@ -95,7 +93,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
-		return spl_load_simple_fit(spl_image, &load, offset / bl_len, header);
+		return spl_load_simple_fit(spl_image, &load, offset, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
@@ -104,7 +102,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
-		return spl_load_imx_container(spl_image, &load, offset / bl_len);
+		return spl_load_imx_container(spl_image, &load, offset);
 	} else if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT) &&
 		   image_get_magic(header) == IH_MAGIC) {
 		struct spl_load_info load;
diff --git a/include/spl.h b/include/spl.h
index 951e136b9ea..5a355e0a1e0 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -297,10 +297,12 @@ struct spl_load_info {
 	 * read() - Read from device
 	 *
 	 * @load: Information about the load state
-	 * @sector: Sector number to read from (each @load->bl_len bytes)
-	 * @count: Number of sectors to read
+	 * @offset: Offset to read from in bytes. This must be a multiple of
+	 *          @load->bl_len.
+	 * @count: Number of bytes to read. This must be a multiple of
+	 *         @load->bl_len.
 	 * @buf: Buffer to read into
-	 * @return number of sectors read, 0 on error
+	 * @return number of bytes read, 0 on error
 	 */
 	ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
 		      void *buf);
@@ -368,7 +370,8 @@ void *spl_load_simple_fit_fix_load(const void *fit);
  * spl_load_simple_fit() - Loads a fit image from a device.
  * @spl_image:	Image description to set up
  * @info:	Structure containing the information required to load data.
- * @sector:	Sector number where FIT image is located in the device
+ * @offset:	Offset where FIT image is located in the device. Must be aligned
+ *              to the device's bl_len.
  * @fdt:	Pointer to the copied FIT header.
  *
  * Reads the FIT image @sector in the device. Loads u-boot image to
@@ -376,7 +379,7 @@ void *spl_load_simple_fit_fix_load(const void *fit);
  * Returns 0 on success.
  */
 int spl_load_simple_fit(struct spl_image_info *spl_image,
-			struct spl_load_info *info, ulong sector, void *fdt);
+			struct spl_load_info *info, ulong offset, void *fdt);
 
 #define SPL_COPY_PAYLOAD_ONLY	1
 #define SPL_FIT_FOUND		2
@@ -402,13 +405,14 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
  * spl_load_imx_container() - Loads a imx container image from a device.
  * @spl_image:	Image description to set up
  * @info:	Structure containing the information required to load data.
- * @sector:	Sector number where container image is located in the device
+ * @sector:	Offset where container image is located in the device. Must be
+ *              aligned to the device block size.
  *
  * Reads the container image @sector in the device. Loads u-boot image to
  * specified load address.
  */
 int spl_load_imx_container(struct spl_image_info *spl_image,
-			   struct spl_load_info *info, ulong sector);
+			   struct spl_load_info *info, ulong offset);
 
 /* SPL common functions */
 void preloader_console_init(void);
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 49edf152d78..794cfad4e70 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -16,14 +16,13 @@ struct text_ctx {
 	int fd;
 };
 
-static ulong read_fit_image(struct spl_load_info *load, ulong sector,
-			    ulong count, void *buf)
+static ulong read_fit_image(struct spl_load_info *load, ulong offset,
+			    ulong size, void *buf)
 {
 	struct text_ctx *text_ctx = load->priv;
-	off_t offset, ret;
+	off_t ret;
 	ssize_t res;
 
-	offset = sector * load->bl_len;
 	ret = os_lseek(text_ctx->fd, offset, OS_SEEK_SET);
 	if (ret != offset) {
 		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
@@ -31,14 +30,14 @@ static ulong read_fit_image(struct spl_load_info *load, ulong sector,
 		return 0;
 	}
 
-	res = os_read(text_ctx->fd, buf, count * load->bl_len);
+	res = os_read(text_ctx->fd, buf, size);
 	if (res == -1) {
 		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
-		       count * load->bl_len, res, errno);
+		       size, res, errno);
 		return 0;
 	}
 
-	return count;
+	return size;
 }
 
 static int spl_test_load(struct unit_test_state *uts)
-- 
2.37.1

