Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EFACA0EED
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 13:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E663281D5D;
	Sat, 23 Aug 2025 15:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gT/qS1wg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B33FF82BA7; Sat, 23 Aug 2025 15:26:12 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B064F800D7
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 15:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so574743f8f.1
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755955570; x=1756560370; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xO6TbKHebfxfs168EGupvR8l5/KdYiNZOhrZbwOqW40=;
 b=gT/qS1wgVfPRp+P/MGYlf/fwIvPu7vXCUOR8Yx/YuuxPpUPkxPg5vam6rPhNn34Tlk
 f5zPQiKV2va6kvfggQCQY8ub1yQ3cmW6+SJe+Rbw8IEMFM3dJsuMeGFNR7T0S2pWhz/E
 gC1p1R7o6IF6HmfmqmxpBPD2037Sq8d2xuzNX/xqcZXynucsihxvn0v5mNQdRPEKt1HG
 w4Y7j8wxLuMOpbDe8KFkuMEVm0JhNLIBLrpAtUjCkho8WDn1x6Ix1meoUGw9QZWlAFyc
 Oi5FZd8JKG4UGRuWYCv7WJu50IJ4c4DpAqlvVFmzs3jnQhj/LhQYgZIRIv6JzART/TvS
 Hurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755955570; x=1756560370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xO6TbKHebfxfs168EGupvR8l5/KdYiNZOhrZbwOqW40=;
 b=UWvHRiciNIatvb1Uz38uzSJBMDGbOkJ4I7vJY5MwSzoum4EoPzIuUxp8emTr7PWkuS
 TBProX+Vcd0UCPE1TiV7DqnUlEc625JSYSqbCa3lq+TAAtCKix5EeWODxfGKdGwCTWXR
 Z3Z7MszGSyqeCOJtxnAFdhIQ+wsgiaBIvSS5dxqgBRvOOmYXpJNCbLhPbbSwQWgg4Fch
 IcKqoPO/P76ma8H0p/BBHSf5eRZ7UMvao9v0WzjyZHhftXsDbrs1oVXny4bNk0hU3a03
 SQDxzfATzKWaJJ15HPdizYNuq5IRgGAfbXxbalhX6cRLeQAMdv+DX+hwObcDmcvmcm3T
 9oQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5uBtZwfJ/gAWiZflzyPYTGdfv1Fo0U6G4ap2L+KGZZsjAZApAg2QOc+JWEMZFCK6nHzK7xzg=@lists.denx.de
X-Gm-Message-State: AOJu0YxKYxHhUKk06IGhKmLhVJdUzqYgh176hDdLVIQidNHQkhbpEElD
 nvpI9c9daSidQ/Ec8nmDXpe4HL4Pj+aUx60ZanYOrVybBQueOvQBFDSy
X-Gm-Gg: ASbGncs0Q+g+llLIVXO+CGewDgCoFV8kyh+llNzHEqPARspRPmPENpdDJhiBnutrnNR
 w0gWxo95y4N0xbq85hQtdPzWF/wbYaa5aAAsvv9UOWn0nx4rwU0eVnMzE7dKggy/AW0Ao1OnmMx
 0OR8L5YsgJXyOoOhHYFTKAReK/bvYHExgJ1RiJS4NRAC8bRfo1+IDj5BnidWGX/gc2rYsVgoDYC
 ROoouXVbjrIm3uWkox7onUKqaKEkKtk2UUxLlukqR9FF1pu0qymoqzvBOhDdjO0NwyE4M0nxMsz
 6Om7pBTOssw0x2aFIT+94SHUeMdL6tixrX0EqVMG5d1xmUw4eUmwUUFNcHukxujFsxIXLdnKudD
 n6hNRMTXmMom+zLcmWPe9UsefT++otnN7ZwDuccxGYBx+KH3Qk5xj5Fx1QF4cVhE8NdHdhQ==
