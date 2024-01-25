Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA9C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62E8807EC;
	Thu, 25 Jan 2024 15:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a/63WO3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D34807EC; Thu, 25 Jan 2024 15:33:11 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99FB80090
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobetter@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so3673467a12.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706193186; x=1706797986; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5iMJAddnMMlcfJNj6L7aVr8lNX1WTHN620V2rrVd+U=;
 b=a/63WO3nxWD/m5GtyafZo1N40AKZetwnhXUOQV19MkWMrgYvoeHD3LiuoM+ktX/w3X
 1zSCyJS/cu8PCe3zocLgrpyWgYNwyUrdZqKLyLZ3XZ4Kbo+fFfDRWuUjJeWphJexKHBd
 mIxxmRagxMCwY4FmOmVkhQ+OJSoeeQ3NuO7/vrWxuSAAoTZNMj2uZnkuGyPO+BL5+nXs
 cbG8+yvcZjLYv24pGs8sAE7hsB8RMXuhr+YtPW38mVn/WnBgvACoc1ajspn8Wr0V4rM0
 /+qEfCKud4EeCMgj0LWhIdwbYs9yI1+3AHzAdFPj5FUZS1f7jRPOk9E20bIHErQyaNn4
 xY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706193186; x=1706797986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5iMJAddnMMlcfJNj6L7aVr8lNX1WTHN620V2rrVd+U=;
 b=mvSwtw3PPzmgoD+QJTrmDX0FnbGMCY7JG4RLse8W9b4Eas2VDarq4lqeqJRR/+3R33
 krtWoE+jPS24nzdoE7yW5ArdXCnn555WNxiN9v8oP2OQdTdPDU4uID8JIw/dqXGbDh/L
 zXbngmNh65r0XyviZ5XkeaUFfySkWO10pHtt9bSgtE4lPFhYV9XRhi7LUXjTTt4PwQm8
 1hsdWEP+30d46H9DghKwFCYwlotVFVMXspuDRUJ96zgzAkE1UAakUDSizJFh2GnSgaRY
 Z87Y9sSv+CwtajUqh2iFJNa00hg13m8n1a36L/i6M7E/yn3erbOGw4WeRXBAf5fXdV2q
 7S0Q==
X-Gm-Message-State: AOJu0YxWqMrGP8p/HsStD4+Uy3cRl8UZqmC70WNGi9QOJn0CtrLTBwj8
 acbKkWBK7DtA9LZ3OVPQH3cT6mBEwsVneap3YpSxLtCA5XLv/iQt0xkNca8ZPc7c0NkgDlrKDnt
 UIoxIl8RgboBolHZYSWvo8DxEwlw=
X-Google-Smtp-Source: AGHT+IGGpdAAXirNPMpDQ5w+Nf+tS8hLu6lOynz4GqgdjLj125l6TYLE8MaarRVj8/+3m2iYdjEMMUzMFo5zMuPZAro=
X-Received: by 2002:a17:90a:4311:b0:290:2f89:5bb8 with SMTP id
 q17-20020a17090a431100b002902f895bb8mr670627pjg.45.1706193185732; Thu, 25 Jan
 2024 06:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20240125070252.2057679-1-tobetter@gmail.com>
 <254dcaee-6aca-48da-a09c-35b8f41f0480@kwiboo.se>
In-Reply-To: <254dcaee-6aca-48da-a09c-35b8f41f0480@kwiboo.se>
From: Dongjin Kim <tobetter@gmail.com>
Date: Thu, 25 Jan 2024 23:32:54 +0900
Message-ID: <CADoNuNdejLOA=_SgrttYbEhfhcHuxJr7fRXovx4V=3dzxHmDKA@mail.gmail.com>
Subject: Re: [PATCH] board: rockchip: Add Hardkernel ODROID-M1S
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

Hello Jans,

Thank you for reviewing.

On Thu, Jan 25, 2024 at 8:51=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Dongjin,
>
> On 2024-01-25 08:02, Dongjin Kim wrote:
> > Hardkernel ODROID-M1S is a single board computer with a RK3566 SoC,
> > a slightly modified version of the RK3566 SoC.
> >
> > Features tested on a ODROID-M1S 8GB v1.0 2023-08-10:
> >     - SD-card boot
> >     - eMMC boot
> >     - PCIe/NVMe
>
> This board does not yet have a device tree in the linux maintainer tree.
> Please first submit the device tree to linux before adding the board to
> U-Boot.
>

