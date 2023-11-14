Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 21:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A5386F6E;
	Tue, 14 Nov 2023 22:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="ax/2YKTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE80786F6F; Tue, 14 Nov 2023 22:02:04 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B27B86D62
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 22:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507a62d4788so8668584e87.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699995718; x=1700600518;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcBCjk7XqXxlWwC+njQDCwBzAPkKAcVIjPrsbDEnAj0=;
 b=ax/2YKTicEHXoeeCVuXQjD+h7/rQl3eABg2eJAq/y7qkSLwD2AYTvJCuOZe71uGfvn
 m6Olesbeu011wwvplMiS8gGG/Tse5HSlsCyGKLEQ+1B7CCwlqFMTkXChDen6apIkF5kr
 GFF2Zd93fZG6DfU2o2XiBUlr6WATb/xCOdkm51F+8KpKnZdI87xq0dvJkXX7OAXa05Uu
 7o/I4XWYU1svPOb60J0NCT9jCpLW8SD5obS7v5+O1I6faNvm59jUk+E0IhX5XL9HQp46
 WVwJ9Czr1041en1NY7TT7Cah4Y+mhtrJAPrGSRFEx1IdNoQ3O3TVlD6Nnd8u+sKzi+w4
 tJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699995718; x=1700600518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcBCjk7XqXxlWwC+njQDCwBzAPkKAcVIjPrsbDEnAj0=;
 b=S38CIVZuVnuilmFD5k92X16xR8pc0G9VhmNXphgSqk7rrDUOD0EYT+pwhXcxHolGaS
 kXyKkN7QUjlHs4jb6u8IVz+C5lPvh9YH0TU1C5pDUU0BVLUSa+hmmYJs+ibicwuzDuAw
 F/gdqvZPRABOmLNCP7OZuhaj38Xc0aWOp9q3p05G/ezjOzdRDiWMDNMZlw6OPLflaVJe
 OS8e8wCIPNVpx1ZtcNLEPuQYVwepj2q7GXpvjisokKbgXeun4QirzjRpwgMs1gYvOyMu
 er777wnhibshKfkKyDih6OuP+FcGYEHMESZo+k7fd4WR5mIY2mQcY1ZAuM2cISnxvLc3
 kWYw==
X-Gm-Message-State: AOJu0YxxqyJjxE1XFWFD6j1oVaNM6V6KXYjSVCOY4gDIEpPtvP0mfwN+
 sY1uIBpdbrnFLyoaL9wtTAB6R5UQLfQTQlEfE4I=
X-Google-Smtp-Source: AGHT+IGMb3K2lgiV2zmF5KErLAukDeReLrGwktMdcqg4LecwBbAYJrUOXHY+xn/r+sG5tMIOQjOYUg==
X-Received: by 2002:ac2:5f6b:0:b0:504:31a0:f9e2 with SMTP id
 c11-20020ac25f6b000000b0050431a0f9e2mr6629997lfc.58.1699995717993; 
 Tue, 14 Nov 2023 13:01:57 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 i23-20020a1709061cd700b009d23e00a90esm6056353ejh.24.2023.11.14.13.01.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 13:01:57 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so9380580a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:01:57 -0800 (PST)
X-Received: by 2002:aa7:d4d2:0:b0:53e:538e:3b70 with SMTP id
 t18-20020aa7d4d2000000b0053e538e3b70mr7760337edr.29.1699995717141; Tue, 14
 Nov 2023 13:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
 <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
 <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
 <CABEcMwVgnRYd3bSRTY3sUsa=igTsQroEMxCtVjO8ApidigMHHQ@mail.gmail.com>
 <ebcb92c8-f710-490a-a3a3-a97a52118608@kwiboo.se>
 <CABEcMwWNxzvkkC6-OwUx7AedhctfT00fM-ubXVf9ec1RoMmgOQ@mail.gmail.com>
