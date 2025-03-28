Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB86FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22021809A4;
	Fri, 28 Mar 2025 12:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NtFPb3py";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618ED805C8; Fri, 28 Mar 2025 12:34:07 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336C381DDF
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so305748766b.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161642; x=1743766442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ADJRUqLNE82RaUGbvOS3mECV9PTkuvvwuNK6OcXz6xk=;
 b=NtFPb3pyRY89SyO7X8pmnbBf+IKgNpMti7e6HuAJcVbcjdZmI1ZcjZWBH05vnlf9qA
 x3YSguLBTsKPugon8dLJCulA+DBEJxDJra8prFkAFL5zQbsRLDnYGuYo6EGkzrvZK+x+
 Zjwpk57cEAaEXze0tDq6mbyiC3IRHPNUDFN6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161642; x=1743766442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ADJRUqLNE82RaUGbvOS3mECV9PTkuvvwuNK6OcXz6xk=;
 b=bTP4TM/IxtNFi/ymia1vnJYqpUOaR4ONDgSSkNaInK3xnP5Bj41QbTov/S0NPrB02Z
 /mEsrh2Y01jF6Z5kjeVIPChogMy4DW/rerXt0KivhGxCFaQ0C6AqqakuTjg/JDgMBQ6y
 PP5eWZgLDS3lv4hpz0W7Z4+Hn+Sub+wntc+jhF4FUv2wR6nZ0XhIrAVopnvtecNo8KGR
 56MS7odvDH4Ql8K47uSKNt1ICq7D8iYcYf69FqTvptSM+9Wh9Dzcm2QUYNWbcmvYWECf
 B2XJidGDaXXVlT+hI4lfoiWBgS/Wyxpf6R48hzM8v7OswlGgHVnPQzfHDakbtwsO3KZC
 aDXA==
X-Gm-Message-State: AOJu0Yyy2Oxss3mwD9pP5/DS9jHYXxcVzcQ0E9Uj30x3SoCeVqquj4pG
 Gqya54VBaJmsyQJCSG7JhcA8uaVHNd+r/3/8+wyzWkqGt2W33o/evTIGRx4HhazfZ0uaZZkzRGr
 R9ITav6bdCmQwtuEOKEu7SKzVYmEmFovoAwlj
X-Gm-Gg: ASbGncsmOTxOFeoU2FBW+9FWuXk+8w9zoBq4CGd/BZJwKEGYLVYfBFkPfFaawzfa6vg
 d+vZByudPYk/TLMZ1qr/6cGxEgn3pnmcjFi5VdeflqvnbNLPnRqXZL6VhJot62NRIo8MXAdbNcg
 7bAuja8CX/m/3hOLjXP/KyjRM/u5I=
X-Google-Smtp-Source: AGHT+IF0kkAbew/gES6cf0LV7tr5urMrMWf7yam2+UQMsVb0IPjNss2UBBvPu7RqgbagGFm0BQBu07yVvPcFcDNUDJE=
X-Received: by 2002:a17:907:7fa6:b0:ac3:17d3:eba1 with SMTP id
 a640c23a62f3a-ac6fae42902mr788707166b.9.1743161642378; Fri, 28 Mar 2025
 04:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-30-sjg@chromium.org>
 <bab4ee26-2c36-462a-997b-aaaeab5944b0@linaro.org>
In-Reply-To: <bab4ee26-2c36-462a-997b-aaaeab5944b0@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:33:49 -0600
X-Gm-Features: AQ5f1JrhGEATXujUtQECD2sVZhuYX6mg0-pp4wZnA1goT5lkVZ7PsBT6kdqpGcI
Message-ID: <CAFLszTjcR2hqpAhFGfEeT1EssoC57iMUi6sVu_z1_B_9uY-kmw@mail.gmail.com>
Subject: Re: [PATCH v4 29/29] efi: arm: Add an EFI app for arm64
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>, 
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Trevor Woerner <twoerner@gmail.com>
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

