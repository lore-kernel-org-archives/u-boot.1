Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49288C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797EE8747A;
	Mon, 18 Dec 2023 23:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ughPjo0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE833874D9; Mon, 18 Dec 2023 23:25:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9DB870AB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1702938307; x=1703543107; i=wahrenst@gmx.net;
 bh=RX43fH9UJltzlG5FzOXLlqZ4aPJVUUMu6TI1LkcfJc8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ughPjo0UyylKI9swmZIpv0ylrKsSiiix15dVz9TKjtNzs5zGu+g50zKa6G6uWlkl
 1jI3k0d8xUmz9TjUlO+UJE4CmuCESYWli9OT97gS7ZpflG5i35SD4WkvaLqFLhfEA
 qvIpWnEnf/1OSlILiPuLGr7WNdzL5SW6KlQ61HoigucOG6voNdbsnQeW51tgBMpyK
 QX5bd8SAQYeiZ9e7oOqp3I04bn+DcqFWcEYXDN1R1K+5/vndCcrjdSGh6s7QLaTCK
 nAz+QzqYM9pGMR2yQxA0mH4VRiGezeKSkLdAIpFAQF5B2WuVx3WxX2uZn0NsIgrks
 G5DxzpETaljnM5L77Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGyxX-1rTQgK2CGp-00E2Eq; Mon, 18
 Dec 2023 23:25:07 +0100
Message-ID: <9d0fc4f9-3f58-4ebc-9af6-82b8823f08dc@gmx.net>
Date: Mon, 18 Dec 2023 23:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] rpi5: add initial memory map for bcm2712
To: "Ivan T. Ivanov" <iivanov@suse.de>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-2-iivanov@suse.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231218210341.30073-2-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sdtpOE4KAlL1Rn6dR9YNFzABpobqi2gIJ1bSVYtaJktN14/LMbq
 apFXTYy/nbQTkFfhTDWe1mwYNfx8pHwoYPsROWOIDuZ7dtFY1hSTHKKBWuDJGk+JNFzN+aq
 jPQHnYTlfkAgFW+aKUNVFHsxn6dAKKqRKtTI2MZ0AaK9AKLEB/js/G+AOwjkv9B6eGPmhq+
 YERRua4LkY4KDrO4e3Akw==
UI-OutboundReport: notjunk:1;M01:P0:OZN3qsN8bS8=;lCB2nm693Q+Ahf4rpQnnMZSiNa1
 87vRHygf5CIKeGGLTnbXbnwF29HGYZZxrg1pdUSZ9Y0f47BLyKyIIDMOpn4gz3nbj3N2/kahq
 62EvIHPtYOJFF87Fbj1tZcoW5T1ZkGG6/pkGIj9AENXYpJlprfQRMFuqlH2pMKjJ1UiKLkyXx
 clTVS59kvB5eP2ZOWzgZh0JzQZ+E72qWPwyKfwE3Yn7H3K8LJi9HIlJc7BhlxjE3xOD8zMttF
 iGWyH7/wddd3XcVoRDFyxoiFBuVwa9eQSwL1epQzRCB/DYcuy3UEMK8foRJYMf6PvYkGMJrcb
 d5QJpzPZGRuVEh2944cOdsmkhCez+Tx88zeu8qmGC6TA61GBfRBdnCM9G1QqI++z+9v1KXAFT
 mYGX1USXbTRPky6DGiIKOyiJkSEfpI8Kr1eTUt0++2Af9O1g4IvoOJQp084dodY6PI0UkChzi
 jaMviXIFSRNbd+hmBgBwwpohkQfthpAm6uIZnaJPFNBH3UOUy2nvCKwxkQeXJYHjh5IUcKmRa
 1OvcJ8Fs7jkPr+MzePrGmzOsVffaMdGtNiwvKoEckBA+X/RntATNgn01J7lFe2glQQixcRqK1
 kmvsqCRb8v7oTp+6B2Pa9PxvcBBskVGM/FPW0FpcBzKP5Y7H1qhShIiuIL9MXzvZvWWXntptb
 WfKeHEXeEBYDCvpMioWGraJNKixH9TgWqFpWbyB4nL2bkEx09jb8li5Gk1ZlTn87vBRA/QOt1
 oa5aXzSuje0fOcSVc/LyJzvo5dtH0fojHJlJIGcszKP+DM9BCeThQBWbNZ7snTWyYZ6YJt+9N
 xE6xy41OPTIi+30HbeyrS7iSL3uNqO4NP//Idif+Z3yNj35f8eU3wpBbbRqCZrx7KnbJW1kf2
 Ijw8hWke387HTQ+CuZE5LSOWIQkIJhtEJluvhvCCJ2pzokRbybxqgJIq0raEpvIOD9V5JNjlS
 FpjIpA==
X-Mailman-Approved-At: Mon, 18 Dec 2023 23:33:51 +0100
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

Hi Ivan,

Am 18.12.23 um 22:03 schrieb Ivan T. Ivanov:
> From: Dmitry Malkin <dmitry@bedrocksystems.com>
>
> includes:
> * 1GB of RAM (from 4GB or 8GB total)
> * VPU memory interface
> * AXI ranges (main peripherals)
my experience with U-Boot is little, but i do my best to give you some
feedback.
>
> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>   arch/arm/mach-bcm283x/init.c | 38 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7265faf6ce..af23b9711a 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -19,7 +19,7 @@
>   #ifdef CONFIG_ARM64
>   #include <asm/armv8/mmu.h>
>
> -#define MEM_MAP_MAX_ENTRIES (4)
> +#define MEM_MAP_MAX_ENTRIES (5)
>
>   static struct mm_region bcm283x_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
>   	{
> @@ -68,6 +68,41 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_E=
NTRIES] =3D {
>   	}
>   };
>
> +static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
> +	{
in comparison to mach-imx/imx9/soc.c most of the memory maps doesn't
have a describing comment.
> +		.virt =3D 0x00000000UL,
> +		.phys =3D 0x00000000UL,
> +		.size =3D 0x3f800000UL,
> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt =3D 0x3f800000UL,
> +		.phys =3D 0x3f800000UL,
> +		.size =3D 0x00800000UL,
> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* Beginning of AXI bus where uSD controller lives */
> +		.virt =3D 0x1000000000UL,
> +		.phys =3D 0x1000000000UL,
> +		.size =3D 0x0002000000UL,
> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		.virt =3D 0x107c000000UL,
> +		.phys =3D 0x107c000000UL,
> +		.size =3D 0x0004000000UL,
> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
>   struct mm_region *mem_map =3D bcm283x_mem_map;
>
>   /*
> @@ -78,6 +113,7 @@ static const struct udevice_id board_ids[] =3D {
>   	{ .compatible =3D "brcm,bcm2837", .data =3D (ulong)&bcm283x_mem_map},
>   	{ .compatible =3D "brcm,bcm2838", .data =3D (ulong)&bcm2711_mem_map},
>   	{ .compatible =3D "brcm,bcm2711", .data =3D (ulong)&bcm2711_mem_map},
> +	{ .compatible =3D "brcm,bcm2712", .data =3D (ulong)&bcm2712_mem_map},
>   	{ },
>   };
>
Looking at the complete file, i saw the function print_cpuinfo().
Personally i think it's wrong to print BCM283x in case of a RPI 4 or 5.
