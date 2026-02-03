Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC436E8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D55842E1;
	Tue,  3 Feb 2026 16:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O3jLPQ50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EEF842C9; Tue,  3 Feb 2026 15:24:57 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098B28423E
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5663601fe8bso4958056e0c.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 06:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770128694; cv=none;
 d=google.com; s=arc-20240605;
 b=Eg8QkCmePZnJk+kS5GCSpafJVD2c9S3Y0TIzjMtM2jXJHj5tpGLmOLPCSKdl5+V+PG
 VGEClmRpBvXWU/aFjQzT19glsb9atdBaDIYMO1/XYwntHnXnK6ema2JbQOOesVVA74wc
 1xofy48RTxJw89fX0U5UV95Fo7lInLI/t/9WqIAkvFrtP9r8GoqA13501hH9pL0oGUHN
 B2Bd6QNFnpFdn6bdTfNtee9FIjAghN7CLsEsNzfKznG7BYgYhbDFsnOZosSx0l4X4azo
 CLCgTYB9oTHJ5Wj7yT5Z+NHQ6ZXUhLLlA87vuC+8+x5crKGAF7pJL9g+OSRPBejefCMP
 UHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bfFhZhYdqgfZouiLwQ3+1t5ELsYYODnucktEQRLNFYY=;
 fh=ZkDUFJRqYIy8IIopJQcrADgAGw+lEvcFtASRXysW43A=;
 b=UBXR6t00LehuYeA4Yi3a953HAbj90A9Iiq6uj7MASzeLzV/yKJaUY+bm6VwZJKNnh7
 jwovKYHoXjYWm9YAepS54/0uGpPgHp7rZZ6Z8hvMCjRNDBv/gTxW/KQ4v1tkFjpv092J
 TDDccUbUJotKaGHDzs2OeM+14WYxh9eFhD643CYZZDhfVRNsoBDYQjwooLe8nyRZkPC0
 497si3wsMDlWtS5Yh6ttXqnoDlCaGrm6J4cW6mwcbhS+5M1sfibyl3/T33sK11WuXWV0
 bo+jx+c1pIcLg5dH5fr1+/2hUBYm0CMoOvXJ9euCarrWfXoLWsd484hjQp/tHLn/Kqcp
 POrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770128694; x=1770733494; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfFhZhYdqgfZouiLwQ3+1t5ELsYYODnucktEQRLNFYY=;
 b=O3jLPQ503ZfPRbVX4jP3JqhyJsIF2gu53Ugsp41n9UgYXhEOfFiRbFTTwWQQXOilc2
 ItZ6I/BKQk0n9NMybRin/Wbtlu4RSeUMs+1liVRYeUz/RTLQC73ISAtx7DiGVZuW0tQe
 gFsk8eVYzO6oaFe9eZKI8lCdpa0R9tYckjbtHeJDjQWLLr8EC0wn+yqdaCC8P33peSm1
 V33NwS1729ALoNubYV+GqceE1COAvHv+m1ock/J3PjEiOiD3wscCH88H6euGneOyZov6
 eba2uIGlJoKiQ2LMdQ+h3XjK5fPa8jwZ2o+yt/rt3ep0QHOWfHo5615BVnx1JctVEI/Y
 RlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128694; x=1770733494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bfFhZhYdqgfZouiLwQ3+1t5ELsYYODnucktEQRLNFYY=;
 b=XMXs2HCR1pCGVqRsxTQ4UsAYF+h47OAYrHJMzOEk7mMZrJZIYnJ4z2QwUQp52Get87
 1TeL70ZmT0p31x3MhYScGsZ76ca35CxkKKlx4n3KhrgX+HoEw4VhsNe0IvpM3dW4brhn
 1QxSbWbmClJj1rY8mPDsB4vk4arw/fjTqNCdpW1220TgVArMCoinhjFBa33RrrB8jFBn
 wqDHJLWDYn6eXs1QyZathuIvt24771S7enDx/Y2qXPkKqw0iQYtB8s0MrIId3AJRXuLY
 3e4TEGGezjcacsoquJMsIVPWZNB5y6CaNct/ffa6cv65LEFo5CKR/DcjRpM8Kqzab80i
 IuEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM98rR27C4FlvU3EHHH5k+CzkSLzvTUWZNMThKaijBaC28xbm8R6JiBTMReA/o8Q+OoHhoMO0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2bMJAWRpgy3lm8ernsRC4aL9KZUy0uAESwmpqkm3frdnIBg4s
 V/SQ/jI6NkPsjT1y9xFTpSLWFxxRXyUMXE61uJKaOEIa2SoynMjbJdr5/zjf46/7vFFaeWYfjAW
 qcTmoKo2L24q/Lf3YH4boo/6Btg1iALU=
