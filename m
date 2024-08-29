Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96632C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4979288C90;
	Thu, 29 Aug 2024 17:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UVFdzFFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE4188C45; Thu, 29 Aug 2024 17:00:40 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473BC88C35
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf705959f1so7060766d6.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943637; x=1725548437; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4OxkXfxgeJFZHSvjOaB9yCSCoeq0bh2HYx9xcp20S1g=;
 b=UVFdzFFZB9pxpY58/YgLFhirzumlc1cPeV1wHqEKXgTOCLod4gmNq22Y+1SedGxeOZ
 1sT9B/I0c5fVyrbQCbEZwjwH3XPPvzEFNlZvHkTEyBJkfMMtzH/qvu26ReJJ7Z/Lv8SK
 9NBmeoxrC0HT3HF0vVuGPq85XQVmmpylicxRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943637; x=1725548437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OxkXfxgeJFZHSvjOaB9yCSCoeq0bh2HYx9xcp20S1g=;
 b=ForbIjn5uL5kQRIlHVIBIR945+hM2opobbUIznZDbCAtu8ceFdkvKOd3aT7y/4m6dU
 cTDsPMlc1V4s45lkdvwJHq+JZ9qqpR/MJemBPfFOCVIpIuiLqMjVTm5evGH7r/1PCbUj
 gJQm3VSeJFr/jcWTu8JWRJUG/8FVkvVyLkfHC2jZh3+NjmyzqXQDPXNPa77IgETIvZVi
 POPv5cx7WyrTBJt8vcv+UWQlGDLahmTqWWJdebfWIw+m5q5Zox+aIbPPXUeakrBIJe+1
 8qaDQUv8m1EIfXcTXYHo4u6ku40BIv8EZmyBQIh0tmTwwcr0+cSjDvYplKYEw3Mm1AVZ
 GSHg==
X-Gm-Message-State: AOJu0YxHOUPF8qUJqpXNBKzMBYhVzJcI9EgMwPcQmbvUz7W517ngvBBh
 m1DISI0rQCOknRYslknhIVoo4ljXkYHMh/GyJszdl4eRR3hID9W0p/CvuHBfq5+pWpybi/0kJ5W
 ULbxw2y9zwHjpe9NCbTNjzYPpixzBMgzh77cO4GiT0gz0b24=
X-Google-Smtp-Source: AGHT+IGsF4rCkd1Ow6Eh5ETtwkXhshselbPkGRWeXRaNdCAfCHBG39WJCDBUqRnmwsgSZ929d6S18hrDsxMRNFgRsZc=
X-Received: by 2002:a05:6214:3106:b0:6c1:6c05:fa87 with SMTP id
 6a1803df08f44-6c341d02305mr46542056d6.8.1724943636674; Thu, 29 Aug 2024
 08:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240829140921.GX2479150@bill-the-cat>
In-Reply-To: <20240829140921.GX2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:00:25 -0600
Message-ID: <CAFLszTgTwHbp8TPaca4jOis+qh=yEUpQA7T-w3toB4hLh0Y-MQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] labgrid: Provide an integration with Labgrid
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

On Thu, 29 Aug 2024 at 08:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 28, 2024 at 04:08:26PM -0600, Simon Glass wrote:
>
> > Labgrid provides access to a hardware lab in an automated way. It is
> > possible to boot U-Boot on boards in the lab without physically touching
> > them. It relies on relays, USB UARTs and SD muxes, among other things.
> >
> > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > which allowed my lab of about 30 devices to be operated remotely, using
> > tbot for the console and build integration. While it worked OK and I
> > used it for many bisects, I didn't take it any further.
> >
> > It turns out that there was already an existing program, called Labgrid,
> > which I did not know about at time (thank you Tom for telling me). It is
> > more rounded than Labman and has a number of advantages:
> >
> > - does not need udev rules, mostly
> > - has several existing users who rely on it
> > - supports multiple machines exporting their devices
> >
> > It lacks a 'lab check' feature and a few other things, but these can be
> > remedied.
> >
> > On and off over the past several weeks I have been experimenting with
> > Labgrid. I have managed to create an initial U-Boot integration (this
> > series) by adding various features to Labgrid[2] and the U-Boot test
> > hooks.
> >
> > I hope that this might inspire others to set up boards and run tests
> > automatically, rather than relying on infrequent, manual test. Perhaps
> > it may even be possible to have a number of labs available.
> >
> > Included in the integration are a number of simple scripts which make it
> > easy to connect to boards and run tests:
> >
> > ub-int <target>
> >     Build and boot on a target, starting an interactive session
> >
> > ub-cli <target>
> >     Build and boot on a target, ensure U-Boot starts and provide an interactive
> >     session from there
> >
> > ub-smoke <target>
> >     Smoke test U-Boot to check that it boots to a prompt on a target
> >
> > ub-bisect <target>
> >     Bisect a git tree to locate a failure on a particular target
> >
> > ub-pyt <target> <testspec>
> >     Run U-Boot pytests on a target
> >
> > Some of these help to provide the same tbot[4] workflow which I have
> > relied on for several years, albeit much simpler versions.
> >
> > The goal here is to create some sort of script which can collect
> > patches from the mailing list, apply them and test them on a selection
> > of boards. I suspect that script already exists, so please let me know
> > what you suggest.
> >
> > I hope you find this interesting and take a look!
> >
> > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > [4] https://tbot.tools/index.html
>
> Part of my concern here is still that this series contains:
>
> - Generic test improvements and fixes:
>
> >   test: Use a constant for the test timeout
> >   test: Pass stderr to stdout
> >   test: Avoid failing skipped tests
> >   test: Move the receive code into a function
> >   test: Separate out the exception handling
> >   test: Detect dead connections
> >   test: Tidy up remaining exceptions
> >   test: Improve handling of sending commands
> >   test: Fix mulptiplex_log typo
> >   test: Avoid double echo when starting up

So should I send those as a separate series?

Note that when things land we will need to look at the gitlab output,
to make sure it is what we want.

>
> - Labgrid specific listed as generic changes:
>
> >   test: Release board after tests complete
> >   test: Try to shut down the lab console gracefully
>
> - Your labgrid+builman implementation specific changes:
>
> >   test: Allow signaling that U-Boot is ready
> >   test: Allow connecting to a running board
> >   test: Create a common function to get the config
> >   test: Introduce the concept of a role
> >   test: Introduce lab mode
> >   test: Add a section for closing the connection
> >   test: Support testing with two board-builds
>
> Which makes this harder to review and clearly merge. For example, we
> already have hooks for power on / power off, and we should just call
> them as wow that would make everyones lab easier (I used to have a
> pre-script to turn on everything).

Power on/off is handled by the strategy[1] in Labgrid. Some boards
have power control, some don't. Some use reset, some don't. Some need
a recovery button to be pressed when resetting. The fundamental point
here is that Labgrid knows how to manage the lab, so any external
scripts are always going to be fiddly. Also, they are such a pain to
maintain.

I see Labgrid as a lab manager, something which looks after the lab
and knows how to operate it.

>
> --
> Tom

Regards,
Simon

[1] https://github.com/labgrid-project/labgrid/pull/1411/commits/7445dc5ea7ffcd9f5f1d99f5b12f58c6681ef6ac#diff-cb9504114f18f1638d04357204de7a2c4a7acb87347d6e97569b4ecf74adbabe
