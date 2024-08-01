Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67BAC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 16:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483F6880D8;
	Thu,  1 Aug 2024 18:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h4M/tiky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D881E87BF4; Thu,  1 Aug 2024 18:22:50 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D303880DE
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 18:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso64635365ad.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722529367; x=1723134167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vX+U+LXc/lU0U/auOS6K1H0YmJN6OV9Sr+wu6Iavm8Y=;
 b=h4M/tikyyiC7NL9B1cEeN9FOQuBbG4NVEV0TRtBikTcEnd6Cm0cmUTb7blMzacKGL3
 ALtnQz572Qm7u67CFeVFTGlT5zNXMBqzsbrk4E9ixFeMWO5lU7ajfetQCWC8n/Hq4mk7
 jqDjxCsOqsf5SCqrzG/nbfhFra/+cHU2vrifAbIoKbahUGPJHoW11WtH0wkisE6L5mg9
 tX8dhFJsCPpxwsc90y1Lbu4tmOahgspQ7Vz4RT0HNEilndluIjVluT3swPHnJj/MJYOc
 hHUWE9rOinzZ5zTiJFoU2w3J6YzP4lvgFB0wpojYEFDR/uQOPpIXpZ5od/bPEgCoAx4x
 1DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722529367; x=1723134167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vX+U+LXc/lU0U/auOS6K1H0YmJN6OV9Sr+wu6Iavm8Y=;
 b=KbLlTCwMk2op1Yp6EBrwxFCkdjrm8uM17PzqleBSRN/OLqdPJU3hzP/nWXkBytQhdz
 UaLJwJVzj3/EOCwBhoCkr8jvq4KD6F0IoOWFxzv8A07QrpRstFIW44Q5sERoDkuyM7xB
 G2PnvEW1oqoijsQIvgRa2JSIexYMj4UK3ZUx3PQW414YWI1kxnoghvgsN/rCIFM69SM8
 ZtH+jnW4SM+xE2pXEsE5N3GGmkD+KUcWANN8UvXHkWaya0sn7wv0iaEbT4/dm+9nAkLG
 7dVioF552I18g7Dhn3Wwb6ehSOkxfcOCbognA0XOagleJQFU8oyL+MYErjQUI6FymQil
 GOJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHyMnJr8Y5fwAv9PCw9aFIof8PiM3G8M5WC8U0lc1909U96Z7TCPlamA6nyCriijztwUMPqdaEi+nPi5LwNj1w+GvM8Q==
X-Gm-Message-State: AOJu0Yw8oi3GSujs6sleTaQ69hqA7IEpEA8zUl75Px8/nxvBc7fKY6bX
 hf536fiQl6oMH+l4qIQaTKNsiGEjqncAVuQXyBzcZY5fiZmitAEU4Q6sf6SO6nk8cc+poYrrJ2s
 6ZdDjR7/sZoiyDp8iYfZOgEM9gNZorb311JrqVw==
X-Google-Smtp-Source: AGHT+IEIOOqQNPU0aoWOYsEx9e0jVOlErsSbgiTtk4QL7P62eifqdeubfER1P53W306b9Fy70p0RKMaaWXSmR/Ejsts=
X-Received: by 2002:a17:902:c405:b0:1fb:8620:c0bd with SMTP id
 d9443c01a7336-1ff5725870bmr10842045ad.15.1722529366820; Thu, 01 Aug 2024
 09:22:46 -0700 (PDT)
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
In-Reply-To: <CAFLszTg998VrMeKHv=-==pS+9Q3NTuuJtHUJfxm38wxDOswp=Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Aug 2024 19:22:10 +0300
Message-ID: <CAC_iWjKqe7nReN9=FajF0cXc0uL+uLjPVw0AMU2h7mn_rcbnPQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
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

hi Simon,

On Thu, 1 Aug 2024 at 19:14, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 1 Aug 2024 at 04:14, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tom
> >
> > On Wed, 31 Jul 2024 at 20:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 08:39:23AM -0600, Simon Glass wrote:
> > >
> > > [snip]
> > > > > > > so that
> > > > > > > step three can be seeing what tweaks may be needed in where things
> > > > > > > allocate memory.
> > > > > >
> > > > > > So my series is step 3?
> > > > >
> > > > > Or at least understanding what the problems may still be, yes.
> > > >
> > > > In that case I would like to clean up EFI's memory management before
> > > > doing step 2, since I believe many of the problems will just go away
> > > > if we can get that right.
> > >
> > > Well, I think that's where some of the big points of contention are,
> > > yes. You say "fix" and Ilias and Heinrich say "but the spec".
> >
> > Using malloc on efi_allocate_pool() would be ok spec-wise. Simon's
> > current patch is ignoring the efi memory type metadata we have to
> > preserve. On top of that using malloc for a *single* memory type, just
> > kicks the can down the road until an EFI app chooses a different type
> > and we are back to the same problem.
> >
> > It's fine to teach efi_allocate_pool to use malloc with 2 conditions
> > - memory types are preserved for all allocations
> > - malloc area is big enough
>
> OK thanks I will take a look.
>
> I see the EFI code eventually dealing with memory in two distinct phases:
> - before the app runs: we try to keep memory usage to within areas people expect
> - once the app runs: t doesn't matter anymore

You need to define 'the app' a bit better.
An app for example may load, use efi_allocate_pool to inject some
runtime memory data which the OS expects and exit. The you would load
you OS (which is really another EFI app). In general I wouldn't make
any assumptions on what EFI apps will do wrt to memory

/Ilias
>
> >
> > Cheers
> > /Ilias
> >
> > >
> > > Perhaps once step one is done it will be easier to find a way to address
> > > your concerns without also breaking "the spec".
>
> Regards,
> Simon
