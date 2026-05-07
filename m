Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F0ECD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 20:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BB684BBE;
	Thu,  7 May 2026 22:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="eVbdoSjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2B584BD5; Thu,  7 May 2026 22:16:35 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE6784BB7
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 22:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a3a8f38c-4a51-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a3a8f38c-4a51-11f1-bea8-005056992ed3;
 Thu, 07 May 2026 22:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=xO/y0CKMhZ+zWtkF5HbcrCoH8bylEA2X5znNRZLZ1AU=;
 b=eVbdoSjBdQ17bDOqcRMaZAnKdMXlawW0TbUooOliShoAAS71stAaxMBlCltywccjUEsa5zKFRZ6jO
 XdK5ZBezd1rOd0tniJn1FcTV1YJMSMPS4kBDVOiKLQH1NtJ7qAIkpRCSSdnoL6OQkPm09HhvF3oXSu
 cCqIeFo/DJtEoEUZiDWimyjevLDroIlX7so9Izq8TFojIdmLvn5PZ7jY2tNls5PSweiNlhKhc/2/sU
 Etus0J2xgg+Hk6uuCjw8Yw/gaM77wI8aqPaRAKFte4ik0DCvYpKpHS/h4cuqj+iLv2BtUJqdLhHD8Z
 4vM2cLgC7s61Yy+mrZqbH+AYDKArDMw==
X-KPN-MID: 33|XbRF+ShiVCYcwoVDjptvoyCC3kwvmSi9hwRIpkG5PuqsOYgtHlwVc+5noL4UaCE
 8UHxQhF1vCdgs1UtMlvL+++9cPifThVGcwySCehl2jZA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cOjvkTo5yYUoFZT9km896/Pi7r95bhoTKRoi34hn/OVQNGgwO2a6o3TP6Ztbg1O
 xAHV4QGZ+3eLnsyZtXZ4k2Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a331e1b5-4a51-11f1-9c0c-00505699d6e5;
 Thu, 07 May 2026 22:16:32 +0200 (CEST)
Date: Thu, 07 May 2026 22:16:31 +0200
Message-Id: <87qznnasbk.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org, trini@konsulko.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, jerome.forissier@arm.com, j@jannau.net
In-Reply-To: <20260507-apple-m3-support-v2-1-ce3db1c9e3ec@jannau.net> (message
 from Janne Grunau on Thu, 07 May 2026 10:41:40 +0200)
Subject: Re: [PATCH v2] arm: apple: Add Apple M3 (t8122) support
References: <20260507-apple-m3-support-v2-1-ce3db1c9e3ec@jannau.net>
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
> Date: Thu, 07 May 2026 10:41:40 +0200
> 
> Apple's M3 SoC is similar to M1 and M2 but uses a different memory map.
> The main difference is that RAM starts at 0x100_0000_0000 like on t600x
> and t602x (M1 and M2 Pro/Max/Ultra). Otherwise IO blocks have been
> rearranged.
> U-boot's existing drivers are compatible with the hardware and M3 device
> trees will carry "apple,t8103-*" compatible strings. Only
> apple-atcphy-reset might need a new compatible due to USB4 / DisplayPort
> changes the Linux driver has to deal with.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
> Changes in v2:
> - aligned main MMIO region to SZ_1G
> - split of NVMe region at 0x300000000
> - sorted IO regions by address
> - reordered M3 additions chronologically with other SoCs
> - Link to v1: https://patch.msgid.link/20260501-apple-m3-support-v1-1-4165bc2a73f4@jannau.net
> ---
>  arch/arm/mach-apple/board.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 4cd8979bdc2..20054f54089 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -673,6 +673,83 @@ static struct mm_region t6022_mem_map[] = {
>  	}
>  };
>  
> +/* Apple M3 */
> +
> +static struct mm_region t8122_mem_map[] = {
> +	{
> +		/* I/O */
> +		.virt = 0x200000000,
> +		.phys = 0x200000000,
> +		.size = 4UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* NVMe */
> +		.virt = 0x300000000,
> +		.phys = 0x300000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
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
> +		/* I/O ATC0 */
> +		.virt = 0x700000000,
> +		.phys = 0x700000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC1 */
> +		.virt = 0xb00000000,
> +		.phys = 0xb00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* RAM */
> +		.virt = 0x10000000000,
> +		.phys = 0x10000000000,
> +		.size = 8UL * SZ_1G,
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
> @@ -720,6 +797,8 @@ void build_mem_map(void)
>  		mem_map = t6020_mem_map;
>  	else if (of_machine_is_compatible("apple,t6022"))
>  		mem_map = t6022_mem_map;
> +	else if (of_machine_is_compatible("apple,t8122"))
> +		mem_map = t8122_mem_map;
>  	else
>  		panic("Unsupported SoC\n");
>  
> 
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260501-apple-m3-support-9fc25ab793d4
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
