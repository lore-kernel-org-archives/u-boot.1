Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149DBC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082AB882E8;
	Thu, 20 Jun 2024 13:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N0YjKVgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD548882E8; Thu, 20 Jun 2024 13:08:42 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AE6882AD
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 13:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c84a21b8cso682588e87.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718881719; x=1719486519; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gx1diNhKyWAjNCLB7+2Z0iSOH9Ctk3ubqT1X8mhOAI=;
 b=N0YjKVgfDw04hqENlf7fg+fTa6EpnZEpLNj1XgTvqbOdtAAW1Sx6B+kw/IObxfcelB
 zTU9xfclLNgo7Taz6FUS/6oaaoz5pFwYZYdOZYTgG1S9LjBWkNp6NcI1sZx+6LNKfElC
 zTjHDo24mGVXvl2/LlQLhr4xy51lHWc9lv8+bnh/s1py45nwO6LoH7dPDGo95wzt1h03
 RZCke8zKW+0qi+ts7+jH2/GhEaVmWctswwYFGu28YeuGWabEVPzZcUnm0qaICDgDJq2Q
 sbKFmjQSBJtPNZYOPNqQpkJTtFAF1Op6cvCH9JQLp1AhaHwTPtXHEPjSb8p7KwPHYFEl
 bd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718881719; x=1719486519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gx1diNhKyWAjNCLB7+2Z0iSOH9Ctk3ubqT1X8mhOAI=;
 b=gQoVDbGunPdQJ36BUCANPrbghVlsXRU7xu60gFcefh5YvgVTkj3S9fnq4A9zkHHFxL
 7tEO4dU9/HG5w7zShW8fZ1OL1nYbqKibNN5vxaZR3AedP2N4JFMY5L0fnkcqHUrZfJgV
 9TKNaNt4OEzaJJzUbl/FtMh/8WapfQgW115EhQBqpHLPJ0CCjp01kUGe7HTsjksOLdLq
 XSIrzUxJ6IZ12GCh8iltU9zKGcj81K6io4Nt2oEazBgzD6EelMDxxZIlVIuOEIxWbyIi
 lbHAtjfeSn7SNvB4/GVms9y4t0rx37zlJ2PUgkbQ7sDxiPXZLT5bZnTsKMUJ3KGcufCI
 0JQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXVlULlIWjpP5Gf/cjUQnrRVEzCxGAaH0q52ErwpG5EBK+bHgagJn2d9+tOXbuu86a9ffdKXZRN5/H8/ayuhJ4umNFUg==
X-Gm-Message-State: AOJu0YzP7JhZXUeRXsfsSBtcOSZBr3PVAHS7WQRNRnDwCKQkkfnUG0W1
 cUYpIboG8OEsIJp/pqplnLuNoRJMEtBRSOa+31XdYz4zZ40goAsQXZTDaxWKqAzKSmofCqMq2wz
 Pbw4jsPx1SGhFd3sGdK04GS/rpQY=
X-Google-Smtp-Source: AGHT+IHXAltcOLzsiCUdThqAC/CogGcbZiXDDkXvR5sT/5NjQua+x4f9LAwQT94u91XTv1iXbOLOrosBojawn/w/1I8=
X-Received: by 2002:a19:6457:0:b0:52c:8dc6:e40b with SMTP id
 2adb3069b0e04-52cca1b983amr1530574e87.4.1718881718579; Thu, 20 Jun 2024
 04:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
 <BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Thu, 20 Jun 2024 04:08:27 -0700
Message-ID: <CANV2PTPjYM1PO5QtwsLYAkTCnko2DqLL2yjfOgaZUvxUjxXr4A@mail.gmail.com>
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

Minda, can you test USB Host function on VisionFive2? I guess that it
is connected to the USB-C port. For the boards with JH7110 and not any
VL805 USB controller this Cadence USB is the only way to have host
USB. It is very much wanted to have host USB. Thanks! -E

