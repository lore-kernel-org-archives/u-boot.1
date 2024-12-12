Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A5EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408E8801DA;
	Thu, 12 Dec 2024 16:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NcvVVAvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01A3801FE; Thu, 12 Dec 2024 16:48:21 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D238780196
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ef60e500d7so5911257b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734018498; x=1734623298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/H3v2i/jLZM4HStqPnv3yviFwl1EdDKcQIMavdj6mU=;
 b=NcvVVAvugRCrbUipuXov7NVfcctunoZta8IdJD03Wsxvgrc2C51X3v6Kxz/h+VHbsz
 AVKQO6UJhkx4zAuZDeayTcGgUu+U11aP0WRM/RMyUe4VhMOC2rtA62NEXQvw7sncU+JQ
 pXGVSFUp/zMBO1vpnrDnHRqDgPkuiyhy4H6EnbK6cjRp+aXp4xQviGFT0+xBEmB2Yzcf
 8ox3NgDuqDApCNHxH8RUlTzuW5ja1JX+9cOJBoP9RV4t29X+4d8ZsECSqPewkTcEWV8T
 jpTOORmoUnx2+qeAx9/AYg/iKsRHJzF/oUGuE/7SDyVmn+6/AnTMmXwzut9k1GHR2Qbx
 jX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734018498; x=1734623298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/H3v2i/jLZM4HStqPnv3yviFwl1EdDKcQIMavdj6mU=;
 b=ohVzMw5Sq7Co51dBUU11I+DGAJJOpr2Edl7Dqk9Yhh8Qs4jhAqyYvgCH+4Sq9EJhYO
 uG4Ksk9kqyGe1CYkitKfagEBhNJ8HXNmwmONi5I2ZbjED/iRhp793rK4zWhVk9nnBYTa
 9XFPzs5lUaRyL6pdGFeZYS3NVvP5XGDyjR1ibkWAOa9Pjs3OodXWNCMeyWUldtoo17u/
 M/c6XD+cnh9Ks//sPERbztWTrahVvwD7rfy5HWJvhqvWQwkFX+7kkJKj6LbGHOleYe63
 T6wpRiNQb+37oFRCwoOn5LoVzNhs8jzJfqj6SLpDa2vqDrS2OJCFSewfc3h4K77qgnzC
 m9Vw==
X-Gm-Message-State: AOJu0YzgUBQeMdufP/Hv6w03pidPBMqx+6rM9QEforJUXvNBDZ2BcBCU
 e9gJkUUOOVPSgtqhcYz4V8Toh3xFkwiPrNPUpBK4MRBIOGFabSHHPVKLwwB+KFGChC7MzQ57DDO
 lShRZnwIMK4iu/e4XWFHJpnRawmY803vq9Nrrhw==
X-Gm-Gg: ASbGncuNuDN+Ot6nqMDL5gHV7zrO7iP75Fscmfo4O30eSSiPZAnW6LIKi9ytPQR2AaA
 0cEHuw2UnYVT2ITnoybCAlFqKk9Eews6Yq8zQIQ==
X-Google-Smtp-Source: AGHT+IHG84GTveGTwaMWsvyd+N1DbJllrQFHJHRRotuk2mA4rOEPbrrhJAFr4Om0gIrO5jo313BHpQ1WNeJMDFSpJ94=
X-Received: by 2002:a05:690c:6881:b0:6ee:ad00:f157 with SMTP id
 00721157ae682-6f2753532f7mr9600627b3.32.1734018497719; Thu, 12 Dec 2024
 07:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
 <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
 <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
 <CAFLszTg0ByzE0WhHmgvgZhDWu4BxZ3a8bLc6EDUvHNqBLyYprg@mail.gmail.com>
 <CAC_iWjKHYznXnjTxC060v3H8vdvMcmTHBM0ZKKqb8PjPoUCqZQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKHYznXnjTxC060v3H8vdvMcmTHBM0ZKKqb8PjPoUCqZQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 17:47:41 +0200
Message-ID: <CAC_iWjLhFymSyHaZ96K6Ga4jz2EbX2L87WUX98pH2xPiJ4WijA@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] efi_loader: Show the resulting memory address
 from an alloc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
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

On Thu, 12 Dec 2024 at 17:46, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 15:44, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 11 Dec 2024 at 23:22, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Wed, 11 Dec 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Update efi_allocate_pool_ext() to log the pointer returned from this
> > > > > > call, which can be helpful when debugging.
> > > > >
> > > > > Can you explain how logging the success is helping? I think its pretty
> > > > > pointless, why not log a failure?
> > > >
> > > > It shows the memory address that was allocated.
> > >
> > > Sure, but that's not what I asked.
> >
> > On failure, the address is undefined, so logging it just adds
> > confusion. It will likely be a random number.

I mean just report a failure to update. What use can the allocated
address be of?

Thanks
/Ilias
> >
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v3)
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Show the returned address rather than the pointer
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Use EFI_PRINT() instead of log_debug()
> > > > > >
> > > > > >  lib/efi_loader/efi_boottime.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > > > > index 080e7f78ae3..f27b3827ed2 100644
> > > > > > --- a/lib/efi_loader/efi_boottime.c
> > > > > > +++ b/lib/efi_loader/efi_boottime.c
> > > > > > @@ -13,6 +13,7 @@
> > > > > >  #include <irq_func.h>
> > > > > >  #include <log.h>
> > > > > >  #include <malloc.h>
> > > > > > +#include <mapmem.h>
> > > > > >  #include <pe.h>
> > > > > >  #include <time.h>
> > > > > >  #include <u-boot/crc.h>
> > > > > > @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
> > > > > >
> > > > > >         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
> > > > > >         r = efi_allocate_pool(pool_type, size, buffer);
> > > > > > +       if (r == EFI_SUCCESS)
> > > > > > +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
> > > > >
> > > > > buffer can be null if size == 0
> > > >
> > > > No, buffer cannot be NULL, I believe you are thinking of *buffer
> > > >
> > > > That's one reason why I prefer bufferp to buffer. It avoids this sort
> > > > of confusion.
> > >
> > > I personally don't find any of this confusing. Yes, I am talking about
> > > *buffer, but I am pretty sure this is obvious in the context of the if
> > > check. It can be NULL
> >
> > OK, then I am missing your point. Could you expand on what you mean here?
>
> EFI is require identity mapping. You have a physical address but if
> you want to dereference the ptr it it's *(virt addr). Since it's 1:1
> *(phys addr) would also work, but we shouldn't do the latter.
>
> Thanks
> /Ilias
> >
> > Regards,
> > Simon
