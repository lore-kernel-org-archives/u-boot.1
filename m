Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76FFC369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E236088363;
	Wed, 25 Sep 2024 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QbPc+0FE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FA788BBF; Wed, 25 Sep 2024 14:50:28 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AEB88C40
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso3011846d6.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268621; x=1727873421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6FMzWHOCGdqPf7Cy0NXWk7U7KlDEVngYbgjbwWgIu8=;
 b=QbPc+0FEDX8BHt+qmQqoDLenFjxsByFRCdG/KLi6hnbqlqj9NsOFNMLEfuSxu9J373
 gUH2W1bwDefseMuuIn2SJcCZfcs3Tn2MUCGHQlM9zPCzek1a9KyO0R21VE+LE3GRE3Cc
 YZzC0hylKoYr9OlYC0BS4JJt0c2DxwtOZubz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268621; x=1727873421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6FMzWHOCGdqPf7Cy0NXWk7U7KlDEVngYbgjbwWgIu8=;
 b=QfyYV0NpvszLerWo4fOepESe5X2a3GCG/IbY+NQvtcRbgFVcYk6Gxk0OTvacQtNkZD
 ZFRUUuqutc8pQ02iLsx0fmQeUYNrPNGsA7onLvPaMnB+Lj9n7Kvv9cybwYrIMYqi0wYc
 l43rW+62HNuJ/30Tn/q0t0Nz+Lfy6FJxXWqdbsGtiX0XpUzOKUMMohGwyEnPQWAE/jss
 oSvpqFfkfuGvmqzRNJw2PQkPFsROyWHlGdk+F67JAgwN+polCmgy1tb29Gk+XHMMpoA6
 e7GAs++zVKZpZL+ZcP06krdiH8aaqPGrkhnI76r7XYbMrBneFwhftNfJ5Gmx0XOIyvBu
 n5rA==
X-Gm-Message-State: AOJu0Ywl+V7wn8pQawHuxDPUMX5U+pKfwMdQB3UmSStCHbKFvXDM3EFd
 WOx9yZfkJXhuBAbMrtvGMszlGOHNnSjVJh4jGq/OJqoHIgVOqiDviaFU+rVVAcfbjvF0DJeogBB
 MxZ1qh0VP269JYI0tm50uQXSLJgVGpvPrtA/Dj+LkaADI8q8aDw==
X-Google-Smtp-Source: AGHT+IFDyVGGh04VgwVl1ytPdYn2FxVdm9zSp34NPd6HUAhzXMvPyyW5wZ0HOjed00WGxAdTaVaX6Nd9ROzIi9Tx+4g=
X-Received: by 2002:a05:6214:2409:b0:6c5:88bf:b268 with SMTP id
 6a1803df08f44-6ca8d2b648emr122713946d6.1.1727268621561; Wed, 25 Sep 2024
 05:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240923203612.GT4252@bill-the-cat>
In-Reply-To: <20240923203612.GT4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:50:08 +0200
Message-ID: <CAFLszThbxYuDeui6PJQpUMr58jvQ=GnxjTK-UWSanU6AGt+cbg@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] labgrid: Provide an integration with Labgrid
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 23 Sept 2024 at 22:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 08:01:35AM +0200, Simon Glass wrote:
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
>
> I still really wish you would split the labgrid parts of this series out
> from the pytest fixes and improvement parts. Things are largely fine
> outside of the labgrid part for example, which I'll probably just take
> after confirming it doesn't break using labgrid other ways.

I have had a few attempts at this, but it ends up being somewhat arbitrary.

Perhaps I could split out a series with the exception-handling changes
and the typo? Perhaps 'Avoid failing skipped tests' also?

Regards,
Simon
