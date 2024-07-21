Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17608C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C77B87FCD;
	Sun, 21 Jul 2024 12:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I46YK6qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3385987F5C; Sun, 21 Jul 2024 12:08:46 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35468657F
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b78c980981so20465286d6.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556522; x=1722161322; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+vxNWFbHGyZymM1SyCCrItpEc598WYMTf8LKxXRVlo=;
 b=I46YK6qPY889gifQ3LJToLFFMRD9wFfNPE/kYev+M6M+vo9s945bH4nua6/Jt6VOA1
 SeFcoz6c4vEwtowwyG6UlYkOyctv4pYSwLdIwcGx5AyfyEC8BzKBF8ZhH9A28aZ+/wbw
 9IR4WOzaoMjINO7Rny9kgiJNwpf8vEO2/osaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556522; x=1722161322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+vxNWFbHGyZymM1SyCCrItpEc598WYMTf8LKxXRVlo=;
 b=g2OjnnkIaqNXSLTbwslaw7wHzlzjdtln4kBC+ftHcNOuY3+/3f0pDAaF/hk+0IMESM
 MFHdxaeR6CPHvT6zrlPVj6n5CyWdlhejIqlLBpQJzJoTFfVbgFveacNvFiNtgxsx6OkU
 Dl/HSOQCCBqmBkAMQgM7FY+fiFR7/wy6VWIaJA/TCVYivzRCnj2qJLWxRLaHeqUuyjbK
 ugZwLN7qabDKlLHC1hcOAabaazRacv1uJDUoIvW5wl49q+XBeU/CgM9wKhPYjZ1USGtu
 py3Jj9762kJp9iMjq9ejl0GdsUSOO1Vr4bdBX13MABvJrR7d1y5I0giqU6jZt4c0m0x0
 cPuA==
X-Gm-Message-State: AOJu0Ywe29vAWiWFmVLwMqxXEXM1itq30GLNT0SUWht0YohI0kSX8Zij
 Em0BPfiHRn4k3CPWLPOkwJRg1E0cyKZ77bLDH5sB55qEs0jN/exnhX7fdSMesuhWAYhCnkjpHOf
 mPxar7rfC+DHf5gZPUj9HipfylJicJCRos9MZ
X-Google-Smtp-Source: AGHT+IGyaccLk7m0g4dKp6NK04rsr+ZP+qKiepzSFy2lRzg3Hm2CSNKju0mJM1v95ot1y960pNBsGUytTKcy396P9BI=
X-Received: by 2002:a05:6214:5192:b0:6b7:9c52:db53 with SMTP id
 6a1803df08f44-6b961123f03mr51005696d6.48.1721556522532; Sun, 21 Jul 2024
 03:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-virtio_gpu-v2-0-b198c35b1fd2@flygoat.com>
 <20240524-virtio_gpu-v2-1-b198c35b1fd2@flygoat.com>
 <af3d7fbf-059e-45b1-bead-3118170d2eb7@app.fastmail.com>
 <CAFLszTjRuvRQGijGEVVRxcUXgHMMVzqqLUKwfinmY09fnwtd5w@mail.gmail.com>
 <93433b4e-2ea2-455d-bb23-f0d94b876a2e@app.fastmail.com>
In-Reply-To: <93433b4e-2ea2-455d-bb23-f0d94b876a2e@app.fastmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:31 +0100
Message-ID: <CAFLszTgrM9Fz8mC=SQ69PRYsdZ5Y38VZYyCFeV3W6FL=DbJKkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] virtio: New virtio_gpu driver
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jiaxun,

