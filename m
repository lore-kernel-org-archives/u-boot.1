Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A855CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54E986E2C;
	Thu, 12 Oct 2023 04:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eGhGlF15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE47386DCE; Thu, 12 Oct 2023 03:58:59 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51FA86E06
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4181462ebf0so3033161cf.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075809; x=1697680609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAwV1rVWSNDAAluljGK1tNERez99VYATOVeCa9VSV34=;
 b=eGhGlF15jl/hzSGKtJ2cql71RcYjtVJ/33hacAl2bi83Uxt6ZnyvdOX3X0bQMwM+EH
 Wfw1DRcvKOrfUUd4eqY26n6RQnEU2s6kLDITrXg2B2jDtbsMHMhGko8vE3V4vldpug8z
 Qbw7jb/Nda+kwXsQfzrr6+V3RXu2c9BCfYvcu3aPTGP2L5+pqmcIYNfAiBjavctNC7GK
 YG29BEBoG8Rc38Ir1nsWd0MjqLrWvA3g4ehbOBqZIArvAeYcj7JGLOLlUHVMai+d7tuM
 F609zWCCt/tX9ql0R0tSgAwobontH7TwMvgFHC/OFMPTKjSKnsavwI+Wla/lqvBKTsjB
 TEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075809; x=1697680609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAwV1rVWSNDAAluljGK1tNERez99VYATOVeCa9VSV34=;
 b=HG3b28m5tZVl/DlPqO4aFCEJnXtaXvYs3G1GzLlUxXp0fUEWBZ8nWFAALBliPPIYWP
 NS1/r3s03bZ7d356RyzzBaTnv1sCYuujJGGsHbNQIVwBUs6YkffAf16aDCFsPwvkt48t
 iUNotnu2YbcobxW0xAtzLgbsNu0leCczglqHm/UED5RhhGT2TF/LPsGnn5sVeA9IiPaO
 T1yfcjs6c75bUoOfMfejOljPD2TXDRrMkkV7TXvuszTESPhNgH1VLMV7/32PsPkVmSlq
 5pYDRTG15eESm3Y/oKY2mEOZojWncQ4grC68mQ3UdPmjKmXv8eMrJHzOzmn3qJv97VbX
 1jXw==
X-Gm-Message-State: AOJu0YxMFC2C+19aUcWW15Or9gW/GWtHNsZMMGsiE+4Xr638Ll0jSExv
 EVlsBPVhTb/yT4diEChmP3PKjGXyw8oIEQ==
X-Google-Smtp-Source: AGHT+IG8h6ESY3O0AL8nHPMvWn1GtOkKwVo6tkYHIUYkqiCM6ztFcQK/Gijvp6u/tub/SsS+GZj3IQ==
X-Received: by 2002:a05:622a:144d:b0:40d:6219:d813 with SMTP id
 v13-20020a05622a144d00b0040d6219d813mr29514070qtx.68.1697075808772; 
 Wed, 11 Oct 2023 18:56:48 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 x25-20020ac84a19000000b004108ce94882sm5790067qtq.83.2023.10.11.18.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:48 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH 17/26] spl: Use map_sysmem where appropriate
Date: Wed, 11 Oct 2023 21:56:17 -0400
Message-Id: <20231012015626.3487451-18-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

All "physical" addresses in SPL must be converted to virtual addresses
before access in order for sandbox to work. Add some calls to map_sysmem in
appropriate places. We do not generally call unmap_sysmem, since we need
the image memory to still be mapped when we jump to the image. This doesn't
matter at the moment since unmap_sysmem is a no-op.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl.c               |  4 +++-
 common/spl/spl_blk_fs.c        |  6 ++++--
 common/spl/spl_ext.c           |  4 +++-
 common/spl/spl_fat.c           | 11 +++++++----
 common/spl/spl_fit.c           | 36 +++++++++++++++++++++-------------
 common/spl/spl_imx_container.c |  4 +++-
 common/spl/spl_legacy.c        |  6 ++++--
 common/spl/spl_mmc.c           |  4 +++-
 common/spl/spl_net.c           | 10 +++++++---
 common/spl/spl_nor.c           |  5 +++--
 common/spl/spl_spi.c           | 14 +++++++++----
 11 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 66eeea41a34..732d90d39e6 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -653,7 +653,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	spl_set_bd();
 
 	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
