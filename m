Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BECC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 15:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D43D86CF4;
	Wed, 20 Dec 2023 16:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVp92ZY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 257D087032; Wed, 20 Dec 2023 16:43:21 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF0586BAC
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so1715497a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703086997; x=1703691797; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqFUC/ilKKgvVspn1WJ8owTH+FONO/Z+Klr7vjCdbu0=;
 b=FVp92ZY/AzjPFSgIH81i16V0lXYsRCcRbV6UyB5dEgorUdwgOyme9UuUyCjwuDrfRv
 TD4ol7mnh7BkdEdwiDHzjgzBo493SoX4VP/JYVwOOquZqV6iTbVtn/uaEbVTp8BUImP2
 uHIY6ODNNjx7L+BrnMrBTttfO39iS5xkgQshlYdWglvi3GpZiR6Zmb5COwjlJlE85BIR
 Ctm0DAdNhgwP0JGTLOePY5dQ9t4jRBQB+5gexyeCwH6DCP5CtG5lBJU/ZXgFiSlXmKEA
 hQythx8iD1XnwBpy6J0ihXEpKg3xFla/G4/eptH/yZNLtvsQTEifyvh+x43XZ1kTTfOc
 5TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703086997; x=1703691797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqFUC/ilKKgvVspn1WJ8owTH+FONO/Z+Klr7vjCdbu0=;
 b=Nt1dz5Lbf26Sea8jCMn7J5dPyAyDGD0T4BlrlW0j3aBf/F8M4meZuuLU+fNZbhIm1f
 O6AaWJZyHlIwJUmWvMQK+XYqu0Wt7FERKEwplJ4qjN8UH/6eXpD/bW8lMp6vG3N09ePX
 C2AgcxCZ+yBih9MtynQsSgnGw0mDwhymwHke39ypzIXUkn1ou7c4g0kkuDzooxNKHDF5
 eGtXsRNzFMSW0xoH2GqU/gDf6lS0t8rdjRu5IBC4/HfuN0ObgG4wxsHfGXJFznx07QU8
 Ql2WE3URHnm1xndhd7Dxn51KK1DxUMbp4/5Y2Y17OS9t+s19mVhE7VJA8rHt89fv6sx9
 xKxg==
X-Gm-Message-State: AOJu0YyzyOxXqwWWPqpxTPKrMpnzbY1lkHWLNjFqP+EL6urTemQrOftc
 gf7L0+AOXR4SXJawRqFYeN2CBxVJ832ET+JMoPE=
X-Google-Smtp-Source: AGHT+IH3lmrT641zcBHbDyy48PqxnpjKP2CRLKBE00WcsY6QTo7ex2MwqQi55XSMjTU6tsz780oWa556zzKgm32r4/8=
X-Received: by 2002:a05:6402:1a56:b0:553:f14:38b7 with SMTP id
 bf22-20020a0564021a5600b005530f1438b7mr3457110edb.2.1703086997034; Wed, 20
 Dec 2023 07:43:17 -0800 (PST)
MIME-Version: 1.0
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
 <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
In-Reply-To: <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 20 Dec 2023 15:43:05 +0000
Message-ID: <CALeDE9NZyAF5iFrbfA2BtWxWdB__cijaME7ppyaPk5Cf7Fd-ZQ@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 xypron.glpk@gmx.de, 
 Abdellatif.ElKhlifi@arm.com, Drew.Reed@arm.com, nd@arm.com, sjg@chromium.org, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 20, 2023 at 6:37=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michael
>
> On Tue, 19 Dec 2023 at 14:47, Michael Walle <mwalle@kernel.org> wrote:
> >
> > Hi Mark,
> >
> > >> > Any runtime device drivers for variable storage should not be in t=
he
> > >> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A is =
the
> > >> > new ARM protocol for talking to the secure world and hence fits in=
to
> > >> > the picture.
> > >>
> > >> What if I just want a simple embedded boot stack where I don't
> > >> want any secure world and just want to be able to boot a COTS linux
> > >> distribution via EFI?
> > >
> > > That already works for many Linux distros.  As long as the distro
> > > installs the appropriate BOOTxxx.EFI file you don't actually need to
> > > set any EFI variables for the OS to boot.  It can't get any simpler
> > > than that.  Of the main Linux distros it seems that only Debian
> > > doesn't do this.  Someone should probably lobby Debian to do this as
> > > well as it would mean that Debian would just work on an EBBR complian=
t
> > > system.
> >
> > I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> > set EFI variables and the installer just failed. Might be fixed now,
> > though.
>
> It's not. The error message is less scary in distros nowadays, but
> setting the variable for Boot0000 is still not working. That being
> said I have a plan to fix it for variables stored in a file, that's
> why we standardized the efi variable format in EBBR.

