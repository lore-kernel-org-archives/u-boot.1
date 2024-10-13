Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BC6CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B17B88FF7;
	Sun, 13 Oct 2024 21:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DUpra8RS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE7A88FFD; Sun, 13 Oct 2024 21:34:03 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5227F88FEE
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso24432326d6.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728848040; x=1729452840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UxECNrFMax8VAoIdyr4JhIvDeQEXbeVRu7CUbDjqCFE=;
 b=DUpra8RSChcrG83AwBVG3ymZppBbTwawGOiojvJPyESuI2nh67vV6OJONKaOcUSfXb
 k2RyGiLcGocQKhbpfHOxGuJZPpY9vsmCgbn74XxEHJ6Z1G2uq93TAvLhT9MQ/XFgyUrY
 Bv5aXIWYwe9SnBTbrkM7/StexBb5rpMPvai/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728848040; x=1729452840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UxECNrFMax8VAoIdyr4JhIvDeQEXbeVRu7CUbDjqCFE=;
 b=QDQuFIWLJ4qXcdqnL5oH6PlEvyP5CZrWp5WJ2PaajTIi49/nOXHOZT6AFvW6D7c6TP
 ZQQ+z5q5a1HrHmzHA/Asiu9y50GHWeICyV/1f+/gtVtMvSdAjXDf3v84kx32NoxPcl2U
 e4fCseLvdziR2jAuspuksKhkRth3mRO6m3ouzgxK5Sf3ZHm+UwJ59KXA36WLz/08gMFn
 pRnhPVBChdO1cE5S1O9sBVA3xrYadFtCe4PJ+hCocMkCUSSdvG/FVq+9yMVkm7qAjfZV
 GPnuOH4wFVCgsyZg2Vyd6MkXyNE2SDaKGwULH1a+IdQOKaVikaKhOjvgh5WTcO0Kl9N+
 QWzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULZ1/zMrFgTfmmS40qMChsxR1u/JRQjeFSeu21M3vLBYcQ62lzLrJ9qjgQiZFaxcTfyF5eWig=@lists.denx.de
X-Gm-Message-State: AOJu0YwXeetNHOYpZJGFLHij+IPfdpOCQUTF12vfc1cCpsXuQy7epw7j
 d7lXVKCLYa38yjF6hj8RBsotKzR8ybDnBYNNdz4GWkwRT4gD/VrfRHl+67DmEeTPodprK2fKnNx
 WrclgHFDGJJQtcCSx+blVWJ6Kr+vDSFpn3exaD/nhLcfPaP8+CQ==
X-Google-Smtp-Source: AGHT+IGdihaKPpw71s9mmqW0OY4az284gt1XW1/yjYWfVPvHdUsVBW8oSBAcoARW5Nc9bukmup88zjQE4tcOUsXYLTA=
X-Received: by 2002:ad4:4501:0:b0:6cb:f561:2a83 with SMTP id
 6a1803df08f44-6cbf5613294mr89101826d6.43.1728848040203; Sun, 13 Oct 2024
 12:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241011170914.1980541-1-pbrobinson@gmail.com>
In-Reply-To: <20241011170914.1980541-1-pbrobinson@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 13 Oct 2024 13:33:48 -0600
Message-ID: <CAFLszTh9ryJNetLVS6Bwe3D1WDhMwvNxd2c4_uJKUmXXK9LXWg@mail.gmail.com>
Subject: Re: [PATCH v2] board: rpi: Pass CMA through from firmware DT
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
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

On Fri, 11 Oct 2024 at 11:09, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> For a lot of usecases, such as display, camera, media
> the Raspberry Pi needs a lot more CMA than distros
> configure as default so we should pass this parameter
> through so things work as expected. Fix a spelling
> mistake while we're at it.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>
> v2: Update the cma string
>
>  board/raspberrypi/rpi/rpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9f..dd5a318d239 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -540,12 +540,15 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>         if (fdt == fw_fdt)
>                 return;
>
> -       /* The firmware provides a more precie model; so copy that */
> +       /* The firmware provides a more precise model; so copy that */
>         copy_property(fdt, fw_fdt, "/", "model");
>
>         /* memory reserve as suggested by the firmware */
>         copy_property(fdt, fw_fdt, "/", "memreserve");
>
> +       /* copy the CMA memory setting from the firmware DT to linux */
> +       copy_property(fdt, fw_fdt, "/reserved-memory/linux,cma", "size");

Does this need / have nodes pointing to it from elsewhere in the tree?

> +
>         /* Adjust dma-ranges for the SD card and PCI bus as they can depend on
>          * the SoC revision
>          */
> --
> 2.47.0
>

Regards,
Simon
