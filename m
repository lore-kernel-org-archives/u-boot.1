Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6723CCFA775
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A85838A5;
	Fri, 21 Nov 2025 11:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="got4C/S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956BA8388D; Fri, 21 Nov 2025 11:53:41 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03D183734
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so15558885e9.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763722418; x=1764327218; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fwfJblDNUu3rerCyM0L18wj2xNMgIHRWSttF4Yxbuhg=;
 b=got4C/S6ghjQm0h/6Lge7qtKLmCmt1VqW2HW62fhGyr9auZuNAhnP0Xdzycl4ldbL8
 ODueHyyk1NI1sMMO2pnXRe72T4NRQWg4DYjd9nhVyrdZ1AVmWk168RdfZpVp7T3e3lIG
 5vmvFynQ2DmelGxPRDoigvIMVI4GHL4loNW0yGuRPHU3SUFzKy2b06djWMRhCbqjKSJR
 FrrlaqPG1F6aybM6axjHVlE4rD0oHBHWCw1udRcDPi7wJGuw0eEg54PeZFl90aPJbsL7
 D5fXX4fborztg5fSD4fhlrEnrpgdIJ7yzfV3g5IwgyeMx0CUu/vb/IteC7xFTjXTV6Jv
 MwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763722418; x=1764327218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fwfJblDNUu3rerCyM0L18wj2xNMgIHRWSttF4Yxbuhg=;
 b=hYgBeu4iLglOGQNfuTwUQzSqkJdlnh+7iNNDyFcHpGcjVMtWSx8MByW7zjmcExRhhR
 x4m+jRk8Ewe2Hi8Cvrzd72QsXzLMgY0FcqkASnPG6fe3LQk9VgDHzPlmrl3VMhSArN+b
 2Yx43ayTRG+mDtcYvEgPwWSswldh2QQab+1HPyte6Z2FhP1f+SZgpJobMO9k6TQ9hfJL
 PVoanzqycxl5T71bInn8pJqdgo3plylQtSW5fKSGxkqZQUMnTBKz+IZgw6PaEfJ4J0rB
 6fP29dnrM6c1hDVExbvESTP+vJgE4Jo2rwU6Qv1zqRSaQVBh3nMTOYdNUwmUQvkRmaVt
 enbQ==
X-Gm-Message-State: AOJu0YxbD/3L2lZWuDG5WfiiMCnQbLdprkUEjF8Tg/w9NBAwbusPGL5m
 ArNXmv50GoBTqgUGZwgcYXDJrHcQhjN0PUWp+fwc8r3KSOoQLy8tp1kpkWgHHvrLHUk=
X-Gm-Gg: ASbGncv6hInsaontO5grTHRxDOMsjQXTcNIvbxyChHerhALCToQHLrMhJc90pVjt3Sa
 Gd79pZyit4P62Rz14EGV3q1Vlag1gwtzZZ+Q6gmKZ6zKtVNyUSS7q77lvtS4mc0EcC2hK+kwEfV
 6kFxd6vZDUGWqgIjmoSLpRUsJYuJqMeDpAeTz5UKQ+tYLTkb4UiTAlkHcvdLIagvU0IOl6wOMHD
 RRoSZxA0JX/TTqsdp+RLtV4bgr3FTSTot2f/So6++WZtP4AcpqGyBJyTFEPQOKEvU/2sD8He6J+
 x4LYnPf0Z1L1091pZl4mPXevRQCmpYJq2R8zZFthjl5C/+k1lb0B+hXaHcoo8kSY7KIPc40kEwN
 BwMuyoziFXa11QJlUs+MlaGEW3awmJ2DgejKPLOt5T64xv5MdnXlfE0xlhkbfY4akIGYG57ux6G
 nr/X7FXX6MVZmAYmAH8WNNIXASskFmrg8=
X-Google-Smtp-Source: AGHT+IG1YZ+f+2G+7pfsXW2gs2Inwt1pehOG+M83aeUoOvBEWWuVrYmbxFZ3XwmGP6/gZtw6f2d+Ow==
X-Received: by 2002:a05:600c:474a:b0:477:b0b9:3137 with SMTP id
 5b1f17b1804b1-477c10c8886mr17595025e9.1.1763722418207; 
 Fri, 21 Nov 2025 02:53:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de46cdsm80985285e9.8.2025.11.21.02.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 02:53:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 21 Nov 2025 11:53:32 +0100
