Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F42CD6E6C
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 08:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF35C83FF5;
	Wed,  3 Jun 2026 10:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EO0vXnQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36F7840ED; Wed,  3 Jun 2026 10:57:52 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD0683EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 10:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6603246b66dso6577005d50.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 01:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780477068; cv=none;
 d=google.com; s=arc-20240605;
 b=SYEunoNHLj2/zYoh/hixlei9hnrUQy9riCwNr/kC7r/lS9YqENEM6znxzWb4FLCOcI
 KPEhjfWSkNCkxE8ANACcofrDr9rZqigP8d5hTWBIFauy/i8+N3YXCP6iZyKgHUJswhik
 WW0wMmPkqYQGr60gPZD7dYAifvIolC/DzmT62QXimhtZs8Oxkfq4ExOx10gw0lVnYLvz
 t7Tomgrk48UcOeVXCQAB4ErSNBSBnes0UK784J9YAj4XlYoa5YATbBepx/gYAICj/Zk6
 RtYKHGTIBD5aVg1mrrWMMALjX4mKjhCPOWhPTQ1pAqcXSoItSP3gcy4JyxWnXntqGOdv
 rOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f7FGyWiG/0RnU5nkJ73d+1jGtq93tMAtg/J2cSvBEgU=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=UgdhzFlLGtTxB7s1+47JCqyXlCqFycRPNtkV7ky1VecQ5aASepSOoViGOwT5VZIkoW
 AlT85YECb+qpW1Qfcu1blzwy5P1A8AAf+DmEJv0W8n9N4qpKk1PKu4nMLgvG3jt9Bb/c
 TrUG8iY93AnGVhddqWyFKy+IZPXmJxl36qB2kpZMigDD1+ww4UY1bPXrUkv0kS3Qhud0
 KPphUPue+Xfxg0P3Gap8Q9jXvNkex+70IaoWA2YC+djDNOOkUhSn4sHR/BkFvYGyJ69B
 iN71Z8+z8O9WNLLfVQXxxjvJc6Yp6r6s5tokakdZwdV4j277AIqHuYdqgRjvkbTVaNVb
 7Few==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780477068; x=1781081868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f7FGyWiG/0RnU5nkJ73d+1jGtq93tMAtg/J2cSvBEgU=;
 b=EO0vXnQQk0FPvxz5mHffvjQBv9MpMBpxQ6uexN2LWEb7QS5YviuapqcHrpxakojSlX
 LdYjBO6HcM+gqifAYSROZ+2Amyb+bFIIAHyeKsEKCgcLxAvXcprTJaSMimaZthQ8ENxl
 IefRwrh2HRiyefT3l4YV1DfHmmOOTIYbh7L2DR2qNg0N295AxErvz39suHolbOzQdCJg
 /0NWoOsoAlI3oE2PkLN+zkLwz6CKKdNBtjDtjuLy0XR80pnJvcU6b5Xp9FXwx6CDdQU8
 cT22Rd59C5aJ2htaGKjo5c+IZUDyOCxJDwPhXJyzI9f2i2jLP52W122IndzFWKiBNXzA
 1Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780477068; x=1781081868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7FGyWiG/0RnU5nkJ73d+1jGtq93tMAtg/J2cSvBEgU=;
 b=dAzi4iOdmSrENOljpx2qIKKSzUsz4J0ZFdnfcM2XvRYKTFxITMhxaB95CoBUDh8KTK
 b3LW9m7L2n+gqFUBLbJHznMdJRlt3km97Ko9K8B29ohPxDoaiouv1B5f/y9I8UoDLOaA
 06hQdV2fW1IL0Df39jbtdPO7+M5ZEfs92ukbseOiPExvXSzMMXeuNFPSgcwkI7i6zM9z
 yCQnFn5hesTkNuxLVqxGD9az3bNwWFGbtAAzk+Zwc8AviVe2IsNvCspz+gjQhSdyiLKg
 JxAXsdXOdBdo1+RRsNEgeZlDmB82iezAjUKvD0ZwAt/cWiG8qpodJCBrD2E2lEPAPG7r
 3s6w==
X-Gm-Message-State: AOJu0YyC92qDa80qm1AwzEL+citZq0jOxkD3Z37zuMW5lM1jRYPknmyk
 5HXLNH7SGuj0qEl2RSjIOVyg0qeyELovgznS3Z74yv2eNedsQF8SxTmwhhiMByQvgxla84l3pKL
 Yn3TWbA7va9RaSFMPToJ9PaTRORtRzdxd10vW9Z4daA==
