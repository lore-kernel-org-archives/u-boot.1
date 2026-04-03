Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B406E85367
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93F78412A;
	Fri,  3 Apr 2026 15:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZY0flBFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 862738412A; Fri,  3 Apr 2026 15:52:29 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDA184101
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so17693135e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224347; x=1775829147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XC5uWtKoliXHahUG6xZcDWM9Q/kzFk37Ld8G3b4Ph5o=;
 b=ZY0flBFMxdMUhp31VGOsYz62h4j6qOtsayyZkBZU+qhQvOiH6TfF+1s7NQSraz+hgb
 +VEORltGHhXO7aBjIZcInEyH6TNyUQTfubBh0Y7p8PAw0+UPS1CipD4ZsYuzsamrkUmg
 Yj0FSm3WfRZ5HOZBr6A5dR8zq6k9oNqpVpPJc8B+zut3OiwqcFWXZel+gctBGppm9/yJ
 8EfGlyjaVoV+9UsGrSUGL9PmehoGfT6aW0ilz2IFI9zPGD5fFzC54h0U26ja2q8CBT2S
 7JGqMToHxIS5VPnyaYY5HiGyiT4z/x8ctAASp0dc3zoMbdioWt8b6RczloyHpiOtrHvE
 UnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224347; x=1775829147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XC5uWtKoliXHahUG6xZcDWM9Q/kzFk37Ld8G3b4Ph5o=;
 b=bXZ0t81WmwPvqxSINr+1hDIzqAdlISr27shybyYhan2A3SqaGf1npJycYNFP7WRNKq
 VLLmk9tA2AZS7nIOV4Mdd2ieSy/9nGE1PIgh94YzcdzP0o0PsX+C2mIbz9JyZ0u35EhM
 GCDSewTw2m8T80SQEKT+GzH8WYAovggozbJlLVawPnq3MLbe0Nng3VJVv0ueTlBYDfU1
 xdNuEtXSxuL/9kkMTcQfBwRsi+bc8vVYGUVGejAH/10btBkqS1vpBLO3XfHV/5G2tEaE
 kqBZvfWccOGRg0PQRoQNyq2wQ5GuO8+3NHUBdU3YYA9hsDp0+jbBzkZ/rpTyR3WtQMo4
 siXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmNveoAYPE2SrFeepgCA6LukdrWzu6G86NzG+/X9fupl0NYxUCOBSFxrIHAb6BlHHzMcgRGW0=@lists.denx.de
X-Gm-Message-State: AOJu0YwquaF/VtiYDG3wAWLFyoVKcmrTJgVUGm7Yk0vnBbaptgbBGVcs
 PPPfJLyFqOlkHyQHoTb1qBmVX5efKXJo+jZUHIZGp9MzjUZMo1lHIJeL
X-Gm-Gg: ATEYQzzoqTvXKRCSDum73MXUGkW7YP4TbxIIdgdgqT0mLBwgdPFoM0oT/AxXk1pOIDs
 vSr3irqFPwMQNS+8btxDwUEsq4QL7Wz9HnVmuvxKs8ESecoUA9iGgfr/nHx2Hy4sFVLGBqnjToA
 cPffHkgwgQPRIyOwIyrcplX+Ndn4Bn6sJi7qSdlXBVP6LB6JPhCoEhGJQpWYqgvB/nzxE4Fnxlt
 +7E8ImBUwWxhWvqV1nQZPop2aBpm3PlHfQWB1IucGhjI7+9gNpJeW6SrRbu5ftIWpkiw64Gt4YC
 SjGPGR7aHtWAp9c75Gxse3JjbQrI8+yoYfOKbwxl9BdNTyB7FAnabynbU0V18VE6K3ee508RTxw
 41mHWlcJB5idnY4dzjtmGWDNnEGlTJW63cl1i1elQ0NZPXaxPKmZrks6/TXStGwS32H2EWPzHVY
 mLDX86EIpH1j/RgTSo1uSSidg=
X-Received: by 2002:a05:600c:638e:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-488997b23c6mr49094935e9.24.1775224346390; 
 Fri, 03 Apr 2026 06:52:26 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 5/6] misc: fw_loader: introduce FIP loader driver
