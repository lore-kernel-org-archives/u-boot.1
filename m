Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D483C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 19:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27CD8882C;
	Mon, 29 Apr 2024 21:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="ZTpB9ACg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1069F8808F; Mon, 29 Apr 2024 21:10:17 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBEB88841
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 21:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so5107925a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714417812; x=1715022612; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQfXrLFUXtnt9Q6m9dzBFQIHmIU76HvxyC5mp4QAqR4=;
 b=ZTpB9ACgD9nqD3O5eR7bHQIOrfeI4BMv/Yg9wbAGIedHgid5Yt9ZSreBSE8IW7AM7N
 IDscJVnrgA7iVA6pSX05SzAFQiFHf7m/rOYh3d1HjDrcyn7yRDb8TDHb/O9i2mgdb6Hr
 3XLjAkKyo3/OgQyscqufyf9OtfeCiODkBQ5WRBhztWYVhhgVTdSBKHKbLkZernbm26Vf
 M9uDkqAvUHvtfmjjbs+IDlZB2se2SK7EfnRzcglblojNkRiAF53b8E1M3CM5iM1VVjPI
 PQ57AUhd6Lavtc0EhVirnz1mVbk4Pp0Pk5ZDS1GPmYx60TphjqZEpHLxNOqoufjY/x50
 YlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714417812; x=1715022612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQfXrLFUXtnt9Q6m9dzBFQIHmIU76HvxyC5mp4QAqR4=;
 b=XFkfOKCY3j6wQpU2NcfUccAYI57EiYW8ArPBQKm4EOjJkjfM/jpNTlXSUynaiLrozq
 pGF5Mt53heXj+QQMrZbWqEKi1RBhw+DgcEeFYALaclQL+AZy5SX4wEoC4KGfMpndAXg3
 PLyZ7rc9eXXcN2/iSzap0Wl34H6e3JOGcs/0aIHp7BvYLCpo63Z+smngfLb2uDNuP1Xg
 ZE80OZ50qJZj59YkcYX7HJh1dgOog5KxFcE9UQnawWu+9Fc9t/ZzLHZc3A7nN52as73b
 I3lJtWTj0rINPFE8T9gN25c7q3xwr4kTRfIExxXuAG8SExFg6fx3ErIpRcQaxMGfB4Sb
 OldA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY39im/p5dtvaU/kvMZc53xhnwLAykttMe9k3qSKxeEKTLdy+lUgTrPY/Vu+h5cVhMA6/DvcsL3dWTUHnl1FSPGrhUCQ==
X-Gm-Message-State: AOJu0YwXt/VlYU33MrbFtbHELTdQ34tRneHjfWOyvmLgPiI/ZW//Cu7e
 fdWkoSh1xvj6w1uojfJQUt1bfQHF780atLPS19mo+/fjb6f71F5CmcsLM+ySg6u82awc56EWXzP
 LgpsFnnDK4Kog9c5zIb8lzbAjQHhbTQindl0YCW8FnvEpGq+BXsZ9vA==
X-Google-Smtp-Source: AGHT+IGEJw9881kHM0KsoZOfgnzXppCnmdLxQO2rkW1AyYc+PsLyAQmmoBnLxkUmHCNRpZwQobpXwJCuK1NCYR6u9dA=
X-Received: by 2002:a17:907:1b16:b0:a58:725b:a021 with SMTP id
 mp22-20020a1709071b1600b00a58725ba021mr9731090ejc.15.1714417812520; Mon, 29
 Apr 2024 12:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
 <CAJ+vNU13yh8K4UbK2xLCwS74gn25NGFUFHd_n_EqbknyVmAdSg@mail.gmail.com>
 <47bfd824-d4e1-41d3-b236-b488edd67504@denx.de>
In-Reply-To: <47bfd824-d4e1-41d3-b236-b488edd67504@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 29 Apr 2024 12:10:00 -0700
Message-ID: <CAJ+vNU05SGZbFMWdzo=5Q0438rW2aRhRBZS4WQnqUMe89-9rZg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
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

