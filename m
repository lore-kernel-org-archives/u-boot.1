Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCABC61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 18:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 007C587626;
	Wed, 22 Nov 2023 19:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRVmkaEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC2787616; Wed, 22 Nov 2023 19:56:53 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A34586DD1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 19:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-548d1f8b388so173677a12.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700679411; x=1701284211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qI9n77HY678YV4rQbX5EWXlpGiPTJulu/yHLaEhWUFQ=;
 b=lRVmkaExTaJK9rJVkPoGaJUxqlDIttVvRoxzmPcXttXekYVHXP/Vc2FZVEaWO1U6C9
 wzEMZEvtmu937OhaRp3fXJ4ibomgJKlWEvZCsjVFO7cICs5z20VjsBHYOcE0DddqT3uA
 EWEbclpz2RkLMx1fPLXVLH3zSmNIHrL7jHOZULbS0FWvgo+pZdYdi2DcviUrbWvZFjXC
 tooAZYkCXrskHIao1J7rp62erjHtX9rDT1qAV02TA/P6bSLoYKAf29oMfEGj+N4mlZ/f
 FY0dSHmVO2j/7aqHXxZebt6VE2NQDvxB5Z891daj2vCFjb9hY0QYC2vqLccjrA9zQ15t
 gpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700679411; x=1701284211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qI9n77HY678YV4rQbX5EWXlpGiPTJulu/yHLaEhWUFQ=;
 b=wdF9a1Ie4TCvdTr92I8725X/WniUbM9gkK3Sg0+jA7T66LE/cUZRt7mQRjmsmfOE4/
 H/zxquMqQXt+A6NBZJd4FVAhx4Y8eK0TWqAyke6fDn6axzjSydiXl78AWhq6awHq+BsB
 0Jz1/eHyQrHBTdJIra0zPUCMdrPE84UjwsGLIIXGhiagGdJn8zH0+d1YXBH9rsrIm0EJ
 +SvMRcX9J0wmC5ohErn5x9v7AnqFwHPqBvxthcovv7fnwTyauRQdphno6mgix28FxuFb
 qoh5G5TuqEq/MxRrDbAA/3Z5ne90x+wPRXX9rqFrwnk7D76L13np2NLO9264vz71Av6U
 tUMw==
X-Gm-Message-State: AOJu0YxsssAmd9EVvzTPijXnfvFUzQuk7CQG7R4cNM3MSwup/rtB0+DI
 cv31/V24q3hsT8WNLJUi9MA6LAGg2SzF9mIPkUw=
X-Google-Smtp-Source: AGHT+IFIojYxNGt63wRHLEWWzOEoXkvq4TWhcIy3rlmm5yh8c+u88yBVPXtS1PNGgch4QC5S8zOgovA6jk3VUZNNmRs=
X-Received: by 2002:a05:6402:64d:b0:548:9374:2928 with SMTP id
 u13-20020a056402064d00b0054893742928mr2589355edx.34.1700679411340; Wed, 22
 Nov 2023 10:56:51 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ3nt3huy9Pt9eesxrKcirBR8aQH5Y8SKsGSbaXmny=_vA@mail.gmail.com>
In-Reply-To: <CAKRNjQ3nt3huy9Pt9eesxrKcirBR8aQH5Y8SKsGSbaXmny=_vA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 18:56:40 +0000
Message-ID: <CALeDE9N23A=YQfHMxB+oprqw5fjMK6xrAWag6z8-ssfUkpd6ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpi5: initial support
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
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

On Tue, Nov 21, 2023 at 10:54=E2=80=AFPM Dmitry Malkin
<dmitry@bedrocksystems.com> wrote:
>
> rpi5: add initial memory map for bcm2712

Could this be the title for the patch, "initial support" is fine for
the cover letter, but doesn't really out line what this specific patch
actually does.

> includes:
> * 1GB of RAM (from 4GB or 8GB total)
> * VPU memory interface
> * SOC range (main peripherals)

Could you include details where this information came from as well please?

> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> ---
> v2:
>       new patch
> ---
>  arch/arm/mach-bcm283x/init.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7265faf6ce..362838e9b9 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -68,6 +68,33 @@ static struct mm_region
> bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
>      }
>  };
>
> +static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
> +    {
> +        .virt =3D 0x00000000UL,
> +        .phys =3D 0x00000000UL,
> +        .size =3D 0x3f800000UL,
> +        .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +             PTE_BLOCK_INNER_SHARE
> +    }, {
> +        .virt =3D 0x3f800000UL,
> +        .phys =3D 0x3f800000UL,
> +        .size =3D 0x00800000UL,
> +        .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +             PTE_BLOCK_NON_SHARE |
> +             PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +    }, {
> +        .virt =3D 0x107c000000UL,
> +        .phys =3D 0x107c000000UL,
> +        .size =3D 0x0004000000UL,
> +        .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +             PTE_BLOCK_NON_SHARE |
> +             PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +    }, {
> +        /* List terminator */
> +        0,
> +    }
> +};
> +
>  struct mm_region *mem_map =3D bcm283x_mem_map;
>
>  /*
> @@ -78,6 +105,7 @@ static const struct udevice_id board_ids[] =3D {
>      { .compatible =3D "brcm,bcm2837", .data =3D (ulong)&bcm283x_mem_map}=
,
>      { .compatible =3D "brcm,bcm2838", .data =3D (ulong)&bcm2711_mem_map}=
,
>      { .compatible =3D "brcm,bcm2711", .data =3D (ulong)&bcm2711_mem_map}=
,
> +    { .compatible =3D "brcm,bcm2712", .data =3D (ulong)&bcm2712_mem_map}=
,
>      { },
>  };
>
> --
> 2.40.1
