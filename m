Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D69D735E4
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 23:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC210894BC;
	Sat, 30 Nov 2024 00:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WK1teiZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F058894BD; Sat, 30 Nov 2024 00:27:56 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3774489475
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 00:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa52edbcb63so594589466b.1
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 15:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732922873; x=1733527673; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xd1parC2sAmEKDdJgIe770I5B+hdJZmCyvtrFwM1BkM=;
 b=WK1teiZWnDtFXc33bF3jS3qbAiZnnGOS9bPAymxHSlz2U3Oy/crvW82VrKl39socMB
 o7HkAQjoQvsfBrHORM/YqbGm0wcXyIqIqXf1gGD5ZBganEIoNL1LbghknakqMk85AMWX
 i4CybZo421c8UfW9qpPdyzU/0fNa7O9ui/Bsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732922873; x=1733527673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xd1parC2sAmEKDdJgIe770I5B+hdJZmCyvtrFwM1BkM=;
 b=sZV5pGOrfDzz7MnISB3ZP4A28OGzSp8XUN6pDYFlx1swvdmMehNT5xX1HQZi7ufIls
 16mhLpbBjJ79t+AqD6YtDqi3DkSVS2Cud6/SwmEHXopZgVTx4uwwMIdYg1x4CXyx4XST
 vPJ/a2M4cznt92dm8XNq/klQwLq7o8G+BQywagfRnmcgdtOVAJ6Xh+a52n0XN8k2/7vM
 p1gy2du7kbCbhaYtJN4pccWLzQn2UXpd7R9hP6vvEMK9LHeDqV5FtM7cSd4EpAyMRGUX
 PdzXz9g7f+wwnGHvkadIdAaHwC74F4lSJt0W4GFIK1diJPOitcUtD6etS/RihwxybUiL
 pZ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlVjtafM24Kw0jvZp+D9Ph/k0kTo10DuBd0VFCnR0/bmNAbPNuFAHTNBVmw16b2BvVwhpafLA=@lists.denx.de
X-Gm-Message-State: AOJu0YyncgBHhGrkGhw0Da/o2FPHAfrz2z2Jf6DATg4s1Pe7d4XtThXc
 pC7dar5VaUOXzdEoXOCVoHkHLBTEkowwCtffFFNWxbYiaCT1auvQ2yI7PsLRBKwB+jYh0gnCXJK
 4T0Ystu2/HFZARcHKpbeip9GKAO6LRxe3y+FI
X-Gm-Gg: ASbGncsmKzcFcL6lPfWCipA6384Ni0FsdClfrKnOaRBrkHNmhaFvV9duEG+SI4JebHB
 YJnqeubp8nLxf8axYY+bUJ5ZmDse8WaI=
X-Google-Smtp-Source: AGHT+IGkSxBHXSSH0I+nYDEBCoov88i2vf3llc564W79jXFVlu+SAJZb3Wb2e6LqJ763Diu0KKOkjRPOBv6IEtFXIPQ=
X-Received: by 2002:a17:906:23e1:b0:a9e:b5d0:4714 with SMTP id
 a640c23a62f3a-aa5945fb940mr1015899966b.21.1732922873451; Fri, 29 Nov 2024
 15:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
 <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
 <CAFLszTixsaUG1LeyWycdER5tU_=9tUpLMt0XZ78P4p8kH03iRw@mail.gmail.com>
In-Reply-To: <CAFLszTixsaUG1LeyWycdER5tU_=9tUpLMt0XZ78P4p8kH03iRw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Nov 2024 16:27:40 -0700
Message-ID: <CAFLszThi51_bB8821kTdk7txP6z+0RpaQ47BFb=UTBkK4Ohpxw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

(Sorry, that was supposed to be sent to Ilias)

- Simon

On Fri, 29 Nov 2024 at 15:26, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Fri, 29 Nov 2024 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 29 Nov 2024 at 22:38, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> > > This code was removed when the EFI subsystem started using LMB calls for
> > > the reservations. In hindsight it unearthed two problems.
> > >
> > > The e820 code is adding u-boot memory as EfiReservedMemory while it
> > > should look at what LMB added and decide instead of blindly overwriting
> > > it. The reason this worked is that we marked that code properly late,
> > > when the EFI came up. But now with the LMB changes, the EFI map gets
> > > added first and the e820 code overwrites it.
> > >
> > > The second problem is that we never mark SetVirtualAddressMap as runtime
> > > code, which we should according to the spec. Until we fix this the
> > > current hack can't go away, at least for architectures that *need* to
> > > call SVAM.
> > >
> > > More specifically x86 currently requires SVAM and sets the NX bit for
> > > pages not marked as *_CODE. So unless we do that late, it will crash
> > > trying to execute from non-executable memory. It's also worth noting
> > > that x86 calls SVAM late in the boot, so this will work until someone
> > > decides to overwrite/use BootServicesData from the OS.
> > >
> > > Notably arm64 disables it explicitly if the VA space is > 48bits, so
> > > doesn't suffer from any of these problems.
> > >
> > > This doesn't really deserve a fixes tag, since it brings back a hack to
> > > remedy a situation that was wrong long before that commit, but in case
> > > anyone hits the same bug ...
> > > Simon sent the original revert in the link, but we need a proper
> > > justification for it.
> > >
> > > Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
> > > Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> >
> > Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > Like you mention in the commit message, I don't think it warrants a Fixes tag.
> >
> > -sughosh
> >
> > > Apologies for sending v2 so fast but we need this in for the release
> > > Changes since v1:
> > > - reword the commit message and fix spelling
> > >
> > >  lib/efi_loader/efi_memory.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index e493934c7131..edd7da7d8c6e 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
> > >  {
> > >         unsigned long runtime_start, runtime_end, runtime_pages;
> > >         unsigned long runtime_mask = EFI_PAGE_MASK;
> > > -
> > > +       unsigned long uboot_start, uboot_pages;
> > > +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> > > +
> > > +       /* Add U-Boot */
> > > +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> > > +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> > > +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> > > +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> > > +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> > > +                             false);
> > >  #if defined(__aarch64__)
> > >         /*
> > >          * Runtime Services must be 64KiB aligned according to the
> > > --
> > > 2.45.2
> > >
>
> Thank you for digging into this. It is helpful to add more things to
> the commit message, but please redo your patch with a 'git revert' so
> we get the correct subject and body, as my patch did.
>
> Regards,
> Simon
