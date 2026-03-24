Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F355E9A75D
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883198352B;
	Tue, 24 Mar 2026 11:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zUocRune";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F33B80050; Tue, 24 Mar 2026 11:14:09 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C3B80050
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7991db3dc98so14911437b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774347245; cv=none;
 d=google.com; s=arc-20240605;
 b=P3V/aq1S2tmFhsWZmIvzSS68xogDd3hITCW0ExWthYxcCm75WhTSXPFMQu9fEFIJTW
 4lOgcPeRmIhDU53LuRfEENNv+Z9gt4WXKsKKCOEf0gNtIU9kTulcAfLsYB6o1O+2/QsV
 LQvd6Gdcyqe8hR5w76nCbc920+SU+L5ew2Tm2SnTkNui85bih3dAGvSdGO33Z3UDDdNl
 Fc/uC1gCIfjkb0+30tLTmh+eGeBKSUkAYdEj+NseFNji/KiqNr5VUSYmZ9M9Admj/e1k
 3zw9AZtGohJw4u0aRSrM1SpmHMGWSjjJuX44KA035IizFqbpoiI65C6VhjsRJFakIuB0
 Ix1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TsdIADncMshfnk25xodQ2PW9JU5ZsRqwIfOUDM2uoOk=;
 fh=o0uaU0vF148YuE7MrmXAhnYZ1ZrC79ng2kp0JdnXWHg=;
 b=AkfqjusxpeN/Y01i2mq1mvyBbRYbmAWsdVc8VCQgztkh6UtzFlkcWlQRrzbXV0AV+o
 nOwa8pbDwYj9YogvQaqq4SHSqH8FGGfRHl3jQKNBuEK9oaVfSRXUX9aF4nHOwwoiUChx
 6YKu9d0AC7N0t4rqH+a7mUiUwCEp58iB37dvWHBh4p//47/Zgd8nHIXP2YxItCv6MIGF
 RkvAQqc8xVYYP1+w+3QrBAcfaWnuUYAkxOIAk6tmjGvesuFe2cJzu/wUp5+TL9P5fCd2
 YMg89Jhc3VGsdeIiU42CXfum0hC1i5FND0fZWQybWjVB01la0DdrLEqYmEU1cajEJW6O
 aPBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774347245; x=1774952045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TsdIADncMshfnk25xodQ2PW9JU5ZsRqwIfOUDM2uoOk=;
 b=zUocRuneqXLpM3/sOcWWSfVvLD04M3jrj1S4Sb+FlHsSkaYE3GrR3FDBu5bGWfzruP
 7hrlsB8bGczNg6YlRFOR1XOF7F1m9o/4CRMN5O5erIa4h/O68j0bCdELLIGSYZe7Feil
 wCM4r8IsVXl8YUm3kXo73OBGAPTNoU7FJs3CK75QrB5dtyVumPGYCSUFLmDN/nQ+Rdzp
 o8r7hBiSu46mdSid6YBxLGsUkEywiWIdWTtYEFg8q7nLM7p4/ikR6USEQhh8U35M8lQN
 GXv2YuVna05s1s3jOLYVGYFMKbLib4RZ3WfRGyAC+UUwGbx4NGCaWkD2ghIQfUW+UyJy
 lyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774347245; x=1774952045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsdIADncMshfnk25xodQ2PW9JU5ZsRqwIfOUDM2uoOk=;
 b=IIGj3qJLBZ4o2AYYI+mT+NrnnNB5kBicDCIYj6WjIjBWKt47DmZ2cZ7NT3VxYkA6gv
 IbGldygyucRo25xEaYMxZ9gDmMWwa2FUGVepGSqT/fdqjz1YZxUnXGHToNdVh1xxM+J2
 yBPdBN9/keFOKkwTQZxltukmf7D2aakShdVSWvdMfz5vKJV4frnkxnDBMawBnfpBHYPd
 7VACPhvpCM0Kyj2goR+R9UbaRNPESMvTib9cxNLmFYpMnZ6FySk4jyBnoXE2U4kN7M6a
 5J0QsDuYRYun5PL5EShzIm9VcFtzU5lBbHoPQ3dHTNEF4B8Y/A0dr7jXJdu2mInuUJdO
 CV/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0tkffgkDK8e+ZPyb9CIvkCSnDfEkSMrd5W++31eFzT1Y4YwAUwLu5LWIvAbJ30dfenNbwzKY=@lists.denx.de
X-Gm-Message-State: AOJu0YzbCpYoNp/iBmN8FN0NK+5bEeubBUnHMyiug3UuObNGJ5+U4ZOd
 wyXAXCh5m1ceel2xtGdx8wf63qUVMNR9AmLGgtmgvj+xmuvNRjUS5JLINpC868MXaie2l8vcHVe
 T8LU/ogMj7/JVNujfvgDBOBy387HhvTDjA7tdY7f76w==
