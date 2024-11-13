Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45349D41C16
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 08:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C070D88E2B;
	Wed, 13 Nov 2024 09:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="i/AcNizf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C9E288EEA; Wed, 13 Nov 2024 09:26:52 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE90B889E9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ea0b25695dso55544057b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1731486408; x=1732091208;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NP7CBd+nU1gF8efBRSzci/LUQgrKU88uKP6qTTQdVTc=;
 b=i/AcNizf/uCMdXov1kXcXJ0tLtK2BmMHhZSIZJhOA4CxH/AHgaNdbBiKNpbs7gTGuc
 Qlo4OcWhjpRn/taSbm3q3z1ZZ9j/3n7LbzMnDdMcSCoDwxJy+ddya2DmUC6Aae83aDxp
 mQaiYebDDG3TO9aiDkzx4rQStfBBoR8eyG7ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731486408; x=1732091208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NP7CBd+nU1gF8efBRSzci/LUQgrKU88uKP6qTTQdVTc=;
 b=WEOUsSR/0lzrN56y2YQbVwmACfOxY72Sf7rOoP/Nl5L/HICUuUzmlVut7Zw0uyAz+O
 tGCYERymCFqsjVaqsP616Qh0PWbY5dhb57JYYttCAuZK3bZmFa1aPX7OwbqvZ7jVJuVc
 tAFWADiJNmFbd007bfDie4GVwLvWqcasU2x/ZCgb+S/DTupcgu/x5nbq+xjklzgYpn+T
 M+LSX0Hkhmsx/X1FQNNMBBQqdKYxzL29t+DD1sHYmcWDbupmZpjxxB97jPLa1rJD6XaC
 OlFcz08l0xFp/jVOkW5g5o+Bt8SIHK3B6+5SyVfs1Z4XQNzSOtQnJ0pOGd7IrxHE2gz8
 K0HA==
X-Gm-Message-State: AOJu0Yy3wxgyyFByIiuLjwp2KuwRbYImcvO/Xcf4SnpdyINOV1x4AOgR
 Wy4/STdiPlZwA02IvaZiHHefGfEtptZso7eOF8w+3tZmMmgj5L6blu0zxsYUYWvIUnBC1JYrFir
 kiCSr9lv/WFCO0RfLD+wsqWFWqiCgCRhxAV8piEzHupefrdiz
X-Google-Smtp-Source: AGHT+IFwRrWZIL6O0w1iH6v+RNr/kExLtu6B+lbirTKbO34yAeIhiJa6ocI76toZDz5FBTJ5/ZuK5PoC/fYiQ3jue48=
X-Received: by 2002:a05:690c:9b10:b0:6d7:f32:735b with SMTP id
 00721157ae682-6eadde3dacamr181602337b3.27.1731486408564; Wed, 13 Nov 2024
 00:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20241113062715.2872-1-dregan@broadcom.com>
In-Reply-To: <20241113062715.2872-1-dregan@broadcom.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 13 Nov 2024 09:26:36 +0100
Message-ID: <CAOf5uwnSmg_+GuEFk8UXMNmDz1CfjPnFBD2Tf1hoENuJ7O8M0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Broadcom BCMBCA nand updates
To: david regan <dregan@broadcom.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kamal Dasu <kamal.dasu@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 dregan@mail.com
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

HI

On Wed, Nov 13, 2024 at 7:27=E2=80=AFAM david regan <dregan@broadcom.com> w=
rote:
>
> These are ports of upstream Linux patches to U-Boot.
>
> Remove device specific nand driver files as they are now replaced
> by a common driver bcmbca_nand.c
>
> Make use of OF_UPSTREAM which uses Linux dts.
>
> Implement a minimal set of defconfig options to enable basic NAND
> functionality. Tested on:
> 47622
> 63146
> 63158
> 63178
> 6813
>
> Set parameter_page_big_endian to zero for bcmbca.
>
> Update log level messages so that more critical messages can be logged
> to console and help the troubleshooting with field devices.
>
> https://lore.kernel.org/linux-mtd/20240223034758.13753-4-william.zhang@br=
oadcom.com/
>

I get all the review I need so I will send on CI today and send on
next merge request

Michael

