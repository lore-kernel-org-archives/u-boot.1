Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98F0D6AAF9
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6065683D8A;
	Thu,  2 Apr 2026 21:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mseo4CLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58DB83F7D; Thu,  2 Apr 2026 21:03:27 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7321A83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 21:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-650182d19e0so1467175d50.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 12:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775156604; cv=none;
 d=google.com; s=arc-20240605;
 b=FqRN6sIXQg0qL0gFVk3kfFF5RDGfjL7UAeT1ynzJz/wY4Lw9JRyAoE9oxVo7x/gwN7
 nTjWhxtjQJqit17e9hE84CWVdpt4eEK06YnN1oCjj90L9/UOjZzIjV3sJji+NSc49rzS
 FV332oaEbuqsvOBnEwVJfKQNuuhgyw38BTqo/L0Dh7ftGthSwGk9H7QgjIJ3tNWx713o
 FwE0Rif6P8eSCH5trK47yoxqu3a1TEeGSPvjuyE9aJvTLgdHYKogX6ipR19958LlNqoD
 p554X/7hx48cYAzqtXvrhG+l8kQqPy5ORTC5f4mEpKkMSP7apPPBrjzHd9dIuI/GH8ja
 GIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VvuXqt/chSpdUfEngroSM8nyMeTpxZoGJ7RwY7KlItc=;
 fh=m1rskiUu/mu1I7yczGCU4nW6RO0i8CefNt/5WSEl7m0=;
 b=TC9Ct+M91cgchubXfQUA4zO/21tagQGF4oN7TZLVphTmmpim37yvr7wvFfPci6VXSy
 gH8oHm8bXfyR9vt2jyA2Y1FM6JDoHEu+e7LWEP4he888TafrK47LPcJgoM6S4kO95j8+
 teQLWg+kMZSFZZoVfHBZ3ywBwmAF50RbPe5on62XIlFHBMiLl6xwkfivpMY/p/PEhRpH
 e2auTxV4I2w80s0q7akJQs7O7SpJEQi8qyI0LLbf6MUcaMhrmJqrdoN6vdTbHwLx16tg
 e900bzWWBNO3cGicWjYWMnWl00/ihtgI8aDFoixfEUppYy+FuPNQJsF4SmDD+adOjFDV
 b1Aw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775156604; x=1775761404; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VvuXqt/chSpdUfEngroSM8nyMeTpxZoGJ7RwY7KlItc=;
 b=Mseo4CLD3sH/K7J9MiKzngsgiUV2i2jEbXF3Y042GXKNVdDLbfRlrRUHkLZMSkWphl
 rrY1gZMLcAeWfZkbgI+ZUA944ONdeOUp0PlTwLOoL3zvejn6G7XNTjPlG2gu/AlrxlW7
 JiC8YCeH3hpcPpfHBmopewDPC4XFgyzBoaqXYB8lN2qjhPsVPcfwbhBWs3mlzJKtU2Wy
 Jejj1Dv361AJupc3S7ugdacvSJdzkhNDyAPIuTdTjg3gQft70qmC6Grnlow901+erQ8R
 V8nGkQQILV51sc/gsvtoGr1/Ucu2EWIJNX6CyEybHyi5l6UyvPcxkTnfPS/YpI+NJ1Ol
 9vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775156604; x=1775761404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvuXqt/chSpdUfEngroSM8nyMeTpxZoGJ7RwY7KlItc=;
 b=Rw4JEvvDREroth1xvBlKs739iDhv4QSZlg0tlyQ4a/bu785krleCZ3gM61SHUWuNEy
 ykOO5d/R0O7lm9IGsRCAi8sZtsugV8ZsdsOq/tJrx1jfjpG7JqmTnmCPwt98za5+dzF0
 wSFASj+QOD6zKi0HhzzfeUmFnwhK8N3vdcIbLazMHbE8kb4mY38bOb/w4IpvLgYiBIoY
 33PL7H3wO1UFK+uzmNXNlOJ1nZXasjx4tlKFXOIXpEfdndvCqHwJQRTcaGbaWKfYh/jt
 EeVH3YT/2igRfzS4mB6KwEUzpIQp//yLmcuwSI0KjaDbPPaRNBAJJRFrxR0PrsL7rGIM
 4hdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWca4raaji3nd0USA+6CLf8gOif01q4t/vFOEk2d/zWcbAwALeblFE3tbJ/a3TcTiDra8ND/5I=@lists.denx.de
X-Gm-Message-State: AOJu0YxBz+mlBC69ndF7J5NrED5KYSnMUNWDMBzfPGihtiyh52LL6PMS
 z/VkGZELkM7ptSziuW9srnWGzHiEuZpc87032FF2E8LKViVvWVAg5BbQ1CdzVGpXVFWQ/J0a6f0
 o3FXcDuffcKQF1z6rs1OHH8x68G/jEQbq1E1fWq0GBQ==
