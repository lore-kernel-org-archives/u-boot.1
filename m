Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4D9D1813D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3519C89119;
	Mon, 14 Oct 2024 21:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kOn+2jb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685AE89150; Mon, 14 Oct 2024 21:13:39 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C16E89082
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b133184f41so10764385a.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933216; x=1729538016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wv8SFrdX9eX2ZBHsB6LPtyZe2NYzcErAk6QZiAOChes=;
 b=kOn+2jb+7Is/+W7QHskSza/eXDEfmt7XThMmKK+OgrI8dtH2AnGO8JLhhWvoA8Ksmy
 jeQw5J1eoD2Se8QZAuM9bDsM1irN1oYyZuPgBmBvP0An4z7OZzkrk0+fFZyYPa8rY2y2
 WZIinq2CD+MjrZppfh6SAo37eeL0fGARDk768=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933216; x=1729538016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wv8SFrdX9eX2ZBHsB6LPtyZe2NYzcErAk6QZiAOChes=;
 b=eVYz4athWki+zLWXVaZczDyCNZNxz2jqlZZX/Q09bTsosK0XDC77tb2JOK9C8gEAG9
 HeoHoJ7Aeu2tGRzZmbO4XUp/8DPINWWMX41Er7NoEF9arKbGMVk3s/8T3dm6rHKdfVvD
 J3SlvL4uBdrn1hgDxZJEy8frB/80ulGlTzpa4fMSsckcTUAnL3eDR9DoEcmSH1Rlluss
 aos3lnjKZrXAauL+ALsd/Dr9L7rWZ2i+nkTvEo+zSIm6gQyEbRxuZgEfdFoFQTyqWPhA
 knE+fUk9Rdv4ynR+GGoi7tT2wGpsdvnYfsD7fJZRPzFkIbmxYSRCDzZY4KQXCqRfgGDG
 tb8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHXVLCnxQyJwEQbY4yW2xSHQwXEoBDPitsuCV11zkaCRp3+pUt1CylbY/iAnYkfOw3IIQVQc0=@lists.denx.de
X-Gm-Message-State: AOJu0YwSHUXsR1XFN2QzuSgblIggJ7myH+/5ruWP0j5YemxmDgKdGFPl
 emAxAnW5edcegsR3U9sgPqnfGLLPiIql5QzylaTuax+w0IqFj+5NIaa0uYAExi/cVBIIPVq9yVV
 5vSlQl8PQgcrvX3DmFr/i/V2MiAC8sZqicVZo
X-Google-Smtp-Source: AGHT+IEiay1fEnYwyWRk6nebQ3PRSoeUTnGMA8bBthIBZO5FgFu/QHnTmPm8I1NYrg9Sh+mxWUJvfURAQj6prMPJpu0=
X-Received: by 2002:ad4:42c5:0:b0:6cb:f7dd:b6a8 with SMTP id
 6a1803df08f44-6cbf7ddb70amr145556766d6.26.1728933216179; Mon, 14 Oct 2024
 12:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
 <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
 <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
 <CAC_iWjKKqsJh7yUv-kRe5WiGA02c4YU4Yj83UXVXjki+CO9X1Q@mail.gmail.com>
In-Reply-To: <CAC_iWjKKqsJh7yUv-kRe5WiGA02c4YU4Yj83UXVXjki+CO9X1Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:25 -0600
Message-ID: <CAFLszTi_CqDY2+RMRo+hJLsCtn6vQHHoeBvT8g-czL7OQAXw0g@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
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

On Thu, 10 Oct 2024 at 09:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
>
> On Thu, 10 Oct 2024 at 18:10, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, 10 Oct 2024 at 06:02, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > We already have a mem info command, which is pretty useless. Can't we
> > > > > > reuse that ?
> > > > >
> > > > > I am not too keen on using that as 'info' is pretty vague. We could
> > > > > perhaps create a 'mem' command with 'info' as one subcommand and 'map'
> > > > > as another?
> > > >
> > > > Are we talking about "meminfo" which literally only prints gd->ram_size?
> > > > If so, I don't think it's worth worrying about enhancing that.
> > >
> > > Yes, that's the one
> >
> > So, you mean to just delete that command and make it show the memory
> > map instead? Or show the memory size at the top, before the memory
> > map?
>
> I meant the latter, but if you and Tom agree that we should leave it
> as is, I don't mind adding a new command. I assume that the list above
> is non exhaustive, so in the future we could expand it with lmb
> reservations etc?

I sent v2 with that done. The lmb reservations aren't that useful as
there are no names attached.

Regards,
Simon
