Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D29CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9D584894;
	Wed, 27 May 2026 18:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZkJ9phci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCED84851; Wed, 27 May 2026 18:11:23 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC728487C
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e66f966d01so728891a34.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898280; x=1780503080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6/uvBK+2AoSvUarQFHy9twUpY9cv3rg1ROfBG5qhK0=;
 b=ZkJ9phciilvoklSXJ9yr3tMQ1fohzsSeuOA8VOf4mBxvYMvqxJbygOsfycjtyEG2o5
 JRY9Sq4lznpL7pDOt0atU0CviPe1bay0LQI5Wz055LxCnCokYx1he/oIWCHFsNvmDtVz
 WXmqYxwxZSWBjkS7jmVpMfpZI9BUlEyNK/KnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898280; x=1780503080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v6/uvBK+2AoSvUarQFHy9twUpY9cv3rg1ROfBG5qhK0=;
 b=Rn9Ev+RNci4G+bNmScnlu9cta0tIJPIcTeQg6EYLXYX1sgl9h9Y4gc4XoXcRjlzhFn
 MB3FZ3V8TjuoH1s+s4PIHIwuygIDU7dOkKBdJxFujmvCB3cD+fX7h/wz0+lHlan526RQ
 w1nq+cOwrMVcYhBd+6jb0a03sqKx247IHPEDdie8tG9NjdHya90cEm3wMaVjSs+n6+9y
 l2ljUH5XaiBDJYzMjKKCIkEuJaDx9hkTimhr/jeRC53LvO9a+rchiaJk1+y9uuJDkCkJ
 jtQ5EPnznaoiX5PDrAZiM0mEcJigTyv09OdifLtzMjQbLllHSX6poK3Xm0B+c4wZtQ0x
 Kb/w==
X-Gm-Message-State: AOJu0Ywk4up0T6xxxnB46Rr58CC0LfLXGVvMugnhimBeVbO6YsbwY2NU
 HS6V99PH+OMmNHCzVS1TNZ0nmh7qj3c3urd+OTieOcmPbOm+kBQHiRD4hqqyuFc1ilXtNHQ3isi
 kIRJt5FPh120Erg==
X-Gm-Gg: Acq92OE2Eb6YB8Ik2huO1TcEEvVuleERRY6Wbgbv90udBPkDQKT7wdbF9mrk59cQbRw
 jrAQCd+IyktwhPW1JOxLsfEm/bToqkCCgz5EXuwFpdvNHBlQfL1l3panwJGgn2mBaMB5XYinSlD
 3Bd26UneAiyFR7I7uc+rp+ajW/d9cPVCZdYc9qILyBOiYfUl89d2VRcxTU7LmMN9USSAjCBX/Ot
 I9/6dy1DMlL/IjteufckbcqSOOB+fU8ec4/VEBmc+A8wv0LXze5FimhlocioKM9lTFBsqIqjzlb
 4zvqWES8nDDUXBJA6/nd3yi1xJISOVBGLUzcAmqzqYOh8CtKMgLWVzmvEq3KtH/FS/ll/O6OEsg
 8iK931GRyAyjowQpkpIq+21nYvc19fxiLlTskcfgrAYB+MCbqErQWbN/LuTeiKAcMvmr7h6AmFh
 J926c4zmAROZvhkYzRqio9dv8qFVEJWLBkQ/SRLsM=
X-Received: by 2002:a05:6830:6007:b0:7de:c87f:53f4 with SMTP id
 46e09a7af769-7e5fefcbc20mr14217808a34.15.1779898279842; 
 Wed, 27 May 2026 09:11:19 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/13] virtio: Implement a simple block-device emulator
Date: Wed, 27 May 2026 10:10:17 -0600
Message-ID: <20260527161033.3273795-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
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

