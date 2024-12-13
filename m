Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C605DE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 03:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A16F801FE;
	Fri, 13 Dec 2024 04:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c1qv9gwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE93D8021C; Fri, 13 Dec 2024 04:53:31 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A268480141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f249f3b2so1638831a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734062009; x=1734666809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbN3Czeygd0gQMlg3dIq5QVpKz8ZMocp1ShtaqsTl90=;
 b=c1qv9gwff7dmgGdqtHQFYmf8ZilEUEkx9GrEOxxUH/kI/Q1sLoNsz2sh/Iqv/qhk+3
 0tLqBt1DPao9ub+KZ0Cxm9qN32KFM9OoDNppS3grI9V/TFR9Q5WqjpfiSGIqREMQayib
 2Fmml06yf2I2jsxlDrUkcXKn7nTYBTfeOBwAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734062009; x=1734666809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbN3Czeygd0gQMlg3dIq5QVpKz8ZMocp1ShtaqsTl90=;
 b=tT8C3aYbQ+hSyAFOAZr/tnGOHZDnnV0uXBl/qhhFqG5hnjEJR7Y9S4vwFfVut/hol7
 oeFkE3PITgtBA07AjPRTgVrxhizPy8Cy+178ji0LAoAFcvGElbp76LyC9mTPBaPKlF3v
 2FLKbISTUhrwNmhWWM940A/zNmSK4NpwPWCQ3BqpnfS0H853rEc20NxWlIdlrnbYAtEK
 FJGbjG96D34Zj5x/6dBeKr+fN0qZg73+FCkAHqQpqESixvOZ7zzxqLJQqhafU7BkaPOv
 +AGaRQh61LS19VH7XGsVyL2fhbIcVWxtnCjof6SLIWNaMx0mj0VGpawu9snTRDmxVUIQ
 /Bnw==
X-Gm-Message-State: AOJu0YwwUixLWNqOjqyvZWDCwy+vRru50YymqyNsm1dcAuvXUhND46CG
 7PnW4wPLCztoWvdqeJNj2Bb8q+Pxu+Y5QIm5J6G3t0j17A7Z9PWv3VtTnkjBf12IaSyDjOALOIX
 vyBjdMJArid0pwP3o0XzdF3y90WTmILA+KqSC+I1voVJ7VZw=
X-Gm-Gg: ASbGnct4HhVFM1XcnZYX8mRW82+f5I94UF1jl1M3spVMOy9E1EUxMBsR5OETrQacRXl
 kgNHaO2cBSZZLRe9sJtTGK59dKRTQ9yh1MInFJXE=
X-Google-Smtp-Source: AGHT+IH0QMiLVs5vk4a5CWVNT6SVXhkguv/IgvdF6YOggHgv8VESsSRU05f1OiOp2F4jDdiUPFVkFDysv4H0wbP6ZoQ=
X-Received: by 2002:a05:6402:390a:b0:5d4:2ef7:1c with SMTP id
 4fb4d7f45d1cf-5d63c3db8d9mr2120223a12.24.1734062009164; Thu, 12 Dec 2024
 19:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
 <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
 <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
 <CAFLszTg0ByzE0WhHmgvgZhDWu4BxZ3a8bLc6EDUvHNqBLyYprg@mail.gmail.com>
 <CAC_iWjKHYznXnjTxC060v3H8vdvMcmTHBM0ZKKqb8PjPoUCqZQ@mail.gmail.com>
 <CAC_iWjLhFymSyHaZ96K6Ga4jz2EbX2L87WUX98pH2xPiJ4WijA@mail.gmail.com>
In-Reply-To: <CAC_iWjLhFymSyHaZ96K6Ga4jz2EbX2L87WUX98pH2xPiJ4WijA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 20:53:17 -0700
Message-ID: <CAFLszTg4Pn_NZkGOtGduz5bm8R5PkTN4W+J7zKCLXJmiX2QYuw@mail.gmail.com>
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

On Thu, 12 Dec 2024 at 08:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 17:46, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 15:44, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 11 Dec 2024 at 23:22, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Dec 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Update efi_allocate_pool_ext() to log the pointer returned from this
> > > > > > > call, which can be helpful when debugging.
> > > > > >
> > > > > > Can you explain how logging the success is helping? I think its pretty
> > > > > > pointless, why not log a failure?
> > > > >
> > > > > It shows the memory address that was allocated.
> > > >
> > > > Sure, but that's not what I asked.
> > >
> > > On failure, the address is undefined, so logging it just adds
> > > confusion. It will likely be a random number.
>
> I mean just report a failure to update. What use can the allocated
> address be of?

Can you please rewrite the patch so I can understand what you are getting at?

>
> Thanks
> /Ilias
> > >
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v3)
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Show the returned address rather than the pointer
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Use EFI_PRINT() instead of log_debug()
> > > > > > >
> > > > > > >  lib/efi_loader/efi_boottime.c | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >
> > > > > > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > > > > > index 080e7f78ae3..f27b3827ed2 100644
> > > > > > > --- a/lib/efi_loader/efi_boottime.c
> > > > > > > +++ b/lib/efi_loader/efi_boottime.c
> > > > > > > @@ -13,6 +13,7 @@
> > > > > > >  #include <irq_func.h>
> > > > > > >  #include <log.h>
> > > > > > >  #include <malloc.h>
> > > > > > > +#include <mapmem.h>
> > > > > > >  #include <pe.h>
> > > > > > >  #include <time.h>
> > > > > > >  #include <u-boot/crc.h>
> > > > > > > @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
> > > > > > >
> > > > > > >         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
> > > > > > >         r = efi_allocate_pool(pool_type, size, buffer);
> > > > > > > +       if (r == EFI_SUCCESS)
> > > > > > > +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
> > > > > >
> > > > > > buffer can be null if size == 0
> > > > >
> > > > > No, buffer cannot be NULL, I believe you are thinking of *buffer
> > > > >
> > > > > That's one reason why I prefer bufferp to buffer. It avoids this sort
> > > > > of confusion.
> > > >
> > > > I personally don't find any of this confusing. Yes, I am talking about
> > > > *buffer, but I am pretty sure this is obvious in the context of the if
> > > > check. It can be NULL
> > >
> > > OK, then I am missing your point. Could you expand on what you mean here?
> >
> > EFI is require identity mapping. You have a physical address but if
> > you want to dereference the ptr it it's *(virt addr). Since it's 1:1
> > *(phys addr) would also work, but we shouldn't do the latter.

We need to talk about sandbox...

Regards,
Simon
