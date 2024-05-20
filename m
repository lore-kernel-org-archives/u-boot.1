Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0867EC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 16:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C10886BB;
	Mon, 20 May 2024 18:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a51p/YyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6218886BF; Mon, 20 May 2024 18:31:16 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F8E886B8
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 18:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5210684cee6so4036169e87.0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716222674; x=1716827474; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCcW9VH2LOI+iC9p+xwamz+SEmIGnUU7jFFABNDc0Sc=;
 b=a51p/YyH+7VlpPPiAr057qJAtB5NeM6HOcTKjpwrTp0BAlHlvba/BhoaQ7/bCMUVUG
 c7i6hVPd9f5EPMJMw5L4T3wx7aQcVMLSP/muVjrW4Dnb89hHn9QluYN84QKpUtA2wJ7j
 RqJHl9PtGI9YHMeLQpw8ov7kFTD9SRDaGzYYY/NoQgF2t8TBzmAkG6j9A3TA/kOlB8Zd
 Cp2aVZNV3Mbq/pziGJOHH6IramIfkMY8t/WOJoNXZnqzIwDpyPNCKEODbqv4Wvo61imj
 UbIRTrlAp+0fmWDNRHEmZ0qwxJayxXg/H07a2yoZRTTHHgXzAh59VlX8sx7XMxPdKqCD
 gO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716222674; x=1716827474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCcW9VH2LOI+iC9p+xwamz+SEmIGnUU7jFFABNDc0Sc=;
 b=giZANhxm/VzFGemVU3QfuFwnI9VaJ0WU631RrbZAxsykdHK1cWVAVqxNxjHjmb9l03
 76m5knknrg0M0aQEOzD5WdcRYQg7H1jMfckIix8iFk0z4Ud20vNDWXntTPSlx/2TQthN
 l9U5gBrn6l32ZiytCxnCr3LGLq/Qa0Hkku3TL1wmj/AJ1L+ql3LEa93KPLvACXIKyJjm
 fkju9zxU5xAkZvTwM7Yvusl6l+cLf+pNLip6zFjnsHZ3T4gd12CHxtSsDMlEJg01srmN
 ZQ0+e5K6M1p/ikbP6cbJ8AIcFy8a2YJKose7vEVwoYxB8qnixvKgKtXkFC+JB4F1mNlj
 46tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC3kaSK5PTzX+5H56QiTdA71q7B3xoruH1dFkzRnjk5bVx5NKW9PbI2SJrrLYAWNIDlnp+pzCcGWSHh0BQiazbM9MyRA==
X-Gm-Message-State: AOJu0Yyz+CjaVhnydNNcApDimwXcsQTfRRUeLjo6uLz/3g4aewCfLW6u
 h3pjlYMoOBRxVH58UopyLS36CJAKbuya3lt0sj8ULH51+BZDCNIcbPK2rsiYLEVYmvFlY1z80UR
 /euZStlLXVReo7F4tIFDy4YgRLsM=
X-Google-Smtp-Source: AGHT+IEO3PH/dOQ2T8v5If4sEgtSi2/J0hDU+93uun/AT6WFE/kTIrG1M84hXZb7/jfvQZWZEzNDGdGRZ0R5iWZV7Dw=
X-Received: by 2002:ac2:5f48:0:b0:51d:abb3:d701 with SMTP id
 2adb3069b0e04-5220fa7191amr18004811e87.5.1716222673580; Mon, 20 May 2024
 09:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240515234839.26898-1-andre.przywara@arm.com>
 <CALeDE9OrY-wdpbdOWvqkgYE6YD8SLGCw_Fo1FaBsjQ75LQcqtQ@mail.gmail.com>
 <20240520151808.1e5fe1e1@donnerap.manchester.arm.com>
In-Reply-To: <20240520151808.1e5fe1e1@donnerap.manchester.arm.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 May 2024 17:31:01 +0100
Message-ID: <CALeDE9PWTfJA48MMgYhZP2RqO1vxPzOrxXg8dziFC7Dp4yzxpA@mail.gmail.com>
Subject: Re: [PATCH 0/6] power: pmic: sunxi: consolidate AXP SPL drivers
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Walklin <ryan@testtoast.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
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

