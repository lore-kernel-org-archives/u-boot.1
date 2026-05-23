Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4C7CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D7A846DF;
	Sat, 23 May 2026 11:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hEAVrvnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C127B847B0; Sat, 23 May 2026 11:31:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F35846AD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd01481e592so1140118066b.2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779528701; cv=none;
 d=google.com; s=arc-20240605;
 b=lPIzBTlnxNZ5w9jj+ow0DYTwbqaMwZZ1mN8tST8z1efTdnJPWy30NvR6ADnl4PyS1f
 yke9j5Y0Nb1GOPS4fItn03AnOmzD/n/lmPM4alV7ZkXYL01hl4qD3KotzNvnkuoI3K0C
 osTQOYZVX25fA8cqUn0QP+TjlMzr3Ux0goiRucBwzz815/R2rqZTpZ2qKqAYCPA2USXR
 ZT/TEaU/yvwSRHZX0RhmthMIYd1YP87MvhgGXZ5KZFX4g/OIdXTAxaO4p8lPUQ7Ejg9J
 cAkWFSuqEYGOPp9q1o5CGOcg8c6BZqd+wZvyFAA5g/s4IFILxi6GUqGbkxeTzlioEq00
 T6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eKSdX4huSX8G1GxdgN1Q/97r5CMQa613YQ/f5AcH61g=;
 fh=1cSkRAOARcU9FB7AcUb0psUnrTlnFZDewL9KK71/Jjk=;
 b=MercJYpC0YUU/RFP71GiWi3XLsLBLE9bo5aiFTMaShXpwjYYjw4zjhtlMuR/0EjEj/
 Hy00Gmtiiz+5qI/+Hf/uAt8am4gKrLbtwh2hZ/wZcaV1Wez/ttwWE8RF6NiTVM+Cfe0o
 /iACogsCorkqWessznUkEkvO/tAdVCYmqKQoeswCLEzNY2TmhmUh9X98DjV8e2IYjU14
 sgQcgcfdsy6vogAILPtid0ZyfqdSTAuAY+TF+bX1x2SLOThfBkqfGPASdPdN6N/NDPnI
 sCqHsd2e6GBxwAz3b9rKIxAePNlTBovYqnNe2lFvH7r1bcyJp7lA7MrSSZ9/LcPEF6uB
 4mQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779528701; x=1780133501; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKSdX4huSX8G1GxdgN1Q/97r5CMQa613YQ/f5AcH61g=;
 b=hEAVrvnHZSU5nRmNnZ1OKCy8jD4mLXgXlEyVRfW3FcrePKAbZ8TNy414AzKnR/Zmka
 pd+A6LYUsdFH+FoUQbv/2sk0gnDhJwFiWFlG1ZC+p+8BGPg07ZNVUbfvg7PJQs25+Zcm
 /lxFLBe3CAFwsVZvOFx0k4qtut9bRvbTP//lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779528701; x=1780133501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKSdX4huSX8G1GxdgN1Q/97r5CMQa613YQ/f5AcH61g=;
 b=cYngtKpqPR3MaDo7wu4XozNZ9/eEeBeMwtxBdi1Yc1+eBHdUTJDoEda5CWgIH5B6h9
 DXVCoThWdNwRWL/hb6BYPUhfqyvbRiA0RpxCKA7QE5ij/bJd07t0e4ZFijF11TDIvTZg
 iEH/2Lml0altqS5rSGbi0WsxIbfP/Lc1dvJGpRirsZJdvdqK1ubO/5NMBj9Jg/z3NGOc
 xOuzgluAy7O6cjgUAx+cL4yk25xjmStkE9T8LfhbyXXgI7ihH6rP5HaKCOBcphkU5lb5
 9GYJ6gaSCA30OBl8jmtvrW8Ys8cNXeUojXnBv1tXp1j8u+D6sm/qpkQtqdDjtTV1L8pn
 uC7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UI6sUoSB8GYpo8hcFanh2PF8JSwf9eW517QtKC+yqpQwbQOsCuW8X4U3GWrGqEWhCP0nlEcI=@lists.denx.de
X-Gm-Message-State: AOJu0YxJEiVt5A+SWl+Sbbnw7wbimzw1n030p9h6W81gNYFoGwsyrE1R
 OmPR03eRzJUR7Dq8uwcMDo8LbiSoa+vqQrBrQEpX9U7geia/35gYAMtr2Rfgyz3Y7llZpNgJaYg
 NH1Yn4pxmZu+mcjSEBeasy/XGeLbQKJ/aQ+PEz/mr
X-Gm-Gg: Acq92OF+3C5Z0Rf5c7FBySwjz/agSpS1YR0GUbkKZ62cXiXXI3MXjcXE4ItRM5mW+Xa
 CnpT/4gDt7MC4gc3dPrTX41/B19z5urmH2AuHZzU2BPyqDmTQxogdgWuK1RmYy0BWfNwR3Gn+7H
 MRCQ320/UqwVx9t64olps++DpwaSxDRpQwOItJpF05zZUUzAyLqhDE3lXbg8Mcfqk/hw0rmzNRM
 gYHlT1pxfQxWUjNDGohegRq0PMZ7G2gXCiFid3zGFcqdVZwrqWCiCbRfOxC7pGpxvrSfMz1yD5f
 Ce1eEA==
X-Received: by 2002:a17:907:b06:b0:bdb:a519:5677 with SMTP id
 a640c23a62f3a-bdd22f30890mr290244866b.16.1779528701063; Sat, 23 May 2026
 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260523055000.1059981-1-daniel@thingy.jp>
