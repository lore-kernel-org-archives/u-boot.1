Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C814C30653
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 01:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709EE8851C;
	Fri,  5 Jul 2024 03:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="meNpMdGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82D98896A; Fri,  5 Jul 2024 03:08:52 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634BB8851C
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 03:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e976208f8so1222326e87.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 18:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720141730; x=1720746530; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZAWddgumASFzxs07Zs9NNSACbEKSLzSK4hBMHEly4A=;
 b=meNpMdGIBy+LDYCnppUhJdVeJnksRJSgysjDUH5EFZK578waLe6Cg5Q6JKUv3qiFzk
 ST3PquDmbiZ1034Rly9DytVJW+gmtbciOZInSq+P1scMdf8F0hfoDTqYwIWSJANnYm/Q
 ePmL2FCbws+jxz2YgMT7lE2uopTBG8zl2g08dUrdJ7NYsyGPSh3p/UUTY8YwO8vu0S0I
 TOWp/K+HAx7zunmsviefcguKstssIFzcdkbVYBXLpycm8kXRe/JIwkXdRAUlLhW10d3T
 Xc5ELaI2Y8W0gfHrdHB68fD6qxYN+T96if/RGK6h4J2VYpI69lViFoEh5Jeho0GKJPb6
 bxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720141730; x=1720746530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZAWddgumASFzxs07Zs9NNSACbEKSLzSK4hBMHEly4A=;
 b=eeHlbQ/iQvQzV8Vo/s8JH7BrRroV5flv6p2fC4XB2nFPgdXTo56nU/a0I1liZrzyjt
 pluzo9UgoRSu1jDQZoBs921rksFZCeu9owIVI39L8TkaTqJUye63pmvEkwGQ6+F8jD8h
 Qqdql5FhyF8tTzOn/ZrEk0jiCu28ZqHvGH0nDu8YBuGO+7/flfU85bUt1pNGoEvQiMjz
 0aiQHUNsiEklkdrVuLqyhXo9ASNjv6KlTgowqZ0QvFOM+byo/UjoqKwrgxnjP/s8Xq4J
 dqulXpTifaeiOPNOno6stFqBmT7jwn4AFH4fq61ZTjuNzD1PbipEVWCOyrRgGQ7yMTEp
 XwSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWik/yW8UZp96Zr8xl0DcSjORB4IfePa/YCI1oiwmPZnG1xkuDlgf7cAFcX5MDclyjZGSdMDhNT3I0kPNTHZfGcklDN4g==
X-Gm-Message-State: AOJu0Yy2mV/Dh0FQ9Ar2j3fZl6XZUkDOU2tWQArdoNlR4Zrfa8+Hkqqy
 fvG978hmbnPSDUNJYrlzHzVQZeel1kQYBE4A3yKpXs6V7Ckch84hsw9atRlWvw6fNdxyxE50YyD
 WY7AJnV9bklUuTc0Vmw5hjHCjgBY=
X-Google-Smtp-Source: AGHT+IG9tews2HNFkOJ5ISWMidEGezpWnC+8Cibx/p9WmZWGTH6xkHdDrO2WJtPlOO8LAxApEbZBfy2ojGj5giNovF8=
X-Received: by 2002:a05:6512:3aa:b0:52c:a0b8:4dc0 with SMTP id
 2adb3069b0e04-52ea0639ec9mr2366715e87.28.1720141729353; Thu, 04 Jul 2024
 18:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <9067a38f-1ebe-40bc-821c-e1cbeb49a615@gmx.de>
In-Reply-To: <9067a38f-1ebe-40bc-821c-e1cbeb49a615@gmx.de>
From: E Shattow <lucent@gmail.com>
Date: Thu, 4 Jul 2024 18:08:38 -0700
Message-ID: <CANV2PTO68ZfZdHR8_n3ou+suVEZ3ZbW8q_yTufeTOFEY-HFw_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add Starfive JH7110 Cadence USB driver
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Roger Quadros <rogerq@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
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

On Thu, Jul 4, 2024 at 6:25=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>
> On 7/4/24 07:50, Minda Chen wrote:
> > Add Starfive JH7110 Cadence USB driver and related PHY driver.
> > So the codes can be used in visionfive2 and star64 7110 board.
> >
> > The driver is almost the same with kernel driver.
> >
> > Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
> > The code can work.
> >
> > - Star64 using USB 3.0 and USB 2.0 host must add below board dts settin=
g.
>
> Does this mean a future patch for spl_fdt_fixup_star64() is needed?

As said by Hal they will be introducing a patchset to OF_UPSTREAM the
JH7110 board support so we should pursue that first to get dts
upstream (Linux?) aligned with U-Boot.

