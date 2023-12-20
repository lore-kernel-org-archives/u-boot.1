Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD83C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 06:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197218701C;
	Wed, 20 Dec 2023 07:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="azIfvZ2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68405870B7; Wed, 20 Dec 2023 07:18:22 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28DD86FD5
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 07:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e44c1b35fso1957933e87.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703053099; x=1703657899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt3CPsjv7rZaoj/TNr+FeJ3PlSOTayPt2nGKngUZGTA=;
 b=azIfvZ2St1g7U+cO0UbDuk6b9fchXrvJvQkDr8VTvB6MWkXh/okaMWdOiThfblkj6F
 llvmLb2Dd2L0zVBzbJcYkVO4ohmbsW1069vNFPdw5yREW3cwx806EoQerALqWOc0nSgr
 ewTA9ML4qo7TlnCRMKS9bNo/aPgZU+Sl2V2pgU3LVhAE4kljw9uP9LCw/G/pDF5wPCg9
 0zmfpl8esUdd5/CA/tDdbcpVCdXMuKT5g3sELLyXH+Q5MBgeapIVMn3oj47sd6j3YnuB
 c1E9Cn39Zf9KLobopmP4r/KtPd6XcqX2Fh+r1MZyG1E20tHrr9xORxT7JdRySck/L65o
 JHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703053099; x=1703657899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dt3CPsjv7rZaoj/TNr+FeJ3PlSOTayPt2nGKngUZGTA=;
 b=eM/7CQfUF61GU5+d5OTRtxF54Z/JYSzi7KrgSBurHaFLIof0f84GyShxGqjL4BVP3c
 62KwcHypXVhBCHCdCAoDa+IgLAH6YxDrh0Pr9x7SWYjQY10UMLaJKa6Kdzb9zHcOoVAx
 PWnOwQ3n7foO6iYRtdSL+2Ll+ZqZgJb3GfpWey9wGhSGzDmu/w6bQ5GQrnAN2WbR72yz
 Plh6x5thkIYHSsaNs65SpkQJVnIM3OwD08GelJXm1SesmIw79Kmd8WPkB1zuzLvFKT3G
 ceWGp0ciLBBat5iBEze9LPq9j9Nv0OfkfrfehTfDCgC/8f01Vrbw8Tyvn0Fr1jC+H/Wu
 Bezw==
X-Gm-Message-State: AOJu0YxFceJxnJiTB19papZGVpZYqjTpc2ID+O0jOY1q6Kn7fCBBAoJc
 0EZK9xKfYqPcp3KOcn2UqbMJltrqgOdVFHgAcpp7ug==
X-Google-Smtp-Source: AGHT+IFCADrz/wVL2VMKVQkXT3Rok2y5SLMz8qY2F0rhzXtGRvoo+7y97mnsu84s+2shrtt260bg6/LylFgi8Th3SRk=
X-Received: by 2002:a05:6512:358a:b0:50e:376b:cfc3 with SMTP id
 m10-20020a056512358a00b0050e376bcfc3mr2123859lfr.49.1703053099013; Tue, 19
 Dec 2023 22:18:19 -0800 (PST)
MIME-Version: 1.0
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
In-Reply-To: <f2eb636cd895aae348d4357537267fd2@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 08:17:42 +0200
Message-ID: <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Michael Walle <mwalle@kernel.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de, 
 Abdellatif.ElKhlifi@arm.com, Drew.Reed@arm.com, nd@arm.com, sjg@chromium.org, 
 u-boot@lists.denx.de
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

Hi Michael

On Tue, 19 Dec 2023 at 14:47, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi Mark,
>
> >> > Any runtime device drivers for variable storage should not be in the
> >> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A is the
> >> > new ARM protocol for talking to the secure world and hence fits into
> >> > the picture.
> >>
> >> What if I just want a simple embedded boot stack where I don't
> >> want any secure world and just want to be able to boot a COTS linux
> >> distribution via EFI?
> >
> > That already works for many Linux distros.  As long as the distro
> > installs the appropriate BOOTxxx.EFI file you don't actually need to
> > set any EFI variables for the OS to boot.  It can't get any simpler
> > than that.  Of the main Linux distros it seems that only Debian
> > doesn't do this.  Someone should probably lobby Debian to do this as
> > well as it would mean that Debian would just work on an EBBR compliant
> > system.
>
> I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> set EFI variables and the installer just failed. Might be fixed now,
> though.

It's not. The error message is less scary in distros nowadays, but
setting the variable for Boot0000 is still not working. That being
said I have a plan to fix it for variables stored in a file, that's
why we standardized the efi variable format in EBBR.

>
> > Things get more complicated if you want to install multiple OSes.
> > Then having EFI variable support makes things a lot more
> > straightforward.
> >
> > And of course EFI secure boot needs EFI variable support as well (with
> > proper support) for authenticated EFI variables.  But IMHO that no
> > longer falls into "simple embedded boot stack" territory.
>
> Thats clear.
>
> >> Assuming, that there might be a simple dedicated EEPROM to store the
> >> variables which is not exposed to linux, is that something which would
> >> be rejected by u-boot mainline now?

Depends by 'not exposed'. And keep in mind that with a simple SPI
flash you also have to worry about easy hardware attacks. E.g. someone
replaces your SPI flash with his version of authenticated EFI
variables.

We have patches on the ML adding variable support to SPI a SPI flash,
but excluding authenticated variables. [0]

> >
> > Not necessarily.  But such an approach will have limitations:
> >
> > * Completely hiding the EEPROM from the OS may be hard.  Even if you
> >   have a dedicated SPI controller for the EEPROM things like the SPI
> >   bus clock or power domains may still be under OS control.
>
> Fair point, but I was thinking about the ls1028a for example, where - if
> I remember correctly - there was one dedicated i2c controller in a sense
> of isolation, probably to use with a secure OS. Also there is no dynamic
> clocking.
>
> So, technically it should be possible, even with a low overhead, like no> device model etc, which could reside in the efi os services. Just
> testing
> the waters here, not that I'm interested in adding support for that in
> u-boot. Just a bit concerned that it (EFI variables) will only work with
> a full stack (tf-a, optee) in the future.
>
> > * It is not possible to properly implement authenticated variables for
> >   secure boot if the EEPROM and associated hardware is just removed
> >   from the device tree but still accessable to the OS.  An
> >   implementation that pretends the variables are "secure" will
> >   probably be rejected.

That would be an EEPROM dedicated to the secure world. At some point,
I got involved with an EDK2 implementation for supporting EFI
variables on a SolidRun honeycomb. We even fixed SetVariableRT and we
run the whole thing via OP-TEE (just like we do for RPMB in U-Boot).
So this (minus the physical attacks) is quite secure, because even the
code running the crypto checks for authenticating variables, runs
isolated in the secure world.

It's been a while, but IIRC StMM has FVBs (firmware block protocols)
in EDK2 parlance. We have StMM FVBs for RPMBs and EEPROMs and we can
launch StMM from OP-TEE. Adding runtime variable support for the RPMB
is close to impossible if you want to adhere to the EFI spec, but for
it's doable for the EEPROM.

Ping me on IRC if you start adding support, I can help.

>
> Sure. I excluded any secure stuff. But, with that i2c controller i was
> talking about earlier, it should be possible to mark it as EL3 access
> only.

Yes, there was a slight implication. NXP some had timer on that I2C or
something, but it's been too long to remember the details...

>
> Thanks,
> -michael

Thanks
/Ilias

[0] https://lore.kernel.org/u-boot/20231126220836.374956-2-i@shantur.com/