X-Gm-Gg: Acq92OFo0DHfHm9Ozg3jMt4EmCGH+BP9NT2t5kqUAcdPBnCUnLU0wWgCC/exWavuXVW
 4mXHHTn4qR/dwdeP5p1sogLU9vEnZSTdqX7eZCyJGvc2NYu9ho4rwy/eZF1XkWlobmUzAs+Mx4J
 hFSNkkzTgeH+Qj5gs508l0esj18bMuKTpIZqJhhy8D47QGMWgvOwzdLJIjEGaDPuFMkxVwr3Vmx
 uHfsJDq2DwG0eqKKPVZBeid9jYrH3M9WiBpll2PGE6d0afazmWqVrcv9B3THpYR9u0nr7YLuje5
 Svu8aDF/z9Cn6uTIz/ofyqkNT8IKfTu8KwTY13pE54GGxvQEcmDG0jrTFheSKvgmoLsDwi1hrXB
 EpKOABoQN/BooLkF7dio6vCfNp3uhJRIUSLj2J3TqeXz6mI9r+ld/SUozQyNLzInYfNW7vor/co
 JlOxaRkbBbO9hNd8BFMNUcl4CUXsbnswMmTsqZ+eREEhHKqK4S2lKxdXBhLIv4YMOQoZ7klpcO7
 DVKalcdktB5J4KiVRGjWMIe7Oq83jG5u9KCQDSaMa1ZGWAlWoZHQITIrMgwbimwSqUtFX3JTC7d
 pcswFMcuHXH2bK3DlSUTc0hxahiVuiDEQ1CXAcjX+AoNK85oskOj9tbzLYhV0SNWAk8gZ8PDmD8
 pbyluAeNKlpAzWplkErrJnfLSU2w=
X-Received: by 2002:a05:690e:c44:b0:660:880f:d4b0 with SMTP id
 956f58d0204a3-660dc5e08d0mr1965749d50.56.1780477067620; Wed, 03 Jun 2026
 01:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-2-7802245a40a2@linaro.org>
 <CAC_iWjJqSO42-w1Yk3+-bbjsGswBaZmg9Smo1CSpJMrP67cpRw@mail.gmail.com>
 <1100f296-59ac-4c26-8711-a82e117c6e1d@linaro.org>
In-Reply-To: <1100f296-59ac-4c26-8711-a82e117c6e1d@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jun 2026 11:57:11 +0300
X-Gm-Features: AVHnY4LCYh0dz6Q5wRfmtyBW2W75NDstlB9h5NlBK6DpSICyE5kBS_Pgag07Pwc
Message-ID: <CAC_iWjLbuHG7ABAxWFfx07fE4vuWareqz0wxt+FDxiLSSW8rtg@mail.gmail.com>
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

On Tue, 26 May 2026 at 17:10, Casey Connolly <casey.connolly@linaro.org> wrote:
>
>
>
> On 25/05/2026 13:35, Ilias Apalodimas wrote:
> > On Mon, 18 May 2026 at 12:00, Casey Connolly <casey.connolly@linaro.org> wrote:
> >>
> >> When a region is explicitly unmapped (like with
> >> mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
> >> still remains but won't be used since the region is marked invalid.
> >> Print these regions when we dump the pagetable to help with debugging.
> >>
> >> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> >> ---
> >>  arch/arm/cpu/armv8/cache_v8.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> >> index 97a1c39ed268..2800ba57a464 100644
> >> --- a/arch/arm/cpu/armv8/cache_v8.c
> >> +++ b/arch/arm/cpu/armv8/cache_v8.c
> >> @@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
> >>
> >>                 if (exit)
> >>                         return;
> >>
> >> -               if (pte_type(&pte) == PTE_TYPE_FAULT)
> >> +               if (!pte)
> >>                         continue;
> >>
> >>                 attrs = pte & ALL_ATTRS;
> >>                 /* If we're currently inside a block or set of pages */
> >> @@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
> >>
> >>                         /* Go down a level */
> >>                         __pagetable_walk(_addr, tcr, level + 1, cb, priv);
> >>                         state[level] = WALKER_STATE_START;
> >> -               } else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
> >> +               } else {
> >>                         /* We foud a block or page, start walking */
> >>                         entry_start = pte;
> >>                         state[level] = WALKER_STATE_REGION;
> >>                 }
> >> @@ -707,8 +707,12 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
> >>  {
> >>         u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
> >>         int indent = va_bits < 39 ? level - 1 : level;
> >>
> >> +       /* Ignore empty blocks */
> >> +       if (!start_attrs)
> >> +               return false;
> >
> > I am not sure I am following this one. This one get the value of
> > TTBR_ELx. What are we trying to prevent? Perhaps we should move the
> > check to walk_pagetable()?
>
> Not sure what you mean about TTBR_ELx here. I think you're right that it

start_attrs is only defined in dump_pagetable(). That's only used with tbbr.

> should be moved, I think I added it because I hit a case where there was
> a table with no blocks in it (which obviously should never happen if the
> mmu code is working properly).

Exactly

>
> I can just drop it then if we see empty FAULT mappings from address 0
> with a size of 1 granule we know there's a bug in the MMU code :D

I tried without it on QEMU and didn't get any splats.

Cheers
/Ilias
>
>
> >
> > Cheers
> > /Ilias
> >> +
> >>         printf("%*s", indent * 2, "");
> >>         if (PTE_IS_TABLE(start_attrs, level))
> >>                 printf("[%#016llx]%19s", _addr, "");
> >>         else
> >>
> >> --
> >> 2.53.0
> >>
>
> --
> // Casey (she/her)
>
