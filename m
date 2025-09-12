Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7E9CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 07:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3D1833E9;
	Fri, 12 Sep 2025 09:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A53vTMHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECDC833EC; Fri, 12 Sep 2025 09:27:37 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A8F83322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 09:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d603b60cbso14451817b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757662052; x=1758266852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DkeCQ3JBQWxpJy+hqbZLKXg8JSsnZ62LYmY5us1geqM=;
 b=A53vTMHBjauv0/L8XVkFruJ5XZ1wG24wJ+ocJkTC+XsyXPK5hfU4FOn8O8HG3kEh3U
 6gN2WuYxymoCPTsmGNpXrzjwdMMiCJ0Tk9DegM0kPuzKCe99HuYcOrvyb0yzcsQTZ7Xp
 VAqm9l+VdaMAyzFQm91Y9RcMAo9jykKP6jBZ/aZotzo40AzBhX91gJB/tk2n4Tb8Fz83
 k69t6LXoc2fA51f6yAFBo3uLR1v8PKezhE0HPv7ZEsSa2fP4X7B3Y1Fp4Xw7BwnhelS9
 U0RHnua2fym+MOcNO7lb7GLsYJc2+NzHau4pBhBlc0Wtg1bmK+WkCmp1ujxzsZZ34spP
 f8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757662052; x=1758266852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DkeCQ3JBQWxpJy+hqbZLKXg8JSsnZ62LYmY5us1geqM=;
 b=Ai8alvw+HGqFm3404ws2b3IlZ5W7r7k84pRbbjqhclsaVqgc5c69j8BCId0+WkRrsI
 V6sGncmmi6PNr1Zc9sYj3dKlKChqq1HwNVwmtAfiivi9IDqRb4lEqO2Aq7kRJp6jucjG
 4iJyedeVi9NwuUSqYIDfJI/BrHNbXhkTi6OMNELDra6tEEByqEoLq/5a6ZEH1NZrsP4U
 v2GQUyCG0f9rtg2TlirTXfLf8dV9IZ4REZBgPk/2Vu5Mr+Vy8ZaztJVg3FF0VMEIL4sC
 ydrlOa5WoJ26eowu6xdczUQl9XeygypAXAvfGppS0CTzqU6aPhvOpjPfyGNaxL+MXKlF
 MKnQ==
X-Gm-Message-State: AOJu0Yz4uDV8DqC8r2gztZ8qmwA4Wxq+jKJ8v1vD+Cu4xOA8xHHjcd0z
 dYhB+Ml6yyUqLEUXAtCdx94334GRoxNupo2whVl6LBE/bKNikaG0kmRW91gK5q+ojNx0ILbr0me
 DK1b8WYtdRu2DaqoiNLvfEmSXFu0APiiHzTMleDtksA==
X-Gm-Gg: ASbGncsWnKcOexXz718VjQdZkLF9c34DjHfBX/j8M1HWBDMQBTpNn4z+whDAAGv/Q5o
 /T1tH/6Xp8AzCYXHFBBBnLsrIHA6/nVF3c8pGxTubpITNPZ6C+vshUHHN/w4YnZfICpPVcifAkY
 5Cvsracw8x1/B/kFUmFuu46VAQj0YV48uSNnkvBJJ0tztAQGQfiVGvdjv8roJyVpgHMnmw8SV4G
 dIEryr1KeLumob9cYraiNOs4QGVkjb5CHfNyE/lzwYxS8t8JU813BWxR1RDcpnBxMF8q6K3fmg9
 MkIoS5q1Kk+6dApfmcrTMZ70e9PW4tHxBdJwllrAvcH5ygmbOZCJWZwfZU8Mx/dgFIG5IKux8F4
 h34bH4aLB