On Tue, Apr 23, 2024 at 4:18=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/19/24 5:24 PM, Tim Harvey wrote:
> > On Thu, Apr 18, 2024 at 11:42=E2=80=AFAM Marek Vasut <marex@denx.de> wr=
ote:
> >>
> >> On 4/18/24 8:02 PM, Fabio Estevam wrote:
> >>> Hi Tim,
> >>>
> >>> On Thu, Apr 18, 2024 at 2:54=E2=80=AFPM Tim Harvey <tharvey@gateworks=
.com> wrote:
> >>>
> >>>> Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get t=
he
> >>>> following in the SPL?
> >>>> Couldn't bind rng driver (-96)
> >>>> SEC0:  RNG instantiated
> >>>>
> >>>> sec_init failed!
> >>>
> >>> Yes, if I add CONFIG_DM_RNG=3Dy to imx8mm_evk_defconfig I get:
> >>>
> >>> U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 14:58:57 =
-0300)
> >>> No pmic
> >>> Couldn't bind rng driver (-96)
> >>> SEC0:  RNG instantiated
> >>>
> >>> sec_init failed!
> >>
> >> Interesting. Which TFA blob version do you use ? I used the mainline
> >> 2.10 for my tests.
> >
> > Marek,
> >
> > Were you able to reproduce this as well with the board you enabled
> > DM_RNG for? If it does work fine what dtb were you using... perhaps
> > there is something in its u-boot.dtsi that we need?
>
> This one arch/arm/dts/imx8mp-dhcom-pdk3.dts , see log below. The build
> has a few extra patches in it, but nothing which affects the KASLR:
>
> $ export SOURCE_DATE_EPOCH=3D1672531200 ; echo tst > .scmversion
> $ make imx8mp_dhcom_pdk3_defconfig ; make
>
> U-Boot SPL 2024.07-rc1tst (Jan 01 2023 - 00:00:00 +0000)
> DDR:   4096 MiB [0x5]
> DDR:   Inline ECC enabled
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x1000, pagesize 0x1, ivt offset 0x0
> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> NOTICE:  BL31: v2.10.0  (release):v2.10.0-5-gfb51ca229
> NOTICE:  BL31: Built : 20:30:36, Apr 23 2024
>
>
> U-Boot 2024.07-rc1tst (Jan 01 2023 - 00:00:00 +0000)
>
> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 70C
> Reset cause: POR
> Model: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3)
> DRAM:  3.5 GiB
> Core:  183 devices, 34 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> Loading Environment from SPIFlash... SF: Detected w25q128jw with page
> size 256 Bytes, erase size 4 KiB, total 16 MiB
> OK
> In:    serial
> Out:   serial
> Err:   serial
> SEC0:  RNG instantiated
> Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000
> ...
>
> > The error -EPFNOSUPPORT is interesting and helps point to the only
> > place it can be where the comment says the strange errno is to make
> > this easier to find:
> > https://elixir.bootlin.com/u-boot/latest/source/drivers/core/uclass.c#L=
70:
> >          if (!uc_drv) {
> >                  debug("Cannot find uclass for id %d: please add the
> > UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> >                        id);
> >                  /*
> >                   * Use a strange error to make this case easier to fin=
d. When
> >                   * a uclass is not available it can prevent driver mod=
el from
> >                   * starting up and this failure is otherwise hard to d=
ebug.
> >                   */
> >                  return -EPFNOSUPPORT;
> >          }
> >
> > I'm not very familiar with the dm driver binding - does the
> > U-BOOT_DRIVER usage in drivers/crypto/fsl/rng.c need to be refactored
> > to use UCLASS_DRIVER for it to be usable in both SPL and U-Boot?
>
> I don't think you need the CAAM RNG in SPL in the first place, or do you =
?
>
> > Honestly I don't know why we need DM_RNG in SPL anyway and we could
> > just add support for disabling it there to avoid unwanted bloat.
>
> I think you can disable it , yes.

Marek,

Would it be advantageous for the kaslr-seed to be added automatically
from image_setup_libfdt?

I notice arch/arm/cpu/armv8/fsl-layerscape/fdt.c:ft_cpu_setup does
this and board/raspberrypi/rpi/rpi.c looks like it copies kaslr-seed
from the control fdt which I assume was added by an earlier layer for
that target.

I'm not clear if there is a disadvantage to automatically adding this
node if DM_RNG is enabled.

Best Regards,

Tim
