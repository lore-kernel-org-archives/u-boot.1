Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D26AE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A27A80600;
	Thu,  9 Jan 2025 13:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JFKCbUkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831BA8005B; Thu,  9 Jan 2025 13:30:36 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003308005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce34c6872aso5388675ab.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425832; x=1737030632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6n3JHzWg5o8hiah06obO83dARehB3ZJNP3aCn7qbwc=;
 b=JFKCbUkX4bo5rcAUF9DVMv9iQn+Zt7XoRLJV/z1zdSb+GcBOqcJBN4mB5vm2P2RsL7
 wjxbDRUWpE10Ka91AdPxdHTCOH7i/BZb0Jx59E4EITqVcXI3Hm8EIv1PTOT6xKYlcwid
 wyV3t64lJ2gW2b839R+tCYXbvHzeP2e6Y+sD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425832; x=1737030632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6n3JHzWg5o8hiah06obO83dARehB3ZJNP3aCn7qbwc=;
 b=P60PFHX30mm+6HtiMgrsLEsAFkfRyp4DlRa6F9PX6nFL14OjQ6POKBYJGj5i+WyHBA
 HipqA8fuNIu7Nw8yPq2M0bs4D3tug4vC6uol7Z2mvO+FRejvEblxaRk/3UZoj37isDNE
 H0+FUytWKntr6I7XbQnxiT+VFc6Q8QzMqUih+ShovyJsszGkwHEqqo1FDQFMk/YIYSVH
 6IhR8tZJEYZoNUgeb/1VpYcUFlr5ZyT2RwJjWQrCEBVe4xB9AtAa+kSBY75mXJO+0gsf
 OVPq6vlUoAcvT6nhvke8ziHrd2ZshBm5GTIwnbYaxVnO4UuaUkNB+XKotwgwndEtf7eT
 qQ8g==
X-Gm-Message-State: AOJu0YwOBvAZUYtF5nCndwElyTtjC5cESuDada/tu3jxJr1OXD57Pieb
 YuYhwTLNsWEHFAGrfvaTKNU2UNsqwkI6i+RlAV4PDcYnPNL6tHfIIVdX/jnFy7OpPHAkwYlA6ZU
 =
X-Gm-Gg: ASbGncu4Qb5PzmOkjt82vTJY1lngHH5bGjSYFu2jkvEClsEo+WViYOOeUM351Gt/IVO
 MTIBuqmi2qr8uTHyvEQ5lRoJxDn3mrSgWUb4sZxCoV1p8LXm1I0OjH+OjGRDuQFvX71vVAG5EzK
 i2J3FtvoXYbrxlyhoNZAL83juSn8dqn6dHmZl2g9R5ZngK3dWhUwe3Lk05UXKWFlZKD8A72Njb5
 wplpm/wGHSGmzqGCuk79Nd0YkWpw3EPA/Ypjet06gouihATo7q1YBPNaZJEcVYR8l7Q3t4TNv8B
 CZsC+/p2vHBprtC/qw==
X-Google-Smtp-Source: AGHT+IGCEsUuh5q8Zg5qD4JueoClEewfkxaZuZggCV5E5qwotRGGfQ0CtL6FCt4lOKeYpyFl0ND9/Q==
X-Received: by 2002:a05:6e02:20ee:b0:3a7:e103:3c46 with SMTP id
 e9e14a558f8ab-3ce3a8ba404mr46652085ab.16.1736425831991; 
 Thu, 09 Jan 2025 04:30:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 01/15] vbe: Split out some VBE code into a common file
Date: Thu,  9 Jan 2025 05:29:56 -0700
Message-Id: <20250109123010.4005298-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

Loading a FIT is useful for other VBE methods, such as ABrec, so start
a new common file. Add functions for reading the version and nvdata.
Also add a function to get the block device.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Makefile     |   2 +-
 boot/vbe_common.c |  93 ++++++++++++++++++++++++++++++
 boot/vbe_common.h | 143 ++++++++++++++++++++++++++++++++++++++++++++++
 boot/vbe_simple.c |  99 +++++++-------------------------
 boot/vbe_simple.h |  15 +----
 5 files changed, 258 insertions(+), 94 deletions(-)
 create mode 100644 boot/vbe_common.c
 create mode 100644 boot/vbe_common.h

