Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E7C2D0D0
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 05:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED1388204;
	Mon, 24 Jun 2024 07:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6JPuDZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563878819D; Mon, 24 Jun 2024 07:16:53 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD43588204
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 07:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so4595724e87.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719206209; x=1719811009; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbRWsN2lc2xr3LKp+ou6va6F/yNwWLiIeHASJwWbCyY=;
 b=X6JPuDZTiviWJkqf8ChJBbBzfYWxfchKbat2VZJt28RpsdFHR+WVfxhxexL9twpfCf
 YU9XOBgkvUamfzJcbrUixNvGSjYANviaWyVG6x0WptAmYwQeXNYP4r5VzjiCxwvgci7r
 VxBvND22O+eGiwMtA2sbtyU0C1spPEjZnFMzV++qDyZyldHLHazBR52WScAvXEyaAaC1
 YxS7lGQtZ8Khu8ldvIRK0tyxYQGehFnkPRQ/bfJ0nfBa8XnpR2d8wuFpAHypWc/m17Na
 mWNh6piSl377F6lKP8JyhS3jaAZd9lraxLjDIY7MB6LTx0cX7L/Q46t3VsIY+F6BFa4t
 niGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719206209; x=1719811009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbRWsN2lc2xr3LKp+ou6va6F/yNwWLiIeHASJwWbCyY=;
 b=tVrbe8CsSY5UUHp0SrMF/HQ/NtC1hh2eQAh/++Ht5fJ+YYD77KZTtJyWKT6pa2A3sr
 DFGHB4bcnU5BKEZIL1mwSryFp6RncmwHgw3eQCpveLBqIucq/RQY/yij7hOLvOVB3T+S
 og2mjuRhXoer5alot/1NxgxM3aCyHQa9uWlpWZ2gzk5a9oY9fr83t59we92Kgvz52Ecc
 OZMfRp8SyCw3JrQ0Y7bi+Q6986VENNJMBVv1ERP2RmrmClxHWZp/50Yq9MbjlNHnX3yi
 VRCrl7arpqAa5IqgU3aMbTQplohMr//0j6rE/k42i1qxuMKJhBrtQ7IwfrXcAyKOjFfs
 cQ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgaQO32hpw73Lr/9zVDaJDbBqrAqTJ7XDEIaXrZACzI7PH91qpEoXowtpSRXrGohFQ7DoXgDXo1w9OHfNZeRxnlTPLxQ==
X-Gm-Message-State: AOJu0Yzqc9DjSHEvhyLhdi8VN+HOJOPYWzdvRmWHNSKP09w1gRRj5nSx
 4F1Fu6zyGQshkWlvIdojhCI16Pd4duDWI/vjrdhvBTFu5EsdFqUXTEte8OaAnNiNWtc6ZL3WKVK
 ArnAyMu64ZQ8GlHyOokmO2oD2GJuVTgPY
X-Google-Smtp-Source: AGHT+IGMwC35X+aRCwtoeB/yvacsu8cD5qv+Vyj2uVBPy07lu6FrRRQPo41ixfcVgKqQpa2niHaklXFV+FXa7FMFfsY=
X-Received: by 2002:a05:6512:539:b0:52c:df3d:4e9d with SMTP id
 2adb3069b0e04-52ce061fecdmr3015511e87.37.1719206208927; Sun, 23 Jun 2024
 22:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
 <BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTPjYM1PO5QtwsLYAkTCnko2DqLL2yjfOgaZUvxUjxXr4A@mail.gmail.com>
 <SHXPR01MB0863E8C1D1CD4A5AF958AA85E6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SHXPR01MB0863E8C1D1CD4A5AF958AA85E6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Sun, 23 Jun 2024 22:16:37 -0700
Message-ID: <CANV2PTPjAEz1x7AJ=9D63pxRk4VmVb-qO+VWW5SOotE3aP0U9g@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add Starfive JH7110 Cadence USB driver
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

Hi,

On Sun, Jun 23, 2024 at 6:28=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
>
>
> >
> > Minda, can you test USB Host function on VisionFive2? I guess that it i=
s
> > connected to the USB-C port. For the boards with JH7110 and not any
> > VL805 USB controller this Cadence USB is the only way to have host USB.=
 It is
> > very much wanted to have host USB. Thanks! -E
> >
>
> In VF2, PCIe0 connect with VL805 USB 3.0 host controller. Now PCIe driver=
 have
> commit to Uboot upstream code. USB 3.0 can be used in uboot upstream code=
.
> Milk-v mars also connect VL805 and can use USB 3.0 host too.

No no I am asking about Cadence USB of JH7110 CPU. This VL805 is not
the question, sorry that my question was not easy to understand
before.

>
> You can use "pci e" command to active USB 3.0 host controller and then "u=
sb reset" to
> scan usb devices.  If you have any issue about this. Also reply it in thi=
s. Thanks.

Can you show that Host USB is functioning on VF2 with the JH7110 CPU
Cadence USB, not the VL805 controller?

