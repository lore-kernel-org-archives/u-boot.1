Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCC7D18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644A9891E5;
	Mon, 14 Oct 2024 23:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e61ePSLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5397F89201; Mon, 14 Oct 2024 23:13:15 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 221DC8919D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbcd49b833so39289716d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728940392; x=1729545192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+8x8wicNMpFdopPTISFj0kX2WI89SoJNGkfyCBkFKGQ=;
 b=e61ePSLjKfIoagpQfBkMp7meTrbQKCF8FtAXv9NsW/r13uXvbqMccHN9FPBTGgHmxB
 7TdLdSyf5I2a24PirqfKsRHZ/N6Vh9bzdV9sL+/UNYnawvleKL5IURbV0/M+GhTJcrqo
 RCTxgzhQRRA0Xihw0BW4G+PgM+nnk6fYlI5Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728940392; x=1729545192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8x8wicNMpFdopPTISFj0kX2WI89SoJNGkfyCBkFKGQ=;
 b=Pw24Mz80dx+RkVFkdQjh3Ks+4dZnvgLsJUgGB1KhxBdzkYCP4eqrwGMYqUzJROS7Ea
 Fez7x2j7+VklPngQ+xSUj/ksR87Q2FiB8OMZcyqY4HXxj6eviEdfOPFYe5gk2W2abUII
 iR67iaCO/FxnY2eUJsvW4ubMa0cjCsF+deaq0g4cKDhnmOJczOD7OJaYgIRKJ+QB14Fg
 PLNHUYacT10LyVOzo2GJFcxlYkuEwduJcMoBwKw4SuaBH4SnbhpFdRlFl4RPC0XDpY2H
 1f5IiLs62cnSJ93pZtjAUHo5jyFFP6jeVfj6Zjn0IjlT0wM9/A2tv27XcExzjPcSiML8
 TVIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjnUKMwT2UADJGMxzy8R5UjoIyTBTu8eY6aFkV3F6t/k1UT767uBhbNGH2uH7BZzmZYnJZ0YQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzlWHZbz2LZmKN2TLeIUq2aCdwmBAuGQ3CpHIXVjFKhoVUJyXSD
 qKhLvkaZFDjdjPR1ujS4BkAo7FrxVQAlEDn28vAbrSEELOt8HVbVgy7diCxhzS2cBZ7rsdYTrcB
 bn+T0ybY5FrDU0BT8rl0HHI0Q8VZBD8A2oGFq
X-Google-Smtp-Source: AGHT+IFVb+7YdejKFhCkbkGyCMkczjkhemVu0Gka8yGOwFar9av7cpUMYg6xmLMOwwsL8hdQDix9ZYpIFUJDGLn8Ojo=
X-Received: by 2002:a05:6214:4521:b0:6cb:cda0:df6 with SMTP id
 6a1803df08f44-6cbf9cb5244mr162659056d6.3.1728940391995; Mon, 14 Oct 2024
 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
In-Reply-To: <20241014210453.GU53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:13:01 -0600
Message-ID: <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Tom,

On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > Hi Sughosh,
> > > >
> > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > > > LMB module becomes the common backend for managing non U-Boot image
> > > > > memory that might be requested by other modules.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V2:
> > > > > * Use map_to_sysmem() to get the user-visible address to be shared
> > > > >   with the lmb API's for sandbox.
> > > > >
> > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > >
> > > > When efi_init_obj() is called, it should be able to add the lmb memory
> > > > to its own tables. There is no need to worry about lmb after that,
> > > > since no other images will be loaded, except under EFI's control. Then
> > > > perhaps you don't need this patch?
> > >
> > > But that's not true. The EFI application can return us to the U-Boot
> > > prompt.
> >
> > Can you finish that thought? What are you getting at?
>
> Your assumption is false. As Heinrich followed up with, there are plenty
> of common cases, including *env* where efi_init_obj() is called and then
> the user can still do whatever they like via bootm. There is a need to
> worry about it. Trying to make an artificial distinction here
> complicates matters. Much more so than adjusting our almost non-existent
> documentation about memory map / layout to say that this EFI related
> data *is* U-Boot.

Which assumption? That it can add the lmb memory to its tables? But
efi_init_obj() is called every time the EFI subsystem is used. That
immediately puts us into 'EFI' mode.

What is *env*? Once efi_init_obj() is called, we know we are booting
an EFI app, so it is OK to go outside the U-Boot region. It has to be,
since U-Boot can be told to allocate anything, under the control of
the EFI app. But when U-Boot is just happily running and not using the
EFI loader, we should not be doing this. That is my primary concern.

Regards,
Simon
