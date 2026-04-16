Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BFDF8A14D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F03FE84105;
	Thu, 16 Apr 2026 11:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FLRi9X52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D038841C2; Thu, 16 Apr 2026 11:28:45 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 224028407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so5296990b3a.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776331721; x=1776936521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yh8pA8DKrq2HyZuyhZCwfnvvT/wWDWWKL7zbePenvNg=;
 b=FLRi9X52+ly7IBRfQfUAdjFilJHzJZy5vzBVKuZlqxgXY42cSdImCUh6FQ0t5X6+18
 fpomG+fUuLQKG0KymRNcHlvJczqgUOEXTF+bKFIYia+w+4XDhR3yStvMVpSZsAOKJ17h
 uxnhiXZWzAjQdFFOyJDpPeX6fm8TSbTumy8BOAzhtGtnI4DaCV6BzwXSz5AICADU6HJF
 q2nkYI88/q4dVu1MvV4hkSiwasIRayDlfegjNJOPlKERrOUNHkQhtT8+g0+NiqBPWJBF
 Nha6hS/7e+jEyoUo02+et3SX5Kpeq0xJxOuE4s0szGKDdPyXE2aM+WhVrhG/dcMPN7z6
 /ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331721; x=1776936521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yh8pA8DKrq2HyZuyhZCwfnvvT/wWDWWKL7zbePenvNg=;
 b=Au7g3hSMluAum72lLrt0b1Tv1VgxNYPSjBbBAG3Zc27dLvFkhC01TFLl1UGW47ylNR
 yRGdWVB0yKpBkzdruJpiZI++acauPyxgmtgyfYjm0P3Vh47I5r+FJgrcv6YIaU2C81H+
 SE0gq4AREJ/IlJmEF/FmDpNM/V9Y/IjsVqgEjsaNOq1qqr3EHbvEQM/I5JLJ+g1eTXV2
 DujQ91wtDNQLrXNA77qPJXQRelV5yRlG1qEYDYv6l1A/6WhnIHq4aD8/9fC8qAwCCR0S
 6EKLVQodN4+oWil99RcaE6IPohfWm1qA+mMYDPdTI69N4A66gvcU+SLY6ZOao/UlNKi4
 rrtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HzgDk91vgPfnl9yPt/4c2gjOkKdWeP1tG6B2HoUEPxLTOjGIUOMslurzvTyYHiVu2dV9g/iY=@lists.denx.de
X-Gm-Message-State: AOJu0YwHXN3DF019WXZALcelCYfTbGx3aFqDHgsGL4Crgjvo/L93jyU+
 v2WmdffVE3UOz6twXKyB2AwX1CAnUuAeHjWHT595nsOmXSVtIX7pSae0
X-Gm-Gg: AeBDieslElcb1wPuP0Qk27O2d6ozK5sop/g5PyIqqPm1/cH0peyND7hcaaAb4AznPWB
 ab7A8KdNZhX/AmQtQgNlrRAR22UtlJyjlJWGuuax+zYdoj9r36J02JI0sCi1GxsggyuKgRs9KjL
 UexS/f768tEW2qmBfWLHLlqKZmSOgDOu4CTfSlbP5qMrDpV9d0t5iLIs7/bKGoJZzjajsrPGQKC
 5eOncX33qU566BlVnuB1vK7LfmWWjG+VFyWrBozUyu3LLO8pNHqC//cdmWbOEqbIMsYBcbsthlr
 0jP9bInfBfST8MDGo5FLP0Hj5xkd3ZCqvPaEkEJmvBKVgboxXvG2A0VXo1yp4/5rKp0R74IY8J+
 nhTbjERpNaSNmbBj/1ZdPzZQka4IyXxf/YaZ+bsRjhJe/LXYaFIa/Yy0/fJPa5e6mSK+WtTT+f2
 WvOzkWatt94fW6W9uOBPZPHSwkdGz9TD8=
X-Received: by 2002:a05:6a00:1795:b0:82c:ded1:2613 with SMTP id
 d2e1a72fcca58-82f0c15c30emr24796046b3a.14.1776331721566; 
 Thu, 16 Apr 2026 02:28:41 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:6c74:6a92:c2eb:e814])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f6b95f222sm3901253b3a.29.2026.04.16.02.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:28:40 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:28:38 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 5/6] virtio: blk: Fix converting the vendor id to a
 string
Message-ID: <aeCrxhUkO2Wb6tS6@google.com>
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-6-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-6-daniel@thingy.jp>
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

On Mon, Apr 13, 2026 at 06:22:39PM +0900, Daniel Palmer wrote:
> Currently we are trying to work out if the vendor id is from
> a virtio-mmio device and then casting a u32 to a char* and using
> it as a C-string. By chance there is usually a zero after the u32
> and it works.
> 
> Since the vendor id we are trying to convert to a string is QEMU's
> just define a value for the QEMU vendor id, check if the vendor
> id matches and then use a predefined string for "QEMU".
> 
> I don't think we should have been assumming all virtio-mmio vendor
> ids are printable ASCII chars in the first place so do this special
> casing just for QEMU. If the vendor id isn't QEMU print the hex
> value of it.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  drivers/virtio/virtio_blk.c | 11 ++++-------
>  include/virtio.h            |  3 +++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> index 3dd0cf36268b..e70cf6a776b2 100644
> --- a/drivers/virtio/virtio_blk.c
> +++ b/drivers/virtio/virtio_blk.c
> @@ -164,14 +164,11 @@ static int virtio_blk_bind(struct udevice *dev)
>  		return devnum;
>  	desc->devnum = devnum;
>  	desc->part_type = PART_TYPE_UNKNOWN;
> -	/*
> -	 * virtio mmio transport supplies string identification for us,
> -	 * while pci trnasport uses a 2-byte subvendor value.
> -	 */
> -	if (uc_priv->vendor >> 16)
> -		sprintf(desc->vendor, "%s", (char *)&uc_priv->vendor);
> +
> +	if (uc_priv->vendor == VIRTIO_VENDOR_QEMU)
> +		strcpy(desc->vendor, "QEMU");
>  	else
> -		sprintf(desc->vendor, "%04x", uc_priv->vendor);
> +		sprintf(desc->vendor, "%08x", uc_priv->vendor);
>  	desc->bdev = dev;
>  
>  	/* Indicate what driver features we support */
> diff --git a/include/virtio.h b/include/virtio.h
> index 17f894a79e31..3edf023463d7 100644
> --- a/include/virtio.h
> +++ b/include/virtio.h
> @@ -25,6 +25,9 @@
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
>  #include <linux/typecheck.h>
> +
> +#define VIRTIO_VENDOR_QEMU	0x554d4551
> +
>  #define VIRTIO_ID_NET		1 /* virtio net */
>  #define VIRTIO_ID_BLOCK		2 /* virtio block */
>  #define VIRTIO_ID_RNG		4 /* virtio rng */
> -- 
> 2.51.0
> 
