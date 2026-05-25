Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F25DCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A99E8460E;
	Mon, 25 May 2026 13:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tXtSkwMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9784F84671; Mon, 25 May 2026 13:36:18 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA90844CF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso3555401d50.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779708974; cv=none;
 d=google.com; s=arc-20240605;
 b=Es/NtC1VC3dptbI5RxkQkpS58wkU7q9aG1PNIoYGFffkVDj/BL9gBmNnVN8QoDOzSW
 s9us5fEVwv3EvLOrpfOgnthWltDAaGSN4nlg/eBokzdQXJ+eAC9RrzxAh1usKG8kx0Cg
 8ROs/c0TOnFXvT2WHEbLltYfPHYuzbwIEz4sHLpI28dt07ooSUZMzHE/ygYR7o8WqUOo
 fAA9x7fXojIvQ39KwPe46hAnbGOEDy3B123x2Wm49e+VtMBcwWIBQRwEAzZcuw8zxuoK
 UOUBIxpv6do91pCduQRykZgM9eAuf6tQtSCjk4vnm4hUXkZ3l7qypODyyACanfwl+TVY
 Jcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+BFnMhCkEJ7BduFd9L30jY0xsjR8SLwty/9BLtbxI4Q=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=UzGZjFbSwV+2R+NQe+o/OJRIXPGFDCJvuBWSqbPvAXt13TnUkFvbNObCj2+ieDSdCX
 RV5MQICDRjcz8E4r513HkFv8HMAgx17XbbUGpX58fdIQYmyl5hIreqsJLHKgl9L7ECDt
 wxzXB4cApsOB3IiXt35mUv+hCAgZiZwwMp3A0IQN2c3mKAg7uV4PSIMGNCVcCaOUx7AM
 Wn5KC/35Ub8mU860te6Hl4Uv1GlP9WMhC7awKhyLFGOA+HmU1AggxY5qMMwRL9spPLWn
 EUvRnDNk+fm2RIeun6g6jx7J8VUIARW58xqtJKvQvEh9CTmPsslg0B172CR5zpNkalaA
 snAg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779708974; x=1780313774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+BFnMhCkEJ7BduFd9L30jY0xsjR8SLwty/9BLtbxI4Q=;
 b=tXtSkwMFdkwah4Kuf+mj2iLgQikk3SY9wkgfIuHZ/X3rITEsnjdtb0WGmEBEbOPSIV
 0XVCp2z7+272SEJSlIUHXNuvgePeJypQ0F4AcsSH/xU9fVtjILKtjnrRIN7RXsi7HjTS
 /q7TUR8LB3VjzgNzO+pdYQ7NvI/RPfGRdQu5OIuys0OOw2ok5tv6/WV07hdhoeZT3hYG
 kDX1vJfNqkC4X7ePasGtRQWTau4PNlVH19YZJYWNaUlpNgNe6y98cGytqHFjjgXW3IkB
 O6MvoczkjyiRIbMHGdg7bEBKSRSdj+W8rXYn1Z8pTLOL8XFng/i44rT7xF5cja7lY4oi
 IgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708974; x=1780313774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BFnMhCkEJ7BduFd9L30jY0xsjR8SLwty/9BLtbxI4Q=;
 b=Jwf3ta/RHsM1CaE3F3OonfQFnQmBrkKU81RlTYwHpoXprcmd3iJ613IqX6kGo0rU6S
 l8aU7XABfAvN+d35rHRS0JJ7Jc+r6MbwiRlyN4tE17Lv89d5TxoW6kknGvB3EzNlwh95
 OhpNOzrrJKvMuBqBLpr6pRmgUsOrLCcEOQ9E5TjaB+/ndbMI7NNiR/Ipz3yWh4aPuUAl
 UH01JGMqvxqX4loK1drqvSry9W+OCIEA9rL+gAqr8XA3Du9RmaFLVmHuLc7NWv/vfCY1
 HXqa3NzOKqdsEDjfh6URQUHu5L6pTYVw0Uq4Y5926UF/aVrJcWJA8qqPAwx8STR9p5bs
 BMWQ==
