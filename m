Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0098710F6FD6
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6D683CE3;
	Wed,  1 Apr 2026 17:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yIbHxRv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D673B83CF5; Wed,  1 Apr 2026 17:54:45 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DB280517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-650221149e2so5179690d50.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 08:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775058881; cv=none;
 d=google.com; s=arc-20240605;
 b=THL9Z8aQR6NEes0c3Aw+mM3qYvf4728WgGnDuCdJkzJhXGFBVlLf1Ij2NhFWQKSKax
 7XLCfzec3CkA2o2gIKJlLPVaepB8FKkfH3wkjHV91NaHeSG+NiE2Roek+dsE80341WOf
 TuIGc8Ll2qDGpsgNhXt13Uq7olDpzA4uX6EGP/smHu+1Wf6IORPtgue4AFMaCdixO6U/
 Nsy24f+RD+3z+D0bPe1vE3T4fFTZ/40wJgCQD29dC+KLSqaUEBDEEW6XHoGR15YOXn1z
 Nwgk8NEmCED19lGD+qIw9Fyy2Ce/iPdKcS5YFQFWs74doiGpGhkDhZhC89HJyeg6tuIE
 hofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BSAPDVp6TtcqLeykNTlgvEY4TweBcEA6gLg5OBmLHlc=;
 fh=LJRmhZbOuISXO1YWwEVo+37XwV6ihA02M2j1xIzYVp4=;
 b=H53Ez9vUmCX85m3ed+y75+3xtFdiMoGu8RarGgtnbHoL+ztqLDX10IVSddx9TZJZSW
 HFMFeH2+y3EqsL3dHSrE4PfwXPhqd/WhdnwQ+rJzXasIJNAU0kT8eCR+uD+t210dgSt9
 zYt+hA+//Rq87iRycWKtyjft6KM/BXuZpkCdsqB/k4P2gY3217Tj4bbPz7Rp//4Pjl+w
 B8XOx0l5+PKJI542akLH1yCwcPr+fCyd3EQAPcv9JSBTw+1PA29ETztKXrul535Is+jI
 lhHhaqVx03a7e5EgsatUBK4j5i1PMbg7aYjm3rxR7kNxTUdp40cowA2/zheU56XDre+9
 DABg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775058881; x=1775663681; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BSAPDVp6TtcqLeykNTlgvEY4TweBcEA6gLg5OBmLHlc=;
 b=yIbHxRv2wQ8pL7uUuxN7bLmKG0MyJq3/LIlmIFhvuoFxe/dWYdHDayf/eJ0XE5U45v
 bts0zm6N9vq8WD9G89uVVBj6gHi4U1tTX0SlSpw5U103TZm3n8tz0sqny4jpiERQagGJ
 tW1jssFD07ByFL4zLFQfq/5ojTb66uEl02ApVaYzjWnDY9wpn1IeBypY2Ib3OowAtz4I
 ABWklSwOPR+ErjzZXsSbJXHif+WkgwmGbPdWbFr+FA79qPc+8Dd1UDJ34+fcYlnGxxvS
 iAwHOGUUAPqd/lqy7rZJoD35lUwhCd32WVqnE2GKu6xoJD8i6oIdXguzkYHlRqN2wdOg
 zulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058881; x=1775663681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSAPDVp6TtcqLeykNTlgvEY4TweBcEA6gLg5OBmLHlc=;
 b=rp/XAgGgFb3UDDtok74dXfvUJT01kLcTjfjl5b6qyb9nWN5xyOj44EToJVlKCygPYa
 5XEzsLoTBkwJb0rVGEG7AvgNrsH0GEz12iVadGzc9Is+2GpyBb0giDukr/CTw0ehWSla
 gfbnmZbfwr1yTM3BAaXA9i4g1nVRJNi0CCpnGYc0CR1L1wpw4EB+BCeLGSaWLl8BcAhS
 +6GbAxCmnMb2qK7tCcjvOdlzYJ7idNU++pk9bE1Tmeilm1kBKvKOnd9Av8YTse3i52E7
 nViWc3AWLEZWnTgKrR7LEonr+RWgJp7xfdCIDKkKsoE8sRZDO+/YDiFMXlcqC35alboa
 1xig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFreJj23tto9G4aEGjML5Yq+I/OZgL+UibqcWLajyinWN7Mr3nepPsVOH7oL8I6ISPD6yUaK4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBVnEp3/bAluM9818nc8Z+yQfzoHiIYm6zXzRPjC9LSSbTQl5Q
 zVB5tCrVDsa1+lbghLbXa7RI/5stRBFQX35twZEa9swRMuxwqEEL8OC9/RdeONXiaAFjmVYeg4V
 bPfyJRVy2wz49qbMHVmmou3IW4sX00ASzD62rDBev27FzPuDxUSkmB0g=