In-Reply-To: <CABEcMwWNxzvkkC6-OwUx7AedhctfT00fM-ubXVf9ec1RoMmgOQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Tue, 14 Nov 2023 21:01:45 +0000
X-Gmail-Original-Message-ID: <CAHc5_t136s5sg4GXXEzeyoH4zO9su2L__Y65t0L675JC9SWH0A@mail.gmail.com>
Message-ID: <CAHc5_t136s5sg4GXXEzeyoH4zO9su2L__Y65t0L675JC9SWH0A@mail.gmail.com>
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
To: Jonas Karlman <jonas@kwiboo.se>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu, 
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

Hi Jonas / Simon,

I have submitted a patch based on Jonas's suggestion.
Apologies, I am new to email based patch management and it went as new
thread (at least for me)

It's here - https://lore.kernel.org/u-boot/20231114203309.852289-1-i@shantu=
r.com/

Kind regards,
Shantur

On Mon, Nov 13, 2023 at 12:07=E2=80=AFAM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Hey Jonas,
>
> This sounds like a good idea.
> Please implement this.
>
> Kind regards,
> Shantur
>
> On Sun, Nov 12, 2023 at 3:01=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> w=
rote:
> >
> > Hi Shantur,
> >
> > On 2023-11-12 15:21, Shantur Rathore wrote:
> > > Hey Jonas,
> > >
> > >> For normal generic use the full bootstd commands should not be neede=
d,
> > >> do you have special scripting requirements that require access to fu=
ll
> > >> bootstd commands?
> > >>
> > >> All rockchip boards use standard boot, this only enables full comman=
ds
> > >> for one particular board, why is this board special? Or
> > >
> > > This board isn't special.
> > >
> > >> is there merit
> > >> to imply enable of full commands for all rockchip boards?
> > >
> > > Maybe not only on rockchip boards but all boards.
> > >
> > > Do we need full commands in general ? - Maybe not
> > >
> > > Then why did you need to enable full commands ?
> > > Bootstd works when the distro used is supporting it. In my case when =
I
> > > installed the distro (Armbian), EFI was installed to
> > > /boot/efi/EFI/debian by default instead of /boot/efi/EFI/boot as
> > > expected by Bootstd.
> > > Bootstd couldn't find the EFI and failed to boot. In this scenario
> > > there is no way to figure out what's going on, what bootmethods /
> > > bootflows is bootstd able to find or try to manually boot some.
> > > To be able to support the smallest bit of debugging you end up
> > > building U-Boot from scratch to enable bootstd full for bootstd info
> > > commands.
> > > All other commands in U-boot by default come with options to display
> > > more information ( for ex. nvme info, nvme detail, usb tree, usb info=
,
> > > usb dev, fatinfo and many more ) then why is bootstd restricted?
> > > Thus, in my opinion we should enable BOOTSTD_FULL for users to be abl=
e
> > > to see more information.
> > > Restricting might be beneficial for end user devices but atleast
> > > development devices like RockPro64 should come with BOOTSTD_FULL by
> > > default.
> >
> > Thanks for clarifying the need! And I also see the benefit of having
> > full feature commands enabled.
> >
> > For RK35xx family of devices I have tried to ensure all boards have sam=
e
> > features and sounds like something like below could benefit all rk
> > boards, or at least for ROCKCHIP_RK3568 and ROCKCHIP_RK3588 boards.
> >
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index c39ae40335a0..07e93a9c7ad5 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1987,6 +1987,7 @@ config ARCH_ROCKCHIP
> >         imply CMD_DM
> >         imply DEBUG_UART_BOARD_INIT
> >         imply BOOTSTD_DEFAULTS
> > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> >         imply FAT_WRITE
> >         imply SARADC_ROCKCHIP
> >         imply SPL_SYSRESET
> >
> >
> > Regards,
> > Jonas
> >
> > >
> > > Kind regards,
> > > Shantur
> > >
> > > On Sun, Nov 12, 2023 at 12:50=E2=80=AFPM Jonas Karlman <jonas@kwiboo.=
se> wrote:
> > >>
> > >> Hi Shantur,
> > >>
> > >> On 2023-11-12 13:34, Shantur Rathore wrote:
> > >>> Hi Jonas,
> > >>>
> > >>>> The CMD_SPI is not used to interact with the SPI flash.
> > >>>>
> > >>>> CMD_SF is already enabled and you can use "sf probe" and any other=
 sf
