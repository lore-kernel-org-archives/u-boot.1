Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545C4CFC276
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 09:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D5F88581;
	Tue, 15 Oct 2024 11:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EoDRtIcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7488852D; Tue, 15 Oct 2024 11:34:52 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4375B88387
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso6178715a12.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728984890; x=1729589690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7/xJ7eWUAZmvkkuxdiwVlpA55Yp1+oDEpSlOAMLv430=;
 b=EoDRtIcIvnyWXgbSE4UUEvgpTROETNqKfvNgadTdc6Z1/sJhE6CphmoKUJEzgBfOMw
 s0M6mXU4elEHGIfD0cW0wjolSwPI59E+MrlJvFFAEE1zqz1XYhJ+ykAISBjHVjAlqohH
 0Qf5y1AH+yY8fu2EygPmod5pYQYiaPp7dd+EtsCwyoBLtuHVARpa0n+hSn0hLzzup+t2
 eD+AezsIHPLD5EkyikGVVakxVDHhBif/Tfj8W923i7HRiZDGd1t+W3IGdj8yIrbqnB+g
 ujSbX/YjFDuMfOV45Vz8ry2hrUlyWm44703B2oyKX2GFiL5BAMdvUXaLQ5QWUizQI8rE
 ljVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984890; x=1729589690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/xJ7eWUAZmvkkuxdiwVlpA55Yp1+oDEpSlOAMLv430=;
 b=Fc+CLURwFF5msZ61vQLcDES776IRuHNNqNcQn91V7rJWsBPvLNo7CxYpuJ7HCIWKpi
 qQiwzJT6qFISVaORcdJwsaPak8/MJJSmCazoe+1V56ubcR+ZXCa4/AYf9NFAdfoLhuaq
 lLfqFGRJluLJ2IRevZTVqU3r/lK3iVHa0aiJEuqMlTzJcWQ/O9f2RiUUlwEduihnAsAr
 n2gB7I8TjK6o7/EYh+R2OtsTEVdJgpLUztswoYcq6sIuz/sF3QMo/VNHFX5MuEm/ENAX
 wdwjsweQzYj/MbtKPUrZ1PFyZPb2gnSlV+y12osPG6kDbNZtPPWi6jcYE/5oFdyDLuix
 1tcg==
X-Gm-Message-State: AOJu0YwzWEwS5PDnEx25UjgJHw+4C/hvsKNth0oajRj5KfKmxDiyKTR0
 O1nCy8pKbCFVmr4gXpFkum1eLFe3m6Wgo+eTTZoy378srEjhCcVtkyQZ41o9TlyhlNh0B/amidW
 0eCWJyxbzzNu/QxJS3erQo5cmiSNsW0yIMOdqKg==
X-Google-Smtp-Source: AGHT+IECnQxw0kIks0FavoPFBvI1mrqD/rOs6T03kBKVqSwCreoXkW/IY6unASxGZPOSQvh1wcAFOjdFwx1UHXShMLU=
X-Received: by 2002:a05:6402:4407:b0:5c9:758c:307d with SMTP id
 4fb4d7f45d1cf-5c9758c317cmr6219342a12.34.1728984889610; Tue, 15 Oct 2024
 02:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-12-sughosh.ganu@linaro.org>
 <CAFLszTjYM_4het1OJx_SXb=2ztqmDtVeACmzZMyhB5q=P9sZMA@mail.gmail.com>
In-Reply-To: <CAFLszTjYM_4het1OJx_SXb=2ztqmDtVeACmzZMyhB5q=P9sZMA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 15 Oct 2024 15:04:38 +0530
Message-ID: <CADg8p95JcjOXJuer6LLfjWjAC0vsKOPm4F4TmGWUSApjoR2_ig@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] layerscape: use the lmb API's to add RAM memory
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 21:21, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The EFI memory allocations are now being done through the LMB module,
> > and hence the memory map is maintained by the LMB module. Use the
> > lmb_arch_add_memory() API function to add the usable RAM memory to the
> > LMB's memory map.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2: None
> >
> >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 8 ++++----
> >  lib/Kconfig                             | 1 +
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> > index f9c2083677..d2d3e346a3 100644
> > --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> > +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> > @@ -10,6 +10,7 @@
> >  #include <env.h>
> >  #include <init.h>
> >  #include <hang.h>
> > +#include <lmb.h>
> >  #include <log.h>
> >  #include <net.h>
> >  #include <vsprintf.h>
> > @@ -1525,8 +1526,8 @@ int dram_init_banksize(void)
> >         return 0;
> >  }
> >
> > -#if CONFIG_IS_ENABLED(EFI_LOADER)
> > -void efi_add_known_memory(void)
> > +#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
> > +void lmb_arch_add_memory(void)
> >  {
> >         int i;
> >         phys_addr_t ram_start;
> > @@ -1548,8 +1549,7 @@ void efi_add_known_memory(void)
> >                     gd->arch.resv_ram < ram_start + ram_size)just
> >                         ram_size = gd->arch.resv_ram - ram_start;
> >  #endif
> > -               efi_add_memory_map(ram_start, ram_size,
> > -                                  EFI_CONVENTIONAL_MEMORY);
> > +               lmb_add(ram_start, ram_size);
>
> But isn't RAM added to lmb anyway? I understand the call-removal but
> why the lmb_add() ?

This function gets called from lmb_add_memory() since an architecture
specific memory map is enabled for this arch. And in this case, the
addition of lmb memory is the responsibility of this function. So this
code is doing the right thing.


>
> >         }
> >  }
> >  #endif
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 100c4e5c25..3796adc453 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1135,6 +1135,7 @@ config SPL_LMB
> >  config LMB_ARCH_MEM_MAP
> >         bool "Add an architecture specific memory map"
> >         depends on LMB
> > +       default y if FSL_LAYERSCAPE
>
> This should use an event.

Again, using this method had been agreed upon by you earlier.

-sughosh

>
> >         help
> >           Some architectures have special or unique aspects which need
> >           consideration when adding memory ranges to the list of available
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
