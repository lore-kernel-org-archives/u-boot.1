Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECC7C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA3782999;
	Tue,  6 May 2025 18:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dzeWFvRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB501822D7; Tue,  6 May 2025 18:10:22 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A1382163
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so4384067f8f.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746547815; x=1747152615; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WF23jBpCJ1tyjHiXL5OSRL9eZIslHT12Wv1X4psD4+o=;
 b=dzeWFvRk+7tgaa/Jh24GBuXXlTXT0xuLdbsASWPP2dSjUru2axJXRo25HZjTYx+1JJ
 N8sod23BjTISJAHSVMQNcGtjbvm3l8VL7aEPQeemsMEpKeIbj0UJLfLSnB81UYMUqUug
 f7iTjNYA40IowiTtdNj1/o4PbGLV3jC6aWxAPJfPloCGCo721oCxTIWUXd7Wvc5YTe9k
 wlDbgUg766pzKE8Q7tsMNXb4OuKN7M87riVBWK00LwWKxN9Nwu3tzQjWRrhEhV05HYjU
 VezL5eIw1LAbzZgdyIPBbvraDqkWnuX1l1pcGCKr8mUORPd+feRqcF29P43O++Z/nBpz
 kIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746547815; x=1747152615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF23jBpCJ1tyjHiXL5OSRL9eZIslHT12Wv1X4psD4+o=;
 b=pT8V+wTeE0+k4k4Rid/vhNzAi9cWQ0TXvoWgIhc96lNdHvpL4S2ZkhoLU2T+qui6MU
 GHx8H8aKIaK12cJdGBWIRW8AHK5LHga3Z0xw2tnx60JoeU3/AMPReEJePwDbsv6IJ8Bk
 ua/bQR9D1FrbGIE8TOrs0cJyru9Cwch+EiJo/2zUKGIO1seegHbQVMkWK4V8I6Qqug+q
 iEJ9nAazhqy8YMX7slddqOTSTf9sRqHBiyiDqUZ/n92wT4CG+YlzRe2F1PGzH5eTFqbN
 OhwMNjE2SqRohcpRJBmtczV2BtmAWo2G85BlWQ5ctIs0NEk2aGkTAjpnQj2T9I1Wzu7y
 6ZHQ==
X-Gm-Message-State: AOJu0YzWS/sy90GEWXPVi0ZVhVqkGHnJ3GoOhYX5wNBQ4Mf5RbmHSW3E
 lRQA3sRbJa9jgvSpFXcZMZjZCJ5sin6qaBf2eCbTb++fGPAljuRXkwRUeudoovQ=
X-Gm-Gg: ASbGncsD9emrE3zX47xjZP3nRFZYRWg6HR/t+kTZuDkt7TVW1ov4CIsPrwiNCq3hDrn
 shE5FZ/ZuvRyOT/qErtsgS11+R0e3AaUhr1aHg55nnnCKduIkceuUXfLp6saJSL/Uo7EHaIOdUd
 JPlgsMk77zEpqlW4LFFBgAWwZ980U4kmkKPuSO30zJ5y1jqcoe12rRmIFsvQ7VFxl4oPqiCxogx
 hAlRRZddamEkdyfb3w0XACSq+iSymuEHame1aD0rWvl4LgVoePI2rZhBxA0JQj941WWRXe4jVb3
 /KWsb4vkKZ8xTTb8cytNQyL8LGTWhvWDrYaaF2Obo/a+GB2VrKVuOm0KrSl6nA==
X-Google-Smtp-Source: AGHT+IHkJWsQHn12J5y8vljK+pTCZbTjfqX809QAvjT0C0LMoC+C6b8V88H/pMjQXVqEaFeQmqll6g==
X-Received: by 2002:a5d:64ac:0:b0:3a0:90bf:b9b with SMTP id
 ffacd0b85a97d-3a0b499c71emr67346f8f.8.1746547815441; 
 Tue, 06 May 2025 09:10:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b0dffaa1sm2103960f8f.31.2025.05.06.09.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:10:14 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 06 May 2025 18:10:08 +0200
Subject: [PATCH RFT v3 2/3] fastboot: blk: switch emmc to use the block helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-topic-fastboot-blk-v3-2-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
In-Reply-To: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10101;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lHkkgroSNmeyt5PIPA2eY/TP0/y3BXJ8Ah6LMg1/Ybo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoGjRjrrmWInY/EtBN8AkNbpMWVdnDN1yOMlEjpFWZ
 WrHdKPWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaBo0YwAKCRB33NvayMhJ0aMrEA
 CSdEbAiX+qWzSeIe9Z/I+FLhVMTa3NrJdwov+M856UsVU9f9jL7drYUzVv1d1KqfoPveCsMnVxD2w+
 9HAMUWFx6Wx/BcCYpoc8FmPcdRAlXcmj22FOJ1bDfTxvtxVH2PZTQhPzqAbD0g2g9nV54yNATTbvMq
 Xn+i7coj/jQOBem2TmB4QZPmUynyX6k/Y21meqxUIbY/g9KXkZf30Fn6eptJo15s5BwV7pM1fc7TZF
 PiszeTFT3+Os53AgAIGdSCyDZv0hiObAPf0cRh6lS1pTRCEHTgjrM0cWiez9ETf6mNmM5sneTmMVEE
 u6xOKmDB6amRSgfujIvvCvkZlkN0vHqIcCYfOf7hIkk2a3aqc+7WHNRkvyZZuEgxyl5ma9fMxOk0gY
 pLQ+sGxqAO2bv8YCFAOHjbyfGEvNsnb/ma9zvmTqYtqk7BhT+ZBaaU+CuksgHe0NJRVRv2MJMcjHqH
 FVGFIT66w4X9sZigY+4tTqvX+CW51hbqpTvyVyth3dd0lzc9Yz+ieKsaTNPd0bF5HvTitf9OjJ4lGg
 CLWVPGYk0l6Oiyng3WdF65XIv4owfZ7tPrzpqpA5S0gVXYPMO876W6bPg5NmymE3KDQXn94lBZ9rHi
 XAoYQxWFh6gDlLWOVC7Z3wr8G3Q7IOHIyEA4oy2N6u3Mjxi1qkpFmAFFQ2xw==
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
 drivers/fastboot/Kconfig  |   4 +-
 drivers/fastboot/Makefile |   3 +-
 drivers/fastboot/fb_mmc.c | 210 +++-------------------------------------------
 3 files changed, 16 insertions(+), 201 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..33825ee408fbd9aff26cd390a140421c7c98ecc3 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -113,7 +113,7 @@ choice
 
 config FASTBOOT_FLASH_MMC
 	bool "FASTBOOT on MMC"
-	depends on MMC
+	depends on MMC && BLK
 
 config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
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

