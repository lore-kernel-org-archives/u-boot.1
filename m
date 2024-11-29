Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E38CD735E0
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 22:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F144894AB;
	Fri, 29 Nov 2024 23:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mORoMAD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F308894AD; Fri, 29 Nov 2024 23:27:04 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA9489494
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 23:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa5302a0901so268507866b.0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732919221; x=1733524021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Qj9fujSB6BBxof+xB3Ke8RJtSwdfwXStTWQjzQck8A=;
 b=mORoMAD/Amo2twU+1fu4BmxNacd73zWx7DMFUWm3hfEJVGoIon2bCLJtivbpkI6UqS
 IKoOeb/LUYVWufvK1MDfZPilZq3sp4xkAYKIH9hFxQVNPXSfDTt8Wc89+A1HuFR85GTW
 22ZyrCjB0+VgjxGbNGOYi4qd+raTLOG+hJtPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732919221; x=1733524021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Qj9fujSB6BBxof+xB3Ke8RJtSwdfwXStTWQjzQck8A=;
 b=e95eSoRZIMsyP0W5NdbuTv/arfWeFdBhA40PclvsiF/2Yz2hUWIUT1X9V5XRZ2uz+N
 feiyBFnJJ6iu1CejtpmE5ochdEEjHfcjEkzgcm2hoFug93KyHoJ270SsYW+tOCHS+mwQ
 6gSbImloGldHJaP16554T8ZaHazujm3LKBFMdaVYLDimOlD09Y6qbzhDVXCClqKf4ZMd
 u/r//lqkvuUXqKtn33ocV8auHmxqY2fDSpprejoZOUQ/Xv1NW9ktKuTLTauRqbZYpCn5
 m15WZYHZw9YyZnv1xqvas7coshiyCphKytz5dXXE/IrJWjXIxlRBcre9O4loKp5FXst6
 wtbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlgZ3nbN47fNnP4PzHpH1Csqt9CQD2UATE/qQCFm8EF6lbMMC7Ge9/is2q7dGl5jcSvoBF+7M=@lists.denx.de
X-Gm-Message-State: AOJu0YwK9cFmB6p8l1PzGBMtxCGHhE4qE8D8zFuoaOD5tn51OZf7YOSi
 Q+rMNkMTaosB/dUZ9KwW/gMm2JlbjxrMRHGAC3+uD7HzIeFO9f1xdVZ4m/eDsWHDZRETp7MouRe
 uRS21rkuPC8Mg7hv/DQJ/7gnnJmfzTiaB+B4Z
X-Gm-Gg: ASbGncvO4QVDKP1rNkmeGqhJY5FU3w0+E+3nzdrKopaddqzdGqNlUQaVBn6aiOXFxhH
 9ik5OxyT18QxwKyBhDmvwzFps3Pk/WdI=
X-Google-Smtp-Source: AGHT+IFRjKFRnyWNxRvD3SPO0dwzmBrCVrU0egoG5yEzJUexXYMrk8MYqTuru/kR7gjFHbAQT09W6TsFDQdaxWzlygg=
X-Received: by 2002:a17:906:30ce:b0:aa5:1551:99f2 with SMTP id
 a640c23a62f3a-aa581072b9amr1127584466b.49.1732919221029; Fri, 29 Nov 2024
 14:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
 <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
In-Reply-To: <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Nov 2024 15:26:49 -0700
Message-ID: <CAFLszTixsaUG1LeyWycdER5tU_=9tUpLMt0XZ78P4p8kH03iRw@mail.gmail.com>
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

Hi Sughosh,

On Fri, 29 Nov 2024 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 29 Nov 2024 at 22:38, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> > This code was removed when the EFI subsystem started using LMB calls for
> > the reservations. In hindsight it unearthed two problems.
> >
> > The e820 code is adding u-boot memory as EfiReservedMemory while it
> > should look at what LMB added and decide instead of blindly overwriting
> > it. The reason this worked is that we marked that code properly late,
> > when the EFI came up. But now with the LMB changes, the EFI map gets
> > added first and the e820 code overwrites it.
> >
> > The second problem is that we never mark SetVirtualAddressMap as runtime
> > code, which we should according to the spec. Until we fix this the
> > current hack can't go away, at least for architectures that *need* to
> > call SVAM.
> >
> > More specifically x86 currently requires SVAM and sets the NX bit for
> > pages not marked as *_CODE. So unless we do that late, it will crash
> > trying to execute from non-executable memory. It's also worth noting
> > that x86 calls SVAM late in the boot, so this will work until someone
> > decides to overwrite/use BootServicesData from the OS.
> >
> > Notably arm64 disables it explicitly if the VA space is > 48bits, so
> > doesn't suffer from any of these problems.
> >
> > This doesn't really deserve a fixes tag, since it brings back a hack to
> > remedy a situation that was wrong long before that commit, but in case
> > anyone hits the same bug ...
> > Simon sent the original revert in the link, but we need a proper
> > justification for it.
> >
> > Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
> > Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> Like you mention in the commit message, I don't think it warrants a Fixes tag.
>
> -sughosh
>
> > Apologies for sending v2 so fast but we need this in for the release
> > Changes since v1:
> > - reword the commit message and fix spelling
> >
> >  lib/efi_loader/efi_memory.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index e493934c7131..edd7da7d8c6e 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
> >  {
> >         unsigned long runtime_start, runtime_end, runtime_pages;
> >         unsigned long runtime_mask = EFI_PAGE_MASK;
> > -
> > +       unsigned long uboot_start, uboot_pages;
> > +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> > +
> > +       /* Add U-Boot */
> > +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> > +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> > +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> > +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> > +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> > +                             false);
> >  #if defined(__aarch64__)
> >         /*
> >          * Runtime Services must be 64KiB aligned according to the
> > --
> > 2.45.2
> >

Thank you for digging into this. It is helpful to add more things to
the commit message, but please redo your patch with a 'git revert' so
we get the correct subject and body, as my patch did.

Regards,
Simon
