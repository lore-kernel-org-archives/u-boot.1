Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1047C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB46188B9C;
	Sun,  1 Sep 2024 22:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YbarXyxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E2C88BFB; Sun,  1 Sep 2024 22:10:16 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBB888B2D
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-715abede256so2590550b3a.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221412; x=1725826212; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r4tioo7mCgoxNcbps4AgW2YafjY+mbhIQ0qtMXmgVlM=;
 b=YbarXyxu8hfxkKv2atlayKQRr+Z5ynpUxgm8rZ3GaPhkkzJFlj3TthrSknqjgJ0DMy
 ol2gfkDaYDkywlKCPF5DHH2Vyio2dodgp5z+wjxotpAaYR4+9QIkZ4JhtPN9+LThA4hF
 ejpKxtNVqWuWcvub71NTfPPzE7ejzgyoXWFvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221412; x=1725826212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r4tioo7mCgoxNcbps4AgW2YafjY+mbhIQ0qtMXmgVlM=;
 b=umZSUk4iZvsYN3/3/0KzoxdsqD3n/xFtVGNozhwl1FYTq757UEmTebPdi4hB5dqdXB
 OqmJkfnCbueBeGDbMhjgXp+44rMUF5TxS6BwiGdW5xKDrFIbnP9bljj8yy3X5goFR6da
 iyDuzyxpUdOBSych6YRBK/yhABCVkXAB062xM0fn85Umr+gbmbLm1MIE4lJ3wt4LIF1M
 724Cgv9wnzOxw4MRN192ERpxRHos3076utqPvaMdcn4UBFIF/901qnJNButUVBptJSwA
 eAJOH75E9wGSZ/lgw6FG2Zc6bEh8lZrOSnrTxwJ+ZI1RjiAPmvIHHQ9RlrSSW8aZH9gH
 4/dw==
X-Gm-Message-State: AOJu0YxjxR9Y/aFD59j94eiKW6/jXxDNi6mjMPEGIMWhCsVRQPfEc2Md
 I1NSthyN8GDmuQHCjbb1pAADMU9/d4sTe91+8WehVeaxA0/Kv+qbi1vcM0CN5QISyMJSd7LEMDk
 JzGAas+qjrvztREkmi/nQKZxOzmJzh0V8FvTS
X-Google-Smtp-Source: AGHT+IF1EAaVU/8xErQRXCbQdrLWa279/iFB5tq9LVrrHOoBOKkBWNJC9EaFb1z2APwiF1UGtqq7vFi0+iuBHkGjHrM=
X-Received: by 2002:a05:6a20:c908:b0:1c4:9e5f:c645 with SMTP id
 adf61e73a8af0-1ced62de9c9mr3119744637.40.1725221412376; Sun, 01 Sep 2024
 13:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240829140921.GX2479150@bill-the-cat>
 <CAFLszTgTwHbp8TPaca4jOis+qh=yEUpQA7T-w3toB4hLh0Y-MQ@mail.gmail.com>
 <20240830215350.GW2479150@bill-the-cat>
In-Reply-To: <20240830215350.GW2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:59 -0600
Message-ID: <CAFLszTi9d7T9FBzGDh7mFUyxg9MhKUwFTDHzsOM+imTucf_g-g@mail.gmail.com>
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

