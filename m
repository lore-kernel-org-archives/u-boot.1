Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16F2EA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A6CD841D7;
	Thu,  9 Apr 2026 15:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G8/Ni9x4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6548416F; Thu,  9 Apr 2026 15:33:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A51841D7
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488d2079582so5418115e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741606; x=1776346406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xi0KjjRHhcT1w5sGmU1735DcovHVbHHPpNF1svMRmX0=;
 b=G8/Ni9x4AYJpnqv4QBscXsi8ZupO0e+/zviJ4F4oE6GbMSPn8gTqF4rYzmrqU8WRZ6
 NCTrOc7MphSsZMiPh18ZHRYpPGIbmtTJIRYV2C1j03z3LckX6ExA0B7HJQJqnKiJgsYF
 +gnDZ0WNOEEdejYnY/P7v4RJS3rTVhecXe3fqkC8XKVBtfeOhDsTKsAdFgpphp2ZOyMK
 afl85JmvwKjvetjgDnVHXsnhnvmF+/Tp+V5I+e6aUJoKkJfj78KRT6C9QMefc5LBrK3U
 ODJviALMD3ruFIvNv1r72JPOiOwn5S0E9bKQ71WU9qzgvKtMOzuOLoEhCXft7pqY+8Xa
 LkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741606; x=1776346406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xi0KjjRHhcT1w5sGmU1735DcovHVbHHPpNF1svMRmX0=;
 b=kQ6Wv/AuU7g2nXP/mbRnoHX2kaytcNaZNHyYG3Vr1dhCjV4zipxPTW5nnTD7hoDNN3
 2zqTzo+bf1CtR9v/yAGdUHq9Gvscd0yFJ+9AnD1ntWTOcpYK3X6TqI+NA6YFBuj6p4px
 xgRA7ouaYUc9MjUX+tuXYnwq47E3mjrJrwgM6Ay5drG6e/UCJsSUoXdAGxBi4ESNWDK2
 wO2+w1YY0AilMcbw8C3jOrDP2H1GY7pQixVKonNiLUzpji7HtuJxZKkao4wsqgpzUsLp
 yttBBGoiYq+CBm3KK8HVSPaJcsK9nxxOo+R/gf7ub/MMc9avpFiLU0t2OF6F8w9GTnkP
 dYPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnRCezCVyP0E7Zkvg5gBLF8F4AWS0hcgD/53sZNGoz9qyjMQeCVsRwiU9fAcwxgJoQUAvZj1A=@lists.denx.de
X-Gm-Message-State: AOJu0YyCpNAryPHNbakCM2AxtXN47KLiAyLk2TRVvlmV8z9Gvf666hD9
 Yl5LTf3GQXpPafzppWurnpZMVk7Qow5lyt1d3USlYVj38Adgua9pXrkC
X-Gm-Gg: AeBDieuqXpvqYqw5uSeOcC/xh7C7uhBBPrE9jk40wkFujrsK8WhlDyhzJqOR9H8+bnh
 xsWMxCgbFFDl+BPe4Sd8U0TuILneMFOtbjbX8GLviDvOwIVFkLZBhemhiEYZasAJMle6o3oca2j
 j+6YCzSihA+CpopaeBUs7ohHEy3fvIlGtU1VCgoi4fAI+Vkz9sHHXYqfRAVltHHKCHWz7Yn1OA7
 nrZxOaPVX2gI3K0GEHsjYUDDOBpWOXVfuDzw+vP4LCkop29yGvBUJDhLr9RfLHVqZtZ32kOH3Bd
 QVNBCwM4I6PT7wC3Nc1t3TpWUfKmbnekEQgrilyqXwaMi8T3r0HGIiy/tPHaJ9iDF9oEJGfDhA7
 5MERPQFofSjpeW9CPqs22TcesrOBl+fSaFPW40fBpf9pN/QAFuz8SAY4xKe6NvF+yf8Avi5l0yx
 TZ2uHE7sQV/KZ2k0O+xLK50WxqomEupLK6XE5QZF2rBKtbpAlk2E2YcXpBrGedT1mcAQGxGD8=
X-Received: by 2002:a05:600c:1d86:b0:485:304a:58cd with SMTP id
 5b1f17b1804b1-488997153c7mr299528425e9.4.1775741606198; 
 Thu, 09 Apr 2026 06:33:26 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v6 5/6] misc: fw_loader: introduce FIP loader driver
