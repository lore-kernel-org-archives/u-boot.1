Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4838FE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF941800D7;
	Fri, 13 Dec 2024 15:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yFAzhbyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE53680104; Fri, 13 Dec 2024 15:31:17 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362A38021D
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so3122807a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734100275; x=1734705075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a8OdqOVUrnRO0M+eyymuEifvO/5SwQPJmPjaXRkypDM=;
 b=yFAzhbyZodSRXj2Cxh7BWmp6zLXGL4fUMcmCdG2jDkbYynHnTs31U0ZHOxkCBVnFwR
 ohIci2QTxma5OyGhgGpTrkjwyLJ3+wJe2oD+y99uQF6z0oK7PQGl4vAwduM+jmEO629/
 B8VwrnG7RsTjYw82b6OlTfI3+MzoLW/+beRUGfM14lOuLj2A0YMA3iHWMX33z3IFBrnp
 tMAarCdBk/WzF+girQzv9cWwUg6zHby5OmI9yxSsHNzBIM7yllSx7JEG9kz3aslHQsLb
 9w4MbBCL7NV3YuE/qBsJ50iu4Jf8bTm1B3+NK2lt9HqPhEpNF2WcmTWD77lGQuAuxYDV
 Xf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100275; x=1734705075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8OdqOVUrnRO0M+eyymuEifvO/5SwQPJmPjaXRkypDM=;
 b=sMSyqdEJp2x9QOTK3Y6EgcYqia56DF10gZGWDmZAuWomD0QjbEZVM8Pt/aVIDf3hE/
 G0nFIMMrl7+TFUcQSlV8VhB2Q446VW3x8BiH6tykuKfTubaZIcvi6NiztlqIHaGiIzAT
 oicqySBi1PzXNwMxfpSDgGzvOeC+g5VUeNRvD1Agg793uZNMZMSvRwaOqavMJkvPJwy8
 oKonwJ2NET9Vv3kYPTkcYCgo1JyYm/pfpIPMqpxsS6XoiD73DJa+RDTsFEhK2Nc4WPWK
 gOtzPkZdHs2A8GAdREJ+5O+YNB3AelGO+WLPLZ1HQGMDv5QBqu3/jayIkxt39GRgF0pl
 M6RQ==
X-Gm-Message-State: AOJu0YzlAaDkRqGQ7mr1w8R6hhbNR/O7S0IXsBeOwt/PqITiTLIVUEGB
 WOKCkJCtqI4XP9GHyOsSO0j/om8yqnE/gqbvs6rDxy4JXiMrzuE+2pg9rzL1VC61WeP3ToHkTN+
 bBrhJuItXQgu03cl0mZKmd2aXeRMVxZMcs4ZiUj06CObWJcYkChk=
X-Gm-Gg: ASbGncsQehw0XBgFG42etqeCpgDqd7KYixvSxbO9cymUEUTV0+uJOVgVn4bjLcWtaPm
 Dw2JHi20TII3AtZv4iwiEaoygC5l1b/QkYN6BoQ==
X-Google-Smtp-Source: AGHT+IHRl4htuJVgS14ECqteZzX4zrvmCBcnQL53L6rijF7j34vQQ5UqCttuRTtHP3sJ5ToyOMe9qByAWYt8jcRFkcI=
X-Received: by 2002:a05:6402:40d4:b0:5d0:ed71:3ce4 with SMTP id
 4fb4d7f45d1cf-5d63c2e9060mr2404326a12.6.1734100274596; Fri, 13 Dec 2024
 06:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20241213132655.670837-1-patrice.chotard@foss.st.com>
In-Reply-To: <20241213132655.670837-1-patrice.chotard@foss.st.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 13 Dec 2024 20:01:03 +0530
Message-ID: <CADg8p977UDbohn7M7UdfMbq8qB7qEc1NzvFxDnYV9krdaJpuiA@mail.gmail.com>
Subject: Re: [PATCH] ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located
 above ram_top
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On Fri, 13 Dec 2024 at 18:59, Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> Previously, all LMB marked with LMB_NOMAP (above and below ram_top)
> are considered as invalid entry in TLB.
>
> Since commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top
>  even from same bank") all LMB located above ram_top are now marked
> LMB_NOOVERWRITE and no more LMB_MAP.
>
> This area above ram_top is reserved for OPTEE and must not be cacheable,
> otherwise this leads to a Panic on some boards (Issue on STM32MP135F-DK).
>
> Restore previous behavior by marking invalid entry all TLB above ram_top.
>
> Fixes: 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> index 62cc98910a7..cb1b84c9af9 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> @@ -53,6 +53,7 @@ void dram_bank_mmu_setup(int bank)
>         struct bd_info *bd = gd->bd;
>         int     i;
>         phys_addr_t start;
> +       phys_addr_t addr;
>         phys_size_t size;
>         bool use_lmb = false;
>         enum dcache_option option;
> @@ -77,8 +78,12 @@ void dram_bank_mmu_setup(int bank)
>         for (i = start >> MMU_SECTION_SHIFT;
>              i < (start >> MMU_SECTION_SHIFT) + (size >> MMU_SECTION_SHIFT);
>              i++) {
> +               addr = i << MMU_SECTION_SHIFT;
>                 option = DCACHE_DEFAULT_OPTION;
> -               if (use_lmb && lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP))
> +               if (use_lmb &&
> +                   (lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP) ||
> +                   addr >= gd->ram_top)
> +                  )
>                         option = 0; /* INVALID ENTRY in TLB */
>                 set_section_dcache(i, option);
>         }
> --
> 2.25.1
>
