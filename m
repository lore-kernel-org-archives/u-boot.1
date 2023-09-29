Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EFEE71D37
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068EE86EC3;
	Fri, 29 Sep 2023 15:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a1912RmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B410B86EC9; Fri, 29 Sep 2023 15:46:26 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A3386EAA
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so491688b3a.1
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695995182; x=1696599982; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssV8dFoAldhneh89idd9ZGviEypfYfriqJ/12cx3TCU=;
 b=a1912RmDJngTRhTqlSPHYyI0hYQHId5hIi23IZuOTIWIF6kIfFGGmBr/i6ec9HFxNu
 RsluCLljxxxh8SkHGqnnka4fHFVz+OrhxVmhMQ20c+hHyHXcHr9bAp93Gquku6Kf2eN6
 edW6LLO4nDWvaKfva9XVdLK5Jbu43BomRiEPEhSwxsigKJ7BhIn2pRB8OYc3wxtfNpYu
 lwDmVx4JZQoi57A6P8nKoSL2i/rZ7ib8npJPihafn47yIz+/cpx86q0FM+TxaACaC0h2
 twQ9TkPqHa7zhd2JtPd2Uev+ouIylgs3Ah9PJvJfvEmnw0xOOwtHusbuB6UpUtL9Sxjd
 QC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695995182; x=1696599982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssV8dFoAldhneh89idd9ZGviEypfYfriqJ/12cx3TCU=;
 b=qpmrdu6K33dfnarfJY3TSgcpzOWFe8lMLKu4nabkX9+i4RjEg3svZsYz293QrS9uCH
 qUmPpxDcun3fkxmNvevHzanonqzGroWXtCOIBTlvrbdlG1aKkSClerX+E3SKOpEcJgKz
 UVA91D5IjVjqNLEf1HJHqiUhjH15FlR190DxJHay8XDk5pI6Up1r39K/Ma8TArCkt07i
 jmyXfsdluO8SYo3rCPcKzjP1P8dr+FbT1APtO8Bn/6a8+4I2B6Hr/9iiB2ltqMTlTZXx
 XSTDS/HmwOi4g31e3FqWkFV6u5FGbCWpWox3uuD8us299+8E4ksjRh4GCZe9qFMzngUd
 vttg==
X-Gm-Message-State: AOJu0Yz3MKOX2xebv859XYeel58ukfkV2FlWjgGWWGRDmRVomzD4buIx
 QmQwRpKzX+/QWuLpkJ3ElYZs/iZL1PLpa1+dMEwfK+Gf
X-Google-Smtp-Source: AGHT+IGPpCJALURUkbitpv1rEAHAuWCBnOZJa7enWaBe7/ei6lTi3vPbyV7SkImkmVVpBGcM9rNwgGkA1b3m0+hDTUo=
X-Received: by 2002:a17:90a:7f82:b0:277:3afc:f27 with SMTP id
 m2-20020a17090a7f8200b002773afc0f27mr6751431pjl.1.1695995182255; Fri, 29 Sep
 2023 06:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
 <20230917141319.379939-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-15-marek.vasut+renesas@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 29 Sep 2023 08:46:10 -0500
Message-ID: <CAHCN7xLZzqnSfpN0VgK5ayYqtWNhtKKRQaaYh6DQ9QjCCWuVNQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] ARM: dts: renesas: Synchronize RZ R8A774A1 RZ/G2M
 DTs with Linux 6.5.3
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
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

On Sun, Sep 17, 2023 at 9:18=E2=80=AFAM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Synchronize RZ R8A774A1 RZ/G2M DTs with Linux 6.5.3,
Thanks!

> commit 238589d0f7b421aae18c5704dc931595019fa6c7 .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Adam Ford <aford173@gmail.com>

> ---
>  arch/arm/dts/beacon-renesom-baseboard.dtsi | 45 ++++++++++++++--------
>  arch/arm/dts/beacon-renesom-som.dtsi       |  2 +-
>  arch/arm/dts/hihope-common.dtsi            | 21 ++++++++--
>  arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts | 21 ----------
>  arch/arm/dts/r8a774a1-u-boot.dtsi          |  1 -
>  arch/arm/dts/r8a774a1.dtsi                 | 14 ++++---
>  6 files changed, 57 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/dts/beacon-renesom-baseboard.dtsi b/arch/arm/dts/be=
acon-renesom-baseboard.dtsi
> index 8166e3c1ff4..2e9927b9773 100644
> --- a/arch/arm/dts/beacon-renesom-baseboard.dtsi
> +++ b/arch/arm/dts/beacon-renesom-baseboard.dtsi
> @@ -367,7 +367,7 @@
>
>                 assigned-clocks =3D <&versaclock6_bb 1>, <&versaclock6_bb=
 2>,