> ---
>
> Changes in v2:
> - Set parameter_page_big_endian to zero for bcmbca instead of
>   using an extra bit of endian translation code.
>
> david regan (4):
>   mtd: nand: brcmnand: remove device specific nand driver files
>   arm: dts: Use upstream dts
>   mtd: rawnand: brcmnand: Default bcmbca parameter_page_big_endian to
>     zero
>   mtd: rawnand: brcmnand: update log level messages
>
>  arch/arm/dts/bcm47622.dtsi                    | 126 --------
>  arch/arm/dts/bcm4912.dtsi                     | 128 --------
>  arch/arm/dts/bcm63146.dtsi                    | 110 -------
>  arch/arm/dts/bcm63158.dtsi                    | 278 ------------------
>  arch/arm/dts/bcm63178.dtsi                    | 120 --------
>  arch/arm/dts/bcm6756.dtsi                     | 130 --------
>  arch/arm/dts/bcm6813.dtsi                     | 128 --------
>  arch/arm/dts/bcm6855.dtsi                     | 257 ----------------
>  arch/arm/dts/bcm6856.dtsi                     | 253 ----------------
>  arch/arm/dts/bcm6858.dtsi                     | 272 -----------------
>  arch/arm/dts/bcm6878.dtsi                     | 111 -------
>  arch/arm/dts/bcm947622.dts                    |  30 --
>  arch/arm/dts/bcm94912.dts                     |  30 --
>  arch/arm/dts/bcm963146.dts                    |  30 --
>  arch/arm/dts/bcm963158.dts                    |  30 --
>  arch/arm/dts/bcm963178.dts                    |  30 --
>  arch/arm/dts/bcm96756.dts                     |  30 --
>  arch/arm/dts/bcm96813.dts                     |  30 --
>  arch/arm/dts/bcm96855.dts                     |  30 --
>  arch/arm/dts/bcm96856.dts                     |  30 --
>  arch/arm/dts/bcm96858.dts                     |  30 --
>  arch/arm/dts/bcm96878.dts                     |  30 --
>  arch/arm/mach-bcmbca/bcm47622/Kconfig         |   1 +
>  arch/arm/mach-bcmbca/bcm4912/Kconfig          |   1 +
>  arch/arm/mach-bcmbca/bcm63146/Kconfig         |   1 +
>  arch/arm/mach-bcmbca/bcm63158/Kconfig         |   1 +
>  arch/arm/mach-bcmbca/bcm63178/Kconfig         |   1 +
>  arch/arm/mach-bcmbca/bcm6756/Kconfig          |   1 +
>  arch/arm/mach-bcmbca/bcm6813/Kconfig          |   1 +
>  arch/arm/mach-bcmbca/bcm6855/Kconfig          |   1 +
>  arch/arm/mach-bcmbca/bcm6856/Kconfig          |   1 +
>  arch/arm/mach-bcmbca/bcm6858/Kconfig          |   1 +
>  arch/arm/mach-bcmbca/bcm6878/Kconfig          |   1 +
>  configs/bcm947622_defconfig                   |  11 +-
>  configs/bcm94912_defconfig                    |  11 +-
>  configs/bcm963146_defconfig                   |  11 +-
>  configs/bcm963158_defconfig                   |  11 +-
>  configs/bcm963178_defconfig                   |  11 +-
>  configs/bcm96756_defconfig                    |  11 +-
>  configs/bcm96813_defconfig                    |  11 +-
>  configs/bcm96855_defconfig                    |  11 +-
>  configs/bcm96856_defconfig                    |  11 +-
>  configs/bcm96858_defconfig                    |  11 +-
>  configs/bcm96878_defconfig                    |  11 +-
>  drivers/mtd/nand/raw/Kconfig                  |  24 --
>  drivers/mtd/nand/raw/brcmnand/Makefile        |   4 -
>  drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c | 125 --------
>  drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c  | 123 --------
>  drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c | 124 --------
>  drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c  | 125 --------
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c      |  14 +-
>  51 files changed, 132 insertions(+), 2782 deletions(-)
>  delete mode 100644 arch/arm/dts/bcm47622.dtsi
>  delete mode 100644 arch/arm/dts/bcm4912.dtsi
>  delete mode 100644 arch/arm/dts/bcm63146.dtsi
>  delete mode 100644 arch/arm/dts/bcm63158.dtsi
>  delete mode 100644 arch/arm/dts/bcm63178.dtsi
>  delete mode 100644 arch/arm/dts/bcm6756.dtsi
>  delete mode 100644 arch/arm/dts/bcm6813.dtsi
>  delete mode 100644 arch/arm/dts/bcm6855.dtsi
>  delete mode 100644 arch/arm/dts/bcm6856.dtsi
>  delete mode 100644 arch/arm/dts/bcm6858.dtsi
>  delete mode 100644 arch/arm/dts/bcm6878.dtsi
>  delete mode 100644 arch/arm/dts/bcm947622.dts
>  delete mode 100644 arch/arm/dts/bcm94912.dts
>  delete mode 100644 arch/arm/dts/bcm963146.dts
>  delete mode 100644 arch/arm/dts/bcm963158.dts
>  delete mode 100644 arch/arm/dts/bcm963178.dts
>  delete mode 100644 arch/arm/dts/bcm96756.dts
>  delete mode 100644 arch/arm/dts/bcm96813.dts
>  delete mode 100644 arch/arm/dts/bcm96855.dts
>  delete mode 100644 arch/arm/dts/bcm96856.dts
>  delete mode 100644 arch/arm/dts/bcm96858.dts
>  delete mode 100644 arch/arm/dts/bcm96878.dts
>  delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
>  delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
>  delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
>  delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
>
> --
> 2.37.3
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
