Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE7CC6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 17:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D8F283F7F;
	Tue, 29 Aug 2023 19:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TA+c65s2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4F981FA8; Tue, 29 Aug 2023 19:07:10 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33148650A
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 19:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so490880a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693328823; x=1693933623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJO8mHmHqpIVYt/s+2VyyPlyGWA4kL5wt/o/vsQ7OJ0=;
 b=TA+c65s2YeS8UiGSoKhXkq7fX5dEXh3XuZrW5XuGb/IeOSaE9Cj9hSiWq6FXRAgMc7
 oWLfEaIvb4exGzFiSOxkFrphMW9J9o74kwxEszwfzgY3rXsO87AS5L8HlILs0tPhrCzb
 9xSCA5VlLtL/hvBpP7Lp8FOdvnyZHgjfTSzJlsyBlTuM5xK3XnRWGUSUnWmsYQvlJhiE
 ofrxRFFpS/ALWx0t+xwJvnMNJ10PORAWxnckLDWjM32gdyVFuVH/G3nTmY3Q3xFvsl2G
 UW2XU7aXFUX2pHUoCcVncF9bvaJy3GwBTlpEeuLE4dlMWX8srKHwXlWyCtkO0PL8ZkTF
 mMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328823; x=1693933623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJO8mHmHqpIVYt/s+2VyyPlyGWA4kL5wt/o/vsQ7OJ0=;
 b=bZEmVXuFItCYCfYBxDcqlWK2B0Q06wCC7U34mEILc0pOd4T5LWX+2tTISXR2nC3pAb
 +4C38P/M4lyGLJv7mg0mPVPK9hR0BPLsjT+Zg6zOPb8Q8SnE+8TglBifxpuTy205K17s
 o3Ke13JT9+epnUL1u1mwzWoNV+yoPY8QXKqTJY7IKigB0tnLkkVSnUaT+YiHdUKg/m0j
 calH5UCMCSlOCHltu4y0huoWePoCIsZ+tOLVhuUbHqRLUkkJFBPb3Yj2LAVGH+UvdX3j
 6oPbsie+qn2oucz2dVMeF43EuDfE8+H1vNC4mcSuku/C1ALp9yeVCF/sVH/soFi7n5om
 aBtA==
X-Gm-Message-State: AOJu0Yz5Qj/gPAQk2TOmmunC/8bDWRhFj6hwR3Nk43awYnODlSyjdvcN
 5vPouVRyeuDw86XXr8i2TXH3ivGP2Tno1LE5wgqpRR63LGY=
X-Google-Smtp-Source: AGHT+IFPyryYtMkLWt+5MOMjmv1ylwdSrYxQGZtMIo3tFJ/5HCRkYi3hE10ful6o/TtsjcCtCM7fFQowCBHPui15Okk=
X-Received: by 2002:a05:6402:34b:b0:525:69ec:e1c8 with SMTP id
 r11-20020a056402034b00b0052569ece1c8mr18482381edw.40.1693328822765; Tue, 29
 Aug 2023 10:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230826033330.7827-1-mibodhi@gmail.com>
In-Reply-To: <20230826033330.7827-1-mibodhi@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 29 Aug 2023 10:06:49 -0700
Message-ID: <CAJaLiFxfEiira6LAjF94QVP0KxuZ86=TR5T7i+zS3fRFvudLCQ@mail.gmail.com>
Subject: Re: [PATCH] arm: kirkwood: Add support for ZyXEL NSA325 board
To: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Stefan,

For unknown reasons (probably Gmail glitches), I did not receive your
email review in this thread. But I did receive the other email review
for the Pogo V4 LTO! lore.kernel.org is OK.

https://lore.kernel.org/u-boot/65ab8aa6-c290-0649-0b2e-374c4f84e1df@denx.de=
/T/#mf17689e3e963ab7a34fda34a97f67dea7a877b65

Stefan: "Just checking: Are the DT files imported from the Linux ones?"

Yes, these DT files were copied verbatim from Linux. That's why we see
some minor warnings about styles.

All the best,
Tony

