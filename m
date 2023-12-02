Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262DDC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 00:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DBAD8701F;
	Sat,  2 Dec 2023 01:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEFC086F9F; Sat,  2 Dec 2023 01:55:05 +0100 (CET)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA3786F9F
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 01:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-50bc501081fso4053760e87.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 16:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701478502; x=1702083302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9Q0mqrHI60oqqAcl92jZhbzuOKaiPGGNZGxwhtg0Ow=;
 b=tIwpj1tyQ92xwH8WukBuiosXajnZfoAx7xSVBI45FwuTc0wqvM4T+IEneZ0AWfNi/f
 LZ4DOCdGvOiCi4rOy1LMwDNSklSlqNpUFLO61BDS3GDpVEX+cUfcuiPDJ8Zw8qkQfvs4
 +OhNjvLsyMGK+SeahoeGOPKrv6sPqHuOAIJz2OIhHgU/si8+jMAVXuy0Zbr1hf6b76SG
 a+mv4YMyKuvumD84Hf6ANz4lVr6ktUl1CeniQesD9Ez8L4RVQf4HY6WRIV8MDSiIr5OE
 owR48R4zZLW1gDIjCXr9A2qGTs5gJUBp0W7naG0cwaW7BsKWGL6jRccsxPpxip43si3F
 rFOQ==
X-Gm-Message-State: AOJu0YznTWYv5IoX+MSfJVyIbMa283eSsGOFlzox+iT7wIvPDo9lwQEH
 epPNbGmhudqE+Qpr+YZow9IxIX0I8DF1qA==
X-Google-Smtp-Source: AGHT+IG17fI4WkuUoloKdvXSJGmKmm1sF6BS2FjwL0JaE4X5X1eefXL1+FYYBJ7EXdu3n/osfSQ4FA==
X-Received: by 2002:a05:6512:3a9:b0:50b:c251:91bc with SMTP id
 v9-20020a05651203a900b0050bc25191bcmr1214924lfp.4.1701478502204; 
 Fri, 01 Dec 2023 16:55:02 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54]) by smtp.gmail.com with ESMTPSA id
 h14-20020ac2596e000000b0050bbb90533bsm563333lfp.186.2023.12.01.16.55.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 16:55:01 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so4051858e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 16:55:01 -0800 (PST)
X-Received: by 2002:a05:6512:793:b0:50b:d763:fe69 with SMTP id
 x19-20020a056512079300b0050bd763fe69mr1151445lfr.132.1701478500997; Fri, 01
 Dec 2023 16:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
In-Reply-To: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 1 Dec 2023 19:54:24 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-xkN6fP3_M84XaAbOutXuOR-K8GrybNA--SqTdQgEGKA@mail.gmail.com>
Message-ID: <CAEg-Je-xkN6fP3_M84XaAbOutXuOR-K8GrybNA--SqTdQgEGKA@mail.gmail.com>
Subject: Re: [PATCH v2] arm: apple: t602x: Add missing MMIO regions to memmap
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
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

On Fri, Dec 1, 2023 at 2:12=E2=80=AFAM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> The memory maps for Apple's M2 Pro/Max/Ultra left MMIO space out which
> was not used by any driver at the time. The display out exposed as
> simple-framebuffer use a power-domain controlled by a device in an
> unmapped region.
> Add a map covering this region as well as another MMIO region in the
> range 0x4'0000'0000 - 0x5'0000'0000. The added regions cover all MMIO
> annotated in Apple's device tree in this range.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - use SZ_1G as block size
> - Link to v1: https://lore.kernel.org/r/20231130-apple_t602x_extend_memma=
p-v1-1-cd96b251d2dc@jannau.net
> ---
>  arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 47393babbc..7a6151a972 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -370,6 +370,22 @@ static struct mm_region t6020_mem_map[] =3D {
>                 .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt =3D 0x400000000,
> +               .phys =3D 0x400000000,
> +               .size =3D SZ_1G,
> +               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt =3D 0x480000000,
> +               .phys =3D 0x480000000,
> +               .size =3D SZ_1G,
> +               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* I/O */
>                 .virt =3D 0x580000000,
> @@ -471,6 +487,22 @@ static struct mm_region t6022_mem_map[] =3D {
>                 .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt =3D 0x400000000,
> +               .phys =3D 0x400000000,
> +               .size =3D SZ_1G,
> +               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt =3D 0x480000000,
> +               .phys =3D 0x480000000,
> +               .size =3D SZ_1G,
> +               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* I/O */
>                 .virt =3D 0x580000000,
> @@ -551,6 +583,22 @@ static struct mm_region t6022_mem_map[] =3D {
>                 .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt =3D 0x2400000000,
> +               .phys =3D 0x2400000000,
> +               .size =3D SZ_1G,
> +               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt =3D 0x2480000000,
> +               .phys =3D 0x2480000000,
> +               .size =3D SZ_1G,
> +               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* I/O */
>                 .virt =3D 0x2580000000,
>
> ---
> base-commit: 43f2873fa98b1da6eb56d756315c7bd7db63db27
> change-id: 20231130-apple_t602x_extend_memmap-c82c522ca8c0
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
