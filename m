Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F170C5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4107A82AFC;
	Fri,  6 Jun 2025 11:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AQSd7LKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A338082AE9; Fri,  6 Jun 2025 11:33:16 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4594882AA7
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1497467f8f.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749202392; x=1749807192; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EEjue6a//58KimZBKjkj7bMaZyR7hvKl1178M90j21k=;
 b=AQSd7LKyTAxhOyDu9TFEUWK9pk+8oJJsGtvIG7ONbLitF7lSBKpuzc+qzJdtzovbmW
 gzeWfFs8XvHloonLSEhmNAefgv4s3+gPzt5VmgHMTjdTEErINPmanvM+NQcNGKFdXZYn
 wxiLLOZAIfOQJr0TZVHfmNasmOXKK6by/eiBTOTBD1kCvglq1etRjKg5Fti0q8YZblqf
 5bMT5Oa18y/5ElAPz5+0hBqQ6df7+doOvM9Ro3V9hwR790xellfF3YfihqxvCNtDh66y
 nq0YWAQwpWtLymj8NvH9LaGTzOgF2jArbtbbUIU+oPN9Bh2MU7CXZGsRp3eHLlaxx7Us
 Zqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202392; x=1749807192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEjue6a//58KimZBKjkj7bMaZyR7hvKl1178M90j21k=;
 b=NdbJKExGDi3B8+pJUylaM6yfKEPx/kM8MjD58IOBN7iVHwuhSlhd7oZC0Gv0UM0u8f
 Bv4hOwS1vE/J6W1AEuJc+wRolLDxX8aA5MeWoBgFW0reFvy+2cVjd6gfyiDHfDskKzPn
 W9VgNg675AmM4pNA71gxKcN407tXTuPkENRbAW2pPUlv6tGF67N7B9/KVsnRMVRAHYlA
 KWUItqZs349wiEsSegNqlWqGYAse0ARtM11fd2McFRlcR7BslvFo0KVLbw1U6bRAaRSB
 PjN/T41TPqUXJ0eluPZczgxewPvhMynHyMHhCc/dnbn0CK2Vir7bYvLlWbQbjbfMU/wh
 20Lg==
X-Gm-Message-State: AOJu0YyB7awZrOMIBUR3y2RPG1T6jwSMaUNBT3oY03CixVl8hNLTBAXQ
 j9RaTZMPD8KJCHUjGQWvCgghM4vsJj0/MyqYKaoI/kygUT80M1qRbM11AFo2CaSk6lQ=
X-Gm-Gg: ASbGncu1U1lO2Dc4RSuX4C4C946CW5HG57FfcnrZMgA0GzBAcmi4DDxBr00Fa2lm51g
 fYpkxqlbF0U70EKz2VXQDRk45ni+nFqoYX+UOj7T0yLfMOgvSRAYTOzqb333rRY+6RY1OeolJ2C
 AIAlCKenjXKKQ051qdqGb6yygTQ+AnSThn+uMvTsBW85RTj3Yq4XbtIqOiqUz2p62mhk/IYRrQS
 oMHFSHe+odn5N/b80EPGf4THuQ+xzcU4MD/7TMYl2rraA8iZnAHTFsAao2GUzXnUiBLB7BX5kUy
 YPh6hmyrAjcdv4lFHI7rActbJ75IC2g2bL8Ae66+E3+QUbjwEUoQg0zgAcAJkxuGjepFd/Td8Oy
 FTtwR2Wpx7ab5iXqPdg==
X-Google-Smtp-Source: AGHT+IGqbCXELRvv/zPcoiuQDu/8ArQiUtzYi4ymZ8Zhnxifqato5cNm95lwvJQ5f+jzrJHJQTbhMA==
X-Received: by 2002:a05:6000:288c:b0:3a4:f7e6:2b29 with SMTP id
 ffacd0b85a97d-3a53188d91emr2516776f8f.5.1749202391555; 
 Fri, 06 Jun 2025 02:33:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532452d7esm1302439f8f.85.2025.06.06.02.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 02:33:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Jun 2025 11:33:08 +0200
Subject: [PATCH RFT v5 2/3] fastboot: blk: switch emmc to use the block helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-topic-fastboot-blk-v5-2-203538ec5b32@linaro.org>
References: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
In-Reply-To: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9409;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=i00E8Gtz4m/2fVqy2mO1ocM94d9KHU3NlieYR42vMkk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoQrXVLpt6ojtulDyuOFQhgBTD5/r9ZbxDX/NYN1xk
 bDjirQuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaEK11QAKCRB33NvayMhJ0V6UD/
 47veE8LWE2Z9YvK3QgMwsb3Mr/dywTFzhjlfjSGtwY9NIAeyltwF7sR40mpbH0ZCDai8lrcZFSa1MW
 igczZIaJrcQh7WRkJVkj1uzGiwXIfqEDcX999kaBJDBLJLFJDYIYhdAdJ4U85HL8PdHHlWgh9yV4l3
 1ttCDTOKhQVm2dqWr9hip9QwyLhEusFy8CvzjkldpF+cJyCVjqnFi9j/nUo4xtoaTt/aXtd6CpGvH7
 rNWCcSrAYxJRKPCb5OjCzIRGLE3oA6U3iRLd4TruDOA/X/i1hEQKODGlx+fz0OiI5+2rFNyHsArNY+
 8kRuW0h5A16LY6XLed8kXiIAuUPDwXyL/vJmj4jqRXnY/x1hS/2Ics0bWBr8wGhtoe3fDcmQJe9zi9
 rtEBdgAqn5iH50LwwxvJ2Rhd0hr5TN5VoECKCEhaJ4YYBs3C+HTeXbHzjrNKW0+/tfV0RgFXF9SRuu
 psfWYDglat8wjDIVGGDldUhjONbfy8PV/p+R07nCCyMO2bTL8xBesXI+pz0SkUaPzcqM8woW+fhpV1
 QzRVKmwyHOJBH0ucZdpb2yxWmhKyg5jk28RS5WZsjEhJgcQjbMrMSjrvG/a04gawM2jg1tZ5Fq6M2Z
 ZTnEfNu2EE7n12gFhZLwHAbANzZwfrT0nPSbPKgVVuX2gAm/68Uv1gV+8FdQ==
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
index 048af5aa823436956142a536c5f7dcf1a8948726..c2214c968ab357371f5d3d27ecc9c1a3e9404e89 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,5 +3,6 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
-obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
+# MMC reuses block implementation
+obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
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

