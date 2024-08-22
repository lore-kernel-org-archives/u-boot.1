Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38681C5320E
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078BA889A7;
	Thu, 22 Aug 2024 15:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n/fl6P/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E6988A25; Thu, 22 Aug 2024 15:55:42 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A809188965
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-824d911b6c4so29267939f.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334938; x=1724939738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlDsPj9TM0qvwIVS/Y0tp/z0G47wwaaL3m5P8ajlmEw=;
 b=n/fl6P/XYHv54/T7calKLDLPqRo+C4KKfiyb7qossJugDiaGW0qc7cCKGuFyaAxkfp
 2MokQtD/V1y1zzlO3H/le9UXG+YUiL18RRipfzUUxVcd65IQU6KPHsBve+zO8OtZvba1
 ARWXxrvo7PMw5AlsgH/qo7Gc+BEfzLo2V9QQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334938; x=1724939738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlDsPj9TM0qvwIVS/Y0tp/z0G47wwaaL3m5P8ajlmEw=;
 b=rt7h5y7/ZYMrfVR6Ma9J6M4xmVKqgJoGrZoiMC7nYxXmXSiaHTqEMKiNCbYkn76ZaF
 DLskgbHcy6fNKDOPAXIexEahWET1nopzS3oZJfwlt6ZACFHKJKLWxwEGMbuJDRNTyeTT
 T7DNet2O/EOA43DQoEXrgo1CecyVerbS/4S8ID88xzwSBkeXIehJGE2BgYp4HhxTxwGV
 vE6FyaEmuKWfb55+m+xoaFXcA+dVoLP3sXIk+spfBsFCwVQE9d6qAEZT0YFDpEvWyviS
 vaxUsHmqQ8uNImDH77sbaf/Ry1fr9cezwP3Ts4969NNKEhEcw/XRhUlOTR7ZKxbYNzIq
 Lyzw==
X-Gm-Message-State: AOJu0YyT/3Hl3Cg1eJUlews3ob/P6wM2iV8Vk4FJR+DZG5K5L8GlOjaJ
 HFja8enNiJoK5dd/YpKNZ5HAmyv1tQPc9C6Y+VEJiYizsuGn9qyBWXkVYX3sIhUwWOQftlo0bMI
 =
X-Google-Smtp-Source: AGHT+IGWUWH/2eq/D7V6MpiXaoY+ICHvCA8tIGCqeHDZ8yrY+Yu6CLhvrythYnhk2JIhhf/3ncNQlQ==
X-Received: by 2002:a05:6e02:1fc4:b0:381:40be:4ce6 with SMTP id
 e9e14a558f8ab-39d74b6d439mr25073485ab.11.1724334938091; 
 Thu, 22 Aug 2024 06:55:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v4 13/14] spl: Create a function to init spl_load_info
Date: Thu, 22 Aug 2024 07:55:02 -0600
Message-Id: <20240822135503.2363706-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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

Rather than having every caller set this up individually, create a
common init function. This allows new fields to be added without the
risk of them being left uninited.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

(no changes since v3)

Changes in v3:
- Rebase on -next

 arch/arm/mach-imx/spl_imx_romapi.c  | 14 ++-------
 arch/arm/mach-sunxi/spl_spi_sunxi.c |  3 +-
 arch/sandbox/cpu/spl.c              |  5 ++--
 common/spl/spl_blk_fs.c             |  9 ++----
 common/spl/spl_ext.c                |  3 +-
 common/spl/spl_fat.c                | 10 +++----
 common/spl/spl_mmc.c                |  4 +--
 common/spl/spl_nand.c               |  4 +--
 common/spl/spl_net.c                |  3 +-
 common/spl/spl_nor.c                |  6 ++--
 common/spl/spl_ram.c                |  3 +-
 common/spl/spl_semihosting.c        |  4 +--
 common/spl/spl_spi.c                |  4 +--
 common/spl/spl_ymodem.c             |  4 +--
 drivers/usb/gadget/f_sdp.c          |  8 ++----
 include/spl.h                       | 44 ++++++++++++++++++++---------
 test/image/spl_load.c               |  4 +--
 test/image/spl_load_os.c            |  1 +
 18 files changed, 57 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index bdaea439d7f..3982f4cca18 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -108,18 +108,13 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) && image_get_magic(header) == FDT_MAGIC) {
 		struct spl_load_info load;
 
-		memset(&load, 0, sizeof(load));
-		spl_set_bl_len(&load, pagesize);
-		load.read = spl_romapi_read_seekable;
+		spl_load_init(&load, spl_romapi_read_seekable, NULL, pagesize);
 		return spl_load_simple_fit(spl_image, &load, offset, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
-		memset(&load, 0, sizeof(load));
-		spl_set_bl_len(&load, pagesize);
-		load.read = spl_romapi_read_seekable;
-
+		spl_load_init(&load, spl_romapi_read_seekable, NULL, pagesize);
 		ret = spl_load_imx_container(spl_image, &load, offset);
 	} else {
 		/* TODO */
@@ -341,10 +336,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 		ss.end = p;
 		ss.pagesize = pagesize;
 
-		memset(&load, 0, sizeof(load));
-		spl_set_bl_len(&load, 1);
-		load.read = spl_romapi_read_stream;
-		load.priv = &ss;
+		spl_load_init(&load, spl_romapi_read_stream, &ss, 1);
 
 		return spl_load_simple_fit(spl_image, &load, (ulong)phdr, phdr);
 	}
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index d7abdc2e401..5f72e809952 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -390,8 +390,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT image\n");
-		spl_set_bl_len(&load, 1);
-		load.read = spi_load_read;
+		spl_load_init(&load, spi_load_read, NULL, 1);
 		ret = spl_load_simple_fit(spl_image, &load,
 					  load_offset, header);
 	} else {
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index bcb1ca10a51..cc46965b73b 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -221,9 +221,8 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
 	int ret;
 	int fd;
 
-	memset(&load, '\0', sizeof(load));
-	spl_set_bl_len(&load, IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) ? 512 : 1);
-	load.read = read_fit_image;
+	spl_load_init(&load, read_fit_image, &load_ctx,
+		      IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) ? 512 : 1);
 
 	ret = sandbox_find_next_phase(fname, maxlen, true);
 	if (ret) {
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index bc551c5c074..bbf90a9741e 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -80,11 +80,8 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 		return ret;
 	}
 
