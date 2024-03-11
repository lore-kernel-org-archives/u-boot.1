Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15519C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 20:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4623387EDF;
	Mon, 11 Mar 2024 21:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2XO0zz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA11A87EF7; Mon, 11 Mar 2024 21:51:34 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 738B987572
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 21:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56838e00367so3713898a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710190292; x=1710795092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25lauT04hvyJo7Y1B1w+m8TlM0bBSygScU+1VzZp7vg=;
 b=Y2XO0zz9fEPwJJtUmUISOW9vNEDy2WJOU3jnQEZuoe5AseqNHHwbr5wnW11vRzQ9ti
 8qw7taJxMeVlZ2p8BT3XjeWRGR7VEwy0GHoObqRp1OzDpeoSbziGsJz81paVlCqaVfsp
 tq5C2HEq1mGkPdJ29GhBYMTAxpoGviWWhvPx7P2/9TMTnQiFbVJWvhDxjkHTsDapn75c
 tofWRicniD/VtViqhkjnkGK1vnkoeAzVtc1l0uLyXv7mfwBT7pCmWLHqWdf5JwFvEjVy
 k6NMRUdDAsoBrEudCyDUnDifVeCaAE2/dXNCt8AmpF7TNP6D9kTnMyNnAKk1xAyVHcDG
 Hr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710190292; x=1710795092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25lauT04hvyJo7Y1B1w+m8TlM0bBSygScU+1VzZp7vg=;
 b=cLW+OCFGXfHecZCGOs1iXVb4rJ6HvrEEptuFbUcQ2I+XOc04CAe8Chpdp2kvnBfz1Y
 EINggccGkNvKLTxKySfkDz3jaIPlkqP/AvYwfgu/LuBhvywV0nvLujZ7YUIyEIoakmo/
 lReVF9vETmSlqZZ5tVMRBRIudA8J+CceoROiN048rHfaqiZSBChzanIQb9GSh95pffrK
 TJWahyoXATHbbmzw1NYz05bpZS2wiVsFQkYBE3h0yWb5c62/opKqVPPheXsxpMbB8IXJ
 9dBtlKJynw5BGjfdOjGDuvexLNCl/p/CNNUmx+pR/W1JeqCMh0UulpNQ1fPdJbw6B7a+
 YnBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOwWRlhkQgPG0WN687df4xHbPywopD9BTtWTRdOFD/MCFCEavZ/SjlFAjQdMbFm8Fd7YLxmfRw04qbpYYbmZgmCVXcGQ==
X-Gm-Message-State: AOJu0Yz3ZeYrzVToyfg0pO8tUuxiFCXok4cODt7/PPYdOCle9RBwrBX4
 GrZApZ8Kl0zcAzgVPnfAOkMscAsD61MFXLqBQO7kuZuHLuHKxQccgCHrgt6WDxARt47wvWU+6jh
 2KhdtJbIaYey/uuIH1yd1zU5/Gr6tX1R/
X-Google-Smtp-Source: AGHT+IFyDfSc2eZoJMyk/vG9xwo4VfsMz8Mj6AwzIzpyERaj5BppKK1RBD1pGJp1PGFBTpimNOFaXPG0nupg6/w4zZo=
X-Received: by 2002:a50:8d0b:0:b0:568:2505:93b4 with SMTP id
 s11-20020a508d0b000000b00568250593b4mr1061581eds.6.1710190291648; Mon, 11 Mar
 2024 13:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
 <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
 <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
 <CAFA6WYM12F_9yyNwXY5xj9+zh3Jwa_Jmz8MkaKsxm3Jn3NPNKA@mail.gmail.com>
 <CAOMZO5DgEaTGmxJfJf=fGgwauE-M+XyHm+tA8rfOw+MwRK_mqA@mail.gmail.com>
 <CAJaLiFxgNPoiGZMFt7SvTdVRUz1QNC7pibbeoaed7DaxEnFWNQ@mail.gmail.com>
 <CAFA6WYOJJ2=x01DcF_u4env=r1On1Ry0kkdi4MZcz8xT7o7V0Q@mail.gmail.com>
In-Reply-To: <CAFA6WYOJJ2=x01DcF_u4env=r1On1Ry0kkdi4MZcz8xT7o7V0Q@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 11 Mar 2024 13:51:18 -0700
Message-ID: <CAJaLiFwh9urHjei7EVpdwguT=F5YK8cdp9r4oL6sfPZZzRi0VQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bryan Brattlof <bb@ti.com>, 
 Stefan Roese <sr@denx.de>, Fabio Estevam <festevam@denx.de>
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