X-Gm-Gg: ATEYQzxbS4z1HgAdohIqM6uCacaVu4PuQo3b6AUaewLOs+I2v3LcrKv7asaBLaSifhM
 q0X9X0FlRyBxufrNhhBbnT2hJkRbboQXLFqZeWlfe+mSX7r+o3ptkxIuImReBQv9MkNocU3Zca5
 jZyUwYNTMckraFHADL1Jg9c9GG+wrc6AAXJP2y48/rvqQDCvOC1f3rfXiod1ZgNwTyjkwMOUGEJ
 F3HFJ3petlU4RcZ9wQoXAuELVx3zmsFbKele4jwEsg7GsNgDYg8QAtKVC3P5zTJMcRhP5gCfiRT
 lQYAlLO80spc6qLe+AegKPSNZlDulmOoxqb6E8Kx/ra84bH8xd/aaH2RNU2anJMCXqfb4FmebG1
 6x52VWiuuVRHkjSZGRAkr4hjvTvmGH0V4jn8lYM+VzBwcguyycRg0xOJCPSz5ZQsEwokHHZrgl0
 Yh25nyl3GcqtfbOfFkUUr3qnpREN/TG0K0JC1ULwtkCeTECKMGsupxLCpb0D2KCDasx3gSacV52
 d6oicR9ukF0EJkS8v0RRdwSBlccNvNwQqFjAPW7h90gj1nn4mqOpQ9JvQdZtdjRsKTdwCCMTTh9
 YqFTujUpxPbCua3IfpchfFEX6whsLwnRxqiBfn3MIqW/
X-Received: by 2002:a05:690c:6e86:b0:79a:ad57:f974 with SMTP id
 00721157ae682-79aad58006emr73347527b3.9.1774347245063; Tue, 24 Mar 2026
 03:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
 <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
 <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
 <20260323181815.GJ502704@bill-the-cat>
 <65974391-a29d-4dcf-ab56-7d6b4a297f0d@mailbox.org>
In-Reply-To: <65974391-a29d-4dcf-ab56-7d6b4a297f0d@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Mar 2026 12:13:29 +0200
X-Gm-Features: AaiRm50nSrd4R_Xs1v5IrTFZ-j6OWY5q27Afh4ZSLQwSUtc-Z4phcpkRT8fBo8I
Message-ID: <CAC_iWjKFAzpj3B_MEW7-dnOrcAV-rfkhXXo8Bv0KgLNP2VJxRA@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Gary Guo <gary@garyguo.net>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 mbrugger@suse.com, pbrobinson@gmail.com, yuya.hamamachi.sx@renesas.com, 
 andrew.goodbody@linaro.org, casey.connolly@linaro.org, xypron.glpk@gmx.de, 
 holger.brunck@hitachienergy.com, jonas@kwiboo.se, kettenis@openbsd.org, 
 semen.protsenko@linaro.org, sughosh.ganu@arm.com, 
 u-boot-bounces@lists.denx.de
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

Hi Marek,


[...]

> >>>>>
> >>>>> "
> >>>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >>>>> index b77c2f980cc..44eccc0cf35 100644
> >>>>> --- a/lib/efi_loader/efi_memory.c
> >>>>> +++ b/lib/efi_loader/efi_memory.c
> >>>>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
> >>>>> efi_allocate_type type,
> >>>>>            flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
> >>>>>            switch (type) {
> >>>>>            case EFI_ALLOCATE_ANY_PAGES:
> >>>>> +               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
> >>>>> +
> >>>>>                    /* Any page */
> >>>>> -               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
> >>>>> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
> >>>>>                                        len, flags);
> >>>>>                    if (err)
> >>>>>                            return EFI_OUT_OF_RESOURCES;
> >>>>> "
> >>>>>
> >>>>> If so, then maybe we need a temporary config option which limits the
> >>>>> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.
> >>>>
> >>>> Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
> >>>> below 4 GiB.  So that change must indeed be behind a config option and
> >>>> care must be taken on what systems to enabled it.
> >>>
> >>> Perhaps a good short-term fix it to use gd->ram_top here rather than hardcoding
> >>> 4 GiB. This way it should work on all systems without a config option.
> >> Looking at my notes from last DMA32 investigation, this may indeed do the
> >> trick in the meantime. But it would be really good to have this temporary
> >> workaround guarded by some Kconfig symbol, so it can be fixed up once the
> >> DMA32 allocator is available.
> >
> > As my recent patches show, I'm digging around a bunch of Kconfig things
> > at the moment and I want to cauation against thinking that a symbol
> > guard will lead to someone doing some required fixup work. At least
> > filing an issue under https://source.denx.de/u-boot/u-boot/-/issues/
> > means we can track it for later and put links to relevant threads as
> > comments, when someone has time and interest in picking it up.
> Unrelated to whether this is going to be an issue or not, I think we
> have two things to do here:
>
> - Consider ram_top , get input from Heinrich on that
> - DMA32 ... how to design that, should that be a special LMB pool ? How
> do we handle hardware which has no memory below 4 GiB, iommu maybe ?

Why don't we add hints in the driver model that explains the device
limitations? That would make the core code more readable as all the
info we need to decide on the memory allocation is packed with the
device

Cheers
/Ilias
