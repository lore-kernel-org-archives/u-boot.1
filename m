Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EAECD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 05:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6D88460E;
	Sat, 23 May 2026 07:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="opYYdta9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F2D84673; Sat, 23 May 2026 07:50:17 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF826805D7
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 07:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so4181576a91.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1779515411; x=1780120211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AaOr0RgA/54RhtAPasvB/tNQyayTj4pv8PEUMr5q4UY=;
 b=opYYdta9DOkAlWfnDaCT/An9YATtVsV3aijq3jTI3OybiiTXLIENmaDIUzWLC5WpqM
 90ELbRkDHqHhEtx1H7QyDY6gqNmrvKteCC1rEHADqbvd6LF3Y6Mtue2XMGz7xXZMkg6/
 3dL/CX43W4dg/9qf85QH7qQ8fpOlsf6/rBW7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779515411; x=1780120211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaOr0RgA/54RhtAPasvB/tNQyayTj4pv8PEUMr5q4UY=;
 b=OMWt6jkabgvSgGRxvxYll3kcDp19T45y+dMv1o5Jm98niyd8oxEA0pqzHjUQnFSxC/
 /UfAQ+qpHXqgAb0k8iuAIMbxxh2/+yq0pDyTF+HMRbiva3MEY1VulAF8GIHo+oCyRefT
 yEWM1EOsNEb6CirkCseT8eOKUYDjxqEXxatMFk4hE/t+tt1X5bXKAdJnQMt67HZ3alj9
 eZ2mRE1Xz4KrDf+jw8J/iF2uxd+Cy6H7llbfVS6RwcpqHAwazq+RivlNQwpzvi6UJ1JK
 rWC3Cm7ljVYxiPtFeyUoLrxKop0qtSksWrogV9Hdg8kAMyteJ2pjQOaFYU/qGwwgnifI
 Okzw==
X-Gm-Message-State: AOJu0YydMNtORjs4UKXYON9msVuyifTANxLmsHeOpeQN+ZNHlbT/rMfY
 qK/eCF6jeaWkgLtl+2dtKMVasDqhrequyWA4znIOrFnXrHBUZJyd/kEehXJ79xUX8NkP9NmO0xH
 H8UZ8
X-Gm-Gg: Acq92OGqfWkLu2qtFX12UFXPGFRV6EdcN0FWEPmtUwEDE5dJ5f9nUYOkMEq7nGxmsJR
 Hwl5k5TRM3U6YxG4uH2yvgE86bkHogCFiD5aJLI5OXSc04bk3ew0AFLjRZpEMi94MTFN7Lx5c6B
 GxnKhqef/lMPWWw+VjgjzQo/UMzFhULxKFpI8s3QvtyJMdlfOvNw/kh2pMlSH78A6EQVWv9TnI8
 /BendZ0BhSmtSvLcR+u7JTK2ZDyfCp+MfgsmgNDxBlzeWiR/wmjKMzh90QreoZTfXIuG71kP1RM
 iyerpd8RT/lNEPUy4/TZ6ihE50+uR5jvqZfntP/1J2l3sQzPMKq0isykmXOjx85zJta4kRkTAl6
 VlknTcAom1KIxB5NRmD/fbT96T4adMgGNWuv+azRA65RyuuHUUPLWGWiFII5JFK6vGoww210EjQ
 PRogtM+zQcLV4+u2Rkdcy2RizIGjwUw2vzzebJHDSK2Ysob7GL25x2B68b0NIWjsNjO3dCJyPk2
 EYRRzU7zCv+tA==
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id
 98e67ed59e1d1-36a473cf321mr8747766a91.3.1779515411105; 
 Fri, 22 May 2026 22:50:11 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c852054d845sm2772545a12.18.2026.05.22.22.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 22:50:10 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: bmeng.cn@gmail.com,
	sjg@chromium.org,
	visitorckw@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH] virtio: Add driver for virtio gpu
Date: Sat, 23 May 2026 14:50:00 +0900
Message-ID: <20260523055000.1059981-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
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

Add a basic driver for virtio gpu. This allows for a video on
qemu virt machines.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---

Since the m68k virtio stuff is now in next I thought I'd send this.
This patch is based on next.

This is a very simple driver for virtio gpu that works just enough
to create a framebuffer that u-boot can use.

I've been playing with this on m68k and its shown that some of the
framebuffer code has some endian issues.

I think this is useful for testing the framebuffer code on other
arches like arm, riscv and so on.