On Sat, 20 Jul 2024 at 07:58, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B47=E6=9C=8819=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=8811:05=EF=BC=8CSimon Glass=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Jiaxun,
> >
> > On Wed, 17 Jul 2024 at 15:34, Jiaxun Yang <jiaxun.yang@flygoat.com> wro=
te:
> >>
> >>
> >>
> >> =E5=9C=A82024=E5=B9=B45=E6=9C=8824=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=
=8B=E5=8D=889:02=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> >> > This driver is implemened based on latest VirtIO spec.
> >> > It follows operation prodcure as defined in the spec.
> >> >
> >> > It implemented multihead (mirroring) support as well.
> >> >
> >> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>
> >> Ping
> >>
> >> > ---
> >> > v2:
> >> >       - Add big endian code path
> >> >       - Reword typical resolution for Kconfig symbol
> >> > ---
> >> >  drivers/virtio/Kconfig         |  29 +++
> >> >  drivers/virtio/Makefile        |   1 +
> >> >  drivers/virtio/virtio-uclass.c |   1 +
> >> >  drivers/virtio/virtio_gpu.c    | 302 +++++++++++++++++++++++++++++
> >> >  drivers/virtio/virtio_gpu.h    | 428 ++++++++++++++++++++++++++++++=
+++++++++++
> >> >  include/virtio.h               |   4 +-
> >> >  6 files changed, 764 insertions(+), 1 deletion(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Nits below
> >
> >> >
> >> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> >> > index 1de68867d52e..a4838278fabc 100644
> >> > --- a/drivers/virtio/Kconfig
> >> > +++ b/drivers/virtio/Kconfig
> >> > @@ -76,4 +76,33 @@ config VIRTIO_RNG
> >> >       help
> >> >         This is the virtual random number generator driver. It can b=
e used
> >> >         with QEMU based targets.
> >> > +
> >> > + config VIRTIO_GPU
> >> > +     bool "virtio GPU driver"
> >> > +     depends on VIRTIO && VIDEO
> >> > +     default y
> >> > +     help
> >> > +       This is the virtual GPU display for virtio. It can be used w=
ith QEMU
> >> > +       based targets.
> >
> > QEMU-based
> >
> > Can you add a bit more info about its capabilities? Should we be using
> > this instead of Bochs?
>
> I think it=E2=80=99s up to users preference?
> For U-Boot there is no visible benefits, for Linux you can enjoy some acc=
el features.
> I=E2=80=99m not really sure if it=E2=80=99s relevant for U-Boot Kconfig.
>
> >
> >> > +
> >> > +if VIRTIO_GPU
> >> > +config VIRTIO_GPU_SIZE_X
> >> > +     int "Width of display (X resolution)"
> >> > +     default 1280
> >> > +     help
> >> > +       Sets the width of the display.
> >> > +
> >> > +       These two options control the size of the display set up by =
QEMU.
> >> > +       Typical size is 1280 x 1024 for compatibility.
> >> > +
> >> > +config VIRTIO_GPU_SIZE_Y
> >> > +     int "High of display (Y resolution)"
> >
> > Height
> >
> >> > +     default 1024
> >> > +     help
> >> > +       Sets the height of the display.
> >> > +
> >> > +       These two options control the size of the display set up by =
QEMU.
> >> > +       Typical size is 1280 x 1024 for compatibility.
> >> > +
> >> > +endif
> >> >  endmenu
> >> > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> >> > index 4c63a6c69043..c830fb6e6049 100644
> >> > --- a/drivers/virtio/Makefile
> >> > +++ b/drivers/virtio/Makefile
> >> > @@ -11,3 +11,4 @@ obj-$(CONFIG_VIRTIO_SANDBOX) +=3D virtio_sandbox.o
> >> >  obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> >> >  obj-$(CONFIG_VIRTIO_BLK) +=3D virtio_blk.o
> >> >  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio_rng.o
> >> > +obj-$(CONFIG_VIRTIO_GPU) +=3D virtio_gpu.o
> >> > diff --git a/drivers/virtio/virtio-uclass.c
> >> > b/drivers/virtio/virtio-uclass.c
> >> > index 1dbc1a56aa21..1f3cdbf689c4 100644
> >> > --- a/drivers/virtio/virtio-uclass.c
> >> > +++ b/drivers/virtio/virtio-uclass.c
> >> > @@ -30,6 +30,7 @@ static const char *const
> >> > virtio_drv_name[VIRTIO_ID_MAX_NUM] =3D {
> >> >       [VIRTIO_ID_NET]         =3D VIRTIO_NET_DRV_NAME,
> >> >       [VIRTIO_ID_BLOCK]       =3D VIRTIO_BLK_DRV_NAME,
> >> >       [VIRTIO_ID_RNG]         =3D VIRTIO_RNG_DRV_NAME,
> >> > +     [VIRTIO_ID_GPU]         =3D VIRTIO_GPU_DRV_NAME,
> >> >  };
> >> >
> >> >  int virtio_get_config(struct udevice *vdev, unsigned int offset,
> >> > diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu=
.c
> >> > new file mode 100644
> >> > index 000000000000..0b306bb9d2fa
> >> > --- /dev/null
> >> > +++ b/drivers/virtio/virtio_gpu.c
> >> > @@ -0,0 +1,302 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +/*
> >> > + * Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> > + */
> >> > +
> >> > +#define pr_fmt(fmt) "virtio_gpu: " fmt
> >> > +
> >> > +#include <dm.h>
> >> > +#include <log.h>
> >> > +#include <malloc.h>
> >> > +#include <video.h>
> >> > +#include <virtio_types.h>
> >> > +#include <virtio.h>
> >> > +#include <virtio_ring.h>
> >> > +#include "virtio_gpu.h"
> >> > +#include <asm/io.h>
> >> > +
> >> > +struct virtio_gpu_priv {
> >> > +     struct virtqueue *vq;
> >> > +     u32 scanout_res_id;
> >> > +     u64 fence_id;
> >> > +     bool in_sync;
> >> > +};
> >> > +
> >> > +static int virtio_gpu_do_req(struct udevice *dev,
> >> > +                          enum virtio_gpu_ctrl_type type,
> >> > +                          void *in, size_t in_size,
> >> > +                          void *out, size_t out_size, bool flush)
> >
> > Please add a function comment
> >
> >> > +{
> >> > +     int ret;
> >> > +     uint len;
> >> > +     struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
> >> > +     struct virtio_sg in_sg;
> >> > +     struct virtio_sg out_sg;
> >> > +     struct virtio_sg *sgs[] =3D { &in_sg, &out_sg };
> >> > +     struct virtio_gpu_ctrl_hdr *ctrl_hdr_in =3D in;
> >> > +     struct virtio_gpu_ctrl_hdr *ctrl_hdr_out =3D out;
> >> > +
> >> > +     ctrl_hdr_in->type =3D cpu_to_virtio32(dev, (u32)type);
> >> > +     if (flush) {
> >> > +             ctrl_hdr_in->flags =3D cpu_to_virtio32(dev, VIRTIO_GPU=
_FLAG_FENCE);
> >> > +             ctrl_hdr_in->fence_id =3D cpu_to_virtio64(dev, priv->f=
ence_id++);
> >> > +     } else {
> >> > +             ctrl_hdr_in->flags =3D 0;
> >> > +             ctrl_hdr_in->fence_id =3D 0;
> >> > +     }
> >> > +     ctrl_hdr_in->ctx_id =3D 0;
> >> > +     ctrl_hdr_in->ring_idx =3D 0;
> >> > +     in_sg.addr =3D in;
> >> > +     in_sg.length =3D in_size;
> >> > +     out_sg.addr =3D out;
> >> > +     out_sg.length =3D out_size;
> >> > +
> >> > +     ret =3D virtqueue_add(priv->vq, sgs, 1, 1);
> >> > +     if (ret) {
> >> > +             log_debug("virtqueue_add failed %d\n", ret);
> >> > +             return ret;
> >> > +     }
> >> > +     virtqueue_kick(priv->vq);
> >> > +
> >> > +     debug("wait...");
> >> > +     while (!virtqueue_get_buf(priv->vq, &len))
> >> > +             ;
> >> > +     debug("done\n");
> >> > +
> >> > +     if (out_size !=3D len) {
> >> > +             log_debug("Invalid response size %d, expected %d\n",
> >> > +                       len, (uint)out_size);
> >> > +     }
> >> > +
> >> > +     return virtio32_to_cpu(dev, ctrl_hdr_out->type);
> >> > +}
> >> > +
> >> > +static int virtio_gpu_probe(struct udevice *dev)
> >> > +{
> >> > +     struct virtio_gpu_priv *priv =3D dev_get_priv(dev);
> >> > +     struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> >> > +     struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
> >> > +     struct virtio_gpu_ctrl_hdr ctrl_hdr_in;
> >> > +     struct virtio_gpu_ctrl_hdr ctrl_hdr_out;
> >> > +     struct virtio_gpu_resp_display_info *disp_info_out;
> >> > +     struct virtio_gpu_display_one *disp;
> >> > +     struct virtio_gpu_resource_create_2d *res_create_2d_in;
> >> > +     void *res_buf_in;
> >> > +     struct virtio_gpu_resource_attach_backing *res_attach_backing_=
in;
> >> > +     struct virtio_gpu_mem_entry *mem_entry;
> >> > +     struct virtio_gpu_set_scanout *set_scanout_in;
> >> > +     unsigned int scanout_mask =3D 0;
> >> > +     int ret, i;
> >> > +
> >> > +     if (!plat->base) {
> >> > +             log_warning("No framebuffer allocated\n");
> >> > +             return -EINVAL;
> >> > +     }
> >> > +
> >> > +     ret =3D virtio_find_vqs(dev, 1, &priv->vq);
> >> > +     if (ret < 0) {
> >> > +             log_warning("virtio_find_vqs failed\n");
> >> > +             return ret;
> >> > +     }
> >> > +
> >> > +     disp_info_out =3D malloc(sizeof(struct virtio_gpu_resp_display=
_info));
> >> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_GET_DISPLAY_INFO=
,
> >> > &ctrl_hdr_in,
> >> > +                             sizeof(struct virtio_gpu_ctrl_hdr), di=
sp_info_out,
> >> > +                             sizeof(struct virtio_gpu_resp_display_=
info), false);
> >> > +
> >> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_DISPLAY_INFO) {
> >> > +             log_warning("CMD_GET_DISPLAY_INFO failed %d\n", ret);
> >> > +             ret =3D -EINVAL;
> >> > +             goto out_free_disp;
> >> > +     }
> >> > +
> >> > +     for (i =3D 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
> >> > +             disp =3D &disp_info_out->pmodes[i];
> >> > +             if (!disp->enabled)
> >> > +                     continue;
> >> > +             log_debug("Found available scanout: %d\n", i);
> >> > +             scanout_mask |=3D 1 << i;
> >> > +     }
> >> > +
> >> > +     if (!scanout_mask) {
> >> > +             log_warning("No active scanout found\n");
> >> > +             ret =3D -EINVAL;
> >> > +             goto out_free_disp;
> >> > +     }
> >> > +
> >> > +     free(disp_info_out);
> >> > +     disp_info_out =3D NULL;
> >> > +
> >> > +     /* TODO: We can parse EDID for those info */
> >> > +     uc_priv->xsize =3D CONFIG_VAL(VIRTIO_GPU_SIZE_X);
> >> > +     uc_priv->ysize =3D CONFIG_VAL(VIRTIO_GPU_SIZE_Y);
> >> > +     uc_priv->bpix =3D VIDEO_BPP32;
> >> > +
> >> > +     priv->scanout_res_id =3D 1;
> >> > +     res_create_2d_in =3D malloc(sizeof(struct
> >> > virtio_gpu_resource_create_2d));
> >> > +     res_create_2d_in->resource_id =3D cpu_to_virtio32(dev,
> >> > priv->scanout_res_id);
> >> > +#ifdef __BIG_ENDIAN
> >> > +     res_create_2d_in->format =3D cpu_to_virtio32(dev,
> >> > VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM);
> >> > +#else
> >> > +     res_create_2d_in->format =3D cpu_to_virtio32(dev,
> >> > VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM);
> >> > +#endif
> >> > +     res_create_2d_in->width =3D cpu_to_virtio32(dev, uc_priv->xsiz=
e);
> >> > +     res_create_2d_in->height =3D cpu_to_virtio32(dev, uc_priv->ysi=
ze);
> >> > +
> >> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_CREATE_=
2D,
> >> > res_create_2d_in,
> >> > +                             sizeof(struct virtio_gpu_resource_crea=
te_2d), &ctrl_hdr_out,
> >> > +                             sizeof(struct virtio_gpu_ctrl_hdr), fa=
lse);
> >> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
> >> > +             log_warning("CMD_RESOURCE_CREATE_2D failed %d\n", ret)=
;
> >> > +             ret =3D -EINVAL;
> >> > +             goto out_free_res_create_2d;
> >> > +     }
> >> > +
> >> > +     free(res_create_2d_in);
> >> > +     res_create_2d_in =3D NULL;
> >> > +
> >> > +     res_buf_in =3D malloc(sizeof(struct virtio_gpu_resource_attach=
_backing)
> >> > +
> >> > +                         sizeof(struct virtio_gpu_mem_entry));
> >> > +     res_attach_backing_in =3D res_buf_in;
> >> > +     mem_entry =3D res_buf_in + sizeof(struct
> >> > virtio_gpu_resource_attach_backing);
> >> > +     res_attach_backing_in->resource_id =3D cpu_to_virtio32(dev,
> >> > priv->scanout_res_id);
> >> > +     res_attach_backing_in->nr_entries =3D cpu_to_virtio32(dev, 1);
> >> > +     mem_entry->addr =3D cpu_to_virtio64(dev, virt_to_phys((void
> >> > *)plat->base));
> >> > +     mem_entry->length =3D cpu_to_virtio32(dev, plat->size);
> >> > +     mem_entry->padding =3D 0;
> >> > +
> >> > +     ret =3D virtio_gpu_do_req(dev, VIRTIO_GPU_CMD_RESOURCE_ATTACH_=
BACKING,
> >> > res_buf_in,
> >> > +                             sizeof(struct virtio_gpu_resource_atta=
ch_backing) +
> >> > +                             sizeof(struct virtio_gpu_mem_entry), &=
ctrl_hdr_out,
> >> > +                             sizeof(struct virtio_gpu_ctrl_hdr), fa=
lse);
> >> > +
> >> > +     if (ret !=3D VIRTIO_GPU_RESP_OK_NODATA) {
> >> > +             log_warning("CMD_RESOURCE_ATTACH_BACKING failed %d\n",=
 ret);
> >> > +             ret =3D -EINVAL;
> >> > +             goto out_free_res_buf;
> >> > +     }
> >> > +     free(res_buf_in);
> >> > +     res_buf_in =3D NULL;
> >> > +
> >> > +     set_scanout_in =3D malloc(sizeof(struct virtio_gpu_set_scanout=
));
> >
> > Could these structs be inside priv instead of allocating each one?
>
> Those structs are all used only once at initialization.
>
> We can save some runtime memory by freeing them here :-)

