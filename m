Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312BCC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B21D835C0;
	Wed,  9 Apr 2025 09:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="guhQ8lKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B397E835A2; Wed,  9 Apr 2025 09:58:33 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308D18359C
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3866902f8f.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744185510; x=1744790310; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=raD5gveqTqJ49JFkgn/KjUTOuwmYDlfMpEFc6AXkUDw=;
 b=guhQ8lKDWfEVOzC5vefQKxAtNPFhS9zRoOyUesVwS5Ezdng3+mQ5YiapWoRgZJIeG2
 YfGG9Fkg2qjzTTgjTq7t93IOyoaVvQIx2o1wi0IehVmgNuUHPq1i3RptPLGCq/6qcfEO
 herSomju1oN/eiL5aa/Vh7+Eaw/Pi3ftqDL5ZZzKkXUwEQqRy5DmHJ64WobUor6iB4F7
 4p0fKjGHPFcRAb0giKrAmxHWZ/Br56Omutz+VfGTV5/hpD48KFAABTrTIEqcEG/C+xWw
 ObK3vzUFKcFHRHeHlaWCkyxkUGDRx340kvsvX/e3ypZf6pVCtkwlgOAa9TJ4pgAPj+Cd
 1l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744185510; x=1744790310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=raD5gveqTqJ49JFkgn/KjUTOuwmYDlfMpEFc6AXkUDw=;
 b=k4DxYiApvxaBXKfy0/CsDMWPIZTvXFLgpqW1DOA0o8mb+95xzS6Kga1b8dFE7s66gR
 jGgWNuwUzmyrwq3WoNgEP9Y0PSl1faEmTnqFpUerAFY9svBWB5tGN1hBs7wbg0NoA7bs
 gqL3WlPJhz0UH32uoFRIEJ1rYDZtVEljQPVTcW/Yr+wKZVHnjIF8FgD6G3SQqXAv+BSR
 /SagvhcXTY6ZjkLefNCJERiNLSiqXuFJxR+/LmLA2baJkpJvgriTVUOGRePL1riqgPgA
 lv0/hf22S8sKDPM+shri/3YuGMcVJK/TgUMlbj9i3ZobkNDFD0pgSLxQnhH1M+e2IZcf
 MfrA==
X-Gm-Message-State: AOJu0Yy8f6VpAQT1gPFPr0HpG/hyT8I+oncpjE4sNUFPu+hifddGRgKK
 hPR3tt9n9dKV8AfZ67MixLHBuU07KRBjcx1W4NFgZGAPFyeMK9cVu3phAlrtKBU=
X-Gm-Gg: ASbGncsgMzduykw5kWKS6kO/BJJIHXZpC7CyPCTl3TVLYKLcSh3jaeO6Q8J5qvN6B5r
 bof587EKQQsYocJ3RotjejfeMVzuxeUcIue5KgX3x3hLLLIOUVGP+oITNZ160ih/hfIlupVl3wl
 UwByNehMilAWZZ+sTCAlhlkpZbHlLg/jw7zjlz1eHy9zbASGjqprgI9ARC6CzMiyVsBW7BUgDNS
 91axuDrmAlvzxE06GX+RpulIVJJ+7wb7WIYW3ZoxmtfabhBs2dVLnnSXNzOqG22dvtGTvrXbNcq
 WoOq0FkQ5bEdSwJdNzczdNXwkhwD/igyAhsHtB5pc/uecIJy1d3aa2eZ7C3Xkw==
X-Google-Smtp-Source: AGHT+IGS1JfSdBwV02d/bfncheDk/aeWibs0+xCLvfR9Lp/2SuxvdVYN3BaydPH77VYAh77QztxV+Q==
X-Received: by 2002:a05:6000:40d9:b0:39c:2669:d786 with SMTP id
 ffacd0b85a97d-39d88531b84mr1392234f8f.19.1744185509536; 
 Wed, 09 Apr 2025 00:58:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b82sm842878f8f.66.2025.04.09.00.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 00:58:29 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Wed, 09 Apr 2025 09:58:26 +0200
Subject: [PATCH RFT v2 2/3] fastboot: blk: switch emmc to use the block helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-topic-fastboot-blk-v2-2-c676f21d414f@linaro.org>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
In-Reply-To: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8745;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mCXcQCbnC1aiZGzrCiM0dOI/ujAKDPWG+XiC37cRV14=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9iijIkuynkxJpNbzwI451RHOoDX3RDNCQgUIY+kr
 7Ui7OQ+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/YoowAKCRB33NvayMhJ0bvNEA
 CMETJzmON/1R3aSs/hMPXERGXVw9cAHB7MsdP0COKKLEjxbnl5sew3K6SBNXUOjNEdnoydfq+CV67H
 AJmZzg3wzv9K6thn9K7OJJsR04tOghCCXtQmdcIfE5sGdYNwzPbX6TO3kzfcHf1j3SSo5XHUm7mty/
 i7BpHm0V5KIowl6j1NdpIsdOOBDKIrmkLnyaNL4mQJflgih4qg/XNLECko1o/WcuesOCHizfPKxeKF
 5b6K3Re8Q/HhlQdvG6xsb3HRhQ1H8+JXdSqycQywSbWaqX3YNmj6/xv/AfWKDl/vmQZeJTL1r8MErT
 xWjjMZdIztt6hb+qRKS2YFIpQh4bC+ufwKJA6JPtIqL+KF1PgRWo602iIa+Y3+1U+0rPHOJEwdiFo7
 cTjECuvCbR/gdWNz7+woe1ItsNqrVm1RDBIhL02QcktlJABkdp1s4YN9iaEYXAceuTkbfwM7zZuqiS
 XLL0ZggJAsDCo0q7v2CQMnqtxxQNOp9aIVowxcofvJBbAs0ba0Njr1X1SI94R3oriTkKGB+uuNUUlf
 QeNwq9RurOdfizF7IobL4M8TRE/lwMW9IGJc11VDWA7w2PwHgeclzugQhhuux3PUwFgugAQMHeF0De
 ajTqRl38HIiv9RLBxykKWSDzUnyPjm88dVxjsuZtOIhcIEekEjPSoIIHGuzA==
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
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/fb_mmc.c | 210 +++-------------------------------------------
 1 file changed, 12 insertions(+), 198 deletions(-)

diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index dca7c222f35659b22d327541b245760a6a6d7b35..11d9c8e84602c7434733c060b84c91c38772ac9f 100644
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

