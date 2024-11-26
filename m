Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A906D3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE64189354;
	Tue, 26 Nov 2024 16:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlTkkzJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7F0893B7; Tue, 26 Nov 2024 16:25:07 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CDCD8932F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ff589728e4so72395201fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732634704; x=1733239504; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YuZPmeaeNioeJ5o1PfgeLdmwzHmGy/bI6A6kgdEiqY=;
 b=YlTkkzJdyMVzCe6a7E2azAB7SepOwAIduJHsuEtw7khpm+KS5iyIQb9XDuYl9Lq4PC
 mYbLZHKaOyr4mX+r4ADNnSRzRw6JXU5dD+xGHoNJhisoZsLGdf9xGMqnUaMMxV6ch+7v
 sV3bLvcEFhJL7KsCjuxnaw3yhapR8PPdVuRiBqiBnhPlvaYzMciriC+cgvFb7ifljo+N
 yBDo2Dn7BPHwQ9+a0PBx6bMJwKvz9uKe6kmL5v4TZf6li1BVCo1xC1FvzntVrNGAgA/z
 tN6vbMO8GbAGgodhsAF/4cs19g6aCZsV58t4PGmFlRw3Ue5MtfroOd9D6TNgHmEoPUnA
 20LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732634704; x=1733239504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YuZPmeaeNioeJ5o1PfgeLdmwzHmGy/bI6A6kgdEiqY=;
 b=MHnPKhqKMrbJkfphJW/xnCQ3DcakcpDsAR4MMaKQg3CQygCXpxbFuic+6Ntkk2xHZN
 M+qW6rJHKQONUn4fk6wQnWwpR/XTsIaEdPQEoHeOpPTPR95b0ZQSRx+hGuHoDtKLBJjn
 rIN3jHQayUhVio3TqqbNYDOzXzi5d9fswYKxlMT8Psw16kIrch6/RHynWK68ag6Ekqvt
 5Enu4Q8iFTFuqz0/m801ZqrC5AFZphKa6L0HzA+XGGxHRjJ2GvJtgDms1frYhQ+GA4XP
 bsfH9RV+GFzmD8RAa33c1/qTkobPL4GH5CKIt8iT07BOJP3PerzfjaTLGd+1ElNed7pY
 U6Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTuaPwNbhROyMHONq7EL3fH0LwTKPeXXk1pYtgtdtHOU62XoR1U5CpLnQhpl0li2D4+e8m8gs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2ORFiMsUXbqqnovG8y76gCvOkcOs6s6Ud8cIULO82c7iSjPFD
 6twdP5OlccHunmNsCZ2Ol5mlYBiJMZ8rBPNmXxZwrNDEkG21SqREt4Sav0qwih62mye29dycIFH
 UW/xaeFT9Qlto0ds9fXbT2UV0P+8=
X-Gm-Gg: ASbGncsBomOJZwq+mFVBOofnSOtkpypr6fgJnNBFj0r0kE9h2jAPjBXhwyQtD3fOi7x
 R9lo52qHR1qa16TX6XXno3Yzmq6bZmO0bRGHjcnFT3A8w8s6FN+dTD6bX2lUYhQn10g==
X-Google-Smtp-Source: AGHT+IH9zPwEcrZQVvBOBCn4DuBZFjkcrIl4YVTI6SonD/jS3BDMC+Qc7utf0XpmLxJMyg4TKszvLyuXfDjE4Rr3ehQ=
X-Received: by 2002:a2e:be9a:0:b0:2ef:28ed:1ff5 with SMTP id
 38308e7fff4ca-2ffcc31e661mr10380051fa.15.1732634704348; Tue, 26 Nov 2024
 07:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
 <20241125003205.75327-5-hal.feng@starfivetech.com>
In-Reply-To: <20241125003205.75327-5-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 26 Nov 2024 07:24:53 -0800
Message-ID: <CANV2PTNCk5rp-NqnYmXztjGQBvAz4U=uvNhVNziXq9hONOdqYQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] riscv: dts: jh7110: Move common code to the new
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

On Sun, Nov 24, 2024 at 4:33=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> To support JH7110 based boards besides v1.3B,
> add a common dtsi and add common code to it.
>
> Tested-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 144 ++++++++++++++++++
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 140 +----------------
>  2 files changed, 145 insertions(+), 139 deletions(-)
>  create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
>
> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh=
7110-common-u-boot.dtsi
> new file mode 100644
> index 0000000000..c44553455e
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> @@ -0,0 +1,144 @@
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
> +       compatible =3D "snps,dw-mshc";
> +};
> +
> +&mmc1 {
> +       bootph-pre-ram;
> +       compatible =3D "snps,dw-mshc";
> +};

Following this series being applied should be an enhancement to add
the U-Boot JH7110 MMC driver wrapper and factor out this override.
Okay for now.

> +
> +&qspi {
> +       bootph-pre-ram;
> +       spi-max-frequency =3D <250000000>;
> +
> +       flash@0 {
> +               bootph-pre-ram;
> +               /delete-property/ cdns,read-delay;
> +               spi-max-frequency =3D <100000000>;
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

(repeating my comment from "[PATCH v6 02/11] riscv: dts: jh7110: Make
u-boot device trees adapting to upstream DT")

In some configurations with RTC there is a conflict in the addressing
with EEPROM, as in:

https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b2=
5843786012351b3f35519

Okay to keep this for now, a conflict is the exception and not the
normal situation. Refactor this out of U-Boot when EEPROM node is sent
upstream to Linux.



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
> index c44553455e..e6bc6630dc 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> @@ -3,142 +3,4 @@
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
> -       compatible =3D "snps,dw-mshc";
> -};
> -
> -&mmc1 {
> -       bootph-pre-ram;
> -       compatible =3D "snps,dw-mshc";
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

Reviewed-by: E Shattow <lucent@gmail.com>
