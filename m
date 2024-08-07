Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17939C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A735788D36;
	Wed,  7 Aug 2024 16:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bg4+yIYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F09B488A5F; Wed,  7 Aug 2024 16:36:40 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA39788D24
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7a36f26f3so8468476d6.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041398; x=1723646198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iP9wLPkBpK8lCjPXL+7/++YdoSFu6RJff23pXN8rSkQ=;
 b=bg4+yIYTTa3jZON7UkovEVwkKA7+XedGjj0RUcD162+7lr5HcoDJLtJJAd3ZoX6Hkq
 wYIrSE5SvY02mo2SNNMP4pPJLJXXuoyFgf5X2xFcZkWFGVo1GjHObr3fvvy+s45Domzz
 FTS0xyXfXo/8Z0cRXxosKmeAh19ZF1fFA3Q9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041398; x=1723646198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iP9wLPkBpK8lCjPXL+7/++YdoSFu6RJff23pXN8rSkQ=;
 b=DuYyhC7Dijj7LsaxXXnSY1lM2oEBauv/CNrWQBGcGBL70xiD1CORU0WASGY2hjWGGz
 onmSa587UtYpED5UJS+ZIQOBYUNdnSKXjgp2R13XbRW8ecgdNxagx+nLgpTTghQL3kL6
 K8YoacNXgU7ALxkz4fBngthT2m5QqXs3DtQC0FWhiy9F+UpgtZwiBVFHNr3z7bfPImg1
 kirZfnqromRJVLhlCYQLtlbA06QvncGapThyIg+LRQ9mPbWTAoYYPhcSpcSbMT9uAvLi
 l5Dxp/RM5CW0+mU4bd0RogFr7+XBGWQrLFvJ3nigfR3W/h40s/tU7lPak+d0du86bFja
 muDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXwMgpc6Gc+XGKLvnOWaP3J+bWGQqajYy8IU9EyRGEwCm8D24c8nXWXPFEygFLUrC7U8CFUo6q8lU6wL9aPizXyI3v+g==
X-Gm-Message-State: AOJu0YxmC1/tlxRCcM+YGoIB1ODuVIgk2wmE19wIAbK4x8uiShpNyOUY
 GCyi4mlHYSYK+s17EYY0mEUJ1YDsILQYZQMCQbuNFTsfvLjd4awbU78ihjl/BTZuoWwn+ZjdOHT
 7kOhY0PIMpmpvy9q9fawJx/eitx4Vw7S8EiDw
X-Google-Smtp-Source: AGHT+IH6SrXddPbxhS6/q00AL2Q9ybqllJweTHyuCzQWCUBXiZBJhqOq8ruWknJs1NbhcTMBZ+QZyDm3VtU2yE5M8jY=
X-Received: by 2002:a05:6214:164a:b0:6b7:9a53:70e9 with SMTP id
 6a1803df08f44-6bbbbe7bee0mr45089976d6.17.1723041397731; Wed, 07 Aug 2024
 07:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:27 -0600
Message-ID: <CAFLszTjw=WEQsPdxoxjdZ980Vq4wvb1tuvFnevOiVBZNARGGJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: set correct block device name in
 set_efi_bootdev()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Tue, 6 Aug 2024 at 18:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For SATA devices the class name is 'ahci' but the block device name is
> 'sata'.
>
> Use function blk_get_uclass_name() to retrieve the correct string.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootmeth_efi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Hmm I suppose I need to do another round to try to get rid of
blk_desc->uclass_id


> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 39232eb2e25..6b41c0999f1 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -100,11 +100,10 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
>         if (last_slash)
>                 *last_slash = '\0';
>
> -       log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> -                 dev_get_uclass_name(media_dev), devnum_str, bflow->fname,
> -                 bflow->buf, size);
>         dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
> -                "usb" : dev_get_uclass_name(media_dev);
> +                "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
> +       log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> +                 dev_name, devnum_str, bflow->fname, bflow->buf, size);
>         efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
>  }
>
> --
> 2.45.2
>