X-Gm-Gg: AeBDiesn2oJXus932whHWZRMIB3jDknO88rlYhkG75K5FSNmVSht9OFu2RVzrD+9aGh
 wKulkeGV/BB3Ofe+XIKEk+LCqO9c7agWnBWUPEeFdALJHmAE9On3ZEKdLpxr3W8LdLkesWMjC9f
 F4MkMHa+KyblwZ9uxfGOrD1ayPmNeiurgbChtLFyKoFxDF5w/m1SizXpdhfDoGAa4YDfQZpfFJS
 zhHZJ4qmhZqMk/lcvL63vS8gC7dV2L97q0lfYDUyWFdh/IoxeWy9cp3lIyjJYI+UzQvmh8txFrc
 LF4BHOxPcl5TMutrwpNUC1WZY2j4hr8dRbu33LPCbT5bu91THOFE10bZIK7kB9Z/FKiYhxc3SYE
 21pKWRHpQOe25ue64vEemqtBe8wZY04EG4kMtzgXC5+U/OKQsiv83lVa1VR6jqQiZaq/5kz573Z
 YWcWkwBayvRWrIUGmOkETjPp5yp5ocRHdOWZt01RfVIHZdxEEL8lp2zBRpOytznXb8sEqDgEmiN
 pBO52hE5irtksVbA3RMBnay/vYnZAZmbE7PU1u2DVToQqCz3+U4s1OjVEA6hcAn+mXOvtyW2wiS
 cQl2ewDKWNszTMim6e2ogtuEzD2yS36SHFF6DviPMRs=
X-Received: by 2002:a05:690e:144d:b0:64c:ea3d:a895 with SMTP id
 956f58d0204a3-650488b70ffmr79702d50.61.1775156604006; Thu, 02 Apr 2026
 12:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-5-rs@ti.com>
 <CAC_iWjK8BNOtyreZR6WRO98z673hthQENN9Fp73+igzaifUuLQ@mail.gmail.com>
 <DHIUPNVL4BG7.1UZWSP0MV8LBE@ti.com>
In-Reply-To: <DHIUPNVL4BG7.1UZWSP0MV8LBE@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 22:02:48 +0300
X-Gm-Features: AQROBzCLLhC-M3knGm0rnWBi3soX6T9lpQyA-gh_fmRZGTu0EuJbnFt_u83vvL4
Message-ID: <CAC_iWjLJc68iL0swF8XcJK8x27aL2DR9bRBvq0VW21-CTXx2jg@mail.gmail.com>
Subject: Re: [PATCH 4/6] efi_memory: nitpick removal loop
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Thu, 2 Apr 2026 at 20:39, Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Apr 2, 2026 at 4:04 AM CDT, Ilias Apalodimas wrote:
> > I don't mind merging this, but why is the current code flawed?
> >
> > Looking at the function even if prevmem contains a previous valid
> > entry the check will fail
> >
> > if ((desc_get_end(cur) == prev->physical_start) &&
> >     (prev->type == cur->type) &&
> >     (prev->attribute == cur->attribute)) {
> >
> > and re-assign prevmem.
> >
> > So please adjust the commit message if you want this merged.
> >
> > Thanks
> > /Ilias
>
> Ah, not really that it is "flawed" right now, but more so that we should never
> even have to think about that occurrence, because at best it's an unnecessary
> compare. Why waste time trying to defend or attack a line of code that simply
> shouldn't exist?

Not attacking anything. But the commit message wasn't as clear and I
ended up looking all the code. Chances are this is going to happen if
someone reads that commit message in a few moths. So something along
the lines of "This not currently a problem but ...." etc is what we
should have in that commit.

Cheers
/Ilias
>
> > On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
> >>
> >> From: Randolph Sapp <rs@ti.com>
> >>
> >> I don't even want to think about the possibility of this pointer
> >> containing a reference to something from a previous iteration.
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> ---
> >>  lib/efi_loader/efi_memory.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >> index b77c2f980cc..882366a9f8a 100644
> >> --- a/lib/efi_loader/efi_memory.c
> >> +++ b/lib/efi_loader/efi_memory.c
> >> @@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
> >>  static void efi_mem_sort(void)
> >>  {
> >>         struct efi_mem_list *lmem;
> >> -       struct efi_mem_list *prevmem = NULL;
> >>         bool merge_again = true;
> >>
> >>         list_sort(NULL, &efi_mem, efi_mem_cmp);
> >>
> >>         /* Now merge entries that can be merged */
> >>         while (merge_again) {
> >> +               struct efi_mem_list *prevmem = NULL;
> >>                 merge_again = false;
> >>                 list_for_each_entry(lmem, &efi_mem, link) {
> >>                         struct efi_mem_desc *prev;
> >> --
> >> 2.53.0
> >>
>