X-Gm-Gg: AZuq6aJx59FvL4531uoHfI0b2CjiI7iM/d0mx71QiQFl8aqi9Iad5bjkDFoZ88+v1NM
 nOUfBC0K/S0B7j2414otpn5amL32Db0lkjg/jNz0UtIVfNLvlPvpnrJfcEweHZ691li+67Mgu4p
 +Q4kSg9x3lJmNeAmBOu36vsFIEhayKYOQ5lQz5CpbSv/244nVEUfkVzOf91wutDEeRAmzz9gGHw
 YnUGPOJiiHmBCz7ymOnJjJVIc4XxmvE4ORluHKHUjaWpNveSS6BCeL1ItxFPP1S9JUnk6wU
X-Received: by 2002:a05:6122:1045:b0:566:354d:9f4a with SMTP id
 71dfb90a1353d-5669ffb37b5mr4447594e0c.1.1770128693473; Tue, 03 Feb 2026
 06:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-3-raymondmaoca@gmail.com>
 <d31e18c6-11d7-4b41-beca-b31bb31a3d14@gmx.de>
In-Reply-To: <d31e18c6-11d7-4b41-beca-b31bb31a3d14@gmx.de>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 3 Feb 2026 09:24:42 -0500
X-Gm-Features: AZwV_QhxpYrta4QgqLastiCtuZeu-koKwMxKNM-tLRRTmifanrOPhTvhnjgTq9k
Message-ID: <CAMDkj5y4v6FBJkGT5EemoayoeYeoza5SExTEjxP05mrjTn-x1w@mail.gmail.com>
Subject: Re: [PATCH 02/17] spacemit: k1: enable SPL with debug UART
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>, 
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Henrik Grimler <henrik@grimler.se>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Samuel Holland <samuel@sholland.org>, Justin Klaassen <justin@tidylabs.net>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Feb 2026 16:03:35 +0100
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

Hi Heinrich,

On Fri, Jan 23, 2026 at 9:52=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 1/17/26 20:01, Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > Add SPL support featuring debug UART output for early boot
> > diagnostics on K1 SoC.
>
> Please, describe how to install the SPL binary to make this patch testabl=
e.
>

Currently it only supports testing via USB download through fastboot,
not an installable image in flash.

Regards,
Raymond

