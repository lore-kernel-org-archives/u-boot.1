Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897E6CA0ECD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A51A88D35;
	Fri, 30 Aug 2024 03:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHQYODgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB84288D28; Fri, 30 Aug 2024 03:06:17 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED5F388D17
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5dfabdbef52so233049eaf.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979974; x=1725584774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UPByMnZ5NhfAbExc8ePnzfRTjGlL1knHDHa7zODnbaY=;
 b=WHQYODgQ75eBABMmztCd/Jf8gJl2Q0fLZg7nUz/XPOZGVdfOuopMJV/WnRZAkpw7Al
 Zghr3XUBt4PJB4uEftVGNy1myrd9nivlrq4yUhV+v7nJ4H7VKXX1nyoL4otTXLOSSsId
 m4w7PdbSgYdBbbnKCJ0AqTinezCl82T/MJLUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979974; x=1725584774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UPByMnZ5NhfAbExc8ePnzfRTjGlL1knHDHa7zODnbaY=;
 b=utdErxMLDdgzYkdi4dfaN3/R6rmuIv/Mwbp6gP8wW68au7tsXkOURR47Oai/UieYyX
 FSz9Eko6iBzeswxK1CxN0FsNpqn85J/S73b6JMtrO2WCQJm0mKAHeN3RkyH4qV65LZpj
 1w+VtxlEpLk5vdh/XU8HAo/RHXpmglgy/vfIpSFAheHqO7JDr4fQqFa5ZZzCcyNbMJLp
 TFWVver/A0MnBEgaWu817Z5x2rqZ+qQBTSwPa2yNFXTmxgLrXh0/eR6lCYQ0tUWhggpA
 hHb2vBAsHt0hdvnxnd08GvLt9DGEnicsGu6X2mFcXkyhFXepOMARrzXrvWX4hIQhEQCG
 0/lA==
X-Gm-Message-State: AOJu0YxFsH6yYrx7+dqehKHvZYt26bPMGGd4h1essXxvCuOPjjTTlpMh
 1OVImQa+xUgG0NHlHi7k3lPxksxBp3NUqZ9KklIVndXzM+gnssyt1+seustzVN29crf2GdP/IEl
 HM5J0c6jZCbf6woFCWdBhKOJ5CdMZC7Rgh2/f
X-Google-Smtp-Source: AGHT+IE4HZ1G9wRlRn0CUcICvejHqUH5UeDHHnHxpz1B4sDZrkiL2jevCUb3TfEVG0lxIPoEgaEGim8Fmg6gvyZAFwI=
X-Received: by 2002:a05:6820:1506:b0:5d5:9ffb:b9de with SMTP id
 006d021491bc7-5dfacf11c85mr795076eaf.4.1724979973616; Thu, 29 Aug 2024
 18:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
 <20240827165025.GN2479150@bill-the-cat>
 <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
 <20240827214330.GP2479150@bill-the-cat>
In-Reply-To: <20240827214330.GP2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:03 -0600
Message-ID: <CAFLszTiywgEjTB2s4Zmz4vcmqLhRXLcbTnJGyig3b38c9Y2KUw@mail.gmail.com>
Subject: Re: xPL terminology
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

On Tue, 27 Aug 2024 at 15:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 27, 2024 at 01:24:59PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 27 Aug 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:
> > >
> > > > Hi,
> > > >
> > > > We have the term 'SPL', which has a dual meaning. It is both a
> > > > particular phase of U-Boot (the one that loads U-Boot proper) and a
> > > > generic name for any pre-proper phase.
> > > >
> > > > You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> > > > enabled for TPL and VPL builds, not just SPL.
> > > >
> > > > I propose to rename the generic term from SPL to xPL (meaning any PL
> > > > phase), leaving SPL to just refer to the phase before U-Boot proper.
> > > >
> > > > The symbol would be CONFIG_XPL but in documentation we would talk of
> > > > xPL, with a lower-case X, so it is more obvious that it refers to any
> > > > phase.
> > > >
> > > > What do you think?
> > >
> > > I still worry this is just another part of the long symptom of needing
> > > to re-work how we configure / build as we have 1 case of "build things
> > > this way" (full U-Boot) and N cases of "build things another way" (SPL,
> > > TPL, VPL, UPL?). And really we need a way to short-hand
> > > "fooboard_defconfig" means "fooboard_spl_defconfig +
> > > fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".
> >
> > IMO my XPL series does this, at least for some definition of this. I'd
> > really like to get that in as it would make all of this much easier.
>
> Yeah, what I recall of your XPL series was that it made a lot of changes
> I didn't like and highlighted what I thought was that yes, really
> Yamada-san was right all along and we need a different way of
> configuring + building.
>
> I had even today thought that we could possibly
> get away with some shorthand where if for "fooboard_defconfig" we _also_
> had "fooboard_spl_defconfig" we knew to build in ${O}/spl/ the spl
> variant. It would be harder for cases where we have "fooboard_defconfig"
> and "fooboard_hs_defconfig" that both need "fooboard_spl_defconfig", but
> it would cover many cases at least. Anyhow...

We should discuss this sometime as it has come up once or twice
before. Given the dependencies between XPL and proper and don't think
we can sensible split into separate files, let alone separate the
Kconfig. In fact I still believe that we need a small Kconfig-language
addition to support this sort of thing and avoid duplicating the rules
everywhere*. I believe I might have even done a patch for it. We got
very close to sorting all this out a year or two ago and then it all
died.

We are really stuck on making progress on 'generic XPL' (or whatever
it is called) until we can figure this out.

>
> I think a series that replaces CONFIG_SPL_BUILD with CONFIG_XPL_BUILD
> (and the required logic to make that work...) would be fine.

OK.

>
> > > But on the flip side, I also suppose replacing CONFIG_SPL_BUILD with
> > > CONFIG_XPL_BUILD would be less confusing.
> >
> > Yes. What do you think of E's idea of renaming all the options? I
> > quite liked it when I read it, but now I am thinking that having
> > everything be xPL is quite a nice convention. If we have SETUP_... and
> > TINY_... it is less clear that they are related.
>
> Yes, I think we need better descriptive documentation for what we have
> and then only maybe renaming a few things that might be too cryptic.

OK. Well I can look at splitting CONFIG_SPL_BUILD into two:

- CONFIG_XPL_BUILD means that it is not building U-Boot proper (i.e.
the current meaning of CONFIG_SPL_BUILD
- CONFIG_SPL_BUILD means it is building SPL (and not TPL or VPL)

Regards,
Simon

* Yes, Linux will never accept a Kconfig addition; this is the same
Linux that refused FIT for 10 years so IMO that issue is not relevant
to the discussion or what is best for U-Boot
