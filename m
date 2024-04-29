Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE9C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 20:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DBA8896B;
	Mon, 29 Apr 2024 22:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="F36oi7AS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC09288963; Mon, 29 Apr 2024 22:53:07 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F097288979
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 22:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5176f217b7bso8614563e87.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714423982; x=1715028782; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7oNRSAPLr4KLHkSrNT8ckJOPKns6cModflJH6h1pxo=;
 b=F36oi7ASwQYTUdtzEbcDYAsmAlVnUviNnf8PDwLhB+0HxnWthycorX6BogjsH7o88c
 xVs8hQY5Nu1++lSGZckIipfNN9yDLUGULf7aHF0fzrjzIi6WpNfrhgeEeXCqH9O5UoDm
 +UBVyygAQl/4kWyjh8x+AVYBGS9hSU1T2hEDqJ0Ky7538YmBrhyHPiUIp1jNSPaLO7bU
 wTykCvMErKrMjG/cIfMAq2ROuzVHC2UiuaAs4IGSltXbKvaNNmVVKkBG0zljmN1RoQSh
 o2wZ6YBDnmJAb/Em8e1SmEPv6rUrAyK2We7xuRsFcfpje0fyXAZEboDA9K7d5JSRijlX
 UTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714423982; x=1715028782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7oNRSAPLr4KLHkSrNT8ckJOPKns6cModflJH6h1pxo=;
 b=nGuCMzWFb3mS60v7ZiWwhbEzUAXtKxwJkEiTPa/4ibkrvec/EYIARaaUbr0vAyEV93
 JwppUoC3tHpsvyMuepi9U40p8Y0j7IepjiZMnoWOvdvVlOqp78xF2dg+Ng2qTuLBjroA
 6c0lbGRa0a6sIuGmkgJ9HomQWOTgh0uWumH/3pfIAH9I6D51fMqeBEkylVjcTYXtJNsr
 MaC/3NlGygJr8IW8UyOgq0NkmvTPJrFnotjwMeyPW3tgpIP6Tuw4iPWPZhVuNKq11SLP
 GIHMOj+13ZQIS86veAcqXZwaO2P3zEHODrm5QQl2GE9kj1jLQnVt3eaphK6Slt1tEW/d
 IYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD8drXbimdG5HEvc2DoZrER4PbpHCtA+Jmid5rBvf8APvotKfG8pKmh7RV3/fZSiVo+kqLaETqaOKbAoSySQp2IHfUxQ==
X-Gm-Message-State: AOJu0Yz9N6h90efRREn8ftrpKDyoyNuTn7RjHSSZwv0q2OK6fGkAi1rS
 YusZCccnSO0SXaTYx7sIGkd3u2+w7yPsekQgMY+/Rxb0wv+lZcV9a1N4dO+w8UFoynkShGyrXtK
 q6PA5BpmBdyRmdkjQaop360lHaYtkYemnedayQZFhc07/AG0TxNI=
X-Google-Smtp-Source: AGHT+IHCQH+EBWFbe6jhNkI8rtCX8OldKRDtCCC49IOLFA3YwR3egUY7lxrljWJkB9jr13CMzsIJVePufax9d82/8pU=
X-Received: by 2002:a05:6512:3196:b0:51d:3675:6a06 with SMTP id
 i22-20020a056512319600b0051d36756a06mr6192619lfe.66.1714423981643; Mon, 29
 Apr 2024 13:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
 <CAJ+vNU13yh8K4UbK2xLCwS74gn25NGFUFHd_n_EqbknyVmAdSg@mail.gmail.com>
 <47bfd824-d4e1-41d3-b236-b488edd67504@denx.de>
 <CAJ+vNU05SGZbFMWdzo=5Q0438rW2aRhRBZS4WQnqUMe89-9rZg@mail.gmail.com>
 <771fb037-0f69-4fc2-b4cf-4bbe41d6f9e9@denx.de>
In-Reply-To: <771fb037-0f69-4fc2-b4cf-4bbe41d6f9e9@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 29 Apr 2024 13:52:49 -0700
Message-ID: <CAJ+vNU0eHia+733DnOzCE+9RiK3k9H2Hqtgecip5bm16ieohsQ@mail.gmail.com>
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

On Mon, Apr 29, 2024 at 1:51=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/29/24 9:10 PM, Tim Harvey wrote:
> > On Tue, Apr 23, 2024 at 4:18=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 4/19/24 5:24 PM, Tim Harvey wrote:
> >>> On Thu, Apr 18, 2024 at 11:42=E2=80=AFAM Marek Vasut <marex@denx.de> =
wrote:
> >>>>
> >>>> On 4/18/24 8:02 PM, Fabio Estevam wrote:
> >>>>> Hi Tim,
> >>>>>
> >>>>> On Thu, Apr 18, 2024 at 2:54=E2=80=AFPM Tim Harvey <tharvey@gatewor=
ks.com> wrote:
> >>>>>
> >>>>>> Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get=
 the
