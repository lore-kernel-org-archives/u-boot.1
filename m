Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1116C369A2
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD778359C;
	Wed,  9 Apr 2025 09:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="coya7uJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F094483560; Wed,  9 Apr 2025 09:58:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A7183577
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so60565965e9.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744185509; x=1744790309; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qp6cAqIfyW9GT+Pwo9ZmaRmWBJEraNykSyj/cS5pA9A=;
 b=coya7uJ3hbnp4ZGVFLyd2p15gA+pZKivd933+SrtKSk1MS6RU8XMytCBYi1ir5ODVC
 I69Q+KCIn68w/zysrARpaUoSYVjEqRdEr9nWHNoQVvwJlN3/XBmmBegtEf7ffuK0YRDv
 upuhrToBXQU6TQnb/Vv5ZWsEYKSXXNaIyI8rrPrnmedOxuugKW2Kilov58C3gw2RGdAB
 hcBYQa/XywZn7KyWPpHc5S7Lkk0F+N0yNFBCeb4X0x8tfftbY8fWQzLOy8hpGJngINDj
 YmIMqK6oIftZPfgwfwxB8ShaEFc7EWE6iJ8OJKXEmvDM/IcW+ljQOJqXCI4QcGDU5xam
 +8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744185509; x=1744790309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qp6cAqIfyW9GT+Pwo9ZmaRmWBJEraNykSyj/cS5pA9A=;
 b=FU77vNHgFIMO2Nc6iwLXaFy5qtw7cJGmzMKKdVb9oTiANuumiF0NzR0QP4CQMvFI3Q
 pgruvV5KDuMmh23DuvTaVksRFPh2HfgxEmw0D9DkgUyOe73Bd/Nt7E0ub7qTkmRnfBmE
 6jsMQ5aPgG11PVRnVmPKyIkM7YJ7evUMILkpnoppEVGHbN+u66va5HfCcKGcw4K/aQKb
 MxdyLtw4FfAuUSn/QmH3xhZiJDgSTLAjecIvoTD571/roWtNFazxTHRZC47csq5QSK0g
 KxWDtUmQiZhAv47/6aCpWHNk70Na+cYXaxh7/lPf0DPBFHty9w1l9ymIADng9w4LxLU8
 PXfA==
X-Gm-Message-State: AOJu0YzeZfUBGUXZdJ0js4c6x64m0kT7SL0fgrMNu/zwJbMn9VRHyefN
 ps5OGE9IqnQkhMJZBRlogF9i21A0HMLuqmMbuto1b6kRjC5pR6dc36b3rGtgEUE=
X-Gm-Gg: ASbGncs8oSlE+IBZjsQ3NmjIpn4u69wM0K/qxWXh/9OeRE6XHWLQahtmkxEvIcyqExV
 itkDwA9IbnV1OoppD4qdbrLR+uqXiaQCEHnxqTUjcSgkUgntEfacLTKHXNPqBbSXxPHlcP+pu0y
 HsxxXcy0ITJjIlFbJjasrWnL2XgBRk65p36XTJikh/8IRelruQCFMSb/FmmLhiy52edQAvtgjuD
 fjXKaNk2Tq6LH4ujgtoKvujXCNp1armbMCtCxULH9ikG9q2PpwwYYMcV59KoTxuICBGfM0DX+cU
 wnVEywKY49bbCsn8bVrhCTh0ah57dejhLutd65jOs2EhvvGzNfJOSvI8l3NdIQ==
X-Google-Smtp-Source: AGHT+IGGY3quzvjxznqLoVbUY5pYLzns2nPQ240Zw14yB961rdZIcQLtXQNxOqtfv3FReVGBBF8HUA==
X-Received: by 2002:a05:6000:4287:b0:391:38a5:efa with SMTP id
 ffacd0b85a97d-39d87ab3ea3mr1694829f8f.23.1744185508956; 
 Wed, 09 Apr 2025 00:58:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b82sm842878f8f.66.2025.04.09.00.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 00:58:28 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Wed, 09 Apr 2025 09:58:25 +0200
