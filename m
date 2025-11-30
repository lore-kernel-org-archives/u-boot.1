Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604D9CFD376
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 07:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FDAF81D6A;
	Sun, 30 Nov 2025 08:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxva7OlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E96F38309A; Sun, 30 Nov 2025 08:28:06 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176E280FA1
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 08:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640a0812658so5564683a12.0
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 23:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764487683; x=1765092483; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+GjwC0vpifmMUSe+PXvtApaVhUsWgzNe2RQ1u/QCWI=;
 b=fxva7OlK4gSQSLUQVxFcH9cQThig3QuZis+IjfbpDFnGzHJJ9tXfwprVnC+lmS7lsJ
 hyl5Q8M0swcK3EzH4RyBLOMr78sC1OIMoXqpuA+W6ZLNWgL85Ht+Nj7PShQJPNep6nqO
 aJxlcWdJCMbv7gS3TC+772kFr9FGqOfKtMsMhXDsfuqbgjwvJ670kByK3iE0wOk+xlu6
 efOLwtuhwyAcNu5CDYd0qvy8NuJHFmtSWsTy8/c8r24UGcTEk2LutpcepG1xeGj8NKH5
 MjlU0q45LGFgwym/XjS7k+ztaGbKwtr8/Uh1nC/+rFAGbBMiEJWDlnNfK/Upj8KG3SDJ
 mIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764487683; x=1765092483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+GjwC0vpifmMUSe+PXvtApaVhUsWgzNe2RQ1u/QCWI=;
 b=AM22NlpgtY81HWNi0Goog/vqATr5l/ydaEL8wHDmVzXUNpQV3VNdK99oADMVeLMgoN
 U3fY6QvjnWlldUXKkiIbSJvVAvY11GQ2PXXKJK1rpGIq1K1m8hEPGcA9gElesPxx4RF1
 pQiwCNUaL+ZMUfrX8v6A16HUgPobaWZAdVb8TvQZ3j5V9C+t1IQJ/YVPUbM3ncVH/o7P
 7K1R2vIQMLK+cTfnGT+gJkvmeCh+bnMep6CdTct8CpA+8jUMndldFxfCgfBtTvTxpRoO
 hz0StoQbNFxX3Zz0NF6loIeWP1+clDqrpph+Fu6yZ5m1P+cpad02tgUf7vak0RiCCAi1
 45Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSVcwQA0YDJZ5HGmi9HfmvhJ9Zd1yUbX4MCQDQ2bBafFS2f8SnNLcuLQwGRjMQ06LhbGnF4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy05AtgIQblH72DXcqUDHGu5XySHKnuwDZJCIRpqqPtTnRnawK4
 EdP5r/JhdGmClOax6IaV0wB1BsRHVbWxQgAdxKaZ8n2dKhLilTbKpWAfabgnOPmchPF5wkuX+QE
 ytnU8DdfWLeHPgsCDOWZPhgqLlyL66+s=
X-Gm-Gg: ASbGncurjYrBnKT2o8lNtROI+mHLnsBs+i9lHaaHLj6oDcBZyrUn58XYW8uWKq4YJK8
 A2kE2+hBjVbHgiNbY4qZySAQcybPlUVceNiw93lvrvZXxkSXOg7ZC5z2vfqWa/jja+nNTgn9/ZO
 cuKKmmu9p26xnT9TKrRQJOdS1Qq3YF9LIQvTJ7uIq7nybxBzdUQtiEorJmif2LZDkiDaBAFgPKO
 7jSZB/+1pRHJgfI021PSMbCAO++Lx+Ii0rIuh3dKnxgu5C+jFJQFC0h2jIczhZe2NZmfA==
X-Google-Smtp-Source: AGHT+IEmI8moHhPROwfGwIQyvXQpUVysOq30B2DeUkAXWnOjsTuAWhuX9UhPNHx2e+CZ3mZ74FIK3gelXbBi2lVyuO8=
X-Received: by 2002:a05:6402:42c9:b0:640:be87:a858 with SMTP id
 4fb4d7f45d1cf-645eb2b5badmr20901682a12.27.1764487683234; Sat, 29 Nov 2025
 23:28:03 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
 <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
 <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
In-Reply-To: <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 30 Nov 2025 12:57:46 +0530
X-Gm-Features: AWmQ_bk81ybHctAgEC9Bg3QuzDa6qEynRzOyc6bCHbKbE9jGMF-pXQTplIqslBg
Message-ID: <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi FUKAUMI

On Sat, 29 Nov 2025 at 15:22, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> Hi Anand,
>
> On 11/29/25 16:25, Anand Moon wrote:
> > Hi FUKAUMI,
> >
> > On Sat, 29 Nov 2025 at 10:09, FUKAUMI Naoki <naoki@radxa.com> wrote:
> >>
> >> Hi Anand,
> >>
> >> On 11/28/25 14:50, Anand Moon wrote:
> >>> Hi Heinrich,
> >>>
> >>>>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
> >>>>>
> >>>>> But I am booting from SPI flash, so I cannot stop this board in the
> >>>>> U-Boot prompt.
> >>>>>
> >>>>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.b=
in image
> >>>>> in the user space to spi flash? using dd coammnd
> >>>>>
> >>>>>    From the schematics, it has W25Q64FWZPIG
> >>>>>
> >>>>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20=
181112.pdf
> >>>>>
> >>>>> I have tried to enable SPI flash, but it is not getting detected on
> >>>>> the board in userspace.
> >>>>
> >>>>
> >>>> https://wiki2.radxa.com/Rockpi4/dev/usb-install
> >>>> has some guidance how to avoid booting from SPI NOR flash.
> >>>>
> >>> Thanks for your tip.
> >>>
> >>> I've attempted this method, but it hasn't worked for me.
> >>> Could you provide the SPI details for this board so I can map it in d=
river code
> >>> and from userspace and then attempt to erase or reflash the image?
> >>>
> >>> on my board
> >>> [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> >>> [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff =
ff ff ff
> >>
> >> Are you using dts with "audio-supply =3D <&vcc_3v0>;"? It should fix S=
PI too.
> >>
> > Thanks for your tip.
> >
> > I have applied the patch from FUKAUMI, and now my console output has
> > started working
> >
> >> 1. Make u-boot-rockchip.bin with "audio-supply =3D <&vcc_3v0>;"
> >> 2. Write it to microSD card
> >> 3. Insert it
> >> 4. Kill SPI flash
> >> 5. Boot U-Boot from SD card
> >> 6. Revert 4.
> >> 7. Try "sf probe" "sf erase"
> >>
> > Yes, I have tried these steps (4 Kill SPI flash) ->
> > I have shortened the SPI1_CLK and GNG in the GPIO header
> > But this board first boots from SPI flash, I don't know the reason.
> >
> > I noticed your patch references the W25Q128.
> > Did you get this device detection in userspace?
> >
> > This output is from your patch.
> > =3D> led blue:status off
> > =3D> sf probe
> > SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total =
16 MiB
> > =3D> led blue:status on
> > =3D> sf probe
> > jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
> > Failed to initialize SPI flash at 1:0 (error -2)
> >
> > Could this explain why I=E2=80=99m unable to detect the device from use=
rspace?
>
> What happens if you lower the SPI clock?
> e.g.
>   spi-max-frequency =3D <10000000>;
>
Thanks for your input, but I have a bad old U-Boot in my SPI chip,
which blocks the UART. I need to erase the SPI chip externally
or erase the chip from user space.

> Best regards,
>
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
>
Thanks
-Anand
