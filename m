Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3305E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 06:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44831801EA;
	Thu, 12 Dec 2024 07:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CWZxic9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B58D801EB; Thu, 12 Dec 2024 07:22:33 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239B0801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so148410276.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 22:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733984550; x=1734589350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qY3sY7I4Pxrgv8GNCiPVBQWyD8FBcazoENUl0m9nLkY=;
 b=CWZxic9lf0VP4jWEE+pSAq8QHpTMDcESg6VVdK4G4tAgq10SJHuXlT7EMQObLZiYtH
 BbyRNYi5HBUMydjfJPK81aILHMwjD9cG2x1z6g2ktrx22dW2iszIv042KOzY0FDykG4n
 gQLKrDLkauP42RzhPlG6gZyBZid4EbS9W4nxNATXSDJxCm7pj5x6Qa4KjwoDeNTlZpBA
 eW6ZohTC8+gqAY1KgsIiO7vpujmWEsJaO4+UqmcaoyGXAxvIXeBkF/NGn96YjPumGHpv
 h50M/eaQ8jI1Ut9Dc6EF8RnJ0hwlvdbJGt+/u36yZm15UsrrUHeC3EeLCwzh9py/d68z
 FU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733984550; x=1734589350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qY3sY7I4Pxrgv8GNCiPVBQWyD8FBcazoENUl0m9nLkY=;
 b=iMWyx/1eKfa02s/8UMucGTIgUMlw1CzdOh2bfHsgLi9uQUmf2akrcpf5cs2VSC8AOr
 RaPYQqRWN2vz7aI4L5NwF9bDy35eXqwwqo2tv58fH8bBksPYhxeGpf34KbnP4NI8rNQJ
 h6JtN2i+Re0m0zNFhXq3R9NDHtGMaX3rOtZ0JQL4Qlt4SKD9slNFV9v5pL3vkuoookub
 qSTLqsN3Vz6MWQDfQZGylHxWw4hwcGqWDvzy23UhzigNI9STuUqn782V7j3hrVJtutHA
 ffu59SBXsrGjMG8IO0ZiS2N/Rtl50WJ5u0CJekCLTLRrd3nhX9REaRv6KMXBTlIiLqWH
 wUfg==
X-Gm-Message-State: AOJu0YyldfkJOSqtbP4kBD0XsvYCthUesbezr5MHjMCunkkc/tbwwrCy
 DKr4YxWaqWGQJZiJwmFqv67KfaO4eeX82Ed5TNalNWZLaJ/gFf19SzvwuMEBchUHOrUX3vBh9EX
 sLkkPnVX4ZRlvUx3MUrhQ+6LFiAAKhukcB1b68mTVBdcDzefS
X-Gm-Gg: ASbGnctrOTFsEEu7++u3KB/9zHk7OfMjHR0QcsF1E+eM1Zdk02wFdC3ZuGFwvd7qnFu
 1ltkC8iytxCgeQJHtmrDN+TcVdpSeIa05u4Z0Kg==
X-Google-Smtp-Source: AGHT+IELyYUqB4Hq8lyFgYQd7HlkH/91Gd8RNRL4h42i7Wo3iECrQRst1JjCUC82F+Myghqf8G1xr3DJ1IbBtBqAUoc=
X-Received: by 2002:a25:8445:0:b0:e38:7df5:5577 with SMTP id
 3f1490d57ef6-e3ddad92f59mr1755523276.24.1733984549976; Wed, 11 Dec 2024
 22:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
 <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
In-Reply-To: <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 08:21:54 +0200
Message-ID: <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
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

On Wed, 11 Dec 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Update efi_allocate_pool_ext() to log the pointer returned from this
> > > call, which can be helpful when debugging.
> >
> > Can you explain how logging the success is helping? I think its pretty
> > pointless, why not log a failure?
>
> It shows the memory address that was allocated.

Sure, but that's not what I asked.

>
>
> >
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v3)
> > >
> > > Changes in v3:
> > > - Show the returned address rather than the pointer
> > >
> > > Changes in v2:
> > > - Use EFI_PRINT() instead of log_debug()
> > >
> > >  lib/efi_loader/efi_boottime.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > index 080e7f78ae3..f27b3827ed2 100644
> > > --- a/lib/efi_loader/efi_boottime.c
> > > +++ b/lib/efi_loader/efi_boottime.c
> > > @@ -13,6 +13,7 @@
> > >  #include <irq_func.h>
> > >  #include <log.h>
> > >  #include <malloc.h>
> > > +#include <mapmem.h>
> > >  #include <pe.h>
> > >  #include <time.h>
> > >  #include <u-boot/crc.h>
> > > @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
> > >
> > >         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
> > >         r = efi_allocate_pool(pool_type, size, buffer);
> > > +       if (r == EFI_SUCCESS)
> > > +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
> >
> > buffer can be null if size == 0
>
> No, buffer cannot be NULL, I believe you are thinking of *buffer
>
> That's one reason why I prefer bufferp to buffer. It avoids this sort
> of confusion.

I personally don't find any of this confusing. Yes, I am talking about
*buffer, but I am pretty sure this is obvious in the context of the if
check. It can be NULL


Thanks
/Ilias
>
> >
> > > +
> > >         return EFI_EXIT(r);
> > >  }
> > >
> > > --
> > > 2.34.1
> > >
>
> Regards,
> SImon