Subject: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
In-Reply-To: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16524;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HFmRuVXraUgNaEbTDKPDtzIrOLJuNTfnOevhdlrH3eI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9iii/aaCcQuSEjGnupR1r/3R/9b2RmCnRr/s5WXK
 rLdUYraJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/YoogAKCRB33NvayMhJ0UVHD/
 9C4wY2trJaigto+4YYTyF0PGK6twrJepX00hIzP0XBOdPG0KNy4TGf/PBnXk6CxtRQ3pO1vPXLwIPd
 llV9Gt9PFXQ4agYjvIP4pUw3hlY29MrycqYOM3WntnOAJkj0oxw7130cQeX0oc4tQP7UUsHR/bt3V6
 kWDd7hNu/AeI9Kt7+M1Cuj8PFWwpdch5yuxDBH7O9VJGJguEEKeirfownbJI7NId0ISWCTz6e+6Wxg
 2lCxU7Hne4BUPc+OpmNhLsitoIi4VtnVFiQDphlw+Af7xa/yfU8fvUOgFIBMWl93cj3O4fkkV8Jh4d
 8gO4ABeYcQ3z8obDmqIQPYJozRMi+lfNQVgNJM/SkMy2/4eT6xVj5DsBCkGvZYGdql1XHYSp+4RYXN
 +PnCDzUQOjcNOUXVx5z2AyDz/KRJ1d6w1zvbkne40zoVlI/qu/oXyqtpuU6DwWPeiVfRfnQxAFCslX
 Tca4Ov/Jo/oRIg9wvw/RUH4bupfZ7jGsxJGXymElZNT22NIlfT+X03rRyN09pphkKNl+5n4LQNLI90
 aS8u0kwADWlBz0O20fhqQ2hl0TOYcHSgmRBcWsHOH4iNFxnY+tZ3rnpKdRsmp/yI+YBx0UKGKsfOD5
 +7sxIta5bnDEwpkqpeqX9SMGBEm8z1Ks6Sx0UXo4d+35l7dAebtp9+o4Xmyw==
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
 drivers/fastboot/Kconfig    |  20 ++-
 drivers/fastboot/Makefile   |   4 +-
 drivers/fastboot/fb_block.c | 313 ++++++++++++++++++++++++++++++++++++++++++++
 include/fb_block.h          | 104 +++++++++++++++
 4 files changed, 438 insertions(+), 3 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1eb460f5a02a87089d85b252375202d9acaec9fa..76b35d8419e02a7f1d36988fbdac190b10bff35e 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -92,7 +92,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -114,12 +114,16 @@ choice
 
 config FASTBOOT_FLASH_MMC
 	bool "FASTBOOT on MMC"
-	depends on MMC
+	depends on MMC && BLK
 
 config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_BLOCK
+	bool "FASTBOOT on block device"
+	depends on BLK
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -194,6 +198,18 @@ config FASTBOOT_MMC_USER_NAME
 	  defined here.
 	  The default target name for erasing EMMC_USER is "mmc0".
 
+config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
+	string "Define FASTBOOT block interface name"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  "Fastboot block interface name (mmc, virtio, etc)"
+
+config FASTBOOT_FLASH_BLOCK_DEVICE_ID
+	int "Define FASTBOOT block device id"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  "Fastboot block device id"
+
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
 	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index 048af5aa823436956142a536c5f7dcf1a8948726..91e98763e8eab84ccd9b8e5354ff1419f61ef372 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,5 +3,7 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
-obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
+obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
+# MMC reuses block implementation
+obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
new file mode 100644
index 0000000000000000000000000000000000000000..e79429a9732c1da1ce88358747cf1cb9419cd12b
--- /dev/null
+++ b/drivers/fastboot/fb_block.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: BSD-2-Clause
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
+					memset(erase_buf, 0, erase_buf_blks * block_dev->blksz);
+
+					printf("Slowly writing empty buffers due to missing erase operation\n");
+				}
+			}
+
+			/* Write 0s instead of using erase operation, inefficient but functional */
+			if (erase_buf) {
+				int j;
+
+				blks_written = 0;
+				for (j = 0; j < cur_blkcnt; j += erase_buf_blks) {
+					lbaint_t remain = min_t(lbaint_t, cur_blkcnt - j,
+								erase_buf_blks);
+
+					blks_written += blk_dwrite(block_dev, blk + j,
+								   remain, erase_buf);
+					printf(".");
+				}
+			}
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
+	puts("Flashing Raw Image\n");
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
+	puts("Flashing Raw Image\n");
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
index 0000000000000000000000000000000000000000..cfc824214acb515a0cc2f13fd786c606c6141489
--- /dev/null
+++ b/include/fb_block.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
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

