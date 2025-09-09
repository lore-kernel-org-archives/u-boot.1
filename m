Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1218CCAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 23:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 999DD8319C;
	Wed, 10 Sep 2025 01:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LDFRDxde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1800D831D5; Wed, 10 Sep 2025 01:30:59 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 846D3830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 01:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so4010071f8f.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757460656; x=1758065456; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+IJpNcjOzKNWuHSfXRwENlWz9RYOHXMvvkUc9o2Rnlc=;
 b=LDFRDxdexxSHav7WwBGOY7OQYa7Jp3ITsHhjQuJgEs4XyN0lfyLlYjZ7DLP6dDOf/k
 tFw2k7Pb9swQV5IUSrP5St31iUbOWmfErFXTtqKjpFcN1p+oGsAOgNAU3tYjdJ5C6LYQ
 hqVegvNknvDVJskWmDBnUZn9UVAB/vYFRgqJlnuCTAHMK6JCYJTyl/c1h3q+Aj4+a07C
 Bdtb/TNwWTP1dJzar/uwf9ERASELgG++KTO9nrLGS8BtyluylQSguEJlRByyIWGOF8i5
 48mjuuM5gRe8bf4R1N9hh4tVKwIjZ/sFv14B8HN+0xT2oHTegZIabZiUULK1RDvTjVlt
 uAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757460656; x=1758065456;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+IJpNcjOzKNWuHSfXRwENlWz9RYOHXMvvkUc9o2Rnlc=;
 b=WCHuxcK/5tlsOSHVNGgxcHy2UcoMeDwtU/k7vlB3df5m/n0d8ZAwnwmL6I2+EsUeeb
 Pjw9Iu7WA6KxVwdy1xNZ1E6iVHiwAqwYgQyZgOMhyjDpRRvxyhIbVINL4dhu1yPJer/C
 IH2Ie255GVjXZNHRUYbPeRq4YROeZnW+z62oD8Zld7A+BEDUpNG9IuAH2X/B313hvyZF
 twoabwx/cwrDfk8j8xrS6cFnxpcgIisFiKzU/GyZCkaVTfDNBnkBwJPKMi1ZE5NYm/rj
 YDzcBtjbG4vCk3gGsL6xjX9vPxg/oVTVZjKuJ1fMhrJDzUtTcd3WLrUXKWgbsticvaV+
 ewsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLsTR06uMRdy0MQn83HVNobs7q9B2OGzB7Ox7kzodTid4wAWGnLs9HpC6a18SPTfUxF0Doebw=@lists.denx.de
X-Gm-Message-State: AOJu0YyE1+ggkHU/DJC/7JfxQgs+xENAauYv1PAJ3wEFKfzladO+/KDA
 rOBZcQksZhfr43uUOZ9/jKYpi+NMaZX4wbL3b9WoxT7wy6WcaJraHkGF8rI2Tw==
X-Gm-Gg: ASbGncuEE9tJtfDhc02ltvMFGFV2VncRSCJy+tjkVN0ZEtjfdMuJFRlxT/Myn7N5zvi
 KTRAM9fGohGahmxUQ0DivvCqPkLi22TRJOsqX6kC55Dr1LiTp2r8zpi+y80Mk8Nw3/mbl5rUvgn
 tc14UTu2dDtyf7nhiqYnlMwBerEGwCSb4R2xTm+J1byjpe0ga0yrZLpf44bJjlJY4Svfn6V6FVv
 C81GVWcKcG7tU/06vSma7sIPL/xGqtYhGlm4Q44+bPXVERRaqo4wvOLkgKN61u66DGitbJslKE4
 G2b+bGt8640IB2aXqwE/S+H0h61c5WhPBLq0jyPKp7Sj+YGkeNFXsYaYiXGhEkKwXmASBzVFPQS
 Z2BnHgOjcGTteEVhgGvxZ1tgvkPtZMeiFK/+n2sVaFapSDN3T1E0ihTdVEjz14WGWRoHfHm5cWC
 LviPrj
X-Google-Smtp-Source: AGHT+IHq9g2vN6u2SqDrRqLc1/35OhbAG/oT7gz9tjK2XnIf3xoKrZibCyA/AvXQ1Q0izgAgvGkDgQ==
X-Received: by 2002:a5d:5f96:0:b0:3db:a907:f173 with SMTP id
 ffacd0b85a97d-3e64317f390mr10899615f8f.33.1757460655794; 
 Tue, 09 Sep 2025 16:30:55 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e752238997sm4735886f8f.37.2025.09.09.16.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 16:30:55 -0700 (PDT)
Message-ID: <68c0b8af.050a0220.1b1c70.3768@mx.google.com>
X-Google-Original-Message-ID: <aMC4rAASlj1nUCoS@Ansuel-XPS.>
Date: Wed, 10 Sep 2025 01:30:52 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] airoha: rework RAM size handling to support multiple
 RAM size
References: <20250909225751.19544-1-ansuelsmth@gmail.com>
 <6758d551-cf2a-42dd-bf2c-5574c89277af@iopsys.eu>
 <68c0b731.df0a0220.1d4f64.2389@mx.google.com>
 <ae009630-e001-41b0-bdb4-70be2fdd0101@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae009630-e001-41b0-bdb4-70be2fdd0101@iopsys.eu>
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

