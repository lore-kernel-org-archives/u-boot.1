Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CCFC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E659988648;
	Sat, 20 Jul 2024 08:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Jerj672C";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbUsyjg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276C488ABA; Sat, 20 Jul 2024 08:58:17 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053A888137
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id C9F32138035C;
 Sat, 20 Jul 2024 02:58:10 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
 by compute1.internal (MEProxy); Sat, 20 Jul 2024 02:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1721458690;
 x=1721545090; bh=OwIQ573U10HuW0/9MqLhUM4dI1L/DWEDRdTYWmR3yLA=; b=
 Jerj672CJp0vej3PcguMKeYTJCpkNFuLKpSQXyUT1RJ4T96gieZqgA27AIyqO72J
 Hz/Gp/ygZB4/0/s8p+c7QlQK22e+Qx2tkxUcLd/YlyZ32xS+qtEBrYf9ROMl95u2
 rakeRxJLXFjeOj6Xxq8neAkwtLPsd5l7NG6ycE/7li5yP6mLWrDFQwdYwEXT78Fy
 BPwdvSCn86I6KsjtwfQvWVeAoUVUzitm9VZ+/CJSaAupRfP6i6ARxUVleDptPDRN
 fTLjRWXW2K1rjv9SMcuYJ/SqPmcK/kaimL2W6of4eHZRjAwT3ENP8esrZVHX5CEr
 wfR9nTRVvOYTnp9rl7t7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721458690; x=
 1721545090; bh=OwIQ573U10HuW0/9MqLhUM4dI1L/DWEDRdTYWmR3yLA=; b=r
 bUsyjg+oOmYG9+T6B41q113qQLT12+YdJ3pJ0m2eixsIZotgdQb+FNBoZ8izgyqS
 SMlX4phFDHhOwCE/0I4Dqxldljx10EkbSrmBPxSS0QOwUeRKOJ6I43MQuwBptzqP
 KUZup9TnxCuTTpFwIIyloYQtdOXET3rMSuX6fNzXtsvdl0NibylyC8UORwvLZyEO
 MyKQBWcoYfYJym4dpId3YS2H8uHvthQFVSj4v//YSJGZlDDOeZyogG8eSmMzvU29
 PYn/temweeFGvlcIXUjEYGE5X+PpSbfvPNLnL4SOg7Jqjtwj5Tv2BPZ+w8IuOKdE
 Avn0/g3BtwrpQMeBofrrw==
X-ME-Sender: <xms:AmCbZr3ue_3fEZsO48zKpMjRTXTlG406cdo82izeG3gcLB5oKafqDQ>
 <xme:AmCbZqGQdIphYGyMMARU7g32YCcaYbgeQfutW_ZZyu-MSKAvzMH1fwPS3o4SnL0V7
 zhOVA0wW-sK4a82vhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedvgdduudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:AmCbZr6SXpck8IEFyL6-oAwDazU1uL_jMy91HEZQ1r9eOGNjPWA3fg>
 <xmx:AmCbZg2bJru47OyfOUOzqWBIc6dpofaRP6ga9q8jFYzo4NnLzyKV_g>
 <xmx:AmCbZuF2_dD6ya0v3AYPs149hW-x4Xrc_5ZmQU2W_drPkNqepMl3Mw>
 <xmx:AmCbZh9gDOtDWvwaBJegMF_NBGpUbGUu7vD8LAdLro5OzPbBr8GoMw>
 <xmx:AmCbZrOuzexQbFB5Zb1ESK-JLA54kb_DPH2Ose9znF59-nb0YcDW1yUN>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6966919C0069; Sat, 20 Jul 2024 02:58:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <93433b4e-2ea2-455d-bb23-f0d94b876a2e@app.fastmail.com>
In-Reply-To: <CAFLszTjRuvRQGijGEVVRxcUXgHMMVzqqLUKwfinmY09fnwtd5w@mail.gmail.com>
References: <20240524-virtio_gpu-v2-0-b198c35b1fd2@flygoat.com>
 <20240524-virtio_gpu-v2-1-b198c35b1fd2@flygoat.com>
 <af3d7fbf-059e-45b1-bead-3118170d2eb7@app.fastmail.com>
 <CAFLszTjRuvRQGijGEVVRxcUXgHMMVzqqLUKwfinmY09fnwtd5w@mail.gmail.com>