I realized that the linux kernel patch for ODROID-M1S was already
submitted by someone else.
https://patchwork.kernel.org/project/linux-rockchip/patch/20240112135004.28=
907-1-lee@kyuhyuk.kr/

It's a slightly different version, so the next patch should be with
the device tree when it's merged.

> The generic-rk3568_defconfig can be used to boot this board from SD-card
> and eMMC until a fully reviewed device tree can be picked from linux.
>

Ok.

> >
> > Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> > ---
> >  arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi |  28 +
> >  arch/arm/dts/rk3566-odroid-m1s.dts         | 665 +++++++++++++++++++++
> >  arch/arm/mach-rockchip/rk3568/Kconfig      |   6 +
> >  board/hardkernel/odroid_m1s/Kconfig        |  15 +
> >  board/hardkernel/odroid_m1s/MAINTAINERS    |   9 +
> >  board/hardkernel/odroid_m1s/Makefile       |   7 +
> >  board/hardkernel/odroid_m1s/board.c        |  80 +++
> >  configs/odroid-m1s-rk3566_defconfig        | 109 ++++
> >  doc/board/rockchip/rockchip.rst            |   1 +
> >  include/configs/odroid_m1s.h               |  12 +
> >  10 files changed, 932 insertions(+)
> >  create mode 100644 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3566-odroid-m1s.dts
> >  create mode 100644 board/hardkernel/odroid_m1s/Kconfig
> >  create mode 100644 board/hardkernel/odroid_m1s/MAINTAINERS
> >  create mode 100644 board/hardkernel/odroid_m1s/Makefile
> >  create mode 100644 board/hardkernel/odroid_m1s/board.c
> >  create mode 100644 configs/odroid-m1s-rk3566_defconfig
> >  create mode 100644 include/configs/odroid_m1s.h
> >
> > diff --git a/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi b/arch/arm/dts/=
rk3566-odroid-m1s-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..33a1d142b8c
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +#include "rk356x-u-boot.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
>
> These includes is not in use in this file, please remove.
>
> > +
> > +/ {
> > +     chosen {
> > +             stdout-path =3D &uart2;
> > +             u-boot,spl-boot-order =3D &sdmmc0, &sdhci;
>
> Is there a reason why this differ from other rk356x boards and the
> default from rk356x-u-boot.dtsi cannot be used?
>

It is to give higher priority to SD cards that have vendor firmware
for maintenance or another OS.
In the worst case if U-Boot eMMC is corrupted for some reason and it
is not able to boot any other
OS, SD card is the most convenient method to recover.

> > +     };
> > +};
> > +
> > +&sdhci {
> > +     cap-mmc-highspeed;
> > +     mmc-ddr-1_8v;
>
> This mode cause eMMC write issues, please drop it, I have an incoming
> series that drop this prop for supported rk35xx boards.
>

Ok.

> > +     mmc-hs200-1_8v;
> > +     mmc-hs400-1_8v;
> > +     mmc-hs400-enhanced-strobe;
>
> Based on my testing HS400 modes is only supported by RK3568 not the
> RK3566 variant.
>

Ok.

> > +     pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> > +};
>
> Because this device tree is not yet in linux, hopefully correct props
> can be applied to device tree and u-boot do not need any overrides.
>

Understand.

