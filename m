Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910FFE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203FE800CF;
	Thu, 12 Dec 2024 14:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aHkFPhjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0244B800CF; Thu, 12 Dec 2024 14:44:50 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6498008A
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa6a3c42400so107381166b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734011087; x=1734615887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GH4uc+ZnK8x184wKdEpXdQiVEZFVZn1kW4+iSIqZ4gs=;
 b=aHkFPhjD0w4/SA/3qXzPvaZCICOt1vg2rOcq4VFsrN6aAcvZ3vCgFOtcjtbteWP4qO
 ZETvzw3bcvzNhGF1Zy9ywJoOR2W+ECG9y1iEAX2F4EgwOsY+wvDgv8zNxMnSyIU/P9ch
 nTFXYHWpm7OTxw+i6SWZG1PMdHf4nY4pH1pko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734011087; x=1734615887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GH4uc+ZnK8x184wKdEpXdQiVEZFVZn1kW4+iSIqZ4gs=;
 b=vePeLs9fHK4gMm/aCw/+IRf3dExBcNaREidVuL0kpkxxgqNLG9GERrjIAORyyax3Li
 UHVOXY/DRlzujUoNYMrL9EY7KcRqsh6JNQRHk3QQA2a4rUBH1VQ1KeJkZvk7RdgcGLiY
 5LHIntS+KqVvdK/dk6k8DpY+D4ZoPxYvGBSojzYPB8IK4gv6sXtBlSCM3IoK8l2qP66C
 UXKKrxsMIU+2YrrAAyG9mDH+IwGg4ZuGsdR3hOE3h9Ai/nrY1cGfpcFk++AcoDfXDNIv
 Z6/61nCrw6D1Kya4lFoIF2+CrK2bQMC4vaNN7PSfX9/DzxjByRvRd21RloInjjJ8Fan0
 6ykA==
X-Gm-Message-State: AOJu0Yy6wDLJmc5N73WTBBPCRTNuv/MmJ0jd270HhAnOysusqleETahZ
 n/hYaP9WW3+UTUiZF8o+B6IETNkfKxAPPin/xY/OzuMXFeY0R7R9DpZv+yDIwwCpax1Jj+BPHS0
 XJb37JYMc1oDm7/trvGrrO4+RZrqSEUJ/9JHBP+21W9baeyU=
X-Gm-Gg: ASbGncs21Ag03anl+U9E5LEPokH6lPbTfQ/zKx16zKZvcpVOFtVeMKi1SAyKEVxTb0r
 UwDWak7wQJnm8lVkZ40Cl85aanfmF9h/7fYjofyc=
X-Google-Smtp-Source: AGHT+IFr4EXmd48K0alJwbDsk/3EY46GXOTQWvDoS2dy/NDssSGcVi0rfER33g+t1dsLzJ4+MzKIa2qiiOpLP09Kxfo=
X-Received: by 2002:a17:906:9c18:b0:aa6:54df:6abf with SMTP id
 a640c23a62f3a-aa6c4139005mr310493466b.18.1734011087441; Thu, 12 Dec 2024
 05:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
 <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
 <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
In-Reply-To: <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 06:44:34 -0700
Message-ID: <CAFLszTg0ByzE0WhHmgvgZhDWu4BxZ3a8bLc6EDUvHNqBLyYprg@mail.gmail.com>
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

On Wed, 11 Dec 2024 at 23:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Update efi_allocate_pool_ext() to log the pointer returned from this
> > > > call, which can be helpful when debugging.
> > >
> > > Can you explain how logging the success is helping? I think its pretty
> > > pointless, why not log a failure?
> >
> > It shows the memory address that was allocated.
>
> Sure, but that's not what I asked.

On failure, the address is undefined, so logging it just adds
confusion. It will likely be a random number.

>
> >
> >
> > >
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v3)
> > > >
> > > > Changes in v3:
> > > > - Show the returned address rather than the pointer
> > > >
> > > > Changes in v2:
> > > > - Use EFI_PRINT() instead of log_debug()
> > > >
> > > >  lib/efi_loader/efi_boottime.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > > index 080e7f78ae3..f27b3827ed2 100644
> > > > --- a/lib/efi_loader/efi_boottime.c
> > > > +++ b/lib/efi_loader/efi_boottime.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include <irq_func.h>
> > > >  #include <log.h>
> > > >  #include <malloc.h>
> > > > +#include <mapmem.h>
> > > >  #include <pe.h>
> > > >  #include <time.h>
> > > >  #include <u-boot/crc.h>
> > > > @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
> > > >
> > > >         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
> > > >         r = efi_allocate_pool(pool_type, size, buffer);
> > > > +       if (r == EFI_SUCCESS)
> > > > +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
> > >
> > > buffer can be null if size == 0
> >
> > No, buffer cannot be NULL, I believe you are thinking of *buffer
> >
> > That's one reason why I prefer bufferp to buffer. It avoids this sort
> > of confusion.
>
> I personally don't find any of this confusing. Yes, I am talking about
> *buffer, but I am pretty sure this is obvious in the context of the if
> check. It can be NULL

OK, then I am missing your point. Could you expand on what you mean here?

Regards,
Simon