This is needed so Milk-V Mars CM and Pine64 Star64 can have USB Host.
There is no use of VL805 and we need JH7110 Cadence USB then.

Thanks!

-E

>
> > On Sun, May 19, 2024 at 11:20=E2=80=AFPM Minda Chen <minda.chen@starfiv=
etech.com>
> > wrote:
> > >
> > >
> > >
> > > >
> > > > Hi, there is a compile warning. I don't know why.
> > > >
> > > > On Sat, May 4, 2024 at 8:04=E2=80=AFAM Minda Chen
> > > > <minda.chen@starfivetech.com>
> > > > wrote:
> > > > >
> > > > > Add Starfive JH7110 Cadence USB driver and related PHY driver.
> > > > > So the codes can be used in visionfive2 and milkv 7110 board.
> > > > >
> > > > > The driver is almost the same with kernel driver.
> > > > >
> > > > > patch1: Add set phy mode function in cdns3 core driver
> > > > >         which is used by Starfive.
> > > > >
> > > > > patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> > > > > patch4: Cadence USB wrapper driver.
> > > > > patch5-7 dts, config and maintainers update.
> > > > >
> > > > > Minda Chen (7):
> > > > >   usb: cdns3: Set USB PHY mode in cdns3_probe()
> > > > >   phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
> > > > >   phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
> > > > >   usb: cdns: starfive: Add cdns USB driver
> > > > >   configs: starfive: Add visionfive2 cadence USB configuration
> > > > >   dts: starfive: Add JH7110 Cadence USB dts node
> > > > >   MAINTAINERS: Update Starfive visionfive2 maintain files.
> > > > >
> > > > >  .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
> > > > >  arch/riscv/dts/jh7110.dtsi                    |  52 +++++
> > > > >  board/starfive/visionfive2/MAINTAINERS        |   2 +
> > > > >  configs/starfive_visionfive2_defconfig        |   9 +
> > > > >  drivers/phy/Kconfig                           |   1 +
> > > > >  drivers/phy/Makefile                          |   1 +
> > > > >  drivers/phy/starfive/Kconfig                  |  19 ++
> > > > >  drivers/phy/starfive/Makefile                 |   7 +
> > > > >  drivers/phy/starfive/phy-jh7110-pcie.c        | 211
> > > > ++++++++++++++++++
> > > > >  drivers/phy/starfive/phy-jh7110-usb2.c        | 135 +++++++++++
> > > > >  drivers/usb/cdns3/Kconfig                     |   7 +
> > > > >  drivers/usb/cdns3/Makefile                    |   2 +
> > > > >  drivers/usb/cdns3/cdns3-starfive.c            | 184
> > +++++++++++++++
> > > > >  drivers/usb/cdns3/core.c                      |  17 ++
> > > > >  14 files changed, 652 insertions(+)  create mode 100644
> > > > > drivers/phy/starfive/Kconfig  create mode 100644
> > > > > drivers/phy/starfive/Makefile  create mode 100644
> > > > > drivers/phy/starfive/phy-jh7110-pcie.c
> > > > >  create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
> > > > >  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> > > > >
> > > > >
> > > > > base-commit: 174ac987655c888017c82df1883c0c2ea0dc2495
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > > The compile warning as follows:
> > > >
> > > > In file included from
> > > > /home/user/source/u-boot.git/drivers/usb/cdns3/gadget.c:70:
> > > > /home/user/source/u-boot.git/include/linux/bitmap.h: In function
> > > > =E2=80=98bitmap_find_next_zero_area=E2=80=99:
> > > > /home/user/source/u-boot.git/include/linux/bitmap.h:170:17: warning=
:
> > > > implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=
=99; did you mean
> > > > =E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
> > > >   170 |         index =3D find_next_zero_bit(map, size, start);
> > > >       |                 ^~~~~~~~~~~~~~~~~~
> > > >       |                 find_next_bit
> > > >   CC      drivers/usb/cdns3/ep0.o
> > > > In file included from
> > > > /home/user/source/u-boot.git/include/linux/usb/composite.h:26,
> > > >                  from
> > > > /home/user/source/u-boot.git/drivers/usb/cdns3/ep0.c:19:
> > > > /home/user/source/u-boot.git/include/linux/bitmap.h: In function
> > > > =E2=80=98bitmap_find_next_zero_area=E2=80=99:
> > > > /home/user/source/u-boot.git/include/linux/bitmap.h:170:17: warning=
:
> > > > implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=
=99; did you mean
> > > > =E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
> > > >   170 |         index =3D find_next_zero_bit(map, size, start);
> > > >       |                 ^~~~~~~~~~~~~~~~~~
> > > >       |                 find_next_bit
> > > >
> > > >
> > > > Is this something missing in the patch series?
> > > >
> > > > -E
> > >
> > > I have not noticed this. I just check this it is risc-v code do not c=
ontain
> > "find_next_zero_bit" macro define.
