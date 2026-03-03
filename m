Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30938EC143D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F7483F86;
	Tue,  3 Mar 2026 14:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFvMbcto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F0083F59; Tue,  3 Mar 2026 14:29:35 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E932A83F86
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso48377685e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544571; x=1773149371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ShAnAlt2fsjNs2UpSZxZhuIixKMrAXfRSHCe3wim4sk=;
 b=kFvMbctouLR9JjrRBIkWJ8oB5O7YtVwXt2IJeGY697WbP/nHFFOM3OvxMN8dkHGRUi
 Ik2ocPcbE83+m3W3t3g0uvzvifRQVbYGbDZYdkSTfRzkDNQZIoWKOUXMrtR0l0DPA7ln
 RjqBzhZQWDkCt+JynHpHBLeL1/1ikK7sYRp6B3NoB1fuvH3u23X7DbXt9jVGTZLCXbFq
 XknuhWsdO3EPdf0wQsFIRv7lG9u3xnAATRFlIg0edsQMxqQ2o73bhzcskwQpb+rDAfWn
 IGdWRLq6jPYKzjKbmoC1LzE8KpnvnfeEr2Gl/HEpSdxep6r4FylPG64SxhJnWP7PO4B+
 KG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544571; x=1773149371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ShAnAlt2fsjNs2UpSZxZhuIixKMrAXfRSHCe3wim4sk=;
 b=bgD8F0u6aDcSFsGPaHcBqgjUYjr2NjzvyLh/6OsOY4Hl7MUbfAbYhv3NBQboVKhK3R
 NXhrjatIabJgLMsI5rF5XsifDY/mYdWr98xSFerzEMWZ+qwrqoS0pqv7NsL5MksHplH3
 7q0A/fEcPn/B4dqMKzfAgaFnkXJgy/iJAJAfE7IVvXAOGOJlUe2v3c2S5CZaM1iHedoQ
 qOU7akaKpRTiAfEm65fFIT2yuRlK9SuiK2qScCjQl86ZqK1FonCCM/6PKnSCoR/hhZ3L
 52WBBBVQ5q1Tu2z4lAc8Fm+z0LtTYMtTXDtK0GmkT8fjm1cdoFPHvzsgwljn0CkzBRIA
 bDPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvCVYZWRdEX7Jqq2JeUa/Y9p/HN/3arP8p2iilNHkATPlc+rhUm/sDAJOZomVTzw0GA1xEKNw=@lists.denx.de
X-Gm-Message-State: AOJu0YzmeBC1+eHmTROB9W8i0tLQ0iioisYpO1pMZZVU/hhxlcNOIxLD
 avrs26JpTVUfv8unbMumylO1fwIlVr8ANvdGgYca/AL6pjoY0aXFQzd1NQS8PQ==
X-Gm-Gg: ATEYQzwJjcmcdZEZysg4h7JMLmurrLX17JMf+Axjv0EEJjclmuxqRar5eLSUD4x7DIp
 9ziqtXHU//3JDsnnNJjwx0tdhVC+lmnoUOHUwUng66LeNWEN2PwBszNd9dtZEeCjFm+Csst+rL1
 7oWU6QgEm+Bzd6d7XXjF31mLPPYHh3G9+pct4uFwBlt54swuYE0HYCPUY+Ka6A67t7zNcWF+4lQ
 Y0mO1G5S0s98Au5Z8qEkpv/Ev4S04EWqScZlb8frnmbPbayS/bz1t9a4mFEoeU551QS7s+KAQ4K
 wH5vZkpswvNkn2xw7YM1C6evI/onnqtWbC5w1K/kuaKMStF4x4G+eF6Sl1o3eGZn2tClLd87Xj9
 RmQGy4PPz4optlkC2v3QKvnfJkeP8P3N/7mp/8foebDOkh03GwW9h6Frb67yD7Jnh7WebB1rugl
 WxkJWDzuh6tr/45D1b38pIwg6uMSy7rbZLC8lKDhkjYrJpTTlN7l4j4Cg=