X-Google-Smtp-Source: AGHT+IElpBp8OFR7TF9uHWL22dMGXi1M9+JHoF2igtq7+ZjBxuvG0un1K7nB9z9GrAJyOMsEFN/d4zJ9VqLNd86oojg=
X-Received: by 2002:a05:690c:9a8d:b0:71f:ecde:87ac with SMTP id
 00721157ae682-7306376e968mr20545487b3.16.1757662052428; Fri, 12 Sep 2025
 00:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-6-anshuld@ti.com>
 <CAC_iWjJos1Xu0LWK4aqJ9aq2UZhor8uvnGRVg1xKs69HmnhP6A@mail.gmail.com>
 <DCQM5KG6M5Q1.3POA3UVZ1J563@ti.com>
In-Reply-To: <DCQM5KG6M5Q1.3POA3UVZ1J563@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Sep 2025 10:26:56 +0300
X-Gm-Features: Ac12FXwrY8UlqPBQAMAJ0obYlxt4yjBGk9jh6QSmzK-uocBOsdxP1ESJG-GeV_s
Message-ID: <CAC_iWjLKGe8CUhA42M_2BEd7gDKT0pW+FWFwmCcoiVcU6YUPmw@mail.gmail.com>
Subject: Re: [PATCH -next v6 05/10] arm: armv8: mmu: add mem_map_fix_dram_banks
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 a-nandan@ti.com, afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 12 Sept 2025 at 09:38, Anshul Dalal <anshuld@ti.com> wrote:
>
> Hi Ilias,
>
> On Fri Sep 12, 2025 at 12:03 PM IST, Ilias Apalodimas wrote:
> > Hi Anshul,
> >
> > On Fri, 5 Sept 2025 at 11:19, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> >> the MMU as part of mmu_setup.
> >>
> >> But since the exact configuration of memory banks might not be known at
> >> build time, many platforms such as imx9, versal2 etc. utilize
> >> gd->bd->bi_dram to configure the static map at runtime.
> >>
> >> Therefore this patch adds a new API mem_map_fix_dram_banks that modifies
> >> the static map in a similar way. Allowing for anyone to map all dram
> >> banks by just passing the index to last entry in their mem_map and it's
> >> length.
> >>
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  arch/arm/cpu/armv8/cache_v8.c    | 27 +++++++++++++++++++++++++++
> >>  arch/arm/include/asm/armv8/mmu.h | 10 ++++++++++
> >>  2 files changed, 37 insertions(+)
> >>
> >> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> >> index 6e662395a83..edb895da1f2 100644
> >> --- a/arch/arm/cpu/armv8/cache_v8.c
> >> +++ b/arch/arm/cpu/armv8/cache_v8.c
> >> @@ -58,6 +58,33 @@ static int get_effective_el(void)
> >>         return el;
> >>  }
> >>
> >> +int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs)
> >> +{
> >> +       unsigned int i;
> >> +       int ret = fdtdec_setup_memory_banksize();
> >> +
> >> +       if (ret) {
> >> +               printf("%s: Failed to setup dram banks\n", __func__);
> >> +               return ret;
> >> +       }
> >> +
> >> +       if (index + CONFIG_NR_DRAM_BANKS >= len) {
> >> +               printf("%s: Not sufficient space in memory map\n", __func__);
> >> +               return -ENOMEM;
> >> +       }
> >
> > The length of the mem_map array is configured at compile time.
> > So this is going to fail for all existing boards unless someone
> > explicitly changes the size of their struct mm_region.
> > I think if we go down that path, we need to change the error message
> > as well and point them to the right direction
> >
> >> +
> >> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> >> +               mem_map[index].virt = gd->bd->bi_dram[i].start;
> >> +               mem_map[index].phys = gd->bd->bi_dram[i].start;
> >> +               mem_map[index].size = gd->bd->bi_dram[i].size;
> >> +               mem_map[index].attrs = attrs;
> >> +               index++;
> >> +       }
> >> +
> >> +       mem_map[index] = (const struct mm_region){ 0 };
> >
> > Why do you need the const?
> > Can we do
> > memset(&mem_map[index], 0, sizeof(mem_map[index]));
> > instead?
> >
>
> Yeah, we could do that instead. But it essentially achieves the same
> thing, right?

Yes, i just find it a bit easier to read

Cheers
/Ilias
>
> Regards,
> Anshul
