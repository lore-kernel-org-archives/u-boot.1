Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F63E7B604
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C03C8752A;
	Wed,  4 Oct 2023 14:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fem5eJPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0AB8752A; Wed,  4 Oct 2023 14:31:00 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9D8874C7
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S0vDc4jxlz9sPx;
 Wed,  4 Oct 2023 14:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696422656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdQpaA+EfMRnxqEzK2nBWpVtWK4d4jMGMdmGHl+xzDE=;
 b=fem5eJPU9WOD4v8I7qkha2k7czFO1reZiSI6pkLqoe4yR/+O+tJ5kpXMWYCTbl2YYWucNi
 Jb+UjiUxSqBA+gFQDh3Q8hJai2SpXBawzrj03Srg+5Q5bcQEnuWXEfo6NQcl51TcibNNeW
 AhOo+1EN3/DQihdeRyxubt1OxoKejCbsO4WlxS8YyZm/yoxMHKMIzRfuNy92wQcKyqI9va
 v549NvJzZURYgneoLjTdhcSn812PhdjaVTv6HRX5ja9eDatXHopaLQvOJxCiSn9dUbQUBn
 QV8mATmY0EQlQQ5JmXkylIsRebnofzhYvYqLn49M24vEaked3on7SCldxXFfIg==
Message-ID: <f3f30fb3-65ed-4070-9f5a-2efd84acc722@mailbox.org>
Date: Wed, 4 Oct 2023 14:30:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 14/16] arm: rmobile: Support RZ/G2L memory map
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
 <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
 <4ee54918-cb7f-b6e1-a712-31b613c4f8ea@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4ee54918-cb7f-b6e1-a712-31b613c4f8ea@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9056d7db30e80e0cf4b
X-MBO-RS-META: 8pbksa789nq6g3afz31hejdrwf4wg5nb
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

On 10/4/23 11:18, Paul Barker wrote:

[...]

>>> +static struct mm_region rzg2l_mem_map[RZG2L_NR_REGIONS] = {
>>> +	{
>>> +		.virt = 0x0UL,
>>> +		.phys = 0x0UL,
>>> +		.size = 0x40000000UL,
>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>> +			 PTE_BLOCK_NON_SHARE |
>>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>> +	}, {
>>> +		.virt = 0x40000000UL,
>>> +		.phys = 0x40000000UL,
>>> +		.size = 0x03F00000UL,
>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>> +			 PTE_BLOCK_INNER_SHARE
>>> +	}, {
>>> +		.virt = 0x47E00000UL,
>>
>> What's this part about ?
> 
> This is copied from the RCar Gen3 memory map.

I suspected as much. Please recheck the memory map instead of copy-paste 
and make sure it is really matching the hardware.

>>> +		.phys = 0x47E00000UL,
>>> +		.size = 0xF8200000UL,
>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>> +			 PTE_BLOCK_INNER_SHARE
>>> +	}, {
>>> +		/* List terminator */
>>> +		0,
>>> +	}
>>> +};
>>> +
>>> +struct mm_region *mem_map = rzg2l_mem_map;
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +#define debug_memmap(i, map) \
>>> +	debug("memmap %d: virt 0x%llx -> phys 0x%llx, size=0x%llx, attrs=0x%llx\n", \
>>> +	      i, map[i].virt, map[i].phys, map[i].size, map[i].attrs)
>>> +
>>> +void enable_caches(void)
>>> +{
>>> +	unsigned int bank, i = 0;
>>> +	u64 start, size;
>>> +
>>> +	/* Create map for register access */
>>> +	rzg2l_mem_map[i].virt = 0x0ULL;
>>> +	rzg2l_mem_map[i].phys = 0x0ULL;
>>> +	rzg2l_mem_map[i].size = 0x40000000ULL;
>>> +	rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>> +				 PTE_BLOCK_NON_SHARE |
>>> +				 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>>> +	debug_memmap(i, rzg2l_mem_map);
>>> +	i++;
>>> +
>>> +	/* Generate entries for DRAM in 32bit address space */
>>> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>> +		start = gd->bd->bi_dram[bank].start;
>>> +		size = gd->bd->bi_dram[bank].size;
>>> +
>>> +		/* Skip empty DRAM banks */
>>> +		if (!size)
>>> +			continue;
>>> +
>>> +		/* Mark memory reserved by ATF as cacheable too. */
>>> +		if (start == 0x48000000) {
>>> +			/* Unmark protection area (0x43F00000 to 0x47DFFFFF) */
>>> +			rzg2l_mem_map[i].virt = 0x40000000ULL;
>>> +			rzg2l_mem_map[i].phys = 0x40000000ULL;
>>> +			rzg2l_mem_map[i].size = 0x03F00000ULL;
>>> +			rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>> +						 PTE_BLOCK_INNER_SHARE;
>>> +			debug_memmap(i, rzg2l_mem_map);
>>> +			i++;
>>> +
>>> +			start = 0x47E00000ULL;
>>> +			size += 0x00200000ULL;
>>> +		}
>>> +
>>> +		rzg2l_mem_map[i].virt = start;
>>> +		rzg2l_mem_map[i].phys = start;
>>> +		rzg2l_mem_map[i].size = size;
>>> +		rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>> +					 PTE_BLOCK_INNER_SHARE;
>>> +		debug_memmap(i, rzg2l_mem_map);
>>> +		i++;
>>> +	}
>>
>> Is this somehow copied from R-Car ? Can this be deduplicated ?
> 
> This is based on the R-Car memory map. We discussed internally whether
> to modify memmap-gen3.c or create a separate memmap-rzg2l.c and decided
> that it was safer not to change the known working code for R-Car systems.
> 
> To merge the two, we'll need to add a few if(IS_ENABLED(CONFIG_RZG2L))
> conditionals to memmap-gen3.c. I'm happy to do that if that's the
> approach you'd prefer.

I suspect if you really align the memmap with your hardware, there will 
be even more differences. All right, lets stick with this setup for now.