Open to comments, ideas etc.

 drivers/virtio/Kconfig         |  19 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_gpu.c    | 284 ++++++++++++++++++++
 drivers/virtio/virtio_gpu.h    | 461 +++++++++++++++++++++++++++++++++
 include/virtio.h               |  10 +-
 6 files changed, 772 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_gpu.c
 create mode 100644 drivers/virtio/virtio_gpu.h

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 512ac376f185..d554346a2772 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -77,4 +77,23 @@ config VIRTIO_RNG
 	help
 	  This is the virtual random number generator driver. It can be used
 	  with QEMU based targets.
+
+config VIRTIO_GPU
+	bool "virtio gpu driver"
+	depends on VIDEO
+	depends on VIRTIO
+	help
+	  This is the virtual GPU driver. It can be used
+	  with QEMU based targets.
+
+if VIRTIO_GPU
+config VIRTIO_DEFAULT_WIDTH
+	int "default width"
+	default 1024
+
+config VIRTIO_DEFAULT_HEIGHT
+	int "default height"
+	default 768
+endif
+
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4c63a6c69043..c830fb6e6049 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_VIRTIO_SANDBOX) += virtio_sandbox.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
+obj-$(CONFIG_VIRTIO_GPU) += virtio_gpu.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c36e9e9b3a77..f040907e3a84 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -30,6 +30,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_NET]		= VIRTIO_NET_DRV_NAME,
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
+	[VIRTIO_ID_GPU]		= VIRTIO_GPU_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu.c
new file mode 100644
index 000000000000..cd4dbc6857aa
--- /dev/null
+++ b/drivers/virtio/virtio_gpu.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio GPU driver
+ * 2025 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <video.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+
+#include "virtio_gpu.h"
+
+#define VQ_CONTROL		0
+#define VQ_CURSOR		1
+#define NUM_VQS			2
+#define FRAMEBUFFER_RESOURCE_ID	1
+
+struct virtio_gpu_priv {
+	struct virtqueue *vqs[NUM_VQS];
+};
+
+static int virtio_gpu_cmd(struct virtqueue *vq,
+			  void *req, size_t req_size,
+			  void *resp, size_t resp_size)
+{
+	struct virtio_sg resp_sg = { resp, resp_size };
+	struct virtio_sg req_sg = { req, req_size };
+	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
+	struct virtio_gpu_ctrl_hdr *resp_hdr = resp;
+	int ret;
+
+	ret = virtqueue_add(vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(vq);
+
+	while (!virtqueue_get_buf(vq, NULL))
+		;
+
+	/* Some basic error handling */
+	switch (le32_to_cpu(resp_hdr->type)) {
+	case VIRTIO_GPU_RESP_ERR_UNSPEC:
+	case VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID:
+	case VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID:
+	case VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID:
+	case VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER:
+		return -EINVAL;
+	case VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY:
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int virtio_gpu_get_display_info(struct virtqueue *vq,
+				       struct virtio_gpu_resp_display_info *info)
+{
+	struct virtio_gpu_ctrl_hdr req = {
+		.type = cpu_to_le32(VIRTIO_GPU_CMD_GET_DISPLAY_INFO),
+	};
+
+	return virtio_gpu_cmd(vq, &req, sizeof(req), info, sizeof(*info));
+}
+
+static int virtio_gpu_resource_create_2d(struct virtqueue *vq,
+					 u32 resource_id,
+					 u32 format,
+					 u32 width,
+					 u32 height)
+{
+	struct virtio_gpu_resource_create_2d req = {
+		.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D),
+		.resource_id = cpu_to_le32(resource_id),
+		.format	= cpu_to_le32(format),
+		.width = cpu_to_le32(width),
+		.height = cpu_to_le32(height),
+	};
+	struct virtio_gpu_ctrl_hdr resp;
+
+	return virtio_gpu_cmd(vq, &req, sizeof(req), &resp, sizeof(resp));
+}
+
+struct virtio_gpu_attach_backing_hdr_ent {
+	struct virtio_gpu_resource_attach_backing hdr;
+	struct virtio_gpu_mem_entry entry;
+};
+
+static int virtio_gpu_resource_attach_backing(struct virtqueue *vq,
+					      u32 resource_id,
+					      u64 addr,
+					      u32 length)
+{
+	struct virtio_gpu_attach_backing_hdr_ent req = {
+		.hdr = {
+			.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING),
+			.resource_id = cpu_to_le32(resource_id),
+			.nr_entries = cpu_to_le32(1),
+		},
+		.entry = {
+			.addr = cpu_to_le64(addr),
+			.length = cpu_to_le32(length),
+		},
+	};
+	struct virtio_gpu_ctrl_hdr resp;
+
+	return virtio_gpu_cmd(vq, &req, sizeof(req), &resp, sizeof(resp));
+}
+
+static int virtio_gpu_set_scanout(struct virtqueue *vq,
+				  u32 resource_id,
+				  u32 width, u32 height)
+{
+	struct virtio_gpu_set_scanout req = {
+		.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_SET_SCANOUT),
+		.resource_id = cpu_to_le32(resource_id),
+		.r = {
+			.width = cpu_to_le32(width),
+			.height = cpu_to_le32(height),
+		},
+	};
+	struct virtio_gpu_ctrl_hdr resp;
+
+	return virtio_gpu_cmd(vq, &req, sizeof(req), &resp, sizeof(resp));
+}
+
+static int virtio_gpu_set_transfer_to_host_2d(struct virtqueue *vq,
+					      u32 resource_id,
+					      u32 width,
+					      u32 height)
+{
+	struct virtio_gpu_transfer_to_host_2d req = {
+		.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D),
+		.resource_id = cpu_to_le32(resource_id),
+		.r = {
+			.width = cpu_to_le32(width),
+			.height = cpu_to_le32(height),
+		},
+	};
+	struct virtio_gpu_ctrl_hdr resp;
+
+	return virtio_gpu_cmd(vq, &req, sizeof(req), &resp, sizeof(resp));
+}
+
+static int virtio_gpu_resource_flush(struct virtqueue *vq,
+				     u32 resource_id,
+				     u32 width,
+				     u32 height)
+{
+	struct virtio_gpu_resource_flush req = {
+		.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_FLUSH),
+		.resource_id = cpu_to_le32(resource_id),
+		.r = {
+			.width = cpu_to_le32(width),
+			.height = cpu_to_le32(height),
+		},
+	};
+	struct virtio_gpu_ctrl_hdr resp;
+
+	return virtio_gpu_cmd(vq, &req, sizeof(req), &resp, sizeof(resp));
+}
+
+static int virtio_gpu_flush(struct udevice *dev)
+{
+	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct virtio_gpu_priv *priv = dev_get_priv(dev);
+	struct virtqueue *vq = priv->vqs[VQ_CONTROL];
+	int ret;
+
+	ret = virtio_gpu_set_transfer_to_host_2d(vq,
+						 FRAMEBUFFER_RESOURCE_ID,
+						 uc_priv->xsize,
+						 uc_priv->ysize);
+	if (ret)
+		return ret;
+
+	ret = virtio_gpu_resource_flush(vq,
+					FRAMEBUFFER_RESOURCE_ID,
+					uc_priv->xsize,
+					uc_priv->ysize);
+
+	return ret;
+}
+
+static int virtio_gpu_probe(struct udevice *dev)
+{
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct virtio_gpu_priv *priv = dev_get_priv(dev);
+	struct virtio_gpu_resp_display_info display_info;
+	struct virtqueue *vq;
+	u32 width, height;
+	int ret;
+	int i;
+
+	width = CONFIG_VIRTIO_DEFAULT_WIDTH;
+	height = CONFIG_VIRTIO_DEFAULT_HEIGHT;
+
+	ret = virtio_find_vqs(dev, NUM_VQS, priv->vqs);
+	if (ret)
+		return ret;
+
+	vq = priv->vqs[VQ_CONTROL];
+
+	ret = virtio_gpu_get_display_info(vq,
+					  &display_info);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
+		u32 h = le32_to_cpu(display_info.pmodes[i].r.height);
+		u32 w = le32_to_cpu(display_info.pmodes[i].r.width);
+		u32 e = le32_to_cpu(display_info.pmodes[i].enabled);
+
+		if (!e)
+			continue;
+
+		/* For now just use the first enabled one */
+		width = w;
+		height = h;
+		break;
+	}
+
+	/* Just use 32 bpp rgba for now */
+	uc_priv->xsize  = width;
+	uc_priv->ysize  = height;
+	uc_priv->bpix   = VIDEO_BPP32;
+	uc_priv->format = VIDEO_RGBA8888;
+
+	ret = virtio_gpu_resource_create_2d(vq,
+					    FRAMEBUFFER_RESOURCE_ID,
+					    VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM,
+					    uc_priv->xsize,
+					    uc_priv->ysize);
+	if (ret)
+		return ret;
+
+	/* virtio GPU apparently doesn't care about alignment */
+	plat->size = (width * height) * 4;
+	plat->base = (ulong)malloc(plat->size);
+	if (!plat->base)
+		return -ENOMEM;
+
+	ret = virtio_gpu_resource_attach_backing(vq,
+						 FRAMEBUFFER_RESOURCE_ID,
+						 plat->base,
+						 round_up(plat->size, 4096));
+	if (ret)
+		goto err;
+
+	ret = virtio_gpu_set_scanout(vq,
+				     FRAMEBUFFER_RESOURCE_ID,
+				     uc_priv->xsize,
+				     uc_priv->ysize);
+	if (ret)
+		goto err;
+
+	/* Do an initial flush to activate the output */
+	ret = virtio_gpu_flush(dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	free((void *)plat->base);
+	return ret;
+}
+
+static const struct video_ops virtio_gpu_ops = {
+	.video_sync = virtio_gpu_flush,
+};
+
+U_BOOT_DRIVER(virtio_gpu) = {
+	.name	   = VIRTIO_GPU_DRV_NAME,
+	.id        = UCLASS_VIDEO,
+	.ops       = &virtio_gpu_ops,
+	.probe     = virtio_gpu_probe,
+	.flags     = DM_FLAG_ACTIVE_DMA,
+	.priv_auto = sizeof(struct virtio_gpu_priv),
+};
diff --git a/drivers/virtio/virtio_gpu.h b/drivers/virtio/virtio_gpu.h
new file mode 100644
index 000000000000..6732c7218ca2
--- /dev/null
+++ b/drivers/virtio/virtio_gpu.h
@@ -0,0 +1,461 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Virtio GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2014
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This header is BSD licensed so anyone can use the definitions
+ * to implement compatible drivers/servers:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef VIRTIO_GPU_HW_H
+#define VIRTIO_GPU_HW_H
+
+#include <linux/types.h>
+
+/*
+ * VIRTIO_GPU_CMD_CTX_*
+ * VIRTIO_GPU_CMD_*_3D
+ */
+#define VIRTIO_GPU_F_VIRGL               0
+
+/*
+ * VIRTIO_GPU_CMD_GET_EDID
+ */
+#define VIRTIO_GPU_F_EDID                1
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
+ */
+#define VIRTIO_GPU_F_RESOURCE_UUID       2
+
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
+ */
+#define VIRTIO_GPU_F_RESOURCE_BLOB       3
+/*
+ * VIRTIO_GPU_CMD_CREATE_CONTEXT with
+ * context_init and multiple timelines
+ */
+#define VIRTIO_GPU_F_CONTEXT_INIT        4
+
+enum virtio_gpu_ctrl_type {
+	VIRTIO_GPU_UNDEFINED = 0,
+
+	/* 2d commands */
+	VIRTIO_GPU_CMD_GET_DISPLAY_INFO = 0x0100,
+	VIRTIO_GPU_CMD_RESOURCE_CREATE_2D,
+	VIRTIO_GPU_CMD_RESOURCE_UNREF,
+	VIRTIO_GPU_CMD_SET_SCANOUT,
+	VIRTIO_GPU_CMD_RESOURCE_FLUSH,
+	VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D,
+	VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING,
+	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
+	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
+	VIRTIO_GPU_CMD_GET_CAPSET,
+	VIRTIO_GPU_CMD_GET_EDID,
+	VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
+	VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB,
+	VIRTIO_GPU_CMD_SET_SCANOUT_BLOB,
+
+	/* 3d commands */
+	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
+	VIRTIO_GPU_CMD_CTX_DESTROY,
+	VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE,
+	VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE,
+	VIRTIO_GPU_CMD_RESOURCE_CREATE_3D,
+	VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
+	VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D,
+	VIRTIO_GPU_CMD_SUBMIT_3D,
+	VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
+	VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
+
+	/* cursor commands */
+	VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
+	VIRTIO_GPU_CMD_MOVE_CURSOR,
+
+	/* success responses */
+	VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
+	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
+	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
+	VIRTIO_GPU_RESP_OK_CAPSET,
+	VIRTIO_GPU_RESP_OK_EDID,
+	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
+	VIRTIO_GPU_RESP_OK_MAP_INFO,
+
+	/* error responses */
+	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
+	VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY,
+	VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID,
+	VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
+	VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
+	VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
+};
+
+enum virtio_gpu_shm_id {
+	VIRTIO_GPU_SHM_ID_UNDEFINED = 0,
+	/*
+	 * VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB
+	 * VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB
+	 */
+	VIRTIO_GPU_SHM_ID_HOST_VISIBLE = 1
+};
+
+#define VIRTIO_GPU_FLAG_FENCE         (1 << 0)
+/*
+ * If the following flag is set, then ring_idx contains the index
+ * of the command ring that needs to used when creating the fence
+ */
+#define VIRTIO_GPU_FLAG_INFO_RING_IDX (1 << 1)
+
+struct virtio_gpu_ctrl_hdr {
+	__le32 type;
+	__le32 flags;
+	__le64 fence_id;
+	__le32 ctx_id;
+	__u8 ring_idx;
+	__u8 padding[3];
+};
+
+/* data passed in the cursor vq */
+
+struct virtio_gpu_cursor_pos {
+	__le32 scanout_id;
+	__le32 x;
+	__le32 y;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_UPDATE_CURSOR, VIRTIO_GPU_CMD_MOVE_CURSOR */
+struct virtio_gpu_update_cursor {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_cursor_pos pos;  /* update & move */
+	__le32 resource_id;           /* update only */
+	__le32 hot_x;                 /* update only */
+	__le32 hot_y;                 /* update only */
+	__le32 padding;
+};
+
+/* data passed in the control vq, 2d related */
+
+struct virtio_gpu_rect {
+	__le32 x;
+	__le32 y;
+	__le32 width;
+	__le32 height;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_UNREF */
+struct virtio_gpu_resource_unref {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_2D: create a 2d resource with a format */
+struct virtio_gpu_resource_create_2d {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 format;
+	__le32 width;
+	__le32 height;
+};
+
+/* VIRTIO_GPU_CMD_SET_SCANOUT */
+struct virtio_gpu_set_scanout {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_rect r;
+	__le32 scanout_id;
+	__le32 resource_id;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_FLUSH */
+struct virtio_gpu_resource_flush {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_rect r;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D: simple transfer to_host */
+struct virtio_gpu_transfer_to_host_2d {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_rect r;
+	__le64 offset;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+struct virtio_gpu_mem_entry {
+	__le64 addr;
+	__le32 length;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING */
+struct virtio_gpu_resource_attach_backing {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 nr_entries;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING */
+struct virtio_gpu_resource_detach_backing {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_DISPLAY_INFO */
+#define VIRTIO_GPU_MAX_SCANOUTS 16
+struct virtio_gpu_resp_display_info {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_display_one {
+		struct virtio_gpu_rect r;
+		__le32 enabled;
+		__le32 flags;
+	} pmodes[VIRTIO_GPU_MAX_SCANOUTS];
+};
+
+/* data passed in the control vq, 3d related */
+
+struct virtio_gpu_box {
+	__le32 x, y, z;
+	__le32 w, h, d;
+};
+
+/* VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D, VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D */
+struct virtio_gpu_transfer_host_3d {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_box box;
+	__le64 offset;
+	__le32 resource_id;
+	__le32 level;
+	__le32 stride;
+	__le32 layer_stride;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_3D */
+#define VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP (1 << 0)
+struct virtio_gpu_resource_create_3d {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 target;
+	__le32 format;
+	__le32 bind;
+	__le32 width;
+	__le32 height;
+	__le32 depth;
+	__le32 array_size;
+	__le32 last_level;
+	__le32 nr_samples;
+	__le32 flags;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_CTX_CREATE */
+#define VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK 0x000000ff
+struct virtio_gpu_ctx_create {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 nlen;
+	__le32 context_init;
+	char debug_name[64];
+};
+
+/* VIRTIO_GPU_CMD_CTX_DESTROY */
+struct virtio_gpu_ctx_destroy {
+	struct virtio_gpu_ctrl_hdr hdr;
+};
+
+/* VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE, VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE */
+struct virtio_gpu_ctx_resource {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_SUBMIT_3D */
+struct virtio_gpu_cmd_submit {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 size;
+	__le32 padding;
+};
+
+#define VIRTIO_GPU_CAPSET_VIRGL 1
+#define VIRTIO_GPU_CAPSET_VIRGL2 2
+#define VIRTIO_GPU_CAPSET_GFXSTREAM_VULKAN 3
+#define VIRTIO_GPU_CAPSET_VENUS 4
+#define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
+#define VIRTIO_GPU_CAPSET_DRM 6
+
+/* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
+struct virtio_gpu_get_capset_info {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 capset_index;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_CAPSET_INFO */
+struct virtio_gpu_resp_capset_info {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 capset_id;
+	__le32 capset_max_version;
+	__le32 capset_max_size;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_GET_CAPSET */
+struct virtio_gpu_get_capset {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 capset_id;
+	__le32 capset_version;
+};
+
+/* VIRTIO_GPU_RESP_OK_CAPSET */
+struct virtio_gpu_resp_capset {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__u8 capset_data[];
+};
+
+/* VIRTIO_GPU_CMD_GET_EDID */
+struct virtio_gpu_cmd_get_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 scanout;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_EDID */
+struct virtio_gpu_resp_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 size;
+	__le32 padding;
+	__u8 edid[1024];
+};
+
+#define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
+
+struct virtio_gpu_config {
+	__le32 events_read;
+	__le32 events_clear;
+	__le32 num_scanouts;
+	__le32 num_capsets;
+};
+
+/* simple formats for fbcon/X use */
+enum virtio_gpu_formats {
+	VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM  = 1,
+	VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM  = 2,
+	VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM  = 3,
+	VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM  = 4,
+
+	VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM  = 67,
+	VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM  = 68,
+
+	VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM  = 121,
+	VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  = 134,
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
+struct virtio_gpu_resource_assign_uuid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_UUID */
+struct virtio_gpu_resp_resource_uuid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__u8 uuid[16];
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB */
+struct virtio_gpu_resource_create_blob {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+#define VIRTIO_GPU_BLOB_MEM_GUEST             0x0001
+#define VIRTIO_GPU_BLOB_MEM_HOST3D            0x0002
+#define VIRTIO_GPU_BLOB_MEM_HOST3D_GUEST      0x0003
+
+#define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
+#define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
+#define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+	/* zero is invalid blob mem */
+	__le32 blob_mem;
+	__le32 blob_flags;
+	__le32 nr_entries;
+	__le64 blob_id;
+	__le64 size;
+	/*
+	 * sizeof(nr_entries * virtio_gpu_mem_entry) bytes follow
+	 */
+};
+
+/* VIRTIO_GPU_CMD_SET_SCANOUT_BLOB */
+struct virtio_gpu_set_scanout_blob {
+	struct virtio_gpu_ctrl_hdr hdr;
+	struct virtio_gpu_rect r;
+	__le32 scanout_id;
+	__le32 resource_id;
+	__le32 width;
+	__le32 height;
+	__le32 format;
+	__le32 padding;
+	__le32 strides[4];
+	__le32 offsets[4];
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB */
+struct virtio_gpu_resource_map_blob {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+	__le64 offset;
+};
+
+/* VIRTIO_GPU_RESP_OK_MAP_INFO */
+#define VIRTIO_GPU_MAP_CACHE_MASK     0x0f
+#define VIRTIO_GPU_MAP_CACHE_NONE     0x00
+#define VIRTIO_GPU_MAP_CACHE_CACHED   0x01
+#define VIRTIO_GPU_MAP_CACHE_UNCACHED 0x02
+#define VIRTIO_GPU_MAP_CACHE_WC       0x03
+struct virtio_gpu_resp_map_info {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__u32 map_info;
+	__u32 padding;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB */
+struct virtio_gpu_resource_unmap_blob {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+#endif
diff --git a/include/virtio.h b/include/virtio.h
index 3edf023463d7..f53158e355b1 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -28,14 +28,16 @@
 
 #define VIRTIO_VENDOR_QEMU	0x554d4551
 
-#define VIRTIO_ID_NET		1 /* virtio net */
-#define VIRTIO_ID_BLOCK		2 /* virtio block */
-#define VIRTIO_ID_RNG		4 /* virtio rng */
-#define VIRTIO_ID_MAX_NUM	5
+#define VIRTIO_ID_NET		1  /* virtio net */
+#define VIRTIO_ID_BLOCK		2  /* virtio block */
+#define VIRTIO_ID_RNG		4  /* virtio rng */
+#define VIRTIO_ID_GPU		16 /* virtio gpu */
+#define VIRTIO_ID_MAX_NUM	17
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
+#define VIRTIO_GPU_DRV_NAME	"virtio-gpu"
 
 /* Status byte for guest to report progress, and synchronize features */
 
-- 
2.53.0

