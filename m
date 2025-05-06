Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD19EC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1DF8210D;
	Tue,  6 May 2025 18:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gbSW/Ow2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C331581FAB; Tue,  6 May 2025 18:10:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E5758210D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso32689725e9.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746547815; x=1747152615; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oY38sKia3A6xChXj2rxwZ2AgXIVtjFs5S4vYPxEIQFo=;
 b=gbSW/Ow2l68g0rw+vt1Kp9902lQenyGn3ZdlMW2bWnVk/AdbFz332LulW/IE09/o/B
 A20nnetzPfUXXqFuaRdkhgB5ry8jitKHp6pmCEnLqMW7NXAzGoGYxSU1ugbvx/bII76F
 88Cibxnk6s/Y9AYZmFLUhXrFbCxCPguQuoP4UX6PfJ35SHOJw9yNADlMVgqmIU7h1BGp
 fR8OiZYnplHpbHjibN1w+kf4kFqum8iBvDnZOBJAKAnm6l8jQz+I+TK/tTX7o2Cb77nM
 1fCpM0y+DYyo1gBqO5ddi9ddwXp0qJo9S54wZwT53Wj7/cSyyJntegG8ANfnkV2R3jAa
 Ps2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746547815; x=1747152615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oY38sKia3A6xChXj2rxwZ2AgXIVtjFs5S4vYPxEIQFo=;
 b=QHXqwjkESDsfCWFM6D3amMrm8Yi1s4OpjOi3SjkK+LOmO7zmVsKPw+2hWrFNf6e2CG
 JhzMVpD5sR3pNtPBfNrN+dcdYR5YB1mJsKSusVOU98GjXBuDbyVTjfxjn0VxjG3yUWud
 M6P1jz7Z18xqXikqq5rLlbsvoIH0HpKITcQS1jm9okLUzueQ2ozwnHesdAMBkMdpql46
 r8V4fL1obksmQOsy9/DG1evABI3iWf6ZYLBrblPCwvw2eZagilkOKku92MT9vmaMNcDJ
 GPgz0UK125IY0TCnr41xnDh/jspcggWJxG0dFQxhrEj3Og9GoYfnk6cuv5sf/kIrl4pG
 TN3w==
X-Gm-Message-State: AOJu0Yw7LzXbFQYW7+icNF73tkwiP/3uhPMdLG7lxQM7kXrmREH/WTPD
 DXeQLP3SZPJ2d8aNa7Txf2cphizIjXyA918Vq/iRHi/VjZIQdlrQrR4mo/OkDTKAL0epFEg+3Pc
 b
X-Gm-Gg: ASbGncsR8PlFFjFePoB7aYuw82DS6Qv3pkn/yDQUo9eGnQ5Y1bw0CGORiD7cHPJGIgJ
 KNC0KkTG/f4IJjSDBUnhxZQzVdbbv8YRSNdyXH6+rn4ebqjWKk1YtMK5+1ta4nXNSU5XDkhw2pe
 WhGaRXnYHDuq6DwK/L59C1YO2/uAKZ7GQRvJ/RJaRglxcbNtjiFfnpwzT6bzePNF6FOxqbqm2zQ
 e7IcJXDI4jmKSnyWmhGzQFTw/tnoXEjK74OoU+jITDm0FsUwvneY2hr0lPYs/0lFIl20J2W0DKv
 vCsoZj+IL3tt8xo9s2aKYerPDInKrHdDAKOLcOfjDA5gr4U0LpimBVnso49fVA==
X-Google-Smtp-Source: AGHT+IGKhkmcj3z+3Bfegemmk1tO7gPCvODxs+QSqzSTW5fCZXmq/8sqtnCD+QMxfUfKcjHvROqzPg==
X-Received: by 2002:a05:6000:178f:b0:3a0:88e5:dbb2 with SMTP id
 ffacd0b85a97d-3a0b49ea2femr47754f8f.11.1746547814661; 
 Tue, 06 May 2025 09:10:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b0dffaa1sm2103960f8f.31.2025.05.06.09.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:10:14 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 06 May 2025 18:10:07 +0200
Subject: [PATCH RFT v3 1/3] fastboot: blk: introduce fastboot block
 flashing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-topic-fastboot-blk-v3-1-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
In-Reply-To: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14626;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aRghPl5ExrSZup+p8WpxC63khnYOQJPIvZS00/FtTi4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoGjRjGfNjEM5ZmQVQNE+jxvvX+zcSMD2iWrRupCk1
 lfAYQYKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaBo0YwAKCRB33NvayMhJ0aiyD/
 94ubEQ9rzjyjUlqzEu5YiRyZ7P6YhipsoJTLiO95OBEXFbVrBcTJL8pKIqLSw2ZoS/JtIrWnIsQ53i
 nLAcXr3Ho6DHkbOEUDECGmQY6P4k3B5by4Oq0Rjmb8DdBwODvJWrMk+/HNQWF7bMtdE0PMvKPo/Uiq
 ETS2MlhutqxMl2Yf/1BwDUzE4D8B8f3Ch2Q44THfppN7YN0F0jq0DZb7ncVmnd5ayACeSzvBUj+St8
 rjLlMlEb43eZjYDksiEdtFRitJlowTWK1O7+a/5cSxonPvxSGqyHiFfPpypaLv1/P0tN2Fitlj6LP8
 3iXjF84bLWK2DS8aFhZ4wUBTh+xXRt/AKkrwOQ/2mIFVUGeD8kvD+9i9VivqlzeQ4WHL5+3J4gPa1c
 r9Mbamy0kzwIqQiK5fG9ywjuhhk7aIh0aKiwtu5WhgmNvkHrS6uxrBCfIigsuhF8SZbzS3Nksajbre
 DMP/OaaaLsRSa9AbPhZia4D37+qMp3dS57Jzup9GEM+cSZu1pjY82Zq1q/s70vwAGoExPC3znek804
 9XPSU8L8WWVcUREMXhyDrTnMyFVsP2zmrH+r8EKj8mWOPoOxuNIplZXdx3Ra7pannYe7dGF+Xnz80x
 HTjUZ8/9vMGeX/DXqMSkNeVYuunmUhCRpdjgdOXQR4Z0ycZJuDTwa8b0eS+w==
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