Date: Fri,  3 Apr 2026 15:52:02 +0200
Message-ID: <20260403135205.26979-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403135205.26979-1-ansuelsmth@gmail.com>
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
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
accelerator or PHY firmware blob.

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
 drivers/misc/fw_loader/fip_loader.c | 578 ++++++++++++++++++++++++++++
 drivers/misc/fw_loader/internal.h   |   2 +
 include/dm/uclass-id.h              |   3 +-
 5 files changed, 594 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/fw_loader/fip_loader.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 58f1a4c07ff5..d56513b71cbb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -615,6 +615,17 @@ config MPC83XX_SERDES
 config FW_LOADER_LIB
 	bool
 
+config FIP_LOADER
+	bool "Enable loader driver from FIP partition"
+	select LIB_UUID
+	select FW_LOADER_DRV
+	help
+	  This is FIP partition generic loader which can be used to load
+	  the file image from the FIP image into target such as memory.
+
+	  The consumer driver would then use this loader to program whatever,
+	  ie. the FPGA device/PHY firmware.
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
 	select FW_LOADER_DRV
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
index 000000000000..dac471d72af9
--- /dev/null
+++ b/drivers/misc/fw_loader/fip_loader.c
@@ -0,0 +1,578 @@
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
+#include <linux/kernel.h>
+#include <log.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <u-boot/uuid.h>
+
+#include "internal.h"
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
+	unsigned long to_read;
+	size_t read = 0;
+	int i, ret;
+
+	for (i = 0; i < blkcnt && read < sizeof(*hdr); i++) {
+		to_read = min(desc->blksz,
+			      (unsigned long)(sizeof(*hdr) - read));
+
+		ret = blk_dread(desc, offset + i, 1, buf);
+		if (ret != 1)
+			return -EINVAL;
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
+	unsigned long left, consumed, to_read, read = 0;
+	unsigned int blkstart, blkcnt;
+	int i, ret;
+
+	consumed = pos % desc->blksz;
+	left = desc->blksz - consumed;
+	to_read = min(left, (unsigned long)sizeof(*ent));
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
+		to_read = min(desc->blksz,
+			      (unsigned long)(sizeof(*ent) - read));
+
+		ret = blk_dread(desc, offset + blkstart + i, 1, buf);
+		if (ret != 1)
+			return -EINVAL;
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
+	ret = blk_read_fip_toc_header(desc, offset, read_buf, &hdr);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pos = ret;
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
+		ret = blk_read_fip_toc_entry(desc, offset, pos,
+					     read_buf, &ent);
+		if (ret < 0)
+			goto out;
+
+		pos += ret;
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
+	unsigned long pos, to_read, read = 0;
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
+		to_read = min(desc->blksz - pos, (unsigned long)size);
+		ret = blk_dread(desc, offset + blkstart, 1, read_buf);
+		if (ret != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		memcpy((u8 *)firmwarep->data, read_buf + pos, to_read);
+		read += to_read;
+		blkstart++;
+	}
+
+	/* Consume all the remaining block */
+	for (i = 0; i < blkcnt && read < size; i++) {
+		to_read = min(desc->blksz, (unsigned long)(size - read));
+		ret = blk_dread(desc, offset + blkstart + i, 1, read_buf);
+		if (ret != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		memcpy((u8 *)firmwarep->data + read, read_buf, to_read);
+		read += to_read;
+	}
+
+	ret = read;
+
+out:
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
+		ret = generic_fw_loader_ubi_select(ubi_mtdpart);
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
+		ret = generic_fw_loader_ubi_select(plat->mtdpart);
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
+		return ret;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep)
+		return -EINVAL;
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		return ret;
+
+	if (ent.size + firmwarep->offset > firmwarep->size) {
+		log_err("Not enough space to read firmware\n");
+		return -ENOMEM;
+	}
+
+	ret = read_fip_firmware(firmwarep, &info, &ent);
+	if (ret < 0)
+		log_err("Failed to read %s from FIP: %d.\n",
+			firmwarep->name, ret);
+
+	return ret;
+}
+
+/**
+ * fw_get_fip_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_fip_firmware_size(struct udevice *dev)
+{
+	struct fip_toc_entry ent;
+	struct fip_storage_info info = { };
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		return ret;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep)
+		return -EINVAL;
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		return ret;
+
+	return ent.size;
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
+	plat->get_size = fw_get_fip_firmware_size;
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
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index a94de609d0b6..d823d56e53f5 100644
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
2.53.0

