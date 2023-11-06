Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B5C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 113F087036;
	Mon,  6 Nov 2023 03:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVHWzhPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275CE86F99; Mon,  6 Nov 2023 03:27:26 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29CFC86FD8
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41b7ec4cceeso25885981cf.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237577; x=1699842377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoVHXg9jbNYG4wpXWzg63wlUQ7SDBfnMz9SurbsWklw=;
 b=EVHWzhPvYbRJ36QfUyTgy7V75I6m88GFtVljKAaACp4ClUXBuHSCpx+pUOYxe9FEPb
 6rSD5CdEqOT3bilXVfbEiubkmFWVGwk3FK6fdownNO3W5L8BilbDyNci1myS4lILYih1
 7XLnUP41AIKSGWNG2pu2k+8YHpP09H32InuDz4bH1RW2Z5PP5DinQnUs33sTfeKCACyO
 TG/x9ydUIChTwjVElvobIK/yOJP8xwwgwPTz/ct0+t0iAK4DF5FZQjxeBY1ROgiIx6AD
 42edjw/QJxym4RypbS5t1wVF7sQxGeReQxs+kvzMijbO4s1k0kYvWi7iRbH/VMrtE1PJ
 QGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237577; x=1699842377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoVHXg9jbNYG4wpXWzg63wlUQ7SDBfnMz9SurbsWklw=;
 b=LTxywvYXF63kPnJmeFzMhcaiUhgdGB0o2c7BDR8MDIbVnHbvsWtq2zztw6sCYv8FVG
 rPVNQiKXrGiTwKd3daOjnLS4LgQRI7VnN6DNvPxvN6a2OxTBl794GRzVCtueRnN7aEa/
 pXkm/XFimhyrVKgCkQ5WVRPFaHNhSqGU/z4sqroYqHWdVuJHLkS8Rm8OaiSiQB+kEiTh
 +fIQjBr3P2ke+gzc8LR7XXs+XG98McqhhnAX8Ir3ES+i+hr/A/dkttTrRV2HJ8pLo9BT
 lbWUB+zYFFxDXupV5EzlPl3bIN4RDcqOWMM4F00o6HXGBLwyHsoS7sNihUvwn7wsKH5r
 VBdw==
X-Gm-Message-State: AOJu0YwLbLO/yFz6If2DJk5PEmUq8haVNMbG9gG00GnX3TKUION1DE2g
 QuN1DNBLnTwWgeQrfgsidNs=
X-Google-Smtp-Source: AGHT+IEbhFRUEYAHr8P/ylAbD+TdcOeXJEmTpvLZB8snEe4AJ1NMyYejGAWzvFCAebDfW0WtQyfG2w==
X-Received: by 2002:a05:622a:15ce:b0:41c:b787:7bb with SMTP id
 d14-20020a05622a15ce00b0041cb78707bbmr36053170qty.21.1699237577108; 
 Sun, 05 Nov 2023 18:26:17 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 r22-20020ac85e96000000b0041ce9ebaad2sm3041420qtx.43.2023.11.05.18.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:16 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 09/25] spl: Remove filename from spl_load_info
Date: Sun,  5 Nov 2023 21:25:47 -0500
Message-Id: <20231106022603.3405551-10-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

For filesystems, filename serves the same purpose as priv. However,
spl_load_fit_image also uses it to determine whether to use a DMA-aligned
buffer. This is beneficial for FAT, which uses a bounce-buffer if the
destination is not DMA-aligned. Remove this logic, and instead achieve it
by setting bl_len to ARCH_DMA_MINALIGN. With this done, we can remove
filename entirely.

One wrinkle bears mentioning: because filesystems are not block-based, we
may read less than the size passed to spl_load_info.read. This can happen
if the file size is not DMA-aligned. This is fine as long as we read the
amount we originally wanted to. Modify the conditions for callers of
spl_load_info.read to check against the original, unaligned size to avoid
failing spuriously.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 arch/arm/mach-sunxi/spl_spi_sunxi.c |  1 -
 common/spl/spl_blk_fs.c             | 10 ++++++----
 common/spl/spl_fat.c                |  6 +++---
 common/spl/spl_fit.c                | 23 +----------------------
 common/spl/spl_imx_container.c      |  8 +++++---
 common/spl/spl_mmc.c                |  2 --
 common/spl/spl_nand.c               |  3 ---
 common/spl/spl_semihosting.c        |  1 -
 common/spl/spl_spi.c                |  2 --
 common/spl/spl_ymodem.c             |  1 -
 include/spl.h                       |  2 --
 test/image/spl_load_os.c            |  1 -
 12 files changed, 15 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 896aba69c32..5e7fba0c8e4 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -354,7 +354,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT image\n");
-		load.filename = NULL;
 		load.bl_len = 1;
 		load.read = spi_load_read;
 		ret = spl_load_simple_fit(spl_image, &load,
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 144c8a65b5d..4975ce4d6ec 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -9,10 +9,12 @@
 #include <spl.h>
 #include <image.h>
 #include <fs.h>
+#include <asm/cache.h>
 #include <asm/io.h>
 
 struct blk_dev {
 	const char *ifname;
+	const char *filename;
 	char dev_part_str[8];
 };
 
@@ -30,11 +32,11 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 		return ret;
 	}
 
-	ret = fs_read(load->filename, virt_to_phys(buf), file_offset, size,
+	ret = fs_read(dev->filename, virt_to_phys(buf), file_offset, size,
 		      &actlen);
 	if (ret < 0) {
 		printf("spl: error reading image %s. Err - %d\n",
-		       load->filename, ret);
+		       dev->filename, ret);
 		return ret;
 	}
 
