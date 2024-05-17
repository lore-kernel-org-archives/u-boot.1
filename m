Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76712C25B74
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 01:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13CF88479;
	Fri, 17 May 2024 03:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HMp7YG9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295898847E; Fri, 17 May 2024 03:57:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB6C88476
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 03:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715911019; x=1716515819; i=xypron.glpk@gmx.de;
 bh=6ZyXZwGPR0niSevYb3Sp0l615vEDMUDEG9pWrEl09Ws=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HMp7YG9cHeb76gVTJ2NoxrJflUeAOl+gXxBoa4EcMoh63esVd5u2CpjhtFIs8WP/
 LSZPZeELuD5F9ohHOqLgmWz/8ahStwBZCqmr9AwfVADCEz7SGURTFP1KByGVn3nWL
 3uzdeS1V8rO57kNOSha0ONtWeb/llZHQy3s+ZppKaQS0bFdwaQdr7QdwmTnX6hb/y
 1sWaSDAquWFhKm5RhbwWCsW4F1ZCKma5lXHEi7eBQx2Ix6cU7mKgHc+1SrnAW/sTM
 80vL+LMI38IMmy9Pv0lnDdKwI19XxHUoQrnWp0xIHwfsztnaEJPla4eHglr0R9w1q
 JAlIoyeqmLWY5yhrNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([149.11.192.251]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1sQ8fc2DJH-00raXH; Fri, 17
 May 2024 03:56:59 +0200
Date: Fri, 17 May 2024 03:56:58 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] virtio: New virtio_gpu driver
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517-virtio_gpu-v1-1-6353b87472c7@flygoat.com>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
 <20240517-virtio_gpu-v1-1-6353b87472c7@flygoat.com>
Message-ID: <0664F4C3-6C95-43DF-A283-760A8BCA1811@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iVM/7YYCaE39JZXKsZWq/9N/aBWK8K4GG+b2TCdblq+kwu5/rRN
 xEldWj5qScjlLhkt5hKxWhkL8FgwBSodW8LeqQy0ourRmErcXJusQINBmk7pBWtx2UYmlne
 UlJPDCA3XsTCZOKK7MxGVkGz4f6ZrdmsgzLCRmWJc6XFo5Lt4OzO85X3WZT6GSG2zMQ1mmE
 gWDUqGx5yOnA9B4ehUWOA==
UI-OutboundReport: notjunk:1;M01:P0:GSLQEoy05OI=;W4q6WaAeb4Kg8T1XsyZFiMz78jZ
 WzNmkpamqaWEVknLzSnLP4e0DTudYK2jV/euCiz/JtdJTHLKI7fqVZvh3pd1qvFUO0k59XBSn
 +NxuUZvUrnW2mdPyCE1FNSHqoKIF6zFACjLfW3y2MT81qimiyN54zpGwUJLxYQ2RIlsmBKu+L
 aKelqSlF70zeH13GhYSSG5/jfKvrPI+sYX5xTqjymOoO7mJdNhQjHRBoMs0jkVJ/LbYPcASJH
 b/UQ7bU1hs5lLR5BzfFAHcglsAZLLglGmko8GJfQGUw5DXILQ7Jf130lb5aPyHPuqlMIbsGEm
 eB51Oxl6ylCDlje7Bd6DuxDadajA9br0Dbpo/UFtwamU2hU+T//YqLwIndkg8UYnBFU8w9wr3
 Y2DrN4/J1m5XVm+rNz/aI3nNe5x4LeSjkhr1jdowkhqc9g8RVcnJ0F7dacn3gQ1VlZLwxiSZj
 0SJWeo10nAvGO59cvJfLhijmD85JmPD/QD2agButrwl2t5e+sYE9Ok6M1ZhN0LvKpdodZBmFm
 fC/yyRjAMKm+0Wru55Y8mpgHpKouvKcYlsLYTZsEH0ewRZOCSNakof012tZCeePllb/qdFUKJ
 H6PUcy5TJx07jA1vcWVJ/p42/3bRIiXTaSDGpvakX0XMlg16ovt5YtzlFyT4S5S2Kpe8G/95Z
 VandaDmiHNt49B2cPtON9eep9vM8RlPIgxIz2Y/zIvPDfg141WmaKx5yCK3wKqIj9euL6Fkud
 N4m/6CkhUS3TdDp/Z7inCeUwa0sEqoLvD62VQ4PzboyTGphcOp6G/+nligq1wxsmkJ9x8kuj+
 9Ai528t3GgGZbVKqEMFZD0gbCBscrxPUIhhf8T0Dgztac=
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



