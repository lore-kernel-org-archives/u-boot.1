Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292DFE6748C
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 23:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3B088B4B;
	Fri,  1 Nov 2024 00:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ITFbdt4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBFBE89293; Thu, 31 Oct 2024 19:02:02 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC3488B8F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso12359195ad.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397719; x=1731002519; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i7tpzcnEyUEG9hyPqAJlb+aWULnpo0pRHYc7UOmc+DI=;
 b=ITFbdt4ohnkcWvZY3w5uIy52EW3ohqYG6g8ooV5yQyr3z9aaRolUCqTn/92WdvM7x0
 V4xLbfelYIfJYPSL+tLNPaSGeowUIIPSJgBXfnqZjjeeN6JskRso9OOfSBomXnOfMc2O
 ZnwGrcrk9yRE7D5nklUFR0Q62ENvKrqbKjiYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397719; x=1731002519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7tpzcnEyUEG9hyPqAJlb+aWULnpo0pRHYc7UOmc+DI=;
 b=i9ENV2uyHN5PZGPdm1vEvHjOZkmZBsHKBrFxfQazgnibQFfU6P2Fq7XDX5eQXBrMYA
 JpNlziT1kmP9GRU8NpthIrJhM0E0Nvp6wVtWdgjBdBKn50lpGzSTJv18V07OytcC8w8P
 nJZjC1FVDy6yKyvdBgKnzm4f2NpFWqwFcd8ZlYSCv7C+jqWcsZcnGuKT2gsGiRsKa8Xx
 5OY4eH/FHfg4wrAVgdCXgT7frFV3QvJQMKWHTgKRKRDPv6v/oawT3WutbPPRt0XKCkus
 yMEIEucj6FsY/99LlOOvfNykWwANE9rit59MTst7SMtlJ1auxSinrJIVanjhxbvUckyU
 MJqw==
X-Gm-Message-State: AOJu0Yx9n5KqTTIsRhdMtZklOjfMYM3KBgYdMOu30CN2I9TYwju/J2+1
 HgGprL/Lxx5+Ejdm0UDK/TwF16t9uJaK5UBT11l0J+xgtYNTjrmAkbVK+KiREInz3teVQ30lOJV
 ye1/NHLimclMt+GkmHvwHscZX602RyulRQaul
X-Google-Smtp-Source: AGHT+IFgqAdz9a34qcLsaqGuat8qwye/dZeViw4Rnf6YQJgGxNs1B68mGq4tJJYuUJuEVXBOgxbg7YHfWb+xG4XkMQY=
X-Received: by 2002:a17:90b:5448:b0:2e5:5ff9:bee1 with SMTP id
 98e67ed59e1d1-2e94c50d18amr1073084a91.29.1730397718665; Thu, 31 Oct 2024
 11:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
In-Reply-To: <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:01:42 +0100
Message-ID: <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 01 Nov 2024 00:20:50 +0100
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

On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > It is a bit of a pain to log EFI boot-services calls at present. The
> > > > output goes to the console so cannot easily be inspected later. Also it
> > > > would be useful to be able to store the log and review it later, perhaps
> > > > after something has gone wrong.
> > > >
> > > > This series makes a start on implementing a log-to-buffer feature. It
> > > > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > > > only memory allocations are logged.
> > >
> > > Why is this problem specific to EFI and no U-Boot in general? Do we
> > > have a similar machinery for malloc()?
> >
> > Mostly because an app can make EFI calls and we want to know what they
> > are, e.g. to debug them and figure out what might be wrong when
> > something doesn't boot.
>
> EFI_PRINT() has been proven pretty useful for this. I don't personally
> see the point of adding ~1300 lines of code to replace a print.
> What would make more sense is teach EFI_PRINT to log errors in a buffer.

Is that a NAK? Please be clear if you are reviewing the code or just
rejecting the whole idea.

I am hoping to expand this into a debugging tool for figuring out how
to boot Windows and perhaps logging detailed information when things
go wrong, for later analysis. It might seem like overkill, but we will
see.

Regards,
Simon
