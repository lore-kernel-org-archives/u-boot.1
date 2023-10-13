Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D3CDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 03:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45047868BF;
	Fri, 13 Oct 2023 04:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K04HvcT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2091986AE6; Fri, 13 Oct 2023 04:44:25 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2A586EA1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 04:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50435a9f800so2170518e87.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697164836; x=1697769636; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtoChQc8CAxwtrNDhhDdnBk+69qcpr9iVX9ibw+AeZs=;
 b=K04HvcT6ZzUXf62kPUHxw/7HR3DD7jfBFhY34cgl5cf+hyTeR5QPtJvNWDsXzP7KKU
 hu55vzkeJNZDY2B8ubkeh/2d0s4mp5uRO+Biz/SKZ3P8MH6cMoxNCMp8z4GPgcRYyDK8
 1VflQISydwrjvGUqfFZX+Gm7UCafcY8FhphpDuhLkA7Ui0mFgZbeeUd+j5nlet2y7pNq
 ocg6WpZBRlsuUCbkCAFW8qegm5C7cbg1XXfCAOiVsD5jqLcJ9p/svGIYE0SNmkDItr3e
 hAZc/nn5jRwnhCd+4FdwhyOgS8ZEOoMMMpxbGM6AhKsZZldq8lAXwa7P140CoY/9SFZH
 VQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697164836; x=1697769636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtoChQc8CAxwtrNDhhDdnBk+69qcpr9iVX9ibw+AeZs=;
 b=AgjXy+8Tg701GVbXQDepTjWGWp+7lG5ZkWFs+yDC7a196hJoHG/5DxpplPUQT0dm23
 fZEjFj1jJVo8x2aVjlJ0WNrcfGlf99PUafy5Q2bX9Vj72xkT9RwcMjcJiurugZcGP862
 B1GpwxvKegvez61/sDPMGNnHuySij3421f+Tz18fLjem9SAREt6qBHyU/Lde7USw9xhT
 KbtefEZcgPhIKCA0G+3IJa4hDrZA5BhvWZGydCOYy7QlhVPRHzC0DzJfti6JMsKgTI3z
 abRcHF9+/av14WGOAJxC3KZwT8XZh72Uu09lht6IoeEHIK5XNZoFQikZ94abQVmMF/Pm
 giAQ==
X-Gm-Message-State: AOJu0YzfHm3hgfgx9wkowJsacJ/iIPsHh0+xQZKoAxpivoPUj7Bs0pU6
 UTsqWueMcGSQCs7su5suPmG22L1PmOGlsdqryWY=
X-Google-Smtp-Source: AGHT+IElZ+SWC+vHqH/WUzk/ZOonSAPkgQ240459S7Fmtk4gTPIFTrhF0Tfzrv7vb9stf5X+VL5pU5DhOfpTF7+tv6c=
X-Received: by 2002:ac2:44af:0:b0:505:7ac4:239 with SMTP id
 c15-20020ac244af000000b005057ac40239mr18805144lfm.1.1697164835859; Thu, 12
 Oct 2023 19:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230317162253.1049446-1-paul.liu@linaro.org>
 <20230317162253.1049446-2-paul.liu@linaro.org>
In-Reply-To: <20230317162253.1049446-2-paul.liu@linaro.org>
From: Chris Packham <judge.packham@gmail.com>
Date: Fri, 13 Oct 2023 15:40:24 +1300
Message-ID: <CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=J0oHyvN75bTaCUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: Use FEAT_HAFDBS to track dirty pages when
 available
To: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marc, Paul,

On Sat, Mar 18, 2023 at 5:23=E2=80=AFAM Ying-Chun Liu (PaulLiu)
<paul.liu@linaro.org> wrote:
>
> From: Marc Zyngier <maz@kernel.org>
>
> Some recent arm64 cores have a facility that allows the page
> table walker to track the dirty state of a page. This makes it
> really efficient to perform CMOs by VA as we only need to look
> at dirty pages.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> [ Paul: pick from the Android tree. Rebase to the upstream ]
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Link: https://android.googlesource.com/platform/external/u-boot/+/3c43372=
4e6f830a6b2edd5ec3d4a504794887263

I think this may have caused a regression for the Marvell AC5X
board(s). I found that v2023.07 locked up at boot but v2023.01 was
fine. The lockup seemed to be in the 'Net:' init probably just as the
mvneta driver was being initialised.