> > >>>> related action to interact with the SPI flash on this board.
> > >>>>
> > >>>
> > >>> You are right, this is not needed, thanks for correcting me.
> > >>> I will update my patch.
> > >>>
> > >>>> What is the reasoning behind enabling full bootstd commands? Espec=
ially
> > >>>> why just this board need it enabled by default.
> > >>>>
> > >>>> Standard boot is already fully functional, it just does not have f=
ull
> > >>>> features commands enabled by default.
> > >>>
> > >>> By default standard boot only allows you to boot from the first
> > >>> available boot device.
> > >>> This board supports SDCard, NVME (via PCIe port), USB and network b=
oot
> > >>> and with BOOTSTD_FULL we can choose what to exactly boot.
> > >>> The boot_targets environment variable only allows you to choose whi=
ch
> > >>> device to boot, not which boot method / flow to use.
> > >>> We have ample space in SPI Flash, so why not let it have the full
> > >>> potential of U-Boot by default.
> > >>
> > >> You can control boot targets using the boot_targets env var and boot
> > >> methods using the bootmeths env var.
> > >>
> > >> https://docs.u-boot.org/en/latest/develop/bootstd.html#controlling-o=
rdering
> > >>
> > >> For normal generic use the full bootstd commands should not be neede=
d,
> > >> do you have special scripting requirements that require access to fu=
ll
> > >> bootstd commands?
> > >>
> > >> All rockchip boards use standard boot, this only enables full comman=
ds
> > >> for one particular board, why is this board special? Or is there mer=
it
> > >> to imply enable of full commands for all rockchip boards?
> > >>
> > >> Regards,
> > >> Jonas
> > >>
> > >>>
> > >>> Kind regards,
> > >>> Shantur
> > >>>
> > >>> On Sun, Nov 12, 2023 at 10:39=E2=80=AFAM Jonas Karlman <jonas@kwibo=
o.se> wrote:
> > >>>>
> > >>>> On 2023-11-11 01:13, Shantur Rathore wrote:
> > >>>>> RockPro64 has a 16MB onboard SPI chip and current u-boot takes
> > >>>>> around 2MB, we can enable more features.
> > >>>>> Updating config to enable SPI commands and full BootSTD support.
> > >>>>> ---
> > >>>>>  configs/rockpro64-rk3399_defconfig | 2 ++
> > >>>>>  1 file changed, 2 insertions(+)
> > >>>>>
> > >>>>> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro=
64-rk3399_defconfig
> > >>>>> index 4cd6b76665..cad0b8a5d7 100644
> > >>>>> --- a/configs/rockpro64-rk3399_defconfig
> > >>>>> +++ b/configs/rockpro64-rk3399_defconfig
> > >>>>> @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=3Dy
> > >>>>>  CONFIG_CMD_GPT=3Dy
> > >>>>>  CONFIG_CMD_MMC=3Dy
> > >>>>>  CONFIG_CMD_PCI=3Dy
> > >>>>> +CONFIG_CMD_SPI=3Dy
> > >>>>
> > >>>> The CMD_SPI is not used to interact with the SPI flash.
> > >>>>
> > >>>> CMD_SF is already enabled and you can use "sf probe" and any other=
 sf
> > >>>> related action to interact with the SPI flash on this board.
> > >>>>
> > >>>>>  CONFIG_CMD_USB=3Dy
> > >>>>>  # CONFIG_CMD_SETEXPR is not set
> > >>>>>  CONFIG_CMD_TIME=3Dy
> > >>>>>  CONFIG_CMD_BOOTSTAGE=3Dy
> > >>>>> +CONFIG_BOOTSTD_FULL=3Dy
> > >>>>
> > >>>> What is the reasoning behind enabling full bootstd commands? Espec=
ially
> > >>>> why just this board need it enabled by default.
> > >>>>
> > >>>> Standard boot is already fully functional, it just does not have f=
ull
> > >>>> features commands enabled by default.
> > >>>>
> > >>>> Regards,
> > >>>> Jonas
> > >>>>
> > >>>>>  CONFIG_SPL_OF_CONTROL=3Dy
> > >>>>>  CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-name=
s interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-pare=
nts"
> > >>>>>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> > >>>>
> > >>
> >