Then you can just use a local var.

>
> >
> >> > +     while (scanout_mask) {
> >> > +             u32 active_scanout =3D ffs(scanout_mask) - 1;
> >> > +
> >> > +             set_scanout_in->r.x =3D 0;
> >> > +             set_scanout_in->r.y =3D 0;
> >> > +             set_scanout_in->r.width =3D cpu_to_virtio32(dev, uc_pr=
iv->xsize);
> >> > +             set_scanout_in->r.height =3D cpu_to_virtio32(dev, uc_p=
riv->ysize);
> >> > +             set_scanout_in->scanout_id =3D cpu_to_virtio32(dev, ac=
tive_scanout);
> >> > +             set_scanout_in->resource_id =3D cpu_to_virtio32(dev,
> >> > priv->scanout_res_id);
> >> > +

[..]

> >> > +/* data passed in the cursor vq */
> >> > +
> >> > +struct virtio_gpu_cursor_pos {
> >> > +     __le32 scanout_id;
> >> > +     __le32 x;
> >> > +     __le32 y;
> >> > +     __le32 padding;
> >> > +};
> >> > +
> >> > +/* VIRTIO_GPU_CMD_UPDATE_CURSOR, VIRTIO_GPU_CMD_MOVE_CURSOR */
> >> > +struct virtio_gpu_update_cursor {
> >> > +     struct virtio_gpu_ctrl_hdr hdr;
> >> > +     struct virtio_gpu_cursor_pos pos;  /* update & move */
> >> > +     __le32 resource_id;           /* update only */
> >> > +     __le32 hot_x;                 /* update only */
> >> > +     __le32 hot_y;                 /* update only */
> >> > +     __le32 padding;
> >> > +};
> >> > +
> >> > +/* data passed in the control vq, 2d related */
> >
> > But there are no comments so we don't know what these structs are for
> > or what the fields do. Can you add documentation, or a pointer to
> > somewhere where it exists?
>
> The whole header is copied from Linux kernel so I=E2=80=99m not really su=
re if we want to edit it.
>
> Maybe I can mention about the specification at start of the driver code?

Yes that would help.

I thought Linux's aversion to comments had softened a little?

Regards,
Simon
