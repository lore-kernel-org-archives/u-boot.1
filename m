Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A12AC8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B28682EB8;
	Mon, 30 Jun 2025 17:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="On4SbVD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5257182EA9; Mon, 30 Jun 2025 17:20:08 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBAB80B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453608ed113so23343005e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751296801; x=1751901601; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/YPHwMzz1kHeByJZyGaprIJA3EOq7dCpM2gKxh2o3z8=;
 b=On4SbVD3DXfY93iYWrQWnUsvlIKTo48G/88B6qrGPeAaBXhehfFWNTEpbcEBq3bLkr
 i8TvBCz8qMU6/lMOEZPBAAe63AJq8LhBu08PqicRApp21x+MmsMs2yDMHbvNLHQSb35p
 buPkbMFkuPIypB0mDljskVievy+4yD+ZhY8mXPJ2fsEbA98rvYga88K3rXEpqerXkIBU
 WqUw+vd6jy0Pz62epXZuXRbD10ZNFbyk+5mwrvvgLCHzJNctNqWYA1hfof1vn+S5NuiC
 b0nce+doXed+Ch/SF48BH7CCneySoYjYVdF/3Zy11MyHgGG9leaMoWvI4aOVO/UfrowW
 Arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296801; x=1751901601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YPHwMzz1kHeByJZyGaprIJA3EOq7dCpM2gKxh2o3z8=;
 b=r/TaK5qCNQG9G+Dyf+VGzhC0aOfPdagsexvdsRAc2QjAmirxAxJ5+BfYIx/8LWxFud
 WoeVeyoRZB1dqmx1kiBtRpjNFmMc/1N1XAm1JIUeKFJL8jGORyHxwRhpHbReheESuh64
 SBQVDyNC6exuEC8eUgBZboodNeJE8PrCLjcINXJAJmdWHye2v6uAQJA5eeYQgwiNb4J1
 HvC0QoOta1p3v6IO6TdhFxWp7tWSMABWCvof3vW2GA38IhNToUWHCeh9DqRSpAdtQrun
 mVOpjQFfVmslOinYEJCLoZEEru7zwj0r1Vm9yGAUjJFvN1ixWUQO/xpXxlfSChHLFI7I
 Uakg==
X-Gm-Message-State: AOJu0YzMtdHMCXcSpTAJuZuCHcikgnqUUbkTVZROLF5csnDCD8GN8915
 NjTHmxyUmk6/I+ElSCFBKwIe3ZF1vxNaXPG0AAc3cohxxL3BRh8pqLq2u4sYyRO7DtY=
X-Gm-Gg: ASbGncvKQiItx2mOEMu5icmnGm+BXcM6ZlbJpwvHAF6qyvTIgj+BO5DQsm4OIy5w+Cd
 +mLUhFA5ANzaEBk2ZMhtDp4OQuhnEl4DbJVzXsU+KzYt4AE/bc0mkEgMTOFal6/BwOIkZvwL7qH
 VPTro5MhJ5bxP9LUJIngf5k8upDiH1uML+NOJgl9m23hdNnBVCbDikDJQ94J+CLRq1Qp9h6cIf0
 ynvIxfYEO2CHxRd84iqWiDxaFiplczcLEtAebwB0t3dJVL4U4/a3oObcOFhlEhUMa5nJFrN0hJa
 EBuU8Mhs9byQBjQ5sMDHLSaS+mfTYi/r+QheD9hYGPCBCJqAiG3IrcSQedkcU+nUVPFONOmS61X
 JcsR6cCI=
X-Google-Smtp-Source: AGHT+IEwAK0o6fAVptq0q28n9mTXsx9QZU/3ZvAimAH26pMYTtz6oxZ3TdPKvS8S5ViPtp7gZBrjXw==
X-Received: by 2002:a05:600c:c4a6:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-4538ee70e24mr138447815e9.18.1751296801379; 
 Mon, 30 Jun 2025 08:20:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad03asm170432295e9.23.2025.06.30.08.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:20:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Jun 2025 17:19:57 +0200