diff --git a/boot/Makefile b/boot/Makefile
index 9446c6b82a9..30529bac367 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -66,7 +66,7 @@ endif
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE) += vbe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_REQUEST) += vbe_request.o
-obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
diff --git a/boot/vbe_common.c b/boot/vbe_common.c
new file mode 100644
index 00000000000..5f31cde0288
--- /dev/null
+++ b/boot/vbe_common.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verified Boot for Embedded (VBE) common functions
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <blk.h>
+#include <bootstage.h>
+#include <display_options.h>
+#include <dm.h>
+#include <image.h>
+#include <spl.h>
+#include <mapmem.h>
+#include <memalign.h>
+#include <linux/types.h>
+#include <u-boot/crc.h>
+#include "vbe_common.h"
+
+int vbe_read_version(struct udevice *blk, ulong offset, char *version,
+		     int max_size)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
+
+	if (max_size > MMC_MAX_BLOCK_LEN)
+		return log_msg_ret("ver", -E2BIG);
+
+	if (offset & (MMC_MAX_BLOCK_LEN - 1))
+		return log_msg_ret("get", -EBADF);
+	offset /= MMC_MAX_BLOCK_LEN;
+
+	if (blk_read(blk, offset, 1, buf) != 1)
+		return log_msg_ret("read", -EIO);
+	strlcpy(version, buf, max_size);
+
+	return 0;
+}
+
+int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf)
+{
+	uint hdr_ver, hdr_size, data_size, crc;
+	const struct vbe_nvdata *nvd;
+
+	if (size > MMC_MAX_BLOCK_LEN)
+		return log_msg_ret("state", -E2BIG);
+
+	if (offset & (MMC_MAX_BLOCK_LEN - 1))
+		return log_msg_ret("get", -EBADF);
+	offset /= MMC_MAX_BLOCK_LEN;
+
+	if (blk_read(blk, offset, 1, buf) != 1)
+		return log_msg_ret("read", -EIO);
+	nvd = (struct vbe_nvdata *)buf;
+	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
+	hdr_size = (nvd->hdr & NVD_HDR_SIZE_MASK) >> NVD_HDR_SIZE_SHIFT;
+	if (hdr_ver != NVD_HDR_VER_CUR)
+		return log_msg_ret("hdr", -EPERM);
+	data_size = 1 << hdr_size;
+	if (data_size > sizeof(*nvd))
+		return log_msg_ret("sz", -EPERM);
+
+	crc = crc8(0, buf + 1, data_size - 1);
+	if (crc != nvd->crc8)
+		return log_msg_ret("crc", -EPERM);
+
+	return 0;
+}
+
+int vbe_get_blk(const char *storage, struct udevice **blkp)
+{
+	struct blk_desc *desc;
+	char devname[16];
+	const char *end;
+	int devnum;
+
+	/* First figure out the block device */
+	log_debug("storage=%s\n", storage);
+	devnum = trailing_strtoln_end(storage, NULL, &end);
+	if (devnum == -1)
+		return log_msg_ret("num", -ENODEV);
+	if (end - storage >= sizeof(devname))
+		return log_msg_ret("end", -E2BIG);
+	strlcpy(devname, storage, end - storage + 1);
+	log_debug("dev=%s, %x\n", devname, devnum);
+
+	desc = blk_get_dev(devname, devnum);
+	if (!desc)
+		return log_msg_ret("get", -ENXIO);
+	*blkp = desc->bdev;
+
+	return 0;
+}
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
new file mode 100644
index 00000000000..df133fbf05f
--- /dev/null
+++ b/boot/vbe_common.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Verified Boot for Embedded (VBE) common functions
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __VBE_COMMON_H
+#define __VBE_COMMON_H
+
+#include <linux/types.h>
+
+struct udevice;
+
+/*
+ * Controls whether we use a full bootmeth driver with VBE in this phase, or
+ * just access the information directly.
+ *
+ * For now VBE-simple uses the full bootmeth, but VBE-abrec does not, to reduce
+ * code size
+ */
+#define USE_BOOTMETH	CONFIG_IS_ENABLED(BOOTMETH_VBE_SIMPLE)
+
+struct spl_image_info;
+struct spl_load_info;
+
+enum {
+	MAX_VERSION_LEN		= 256,
+
+	NVD_HDR_VER_SHIFT	= 0,
+	NVD_HDR_VER_MASK	= 0xf,
+	NVD_HDR_SIZE_SHIFT	= 4,
+	NVD_HDR_SIZE_MASK	= 0xf << NVD_HDR_SIZE_SHIFT,
+
+	/* Firmware key-version is in the top 16 bits of fw_ver */
+	FWVER_KEY_SHIFT		= 16,
+	FWVER_FW_MASK		= 0xffff,
+
+	NVD_HDR_VER_CUR		= 1,	/* current version */
+};
+
+/**
+ * enum vbe_try_result - result of trying a firmware pick
+ *
+ * @VBETR_UNKNOWN: Unknown / invalid result
+ * @VBETR_TRYING: Firmware pick is being tried
+ * @VBETR_OK: Firmware pick is OK and can be used from now on
+ * @VBETR_BAD: Firmware pick is bad and should be removed
+ */
+enum vbe_try_result {
+	VBETR_UNKNOWN,
+	VBETR_TRYING,
+	VBETR_OK,
+	VBETR_BAD,
+};
+
+/**
+ * enum vbe_flags - flags controlling operation
+ *
+ * @VBEF_TRY_COUNT_MASK: mask for the 'try count' value
+ * @VBEF_TRY_B: Try the B slot
+ * @VBEF_RECOVERY: Use recovery slot
+ */
+enum vbe_flags {
+	VBEF_TRY_COUNT_MASK	= 0x3,
+	VBEF_TRY_B	= BIT(2),
+	VBEF_RECOVERY	= BIT(3),
+
+	VBEF_RESULT_SHIFT	= 4,
+	VBEF_RESULT_MASK	= 3 << VBEF_RESULT_SHIFT,
+
+	VBEF_PICK_SHIFT		= 6,
+	VBEF_PICK_MASK		= 3 << VBEF_PICK_SHIFT,
+};
+
+/**
+ * struct vbe_nvdata - basic storage format for non-volatile data
+ *
+ * This is used for all VBE methods
+ *
+ * @crc8: crc8 for the entire record except @crc8 field itself
+ * @hdr: header size and version (NVD_HDR_...)
+ * @spare1: unused, must be 0
+ * @fw_vernum: version and key version (FWVER_...)
+ * @flags: Flags controlling operation (enum vbe_flags)
+ */
+struct vbe_nvdata {
+	u8 crc8;
+	u8 hdr;
+	u16 spare1;
+	u32 fw_vernum;
+	u32 flags;
+	u8 spare2[0x34];
+};
+
+/**
+ * vbe_read_nvdata() - Read non-volatile data from a block device
+ *
+ * Reads the VBE nvdata from a device. This function reads a single block from
+ * the device, so the nvdata cannot be larger than that.
+ *
+ * @blk: Device to read from
+ * @offset: Offset to read, in bytes
+ * @size: Number of bytes to read
+ * @buf: Buffer to hold the data
+ * Return: 0 if OK, -E2BIG if @size > block size, -EBADF if the offset is not
+ * block-aligned, -EIO if an I/O error occurred, -EPERM if the header version is
+ * incorrect, the header size is invalid or the data fails its CRC check
+ */
+int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf);
+
+/**
+ * vbe_read_version() - Read version-string from a block device
+ *
+ * Reads the VBE version-string from a device. This function reads a single
+ * block from the device, so the string cannot be larger than that. It uses a
+ * temporary buffer for the read, then copies in up to @size bytes
+ *
+ * @blk: Device to read from
+ * @offset: Offset to read, in bytes
+ * @version: Place to put the string
+ * @max_size: Maximum size of @version
+ * Return: 0 if OK, -E2BIG if @max_size > block size, -EBADF if the offset is
+ * not block-aligned, -EIO if an I/O error occurred
+ */
+int vbe_read_version(struct udevice *blk, ulong offset, char *version,
+		     int max_size);
+
+/**
+ * vbe_get_blk() - Obtain the block device to use for VBE
+ *
+ * Decodes the string to produce a block device
+ *
+ * @storage: String indicating the device to use, e.g. "mmc1"
+ * @blkp: Returns associated block device, on success
+ * Return 0 if OK, -ENODEV if @storage does not end with a number, -E2BIG if
+ * the device name is more than 15 characters, -ENXIO if the block device could
+ * not be found
+ */
+int vbe_get_blk(const char *storage, struct udevice **blkp);
+
+#endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index ed7b9598e38..792750f7ef6 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -18,70 +18,23 @@
 #include <vbe.h>
 #include <dm/device-internal.h>
 #include <dm/ofnode.h>
