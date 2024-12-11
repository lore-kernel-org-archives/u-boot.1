Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8E0E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23E180304;
	Wed, 11 Dec 2024 16:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X4nH6RA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623F080303; Wed, 11 Dec 2024 16:53:31 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE198031E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfa1ec3b94so9470294a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932409; x=1734537209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qAzFZCADvDGEpLzCNxvfo+ihE8rYlRbOgnRw4xJFPMQ=;
 b=X4nH6RA4FCYqUOfOmocoFY12Aj8t2T6hy0GRnfNodAV1x3FK1xbDi3nSHRrAVh9Q37
 NYGRRTOjR3NAnt3O+/GkVyplEhd9OKU9akd0oakF45OXezWdXWpNwaxqYOzjliNKkSZG
 FBI8zvtMwFhzsiTDrnM3yhi4NlZumWe6S03to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932409; x=1734537209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qAzFZCADvDGEpLzCNxvfo+ihE8rYlRbOgnRw4xJFPMQ=;
 b=Jn/VkmGUZ8jIE7olv1TyEz5xoC7SQtG6hrDRxnRm7H8+0UHkGVO86LTRKCD8XK8hvF
 hdtfhZ0vdk2rLTDuamSI9D0+LVQX3YbLd7m0rfgCOSUssaePufBqW4tbiLpvuqMQIcFz
 DapmurgYItePnnI4FF8jo3N5Lr5BuGuRXvxtU5qkw8o6mBQJqoqbWOhOXWtee87Gqa3j
 a0ObHowkBJ0bGXw9d47ciFFiuQsJCS60PSJ3DbUA/yBK9Uunu+0wE0MDK6JZTohy3Fr7
 G1/Zq5Uc6dW0PVX6c+upa1t05unvxSjW2fp+eL+x+EPOwYRbodKLn6liMwwIfeemA2aR
 euZQ==
X-Gm-Message-State: AOJu0YzkhKkmmd1W5eAaZxYvFRiWeVwoHIqnTgejnHzOiVQoOfAw7ZD1
 EES+tiIwS/k60FLiM+lxtzTJ/4uO+4DhZl2tMOPwEi/udVb+NbSIzqxT4VoXFa1Nus0PMG/AjQl
 uksCHBMDozM/DX/p4sJYKaiAt0fflainEZMWaiind80euO2c=
X-Gm-Gg: ASbGncvMZfwD+54Fv2GJlFNLzHYHtiH1MnszhUcK/JmB6EuXKXXJ73YAH9RyvliNbQo
 cE+AHR/oSTgvM4/pLc/SH88plcSPnJTT5ZjwE
X-Google-Smtp-Source: AGHT+IFZ2kkF8koXW9rS6pf0dHDkVBFMoRVXk19qAB9b6yvvyh3R6R1h23PEdnkvML0J7ymaGEIhaqai6G+n26q8C0M=
X-Received: by 2002:a17:906:3154:b0:aa6:8fa5:f3e3 with SMTP id
 a640c23a62f3a-aa6c1ab62b1mr22979066b.8.1733932408124; Wed, 11 Dec 2024
 07:53:28 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:53:16 -0700
Message-ID: <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] efi_loader: Show the resulting memory address
 from an alloc
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Update efi_allocate_pool_ext() to log the pointer returned from this
> > call, which can be helpful when debugging.
>
> Can you explain how logging the success is helping? I think its pretty
> pointless, why not log a failure?

It shows the memory address that was allocated.


>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Show the returned address rather than the pointer
> >
> > Changes in v2:
> > - Use EFI_PRINT() instead of log_debug()
> >
> >  lib/efi_loader/efi_boottime.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index 080e7f78ae3..f27b3827ed2 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -13,6 +13,7 @@
> >  #include <irq_func.h>
> >  #include <log.h>
> >  #include <malloc.h>
> > +#include <mapmem.h>
> >  #include <pe.h>
> >  #include <time.h>
> >  #include <u-boot/crc.h>
> > @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
> >
> >         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
> >         r = efi_allocate_pool(pool_type, size, buffer);
> > +       if (r == EFI_SUCCESS)
> > +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
>
> buffer can be null if size == 0

No, buffer cannot be NULL, I believe you are thinking of *buffer

That's one reason why I prefer bufferp to buffer. It avoids this sort
of confusion.

>
> > +
> >         return EFI_EXIT(r);
> >  }
> >
> > --
> > 2.34.1
> >

Regards,
SImon