Subject: [PATCH RFT v6 1/3] fastboot: blk: introduce fastboot block
 flashing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-topic-fastboot-blk-v6-1-7cdfd3a24786@linaro.org>
References: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
In-Reply-To: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14744;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=u38gyfBbqcgweukdputMcJtzWtuesaIscq4GIrJIkOU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoYqse0XiMotbeYdRkACRFh0lIxwThV4kx/cMDrRZy
 W+ukLvyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaGKrHgAKCRB33NvayMhJ0cTYD/
 9I8Xz5XvxsRVDPP5ZHMM20ZkOgcHWDE2aumdHvrgoQr3NIHqdKoVOaX9TK9u0Vk32DB79QJLekIYMa
 gWP5s0UMOTue1y6Hgo27bZkxu6t/W1y1uX7S4nZyUEpMKLrSo99Y5Pae6x74rYE6l9tgxiEsRizX0W
 kXq7fp/eputHKlpCDwgfL7ATOu63dkPUIvXd2KRiMm5TTc1Z3WGU+kU2TjJ8shs6cL5JbGv5Cks1BU
 q99uxgxMtLuf9XYQ+kTbtbKqu+mEf9XpSISL6uhBiIB0mcCXyoJqdIr7x86KvYSrDJWmskrvd/Sn5D
 N3mTJeKujQ2icNBf0IhRVVnJG140h9yMfdCswx2jYhCdZXg716dAetEmi11EnZHWCcGi+fE84KzFiX
 Jq+EXf86o86wzMF8Qt4wD9D7/7lLJVr6eFLywqE/KAAwMuL7y2pFSMLOcY49tKKR71o+gE5D9kFV23
 O5dFjgbNu5cQRtvMx00SjgI2lXwZRjpL2cUO/sRiJr8y15Q5DHRzq5R9wG1ncJISLMWx1soGfViAO3
 nQvdRUnB/QmmQUY/CiTvCQqnwdVW1ua8pDp1uz5UJVfyR4W4QwnfPS2iSfMDMyZnsFttKV+V6TlDlx
 024evzbGy5fdS0JZ0DRmknqAhWmmMZJwIVRhSsQSebwmwgHvxMfRBDYmfEtQ==
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

Introduce fastboot block flashing functions and helpers
to be shared with the MMC implementation.

The write logic comes from the mmc implementation, while
the partition lookup is much simpler and could be extended.

For the erase logic, allmost no block drivers exposes the
erase operation, except mmc & virtio, so in order to allow
erasiong any partition a soft-erase logic has been added
to write zero-ed buffers in a loop.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/fb_block.c | 323 ++++++++++++++++++++++++++++++++++++++++++++
 include/fb_block.h          | 105 ++++++++++++++
 2 files changed, 428 insertions(+)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