Subject: [PATCH RFT v7 2/3] fastboot: blk: switch emmc to use the block helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-topic-fastboot-blk-v7-2-9589d902fc91@linaro.org>
References: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
In-Reply-To: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9346;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LUztY+npi5ehkINJISg2WnT1ea808VK3hVxtvZ/OMrA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpIESuYfwyIpU4SPEoe/khoAHJeX7oJeyk+VLoCqGm
 gaanp6eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaSBErgAKCRB33NvayMhJ0dSaEA
 C/XOIkWd72kNmy88XMrkriFB7qxwUzjD0mACpsDtyp17SsyQVpHgaKED9GwvDV7YuEM/peiLk3GMcc
 Qec8N0Qu+0p9NQX/Xg/LCbV/O9wXsnZ/exRKu5o/Ngu7/ftcgEGfHJvZb8dGy0siz3DJSGoZHs386E
 J1FtDnmJV3vKtX7lPcQ/83qkRdVotdAbNFDY91DqWjKav5IqHo57+CAfour3KVBTBa/qGBpWTsVo1S
 jtPUhO1PYhqxOZwFgA3ZDESBKGWbMm9R6gV1xvpohYhVDLrEL8UA1H86gDu2E1nFhT1aSbSaAZJn+J
 UGKstVdlLmXLJtkJYxwlvgDzkBmnfF+k3CeZXzJOqrKWePJVRuUoVBPQ2TE/DWrkWvv0VOvTxI50vl
 x3/X3fBwyYZYs0YXJlw0bkaAgy8sF8KWQ2z37/lJqP1ngGqTL/cCjkcw65dIvHFhttwB+TTcj0Uia7
 U428VNguXfo95HajmcIBZ8aHkis/idERFmhUUYaRFIUX2lRlRUK9zbMIuJZihrz5l6EFSnAcwEG+LP
 cLHFIUuMXLIWoSm0vIEUFbGtTnE0rALDOgcOc2Q9hq45lsANZVQovJocW3krlhtYncH6d0JFopWY6R
 yfIjK5ScqibTZCkW6HUdH8FXgpmStQ0RBxNdG1P7PV+LhBiYDtl0AlI6q40Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Dmitrii Merkurev <dimorinny@google.com>

Switch the mmc backend to this new shared block helpers,
reducing block logic and only leaving MMC specific logic.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/Makefile |   3 +-
 drivers/fastboot/fb_mmc.c | 210 +++-------------------------------------------
 2 files changed, 14 insertions(+), 199 deletions(-)

diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index adedba0bf24..e4c97d45997 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,6 +3,7 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
-obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
+# MMC reuses block implementation
+obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
 obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index dca7c222f35..11d9c8e8460 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
+#include <fb_block.h>
 #include <fb_mmc.h>
 #include <image-sparse.h>
 #include <image.h>
@@ -20,10 +21,6 @@
 
 #define BOOT_PARTITION_NAME "boot"
 
-struct fb_mmc_sparse {
-	struct blk_desc	*dev_desc;
-};
-
 static int raw_part_get_info_by_name(struct blk_desc *dev_desc,
 				     const char *name,
 				     struct disk_partition *info)
@@ -114,118 +111,10 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
 	return do_get_part_info(dev_desc, name, info);
 }
 
