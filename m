Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0A1CD4F35
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC67D83FB0;
	Wed, 13 May 2026 13:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CC+qeyys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57D6844BF; Wed, 13 May 2026 13:27:03 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC9C836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c364b893aso6496940d50.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 04:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778671618; cv=none;
 d=google.com; s=arc-20240605;
 b=idNrlyDyB6+1GC9HHCgbaigLoHEeif/MevJQe7lEuOL9Rm0HLqIRaqCqXwn5QFxlKL
 QyppBQ5hPjN20Korw+lLsS0GpniYF2+u7+xmG40m3c5vqZF+OeWxugfp39W24DkAWrE5
 olVv5qC3a3yH4/ULiR30h8m5BxM0BKAvmbqPXpnEqrFw+Fvp/Wsp17zNpEt9vWh0gSgz
 qeMUy+lIvRbCBEnuAYibr7v6H8neY1x1V70++PYy+hIueKnrc3fBWMUfCiwD8qycwwsR
 UyVnmHJolYwzhI4+NjdRrFSU3E3FFreIjO1aE0cyTXoVF9qjrbP9q/nTa+5S0HJaGjgi
 BgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=skB9GYoZzgwMANMCIT5/p17sqgJdt9PmKRkgHNuVfCo=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=I+6ffWO94AZ+WJqQFxijXkxjlneG8bYrs5JAoIVXSTLu0NPQC29AwqU7ukbgoc1Pku
 anQKBMfLbfm0/F16AOXiug57+3QfYFWHc8kWGEg7wtxSUj9ZSPO0cdumQpSy9IG4flN0
 bwD3Tz8XgvcCyCdazumJ4rr5uO4RDjXGzkqPn8qTTEuBh/WsRF2Df/Wu3txQHG9GqoLK
 PZrQRSJFqrVZtoGZCZ22AxOhM4DQfdOg316yWfk51P4en2lSeKLoQAzZmpBftI6C0iQc
 qLmheTdv7Gj/IVKZdj8mu+THE5hk9VZH6/sdjy2aIjBf4LcGJZLmouKQ6Nfdqw1MRuws
 uELQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778671618; x=1779276418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=skB9GYoZzgwMANMCIT5/p17sqgJdt9PmKRkgHNuVfCo=;
 b=CC+qeyys+HmMmQ+2UB6SLqwv3xdxWG+OOPX12u1kE0deZVpAmwBVdVqQzl+0P45eaJ
 CmbiK+ZS72qtbeN8Q9Snt04ob3GFLh5Y/MFKI6SbvVkNyds01M/bfuGNn0NTH4NbknZC
 eGn0DFa8OoezvrEyTD+0wBODzxcVSKwBcGvz+HZym/PrnYv0aUSaTQTRP38EDYGAf6R4
 c1MRLCAFJj+VZCInTykW89811TtfWI8S7x/sWYQxW1oeu8vKsLf9lCY9tFXQ8soeKNqk
 uFqIo2qgxnSgwKay7IxitsfJC7+hu3eW/t5ZJk4HXATaJbo1oGXC+8zvtKsfjelao5px
 lhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778671618; x=1779276418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skB9GYoZzgwMANMCIT5/p17sqgJdt9PmKRkgHNuVfCo=;
 b=VRbTSu+tZdHUCLyaDX8GAEOj57wghSVlFVRPlLBmJV2ApdO+qMsatkbMyLHA3Husco
 w52d8DrRbOxmmFxexYCX2t9cQDn2nT4hKi5JyBTS3Fk8RPs4ebDOrQnVhiWz9fxrUpx/
 pZgklga2wFElDly7ajNLW9GLzI3w/91AT3suv4RMgW8PBxuKAvZ1lCAGUoNIJfyZB+vI
 dO4zYToTDLCo+E9oOWQ7iOZs8AkvZM3pqI8L2MDEsLqUo6I28B8SAv2gTYu2A9BwUiEi
 VbZx/tdI0sNAijJIjCTf3mFBIynz3fQsxc6iGTpwAdpxe/F+FSYk/EyoBpaAf0pJqeVG
 sZIw==
X-Gm-Message-State: AOJu0YxQocnorZsSlvXY1ghOnumE6L51eSIWt1T3g1DkPTVglwZoWekp
 roLWsyZ6P431yeREzV2WN1/sO2PHUbM2geLdjpG+evp1kROZflpaNcBE5QH4oN/POh+P+acpHoo
 fJacWmpORhIWhekFXv26xTW3zubAk17Sp9oFtfSJuCQ==