Hi Caleb,

On Thu, 27 Mar 2025 at 11:10, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/15/25 04:22, Simon Glass wrote:
> > Introduce an EFI app for arm64 and update the documentation.
> >
> > Provide a value for LOAD_ADDR to avoid a link error.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Use ARCH_EFI instead of VENDOR_EFI
> > - Merge the linker-script rules into Kconfig in this patch
> > - Drop patch 'Select the EFI linker script for the app'
> >
> >   Kconfig                               |  1 +
> >   MAINTAINERS                           |  4 ++-
> >   arch/arm/dts/efi-arm_app.dts          | 31 ++++++++++++++++
> >   board/efi/Kconfig                     | 23 ++++++++++++
> >   board/efi/efi-arm_app/Kconfig         | 19 ++++++++++
> >   board/efi/efi-arm_app/MAINTAINERS     | 13 +++++++
> >   board/efi/efi-arm_app/Makefile        |  5 +++
> >   board/efi/efi-arm_app/board.c         | 18 ++++++++++
> >   board/efi/efi-arm_app/efi-arm_app.env | 11 ++++++
> >   configs/efi-arm_app64_defconfig       | 51 +++++++++++++++++++++++++++
> >   doc/develop/uefi/u-boot_on_efi.rst    | 17 ++++-----
> >   lib/efi/Kconfig                       |  2 +-
> >   12 files changed, 185 insertions(+), 10 deletions(-)
> >   create mode 100644 arch/arm/dts/efi-arm_app.dts
> >   create mode 100644 board/efi/efi-arm_app/Kconfig
> >   create mode 100644 board/efi/efi-arm_app/MAINTAINERS
> >   create mode 100644 board/efi/efi-arm_app/Makefile
> >   create mode 100644 board/efi/efi-arm_app/board.c
> >   create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
> >   create mode 100644 configs/efi-arm_app64_defconfig
> >
> > diff --git a/Kconfig b/Kconfig
> > index 2e63896c477..5ffdc481827 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -551,6 +551,7 @@ config SYS_LOAD_ADDR
> >       default 0x12000000 if ARCH_MX6 && !(MX6SL || MX6SLL  || MX6SX || MX6UL || MX6ULL)
> >       default 0x80800000 if ARCH_MX7
> >       default 0x90000000 if FSL_LSCH2 || FSL_LSCH3
> > +     default 0x02000000 if ARCH_EFI
>
> This value should be clearly wrong like 0x0 or 0xdeada555 or something.
> So when it gets used at runtime by mistake it's more obvious what happened.

OK, I'll send a follow-up patch for this.

> >       default 0x0 if ARCH_SC5XX
> >       help
> >         Address in memory to use as the default safe load address.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8132ab3987d..494d4424ce2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1066,12 +1066,14 @@ M:    Simon Glass <sjg@chromium.org>
> >   M:  Heinrich Schuchardt <xypron.glpk@gmx.de>
> >   S:  Maintained
> >   W:  https://docs.u-boot.org/en/latest/develop/uefi/u-boot_on_efi.html
> > +F:   board/efi/efi-arm_app
> >   F:  board/efi/efi-x86_app
> > +F:   configs/efi-arm_app*
> >   F:  configs/efi-x86_app*
> >   F:  doc/develop/uefi/u-boot_on_efi.rst
> >   F:  drivers/block/efi-media-uclass.c
> >   F:  drivers/block/sb_efi_media.c
> > -F:   lib/efi/efi_app.c
> > +F:   lib/efi/
> >   F:  scripts/build-efi.py
> >   F:  test/dm/efi_media.c
> >
> > diff --git a/arch/arm/dts/efi-arm_app.dts b/arch/arm/dts/efi-arm_app.dts
> > new file mode 100644
> > index 00000000000..38cab04e510
> > --- /dev/null
> > +++ b/arch/arm/dts/efi-arm_app.dts
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2015 Google, Inc
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +     model = "EFI ARM Application";
> > +     compatible = "efi,arm-app";
> > +
> > +     chosen {
> > +             stdout-path = &serial;
> > +     };
> > +
> > +     serial: serial {
> > +             compatible = "efi,uart";
> > +     };
> > +
> > +     reset {
> > +             compatible = "efi,reset";
> > +             bootph-all;
> > +     };
> > +     efi-fb {
> > +             compatible = "efi-fb";
> > +             bootph-some-ram;
> > +     };
>
> what is this?? We shouldn't be using devicetree, we're running on EFI.
> This makes absolutely no sense.
>
> I see the original x86 app back in the day did it this way, but this is
> just wrong. I can understanding reusing U-Boot's DM, but at least then
> build this DT at runtime based on discovering EFI drivers.

