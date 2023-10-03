Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2583E7AD4C
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D32874A9;
	Tue,  3 Oct 2023 15:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o66SoFKq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I9aj1Jwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74186874A9; Tue,  3 Oct 2023 15:41:07 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527E787458
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S0Jr10Qczz9spW;
 Tue,  3 Oct 2023 15:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV+nl0/RcJsWlDEL5WGPL3kBu3m2+c499hI2OSntG/E=;
 b=o66SoFKqmkv2Ya+gQWD91/A2fZmZUZ46/mZNtoyOnbLd/Kib5gvkTKEUhEyemtKkuCqTLv
 5Mp4b5Eo2YfgKx6osuwH4XJYbtGQWlshN6uIUe2KO2bwvOpQ0bpkzqmevHDRMKCFp80t4/
 cjoCqeyvXM8fkMHShd91v9fh8JCzS+/buU8FaL17syslEXSmGeEc1TA8aptTG0+MJBiUYK
 fXwnp5TENFyPwdvQtpqwyVZfm5n+3CZn6WfiH8biAzs9jGHbxJw7iMBaAfTAT7IbH3J6s+
 KPXGtuHH40T4w73XkDTFey2A5s4qyziABucxRNb9bj1qEisf7Ed0jPsmySaBfw==
Message-ID: <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV+nl0/RcJsWlDEL5WGPL3kBu3m2+c499hI2OSntG/E=;
 b=I9aj1JwzVQYnVF3L8mqhfGELN98YUKuAWDOTcTC2EdJSkDR76Fk/9cF94scgwmvhw4cjde
 0KCGoNw04aLDCnB9UihsrEZ/MDD7251evbVSzil+PVtGhMaoTYqODlHR66az/c6DzQEyyb
 Hmt/LSE1W+Ts6/0y2FMsQLY94HujcO17DtqFA+ND28/m3RNdYyoikyO/GAqjLT/SXwPE2q
 7ufkvvPgFQNJgF2mnVV8YvAERs7qtf6X7nEZgy9TmNMnTyItY71eFI8mFj6FDVvTkmZKID
 Qd2SH57B9TOrh9l4ZFTFklve5LhmXSekkuft/VtTAEAn/RARuj5gOL+EHeMNlQ==
Date: Tue, 3 Oct 2023 15:32:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 14/16] arm: rmobile: Support RZ/G2L memory map
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8387ab3581204bbb862
X-MBO-RS-META: gaoz8nc7yuf16km59uasxmfdzwbkqf4h
X-Rspamd-Queue-Id: 4S0Jr10Qczz9spW
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

On 9/20/23 14:42, Paul Barker wrote:
> The memory map for the RZ/G2L family differs from that of previous R-Car
> gen3/gen4 SoCs.

Gen3 / Gen4

> A high level memory map can be seen in figure 5.2 (section 5.2.1) of the
> RZ/G2L data sheet rev 1.30 published May 12, 2023. A summary is included
> here (note that this is a 34-bit address space):
>    * 0x0_0000_0000 - 0x0_0002_FFFF SRAM area
>    * 0x0_0003_0000 - 0x0_0FFF_FFFF Reserved area
>    * 0x0_1000_0000 - 0x0_1FFF_FFFF I/O register area
>    * 0x0_2000_0000 - 0x0_2FFF_FFFF SPI Multi area
>    * 0x0_3000_0000 - 0x0_3FFF_FFFF Reserved area
>    * 0x0_4000_0000 - 0x1_3FFF_FFFF DDR area (4 GiB)
>    * 0x1_4000_0000 - 0x3_FFFF_FFFF Reserved area
> 
> Within the DDR area, the first 128 MiB are reserved by TrustedFirmware.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Makefile       |   8 +-
>   arch/arm/mach-rmobile/memmap-rzg2l.c | 115 +++++++++++++++++++++++++++
>   2 files changed, 119 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm/mach-rmobile/memmap-rzg2l.c
> 
> diff --git a/arch/arm/mach-rmobile/Makefile b/arch/arm/mach-rmobile/Makefile
> index 45d6a0e2a28a..ff8b0c7bae25 100644
> --- a/arch/arm/mach-rmobile/Makefile
> +++ b/arch/arm/mach-rmobile/Makefile
> @@ -10,11 +10,11 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) += board.o
>   obj-$(CONFIG_TMU_TIMER) += ../../sh/lib/time.o
>   obj-$(CONFIG_R8A7740) += lowlevel_init.o cpu_info-r8a7740.o pfc-r8a7740.o
>   obj-$(CONFIG_RCAR_GEN2) += lowlevel_init_ca15.o cpu_info-rcar.o
> -obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o memmap-gen3.o
> -obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o
> -obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o
> +obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o
> +obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o memmap-gen3.o
> +obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o memmap-gen3.o
>   obj-$(CONFIG_RZ_G2) += cpu_info-rzg.o
> -obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o
> +obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o memmap-rzg2l.o
>   
>   ifneq ($(CONFIG_R8A779A0),)
>   obj-$(CONFIG_ARMV8_PSCI) += psci-r8a779a0.o
> diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-rmobile/memmap-rzg2l.c
> new file mode 100644
> index 000000000000..d0509424fb73
> --- /dev/null
> +++ b/arch/arm/mach-rmobile/memmap-rzg2l.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Renesas RZ/G2L family memory map tables
> + *
> + * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +#include <common.h>
> +#include <asm/armv8/mmu.h>
> +#include <asm/global_data.h>
> +#include <cpu_func.h>
> +
> +#define RZG2L_NR_REGIONS 16
> +
> +/*
> + * RZ/G2L supports up to 4 GiB RAM starting at 0x40000000, of
> + * which the first 128 MiB is reserved by TF-A.
> + */