X-Gm-Gg: Acq92OE/V4GrYh9wpgJsQsSbaxvnnslyT8u2qH6H68pkpxTiYKAdqkN2rdTV7WBnBYv
 nx7aQJKuYgUJjnItYbiEK28OYimUpxvrQG0ERGMAGTTLanJCDqo538jiVysNTIdMV1I7xUqc+oA
 cbNhN2Zgp04FSArdcqVkmQbx1vL7Ohc0fWwMIkIFi2bD3naDPYekP8vLHsJzAJxPb7hXj4CfVFp
 p4G/ARzVs7QSrnIt7Xqb38bcY86vssnKJ9gisn9WojNhtF/vkMlP7jnzPvzVQlgKi3hd+ELDrri
 RmwGhf+7kqbOy9vPHZQK6OdzitXJTMIrq8xPENAFs443IdiKh8E42qOqLr+TMNjNu4HxTNsUQF4
 H6tXy9avnVmJViRThQPSC3NUpWeB5al4he10LS7ynEqG2pkvljOO2YxyFFJ5vu8PZfE9ac7ERLM
 vI1NZA5UE0+6oCURdBRDxSH0kKahtuTRNF5zkziN9dffbO3PdRNGfHDsKC3CCQfC30HZmtsv1jv
 KgG967LgL/dCcSL+BtKDWyuZg77K4sN3NpS885Xaw5XmJtIe36Dp1jLQL3Xf6jpkN3bnmFCgmUR
 EENCX2czT9kP/o3nDvdLjMgKtcZT/3rRYkX1/XTisO/o1Fbsj1oCwQsX+SHaSBHkW3DBLYvcnCT
 UsGeEqQ==
X-Received: by 2002:a53:ac82:0:b0:65c:391:4553 with SMTP id
 956f58d0204a3-65df61fb55emr3104538d50.2.1778671617535; Wed, 13 May 2026
 04:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
 <20260512-b4-mmu-unmap-fixes-v4-2-fab802f647c9@linaro.org>
 <CAC_iWjJnJ4T1F4difHoR8k6DPj5BmHeqjCeTtJ+jqc0Yr6RhMQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJnJ4T1F4difHoR8k6DPj5BmHeqjCeTtJ+jqc0Yr6RhMQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 14:26:20 +0300
X-Gm-Features: AVHnY4KTiRlmLDkF3nalHsd9s7PpmvNqZhzYmRaVGO1qcfLDPBc9aty3Ei4AmEw
Message-ID: <CAC_iWjKT=XPs25soz82fdGufLT_Efy1T0aFvgQWrUd9m8aStkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] armv8: mmu: teach the pagetable dumper to show
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

On Wed, 13 May 2026 at 12:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 12 May 2026 at 14:13, Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> > When a region is explicitly unmapped (like with
> > mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
> > still remains but won't be used since the region is marked invalid.
> > Print these regions when we dump the pagetable to help with debugging.
> >
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Looking at it again, this prints 'Ukn' instead of 'Fault'

Cheers
/Ilias
>
> >  arch/arm/cpu/armv8/cache_v8.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 368c622cd18e..36d337378fcd 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
> >
> >                 if (exit)
> >                         return;
> >
> > -               if (pte_type(&pte) == PTE_TYPE_FAULT)
> > +               if (!pte)
> >                         continue;
> >
> >                 attrs = pte & ALL_ATTRS;
> >                 /* If we're currently inside a block or set of pages */
> > @@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
> >
> >                         /* Go down a level */
> >                         __pagetable_walk(_addr, tcr, level + 1, cb, priv);
> >                         state[level] = WALKER_STATE_START;
> > -               } else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
> > +               } else {
> >                         /* We foud a block or page, start walking */
> >                         entry_start = pte;
> >                         state[level] = WALKER_STATE_REGION;
> >                 }
> > @@ -707,8 +707,12 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
> >  {
> >         u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
> >         int indent = va_bits < 39 ? level - 1 : level;
> >
> > +       /* Ignore empty blocks */
> > +       if (!start_attrs)
> > +               return false;
> > +
> >         printf("%*s", indent * 2, "");
> >         if (PTE_IS_TABLE(start_attrs, level))
> >                 printf("[%#016llx]%19s", _addr, "");
> >         else
> >
> > --
> > 2.53.0
> >