-		mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
+		mem_malloc_init((ulong)map_sysmem(SPL_SYS_MALLOC_START,
+						  SPL_SYS_MALLOC_SIZE),
+				SPL_SYS_MALLOC_SIZE);
 		gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 	}
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index ea5d1a51d9f..63825d620d1 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -9,6 +9,7 @@
 #include <spl.h>
 #include <image.h>
 #include <fs.h>
+#include <asm/io.h>
 
 struct blk_dev {
 	const char *ifname;
@@ -29,7 +30,8 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 		return ret;
 	}
 
-	ret = fs_read(load->filename, (ulong)buf, file_offset, size, &actlen);
+	ret = fs_read(load->filename, virt_to_phys(buf), file_offset, size,
+		      &actlen);
 	if (ret < 0) {
 		printf("spl: error reading image %s. Err - %d\n",
 		       load->filename, ret);
@@ -69,7 +71,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 		goto out;
 	}
 
-	ret = fs_read(filename, (ulong)header, 0,
+	ret = fs_read(filename, virt_to_phys(header), 0,
 		      sizeof(struct legacy_img_hdr), &actlen);
 	if (ret) {
 		printf("spl: unable to read file %s. Err - %d\n", filename,
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 902564a6077..af836ca15b8 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -2,6 +2,7 @@
 
 #include <common.h>
 #include <env.h>
+#include <mapmem.h>
 #include <part.h>
 #include <spl.h>
 #include <asm/u-boot.h>
@@ -53,7 +54,8 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 		goto end;
 	}
 
-	err = ext4fs_read((char *)spl_image->load_addr, 0, filelen, &actlen);
+	err = ext4fs_read(map_sysmem(spl_image->load_addr, filelen), 0, filelen,
+			  &actlen);
 
 end:
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 8bec9cce5ca..ff9892356f6 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -11,6 +11,7 @@
 #include <common.h>
 #include <env.h>
 #include <log.h>
+#include <mapmem.h>
 #include <spl.h>
 #include <asm/u-boot.h>
 #include <fat.h>
@@ -74,11 +75,13 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL) &&
 	    image_get_magic(header) == FDT_MAGIC) {
-		err = file_fat_read(filename, (void *)CONFIG_SYS_LOAD_ADDR, 0);
+		err = file_fat_read(filename,
+				    map_sysmem(CONFIG_SYS_LOAD_ADDR, 0), 0);
 		if (err <= 0)
 			goto end;
 		err = spl_parse_image_header(spl_image, bootdev,
-				(struct legacy_img_hdr *)CONFIG_SYS_LOAD_ADDR);
+					     map_sysmem(CONFIG_SYS_LOAD_ADDR,
+							err));
 		if (err == -EAGAIN)
 			return err;
 		if (err == 0)
@@ -99,8 +102,8 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 		if (err)
 			goto end;
 
-		err = file_fat_read(filename,
-				    (u8 *)(uintptr_t)spl_image->load_addr, 0);
+		err = file_fat_read(filename, map_sysmem(spl_image->load_addr,
+							 spl_image->size), 0);
 	}
 
 end:
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index e3cdf8e5c05..f397cb40277 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -16,6 +16,7 @@
 #include <sysinfo.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 
@@ -388,25 +389,32 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	/* Figure out which device tree the board wants to use */
 	node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);
 	if (node < 0) {
+		size_t size;
+
 		debug("%s: cannot find FDT node\n", __func__);
 
 		/*
 		 * U-Boot did not find a device tree inside the FIT image. Use
 		 * the U-Boot device tree instead.
 		 */
-		if (gd->fdt_blob)
-			memcpy((void *)image_info.load_addr, gd->fdt_blob,
-			       fdt_totalsize(gd->fdt_blob));
-		else
+		if (!gd->fdt_blob)
 			return node;
+
+		/*
+		 * Make the load-address of the FDT available for the SPL
+		 * framework
+		 */
+		size = fdt_totalsize(gd->fdt_blob);
+		spl_image->fdt_addr = map_sysmem(image_info.load_addr, size);
+		memcpy(spl_image->fdt_addr, gd->fdt_blob, size);
 	} else {
 		ret = load_simple_fit(info, sector, ctx, node, &image_info);
 		if (ret < 0)
 			return ret;
+
+		spl_image->fdt_addr = phys_to_virt(image_info.load_addr);
 	}
 
