Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25022C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 08:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737678398C;
	Fri,  1 Aug 2025 10:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Xgyj4Tv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F2D839CA; Fri,  1 Aug 2025 10:47:38 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D058396E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 10:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id F149225D92;
 Fri,  1 Aug 2025 10:47:35 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkxNNO8c2Lo7; Fri,  1 Aug 2025 10:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754038034; bh=1HoDkM/ZY8x5wTpw3HOeSz4rW/DxtkV3g+rBddmVzkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Xgyj4Tv7H+ucVZO9iyswA9W3Ncc7KBd8GCOo/8GEglGmyIUM71f09KiQSt8f96B8I
 gjk8CRG4eIk/taITMkzfg6nC7NLcE8TJHzG5vZDhLqNlucRYJGFk7agBT9nnKfqWLu
 Ee2qZbl6eSDKcCWjxziSA8De059wSBfppgGKsAq05N4D0SuIMlYTVTQREGeIO8oLlH
 BhiNg4UsPueqQBjmfiLBIJLB1WmI5aYN7sujstAaSHAAixHgfMpYRZmQLhBOp0JuNG
 18pfLhWchiHxg+Pyjr4rOkopGt7ULJn8RhKNPH+YHFG4sSkpfasY2akqV1OPkD7FGT
 wPtISQeuYvFGg==
Date: Fri, 1 Aug 2025 08:47:07 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v3 09/12] riscv: p8700: Add Coherence Manager (CM) and
 IOCU support
Message-ID: <aIx_Cwijrz8L7IHK@pie>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-10-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729162035.209849-10-uros.stajic@htecgroup.com>
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

On Tue, Jul 29, 2025 at 04:24:36PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add support for Coherence Manager (CM) and IOCU discovery and
> configuration on the P8700 platform.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/cpu/p8700/Makefile             |   2 +
>  arch/riscv/cpu/p8700/cache.c              |  10 +++
>  arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++++++++++++
>  arch/riscv/cpu/p8700/cm.c                 |  92 +++++++++++++++++++
>  arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++++++++++
>  arch/riscv/include/asm/arch-p8700/p8700.h |  31 +++++++
>  arch/riscv/include/asm/global_data.h      |   2 +
>  arch/riscv/include/asm/io.h               |  86 ++++++++++++++++++
>  board/mips/boston-riscv/Makefile          |   1 +
>  board/mips/boston-riscv/iocu.c            | 104 ++++++++++++++++++++++
>  10 files changed, 464 insertions(+)
>  create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
>  create mode 100644 arch/riscv/cpu/p8700/cm.c
>  create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
>  create mode 100644 board/mips/boston-riscv/iocu.c
> 

...

> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index da165858034..fb79d0a8d32 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h

These changes don't seem to be related to the commit message. Please
split them into a separate patch (if these are really necessary, see
my comments below).

> @@ -15,6 +15,91 @@ static inline void sync(void)
>  {
>  }
>  
> +/*
> + * Generic virtual read/write.  Note that we don't support half-word
> + * read/writes.  We define __arch_*[bl] here, and leave __arch_*w
> + * to the architecture specific code.
> + */

But you do define half-word operations. This comment looks like the one
removed in d5af15bf515 ("riscv: Clean up asm/io.h"), and seems already
out-of-date.

> +#if CONFIG_P8700_RISCV
> +#ifdef CONFIG_ARCH_MAP_SYSMEM
> +static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
> +{
> +	if (paddr < PHYS_SDRAM_0_SIZE + PHYS_SDRAM_1_SIZE)
> +		paddr = paddr | 0x40000000;
> +	return (void *)(uintptr_t)paddr;
> +}
> +
> +static inline void *unmap_sysmem(const void *vaddr)
> +{
> +	phys_addr_t paddr = (phys_addr_t)vaddr;
> +
> +	paddr = paddr & ~0x40000000;
> +	return (void *)(uintptr_t)paddr;
> +}
> +
> +static inline phys_addr_t map_to_sysmem(const void *ptr)
> +{
> +	return (phys_addr_t)(uintptr_t)ptr;
> +}
> +#endif
> +
> +static inline unsigned char __arch_getb(const volatile void __iomem *mem)
> +{
> +	unsigned char value;
> +
> +	asm volatile("lbu %0,0(%1)" : "=r"(value) : "r"(mem));
> +
> +	return value;
> +}
> +
> +static inline unsigned short __arch_getw(const volatile void __iomem *mem)
> +{
> +	unsigned short value;
> +
> +	asm volatile("lhu %0,0(%1)" : "=r"(value) : "r"(mem));
> +
> +	return value;
> +}
> +
> +static inline unsigned int __arch_getl(const volatile void __iomem *mem)
> +{
> +	unsigned int value;
> +
> +	asm volatile("lw %0,0(%1)" : "=r"(value) : "r"(mem));
> +
> +	return value;
> +}
> +
> +static inline unsigned long long __arch_getq(const volatile void __iomem *mem)
> +{
> +	unsigned long long value;
> +
> +	asm volatile("ld %0,0(%1)" : "=r"(value) : "r"(mem));
> +
> +	return value;
> +}
> +
> +static inline void __arch_putb(unsigned char value, volatile void __iomem *mem)
> +{
> +	asm volatile("sb %0,0(%1)"::"r"(value), "r"(mem));
> +}
> +
> +static inline void __arch_putw(unsigned short value, volatile void __iomem *mem)
> +{
> +	asm volatile("sh %0,0(%1)"::"r"(value), "r"(mem));
> +}
> +
> +static inline void __arch_putl(unsigned int value, volatile void __iomem *mem)
> +{
> +	asm volatile("sw %0,0(%1)"::"r"(value), "r"(mem));
> +}
> +
> +static inline void __arch_putq(unsigned int value, volatile void __iomem *mem)
> +{
> +	asm volatile("sd %0,0(%1)"::"r"(value), "r"(mem));
> +}

I don't see any reason not to use the generic macros for P8700, these
inline assembly should basically behave the same as the C-version below.
Could you please explain it futher?

Thanks,
Yao Zi

> +#else
>  #define __arch_getb(a)			(*(volatile unsigned char *)(a))
>  #define __arch_getw(a)			(*(volatile unsigned short *)(a))
>  #define __arch_getl(a)			(*(volatile unsigned int *)(a))
> @@ -24,6 +109,7 @@ static inline void sync(void)
>  #define __arch_putw(v, a)		(*(volatile unsigned short *)(a) = (v))
>  #define __arch_putl(v, a)		(*(volatile unsigned int *)(a) = (v))
>  #define __arch_putq(v, a)		(*(volatile unsigned long long *)(a) = (v))
> +#endif
>  
>  #define __raw_writeb(v, a)		__arch_putb(v, a)
>  #define __raw_writew(v, a)		__arch_putw(v, a)
> +}