> >
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> >   arch/riscv/cpu/k1/Kconfig  |  2 ++
> >   arch/riscv/dts/Makefile    |  1 +
> >   arch/riscv/dts/k1-spl.dts  | 26 ++++++++++++++++++++++++++
> >   arch/riscv/dts/k1.dtsi     |  2 +-
> >   board/spacemit/k1/Makefile |  2 ++
> >   board/spacemit/k1/spl.c    | 24 ++++++++++++++++++++++++
> >   configs/k1_defconfig       | 21 ++++++++++++++++++++-
> >   include/configs/k1.h       |  2 ++
> >   8 files changed, 78 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/riscv/dts/k1-spl.dts
> >   create mode 100644 board/spacemit/k1/spl.c
> >
> > diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
> > index 4b621158334..4f7a07fd8ee 100644
> > --- a/arch/riscv/cpu/k1/Kconfig
> > +++ b/arch/riscv/cpu/k1/Kconfig
> > @@ -1,6 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0-or-later
> >   #
> >   # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > +# Copyright (C) 2025-2026, RISCStar Ltd.
> >
> >   if ARCH_K1
> >
> > @@ -9,6 +10,7 @@ config SPACEMIT_K1
> >       select BINMAN
> >       select ARCH_EARLY_INIT_R
> >       select SYS_CACHE_SHIFT_6
> > +     select SUPPORT_SPL
> >       imply CPU
> >       imply CPU_RISCV
> >       imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> > diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> > index 9b347fc3b50..e942ef95142 100644
> > --- a/arch/riscv/dts/Makefile
> > +++ b/arch/riscv/dts/Makefile
> > @@ -1,5 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >
> > +dtb-$(CONFIG_ARCH_K1) +=3D k1-spl.dtb
> >   dtb-$(CONFIG_TARGET_ANDES_AE350) +=3D ae350_32.dtb ae350_64.dtb
> >   dtb-$(CONFIG_TARGET_ANDES_VOYAGER) +=3D qilai-voyager.dtb
> >   dtb-$(CONFIG_TARGET_BANANAPI_F3) +=3D k1-bananapi-f3.dtb
> > diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
> > new file mode 100644
> > index 00000000000..6018ea1e452
> > --- /dev/null
> > +++ b/arch/riscv/dts/k1-spl.dts
>
> Why do you introduce this file?
> Can't we use dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
>
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (C) 2023-2026 Spacemit, Inc
> > + * Copyright (C) 2025-2026 RISCStar Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +#include "k1.dtsi"
> > +#include "binman.dtsi"
> > +
> > +/ {
> > +     model =3D "spacemit k1 spl";
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +             bootph-all;
>
> The target should be to inherit bootph-all from the Linux kernel tree.
>
> Until you you have this upstream you could add the bootph-all properties
> to arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
>
> Best regards
>
> Heinrich
>
> > +     };
> > +};
> > +
> > +&soc {
> > +     bootph-all;
> > +     serial@d4017000 {
> > +             status =3D "okay";
> > +             bootph-all;
> > +     };
> > +};
> > diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
> > index a633e43da32..9c203eb4b79 100644
> > --- a/arch/riscv/dts/k1.dtsi
> > +++ b/arch/riscv/dts/k1.dtsi
> > @@ -318,7 +318,7 @@
> >               };
> >       };
> >
> > -     soc {
> > +     soc: soc {
> >               compatible =3D "simple-bus";
> >               interrupt-parent =3D <&plic>;
> >               #address-cells =3D <2>;
> > diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
> > index 2168698402b..7bce47bac8c 100644
> > --- a/board/spacemit/k1/Makefile
> > +++ b/board/spacemit/k1/Makefile
> > @@ -1,5 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0-or-later
> >   #
> >   # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > +# Copyright (c) 2025-2026, RISCStar Ltd.
> >
> >   obj-y :=3D board.o
> > +obj-$(CONFIG_SPL_BUILD) +=3D spl.o
> > diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> > new file mode 100644
> > index 00000000000..11a097389f1
> > --- /dev/null
> > +++ b/board/spacemit/k1/spl.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025-2026, RISCStar Ltd.
> > + */
> > +
> > +#include <spl.h>
> > +
> > +void board_init_f(ulong dummy)
> > +{
> > +     int ret;
> > +
> > +     ret =3D spl_early_init();
> > +     if (ret)
> > +             panic("spl_early_init() failed:%d\n", ret);
> > +
> > +     riscv_cpu_setup();
> > +
> > +     preloader_console_init();
> > +}
> > +
> > +u32 spl_boot_device(void)
> > +{
> > +     return BOOT_DEVICE_NONE;
> > +}
> > diff --git a/configs/k1_defconfig b/configs/k1_defconfig
> > index 0bdc3c800f0..f1a16735943 100644
> > --- a/configs/k1_defconfig
> > +++ b/configs/k1_defconfig
> > @@ -3,7 +3,19 @@ CONFIG_SYS_MALLOC_LEN=3D0x1000000
> >   CONFIG_NR_DRAM_BANKS=3D2
> >   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"k1-bananapi-f3"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"k1-spl"
> > +CONFIG_SPL=3Dy
> > +CONFIG_SPL_TEXT_BASE=3D0xC0801000
> > +CONFIG_SPL_MAX_SIZE=3D0x33000
> > +CONFIG_SPL_BSS_START_ADDR=3D0xC0837000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_HAVE_INIT_STACK=3Dy
> > +CONFIG_SPL_STACK=3D0xC0840000
> > +CONFIG_SPL_SIZE_LIMIT=3D0x31000
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x08000000
> > +CONFIG_STACK_SIZE=3D0x100000
> >   CONFIG_SYS_BOOTM_LEN=3D0xa000000
> >   CONFIG_SYS_LOAD_ADDR=3D0x200000
> >   CONFIG_ARCH_RV64I=3Dy
> > @@ -23,3 +35,10 @@ CONFIG_PINCTRL_SINGLE=3Dy
> >   CONFIG_RESET_SPACEMIT_K1=3Dy
> >   CONFIG_SYS_NS16550=3Dy
> >   CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_DEBUG_UART=3Dy
> > +CONFIG_DEBUG_UART_BASE=3D0xD4017000
> > +CONFIG_DEBUG_UART_CLOCK=3D14700000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_DEBUG_UART_NS16550=3Dy
> > +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> > +# CONFIG_DEBUG_SBI_CONSOLE is not set
> > diff --git a/include/configs/k1.h b/include/configs/k1.h
> > index 97cf4d72df0..6a26fdfcebe 100644
> > --- a/include/configs/k1.h
> > +++ b/include/configs/k1.h
> > @@ -7,6 +7,8 @@
> >   #ifndef __CONFIG_H
> >   #define __CONFIG_H
> >
> > +#define CFG_SYS_NS16550_CLK      14700000
> > +
> >   #define CFG_SYS_SDRAM_BASE         0x0
> >   #define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
> >
>