> > +
> > +&uart2 {
> > +     bootph-all;
> > +     clock-frequency =3D <24000000>;
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/arm/dts/rk3566-odroid-m1s.dts b/arch/arm/dts/rk3566-o=
droid-m1s.dts
> > new file mode 100644
> > index 00000000000..73e29d80c71
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3566-odroid-m1s.dts
>
> [snip]
>
> > diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rock=
chip/rk3568/Kconfig
> > index baa51349f4b..2f03b983ee5 100644
> > --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> > @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
> >       help
> >         Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
> >
> > +config TARGET_ODROID_M1S_RK3566
> > +     bool "ODROID-M1S"
> > +     help
> > +       Hardkernel ODROID-M1S single board computer with a RK3566 SoC.
> > +
> >  config TARGET_QUARTZ64_RK3566
> >       bool "Pine64 Quartz64"
> >       help
> > @@ -44,6 +49,7 @@ config SYS_MALLOC_F_LEN
> >  source "board/rockchip/evb_rk3568/Kconfig"
> >  source "board/anbernic/rgxx3_rk3566/Kconfig"
> >  source "board/hardkernel/odroid_m1/Kconfig"
> > +source "board/hardkernel/odroid_m1s/Kconfig"
> >  source "board/pine64/quartz64_rk3566/Kconfig"
> >
> >  endif
> > diff --git a/board/hardkernel/odroid_m1s/Kconfig b/board/hardkernel/odr=
oid_m1s/Kconfig
> > new file mode 100644
> > index 00000000000..0acea61dac4
> > --- /dev/null
> > +++ b/board/hardkernel/odroid_m1s/Kconfig
> > @@ -0,0 +1,15 @@
> > +if TARGET_ODROID_M1S_RK3566
> > +
> > +config SYS_BOARD
> > +     default "odroid_m1s"
> > +
> > +config SYS_VENDOR
> > +     default "hardkernel"
> > +
> > +config SYS_CONFIG_NAME
> > +     default "odroid_m1s"
> > +
> > +config BOARD_SPECIFIC_OPTIONS # dummy
> > +     def_bool y
> > +
> > +endif
> > diff --git a/board/hardkernel/odroid_m1s/MAINTAINERS b/board/hardkernel=
/odroid_m1s/MAINTAINERS
> > new file mode 100644
> > index 00000000000..20fc277ccc6
> > --- /dev/null
> > +++ b/board/hardkernel/odroid_m1s/MAINTAINERS
> > @@ -0,0 +1,9 @@
> > +ODROID-M1S
> > +M:   Dongjin Kim <tobetter@gmail.com>
>
> I have this board so feel free to add me as a reviewer :-)
>
> R:      Jonas Karlman <jonas@kwiboo.se>
>

Thank you. :)

> > +S:   Maintained
> > +F:   arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> > +F:   arch/arm/dts/rk3566-odroid-m1s.dts
> > +F:   board/hardkernel/odroid_m1s/
> > +F:   board/hardkernel/odroid_m1s/board.c
> > +F:   configs/odroid-m1s-rk3566_defconfig
> > +F:   include/configs/odroid_m1s.h
> > diff --git a/board/hardkernel/odroid_m1s/Makefile b/board/hardkernel/od=
roid_m1s/Makefile
> > new file mode 100644
> > index 00000000000..6ca49c49b71
> > --- /dev/null
> > +++ b/board/hardkernel/odroid_m1s/Makefile
> > @@ -0,0 +1,7 @@
> > +#
> > +# Copyright (c) 2024 Hardkernel Co,. Ltd
> > +#
> > +# SPDX-License-Identifier:     GPL-2.0+
> > +#
> > +
> > +obj-y        +=3D board.o
> > diff --git a/board/hardkernel/odroid_m1s/board.c b/board/hardkernel/odr=
oid_m1s/board.c
> > new file mode 100644
> > index 00000000000..de7b160a51a
> > --- /dev/null
> > +++ b/board/hardkernel/odroid_m1s/board.c
> > @@ -0,0 +1,80 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2024 Hardkernel Co., Ltd
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <mmc.h>
> > +#include <net.h>
> > +#include <asm/arch-rockchip/misc.h>
> > +
> > +#ifdef CONFIG_MISC_INIT_R
> > +
> > +/* Read first block 512 bytes from the first BOOT partition of eMMC
> > + * that stores device identifcation sting in UUID type 1, this string
> > + * is written in factory to give device seranl number and MAC address.
> > + */
> > +static int odroid_setup_macaddr(void)
> > +{
> > +     struct mmc *mmc;
> > +     struct blk_desc *desc;
> > +     unsigned long mac_addr;
> > +     unsigned long count;
> > +     int ret;
> > +     u8 buf[512];
> > +
> > +     mmc =3D find_mmc_device(0);
> > +     if (!mmc)
> > +             return -ENODEV;
> > +
> > +     desc =3D mmc_get_blk_desc(mmc);
> > +
> > +     // Switch to the first BOOT partition
> > +     ret =3D blk_select_hwpart_devnum(UCLASS_MMC, 0, 1);
> > +     if (ret)
> > +             return -EIO;
> > +
> > +     count =3D blk_dread(desc, 0, 1, (void *)buf);
> > +
> > +     // Switch back to USER partition
> > +     ret =3D blk_dselect_hwpart(desc, 0);
> > +     if (ret || count !=3D 1)
> > +             return -EIO;
> > +
> > +     *(char *)(buf + 36) =3D 0;
> > +
> > +     // Serial number
> > +     env_set("serial#", (char *)buf);
> > +
> > +     // MAC address
> > +     mac_addr =3D cpu_to_be64(simple_strtoul((char *)buf + 24, NULL, 1=
6)) >> 16;
> > +
> > +     eth_env_set_enetaddr("ethaddr", (unsigned char *)&mac_addr);
> > +     eth_env_set_enetaddr("eth1addr", (unsigned char *)&mac_addr);
> > +
> > +     return 0;
> > +}
> > +
> > +int misc_init_r(void)
> > +{
> > +     const u32 cpuid_offset =3D CFG_CPUID_OFFSET;
> > +     const u32 cpuid_length =3D 0x10;
> > +     u8 cpuid[cpuid_length];
> > +     int ret;
> > +
> > +     ret =3D odroid_setup_macaddr();
> > +     if (ret) {
> > +             ret =3D rockchip_setup_macaddr();
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret =3D rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpu=
id);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D rockchip_cpuid_set(cpuid, cpuid_length);
> > +
> > +     return ret;
> > +}
> > +#endif
>
> I get build errors without "#include <common.h>":
>
> In file included from include/linux/byteorder/little_endian.h:14,
>                  from ./arch/arm/include/asm/byteorder.h:29,
>                  from include/asm-generic/unaligned.h:5,
>                  from ./arch/arm/include/asm/unaligned.h:2,
>                  from board/hardkernel/odroid_m1s/board.c:6:
> board/hardkernel/odroid_m1s/board.c: In function =E2=80=98odroid_setup_ma=
caddr=E2=80=99:
>   CC      drivers/adc/adc-uclass.o
> board/hardkernel/odroid_m1s/board.c:50:32: warning: implicit declaration =
of function =E2=80=98simple_strtoul=E2=80=99 [-Wimplicit-function-declarati=
on]
>    50 |         mac_addr =3D cpu_to_be64(simple_strtoul((char *)buf + 24,=
 NULL, 16)) >> 16;
