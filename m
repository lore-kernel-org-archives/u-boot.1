Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED96BC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E8388027;
	Fri, 21 Jun 2024 22:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AqQs7EFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEFA87FBC; Fri, 21 Jun 2024 22:27:02 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38D088405
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-797b24b8944so235026885a.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719001619; x=1719606419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=to4Ra8uNKwjEyamTk8PYejU2gVASSxrO5cbJUuwcFqI=;
 b=AqQs7EFmIbk0yCp5Mz+jkzZaWVpwGbI1VewuiP1KlPNY1VvvdtSAA19bgNAXvwuK5O
 2ZZ0Gc61TqnvMSeLLBqtEvivWZohdRVIcvMKsMccAiS1uou1r2W841yWOHnphic1tqCL
 evTNh5Z0ZXupR5CUDGeCgBWewArszrCzb88FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719001619; x=1719606419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=to4Ra8uNKwjEyamTk8PYejU2gVASSxrO5cbJUuwcFqI=;
 b=tMRis3Nwlfnxf+VaG7ebWTxlJFOkROSF9vHp1RbLng8leSUeM/SY1a1ufUCGNMzhI4
 XwK4A56SxqVUdCnnxnHt2Q4flKAmcee1Ltfffe3OfpvuRWNJ9ONKLO+Y7SuTvkf9LHr0
 UUbz0bHW0Wu04m95Zw1EHNOYNoAGhOOsLXVrgYeiOsErhnZXKWyLzGYGEz5iCKPFSsf3
 v3Lh43E1BgvA3Qyj3HOJEjsp6XQI0ZWgOF27alM+fOfbxnoulQNgftnxACy31Onvz3Si
 J4XIx2CI3y9mNK1bOucSf13EdARcPI5T0I+XVnmuHpwBTTSqT2aGFwuWFgPefLeGUA/N
 q/4g==
X-Gm-Message-State: AOJu0Yzg+vkXI1+XIrBHFcYXD572nw1CYfw6Ml2oZJAe+53DkNF0vU63
 iXBMxwQJf551eAyunW7VvtPnaENSiJUE7ocEt9K18MsVuQgbVnicY7yYjQ1m3D8XayEV8kwJUHQ
 7yH9VQXmnlfHehYdnF4I0PLaOnkJcRz3X/5rK
X-Google-Smtp-Source: AGHT+IFdWnkViz2YQwdY2W/iQA51anwQ2RdGaKfywsgTMSIFWyea3ek2gfdqKsD1Y4FaathJ4u639oWX9/PD5T7uRpk=
X-Received: by 2002:a05:6214:b32:b0:6b2:a364:b86d with SMTP id
 6a1803df08f44-6b501df809dmr86650246d6.3.1719001619385; Fri, 21 Jun 2024
 13:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240621195204.2675252-1-sjg@chromium.org>
 <20240621200735.GB68077@bill-the-cat>
In-Reply-To: <20240621200735.GB68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 14:26:48 -0600
Message-ID: <CAFLszTj4o3EZJ7tVn+URbz1+9vyR2JdXu62A=nuPX3v15JY9+A@mail.gmail.com>
Subject: Re: [PATCH v2 00/43] labgrid: Provide an integration with Labgrid
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

OK will do.

One I have already split out ("Bug-fixes for a few boards") so I'll
split out a few more.

REgards,
Simon

On Fri, 21 Jun 2024 at 14:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 21, 2024 at 01:51:21PM -0600, Simon Glass wrote:
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
> > ub-bisect
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
>
> Can you please split this up in to 3-4 series so that they can be
> reviewed and merged? Thanks.
>
> --
> Tom