X-Received: by 2002:a05:600c:34cf:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483c9bb6744mr265539425e9.14.1772544570992; 
 Tue, 03 Mar 2026 05:29:30 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm772625095e9.0.2026.03.03.05.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:29:30 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: [PATCH 4/5] misc: fw_loader: introduce FIP loader driver
Date: Tue,  3 Mar 2026 14:29:11 +0100
Message-ID: <20260303132916.5502-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303132916.5502-1-ansuelsmth@gmail.com>
References: <20260303132916.5502-1-ansuelsmth@gmail.com>
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

Introduce a variant of the FS loader driver to extract images from FIP
image. These image can contain additional binary used to init Network
accellerator or PHY firmware blob.

The way FIP handle image type is with the usage of UUID.

This FIP loader driver implement a simple FIP image parser that check
every entry for a matching UUID.

Similar to FS loader, this driver also support both UBI and Block
devices.

Also an additional property is added to handle special case with eMMC
that doesn't have a GPT partition and require a global offset to
reference the FIP partition.

An example usage of this driver is the following:

Entry in DTS:

	fs_loader0: fip-loader {
		bootph-all;
		compatible = "u-boot,fip-loader";
		phandlepart = <&mmc0 0>;
		partoffset = <0x100>;
	};

	ethernet@1fb50000 {
		firmware-loader = <&fs_loader0>;
	}

FIP loader user:

	/* get the FW loader from the ethernet node */
	get_fw_loader_from_node(dev_ofnode(dev), &fw_loader);

	/* read the blob identified by "58704aef-389f-3e52-b475-e0bf2234a6a2" UUID */
	request_firmware_into_buf(fw_loader, "58704aef-389f-3e52-b475-e0bf2234a6a2",
				  buf, 261400, 0);

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/Kconfig                |  11 +
 drivers/misc/fw_loader/Makefile     |   1 +
 drivers/misc/fw_loader/fip_loader.c | 575 ++++++++++++++++++++++++++++
 drivers/misc/fw_loader/fw_loader.c  |   3 +
 drivers/misc/fw_loader/internal.h   |   2 +
 include/dm/uclass-id.h              |   3 +-
 6 files changed, 594 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/fw_loader/fip_loader.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 9d332230b1f9..8d2f11de0fe7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -613,6 +613,17 @@ config MPC83XX_SERDES
 config FW_LOADER
 	bool
 
+config FIP_LOADER
+	bool "Enable loader driver from FIP partition"
+	select LIB_UUID
+	select FW_LOADER
+	help
+	  This is FIP partition generic loader which can be used to load
+	  the file image from the FIP image into target such as memory.
+
+	  The consumer driver would then use this loader to program whatever,
+	  ie. the FPGA device/PHY firmware.
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
 	select FW_LOADER
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
index 96baebede788..7854b64148e6 100644
--- a/drivers/misc/fw_loader/Makefile
+++ b/drivers/misc/fw_loader/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y += fw_loader.o
+obj-$(CONFIG_FIP_LOADER) += fip_loader.o
 obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
