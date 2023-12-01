Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F140CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 11:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A29B876AA;
	Fri,  1 Dec 2023 12:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="hjCIrfpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF864876C7; Fri,  1 Dec 2023 12:09:59 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645B5871CC
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 12:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 2683bc11-903a-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 2683bc11-903a-11ee-91e7-005056994fde;
 Fri, 01 Dec 2023 12:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=kQDLe+zEx62BSoAp3KLhnqFvTxu38gzvkQWAWsPkmT4=;
 b=hjCIrfprEpPWP0fZgEKtIwWjD41gsXX/fEUxHNaR4xUpSqvkleDu8TjIkDl5wZjszbVfWrWNMM1cC
 0oi08KtorqCggaipPRDiOxw2Fbn36dN6I1O8S2XQ6zc5N3ywYejlo8HSbVCYPQnUCDaqjYJBXlhzOW
 BqNkMTFsr4f0/iD99aSrRKN0TM8OJIcSF4Z+sDJDXDowNttvaF+YZRxY8CeufUZJKiyM5UMXu02C7A
 4ymuSdxPGdmErH9K2mbVk8EkLszdttAX3aMu78L/FtxC5XxigrLlGGXqywTGkHl8ocq7lbEdHVNkHr
 EXVg86r7tDCiwETj9GL/11JeODnND1Q==
X-KPN-MID: 33|YFXKlkpihd2GVBsTR88zZIqtFGlp+OE+QTYeg2tBRGTZNo9vVBjlERIfKrskgC1
 5wDJYLdNU/3WAm7OlEGRWX7enBwFpOlyPQ7AAO53qvYw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7niiIbP8swC2JOF0iMzOkx1cPUR6sUwrPRbj67zKFWW2+fUGi1F2MOYOZ11A+sD
 7lM2TwQm6XbuY9lFHZL0rtQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 2671167c-903a-11ee-ac85-00505699b758;
 Fri, 01 Dec 2023 12:09:56 +0100 (CET)
Date: Fri, 01 Dec 2023 12:09:52 +0100
Message-Id: <87leaeb2m7.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, u-boot@lists.denx.de,
 asahi@lists.linux.dev
In-Reply-To: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
 (message from Janne Grunau via B4 Relay on Fri, 01 Dec 2023 08:12:33
 +0100)
Subject: Re: [PATCH v2] arm: apple: t602x: Add missing MMIO regions to memmap
References: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
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

> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> Date: Fri, 01 Dec 2023 08:12:33 +0100
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
> - Link to v1: https://lore.kernel.org/r/20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net
> ---
>  arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

Tom, as this fixes a crash with newer device trees passed by the stage
that runs before U-Boot, it would be good if this could make 2024.01.

Thanks,

Mark

> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 47393babbc..7a6151a972 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -370,6 +370,22 @@ static struct mm_region t6020_mem_map[] = {
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x400000000,
> +		.phys = 0x400000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x480000000,
> +		.phys = 0x480000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
>  	}, {
>  		/* I/O */
>  		.virt = 0x580000000,
> @@ -471,6 +487,22 @@ static struct mm_region t6022_mem_map[] = {
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x400000000,
> +		.phys = 0x400000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x480000000,
> +		.phys = 0x480000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
>  	}, {
>  		/* I/O */
>  		.virt = 0x580000000,
> @@ -551,6 +583,22 @@ static struct mm_region t6022_mem_map[] = {
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2400000000,
> +		.phys = 0x2400000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2480000000,
> +		.phys = 0x2480000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
>  	}, {
>  		/* I/O */
>  		.virt = 0x2580000000,
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
> 