On Wed, Sep 10, 2025 at 02:29:10AM +0300, Mikhail Kshevetskiy wrote:
> 
> On 10.09.2025 02:24, Christian Marangi wrote:
> > On Wed, Sep 10, 2025 at 02:16:03AM +0300, Mikhail Kshevetskiy wrote:
> >> On 10.09.2025 01:57, Christian Marangi wrote:
> >>> There are multiple version of the same reference board with different
> >>> RAM size and it's not enough to base the RAM size entirely from DT. To
> >>> better support it use the get_ram_size way to scan for the actual RAM
> >>> size of Airoha SoC and increase the size of the memory map.
> >>>
> >>> Also rework the memory map to account for 2 memyro map. The first one of
> >> Misprint, please replace 'memyro' with 'memory'.
> >>
> > will fix.
> >
> >>> 2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
> >>> rest of the RAM since up to 8GB are supported.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>> Changes v2:
> >>> - Add memory map to support full 8GB
> >>> - Assign 2gb to first memory map for U-Boot
> >>>
> >>>  arch/arm/mach-airoha/an7581/init.c | 40 +++++++++++++++++++++++++-----
> >>>  1 file changed, 34 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> >>> index d149e0ee3c8..11992027d92 100644
> >>> --- a/arch/arm/mach-airoha/an7581/init.c
> >>> +++ b/arch/arm/mach-airoha/an7581/init.c
> >>> @@ -2,10 +2,16 @@
> >>>  
> >>>  #include <fdtdec.h>
> >>>  #include <init.h>
> >>> +#include <linux/sizes.h>
> >>>  #include <sysreset.h>
> >>>  #include <asm/armv8/mmu.h>
> >>> +#include <asm/global_data.h>
> >>>  #include <asm/system.h>
> >>>  
> >>> +#define CFG_MAX_MEM_MAPPED  SZ_2G
> >>> +
> >>> +DECLARE_GLOBAL_DATA_PTR;
> >>> +
> >>>  int print_cpuinfo(void)
> >>>  {
> >>>  	printf("CPU:   Airoha AN7581\n");
> >>> @@ -14,12 +20,28 @@ int print_cpuinfo(void)
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
> >> I think this will not work correctly for 2 memory regions with a gap in
> >> between, see  an7581_mem_map. So I think we should use get_ram_size()
> >> twice (for each of regions).
> >>
> > There is no gap between the 2 region. I have the memory map for the SoC,
> > it's from 0x80000000 to 0x280000000
> >
> > With specified
> > 0x080000000 0x100000000 32 bit
> > 0x100000000 0x280000000 64 bit
> 
> Sorry, I am not calculate it properly.
>

Np actually thanks for extra checking this HEX calculation with bytes is
annoying and very error prone sometimes!

So aside from the typo I think this should be ok and should address all
the memory when the kernel is loaded. Right?

> >
> >>> +
> >>> +	return 0;
> >>>  }
> >>>  
> >>>  int dram_init_banksize(void)
> >>>  {
> >>> -	return fdtdec_setup_memory_banksize();
> >>> +	gd->bd->bi_dram[0].start = gd->ram_base;
> >>> +	gd->bd->bi_dram[0].size = get_effective_memsize();
> >>> +
> >>> +	if (gd->ram_size > SZ_2G) {
> >>> +		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
> >> gd->bd->bi_dram[1].start does not match to the virtual address of second
> >> region, see  an7581_mem_map. I think this is a mistake.
> > Assuming ram_base ios 0x80000000 + SZ_2G we should be at 0x100000000.
> >
> > Am I wrong?
> I was wrong, sorry.
> >>> +		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>>  }
> >>>  
> >>>  void reset_cpu(void)
> >>> @@ -29,20 +51,26 @@ void reset_cpu(void)
> >>>  
> >>>  static struct mm_region an7581_mem_map[] = {
> >>>  	{
> >>> -		/* DDR */
> >>> +		/* DDR, 32-bit area */
> >>>  		.virt = 0x80000000UL,
> >>>  		.phys = 0x80000000UL,
> >>> -		.size = 0x80000000UL,
> >>> +		.size = SZ_2G,
> >>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> >>> +	}, {
> >>> +		/* DDR, 64-bit area */
> >>> +		.virt = 0x100000000UL,
> >>> +		.phys = 0x100000000UL,
> >>> +		.size = SZ_4G + SZ_2G,
> >>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> >>>  	}, {
> >>>  		.virt = 0x00000000UL,
> >>>  		.phys = 0x00000000UL,
> >>> -		.size = 0x20000000UL,
> >>> +		.size = 0x40000000UL,
> >>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> >>>  			 PTE_BLOCK_NON_SHARE |
> >>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> >>>  	}, {
> >>> -		0,
> >>> +		/* List terminator */
> >>>  	}
> >>>  };
> >>>  struct mm_region *mem_map = an7581_mem_map;

-- 
	Ansuel
