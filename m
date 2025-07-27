Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA74EC87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 11:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0578304F;
	Sun, 27 Jul 2025 13:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ftnxMo/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2868830B4; Sun, 27 Jul 2025 13:58:12 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A3F883015
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 13:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so64205f8f.0
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753617490; x=1754222290; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hjiX+V6tVKBeZpL71BMmrbagFyK3b9W5JDNe1uKG1xg=;
 b=ftnxMo/wwaqqhlshEl5+btyjbp9yLLwJ4uX7nHi+nOee6DZgUu4bNqjT4qzBa6V3Q+
 JT4ED5MfW4mY7zBfOollp33O6fBOD4jGrhrrr3Be1c71YyUhKR36K70ckr3LjVuWnaID
 bGGaexMLhUdmK+dewygTnxtKqrEatGLPdTg1Pubf44hl37heyDqQ8EHVD84Qjx1Qk0tG
 grp9ESrwhoDC4fdkAF2Sm2HmGU46x7UUj5D96h1fOrunW2fBZu6svIOVMbPeVhp4OGck
 1hmeUfFG0HFo85wIbhwhUT/ufVEXjrlLXpLV4XHfK74oGOeb1gKsD6XjJxrw67ilDOl6
 nA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753617490; x=1754222290;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hjiX+V6tVKBeZpL71BMmrbagFyK3b9W5JDNe1uKG1xg=;
 b=O275IKA6uy1G+sOHxo47z6eX4AtpTbz67FfnKgwP41EcC1uVJmo2e1y/Qe1jbnGC3s
 ceXmnBnFZANcF1ls74uPGiLEcUQeGVxcHvkFkqYNu4UAuLncGGsrpfEBhcpzxaTn9YXf
 n+b8c70xGTTERdN1s7ci+xzaCMEqIHTb6klQ67NdZQ1yQsud/EMhFvHvxUdoe4NqSiyL
 etz8Pb/qdJfJsnI1Wch1ZG51XNdHXPOGlJsQtvAZoynQ1+MyJtft599+J+NYDjag8IFM
 95iGzINDyqv/qsVVjgqonpzaMHyYhuGvi8+Uf64wGsslerfACBC2X/yWt+pqw7XU9qKB
 3wqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMRYZNy5ucTO8yldU06P8u35LiKr5NeWJQyO/R2RzuSB7dHohRAGMuufHGRTGpv9oB91+K3GY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0rvNaqzrCcnVArc2mz2I3TG6Grtnu5u9P6z3XWVZ/1CqELg4U
 GBtMa2pgJLN/XEBMNPNY3+b66ejhUiY4RXzAXndq9FHi6ZB3yzYxt2gDqEJzxg==
X-Gm-Gg: ASbGncvxbVsauZ+Q6CxWXoOqz0F9Lx3K/u214uTykYlfCiyTmp6TJADuTSvC+q4J06n
 UHV/i6ypr4H19B1Am5xZZzxwr5Wpi6N2mPdR62YfmA7hmrGNAhTbv+DLLfUtklvc/a10C+jcUgY
 zAdAVM74kBijP6Gud8WEQCn14ZM0Ita+6ozvVNFhZ2gyZDa81jfPn6HRwIDItm8hMRsZ5InQlJb
 thsYleyo4kbNP0vn+cxplp9mpCN3UyDSvM/kugMmpXcJuQlw4X4QyzEHuhqkDuTXEiDtGioP9uf
 XTkWVJNfVA+uNMQKQnLvKcTFNtixoFL0VdzWlZiu26kc/8iguzr7j0BsPI0JpKg+1gqWNAVJoP4
 gGz1+V5/6mZHdMbfgSbNuymhZvb3RfS8acgqo0uGIxrZ5prgPh8tIKfnKnU2ajjU8LexLoeYA
X-Google-Smtp-Source: AGHT+IF15e892Rk+uPpvHpj9mShkOLQKP2Jq9HzTm3tVNDUZ1bPalhR0DXIiwYsa2Oq+tRdP0SUKsQ==
X-Received: by 2002:a05:6000:420e:b0:3b7:861f:4887 with SMTP id
 ffacd0b85a97d-3b7861f521fmr828730f8f.3.1753617489702; 
 Sun, 27 Jul 2025 04:58:09 -0700 (PDT)
Received: from Ansuel-XPS. (host-80-181-255-224.retail.telecomitalia.it.
 [80.181.255.224]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f045f3sm5483625f8f.46.2025.07.27.04.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 04:58:09 -0700 (PDT)
Message-ID: <68861451.050a0220.a546a.2ace@mx.google.com>
X-Google-Original-Message-ID: <aIYUTpr2LQb61Zg1@Ansuel-XPS.>
Date: Sun, 27 Jul 2025 13:58:06 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
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

On Thu, Jul 24, 2025 at 01:30:45PM +0300, Mikhail Kshevetskiy wrote:
> 
> On 22.07.2025 21:44, Christian Marangi wrote:
> > There are multiple version of the same reference board with different
> > RAM size and it's not enough to base the RAM size entirely from DT. To
> > better support it use the get_ram_size way to scan for the actual RAM
> > size of Airoha SoC and increase the size of the memory map.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> > index d149e0ee3c8..0f72365c4ab 100644
> > --- a/arch/arm/mach-airoha/an7581/init.c
> > +++ b/arch/arm/mach-airoha/an7581/init.c
> > @@ -2,10 +2,14 @@
> >  
> >  #include <fdtdec.h>
> >  #include <init.h>
> > +#include <linux/sizes.h>
> >  #include <sysreset.h>
> >  #include <asm/armv8/mmu.h>
> > +#include <asm/global_data.h>
> >  #include <asm/system.h>
> >  
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> >  int print_cpuinfo(void)
> >  {
> >  	printf("CPU:   Airoha AN7581\n");
> > @@ -14,12 +18,23 @@ int print_cpuinfo(void)
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
> Can we use a memory size passed by airoha trusted firmware instead of
> playing with  get_ram_size()?
>

Hi I received some feedback from Airoha about this and sadly it's not
possible. There are too much version of ATF and only some of them
provide RAM size in some way or another. Also there isn't an exact HW
trap to read to know the RAM size hence raw testing the ram and not
depending externally is the only solution :(

I will address all the other comments.

> > +
> > +	return 0;
> >  }
> >  
> >  int dram_init_banksize(void)
> >  {
> > -	return fdtdec_setup_memory_banksize();
> > +	gd->bd->bi_dram[0].start = gd->ram_base;
> > +	gd->bd->bi_dram[0].size = gd->ram_size;
> as I know u-boot can safely use only 2Gb of memory, thus it's better
> 
>         #define CFG_MAX_MEM_MAPPED  SZ_2G
> 
> and replace above line with
> 
>         gd->bd->bi_dram[0].size = get_effective_memsize();
> 
> > +
> > +	return 0;
> >  }
> >  
> >  void reset_cpu(void)
> > @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
> >  		/* DDR */
> >  		.virt = 0x80000000UL,
> >  		.phys = 0x80000000UL,
> > -		.size = 0x80000000UL,
> > +		.size = 0x200000000ULL,
> >  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> >  	}, {
> >  		.virt = 0x00000000UL,
> >  		.phys = 0x00000000UL,
> > -		.size = 0x20000000UL,
> > +		.size = 0x40000000UL,
> >  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> >  			 PTE_BLOCK_NON_SHARE |
> >  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN

-- 
	Ansuel