Date: Sat, 20 Jul 2024 14:57:48 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Simon Glass" <sjg@chromium.org>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Bin Meng" <bmeng.cn@gmail.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/2] virtio: New virtio_gpu driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B47=E6=9C=8819=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=8811:05=EF=BC=8CSimon Glass=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
>
> On Wed, 17 Jul 2024 at 15:34, Jiaxun Yang <jiaxun.yang@flygoat.com> wr=
ote:
>>
>>
>>
>> =E5=9C=A82024=E5=B9=B45=E6=9C=8824=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=889:02=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
>> > This driver is implemened based on latest VirtIO spec.
>> > It follows operation prodcure as defined in the spec.
>> >
>> > It implemented multihead (mirroring) support as well.
>> >
>> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>
>> Ping
>>
>> > ---
>> > v2:
>> >       - Add big endian code path
>> >       - Reword typical resolution for Kconfig symbol
>> > ---
>> >  drivers/virtio/Kconfig         |  29 +++
>> >  drivers/virtio/Makefile        |   1 +
>> >  drivers/virtio/virtio-uclass.c |   1 +
>> >  drivers/virtio/virtio_gpu.c    | 302 +++++++++++++++++++++++++++++
>> >  drivers/virtio/virtio_gpu.h    | 428 +++++++++++++++++++++++++++++=
++++++++++++
>> >  include/virtio.h               |   4 +-
>> >  6 files changed, 764 insertions(+), 1 deletion(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Nits below
>
>> >
>> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> > index 1de68867d52e..a4838278fabc 100644
>> > --- a/drivers/virtio/Kconfig
>> > +++ b/drivers/virtio/Kconfig
>> > @@ -76,4 +76,33 @@ config VIRTIO_RNG
>> >       help
>> >         This is the virtual random number generator driver. It can =
be used
>> >         with QEMU based targets.
>> > +
>> > + config VIRTIO_GPU
>> > +     bool "virtio GPU driver"
>> > +     depends on VIRTIO && VIDEO
>> > +     default y
>> > +     help
>> > +       This is the virtual GPU display for virtio. It can be used =
with QEMU
>> > +       based targets.
>
> QEMU-based
>
> Can you add a bit more info about its capabilities? Should we be using
> this instead of Bochs?

I think it=E2=80=99s up to users preference?
For U-Boot there is no visible benefits, for Linux you can enjoy some ac=
cel features.
I=E2=80=99m not really sure if it=E2=80=99s relevant for U-Boot Kconfig.

>
>> > +
>> > +if VIRTIO_GPU
>> > +config VIRTIO_GPU_SIZE_X
>> > +     int "Width of display (X resolution)"
>> > +     default 1280
>> > +     help
>> > +       Sets the width of the display.
>> > +
>> > +       These two options control the size of the display set up by=
 QEMU.
>> > +       Typical size is 1280 x 1024 for compatibility.
>> > +
>> > +config VIRTIO_GPU_SIZE_Y
>> > +     int "High of display (Y resolution)"
>
> Height
>
>> > +     default 1024
>> > +     help
>> > +       Sets the height of the display.
>> > +
>> > +       These two options control the size of the display set up by=
 QEMU.
>> > +       Typical size is 1280 x 1024 for compatibility.
>> > +
>> > +endif
>> >  endmenu
>> > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>> > index 4c63a6c69043..c830fb6e6049 100644
>> > --- a/drivers/virtio/Makefile
>> > +++ b/drivers/virtio/Makefile
>> > @@ -11,3 +11,4 @@ obj-$(CONFIG_VIRTIO_SANDBOX) +=3D virtio_sandbox.o
>> >  obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
>> >  obj-$(CONFIG_VIRTIO_BLK) +=3D virtio_blk.o
>> >  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio_rng.o
>> > +obj-$(CONFIG_VIRTIO_GPU) +=3D virtio_gpu.o
>> > diff --git a/drivers/virtio/virtio-uclass.c
>> > b/drivers/virtio/virtio-uclass.c
>> > index 1dbc1a56aa21..1f3cdbf689c4 100644
>> > --- a/drivers/virtio/virtio-uclass.c
>> > +++ b/drivers/virtio/virtio-uclass.c
>> > @@ -30,6 +30,7 @@ static const char *const
>> > virtio_drv_name[VIRTIO_ID_MAX_NUM] =3D {
>> >       [VIRTIO_ID_NET]         =3D VIRTIO_NET_DRV_NAME,
>> >       [VIRTIO_ID_BLOCK]       =3D VIRTIO_BLK_DRV_NAME,
>> >       [VIRTIO_ID_RNG]         =3D VIRTIO_RNG_DRV_NAME,
>> > +     [VIRTIO_ID_GPU]         =3D VIRTIO_GPU_DRV_NAME,
>> >  };
>> >
>> >  int virtio_get_config(struct udevice *vdev, unsigned int offset,
>> > diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gp=
u.c
>> > new file mode 100644
>> > index 000000000000..0b306bb9d2fa
>> > --- /dev/null
>> > +++ b/drivers/virtio/virtio_gpu.c
>> > @@ -0,0 +1,302 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
>> > + */
>> > +
>> > +#define pr_fmt(fmt) "virtio_gpu: " fmt
>> > +
>> > +#include <dm.h>
>> > +#include <log.h>
>> > +#include <malloc.h>
>> > +#include <video.h>
>> > +#include <virtio_types.h>
>> > +#include <virtio.h>
>> > +#include <virtio_ring.h>
>> > +#include "virtio_gpu.h"
>> > +#include <asm/io.h>
>> > +
>> > +struct virtio_gpu_priv {
>> > +     struct virtqueue *vq;
>> > +     u32 scanout_res_id;
>> > +     u64 fence_id;
>> > +     bool in_sync;
>> > +};
>> > +
>> > +static int virtio_gpu_do_req(struct udevice *dev,
>> > +                          enum virtio_gpu_ctrl_type type,
>> > +                          void *in, size_t in_size,
>> > +                          void *out, size_t out_size, bool flush)
>
> Please add a function comment
>
>> > +{
>> > +     int ret;
>> > +     uint len;
>> > +     struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
>> > +     struct virtio_sg in_sg;
>> > +     struct virtio_sg out_sg;
>> > +     struct virtio_sg *sgs[] =3D { &in_sg, &out_sg };
>> > +     struct virtio_gpu_ctrl_hdr *ctrl_hdr_in =3D in;
>> > +     struct virtio_gpu_ctrl_hdr *ctrl_hdr_out =3D out;
>> > +
>> > +     ctrl_hdr_in->type =3D cpu_to_virtio32(dev, (u32)type);
>> > +     if (flush) {
>> > +             ctrl_hdr_in->flags =3D cpu_to_virtio32(dev, VIRTIO_GP=
U_FLAG_FENCE);
>> > +             ctrl_hdr_in->fence_id =3D cpu_to_virtio64(dev, priv->=
fence_id++);
>> > +     } else {
>> > +             ctrl_hdr_in->flags =3D 0;
>> > +             ctrl_hdr_in->fence_id =3D 0;
>> > +     }
>> > +     ctrl_hdr_in->ctx_id =3D 0;
>> > +     ctrl_hdr_in->ring_idx =3D 0;
>> > +     in_sg.addr =3D in;
>> > +     in_sg.length =3D in_size;
>> > +     out_sg.addr =3D out;
>> > +     out_sg.length =3D out_size;
>> > +
>> > +     ret =3D virtqueue_add(priv->vq, sgs, 1, 1);
>> > +     if (ret) {
>> > +             log_debug("virtqueue_add failed %d\n", ret);
>> > +             return ret;
>> > +     }
>> > +     virtqueue_kick(priv->vq);
>> > +
>> > +     debug("wait...");
>> > +     while (!virtqueue_get_buf(priv->vq, &len))
>> > +             ;
>> > +     debug("done\n");
>> > +
>> > +     if (out_size !=3D len) {
>> > +             log_debug("Invalid response size %d, expected %d\n",
>> > +                       len, (uint)out_size);
>> > +     }
>> > +
>> > +     return virtio32_to_cpu(dev, ctrl_hdr_out->type);
>> > +}
>> > +
>> > +static int virtio_gpu_probe(struct udevice *dev)
>> > +{
>> > +     struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
>> > +     struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
>> > +     struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
>> > +     struct virtio_gpu_ctrl_hdr ctrl_hdr_in;
>> > +     struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
>> > +     struct virtio_gpu_resp_display_info *disp_info_out;
>> > +     struct virtio_gpu_display_one *disp;
>> > +     struct virtio_gpu_resource_create_2d *res_create_2d_in;
>> > +     void *res_buf_in;
>> > +     struct virtio_gpu_resource_attach_backing *res_attach_backing=
_in;
>> > +     struct virtio_gpu_mem_entry *mem_entry;
>> > +     struct virtio_gpu_set_scanout *set_scanout_in;
>> > +     unsigned int scanout_mask =3D 0;
>> > +     int ret, i;
>> > +
>> > +     if (!plat->base) {
>> > +             log_warning("No framebuffer allocated\n");
>> > +             return -EINVAL;
>> > +     }
>> > +
>> > +     ret =3D virtio_find_vqs(dev, 1, &priv->vq);
>> > +     if (ret < 0) {
>> > +             log_warning("virtio_find_vqs failed\n");
>> > +             return ret;
>> > +     }
>> > +
>> > +     disp_info_out =3D malloc(sizeof(struct virtio_gpu_resp_displa=
y_info));
>> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_GET_DISPLAY_INF=
O,
>> > &ctrl_hdr_in,
>> > +                             sizeof(struct virtio_gpu_ctrl_hdr), d=
isp_info_out,
>> > +                             sizeof(struct virtio_gpu_resp_display=
_info), false);
>> > +
>> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_DISPLAY_INFO) {
>> > +             log_warning("CMD_GET_DISPLAY_INFO failed %d\n", ret);
>> > +             ret =3D -EINVAL;
>> > +             goto out_free_disp;
>> > +     }
>> > +
>> > +     for (i =3D 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
>> > +             disp =3D &disp_info_out->pmodes[i];
>> > +             if (!disp->enabled)
>> > +                     continue;
>> > +             log_debug("Found available scanout: %d\n", i);
>> > +             scanout_mask |=3D 1 << i;
>> > +     }
>> > +
>> > +     if (!scanout_mask) {
>> > +             log_warning("No active scanout found\n");
>> > +             ret =3D -EINVAL;
>> > +             goto out_free_disp;
>> > +     }
>> > +
>> > +     free(disp_info_out);
>> > +     disp_info_out =3D NULL;
>> > +
>> > +     /* TODO: We can parse EDID for those info */
>> > +     uc_priv->xsize =3D CONFIG_VAL(VIRTIO_GPU_SIZE_X);
>> > +     uc_priv->ysize =3D CONFIG_VAL(VIRTIO_GPU_SIZE_Y);
>> > +     uc_priv->bpix =3D VIDEO_BPP32;
>> > +
>> > +     priv->scanout_res_id =3D 1;
>> > +     res_create_2d_in =3D malloc(sizeof(struct
>> > virtio_gpu_resource_create_2d));
>> > +     res_create_2d_in->resource_id =3D cpu_to_virtio32(dev,
>> > priv->scanout_res_id);
>> > +#ifdef __BIG_ENDIAN
>> > +     res_create_2d_in->format =3D cpu_to_virtio32(dev,
>> > VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM);
>> > +#else
>> > +     res_create_2d_in->format =3D cpu_to_virtio32(dev,
>> > VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM);
>> > +#endif
>> > +     res_create_2d_in->width =3D cpu_to_virtio32(dev, uc_priv->xsi=
ze);
>> > +     res_create_2d_in->height =3D cpu_to_virtio32(dev, uc_priv->ys=
ize);
>> > +
>> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_CREATE=
_2D,
>> > res_create_2d_in,
>> > +                             sizeof(struct virtio_gpu_resource_cre=
ate_2d), &ctrl_hdr_out,
>> > +                             sizeof(struct virtio_gpu_ctrl_hdr), f=
alse);
>> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>> > +             log_warning("CMD_RESOURCE_CREATE_2D failed %d\n", ret=
);
>> > +             ret =3D -EINVAL;
>> > +             goto out_free_res_create_2d;
>> > +     }
>> > +
>> > +     free(res_create_2d_in);
>> > +     res_create_2d_in =3D NULL;
>> > +
>> > +     res_buf_in =3D malloc(sizeof(struct virtio_gpu_resource_attac=
h_backing)
>> > +
>> > +                         sizeof(struct virtio_gpu_mem_entry));
>> > +     res_attach_backing_in =3D res_buf_in;
>> > +     mem_entry =3D res_buf_in + sizeof(struct
>> > virtio_gpu_resource_attach_backing);
>> > +     res_attach_backing_in->resource_id =3D cpu_to_virtio32(dev,
>> > priv->scanout_res_id);
>> > +     res_attach_backing_in->nr_entries =3D cpu_to_virtio32(dev, 1);
>> > +     mem_entry->addr =3D cpu_to_virtio64(dev, virt_to_phys((void
>> > *)plat->base));
>> > +     mem_entry->length =3D cpu_to_virtio32(dev, plat->size);
>> > +     mem_entry->padding =3D 0;
>> > +
>> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_ATTACH=
_BACKING,
>> > res_buf_in,
>> > +                             sizeof(struct virtio_gpu_resource_att=
ach_backing) +
>> > +                             sizeof(struct virtio_gpu_mem_entry), =
&ctrl_hdr_out,
>> > +                             sizeof(struct virtio_gpu_ctrl_hdr), f=
alse);
>> > +
>> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>> > +             log_warning("CMD_RESOURCE_ATTACH_BACKING failed %d\n"=
, ret);
>> > +             ret =3D -EINVAL;
>> > +             goto out_free_res_buf;
>> > +     }
>> > +     free(res_buf_in);
>> > +     res_buf_in =3D NULL;
>> > +
>> > +     set_scanout_in =3D malloc(sizeof(struct virtio_gpu_set_scanou=
t));
>
> Could these structs be inside priv instead of allocating each one?

