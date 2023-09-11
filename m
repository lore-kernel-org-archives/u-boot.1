Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39BEEE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 20:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D156386500;
	Mon, 11 Sep 2023 22:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="pecht3pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1ED886579; Mon, 11 Sep 2023 22:28:08 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2805286284
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 22:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b5b6306d-50e1-11ee-b452-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b5b6306d-50e1-11ee-b452-005056994fde;
 Mon, 11 Sep 2023 22:28:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=w9yUrJfFiuWra1Msm86Pm+u3FcyjzZckztdGqqmL20Q=;
 b=pecht3pt0SwANc5WhbfqnqzUlWqK3YeEooEY/9icHc4zZvpcA0kRTSRSTGsPdkX4DxXjk9vzybYks
 ydBzK3beLdEnIfK+RqNrF0qqwgCKtVAzqp1cPwbKotwQv/HfmQIFzPNMAgfpxsScTf7JUMR+LGulE9
 YHHqcaGt6xnjib/4MgO4ELZQXLINVXapPy2CWpy1pFs1EcrUNiRkaf2w8qWHMwg9HHSieTQ5o6E0rP
 grnAIBQ7MF48+7ouifIv8D2YUygN3iUGGpnyCmxPbZ7gGAxFsUrFAYCIVLa8ocbdWUyF2zrf3j7CJ/
 7aRiskhKe3qZBbv2IFIBehroyzLGCgQ==
X-KPN-MID: 33|tUgUwMdGS81YJ57m/FJxR1i78Ykdjf7G4qxRXdCbB0VJGYdZd4xbqb26D6JBjDS
 IE2CgOFvYytt9A8kKYW/lMg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|KE2NUWTkqJLs3+NxxdKKs2tMkdauhN5f+pHIZ4kMlasacBbNpo77Taigrwv3/fj
 G5dZQ48QnwYb5OT5E6RacMw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b627b633-50e1-11ee-acaa-00505699d6e5;
 Mon, 11 Sep 2023 22:28:05 +0200 (CEST)
Date: Mon, 11 Sep 2023 22:28:04 +0200
Message-Id: <87pm2ofoa3.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
 (message from Janne Grunau on Wed, 06 Sep 2023 23:50:34 +0200)
Subject: Re: [PATCH] arm: apple: Add initial Apple M2 Ultra support
References: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Wed, 06 Sep 2023 23:50:34 +0200
> 
> Apple's M2 Ultra SoC are somewhat similar to the M1 Ultra but needs
> a tweaked memory map as the M2 Pro/Max SoCs.  USB, NVMe, UART, WDT
> and PCIe are working with the existing drivers.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  arch/arm/mach-apple/board.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index d50194811843..47393babbc62 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -444,6 +444,187 @@ static struct mm_region t6020_mem_map[] = {
>  	}
>  };
>  
> +/* Apple M2 Ultra */
> +
> +static struct mm_region t6022_mem_map[] = {
> +	{
> +		/* I/O */
> +		.virt = 0x280000000,
> +		.phys = 0x280000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x340000000,
> +		.phys = 0x340000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x380000000,
> +		.phys = 0x380000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x580000000,
> +		.phys = 0x580000000,
> +		.size = SZ_512M,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x5a0000000,
> +		.phys = 0x5a0000000,
> +		.size = SZ_512M,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x5c0000000,
> +		.phys = 0x5c0000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x700000000,
> +		.phys = 0x700000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0xb00000000,
> +		.phys = 0xb00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0xf00000000,
> +		.phys = 0xf00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x1300000000,
> +		.phys = 0x1300000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2280000000,
> +		.phys = 0x2280000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2340000000,
> +		.phys = 0x2340000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2380000000,
> +		.phys = 0x2380000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2580000000,
> +		.phys = 0x2580000000,
> +		.size = SZ_512M,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x25a0000000,
> +		.phys = 0x25a0000000,
> +		.size = SZ_512M,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x25c0000000,
> +		.phys = 0x25c0000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2700000000,
> +		.phys = 0x2700000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2b00000000,
> +		.phys = 0x2b00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2f00000000,
> +		.phys = 0x2f00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x3300000000,
> +		.phys = 0x3300000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* RAM */
> +		.virt = 0x10000000000,
> +		.phys = 0x10000000000,
> +		.size = 16UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* Framebuffer */
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
>  struct mm_region *mem_map;
>  
>  int board_init(void)
> @@ -488,6 +669,8 @@ void build_mem_map(void)
>  	else if (of_machine_is_compatible("apple,t6020") ||
>  		 of_machine_is_compatible("apple,t6021"))
>  		mem_map = t6020_mem_map;
> +	else if (of_machine_is_compatible("apple,t6022"))
> +		mem_map = t6022_mem_map;
>  	else
>  		panic("Unsupported SoC\n");
>  
> 
> ---
> base-commit: c0c08be5468cb26db597932bc69c4eda1129841d
> change-id: 20230906-apple_t6022_m2_ultra-9146e34619e6
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