>       |                                ^~~~~~~~~~~~~~
> include/linux/byteorder/swab.h:93:31: note: in definition of macro =E2=80=
=98__swab64=E2=80=99
>    93 | (__builtin_constant_p((__u64)(x)) ? \
>       |                               ^
> include/linux/byteorder/generic.h:92:21: note: in expansion of macro =E2=
=80=98__cpu_to_be64=E2=80=99
>    92 | #define cpu_to_be64 __cpu_to_be64
>       |                     ^~~~~~~~~~~~~
> board/hardkernel/odroid_m1s/board.c:50:20: note: in expansion of macro =
=E2=80=98cpu_to_be64=E2=80=99
>    50 |         mac_addr =3D cpu_to_be64(simple_strtoul((char *)buf + 24,=
 NULL, 16)) >> 16;
>       |                    ^~~~~~~~~~~
> board/hardkernel/odroid_m1s/board.c: In function =E2=80=98misc_init_r=E2=
=80=99:
> board/hardkernel/odroid_m1s/board.c:60:34: error: =E2=80=98CFG_CPUID_OFFS=
ET=E2=80=99 undeclared (first use in this function)
>    60 |         const u32 cpuid_offset =3D CFG_CPUID_OFFSET;
>       |                                  ^~~~~~~~~~~~~~~~
> board/hardkernel/odroid_m1s/board.c:60:34: note: each undeclared identifi=
er is reported only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:257: board/hardkernel/odroid_m1s/boa=
rd.o] Error 1
> make[1]: *** [Makefile:1859: board/hardkernel/odroid_m1s] Error 2
>

True. "#include <common.h>" is removed since "scripts/checkpatch.pl"
asked me not to add it.
So, I have to add "#include <vsprintf.h>" instead. :)