Date: Thu,  9 Apr 2026 15:33:01 +0200
Message-ID: <20260409133303.31875-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133303.31875-1-ansuelsmth@gmail.com>
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
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
 drivers/misc/Kconfig                      |  11 +
 drivers/misc/fw_loader/Makefile           |   1 +
 drivers/misc/fw_loader/fip_loader.c       | 544 ++++++++++++++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c |   3 +
 drivers/misc/fw_loader/internal.h         |   2 +
 5 files changed, 561 insertions(+)
 create mode 100644 drivers/misc/fw_loader/fip_loader.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 9b181339c468..ee0a9f40d99e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -615,6 +615,17 @@ config MPC83XX_SERDES
 config FW_LOADER_UCLASS
 	bool
 
+config FIP_LOADER
+	bool "Enable loader driver from FIP partition"
+	select LIB_UUID
+	select FW_LOADER_UCLASS
+	help
+	  This is FIP partition generic loader which can be used to load
+	  the file image from the FIP image into target such as memory.
+
+	  The consumer driver would then use this loader to program whatever,
+	  ie. the FPGA device/PHY firmware.
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
 	select FW_LOADER_UCLASS
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
index 3d5e9f5b338e..29418a008fb3 100644
--- a/drivers/misc/fw_loader/Makefile
+++ b/drivers/misc/fw_loader/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y += fw_loader-uclass.o
+obj-$(CONFIG_FIP_LOADER) += fip_loader.o
 obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
new file mode 100644
index 000000000000..da1ed98eeb4c
--- /dev/null
+++ b/drivers/misc/fw_loader/fip_loader.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_LOADER
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
+	unsigned int blkcnt;
+	char *read_buf;
+	size_t size;
+	int i, ret;
+
+	read_buf = malloc(desc->blksz);
+	if (!read_buf)
+		return -ENOMEM;
+
+	size = ent->size - firmwarep->offset;
+	blkcnt = BLOCK_CNT(size, desc);
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
+	struct device_plat *plat = dev_get_uclass_plat(dev);
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
+	struct fip_storage_info info = { };
+	struct firmware *firmwarep;
+	struct fip_toc_entry ent;
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		return ret;
+
+	firmwarep = dev_get_uclass_priv(dev);
+	if (!firmwarep)
+		return -EINVAL;
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		return ret;
+
+	if (ent.size - firmwarep->offset > firmwarep->size) {
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
+	struct fip_storage_info info = { };
+	struct firmware *firmwarep;
+	struct fip_toc_entry ent;
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		return ret;
+
+	firmwarep = dev_get_uclass_priv(dev);
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
+static const struct fw_loader_ops fip_loader_ops = {
+	.get_firmware = fw_get_fip_firmware,
+	.get_size = fw_get_fip_firmware_size,
+};
+
+static const struct udevice_id fip_loader_ids[] = {
+	{ .compatible = "u-boot,fip-loader"},
+	{ }
+};
+
+U_BOOT_DRIVER(fip_loader) = {
+	.name		= "fip-loader",
+	.id		= UCLASS_FIRMWARE_LOADER,
+	.of_match	= fip_loader_ids,
+	.ops		= &fip_loader_ops,
+};
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 19379c23411b..1d47c4437072 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -62,6 +62,9 @@ static int fw_loader_pre_probe(struct udevice *dev)
 
 		plat->ubivol = (char *)ofnode_read_string(fw_loader_node,
 							  "ubivol");
+
+		ofnode_read_u32(fw_loader_node, "partoffset",
+				&plat->partoffset);
 	}
 
 	if (plat->phandlepart.phandle) {
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 9964dc436afb..6003b15ab9ac 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -49,11 +49,13 @@ struct fw_loader_ops {
  * This holds information about all supported storage devices for driver use.
  *
  * @phandlepart: Attribute data for block device.
+ * @partoffset: Global offset for BLK partition.
  * @mtdpart: MTD partition for ubi partition.
  * @ubivol: UBI volume-name for ubifsmount.
  */
 struct device_plat {
 	struct phandle_part phandlepart;
+	u32 partoffset;
 	char *mtdpart;
 	char *ubivol;
 };
-- 
2.53.0