-#include <u-boot/crc.h>
+#include "vbe_common.h"
 #include "vbe_simple.h"
 
-/** struct simple_nvdata - storage format for non-volatile data */
-struct simple_nvdata {
-	u8 crc8;
-	u8 hdr;
-	u16 spare1;
-	u32 fw_vernum;
-	u8 spare2[0x38];
-};
-
-static int simple_read_version(struct udevice *dev, struct blk_desc *desc,
-			       u8 *buf, struct simple_state *state)
+static int simple_read_nvdata(struct udevice *dev, struct udevice *blk,
+			      struct simple_state *state)
 {
+	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	struct simple_priv *priv = dev_get_priv(dev);
-	int start;
-
-	if (priv->version_size > MMC_MAX_BLOCK_LEN)
-		return log_msg_ret("ver", -E2BIG);
-
-	start = priv->area_start + priv->version_offset;
-	if (start & (MMC_MAX_BLOCK_LEN - 1))
-		return log_msg_ret("get", -EBADF);
-	start /= MMC_MAX_BLOCK_LEN;
-
-	if (blk_dread(desc, start, 1, buf) != 1)
-		return log_msg_ret("read", -EIO);
-	strlcpy(state->fw_version, buf, MAX_VERSION_LEN);
-	log_debug("version=%s\n", state->fw_version);
+	const struct vbe_nvdata *nvd;
+	int ret;
 
-	return 0;
-}
+	ret = vbe_read_nvdata(blk, priv->area_start + priv->state_offset,
+			      priv->state_size, buf);
+	if (ret)
+		return log_msg_ret("nv", ret);
 