>
> > diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-r=
k3566_defconfig
> > new file mode 100644
> > index 00000000000..d70a10dc080
> > --- /dev/null
> > +++ b/configs/odroid-m1s-rk3566_defconfig
> > @@ -0,0 +1,109 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D24000000
> > +CONFIG_ARCH_ROCKCHIP=3Dy
> > +CONFIG_TEXT_BASE=3D0x00a00000
> > +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> > +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> > +CONFIG_NR_DRAM_BANKS=3D2
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xc00000
> > +CONFIG_SF_DEFAULT_SPEED=3D24000000
> > +CONFIG_SF_DEFAULT_MODE=3D0x1000
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3566-odroid-m1s"
> > +CONFIG_ROCKCHIP_RK3568=3Dy
> > +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy
> > +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
> > +CONFIG_SPL_SERIAL=3Dy
> > +CONFIG_SPL_STACK_R_ADDR=3D0x600000
> > +CONFIG_TARGET_ODROID_M1S_RK3566=3Dy
> > +CONFIG_SPL_STACK=3D0x400000
> > +CONFIG_DEBUG_UART_BASE=3D0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> > +CONFIG_SPL_SPI=3Dy
> > +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> > +CONFIG_PCI=3Dy
> > +CONFIG_DEBUG_UART=3Dy
> > +CONFIG_AHCI=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3566-odroid-m1s.dtb"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +CONFIG_SPL_PAD_TO=3D0x7f8000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > +CONFIG_SPL_BSS_START_ADDR=3D0x4000000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_STACK_R=3Dy
> > +CONFIG_SPL_SPI_LOAD=3Dy
> > +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x100000
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_I2C=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_PCI=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +# CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_INI=3Dy
> > +CONFIG_CMD_PMIC=3Dy
> > +CONFIG_CMD_REGULATOR=3Dy
> > +CONFIG_CMD_CRAMFS=3Dy
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_OF_LIVE=3Dy
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cl=
ocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > +CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +CONFIG_AHCI_PCI=3Dy
> > +CONFIG_DWC_AHCI=3Dy
> > +CONFIG_SPL_CLK=3Dy
> > +CONFIG_ROCKCHIP_GPIO=3Dy
> > +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_SDMA=3Dy
> > +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_SF_DEFAULT_BUS=3D4
> > +CONFIG_PHY_REALTEK=3Dy
> > +CONFIG_DWC_ETH_QOS=3Dy
> > +CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
> > +CONFIG_NVME_PCI=3Dy
> > +CONFIG_PCIE_DW_ROCKCHIP=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
> > +CONFIG_PHY_ROCKCHIP_PCIE=3Dy
> > +CONFIG_SPL_PINCTRL=3Dy
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_PMIC_RK8XX=3Dy
> > +CONFIG_REGULATOR_RK8XX=3Dy
> > +CONFIG_PWM_ROCKCHIP=3Dy
> > +CONFIG_SPL_RAM=3Dy
> > +CONFIG_SCSI=3Dy
> > +CONFIG_DM_SCSI=3Dy
>
> DM_SCSI have been migrated to SCSI and can be dropped.
>

Ok.

> > +CONFIG_BAUDRATE=3D1500000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_GENERIC=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_GENERIC=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_FS_CRAMFS=3Dy
> > +CONFIG_ERRNO_STR=3Dy
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x0800
>
> This does not correspont to SPL_PAD_TO, so the generated
> u-boot-rockchip.bin have FIT at wrong offset and I get the following
> error on my board:
>
>   U-Boot SPL 2024.01 (Jan 25 2024 - 11:43:22 +0000)
>   Trying to boot from MMC2
>   mmc_load_image_raw_sector: mmc block read error
>   Trying to boot from MMC1
>   mmc_load_image_raw_sector: mmc block read error
>   SPL: failed to boot from all boot devices
>   ### ERROR ### Please RESET the board ###
>
> Please drop this and accept the default 0x4000 value.
>

0x0800 is from the partition layout for Hardkernel's OS image, but sure...
0x4000 can be acceptable for future.

> Regards,
> Jonas
>
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockc=
hip.rst
> > index 18d0b6f0891..3ce9966fc13 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -93,6 +93,7 @@ List of mainline supported Rockchip boards:
> >
> >  * rk3566
> >       - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
> > +     - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
> >       - Pine64 Quartz64-A Board (quartz64-a-rk3566)
> >       - Pine64 Quartz64-B Board (quartz64-b-rk3566)
> >       - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
> > diff --git a/include/configs/odroid_m1s.h b/include/configs/odroid_m1s.=
h
> > new file mode 100644
> > index 00000000000..b2718613886
> > --- /dev/null
> > +++ b/include/configs/odroid_m1s.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef __ODROID_M1S_H
> > +#define __ODROID_M1S_H
> > +
> > +#include <configs/rk3568_common.h>
> > +
> > +#define ROCKCHIP_DEVICE_SETTINGS \
> > +             "stdout=3Dserial\0" \
> > +             "stderr=3Dserial\0"
> > +
> > +#endif
>

Thank you,
Dongjin Kim.