On Mon, 20 May 2024 at 15:18, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Mon, 20 May 2024 13:48:41 +0100
> Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Peter,
>
> thanks for having a look!
>
> > Hi Andre,
> >
> > > this is the first series in an attempt to clean up the X-Powers AXP PMIC
> > > drivers used by the SPL for sunxi boards. So far we have a separate
> > > driver file for each AXP variant, but the code was largely the same,
> > > just differing by the regulator ranges.
> > >
> > > This adds a new generic driver, which reads the regulator description
> > > from an array of structs. This is similar to how the DM AXP driver used
> > > for U-Boot proper works, but is simplified, since we won't need the full
> > > feature set for the SPL, and we want to keep the code size small.
> >
> > Overall seems a reasonable approach, would it make sense to put the
> > regulator descriptions in a file that could be shared between this and
> > the DM driver so the information isn't duplicated and hence may
> > diverge over time with things like copy/paste errors?
>
> Yes, I thought about it, but it gets nasty:
> - The SPL should only have the regulator descriptions for the *one*
> selected AXP chip, whereas the DM driver can afford to describe all
> regulators and select the right ones via the compatible at runtime. This
> is to conserve memory for the SPL.
> - The SPL should only be interested in the DC/DC buck converters, we don't
> really need any LDOs. Again saves memory.
> - Each regulator entry for the SPL should be as small as possible, we don't
> want and need the regulator name, for instance, or the table pointer.
> Again to save memory.
>
> Currently the array for the three AXP313 regulators in the SPL is exactly
> 30 bytes long; in the DM driver, just for the small AXP313: 192 bytes. The
> difference is even more pronounced for the larger AXPs.
>
> I am hopeful there might be some macro magic to express this, like:
> static const struct axp_regulator_plat axp313_regulators[] = {
>    SPL( "dcdc1", 0x10, BIT(0), 0x13, 0x7f,  500, 1540,  10, 70 )
>    SPL( "dcdc2", 0x10, BIT(1), 0x14, 0x7f,  500, 1540,  10, 70 )
>    SPL( "dcdc3", 0x10, BIT(2), 0x15, 0x7f,  500, 1840,  10, 70 )
> PROPER( "aldo1", 0x10, BIT(3), 0x16, 0x1f,  500, 3500, 100, NA )
> PROPER( "dldo1", 0x10, BIT(4), 0x17, 0x1f,  500, 3500, 100, NA )
>         {}
> };
> But we still need something to avoid the array altogether when another AXP
> is selected, which might require #ifdefs.
> So it might be possible, but the devil is probably in the details.
>
> For now I just wanted to avoid adding more AXP driver files to
> the drivers/power directory, so I consider this a future optimisation.

That all makes sense, thanks for the great explanation!

> Happy to take patches :-D
>
> Cheers,
> Andre
>
> > Peter
> >
> > > To help bisect-ability, and to simplify review, each of the simpler AXP
> > > drivers covered by this approach is handled in a separate patch.
> > > We just convert the AXP313, AXP305, AXP717 for now, and on the way add
> > > support for the AXP707, just because it's now very easy, and we will
> > > need it soon enough.
> > > The other AXP SPL drivers are more complex, and support more regulators,
> > > but my hunch is that we really just need the DC/DC converters in the
> > > SPL. However I need to prove and test this, so I will convert the other
> > > AXP chips later.
> > >
> > > Please have a look and comment whether the approach in general is a good
> > > idea.
> > >
> > > Cheers,
> > > Andre
> > >
> > > Andre Przywara (6):
> > >   power: pmic: sunxi: only build AXP drivers for SPL
> > >   power: pmic: sunxi: introduce generic SPL AXP DC/DC driver
> > >   power: pmic: sunxi: replace AXP717 SPL driver
> > >   power: pmic: sunxi: use generic AXP SPL driver for AXP313
> > >   power: pmic: sunxi: use generic AXP SPL driver for AXP305
> > >   power: pmic: sunxi: add AXP707 support
> > >
> > >  drivers/power/Makefile  |   8 +-
> > >  drivers/power/axp305.c  |  82 ------------------
> > >  drivers/power/axp313.c  | 133 -----------------------------
> > >  drivers/power/axp717.c  |  92 --------------------
> > >  drivers/power/axp_spl.c | 184 ++++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 189 insertions(+), 310 deletions(-)
> > >  delete mode 100644 drivers/power/axp305.c
> > >  delete mode 100644 drivers/power/axp313.c
> > >  delete mode 100644 drivers/power/axp717.c
> > >  create mode 100644 drivers/power/axp_spl.c
> > >
> > > --
> > > 2.35.8
> > >
>