On Fri, Aug 25, 2023 at 8:33=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> ZyXEL NSA325 specifications:
>
> Marvell Kirkwood 88F6282 SoC
> 1.6 GHz CPU
> 1x GBE LAN port (Marvell MV88E1318)
> 512 MB RAM
> 128 MB Eon NAND, SLC
> I2C
> 1x USB 3.0 (on PCIe bus)
> 2x USB 2.0
> 2x SATA (hot swap slots)
> Serial console
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  arch/arm/dts/Makefile                    |   1 +
>  arch/arm/dts/kirkwood-6282.dtsi          | 161 ++++++++++++++++
>  arch/arm/dts/kirkwood-nsa325.dts         | 231 +++++++++++++++++++++++
>  arch/arm/dts/kirkwood-nsa3x0-common.dtsi | 157 +++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig           |   7 +
>  board/zyxel/nsa325/Kconfig               |  12 ++
>  board/zyxel/nsa325/MAINTAINERS           |   9 +
>  board/zyxel/nsa325/Makefile              |  11 ++
>  board/zyxel/nsa325/kwbimage.cfg          |  55 ++++++
>  board/zyxel/nsa325/nsa325.c              | 196 +++++++++++++++++++
>  configs/nsa325_defconfig                 |  81 ++++++++
>  include/configs/nsa325.h                 |  37 ++++
>  12 files changed, 958 insertions(+)
>  create mode 100644 arch/arm/dts/kirkwood-6282.dtsi
>  create mode 100644 arch/arm/dts/kirkwood-nsa325.dts
>  create mode 100644 arch/arm/dts/kirkwood-nsa3x0-common.dtsi
>  create mode 100644 board/zyxel/nsa325/Kconfig
>  create mode 100644 board/zyxel/nsa325/MAINTAINERS
>  create mode 100644 board/zyxel/nsa325/Makefile
>  create mode 100644 board/zyxel/nsa325/kwbimage.cfg
>  create mode 100644 board/zyxel/nsa325/nsa325.c
>  create mode 100644 configs/nsa325_defconfig
>  create mode 100644 include/configs/nsa325.h
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 85fd5b1157..b9fc46544f 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) +=3D \
>         kirkwood-ns2max.dtb \
>         kirkwood-ns2mini.dtb \
>         kirkwood-nsa310s.dtb \
> +       kirkwood-nsa325.dtb \
>         kirkwood-openrd-base.dtb \
>         kirkwood-openrd-client.dtb \
>         kirkwood-openrd-ultimate.dtb \
> diff --git a/arch/arm/dts/kirkwood-6282.dtsi b/arch/arm/dts/kirkwood-6282=
.dtsi
> new file mode 100644
> index 0000000000..e732c501ea
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-6282.dtsi
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/ {
> +       mbus@f1000000 {
> +               pciec: pcie@82000000 {
> +                       compatible =3D "marvell,kirkwood-pcie";
> +                       status =3D "disabled";
> +                       device_type =3D "pci";
> +
> +                       #address-cells =3D <3>;
> +                       #size-cells =3D <2>;
> +
> +                       bus-range =3D <0x00 0xff>;
> +
> +                       ranges =3D
> +                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) =
0x40000 0 0x00002000
> +                               0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) =
0x44000 0 0x00002000
> +                               0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) =
0x80000 0 0x00002000
> +                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) =
0       1 0 /* Port 0.0 MEM */
> +                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) =
0       1 0 /* Port 0.0 IO  */
> +                               0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) =
0       1 0 /* Port 1.0 MEM */
> +                               0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) =
0       1 0 /* Port 1.0 IO  */>;
> +
> +                       pcie0: pcie@1,0 {
> +                               device_type =3D "pci";
> +                               assigned-addresses =3D <0x82000800 0 0x00=
040000 0 0x2000>;
> +                               reg =3D <0x0800 0 0 0 0>;
> +                               #address-cells =3D <3>;
> +                               #size-cells =3D <2>;
> +                               #interrupt-cells =3D <1>;
> +                               ranges =3D <0x82000000 0 0 0x82000000 0x1=
 0 1 0
> +                                         0x81000000 0 0 0x81000000 0x1 0=
 1 0>;
> +                               bus-range =3D <0x00 0xff>;
> +                               interrupt-names =3D "intx", "error";
> +                               interrupts =3D <9>, <44>;
> +                               interrupt-map-mask =3D <0 0 0 7>;
> +                               interrupt-map =3D <0 0 0 1 &pcie0_intc 0>=
,
> +                                               <0 0 0 2 &pcie0_intc 1>,
> +                                               <0 0 0 3 &pcie0_intc 2>,
> +                                               <0 0 0 4 &pcie0_intc 3>;
> +                               marvell,pcie-port =3D <0>;
> +                               marvell,pcie-lane =3D <0>;
> +                               clocks =3D <&gate_clk 2>;
> +                               status =3D "disabled";
> +
> +                               pcie0_intc: interrupt-controller {
> +                                       interrupt-controller;
> +                                       #interrupt-cells =3D <1>;
> +                               };
> +                       };
> +
> +                       pcie1: pcie@2,0 {
> +                               device_type =3D "pci";
> +                               assigned-addresses =3D <0x82001000 0 0x00=
044000 0 0x2000>;
> +                               reg =3D <0x1000 0 0 0 0>;
> +                               #address-cells =3D <3>;
> +                               #size-cells =3D <2>;
> +                               #interrupt-cells =3D <1>;
> +                               ranges =3D <0x82000000 0 0 0x82000000 0x2=
 0 1 0
> +                                         0x81000000 0 0 0x81000000 0x2 0=
 1 0>;
> +                               bus-range =3D <0x00 0xff>;
> +                               interrupt-names =3D "intx", "error";
> +                               interrupts =3D <10>, <45>;
> +                               interrupt-map-mask =3D <0 0 0 7>;
> +                               interrupt-map =3D <0 0 0 1 &pcie1_intc 0>=
,
> +                                               <0 0 0 2 &pcie1_intc 1>,
> +                                               <0 0 0 3 &pcie1_intc 2>,
> +                                               <0 0 0 4 &pcie1_intc 3>;
> +                               marvell,pcie-port =3D <1>;
> +                               marvell,pcie-lane =3D <0>;
> +                               clocks =3D <&gate_clk 18>;
> +                               status =3D "disabled";
> +
> +                               pcie1_intc: interrupt-controller {
> +                                       interrupt-controller;
> +                                       #interrupt-cells =3D <1>;
> +                               };
> +                       };
> +               };
> +       };
> +       ocp@f1000000 {
> +
> +               pinctrl: pin-controller@10000 {
> +                       compatible =3D "marvell,88f6282-pinctrl";
> +
> +                       pmx_sata0: pmx-sata0 {
> +                               marvell,pins =3D "mpp5", "mpp21", "mpp23"=
;
> +                               marvell,function =3D "sata0";
> +                       };
> +                       pmx_sata1: pmx-sata1 {
> +                               marvell,pins =3D "mpp4", "mpp20", "mpp22"=
;
> +                               marvell,function =3D "sata1";
> +                       };
> +
> +                       /*
> +                        * Default I2C1 pinctrl setting on mpp36/mpp37,
> +                        * overwrite marvell,pins on board level if requi=
red.
> +                        */
> +                       pmx_twsi1: pmx-twsi1 {
> +                               marvell,pins =3D "mpp36", "mpp37";
> +                               marvell,function =3D "twsi1";
> +                       };
> +
> +                       pmx_sdio: pmx-sdio {
> +                               marvell,pins =3D "mpp12", "mpp13", "mpp14=
",
> +                                              "mpp15", "mpp16", "mpp17";
> +                               marvell,function =3D "sdio";
> +                       };
> +               };
> +
> +               thermal: thermal@10078 {
> +                       compatible =3D "marvell,kirkwood-thermal";
> +                       reg =3D <0x10078 0x4>;
> +                       status =3D "okay";
> +               };
> +
> +               rtc: rtc@10300 {
> +                       compatible =3D "marvell,kirkwood-rtc", "marvell,o=
rion-rtc";
> +                       reg =3D <0x10300 0x20>;
> +                       interrupts =3D <53>;
> +                       clocks =3D <&gate_clk 7>;
> +               };
> +
> +               i2c1: i2c@11100 {
> +                       compatible =3D "marvell,mv64xxx-i2c";
> +                       reg =3D <0x11100 0x20>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       interrupts =3D <32>;
> +                       clock-frequency =3D <100000>;
> +                       clocks =3D <&gate_clk 7>;
> +                       pinctrl-0 =3D <&pmx_twsi1>;
> +                       pinctrl-names =3D "default";
> +                       status =3D "disabled";
> +               };
> +
> +               sata: sata@80000 {
> +                       compatible =3D "marvell,orion-sata";
> +                       reg =3D <0x80000 0x5000>;
> +                       interrupts =3D <21>;
> +                       clocks =3D <&gate_clk 14>, <&gate_clk 15>;
> +                       clock-names =3D "0", "1";
> +                       phys =3D <&sata_phy0>, <&sata_phy1>;
> +                       phy-names =3D "port0", "port1";
> +                       status =3D "disabled";
> +               };
> +
> +               sdio: mvsdio@90000 {
> +                       compatible =3D "marvell,orion-sdio";
> +                       reg =3D <0x90000 0x200>;
> +                       interrupts =3D <28>;
> +                       clocks =3D <&gate_clk 4>;
> +                       pinctrl-0 =3D <&pmx_sdio>;
> +                       pinctrl-names =3D "default";
> +                       bus-width =3D <4>;
> +                       cap-sdio-irq;
> +                       cap-sd-highspeed;
> +                       cap-mmc-highspeed;
> +                       status =3D "disabled";
> +               };
> +       };
> +};
> diff --git a/arch/arm/dts/kirkwood-nsa325.dts b/arch/arm/dts/kirkwood-nsa=
325.dts
> new file mode 100644
> index 0000000000..efc57cfa41
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-nsa325.dts
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Device tree file for the Zyxel NSA 325 NAS box.
> + *
> + * Copyright (c) 2015, Hans Ulli Kroll <ulli.kroll@googlemail.com>
> + *
> + *
> + * Based upon the board setup file created by Peter Schildmann
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood-nsa3x0-common.dtsi"
> +
> +/ {
> +       model =3D "ZyXEL NSA325";
> +       compatible =3D "zyxel,nsa325", "marvell,kirkwood-88f6282", "marve=
ll,kirkwood";
> +
> +       memory {
> +               device_type =3D "memory";
> +               reg =3D <0x00000000 0x20000000>;
> +       };
> +
> +       chosen {
> +               bootargs =3D "console=3DttyS0,115200";
> +               stdout-path =3D &uart0;
> +       };
> +
> +       ocp@f1000000 {
> +               pinctrl: pin-controller@10000 {
> +                       pinctrl-names =3D "default";
> +
> +                       pmx_led_hdd2_green: pmx-led-hdd2-green {
> +                               marvell,pins =3D "mpp12";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_hdd2_red: pmx-led-hdd2-red {
> +                               marvell,pins =3D "mpp13";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_mcu_data: pmx-mcu-data {
> +                               marvell,pins =3D "mpp14";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_usb_green: pmx-led-usb-green {
> +                               marvell,pins =3D "mpp15";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_mcu_clk: pmx-mcu-clk {
> +                               marvell,pins =3D "mpp16";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_mcu_act: pmx-mcu-act {
> +                               marvell,pins =3D "mpp17";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_sys_green: pmx-led-sys-green {
> +                               marvell,pins =3D "mpp28";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_sys_orange: pmx-led-sys-orange {
> +                               marvell,pins =3D "mpp29";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_hdd1_green: pmx-led-hdd1-green {
> +                               marvell,pins =3D "mpp41";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_hdd1_red: pmx-led-hdd1-red {
> +                               marvell,pins =3D "mpp42";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_htp: pmx-htp {
> +                               marvell,pins =3D "mpp43";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       /*
> +                        * Buzzer needs to be switched at around 1kHz so =
is
> +                        * not compatible with the gpio-beeper driver.
> +                        */
> +                       pmx_buzzer: pmx-buzzer {
> +                               marvell,pins =3D "mpp44";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_vid_b1: pmx-vid-b1 {
> +                               marvell,pins =3D "mpp45";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_power_resume_data: pmx-power-resume-data {
> +                               marvell,pins =3D "mpp47";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_power_resume_clk: pmx-power-resume-clk {
> +                               marvell,pins =3D "mpp49";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_pwr_sata1: pmx-pwr-sata1 {
> +                               marvell,pins =3D "mpp47";
> +                               marvell,function =3D "gpio";
> +                       };
> +               };
> +
> +               /* This board uses the pcf8563 RTC instead of the SoC RTC=
 */
> +               rtc@10300 {
> +                       status =3D "disabled";
> +               };
> +
> +               i2c@11000 {
> +                       status =3D "okay";
> +
> +                       pcf8563: pcf8563@51 {
> +                               compatible =3D "nxp,pcf8563";
> +                               reg =3D <0x51>;
> +                       };
> +               };
> +       };
> +
> +       regulators {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               pinctrl-0 =3D <&pmx_pwr_sata1>;
> +               pinctrl-names =3D "default";
> +
> +               usb0_power: regulator@1 {
> +                       enable-active-high;
> +               };
> +
> +               sata1_power: regulator@2 {
> +                       compatible =3D "regulator-fixed";
> +                       reg =3D <2>;
> +                       regulator-name =3D "SATA1 Power";
> +                       regulator-min-microvolt =3D <5000000>;
> +                       regulator-max-microvolt =3D <5000000>;
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       enable-active-high;
> +                       gpio =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +
> +       gpio-leds {
> +               compatible =3D "gpio-leds";
> +               pinctrl-0 =3D <&pmx_led_hdd2_green &pmx_led_hdd2_red
> +                            &pmx_led_usb_green
> +                            &pmx_led_sys_green &pmx_led_sys_orange
> +                            &pmx_led_copy_green &pmx_led_copy_red
> +                            &pmx_led_hdd1_green &pmx_led_hdd1_red>;
> +               pinctrl-names =3D "default";
> +
> +               green-sys {
> +                       label =3D "nsa325:green:sys";
> +                       gpios =3D <&gpio0 28 GPIO_ACTIVE_HIGH>;
> +               };
> +               orange-sys {
> +                       label =3D "nsa325:orange:sys";
> +                       gpios =3D <&gpio0 29 GPIO_ACTIVE_HIGH>;
> +               };
> +               green-hdd1 {
> +                       label =3D "nsa325:green:hdd1";
> +                       gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +               };
> +               red-hdd1 {
> +                       label =3D "nsa325:red:hdd1";
> +                       gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +               };
> +               green-hdd2 {
> +                       label =3D "nsa325:green:hdd2";
> +                       gpios =3D <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +               };
> +               red-hdd2 {
> +                       label =3D "nsa325:red:hdd2";
> +                       gpios =3D <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +               };
> +               green-usb {
> +                       label =3D "nsa325:green:usb";
> +                       gpios =3D <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +               };
> +               green-copy {
> +                       label =3D "nsa325:green:copy";
> +                       gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +               };
> +               red-copy {
> +                       label =3D "nsa325:red:copy";
> +                       gpios =3D <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +       /* The following pins are currently not assigned to a driver,
> +          some of them should be configured as inputs.
> +       pinctrl-0 =3D <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
> +                    &pmx_htp &pmx_vid_b1
> +                    &pmx_power_resume_data &pmx_power_resume_clk>; */
> +       };
> +
> +};
> +
> +&mdio {
> +       status =3D "okay";
> +       ethphy0: ethernet-phy@1 {
> +               reg =3D <1>;
> +       };
> +};
> +
> +&eth0 {
> +       status =3D "okay";
> +       ethernet0-port@0 {
> +               phy-handle =3D <&ethphy0>;
> +       };
> +};
> +
> +&pciec {
> +       status =3D "okay";
> +};
> +
> +&pcie0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/arm/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/dts/kirk=
wood-nsa3x0-common.dtsi
> new file mode 100644
> index 0000000000..a21c50d44a
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +       model =3D "ZyXEL NSA310";
> +
> +       ocp@f1000000 {
> +               pinctrl: pin-controller@10000 {
> +
> +                       pmx_usb_power: pmx-usb-power {
> +                               marvell,pins =3D "mpp21";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_pwr_off: pmx-pwr-off {
> +                               marvell,pins =3D "mpp48";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_btn_reset: pmx-btn-reset {
> +                               marvell,pins =3D "mpp36";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_btn_copy: pmx-btn-copy {
> +                               marvell,pins =3D "mpp37";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_btn_power: pmx-btn-power {
> +                               marvell,pins =3D "mpp46";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_copy_green: pmx-led-copy-green {
> +                               marvell,pins =3D "mpp39";
> +                               marvell,function =3D "gpio";
> +                       };
> +
> +                       pmx_led_copy_red: pmx-led-copy-red {
> +                               marvell,pins =3D "mpp40";
> +                               marvell,function =3D "gpio";
> +                       };
> +               };
> +
> +               serial@12000 {
> +                       status =3D "okay";
> +               };
> +
> +               sata@80000 {
> +                       status =3D "okay";
> +                       nr-ports =3D <2>;
> +               };
> +       };
> +
> +       gpio_poweroff {
> +               compatible =3D "gpio-poweroff";
> +               pinctrl-0 =3D <&pmx_pwr_off>;
> +               pinctrl-names =3D "default";
> +               gpios =3D <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       gpio_keys {
> +               compatible =3D "gpio-keys";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               pinctrl-0 =3D <&pmx_btn_reset &pmx_btn_copy &pmx_btn_powe=
r>;
> +               pinctrl-names =3D "default";
> +
> +               power {
> +                       label =3D "Power Button";
> +                       linux,code =3D <KEY_POWER>;
> +                       gpios =3D <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +               };
> +               copy {
> +                       label =3D "Copy Button";
> +                       linux,code =3D <KEY_COPY>;
> +                       gpios =3D <&gpio1 5 GPIO_ACTIVE_LOW>;
> +               };
> +               reset {
> +                       label =3D "Reset Button";
> +                       linux,code =3D <KEY_RESTART>;
> +                       gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +
> +       regulators {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               pinctrl-0 =3D <&pmx_usb_power>;
> +               pinctrl-names =3D "default";
> +
> +               usb0_power: regulator@1 {
> +                       compatible =3D "regulator-fixed";
> +                       reg =3D <1>;
> +                       regulator-name =3D "USB Power";
> +                       regulator-min-microvolt =3D <5000000>;
> +                       regulator-max-microvolt =3D <5000000>;
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       gpio =3D <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +};
> +
> +&nand {
> +       status =3D "okay";
> +       chip-delay =3D <35>;
> +
> +       partition@0 {
> +               label =3D "uboot";
> +               reg =3D <0x0000000 0x0100000>;
> +       };
> +       partition@100000 {
> +               label =3D "uboot_env";
> +               reg =3D <0x0100000 0x0080000>;
> +       };
> +       partition@180000 {
> +               label =3D "key_store";
> +               reg =3D <0x0180000 0x0080000>;
> +       };
> +       partition@200000 {
> +               label =3D "info";
> +               reg =3D <0x0200000 0x0080000>;
> +       };
> +       partition@280000 {
> +               label =3D "etc";
> +               reg =3D <0x0280000 0x0a00000>;
> +       };
> +       partition@c80000 {
> +               label =3D "kernel_1";
> +               reg =3D <0x0c80000 0x0a00000>;
> +       };
> +       partition@1680000 {
> +               label =3D "rootfs1";
> +               reg =3D <0x1680000 0x2fc0000>;
> +       };
> +       partition@4640000 {
> +               label =3D "kernel_2";
> +               reg =3D <0x4640000 0x0a00000>;
> +       };
> +       partition@5040000 {
> +               label =3D "rootfs2";
> +               reg =3D <0x5040000 0x2fc0000>;
> +       };
> +};
> +
> +&pciec {
> +       status =3D "okay";
> +};
> +
> +&pcie0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kcon=
fig
> index 54027ccb0e..c2fff84a68 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -133,6 +133,12 @@ config TARGET_NSA310S
>         select KW88F6192
>         select KIRKWOOD_COMMON
>
> +config TARGET_NSA325
> +       bool "ZyXEL NSA325"
> +       select FEROCEON_88FR131
> +       select KW88F6281
> +       select KIRKWOOD_COMMON
> +
>  config TARGET_SBx81LIFKW
>         bool "Allied Telesis SBx81GS24/SBx81GT40/SBx81XS6/SBx81XS16"
>         select FEROCEON_88FR131
> @@ -177,6 +183,7 @@ source "board/Seagate/dockstar/Kconfig"
>  source "board/Seagate/goflexhome/Kconfig"
>  source "board/Seagate/nas220/Kconfig"
>  source "board/zyxel/nsa310s/Kconfig"
> +source "board/zyxel/nsa325/Kconfig"
>  source "board/alliedtelesis/SBx81LIFKW/Kconfig"
>  source "board/alliedtelesis/SBx81LIFXCAT/Kconfig"
>
> diff --git a/board/zyxel/nsa325/Kconfig b/board/zyxel/nsa325/Kconfig
> new file mode 100644
> index 0000000000..1fe5ead76e
> --- /dev/null
> +++ b/board/zyxel/nsa325/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_NSA325
> +
> +config SYS_BOARD
> +       default "nsa325"
> +
> +config SYS_VENDOR
> +       default "zyxel"
> +
> +config SYS_CONFIG_NAME
> +       default "nsa325"
> +
> +endif
> diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAIN=
ERS
> new file mode 100644
> index 0000000000..013cb84b99
> --- /dev/null
> +++ b/board/zyxel/nsa325/MAINTAINERS
> @@ -0,0 +1,9 @@
> +NSA325 BOARD
> +M:     Tony Dinh <mibodhi@gmail.com>
> +S:     Maintained
> +F:     arch/arm/dts/kirkwood-6282.dtsi
> +F:     arch/arm/dts/kirkwood-nsa325.dts
> +F:     arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> +F:     board/zyxel/nsa325/
> +F:     include/configs/nsa325.h
> +F:     configs/nsa325_defconfig
> diff --git a/board/zyxel/nsa325/Makefile b/board/zyxel/nsa325/Makefile
> new file mode 100644
> index 0000000000..2887ba2d13
> --- /dev/null
> +++ b/board/zyxel/nsa325/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2015-2023 Tony Dinh <mibodhi@gmail.com>
> +#
> +# Based on
> +# (C) Copyright 2009
> +# Marvell Semiconductor <www.marvell.com>
> +# Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> +#
> +
> +obj-y  :=3D nsa325.o
> diff --git a/board/zyxel/nsa325/kwbimage.cfg b/board/zyxel/nsa325/kwbimag=
e.cfg
> new file mode 100644
> index 0000000000..a497300873
> --- /dev/null
> +++ b/board/zyxel/nsa325/kwbimage.cfg
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2015-2023 Tony Dinh <mibodhi@gmail.com>
> +#
> +# Extracted from Zyxel GPL source for u-boot-1.1.4_NSA325v2
> +#
> +# Boot Media configurations
> +BOOT_FROM       nand
> +NAND_ECC_MODE   default
> +NAND_PAGE_SIZE  0x0800
> +
> +# SOC registers configuration using bootrom header extension
> +# Maximum KWBIMAGE_MAX_CONFIG configurations allowed
> +
> +# Configure RGMII-0 interface pad voltage to 1.8V
> +DATA 0xFFD100e0 0x1b1b1b9b
> +
> +#Dram initalization
> +DATA 0xFFD01400 0x4301503E      # DDR Configuration register
> +DATA 0xFFD01404 0xB9843000      # DDR Controller Control Low
> +DATA 0xFFD01408 0x33137777      # DDR Timing (Low)
> +DATA 0xFFD0140C 0x16000C55      # DDR Timing (High)
> +DATA 0xFFD01410 0x04000000      # DDR Address Control
> +DATA 0xFFD01414 0x00000000     #  DDR Open Pages Control
> +DATA 0xFFD01418 0x00000000     #  DDR Operation
> +DATA 0xFFD0141C 0x00000672     #  DDR Mode
> +DATA 0xFFD01420 0x00000004     #  DDR Extended Mode
> +DATA 0xFFD01424 0x0000F14F     #  DDR Controller Control High
> +DATA 0xFFD01428 0x000D6720     # DDR3 ODT Read Timing
> +DATA 0xFFD0147C 0x0000B571     # DDR2 ODT Write Timing
> +DATA 0xFFD01504 0x1FFFFFF1      # CS[0]n Size
> +DATA 0xFFD01508 0x20000000      # CS[1]n Base address to 512Mb
> +DATA 0xFFD0150C 0x1FFFFFF4      # CS[1]n Size 512Mb Window enabled for C=
S1
> +DATA 0xFFD01514 0x00000000      # CS[2]n Size, window disabled
> +DATA 0xFFD0151C 0x00000000      # CS[3]n Size, window disabled
> +DATA 0xFFD01494 0x00120000      #  DDR ODT Control (Low)
> +DATA 0xFFD01498 0x00000000      #  DDR ODT Control (High)
> +DATA 0xFFD0149C 0x0000E803      # CPU ODT Control
> +
> +DATA 0xFFD015D0 0x00000630
> +DATA 0xFFD015D4 0x00000046
> +DATA 0xFFD015D8 0x00000008
> +DATA 0xFFD015DC 0x00000000
> +DATA 0xFFD015E0 0x00000023
> +DATA 0xFFD015E4 0x00203C18
> +DATA 0xFFD01620 0x00384800
> +DATA 0xFFD01480 0x00000001
> +DATA 0xFFD20134 0x66666666
> +DATA 0xFFD20138 0x00066666
> +
> +DATA 0xFFD10100 0x00004000     # stop the watchdog
> +DATA 0xFFD10104 0xFFFFBFFF
> +
> +# End of Header extension
> +DATA 0x0 0x0
> diff --git a/board/zyxel/nsa325/nsa325.c b/board/zyxel/nsa325/nsa325.c
> new file mode 100644
> index 0000000000..f5f63ee5d3
> --- /dev/null
> +++ b/board/zyxel/nsa325/nsa325.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2014-2023 Tony Dinh <mibodhi@gmail.com>
> + *
> + * Based on
> + * Copyright (C) 2014  Jason Plum <jplum@archlinuxarm.org>
> + *
> + * Based on nsa320.c originall written by
> + * Copyright (C) 2012  Peter Schildmann <linux@schildmann.info>
> + *
> + * Based on guruplug.c originally written by
> + * Siddarth Gore <gores@marvell.com>
> + * (C) Copyright 2009
> + * Marvell Semiconductor <www.marvell.com>
> + */
> +
> +#include <common.h>
> +#include <asm/arch/soc.h>
> +#include <asm/arch/mpp.h>
> +#include <netdev.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <asm/arch/gpio.h>
> +#include <asm/mach-types.h>
> +#include <bootstage.h>
> +#include <command.h>
> +#include <init.h>
> +#include <linux/bitops.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* low GPIO's */
> +#define HDD2_GREEN_LED         BIT(12)
> +#define HDD2_RED_LED           BIT(13)
> +#define USB_GREEN_LED          BIT(15)
> +#define USB_POWER              BIT(21)
> +#define SYS_GREEN_LED          BIT(28)
> +#define SYS_ORANGE_LED         BIT(29)
> +
> +#define PIN_USB_GREEN_LED      15
> +#define PIN_USB_POWER          21
> +
> +#define NSA325_OE_LOW          (~(HDD2_GREEN_LED | HDD2_RED_LED |      \
> +                                  USB_GREEN_LED | USB_POWER |          \
> +                                  SYS_GREEN_LED | SYS_ORANGE_LED))
> +#define NSA325_VAL_LOW         (SYS_GREEN_LED | USB_POWER)
> +
> +/* high GPIO's */
> +#define COPY_GREEN_LED         BIT(7)
> +#define COPY_RED_LED           BIT(8)
> +#define HDD1_GREEN_LED         BIT(9)
> +#define HDD1_RED_LED           BIT(10)
> +#define HDD2_POWER             BIT(15)
> +#define WATCHDOG_SIGNAL                BIT(14)
> +
> +#define NSA325_OE_HIGH         (~(COPY_GREEN_LED | COPY_RED_LED | \
> +                                  HDD1_GREEN_LED | HDD1_RED_LED | HDD2_P=
OWER | WATCHDOG_SIGNAL))
> +#define NSA325_VAL_HIGH                (WATCHDOG_SIGNAL | HDD2_POWER)
> +
> +#define BTN_POWER                              46
> +#define BTN_RESET                              36
> +#define BTN_COPY                               37
> +
> +int board_early_init_f(void)
> +{
> +       /*
> +        * default gpio configuration
> +        * There are maximum 64 gpios controlled through 2 sets of regist=
ers
> +        * the below configuration configures mainly initial LED status
> +        */
> +       mvebu_config_gpio(NSA325_VAL_LOW, NSA325_VAL_HIGH,
> +                         NSA325_OE_LOW, NSA325_OE_HIGH);
> +
> +       /* Multi-Purpose Pins Functionality configuration */
> +       /* (all LEDs & power off active high) */
> +       u32 kwmpp_config[] =3D {
> +               MPP0_NF_IO2,
> +               MPP1_NF_IO3,
> +               MPP2_NF_IO4,
> +               MPP3_NF_IO5,
> +               MPP4_NF_IO6,
> +               MPP5_NF_IO7,
> +               MPP6_SYSRST_OUTn,
> +               MPP7_GPO,
> +               MPP8_TW_SDA,            /* PCF8563 RTC chip   */
> +               MPP9_TW_SCK,            /* connected to TWSI  */
> +               MPP10_UART0_TXD,
> +               MPP11_UART0_RXD,
> +               MPP12_GPO,              /* HDD2 LED (green)   */
> +               MPP13_GPIO,             /* HDD2 LED (red)     */
> +               MPP14_GPIO,             /* MCU DATA pin (in)  */
> +               MPP15_GPIO,             /* USB LED (green)    */
> +               MPP16_GPIO,             /* MCU CLK pin (out)  */
> +               MPP17_GPIO,             /* MCU ACT pin (out)  */
> +               MPP18_NF_IO0,
> +               MPP19_NF_IO1,
> +               MPP20_GPIO,
> +               MPP21_GPIO,             /* USB power          */
> +               MPP22_GPIO,
> +               MPP23_GPIO,
> +               MPP24_GPIO,
> +               MPP25_GPIO,
> +               MPP26_GPIO,
> +               MPP27_GPIO,
> +               MPP28_GPIO,             /* SYS LED (green)    */
> +               MPP29_GPIO,             /* SYS LED (orange)   */
> +               MPP30_GPIO,
> +               MPP31_GPIO,
> +               MPP32_GPIO,
> +               MPP33_GPIO,
> +               MPP34_GPIO,
> +               MPP35_GPIO,
> +               MPP36_GPIO,             /* reset button       */
> +               MPP37_GPIO,             /* copy button        */
> +               MPP38_GPIO,             /* VID B0             */
> +               MPP39_GPIO,             /* COPY LED (green)   */
> +               MPP40_GPIO,             /* COPY LED (red)     */
> +               MPP41_GPIO,             /* HDD1 LED (green)   */
> +               MPP42_GPIO,             /* HDD1 LED (red)     */
> +               MPP43_GPIO,             /* HTP pin            */
> +               MPP44_GPIO,             /* buzzer             */
> +               MPP45_GPIO,             /* VID B1             */
> +               MPP46_GPIO,             /* power button       */
> +               MPP47_GPIO,             /* HDD2 power         */
> +               MPP48_GPIO,             /* power off          */
> +               0
> +       };
> +       kirkwood_mpp_conf(kwmpp_config, NULL);
> +       return 0;
> +}
> +
> +int board_eth_init(struct bd_info *bis)
> +{
> +       return cpu_eth_init(bis);
> +}
> +
> +int board_init(void)
> +{
> +       /* address of boot parameters */
> +       gd->bd->bi_boot_params =3D mvebu_sdram_bar(0) + 0x100;
> +
> +       return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +       /* Do late init to ensure successful enumeration of XHCI devices =
*/
> +       pci_init();
> +       return 0;
> +}
> +
> +#if defined(CONFIG_SHOW_BOOT_PROGRESS)
> +void show_boot_progress(int val)
> +{
> +       struct kwgpio_registers *gpio0 =3D (struct kwgpio_registers *)MVE=
BU_GPIO0_BASE;
> +       u32 dout0 =3D readl(&gpio0->dout);
> +       u32 blen0 =3D readl(&gpio0->blink_en);
> +
> +       struct kwgpio_registers *gpio1 =3D (struct kwgpio_registers *)MVE=
BU_GPIO1_BASE;
> +       u32 dout1 =3D readl(&gpio1->dout);
> +       u32 blen1 =3D readl(&gpio1->blink_en);
> +
> +       switch (val) {
> +       case BOOTSTAGE_ID_DECOMP_IMAGE:
> +               writel(blen0 & ~(SYS_GREEN_LED | SYS_ORANGE_LED), &gpio0-=
>blink_en);
> +               writel((dout0 & ~SYS_GREEN_LED) | SYS_ORANGE_LED, &gpio0-=
>dout);
> +               break;
> +       case BOOTSTAGE_ID_RUN_OS:
> +               writel(dout0 & ~SYS_ORANGE_LED, &gpio0->dout);
> +               writel(blen0 | SYS_GREEN_LED, &gpio0->blink_en);
> +               break;
> +       case BOOTSTAGE_ID_NET_START:
> +               writel(dout1 & ~COPY_RED_LED, &gpio1->dout);
> +               writel((blen1 & ~COPY_RED_LED) | COPY_GREEN_LED, &gpio1->=
blink_en);
> +               break;
> +       case BOOTSTAGE_ID_NET_LOADED:
> +               writel(blen1 & ~(COPY_RED_LED | COPY_GREEN_LED), &gpio1->=
blink_en);
> +               writel((dout1 & ~COPY_RED_LED) | COPY_GREEN_LED, &gpio1->=
dout);
> +               break;
> +       case -BOOTSTAGE_ID_NET_NETLOOP_OK:
> +       case -BOOTSTAGE_ID_NET_LOADED:
> +               writel(dout1 & ~COPY_GREEN_LED, &gpio1->dout);
> +               writel((blen1 & ~COPY_GREEN_LED) | COPY_RED_LED, &gpio1->=
blink_en);
> +               break;
> +       default:
> +               if (val < 0) {
> +                       /* error */
> +                       printf("Error occurred, error code =3D %d\n", -va=
l);
> +                       writel(dout0 & ~SYS_GREEN_LED, &gpio0->dout);
> +                       writel(blen0 | SYS_ORANGE_LED, &gpio0->blink_en);
> +               }
> +               break;
> +       }
> +}
> +#endif /* CONFIG_SHOW_BOOT_PROGRESS */
> diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
> new file mode 100644
> index 0000000000..d5fe9ca099
> --- /dev/null
> +++ b/configs/nsa325_defconfig
> @@ -0,0 +1,81 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> +CONFIG_SYS_DCACHE_OFF=3Dy
> +CONFIG_ARCH_CPU_INIT=3Dy
> +CONFIG_SYS_THUMB_BUILD=3Dy
> +CONFIG_ARCH_KIRKWOOD=3Dy
> +CONFIG_SUPPORT_PASSING_ATAGS=3Dy
> +CONFIG_CMDLINE_TAG=3Dy
> +CONFIG_INITRD_TAG=3Dy
> +CONFIG_SYS_KWD_CONFIG=3D"board/zyxel/nsa325/kwbimage.cfg"
> +CONFIG_TEXT_BASE=3D0x600000
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_TARGET_NSA325=3Dy
> +CONFIG_ENV_SIZE=3D0x20000
> +CONFIG_ENV_OFFSET=3D0xC0000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"kirkwood-nsa325"
> +CONFIG_SYS_PROMPT=3D"NSA325> "
> +CONFIG_IDENT_STRING=3D"\nZyXEL NSA325 2-Bay Power Media Server"
> +CONFIG_SYS_LOAD_ADDR=3D0x800000
> +CONFIG_PCI=3Dy
> +CONFIG_LTO=3Dy
> +CONFIG_BOOTSTD_FULL=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
> +CONFIG_BOOTSTD_BOOTCOMMAND=3Dy
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_BOOTSTAGE=3Dy
> +CONFIG_SHOW_BOOT_PROGRESS=3Dy
> +CONFIG_BOOTDELAY=3D10
> +CONFIG_USE_PREBOOT=3Dy
> +CONFIG_BOARD_LATE_INIT=3Dy
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_IMI is not set
> +# CONFIG_CMD_XIMG is not set
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_I2C=3Dy
> +CONFIG_CMD_MTD=3Dy
> +CONFIG_CMD_NAND=3Dy
> +CONFIG_CMD_PCI=3Dy
> +CONFIG_CMD_SATA=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
> +CONFIG_CMD_DNS=3Dy
> +# CONFIG_CMD_BLOCK_CACHE is not set
> +CONFIG_CMD_JFFS2=3Dy
> +CONFIG_CMD_MTDPARTS=3Dy
> +CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dorion_nand"
> +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dorion_nand:0x100000(uboot),0x80000=
(stock_uboot_env),0x80000(key_store),0x80000(info),0xA00000(etc),0xA00000(k=
ernel_1),0x2FC0000(rootfs1),0xA00000(kernel_2),0x2FC0000(rootfs2)"
> +CONFIG_CMD_UBI=3Dy
> +CONFIG_PARTITION_TYPE_GUID=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_ENV_IS_IN_NAND=3Dy
> +CONFIG_VERSION_VARIABLE=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_NETCONSOLE=3Dy
> +# CONFIG_DM_WARN is not set
> +CONFIG_SATA_MV=3Dy
> +CONFIG_SYS_SATA_MAX_DEVICE=3D2
> +CONFIG_LBA48=3Dy
> +CONFIG_SYS_64BIT_LBA=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_MVTWSI=3Dy
> +# CONFIG_MMC is not set
> +CONFIG_MTD=3Dy
> +CONFIG_MTD_RAW_NAND=3Dy
> +CONFIG_PHY_MARVELL=3Dy
> +CONFIG_MVGBE=3Dy
> +CONFIG_MII=3Dy
> +CONFIG_PCI_MVEBU=3Dy
> +CONFIG_DM_RTC=3Dy
> +CONFIG_RTC_PCF8563=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_PCI=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_JFFS2_LZO=3Dy
> +CONFIG_JFFS2_NAND=3Dy
> +CONFIG_UBIFS_SILENCE_MSG=3Dy
> diff --git a/include/configs/nsa325.h b/include/configs/nsa325.h
> new file mode 100644
> index 0000000000..00a148c6ae
> --- /dev/null
> +++ b/include/configs/nsa325.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2016-2023 Tony Dinh <mibodhi@gmail.com>
> + * (C) Copyright 2014 Jason Plum <jplum@archlinuxarm.org>
> + *
> + * Based on
> + * Copyright (C) 2012  Peter Schildmann <linux@schildmann.info>
> + *
> + * Based on guruplug.h originally written by
> + * Siddarth Gore <gores@marvell.com>
> + * (C) Copyright 2009
> + * Marvell Semiconductor <www.marvell.com>
> + */
> +
> +#ifndef _CONFIG_NSA325_H
> +#define _CONFIG_NSA325_H
> +
> +#include "mv-common.h"
> +
> +#define KERNEL_ADDR_R  __stringify(0x800000)
> +#define FDT_ADDR_R     __stringify(0x2c00000)
> +#define RAMDISK_ADDR_R __stringify(0x01100000)
> +#define SCRIPT_ADDR_R  __stringify(0x200000)
> +
> +#define LOAD_ADDRESS_ENV_SETTINGS \
> +       "kernel_addr_r=3D" KERNEL_ADDR_R "\0" \
> +       "fdt_addr_r=3D" FDT_ADDR_R "\0" \
> +       "ramdisk_addr_r=3D" RAMDISK_ADDR_R "\0" \
> +       "scriptaddr=3D" SCRIPT_ADDR_R "\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +       LOAD_ADDRESS_ENV_SETTINGS \
> +       "fdtfile=3D" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +       "mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
> +       "console=3DttyS0,115200\0"
> +
> +#endif /* _CONFIG_NSA325_H */
> --
> 2.39.2
>
