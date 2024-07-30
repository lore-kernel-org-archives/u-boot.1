Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B83C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 22:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB29882F0;
	Wed, 31 Jul 2024 00:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DRtGicLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9437C8882F; Wed, 31 Jul 2024 00:35:21 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9C587919
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b79293a858so24462806d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722378918; x=1722983718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T3Hwc6uE85gHH7uNy/qst7q8cmcimnVOcFNd7EXNGGA=;
 b=DRtGicLfbl2XEAFR4y66fVJ5zUJGBNfIUsOj0nWMfZkpZby5iHvTtpgZfzhcxzQpZW
 PtDepwHoEpYMDfO+WAvme1VnAsfHsQcbnmFlW6NWbDhJ3eDN0fBsHLT3XD+B75rUjcL+
 FkKtGmm3mslynpgQ4KdgrCdFCzOHo9f0oN/2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378918; x=1722983718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3Hwc6uE85gHH7uNy/qst7q8cmcimnVOcFNd7EXNGGA=;
 b=jSJY7aetxOo/bQFVvJ34I4XU0dpH0XYBNxbxONaowkks5NhI4lSB85jD4KTCelEK8R
 Owv47nHpRF+kHhpbj1xP9E9UordhGMbnBl5NqsIkn1JbFpk57iAn4oOMbg39XWSMzvjQ
 jioF2l0Rj55MQCy0CPPEe40A4dKjPvIxGUoqtbL4JVo9b8C8JJ+AARJgsyFQdF98tRqD
 wXYX4FX13K9sh9O8KWFO5Y5vB51gZDD1RMZBt7VumWg6J0JF23F9qqApF9zwl5RN9xL6
 OjvWnkrax2A/KS5WkL7lnX8pb05YyGmMsQoCjj8j+wweGMAm54chXsqx54ktQmLol+1s
 gi6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW94HQ3NQKHyqh8/ZmCElkBcYoo2naCUj/q70n5K7NP3lms6IPoxCpS9ME6GpZDh5PayWm3dPFMzeIGmZxdygyNDNrhdg==
X-Gm-Message-State: AOJu0YxP9bogh0hl7CkzWha30zsP8m/gGRJvwRF1UNvxk+oJXGWVGX/N
 Fr1QcG8rcmUgPnz8L3Z88KCcOA6RTfcdCGYh9fm+aOmeelV8miBO07bvtms4HdQPbYyaTjBgX2r
 INd77ErzUcAzRSCrDSgAOWgtpK1IW0Glv8bQk
X-Google-Smtp-Source: AGHT+IFdM3FVmaQhGrMKxJPQwzumtm0i6N3W2CzgpSyRtBokYyqakgkYtefwLFYyXFswq86gW43ajbVgkxgLJMZARt4=
X-Received: by 2002:a05:6214:daf:b0:6b7:b285:74eb with SMTP id
 6a1803df08f44-6bb55a2b8eemr169287696d6.19.1722378917643; Tue, 30 Jul 2024
 15:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
 <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
 <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
 <CAC_iWj+Y+hXwjgcVaMdEYrE_G9XuuhiZQnp2ckCYNkzYPZN3tQ@mail.gmail.com>
 <CAFLszThK_FnLxWrSzax_Jm7XMmmTanTmGrLjK3MfCM0uqKsNOw@mail.gmail.com>
 <ZnLR_NnJY3hFBXcR@hera>
 <CAFLszTitfewWG_dHDM3idEyntkL8tjvh6puH08+aUDeXLy4+LQ@mail.gmail.com>
 <CAEfUkU+AJb8z6_KgMVac90iQ6R4P0dNTgq5hitvZrXDQ8x8B1w@mail.gmail.com>
 <CAFLszTjQwiJFbgG+aXf9qmXPbHSP6JVowhv=xdZYr3B45_+1nA@mail.gmail.com>
In-Reply-To: <CAFLszTjQwiJFbgG+aXf9qmXPbHSP6JVowhv=xdZYr3B45_+1nA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 16:35:06 -0600
Message-ID: <CAFLszThtUprUv5ZsoN-R_W2c9YG4FvvZ6zT_qGpqOwW5Axbs1Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Shiji Yang <yangshiji66@outlook.com>
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

Hi all,