>                                   <&versaclock6_bb 3>, <&versaclock6_bb 4=
>;
> -               assigned-clock-rates =3D <24000000>, <24000000>, <2400000=
0>,
> +               assigned-clock-rates =3D <24000000>, <24000000>, <2457600=
0>,
>                                        <24576000>;
>
>                 OUT1 {
> @@ -437,20 +437,6 @@
>                 };
>         };
>
> -       /* 0 - lcd_reset */
> -       /* 1 - lcd_pwr */
> -       /* 2 - lcd_select */
> -       /* 3 - backlight-enable */
> -       /* 4 - Touch_shdwn */
> -       /* 5 - LCD_H_pol */
> -       /* 6 - lcd_V_pol */
> -       gpio_exp1: gpio@20 {
> -               compatible =3D "onnn,pca9654";
> -               reg =3D <0x20>;
> -               gpio-controller;
> -               #gpio-cells =3D <2>;
> -       };
> -
>         touchscreen@26 {
>                 compatible =3D "ilitek,ili2117";
>                 reg =3D <0x26>;
> @@ -482,6 +468,16 @@
>                         };
>                 };
>         };
> +
> +       gpio_exp1: gpio@70 {
> +               compatible =3D "nxp,pca9538";
> +               reg =3D <0x70>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +               gpio-line-names =3D "lcd_reset", "lcd_pwr", "lcd_select",
> +                                 "backlight-enable", "Touch_shdwn",
> +                                 "LCD_H_pol", "lcd_V_pol";
> +       };
>  };
>
>  &lvds0 {
> @@ -638,6 +634,25 @@
>         #clock-cells =3D <1>;
>         clock-frequency =3D <11289600>;
>
> +       /* Reference versaclock instead of audio_clk_a */
> +       clocks =3D <&cpg CPG_MOD 1005>,
> +                <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
> +                <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
> +                <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
> +                <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
> +                <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
> +                <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
> +                <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
> +                <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
> +                <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
> +                <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
> +                <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
> +                <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
> +                <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
> +                <&versaclock6_bb 4>, <&audio_clk_b>,
> +                <&audio_clk_c>,
> +                <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
> +
>         status =3D "okay";
>
>         ports {
> diff --git a/arch/arm/dts/beacon-renesom-som.dtsi b/arch/arm/dts/beacon-r=
enesom-som.dtsi
> index d3fc8ffd5b4..68b04e56ae5 100644
> --- a/arch/arm/dts/beacon-renesom-som.dtsi
> +++ b/arch/arm/dts/beacon-renesom-som.dtsi
> @@ -59,7 +59,7 @@
>         status =3D "okay";
>
>         phy0: ethernet-phy@0 {
> -               compatible =3D "ethernet-phy-id004d.d074",
> +               compatible =3D "ethernet-phy-id0022.1640",
>                              "ethernet-phy-ieee802.3-c22";
>                 reg =3D <0>;
>                 interrupt-parent =3D <&gpio2>;
> diff --git a/arch/arm/dts/hihope-common.dtsi b/arch/arm/dts/hihope-common=
.dtsi
> index b1eb6a08029..83104af2813 100644
> --- a/arch/arm/dts/hihope-common.dtsi
> +++ b/arch/arm/dts/hihope-common.dtsi
> @@ -3,15 +3,26 @@
>   * Device Tree Source for the HiHope RZ/G2H Rev.4.0 and
>   * HiHope RZ/G2[MN] Rev.[2.0/3.0/4.0] main board common parts
>   *
> - * Copyright (C) 2021 Renesas Electronics Corp.
> + * Copyright (C) 2019 Renesas Electronics Corp.
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
>         aliases {
> +               i2c0 =3D &i2c0;
> +               i2c1 =3D &i2c1;
> +               i2c2 =3D &i2c2;
> +               i2c3 =3D &i2c3;
> +               i2c4 =3D &i2c4;
> +               i2c5 =3D &i2c5;
> +               i2c6 =3D &i2c6;
> +               i2c7 =3D &iic_pmic;
>                 serial0 =3D &scif2;
>                 serial1 =3D &hscif0;
> +               mmc0 =3D &sdhi3;
> +               mmc1 =3D &sdhi0;
> +               mmc2 =3D &sdhi2;
>         };
>
>         chosen {
> @@ -50,7 +61,7 @@
>                 };
>         };
>
> -       reg_1p8v: regulator0 {
> +       reg_1p8v: regulator-1p8v {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "fixed-1.8V";
>                 regulator-min-microvolt =3D <1800000>;
> @@ -59,7 +70,7 @@
>                 regulator-always-on;
>         };
>
> -       reg_3p3v: regulator1 {
> +       reg_3p3v: regulator-3p3v {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "fixed-3.3V";
>                 regulator-min-microvolt =3D <3300000>;
> @@ -137,7 +148,7 @@
>  };
>
>  &gpio6 {
> -       usb1-reset {
> +       usb1-reset-hog {
>                 gpio-hog;
>                 gpios =3D <10 GPIO_ACTIVE_LOW>;
>                 output-low;
> @@ -328,6 +339,8 @@
>         vqmmc-supply =3D <&reg_1p8v>;
>         bus-width =3D <8>;
>         mmc-hs200-1_8v;
> +       no-sd;
> +       no-sdio;
>         non-removable;
>         fixed-emmc-driver-type =3D <1>;
>         status =3D "okay";
> diff --git a/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts b/arch/arm/dts/r8=
a774a1-beacon-rzg2m-kit.dts
> index 9ae67263c0d..24da6ee6ecc 100644
> --- a/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
> +++ b/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
> @@ -58,24 +58,3 @@
>         clock-names =3D "du.0", "du.1", "du.2",
>                       "dclkin.0", "dclkin.1", "dclkin.2";
>  };
> -
> -/* Reference versaclock instead of audio_clk_a */
> -&rcar_sound {
> -       clocks =3D <&cpg CPG_MOD 1005>,
> -                <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
> -                <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
> -                <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
> -                <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
> -                <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
> -                <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
> -                <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
> -                <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
> -                <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
> -                <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
> -                <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
> -                <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
> -                <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
> -                <&versaclock6_bb 4>, <&audio_clk_b>,
> -                <&audio_clk_c>,
> -                <&cpg CPG_CORE R8A774A1_CLK_S0D4>;
> -};
> diff --git a/arch/arm/dts/r8a774a1-u-boot.dtsi b/arch/arm/dts/r8a774a1-u-=
boot.dtsi
> index cddffe87645..38f5bfe85fc 100644
> --- a/arch/arm/dts/r8a774a1-u-boot.dtsi
> +++ b/arch/arm/dts/r8a774a1-u-boot.dtsi
> @@ -28,7 +28,6 @@
>  /delete-node/ &hdmi0;
>  /delete-node/ &lvds0;
>  /delete-node/ &rcar_sound;
> -/delete-node/ &sdhi2;
>  /delete-node/ &sound_card;
>  /delete-node/ &vin0;
>  /delete-node/ &vin1;
> diff --git a/arch/arm/dts/r8a774a1.dtsi b/arch/arm/dts/r8a774a1.dtsi
> index 7e643243c3b..9065dc24342 100644
> --- a/arch/arm/dts/r8a774a1.dtsi
> +++ b/arch/arm/dts/r8a774a1.dtsi
> @@ -1678,7 +1678,7 @@
>
>                 rcar_sound: sound@ec500000 {
>                         /*
> -                        * #sound-dai-cells is required
> +                        * #sound-dai-cells is required if simple-card
>                          *
>                          * Single DAI : #sound-dai-cells =3D <0>; <&rcar_=
sound>;
>                          * Multi  DAI : #sound-dai-cells =3D <1>; <&rcar_=
sound N>;
> @@ -2359,8 +2359,8 @@
>                                  <0x02000000 0 0xfe200000 0 0xfe200000 0 =
0x00200000>,
>                                  <0x02000000 0 0x30000000 0 0x30000000 0 =
0x08000000>,
>                                  <0x42000000 0 0x38000000 0 0x38000000 0 =
0x08000000>;
> -                       /* Map all possible DDR as inbound ranges */
> -                       dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000=
000 0 0x80000000>;
> +                       /* Map all possible DDR/IOMMU as inbound ranges *=
/
> +                       dma-ranges =3D <0x42000000 0 0x00000000 0 0x00000=
000 1 0x00000000>;
>                         interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2371,6 +2371,8 @@
>                         clock-names =3D "pcie", "pcie_bus";
>                         power-domains =3D <&sysc R8A774A1_PD_ALWAYS_ON>;
>                         resets =3D <&cpg 319>;
> +                       iommu-map =3D <0 &ipmmu_hc 0 1>;
> +                       iommu-map-mask =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -2386,8 +2388,8 @@
>                                  <0x02000000 0 0xeea00000 0 0xeea00000 0 =
0x00200000>,
>                                  <0x02000000 0 0xc0000000 0 0xc0000000 0 =
0x08000000>,
>                                  <0x42000000 0 0xc8000000 0 0xc8000000 0 =
0x08000000>;
> -                       /* Map all possible DDR as inbound ranges */
> -                       dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000=
000 0 0x80000000>;
> +                       /* Map all possible DDR/IOMMU as inbound ranges *=
/
> +                       dma-ranges =3D <0x42000000 0 0x00000000 0 0x00000=
000 1 0x00000000>;
>                         interrupts =3D <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2398,6 +2400,8 @@
>                         clock-names =3D "pcie", "pcie_bus";
>                         power-domains =3D <&sysc R8A774A1_PD_ALWAYS_ON>;
>                         resets =3D <&cpg 318>;
> +                       iommu-map =3D <0 &ipmmu_hc 1 1>;
> +                       iommu-map-mask =3D <0>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.40.1
>
