Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B37E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092968036B;
	Fri, 10 Jan 2025 14:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B1KaJh1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D3D80608; Fri, 10 Jan 2025 14:39:03 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AA7800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso2663820a91.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516339; x=1737121139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dWvPT+2KnlcFFXfoS/QqipS2fNmdlyLchje9GFjWMIg=;
 b=B1KaJh1YGFgiwM04XdfGsmgdl0qdWppE+UbEnoPEm0Vg20FUnBwtG8925b1z8K+dVK
 22e/qm0HQWojZaUXHYZsh6pHrdkhDB0turirnRaJQzE2xjzqsoxKsGq4lDuIR4jFt5NQ
 EUiZlzbCHcC+nQgrjjudMWtirXQioAzjd2XYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516339; x=1737121139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dWvPT+2KnlcFFXfoS/QqipS2fNmdlyLchje9GFjWMIg=;
 b=FL4OM8qNR4Y/uX9j8BV0F4jwzymxAiFij0JNiEKzBksPSD9T0FasKl46raXVAtp924
 QjdbOYCpYoCUisx8K9L+v+HSwmtew+EJ2ca5TDiH4XAye9yapLOPdG+TOTJeYI8y/5cv
 jXwDmT7WoT3et5zcf0vLE/+JjiF2l7INfG/5NusH5ljCChWWcVvJtShuEXbIQM/e1r56
 ZrOIrJ0SqfuOJv3siF4R0ayXk0fPLxXmzgoVylt2gzmMrvrX26j+fWaZ/jV9rW6l/ZEp
 6+fXqdNwfyC1F/YuV1hSd+SFlZTpSvJgxHtBh6EgtCSlBBYOMcju+rUo/aSVjgEz9oyH
 ecMQ==
X-Gm-Message-State: AOJu0Ywd24/VJw+Jq8cu4CSU41I7LtTDsvr7I58mI/UnoOQnwng/JMBH
 knJtVcPBLs9FdMX+HO871/JJv3XnRGoDKKBXCUy50KIfTZpiyaXAXk8SHoL5i92jzjTUkDvD/KF
 eOJwlot+2TMa1i/cML2uWiLbBAdzG9SHTsVDF
X-Gm-Gg: ASbGnctABx/zjZn5jd3cMx+JTV8qPNc7M7X7j2hyD9NBHCjqXZlcAb0inZB/SuOLsnk
 rBNSqo1gFXWjMT5lWJ6SQEn4v4J4DoVM7Sy0/gV0=
X-Google-Smtp-Source: AGHT+IFZDENatPFqYdTuHdGEiL+x5pNfdfoDjghnIzIUCHvJTjqQWmqk0NVu+5x8Vlo3EcEOUDDpfEtxwu95WBpyUJ8=
X-Received: by 2002:a17:90b:270c:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f548f45fbfmr15145101a91.28.1736516337509; Fri, 10 Jan 2025
 05:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-4-sjg@chromium.org>
 <20250106214130.GC3476@bill-the-cat>
 <CAFLszTif6J6r48DWca3GSuGwnARuzJdnuhbi9wkr8ws=0S6Cjw@mail.gmail.com>
 <20250109164230.GY3476@bill-the-cat>
In-Reply-To: <20250109164230.GY3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:38:32 -0700
X-Gm-Features: AbW1kvbtqFqUP8SbWJffZWtRV0pqjuLZzhA8ylpGgzgl31muJ_NzJ9A5bT_jcg4
Message-ID: <CAFLszTij6xE_tSNPj3D-6=O3_sbpbOTJdgOrtukJzfRMAq4W+w@mail.gmail.com>
Subject: Re: [PATCH v2 03/33] bloblist: Make BLOBLIST_ALLOC the default
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>
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

On Thu, 9 Jan 2025 at 09:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 08:01:17AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 6 Jan 2025 at 14:41, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jan 06, 2025 at 07:31:59AM -0700, Simon Glass wrote:
> > >
> > > > We want to encourage people to use an allocated bloblist since it is
> > > > more flexible than a fixed one. Make this the default, being sure not to
> > > > change existing users.
> > > >
> > > > The unit tests require BLOBLIST_FIXED so add a dependency in the
> > > > Makefile to avoid build errors.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > index e8d89bf6eb9..a00387a4609 100644
> > > > --- a/common/Kconfig
> > > > +++ b/common/Kconfig
> > > > @@ -1039,16 +1039,10 @@ if BLOBLIST
> > > >
> > > >  choice
> > > >       prompt "Bloblist location"
> > > > +     default BLOBLIST_FIXED if SANDBOX
> > > >       help
> > > >         Select the location of the bloblist, via various means.
> > >
> > > This should just be "default BLOBLIST_ALLOC" and sandbox platforms that
> > > are using the bloblist can be like the other platforms using a fixed
> > > address.
> >
> > We don't need 'default BLOBLIST_ALLOC' as it is now first, so is the
> > default. I would like the 'fixed' thing to be later on so that people
> > know we want to stop using it.
> >
> > All the sandbox platforms use BLOBLIST_FIXED. I'm not sure what change
> > you are wanting me to make to this patch?
>
> I'm wanting you to not re-order the list to change the default and
> instead use the default keyword to change the default.

Oh, OK I see.

Regards,
Simon
