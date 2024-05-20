Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67CBC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 05:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E027A882B7;
	Mon, 20 May 2024 07:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BfEvTrzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212F488303; Mon, 20 May 2024 07:06:26 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF10882BE
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 07:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4df7cb5894fso765681e0c.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716181583; x=1716786383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m72pFFiVBRjDRX8/Da3a9izuMmNGh3OqJjf4uiy9ytE=;
 b=BfEvTrzr25aoE5AR7fX0mEZErJw7kJvFNvfROvD/hSFfBQO8uGPzxq9pVpehs447HW
 WySptjBWiG3HzuUOlSNoVhthlUcjUtyDiEIAtXWqn/7JZEip3zi/O2oJqMSiZh2En0/l
 CpeChJ7OnuMhAw78GcQ0N4p913BJ/wy5exFRzflZr4Q+G5RoDMMalg5U449JE4C7+Rb1
 cngppWzMdbuqTEdc6zefQICKwwHuA8x1sCp6VMI1EQkUC9S96YSfGhwH+JM1IztrnMYy
 MVKXku6/f9T78oFFYs6/N3nDe92mSNPRyNcxyrt8Hnj5MtYvc3Nr3KkIDIZGuifoIOv5
 kz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716181583; x=1716786383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m72pFFiVBRjDRX8/Da3a9izuMmNGh3OqJjf4uiy9ytE=;
 b=dgTeW35XwA+Fg3p8wXa4m4qRKPX58f/h2//HlI/Vbg/Kse/kmZA/j3xyI1NHN7u9wF
 8uH6kAWtVd7uY2frZ+5nYVlinlfGz5xYvR5mWJJdrScX50+cUZ4bhl1dkXnkHpK/bca9
 WGS1BVw14PsajNeMhsUKvKJReS3WikCSsWwhIRNgst1r03rUpTO/Z17dILT7HAjnJAsD
 uOkgwe48Ds0ozG4e4tWGw3ZnhSEW5aSmvKg8SsTIOlQhHI5qnBuXTikXrbctJthEQ560
 L38AFwMxdYYfCVqhHMa5RSm6OubMme+nOi5oH+GRPvKF2XwVjFmdKUKgAMnryKMsUsee
 NKDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrI/wZ5fdLolxGHbcBoH5VZP9BtxM9FAIJp4md3Z3Bl/QRmKkmuvvTct/ZcDFWejSHAXf58bopkA2o97Bi+h822Pm/5Q==
X-Gm-Message-State: AOJu0YxGhgTc9VfjC/KZ7MV6XKuqJBs563FQCZJzi/2s499uY9YIZ+7H
 dUzDKqnyIXq3gJOaeSWd55SnUeLa1zw0ULn11y8aeUCZzphFHDZeiezMEI2q2+xM6TchU3OB67v
 r5NQ6rI3D4BytQ4t4SQpOZ9v+4M0=
X-Google-Smtp-Source: AGHT+IEScQdYwivjh2lEVPhNYDI9U3s9FiBSibmaMR6EFub7We6Vv2MyIjJ5zHtSJ/hwaAWIw+gPlwFWjYWuuWd3eOI=
X-Received: by 2002:a05:6122:1696:b0:4d3:31fc:4839 with SMTP id
 71dfb90a1353d-4df88280108mr23027019e0c.2.1716181582671; Sun, 19 May 2024
 22:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 19 May 2024 22:06:11 -0700
Message-ID: <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add Starfive JH7110 Cadence USB driver
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 u-boot@lists.denx.de, 
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

Hi, there is a compile warning. I don't know why.

On Sat, May 4, 2024 at 8:04=E2=80=AFAM Minda Chen <minda.chen@starfivetech.=
com> wrote:
>
> Add Starfive JH7110 Cadence USB driver and related PHY driver.
> So the codes can be used in visionfive2 and milkv 7110 board.
>
> The driver is almost the same with kernel driver.
>
> patch1: Add set phy mode function in cdns3 core driver
>         which is used by Starfive.
>
> patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> patch4: Cadence USB wrapper driver.
> patch5-7 dts, config and maintainers update.
>
> Minda Chen (7):
>   usb: cdns3: Set USB PHY mode in cdns3_probe()
>   phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
>   phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
>   usb: cdns: starfive: Add cdns USB driver
>   configs: starfive: Add visionfive2 cadence USB configuration
>   dts: starfive: Add JH7110 Cadence USB dts node
>   MAINTAINERS: Update Starfive visionfive2 maintain files.
>
>  .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
>  arch/riscv/dts/jh7110.dtsi                    |  52 +++++
>  board/starfive/visionfive2/MAINTAINERS        |   2 +
>  configs/starfive_visionfive2_defconfig        |   9 +
>  drivers/phy/Kconfig                           |   1 +
>  drivers/phy/Makefile                          |   1 +
>  drivers/phy/starfive/Kconfig                  |  19 ++
>  drivers/phy/starfive/Makefile                 |   7 +
>  drivers/phy/starfive/phy-jh7110-pcie.c        | 211 ++++++++++++++++++
>  drivers/phy/starfive/phy-jh7110-usb2.c        | 135 +++++++++++
>  drivers/usb/cdns3/Kconfig                     |   7 +
>  drivers/usb/cdns3/Makefile                    |   2 +
>  drivers/usb/cdns3/cdns3-starfive.c            | 184 +++++++++++++++
>  drivers/usb/cdns3/core.c                      |  17 ++
>  14 files changed, 652 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile
>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>
>
> base-commit: 174ac987655c888017c82df1883c0c2ea0dc2495
> --
> 2.17.1
>

The compile warning as follows:

In file included from
/home/user/source/u-boot.git/drivers/usb/cdns3/gadget.c:70:
/home/user/source/u-boot.git/include/linux/bitmap.h: In function
=E2=80=98bitmap_find_next_zero_area=E2=80=99:
/home/user/source/u-boot.git/include/linux/bitmap.h:170:17: warning:
implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=99; did =
you mean
=E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
  170 |         index =3D find_next_zero_bit(map, size, start);
      |                 ^~~~~~~~~~~~~~~~~~
      |                 find_next_bit
  CC      drivers/usb/cdns3/ep0.o
In file included from
/home/user/source/u-boot.git/include/linux/usb/composite.h:26,
                 from /home/user/source/u-boot.git/drivers/usb/cdns3/ep0.c:=
19:
/home/user/source/u-boot.git/include/linux/bitmap.h: In function
=E2=80=98bitmap_find_next_zero_area=E2=80=99:
/home/user/source/u-boot.git/include/linux/bitmap.h:170:17: warning:
implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=99; did =
you mean
=E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
  170 |         index =3D find_next_zero_bit(map, size, start);
      |                 ^~~~~~~~~~~~~~~~~~
      |                 find_next_bit


Is this something missing in the patch series?

-E