-	load.read = spl_fit_read;
-	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
-		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
-	else
-		spl_set_bl_len(&load, 1);
-	load.priv = &dev;
+	spl_load_init(&load, spl_fit_read, &dev,
+		      IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN) ?
+		      ARCH_DMA_MINALIGN : 1);
 	return spl_load(spl_image, bootdev, &load, filesize, 0);
 }
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 76f49a5a8a6..c5478820a9b 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -51,8 +51,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 		goto end;
 	}
 
-	spl_set_bl_len(&load, 1);
-	load.read = spl_fit_read;
+	spl_load_init(&load, spl_fit_read, NULL, 1);
 	err = spl_load(spl_image, bootdev, &load, filelen, 0);
 
 end:
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index bd8aab253a9..fce451b7664 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -83,12 +83,10 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 		size = 0;
 	}
 
-	load.read = spl_fit_read;
-	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
-		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
-	else
-		spl_set_bl_len(&load, 1);
-	load.priv = (void *)filename;
+	spl_load_init(&load, spl_fit_read, (void *)filename,
+		      IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN) ?
+		      ARCH_DMA_MINALIGN : 1);
+
 	err = spl_load(spl_image, bootdev, &load, size, 0);
 
 end:
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 887ea760b84..3fd81608e9f 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -46,9 +46,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 	struct blk_desc *bd = mmc_get_blk_desc(mmc);
 	struct spl_load_info load;
 
-	load.priv = bd;
-	spl_set_bl_len(&load, bd->blksz);
-	load.read = h_spl_load_read;
+	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
 	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (ret) {
 		puts("mmc_load_image_raw_sector: mmc block read error\n");
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 5631fa6d563..22883f4e8b9 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -71,9 +71,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 {
 	struct spl_load_info load;
 
-	load.priv = &offset;
-	spl_set_bl_len(&load, 1);
-	load.read = spl_nand_read;
+	spl_load_init(&load, spl_nand_read, &offset, 1);
 	return spl_load(spl_image, bootdev, &load, 0, offset);
 }
 
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index be7278bb933..2be7b73ed35 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -47,8 +47,7 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 		return rv;
 	}
 
-	spl_set_bl_len(&load, 1);
-	load.read = spl_net_load_read;
+	spl_load_init(&load, spl_net_load_read, NULL, 1);
 	return spl_load(spl_image, bootdev, &load, 0, 0);
 }
 #endif
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index ed76b5e1293..1021d933999 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -49,8 +49,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 			int ret;
 
 			debug("Found FIT\n");
-			spl_set_bl_len(&load, 1);
-			load.read = spl_nor_load_read;
+			spl_load_init(&load, spl_nor_load_read, NULL, 1);
 
 			ret = spl_load_simple_fit(spl_image, &load,
 						  CONFIG_SYS_OS_BASE,
@@ -93,8 +92,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 	 * Load real U-Boot from its location in NOR flash to its
 	 * defined location in SDRAM
 	 */
-	spl_set_bl_len(&load, 1);
-	load.read = spl_nor_load_read;
+	spl_load_init(&load, spl_nor_load_read, NULL, 1);
 	return spl_load(spl_image, bootdev, &load, 0, spl_nor_get_uboot_base());
 }
 SPL_LOAD_IMAGE_METHOD("NOR", 0, BOOT_DEVICE_NOR, spl_nor_load_image);
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 5a23841f698..71b7a8374bb 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -69,8 +69,7 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
-		spl_set_bl_len(&load, 1);
-		load.read = spl_ram_load_read;
+		spl_load_init(&load, spl_ram_load_read, NULL, 1);
 		ret = spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 2047248f39b..f36863fe48d 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -43,9 +43,7 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 	}
 	len = ret;
 