Those structs are all used only once at initialization.

We can save some runtime memory by freeing them here :-)

>
>> > +     while (scanout_mask) {
>> > +             u32 active_scanout =3D ffs(scanout_mask) - 1;
>> > +
>> > +             set_scanout_in->r.x =3D 0;
>> > +             set_scanout_in->r.y =3D 0;
>> > +             set_scanout_in->r.width =3D cpu_to_virtio32(dev, uc_p=
riv->xsize);
>> > +             set_scanout_in->r.height =3D cpu_to_virtio32(dev, uc_=
priv->ysize);
>> > +             set_scanout_in->scanout_id =3D cpu_to_virtio32(dev, a=
ctive_scanout);
>> > +             set_scanout_in->resource_id =3D cpu_to_virtio32(dev,
>> > priv->scanout_res_id);
>> > +
>> > +             ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_SET_SCA=
NOUT,
>> > set_scanout_in,
>> > +                                     sizeof(struct virtio_gpu_set_=
scanout), &ctrl_hdr_out,
>> > +                                     sizeof(struct virtio_gpu_ctrl=
_hdr), false);
>> > +
>> > +             if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>> > +                     log_warning("CMD_SET_SCANOUT failed %d for sc=
anout %d\n",
>> > +                                 ret, active_scanout);
>> > +                     ret =3D -EINVAL;
>> > +                     goto out_free_set_scanout;
>> > +             }
>> > +             scanout_mask &=3D ~(1 << active_scanout);
>> > +     }
>> > +     free(set_scanout_in);
>> > +     set_scanout_in =3D NULL;
>> > +
>> > +     return 0;
>> > +out_free_set_scanout:
>> > +     if (set_scanout_in)
>> > +             free(set_scanout_in);
>> > +out_free_res_buf:
>> > +     if (res_buf_in)
>> > +             free(res_buf_in);
>> > +out_free_res_create_2d:
>> > +     if (res_create_2d_in)
>> > +             free(res_create_2d_in);
>> > +out_free_disp:
>> > +     if (disp_info_out)
>> > +             free(disp_info_out);
>> > +     return ret;
>> > +}
>> > +
>> > +static int virtio_gpu_bind(struct udevice *dev)
>> > +{
>> > +     struct virtio_dev_priv *virtio_uc_priv =3D
>> > dev_get_uclass_priv(dev->parent);
>> > +     struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
>> > +
>> > +     /* Indicate what driver features we support */
>> > +     virtio_driver_features_init(virtio_uc_priv, NULL, 0, NULL, 0);
>> > +     plat->base =3D 0; /* Framebuffer will be allocated by the vid=
eo-uclass
>> > */
>> > +     plat->size =3D CONFIG_VAL(VIRTIO_GPU_SIZE_X) *
>> > +                  CONFIG_VAL(VIRTIO_GPU_SIZE_X) * VNBYTES(VIDEO_BP=
P32);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int virtio_gpu_video_sync(struct udevice *dev)
>> > +{
>> > +     struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
>> > +     struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
>> > +     struct virtio_gpu_transfer_to_host_2d to_host_2d_in;
>> > +     struct virtio_gpu_resource_flush res_flush_in;
>> > +     struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
>> > +     int ret;
>> > +
>> > +     /* We need to protect sync function reentrance to prevent exa=
usting
>> > VQ */
>> > +     if (priv->in_sync)
>> > +             return 0;
>> > +
>> > +     priv->in_sync =3D true;
>> > +
>> > +     to_host_2d_in.r.x =3D 0;
>> > +     to_host_2d_in.r.y =3D 0;
>> > +     to_host_2d_in.r.width =3D cpu_to_virtio32(dev, uc_priv->xsize=
);
>> > +     to_host_2d_in.r.height =3D cpu_to_virtio32(dev, uc_priv->ysiz=
e);
>> > +     to_host_2d_in.offset =3D 0;
>> > +     to_host_2d_in.resource_id =3D cpu_to_virtio32(dev,
>> > priv->scanout_res_id);
>> > +     to_host_2d_in.padding =3D 0;
>> > +
>> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_TRANSFER_TO_HOS=
T_2D,
>> > &to_host_2d_in,
>> > +                             sizeof(struct virtio_gpu_transfer_to_=
host_2d), &ctrl_hdr_out,
>> > +                             sizeof(struct virtio_gpu_ctrl_hdr), t=
rue);
>> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>> > +             log_debug("CMD_TRANSFER_TO_HOST_2D failed %d\n", ret);
>> > +             priv->in_sync =3D false;
>> > +             return -EINVAL;
>> > +     }
>> > +
>> > +     res_flush_in.r.x =3D 0;
>> > +     res_flush_in.r.y =3D 0;
>> > +     res_flush_in.r.width =3D cpu_to_virtio32(dev, uc_priv->xsize);
>> > +     res_flush_in.r.height =3D cpu_to_virtio32(dev, uc_priv->ysize=
);
>> > +     res_flush_in.resource_id =3D cpu_to_virtio32(dev, priv->scano=
ut_res_id);
>> > +     res_flush_in.padding =3D 0;
>> > +
>> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_FLUSH,
>> > &res_flush_in,
>> > +                             sizeof(struct virtio_gpu_resource_flu=
sh), &ctrl_hdr_out,
>> > +                             sizeof(struct virtio_gpu_ctrl_hdr), t=
rue);
>> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
>> > +             log_debug("CMD_RESOURCE_FLUSH failed %d\n", ret);
>> > +             priv->in_sync =3D false;
>> > +             return -EINVAL;
>> > +     }
>> > +
>> > +     priv->in_sync =3D false;
>> > +     return 0;
>> > +}
>> > +
>> > +static struct video_ops virtio_gpu_ops =3D {
>> > +     .video_sync =3D virtio_gpu_video_sync,
>> > +};
>> > +
>> > +U_BOOT_DRIVER(virtio_gpu) =3D {
>> > +     .name   =3D VIRTIO_GPU_DRV_NAME,
>> > +     .id     =3D UCLASS_VIDEO,
>> > +     .bind   =3D virtio_gpu_bind,
>> > +     .probe  =3D virtio_gpu_probe,
>> > +     .remove =3D virtio_reset,
>> > +     .ops    =3D &virtio_gpu_ops,
>> > +     .priv_auto      =3D sizeof(struct virtio_gpu_priv),
>> > +     .flags  =3D DM_FLAG_ACTIVE_DMA,
>> > +};
>> > diff --git a/drivers/virtio/virtio_gpu.h b/drivers/virtio/virtio_gp=
u.h
>> > new file mode 100644
>> > index 000000000000..d2e5c0e02f13
>> > --- /dev/null
>> > +++ b/drivers/virtio/virtio_gpu.h
>> > @@ -0,0 +1,428 @@
>> > +/* SPDX-License-Identifier: BSD-3-Clause */
>> > +/*
>> > + * Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
>> > + *
>> > + * From Linux kernel include/uapi/linux/virtio_gpu.h
>> > + */
>> > +
>> > +#ifndef VIRTIO_GPU_HW_H
>> > +#define VIRTIO_GPU_HW_H
>> > +
>> > +#include <linux/types.h>
>> > +
>> > +/*
>> > + * VIRTIO_GPU_CMD_CTX_*
>> > + * VIRTIO_GPU_CMD_*_3D
>> > + */
>> > +#define VIRTIO_GPU_F_VIRGL               0
>> > +
>> > +/*
>> > + * VIRTIO_GPU_CMD_GET_EDID
>> > + */
>> > +#define VIRTIO_GPU_F_EDID                1
>> > +/*
>> > + * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
>> > + */
>> > +#define VIRTIO_GPU_F_RESOURCE_UUID       2
>> > +
>> > +/*
>> > + * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
>> > + */
>> > +#define VIRTIO_GPU_F_RESOURCE_BLOB       3
>> > +/*
>> > + * VIRTIO_GPU_CMD_CREATE_CONTEXT with
>> > + * context_init and multiple timelines
>> > + */
>> > +#define VIRTIO_GPU_F_CONTEXT_INIT        4
>> > +
>> > +enum virtio_gpu_ctrl_type {
>> > +     VIRTIO_GPU_UNDEFINED =3D 0,
>> > +
>> > +     /* 2d commands */
>> > +     VIRTIO_GPU_CMD_GET_DISPLAY_INFO =3D 0x0100,
>> > +     VIRTIO_GPU_CMD_RESOURCE_CREATE_2D,
>> > +     VIRTIO_GPU_CMD_RESOURCE_UNREF,
>> > +     VIRTIO_GPU_CMD_SET_SCANOUT,
>> > +     VIRTIO_GPU_CMD_RESOURCE_FLUSH,
>> > +     VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D,
>> > +     VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING,
>> > +     VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
>> > +     VIRTIO_GPU_CMD_GET_CAPSET_INFO,
>> > +     VIRTIO_GPU_CMD_GET_CAPSET,
>> > +     VIRTIO_GPU_CMD_GET_EDID,
>> > +     VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
>> > +     VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB,
>> > +     VIRTIO_GPU_CMD_SET_SCANOUT_BLOB,
>> > +
>> > +     /* 3d commands */
>> > +     VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
>> > +     VIRTIO_GPU_CMD_CTX_DESTROY,
>> > +     VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE,
>> > +     VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE,
>> > +     VIRTIO_GPU_CMD_RESOURCE_CREATE_3D,
>> > +     VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
>> > +     VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D,
>> > +     VIRTIO_GPU_CMD_SUBMIT_3D,
>> > +     VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
>> > +     VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
>> > +
>> > +     /* cursor commands */
>> > +     VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
>> > +     VIRTIO_GPU_CMD_MOVE_CURSOR,
>> > +
>> > +     /* success responses */
>> > +     VIRTIO_GPU_RESP_OK_NODATA =3D 0x1100,
>> > +     VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
>> > +     VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>> > +     VIRTIO_GPU_RESP_OK_CAPSET,
>> > +     VIRTIO_GPU_RESP_OK_EDID,
>> > +     VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
>> > +     VIRTIO_GPU_RESP_OK_MAP_INFO,
>> > +
>> > +     /* error responses */
>> > +     VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
>> > +     VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY,
>> > +     VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID,
>> > +     VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
>> > +     VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
>> > +     VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
>> > +};
>> > +
>> > +enum virtio_gpu_shm_id {
>> > +     VIRTIO_GPU_SHM_ID_UNDEFINED =3D 0,
>> > +     /*
>> > +      * VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB
>> > +      * VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB
>> > +      */
>> > +     VIRTIO_GPU_SHM_ID_HOST_VISIBLE =3D 1
>> > +};
>> > +
>> > +#define VIRTIO_GPU_FLAG_FENCE         (1 << 0)
>> > +/*
>> > + * If the following flag is set, then ring_idx contains the index
>> > + * of the command ring that needs to used when creating the fence
>> > + */
>> > +#define VIRTIO_GPU_FLAG_INFO_RING_IDX (1 << 1)
>> > +
>> > +struct virtio_gpu_ctrl_hdr {
>> > +     __le32 type;
>> > +     __le32 flags;
>> > +     __le64 fence_id;
>> > +     __le32 ctx_id;
>> > +     __u8 ring_idx;
>> > +     __u8 padding[3];
>> > +};
>> > +
>> > +/* data passed in the cursor vq */
>> > +
>> > +struct virtio_gpu_cursor_pos {
>> > +     __le32 scanout_id;
>> > +     __le32 x;
>> > +     __le32 y;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_UPDATE_CURSOR, VIRTIO_GPU_CMD_MOVE_CURSOR */
>> > +struct virtio_gpu_update_cursor {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_cursor_pos pos;  /* update & move */
>> > +     __le32 resource_id;           /* update only */
>> > +     __le32 hot_x;                 /* update only */
>> > +     __le32 hot_y;                 /* update only */
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* data passed in the control vq, 2d related */
>
> But there are no comments so we don't know what these structs are for
> or what the fields do. Can you add documentation, or a pointer to
> somewhere where it exists?

The whole header is copied from Linux kernel so I=E2=80=99m not really s=
ure if we want to edit it.

Maybe I can mention about the specification at start of the driver code?

Thanks
>
>> > +
>> > +struct virtio_gpu_rect {
>> > +     __le32 x;
>> > +     __le32 y;
>> > +     __le32 width;
>> > +     __le32 height;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_UNREF */
>> > +struct virtio_gpu_resource_unref {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_2D: create a 2d resource with a
>> > format */
>> > +struct virtio_gpu_resource_create_2d {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 format;
>> > +     __le32 width;
>> > +     __le32 height;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_SET_SCANOUT */
>> > +struct virtio_gpu_set_scanout {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_rect r;
>> > +     __le32 scanout_id;
>> > +     __le32 resource_id;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_FLUSH */
>> > +struct virtio_gpu_resource_flush {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_rect r;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D: simple transfer to_host */
>> > +struct virtio_gpu_transfer_to_host_2d {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_rect r;
>> > +     __le64 offset;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +struct virtio_gpu_mem_entry {
>> > +     __le64 addr;
>> > +     __le32 length;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING */
>> > +struct virtio_gpu_resource_attach_backing {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 nr_entries;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING */
>> > +struct virtio_gpu_resource_detach_backing {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_RESP_OK_DISPLAY_INFO */
>> > +#define VIRTIO_GPU_MAX_SCANOUTS 16
>> > +struct virtio_gpu_resp_display_info {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_display_one {
>> > +             struct virtio_gpu_rect r;
>> > +             __le32 enabled;
>> > +             __le32 flags;
>> > +     } pmodes[VIRTIO_GPU_MAX_SCANOUTS];
>> > +};
>> > +
>> > +/* data passed in the control vq, 3d related */
>> > +
>> > +struct virtio_gpu_box {
>> > +     __le32 x, y, z;
>> > +     __le32 w, h, d;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
>> > VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D */
>> > +struct virtio_gpu_transfer_host_3d {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_box box;
>> > +     __le64 offset;
>> > +     __le32 resource_id;
>> > +     __le32 level;
>> > +     __le32 stride;
>> > +     __le32 layer_stride;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_3D */
>> > +#define VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP (1 << 0)
>> > +struct virtio_gpu_resource_create_3d {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 target;
>> > +     __le32 format;
>> > +     __le32 bind;
>> > +     __le32 width;
>> > +     __le32 height;
>> > +     __le32 depth;
>> > +     __le32 array_size;
>> > +     __le32 last_level;
>> > +     __le32 nr_samples;
>> > +     __le32 flags;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_CTX_CREATE */
>> > +#define VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK 0x000000ff
>> > +struct virtio_gpu_ctx_create {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 nlen;
>> > +     __le32 context_init;
>> > +     char debug_name[64];
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_CTX_DESTROY */
>> > +struct virtio_gpu_ctx_destroy {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE,
>> > VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE */
>> > +struct virtio_gpu_ctx_resource {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_SUBMIT_3D */
>> > +struct virtio_gpu_cmd_submit {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 size;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +#define VIRTIO_GPU_CAPSET_VIRGL 1
>> > +#define VIRTIO_GPU_CAPSET_VIRGL2 2
>> > +/* 3 is reserved for gfxstream */
>> > +#define VIRTIO_GPU_CAPSET_VENUS 4
>> > +
>> > +/* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>> > +struct virtio_gpu_get_capset_info {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 capset_index;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_RESP_OK_CAPSET_INFO */
>> > +struct virtio_gpu_resp_capset_info {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 capset_id;
>> > +     __le32 capset_max_version;
>> > +     __le32 capset_max_size;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_GET_CAPSET */
>> > +struct virtio_gpu_get_capset {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 capset_id;
>> > +     __le32 capset_version;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_RESP_OK_CAPSET */
>> > +struct virtio_gpu_resp_capset {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __u8 capset_data[];
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_GET_EDID */
>> > +struct virtio_gpu_cmd_get_edid {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 scanout;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_RESP_OK_EDID */
>> > +struct virtio_gpu_resp_edid {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 size;
>> > +     __le32 padding;
>> > +     __u8 edid[1024];
>> > +};
>> > +
>> > +#define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
>> > +
>> > +struct virtio_gpu_config {
>> > +     __le32 events_read;
>> > +     __le32 events_clear;
>> > +     __le32 num_scanouts;
>> > +     __le32 num_capsets;
>> > +};
>> > +
>> > +/* simple formats for fbcon/X use */
>> > +enum virtio_gpu_formats {
>> > +     VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM  =3D 1,
>> > +     VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM  =3D 2,
>> > +     VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM  =3D 3,
>> > +     VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM  =3D 4,
>> > +
>> > +     VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM  =3D 67,
>> > +     VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM  =3D 68,
>> > +
>> > +     VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM  =3D 121,
>> > +     VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  =3D 134,
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
>> > +struct virtio_gpu_resource_assign_uuid {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_RESP_OK_RESOURCE_UUID */
>> > +struct virtio_gpu_resp_resource_uuid {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __u8 uuid[16];
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB */
>> > +struct virtio_gpu_resource_create_blob {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +#define VIRTIO_GPU_BLOB_MEM_GUEST             0x0001
>> > +#define VIRTIO_GPU_BLOB_MEM_HOST3D            0x0002
>> > +#define VIRTIO_GPU_BLOB_MEM_HOST3D_GUEST      0x0003
>> > +
>> > +#define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>> > +#define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>> > +#define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>> > +     /* zero is invalid blob mem */
>> > +     __le32 blob_mem;
>> > +     __le32 blob_flags;
>> > +     __le32 nr_entries;
>> > +     __le64 blob_id;
>> > +     __le64 size;
>> > +     /*
>> > +      * sizeof(nr_entries * virtio_gpu_mem_entry) bytes follow
>> > +      */
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_SET_SCANOUT_BLOB */
>> > +struct virtio_gpu_set_scanout_blob {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     struct virtio_gpu_rect r;
>> > +     __le32 scanout_id;
>> > +     __le32 resource_id;
>> > +     __le32 width;
>> > +     __le32 height;
>> > +     __le32 format;
>> > +     __le32 padding;
>> > +     __le32 strides[4];
>> > +     __le32 offsets[4];
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB */
>> > +struct virtio_gpu_resource_map_blob {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +     __le64 offset;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_RESP_OK_MAP_INFO */
>> > +#define VIRTIO_GPU_MAP_CACHE_MASK     0x0f
>> > +#define VIRTIO_GPU_MAP_CACHE_NONE     0x00
>> > +#define VIRTIO_GPU_MAP_CACHE_CACHED   0x01
>> > +#define VIRTIO_GPU_MAP_CACHE_UNCACHED 0x02
>> > +#define VIRTIO_GPU_MAP_CACHE_WC       0x03
>> > +struct virtio_gpu_resp_map_info {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __u32 map_info;
>> > +     __u32 padding;
>> > +};
>> > +
>> > +/* VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB */
>> > +struct virtio_gpu_resource_unmap_blob {
>> > +     struct virtio_gpu_ctrl_hdr hdr;
>> > +     __le32 resource_id;
>> > +     __le32 padding;
>> > +};
>> > +
>> > +#endif
>> > diff --git a/include/virtio.h b/include/virtio.h
>> > index 1ab0ec5f39f5..93a6f5e92a48 100644
>> > --- a/include/virtio.h
>> > +++ b/include/virtio.h
>> > @@ -27,11 +27,13 @@
>> >  #define VIRTIO_ID_NET                1 /* virtio net */
>> >  #define VIRTIO_ID_BLOCK              2 /* virtio block */
>> >  #define VIRTIO_ID_RNG                4 /* virtio rng */
>> > -#define VIRTIO_ID_MAX_NUM    5
>> > +#define VIRTIO_ID_GPU                16 /* virtio GPU */
>> > +#define VIRTIO_ID_MAX_NUM    17
>> >
>> >  #define VIRTIO_NET_DRV_NAME  "virtio-net"
>> >  #define VIRTIO_BLK_DRV_NAME  "virtio-blk"
>> >  #define VIRTIO_RNG_DRV_NAME  "virtio-rng"
>> > +#define VIRTIO_GPU_DRV_NAME  "virtio-gpu"
>> >
>> >  /* Status byte for guest to report progress, and synchronize featu=
res */
>> >
>> >
>> > --
>> > 2.43.0
>>
>
> Regards,
> Simon

--=20
- Jiaxun
