Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B8E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53B5801DA;
	Thu, 12 Dec 2024 16:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tp7XnCG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7786801FE; Thu, 12 Dec 2024 16:47:13 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F72680196
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f00da6232bso6915387b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734018430; x=1734623230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lgd62mDJvugWp5sBYX3PrnIkS6UpogH9MsXsadi+iSo=;
 b=tp7XnCG4cq9kM5TsEkY7HI8LSxQkRrnaIK/zAeEG7IxFnC3S7epz5E3YfCflWe6iB/
 RG54wcoeY/GRqjHWUJ6QMa/2uD5VzCwwdvRz4ejXCjtVR1GdlzYjXDwsrj5bvieX5Mvd
 useSDQ0ITIR8hU6bzD7FqtZmt27AkMCGgJ+9zckbkAz02Fb8xCciqY08IG9cGKpQeZrE
 NbCu1qaWMwhZp35/VmYujKdgHk2Oaoc7XQWlxaVz2lESXbU4ZnwSwV7AMd71d2vf5iR/
 fYMdmpNbbhaAi5TNwvhGrwXrit10KoQ+iARAaogGtqgn4/wVBhNL6B6zmgYuYkW4e3Ur
 RfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734018430; x=1734623230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgd62mDJvugWp5sBYX3PrnIkS6UpogH9MsXsadi+iSo=;
 b=QAU3EoDcgeZY9UH98alQoknS41CySdIrCjquDyLbemCBul2joLp+SRLGCCCJqN45op
 ytGC9Df8wM5trdpagOUf25IWf/st0m27Ma0nS+wVswXuDEZXAuBhEDiyKySvVXpiu4Rg
 WWrHstldg6BnpuGavo138XsOz1JU/xq8qhzbNH+h7LSpOyMLvq5gB8BUDAsndn8zPL69
 SRh4E91VHuHgNwwE+XKB2rm81sf1i8sGeD7fbcotTloiSpdKYsQYbXQOFmUdx4pbw7oP
 lPaeYiGOXNw4x/cAdpJNn44HBksqz5R+5NvB+mZgt6yJSQYs6V1SQrOgMtPgSDyKgpBN
 nfPw==
X-Gm-Message-State: AOJu0YyySK5PY55oGU+8DDLCT1DaUfY1Z1dDe1EST02yifwMZpIU0WRf
 hkUza5ZwXTvoOcrirideC8BsN4RFELXLDAtrmwqX72QyxpbKuuU8kd+r5BlfG1hZv//IPD0Be4v
 YHEGLhGezQyK4VgCkRPobdX2DA+KrsQ5Af2epcA==
X-Gm-Gg: ASbGncsC+lExJ0CYZf+etaoc4P/CT4YOSEJgHsp4bOp0+2jgPiRN/ULgN8XoSJvT7M7
 S/rq/hqpfbFSi5VUkBO3txgpmhoVWPbIRb87Swg==
X-Google-Smtp-Source: AGHT+IEnJzIejU+dcww0YrSs/EpUgX8MfVNUjG5gvIhYNcFPmGkUmc0EvuEh4PNH2ro4/jDWphj6vSs3pUg2e/gOY5s=
X-Received: by 2002:a05:690c:610b:b0:6ef:62c7:cedb with SMTP id
 00721157ae682-6f2752a6edfmr9126567b3.17.1734018430254; Thu, 12 Dec 2024
 07:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
 <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
 <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
 <CAFLszTg0ByzE0WhHmgvgZhDWu4BxZ3a8bLc6EDUvHNqBLyYprg@mail.gmail.com>
In-Reply-To: <CAFLszTg0ByzE0WhHmgvgZhDWu4BxZ3a8bLc6EDUvHNqBLyYprg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 17:46:33 +0200
Message-ID: <CAC_iWjKHYznXnjTxC060v3H8vdvMcmTHBM0ZKKqb8PjPoUCqZQ@mail.gmail.com>
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

On Thu, 12 Dec 2024 at 15:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 11 Dec 2024 at 23:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 11 Dec 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Update efi_allocate_pool_ext() to log the pointer returned from this
> > > > > call, which can be helpful when debugging.
> > > >
> > > > Can you explain how logging the success is helping? I think its pretty
> > > > pointless, why not log a failure?
> > >
> > > It shows the memory address that was allocated.
> >
> > Sure, but that's not what I asked.
>
> On failure, the address is undefined, so logging it just adds
> confusion. It will likely be a random number.
>
> >
> > >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v3)
> > > > >
> > > > > Changes in v3:
> > > > > - Show the returned address rather than the pointer
> > > > >
> > > > > Changes in v2:
> > > > > - Use EFI_PRINT() instead of log_debug()
> > > > >
> > > > >  lib/efi_loader/efi_boottime.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > > > index 080e7f78ae3..f27b3827ed2 100644
> > > > > --- a/lib/efi_loader/efi_boottime.c
> > > > > +++ b/lib/efi_loader/efi_boottime.c
> > > > > @@ -13,6 +13,7 @@
> > > > >  #include <irq_func.h>
> > > > >  #include <log.h>
> > > > >  #include <malloc.h>
> > > > > +#include <mapmem.h>
> > > > >  #include <pe.h>
> > > > >  #include <time.h>
> > > > >  #include <u-boot/crc.h>
> > > > > @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
> > > > >
> > > > >         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
> > > > >         r = efi_allocate_pool(pool_type, size, buffer);
> > > > > +       if (r == EFI_SUCCESS)
> > > > > +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
> > > >
> > > > buffer can be null if size == 0
> > >
> > > No, buffer cannot be NULL, I believe you are thinking of *buffer
> > >
> > > That's one reason why I prefer bufferp to buffer. It avoids this sort
> > > of confusion.
> >
> > I personally don't find any of this confusing. Yes, I am talking about
> > *buffer, but I am pretty sure this is obvious in the context of the if
> > check. It can be NULL
>
> OK, then I am missing your point. Could you expand on what you mean here?

EFI is require identity mapping. You have a physical address but if
you want to dereference the ptr it it's *(virt addr). Since it's 1:1
*(phys addr) would also work, but we shouldn't do the latter.

Thanks
/Ilias
>
> Regards,
> Simon
