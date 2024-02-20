Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF31BC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 19:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C634588008;
	Tue, 20 Feb 2024 20:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lb+gKQHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C59788001; Tue, 20 Feb 2024 20:15:05 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2353487FF6
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 20:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d220ad10b3so49817931fa.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708456499; x=1709061299; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRgboJSmymKVgxZ1RdekP5U3dGx7PPfsJFn4b7GRj/A=;
 b=Lb+gKQHuDpPDl6FCEjxcL4VAK5IS1Ez9fyz4xBIfLQhQnOG/FKnYpwc75M4ChpOkCg
 wqJb1Qe6qUKkU0MpdQN56S216Y1Dy39kbw71TUvIMZai5Ve3aahTIMKvtB5cEd3Oj1Th
 TZN/cBKw6wNdvbsv6E1dgYvGn7XGFJ+3goIARtuWoBWD7SzmtzbyJ/LhJlRq0/vN8w0Z
 voNkeO1lMOV0y48hPPEk25jcosyyatXE6MGBOJMrT6g9rEup39XPoLZG4gvUHhl5gz0v
 6dddyptxNyvJkRRglbyNlA94y9ijsgLO5BpAEkd8QSSeaaSslO7vYesy+84unADhEfup
 r5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708456499; x=1709061299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRgboJSmymKVgxZ1RdekP5U3dGx7PPfsJFn4b7GRj/A=;
 b=YetAiORO4gNQ+tf7LkApERm0lUSNrFo+n3sSJoZNSe2GfCVctISqvS/Yx/0qGoh24Y
 lgvhh7PI9UNFO4zUNocimvEPmq6w818a/mOKiSpiMSnySuuZ5mvGcChiemwL0NlKIlHT
 Q6pxrtoNhQZpPFdJYP9SYL7m0dKHrXbEX1+MvxLUKvo8KvAoOsyxAcjbvO3kmDFk8tnw
 o1W+oROKZWbViABlwMNCY7CnSjDEeA1+sr2SeFBvbnR8lB9lNtFIME27yPut1Nkzes2t
 jUVU7oj6ZsNLjio3eeuKeAqcEWJh02A3bUD9pqFia2sbUnwgHG3wJaVavsopGnNUP/c/
 KjqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFPMYs0flqAWbAigJCW8FjMhvp+wKUvaEv4SAcayx8WlZST65Qfd6KwEwIT6/6Ouot6ngAKVeqEqvZDSZhlcQyWmwGpQ==
X-Gm-Message-State: AOJu0YxdrId+PMzaBFcS9e7LEHmg2g86BcfodV2vQCxILQNhg3L6lR+B
 v3WoKtXuBkwZSfKaTnE86odBsmZFxrp9+ayIN+H8BI5dNDjA0TDhao6x9e3ivUp157foOpxmzTK
 vl9304bVxfXzfhdxTXPZWMOyeguQYV9gn
X-Google-Smtp-Source: AGHT+IHLDd3CN0ZE3W7SDEEm5ZYaTe7FmN8eQuzZlNDRSSmA/FAYR28ymjxLBZ2kkbpkZYARsw1Pb1Ryxk+gq7+ZDaQ=
X-Received: by 2002:a2e:9592:0:b0:2d2:3573:27e6 with SMTP id
 w18-20020a2e9592000000b002d2357327e6mr4808967ljh.35.1708456499005; Tue, 20
 Feb 2024 11:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20240220182926.101161-1-francesco@dolcini.it>
 <20240220182926.101161-6-francesco@dolcini.it>
In-Reply-To: <20240220182926.101161-6-francesco@dolcini.it>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 20 Feb 2024 21:14:47 +0200
Message-ID: <CAPVz0n1oQZR5muRGHFm66hY6jEA8cSVUdJG0t2WTqV=oC6DiEA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] toradex: common: Add sysinfo driver
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

=D0=B2=D1=82, 20 =D0=BB=D1=8E=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 20:29 Fran=
cesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> This commit introduces support for the Toradex sysinfo driver in U-Boot,
> which uses information from Toradex config block to print correct
> board model.
> In case the Toradex config block is not present sysinfo prints the model
> of the board provided by device tree removing per board specific prints.
>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi    |  6 +++
>  arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi  |  6 +++
>  .../dts/imx6dl-colibri-eval-v3-u-boot.dtsi    |  4 ++
>  arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi    |  4 ++
>  .../dts/imx6ull-colibri-eval-v3-u-boot.dtsi   |  4 ++
>  .../arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |  4 ++
>  .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |  4 ++
>  .../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    |  4 ++
>  .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  4 ++
>  arch/arm/dts/tegra124-apalis-u-boot.dtsi      | 12 +++++
>  arch/arm/dts/tegra20-colibri-u-boot.dtsi      | 12 +++++
>  arch/arm/dts/tegra30-apalis-u-boot.dtsi       | 12 +++++
>  arch/arm/dts/tegra30-colibri-u-boot.dtsi      | 12 +++++
>  .../arm/dts/vf610-colibri-eval-v3-u-boot.dtsi |  4 ++
>  board/toradex/common/Kconfig                  |  1 +
>  board/toradex/common/tdx-common.c             | 50 ++++++++++++++++---
>  16 files changed, 136 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/dts/tegra124-apalis-u-boot.dtsi
>  create mode 100644 arch/arm/dts/tegra20-colibri-u-boot.dtsi
>  create mode 100644 arch/arm/dts/tegra30-apalis-u-boot.dtsi
>  create mode 100644 arch/arm/dts/tegra30-colibri-u-boot.dtsi
>