-	/* Make the load-address of the FDT available for the SPL framework */
-	spl_image->fdt_addr = map_sysmem(image_info.load_addr, 0);
 	if (CONFIG_IS_ENABLED(FIT_IMAGE_TINY))
 		return 0;
 
@@ -859,7 +867,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 	images.verify = 1;
 #endif
-	ret = fit_image_load(&images, (ulong)header,
+	ret = fit_image_load(&images, virt_to_phys((void *)header),
 			     NULL, &fit_uname_config,
 			     IH_ARCH_DEFAULT, IH_TYPE_STANDALONE, -1,
 			     FIT_LOAD_OPTIONAL, &fw_data, &fw_len);
@@ -867,15 +875,15 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		printf("DEPRECATED: 'standalone = ' property.");
 		printf("Please use either 'firmware =' or 'kernel ='\n");
 	} else {
-		ret = fit_image_load(&images, (ulong)header, NULL,
-				     &fit_uname_config, IH_ARCH_DEFAULT,
+		ret = fit_image_load(&images, virt_to_phys((void *)header),
+				     NULL, &fit_uname_config, IH_ARCH_DEFAULT,
 				     IH_TYPE_FIRMWARE, -1, FIT_LOAD_OPTIONAL,
 				     &fw_data, &fw_len);
 	}
 
 	if (ret < 0) {
-		ret = fit_image_load(&images, (ulong)header, NULL,
-				     &fit_uname_config, IH_ARCH_DEFAULT,
+		ret = fit_image_load(&images, virt_to_phys((void *)header),
+				     NULL, &fit_uname_config, IH_ARCH_DEFAULT,
 				     IH_TYPE_KERNEL, -1, FIT_LOAD_OPTIONAL,
 				     &fw_data, &fw_len);
 	}
@@ -898,9 +906,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 	images.verify = 1;
 #endif
-	ret = fit_image_load(&images, (ulong)header, NULL, &fit_uname_config,
-			     IH_ARCH_DEFAULT, IH_TYPE_FLATDT, -1,
-			     FIT_LOAD_OPTIONAL, &dt_data, &dt_len);
+	ret = fit_image_load(&images, virt_to_phys((void *)header), NULL,
+			     &fit_uname_config, IH_ARCH_DEFAULT, IH_TYPE_FLATDT,
+			     -1, FIT_LOAD_OPTIONAL, &dt_data, &dt_len);
 	if (ret >= 0) {
 		spl_image->fdt_addr = (void *)dt_data;
 
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 126ab7c57a1..ed671278522 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <imx_container.h>
 #include <log.h>
+#include <mapmem.h>
 #include <spl.h>
 #ifdef CONFIG_AHAB_BOOT
 #include <asm/mach-imx/ahab.h>
@@ -45,7 +46,8 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	debug("%s: container: %p sector: %lu sectors: %u\n", __func__,
 	      container, sector, sectors);
 	if (info->read(info, sector, sectors,
-		       (void *)images[image_index].dst) != sectors) {
+		       map_sysmem(images[image_index].dst,
+				  images[image_index].size)) != sectors) {
 		printf("%s wrong\n", __func__);
 		return NULL;
 	}
diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index e9564e5c2a5..51656fb9617 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -7,6 +7,7 @@
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <asm/sections.h>
 #include <spl.h>
 
@@ -129,7 +130,7 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 			dataptr += sizeof(*hdr);
 
 		load->read(load, dataptr, spl_image->size,
-			   (void *)(unsigned long)spl_image->load_addr);
+			   map_sysmem(spl_image->load_addr, spl_image->size));
 		break;
 
 	case IH_COMP_LZMA:
@@ -148,7 +149,8 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 		}
 
 		load->read(load, dataptr, spl_image->size, src);