Sorry, no. U-Boot uses devicetree to instantiate its drivers, no
matter what environment we are in. E.g. it is used on x86 even though
x86 uses ACPI.

> > +
> > +};
> > diff --git a/board/efi/Kconfig b/board/efi/Kconfig
> > index 4c68d85a076..174e6ecd6f4 100644
> > --- a/board/efi/Kconfig
> > +++ b/board/efi/Kconfig
> > @@ -45,4 +45,27 @@ source "board/efi/efi-x86_payload/Kconfig"
> >
> >   endif  # X86
> >
> > +if ARM
> > +
> > +choice
> > +     prompt "Mainboard model"
> > +     optional
> > +
> > +config TARGET_EFI_ARM_APP64
> > +     bool "64-bit efi application"
> > +     select EFI_APP
> > +     select SYS_CUSTOM_LDSCRIPT
> > +     select ARM64
> > +     help
> > +       This target is used for running U-Boot on top of EFI in 64-bit mode.
> > +       In this case EFI does the early initialisation, and U-Boot
> > +       takes over once the RAM, video and CPU are fully running.
>
> EFI boot services are still running (and stuff like interrupts will be
> handled by EFI drivers), I wouldn't say U-Boot "takes over" until/unless
> it calls EBS.

Yes, good point, I'll send a follow-up patch.


> > +       U-Boot is loaded as an application from EFI.
> > +
> > +endchoice
> > +
> > +source "board/efi/efi-arm_app/Kconfig"
> > +
> > +endif  # ARM
> > +
> >   endif  # ARCH_EFI
> > diff --git a/board/efi/efi-arm_app/Kconfig b/board/efi/efi-arm_app/Kconfig
> > new file mode 100644
> > index 00000000000..6e64bc8a721
> > --- /dev/null
> > +++ b/board/efi/efi-arm_app/Kconfig
> > @@ -0,0 +1,19 @@
> > +if EFI_APP
> > +
> > +config SYS_BOARD
> > +     default "efi-arm_app"
> > +
> > +config SYS_VENDOR
> > +     default "efi"
> > +
> > +config SYS_SOC
> > +     default "efi"
> > +
> > +config BOARD_SPECIFIC_OPTIONS # dummy
> > +     def_bool y
> > +     imply VIDEO_EFI
>
> Why not just put this in TARGET_EFI_ARM_APP64?

This fits with how x86 does it and allows us to add other boards which
are based on the EFI app.

> > +
> > +config SYS_LDSCRIPT
> > +     default "arch/arm/lib/elf_aarch64_efi.lds"
> > +
> > +endif
> > diff --git a/board/efi/efi-arm_app/MAINTAINERS b/board/efi/efi-arm_app/MAINTAINERS
> > new file mode 100644
> > index 00000000000..3114db69a35
> > --- /dev/null
> > +++ b/board/efi/efi-arm_app/MAINTAINERS
> > @@ -0,0 +1,13 @@
> > +EFI-ARM_APP32 BOARD
> > +M:   Simon Glass <sjg@chromium.org>
> > +S:   Maintained
> > +F:   board/efi/Kconfig
> > +F:   board/efi/efi-arm_app/
> > +F:   configs/efi-arm_app32_defconfig
>
> Am I missing something or is this not there?