-	load.read = smh_fit_read;
-	spl_set_bl_len(&load, 1);
-	load.priv = &fd;
+	spl_load_init(&load, smh_fit_read, &fd, 1);
 	ret = spl_load(spl_image, bootdev, &load, len, 0);
 	if (ret)
 		log_debug("could not read %s: %d\n", filename, ret);
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 8ab4803f7c4..691a431a926 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -77,9 +77,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		return -ENODEV;
 	}
 
-	load.priv = flash;
-	spl_set_bl_len(&load, 1);
-	load.read = spl_spi_fit_read;
+	spl_load_init(&load, spl_spi_fit_read, flash, 1);
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (spl_start_uboot()) {
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 4c7222af612..2be957134c1 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -132,11 +132,9 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
 		struct ymodem_fit_info info;
 
 		debug("Found FIT\n");
-		load.priv = (void *)&info;
-		spl_set_bl_len(&load, 1);
+		spl_load_init(&load, ymodem_read_fit, (void *)&info, 1);
 		info.buf = buf;
 		info.image_read = BUF_SIZE;
-		load.read = ymodem_read_fit;
 		ret = spl_load_simple_fit(spl_image, &load, 0, (void *)buf);
 		size = info.image_read;
 
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 514c097591b..5d62eb475d0 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -842,9 +842,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 				struct spl_load_info load;
 
 				debug("Found FIT\n");
-				load.priv = header;
-				spl_set_bl_len(&load, 1);
-				load.read = sdp_load_read;
+				spl_load_init(&load, sdp_load_read, header, 1);
 				spl_load_simple_fit(spl_image, &load, 0,
 						    header);
 
@@ -855,9 +853,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 			    valid_container_hdr((void *)header)) {
 				struct spl_load_info load;
 
-				load.priv = header;
-				spl_set_bl_len(&load, 1);
-				load.read = sdp_load_read;
+				spl_load_init(&load, sdp_load_read, header, 1);
 				spl_load_imx_container(spl_image, &load, 0);
 				return SDP_EXIT;
 			}
diff --git a/include/spl.h b/include/spl.h
index fb26e3f5537..de808ccd413 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -282,28 +282,32 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
 #endif
 }
 
+struct spl_load_info;
+
+/**
+ * spl_load_reader() - Read from device
+ *
+ * @load: Information about the load state
+ * @offset: Offset to read from in bytes. This must be a multiple of
+ *          @load->bl_len.
+ * @count: Number of bytes to read. This must be a multiple of
+ *         @load->bl_len.
+ * @buf: Buffer to read into
+ * @return number of bytes read, 0 on error
+ */
+typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
+				 ulong count, void *buf);
+
 /**
  * Information required to load data from a device
  *
+ * @read: Function to call to read from the device
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
- * @read: Function to call to read from the device
  */
 struct spl_load_info {
+	spl_load_reader read;
 	void *priv;
-	/**
-	 * read() - Read from device
-	 *
-	 * @load: Information about the load state
-	 * @offset: Offset to read from in bytes. This must be a multiple of
-	 *          @load->bl_len.
-	 * @count: Number of bytes to read. This must be a multiple of
-	 *         @load->bl_len.
-	 * @buf: Buffer to read into
-	 * @return number of bytes read, 0 on error
-	 */
-	ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
-		      void *buf);
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	int bl_len;
 #endif
@@ -328,6 +332,18 @@ static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 #endif
 }
 
+/**
+ * spl_load_init() - Set up a new spl_load_info structure
+ */
+static inline void spl_load_init(struct spl_load_info *load,
+				 spl_load_reader h_read, void *priv,
+				 uint bl_len)
+{
+	load->read = h_read;
+	load->priv = priv;
+	spl_set_bl_len(load, bl_len);
+}
+
 /*
  * We need to know the position of U-Boot in memory so we can jump to it. We
  * allow any U-Boot binary to be used (u-boot.bin, u-boot-nodtb.bin,
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 7cbad40ea0c..3b6206955d3 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -343,9 +343,7 @@ static int spl_test_image(struct unit_test_state *uts, const char *test_name,
 	} else {
 		struct spl_load_info load;
 
-		spl_set_bl_len(&load, 1);
-		load.priv = img;
-		load.read = spl_test_read;
+		spl_load_init(&load, spl_test_read, img, 1);
 		if (type == IMX8)
 			ut_assertok(spl_load_imx_container(&info_read, &load,
 							   0));
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 56105a59236..d17cf116a0e 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -20,3 +20,4 @@ static int spl_test_load(struct unit_test_state *uts)
 	return 0;
 }
 SPL_TEST(spl_test_load, 0);
+
-- 
2.34.1