X-Gm-Message-State: AOJu0Yw+q+q7r5jjG4Gh6FhQ/fvKizGHmSfjZvRD6ChOXbJJpnhrTFlf
 qkBKc2ImlHipYp+bujRmgGA/1c6Ta0VhogirXyG3SpIid9g554HGw7byE3yWaMcrh7btRFKydun
 GAp32PPsDdw/jJdBy9E+GurXjeA1I9+SKSxdE0doacg==
X-Gm-Gg: Acq92OFXjktmu4qEUwD8xgQwMIdsG+Blnu/35Fr8wzd0G4mdWwmtt7y2gC+5zZGwwVL
 u5B7S22eRmT708opvHsVhwKvbOtVImeaKWf5+RLIsncR/AJ8XF2aFgOgR/2f9rMXvM0R99+S/jJ
 iTyd+dJRAufbQz54GULq3SM+ZCWOXXH4gohc1GT7z2b0rYBPTd7bNiKOTH9bf8fylLNpG0C+v0D
 NNl1G5vn+Y4M+rYSa+EMZI9yVHgqx7AtaGGOHdrZs+v11QQpw7OiZT8fexyEbywCMo1055JJfpJ
 49K2aNQqK8DqkTFPeLe1ytHHGhPDwhy/KNODngz/ZNsUsEpf/HV61qTNu7ERUpuMGXLou03s1nt
 Wgr41sS8FlUCV9OsWSfXk1f4Tasv4TQlRx+oM7kKPZatWgjpYcnyXNpcWitPd4IjmlsWyEAva6g
 LffVTZ8pBDVYqsIJlKsJ9FWAz/c1NEC8aZnVtscsfCUlS1l5CAUe1uP7eXM1U0Y0+1B6KaqL/Aa
 EBuGXFz3Phhc0I4J8dh8vKBnqwzoSXqsnPUYpVzyG16aXi2tWu7M0XF0S1tdvvAd9AUGNhQTCFn
 aI81NcPlQdI+OOfsHqMT/edjvsuucROTmgzcP9/dG7cocwK4kHZc3/lEPuk1AZWxEg4lnnQUtdp
 lpnqRyA==
X-Received: by 2002:a05:690e:4186:b0:651:c20e:a43 with SMTP id
 956f58d0204a3-65ec95f1d06mr12069561d50.6.1779708974225; Mon, 25 May 2026
 04:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-2-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-2-7802245a40a2@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 May 2026 14:35:38 +0300
X-Gm-Features: AVHnY4KCGqHQbqcGMDoCOLtgQmW6UybfvdBjLSevcF_sLaEp9OyfOC38tt8X888
Message-ID: <CAC_iWjJqSO42-w1Yk3+-bbjsGswBaZmg9Smo1CSpJMrP67cpRw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
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

On Mon, 18 May 2026 at 12:00, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> When a region is explicitly unmapped (like with
> mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
> still remains but won't be used since the region is marked invalid.
> Print these regions when we dump the pagetable to help with debugging.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 97a1c39ed268..2800ba57a464 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
>
>                 if (exit)
>                         return;
>
> -               if (pte_type(&pte) == PTE_TYPE_FAULT)
> +               if (!pte)
>                         continue;
>
>                 attrs = pte & ALL_ATTRS;
>                 /* If we're currently inside a block or set of pages */
> @@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
>
>                         /* Go down a level */
>                         __pagetable_walk(_addr, tcr, level + 1, cb, priv);
>                         state[level] = WALKER_STATE_START;
> -               } else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
> +               } else {
>                         /* We foud a block or page, start walking */
>                         entry_start = pte;
>                         state[level] = WALKER_STATE_REGION;
>                 }
> @@ -707,8 +707,12 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
>  {
>         u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
>         int indent = va_bits < 39 ? level - 1 : level;
>
> +       /* Ignore empty blocks */
> +       if (!start_attrs)
> +               return false;

I am not sure I am following this one. This one get the value of
TTBR_ELx. What are we trying to prevent? Perhaps we should move the
check to walk_pagetable()?

Cheers
/Ilias
> +
>         printf("%*s", indent * 2, "");
>         if (PTE_IS_TABLE(start_attrs, level))
>                 printf("[%#016llx]%19s", _addr, "");
>         else
>
> --
> 2.53.0
>
