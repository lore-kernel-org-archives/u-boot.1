Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C95C38150
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 06:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2669886F9;
	Wed, 10 Jul 2024 08:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hK6idTkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6669388700; Wed, 10 Jul 2024 08:53:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220DA886F1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 08:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720594405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtbYCdTT+mRuL9Fw+Q7XpJDbYBClCFnETr+9hapaMrE=;
 b=hK6idTkTq/HgKxxbUmpXLDXS4pyHBNaeByJBAPrwFu8W34rLcVhfJ3c0JKzCuevTmVp7jb
 ztBe8d4wRrHKKARJ9SYSHFBu6d51js/kafqf47RMJm/GVLKkeqswNvTodsvtu7tHnqE/Ab
 YfMKZ2F6SYRvOM8U7LfVYv/0Q35xJ80=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-xsK_m3nWMgeqJUUle_O0VQ-1; Wed, 10 Jul 2024 02:53:23 -0400
X-MC-Unique: xsK_m3nWMgeqJUUle_O0VQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5c7b7c50028so136952eaf.1
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 23:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720594402; x=1721199202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtbYCdTT+mRuL9Fw+Q7XpJDbYBClCFnETr+9hapaMrE=;
 b=ectLvp1cD0DnIi6fJ3Pc+zTyqCzBYiIDcRyvoV2Qw6oIlkazJNuWRsvUfRmB8TIKXb
 ilTelrt2oeV10Plw52VGfNFDE5Ztmkt0wa0/bO0behezMYQrOEYM7jdtraE2l2Wbp5Ht
 pCsjkUYqWSfwvVVIP37FvrqPp4+hMdbw3kz5B1+YKRVJsghCuvnK3VpxB2y80CMDGgBj
 GIWSNmuudLd5QgLc3Mzsj5W7gzs3uEFHULK0Qbwp18kkMDCIbd7FWLPt5CDp2QHScbfa
 hKIqzIenP6ZLR1NUPPbLvgq7Zh46AeQBMzpkiuORFTL5BJZ5rVHKIkbwRhD7SuiMBBKM
 4+Gw==
X-Gm-Message-State: AOJu0YwktFUx3ig0+9zuIaD6ST7aA+ViYBZUVlGGmNo1nvsk4DZTbIQH
 M721XmP3i2sfUYJOhG00Rn+/awCnLIgnDxdY0y8MmA2nI9rxFi6OueePDYE6gPdkp8FcSjIupKs
 g5Rki89xE4mfAWxDiFEUoUNFwRWRj0Xpevql88JM3/G9gYfGJWMxWbzEaQMnPqg5MrhmnTZD2/L
 Y8rS+gNt4VWik1NByhvJ5J8EBGbQ==
X-Received: by 2002:a05:6870:288e:b0:25e:1e11:aa4b with SMTP id
 586e51a60fabf-25eaec16b2dmr4195623fac.46.1720594402257; 
 Tue, 09 Jul 2024 23:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExSIYGFfJhVqnMywyzabEXXaKL5JHvyasR+sl5sBa9N2F9GyMTUU+o3QVHNh6ygbo4GYaPld/HZ9UkhDDwAco=
X-Received: by 2002:a05:6870:288e:b0:25e:1e11:aa4b with SMTP id
 586e51a60fabf-25eaec16b2dmr4195611fac.46.1720594401968; Tue, 09 Jul 2024
 23:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240628231707.195389-1-javier@dowhile0.org>
In-Reply-To: <20240628231707.195389-1-javier@dowhile0.org>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 10 Jul 2024 08:53:11 +0200
Message-ID: <CALE0LRua-obPE0_cPPUmYfj7GFv2JsJ8UHGMSxUOhB1v9AAP1g@mail.gmail.com>
Subject: Re: [PATCH] omap3: igep0x00: Switch to the I2C driver model
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: u-boot@lists.denx.de, Javier Martinez Canillas <javierm@redhat.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

Hi Javier,

Many thanks for still maintaining this.


On Sat, Jun 29, 2024 at 1:17=E2=80=AFAM Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> From: Javier Martinez Canillas <javierm@redhat.com>
>
> When building with the igep00x0_defconfig, the following warning is shown=
:
>
>   $ make -j $(nproc)
>   ...
>     LD      spl/u-boot-spl
>     OBJCOPY spl/u-boot-spl-nodtb.bin
>     SYM     spl/u-boot-spl.sym
>     CAT     spl/u-boot-spl-dtb.bin
>     COPY    spl/u-boot-spl.bin
>     MKIMAGE MLO
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   This board does not use CONFIG_DM_I2C (Driver Model
>   for I2C drivers). Please update the board to use
>   CONFIG_DM_I2C before the v2022.04 release. Failure to
>   update by the deadline may result in board removal.
>   See doc/develop/driver-model/migration.rst for more info.
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> The only reason why I2C is enabled for the IGEP boards is that the TWL403=
0
> driver requires it.
>
> But both the TWL4034 and the OMAP I2C controller drivers were converted t=
o
> the driver model by commits daa69ffe3d4d ("drivers: i2c: omap24xx_i2c:
> adopt omap_i2c driver to driver model") and fb1b7712ad3f power: make most
> tps drivers and the twl4030 driver compatible with DM_I2C") respectively.
>
> So there's no reason anymore to keep using the I2C legacy API and instead
> the DM_I2C option could just be enabled.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

The changes looks good to me so:

Reviewed-by: Enric Balletbo i Serra <eballetbo@gmail.com>


> ---
>
>  configs/igep00x0_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
> index 87fd2797eace..473891607b0f 100644
> --- a/configs/igep00x0_defconfig
> +++ b/configs/igep00x0_defconfig
> @@ -68,8 +68,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_VERSION_VARIABLE=3Dy
>  # CONFIG_NET is not set
>  CONFIG_SPL_DM=3Dy
> -CONFIG_SYS_I2C_LEGACY=3Dy
> -CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=3Dy
>  CONFIG_MMC_OMAP_HS=3Dy
>  CONFIG_MTD=3Dy
>  CONFIG_SYS_MTDPARTS_RUNTIME=3Dy
> --
> 2.45.2
>

