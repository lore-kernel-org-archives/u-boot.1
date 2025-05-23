Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CB8C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E31832EA;
	Fri, 23 May 2025 15:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fpeMkfA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2D0832A4; Fri, 23 May 2025 15:44:28 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32B5832C0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso1615199966b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748007866; x=1748612666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4jrGUoU+0v/HS0B8AXmjH0k4GUk55RrU1X9GksRGdnY=;
 b=fpeMkfA5qDxAQBZ+0ssllCqadpmCxcXsdNkmieu/ixFaUKlLZ35Hqk0tNHn/hF+Gsq
 4mH2JzJvpu3dAHZbJsO+V/4RyQFjY1w8e8l0bYDrFGnhjLOOI01XnP+f8G9U234DUBIS
 5qnm2bOv3P7nyxA9Z/+6/ywVuxeoPU8mYNojc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748007866; x=1748612666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4jrGUoU+0v/HS0B8AXmjH0k4GUk55RrU1X9GksRGdnY=;
 b=euOde9TX5g2QsAkOMP7gZquE/KHjVJ/V4d9epDFfbAHjxplXMUM2oByTcdaSdZTg6d
 L7ZTlQprn1Iztuv/NKFw7Q9qVRZ5eS7YojV0GyFjy2cE8ey3zKmdqMEgPlEBRpeDlR34
 oGRxNfnHk8vwWSlO59/2rvhfWx6lQuWgVVsuETJUGmuHY8wtllcAB5WEWsxnTAjLj9ai
 84Vho86igRBX9mCpqxzTJn6dGVVJUgxs3vyVAK5WvEisVuVa92pW9c+ePEotj/QGnuEM
 Ju5wiPY5Ofx4kNZi06eOouBNgHNieNAW4hgym7bYDsaN/IlNU42Ob6PbKNGLzc3gN5/X
 yQoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBM7vT1/UWTaUFlOOwD0bjjrpanQ5E2hTJWGv7ao6hmgowxkqChCL7pyT0onOgXByBeh8iGN8=@lists.denx.de
X-Gm-Message-State: AOJu0YxxUkyZOCWsaBYNXGMYD5mf7zrOMqY3B8YCORmg3mtcw46Ok1y1
 kfArN3LXm4FoAPyO3WdHmN6RkzlgmOpEIzKCn5/jq/CaaDgRnKAbrffPH8bGOiIMDDErdz9qtbi
 0zeQtHZLn62mAGuVpRiDfkKTnu9ahUGhlxrvQj8EK
X-Gm-Gg: ASbGncvEh+xCoEzDQqBsKy4PNdYpdS6VP9sQBn5fk7YZdETupYhd9sI1TWYmJW5YHIH
 9O31S2YBF7LNDvks7jUUMLCoGDaOfRvKYcCQdC0SD1B5MK8+Q+NEFC1ynJyygKK9SZZm+7tOub0
 8OKP7fZ6Xs2Zfoy+/wrWqXKhyjogk0mdHygg==
X-Google-Smtp-Source: AGHT+IHTPzzqD3znu4ZC7VSh+FOMp0zHBLiWi0mdoO7mSBYqhrt/2KyazwaCAi/adv6OpgAf7+VmKIcoJuYIvOW1qcU=
X-Received: by 2002:a17:907:3f29:b0:ad4:f5ee:3c0 with SMTP id
 a640c23a62f3a-ad7083bb71dmr313264266b.16.1748007866156; Fri, 23 May 2025
 06:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <qGUwuf16r8DyviFIr-y8PVzG36Fp4Q9yiMZWn6l1V7dsu9-OmwHLFXXKEOOZHdQNBFxW6SB8tU5jL3MzuDmxq0SRl1lELPpnwJqcKMqPeZY=@protonmail.com>
 <682d44f6.250a0220.1eefc.291d@mx.google.com>