X-Gm-Gg: ATEYQzwLxcXASGi4oCP9m37ZoHI0bKjeO1Ki+tvoUniaDAvuLozIwCzbeTUupD13Ucm
 J8omW0Pg1N0llJ2EkYcY47j0f07SWPr+GxIoOoeWx8pkj7ulMjgR81Gt03zmcRraIpBR8Rdppd3
 6LPsTbGLPuEJ4SFR3WO3uIbyYBSiafF4NWww3HxORfrgWHAQtF+nyHUv4Si2qv5iLlxDfXo9oSV
 xuAie3TzQK8r2Zh24eEqmNpNY5SXoU6RUFRD7swoxMHauhPbQ8sBNynZR1+qELYQek7gSDxxmQx
 6ZecTOFo+eP0M/k4GBzzCMRM1vSufYZUcAy8usZHPDIevailbTtrD+b5F5SKnYjHC2e/6NzfUPW
 3YEPfIEviUjcH7K6/M1QYPSFqybaRn/L8L+pGXxCDKw8VIZiS7vtDXZpHJgVtch5E9n0k+nkvln
 t8vjDOW2OG5xn0WArK1Dnsj6SUMKQMD0UsyssmRVELDBzsLDQdA/8WJqFhurG59ZqjkmwFZFI9y
 rCavsm5Yjm2NHADo2T4yO+wFl+RsOclojSJ67JjC1Kb7AIZLlen2FfrLM4sivgfnPiPurjKKED5
 w1bi514HiPLfaVBnfpdlvZVzfMN2lq/U3rghlDbN74Y=
X-Received: by 2002:a53:bb88:0:b0:64a:db29:5e57 with SMTP id
 956f58d0204a3-6502fde3324mr2921913d50.8.1775058881149; Wed, 01 Apr 2026
 08:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
 <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
 <CAC_iWjLOJs-C4W=9EcY2DEVRde8Qqmmqb3b3h4+hGn1r9Pab+g@mail.gmail.com>
 <e8bcf2e6-9962-4c82-b38d-f803a69028d6@mailbox.org>
 <CAC_iWj+MyguKpRz7kcfSyaASiUUH2P=YW84zu5xy13pCh6zV+Q@mail.gmail.com>
 <b5b94815-f0bf-4a4b-b62c-d7a2e85fb48f@mailbox.org>
In-Reply-To: <b5b94815-f0bf-4a4b-b62c-d7a2e85fb48f@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 18:54:05 +0300
X-Gm-Features: AQROBzAtjBeDB-vfXe-RVxho6pRGnZUh9h7m2yKpvoZNQ_SyVUhY2jMBeQIR5Es
Message-ID: <CAC_iWjKX6jS_hn+4NtmFa2p5k7kLq+so=U0u+MXPC1j8SbifAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, 1 Apr 2026 at 18:40, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/1/26 5:29 PM, Ilias Apalodimas wrote:
> > Hi Marek,
> >
> > On Wed, 1 Apr 2026 at 18:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 4/1/26 8:43 AM, Ilias Apalodimas wrote:
> >>
> >>>>> +++ b/include/fdtdec.h
> >>>>> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
> >>>>>      * invalid
> >>>>>      */
> >>>>>     int fdtdec_setup_memory_banksize(void);
> >>>>> +/**
> >>>>> + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
> >>>>> + *                        all banks
> >>>>> + *
> >>>>> + * Decode the /memory 'reg' property to determine the memory available in all
> >>>>> + * banks and populate the global data ram_size with it.
> >>>>> + *
> >>>>> + * This function should be called from a boards board_get_usable_ram_top().
> >>>>
> >>>> Is the board_get_usable_ram_top() really the right place to call this ?
> >>>> It feels like it is being conflated with ram_top here too.
> >>>
> >>> I don't think so. You are effectively calculating the top address you
> >>> should relocate to. You should also calculate the difference in
> >>> ramsize. Those two should not be separated actions
> >> The address where you relocate to is gd->relocaddr, which is ram_top
> >> minus all the reserved areas, see common/board_f.c setup_dest_addr().
> >>
> >> This setup_dest_addr() function does manipulate with gd->ram_size , but
> >> only to handle CONFIG_SYS_MEM_TOP_HIDE , which may not be the right
> >> place for it, I think it would be better to have a separate initcall for
> >> the ram_size calculation, which precedes setup_dest_addr().
> >
> > Yes, but when you calculate the reloc address and use a bigger
> > ram_top, the right thing to do is adjust the size as well
>
> That is the root of my concern, ram_top and ram_size are always the
> same, relocaddr is not.

Yes, relocaddr is basically ram_top. But I think we agree here.
Changning ram_top without ram_size makes little sense.

>
> >> With that, the function description can claim that each function must be
> >> called before that specific initcall, fdtdec_setup_mem_ram_top() before
> >> setup_dest_addr() and fdtdec_setup_ram_size() before
> >> setup_whatever_is_the_new_initcall_name().
> >
> > I really don't mind. I just don't see the point of making things so
> > granular. Unless I am wrong and someone thinks it makes sense to
> > change ram_top without taking into account the size.
> Maybe it would make sense to decouple relocaddr from ram_top/ram_size
> calculation ?

Where? In setup_dest_addr()? Yea that can be moved out.

But please have a look at the rest of the thread.
TL;DR
Staring at the code more we can make things a lot simpler. We can move
dram_init_banksize() higher up in the INITCALL chain and calculate the
size and ram_top from that. Then deciding where to relocate becomes
trivial. The only problem is that the dram bank info is stored in bd,
not gd (and bd is allocated later). I don't remember why that ended up
in bd, but if can move that information in gd, the code will look a
lot simpler.

What I suggest is apply patches #1 & #2 now. I'll play around with the
idea above tomorrow and if I hit a brick wall I can resend #3 & #4
separately.
