Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D127CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 23:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546498319C;
	Wed, 10 Sep 2025 01:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a47Qg60q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A73DB831A4; Wed, 10 Sep 2025 01:24:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F1E830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 01:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45df09c7128so707755e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757460274; x=1758065074; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ycN9mnqKS874/U8zS0kbglnVxYIt2c/n7sXpgelF/aQ=;
 b=a47Qg60qLH1sqHOIdrXQ/CntcOAd63B66TEiYhCth1RIij/0Dp6CXRg050uqs5AuRA
 n1fgo9VQDEy+6vdwVhM/igIeG1BGyTqp+O1f59+siOqL2ea81RfrcogI4k2eq7k5gq7F
 IE+Ji/KxtQ2MkA8TofJc3ovxyT9KE2GLKymKl99B3l1jxSjIdz9BK8R8FxXZzg8e1FuC
 SkWV9AbPK4cU4UfZOwoSNiz3UE5+O/ZGyYzJUnnorGfAgUtXG8ReFWTt0C4Um97pavWr
 7xQwFzl9QBTTR1c7iPBk60sEvY1sioY5A/gFpXDrQqf0Nf4nd9gBtl697R/OGhzLUHO0
 1Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757460274; x=1758065074;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycN9mnqKS874/U8zS0kbglnVxYIt2c/n7sXpgelF/aQ=;
 b=CfT1Ug8WJ4Om9SU4hvztQRYMN7QrOQJKXp1EU54m0C2xS2I1qS9N/4Ven+8/ndaQRC
 pXfGU5w5H2cpi9mCdhozOH0GSvJS3x80NxVO05r/JS4PAxgEowLx/az8Ju/16zxwx8MS
 1Soo46zOM1YNPlagcP5J1fs7Io6sDIYx0K79NSMysnmIOOVKhQ226JMM94DfVnWz/pfM
 Ek6pSKCmVVqVU/srTJMZIX5c/RLWvTTSh5VKyDB4RSQ10vpwH49lAIPQAKYASaD/ZMHa
 gfnvehdauAvh4Ya9ltU3G9cGreHQkIhJSncJLApGs16nhrVQ6b4cORzhAm469dZiyRsf
 l3PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLaagqfDyllAfZKzXazyXcxZnxu9Cm6qlQKULXgdgUcYtvQNBQKcVHdhlJ4MB/hGHfu7wmI9s=@lists.denx.de
X-Gm-Message-State: AOJu0YyZiWOLuFr5nC1qFiIY4vFYDJXlw7s1tiBwKSpMifEZuitayBd2
 f67YJxAnoX2nyPi7FP3j8i2R0eCwtCYPxdFQXva3fUPxlr8n2eefu8nsTPh3JQ==
X-Gm-Gg: ASbGncsRTCq1h863CHQuLlRqmEcAIHd7Qzaw3rajJoTIBEgXfmaadTObxBWkgbVv6u1
 BfnMmljx9g7fGjx3YRU6SUf6Z6L1oX1pTjT8I8ici34ldfbvUijOiMWoSphWFHqnXDipOaeRcEJ
 /BNmxCu+WLzR2J/QJCbn60vrRbV3OGuqqHFJ3KiudgZ7k4WCm+KI0CYE7gufAX9UJzLnXzJixWg
 npKClMZzU508yi4s/N/oonHFgRUQE9DrxXiKDcqNGtxTZpD3DrGnua3Db/iFbiP70HnHD8YWP1y
 LeC9wmpax9UhJrWK40idBkK65uZ0Bv+X1DxVg+TTUNA8pVMASHKuMBLYLQU6II0mXNUilzcgumh
 YtPhCAotkCnrt5jK+Tn3iGcLVuTjLyNIQHL1eb9AKvaIhLtMvYrIdRVFgnNpeYTilrIp/rPHL8R
 D7T+dq
X-Google-Smtp-Source: AGHT+IE6LBABClq2FeBUn+nxhVjhy9XGkS8PDkLmIyMT9YK4xmAX2sNpFW+RqwRtL/PdbXDAaCDfSA==
X-Received: by 2002:a05:600c:8b5c:b0:45b:9b9f:88cb with SMTP id
 5b1f17b1804b1-45dd5b78584mr153414455e9.16.1757460273876; 
 Tue, 09 Sep 2025 16:24:33 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223f188sm4261445f8f.48.2025.09.09.16.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 16:24:33 -0700 (PDT)
