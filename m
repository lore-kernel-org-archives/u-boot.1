Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369A8C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2312587663;
	Thu, 30 Nov 2023 21:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="FjaGKIGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218B187116; Thu, 30 Nov 2023 21:45:39 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1865D8770B
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 66024aa6-8fc1-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 66024aa6-8fc1-11ee-90ec-00505699b430;
 Thu, 30 Nov 2023 21:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=wRBnsSMpxk47NJ9LiZMl2l9xDx5Ziq6j0PVG+dHYc8E=;
 b=FjaGKIGnL1kmmFtqU119hjr2sC41M0kRKWSkc8AoMpUarPVjUVcM5vnZihxBM/w+mfPRoL4tzlWK7
 JhcIDfWC8MKD61Iof+svt2GH3w4xI4lhc9O3B0PL9UPRzO3ZlOO00/liaAabqa/ovzrQ2qDOQQmANn
 daQycUkWZtIUpT7fn+brF2ZqzMvQsIrtwUqMheMM0xr0mAW6VHkuhFXOpw61pjlXXf+TswJ4v+/sY8
 J7sDUTKvj+EG1/QQtiku9ePjYyNALknYsRAn87MXyDGZ0DBrjSV6S4w+b1jHA5xsb6mhgNqI6ABeFS
 O87MOBpRqoclCe/tsRmn1GLUi0s9w1Q==
X-KPN-MID: 33|wlX5AGLjZlt2jPjJLv3etq/dRXWbwi9deqQDFBCGGGqLuy3NlZzNo3yQyljvBG8
 Gb4AosDeod+nJTy/1LhSUn0b1gshynD7WHrErsY19uFg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|f+xYDDl8aMRj13hriGoQmFLoHCZSjtNrJZZGvkJ4GRomUqiBggRrbqJAYQtyxzG
 UwK5xMJLuTRDscwbOVdI36w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6965e7d2-8fc1-11ee-ac85-00505699b758;
 Thu, 30 Nov 2023 21:45:36 +0100 (CET)
Date: Thu, 30 Nov 2023 21:45:35 +0100
Message-Id: <87jzpz0y34.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: j@jannau.net
Cc: kettenis@openbsd.org, trini@konsulko.com, u-boot@lists.denx.de,
 asahi@lists.linux.dev
In-Reply-To: <20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net>
 (message from Janne Grunau via B4 Relay on Thu, 30 Nov 2023 13:42:22
 +0100)
Subject: Re: [PATCH] arm: apple: t602x: Add missing MMIO regions to memmap
References: <20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net>
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
> Date: Thu, 30 Nov 2023 13:42:22 +0100
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
>  arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Hi Janne,

Is there a reason why you can't use a SZ_1G mapping for the blocks
where you're using a SZ_512M mapping?  With SZ_1G the mapping code
will use a 1G block descriptor which avoids another level of page
tables.


> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 47393babbc..e05ec431bc 100644
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
> +		.size = SZ_512M,
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
> +		.size = SZ_512M,
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
> +		.size = SZ_512M,
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