On Fri, 30 Aug 2024 at 15:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 09:00:25AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 29 Aug 2024 at 08:13, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 28, 2024 at 04:08:26PM -0600, Simon Glass wrote:
> > >
> > > > Labgrid provides access to a hardware lab in an automated way. It is
> > > > possible to boot U-Boot on boards in the lab without physically touching
> > > > them. It relies on relays, USB UARTs and SD muxes, among other things.
> > > >
> > > > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > > > which allowed my lab of about 30 devices to be operated remotely, using
> > > > tbot for the console and build integration. While it worked OK and I
> > > > used it for many bisects, I didn't take it any further.
> > > >
> > > > It turns out that there was already an existing program, called Labgrid,
> > > > which I did not know about at time (thank you Tom for telling me). It is
> > > > more rounded than Labman and has a number of advantages:
> > > >
> > > > - does not need udev rules, mostly
> > > > - has several existing users who rely on it
> > > > - supports multiple machines exporting their devices
> > > >
> > > > It lacks a 'lab check' feature and a few other things, but these can be
> > > > remedied.
> > > >
> > > > On and off over the past several weeks I have been experimenting with
> > > > Labgrid. I have managed to create an initial U-Boot integration (this
> > > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > > hooks.
> > > >
> > > > I hope that this might inspire others to set up boards and run tests
> > > > automatically, rather than relying on infrequent, manual test. Perhaps
> > > > it may even be possible to have a number of labs available.
> > > >
> > > > Included in the integration are a number of simple scripts which make it
> > > > easy to connect to boards and run tests:
> > > >
> > > > ub-int <target>
> > > >     Build and boot on a target, starting an interactive session
> > > >
> > > > ub-cli <target>
> > > >     Build and boot on a target, ensure U-Boot starts and provide an interactive
> > > >     session from there
> > > >
> > > > ub-smoke <target>
> > > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > > >
> > > > ub-bisect <target>
> > > >     Bisect a git tree to locate a failure on a particular target
> > > >
> > > > ub-pyt <target> <testspec>
> > > >     Run U-Boot pytests on a target
> > > >
> > > > Some of these help to provide the same tbot[4] workflow which I have
> > > > relied on for several years, albeit much simpler versions.
> > > >
> > > > The goal here is to create some sort of script which can collect
> > > > patches from the mailing list, apply them and test them on a selection
> > > > of boards. I suspect that script already exists, so please let me know
> > > > what you suggest.
> > > >
> > > > I hope you find this interesting and take a look!
> > > >
> > > > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > > > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > > > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > > > [4] https://tbot.tools/index.html
> > >
> > > Part of my concern here is still that this series contains:
> > >
> > > - Generic test improvements and fixes:
> > >
> > > >   test: Use a constant for the test timeout
> > > >   test: Pass stderr to stdout
> > > >   test: Avoid failing skipped tests
> > > >   test: Move the receive code into a function
> > > >   test: Separate out the exception handling
> > > >   test: Detect dead connections
> > > >   test: Tidy up remaining exceptions
> > > >   test: Improve handling of sending commands
> > > >   test: Fix mulptiplex_log typo
> > > >   test: Avoid double echo when starting up
> >
> > So should I send those as a separate series?
>
> Well, as some of the other comments have been getting to, I don't know
> what's really useful / needed, or not here.
>
> > Note that when things land we will need to look at the gitlab output,
> > to make sure it is what we want.
>
> In general getting our pytest output more understandable is always nice
> and useful, but this shouldn't be any different from all the platforms
> we already test in CI.

OK I can adjust that. For my testing I have it spitting out all the
output, since hunting through log files to see why a particular board
didn't boot is a right pain.

>
> > > - Labgrid specific listed as generic changes:
> > >
> > > >   test: Release board after tests complete
> > > >   test: Try to shut down the lab console gracefully
> > >
> > > - Your labgrid+builman implementation specific changes:
> > >
> > > >   test: Allow signaling that U-Boot is ready
> > > >   test: Allow connecting to a running board
> > > >   test: Create a common function to get the config
> > > >   test: Introduce the concept of a role
> > > >   test: Introduce lab mode
> > > >   test: Add a section for closing the connection
> > > >   test: Support testing with two board-builds
> > >
> > > Which makes this harder to review and clearly merge. For example, we
> > > already have hooks for power on / power off, and we should just call
> > > them as wow that would make everyones lab easier (I used to have a
> > > pre-script to turn on everything).
> >
> > Power on/off is handled by the strategy[1] in Labgrid. Some boards
> > have power control, some don't. Some use reset, some don't. Some need
> > a recovery button to be pressed when resetting. The fundamental point
> > here is that Labgrid knows how to manage the lab, so any external
> > scripts are always going to be fiddly. Also, they are such a pain to
> > maintain.
> >
> > I see Labgrid as a lab manager, something which looks after the lab
> > and knows how to operate it.
>
> I think the biggest take away here is that we need to make sure whatever
> goes in to the hooks repository can be easily customized to fit how
> someone uses their lab, and that's going to be different from what I
> have and what you have.

Yes and be sure that my Labgrid stuff doesn't stomp on some other use case.

Regards,
Simon