X-Google-Smtp-Source: AGHT+IHHFtRvT2uBndjzgUDIrh0xGhIadBEw2AH43+YXCpvwF0RDqmA8tWaEp0ezOESYo6KOrnkZZw==
X-Received: by 2002:a05:6000:40de:b0:3b7:b3f2:f8c3 with SMTP id
 ffacd0b85a97d-3c5de3496a2mr5402041f8f.57.1755955569781; 
 Sat, 23 Aug 2025 06:26:09 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-251-209-58.retail.telecomitalia.it.
 [95.251.209.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm3557273f8f.66.2025.08.23.06.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 06:26:09 -0700 (PDT)
Message-ID: <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
X-Google-Original-Message-ID: <aKnBbzyFNtREvyUd@Ansuel-XPS.>
Date: Sat, 23 Aug 2025 15:26:07 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
References: <20250722184426.6964-1-ansuelsmth@gmail.com>
 <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
 <68861451.050a0220.a546a.2ace@mx.google.com>
 <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
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

On Sun, Jul 27, 2025 at 03:03:30PM +0300, Mikhail Kshevetskiy wrote:
> 
> On 27.07.2025 14:58, Christian Marangi wrote:
> > On Thu, Jul 24, 2025 at 01:30:45PM +0300, Mikhail Kshevetskiy wrote:
> >> On 22.07.2025 21:44, Christian Marangi wrote:
> >>> There are multiple version of the same reference board with different
> >>> RAM size and it's not enough to base the RAM size entirely from DT. To
> >>> better support it use the get_ram_size way to scan for the actual RAM
> >>> size of Airoha SoC and increase the size of the memory map.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>>  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
> >>>  1 file changed, 19 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> >>> index d149e0ee3c8..0f72365c4ab 100644
> >>> --- a/arch/arm/mach-airoha/an7581/init.c
> >>> +++ b/arch/arm/mach-airoha/an7581/init.c
> >>> @@ -2,10 +2,14 @@
> >>>  
> >>>  #include <fdtdec.h>
> >>>  #include <init.h>
> >>> +#include <linux/sizes.h>
> >>>  #include <sysreset.h>
> >>>  #include <asm/armv8/mmu.h>
> >>> +#include <asm/global_data.h>
> >>>  #include <asm/system.h>
> >>>  
> >>> +DECLARE_GLOBAL_DATA_PTR;
> >>> +
> >>>  int print_cpuinfo(void)
> >>>  {
> >>>  	printf("CPU:   Airoha AN7581\n");
> >>> @@ -14,12 +18,23 @@ int print_cpuinfo(void)
> >>>  
> >>>  int dram_init(void)
> >>>  {
> >>> -	return fdtdec_setup_mem_size_base();
> >>> +	int ret;
> >>> +
> >>> +	ret = fdtdec_setup_mem_size_base();
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
> >> Can we use a memory size passed by airoha trusted firmware instead of
> >> playing with  get_ram_size()?
> >>
> > Hi I received some feedback from Airoha about this and sadly it's not
> > possible. There are too much version of ATF and only some of them
> > provide RAM size in some way or another. Also there isn't an exact HW
> > trap to read to know the RAM size hence raw testing the ram and not
> > depending externally is the only solution :(
> >
> > I will address all the other comments.
> great.
> >>> +
> >>> +	return 0;
> >>>  }
> >>>  
> >>>  int dram_init_banksize(void)
> >>>  {
> >>> -	return fdtdec_setup_memory_banksize();
> >>> +	gd->bd->bi_dram[0].start = gd->ram_base;
> >>> +	gd->bd->bi_dram[0].size = gd->ram_size;
> >> as I know u-boot can safely use only 2Gb of memory, thus it's better
> >>
> >>         #define CFG_MAX_MEM_MAPPED  SZ_2G
> >>

Sorry for coming back on this but by declaring CFG_MAX_MEM_MAPPED 
aren't we limiting the memory to 2gb? Also these info are passed to the
kernel so we are limiting the RAM also there. Am I wrong?

Also I notice the weak function dram_init_banksize is exactly the
current one with the usage of effective ram so I guess I can drop it
entirely?

Can you help me understand the usage of MAX_MEM_MAPPED and confirm this
doesn't limit the total RAM when loading the kernel? (we don't use ATAGS
as we use FDT)

> >> and replace above line with
> >>
> >>         gd->bd->bi_dram[0].size = get_effective_memsize();
> >>
> >>> +
> >>> +	return 0;
> >>>  }
> >>>  
> >>>  void reset_cpu(void)
> >>> @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
> >>>  		/* DDR */
> >>>  		.virt = 0x80000000UL,
> >>>  		.phys = 0x80000000UL,
> >>> -		.size = 0x80000000UL,
> >>> +		.size = 0x200000000ULL,
> >>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> >>>  	}, {
> >>>  		.virt = 0x00000000UL,
> >>>  		.phys = 0x00000000UL,
> >>> -		.size = 0x20000000UL,
> >>> +		.size = 0x40000000UL,
> >>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> >>>  			 PTE_BLOCK_NON_SHARE |
> >>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN

-- 
	Ansuel