Are those 4 GiB continuous , or is there some "low" mem alias and then 
full "high" mem above the 32bit barrier ?

> +static struct mm_region rzg2l_mem_map[RZG2L_NR_REGIONS] = {
> +	{
> +		.virt = 0x0UL,
> +		.phys = 0x0UL,
> +		.size = 0x40000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		.virt = 0x40000000UL,
> +		.phys = 0x40000000UL,
> +		.size = 0x03F00000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x47E00000UL,

What's this part about ?

> +		.phys = 0x47E00000UL,
> +		.size = 0xF8200000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
> +struct mm_region *mem_map = rzg2l_mem_map;
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define debug_memmap(i, map) \
> +	debug("memmap %d: virt 0x%llx -> phys 0x%llx, size=0x%llx, attrs=0x%llx\n", \
> +	      i, map[i].virt, map[i].phys, map[i].size, map[i].attrs)
> +
> +void enable_caches(void)
> +{
> +	unsigned int bank, i = 0;
> +	u64 start, size;
> +
> +	/* Create map for register access */
> +	rzg2l_mem_map[i].virt = 0x0ULL;
> +	rzg2l_mem_map[i].phys = 0x0ULL;
> +	rzg2l_mem_map[i].size = 0x40000000ULL;
> +	rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +				 PTE_BLOCK_NON_SHARE |
> +				 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> +	debug_memmap(i, rzg2l_mem_map);
> +	i++;
> +
> +	/* Generate entries for DRAM in 32bit address space */
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		start = gd->bd->bi_dram[bank].start;
> +		size = gd->bd->bi_dram[bank].size;
> +
> +		/* Skip empty DRAM banks */
> +		if (!size)
> +			continue;
> +
> +		/* Mark memory reserved by ATF as cacheable too. */
> +		if (start == 0x48000000) {
> +			/* Unmark protection area (0x43F00000 to 0x47DFFFFF) */
> +			rzg2l_mem_map[i].virt = 0x40000000ULL;
> +			rzg2l_mem_map[i].phys = 0x40000000ULL;
> +			rzg2l_mem_map[i].size = 0x03F00000ULL;
> +			rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +						 PTE_BLOCK_INNER_SHARE;
> +			debug_memmap(i, rzg2l_mem_map);
> +			i++;
> +
> +			start = 0x47E00000ULL;
> +			size += 0x00200000ULL;
> +		}
> +
> +		rzg2l_mem_map[i].virt = start;
> +		rzg2l_mem_map[i].phys = start;
> +		rzg2l_mem_map[i].size = size;
> +		rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +					 PTE_BLOCK_INNER_SHARE;
> +		debug_memmap(i, rzg2l_mem_map);
> +		i++;
> +	}

Is this somehow copied from R-Car ? Can this be deduplicated ?