Hi Sumit,

On Sun, Mar 10, 2024 at 11:24=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Hi Tony,
>
> On Mon, 11 Mar 2024 at 09:20, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Hi Sumit,
> > Hi Tom,
> >
> > On Mon, Mar 4, 2024 at 4:29=E2=80=AFAM Fabio Estevam <festevam@gmail.co=
m> wrote:
> > >
> > > On Mon, Mar 4, 2024 at 9:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > > I suppose the earlier reference patch wasn't complete, can you rath=
er
> > > > try its v4 [1] instead?
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240304121257=
.3551104-1-sumit.garg@linaro.org/
> > >
> > > This one works, thanks!
> >
> > I'm testing this for a Marvell Armada 385 board (Synology DS116). I'm
> > on the next branch, but  perhaps something is still missing.
> >
> > diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
> > index 02ddc0e7918..1fbedcf91cf 100644
> > --- a/configs/ds116_defconfig
> > +++ b/configs/ds116_defconfig
> > @@ -16,7 +16,7 @@ CONFIG_SF_DEFAULT_SPEED=3D50000000
> >  CONFIG_ENV_SIZE=3D0x10000
> >  CONFIG_ENV_OFFSET=3D0x7E0000
> >  CONFIG_ENV_SECT_SIZE=3D0x10000
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"armada-385-synology-ds116"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
> >  CONFIG_SPL_TEXT_BASE=3D0x40000030
> >  CONFIG_SPL_SERIAL=3Dy
> >  CONFIG_SPL_STACK=3D0x4002c000
> > @@ -29,7 +29,6 @@ CONFIG_PCI=3Dy
> >  CONFIG_DEBUG_UART=3Dy
> >  CONFIG_AHCI=3Dy
> >  CONFIG_BOOTSTD_FULL=3Dy
> > -CONFIG_BOOTSTD_DEFAULTS=3Dy
> >  CONFIG_BOOTDELAY=3D10
> >  CONFIG_USE_PREBOOT=3Dy
> >  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
> > @@ -57,6 +56,7 @@ CONFIG_CMD_CACHE=3Dy
> >  CONFIG_CMD_TIME=3Dy
> >  CONFIG_CMD_MTDPARTS=3Dy
> >  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dspi0.0:1m(u-boot),7040k(kernel),=
64k(u-boot-env),-(data)"
> > +CONFIG_OF_UPSTREAM=3Dy
> >  CONFIG_ENV_OVERWRITE=3Dy
> >  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> >  CONFIG_VERSION_VARIABLE=3Dy
> >
> > # make ds116_defconfig
> >
> > # grep -i ds116 .config
> > CONFIG_SYS_BOARD=3D"ds116"
> > CONFIG_SYS_CONFIG_NAME=3D"ds116"
> > CONFIG_TARGET_DS116=3Dy
> > CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
> > CONFIG_IDENT_STRING=3D"\nSynology DS116"
> > CONFIG_SYS_PROMPT=3D"DS116> "
> > CONFIG_OF_LIST=3D"marvell/armada-385-synology-ds116"
> > CONFIG_SPL_OF_LIST=3D"marvell/armada-385-synology-ds116"
> >
> > Built it, and looks like vendor Marvell is missing during the Make
> > file execution.
> >
> > make -f ./scripts/Makefile.build obj=3Ddts dtbs
> > make -f ./scripts/Makefile.build obj=3Ddts/upstream/src/arm dtbs
> > scripts/Makefile.build:57: dts/upstream/src/arm/Makefile: No such file
> > or directory
>
> As you are building for the 32-bit Arm, you have to add a Makefile
> here [1] similar to this one [2] for arm64.
>
> [1] https://source.denx.de/u-boot/u-boot/-/tree/next/dts/upstream/src/arm=
?ref_type=3Dheads
> [2] https://source.denx.de/u-boot/u-boot/-/blob/next/dts/upstream/src/arm=
64/Makefile?ref_type=3Dheads

Thanks! It works great with that Make file.

All the best,
Tony

>
> -Sumit
>
> > make[2]: *** No rule to make target 'dts/upstream/src/arm/Makefile'.  S=
top.
> > make[1]: *** [dts/Makefile:54: arch-dtbs] Error 2
> > make: *** [Makefile:1166: dts/dt.dtb] Error 2
> > make: *** Waiting for unfinished jobs....
> > make: Leaving directory '/usr/src/u-boot'
> >
> > I also tried Bryan's patch like you've suggested to Fabio. But it
> > seems Bryan's patch was already in the next branch. Did I miss
> > something?
> >
> > All the best ,
> > Tony
