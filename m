Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922A4E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 12:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F99801CF;
	Tue, 17 Dec 2024 13:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jqBquHLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F986801FB; Tue, 17 Dec 2024 13:29:47 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CBB801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 13:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so7245776a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 04:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734438584; x=1735043384; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5EtmWZWC4UQx1C6baErXULHwTKA0U5t6uDX0uBTJ0M=;
 b=jqBquHLa2RY4nuMt7UDMpixVngFMEUzEFEv3H7wvVY0FQ7PHDJukI8+/6h/Fp1NOWe
 4ABPuPOvTJcDFUL0vVrgvErd7xXEK/f6R6pLWLwdoofB9J4/qrtRU+9s0sEnZv0X2iRN
 6i0OIdjLUGczUn+tXIamzLvRW1dvmZT1P5t1CbwLxsPvSZym7j4lP6S+INMUG0S0atfP
 6hnyVu22IkHmxqx77SvKEyXo/LoGBqgzqV3U87iBOaTjGG0iWTNSUv23Ews4WqaftF5r
 U5CqfbNTYm1QXGYFOafBGPm18sE2GQLCW9WVPdW2NlGzhvM1jAG4di/fRzxNkGX9btyn
 wm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734438584; x=1735043384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5EtmWZWC4UQx1C6baErXULHwTKA0U5t6uDX0uBTJ0M=;
 b=aqWWq7YhSLRPycfgAlf7F2238RTZmPa7t4p/LrGzf4Hno9zyacl46bQ21rzyaEEy9g
 shqQF72dELTwP945zLIIJGTfPp2+WMc4VKSTGTKrlMywa6C319QncQ9kOyXLuLpHhSpN
 JnbcqjjgwThqVcuLySr2MAD0TOOXsKcdLA6j42PQmEkpgWO+f6pxDFATIIgJ1oZPNEZc
 xDfNKeriuNmVj083NCTWUDLuqnMYkHmoV6FL9a/gYbdq7oo+GDctREzwfV2ia69B3ZQs
 JLSuqhfGaV+tLcOqZX69+U+PwRPCeryaE0F8AdH5rMEGR2WpYxFap5gHHIizULYW4X3y
 mfsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu8aL/XtWW0X2+AV1ekpYTpIKD8/r6Gk4nttDNK2adhdmrBWUCoEXz4S+UORB9/EGPSKr1Uho=@lists.denx.de
X-Gm-Message-State: AOJu0Yzji09F5FJ6lHuunkYlYa1MtJABhRK4IzAh6hCuYOs47tlBLB8k
 ZdoRtvYkLDointPC9A1KI+wzeqIz9WGAUh+hX9mVWcgVL4mUhJCGRpaqvi/VevuKe21ixzDDQea
 Tafzh46WvTc7ky3GJmHQwcDGOhIg4qi36Irfo8A==
X-Gm-Gg: ASbGncufDe66BG0YZjkqYPjtnTAYyu7+QfWQLtpW01B5Kowg/4IvNjPThMmJDal6D0g
 HbUqpNaU064V4NEQnIKczxWYS2drKPscuDMsp0A==
X-Google-Smtp-Source: AGHT+IHLnVRIUy8Nyif5qYfnCGYS2cFXVbHNrNQnSO2m89XQOKODr6FSpIGJZKjQvklp2VeRVec0K7ntfGJC5yDPGnk=
X-Received: by 2002:a05:6402:3489:b0:5d4:1ac2:277f with SMTP id
 4fb4d7f45d1cf-5d63c306485mr15397994a12.9.1734438584492; Tue, 17 Dec 2024
 04:29:44 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
 <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
 <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
 <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
 <20241217112535.GA43472@francesco-nb>
In-Reply-To: <20241217112535.GA43472@francesco-nb>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Dec 2024 17:59:33 +0530
Message-ID: <CADg8p94+y3VwpeWNy6Zgutei9HE4WSWeBr6QSeU+UqpeVOY4Qw@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@denx.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>
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

On Tue, 17 Dec 2024 at 16:55, Francesco Dolcini <francesco@dolcini.it> wrot=
e:
>
> +Fabio, Marex, Peng, Frieder
>
> On Tue, Dec 17, 2024 at 08:18:50AM -0300, Jo=C3=A3o Paulo Gon=C3=A7alves =
wrote:
> > >
> > > Okay. Please try changing the value of ram_top to 0x1_0000_0000
> > > instead of 0xFFFF_FFFF. That should work.
> > >
> >
> > Changing ram_top to 0x1_0000_0000 worked:
> >
> > U-Boot SPL 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -030=
0)
> > DDR configured as dual rank
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > SEC0:  RNG instantiated
> > Normal Boot
> > Trying to boot from BOOTROM
> > Boot Stage: Primary boot
> > Find img info 0x4802d400, size 1116
> > Need continue download 1024
> > NOTICE:  BL31: v2.6(release):lf_v2.6-g3c1583ba0a
> > NOTICE:  BL31: Built : 11:00:38, Nov 21 2022
> >
> >
> > U-Boot 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
> >
> > CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> > CPU:   Industrial temperature grade (-40C to 105C) at 54C
> > Reset cause: POR
> > DRAM:  Ram top: 100000000
> > 8 GiB
> > Core:  183 devices, 31 uclasses, devicetree: separate
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> > Loading Environment from MMC... Reading from MMC(2)... OK
> > In:    serial@30880000
> > Out:   serial@30880000
> > Err:   serial@30880000
> > Model: Toradex 0070 Verdin iMX8M Plus Quad 8GB WB IT V1.1A
> > Serial#: 15207893
> > Carrier: Toradex Dahlia V1.1C, Serial# 11060859
> > SEC0:  RNG instantiated
> > Setting variant to wifi
> > Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
> > Hit any key to stop autoboot:  0
> > MMC: no card present
> > switch to partitions #0, OK
> > mmc2(part 0) is current device
> > Scanning mmc 2:1...
> > Found U-Boot script /boot.scr
> > 5974 bytes read in 1 ms (5.7 MiB/s)
> > ## Executing script at 50280000
> > Loading DeviceTree: imx8mp-verdin-wifi-dev.dtb
> > ...
> > Starting kernel ...
> >
> > The change is shown in the patch below, but I am unsure if this is the
> > correct solution. Should ram_top be the last valid address or the upper
> > bound?
> >
> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/so=
c.c
> > index 9588b8b28bf2..e01774ebc8a4 100644
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t to=
tal_size)
> >          * space below the 4G address boundary (which is 3GiB big),
> >          * even when the effective available memory is bigger.
> >          */
> > -       top_addr =3D clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xfff=
fffff);
> > +       top_addr =3D clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0x100=
000000);
> >
> >         /*
> >          * rom_pointer[0] stores the TEE memory start address.
>
> see commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G=
 boundary").
>
> I assume such a change might introduce regressions.

I am not sure which commit you mean, since the above commit is
actually restricting the ram_top to 0x8000_0000. This is a corner case
of the bank end being above the value of ram_top. With the current
values, a single byte at 0xffff_ffff is getting reserved. And this
causes the lmb to not reserve the u-boot image region and also causes
the future allocations to fail. With the value of ram_top set to
0x1_0000_0000, the single byte reservation does not happen, and the
issue is not seen.

There is another way that this can be handled in the lmb code, but I
want to send that change after this release as we are pretty close to
this release. For the meantime, for this release, can you bump up the
value of ram_top by 1. I understand that the value of ram_top is one
more than the highest address that is to be used on the platform.

-sughosh

>
> Francesco
>
>
