Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62153C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 16:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D1188B17;
	Thu,  1 Aug 2024 18:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lX7n8K5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6B988A9B; Thu,  1 Aug 2024 18:14:49 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880898862F
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 18:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7a3b75133so51326376d6.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722528886; x=1723133686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1EinNc/dplLTOEDiPFXJNEpVHbrewHd0FuxiuqKpjxY=;
 b=lX7n8K5jqNAwb2ykc9f39RqzS7zr+JNc0gS6U1qvXXdO8YzUhqsqC7wsCqcW+2R/HO
 exUFJ5j4NOe9LCFeEHs9eVeOeegsCKdQ2q1SRjiPrQK9lHlLVjWIehYn7TZ0mluBU1Wn
 IY6yGq+t/G59Y+3+/BtjpGe5kU1L4mokTLJkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528886; x=1723133686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EinNc/dplLTOEDiPFXJNEpVHbrewHd0FuxiuqKpjxY=;
 b=Q9t23dsjYz24ZBzJ/7fiEgiQs19VTeCn1rPVKYRxoZjT825sWw+rVyWeutthDjpwaR
 h4pufQn9YxztfcMc89I0S8OtNg0eSt+s1Gvyz1erKN6bXdrawNw7LPCDiIqjLFSAyhjw
 SKW6KBv1vDa9MLWvvW8PkhKJcAvya1n4kFrgkw3buLy3Lyk9X1hjvCLigFvYVFyRwbiv
 MzSDmMym0SMuvXtHWDnem7vlbKLh+RoCHPpWpwO6rQewkLQVX0TAXuSB+UCBxdoPF3g3
 mW7jCtP+1+tByzAUoiMBl+VGcmcfJ8D9UKoFASNtEYhdOgu/6RdZKO+aL1RVhVbsN8Fy
 d1fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSwQyXdZe6ZPqZ9n41N64y+ZojZTPqnZlPDVnmAXb+U7R0Nvy8AM5wh4qkFjrUwwiftD8nhcmr6T9qNofcSPnn5yUuAA==
X-Gm-Message-State: AOJu0YwesFWHKfxgZwq/6eBlhqD78ubKKUOx6rZWZQQOhO4oQDZa0h52
 rIkxlWEiGFKr9i4hz63FH2JMNOgFVVOqAyh3RMVvKfA0SlIdJ1a04O9NWn//TAlV1uEZ2C9XoHk
 J5ACEOOfXD8kWhT/X2T8r1yVk6kJ7tr7a3XQ4
X-Google-Smtp-Source: AGHT+IHbc42UKR0ggXRtxsZ5508vr1NZvjaR49OPE9H4N7Ke8QWTUOz8TEoAdiku7cxv5C0Gb2UqhYZonsfLgFiAofM=
X-Received: by 2002:a05:6214:5bc6:b0:6b7:42bd:99e9 with SMTP id
 6a1803df08f44-6bb983d5e9cmr6231336d6.35.1722528886380; Thu, 01 Aug 2024
 09:14:46 -0700 (PDT)
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
In-Reply-To: <CAC_iWjLrCM209h=mghHSNi=9aURY5P_-NyidQRJY1hR8D1FFBA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 10:14:35 -0600
Message-ID: <CAFLszTg998VrMeKHv=-==pS+9Q3NTuuJtHUJfxm38wxDOswp=Q@mail.gmail.com>
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

On Thu, 1 Aug 2024 at 04:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tom
>
> On Wed, 31 Jul 2024 at 20:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 08:39:23AM -0600, Simon Glass wrote:
> >
> > [snip]
> > > > > > so that
> > > > > > step three can be seeing what tweaks may be needed in where things
> > > > > > allocate memory.
> > > > >
> > > > > So my series is step 3?
> > > >
> > > > Or at least understanding what the problems may still be, yes.
> > >
> > > In that case I would like to clean up EFI's memory management before
> > > doing step 2, since I believe many of the problems will just go away
> > > if we can get that right.
> >
> > Well, I think that's where some of the big points of contention are,
> > yes. You say "fix" and Ilias and Heinrich say "but the spec".
>
> Using malloc on efi_allocate_pool() would be ok spec-wise. Simon's
> current patch is ignoring the efi memory type metadata we have to
> preserve. On top of that using malloc for a *single* memory type, just
> kicks the can down the road until an EFI app chooses a different type
> and we are back to the same problem.
>
> It's fine to teach efi_allocate_pool to use malloc with 2 conditions
> - memory types are preserved for all allocations
> - malloc area is big enough

OK thanks I will take a look.

I see the EFI code eventually dealing with memory in two distinct phases:
- before the app runs: we try to keep memory usage to within areas people expect
- once the app runs: t doesn't matter anymore

>
> Cheers
> /Ilias
>
> >
> > Perhaps once step one is done it will be easier to find a way to address
> > your concerns without also breaking "the spec".

Regards,
Simon
