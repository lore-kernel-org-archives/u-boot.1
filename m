Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808D4C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D381F88381;
	Thu, 29 Aug 2024 00:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FAhOO+uO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268DE8862E; Thu, 29 Aug 2024 00:28:01 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC23387E64
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1dcba8142so89762385a.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724884078; x=1725488878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EKaYZWRmpXzI0G72f7BD3P88yPxT5PxoYiWAv/uvlXA=;
 b=FAhOO+uOU3FKJejDW+W5DWVqEZeW4+KCyUoOGCN9OjQoDLLP/XrJS9oNJTmcShYy0V
 X6DoHrfKZ7iAmo9iuqbHSZua7PzfhrG1CYwNqyY/F7om22jYrmhqd39kc0c1jZ4nWVm9
 ePJoTw1Kna+mdFW7NSZQ4xBW0LmtshzP7REAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724884078; x=1725488878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EKaYZWRmpXzI0G72f7BD3P88yPxT5PxoYiWAv/uvlXA=;
 b=idVfcmT/428HFAKd1s6qu0YQtYJAn55MJVbNHb68oaw2Oi+kF7nm/EkqqBfULPnIZf
 D68bQ/HgjwCZm/LUWrT7ClasU2+FEH+TDRjeQwMjgtOqzMDBebiLiGMhTO/1KoKKpOVP
 iA0nv9Pt3QXcZW5+5ClJeRe9cpc1JdpPnk9UGeBZejF3R3Kws52AWpY4ER44buyz4laG
 MeIEjVkEguOpPrJLNzt2FzOsr4c4jQ+VgEFyqeVVU8Cr8xmbIiFUx3xXCR4iSJ9fYvD0
 oPxo2LFnju96stNFKX1gvEptw9BD1QuxbSPQdfyEVhg6NyQ1zPbpAR7ZzybpA0xP3EyA
 aUZQ==
X-Gm-Message-State: AOJu0Yzmb/u/lgAwNGzLK1GIccnMfPBYMVEX/iMPlIlsT+6+Zfv4qVo7
 rHDbKAzNHNQ+rd89S4LcuqfHr27o4pZGt0EHfQDDIaQTiXeGwhl9aWkcM6YG1AEuzVTCeG07wPp
 o8ckGXOVv4B6NYqqCxstFZ+M3jPOVqUy5F0q+IkiCUxBoV58=
X-Google-Smtp-Source: AGHT+IGpwKEzqsaEPbAAuN51maDjGwgtTBrYJI+/flHH4Up23DInc7cj74zd2032p3035GPV4M/VcDz1xT4Zpg7OLng=
X-Received: by 2002:a05:6214:4203:b0:6af:33ed:87de with SMTP id
 6a1803df08f44-6c33f37dc39mr11812026d6.20.1724884077799; Wed, 28 Aug 2024
 15:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <20240828201912.GV2479150@bill-the-cat>
 <CAFLszTjzH9kiM3SEzfjfhCWMCMnLLeBy1UipH9kW0-z3s-1xxA@mail.gmail.com>
 <20240828213345.GW2479150@bill-the-cat>
In-Reply-To: <20240828213345.GW2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 16:27:47 -0600
Message-ID: <CAFLszTjG1ySeXpWD60aNEX5Te0nRKC53EXP5L1AoG+kXqFe8Ew@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 28 Aug 2024 at 15:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 28, 2024 at 03:25:00PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 28 Aug 2024 at 14:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 28, 2024 at 10:45:23AM -0600, Simon Glass wrote:
> > >
> > > > With Labgrid we don't need to specify the various methods, except for
> > > > the console, which simply calls labgrid-client.
> > > >
> > > > This allows supporting any boards in your lab, without adding per-board
> > > > configuration to these hooks.
> > > >
> > > > Provide ellesmere files as an example.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > I think maybe we call this version "labgrid-buildman" and make sure the
> > > documentation emphasizes using buildman to provide U-Boot. This will
> > > make it easier for me to provide a follow-up of say "labgrid-external"
> > > that requires the binary to be provided, similar to our other hooks.
> >
> > It can be used in this way. The 'ub-pyt -B' does a bootstrap of the
> > board without doing a build, if that helps to show the path through
> > the code.
> >
> > If you don't pass --build to test.py then it won't do a build.
> >
> > If you like, you can pass --build-dir (and with the testb series
> > --build-dir-extra) as you do now. The binary will be written to the
> > board as is.
>
> Right, but this gets back to what I'm most confused about (and need to
> talk with Kevin Hillman about maybe, but I missed my last meeting where
> he was as well), you have a bunch of logic for integration of buildman
> too, and I have a few wrappers around exiting labgrid-client commands.
> And I don't know what direction upstream is going to want to take.

Hmm, who is Kevin?

At the moment we are a long way from upstream. I have only one
reviewed patch and it is pretty trivial. I just updated the stack
again. I am hoping to meet some of the people in a few weeks, but they
are pretty tied up on other projects, from my understanding.

Anyway, we could have a chat about it if you like. So far I'm pretty
comfortable with the approach taken here. At this point it replaces my
Labman as well as tbot for my use cases. Without integrated building,
everything will be a PITA for me.

I am not sure this much matters on your side though, since you don't
intend to use the building features here? How exactly are you building
U-Boot? Is it using the --build option with pytest, or something else?

In the interim, one way of threading the needle would be to have
test.py get the info from Labgrid using the 'query' and then run in
the build in pytest. Or, even worse, have a separate yaml file with
the required info and parse that in pytest and run buildman there...
but as I say we are a long way from getting this integrated into
Labgrid, so it is somewhat academic at present.

My immediate goal is to get all these things merged in U-Boot, so I
can get my lab running properly with gitlab, etc. and ideally allow
other custodians to push to it. Getting the integration landed in
labgrid will likely come a lot later.

Regards,
Simon
