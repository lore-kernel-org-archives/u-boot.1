Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B3AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 17:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E44889D2;
	Thu,  1 Aug 2024 19:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rd5dZVMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AEB88297; Thu,  1 Aug 2024 19:44:13 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B623688B33
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 19:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b795574f9dso39483816d6.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722534250; x=1723139050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/fn74D0rbrqQxDf+av1Kou/brySTwWsj3mwl80EheKk=;
 b=Rd5dZVMdqbTMDF93Qf0aZ9CZAb/YCIH951IDQGshuhVzCQokB7LLS8gqGKeAKTGyhI
 qIvJV8z1WcPW3kuilET8tSchy39k7vlSkUDewke8t3v5gMSYseX0/3AD52PAVzIYd2ew
 LFv35DSRUhvtubBQ1QAMp3qAM+OOsi0k/44dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722534250; x=1723139050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fn74D0rbrqQxDf+av1Kou/brySTwWsj3mwl80EheKk=;
 b=NFSqtGJY1YdnGmJ2EpBm4iMj7H9wRcH+PvnS47W5uRpTjvFU8XtKZ6VGsk9DR11zGX
 HAzg/4bEg2XPIPyDz32MOnp0J1NXhOVVIm3hPkAc5c4EAGGKmPVfceoXdg4zsRTZIGfB
 2CEoeRQEE/W4sQ+Z0i9bG/eMORlt6EWpmj3qjdTzxEwaNk5WCzF82d6GDRvZYMoaKVt9
 fIUUYaKgLU3scAAjoWnQQiehGaT4Vc5o+/LComAW8uZwCJhn4v6hpC8naiDAZYC70N7l
 VRIWBTq1mBVOO/KzJpJfomoDld21Jn7KDSUUvVItMX3cs0DMLrxO84VxvuXyL4WYI49R
 UIPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdhcQQatPLPn1gxtwtHXtZHbSxZ5J0Zxn3TGdMkQwU60XkOPqkDTBjPR9B9Jakcw9XwfF+tUoxso4sajSbZbEEXJegmg==
X-Gm-Message-State: AOJu0Yyisu4gWxKJQbbIn1i54f4dJ6ivsP2e5yu4D5T2UcXXqzZQejv1
 cYQZ57ijHbMBp7vT/Sl7xKOdEZeSWA/dQueuQs+JNBtxT8SjM2NW7eKhh00it4oyyyBXqoUuvtG
 rBgeYK28wKny8jBvvXf4dlMGPmmsKlkqPW3I1
X-Google-Smtp-Source: AGHT+IEDKkhQopw7meNbRJddHYR0CEUAsjpU8mq8KAmudhQWAnNO6zTFms1ucw1jGyiHUGJ7j9EvQtkG8YWeCvWp9ME=
X-Received: by 2002:a05:6214:3bc7:b0:6b9:5bee:243 with SMTP id
 6a1803df08f44-6bb984301c4mr9585456d6.55.1722534250592; Thu, 01 Aug 2024
 10:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
 <20240730201129.GB3794063@bill-the-cat>
 <CAFLszThWZUZabbysC15aLaCRt8EL1=qts45hn0Usp5htR-dp1A@mail.gmail.com>
 <20240730212009.GC3794063@bill-the-cat>
 <CAFLszThsMiQWfkVJ0POMJAFDyYWErLssG5vsQOG4V2WTWoE=4w@mail.gmail.com>
 <20240731171726.GF3794063@bill-the-cat>
 <CAC_iWjLrCM209h=mghHSNi=9aURY5P_-NyidQRJY1hR8D1FFBA@mail.gmail.com>
 <CAFLszTg998VrMeKHv=-==pS+9Q3NTuuJtHUJfxm38wxDOswp=Q@mail.gmail.com>
 <CAC_iWjKqe7nReN9=FajF0cXc0uL+uLjPVw0AMU2h7mn_rcbnPQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKqe7nReN9=FajF0cXc0uL+uLjPVw0AMU2h7mn_rcbnPQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 11:43:58 -0600
Message-ID: <CAFLszTj1-qHtb1TsWrsPOosHrunRM2Z9z2jgkQbUhqxE42sizQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 1 Aug 2024 at 10:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> hi Simon,
>
> On Thu, 1 Aug 2024 at 19:14, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 1 Aug 2024 at 04:14, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tom
> > >
> > > On Wed, 31 Jul 2024 at 20:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Jul 31, 2024 at 08:39:23AM -0600, Simon Glass wrote:
> > > >
> > > > [snip]
> > > > > > > > so that
> > > > > > > > step three can be seeing what tweaks may be needed in where things
> > > > > > > > allocate memory.
> > > > > > >
> > > > > > > So my series is step 3?
> > > > > >
> > > > > > Or at least understanding what the problems may still be, yes.
> > > > >
> > > > > In that case I would like to clean up EFI's memory management before
> > > > > doing step 2, since I believe many of the problems will just go away
> > > > > if we can get that right.
> > > >
> > > > Well, I think that's where some of the big points of contention are,
> > > > yes. You say "fix" and Ilias and Heinrich say "but the spec".
> > >
> > > Using malloc on efi_allocate_pool() would be ok spec-wise. Simon's
> > > current patch is ignoring the efi memory type metadata we have to
> > > preserve. On top of that using malloc for a *single* memory type, just
> > > kicks the can down the road until an EFI app chooses a different type
> > > and we are back to the same problem.
> > >
> > > It's fine to teach efi_allocate_pool to use malloc with 2 conditions
> > > - memory types are preserved for all allocations
> > > - malloc area is big enough
> >
> > OK thanks I will take a look.
> >
> > I see the EFI code eventually dealing with memory in two distinct phases:
> > - before the app runs: we try to keep memory usage to within areas people expect
> > - once the app runs: t doesn't matter anymore
>
> You need to define 'the app' a bit better.
> An app for example may load, use efi_allocate_pool to inject some
> runtime memory data which the OS expects and exit. The you would load
> you OS (which is really another EFI app). In general I wouldn't make
> any assumptions on what EFI apps will do wrt to memory

My intention is not to make assumptions about what EFI apps will do*.

But I do see value in separating the setup done by U-Boot from the
operation of the app. My point is that once the app starts, we don't
care what memory the app uses, so long as it allocates things
properly. If the app exits back to U-Boot and then U-Boot runs another
app, I would say we are in 'EFI land' as soon as the first app runs,
so further EFI apps don't really change that. EFI apps are allowed to
allocate memory as they wish...they can even request a particular
memory address!

Regards,
Simon

> > > > Perhaps once step one is done it will be easier to find a way to address
> > > > your concerns without also breaking "the spec".


* After all, that is my primary criticism of EFI as a whole.