Oh yes, this needs to be deleted. I gave up trying to make it work.

> > +
> > +EFI-ARM_APP64 BOARD
> > +M:   Simon Glass <sjg@chromium.org>
> > +S:   Maintained
> > +F:   board/efi/Kconfig
> > +F:   board/efi/efi-arm_app/
> > +F:   configs/efi-arm_app64_defconfig
> > diff --git a/board/efi/efi-arm_app/Makefile b/board/efi/efi-arm_app/Makefile
> > new file mode 100644
> > index 00000000000..fc6ef159473
> > --- /dev/null
> > +++ b/board/efi/efi-arm_app/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> > +
> > +obj-y        += board.o
> > diff --git a/board/efi/efi-arm_app/board.c b/board/efi/efi-arm_app/board.c
> > new file mode 100644
> > index 00000000000..239e1fbaba4
> > --- /dev/null
> > +++ b/board/efi/efi-arm_app/board.c
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2015 Google, Inc
>
> 10 years out of date here

Indeed. When I copy a file I keep the original author and copyright.

> > + */
> > +
> > +#include <init.h>
> > +
> > +struct mm_region *mem_map;
> > +
> > +int print_cpuinfo(void)
>
> Just disable CONFIG_DISPLAY_CPUINFO

OK

> > +{
> > +     return 0;
> > +}
> > +
> > +int board_init(void)
> > +{
> > +     return 0;
> > +}
> > diff --git a/board/efi/efi-arm_app/efi-arm_app.env b/board/efi/efi-arm_app/efi-arm_app.env
> > new file mode 100644
> > index 00000000000..b28c15556de
> > --- /dev/null
> > +++ b/board/efi/efi-arm_app/efi-arm_app.env
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Environment file for ARM EFI app
> > + *
> > + * Copyright 2025, Simon Glass <simon.glass@canonical.com>
> > + */
> > +
> > +/* common console settings */
> > +stdin=serial
> > +stdout=serial,vidconsole
> > +stderr=serial,vidconsole
> > diff --git a/configs/efi-arm_app64_defconfig b/configs/efi-arm_app64_defconfig
> > new file mode 100644
> > index 00000000000..0199fb16467
> > --- /dev/null
> > +++ b/configs/efi-arm_app64_defconfig
> > @@ -0,0 +1,51 @@
> > +CONFIG_ARM=y
> > +# CONFIG_ARM64_CRC32 is not set
> > +CONFIG_ARCH_EFI_ARM=y
> > +CONFIG_NR_DRAM_BANKS=8
>
> Real platforms have way more than this, 32 might be better.
>
> Saying that, it doesn't seem like gd->bd->bi_dram is populated anywhere,
> am I missing something?

Yes, you are right, it is not. It doesn't really make any sense in the
EFI app. We just allocate a single block of memory and don't worry too
much about what is going on elsewhere.

>
> > +CONFIG_ENV_SIZE=0x1000
> > +CONFIG_DEFAULT_DEVICE_TREE="efi-arm_app"
> > +CONFIG_DEBUG_UART_BASE=0x0
> > +CONFIG_DEBUG_UART_CLOCK=0
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_TARGET_EFI_ARM_APP64=y
> > +CONFIG_EFI=y
> > +CONFIG_EFI_APP_64BIT=y
>
> Looking at these next to each other, it seems odd to have
> CONFIG_TARGET_EFI_ARM_APP64 and CONFIG_EFI_APP_64BIT, would you ever
> have one but not the other?

At least with postmarketOS we are seeing boards which are EFI payloads
but have their own config, so I thought it best to keep the same
approach here.

[..]

Regards,
Simon