-		ret = lzmaBuffToBuffDecompress((void *)spl_image->load_addr,
+		ret = lzmaBuffToBuffDecompress(map_sysmem(spl_image->load_addr,
+							  spl_image->size),
 					       &lzma_len, src, spl_image->size);
 		if (ret) {
 			printf("LZMA decompression error: %d\n", ret);
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index a8579e29dee..a937c1762b1 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <mapmem.h>
 #include <part.h>
 #include <spl.h>
 #include <linux/compiler.h>
@@ -46,7 +47,8 @@ static int mmc_load_legacy(struct spl_image_info *spl_image,
 	count = blk_dread(mmc_get_blk_desc(mmc),
 			  sector + image_offset_sectors,
 			  image_size_sectors,
-			  (void *)(ulong)spl_image->load_addr);
+			  map_sysmem(spl_image->load_addr,
+				     image_size_sectors * mmc->read_bl_len));
 	debug("read %x sectors to %lx\n", image_size_sectors,
 	      spl_image->load_addr);
 	if (count != image_size_sectors)
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index b2c901b554b..f01d4df8bc6 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <image.h>
 #include <log.h>
+#include <mapmem.h>
 #include <spl.h>
 #include <net.h>
 #include <linux/libfdt.h>
@@ -21,14 +22,15 @@ static ulong spl_net_load_read(struct spl_load_info *load, ulong sector,
 {
 	debug("%s: sector %lx, count %lx, buf %lx\n",
 	      __func__, sector, count, (ulong)buf);
-	memcpy(buf, (void *)(image_load_addr + sector), count);
+	memcpy(buf, map_sysmem(image_load_addr + sector, count), count);
 	return count;
 }
 
 static int spl_net_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
-	struct legacy_img_hdr *header = (struct legacy_img_hdr *)image_load_addr;
+	struct legacy_img_hdr *header = map_sysmem(image_load_addr,
+						   sizeof(*header));
 	int rv;
 
 	env_init();
@@ -62,7 +64,9 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 		if (rv)
 			return rv;
 
-		memcpy((void *)spl_image->load_addr, header, spl_image->size);
+		memcpy(map_sysmem(spl_image->load_addr, spl_image->size),
+		       map_sysmem(image_load_addr, spl_image->size),
+		       spl_image->size);
 	}
 
 	return rv;
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index dd447982071..236b0718283 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -7,6 +7,7 @@
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
+#include <mapmem.h>
 #include <spl.h>
 
 static ulong spl_nor_load_read(struct spl_load_info *load, ulong sector,
@@ -14,7 +15,7 @@ static ulong spl_nor_load_read(struct spl_load_info *load, ulong sector,
 {
 	debug("%s: sector %lx, count %lx, buf %p\n",
 	      __func__, sector, count, buf);
-	memcpy(buf, (void *)sector, count);
+	memcpy(buf, map_sysmem(sector, count), count);
 
 	return count;
 }
@@ -92,7 +93,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 	 * Load real U-Boot from its location in NOR flash to its
 	 * defined location in SDRAM
 	 */
-	header = (const struct legacy_img_hdr *)spl_nor_get_uboot_base();
+	header = map_sysmem(spl_nor_get_uboot_base(), sizeof(*header));
 #ifdef CONFIG_SPL_LOAD_FIT
 	if (image_get_magic(header) == FDT_MAGIC) {
 		debug("Found FIT format U-Boot\n");
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 1427c9478c0..3ac4b1b5091 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -12,11 +12,13 @@
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
+#include <mapmem.h>
 #include <spi.h>
 #include <spi_flash.h>
 #include <errno.h>
 #include <spl.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <dm/ofnode.h>
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
@@ -134,13 +136,16 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 		if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL) &&
 		    image_get_magic(header) == FDT_MAGIC) {
+			u32 size = roundup(fdt_totalsize(header), 4);
+
 			err = spi_flash_read(flash, payload_offs,
-					     roundup(fdt_totalsize(header), 4),
-					     (void *)CONFIG_SYS_LOAD_ADDR);
+					     size,
+					     map_sysmem(CONFIG_SYS_LOAD_ADDR,
+							size));
 			if (err)
 				return err;
 			err = spl_parse_image_header(spl_image, bootdev,
-					(struct legacy_img_hdr *)CONFIG_SYS_LOAD_ADDR);
+					phys_to_virt(CONFIG_SYS_LOAD_ADDR));
 		} else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 			   image_get_magic(header) == FDT_MAGIC) {
 			struct spl_load_info load;
@@ -172,7 +177,8 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 				return err;
 			err = spi_flash_read(flash, payload_offs + spl_image->offset,
 					     spl_image->size,
-					     (void *)spl_image->load_addr);
+					     map_sysmem(spl_image->load_addr,
+							spl_image->size));
 		}
 		if (IS_ENABLED(CONFIG_SPI_FLASH_SOFT_RESET)) {
 			err = spi_nor_remove(flash);
-- 
2.37.1

