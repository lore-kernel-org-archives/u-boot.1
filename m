Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A51DC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 11:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28B787619;
	Fri,  1 Dec 2023 12:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KhT4FGfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4195687638; Fri,  1 Dec 2023 11:33:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48BD870B7
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ecurtin@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701426821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUGBybqkRSK6OmVbAIF6ZaxS5DrFBBIdD3KXr/fsi5o=;
 b=KhT4FGfM5HbK4CeZE1UmGuQ5sZ11xUS1EIrhrpObeZq8mmi4t8YbWrghQ61T2GLcQtO8+6
 gPeHd+89SFCrypB4m1uWaa5D7vTojc+F74Zh59x3kBTsY7ME7jbDk0xRRLytw1VLkdhFpP
 xL2ar8Tamkyj8x2U8HtX/Hb/lYH7UZU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-rYiBO12WNIass-VvR-IiCg-1; Fri, 01 Dec 2023 05:33:38 -0500
X-MC-Unique: rYiBO12WNIass-VvR-IiCg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-285b77f7e1fso1862892a91.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 02:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701426817; x=1702031617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUGBybqkRSK6OmVbAIF6ZaxS5DrFBBIdD3KXr/fsi5o=;
 b=VseWFf06r6MJYqd2+OANjZlASBPEqxM+HjHlrvRTcKMVbmpkHvJHZz/kaD7fzf4q+N
 QI51qi7IeYhBnSlNSr7Y786WOZ2VcrDUu3uRYtydewlnTjIew3Pc0cWbJ8uDMzCuXxuA
 ehtReIvF750FoDiy2MEo7XpNCGjnuFK1bCWuPp69d6vZH1Ls9SfRipD+XAoSEOuZAaVj
 i82Lik1gFjWrBpRojrLg2HC4+qxLljWynE5GsTBDzfYWy5FM6eA8EBjTK/6viibuWwXK
 5rwbvK/vWMQeC1ZEXJj2MB5mM0W3Z89GSqDtxcy+yu/OyHL0GyBrkbOAC4vUD5me2ViB
 rj8Q==
X-Gm-Message-State: AOJu0Yzy8HO8GPOwnFbJwdsIGe4zBQGGvFHNH2WbOVHdKJRF+qS0C5XC
 LxocICZENSNIp5SuvOPU+Xn1xiPltsujtBFWrMgfParrSaG197xVCjD0TKxjzipKYsgsu1dn0jk
 RKMWBzptUqnTqQa7ZyaGuwrmIBPywIw==
X-Received: by 2002:a17:90b:a14:b0:286:424b:5be2 with SMTP id
 gg20-20020a17090b0a1400b00286424b5be2mr5265390pjb.21.1701426817429; 
 Fri, 01 Dec 2023 02:33:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESEcVcuWL3WyelI6GPfSxh6R2nxgKVIAvS3MhXrvFTq2zcFiM65ZAFrL0lG3z21JeWFvnSpGBe9Su1u3GrIAw=
X-Received: by 2002:a17:90b:a14:b0:286:424b:5be2 with SMTP id
 gg20-20020a17090b0a1400b00286424b5be2mr5265375pjb.21.1701426817147; Fri, 01
 Dec 2023 02:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
In-Reply-To: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 1 Dec 2023 10:33:00 +0000
Message-ID: <CAOgh=FyOpcWm_tBX8PQRRDC3C+GmTkObExBSXCk_VLKwQ2xSEg@mail.gmail.com>
Subject: Re: [PATCH v2] arm: apple: t602x: Add missing MMIO regions to memmap
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 01 Dec 2023 12:20:40 +0100
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

On Fri, 1 Dec 2023 at 07:20, Janne Grunau via B4 Relay
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

Review comments addressed.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
> Changes in v2:
> - use SZ_1G as block size
> - Link to v1: https://lore.kernel.org/r/20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net
> ---
>  arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 47393babbc..7a6151a972 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -370,6 +370,22 @@ static struct mm_region t6020_mem_map[] = {
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x400000000,
> +               .phys = 0x400000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x480000000,
> +               .phys = 0x480000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* I/O */
>                 .virt = 0x580000000,
> @@ -471,6 +487,22 @@ static struct mm_region t6022_mem_map[] = {
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x400000000,
> +               .phys = 0x400000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x480000000,
> +               .phys = 0x480000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* I/O */
>                 .virt = 0x580000000,
> @@ -551,6 +583,22 @@ static struct mm_region t6022_mem_map[] = {
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x2400000000,
> +               .phys = 0x2400000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x2480000000,
> +               .phys = 0x2480000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                       PTE_BLOCK_NON_SHARE |
> +                       PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* I/O */
>                 .virt = 0x2580000000,
>
> ---
> base-commit: 43f2873fa98b1da6eb56d756315c7bd7db63db27
> change-id: 20231130-apple_t602x_extend_memmap-c82c522ca8c0
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
>