Am 17=2E Mai 2024 01:03:24 MESZ schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>This driver is implemened based on latest VirtIO spec=2E
>It follows operation prodcure as defined in the spec=2E
>
>It implemented multihead (mirroring) support as well=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> drivers/virtio/Kconfig         |  29 +++
> drivers/virtio/Makefile        |   1 +
> drivers/virtio/virtio-uclass=2Ec |   1 +
> drivers/virtio/virtio_gpu=2Ec    | 298 ++++++++++++++++++++++++++++
> drivers/virtio/virtio_gpu=2Eh    | 428 +++++++++++++++++++++++++++++++++=
++++++++
> include/virtio=2Eh               |   4 +-
> 6 files changed, 760 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>index 1de68867d52e=2E=2Eb75572c4ad13 100644
>--- a/drivers/virtio/Kconfig
>+++ b/drivers/virtio/Kconfig
>@@ -76,4 +76,33 @@ config VIRTIO_RNG
> 	help
> 	  This is the virtual random number generator driver=2E It can be used
> 	  with QEMU based targets=2E
>+
>+ config VIRTIO_GPU
>+	bool "virtio GPU driver"
>+	depends on VIRTIO && VIDEO
>+	default y
>+	help
>+	  This is the virtual GPU display for virtio=2E It can be used with QEM=
U
>+	  based targets=2E
>+
>+if VIRTIO_GPU
>+config VIRTIO_GPU_SIZE_X
>+	int "Width of display (X resolution)"
>+	default 1280

1920x1080 would look like a reasonable default for me=2E


>+	help
>+	  Sets the width of the display=2E
>+
>+	  These two options control the size of the display set up by QEMU=2E
>+	  Typical sizes are 1024 x 768 or 1280 x 1024=2E
>+
>+config VIRTIO_GPU_SIZE_Y
>+	int "High of display (Y resolution)"
>+	default 1024
>+	help
>+	  Sets the height of the display=2E
>+
>+	  These two options control the size of the display set up by QEMU=2E
>+	  Typical sizes are 1024 x 768 or 1280 x 1024=2E

Haven't had such small monitors for a while=2E Why should this be typical?

Doesn't QEMU allow to read the size of the output window at runtime?

Best regards

Heinrich