new file mode 100644
index 000000000000..376e1d2a59d8
--- /dev/null
+++ b/drivers/misc/fw_loader/fip_loader.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_FIP_FIRMWARE_LOADER
+
+#include <dm.h>
+#include <div64.h>
+#include <env.h>
+#include <errno.h>
+#include <blk.h>
+#include <fs.h>
+#include <fs_loader.h>
+#include <log.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <u-boot/uuid.h>
+
+#ifdef CONFIG_CMD_UBIFS
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
+#define TOC_HEADER_NAME	0xaa640001
+
+struct fip_toc_header {
+	u32 name;
+	u32 serial_number;
+	u64 flags;
+};
+
+struct fip_toc_entry {
+	struct uuid uuid;
+	u64 offset_address;
+	u64 size;
+	u64 flags;
+};
+
+enum fip_storage_interface {
+	FIP_STORAGE_INTERFACE_BLK,
+	FIP_STORAGE_INTERFACE_UBI,
+};
+
+struct fip_storage_info {
+	enum fip_storage_interface storage_interface;
+
+	/* BLK info */
+	struct disk_partition part_info;
+	struct blk_desc *desc;
+	unsigned int part_offset;
+
+	/* UBI info */
+	char *ubi_volume;
+};
+
+#ifdef CONFIG_CMD_UBIFS
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	int ret;
+
+	ret = ubi_part(mtdpart, NULL);
+	if (ret)
+		log_err("Cannot find mtd partition %s\n", mtdpart);
+
+	return ret;
+}
+
+static void umount_ubifs(void)
+{
+	cmd_ubifs_umount();
+}
+#else
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	log_err("Cannot load image: no UBIFS support.\n");
+	return -ENOSYS;
+}
+
+static void umount_ubifs(void)
+{
+}
+#endif
+
+static bool validate_fip_toc_header(struct fip_toc_header *hdr)
+{
+	if (hdr->name != TOC_HEADER_NAME) {
+		log_err("Invalid FIP header\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int firmware_name_to_uuid(struct firmware *firmwarep,
+				 struct uuid *uuid)
+{
+	const char *uuid_str = firmwarep->name;
+	int ret;
+
+	ret = uuid_str_to_bin(uuid_str, (unsigned char *)uuid,
+			      UUID_STR_FORMAT_STD);
+	if (ret)
+		log_err("Invalid UUID str: %s\n", uuid_str);
+
+	return ret;
+}
+
+static int check_fip_toc_entry(struct fip_toc_entry *ent,
+			       struct uuid *uuid,
+			       struct fip_toc_entry *dent)
+{
+	struct uuid uuid_null = { };
+
+	/* NULL uuid. We parsed every entry */
+	if (!memcmp(&ent->uuid, &uuid_null, sizeof(uuid_null)))
+		return -ENOENT;
+
+	/* We found the related uuid */
+	if (!memcmp(&ent->uuid, uuid, sizeof(*uuid))) {
+		log_debug("Found matching FIP entry. offset: 0x%llx size: %lld\n",
+			  ent->offset_address, ent->size);
+		memcpy(dent, ent, sizeof(*ent));
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+static int blk_read_fip_toc_header(struct blk_desc *desc, u32 offset,
+				   char *buf, struct fip_toc_header *hdr)
+{
+	unsigned int blkcnt = BLOCK_CNT(sizeof(*hdr), desc);
+	size_t read = 0;
+	int i;
+
+	for (i = 0; i < blkcnt && read < sizeof(*hdr); i++) {
+		unsigned int to_read = MIN(desc->blksz,
+					   sizeof(*hdr) - read);
+
+		blk_dread(desc, offset + i, 1, buf);
+
+		memcpy((u8 *)hdr + read, buf, to_read);
+		read += to_read;
+	}
+
+	return read;
+}
+
+static int blk_read_fip_toc_entry(struct blk_desc *desc, u32 offset,
+				  int pos, char *buf,
+				  struct fip_toc_entry *ent)
+{
+	unsigned int left, consumed, to_read, read = 0;
+	unsigned int blkstart, blkcnt;
+	int i;
+
+	consumed = pos % desc->blksz;
+	left = desc->blksz - consumed;
+	to_read = MIN(left, sizeof(*ent));
+
+	blkstart = BLOCK_CNT(pos, desc);
+	blkcnt = BLOCK_CNT(sizeof(*ent) - to_read, desc);
+
+	/* Read data from previous cached block if present */
+	if (left) {
+		memcpy(ent, buf + consumed, to_read);
+		read += to_read;
+	}
+
+	for (i = 0; i < blkcnt && read < sizeof(*ent); i++) {
+		to_read = MIN(desc->blksz, sizeof(*ent) - read);
+
+		blk_dread(desc, offset + blkstart + i, 1, buf);
+
+		memcpy((u8 *)ent + read, buf, to_read);
+		read += to_read;
+	}
+
+	return read;
+}
+
+static int blk_parse_fip_firmware(struct firmware *firmwarep,
+				  struct blk_desc *desc,
+				  struct disk_partition *part_info,
+				  unsigned int part_offset,
+				  struct fip_toc_entry *dent)
+{
+	unsigned int offset = part_info->start + part_offset;
+	struct fip_toc_header hdr;
+	struct fip_toc_entry ent;
+	struct uuid uuid;
+	unsigned int pos;
+	char *read_buf;
+	int ret;
+
+	/* Allocate a Scratch Buffer for FIP parsing */
+	read_buf = malloc(desc->blksz);
+	if (!read_buf)
+		return -ENOMEM;
+
+	pos = blk_read_fip_toc_header(desc, offset, read_buf, &hdr);
+
+	if (!validate_fip_toc_header(&hdr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = firmware_name_to_uuid(firmwarep, &uuid);
+	if (ret)
+		goto out;
+
+	/* Loop for every FIP entry searching for uuid */
+	while (true) {
+		pos += blk_read_fip_toc_entry(desc, offset, pos,
+					      read_buf, &ent);
+
+		ret = check_fip_toc_entry(&ent, &uuid, dent);
+		if (ret != -EAGAIN)
+			break;
+	}
+
+out:
+	free(read_buf);
+	return ret;
+}
+
+#ifdef CONFIG_CMD_UBIFS
+static int ubi_parse_fip_firmware(struct firmware *firmwarep,
+				  char *ubi_vol,
+				  struct fip_toc_entry *dent)
+{
+	struct fip_toc_header hdr;
+	struct fip_toc_entry ent;
+	struct uuid uuid;
+	unsigned int pos;
+	int ret;
+
+	ret = ubi_volume_read(ubi_vol, (char *)&hdr, 0, sizeof(hdr));
+	if (ret)
+		return ret;
+
+	pos = sizeof(hdr);
+
+	if (!validate_fip_toc_header(&hdr))
+		return -EINVAL;
+
+	ret = firmware_name_to_uuid(firmwarep, &uuid);
+	if (ret)
+		return ret;
+
+	/* Loop for every FIP entry searching for uuid */
+	while (true) {
+		ret = ubi_volume_read(ubi_vol, (char *)&ent, pos,
+				      sizeof(ent));
+		if (ret)
+			return ret;
+
+		ret = check_fip_toc_entry(&ent, &uuid, dent);
+		if (ret != -EAGAIN)
+			break;
+
+		pos += sizeof(ent);
+	}
+
+	return ret;
+}
+#endif
+
+static int parse_fip_firmware(struct firmware *firmwarep,
+			      struct fip_storage_info *info,
+			      struct fip_toc_entry *dent)
+{
+	switch (info->storage_interface) {
+	case FIP_STORAGE_INTERFACE_BLK:
+		return blk_parse_fip_firmware(firmwarep, info->desc,
+					      &info->part_info,
+					      info->part_offset,
+					      dent);
+#ifdef CONFIG_CMD_UBIFS
+	case FIP_STORAGE_INTERFACE_UBI:
+		return ubi_parse_fip_firmware(firmwarep,
+					      info->ubi_volume,
+					      dent);
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
+static int blk_read_fip_firmware(struct firmware *firmwarep,
+				 struct blk_desc *desc,
+				 struct disk_partition *part_info,
+				 unsigned int part_offset,
+				 const struct fip_toc_entry *ent)
+{
+	unsigned int offset = part_info->start + part_offset;
+	unsigned int pos, to_read, read = 0;
+	unsigned long long blkstart;
+	size_t size = ent->size;
+	unsigned int blkcnt;
+	char *read_buf;
+	int i, ret;
+
+	read_buf = malloc(desc->blksz);
+	if (!read_buf)
+		return -ENOMEM;
+
+	blkcnt = BLOCK_CNT(size + firmwarep->offset, desc);
+	blkstart = ent->offset_address + firmwarep->offset;
+	pos = do_div(blkstart, desc->blksz);
+
+	/* Read data in the middle of a block */
+	if (pos) {
+		to_read = MIN(desc->blksz - pos, size);
+		blk_dread(desc, offset + blkstart, 1, read_buf);
+
+		memcpy((u8 *)firmwarep->data, read_buf + pos, to_read);
+		read += to_read;
+		blkstart++;
+	}
+
+	/* Consume all the remaining block */
+	for (i = 0; i < blkcnt && read < size; i++) {
+		to_read = MIN(desc->blksz, size - read);
+		blk_dread(desc, offset + blkstart + i, 1, read_buf);
+
+		memcpy((u8 *)firmwarep->data + read, read_buf, to_read);
+		read += to_read;
+	}
+
+	ret = read;
+
+	free(read_buf);
+	return ret;
+}
+
+#ifdef CONFIG_CMD_UBIFS
+static int ubi_read_fip_firmware(struct firmware *firmwarep,
+				 char *ubi_vol,
+				 const struct fip_toc_entry *ent)
+{
+	unsigned int offset = firmwarep->offset;
+	size_t size = ent->size;
+	int ret;
+
+	ret = ubi_volume_read(ubi_vol,
+			      (u8 *)firmwarep->data,
+			      ent->offset_address + offset,
+			      size - offset);
+	if (ret)
+		return ret;
+
+	return size - firmwarep->offset;
+}
+#endif
+
+static int read_fip_firmware(struct firmware *firmwarep,
+			     struct fip_storage_info *info,
+			     const struct fip_toc_entry *dent)
+{
+	switch (info->storage_interface) {
+	case FIP_STORAGE_INTERFACE_BLK:
+		return blk_read_fip_firmware(firmwarep, info->desc,
+					     &info->part_info,
+					     info->part_offset,
+					     dent);
+#ifdef CONFIG_CMD_UBIFS
+	case FIP_STORAGE_INTERFACE_UBI:
+		return ubi_read_fip_firmware(firmwarep,
+					     info->ubi_volume,
+					     dent);
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fw_parse_storage_info(struct udevice *dev,
+				 struct fip_storage_info *info)
+{
+	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
+	struct device_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	storage_interface = env_get("storage_interface");
+	dev_part = env_get("fw_dev_part");
+	ubi_mtdpart = env_get("fw_ubi_mtdpart");
+	ubi_volume = env_get("fw_ubi_volume");
+	info->part_offset = env_get_hex("fw_partoffset", 0);
+
+	if (storage_interface && dev_part) {
+		int part;
+
+		part = part_get_info_by_dev_and_name_or_num(storage_interface,
+							    dev_part,
+							    &info->desc,
+							    &info->part_info, 1);
+		if (part < 0)
+			return part;
+
+		info->storage_interface = FIP_STORAGE_INTERFACE_BLK;
+
+		return 0;
+	}
+
+	if (storage_interface && ubi_mtdpart && ubi_volume) {
+		if (strcmp("ubi", storage_interface))
+			return -ENODEV;
+
+		ret = mount_ubifs(ubi_mtdpart, ubi_volume);
+		if (ret)
+			return ret;
+
+		info->ubi_volume = ubi_volume;
+		info->storage_interface = FIP_STORAGE_INTERFACE_UBI;
+
+		return 0;
+	}
+
+	info->part_offset = plat->partoffset;
+
+	if (plat->phandlepart.phandle) {
+		struct udevice *disk_dev;
+		ofnode node;
+		int part;
+
+		node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+
+		ret = device_get_global_by_ofnode(node, &disk_dev);
+		if (ret)
+			return ret;
+
+		info->desc = blk_get_by_device(disk_dev);
+		if (!info->desc)
+			return -ENODEV;
+
+		part = plat->phandlepart.partition;
+		if (part >= 1)
+			ret = part_get_info(info->desc, part,
+					    &info->part_info);
+		else
+			ret = part_get_info_whole_disk(info->desc,
+						       &info->part_info);
+
+		info->storage_interface = FIP_STORAGE_INTERFACE_BLK;
+
+		return ret;
+	}
+
+	if (plat->mtdpart && plat->ubivol) {
+		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
+		if (ret)
+			return ret;
+
+		info->ubi_volume = plat->ubivol;
+		info->storage_interface = FIP_STORAGE_INTERFACE_UBI;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void fw_storage_info_release(struct udevice *dev,
+				    const struct fip_storage_info *info)
+{
+	switch (info->storage_interface) {
+	case FIP_STORAGE_INTERFACE_UBI:
+		umount_ubifs();
+		return;
+	default:
+		return;
+	}
+}
+
+/**
+ * fw_get_fip_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_fip_firmware(struct udevice *dev)
+{
+	struct fip_toc_entry ent;
+	struct fip_storage_info info = { };
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		goto out;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		goto out;
+
+	if (ent.size + firmwarep->offset > firmwarep->size) {
+		log_err("Not enough space to read firmware\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = read_fip_firmware(firmwarep, &info, &ent);
+	if (ret < 0)
+		log_err("Failed to read %s from FIP: %d.\n",
+			firmwarep->name, ret);
+
+out:
+	fw_storage_info_release(dev, &info);
+	return ret;
+}
+
+static int fip_loader_probe(struct udevice *dev)
+{
+	struct device_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = generic_fw_loader_probe(dev);
+	if (ret)
+		return ret;
+
+	plat->get_firmware = fw_get_fip_firmware;
+
+	return 0;
+};
+
+static int fip_loader_of_to_plat(struct udevice *dev)
+{
+	struct device_plat *plat = dev_get_plat(dev);
+	ofnode fip_loader_node = dev_ofnode(dev);
+	int ret;
+
+	ret = generic_fw_loader_of_to_plat(dev);
+	if (ret)
+		return ret;
+
+	/* Node validation is already done by the generic function */
+	ofnode_read_u32(fip_loader_node, "partoffset",
+			&plat->partoffset);
+
+	return 0;
+}
+
+static const struct udevice_id fip_loader_ids[] = {
+	{ .compatible = "u-boot,fip-loader"},
+	{ }
+};
+
+U_BOOT_DRIVER(fip_loader) = {
+	.name		= "fip-loader",
+	.id		= UCLASS_FIP_FIRMWARE_LOADER,
+	.of_match	= fip_loader_ids,
+	.probe		= fip_loader_probe,
+	.of_to_plat	= fip_loader_of_to_plat,
+	.plat_auto	= sizeof(struct device_plat),
+	.priv_auto	= sizeof(struct firmware),
+};
+
+UCLASS_DRIVER(fip_loader) = {
+	.id		= UCLASS_FIP_FIRMWARE_LOADER,
+	.name		= "fip-loader",
+};
diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index e477a631fae3..d2446fdc07da 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -72,6 +72,9 @@ static int fw_loaders[] = {
 #if CONFIG_IS_ENABLED(FS_LOADER)
 	UCLASS_FS_FIRMWARE_LOADER,
 #endif
+#if CONFIG_IS_ENABLED(FIP_LOADER)
+	UCLASS_FIP_FIRMWARE_LOADER,
+#endif
 };
 
 /**
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index fc78a4add59d..5513e043925f 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -25,11 +25,13 @@ struct phandle_part {
  * This holds information about all supported storage devices for driver use.
  *
  * @phandlepart: Attribute data for block device.
+ * @partoffset: Global offset for BLK partition.
  * @mtdpart: MTD partition for ubi partition.
  * @ubivol: UBI volume-name for ubifsmount.
  */
 struct device_plat {
 	struct phandle_part phandlepart;
+	int partoffset;
 	char *mtdpart;
 	char *ubivol;
 
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304f..641d8e1e42fa 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -69,7 +69,8 @@ enum uclass_id {
 	UCLASS_FIRMWARE,	/* Firmware */
 	UCLASS_FPGA,		/* FPGA device */
 	UCLASS_FUZZING_ENGINE,	/* Fuzzing engine */
-	UCLASS_FS_FIRMWARE_LOADER,		/* Generic loader */
+	UCLASS_FIP_FIRMWARE_LOADER, /* FIP image loader */
+	UCLASS_FS_FIRMWARE_LOADER, /* Generic loader */
 	UCLASS_FWU_MDATA,	/* FWU Metadata Access */
 	UCLASS_GPIO,		/* Bank of general-purpose I/O pins */
 	UCLASS_HASH,		/* Hash device */
-- 
2.51.0

