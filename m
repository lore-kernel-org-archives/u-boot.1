Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACDFEDB7EC
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 10:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C5F83A41;
	Tue,  7 Apr 2026 12:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="AJYcmNd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1279F83F98; Tue,  7 Apr 2026 12:17:45 +0200 (CEST)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2D18352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1279eced0b9so5629572c88.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 03:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775557060; cv=none;
 d=google.com; s=arc-20240605;
 b=O8F0x6B4nFIsom0OGs5gz2Y3D4qEQm3dOaZuyg4cv9BM7MCNoiu9gIDmrCgwfUlLmq
 jBCmlzbngwXKC4yzjvQ0zK4NXclRBtre7ABb2pHGBq2IQraQz2bm7N1yXff+kw8rIhZD
 CN0Ikgf285QCH/vAPbPocFb6JZMy3UIGDZ4zYy7+iwmBuvHPK/3MksiBptvx/Gcf+WRS
 NlKR800X+i7/SjvEn9/hVMUqYxK1nmgW5oJUdf6Se+sZDKwqhqkGaed+xqttgvgtp4ui
 Ixh0bqW/63m2MMAIf8mr7EwzXqdhHQwIqEN8wqZc1T6lmZaIKiFt2DKPEn2WdAUvLmPR
 T4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wrQe5oHNvMzH/J0CM9OxjvZDkKEjQn+KFSDtTr5Zjrc=;
 fh=iG9b5sHGu6FrKjVKxRyiQzV0om5tLq7uTHSsMP33bRI=;
 b=UL9rBjOE7N/eTLNpbvn6XMU7GL7M145Kqae8jTCOLllKUK4hfLdu7Gx1YMT7dirN2t
 poSWRdlHQJAKfgPRQXVTPqDQ02YmudSL6xgaK2jzuGrcjkvZT/O8FfKlfMisbJ4r/hj0
 Kb2QnAnCDuY4rSWC28O94hIR89ZiuX3g7refk94zkPDFzog8/+USeJ+Ti4OKG1lfHLSA
 Zrx4eLzbj7lrwGyQ35r0XN8Xvk1JNdjouIyp8HsoqhWSb0oqUl7aAjv2jaYD6+nQEcHX
 Sy1Cmim7M4AtszsnMbRiGbwUyVINxfBpBTOQjzAA0ojk7vUTcSEy5UsdxwQnQidh8iE/
 2psg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775557060; x=1776161860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wrQe5oHNvMzH/J0CM9OxjvZDkKEjQn+KFSDtTr5Zjrc=;
 b=AJYcmNd+xEwxwhuGizRZZZenjjhhjqDXnJyjQbjyrmOqN07IH2MfKOa71spFL6n0q/
 7zNdu0BbGQPJ3hbpCGeU1gWIqQSlSULPlJeBmDsPT8VUwjcV4MP3WWdK0OE8WeeDTEF6
 WCdHb96SxnZiXiIwcEHwq7+G8qEwu2Sa5MEmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775557060; x=1776161860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrQe5oHNvMzH/J0CM9OxjvZDkKEjQn+KFSDtTr5Zjrc=;
 b=U3Rn8austBmVhUHqpa9OXOr7xY8tPQo6pTKRhFWxjL7NuuLEETRANY0YtiXY8tYQLE
 CeuQPsotTygGToxa7kNPxr0BnEd3UzyD3zFtu20aPj+Le2bu0BGszBMsA5TzSZliKpCW
 Z1AOj25EbbB27T9rUrjfugTCVpRQ+JONZyslyCQF1VXGttcWIbAzKwOd5jPws0KYKaMg
 4DEXQ6pPCJiq01GCmkYueC4yegyfj29H78KmS3Uscf88pzrKmBTuW7LxZPykV/bIP7Zn
 CMkqO1gr7Ain8SmvTYziU9RXwiHW0+cKn1QXTsfwofYyHMzMeD1l1Mv87JsYDBqyQF47
 WHtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKm5egXRGNsqK3I14K9nvPePUNHLshGFlE0YN30scmcIsgKo+m6IuAr/Yc86vkVCdMZopYOS8=@lists.denx.de
