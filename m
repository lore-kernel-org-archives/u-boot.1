Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5269FCD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 11:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E13483642;
	Sat,  2 May 2026 13:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="YAlQzw7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A329F83642; Sat,  2 May 2026 13:53:49 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689E680F0E
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 13:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 91c9c7a3-461d-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 91c9c7a3-461d-11f1-bea8-005056992ed3;
 Sat, 02 May 2026 13:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=NndJWdC2XdHsgSMDPHLy5j0UmQGMya3mxxlaUEaFIVA=;
 b=YAlQzw7ksRQ3I2FVU39A8qmUXeDcgpE/BCyQSEQK7U/NS+L6pnbN/xN7zC0NGi1RBfa7tofHQ5IV7
 mB8UDalylfaS69UrfqUW6f6IdmNkCb4KGVo+RylbDax144qDsmYzMre0ruqbCB7rC1jeqIcbslgY+3
 0Wocqn/+YVYRTfUPokZ5ev015b+9nOt8PILA1A+jjilONW/juhldM73kNDk2JPBH09rkyreHVBof/6
 JtZ9xj5KLcA2D/2qHpKJRGaPz3ZuIFpXUG9nw7p7/f/maWuSS+kKVHvHkEiXCdL6xOyd6MCX5poGix
 xKZq1F6PT2r5rTJc66/PdKgoG1EepRQ==
X-KPN-MID: 33|Bw0f43nOdSbxyj4kJgouwp/Pf5OP3yuJslcAhZqINEo9+9P6MVoJSOY60RjaxFg
 hjrURGRf8WxCPky/VbUCv2WmbSWPswGFooNTUYSRgZpA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Q45zx/JzG6TGyD3fchD7VCTJ0+bE/3Pt6I4Lt/EwHp4GxfDkQaN9PNdTex/IKZX
 baf8VjPUboJIXCx9IKYuTGA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 9150aca5-461d-11f1-86d8-005056998788;
 Sat, 02 May 2026 13:53:43 +0200 (CEST)
Date: Sat, 02 May 2026 13:53:43 +0200
Message-Id: <87zf2ic9iw.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org, trini@konsulko.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, jerome.forissier@arm.com, j@jannau.net
In-Reply-To: <20260501-apple-m3-support-v1-1-4165bc2a73f4@jannau.net> (message
 from Janne Grunau on Fri, 01 May 2026 16:07:16 +0200)
Subject: Re: [PATCH] arm: apple: Add Apple M3 (t8122) support
References: <20260501-apple-m3-support-v1-1-4165bc2a73f4@jannau.net>
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
> Date: Fri, 01 May 2026 16:07:16 +0200

Hi Janne,

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
> ---
>  arch/arm/mach-apple/board.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 4cd8979bdc2..914b4581e7d 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -85,6 +85,75 @@ static struct mm_region t8103_mem_map[] = {
>  	}
>  };
>  
> +/* Apple M3 */

I think it makes more sense to keep things sorted based on the name
and put M3 after M2 Ultra?  M2 is the odd one out here since it is
identical to M1.

> +
> +static struct mm_region t8122_mem_map[] = {
> +	{
> +		/* I/O */
> +		.virt = 0x210000000,
> +		.phys = 0x210000000,
> +		.size = 4UL * SZ_1G,

We should try to keep the regions aligned on 1G boundaries with sizes
that are multiples of 1G as that allows for more efficient page
tables.

I haven't looked at Apple's device tree for the t8122 (I don't think I
have ever seen one).  But based on the t8122.dtsi from the asahi-wip
branch, I'd suggest using two regions

0x200000000: 4UL * SZ_1G
0x300000000: 1UL * SZ_1G

You could tag the region at 0x300000000 as /* NVME */ if the Apple dts
doesn't suggest there are non-NVMe things in there.


> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
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
>  /* Apple M1 Pro/Max */
>  
>  static struct mm_region t6000_mem_map[] = {
> @@ -710,6 +779,8 @@ void build_mem_map(void)
>  	if (of_machine_is_compatible("apple,t8103") ||
>  	    of_machine_is_compatible("apple,t8112"))
>  		mem_map = t8103_mem_map;
> +	else if (of_machine_is_compatible("apple,t8122"))
> +		mem_map = t8122_mem_map;

I'd probably move this down as well.

>  	else if (of_machine_is_compatible("apple,t6000") ||
>  		 of_machine_is_compatible("apple,t6001"))
>  		mem_map = t6000_mem_map;
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
