Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7D0C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 12:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247CF8725C;
	Fri, 10 Nov 2023 13:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OPqyj/bJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304868747E; Fri, 10 Nov 2023 13:54:19 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F8C871A2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9dd3f4a0f5aso333340366b.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 04:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699620856; x=1700225656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8N+fvzXXpk+7+mXF4R2BWrnLOaZvbG5wlFVepY1h9/U=;
 b=OPqyj/bJuCHHT8E03vMSCtkPxavLhGvH4ndk4ZpZF39lSA0vlZPBXTcY83H0u5VXjX
 y1VurVxkeJONkcms2O25VUPE7QGkQ2hosda40Nt0EiHBvc8duHvV9ZXATs+P9jJR37uy
 uYD0u1tsub8XD3OM8DFbiSyAm0p6YH93Frpmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699620856; x=1700225656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8N+fvzXXpk+7+mXF4R2BWrnLOaZvbG5wlFVepY1h9/U=;
 b=FVKmI+J7+5Hazur2S2edvGdM6/YVxWx9fne2QW/GrSr/kf95nhwebtSCoNH0gCeM5l
 4bPoAuyo13C6rV+VdQaNYZttyTwiqxRb6HoayhOvX3d/iSXK2F/T4q2m86aRN6aBo/4B
 DmVnrSbNRKpc+sycTD/YXFmFjDoNNWLE20fHs0nj3UYLGC4fsUDNGKQnD9SoS7HxBLcX
 ISI7iIclaiHxLQYOz+UE3F3CcZA/vw00ZEzHCC4uWtySH5bdGN1Ixz1GPf5mMV5Xypxm
 6lWlI9ye4gDvABgRAoiDX7Lbom+ghCLUMUB1e+TULn5l+F8NQMF5X/18H86X7auV0pP9
 nWAA==
X-Gm-Message-State: AOJu0YzYgXyLQ40+yy9UZ2SptCsJ7vgOQEpi+A/i/6Lr3o3WkIUWLo5E
 9VrYO1yahLomZ29BHaKuJQL/KYoTxhLdT/hHU892Tg==
X-Google-Smtp-Source: AGHT+IF/HAYyT6K9DAZo5477U1DEin5mTCPEUoHuEFnEXGotH3A5ZIIfkHRIYomS5hdKpOosJDs+4nRACBhr6XMBy9c=
X-Received: by 2002:a17:906:2cd3:b0:9e3:fe08:27b1 with SMTP id
 r19-20020a1709062cd300b009e3fe0827b1mr4936069ejr.73.1699620856197; Fri, 10
 Nov 2023 04:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20231107160900.2652813-1-andre.przywara@arm.com>
In-Reply-To: <20231107160900.2652813-1-andre.przywara@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 05:53:59 -0700
Message-ID: <CAPnjgZ1_KVcGvh869p3jvBh6umkwGv_VwFs73Yo3k9BBM54p0w@mail.gmail.com>
Subject: Re: [PATCH] virtio: rng: gracefully handle 0 byte returns
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de, 
 Peter Hoyes <peter.hoyes@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Andre,

On Tue, 7 Nov 2023 at 09:09, Andre Przywara <andre.przywara@arm.com> wrote:
>
> According to the virtio v1.x "entropy device" specification, a virtio-rng
> device is supposed to always return at least one byte of entropy.
> However the virtio v0.9 spec does not mention such a requirement.
>
> The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng always
> returns 8 bytes less of entropy than requested. If 8 bytes or less are
> requested, it will return 0 bytes.
> This behaviour makes U-Boot's virtio_rng_read() implementation go into an
> endless loop, hanging the system.
>
> Work around this problem by always requesting 8 bytes more than needed,
> but only if a previous call to virtqueue_get_buf() returned 0 bytes.
>
> This should never trigger on a v1.x spec compliant implementation, but
> fixes the hang on the Arm FVP.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Peter Hoyes <peter.hoyes@arm.com>
> ---
>  drivers/virtio/virtio_rng.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Unrelated to this patch, but do you know the hardware architecture of
the ARM RNG? Is there one RNG unit per CPU or one for the whole SoC?

>
> diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
> index b85545c2ee5..786359a6e36 100644
> --- a/drivers/virtio/virtio_rng.c
> +++ b/drivers/virtio/virtio_rng.c
> @@ -20,7 +20,7 @@ struct virtio_rng_priv {
>  static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
>  {
>         int ret;
> -       unsigned int rsize;
> +       unsigned int rsize = 1;
>         unsigned char buf[BUFFER_SIZE] __aligned(4);
>         unsigned char *ptr = data;
>         struct virtio_sg sg;
> @@ -29,7 +29,12 @@ static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
>
>         while (len) {
>                 sg.addr = buf;
> -               sg.length = min(len, sizeof(buf));
> +               /*
> +                * Work around implementations which always return 8 bytes
> +                * less than requested, down to 0 bytes, which would
> +                * cause an endless loop otherwise.
> +                */
> +               sg.length = min(rsize ? len : len + 8, sizeof(buf));
>                 sgs[0] = &sg;
>
>                 ret = virtqueue_add(priv->rng_vq, sgs, 0, 1);
> --
> 2.25.1
>

Regards,
Simon