A git bisect led me to this change although for this specific change
instead of the lockup I get a crash so maybe I'm actually hitting a
different issue.

Any thoughts as to why this may have caused problems?

> ---
>  arch/arm/cpu/armv8/cache_v8.c      | 16 +++++++++++++++-
>  arch/arm/include/asm/armv8/mmu.h   | 14 ++++++++++----
>  arch/arm/include/asm/global_data.h |  1 +
>  3 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.=
c
> index 697334086f..4760064ee1 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -93,6 +93,8 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
>
>         if (el =3D=3D 1) {
>                 tcr =3D TCR_EL1_RSVD | (ips << 32) | TCR_EPD1_DISABLE;
> +               if (gd->arch.has_hafdbs)
> +                       tcr |=3D TCR_HA | TCR_HD;
>         } else if (el =3D=3D 2) {
>                 tcr =3D TCR_EL2_RSVD | (ips << 16);
>         } else {
> @@ -200,6 +202,9 @@ static void __cmo_on_leaves(void (*cmo_fn)(unsigned l=
ong, unsigned long),
>                     attrs !=3D PTE_BLOCK_MEMTYPE(MT_NORMAL_NC))
>                         continue;
>
> +               if (gd->arch.has_hafdbs && (pte & (PTE_RDONLY | PTE_DBM))=
 !=3D PTE_DBM)
> +                       continue;
> +
>                 end =3D va + BIT(level2shift(level)) - 1;
>
>                 /* No intersection with RAM? */
> @@ -348,6 +353,9 @@ static void add_map(struct mm_region *map)
>         if (va_bits < 39)
>                 level =3D 1;
>
> +       if (gd->arch.has_hafdbs)
> +               attrs |=3D PTE_DBM | PTE_RDONLY;
> +
>         map_range(map->virt, map->phys, map->size, level,
>                   (u64 *)gd->arch.tlb_addr, attrs);
>  }
> @@ -399,7 +407,13 @@ static int count_ranges(void)
>  __weak u64 get_page_table_size(void)
>  {
>         u64 one_pt =3D MAX_PTE_ENTRIES * sizeof(u64);
> -       u64 size;
> +       u64 size, mmfr1;
> +
> +       asm volatile("mrs %0, id_aa64mmfr1_el1" : "=3Dr" (mmfr1));
> +       if ((mmfr1 & 0xf) =3D=3D 2)
> +               gd->arch.has_hafdbs =3D true;
> +       else
> +               gd->arch.has_hafdbs =3D false;
>
>         /* Account for all page tables we would need to cover our memory =
map */
>         size =3D one_pt * count_ranges();
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv=
8/mmu.h
> index 9f58cedb65..98a27db316 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -49,10 +49,13 @@
>  #define PTE_TYPE_BLOCK         (1 << 0)
>  #define PTE_TYPE_VALID         (1 << 0)
>
> -#define PTE_TABLE_PXN          (1UL << 59)
> -#define PTE_TABLE_XN           (1UL << 60)
> -#define PTE_TABLE_AP           (1UL << 61)
> -#define PTE_TABLE_NS           (1UL << 63)
> +#define PTE_RDONLY             BIT(7)
> +#define PTE_DBM                        BIT(51)
> +
> +#define PTE_TABLE_PXN          BIT(59)
> +#define PTE_TABLE_XN           BIT(60)
> +#define PTE_TABLE_AP           BIT(61)
> +#define PTE_TABLE_NS           BIT(63)
>
>  /*
>   * Block
> @@ -99,6 +102,9 @@
>  #define TCR_TG0_16K            (2 << 14)
>  #define TCR_EPD1_DISABLE       (1 << 23)
>
> +#define TCR_HA                 BIT(39)
> +#define TCR_HD                 BIT(40)
> +
>  #define TCR_EL1_RSVD           (1U << 31)
>  #define TCR_EL2_RSVD           (1U << 31 | 1 << 23)
>  #define TCR_EL3_RSVD           (1U << 31 | 1 << 23)
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/gl=
obal_data.h
> index 9e746e380a..eda99b5b41 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -52,6 +52,7 @@ struct arch_global_data {
>  #if defined(CONFIG_ARM64)
>         unsigned long tlb_fillptr;
>         unsigned long tlb_emerg;
> +       bool has_hafdbs;
>  #endif
>  #endif
>  #ifdef CFG_SYS_MEM_RESERVE_SECURE
> --
> 2.39.2
>
