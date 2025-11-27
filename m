Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAACCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 18:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73AB844AF;
	Thu, 27 Nov 2025 19:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVrB6Zr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67601844AF; Thu, 27 Nov 2025 19:25:46 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A1983B49
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 19:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64198771a9bso2193778a12.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764267943; x=1764872743; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAPF9+DkqGTQnyRMaVIJx7ywmec0Zc4AHlkXHVJCdnI=;
 b=fVrB6Zr6A1QhC10X/cPLlp16XVTdeJEa+h6jjKGvlyhzJQuM1BUNFCuzA+kAiBjZ+t
 LSOOCTEzEmY3eeX2xCZSXhphMeyOvJ+OR0k+SRnJpefcCkj28FQDLXX6KoUYsAd/cjur
 sUYb1HlzMdB9OcE7akavNIpZX1e8KZVqCIKeoR8RZBjDBr4b4Gp+hBvoDoN/FwhmEKxS
 snajsM3MMTuwALaMqvSmFA5LeXvKDofdpwXm9HNi01Et+1BfTEhXsLIEUWwXj6SmMD3a
 cyRbEf+l3M3zudTr3oXDclZIaWUCek7sdasGWzi7q20wEzzVEOM9WGK39Q8ADpB+d/zd
 9VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764267943; x=1764872743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rAPF9+DkqGTQnyRMaVIJx7ywmec0Zc4AHlkXHVJCdnI=;
 b=w8GY5rszc2AuX2rs30+sC5gTsrvQ3YnXbMVoHl6LV93zFk6QczbaPk9dxfxm2C4cBt
 v5OHPvY5eGfctrxCHT3tdBPpjAblVh20L9r6wk31glWrS9YppeUYW0VsmwIkHfq0S0zA
 h/xyBmCgQOA1cNI7Ig41m5Z5BAOXZgvEqlgDKi/S9NIjuITWSzaQ47fxv7MCwec5Fk/v
 1EzzX6EsHxQS9RLMMR1RRA5XBqqSvhUFeSoCCxrFMxDU8uFzr9Vlrag8l5ZQVmmbpFt0
 KCtYAZS7Q6k5Gda+fLcz6vEK+r+pbVKcJC3+lMktI9f5F0gO/9cAQSxqcHqaRp4rW3Qq
 t5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDra2AqJ9fHh0tnKU4GO2HjWpUMkeyy0WEZfsJ77OImV5elQI10XzRxyXg+pvDxDZNrbSNOFg=@lists.denx.de
X-Gm-Message-State: AOJu0YwRV09mKKRScepA2F+MxL47roERAPV1k3TbdxEO2R69ZZwTGduU
 t713TJpzBXQYofe8p+ZgUzQsm8bIir4b9LQhl+wTeIwxTWsJNzuUfYxkDRl/783u8QY5m2F8luV
 VG3Rn2+G0Y/TfEKJicUeKJoqKXVF9GIo=
X-Gm-Gg: ASbGncu6e+WubVEtJIFLPG52Z1xxaLV50hdMOzLf+TfrFzfrA9VKXCbY9fhHhP4k79k
 epqrw6v7txulnB+FvHpveOmhI0Ynd8Cq79MXSfNdh6usxWnYEBtyGfp47Nl4j45F8wiumzVFDOJ
 8JMUMk9b/njINlP8J6ViL67i9KbESZIimTNz+otIrQLztVQRMr9J4SP241LP/pMjZAxzEAPxdyx
 mQeL17RUBmxln05bhN8vnqjyBCUKqHLvPOR1hDweZfY6uT4AwsWuTvigSgoQcgSsenHRg==
X-Google-Smtp-Source: AGHT+IHInovcDvdu7/T20AL2oAORxu1PNrbubBZ7WrQJ8eVP45oc+8Xia0xuln1M9D+vXs5j7Rev4caajN/cJVq67VE=
X-Received: by 2002:a05:6402:4056:20b0:645:d3bc:bb26 with SMTP id
 4fb4d7f45d1cf-645d3bcbb7emr12338702a12.13.1764267943264; Thu, 27 Nov 2025
 10:25:43 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <007d72bd-89a6-41d3-8d48-88d2e145364a@cherry.de>
In-Reply-To: <007d72bd-89a6-41d3-8d48-88d2e145364a@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 27 Nov 2025 23:55:25 +0530
X-Gm-Features: AWmQ_blHth-mwJT1cH568Y1wB8DKYuScK2p6589BBgQE13l-6CVt-XWS0rIe07Y
Message-ID: <CANAwSgTBTiw6Zxbd36f_xOE2Gxsc4JuuDBkBQ_7bjhUR9WcwjQ@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heiko Stuebner <heiko@sntech.de>
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

Hi Quentin,

Thanks for your input

> > Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
> >
> > But I am booting from SPI flash, so I cannot stop this board in the
> > U-Boot prompt.
> >
>
> Not sure why booting from SPI flash means you cannot stop the board in
> U-Boot?
>
The board stop at

U-Boot SPL 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
Trying to boot from MMC1
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
load_simple_fit: Skip load 'atf-5': image size is 0!


U-Boot 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)

SoC: Rockchip rk3399
Reset cause: POR
Model: Radxa ROCK Pi 4A
DRAM:  4 GiB (total 3.9 GiB)
PMIC:  RK808

Here, I cannot enter into U-Boot prompt.

> > Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin i=
mage
> > in the user space to spi flash? using dd coammnd
>
> flashcp u-boot-rockchip-spi.bin /dev/mtdX
>
Thanks, I will give this a try. Once I get the SPI flash detected
> I believe?
>
> >
> >  From the schematics, it has W25Q64FWZPIG
> >
> > [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_201811=
12.pdf
> >
> > I have tried to enable SPI flash, but it is not getting detected on
> > the board in userspace.
>
> Are you sure you have the driver for the SPI controller, MTD,
> MTD_SPI_NOR, ... available?
>
Yes, it's enabled, but it's not getting detected in userspace.

[    0.997896] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
[    0.999656] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff =
ff
[    1.000975] mmcblk0rpmb: mmc0:0001 SLD64G 4.00 MiB, chardev (240:0)

Datasheet for the Winbond W25Q64FW SPI flash
[1] https://www.winbond.com/resource-files/w25q64fw%20revn%2005182017%20sfd=
p.pdf

Should we add a dedicated entry for the W25Q64FW in the driver=E2=80=99s de=
vice
table to ensure the flash is properly recognised?

> You can check from a running system by looking at /proc/config or
> /proc/config.gz
>
> (you can grep in config.gz with zgrep)
>
> >
> > $ git diff arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> > b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> > index 9c741d1a3047..d18b59ddaa1d 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> > @@ -42,6 +42,16 @@ &sound {
> >          hp-det-gpios =3D <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> >   };
> >
> > +&spi1 {
> > +       status =3D "okay";
> > +
> > +       flash@0 {
> > +               compatible =3D "winbond,w25q64", "jedec,spi-nor";
> > +               reg =3D <0>;
> > +               spi-max-frequency =3D <108000000>;
> > +       };
> > +};
> > +
> >   &uart0 {
> >          status =3D "okay";
> >
> > Can you share some input on how to resolve this issue?
> >
>
> Looks ok to me.
>
> Cheers,
> Quentin

Thanks
-Anand
