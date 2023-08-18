Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46AFC71149
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 13:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B42386E38;
	Fri, 18 Aug 2023 15:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dawes-za-net.20221208.gappssmtp.com header.i=@dawes-za-net.20221208.gappssmtp.com header.b="UwUkPFzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35CA86E38; Fri, 18 Aug 2023 15:45:34 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EC986E3A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 15:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c8c44053e8so498216fac.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dawes-za-net.20221208.gappssmtp.com; s=20221208; t=1692366330; x=1692971130; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDs83L8oXaD4RnN8xCcC6ysXIayt5w8YK1MyM/x1k9w=;
 b=UwUkPFzIQdgixwmklNNSrMIj8ftsAWRbhEgPim75kJdGKrW9AFTkFTqQ4li+HdSbdU
 zJeaN/07no2TPFAOncYJTyD8yhy3trX75Z9kpfLvw3c2715TyEDZ4sox1BKDwWsVeMJ4
 xvwfQ+XsMXDgK5dkd6x/mVc54kBq2YQEoHhGuF+4MLY4pNlfYfV/Vqw9fiJWMe1z2hSj
 b3cZzbUSr2rojMAzu01EBJO3GutGi+kQY2abP7MGo+NqL+REWainmNRjLZhtJfHQxIvE
 +s44BUot1SuWmuh4+mAU0mKacge8uGOMT1wMr/K7NSmIj/ijA5IaKjlnZuyr+rsW6Y5s
 UkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692366330; x=1692971130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDs83L8oXaD4RnN8xCcC6ysXIayt5w8YK1MyM/x1k9w=;
 b=ZVEKqc3MtS0H3PfYo+A8eE14xr7Qhcd+RU1MmW6dabmggjwDLLX3Mn9ZTzx3ohV5M4
 OjMbxzWaNi+HXIjCZpLp0VTyFi9oGL8+/IstGNKygrNC6p3XXTbsWdZ+7sN/m/zposcN
 Qq3lrqaWSmVHxrWVi1KUMf55gWfRbAlzNBSY7Lq3C43pZfweRDytiOOrXysMdOpjDm2J
 ayTpXa3/Qr/3DQ2gkO+kU9nSq42aS7gfHyZhu7esLu52/W8iJ4SpYG4fRjF2dTTDM/z6
 bTs52a4rTbW98PlDE7dcfP/jmo4LAYx+JXmM+tjcM4iaZ7GkJfvpidn7xhlMfbYDhwJx
 8zHg==
X-Gm-Message-State: AOJu0Yw6bveRUVEFpr+ZqemSwnBr8uGIc+WLaYhf/NF+oCAGysQOdzhp
 Dzu5BBO8DEjsdb4aOzSrmsUNjDw/QwZYGyj0Xxs=
X-Google-Smtp-Source: AGHT+IHB9LulyOMUjf+nl7Oi3wP/suA/++43sFg96dO6Wb8U1PynWMRWEGl11O+IIGSBmTuKntIgexE2pgLhGFo4dO4=
X-Received: by 2002:a05:6870:330a:b0:1bb:b392:3b97 with SMTP id
 x10-20020a056870330a00b001bbb3923b97mr1796906oae.6.1692366330334; Fri, 18 Aug
 2023 06:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
In-Reply-To: <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Fri, 18 Aug 2023 15:45:19 +0200
Message-ID: <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
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

Circling back to this, I wanted to get a modern u-boot running on the
Wink Hub v1 as well. Since it is possible to invoke SDP over USB
(having soldered on a suitable microUSB connector), I have no concern
about bricking it now. It's also a LOT easier than JTAG!

I tried to build and flash the mx28evk_defconfig, but failed to get
any output on the serial console. This is likely to be unsurprising,
due to the already established alternative configuration of the UART
identified by Fabio.

I then patched imx28.dtsi to add duart_pins_c as per Fabio's previous
patch for the Linux kernel:

+ duart_pins_c: duart@2 {
+ reg =3D <2>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_I2C0_SCL__DUART_RX
+ MX28_PAD_I2C0_SDA__DUART_TX
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_8mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+

And updated mx28evk_defconfig to use duart_pins_c instead of
duart_pins_a. However, I still got no output after using:

sudo $(which snagrecover) --soc imx28 -f
src/snagrecover/templates/imx28-evk.yaml

with u-boot.sb in the current directory.

I also tried using the complete imx28-wink-hub-v1.dts as created by
Fabio, and updated the .config to reference that instead of the
imx28-evk, but I suspect that I may not have made the updates
sufficiently well, if the name of the board needs to correspond with
any details of the device tree? Neither of these resulted in any
output.

Any other suggestions?

Regards,

Rogan Dawes

On Fri, 23 Jun 2023 at 03:25, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rogan,
>
> On Thu, Jun 22, 2023 at 10:03=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Hi Rogan,
> >
> > On Thu, Jun 22, 2023 at 7:43=E2=80=AFPM Fabio Estevam <festevam@gmail.c=
om> wrote:
> >
> > > You should also pass the kernel command line: console=3DttyAMA0,11520=
0n8
> > >
> > > As far as I recall, the 2.6.35 kernel used a different console device=
.
> >
> > Yes, 2.6.35  uses ttyAM0. Mainline uses ttyAMA0 (note the extra A).
> >
> > Please adjust it accordingly.
>
> Also, I validated booting a uImage on a imx28-evk using the same procedur=
e.
>
> I used kernel 6.1.34.
>
> $ grep DTB .config
> CONFIG_ARM_APPENDED_DTB=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
> # CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
>
> =3D> setenv bootargs 'console=3DttyAMA0,115200 root=3D/dev/mmcblk0p3 rw r=
ootwait'
> =3D> print loadaddr
> loadaddr=3D0x42000000
> =3D> load mmc 0:2 $loadaddr uImage_with_dtb
> 5916489 bytes read in 1778 ms (3.2 MiB/s)
> =3D> bootm
> ## Booting kernel from Legacy Image at 42000000 ...
>    Image Name:
>    Created:      2023-06-23   1:17:21 UTC
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    5916425 Bytes =3D 5.6 MiB
>    Load Address: 40008000
>    Entry Point:  40008000
>    Verifying Checksum ... OK
>    Loading Kernel Image
>
> Starting kernel ...
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.1.34-00030-ga03745a375fa-dirty
> (fabio@fabio-Precision-3551) (arm-linux-gnueabihf-gcc (Ubuntu
> 11.3.0-1ubuntu1~22.04.1) 11.3.0, GNU ld (GNU Binutils for Ubuntu)
> 2.38) #31 Thu Jun 22 22:12:44 -03 2023
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D000=
5317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] OF: fdt: Machine model: Freescale i.MX28 Evaluation Kit
> ...
>
> Most likely the ttyAMA0 change should allow you to boot.
>
> Cheers
