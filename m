Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF8CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 06:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA08F8334F;
	Fri, 12 Sep 2025 08:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nJPy7Kgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F31833E9; Fri, 12 Sep 2025 08:03:20 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532A483322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 08:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-ea3dbcc5410so243882276.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757656996; x=1758261796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4mnu/31a25tt2HrIbsh8Mbvvv9s+dpqHhl8F7N4IGpY=;
 b=nJPy7KguqAk6Qe6ijYh/C6ECgXT6OgLnXWP/jRUG4rt/hQ6KzA/MSy/7yrzcInA4rt
 u3+H8EGOUaS6KlMCH9J2ainJXKKMaJGmE8lMimlZfZuGin8Yj2YLghoKhIOMfGVJV3f9
 8bn9E0qthq1s8Gey8UdeQ/nhlh+x08+q6XqbOEYMV+rbB1ShNyt8hypoFUIWNazcHNTs
 nuZak0VqlA9DugcUlzlLMzfJcK4QMMfo3flSIqmfIn+Mrj8/5FssKhJjvJVwj3TPNsLT
 SaGpcAxJemOl9TtgsNoxbvXxyRRBIfAcWoVWM6rF7hffOFMPjjYlwZdIITxhQzFfcThg
 rAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757656996; x=1758261796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mnu/31a25tt2HrIbsh8Mbvvv9s+dpqHhl8F7N4IGpY=;
 b=IK0up6tRy+7JDJOsrkqVvmI+LH1ZWZMNK4GQW5uh1QCq6tIpeJLnFVwJ/EBiB7N62C
 C4WR1vFJ8Tb8o14PWG7mbrlztvpzYarTjgkVmOUqzW6g+NB+T4WsKVoD0TvT/rJ8ujHp
 Zx0pyFkHZ1hxRFINQ+FVHqBMVCiHVBcCu6ZFcJScPt7IN+RYNS7JFekLl7lmL8swXyjv
 mY0M8cNgMJIe58oDUr9lkD7Gi73rh32R5p3ikP0l2pIS8D+N6rbJHOWPSF/yxQkFM5eG
 d336YJNebIv9ldBPqOVLidxmCswmJ+BZC0xEfGKLJ1ohagwL6gHXy1k8zCOq8hoa7ykB
 IrDA==
X-Gm-Message-State: AOJu0YwSA2JYVYmRSXTM7H69od654UUQB9W6o3HXblUwLh5OIXZdDDi4
 xPR91AcByV0+6GsgugnC2Gef6EwpQ0XT9u1vITVCLCcQb6e1zVAR4EWZDYyqQj75uij4Ke/D12o
 cGoOJ1kAjaGONPzKzj02NnKYSSB4S4UW9PuHhKTOKJw==
X-Gm-Gg: ASbGncvUxA9Gk9YAkjWDBfAbe8AdPACruuhJvs4GA4lKI9HCPrfS/Onr5RuCr64WNDU
 bFphBBY7XD4DPjYs9GTA6GKCYQoEySiC+wvoUXsbz1COUdEfsuZevmrBBDyYtHlfjncQPLobX82
 8wsGdxI0aep8eyUdUNi8cHCe21H+HmxiIqaKMjDJIKY/mXZoSJ7n0ZuW5o8aqD91QBnr6GMhaSQ
 ZNHoHjGWfrZUfbLJacXdnnuI9yT31whhEDw6lLKYmKxHr1VMN0rMP120pZeigRIASFbLs2feR2C
 4opNLwOIFcBcIvSNHPBrHx22BowO1ItffB0oIm0ghbczWa+RiurIOunBaG77PYVowUEHa8GtbQ=
 =
X-Google-Smtp-Source: AGHT+IHl6JvOrHzYC5lgP2U6xrs42PgJh3PuEdj7gIryAMswZ407oVaut6jpWJ8noMxAYMgRjmEGN3ggTAQZhtWF16Y=
X-Received: by 2002:a05:690c:4509:b0:722:7a7f:5358 with SMTP id
 00721157ae682-730626d3e26mr13989207b3.4.1757656996187; Thu, 11 Sep 2025
 23:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-4-anshuld@ti.com>
 <CAC_iWjJhJfQpRjx9qumKZn6cHKOfj2QvhGNbCuHs7S2NFGMNZg@mail.gmail.com>
In-Reply-To: <CAC_iWjJhJfQpRjx9qumKZn6cHKOfj2QvhGNbCuHs7S2NFGMNZg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Sep 2025 09:02:39 +0300
X-Gm-Features: Ac12FXycD_76d6S4f3v6NjFZY10t-G6Hu52U9nhZZFmVg-RVMz_9rdD-DHOYki4
Message-ID: <CAC_iWjJGjynKDyfRQwuKzi5a2D0xYOcdVF79ok+FrupVhf5joQ@mail.gmail.com>
Subject: Re: [PATCH -next v6 03/10] arm: armv8: mmu: export mmu_setup
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

On Fri, 12 Sept 2025 at 08:59, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 5 Sept 2025 at 11:19, Anshul Dalal <anshuld@ti.com> wrote:
> >
> > The mmu_setup function configures the page tables based on the board
> > supplied mem_map struct array. It is called implicitly as part of
> > dcache_enable but this limits us to only be able to use APIs such as
> > mmu_change_region_attr only after caches are enabled.
> >
> > This might lead to speculative accesses before we can unmap a region
> > that is marked as cacheable in the static memory map.
> >
> > Therefore this patch exports the mmu_setup function in mmu.h allowing
> > users to have more control over when the mmu is configured.
> >
> > For K3 specifically this allows for the following configuration sequence
> > as part of enable_caches:
> >
> > static mem_map fixups (TODO) -> mmu_setup -> carveouts using
> > mmu_change_region_attr (TODO) -> icache/dcache enable
> >
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> >  arch/arm/include/asm/armv8/mmu.h | 5 +++++
> >  arch/arm/mach-k3/common.c        | 3 +++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> > index 6af8cd111a4..3807c702fb6 100644
> > --- a/arch/arm/include/asm/armv8/mmu.h
> > +++ b/arch/arm/include/asm/armv8/mmu.h
> > @@ -197,6 +197,11 @@ struct mm_region {
> >  extern struct mm_region *mem_map;
> >  void setup_pgtables(void);
> >  u64 get_tcr(u64 *pips, u64 *pva_bits);
> > +
> > +/**
> > + * mmu_setup() - Sets up the mmu page tables as per mem_map
> > + */
> > +void mmu_setup(void);
> >  #endif
> >
> >  #endif /* _ASM_ARMV8_MMU_H_ */
> > diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> > index 9d6c6fea451..e9b48b528d6 100644
> > --- a/arch/arm/mach-k3/common.c
> > +++ b/arch/arm/mach-k3/common.c
> > @@ -30,6 +30,7 @@
> >  #include <soc.h>
> >  #include <dm/uclass-internal.h>
> >  #include <dm/device-internal.h>
> > +#include <asm/armv8/mmu.h>
> >
> >  #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT       0x00000001
> >  #define PROC_BOOT_STATUS_FLAG_R5_WFI           0x00000002
> > @@ -261,6 +262,8 @@ void board_prep_linux(struct bootm_headers *images)
> >
> >  void enable_caches(void)
> >  {
> > +       mmu_setup();
> > +
>
> mmu_setup() will run twice here. I assume that's ok ?
>
> Thanks
> /Ilias

Oh I misread this. It won't

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >         icache_enable();
> >         dcache_enable();
> >  }
> > --
> > 2.50.1
> >
