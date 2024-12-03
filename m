Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84198E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051608968D;
	Tue,  3 Dec 2024 20:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAWs0Lg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC69B89655; Tue,  3 Dec 2024 20:16:09 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D635895BD
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ffc76368c6so91277771fa.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733253367; x=1733858167; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNCCWrrPMnlIGNn1af+r8PDJmWchrSKcx2EFG9OlWHs=;
 b=gAWs0Lg7IjPfgxQT0466/uvP3Jz8uXbpHSZgl0P7+wpFjAlCVbRNKK1+AqgW/ugOfg
 UZUPNdJRaZkYMfgvDsdSL205tp+fNR0rwT9wVYUx9XYUVB07xkBM9M7sWmbqcaTrVbAH
 nMDjtqsd9V0M9uH7z/lr6/IjtTMtBaNSL2Kvgg366YsISAfipZ3wxH8cUB7TuP48UfxJ
 1tloLqddVYS8Iz01mE2PFvVHjX/WWCmp/GdKRr7Bwq8pOTUFRd/kPqDg8hL4gWhWHSg4
 KGCaT4Tf7nQ33yNn/55NLqV1JXNpn4vJcrzOobF7LH8RUluT2FC1oiZVXUd6YBPgczWb
 bW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733253367; x=1733858167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNCCWrrPMnlIGNn1af+r8PDJmWchrSKcx2EFG9OlWHs=;
 b=P6/gJcToeD5gF48nUzapUHNwMhEHJywQ/rcpdwBZNIma2qMHoqL2/7KGRSNCsejOVu
 5MREdzx83jqjHFftP8R+Z5wgGeG1tZjfgIuxo/+VS71nTcrop+5xrIqnX+QQZilSmKnb
 k97SHh8ibkTVOh7F7T1oCUCx2uVizkm+STBAQFCWqVf6nouE/d9hC68B+QBjeBD9mJy5
 8rmNXCDxdRXya3IrXHaZO7dlCokvBkLxVrrH3XWL5cv/pJWCDJJA6i2GzIrZKr3ZANI7
 kzl7Jk3c66CWjLJ5wOLd++DyOJoF/UV7+wh3AxCwGs4W2FH/S5tARkeUoY1La4qlqWnL
 pGlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW0Ivp2V0GQI5Web7O8G7V9hX/4tspfiHbL87RToag47DTb9xnkipuv0r3Xze9P4fkjNIbee4=@lists.denx.de
X-Gm-Message-State: AOJu0YzNW0c8gX7QWnwIn9mDBoQYi/W4KsxbvXzEV1g3rRxGi0HmbJsb
 lNyb31fO/YuvFweTBe0bNJufjTEX6jNp11fTYF0d5K12Z97zFQ1nNRnbg683VC+JVjO3eN0Gin9
 HSdAcUppVRIiZUKd0GBY72nY1efQ=
X-Gm-Gg: ASbGncuQ1IHnW233TIRcwXvWjHiXC3ys3up4Me156wjlND5v7hwek8xuSJan2tslFvH
 21b+zPcvwlpJF8lubDTeUJRAuFaLw64rLPWXNpfzf2MzzBtoCMJYHxvhLmb13AeO2ew==
X-Google-Smtp-Source: AGHT+IEAhr0U89qRUZW5ctRCk4ivp36UWdrHzEwYwTQaTaf73aQDcIwxYRKKPxC5Mu+xG5pOpEQnhKyp9u87Cf/Ay3k=
X-Received: by 2002:a2e:bea2:0:b0:2ff:d821:3398 with SMTP id
 38308e7fff4ca-30009caa1c4mr37960031fa.21.1733253366516; Tue, 03 Dec 2024
 11:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <20241203030430.26089-6-hal.feng@starfivetech.com>
In-Reply-To: <20241203030430.26089-6-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 3 Dec 2024 11:15:55 -0800
Message-ID: <CANV2PTOxKz33x4vNioD0rqkTCGTKhdbNHo6eJFrCxn5yq6SX0Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:40:44 +0100
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

On Mon, Dec 2, 2024 at 7:06=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com>=
 wrote:
