Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE7DC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 22:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8F587F19;
	Fri, 21 Jun 2024 00:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k5LTrwO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377B687DDF; Fri, 21 Jun 2024 00:29:44 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DB7883F2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e72224c395so14538811fa.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718922581; x=1719527381; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6De34qZS6b7fZUEYzcVvgyQh+UAO4t57gTcjDv5JNxE=;
 b=k5LTrwO5saDVg6XOlDzDMYx9rbvGG6kPw79PU/E7iYVb2mZa50P0U55c6Rxsj8poic
 WzE1cZ6SeEckOHw3rq8KZ8VrZ0gLj5xkQSe6O9QIxgRJkojRiD4atFwffxRv0ubJeaOQ
 iIHCmq4nMp6yVndhZUtFGBCJ77tTttQUwoZxYlEBSlVJUVyjXbSGx19lZS0RIi9+24Qd
 x4Mx04TSZtcd1UYXFVrfV7v4fl4uVK/GB9KNQTpz9mqa7c5zOCsmWyqT+VVfZM0Blah0
 kmnna3g64dNtUsGVrrthngMZDap+eGtk3/W1W9IH58jss2wM/j2CqB5ExBR+uD1dhb9k
 SkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718922581; x=1719527381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6De34qZS6b7fZUEYzcVvgyQh+UAO4t57gTcjDv5JNxE=;
 b=aBmfAKztHF+4/axSwTm1HffboC33rnfDO7AEj5N+2R3AVhA+xfsWBqa5mXNWmmtUua
 5N11yBVgX+hEt0EuYVpGT6Xq+YCMvbehxQel/Juo1hmTpuxR2X84tsMR5dxXfz/gQ2I2
 P1FEkjUnR+jup2bSepc0atrwaWqLDldOSg5XLAoJpsdyc7sC6uSB0HptcIUYTy1iMY69
 hxzMhmTF0CkVAtCFNK2DAeSuIpMgBrpgTwKOxw5bcV84BlJ0OdZnAlCfXTD6AF69udX8
 rqdjanjQvvBXG9jfjUVWBa6h1cMrO9FjTlnqlMqATZcgZRE/sBqOjQb9qhi9u0kbVzOX
 voNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXycttyB+v0d3rUb4iKbQzu94iXbEpkb3F/MOL78woca6FSM1DSGZYLFY/n10pJ9XF6eplhqBXT7ipuOiRpFrGSfp2F1w==
X-Gm-Message-State: AOJu0Yy7vrN8tyYyIttlVxX5yPbnlRu50wcCSIGQ8C/d1vtM6vh6UNOH
 4VG0vC8fivza4Vap8l9Kw7mMR0D/1sNnQFo+XLS4rv6BeDrWdhdAhEgbKJSwmkVB34as7tFxzAw
 2HzCPcC2LwJ9tRfb1EDslmOzv5I8=
X-Google-Smtp-Source: AGHT+IG6u0Ug7MrW1cPlYuCHXhdv7sgr+TSCNNX5b2Pcry19dCYF46AsbBsHmeIl0ojF3yFFA73eE5TrzsvR0KoRJ4s=
X-Received: by 2002:a2e:9585:0:b0:2eb:ec25:c4af with SMTP id
 38308e7fff4ca-2ec3cffd277mr44994901fa.50.1718922580895; Thu, 20 Jun 2024
 15:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
In-Reply-To: <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 23:29:29 +0100
Message-ID: <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Enric Balletbo i Serra <eballetb@redhat.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
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