> >>>>>> following in the SPL?
> >>>>>> Couldn't bind rng driver (-96)
> >>>>>> SEC0:  RNG instantiated
> >>>>>>
> >>>>>> sec_init failed!
> >>>>>
> >>>>> Yes, if I add CONFIG_DM_RNG=3Dy to imx8mm_evk_defconfig I get:
> >>>>>
> >>>>> U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 14:58:5=
7 -0300)
> >>>>> No pmic
> >>>>> Couldn't bind rng driver (-96)
> >>>>> SEC0:  RNG instantiated
> >>>>>
> >>>>> sec_init failed!
> >>>>
> >>>> Interesting. Which TFA blob version do you use ? I used the mainline
> >>>> 2.10 for my tests.
> >>>
> >>> Marek,
> >>>
> >>> Were you able to reproduce this as well with the board you enabled
> >>> DM_RNG for? If it does work fine what dtb were you using... perhaps
> >>> there is something in its u-boot.dtsi that we need?
> >>
> >> This one arch/arm/dts/imx8mp-dhcom-pdk3.dts , see log below. The build
> >> has a few extra patches in it, but nothing which affects the KASLR:
> >>
> >> $ export SOURCE_DATE_EPOCH=3D1672531200 ; echo tst > .scmversion
> >> $ make imx8mp_dhcom_pdk3_defconfig ; make
> >>
> >> U-Boot SPL 2024.07-rc1tst (Jan 01 2023 - 00:00:00 +0000)
> >> DDR:   4096 MiB [0x5]
> >> DDR:   Inline ECC enabled
> >> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s time=
out)
> >> Trying to boot from BOOTROM
> >> Boot Stage: Primary boot
> >> image offset 0x1000, pagesize 0x1, ivt offset 0x0
> >> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> >> NOTICE:  BL31: v2.10.0  (release):v2.10.0-5-gfb51ca229
> >> NOTICE:  BL31: Built : 20:30:36, Apr 23 2024
> >>
> >>
> >> U-Boot 2024.07-rc1tst (Jan 01 2023 - 00:00:00 +0000)
> >>
> >> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> >> CPU:   Industrial temperature grade (-40C to 105C) at 70C
> >> Reset cause: POR
> >> Model: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3)
> >> DRAM:  3.5 GiB
> >> Core:  183 devices, 34 uclasses, devicetree: separate
> >> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s time=
out)
> >> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> >> Loading Environment from SPIFlash... SF: Detected w25q128jw with page
> >> size 256 Bytes, erase size 4 KiB, total 16 MiB
> >> OK
> >> In:    serial
> >> Out:   serial
> >> Err:   serial
> >> SEC0:  RNG instantiated
> >> Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000
> >> ...
> >>
> >>> The error -EPFNOSUPPORT is interesting and helps point to the only
> >>> place it can be where the comment says the strange errno is to make
> >>> this easier to find:
> >>> https://elixir.bootlin.com/u-boot/latest/source/drivers/core/uclass.c=
#L70:
> >>>           if (!uc_drv) {
> >>>                   debug("Cannot find uclass for id %d: please add the
> >>> UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> >>>                         id);
> >>>                   /*
> >>>                    * Use a strange error to make this case easier to =
find. When
> >>>                    * a uclass is not available it can prevent driver =
model from
> >>>                    * starting up and this failure is otherwise hard t=
o debug.
> >>>                    */
> >>>                   return -EPFNOSUPPORT;
> >>>           }
> >>>
> >>> I'm not very familiar with the dm driver binding - does the
> >>> U-BOOT_DRIVER usage in drivers/crypto/fsl/rng.c need to be refactored
> >>> to use UCLASS_DRIVER for it to be usable in both SPL and U-Boot?
> >>
> >> I don't think you need the CAAM RNG in SPL in the first place, or do y=
ou ?
> >>
> >>> Honestly I don't know why we need DM_RNG in SPL anyway and we could
> >>> just add support for disabling it there to avoid unwanted bloat.
> >>
> >> I think you can disable it , yes.
> >
> > Marek,
> >
> > Would it be advantageous for the kaslr-seed to be added automatically
> > from image_setup_libfdt?
>
> Yes, can you prepare a patch ? (I wanted to do this, just haven't had
> the time)
>
> > I notice arch/arm/cpu/armv8/fsl-layerscape/fdt.c:ft_cpu_setup does
> > this and board/raspberrypi/rpi/rpi.c looks like it copies kaslr-seed
> > from the control fdt which I assume was added by an earlier layer for
> > that target.
>
> Right, exactly, this .
>
> > I'm not clear if there is a disadvantage to automatically adding this
> > node if DM_RNG is enabled.
>
> I would say, add it.

Yes, I'll submit something this week.

Best Regards,

Tim