-/**
- * fb_mmc_blk_write() - Write/erase MMC in chunks of FASTBOOT_MAX_BLK_WRITE
- *
- * @block_dev: Pointer to block device
- * @start: First block to write/erase
- * @blkcnt: Count of blocks
- * @buffer: Pointer to data buffer for write or NULL for erase
- */
-static lbaint_t fb_mmc_blk_write(struct blk_desc *block_dev, lbaint_t start,
-				 lbaint_t blkcnt, const void *buffer)
-{
-	lbaint_t blk = start;
-	lbaint_t blks_written;
-	lbaint_t cur_blkcnt;
-	lbaint_t blks = 0;
-	int i;
-
-	for (i = 0; i < blkcnt; i += FASTBOOT_MAX_BLK_WRITE) {
-		cur_blkcnt = min((int)blkcnt - i, FASTBOOT_MAX_BLK_WRITE);
-		if (buffer) {
-			if (fastboot_progress_callback)
-				fastboot_progress_callback("writing");
-			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
-						  buffer + (i * block_dev->blksz));
-		} else {
-			if (fastboot_progress_callback)
-				fastboot_progress_callback("erasing");
-			blks_written = blk_derase(block_dev, blk, cur_blkcnt);
-		}
-		blk += blks_written;
-		blks += blks_written;
-	}
-	return blks;
-}
-
-static lbaint_t fb_mmc_sparse_write(struct sparse_storage *info,
-		lbaint_t blk, lbaint_t blkcnt, const void *buffer)
-{
-	struct fb_mmc_sparse *sparse = info->priv;
-	struct blk_desc *dev_desc = sparse->dev_desc;
-
-	return fb_mmc_blk_write(dev_desc, blk, blkcnt, buffer);
-}
-
-static lbaint_t fb_mmc_sparse_reserve(struct sparse_storage *info,
-		lbaint_t blk, lbaint_t blkcnt)
-{
-	return blkcnt;
-}
-
-static void write_raw_image(struct blk_desc *dev_desc,
-			    struct disk_partition *info, const char *part_name,
-			    void *buffer, u32 download_bytes, char *response)
-{
-	lbaint_t blkcnt;
-	lbaint_t blks;
-
-	/* determine number of blocks to write */
-	blkcnt = ((download_bytes + (info->blksz - 1)) & ~(info->blksz - 1));
-	blkcnt = lldiv(blkcnt, info->blksz);
-
-	if (blkcnt > info->size) {
-		pr_err("too large for partition: '%s'\n", part_name);
-		fastboot_fail("too large for partition", response);
-		return;
-	}
-
-	puts("Flashing Raw Image\n");
-
-	blks = fb_mmc_blk_write(dev_desc, info->start, blkcnt, buffer);
-
-	if (blks != blkcnt) {
-		pr_err("failed writing to device %d\n", dev_desc->devnum);
-		fastboot_fail("failed writing to device", response);
-		return;
-	}
-
-	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * info->blksz,
-	       part_name);
-	fastboot_okay(NULL, response);
-}
-
-#if defined(CONFIG_FASTBOOT_MMC_BOOT_SUPPORT) || \
-	defined(CONFIG_FASTBOOT_MMC_USER_SUPPORT)
-static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
-{
-	lbaint_t blks;
-
-	debug("Start Erasing mmc hwpart[%u]...\n", dev_desc->hwpart);
-
-	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL);
-
-	if (blks != dev_desc->lba) {
-		pr_err("Failed to erase mmc hwpart[%u]\n", dev_desc->hwpart);
-		return 1;
-	}
-
-	printf("........ erased %llu bytes from mmc hwpart[%u]\n",
-	       (u64)(dev_desc->lba * dev_desc->blksz), dev_desc->hwpart);
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
 static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 			    int hwpart, u32 buff_sz, char *response)
 {
-	lbaint_t blkcnt;
-	lbaint_t blks;
-	unsigned long blksz;
-
 	// To operate on EMMC_BOOT1/2 (mmc0boot0/1) we first change the hwpart
 	if (blk_dselect_hwpart(dev_desc, hwpart)) {
 		pr_err("Failed to select hwpart\n");
@@ -233,42 +122,11 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 		return;
 	}
 
-	if (buffer) { /* flash */
-
-		/* determine number of blocks to write */
-		blksz = dev_desc->blksz;
-		blkcnt = ((buff_sz + (blksz - 1)) & ~(blksz - 1));
-		blkcnt = lldiv(blkcnt, blksz);
-
-		if (blkcnt > dev_desc->lba) {
-			pr_err("Image size too large\n");
-			fastboot_fail("Image size too large", response);
-			return;
-		}
-
-		debug("Start Flashing Image to EMMC_BOOT%d...\n", hwpart);
-
-		blks = fb_mmc_blk_write(dev_desc, 0, blkcnt, buffer);
-
-		if (blks != blkcnt) {
-			pr_err("Failed to write EMMC_BOOT%d\n", hwpart);
-			fastboot_fail("Failed to write EMMC_BOOT part",
-				      response);
-			return;
-		}
-
-		printf("........ wrote %llu bytes to EMMC_BOOT%d\n",
-		       (u64)(blkcnt * blksz), hwpart);
-	} else { /* erase */
-		if (fb_mmc_erase_mmc_hwpart(dev_desc)) {
-			pr_err("Failed to erase EMMC_BOOT%d\n", hwpart);
-			fastboot_fail("Failed to erase EMMC_BOOT part",
-				      response);
-			return;
-		}
-	}
-
-	fastboot_okay(NULL, response);
+	if (buffer) /* flash */
+		fastboot_block_write_raw_disk(dev_desc, "EMMC_BOOT",
+					      buffer, buff_sz, response);
+	else /* erase */
+		fastboot_block_raw_erase_disk(dev_desc, "EMMC_BOOT", response);
 }
 #endif
 
