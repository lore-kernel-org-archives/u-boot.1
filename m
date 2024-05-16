Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB03C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 23:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3CB188482;
	Fri, 17 May 2024 01:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="S/WyQOXa";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="E96VugCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD47F88488; Fri, 17 May 2024 01:03:29 +0200 (CEST)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9E98847C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 01:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 141D611400D8;
 Thu, 16 May 2024 19:03:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 16 May 2024 19:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715900606;
 x=1715987006; bh=rEveXkG6Oy8dk1rO0DQTsCW8UMtuyM8igV/jMT6B7PU=; b=
 S/WyQOXaC/QfooaY56I1LUFKHyXD2BCVMAt9SLqG8OCqkirwponkv5jghkae/yuZ
 KRx90//NXxnXZ+wVnxvd+2Wy57POnJGSc0ylcfxSwau+MNz8vU+41cB4TYGpKX+0
 rd1eGXmI21HwWellahLTfqy/q34RhO7+UWwDbwuOSaQAasNspx4tejSqvh7pfHNN
 aFhBX1a9GPSy050Iruyo9xD5uH8h6so3XK7WJKzow4G+wYr+t6ZsSp598To03+MK
 OzB3AA+xpl6+hGGCpc1Ijyr0STbe6o9nHOoQl0kd91X1OxL1T1pjeu/UEd4b/Vnp
 uxEM3xeZQZb0YgpN+J+6HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715900606; x=
 1715987006; bh=rEveXkG6Oy8dk1rO0DQTsCW8UMtuyM8igV/jMT6B7PU=; b=E
 96VugCbc7uoO1o/mI+5lMR86WdrKPBU45i+3tyxNpgg0GvzRcHAUaYeXcKmTXPKL
 JD0VYJSnJQqMksDjW8GY2epv5E3HDWpHdGbbd+EC9F8AiIFlj3D2krtSolBqM3zj
 coGILftgZPRbHi2evf4qWFs7xeF/0xE3TMXs6kkv9EnIO3bOFRRiAa4Tzomi/Vl4
 RlSGYYMItnoLCbxRX7F6sMlajaMgne/8oJs2Hy8AiaUWmufAQQl+eqRBT5sH4FIH
 YWYkWy6xTmIdjCF0WqKE4mKHBNSiepf4Mmdl6EZ6feWkOPD0qiU4XEW8xC7DBP1F
 epzRuKnMVkZZ1oXfv2fXg==
X-ME-Sender: <xms:vZBGZtWY-05J7QXHMG_UaFJsiaggJevHYeFgiKzV8x0ON6NyMCzY9g>
 <xme:vZBGZtmMwY4FlES6P30wVVwyzN7B2RMtUteSBXqT5tIdahLCmCICI2hN9M_kB-ypF
 XCYAwTlqk3rgJVyhU0>
X-ME-Received: <xmr:vZBGZpZGYKq2b267l0bt45C1SdpdoXSX5tVm4BhTYPh6JAZ9yId1RYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vZBGZgU-lHUdK-e33FHzFYvPStfDK0Lcj-2WsNMceve2gN-7a6P-DA>
 <xmx:vZBGZnmqtv50olVfuU0Jr6iEMbLuQiStxo9-Zc9yEMdS2poT5lKhFQ>
 <xmx:vZBGZtfnYSdJLdJr905lPufTz4KOWO92xF8z_3LFDkzWlQAioDzmog>
 <xmx:vZBGZhFyzFmja3uDM8ve3mNMXLbThvQ62vVMnzmt9Wg0gtZsWqsqww>
 <xmx:vpBGZlbdBNFpVjrRCZhsSKRdkr8Rotwjo4TIMyyItlux1EVRwtGlpZE6>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 19:03:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 00:03:24 +0100