On Fri, 21 Jun 2024 at 12:16, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 21 Jun 2024 at 10:40, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 21 Jun 2024 at 10:58, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Ilias,
> >>
> >> On Wed, 19 Jun 2024 at 06:41, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >> >
> >> > Hi Simon,
> >> >
> >> > On Wed, Jun 12, 2024 at 02:24:31PM -0600, Simon Glass wrote:
> >> > > Hi Ilias,
> >> > >
> >> > > On Wed, 12 Jun 2024 at 00:02, Ilias Apalodimas
> >> > > <ilias.apalodimas@linaro.org> wrote:
> >> > > >
> >> > > > [...]
> >> > > >
> >> > > > > > > >> ---
> >> > > > > > > >>
> >> > > > > > > >>  lib/fdtdec.c | 12 ++++++++++--
> >> > > > > > > >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >> > > > > > > >>
> >> > > > > > > >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> >> > > > > > > >> index b2c59ab3818..b141244e3b9 100644
> >> > > > > > > >> --- a/lib/fdtdec.c
> >> > > > > > > >> +++ b/lib/fdtdec.c
> >> > > > > > > >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> >> > > > > > > >>  {
> >> > > > > > > >>         int ret = -ENOENT;
> >> > > > > > > >>
> >> > > > > > > >> -       /* If allowing a bloblist, check that first */
> >> > > > > > > >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> >> > > > > > > >> +       /*
> >> > > > > > > >> +        * If allowing a bloblist, check that first. This would be better
> >> > > > > > > >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> >> > > > > > > >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> >> > > > > > > >
> >> > > > > > > > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> >> > > > > > > > but actually you are using it below. Is it a typo?
> >> > > > > > >
> >> > > > > > > Basically it would be cleaner to have a separate, phase-specific
> >> > > > > > > Kconfig control as to whether the DT can come from the bloblist (I
> >> > > > > > > can't remember the Kconfig name I suggested, nor the patch as it was
> >> > > > > > > last year sometime). But for now I am adding this hack to get a few
> >> > > > > > > boards working again.
> >> > > > > >
> >> > > > > > I am a bit confused.
> >> > > > > > First of all the comment is innapropriate. We went through a lengthy
> >> > > > > > discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
> >> > > > > > made up our minds. Why are you adding this comment now? Why do code
> >> > > > > > comments have to illustrate your personal opinion -- which was
> >> > > > > > rejected?
> >> > > > >
> >> > > > > I'm sorry for the tone of the comment. I am not trying to offend
> >> > > > > anyone here and I'm happy to change the language.
> >> > > >
> >> > > > Yes please a comment explaining why that piece of code is there is far
> >> > > > more intuitive.
> >> > >
> >> > > OK, once we have agreed the below I can do that.
> >> > >
> >> > > >
> >> > > > >  As I probably
> >> > > > > mentioned at the time, my accepted patch breaks my workflow and
> >> > > > > several boards. I hope you can understand how frustrating that sort of
> >> > > > > thing can be.
> >> > > >
> >> > > > Yes, I do and I am fine with a short-term patch that fixes issues, as
> >> > > > long as its not too intrusive. There is a very thin line between quick
> >> > > > and dirty fixes to spaghetti unreadable code. But we should have
> >> > > > comments and/or commit messages indicating that this needs a proper
> >> > > > fix
> >> > >
> >> > > I spent a lot of time explaining this last time.
> >> > >
> >> > > >
> >> > > > > Also, now that I have my lab back up and running and I
> >> > > > > would like these boards to work again on mainline!
> >> > > > >
> >> > > > > >
> >> > > > > > Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?
> >> > > > >
> >> > > > > Remember, it was a patch you rejected :-)
> >> > > >
> >> > > > I don't maintain any of that. I only gave some feedback along the
> >> > > > lines of "bloblist was designed to be auto-discoverable, I don't see
> >> > > > how adding an explicit Kconfig helps". IIRC we eventually followed
> >> > > > what Tom suggested.
> >> > >
> >> > > I'm not trying to point the finger here. So far the boards are broken
> >> > > in mainline...I'm just trying to fix that,
> >> > >
> >> > > >
> >> > > > In any case, the amount of bike-shedding in the topic is too much. Do
> >> > > > you mind explaining the problem in your workflow again? Perhaps we can
> >> > > > find a solution that is integrated in bloblist_maybe_init() instead of
> >> > > > injecting ifs on when a bloblist should or should not be searched for
> >> > > > all over the place.
> >> > >
> >> > > TPL (or SPL) sets up a bloblist with bits of info in it, but no DT
> >> > > (which is in memory-mapped SPI flash)
> >> > > U-Boot proper starts up, it wants to get the bloblist but not hang if
> >> > > the bloblist doesn't have a DT
> >> >
> >> > Sure, that's reasonable and IIRC that's the design we agreed a while back.
> >> > Looking at the code, if the DT isn't found in a bloblist and the feature is
> >> > enabled, we don't crash. We just print a debug message and continue to find
> >> > the DT as we used. Why do we have to skip the call to
> >> > bloblist_maybe_init()?
> >>
> >> Because at this point, if there is no bloblist, then it needs to be
> >> created. But creating it this early may fail, e.g. since there is no
> >> malloc(). The intent of this code is to locate an FDT from an existing
> >> bloblist. There is no point in creating a new bloblist here, since it
> >> obviously won't have an FDT in it.
> >>
> > Can we add a bool arg to bloblist_init for this?
> > Eg. int bloblist_init(bool allow_malloc);
>
> Yes, we can do anything, but that seems like a hack to me...if we init
> the bloblist for the first time in the current phase, then it
> obviously won't have an FDT inside it. It is the unconditional
> requirement of an FDT which is causing the problems here.

Can we apply this patch, please? I still have several broken boards in
my lab due to this.

Regards,
Simon