>
> Did you also have a look at the USB on the Milk V Mars CM?

With Minda's advice for Star64 applied to
jh7110-starfive-visionfive-2.dtsi directly as a test on Milk-V Mars CM
Lite:

StarFive # usb info
1: Hub,  USB Revision 3.0
 - U-Boot XHCI Host Controller
 - Class: Hub
 - PacketSize: 512  Configurations: 1
 - Vendor: 0x0000  Product 0x0000 Version 1.0
   Configuration: 1
   - Interfaces: 1 Self Powered 0mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 1
     - Class Hub
     - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

>
> Best regards
>
> Heinrich
>
> >
> > 1. usb pin setting
> >       usb_pins: usb0-0 {
> >               driver-vbus-pin {
> >                       pinmux =3D <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
> >                                         GPOEN_ENABLE,
> >                                         GPI_NONE)>;
> >                       bias-disable;
> >                       input-disable;
> >                       input-schmitt-disable;
> >                       slew-rate =3D <0>;
> >               };
> >       };
> >
> > 2. related dts node setting.
> > &pcie0 {
> >       status =3D "disabled";
> > };
> >
> > &pciephy0 {
> >       starfive,sys-syscon =3D <&sys_syscon 0x18>;
> >       starfive,stg-syscon =3D <&stg_syscon 0x148 0x1f4>;
> >       status =3D "okay";
> > };

Question I have is:   Where is the documentation for these "magical"
numbers 0x18 00x148 0x1f4 ?  Is this a defined constant, or else where
is this in the Technical Reference Manual?

> >
> > &usb0 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&usb_pins>;
> >       status =3D "okay";
> > };
> >
> > &usb_cdns3 {
> >       phys =3D <&usbphy0>, <&pciephy0>;
> >       phy-names =3D "cdns3,usb2-phy", "cdns3,usb3-phy";
> >       dr_mode =3D "host";
> >       status =3D "okay";
> > };
> >
> > - previous version
> >    v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.=
19600-1-minda.chen@starfivetech.com/
> >
> > - patch description.
> >
> > patch1: Add set phy mode function in cdns3 core driver
> >          which is used by Starfive JH7110.
> > patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> > patch4: Cadence USB wrapper driver.
> > patch5: Add JH7110 USB default overcurrent pin.
> > patch6-8 dts, config and maintainers update.
> >
> > - change:
> >       v2:
> >       - patch 1 Move the added code to cdns3_core_init_role(). Must
> >         set PHY mode before calling cdns3 role start function.
> >       - patch 1-4 correct the code format.(follow Marek's comments.)
> >       - patch 2 Add set 125M clock in PHY init function.
> >       - Add new patch5.
> >
> > Minda Chen (8):
> >    usb: cdns3: Set USB PHY mode in cdns3_core_init_role()
> >    phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
> >    phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
> >    usb: cdns: starfive: Add cdns USB driver
> >    pinctrl: starfive: Setup USB default disable overcurrent pin
> >    configs: starfive: Add visionfive2 cadence USB configuration
> >    dts: starfive: Add JH7110 Cadence USB dts node
> >    MAINTAINERS: Update Starfive visionfive2 maintain files.
> >
> >   .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
> >   arch/riscv/dts/jh7110.dtsi                    |  52 +++++
> >   board/starfive/visionfive2/MAINTAINERS        |   2 +
> >   configs/starfive_visionfive2_defconfig        |   9 +
> >   drivers/phy/Kconfig                           |   1 +
> >   drivers/phy/Makefile                          |   1 +
> >   drivers/phy/starfive/Kconfig                  |  21 ++
> >   drivers/phy/starfive/Makefile                 |   7 +
> >   drivers/phy/starfive/phy-jh7110-pcie.c        | 202 +++++++++++++++++=
+
> >   drivers/phy/starfive/phy-jh7110-usb2.c        | 135 ++++++++++++
> >   drivers/pinctrl/starfive/pinctrl-jh7110-sys.c |  11 +-
> >   drivers/usb/cdns3/Kconfig                     |   7 +
> >   drivers/usb/cdns3/Makefile                    |   2 +
> >   drivers/usb/cdns3/cdns3-starfive.c            | 183 ++++++++++++++++
> >   drivers/usb/cdns3/core.c                      |  25 +++
> >   15 files changed, 661 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/phy/starfive/Kconfig
> >   create mode 100644 drivers/phy/starfive/Makefile
> >   create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
> >   create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
> >   create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> >
> >
> > base-commit: 8937bb265a7f2251c1bd999784a4ef10e9c6080d
>

Thanks very much Minda, I am happy to see some USB Host function on
Milk-V Mars CM Lite here.   -E Shattow