X-Gm-Message-State: AOJu0YxKm7HSNDiyQzkJx3GvMOn9oirK75Fb99DDid7vB7A2MGIhpYik
 8N+cF5qk7X39wuy7bIdZG77wUwBf8qe6yJGgM5MPZR6PHrFfd9pNr4sTXlYiTrpeQZd9CyA3DRO
 VPyFQBIZFY/vqxDhm3ww1LZus06/X8RxGTLXcwZ/ORQ==
X-Gm-Gg: AeBDievtc3IHAXeh/42Uc/BO+pLpfByaMXOMDxEQWFEnf2YlDk/VFC8ypxmpZV3XdwH
 vy49A/y5l5Fstb7oIRf1l66XwayYKnekZAC637dht1nqbbV7mMV8nyZPggnEj8JNMT3992f/pEe
 yle37l1FYQTaCiHt6/W5jqK5P9IUpLsilRyJQcKLHue1rKHFFe3xFrrXLfmm1dj+T0MJde4BbWv
 wNx2VUAMYBqbhhJu2ob+rb/o2ca45VSPZ0NmyZi7kE3pRK53fRPb6udn7g8lnuNNe1xZAUfle7c
 7N6P
X-Received: by 2002:a05:7022:49d:b0:12b:ed30:5a32 with SMTP id
 a92af1059eb24-12bfb6e7d5cmr6643968c88.5.1775557059779; Tue, 07 Apr 2026
 03:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260407094900.420176-1-visitorckw@gmail.com>
In-Reply-To: <20260407094900.420176-1-visitorckw@gmail.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 7 Apr 2026 19:17:28 +0900
X-Gm-Features: AQROBzDZVLJPUKIGeFifUYQI6hUZkp7iFGq1ogrBuj4IYEgOzMepFxOsET4n9fU
Message-ID: <CAFr9PX=zVHFmREtduEv_DVLieoLkKL9oSo=MrFL+NcBVgaEt7g@mail.gmail.com>
Subject: Re: [PATCH] virtio: mmio: Return error codes on probe failures
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: bmeng.cn@gmail.com, trini@konsulko.com, tuomas.tynkkynen@iki.fi, 
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Tue, 7 Apr 2026 at 18:49, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Currently, virtio_mmio_probe() returns 0 when it encounters an invalid
> magic value, an unsupported version, or a dummy device (ID 0). In
> U-Boot's driver model, returning 0 indicates a successful probe. This
> causes the system to incorrectly register and activate invalid or
> placeholder devices, potentially leading to undefined behavior or
> crashes later on.
>
> Update the probe function to return appropriate error codes (-ENODEV
> for invalid magic values and dummy devices, and -ENXIO for unsupported
> versions). This fix correctly instructs the DM to abort the binding
> process.
>
> Fixes: fdc4aca89ecb ("virtio: Add virtio over mmio transport driver")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/virtio/virtio_mmio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1cd737aca24..62afe609ec0 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -354,7 +354,7 @@ static int virtio_mmio_probe(struct udevice *udev)
>         magic = readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
>         if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>                 debug("(%s): wrong magic value 0x%08x!\n", udev->name, magic);
> -               return 0;
> +               return -ENODEV;
>         }
>
>         /* Check device version */
> @@ -362,7 +362,7 @@ static int virtio_mmio_probe(struct udevice *udev)
>         if (priv->version < 1 || priv->version > 2) {
>                 debug("(%s): version %d not supported!\n",
>                       udev->name, priv->version);
> -               return 0;
> +               return -ENXIO;
>         }
>
>         /* Check device ID */
> @@ -372,7 +372,7 @@ static int virtio_mmio_probe(struct udevice *udev)
>                  * virtio-mmio device with an ID 0 is a (dummy) placeholder
>                  * with no function. End probing now with no error reported.
>                  */
> -               return 0;
> +               return -ENODEV;
>         }
>         uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
>
> --
> 2.53.0.1213.gd9a14994de-goog
>

I'm surprised I didn't notice this when working out the endian issues on m68k.
I have build/boot tested on m68k and the change looks correct to me.

Since I'm not the maintainer for this thing I guess:

Acked-by: Daniel Palmer <daniel@thingy.jp>