Greetings! Thank you for contribution but may you at split patches
according to SoC vendor at least? For imx, tegra and ti since it
would be hard to both review and pick them to correct custodian
trees.

> diff --git a/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi b/arch/arm/dts/fs=
l-imx8qm-apalis-u-boot.dtsi
> index c54a59e89c5d..d73be74d2112 100644
> --- a/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
> +++ b/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
> @@ -3,6 +3,12 @@
>   * Copyright 2019 Toradex AG
>   */
>
> +/ {
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +};
> +
>  &mu {
>         bootph-some-ram;
>  };
> diff --git a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi b/arch/arm/dts/=
fsl-imx8qxp-colibri-u-boot.dtsi
> index 6ab6b1f9ee69..60c4cd6fc01f 100644
> --- a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> +++ b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> @@ -3,6 +3,12 @@
>   * Copyright 2019 Toradex AG
>   */
>
> +/ {
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +};
> +
>  &{/imx8qx-pm} {
>
>         bootph-some-ram;
> diff --git a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi b/arch/arm/d=
ts/imx6dl-colibri-eval-v3-u-boot.dtsi
> index 0eea4d1862ae..5a91d0aca204 100644
> --- a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
> +++ b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
> @@ -16,6 +16,10 @@
>                 mmc0 =3D &usdhc3;
>                 mmc1 =3D &usdhc1;
>         };
> +
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
>  };
>
>  &wdog1 {
> diff --git a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi b/arch/arm/dts/im=
x6q-apalis-eval-u-boot.dtsi
> index 3c6e503d043b..59412635420a 100644
> --- a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
> +++ b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
> @@ -19,6 +19,10 @@
>                 mmc1 =3D &usdhc1;
>                 mmc2 =3D &usdhc2;
>         };
> +
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
>  };
>
>  &wdog1 {
> diff --git a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi b/arch/arm/=
dts/imx6ull-colibri-eval-v3-u-boot.dtsi
> index 6823b42d4514..731814216e1f 100644
> --- a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
> +++ b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
> @@ -9,6 +9,10 @@
>                 usb0 =3D &usbotg1; /* required for ums */
>                 display0 =3D &lcdif;
>         };
> +
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
>  };
>
>  &pinctrl_uart1 {
> diff --git a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi b/arch/arm/dt=
s/imx7d-colibri-eval-v3-u-boot.dtsi
> index b2c12a413daf..68142769d360 100644
> --- a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
> +++ b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
> @@ -11,6 +11,10 @@
>                 mmc0 =3D &usdhc3;
>                 mmc1 =3D &usdhc1;
>         };
> +
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
>  };
>
>  &lcdif {
> diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/d=
ts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> index 515f195ab759..38db56059d69 100644
> --- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> @@ -12,6 +12,10 @@
>                 eeprom2 =3D &eeprom_display_adapter;
>         };
>
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +
>         wdt-reboot {
>                 compatible =3D "wdt-reboot";
>                 bootph-pre-ram;
> diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/d=
ts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> index 67f1d45ce269..03f211d5f7d3 100644
> --- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> @@ -12,6 +12,10 @@
>                 eeprom2 =3D &eeprom_display_adapter;
>         };
>
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +
>         wdt-reboot {
>                 compatible =3D "wdt-reboot";
>                 bootph-pre-ram;
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm=
/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> index 02f34c90c6d7..28b697b67ae0 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> @@ -19,6 +19,10 @@
>         memory@80000000 {
>                 bootph-all;
>         };
> +
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
>  };
>
>  &main_timer0 {
> diff --git a/arch/arm/dts/tegra124-apalis-u-boot.dtsi b/arch/arm/dts/tegr=
a124-apalis-u-boot.dtsi
> new file mode 100644
> index 000000000000..a3614d279439
> --- /dev/null
> +++ b/arch/arm/dts/tegra124-apalis-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2023 Toradex
> + */
> +
> +#include "tegra124-u-boot.dtsi"
> +
> +/ {
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +};
> diff --git a/arch/arm/dts/tegra20-colibri-u-boot.dtsi b/arch/arm/dts/tegr=
a20-colibri-u-boot.dtsi
> new file mode 100644
> index 000000000000..d4a669a288d8
> --- /dev/null
> +++ b/arch/arm/dts/tegra20-colibri-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2023 Toradex
> + */
> +
> +#include "tegra20-u-boot.dtsi"
> +
> +/ {
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +};
> diff --git a/arch/arm/dts/tegra30-apalis-u-boot.dtsi b/arch/arm/dts/tegra=
30-apalis-u-boot.dtsi
> new file mode 100644
> index 000000000000..37cbfbcc3506
> --- /dev/null
> +++ b/arch/arm/dts/tegra30-apalis-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2023 Toradex
> + */
> +
> +#include "tegra30-u-boot.dtsi"
> +
> +/ {
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +};
> diff --git a/arch/arm/dts/tegra30-colibri-u-boot.dtsi b/arch/arm/dts/tegr=
a30-colibri-u-boot.dtsi
> new file mode 100644
> index 000000000000..37cbfbcc3506
> --- /dev/null
> +++ b/arch/arm/dts/tegra30-colibri-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2023 Toradex
> + */
> +
> +#include "tegra30-u-boot.dtsi"
> +
> +/ {
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
> +};
> diff --git a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi b/arch/arm/dt=
s/vf610-colibri-eval-v3-u-boot.dtsi
> index 572d40877ef9..8c3b86c201fa 100644
> --- a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
> +++ b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
> @@ -7,6 +7,10 @@
>         soc {
>                 bootph-all;
>         };
> +
> +       sysinfo {
> +               compatible =3D "toradex,sysinfo";
> +       };
>  };
>
>  &aips0 {
> diff --git a/board/toradex/common/Kconfig b/board/toradex/common/Kconfig
> index 1f6a5e4db561..b85893ab44e4 100644
> --- a/board/toradex/common/Kconfig
> +++ b/board/toradex/common/Kconfig
> @@ -4,6 +4,7 @@
>  menuconfig TDX_CFG_BLOCK
>         bool "Enable Toradex config block support"
>         select OF_BOARD_SETUP
> +       select SYSINFO
>         help
>           The Toradex config block stored production data on the on-modul=
e
>           flash device (NAND, NOR or eMMC). The area is normally preserve=
d by
> diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx=
-common.c
> index 6084436b48b4..1f3253f4222e 100644
> --- a/board/toradex/common/tdx-common.c
> +++ b/board/toradex/common/tdx-common.c
> @@ -3,15 +3,16 @@
>   * Copyright (c) 2016 Toradex, Inc.
>   */
>
> +#include <dm.h>
>  #include <common.h>
>  #include <env.h>
>  #include <g_dnl.h>
>  #include <init.h>
>  #include <linux/libfdt.h>
> +#include <sysinfo.h>
>
>  #ifdef CONFIG_VIDEO
>  #include <bmp_logo.h>
> -#include <dm.h>
>  #include <splash.h>
>  #include <video.h>
>  #endif
> @@ -103,13 +104,8 @@ __weak int print_bootinfo(void)
>
>  int checkboard(void)
>  {
> -       if (valid_cfgblock) {
> -               printf("Model: Toradex %04d %s %s\n",
> -                      tdx_hw_tag.prodid,
> -                      toradex_modules[tdx_hw_tag.prodid].name,
> -                      tdx_board_rev_str);
> +       if (valid_cfgblock)
>                 printf("Serial#: %s\n", tdx_serial_str);
> -       }
>
>  #ifdef CONFIG_TDX_CFG_BLOCK_EXTRA
>         if (tdx_carrier_board_name)
> @@ -188,6 +184,46 @@ static int settings_r(void)
>  }
>  EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
>
> +static int tdx_detect(struct udevice *dev)
> +{
> +       return valid_cfgblock ? 0 : -EINVAL;
> +}
> +
> +static int tdx_get_str(struct udevice *dev, int id, size_t size, char *v=
al)
> +{
> +       int ret =3D -ENOTSUPP;
> +
> +       switch (id) {
> +       case SYSINFO_ID_BOARD_MODEL:
> +               snprintf(val, size,
> +                        "Toradex %04d %s %s",
> +                        tdx_hw_tag.prodid,
> +                        toradex_modules[tdx_hw_tag.prodid].name,
> +                        tdx_board_rev_str);
> +
> +               ret =3D 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct udevice_id sysinfo_tdx_ids[] =3D {
> +       { .compatible =3D "toradex,sysinfo" },
> +       { /* sentinel */ }
> +};
> +
> +static const struct sysinfo_ops sysinfo_tdx_ops =3D {
> +       .detect         =3D tdx_detect,
> +       .get_str        =3D tdx_get_str,
> +};
> +
> +U_BOOT_DRIVER(sysinfo_toradex) =3D {
> +       .name           =3D "sysinfo_toradex",
> +       .id             =3D UCLASS_SYSINFO,
> +       .of_match       =3D sysinfo_tdx_ids,
> +       .ops            =3D &sysinfo_tdx_ops,
> +};
> +
>  #ifdef CONFIG_TDX_CFG_BLOCK_USB_GADGET_PID
>  int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name=
)
>  {
> --
> 2.39.2
>