Subject: [PATCH 1/2] virtio: New virtio_gpu driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-virtio_gpu-v1-1-6353b87472c7@flygoat.com>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
In-Reply-To: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24072;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=mSYSOo4mtscKlucpFLP6wxiopxSwV8COm93huRFAwGw=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS3CXsnfvzgzzd36x+BV0/9FedF7fzJtHyu9u2auQ+4q
 5+Y+6lxdJSyMIhxMMiKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEwmIZ/peIb9q6hM1iY9ya
 Y6mL53hWr5KonL/6Sbu22bQ9P+yTzaUY/krpuSUdtxGoYXtpdVJxK9/ZFd11rPpxG8VXu60JS3O
 fwAgA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

This driver is implemened based on latest VirtIO spec.
It follows operation prodcure as defined in the spec.

It implemented multihead (mirroring) support as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/virtio/Kconfig         |  29 +++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_gpu.c    | 298 ++++++++++++++++++++++++++++
 drivers/virtio/virtio_gpu.h    | 428 +++++++++++++++++++++++++++++++++++++++++
 include/virtio.h               |   4 +-
 6 files changed, 760 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 1de68867d52e..b75572c4ad13 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -76,4 +76,33 @@ config VIRTIO_RNG
 	help
 	  This is the virtual random number generator driver. It can be used
 	  with QEMU based targets.
