Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3DCC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 13:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84072826AA;
	Mon,  9 Jun 2025 15:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="chPOOBIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B643782998; Mon,  9 Jun 2025 15:46:42 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF57811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 15:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e81826d5b72so4020835276.3
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749476799; x=1750081599;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHNtEv6GUHFHoLc/4f6bjebbun7rJWirlIrwg3vfsHM=;
 b=chPOOBIf/r2IprKv7+p7r+8K0Cpp9XqSYDGUkRzBO8bw1Zwo7nwD6U8Cv0u47Xembc
 3AlAErwf1vKZZWH+V95nOKJQOzZdsiv+39jgO18X09NTBvyALuJjEAGqgUcGXcy0g96j
 fg1pL3TfTxfsczTsxCYsidTIxzsSE6gK6gtCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749476799; x=1750081599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHNtEv6GUHFHoLc/4f6bjebbun7rJWirlIrwg3vfsHM=;
 b=sayBr7Zi6XuzA5eCkWhDM69+6SrLOlAvlHrouvVrkQ0VFyWVwIFTLwzMP31YMtqTFu
 TaDZHPairQCwifDk4l14lrv3+szr6s5uW5bV5Gj8FUpNDS8j88RDiWvOVX1gGqKht7Cq
 /Tbwt/IWqf5oldMYmKnPrp6xdHjI4VDB7a2A7dKAQmEhQaOXKPnhouQm0yv6ftE7h0f5
 8BpGAC6MHW63qKWr9Su+HDNMleK1a4pITgC0KRcaHg852xNqyehT6y8NXza/N0JqGjGw
 RoYJxENnVuJk/GxdYn4mr5T0VWwaBm814+TmPM/rsinEBAb9N89/NiJFxNDk9nxKTMGA
 RNfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8bPj9d70S4PUkAkoo2lZiGYBZ9VsQLhcgBaybJ3eds0MCJgl97ipb2Q4C3lUHtIqq3bL3neI=@lists.denx.de
X-Gm-Message-State: AOJu0YwGGFJNutiXmd5Tg7Hx7kSoL3Q8HEyF+KLyWH/WODcj7pVDddtF
 7xWPx3TpmN+MlVZ7+OJcvAxtfDj/nP//mKSbWGyn+WEYNNlPjYTNcCu8zFHgUdUfEzbwzDW4BvB
 4GPAA0gnvH7iK3mASuxrsjICEj1BbXhDoxKq92AzTsg==
X-Gm-Gg: ASbGncutNmZX7nQFBIgE/LJwCEdHhrsCEsrZThE74fLKp/jKTKz5UTrjzwhACj7uGmp
 qmDoAia10LfwZyRTY+1mB4fhJb8+z71nAtZ+OvnPV1dXcMN2xPSJw+zE6Vap141zuPJ9vEz3503
 b9g99KHYyJQNt56U/+0j+1hybtpugMkw==
X-Google-Smtp-Source: AGHT+IHAoO3T2+5L6fIqX4FaWxHP4DyUt4F6Vs/XbbVOKdWjzW6PaZeiOQ2b18yHJK6r94R35DXbjfS98oqZJh999UY=
X-Received: by 2002:a05:6902:e02:b0:e81:347a:2a9c with SMTP id
 3f1490d57ef6-e81a20d37e2mr18567465276.7.1749476799047; Mon, 09 Jun 2025
 06:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com> <aEbgxo0WUDPd-S8Z@sumit-X1>
In-Reply-To: <aEbgxo0WUDPd-S8Z@sumit-X1>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 9 Jun 2025 15:46:27 +0200
X-Gm-Features: AX0GCFtTDCAfN-0SAn9TfxclWY59BUCyNHLlf7ttWAVDH7HslvpIgrTjmtUK7ao
Message-ID: <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Support stm32h747-discovery board
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de, 
 linux-amarula@amarulasolutions.com, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
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

Hi Sumit,

On Mon, Jun 9, 2025 at 3:25=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> Hi Patrice,
>
> On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> >
> >
> > On 6/7/25 11:37, Dario Binacchi wrote:
> > > The series adds support for stm32h747-discovery board.
> > >
> > > Detailed information can be found at:
> > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > >
> > >
> > > Dario Binacchi (9):
> > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
> > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
> > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
> > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> > >   ARM: dts: stm32: support STM32h747i-disco board
> > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > >   board: stm32: add stm32h747-discovery board support
> >
> >
> > Hi Dario
> >
> > For the whole series
> > Applied to u-boot-stm32/next
>
> Please give some time for other maintainers to review this patch-set.
> The dts/upstream patches in this series aren't clean cherry pick from
> upstream.

All the commits are already in the mainline Linux kernel, specifically
in v6.16-rc1.
If you're referring to the fact that the patches can't be applied
cleanly, I believe it's
because the target path in the Linux kernel doesn't match the one in U-Boot=
.
In fact, the DTS files are located in two different relative paths.

Thanks and regards,
Dario

> This has to be fixed as otherwise random patches are going to
> cause DT sync issues.
>
> -Sumit
>
> >
> > Thanks
> > Patrice
> >
> > >
> > >  arch/arm/dts/stm32h747i-disco-u-boot.dtsi     | 104 ++++++++++++++
> > >  arch/arm/mach-stm32/stm32h7/Kconfig           |   4 +
> > >  board/st/stm32h747-disco/Kconfig              |  15 ++
> > >  board/st/stm32h747-disco/MAINTAINERS          |   7 +
> > >  board/st/stm32h747-disco/Makefile             |   6 +
> > >  board/st/stm32h747-disco/stm32h747-disco.c    |  42 ++++++
> > >  configs/stm32h747-disco_defconfig             |  35 +++++
> > >  drivers/clk/stm32/clk-stm32h7.c               |   5 +
> > >  dts/upstream/Bindings/arm/stm32/stm32.yaml    |   4 +
> > >  .../include/dt-bindings/clock/stm32h7-clks.h  |   4 +-
> > >  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  |  34 ++++-
> > >  dts/upstream/src/arm/st/stm32h743.dtsi        |   8 ++
> > >  dts/upstream/src/arm/st/stm32h743i-disco.dts  |   2 +-
> > >  dts/upstream/src/arm/st/stm32h743i-eval.dts   |   2 +-
> > >  dts/upstream/src/arm/st/stm32h747i-disco.dts  | 136 ++++++++++++++++=
++
> > >  dts/upstream/src/arm/st/stm32h750i-art-pi.dts |   6 +-
> > >  include/configs/stm32h747-disco.h             |  32 +++++
> > >  17 files changed, 435 insertions(+), 11 deletions(-)
> > >  create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
> > >  create mode 100644 board/st/stm32h747-disco/Kconfig
> > >  create mode 100644 board/st/stm32h747-disco/MAINTAINERS
> > >  create mode 100644 board/st/stm32h747-disco/Makefile
> > >  create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
> > >  create mode 100644 configs/stm32h747-disco_defconfig
> > >  create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
> > >  create mode 100644 include/configs/stm32h747-disco.h
> > >



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