In-Reply-To: <682d44f6.250a0220.1eefc.291d@mx.google.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 14:44:12 +0100
X-Gm-Features: AX0GCFvtiG6MY9zFKKawb3pI_pXTlXClJFw1ybd0L3HIJOKMmsWN4Ku0RqVgnC4
Message-ID: <CAFLszTgbS=rxLUXRq7+pdfVvace_KbYzdGmReFJZmirA0wVZ3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] BeagleBoard: Bring it back with updates.
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: OMAP at BSF <omapbsf@protonmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 21 May 2025 at 05:14, Derald D. Woods <woods.technical@gmail.com> wrote:
>
> On Sat, May 17, 2025 at 09:28:00PM +0000, OMAP at BSF wrote:
> > * Converted to using DM_I2C.
> > * New config file for xM.
> > * Run 'patman' on patches.
> > * Use upstream device tree files.
> >
> > Signed-off-by: Steven Hill <omapbsf@protonmail.com>
> > ---
> > v2: Use upstream device trees.
> > v3: No change.
> > v4: Update name in MAINTAINERS file.
> >
> > ---
> >  arch/arm/dts/Makefile                       |   9 +
> >  arch/arm/dts/omap3-beagle-u-boot.dtsi       |  14 +
> >  arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi |  14 +
> >  arch/arm/dts/omap3-beagle-xm-u-boot.dtsi    |  14 +
> >  arch/arm/dts/omap3-u-boot.dtsi              |  34 +-
> >  arch/arm/include/asm/arch-omap3/cpu.h       |   3 +-
> >  arch/arm/include/asm/arch-omap3/hardware.h  |  22 +
> >  arch/arm/include/asm/arch-omap3/mem.h       |   8 +-
> >  arch/arm/mach-omap2/omap3/Kconfig           |  14 +
> >  board/beagle/beagle/Kconfig                 |  14 +
> >  board/beagle/beagle/MAINTAINERS             |   7 +
> >  board/beagle/beagle/Makefile                |   7 +
> >  board/beagle/beagle/beagle.c                | 541 +++++++++++++++++++
> >  board/beagle/beagle/beagle.h                | 545 ++++++++++++++++++++
> >  board/beagle/beagle/led.c                   |  70 +++
> >  board/isee/igep00x0/spl.c                   |   6 +-
> >  board/lg/sniper/sniper.c                    |   2 +-
> >  board/logicpd/omap3som/omap3logic.c         |   4 +-
> >  board/ti/omap3evm/evm.c                     |   2 +-
> >  board/timll/devkit8000/devkit8000.c         |   2 +-
> >  configs/omap3_beagle_defconfig              | 124 +++++
> >  configs/omap3_beagle_xm_defconfig           | 109 ++++
> >  include/configs/omap3_beagle.h              | 201 ++++++++

Please also move to bootstd and text environment.

> >  23 files changed, 1736 insertions(+), 30 deletions(-)
> >  create mode 100644 arch/arm/dts/omap3-beagle-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/omap3-beagle-xm-u-boot.dtsi
> >  create mode 100644 arch/arm/include/asm/arch-omap3/hardware.h
> >  create mode 100644 board/beagle/beagle/Kconfig
> >  create mode 100644 board/beagle/beagle/MAINTAINERS
> >  create mode 100644 board/beagle/beagle/Makefile
> >  create mode 100644 board/beagle/beagle/beagle.c
> >  create mode 100644 board/beagle/beagle/beagle.h
> >  create mode 100644 board/beagle/beagle/led.c
> >  create mode 100644 configs/omap3_beagle_defconfig
> >  create mode 100644 configs/omap3_beagle_xm_defconfig
> >  create mode 100644 include/configs/omap3_beagle.h

Some other things I noticed:

Board detection in a SYSINFO driver
Use DM_I2C always (drop dead code)
Use DM_GPIO always
Use a PMIC driver instead of manual access
Use an I2C EEPROM driver instead of manually coding the I2C access
Use a GPIO driver for TWL4030
Is there a pinctrl driver?

Regards,
Simon