The actual error is coming from efibootmgr, which is the tool trying
to set the variable and is just passed up to installers.

It's now mostly a soft error as if you confirm the error the device
still boots via the EFI Fallback methods.

> >
> > > Things get more complicated if you want to install multiple OSes.
> > > Then having EFI variable support makes things a lot more
> > > straightforward.
> > >
> > > And of course EFI secure boot needs EFI variable support as well (wit=
h
> > > proper support) for authenticated EFI variables.  But IMHO that no
> > > longer falls into "simple embedded boot stack" territory.
> >
> > Thats clear.
> >
> > >> Assuming, that there might be a simple dedicated EEPROM to store the
> > >> variables which is not exposed to linux, is that something which wou=
ld
> > >> be rejected by u-boot mainline now?
>
> Depends by 'not exposed'. And keep in mind that with a simple SPI
> flash you also have to worry about easy hardware attacks. E.g. someone
> replaces your SPI flash with his version of authenticated EFI
> variables.
>
> We have patches on the ML adding variable support to SPI a SPI flash,
> but excluding authenticated variables. [0]
>
> > >
> > > Not necessarily.  But such an approach will have limitations:
> > >
> > > * Completely hiding the EEPROM from the OS may be hard.  Even if you
> > >   have a dedicated SPI controller for the EEPROM things like the SPI
> > >   bus clock or power domains may still be under OS control.
> >
> > Fair point, but I was thinking about the ls1028a for example, where - i=
f
> > I remember correctly - there was one dedicated i2c controller in a sens=
e
> > of isolation, probably to use with a secure OS. Also there is no dynami=
c
> > clocking.
> >
> > So, technically it should be possible, even with a low overhead, like n=
o> device model etc, which could reside in the efi os services. Just
> > testing
> > the waters here, not that I'm interested in adding support for that in
> > u-boot. Just a bit concerned that it (EFI variables) will only work wit=
h
> > a full stack (tf-a, optee) in the future.
> >
> > > * It is not possible to properly implement authenticated variables fo=
r
> > >   secure boot if the EEPROM and associated hardware is just removed
> > >   from the device tree but still accessable to the OS.  An
> > >   implementation that pretends the variables are "secure" will
> > >   probably be rejected.
>
> That would be an EEPROM dedicated to the secure world. At some point,
> I got involved with an EDK2 implementation for supporting EFI
> variables on a SolidRun honeycomb. We even fixed SetVariableRT and we
> run the whole thing via OP-TEE (just like we do for RPMB in U-Boot).
> So this (minus the physical attacks) is quite secure, because even the
> code running the crypto checks for authenticating variables, runs
> isolated in the secure world.
>
> It's been a while, but IIRC StMM has FVBs (firmware block protocols)
> in EDK2 parlance. We have StMM FVBs for RPMBs and EEPROMs and we can
> launch StMM from OP-TEE. Adding runtime variable support for the RPMB
> is close to impossible if you want to adhere to the EFI spec, but for
> it's doable for the EEPROM.
>
> Ping me on IRC if you start adding support, I can help.
>
> >
> > Sure. I excluded any secure stuff. But, with that i2c controller i was
> > talking about earlier, it should be possible to mark it as EL3 access
> > only.
>
> Yes, there was a slight implication. NXP some had timer on that I2C or
> something, but it's been too long to remember the details...
>
> >
> > Thanks,
> > -michael
>
> Thanks
> /Ilias
>
> [0] https://lore.kernel.org/u-boot/20231126220836.374956-2-i@shantur.com/