new file mode 100644
index 0000000000000000000000000000000000000000..b725397c91af2717812e69e2b624076eb30f781d
--- /dev/null
+++ b/drivers/fastboot/fb_block.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 The Android Open Source Project
+ */
+
+#include <blk.h>
+#include <div64.h>
+#include <fastboot-internal.h>
+#include <fastboot.h>
+#include <fb_block.h>
+#include <image-sparse.h>
+#include <part.h>
+#include <malloc.h>
+
+/**
+ * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
+ *
+ * in the ERASE case we can have much larger buffer size since
+ * we're not transferring an actual buffer
+ */
+#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
+/**
+ * FASTBOOT_MAX_BLOCKS_SOFT_ERASE - maximum blocks to software erase at once
+ */
+#define FASTBOOT_MAX_BLOCKS_SOFT_ERASE 4096
+/**
+ * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
+ */
+#define FASTBOOT_MAX_BLOCKS_WRITE 65536
+
+struct fb_block_sparse {
+	struct blk_desc	*dev_desc;
+};
+
+/* Write 0s instead of using erase operation, inefficient but functional */
+static lbaint_t fb_block_soft_erase(struct blk_desc *block_dev, lbaint_t blk,
+				    lbaint_t cur_blkcnt, lbaint_t erase_buf_blks,
+				    void *erase_buffer)
+{
+	lbaint_t blks_written = 0;
+	int j;
+
+	memset(erase_buffer, 0, erase_buf_blks * block_dev->blksz);
+
+	for (j = 0; j < cur_blkcnt; j += erase_buf_blks) {
+		lbaint_t remain = min_t(lbaint_t, cur_blkcnt - j,
+				erase_buf_blks);
+
+		blks_written += blk_dwrite(block_dev, blk + j,
+				remain, erase_buffer);
+		printf(".");
+	}
+
+	return blks_written;
+}
+
+static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t start,
+			       lbaint_t blkcnt, const void *buffer)
+{
+	lbaint_t blk = start;
+	lbaint_t blks_written = 0;
+	lbaint_t cur_blkcnt = 0;
+	lbaint_t blks = 0;
+	void *erase_buf = NULL;
+	int erase_buf_blks = 0;
+	int step = buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_ERASE;
+	int i;
+
+	for (i = 0; i < blkcnt; i += step) {
+		cur_blkcnt = min((int)blkcnt - i, step);
+		if (buffer) {
+			if (fastboot_progress_callback)
+				fastboot_progress_callback("writing");
+			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
+						  buffer + (i * block_dev->blksz));
+		} else {
+			if (fastboot_progress_callback)
+				fastboot_progress_callback("erasing");
+
+			if (!erase_buf) {
+				blks_written = blk_derase(block_dev, blk, cur_blkcnt);
+
+				/* Allocate erase buffer if erase is not implemented */
+				if ((long)blks_written == -ENOSYS) {
+					erase_buf_blks = min_t(long, blkcnt,
+							       FASTBOOT_MAX_BLOCKS_SOFT_ERASE);
+					erase_buf = malloc(erase_buf_blks * block_dev->blksz);
+
+					printf("Slowly writing empty buffers due to missing erase operation\n");
+				}
+			}
+
+			if (erase_buf)
+				blks_written = fb_block_soft_erase(block_dev, blk, cur_blkcnt,
+								   erase_buf_blks, erase_buf);
+		}
+		blk += blks_written;
+		blks += blks_written;
+	}
+
+	if (erase_buf)
+		free(erase_buf);
+
+	return blks;
+}
+
+static lbaint_t fb_block_sparse_write(struct sparse_storage *info,
+				      lbaint_t blk, lbaint_t blkcnt,
+				      const void *buffer)
+{
+	struct fb_block_sparse *sparse = info->priv;
+	struct blk_desc *dev_desc = sparse->dev_desc;
+
+	return fb_block_write(dev_desc, blk, blkcnt, buffer);
+}
+
+static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
+					lbaint_t blk, lbaint_t blkcnt)
+{
+	return blkcnt;
+}
+
+int fastboot_block_get_part_info(const char *part_name,
+				 struct blk_desc **dev_desc,
+				 struct disk_partition *part_info,
+				 char *response)
+{
+	int ret;
+	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						   NULL);
+	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+
+	if (!part_name || !strcmp(part_name, "")) {
+		fastboot_fail("partition not given", response);
+		return -ENOENT;
+	}
+	if (!interface || !strcmp(interface, "")) {
+		fastboot_fail("block interface isn't provided", response);
+		return -EINVAL;
+	}
+
+	*dev_desc = blk_get_dev(interface, device);
+	if (!dev_desc) {
+		fastboot_fail("no such device", response);
+		return -ENODEV;
+	}
+
+	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
+	if (ret < 0)
+		fastboot_fail("failed to get partition info", response);
+
+	return ret;
+}
+
+void fastboot_block_raw_erase_disk(struct blk_desc *dev_desc, const char *disk_name,
+				   char *response)
+{
+	lbaint_t written;
+
+	debug("Start Erasing %s...\n", disk_name);
+
+	written = fb_block_write(dev_desc, 0, dev_desc->lba, NULL);
+	if (written != dev_desc->lba) {
+		pr_err("Failed to erase %s\n", disk_name);
+		fastboot_response("FAIL", response, "Failed to erase %s", disk_name);
+		return;
+	}
+
+	printf("........ erased " LBAFU " bytes from '%s'\n",
+	       dev_desc->lba * dev_desc->blksz, disk_name);
+	fastboot_okay(NULL, response);
+}
+
+void fastboot_block_raw_erase(struct blk_desc *dev_desc, struct disk_partition *info,
+			      const char *part_name, uint alignment, char *response)
+{
+	lbaint_t written, blks_start, blks_size;
+
+	if (alignment) {
+		blks_start = (info->start + alignment - 1) & ~(alignment - 1);
+		if (info->size >= alignment)
+			blks_size = (info->size - (blks_start - info->start)) &
+				(~(alignment - 1));
+		else
+			blks_size = 0;
+
+		printf("Erasing blocks " LBAFU " to " LBAFU " due to alignment\n",
+		       blks_start, blks_start + blks_size);
+	} else {
+		blks_start = info->start;
+		blks_size = info->size;
+	}
+
+	written = fb_block_write(dev_desc, blks_start, blks_size, NULL);
+	if (written != blks_size) {
+		fastboot_fail("failed to erase partition", response);
+		return;
+	}
+
+	printf("........ erased " LBAFU " bytes from '%s'\n",
+	       blks_size * info->blksz, part_name);
+	fastboot_okay(NULL, response);
+}
+
+void fastboot_block_erase(const char *part_name, char *response)
+{
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+
+	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
+		return;
+
+	fastboot_block_raw_erase(dev_desc, &part_info, part_name, 0, response);
+}
+
+void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_name,
+				   void *buffer, u32 download_bytes, char *response)
+{
+	lbaint_t blkcnt;
+	lbaint_t blks;
+
+	/* determine number of blocks to write */
+	blkcnt = ((download_bytes + (dev_desc->blksz - 1)) & ~(dev_desc->blksz - 1));
+	blkcnt = lldiv(blkcnt, dev_desc->blksz);
+
+	if (blkcnt > dev_desc->lba) {
+		pr_err("too large for disk: '%s'\n", disk_name);
+		fastboot_fail("too large for disk", response);
+		return;
+	}
+
+	printf("Flashing Raw Image\n");
+
+	blks = fb_block_write(dev_desc, 0, blkcnt, buffer);
+
+	if (blks != blkcnt) {
+		pr_err("failed writing to %s\n", disk_name);
+		fastboot_fail("failed writing to device", response);
+		return;
+	}
+
+	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * dev_desc->blksz,
+	       disk_name);
+	fastboot_okay(NULL, response);
+}
+
+void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
+				    struct disk_partition *info, const char *part_name,
+				    void *buffer, u32 download_bytes, char *response)
+{
+	lbaint_t blkcnt;
+	lbaint_t blks;
+
+	/* determine number of blocks to write */
+	blkcnt = ((download_bytes + (info->blksz - 1)) & ~(info->blksz - 1));
+	blkcnt = lldiv(blkcnt, info->blksz);
+
+	if (blkcnt > info->size) {
+		pr_err("too large for partition: '%s'\n", part_name);
+		fastboot_fail("too large for partition", response);
+		return;
+	}
+
+	printf("Flashing Raw Image\n");
+
+	blks = fb_block_write(dev_desc, info->start, blkcnt, buffer);
+
+	if (blks != blkcnt) {
+		pr_err("failed writing to device %d\n", dev_desc->devnum);
+		fastboot_fail("failed writing to device", response);
+		return;
+	}
+
+	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * info->blksz,
+	       part_name);
+	fastboot_okay(NULL, response);
+}
+
+void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
+				       const char *part_name, void *buffer, char *response)
+{
+	struct fb_block_sparse sparse_priv;
+	struct sparse_storage sparse;
+	int err;
+
+	sparse_priv.dev_desc = dev_desc;
+
+	sparse.blksz = info->blksz;
+	sparse.start = info->start;
+	sparse.size = info->size;
+	sparse.write = fb_block_sparse_write;
+	sparse.reserve = fb_block_sparse_reserve;
+	sparse.mssg = fastboot_fail;
+
+	printf("Flashing sparse image at offset " LBAFU "\n",
+	       sparse.start);
+
+	sparse.priv = &sparse_priv;
+	err = write_sparse_image(&sparse, part_name, buffer,
+				 response);
+	if (!err)
+		fastboot_okay(NULL, response);
+}
+
+void fastboot_block_flash_write(const char *part_name, void *download_buffer,
+				u32 download_bytes, char *response)
+{
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+
+	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
+		return;
+
+	if (is_sparse_image(download_buffer)) {
+		fastboot_block_write_sparse_image(dev_desc, &part_info, part_name,
+						  download_buffer, response);
+	} else {
+		fastboot_block_write_raw_image(dev_desc, &part_info, part_name,
+					       download_buffer, download_bytes, response);
+	}
+}
diff --git a/include/fb_block.h b/include/fb_block.h
new file mode 100644
index 0000000000000000000000000000000000000000..189c708e2f0eaccf4871f68f93c8d38eabc4349a
--- /dev/null
+++ b/include/fb_block.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 The Android Open Source Project
+ */
+
+#ifndef _FB_BLOCK_H_
+#define _FB_BLOCK_H_
+
+struct blk_desc;
+struct disk_partition;
+
+/**
+ * fastboot_block_get_part_info() - Lookup block partition by name
+ *
+ * @part_name: Named partition to lookup
+ * @dev_desc: Pointer to returned blk_desc pointer
+ * @part_info: Pointer to returned struct disk_partition
+ * @response: Pointer to fastboot response buffer
+ * Return: 0 on success, -ve on error
+ */
+int fastboot_block_get_part_info(const char *part_name,
+				 struct blk_desc **dev_desc,
+				 struct disk_partition *part_info,
+				 char *response);
+
+/**
+ * fastboot_block_raw_erase() - Erase raw block device partition
+ *
+ * @dev_desc: Block device we're going write to
+ * @info: Partition we're going write to
+ * @part_name: Name of partition we're going write to
+ * @alignment: erase start and size alignment, specify 0 to ignore
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_raw_erase(struct blk_desc *dev_desc, struct disk_partition *info,
+			      const char *part_name, uint alignment, char *response);
+
+/**
+ * fastboot_block_raw_erase_disk() - Erase raw block device
+ *
+ * @dev_desc: Block device we're going write to
+ * @disk_name: Name of disk we're going write to
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_raw_erase_disk(struct blk_desc *dev_desc, const char *disk_name,
+				   char *response);
+
+/**
+ * fastboot_block_erase() - Erase partition on block device for fastboot
+ *
+ * @part_name: Named partition to erase
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_erase(const char *part_name, char *response);
+
+/**
+ * fastboot_block_write_raw_disk() - Write raw image to block device
+ *
+ * @dev_desc: Block device we're going write to
+ * @disk_name: Name of disk we're going write to
+ * @buffer: Downloaded buffer pointer
+ * @download_bytes: Size of content on downloaded buffer pointer
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_name,
+				   void *buffer, u32 download_bytes, char *response);
+
+/**
+ * fastboot_block_write_raw_image() - Write raw image to block device partition
+ *
+ * @dev_desc: Block device we're going write to
+ * @info: Partition we're going write to
+ * @part_name: Name of partition we're going write to
+ * @buffer: Downloaded buffer pointer
+ * @download_bytes: Size of content on downloaded buffer pointer
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
+				    struct disk_partition *info, const char *part_name,
+				    void *buffer, u32 download_bytes, char *response);
+
+/**
+ * fastboot_block_write_sparse_image() - Write sparse image to block device partition
+ *
+ * @dev_desc: Block device we're going write to
+ * @info: Partition we're going write to
+ * @part_name: Name of partition we're going write to
+ * @buffer: Downloaded buffer pointer
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
+				       const char *part_name, void *buffer, char *response);
+
+/**
+ * fastboot_block_flash_write() - Write image to block device for fastboot
+ *
+ * @part_name: Named partition to write image to
+ * @download_buffer: Pointer to image data
+ * @download_bytes: Size of image data
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_flash_write(const char *part_name, void *download_buffer,
+				u32 download_bytes, char *response);
+
+#endif // _FB_BLOCK_H_

-- 
2.34.1