-static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
-			      u8 *buf, struct simple_state *state)
-{
-	struct simple_priv *priv = dev_get_priv(dev);
-	uint hdr_ver, hdr_size, size, crc;
-	const struct simple_nvdata *nvd;
-	int start;
-
-	if (priv->state_size > MMC_MAX_BLOCK_LEN)
-		return log_msg_ret("state", -E2BIG);
-
-	start = priv->area_start + priv->state_offset;
-	if (start & (MMC_MAX_BLOCK_LEN - 1))
-		return log_msg_ret("get", -EBADF);
-	start /= MMC_MAX_BLOCK_LEN;
-
-	if (blk_dread(desc, start, 1, buf) != 1)
-		return log_msg_ret("read", -EIO);
-	nvd = (struct simple_nvdata *)buf;
-	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
-	hdr_size = (nvd->hdr & NVD_HDR_SIZE_MASK) >> NVD_HDR_SIZE_SHIFT;
-	if (hdr_ver != NVD_HDR_VER_CUR)
-		return log_msg_ret("hdr", -EPERM);
-	size = 1 << hdr_size;
-	if (size > sizeof(*nvd))
-		return log_msg_ret("sz", -ENOEXEC);
-
-	crc = crc8(0, buf + 1, size - 1);
-	if (crc != nvd->crc8)
-		return log_msg_ret("crc", -EPERM);
+	nvd = (struct vbe_nvdata *)buf;
 	state->fw_vernum = nvd->fw_vernum;
 
 	log_debug("version=%s\n", state->fw_version);
@@ -91,33 +44,21 @@ static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
 
 int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	struct simple_priv *priv = dev_get_priv(dev);
-	struct blk_desc *desc;
-	char devname[16];
-	const char *end;
-	int devnum;
+	struct udevice *blk;
 	int ret;
 
-	/* First figure out the block device */
-	log_debug("storage=%s\n", priv->storage);
-	devnum = trailing_strtoln_end(priv->storage, NULL, &end);
-	if (devnum == -1)
-		return log_msg_ret("num", -ENODEV);
-	if (end - priv->storage >= sizeof(devname))
-		return log_msg_ret("end", -E2BIG);
-	strlcpy(devname, priv->storage, end - priv->storage + 1);
-	log_debug("dev=%s, %x\n", devname, devnum);
-
-	desc = blk_get_dev(devname, devnum);
-	if (!desc)
-		return log_msg_ret("get", -ENXIO);
-
-	ret = simple_read_version(dev, desc, buf, state);
+	ret = vbe_get_blk(priv->storage, &blk);
+	if (ret)
+		return log_msg_ret("blk", ret);
+
+	ret = vbe_read_version(blk, priv->area_start + priv->version_offset,
+			       state->fw_version, MAX_VERSION_LEN);
 	if (ret)
 		return log_msg_ret("ver", ret);
+	log_debug("version=%s\n", state->fw_version);
 
-	ret = simple_read_nvdata(dev, desc, buf, state);
+	ret = simple_read_nvdata(dev, blk, state);
 	if (ret)
 		return log_msg_ret("nvd", ret);
 
diff --git a/boot/vbe_simple.h b/boot/vbe_simple.h
index 56d319206f2..8eb3ddb61ba 100644
--- a/boot/vbe_simple.h
+++ b/boot/vbe_simple.h
@@ -9,20 +9,7 @@
 #ifndef __VBE_SIMPLE_H
 #define __VBE_SIMPLE_H
 
-enum {
-	MAX_VERSION_LEN		= 256,
-
-	NVD_HDR_VER_SHIFT	= 0,
-	NVD_HDR_VER_MASK	= 0xf,
-	NVD_HDR_SIZE_SHIFT	= 4,
-	NVD_HDR_SIZE_MASK	= 0xf << NVD_HDR_SIZE_SHIFT,
-
-	/* Firmware key-version is in the top 16 bits of fw_ver */
-	FWVER_KEY_SHIFT		= 16,
-	FWVER_FW_MASK		= 0xffff,
-
-	NVD_HDR_VER_CUR		= 1,	/* current version */
-};
+#include "vbe_common.h"
 
 /** struct simple_priv - information read from the device tree */
 struct simple_priv {
-- 
2.34.1