In-Reply-To: <20260523055000.1059981-1-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:31:29 -0600
X-Gm-Features: AVHnY4IYkqI-u3PgIsrxl42l4QkizN1vY2YV5mdY4b4Za1u325ORj9sriluFYbA
Message-ID: <CAFLszTja_a9Xfzt=bt0==TUBJvdA3peC7jY2ij9xTky=2ptERg@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio: Add driver for virtio gpu
To: daniel@thingy.jp
Cc: bmeng.cn@gmail.com, sjg@chromium.org, visitorckw@gmail.com, 
 u-boot@lists.denx.de
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

Hi Daniel,

On 2026-05-23T05:50:00, Daniel Palmer <daniel@thingy.jp> wrote:
> virtio: Add driver for virtio gpu
>
> Add a basic driver for virtio gpu. This allows for a video on
> qemu virt machines.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/virtio/Kconfig         |  19 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_gpu.c    | 284 +++++++++++++++++++++++++
>  drivers/virtio/virtio_gpu.h    | 461 +++++++++++++++++++++++++++++++++++=
++++++
>  include/virtio.h               |  10 +-
>  6 files changed, 772 insertions(+), 4 deletions(-)

Thanks for doing this!

> diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu.c
> @@ -0,0 +1,284 @@
> +U_BOOT_DRIVER(virtio_gpu) =3D {
> +     .name      =3D VIRTIO_GPU_DRV_NAME,
> +     .id        =3D UCLASS_VIDEO,
> +     .ops       =3D &virtio_gpu_ops,
> +     .probe     =3D virtio_gpu_probe,
> +     .flags     =3D DM_FLAG_ACTIVE_DMA,
> +     .priv_auto =3D sizeof(struct virtio_gpu_priv),
> +};

Two things are missing here per doc/develop/driver-model/virtio.rst

- a bind() that calls virtio_driver_features_init() for feature negotiation
- a '.remove =3D virtio_reset' so the device is reset before jumping to
the OS; without it the host may keep scanning out of a buffer U-Boot
has freed.

> diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu.c
> @@ -0,0 +1,284 @@
> +     /* virtio GPU apparently doesn't care about alignment */
> +     plat->size =3D (width * height) * 4;
> +     plat->base =3D (ulong)malloc(plat->size);
> +     if (!plat->base)
> +             return -ENOMEM;
> +
> +     ret =3D virtio_gpu_resource_attach_backing(vq,
> +                                              FRAMEBUFFER_RESOURCE_ID,
> +                                              plat->base,
> +                                              round_up(plat->size, 4096)=
);

The length advertised to the host is round_up(plat->size, 4096) but
only plat->size bytes are allocated, so the host may read past the
end. Allocate the rounded-up size or pass plat->size

More fundamentally, video drivers declare plat->size (and plat->align
if needed) in bind(), and video_reserve() places the framebuffer in
the reserved region below the U-Boot relocation address - see
drivers/video/bochs.c for the standard pattern. So you should not need
the malloc() in probe() ?

> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> @@ -77,4 +77,23 @@ config VIRTIO_RNG
> +if VIRTIO_GPU
> +config VIRTIO_DEFAULT_WIDTH
> +     int "default width"
> +     default 1024
> +
> +config VIRTIO_DEFAULT_HEIGHT
> +     int "default height"
> +     default 768
> +endif

These sit in the VIRTIO namespace but are GPU-specific - please rename
to VIRTIO_GPU_DEFAULT_WIDTH / VIRTIO_GPU_DEFAULT_HEIGHT

The prompts also do not say what they configure; something like
'Default framebuffer width' would be clearer. BTW, are these ever
used?

> diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * virtio GPU driver
> + * 2025 Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <dm.h>
> +#include <malloc.h>
> +#include <video.h>
> +#include <virtio_types.h>
> +#include <virtio.h>
> +#include <virtio_ring.h>

Please add #define LOG_CATEGORY UCLASS_VIRTIO at the top - also good
to use log_msg_ret() / log_debug() on the error paths. Several
goto-err paths currently swallow the error silently.

> diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu.c
> @@ -0,0 +1,284 @@
> +     while (!virtqueue_get_buf(vq, NULL))
> +             ;
> +
> +     /* Some basic error handling */
> +     switch (le32_to_cpu(resp_hdr->type)) {
> +     case VIRTIO_GPU_RESP_ERR_UNSPEC:
> +     case VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID:
> +     case VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID:
> +     case VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID:
> +     case VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER:
> +             return -EINVAL;
> +     case VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY:
> +             return -ENOMEM;
> +     }
> +
> +     return 0;

This returns success for any response not in the listed error codes,
so a future spec error (or garbage) is silently treated as OK. Please
invert the check =E2=80=94 require resp_hdr->type to be one of
VIRTIO_GPU_RESP_OK_* and return -EIO otherwise.

> diff --git a/drivers/virtio/virtio_gpu.c b/drivers/virtio/virtio_gpu.c
> @@ -0,0 +1,284 @@
> +    virtio: Add driver for virtio gpu
> +
> +    Add a basic driver for virtio gpu. This allows for a video on
> +    qemu virt machines.
> +
> +    Signed-off-by: Daniel Palmer <daniel@thingy.jp>

The commit message is thin. Please mention the motivation (no current
display driver works on QEMU virt for arm64/riscv?), what is and isn't
supported (2D only, single scanout, no cursor, no EDID, no feature
negotiation) and how the user enables it. Also 'allows for a video'
reads oddly - perhaps 'enables video output on QEMU virt machines'.

Regards,
Simon