>
> To support JH7110 based boards besides v1.3B,
> add a common dtsi and add common code to it.
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: E Shattow <lucent@gmail.com>
> Reviewed-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 142 ++++++++++++++++++
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 138 +----------------
>  2 files changed, 143 insertions(+), 137 deletions(-)
>  create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
>
> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh=
7110-common-u-boot.dtsi
> new file mode 100644
> index 0000000000..7953459e67
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + */
> +
> +#include "binman.dtsi"
> +#include "jh7110-u-boot.dtsi"
> +/ {
> +       aliases {
> +               spi0 =3D &qspi;
> +       };
> +
> +       chosen {
> +               bootph-pre-ram;
> +       };
> +
> +       firmware {
> +               spi0 =3D &qspi;
> +               bootph-pre-ram;
> +       };
> +
> +       config {
> +               bootph-pre-ram;
> +               u-boot,spl-payload-offset =3D <0x100000>;
> +       };
> +
> +       memory@40000000 {
> +               bootph-pre-ram;
> +       };
> +};
> +
> +&uart0 {
> +       bootph-pre-ram;
> +       reg-offset =3D <0>;
> +       current-speed =3D <115200>;
> +       clock-frequency =3D <24000000>;
> +};
> +
> +&mmc0 {
> +       bootph-pre-ram;
> +};
> +
> +&mmc1 {
> +       bootph-pre-ram;
> +};
> +
> +&qspi {
> +       bootph-pre-ram;

> +       spi-max-frequency =3D <250000000>;

Drop this line spi-max-frequency 250Mhz. The driver expects
spi-max-frequency in any sub-node, and not here?

> +
> +       flash@0 {
> +               bootph-pre-ram;

> +               /delete-property/ cdns,read-delay;

Drop this line /delete-property/ because it is a problem for the
parser if we need to re-define 'cdns,read-delay' later in dts files
downstream of jh7110-common-u-boot.dtsi

If you want drivers/spi/cadence_qspi.c:spi_calibration() to do this
work then it needs to be the same upstream. In my testing on 4GB
Star64 the calibration (via /delete-property/ cdns,read-delay) method
with spi-max-frequency less than exactly 49.8MHz results in a failure
to write SPI-NOR correctly. When spi-max-frequency is approximately
25MHz up to 49.799999MHz and written with a known good tool then the
boot may be successful but "Main section boot fail,use backup section"
or other errors on boot after using that unstable configuration of
U-Boot to write U-Boot image to the SPI-NOR. No problems writing and
boot during testing with spi-max-frequency 49.8MHz up to 100MHz (not
tested above 100MHz).

The upstream dts has spi-max-frequency 12MHz which is not successful
with any of the read-delay values I tested: 0 1 2 3 4 5

> +               spi-max-frequency =3D <100000000>;

Why 12MHz upstream and 100MHz here? Something is wrong but I do not
know is it U-Boot or Linux?

Success:
+             /delete-property/ cdns,read-delay;
+             spi-max-frequency =3D <100000000>;

Success:
+             cdns,read-delay =3D <2>;
-             /delete-property/ cdns,read-delay;
+             spi-max-frequency =3D <100000000>;

Failure:
+             cdns,read-delay =3D <2>;
+             spi-max-frequency =3D <50000000>;

The actual fix is going to need testing Linux and U-Boot on all the
boards I do not have access to.

For the moment we can:
-             /delete-property/ cdns,read-delay;
+             cdns,read-delay =3D <2>;
+             spi-max-frequency =3D <100000000>;

or do nothing (but yes please drop that 250Mhz line it is non-op I think).

What do you think?  Or else we discuss here and follow with patches in
future to fix the mess. I really do not want any /delete-property/ to
be in dtsi but I don't know why it is so different between U-Boot and
Linux and cannot personally test all the possible boards to verify a
change.

> +       };
> +};
> +
> +&syscrg {
> +       assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_QSPI_REF>;
> +       assigned-clock-parents =3D <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +                                <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> +       assigned-clock-rates =3D <0>, <0>, <0>, <0>;
> +};
> +
> +&sysgpio {
> +       bootph-pre-ram;
> +};
> +
> +&mmc0_pins {
> +       bootph-pre-ram;
> +       rst-pins {
> +               bootph-pre-ram;
> +       };
> +};
> +
> +&mmc1_pins {
> +       bootph-pre-ram;
> +       clk-pins {
> +               bootph-pre-ram;
> +       };
> +
> +       mmc-pins {
> +               bootph-pre-ram;
> +       };
> +};
> +
> +&i2c5_pins {
> +       bootph-pre-ram;
> +       i2c-pins {
> +               bootph-pre-ram;
> +       };
> +};
> +
> +&i2c5 {
> +       bootph-pre-ram;
> +       eeprom@50 {
> +               bootph-pre-ram;
> +               compatible =3D "atmel,24c04";
> +               reg =3D <0x50>;
> +               pagesize =3D <16>;
> +       };
> +};
> +
> +&binman {
> +       itb {
> +               fit {
> +                       images {
> +                               fdt-1 {
> +                                       description =3D "NAME";
> +                                       load =3D <0x40400000>;
> +                                       compression =3D "none";
> +
> +                                       uboot_fdt_blob: blob-ext {
> +                                               filename =3D "u-boot.dtb"=
;
> +                                       };
> +                               };
> +                       };
> +
> +                       configurations {
> +                               conf-1 {
> +                                       fdt =3D "fdt-1";
> +                               };
> +                       };
> +               };
> +       };
> +
> +       spl-img {
> +               filename =3D "spl/u-boot-spl.bin.normal.out";
> +
> +               mkimage {
> +                       args =3D "-T sfspl";
> +
> +                       u-boot-spl {
> +                       };
> +               };
> +       };
> +};
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dts=
i b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> index 7953459e67..e6bc6630dc 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> @@ -3,140 +3,4 @@
>   * Copyright (C) 2023 StarFive Technology Co., Ltd.
>   */
>
> -#include "binman.dtsi"
> -#include "jh7110-u-boot.dtsi"
> -/ {
> -       aliases {
> -               spi0 =3D &qspi;
> -       };
> -
> -       chosen {
> -               bootph-pre-ram;
> -       };
> -
> -       firmware {
> -               spi0 =3D &qspi;
> -               bootph-pre-ram;
> -       };
> -
> -       config {
> -               bootph-pre-ram;
> -               u-boot,spl-payload-offset =3D <0x100000>;
> -       };
> -
> -       memory@40000000 {
> -               bootph-pre-ram;
> -       };
> -};
> -
> -&uart0 {
> -       bootph-pre-ram;
> -       reg-offset =3D <0>;
> -       current-speed =3D <115200>;
> -       clock-frequency =3D <24000000>;
> -};
> -
> -&mmc0 {
> -       bootph-pre-ram;
> -};
> -
> -&mmc1 {
> -       bootph-pre-ram;
> -};
> -
> -&qspi {
> -       bootph-pre-ram;
> -       spi-max-frequency =3D <250000000>;
> -
> -       flash@0 {
> -               bootph-pre-ram;
> -               /delete-property/ cdns,read-delay;
> -               spi-max-frequency =3D <100000000>;
> -       };
> -};
> -
> -&syscrg {
> -       assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> -                         <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> -                         <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> -                         <&syscrg JH7110_SYSCLK_QSPI_REF>;
> -       assigned-clock-parents =3D <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> -                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> -                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> -                                <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> -       assigned-clock-rates =3D <0>, <0>, <0>, <0>;
> -};
> -
> -&sysgpio {
> -       bootph-pre-ram;
> -};
> -
> -&mmc0_pins {
> -       bootph-pre-ram;
> -       rst-pins {
> -               bootph-pre-ram;
> -       };
> -};
> -
> -&mmc1_pins {
> -       bootph-pre-ram;
> -       clk-pins {
> -               bootph-pre-ram;
> -       };
> -
> -       mmc-pins {
> -               bootph-pre-ram;
> -       };
> -};
> -
> -&i2c5_pins {
> -       bootph-pre-ram;
> -       i2c-pins {
> -               bootph-pre-ram;
> -       };
> -};
> -
> -&i2c5 {
> -       bootph-pre-ram;
> -       eeprom@50 {
> -               bootph-pre-ram;
> -               compatible =3D "atmel,24c04";
> -               reg =3D <0x50>;
> -               pagesize =3D <16>;
> -       };
> -};
> -
> -&binman {
> -       itb {
> -               fit {
> -                       images {
> -                               fdt-1 {
> -                                       description =3D "NAME";
> -                                       load =3D <0x40400000>;
> -                                       compression =3D "none";
> -
> -                                       uboot_fdt_blob: blob-ext {
> -                                               filename =3D "u-boot.dtb"=
;
> -                                       };
> -                               };
> -                       };
> -
> -                       configurations {
> -                               conf-1 {
> -                                       fdt =3D "fdt-1";
> -                               };
> -                       };
> -               };
> -       };
> -
> -       spl-img {
> -               filename =3D "spl/u-boot-spl.bin.normal.out";
> -
> -               mkimage {
> -                       args =3D "-T sfspl";
> -
> -                       u-boot-spl {
> -                       };
> -               };
> -       };
> -};
> +#include "jh7110-common-u-boot.dtsi"
> --
> 2.43.2
>

-E