>+
>+endif
> endmenu
>diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>index 4c63a6c69043=2E=2Ec830fb6e6049 100644
>--- a/drivers/virtio/Makefile
>+++ b/drivers/virtio/Makefile
>@@ -11,3 +11,4 @@ obj-$(CONFIG_VIRTIO_SANDBOX) +=3D virtio_sandbox=2Eo
> obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net=2Eo
> obj-$(CONFIG_VIRTIO_BLK) +=3D virtio_blk=2Eo
> obj-$(CONFIG_VIRTIO_RNG) +=3D virtio_rng=2Eo
>+obj-$(CONFIG_VIRTIO_GPU) +=3D virtio_gpu=2Eo
>diff --git a/drivers/virtio/virtio-uclass=2Ec b/drivers/virtio/virtio-ucl=
ass=2Ec
>index 1dbc1a56aa21=2E=2E1f3cdbf689c4 100644
>--- a/drivers/virtio/virtio-uclass=2Ec
>+++ b/drivers/virtio/virtio-uclass=2Ec
>@@ -30,6 +30,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_=
NUM] =3D {
> 	[VIRTIO_ID_NET]		=3D VIRTIO_NET_DRV_NAME,
> 	[VIRTIO_ID_BLOCK]	=3D VIRTIO_BLK_DRV_NAME,
> 	[VIRTIO_ID_RNG]		=3D VIRTIO_RNG_DRV_NAME,
>+	[VIRTIO_ID_GPU]		=3D VIRTIO_GPU_DRV_NAME,
> };
>=20
> int virtio_get_config(struct udevice *vdev, unsigned int offset,
>diff --git a/drivers/virtio/virtio_gpu=2Ec b/drivers/virtio/virtio_gpu=2E=
c
>new file mode 100644
>index 000000000000=2E=2Ed798562ecba2
>--- /dev/null
>+++ b/drivers/virtio/virtio_gpu=2Ec
>@@ -0,0 +1,298 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ * Copyright (C) 2024, Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>+ */
>+
>+#define pr_fmt(fmt) "virtio_gpu: " fmt
>+
>+#include <dm=2Eh>
>+#include <log=2Eh>
>+#include <malloc=2Eh>
>+#include <video=2Eh>
>+#include <virtio_types=2Eh>
>+#include <virtio=2Eh>
>+#include <virtio_ring=2Eh>
>+#include "virtio_gpu=2Eh"
>+#include <asm/io=2Eh>
>+
>+struct virtio_gpu_priv {
>+	struct virtqueue *vq;
>+	u32 scanout_res_id;
>+	u64 fence_id;
>+	bool in_sync;
>+};
>+
>+static int virtio_gpu_do_req(struct udevice *dev,
>+			     enum virtio_gpu_ctrl_type type,
>+			     void *in, size_t in_size,
>+			     void *out, size_t out_size, bool flush)
>+{
>+	int ret;
>+	uint len;
>+	struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
>+	struct virtio_sg in_sg;
>+	struct virtio_sg out_sg;
>+	struct virtio_sg *sgs[] =3D { &in_sg, &out_sg };
>+	struct virtio_gpu_ctrl_hdr *ctrl_hdr_in =3D in;
>+	struct virtio_gpu_ctrl_hdr *ctrl_hdr_out =3D out;
>+
>+	ctrl_hdr_in->type =3D cpu_to_virtio32(dev, (u32)type);
>+	if (flush) {
>+		ctrl_hdr_in->flags =3D cpu_to_virtio32(dev, VIRTIO_GPU_FLAG_FENCE);
>+		ctrl_hdr_in->fence_id =3D cpu_to_virtio64(dev, priv->fence_id++);
>+	} else {
>+		ctrl_hdr_in->flags =3D 0;
>+		ctrl_hdr_in->fence_id =3D 0;
>+	}
>+	ctrl_hdr_in->ctx_id =3D 0;
>+	ctrl_hdr_in->ring_idx =3D 0;
>+	in_sg=2Eaddr =3D in;
>+	in_sg=2Elength =3D in_size;
>+	out_sg=2Eaddr =3D out;
>+	out_sg=2Elength =3D out_size;
>+
>+	ret =3D virtqueue_add(priv->vq, sgs, 1, 1);
>+	if (ret) {
>+		log_debug("virtqueue_add failed %d\n", ret);
>+		return ret;
>+	}
>+	virtqueue_kick(priv->vq);
>+
>+	debug("wait=2E=2E=2E");
>+	while (!virtqueue_get_buf(priv->vq, &len))
>+		;
>+	debug("done\n");
>+
>+	if (out_size !=3D len) {
>+		log_debug("Invalid response size %d, expected %d\n",
>+			  len, (uint)out_size);
>+	}
>+
>+	return virtio32_to_cpu(dev, ctrl_hdr_out->type);
>+}
>+
>+static int virtio_gpu_probe(struct udevice *dev)
>+{
>+	struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
>+	struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
>+	struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
>+	struct virtio_gpu_ctrl_hdr ctrl_hdr_in;
>+	struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
>+	struct virtio_gpu_resp_display_info *disp_info_out;
>+	struct virtio_gpu_display_one *disp;
>+	struct virtio_gpu_resource_create_2d *res_create_2d_in;
>+	void *res_buf_in;
>+	struct virtio_gpu_resource_attach_backing *res_attach_backing_in;
>+	struct virtio_gpu_mem_entry *mem_entry;
>+	struct virtio_gpu_set_scanout *set_scanout_in;
>+	unsigned int scanout_mask =3D 0;
>+	int ret, i;
>+
>+	if (!plat->base) {
>+		log_warning("No framebuffer allocated\n");
>+		return -EINVAL;
>+	}
>+
>+	ret =3D virtio_find_vqs(dev, 1, &priv->vq);
>+	if (ret < 0) {
>+		log_warning("virtio_find_vqs failed\n");
>+		return ret;
>+	}
>+
>+	disp_info_out =3D malloc(sizeof(struct virtio_gpu_resp_display_info));
>+	ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_GET_DISPLAY_INFO, &ctrl_h=
dr_in,
>+				sizeof(struct virtio_gpu_ctrl_hdr), disp_info_out,
>+				sizeof(struct virtio_gpu_resp_display_info), false);
>+
>+	if (ret !=3D VIRTIO_GPU_RESP_OK_DISPLAY_INFO) {
>+		log_warning("CMD_GET_DISPLAY_INFO failed %d\n", ret);
>+		ret =3D -EINVAL;
>+		goto out_free_disp;
>+	}
>+
>+	for (i =3D 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
>+		disp =3D &disp_info_out->pmodes[i];
>+		if (!disp->enabled)
>+			continue;
>+		log_debug("Found available scanout: %d\n", i);
>+		scanout_mask |=3D 1 << i;
>+	}
>+
>+	if (!scanout_mask) {
>+		log_warning("No active scanout found\n");
>+		ret =3D -EINVAL;
>+		goto out_free_disp;
>+	}
>+
>+	free(disp_info_out);
>+	disp_info_out =3D NULL;
>+
>+	/* TODO: We can parse EDID for those info */
>+	uc_priv->xsize =3D CONFIG_VAL(VIRTIO_GPU_SIZE_X);
>+	uc_priv->ysize =3D CONFIG_VAL(VIRTIO_GPU_SIZE_Y);
>+	uc_priv->bpix =3D VIDEO_BPP32;
>+
>+	priv->scanout_res_id =3D 1;
>+	res_create_2d_in =3D malloc(sizeof(struct virtio_gpu_resource_create_2d=
));
>+	res_create_2d_in->resource_id =3D cpu_to_virtio32(dev, priv->scanout_re=
s_id);
>+	res_create_2d_in->format =3D cpu_to_virtio32(dev, VIRTIO_GPU_FORMAT_B8G=
8R8X8_UNORM);
>+	res_create_2d_in->width =3D cpu_to_virtio32(dev, uc_priv->xsize);
>+	res_create_2d_in->height =3D cpu_to_virtio32(dev, uc_priv->ysize);
>+
>+	ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_CREATE_2D, res_c=
reate_2d_in,
>+				sizeof(struct virtio_gpu_resource_create_2d), &ctrl_hdr_out,
>+				sizeof(struct virtio_gpu_ctrl_hdr), false);
>+	if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>+		log_warning("CMD_RESOURCE_CREATE_2D failed %d\n", ret);
>+		ret =3D -EINVAL;
>+		goto out_free_res_create_2d;
>+	}
>+
>+	free(res_create_2d_in);
>+	res_create_2d_in =3D NULL;
>+
>+	res_buf_in =3D malloc(sizeof(struct virtio_gpu_resource_attach_backing)=
 +
>+			    sizeof(struct virtio_gpu_mem_entry));
>+	res_attach_backing_in =3D res_buf_in;
>+	mem_entry =3D res_buf_in + sizeof(struct virtio_gpu_resource_attach_bac=
king);
>+	res_attach_backing_in->resource_id =3D cpu_to_virtio32(dev, priv->scano=
ut_res_id);
>+	res_attach_backing_in->nr_entries =3D cpu_to_virtio32(dev, 1);
>+	mem_entry->addr =3D cpu_to_virtio64(dev, virt_to_phys((void *)plat->bas=
e));
>+	mem_entry->length =3D cpu_to_virtio32(dev, plat->size);
>+	mem_entry->padding =3D 0;
>+
>+	ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING, =
res_buf_in,
>+				sizeof(struct virtio_gpu_resource_attach_backing) +
>+				sizeof(struct virtio_gpu_mem_entry), &ctrl_hdr_out,
>+				sizeof(struct virtio_gpu_ctrl_hdr), false);
>+
>+	if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>+		log_warning("CMD_RESOURCE_ATTACH_BACKING failed %d\n", ret);
>+		ret =3D -EINVAL;
>+		goto out_free_res_buf;
>+	}
>+	free(res_buf_in);
>+	res_buf_in =3D NULL;
>+
>+	set_scanout_in =3D malloc(sizeof(struct virtio_gpu_set_scanout));
>+	while (scanout_mask) {
>+		u32 active_scanout =3D ffs(scanout_mask) - 1;
>+
>+		set_scanout_in->r=2Ex =3D 0;
>+		set_scanout_in->r=2Ey =3D 0;
>+		set_scanout_in->r=2Ewidth =3D cpu_to_virtio32(dev, uc_priv->xsize);
>+		set_scanout_in->r=2Eheight =3D cpu_to_virtio32(dev, uc_priv->ysize);
>+		set_scanout_in->scanout_id =3D cpu_to_virtio32(dev, active_scanout);
>+		set_scanout_in->resource_id =3D cpu_to_virtio32(dev, priv->scanout_res=
_id);
>+
>+		ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_SET_SCANOUT, set_scanout=
_in,
>+					sizeof(struct virtio_gpu_set_scanout), &ctrl_hdr_out,
>+					sizeof(struct virtio_gpu_ctrl_hdr), false);
>+
>+		if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>+			log_warning("CMD_SET_SCANOUT failed %d for scanout %d\n",
>+				    ret, active_scanout);
>+			ret =3D -EINVAL;
>+			goto out_free_set_scanout;
>+		}
>+		scanout_mask &=3D ~(1 << active_scanout);
>+	}
>+	free(set_scanout_in);
>+	set_scanout_in =3D NULL;
>+
>+	return 0;
>+out_free_set_scanout:
>+	if (set_scanout_in)
>+		free(set_scanout_in);
>+out_free_res_buf:
>+	if (res_buf_in)
>+		free(res_buf_in);
>+out_free_res_create_2d:
>+	if (res_create_2d_in)
>+		free(res_create_2d_in);
>+out_free_disp:
>+	if (disp_info_out)
>+		free(disp_info_out);
>+	return ret;
>+}
>+
>+static int virtio_gpu_bind(struct udevice *dev)
>+{
>+	struct virtio_dev_priv *virtio_uc_priv =3D dev_get_uclass_priv(dev->par=
ent);
>+	struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
>+
>+	/* Indicate what driver features we support */
>+	virtio_driver_features_init(virtio_uc_priv, NULL, 0, NULL, 0);
>+	plat->base =3D 0; /* Framebuffer will be allocated by the video-uclass =
*/
>+	plat->size =3D CONFIG_VAL(VIRTIO_GPU_SIZE_X) *
>+		     CONFIG_VAL(VIRTIO_GPU_SIZE_X) * VNBYTES(VIDEO_BPP32);
>+
>+	return 0;
>+}
>+
>+static int virtio_gpu_video_sync(struct udevice *dev)
>+{
>+	struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
>+	struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
>+	struct virtio_gpu_transfer_to_host_2d to_host_2d_in;
>+	struct virtio_gpu_resource_flush res_flush_in;
>+	struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
>+	int ret;
>+
>+	/* We need to protect sync function reentrance to prevent exausting VQ =
*/
>+	if (priv->in_sync)
>+		return 0;
>+
>+	priv->in_sync =3D true;
>+
>+	to_host_2d_in=2Er=2Ex =3D 0;
>+	to_host_2d_in=2Er=2Ey =3D 0;
>+	to_host_2d_in=2Er=2Ewidth =3D cpu_to_virtio32(dev, uc_priv->xsize);
>+	to_host_2d_in=2Er=2Eheight =3D cpu_to_virtio32(dev, uc_priv->ysize);
>+	to_host_2d_in=2Eoffset =3D 0;
>+	to_host_2d_in=2Eresource_id =3D cpu_to_virtio32(dev, priv->scanout_res_=
id);
>+	to_host_2d_in=2Epadding =3D 0;
>+
>+	ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D, &to_=
host_2d_in,
>+				sizeof(struct virtio_gpu_transfer_to_host_2d), &ctrl_hdr_out,
>+				sizeof(struct virtio_gpu_ctrl_hdr), true);
>+	if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>+		log_debug("CMD_TRANSFER_TO_HOST_2D failed %d\n", ret);
>+		priv->in_sync =3D false;
>+		return -EINVAL;
>+	}
>+
>+	res_flush_in=2Er=2Ex =3D 0;
>+	res_flush_in=2Er=2Ey =3D 0;
>+	res_flush_in=2Er=2Ewidth =3D cpu_to_virtio32(dev, uc_priv->xsize);
>+	res_flush_in=2Er=2Eheight =3D cpu_to_virtio32(dev, uc_priv->ysize);
>+	res_flush_in=2Eresource_id =3D cpu_to_virtio32(dev, priv->scanout_res_i=
d);
>+	res_flush_in=2Epadding =3D 0;
>+
>+	ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_FLUSH, &res_flus=
h_in,
>+				sizeof(struct virtio_gpu_resource_flush), &ctrl_hdr_out,
>+				sizeof(struct virtio_gpu_ctrl_hdr), true);
>+	if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>+		log_debug("CMD_RESOURCE_FLUSH failed %d\n", ret);
>+		priv->in_sync =3D false;
>+		return -EINVAL;
>+	}
>+
>+	priv->in_sync =3D false;
>+	return 0;
>+}
>+
>+static struct video_ops virtio_gpu_ops =3D {
>+	=2Evideo_sync =3D virtio_gpu_video_sync,
>+};
>+
>+U_BOOT_DRIVER(virtio_gpu) =3D {
>+	=2Ename	=3D VIRTIO_GPU_DRV_NAME,
>+	=2Eid	=3D UCLASS_VIDEO,
>+	=2Ebind	=3D virtio_gpu_bind,
>+	=2Eprobe	=3D virtio_gpu_probe,
>+	=2Eremove =3D virtio_reset,
>+	=2Eops	=3D &virtio_gpu_ops,
>+	=2Epriv_auto	=3D sizeof(struct virtio_gpu_priv),
>+	=2Eflags	=3D DM_FLAG_ACTIVE_DMA,
>+};
>diff --git a/drivers/virtio/virtio_gpu=2Eh b/drivers/virtio/virtio_gpu=2E=
h
>new file mode 100644
>index 000000000000=2E=2Ed2e5c0e02f13
>--- /dev/null
>+++ b/drivers/virtio/virtio_gpu=2Eh
>@@ -0,0 +1,428 @@
>+/* SPDX-License-Identifier: BSD-3-Clause */
>+/*
>+ * Copyright (C) 2024, Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>+ *
>+ * From Linux kernel include/uapi/linux/virtio_gpu=2Eh
>+ */
>+
>+#ifndef VIRTIO_GPU_HW_H
>+#define VIRTIO_GPU_HW_H
>+
>+#include <linux/types=2Eh>
>+
>+/*
>+ * VIRTIO_GPU_CMD_CTX_*
>+ * VIRTIO_GPU_CMD_*_3D
>+ */
>+#define VIRTIO_GPU_F_VIRGL               0
>+
>+/*
>+ * VIRTIO_GPU_CMD_GET_EDID
>+ */
>+#define VIRTIO_GPU_F_EDID                1
>+/*
>+ * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
>+ */
>+#define VIRTIO_GPU_F_RESOURCE_UUID       2
>+
>+/*
>+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
>+ */
>+#define VIRTIO_GPU_F_RESOURCE_BLOB       3
>+/*
>+ * VIRTIO_GPU_CMD_CREATE_CONTEXT with
>+ * context_init and multiple timelines
>+ */
>+#define VIRTIO_GPU_F_CONTEXT_INIT        4
>+
>+enum virtio_gpu_ctrl_type {
>+	VIRTIO_GPU_UNDEFINED =3D 0,
>+
>+	/* 2d commands */
>+	VIRTIO_GPU_CMD_GET_DISPLAY_INFO =3D 0x0100,
>+	VIRTIO_GPU_CMD_RESOURCE_CREATE_2D,
>+	VIRTIO_GPU_CMD_RESOURCE_UNREF,
>+	VIRTIO_GPU_CMD_SET_SCANOUT,
>+	VIRTIO_GPU_CMD_RESOURCE_FLUSH,
>+	VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D,
>+	VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING,
>+	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
>+	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
>+	VIRTIO_GPU_CMD_GET_CAPSET,
>+	VIRTIO_GPU_CMD_GET_EDID,
>+	VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
>+	VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB,
>+	VIRTIO_GPU_CMD_SET_SCANOUT_BLOB,
>+
>+	/* 3d commands */
>+	VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
>+	VIRTIO_GPU_CMD_CTX_DESTROY,
>+	VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE,
>+	VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE,
>+	VIRTIO_GPU_CMD_RESOURCE_CREATE_3D,
>+	VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
>+	VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D,
>+	VIRTIO_GPU_CMD_SUBMIT_3D,
>+	VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
>+	VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
>+
>+	/* cursor commands */
>+	VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
>+	VIRTIO_GPU_CMD_MOVE_CURSOR,
>+
>+	/* success responses */
>+	VIRTIO_GPU_RESP_OK_NODATA =3D 0x1100,
>+	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
>+	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>+	VIRTIO_GPU_RESP_OK_CAPSET,
>+	VIRTIO_GPU_RESP_OK_EDID,
>+	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
>+	VIRTIO_GPU_RESP_OK_MAP_INFO,
>+
>+	/* error responses */
>+	VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
>+	VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY,
>+	VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID,
>+	VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
>+	VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
>+	VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
>+};
>+
>+enum virtio_gpu_shm_id {
>+	VIRTIO_GPU_SHM_ID_UNDEFINED =3D 0,
>+	/*
>+	 * VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB
>+	 * VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB
>+	 */
>+	VIRTIO_GPU_SHM_ID_HOST_VISIBLE =3D 1
>+};
>+
>+#define VIRTIO_GPU_FLAG_FENCE         (1 << 0)
>+/*
>+ * If the following flag is set, then ring_idx contains the index
>+ * of the command ring that needs to used when creating the fence
>+ */
>+#define VIRTIO_GPU_FLAG_INFO_RING_IDX (1 << 1)
>+
>+struct virtio_gpu_ctrl_hdr {
>+	__le32 type;
>+	__le32 flags;
>+	__le64 fence_id;
>+	__le32 ctx_id;
>+	__u8 ring_idx;
>+	__u8 padding[3];
>+};
>+
>+/* data passed in the cursor vq */
>+
>+struct virtio_gpu_cursor_pos {
>+	__le32 scanout_id;
>+	__le32 x;
>+	__le32 y;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_UPDATE_CURSOR, VIRTIO_GPU_CMD_MOVE_CURSOR */
>+struct virtio_gpu_update_cursor {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_cursor_pos pos;  /* update & move */
>+	__le32 resource_id;           /* update only */
>+	__le32 hot_x;                 /* update only */
>+	__le32 hot_y;                 /* update only */
>+	__le32 padding;
>+};
>+
>+/* data passed in the control vq, 2d related */
>+
>+struct virtio_gpu_rect {
>+	__le32 x;
>+	__le32 y;
>+	__le32 width;
>+	__le32 height;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_UNREF */
>+struct virtio_gpu_resource_unref {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_2D: create a 2d resource with a format=
 */
>+struct virtio_gpu_resource_create_2d {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 format;
>+	__le32 width;
>+	__le32 height;
>+};
>+
>+/* VIRTIO_GPU_CMD_SET_SCANOUT */
>+struct virtio_gpu_set_scanout {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_rect r;
>+	__le32 scanout_id;
>+	__le32 resource_id;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_FLUSH */
>+struct virtio_gpu_resource_flush {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_rect r;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D: simple transfer to_host */
>+struct virtio_gpu_transfer_to_host_2d {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_rect r;
>+	__le64 offset;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+struct virtio_gpu_mem_entry {
>+	__le64 addr;
>+	__le32 length;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING */
>+struct virtio_gpu_resource_attach_backing {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 nr_entries;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING */
>+struct virtio_gpu_resource_detach_backing {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_RESP_OK_DISPLAY_INFO */
>+#define VIRTIO_GPU_MAX_SCANOUTS 16
>+struct virtio_gpu_resp_display_info {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_display_one {
>+		struct virtio_gpu_rect r;
>+		__le32 enabled;
>+		__le32 flags;
>+	} pmodes[VIRTIO_GPU_MAX_SCANOUTS];
>+};
>+
>+/* data passed in the control vq, 3d related */
>+
>+struct virtio_gpu_box {
>+	__le32 x, y, z;
>+	__le32 w, h, d;
>+};
>+
>+/* VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D, VIRTIO_GPU_CMD_TRANSFER_FROM_HOST=
_3D */
>+struct virtio_gpu_transfer_host_3d {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_box box;
>+	__le64 offset;
>+	__le32 resource_id;
>+	__le32 level;
>+	__le32 stride;
>+	__le32 layer_stride;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_3D */
>+#define VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP (1 << 0)
>+struct virtio_gpu_resource_create_3d {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 target;
>+	__le32 format;
>+	__le32 bind;
>+	__le32 width;
>+	__le32 height;
>+	__le32 depth;
>+	__le32 array_size;
>+	__le32 last_level;
>+	__le32 nr_samples;
>+	__le32 flags;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_CTX_CREATE */
>+#define VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK 0x000000ff
>+struct virtio_gpu_ctx_create {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 nlen;
>+	__le32 context_init;
>+	char debug_name[64];
>+};
>+
>+/* VIRTIO_GPU_CMD_CTX_DESTROY */
>+struct virtio_gpu_ctx_destroy {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+};
>+
>+/* VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE, VIRTIO_GPU_CMD_CTX_DETACH_RESOURC=
E */
>+struct virtio_gpu_ctx_resource {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_SUBMIT_3D */
>+struct virtio_gpu_cmd_submit {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 size;
>+	__le32 padding;
>+};
>+
>+#define VIRTIO_GPU_CAPSET_VIRGL 1
>+#define VIRTIO_GPU_CAPSET_VIRGL2 2
>+/* 3 is reserved for gfxstream */
>+#define VIRTIO_GPU_CAPSET_VENUS 4
>+
>+/* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>+struct virtio_gpu_get_capset_info {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 capset_index;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_RESP_OK_CAPSET_INFO */
>+struct virtio_gpu_resp_capset_info {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 capset_id;
>+	__le32 capset_max_version;
>+	__le32 capset_max_size;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_GET_CAPSET */
>+struct virtio_gpu_get_capset {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 capset_id;
>+	__le32 capset_version;
>+};
>+
>+/* VIRTIO_GPU_RESP_OK_CAPSET */
>+struct virtio_gpu_resp_capset {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__u8 capset_data[];
>+};
>+
>+/* VIRTIO_GPU_CMD_GET_EDID */
>+struct virtio_gpu_cmd_get_edid {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 scanout;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_RESP_OK_EDID */
>+struct virtio_gpu_resp_edid {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 size;
>+	__le32 padding;
>+	__u8 edid[1024];
>+};
>+
>+#define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
>+
>+struct virtio_gpu_config {
>+	__le32 events_read;
>+	__le32 events_clear;
>+	__le32 num_scanouts;
>+	__le32 num_capsets;
>+};
>+
>+/* simple formats for fbcon/X use */
>+enum virtio_gpu_formats {
>+	VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM  =3D 1,
>+	VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM  =3D 2,
>+	VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM  =3D 3,
>+	VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM  =3D 4,
>+
>+	VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM  =3D 67,
>+	VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM  =3D 68,
>+
>+	VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM  =3D 121,
>+	VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  =3D 134,
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
>+struct virtio_gpu_resource_assign_uuid {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+/* VIRTIO_GPU_RESP_OK_RESOURCE_UUID */
>+struct virtio_gpu_resp_resource_uuid {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__u8 uuid[16];
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB */
>+struct virtio_gpu_resource_create_blob {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+#define VIRTIO_GPU_BLOB_MEM_GUEST             0x0001
>+#define VIRTIO_GPU_BLOB_MEM_HOST3D            0x0002
>+#define VIRTIO_GPU_BLOB_MEM_HOST3D_GUEST      0x0003
>+
>+#define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>+#define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>+#define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>+	/* zero is invalid blob mem */
>+	__le32 blob_mem;
>+	__le32 blob_flags;
>+	__le32 nr_entries;
>+	__le64 blob_id;
>+	__le64 size;
>+	/*
>+	 * sizeof(nr_entries * virtio_gpu_mem_entry) bytes follow
>+	 */
>+};
>+
>+/* VIRTIO_GPU_CMD_SET_SCANOUT_BLOB */
>+struct virtio_gpu_set_scanout_blob {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	struct virtio_gpu_rect r;
>+	__le32 scanout_id;
>+	__le32 resource_id;
>+	__le32 width;
>+	__le32 height;
>+	__le32 format;
>+	__le32 padding;
>+	__le32 strides[4];
>+	__le32 offsets[4];
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB */
>+struct virtio_gpu_resource_map_blob {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 padding;
>+	__le64 offset;
>+};
>+
>+/* VIRTIO_GPU_RESP_OK_MAP_INFO */
>+#define VIRTIO_GPU_MAP_CACHE_MASK     0x0f
>+#define VIRTIO_GPU_MAP_CACHE_NONE     0x00
>+#define VIRTIO_GPU_MAP_CACHE_CACHED   0x01
>+#define VIRTIO_GPU_MAP_CACHE_UNCACHED 0x02
>+#define VIRTIO_GPU_MAP_CACHE_WC       0x03
>+struct virtio_gpu_resp_map_info {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__u32 map_info;
>+	__u32 padding;
>+};
>+
>+/* VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB */
>+struct virtio_gpu_resource_unmap_blob {
>+	struct virtio_gpu_ctrl_hdr hdr;
>+	__le32 resource_id;
>+	__le32 padding;
>+};
>+
>+#endif
>diff --git a/include/virtio=2Eh b/include/virtio=2Eh
>index 1ab0ec5f39f5=2E=2E93a6f5e92a48 100644
>--- a/include/virtio=2Eh
>+++ b/include/virtio=2Eh
>@@ -27,11 +27,13 @@
> #define VIRTIO_ID_NET		1 /* virtio net */
> #define VIRTIO_ID_BLOCK		2 /* virtio block */
> #define VIRTIO_ID_RNG		4 /* virtio rng */
>-#define VIRTIO_ID_MAX_NUM	5
>+#define VIRTIO_ID_GPU		16 /* virtio GPU */
>+#define VIRTIO_ID_MAX_NUM	17
>=20
> #define VIRTIO_NET_DRV_NAME	"virtio-net"
> #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
> #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
>+#define VIRTIO_GPU_DRV_NAME	"virtio-gpu"
>=20
> /* Status byte for guest to report progress, and synchronize features */
>=20
>