@@ -609,30 +467,11 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 		return;
 
 	if (is_sparse_image(download_buffer)) {
-		struct fb_mmc_sparse sparse_priv;
-		struct sparse_storage sparse;
-		int err;
-
-		sparse_priv.dev_desc = dev_desc;
-
-		sparse.blksz = info.blksz;
-		sparse.start = info.start;
-		sparse.size = info.size;
-		sparse.write = fb_mmc_sparse_write;
-		sparse.reserve = fb_mmc_sparse_reserve;
-		sparse.mssg = fastboot_fail;
-
-		printf("Flashing sparse image at offset " LBAFU "\n",
-		       sparse.start);
-
-		sparse.priv = &sparse_priv;
-		err = write_sparse_image(&sparse, cmd, download_buffer,
-					 response);
-		if (!err)
-			fastboot_okay(NULL, response);
+		fastboot_block_write_sparse_image(dev_desc, &info, cmd,
+						  download_buffer, response);
 	} else {
-		write_raw_image(dev_desc, &info, cmd, download_buffer,
-				download_bytes, response);
+		fastboot_block_write_raw_image(dev_desc, &info, cmd, download_buffer,
+					       download_bytes, response);
 	}
 }
 
@@ -646,7 +485,6 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 {
 	struct blk_desc *dev_desc;
 	struct disk_partition info;
-	lbaint_t blks, blks_start, blks_size, grp_size;
 	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
 
 #ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
@@ -673,10 +511,7 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 		if (!dev_desc)
 			return;
 
-		if (fb_mmc_erase_mmc_hwpart(dev_desc))
-			fastboot_fail("Failed to erase EMMC_USER", response);
-		else
-			fastboot_okay(NULL, response);
+		fastboot_block_raw_erase_disk(dev_desc, "EMMC_USER", response);
 		return;
 	}
 #endif
@@ -685,26 +520,5 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 		return;
 
 	/* Align blocks to erase group size to avoid erasing other partitions */
-	grp_size = mmc->erase_grp_size;
-	blks_start = (info.start + grp_size - 1) & ~(grp_size - 1);
-	if (info.size >= grp_size)
-		blks_size = (info.size - (blks_start - info.start)) &
-				(~(grp_size - 1));
-	else
-		blks_size = 0;
-
-	printf("Erasing blocks " LBAFU " to " LBAFU " due to alignment\n",
-	       blks_start, blks_start + blks_size);
-
-	blks = fb_mmc_blk_write(dev_desc, blks_start, blks_size, NULL);
-
-	if (blks != blks_size) {
-		pr_err("failed erasing from device %d\n", dev_desc->devnum);
-		fastboot_fail("failed erasing from device", response);
-		return;
-	}
-
-	printf("........ erased " LBAFU " bytes from '%s'\n",
-	       blks_size * info.blksz, cmd);
-	fastboot_okay(NULL, response);
+	fastboot_block_raw_erase(dev_desc, &info, cmd, mmc->erase_grp_size, response);
 }

-- 
2.34.1