+
+ config VIRTIO_GPU
+	bool "virtio GPU driver"
+	depends on VIRTIO && VIDEO
+	default y
+	help
+	  This is the virtual GPU display for virtio. It can be used with QEMU
+	  based targets.
+
+if VIRTIO_GPU
+config VIRTIO_GPU_SIZE_X
+	int "Width of display (X resolution)"
+	default 1280
+	help
+	  Sets the width of the display.
+
+	  These two options control the size of the display set up by QEMU.
+	  Typical sizes are 1024 x 768 or 1280 x 1024.
+
+config VIRTIO_GPU_SIZE_Y
+	int "High of display (Y resolution)"
+	default 1024
+	help
+	  Sets the height of the display.
+
+	  These two options control the size of the display set up by QEMU.
+	  Typical sizes are 1024 x 768 or 1280 x 1024.
+
+endif
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
index 1dbc1a56aa21..1f3cdbf689c4 100644
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
index 000000000000..d798562ecba2
--- /dev/null
+++ b/drivers/virtio/virtio_gpu.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#define pr_fmt(fmt) "virtio_gpu: " fmt
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <video.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include "virtio_gpu.h"
+#include <asm/io.h>
+
+struct virtio_gpu_priv {
+	struct virtqueue *vq;
+	u32 scanout_res_id;
+	u64 fence_id;
+	bool in_sync;
+};
+
+static int virtio_gpu_do_req(struct udevice *dev,
+			     enum virtio_gpu_ctrl_type type,
+			     void *in, size_t in_size,
+			     void *out, size_t out_size, bool flush)
+{
+	int ret;
+	uint len;
+	struct virtio_gpu_priv *priv = dev_get_priv(dev);
+	struct virtio_sg in_sg;
+	struct virtio_sg out_sg;
+	struct virtio_sg *sgs[] = { &in_sg, &out_sg };
+	struct virtio_gpu_ctrl_hdr *ctrl_hdr_in = in;
+	struct virtio_gpu_ctrl_hdr *ctrl_hdr_out = out;
+
+	ctrl_hdr_in->type = cpu_to_virtio32(dev, (u32)type);
+	if (flush) {
+		ctrl_hdr_in->flags = cpu_to_virtio32(dev, VIRTIO_GPU_FLAG_FENCE);
+		ctrl_hdr_in->fence_id = cpu_to_virtio64(dev, priv->fence_id++);
+	} else {
+		ctrl_hdr_in->flags = 0;
+		ctrl_hdr_in->fence_id = 0;
+	}
+	ctrl_hdr_in->ctx_id = 0;
+	ctrl_hdr_in->ring_idx = 0;
+	in_sg.addr = in;
+	in_sg.length = in_size;
+	out_sg.addr = out;
+	out_sg.length = out_size;
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret) {
+		log_debug("virtqueue_add failed %d\n", ret);
+		return ret;
+	}
+	virtqueue_kick(priv->vq);
+
+	debug("wait...");
+	while (!virtqueue_get_buf(priv->vq, &len))
+		;
+	debug("done\n");
+
+	if (out_size != len) {
+		log_debug("Invalid response size %d, expected %d\n",
+			  len, (uint)out_size);
+	}
+
+	return virtio32_to_cpu(dev, ctrl_hdr_out->type);
+}
+
+static int virtio_gpu_probe(struct udevice *dev)
+{
+	struct virtio_gpu_priv *priv = dev_get_priv(dev);
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct virtio_gpu_ctrl_hdr ctrl_hdr_in;
+	struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
+	struct virtio_gpu_resp_display_info *disp_info_out;
+	struct virtio_gpu_display_one *disp;
+	struct virtio_gpu_resource_create_2d *res_create_2d_in;
+	void *res_buf_in;
+	struct virtio_gpu_resource_attach_backing *res_attach_backing_in;
+	struct virtio_gpu_mem_entry *mem_entry;
+	struct virtio_gpu_set_scanout *set_scanout_in;
+	unsigned int scanout_mask = 0;
+	int ret, i;
+
+	if (!plat->base) {
+		log_warning("No framebuffer allocated\n");
+		return -EINVAL;
+	}
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret < 0) {
+		log_warning("virtio_find_vqs failed\n");
+		return ret;
+	}
+
+	disp_info_out = malloc(sizeof(struct virtio_gpu_resp_display_info));
+	ret = virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_GET_DISPLAY_INFO, &ctrl_hdr_in,
+				sizeof(struct virtio_gpu_ctrl_hdr), disp_info_out,
+				sizeof(struct virtio_gpu_resp_display_info), false);
+
+	if (ret != VIRTIO_GPU_RESP_OK_DISPLAY_INFO) {
+		log_warning("CMD_GET_DISPLAY_INFO failed %d\n", ret);
+		ret = -EINVAL;
+		goto out_free_disp;
+	}
+
+	for (i = 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
+		disp = &disp_info_out->pmodes[i];
+		if (!disp->enabled)
+			continue;
+		log_debug("Found available scanout: %d\n", i);
+		scanout_mask |= 1 << i;
+	}
+
+	if (!scanout_mask) {
+		log_warning("No active scanout found\n");
+		ret = -EINVAL;
+		goto out_free_disp;
+	}
+
+	free(disp_info_out);
+	disp_info_out = NULL;
+
+	/* TODO: We can parse EDID for those info */
+	uc_priv->xsize = CONFIG_VAL(VIRTIO_GPU_SIZE_X);
+	uc_priv->ysize = CONFIG_VAL(VIRTIO_GPU_SIZE_Y);
+	uc_priv->bpix = VIDEO_BPP32;
+
+	priv->scanout_res_id = 1;
+	res_create_2d_in = malloc(sizeof(struct virtio_gpu_resource_create_2d));
+	res_create_2d_in->resource_id = cpu_to_virtio32(dev, priv->scanout_res_id);
+	res_create_2d_in->format = cpu_to_virtio32(dev, VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM);
+	res_create_2d_in->width = cpu_to_virtio32(dev, uc_priv->xsize);
+	res_create_2d_in->height = cpu_to_virtio32(dev, uc_priv->ysize);
+
+	ret = virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_CREATE_2D, res_create_2d_in,
+				sizeof(struct virtio_gpu_resource_create_2d), &ctrl_hdr_out,
+				sizeof(struct virtio_gpu_ctrl_hdr), false);
+	if (ret != VIRTIO_GPU_RESP_OK_NODATA) {
+		log_warning("CMD_RESOURCE_CREATE_2D failed %d\n", ret);
+		ret = -EINVAL;
+		goto out_free_res_create_2d;
+	}
+
+	free(res_create_2d_in);
+	res_create_2d_in = NULL;
+
+	res_buf_in = malloc(sizeof(struct virtio_gpu_resource_attach_backing) +
+			    sizeof(struct virtio_gpu_mem_entry));
+	res_attach_backing_in = res_buf_in;
+	mem_entry = res_buf_in + sizeof(struct virtio_gpu_resource_attach_backing);
+	res_attach_backing_in->resource_id = cpu_to_virtio32(dev, priv->scanout_res_id);
+	res_attach_backing_in->nr_entries = cpu_to_virtio32(dev, 1);
+	mem_entry->addr = cpu_to_virtio64(dev, virt_to_phys((void *)plat->base));
+	mem_entry->length = cpu_to_virtio32(dev, plat->size);
+	mem_entry->padding = 0;
+
+	ret = virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING, res_buf_in,
+				sizeof(struct virtio_gpu_resource_attach_backing) +
+				sizeof(struct virtio_gpu_mem_entry), &ctrl_hdr_out,
+				sizeof(struct virtio_gpu_ctrl_hdr), false);
+
+	if (ret != VIRTIO_GPU_RESP_OK_NODATA) {
+		log_warning("CMD_RESOURCE_ATTACH_BACKING failed %d\n", ret);
+		ret = -EINVAL;
+		goto out_free_res_buf;
+	}
+	free(res_buf_in);
+	res_buf_in = NULL;
+
+	set_scanout_in = malloc(sizeof(struct virtio_gpu_set_scanout));
+	while (scanout_mask) {
+		u32 active_scanout = ffs(scanout_mask) - 1;
+
+		set_scanout_in->r.x = 0;
+		set_scanout_in->r.y = 0;
+		set_scanout_in->r.width = cpu_to_virtio32(dev, uc_priv->xsize);
+		set_scanout_in->r.height = cpu_to_virtio32(dev, uc_priv->ysize);
+		set_scanout_in->scanout_id = cpu_to_virtio32(dev, active_scanout);
+		set_scanout_in->resource_id = cpu_to_virtio32(dev, priv->scanout_res_id);
+
+		ret = virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_SET_SCANOUT, set_scanout_in,
+					sizeof(struct virtio_gpu_set_scanout), &ctrl_hdr_out,
+					sizeof(struct virtio_gpu_ctrl_hdr), false);
+
+		if (ret != VIRTIO_GPU_RESP_OK_NODATA) {
+			log_warning("CMD_SET_SCANOUT failed %d for scanout %d\n",
+				    ret, active_scanout);
+			ret = -EINVAL;
+			goto out_free_set_scanout;
+		}
+		scanout_mask &= ~(1 << active_scanout);
+	}
+	free(set_scanout_in);
+	set_scanout_in = NULL;
+
+	return 0;
+out_free_set_scanout:
+	if (set_scanout_in)
+		free(set_scanout_in);
+out_free_res_buf:
+	if (res_buf_in)
+		free(res_buf_in);
+out_free_res_create_2d:
+	if (res_create_2d_in)
+		free(res_create_2d_in);
+out_free_disp:
+	if (disp_info_out)
+		free(disp_info_out);
+	return ret;
+}
+
+static int virtio_gpu_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *virtio_uc_priv = dev_get_uclass_priv(dev->parent);
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	/* Indicate what driver features we support */
+	virtio_driver_features_init(virtio_uc_priv, NULL, 0, NULL, 0);
+	plat->base = 0; /* Framebuffer will be allocated by the video-uclass */
+	plat->size = CONFIG_VAL(VIRTIO_GPU_SIZE_X) *
+		     CONFIG_VAL(VIRTIO_GPU_SIZE_X) * VNBYTES(VIDEO_BPP32);
+
+	return 0;
+}
+
+static int virtio_gpu_video_sync(struct udevice *dev)
+{
+	struct virtio_gpu_priv *priv = dev_get_priv(dev);
+	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct virtio_gpu_transfer_to_host_2d to_host_2d_in;
+	struct virtio_gpu_resource_flush res_flush_in;
+	struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
+	int ret;
+
+	/* We need to protect sync function reentrance to prevent exausting VQ */
+	if (priv->in_sync)
+		return 0;
+
+	priv->in_sync = true;
+
+	to_host_2d_in.r.x = 0;
+	to_host_2d_in.r.y = 0;
+	to_host_2d_in.r.width = cpu_to_virtio32(dev, uc_priv->xsize);
+	to_host_2d_in.r.height = cpu_to_virtio32(dev, uc_priv->ysize);
+	to_host_2d_in.offset = 0;
+	to_host_2d_in.resource_id = cpu_to_virtio32(dev, priv->scanout_res_id);
+	to_host_2d_in.padding = 0;
+
+	ret = virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D, &to_host_2d_in,
+				sizeof(struct virtio_gpu_transfer_to_host_2d), &ctrl_hdr_out,
+				sizeof(struct virtio_gpu_ctrl_hdr), true);
+	if (ret != VIRTIO_GPU_RESP_OK_NODATA) {
+		log_debug("CMD_TRANSFER_TO_HOST_2D failed %d\n", ret);
+		priv->in_sync = false;
+		return -EINVAL;
+	}
+
+	res_flush_in.r.x = 0;
+	res_flush_in.r.y = 0;
+	res_flush_in.r.width = cpu_to_virtio32(dev, uc_priv->xsize);
+	res_flush_in.r.height = cpu_to_virtio32(dev, uc_priv->ysize);
+	res_flush_in.resource_id = cpu_to_virtio32(dev, priv->scanout_res_id);
+	res_flush_in.padding = 0;
+
+	ret = virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_FLUSH, &res_flush_in,
+				sizeof(struct virtio_gpu_resource_flush), &ctrl_hdr_out,
+				sizeof(struct virtio_gpu_ctrl_hdr), true);
+	if (ret != VIRTIO_GPU_RESP_OK_NODATA) {
+		log_debug("CMD_RESOURCE_FLUSH failed %d\n", ret);
+		priv->in_sync = false;
+		return -EINVAL;
+	}
+
+	priv->in_sync = false;
+	return 0;
+}
+
+static struct video_ops virtio_gpu_ops = {
+	.video_sync = virtio_gpu_video_sync,
+};
+
+U_BOOT_DRIVER(virtio_gpu) = {
+	.name	= VIRTIO_GPU_DRV_NAME,
+	.id	= UCLASS_VIDEO,
+	.bind	= virtio_gpu_bind,
+	.probe	= virtio_gpu_probe,
+	.remove = virtio_reset,
+	.ops	= &virtio_gpu_ops,
+	.priv_auto	= sizeof(struct virtio_gpu_priv),
+	.flags	= DM_FLAG_ACTIVE_DMA,
+};
diff --git a/drivers/virtio/virtio_gpu.h b/drivers/virtio/virtio_gpu.h
new file mode 100644
index 000000000000..d2e5c0e02f13
--- /dev/null
+++ b/drivers/virtio/virtio_gpu.h
@@ -0,0 +1,428 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * From Linux kernel include/uapi/linux/virtio_gpu.h
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
+/* 3 is reserved for gfxstream */
+#define VIRTIO_GPU_CAPSET_VENUS 4
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
index 1ab0ec5f39f5..93a6f5e92a48 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -27,11 +27,13 @@
 #define VIRTIO_ID_NET		1 /* virtio net */
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
-#define VIRTIO_ID_MAX_NUM	5
+#define VIRTIO_ID_GPU		16 /* virtio GPU */
+#define VIRTIO_ID_MAX_NUM	17
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
+#define VIRTIO_GPU_DRV_NAME	"virtio-gpu"
 
 /* Status byte for guest to report progress, and synchronize features */
 

-- 
2.34.1