Message-ID: <68c0b731.df0a0220.1d4f64.2389@mx.google.com>
X-Google-Original-Message-ID: <aMC3LTBwZjE1b218@Ansuel-XPS.>
Date: Wed, 10 Sep 2025 01:24:29 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] airoha: rework RAM size handling to support multiple
 RAM size
References: <20250909225751.19544-1-ansuelsmth@gmail.com>
 <6758d551-cf2a-42dd-bf2c-5574c89277af@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6758d551-cf2a-42dd-bf2c-5574c89277af@iopsys.eu>
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

On Wed, Sep 10, 2025 at 02:16:03AM +0300, Mikhail Kshevetskiy wrote:
> 
> On 10.09.2025 01:57, Christian Marangi wrote:
> > There are multiple version of the same reference board with different
> > RAM size and it's not enough to base the RAM size entirely from DT. To
> > better support it use the get_ram_size way to scan for the actual RAM
> > size of Airoha SoC and increase the size of the memory map.
> >
> > Also rework the memory map to account for 2 memyro map. The first one of
> 
> Misprint, please replace 'memyro' with 'memory'.
>

will fix.

> > 2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
> > rest of the RAM since up to 8GB are supported.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Add memory map to support full 8GB
> > - Assign 2gb to first memory map for U-Boot
> >
> >  arch/arm/mach-airoha/an7581/init.c | 40 +++++++++++++++++++++++++-----
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> > index d149e0ee3c8..11992027d92 100644
> > --- a/arch/arm/mach-airoha/an7581/init.c
> > +++ b/arch/arm/mach-airoha/an7581/init.c
> > @@ -2,10 +2,16 @@
> >  
> >  #include <fdtdec.h>
> >  #include <init.h>
> > +#include <linux/sizes.h>
> >  #include <sysreset.h>
> >  #include <asm/armv8/mmu.h>
> > +#include <asm/global_data.h>
> >  #include <asm/system.h>
> >  
> > +#define CFG_MAX_MEM_MAPPED  SZ_2G
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> >  int print_cpuinfo(void)
> >  {
> >  	printf("CPU:   Airoha AN7581\n");
> > @@ -14,12 +20,28 @@ int print_cpuinfo(void)
> >  
> >  int dram_init(void)
> >  {
> > -	return fdtdec_setup_mem_size_base();
> > +	int ret;
> > +
> > +	ret = fdtdec_setup_mem_size_base();
> > +	if (ret)
> > +		return ret;
> > +
> > +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
> 
> I think this will not work correctly for 2 memory regions with a gap in
> between, see  an7581_mem_map. So I think we should use get_ram_size()
> twice (for each of regions).
> 

There is no gap between the 2 region. I have the memory map for the SoC,
it's from 0x80000000 to 0x280000000

With specified
0x080000000 0x100000000 32 bit
0x100000000 0x280000000 64 bit

> > +
> > +	return 0;
> >  }
> >  
> >  int dram_init_banksize(void)
> >  {
> > -	return fdtdec_setup_memory_banksize();
> > +	gd->bd->bi_dram[0].start = gd->ram_base;
> > +	gd->bd->bi_dram[0].size = get_effective_memsize();
> > +
> > +	if (gd->ram_size > SZ_2G) {
> > +		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
> gd->bd->bi_dram[1].start does not match to the virtual address of second
> region, see  an7581_mem_map. I think this is a mistake.

Assuming ram_base ios 0x80000000 + SZ_2G we should be at 0x100000000.

Am I wrong?

> > +		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  void reset_cpu(void)
> > @@ -29,20 +51,26 @@ void reset_cpu(void)
> >  
> >  static struct mm_region an7581_mem_map[] = {
> >  	{
> > -		/* DDR */
> > +		/* DDR, 32-bit area */
> >  		.virt = 0x80000000UL,
> >  		.phys = 0x80000000UL,
> > -		.size = 0x80000000UL,
> > +		.size = SZ_2G,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> > +	}, {
> > +		/* DDR, 64-bit area */
> > +		.virt = 0x100000000UL,
> > +		.phys = 0x100000000UL,
> > +		.size = SZ_4G + SZ_2G,
> >  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> >  	}, {
> >  		.virt = 0x00000000UL,
> >  		.phys = 0x00000000UL,
> > -		.size = 0x20000000UL,
> > +		.size = 0x40000000UL,
> >  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> >  			 PTE_BLOCK_NON_SHARE |
> >  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> >  	}, {
> > -		0,
> > +		/* List terminator */
> >  	}
> >  };
> >  struct mm_region *mem_map = an7581_mem_map;

-- 
	Ansuel