On Thu, 20 Jun 2024 at 23:22, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Nishanth Menon,
>
> +Cc Kever from Rockchip as maintainer of the arch in U-Boot
> +Cc Heiko as maintainer of many things Rockchip in many projects
>
> On 6/20/24 11:35 PM, Nishanth Menon wrote:
> > Hi Team,
> >
> > We have briefly discussed this topic on IRC[1]. I would like to
> > propose a new boot-firmware repository similar to the Linux-firmware
> > repository under the aegis of u-boot hosting.
> >
> > In addition to TI, it looks like some NXP[2] and Rockchip[3]
> > platforms seem to require additional closed-source/open-source
> > binaries to have a complete bootable image. Distribution rights and
> > locations of these binaries are challenging, and there needs to be a
> > standard for how and where they are hosted for end users.
> >
> > Further, looking ahead to future architectures:
> > * IP firmware: More and more IP vendors are embedding their own
> >    "specialized controllers" and require firmware for the operation
> >    (similar to Rockchip's DDR controller, I guess),
> > * boot stage firmware: Additional stages of the boot process involve
> >    vendor intermediate firmware, such as power configuration.
> > * Security enclave binaries: While I see a few folks trying to have an
> >    open-source s/w architecture, many PKA and PQC systems still require
> >    prop binaries for IP reasons.
> >
> > NOTE: I am not judging any company(including TI) for reasons why some
> > firmware is proprietary, but I hate to have the end users and other
> > system (distro) maintainers have to deal with hell trying to make the
> > life of end users easy to live with.
> >
> > In the case of TI's K3 architecture devices, we have two binary blobs
> > that are critical for the boot process.
> >
> > 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security enclav=
e
> >    firmware. It is often encrypted, and sources are not public (due to
> >    various business/regulatory reasons).
> > 2. DM Firmware[5] - There is a source in public in some cases and
> >    binary only in others - essentially limited function binary to be
> >    put up in the device management uC. In cases where the source is
> >    available, the build procedure is, in my personal opinion, pretty
> >    arcane, and even though in theory it is practical, in practice, not
> >    friendly - efforts are going to simplify it, even probably integrate
> >    it with a more opensource ecosystem, but that is talking "look at th=
e
> >    tea leaves" stuff.
> > 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
> >    binary that gives the tifs system context restore logic before
> >    retrieving tifs firmware and a corresponding DM restoration binary.
> >
> > All told, this is not unlike the situation that necessitated the
> > creation of a Linux firmware repository.
> >
> > Options that I see:
> >
> > 1. Let the status quo be - SoC vendors maintain random locations and
> >    random rules to maintain boot firmware.
> > 2. Ask Linux-firmware to host the binaries in a single canonical
> >    location
> > 3. Host a boot-firmware repository - u-boot repo may be the more
> >    logical location.
> >
> > * (1) isn't the correct answer.
> >
> > * (2) Though I haven't seen any policy from the Linux-firmware
> >    community mandating anything of the form, the binaries we are talkin=
g
> >    of may not belong to Linux-firmware as they aren't strictly speaking
> >    something Linux kernel will load (since the bootloader has that
> >    responsibility), and in some cases may not even directly talk to
> >    (security enclave or DDR firmware stuff). I am adding Josh to this
> >    mail to see if he has any opinions on the topic (but keeping
> >    from cross posting on linux-firmware list, unless folks feel it is
> >    OK).
> >
> > On (3):
> > Proposal:
> >
> > * Create a boot firmware repository in Denx and/or GitHub (if
> >    financials are a hurdle, I hope we can solve it as a community).
> > * Limit binaries only to those consumed part of the u-boot scope.
> >
> > * Limit binaries only to those that do not have an opensource project
> >    (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
> >    source or are binary only in nature (subject to licensing terms belo=
w)
>
> FYI, on Rockchip, there are currently three blobs **we** use on Aarch64
> (i have only worked with RK3399, PX30 and RK3588, so they may be more :) =
):
>   - DDR bin/TPL no clue what this actually is under the hood. I think
> most SoCs do not get an open-source DDR init in U-Boot sadly, therefore
> mandatory until it isn't,
>   - BL31, mandatory on Aarch64, a blob that is an old TF-A (v2.2/2.3 I
> don't remember anymore). I don't know the state for all SoCs, but I can
> say the RK3399, PX30 and RK3568 have an open one, RK3588 is one the way
> (but considering the RK3568 and RK3588 were released years ago, BL31
> blob is mandatory for a while),

rk3568 is now upstream, there was a PR upstream for this for some
time, similar to rk3588, albeit not as long as rk56x. In some cases
the issue here is the speed of review of upstream ATF. I don't think
that means it should go into something like this.

>   - BL32, OP-TEE. I don't think we support it upstream for Aarch64 (I
> think there was some issue around the binary format being different than
> the upstream OP-TEE?). Don't know the state for Aarch32 SoCs though.

These are generally optional, at least for rockchip

>   - I vaguely remember something about a miniloader but have no clue
> what is its use as I've never had to use it, mentioning it anyway.

I rarely use this, it's generally needed for maskrom and recovery of
devices. I don't think they need to go into this sort of repo as
they're generally not needed for core booting of the rockchips
devices.

> So, BL31 and BL32 are blobs but based on open-source projects with
> "weak" licensing requirements. This means "Limit binaries only to those
> that do not have an opensource project" is maybe not the correct wording
> (or it is and then we can only have the DDR bin there, which isn't
> necessarily a win since we would have to fetch the binaries from some
> other places as well).
>
> FYI, the DDR bin is printing stuff on the console, so we had to modify
> it (with a tool from Rockchip) to remove the gibberish breaking the
> terminal by setting the appropriate controller, mux and baudrate (for
> our products, there's no one size fits all :) ). The question is how to
> handle this since we cannot realistically store every possible
> permutation of that binary for each UART controller, mux of UART
> controller and baudrate (the only parameters **we** modify, but there
> are tons of others).

I think those sort of things should be mostly quiet TBH.