On Sun, May 19, 2024 at 11:20=E2=80=AFPM Minda Chen <minda.chen@starfivetec=
h.com> wrote:
>
>
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: E Shattow <lucent@gmail.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B45=E6=9C=8820=E6=97=
=A5 13:06
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Minda Chen <minda.chen@starfivetech.com>
> > =E6=8A=84=E9=80=81: Marek Vasut <marex@denx.de>; Tom Rini <trini@konsul=
ko.com>; Roger
> > Quadros <rogerq@kernel.org>; Neil Armstrong <neil.armstrong@linaro.org>=
;
> > Alexey Romanov <avromanov@salutedevices.com>; Sumit Garg
> > <sumit.garg@linaro.org>; Mark Kettenis <kettenis@openbsd.org>; Nishanth
> > Menon <nm@ti.com>; Rick Chen <rick@andestech.com>; Leo Yu-Chi Liang
> > <ycliang@andestech.com>; u-boot@lists.denx.de; Heinrich Schuchardt
> > <xypron.glpk@gmx.de>; Simon Glass <sjg@chromium.org>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v1 0/7] Add Starfive JH7110 Cadence USB =
driver
> >
> > Hi, there is a compile warning. I don't know why.
> >
> > On Sat, May 4, 2024 at 8:04=E2=80=AFAM Minda Chen <minda.chen@starfivet=
ech.com>
> > wrote:
> > >
> > > Add Starfive JH7110 Cadence USB driver and related PHY driver.
> > > So the codes can be used in visionfive2 and milkv 7110 board.
> > >
> > > The driver is almost the same with kernel driver.
> > >
> > > patch1: Add set phy mode function in cdns3 core driver
> > >         which is used by Starfive.
> > >
> > > patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> > > patch4: Cadence USB wrapper driver.
> > > patch5-7 dts, config and maintainers update.
> > >
> > > Minda Chen (7):
> > >   usb: cdns3: Set USB PHY mode in cdns3_probe()
> > >   phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
> > >   phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
> > >   usb: cdns: starfive: Add cdns USB driver
> > >   configs: starfive: Add visionfive2 cadence USB configuration
> > >   dts: starfive: Add JH7110 Cadence USB dts node
> > >   MAINTAINERS: Update Starfive visionfive2 maintain files.
> > >
> > >  .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
> > >  arch/riscv/dts/jh7110.dtsi                    |  52 +++++
> > >  board/starfive/visionfive2/MAINTAINERS        |   2 +
> > >  configs/starfive_visionfive2_defconfig        |   9 +
> > >  drivers/phy/Kconfig                           |   1 +
> > >  drivers/phy/Makefile                          |   1 +
> > >  drivers/phy/starfive/Kconfig                  |  19 ++
> > >  drivers/phy/starfive/Makefile                 |   7 +
> > >  drivers/phy/starfive/phy-jh7110-pcie.c        | 211
> > ++++++++++++++++++
> > >  drivers/phy/starfive/phy-jh7110-usb2.c        | 135 +++++++++++
> > >  drivers/usb/cdns3/Kconfig                     |   7 +
> > >  drivers/usb/cdns3/Makefile                    |   2 +
> > >  drivers/usb/cdns3/cdns3-starfive.c            | 184 +++++++++++++++
> > >  drivers/usb/cdns3/core.c                      |  17 ++
> > >  14 files changed, 652 insertions(+)
> > >  create mode 100644 drivers/phy/starfive/Kconfig  create mode 100644
> > > drivers/phy/starfive/Makefile  create mode 100644
> > > drivers/phy/starfive/phy-jh7110-pcie.c
> > >  create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
> > >  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> > >
> > >
> > > base-commit: 174ac987655c888017c82df1883c0c2ea0dc2495
> > > --
> > > 2.17.1
> > >
> >
> > The compile warning as follows:
> >
> > In file included from
> > /home/user/source/u-boot.git/drivers/usb/cdns3/gadget.c:70:
> > /home/user/source/u-boot.git/include/linux/bitmap.h: In function
> > =E2=80=98bitmap_find_next_zero_area=E2=80=99:
> > /home/user/source/u-boot.git/include/linux/bitmap.h:170:17: warning:
> > implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=99; =
did you mean
> > =E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
> >   170 |         index =3D find_next_zero_bit(map, size, start);
> >       |                 ^~~~~~~~~~~~~~~~~~
> >       |                 find_next_bit
> >   CC      drivers/usb/cdns3/ep0.o
> > In file included from
> > /home/user/source/u-boot.git/include/linux/usb/composite.h:26,
> >                  from
> > /home/user/source/u-boot.git/drivers/usb/cdns3/ep0.c:19:
> > /home/user/source/u-boot.git/include/linux/bitmap.h: In function
> > =E2=80=98bitmap_find_next_zero_area=E2=80=99:
> > /home/user/source/u-boot.git/include/linux/bitmap.h:170:17: warning:
> > implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=99; =
did you mean
> > =E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
> >   170 |         index =3D find_next_zero_bit(map, size, start);
> >       |                 ^~~~~~~~~~~~~~~~~~
> >       |                 find_next_bit
> >
> >
> > Is this something missing in the patch series?
> >
> > -E
>
> I have not noticed this. I just check this it is risc-v code do not conta=
in "find_next_zero_bit" macro define.
