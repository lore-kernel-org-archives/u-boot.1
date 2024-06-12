Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15F7C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904E98888F;
	Wed, 12 Jun 2024 22:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXSZqUM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0ABB88888; Wed, 12 Jun 2024 22:24:50 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781C3882B6
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so180272a91.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223887; x=1718828687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FKO08LYkCwRomaCLXY85Tx5g50BMD9EtyWkO8k/Tl14=;
 b=kXSZqUM9zdOVjagbkWTTPRAegw+Zo5XTI95BZR4nBcgDtZfHZl8UETYPwDcYQ0KpxG
 s7oK8VYcM7TX84/OZuj2Arz6258XjOEp+k5MxzCZ+wqJzzsYTPZN7HdwIp4xYyEdra79
 A5YdCZlrgvGvX/bA+h60QoEzxFHNZAO8JzBew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223887; x=1718828687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKO08LYkCwRomaCLXY85Tx5g50BMD9EtyWkO8k/Tl14=;
 b=X9WwjWcpgheE37aePDDJGM0F0adJFsRq17+wekuRHkNZqLPe2HDJ10D97tnRyUfJsw
 RkLSfCAbTn90XhR2hk9DtrKuDj6WTknU7mGaZcZmrhnW6HHpw2zPEscT1UiLjB2TRfI5
 cLINGCWleIOZorfIIQMK6QN5yOHQl4GSYdJrVSH61tn3dFWXJrXH57uwjo0OJKZeqo3b
 St75b4Z8j/LoxPV2astRG5DDdg/Pr9up28bgjhwX4tizFbLP4rJgKaAALHyAH52EZio6
 JdUJojUDok6RM28loEnuvKCd6WRmIqUp85zn4tEEOs/Pt9Gg6a9HPUJcHrVN7SJ8in0o
 J04A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJoWeThgpUygCdGv0p7qXN9LMr/jLYTP+NDxc4JWR348ZQgvzWoBM4i6C8E7jAi1fMfpuuw2xinvzsKPURQFbNBrl5Gg==
X-Gm-Message-State: AOJu0YyKq9rH6RvNbXlR2MPkuTTydXKHoyjNo+sHo2hqKvIJa31ThJid
 1G/Pw+mOkQZ1yNZALy+fNIGfUUFayLEgKjdg28phPTmd8zQDYJ7tkRTKlBRZjEh9e1ZkvuaTAmF
 LNFscgh7uOFEdLVZ+NzH9v4DLu3HbAY9p/aUC
X-Google-Smtp-Source: AGHT+IFcUyXpKsZFAsAvxvsmSuJfnxFQB2EDveFxA0ppnV/nay/b+0+ldwIg6atYvimwBFCp8JQLoolfOiqyYtzGQn4=
X-Received: by 2002:a17:90b:714:b0:2c1:ebc4:4f1f with SMTP id
 98e67ed59e1d1-2c4a76d4951mr2995917a91.33.1718223886999; Wed, 12 Jun 2024
 13:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
 <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
 <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
 <CAC_iWj+Y+hXwjgcVaMdEYrE_G9XuuhiZQnp2ckCYNkzYPZN3tQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+Y+hXwjgcVaMdEYrE_G9XuuhiZQnp2ckCYNkzYPZN3tQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:31 -0600
Message-ID: <CAFLszThK_FnLxWrSzax_Jm7XMmmTanTmGrLjK3MfCM0uqKsNOw@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
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

Hi Ilias,

On Wed, 12 Jun 2024 at 00:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > >> ---
> > > > >>
> > > > >>  lib/fdtdec.c | 12 ++++++++++--
> > > > >>  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > >> index b2c59ab3818..b141244e3b9 100644
> > > > >> --- a/lib/fdtdec.c
> > > > >> +++ b/lib/fdtdec.c
> > > > >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> > > > >>  {
> > > > >>         int ret = -ENOENT;
> > > > >>
> > > > >> -       /* If allowing a bloblist, check that first */
> > > > >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > > > >> +       /*
> > > > >> +        * If allowing a bloblist, check that first. This would be better
> > > > >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> > > > >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> > > > >
> > > > > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> > > > > but actually you are using it below. Is it a typo?
> > > >
> > > > Basically it would be cleaner to have a separate, phase-specific
> > > > Kconfig control as to whether the DT can come from the bloblist (I
> > > > can't remember the Kconfig name I suggested, nor the patch as it was
> > > > last year sometime). But for now I am adding this hack to get a few
> > > > boards working again.
> > >
> > > I am a bit confused.
> > > First of all the comment is innapropriate. We went through a lengthy
> > > discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
> > > made up our minds. Why are you adding this comment now? Why do code
> > > comments have to illustrate your personal opinion -- which was
> > > rejected?
> >
> > I'm sorry for the tone of the comment. I am not trying to offend
> > anyone here and I'm happy to change the language.
>
> Yes please a comment explaining why that piece of code is there is far
> more intuitive.

OK, once we have agreed the below I can do that.

>
> >  As I probably
> > mentioned at the time, my accepted patch breaks my workflow and
> > several boards. I hope you can understand how frustrating that sort of
> > thing can be.
>
> Yes, I do and I am fine with a short-term patch that fixes issues, as
> long as its not too intrusive. There is a very thin line between quick
> and dirty fixes to spaghetti unreadable code. But we should have
> comments and/or commit messages indicating that this needs a proper
> fix

I spent a lot of time explaining this last time.

>
> > Also, now that I have my lab back up and running and I
> > would like these boards to work again on mainline!
> >
> > >
> > > Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?
> >
> > Remember, it was a patch you rejected :-)
>
> I don't maintain any of that. I only gave some feedback along the
> lines of "bloblist was designed to be auto-discoverable, I don't see
> how adding an explicit Kconfig helps". IIRC we eventually followed
> what Tom suggested.

I'm not trying to point the finger here. So far the boards are broken
in mainline...I'm just trying to fix that,

>
> In any case, the amount of bike-shedding in the topic is too much. Do
> you mind explaining the problem in your workflow again? Perhaps we can
> find a solution that is integrated in bloblist_maybe_init() instead of
> injecting ifs on when a bloblist should or should not be searched for
> all over the place.

TPL (or SPL) sets up a bloblist with bits of info in it, but no DT
(which is in memory-mapped SPI flash)
U-Boot proper starts up, it wants to get the bloblist but not hang if
the bloblist doesn't have a DT

Regards,
Simon