Add an emulator driver for block devices, so that sandbox can test these
fully. The emulator uses MMIO to communicate with the controlling virtio
device.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/sandbox_defconfig   |   1 +
 drivers/virtio/Makefile     |   2 +-
 drivers/virtio/emul_blk.c   | 176 ++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_blk.h |   3 +
 4 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/emul_blk.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..fbc30969534 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -363,6 +363,7 @@ CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_W1=y
 CONFIG_W1_GPIO=y
 CONFIG_W1_EEPROM=y
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index d928c7b0ad2..4709e16f789 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci_modern.o
 obj-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
 obj-$(CONFIG_VIRTIO_SANDBOX) += virtio_sandbox.o
-obj-$(CONFIG_VIRTIO_SANDBOX_EMUL) += sandbox_emul.o
+obj-$(CONFIG_VIRTIO_SANDBOX_EMUL) += sandbox_emul.o emul_blk.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
diff --git a/drivers/virtio/emul_blk.c b/drivers/virtio/emul_blk.c
new file mode 100644
index 00000000000..62ee125cf3c
--- /dev/null
+++ b/drivers/virtio/emul_blk.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Emulation of a block device. This implements a simple version of the QEMU
+ * side of the interface.
+ *
+ * Copyright 2025 Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
+#include <dm.h>
+#include <malloc.h>
+#include <virtio.h>
+#include <asm/io.h>
+#include <linux/sizes.h>
+#include "virtio_blk.h"
+#include "virtio_ring.h"
+#include "sandbox_emul.h"
+
+enum {
+	DISK_SIZE_MB	= 1,
+	SECTOR_SIZE	= 512,
+};
+
+/**
+ * struct virtio_blk_emul_priv - private data for the block emulator
+ *
+ * @config: virtio block-device-configuration structure, exposed to the driver
+ *	through the config space
+ * @disk_data: allocated memory for the virtual disk
+ * @disk_size: total size of the virtual disk in bytes
+ */
+struct virtio_blk_emul_priv {
+	struct virtio_blk_config config;
+	void *disk_data;
+	u64 disk_size;
+};
+
+/**
+ * blk_emul_process_req() - Handle one virtio-blk request from the driver
+ *
+ * Implements the .process_request callback for the virtio-blk emulator.
+ * Each request is a chain of three descriptors:
+ *
+ *	1. virtio_blk_outhdr	- request header (type, sector)
+ *	2. data buffer		- payload for read or write
+ *	3. status byte		- result code returned to the driver
+ *
+ * For VIRTIO_BLK_T_IN the data buffer is filled from @priv->disk_data; for
+ * VIRTIO_BLK_T_OUT it is copied into it. Out-of-range and unsupported
+ * requests are reported through the status byte rather than returned as
+ * errors. The number of bytes the device wrote (data + status) is reported
+ * via @lenp so the caller can populate the used-ring entry.
+ *
+ * @dev: The block emulator device
+ * @descs: Pointer to the virtqueue's descriptor table
+ * @head_idx: Index of the first descriptor in the chain
+ * @lenp: Returns total bytes written by the device
+ * Return: 0 (a malformed chain returns -EIO; payload errors are reported
+ *	through the status byte and still return 0)
+ */
+static int blk_emul_process_req(struct udevice *dev,
+				struct vring_desc *descs, u32 head_idx,
+				int *lenp)
+{
+	struct virtio_blk_emul_priv *priv = dev_get_priv(dev);
+	struct vring_desc *hdr_desc, *data_desc, *status_desc;
+	struct virtio_blk_outhdr *hdr;
+	void *data_buf;
+	u64 offset;
+	u8 *status;
+
+	hdr_desc = &descs[head_idx];
+	if (!(hdr_desc->flags & VRING_DESC_F_NEXT))
+		return -EIO;
+	data_desc = &descs[hdr_desc->next];
+	if (!(data_desc->flags & VRING_DESC_F_NEXT))
+		return -EIO;
+	status_desc = &descs[data_desc->next];
+
+	hdr = (struct virtio_blk_outhdr *)hdr_desc->addr;
+	status = (u8 *)status_desc->addr;
+
+	offset = hdr->sector * SECTOR_SIZE;
+	if (offset + data_desc->len > priv->disk_size) {
+		*status = VIRTIO_BLK_S_IOERR;
+		*lenp = 1;
+		return 0;
+	}
+
+	data_buf = (void *)data_desc->addr;
+
+	switch (hdr->type) {
+	case VIRTIO_BLK_T_IN:
+		log_debug("read: sector %lld, len %u\n", hdr->sector,
+			  data_desc->len);
+		memcpy(data_buf, priv->disk_data + offset, data_desc->len);
+		*lenp = data_desc->len;
+		break;
+	case VIRTIO_BLK_T_OUT:
+		log_debug("write: sector %lld, len %u\n", hdr->sector,
+			  data_desc->len);
+		memcpy(priv->disk_data + offset, data_buf, data_desc->len);
+		*lenp = 0;
+		break;
+	default:
+		log_warning("unknown request type 0x%x\n", hdr->type);
+		*status = VIRTIO_BLK_S_UNSUPP;
+		*lenp = 1;
+		return 0;
+	}
+
+	*status = VIRTIO_BLK_S_OK;
+	*lenp += 1; /* For the status byte */
+
+	return 0;
+}
+
+static int blk_emul_get_config(struct udevice *dev, ulong offset, void *buf,
+			       enum sandboxio_size_t size)
+{
+	struct virtio_blk_emul_priv *priv = dev_get_priv(dev);
+
+	if (offset + size > sizeof(priv->config))
+		return -EIO;
+
+	memcpy(buf, (u8 *)&priv->config + offset, size);
+
+	return 0;
+}
+
+static u64 blk_emul_get_features(struct udevice *dev)
+{
+	return BIT(VIRTIO_BLK_F_BLK_SIZE);
+}
+
+static u32 blk_emul_get_device_id(struct udevice *dev)
+{
+	return VIRTIO_ID_BLOCK;
+}
+
+static int virtio_blk_emul_probe(struct udevice *dev)
+{
+	struct virtio_blk_emul_priv *priv = dev_get_priv(dev);
+
+	priv->disk_size = (u64)DISK_SIZE_MB * SZ_1M;
+	priv->disk_data = calloc(1, priv->disk_size);
+	if (!priv->disk_data)
+		return -ENOMEM;
+
+	priv->config.capacity = priv->disk_size / SECTOR_SIZE;
+	priv->config.blk_size = SECTOR_SIZE;
+
+	return 0;
+}
+
+static struct virtio_emul_ops blk_emul_ops = {
+	.process_request = blk_emul_process_req,
+	.get_config = blk_emul_get_config,
+	.get_features = blk_emul_get_features,
+	.get_device_id = blk_emul_get_device_id,
+};
+
+static const struct udevice_id virtio_blk_emul_ids[] = {
+	{ .compatible = "sandbox,virtio-blk-emul" },
+	{ }
+};
+
+U_BOOT_DRIVER(virtio_blk_emul) = {
+	.name	= "virtio_blk_emul",
+	.id	= UCLASS_VIRTIO_EMUL,
+	.of_match = virtio_blk_emul_ids,
+	.probe	= virtio_blk_emul_probe,
+	.ops	= &blk_emul_ops,
+	.priv_auto	= sizeof(struct virtio_blk_emul_priv),
+};
diff --git a/drivers/virtio/virtio_blk.h b/drivers/virtio/virtio_blk.h
index b37ba264df4..cbb6996ebde 100644
--- a/drivers/virtio/virtio_blk.h
+++ b/drivers/virtio/virtio_blk.h
@@ -9,6 +9,9 @@
 #ifndef _LINUX_VIRTIO_BLK_H
 #define _LINUX_VIRTIO_BLK_H
 
+#include <compiler.h>
+#include "virtio_types.h"
+
 /* Feature bits */
 #define VIRTIO_BLK_F_SIZE_MAX	1	/* Indicates maximum segment size */
 #define VIRTIO_BLK_F_SEG_MAX	2	/* Indicates maximum # of segments */
-- 
2.43.0

