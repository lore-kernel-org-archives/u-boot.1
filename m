Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A173EE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 12:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB36801CF;
	Tue, 17 Dec 2024 13:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f0V+ufrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231BF801FB; Tue, 17 Dec 2024 13:38:15 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5577801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 13:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso45028215ad.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 04:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734439091; x=1735043891; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Usu5IY7SxgA/oss+Kgv/v24TUjQkr4pbq4X/7s2yJRk=;
 b=f0V+ufrmA5K+tZjjM0MMbPePkPHdjOPztAYecH9L6AIhjGcDDmGfErRQt0OF95K8Qv
 2PIsnteUlSY4dEEGBPveTANZ82pBLYwH2hadlPuQdXzcIXlIUh5+ihaLA/6rLZ540stW
 1XftojL4VjR0dmTRFqJX6esWET7HmqobssReDgaNB82RihgMu5/4lCw56ZdgO57gjOjG
 vqNpqCjQv1WMptCKUWqOqZe6X6esXi3X9AglmGnj8Ncn12s7ab1zOQFZeyNsL2AbTjHh
 IjBY5nxoAEqfy6OgDC+7J3KHxFiXQUvYlMC3z04w+7qRZiuJsaBZVq+tDPKouKWEVvVC
 qXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734439091; x=1735043891;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Usu5IY7SxgA/oss+Kgv/v24TUjQkr4pbq4X/7s2yJRk=;
 b=p5GWkcd1sbiWV1XOCE5P9zuMExzBqPQNzHx1tCDoMQKFkFSSiu+fZA1X1ED1BfS0gP
 teaJ3bRW/o97bdm2PiwxF7/GAIHxqk+BP78h2Bdjd5BFXfTaHeqXYAMvoiI/A7+/UszU
 nG/fcbRx7YiFJiMeC/A7QnAJhXN/lOrbqiZbtOKRv8qD9dfjmb8//v/qAxd2bW5Y3qDr
 f8rPpTel/3F1OyCukEPe3nEmK+EABokhsyBMRD4bqILUJlT/WvLnOk5KQfudTrnFH5w3
 PTuRyZapZWZJLd/Pn8bn7d4ys/8eNX5m0YrvxaNSzDZpaW2cJ/YKT6IA2mR2aPOhHneS
 fWYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlKIPD5865uWkPtSLGsmwcK2TYWWfTDV02sKa1CRTjzUf7o6kDmwIh+jA6sknncfbyAgnuhzs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc0XVKZw4G+1bAmPFefWuj+hKprpHH55YcwKI6w31/KWunHI6z
 HpOddCk+PRlHWWmMils3Orwyuk+9y/uSvXcN9tBkZHWR+umY3lty
X-Gm-Gg: ASbGncvZi8a7VHIlovj6XFOavZV2i/01dP7uILZ6AqsDNKiJE698B3TgQURLGyLwQUP
 tVYB4djKpsGX4I7OQrhCj6vEJHXhtMLgRj3y0c4Q/mKgHwj5TdoE1PEVXSYYYwfuASnBsqWgO1C
 VLZyPyP+tB8QXL1PmmX/B1P7TV4CogQDLLbEej8ArtUFBtthLm+dAC7oZE+AaTY+18dM5nwF3Aq
 yCZcsl/LAx5Ziuw7u/cH+S2rgDVaAkYHOG9ntA1RNAfduV3253Cd6uqlz38x0oiN5vcZZzHoRak
 dx/i7muEG5eLQkE=
X-Google-Smtp-Source: AGHT+IG03J9IKE5cCuGEeI2Ls4qEW+e9NrX+PG4YCuB74wo/TZFA+mHWF8C4lboLX0GqvKColmi27Q==
X-Received: by 2002:a17:902:d508:b0:216:6f1a:1c81 with SMTP id
 d9443c01a7336-21892992997mr237658415ad.2.1734439090927; 
 Tue, 17 Dec 2024 04:38:10 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db7587sm58558975ad.35.2024.12.17.04.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 04:38:10 -0800 (PST)
Date: Tue, 17 Dec 2024 09:38:05 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <20241217123805.r6a74g4ot2hblmld@joaog-nb.corp.toradex.com>
References: <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
 <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
 <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
 <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
 <CAC_iWjJWA5nUP_cPkKnziK9s=dd6Zv40eOueyi7biERoO-UrkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjJWA5nUP_cPkKnziK9s=dd6Zv40eOueyi7biERoO-UrkA@mail.gmail.com>
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

On Tue, Dec 17, 2024 at 01:55:51PM +0200, Ilias Apalodimas wrote:
> Joao, there's 3 places that
> 'ERROR: Out of memory'. Since I don't have access to the board, can
> you change the prints a bit and figure out where it comes from? I
> assume it's from efi_console.c. Can we verify it?
> 
> Thanks
> /Ilias
> 
> On Tue, 17 Dec 2024 at 13:18, João Paulo Gonçalves
> <jpaulo.silvagoncalves@gmail.com> wrote:
> >
> > >
> > > Okay. Please try changing the value of ram_top to 0x1_0000_0000
> > > instead of 0xFFFF_FFFF. That should work.
> > >
> >
> > Changing ram_top to 0x1_0000_0000 worked:
> >
> > U-Boot SPL 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
> > DDR configured as dual rank
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
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
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
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
> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> > index 9588b8b28bf2..e01774ebc8a4 100644
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >          * space below the 4G address boundary (which is 3GiB big),
> >          * even when the effective available memory is bigger.
> >          */
> > -       top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xffffffff);
> > +       top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0x100000000);
> >
> >         /*
> >          * rom_pointer[0] stores the TEE memory start address.
> >
> > Best Regards,
> > João Paulo Gonçalves

Yes, it is coming from efi_console.c in the efi_console_register(). The
first 'out of memory' occurs in efi_alloc() within efi_dp_from_uart().
As a result, efi_console_register() fails in efi_dp_from_uart() and
returns 'ERROR: Out of memory'." 

João Paulo