@@ -85,9 +87,9 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
-		load.bl_len = 1;
-		load.filename = (void *)filename;
+		load.bl_len = ARCH_DMA_MINALIGN;
 		load.priv = &dev;
+		dev.filename = filename;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
 	}
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 6172e7bcd48..8a2c4e3af49 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -51,7 +51,7 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 {
 	loff_t actread;
 	int ret;
-	char *filename = (char *)load->filename;
+	char *filename = load->priv;
 
 	ret = fat_read_file(filename, buf, file_offset, size, &actread);
 	if (ret)
@@ -97,8 +97,8 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
-		load.bl_len = 1;
-		load.filename = (void *)filename;
+		load.bl_len = ARCH_DMA_MINALIGN;
+		load.priv = (void *)filename;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ce7ef0efd0d..0df4e6d1484 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -14,7 +14,6 @@
 #include <mapmem.h>
 #include <spl.h>
 #include <sysinfo.h>
-#include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
@@ -172,28 +171,11 @@ static int spl_fit_get_image_node(const struct spl_fit_info *ctx,
 
 static int get_aligned_image_offset(struct spl_load_info *info, int offset)
 {
-	/*
-	 * If it is a FS read, get the first address before offset which is
-	 * aligned to ARCH_DMA_MINALIGN. If it is raw read return the
-	 * block number to which offset belongs.
-	 */
-	if (info->filename)
-		return offset & ~(ARCH_DMA_MINALIGN - 1);
-
 	return ALIGN_DOWN(offset, info->bl_len);
 }
 
 static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
 {
-	/*
-	 * If it is a FS read, get the difference between the offset and
-	 * the first address before offset which is aligned to
-	 * ARCH_DMA_MINALIGN. If it is raw read return the offset within the
-	 * block.
-	 */
-	if (info->filename)
-		return offset & (ARCH_DMA_MINALIGN - 1);
-
 	return offset & (info->bl_len - 1);
 }
 
@@ -202,9 +184,6 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 {
 	data_size = data_size + get_aligned_image_overhead(info, offset);
 
-	if (info->filename)
-		return data_size;
-
 	return ALIGN(data_size, info->bl_len);
 }
 
@@ -295,7 +274,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		if (info->read(info,
 			       fit_offset +
 			       get_aligned_image_offset(info, offset), size,
-			       src_ptr) != size)
+			       src_ptr) < length)
 			return -EIO;
 
 		debug("External data: dst=%p, offset=%x, size=%lx\n",
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index ad89a99fb23..7cd674f835f 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -45,7 +45,8 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	      container, offset, size);
 	if (info->read(info, offset, size,
 		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) != size) {
+				  images[image_index].size)) <
+	    images[image_index].size) {
 		printf("%s wrong\n", __func__);
 		return NULL;
 	}
@@ -77,7 +78,8 @@ static int read_auth_container(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %u\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size, container) != size) {
+	if (info->read(info, offset, size, container) <
+	    CONTAINER_HDR_ALIGNMENT) {
 		ret = -EIO;
 		goto end;
 	}
@@ -107,7 +109,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 
 		debug("%s: container: %p offset: %lu size: %u\n",
 		      __func__, container, offset, size);
-		if (info->read(info, offset, size, container) != size) {
+		if (info->read(info, offset, size, container) < length) {
 			ret = -EIO;
 			goto end;
 		}
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 9f41ea648ce..8c4ffe743d5 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -108,7 +108,6 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = bd;
-		load.filename = NULL;
 		load.bl_len = bd->blksz;
 		load.read = h_spl_load_read;
 		ret = spl_load_simple_fit(spl_image, &load,
@@ -118,7 +117,6 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.priv = bd;
-		load.filename = NULL;
 		load.bl_len = bd->blksz;
 		load.read = h_spl_load_read;
 
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 1fcc89fa660..45d7c5f6cfb 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -90,7 +90,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = &offset;
-		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
 		return spl_load_simple_fit(spl_image, &load, offset, header);
@@ -99,7 +98,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.priv = &offset;
-		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
 		return spl_load_imx_container(spl_image, &load, offset);
@@ -108,7 +106,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found legacy image\n");
-		load.filename = NULL;
 		load.bl_len = IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1;
 		load.read = spl_nand_legacy_read;
 
diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 8f11c29913f..24a3d9fd1c9 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -69,7 +69,6 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.read = smh_fit_read;
 		load.bl_len = 1;
-		load.filename = NULL;
 		load.priv = &fd;
 
 		ret = spl_load_simple_fit(spl_image, &load, 0, header);
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index af7a28e7c25..373caea322a 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -152,7 +152,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 			debug("Found FIT\n");
 			load.priv = flash;
-			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
 			err = spl_load_simple_fit(spl_image, &load,
@@ -163,7 +162,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			struct spl_load_info load;
 
 			load.priv = flash;
-			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
 
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 8616cb3e915..3f92b9b0036 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -135,7 +135,6 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = (void *)&info;
-		load.filename = NULL;
 		load.bl_len = 1;
 		info.buf = buf;
 		info.image_read = BUF_SIZE;
diff --git a/include/spl.h b/include/spl.h
index ecfc50e0095..1021bab3f30 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -287,12 +287,10 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
  *
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
- * @filename: Name of the fit image file.
  * @read: Function to call to read from the device
  */
 struct spl_load_info {
 	void *priv;
-	const char *filename;
 	/**
 	 * read() - Read from device
 	 *
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 794cfad4e70..f46df907c63 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -57,7 +57,6 @@ static int spl_test_load(struct unit_test_state *uts)
 	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
 	if (ret)
 		ut_assertf(0, "%s not found, error %d\n", fname, ret);
-	load.filename = fname;
 
 	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
 
-- 
2.37.1

