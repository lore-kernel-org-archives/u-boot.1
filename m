Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F739C25B79
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 15:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBE687E88;
	Mon, 20 May 2024 17:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bo60zVWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F21D87ED3; Mon, 20 May 2024 17:19:23 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E489687E06
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 17:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso74029005ad.1
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716218358; x=1716823158; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsfNft4C/HC4daY5TE+cHQP8TckqRhPvYcNku7lAvrs=;
 b=bo60zVWsjAeGWSytDLBTHbShDEjnurGpctqkgiJqD78tkoCoaFr+oWmC5vD8NjL/Rb
 OqP112n1xvjwEdKoY8oPfaWWhvWOu3/zLfdvpgs0MP6PZMVaxH7nojuh2LRsY/N+3RtU
 76xBSEVvGodccPrQWaGiDSxdYACYuMGBstysq0YJ64H4ik3JpYa8HBRWjl4oY2jSHrj+
 RuP22Sc1/zJRymUY+fmWIIHsidJm9v2RdwhpvkVtT/xRqI9avM9DmOfvmu2eCtb8vqUJ
 l+cNehPwImEJyr18Rs+UnG3VgUZQ8TkiHFSXHiNvx7T2TYM6Q1KlMLPTj/lQhJFEUcDa
 U0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716218358; x=1716823158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsfNft4C/HC4daY5TE+cHQP8TckqRhPvYcNku7lAvrs=;
 b=ZKCRPjMEGCLWzpVZWL98TzAdsjjZkpRbUU6DeJXGqMasCaFpnzmWFBcUS92Ju4Eb0C
 y7ujg5gFoBO+Aa85yA2rW8qXUo/WChtP6Upqs+qVINwfvaMK7q379RqBUWlCPb4ZpISD
 y4ZkKEFAjkmEQARAQK1bRQRijUUbmuQqBogsoEV9IEElgBjH5WWgRieISJzb3Wj1xaj5
 5twjnBgeo1G9rGfMJ2pF3DuBKvJhke+UhwuuQmLuMOZPczpYRuR19KitbbV6KXtopAaL
 NAQkBYDTSYWfTNG3zuE20nrHO7zP8cfrliRqAOlavwCPpwI4tPkxwXjWao+hsNyzvkTl
 MIdw==
X-Gm-Message-State: AOJu0YwwF6zUfF2i2SvzlObh37YQk2YDCyaSHPKyCh2hcT0G57RO7Ch5
 tWJdJEdh0nIdxlKlpBHiPkVmQNyUmQxNn++cPqL77uV6BQ8j6G2rSVEOCm+z30kgg1ycKRR0YA5
 KysQhqyVa2IojKqTnttl+QwIMuOI=
X-Google-Smtp-Source: AGHT+IFfnZNocln6AWY6aqyb/AiAy90QPjTX+31x+uD9kygNFTGgpD6J6vLdFzHA+EBjiyky0uPrYmzGActZsAa0mP4=
X-Received: by 2002:a17:90b:4f8d:b0:2bd:6e54:b764 with SMTP id
 98e67ed59e1d1-2bd6e54c556mr3920950a91.35.1716218358014; Mon, 20 May 2024
 08:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240519203944.187134-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240519203944.187134-1-marek.vasut+renesas@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 20 May 2024 10:19:06 -0500
Message-ID: <CAHCN7x+wyK8JUZaJ2yoY3R8f-0EWVhhE2cxmOf=A4T18eDE3Yg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: renesas: Remove leftovers after OF_UPSTREAM
 conversion
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Sun, May 19, 2024 at 3:40=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Remove leftover DTSI files after OF_UPSTREAM conversion.
> Those are no longer used and no longer necessary, remove them.
> No functional change.
>

This seems like the right thing to do.

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Adam Ford <aford173@gmail.com>

> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/dts/salvator-common.dtsi        | 1104 ----------------------
>  arch/arm/dts/salvator-x.dtsi             |   29 -
>  arch/arm/dts/salvator-xs.dtsi            |   85 --
>  arch/arm/dts/ulcb-audio-graph-card.dtsi  |   85 --
>  arch/arm/dts/ulcb-audio-graph-card2.dtsi |   26 -
>  arch/arm/dts/ulcb.dtsi                   |  509 ----------
>  6 files changed, 1838 deletions(-)
>  delete mode 100644 arch/arm/dts/salvator-common.dtsi
>  delete mode 100644 arch/arm/dts/salvator-x.dtsi
>  delete mode 100644 arch/arm/dts/salvator-xs.dtsi
>  delete mode 100644 arch/arm/dts/ulcb-audio-graph-card.dtsi
>  delete mode 100644 arch/arm/dts/ulcb-audio-graph-card2.dtsi
>  delete mode 100644 arch/arm/dts/ulcb.dtsi
>
> diff --git a/arch/arm/dts/salvator-common.dtsi b/arch/arm/dts/salvator-co=
mmon.dtsi
> deleted file mode 100644
> index 4a3d5037821..00000000000
> --- a/arch/arm/dts/salvator-common.dtsi
> +++ /dev/null
> @@ -1,1104 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for common parts of Salvator-X board variants
> - *
> - * Copyright (C) 2015-2016 Renesas Electronics Corp.
> - */
> -
> -/*
> - * SSI-AK4613
> - *
> - * This command is required when Playback/Capture
> - *
> - *     amixer set "DVC Out" 100%
> - *     amixer set "DVC In" 100%
> - *
> - * You can use Mute
> - *
> - *     amixer set "DVC Out Mute" on
> - *     amixer set "DVC In Mute" on
> - *
> - * You can use Volume Ramp
> - *
> - *     amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
> - *     amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
> - *     amixer set "DVC Out Ramp" on
> - *     aplay xxx.wav &
> - *     amixer set "DVC Out"  80%  // Volume Down
> - *     amixer set "DVC Out" 100%  // Volume Up
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -       aliases {
> -               i2c0 =3D &i2c0;
> -               i2c1 =3D &i2c1;
> -               i2c2 =3D &i2c2;
> -               i2c3 =3D &i2c3;
> -               i2c4 =3D &i2c4;
> -               i2c5 =3D &i2c5;
> -               i2c6 =3D &i2c6;
> -               i2c7 =3D &i2c_dvfs;
> -               serial0 =3D &scif2;
> -               serial1 =3D &hscif1;
> -               ethernet0 =3D &avb;
> -               mmc0 =3D &sdhi2;
> -               mmc1 =3D &sdhi0;
> -               mmc2 =3D &sdhi3;
> -       };
> -
> -       chosen {
> -               bootargs =3D "ignore_loglevel rw root=3D/dev/nfs ip=3Don"=
;
> -               stdout-path =3D "serial0:115200n8";
> -       };
> -
> -       audio_clkout: audio-clkout {
> -               /*
> -                * This is same as <&rcar_sound 0>
> -                * but needed to avoid cs2000/rcar_sound probe dead-lock
> -                */
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <12288000>;
> -       };
> -
> -       backlight: backlight {
> -               compatible =3D "pwm-backlight";
> -               pwms =3D <&pwm1 0 50000>;
> -
> -               brightness-levels =3D <256 128 64 16 8 4 0>;
> -               default-brightness-level =3D <6>;
> -
> -               power-supply =3D <&reg_12v>;
> -               enable-gpios =3D <&gpio6 7 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       cvbs-in {
> -               compatible =3D "composite-video-connector";
> -               label =3D "CVBS IN";
> -
> -               port {
> -                       cvbs_con: endpoint {
> -                               remote-endpoint =3D <&adv7482_ain7>;
> -                       };
> -               };
> -       };
> -
> -       hdmi-in {
> -               compatible =3D "hdmi-connector";
> -               label =3D "HDMI IN";
> -               type =3D "a";
> -
> -               port {
> -                       hdmi_in_con: endpoint {
> -                               remote-endpoint =3D <&adv7482_hdmi>;
> -                       };
> -               };
> -       };
> -
> -       hdmi0-out {
> -               compatible =3D "hdmi-connector";
> -               label =3D "HDMI0 OUT";
> -               type =3D "a";
> -
> -               port {
> -                       hdmi0_con: endpoint {
> -                               remote-endpoint =3D <&rcar_dw_hdmi0_out>;
> -                       };
> -               };
> -       };
> -
> -       hdmi1-out {
> -               compatible =3D "hdmi-connector";
> -               label =3D "HDMI1 OUT";
> -               type =3D "a";
> -
> -               port {
> -                       hdmi1_con: endpoint {
> -                       };
> -               };
> -       };
> -
> -       keys {
> -               compatible =3D "gpio-keys";
> -
> -               pinctrl-0 =3D <&keys_pins>;
> -               pinctrl-names =3D "default";
> -
> -               key-1 {
> -                       gpios =3D <&gpio5 17 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_1>;
> -                       label =3D "SW4-1";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -               key-2 {
> -                       gpios =3D <&gpio5 20 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_2>;
> -                       label =3D "SW4-2";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -               key-3 {
> -                       gpios =3D <&gpio5 22 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_3>;
> -                       label =3D "SW4-3";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -               key-4 {
> -                       gpios =3D <&gpio5 23 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_4>;
> -                       label =3D "SW4-4";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -               key-a {
> -                       gpios =3D <&gpio6 11 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_A>;
> -                       label =3D "TSW0";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -               key-b {
> -                       gpios =3D <&gpio6 12 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_B>;
> -                       label =3D "TSW1";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -               key-c {
> -                       gpios =3D <&gpio6 13 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_C>;
> -                       label =3D "TSW2";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -               };
> -       };
> -
> -       reg_1p8v: regulator-1p8v {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "fixed-1.8V";
> -               regulator-min-microvolt =3D <1800000>;
> -               regulator-max-microvolt =3D <1800000>;
> -               regulator-boot-on;
> -               regulator-always-on;
> -       };
> -
> -       reg_3p3v: regulator-3p3v {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "fixed-3.3V";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -               regulator-boot-on;
> -               regulator-always-on;
> -       };
> -
> -       reg_12v: regulator-12v {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "fixed-12V";
> -               regulator-min-microvolt =3D <12000000>;
> -               regulator-max-microvolt =3D <12000000>;
> -               regulator-boot-on;
> -               regulator-always-on;
> -       };
> -
> -       sound_card: sound {
> -               compatible =3D "audio-graph-card";
> -
> -               label =3D "rcar-sound";
> -
> -               dais =3D <&rsnd_port0     /* ak4613 */
> -                       &rsnd_port1     /* HDMI0  */
> -#ifdef SOC_HAS_HDMI1
> -                       &rsnd_port2     /* HDMI1  */
> -#endif
> -                       >;
> -       };
> -
> -       vbus0_usb2: regulator-vbus0-usb2 {
> -               compatible =3D "regulator-fixed";
> -
> -               regulator-name =3D "USB20_VBUS0";
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -
> -               gpio =3D <&gpio6 16 GPIO_ACTIVE_HIGH>;
> -               enable-active-high;
> -       };
> -
> -       vcc_sdhi0: regulator-vcc-sdhi0 {
> -               compatible =3D "regulator-fixed";
> -
> -               regulator-name =3D "SDHI0 Vcc";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -
> -               gpio =3D <&gpio5 2 GPIO_ACTIVE_HIGH>;
> -               enable-active-high;
> -       };
> -
> -       vccq_sdhi0: regulator-vccq-sdhi0 {
> -               compatible =3D "regulator-gpio";
> -
> -               regulator-name =3D "SDHI0 VccQ";
> -               regulator-min-microvolt =3D <1800000>;
> -               regulator-max-microvolt =3D <3300000>;
> -
> -               gpios =3D <&gpio5 1 GPIO_ACTIVE_HIGH>;
> -               gpios-states =3D <1>;
> -               states =3D <3300000 1>, <1800000 0>;
> -       };
> -
> -       vcc_sdhi3: regulator-vcc-sdhi3 {
> -               compatible =3D "regulator-fixed";
> -
> -               regulator-name =3D "SDHI3 Vcc";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -
> -               gpio =3D <&gpio3 15 GPIO_ACTIVE_HIGH>;
> -               enable-active-high;
> -       };
> -
> -       vccq_sdhi3: regulator-vccq-sdhi3 {
> -               compatible =3D "regulator-gpio";
> -
> -               regulator-name =3D "SDHI3 VccQ";
> -               regulator-min-microvolt =3D <1800000>;
> -               regulator-max-microvolt =3D <3300000>;
> -
> -               gpios =3D <&gpio3 14 GPIO_ACTIVE_HIGH>;
> -               gpios-states =3D <1>;
> -               states =3D <3300000 1>, <1800000 0>;
> -       };
> -
> -       vga {
> -               compatible =3D "vga-connector";
> -
> -               port {
> -                       vga_in: endpoint {
> -                               remote-endpoint =3D <&adv7123_out>;
> -                       };
> -               };
> -       };
> -
> -       vga-encoder {
> -               compatible =3D "adi,adv7123";
> -
> -               ports {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -
> -                       port@0 {
> -                               reg =3D <0>;
> -                               adv7123_in: endpoint {
> -                                       remote-endpoint =3D <&du_out_rgb>=
;
> -                               };
> -                       };
> -                       port@1 {
> -                               reg =3D <1>;
> -                               adv7123_out: endpoint {
> -                                       remote-endpoint =3D <&vga_in>;
> -                               };
> -                       };
> -               };
> -       };
> -
> -       x12_clk: x12 {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <24576000>;
> -       };
> -
> -       /* External DU dot clocks */
> -       x21_clk: x21-clock {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <33000000>;
> -       };
> -
> -       x22_clk: x22-clock {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <33000000>;
> -       };
> -
> -       x23_clk: x23-clock {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <25000000>;
> -       };
> -};
> -
> -&a57_0 {
> -       cpu-supply =3D <&dvfs>;
> -};
> -
> -&audio_clk_a {
> -       clock-frequency =3D <22579200>;
> -};
> -
> -&avb {
> -       pinctrl-0 =3D <&avb_pins>;
> -       pinctrl-names =3D "default";
> -       phy-handle =3D <&phy0>;
> -       tx-internal-delay-ps =3D <2000>;
> -       status =3D "okay";
> -
> -       phy0: ethernet-phy@0 {
> -               compatible =3D "ethernet-phy-id0022.1622",
> -                            "ethernet-phy-ieee802.3-c22";
> -               rxc-skew-ps =3D <1500>;
> -               reg =3D <0>;
> -               interrupt-parent =3D <&gpio2>;
> -               interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> -               reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
> -       };
> -};
> -
> -&csi20 {
> -       status =3D "okay";
> -
> -       ports {
> -               port@0 {
> -                       csi20_in: endpoint {
> -                               clock-lanes =3D <0>;
> -                               data-lanes =3D <1>;
> -                               remote-endpoint =3D <&adv7482_txb>;
> -                       };
> -               };
> -       };
> -};
> -
> -&csi40 {
> -       status =3D "okay";
> -
> -       ports {
> -               port@0 {
> -                       csi40_in: endpoint {
> -                               clock-lanes =3D <0>;
> -                               data-lanes =3D <1 2 3 4>;
> -                               remote-endpoint =3D <&adv7482_txa>;
> -                       };
> -               };
> -       };
> -};
> -
> -&du {
> -       pinctrl-0 =3D <&du_pins>;
> -       pinctrl-names =3D "default";
> -       status =3D "okay";
> -
> -       ports {
> -               port@0 {
> -                       du_out_rgb: endpoint {
> -                               remote-endpoint =3D <&adv7123_in>;
> -                       };
> -               };
> -       };
> -};
> -
> -&ehci0 {
> -       dr_mode =3D "otg";
> -       status =3D "okay";
> -};
> -
> -&ehci1 {
> -       status =3D "okay";
> -};
> -
> -&extalr_clk {
> -       clock-frequency =3D <32768>;
> -};
> -
> -&hdmi0 {
> -       status =3D "okay";
> -
> -       ports {
> -               port@1 {
> -                       reg =3D <1>;
> -                       rcar_dw_hdmi0_out: endpoint {
> -                               remote-endpoint =3D <&hdmi0_con>;
> -                       };
> -               };
> -               port@2 {
> -                       reg =3D <2>;
> -                       dw_hdmi0_snd_in: endpoint {
> -                               remote-endpoint =3D <&rsnd_endpoint1>;
> -                       };
> -               };
> -       };
> -};
> -
> -#ifdef SOC_HAS_HDMI1
> -&hdmi1 {
> -       status =3D "okay";
> -
> -       ports {
> -               port@1 {
> -                       reg =3D <1>;
> -                       rcar_dw_hdmi1_out: endpoint {
> -                               remote-endpoint =3D <&hdmi1_con>;
> -                       };
> -               };
> -               port@2 {
> -                       reg =3D <2>;
> -                       dw_hdmi1_snd_in: endpoint {
> -                               remote-endpoint =3D <&rsnd_endpoint2>;
> -                       };
> -               };
> -       };
> -};
> -
> -&hdmi1_con {
> -       remote-endpoint =3D <&rcar_dw_hdmi1_out>;
> -};
> -#endif /* SOC_HAS_HDMI1 */
> -
> -&hscif1 {
> -       pinctrl-0 =3D <&hscif1_pins>;
> -       pinctrl-names =3D "default";
> -
> -       uart-has-rtscts;
> -       /* Please only enable hscif1 or scif1 */
> -       status =3D "okay";
> -};
> -
> -&hsusb {
> -       dr_mode =3D "otg";
> -       status =3D "okay";
> -};
> -
> -&i2c2 {
> -       pinctrl-0 =3D <&i2c2_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -
> -       clock-frequency =3D <100000>;
> -
> -       ak4613: codec@10 {
> -               compatible =3D "asahi-kasei,ak4613";
> -               #sound-dai-cells =3D <0>;
> -               reg =3D <0x10>;
> -               clocks =3D <&rcar_sound 3>;
> -
> -               asahi-kasei,in1-single-end;
> -               asahi-kasei,in2-single-end;
> -               asahi-kasei,out1-single-end;
> -               asahi-kasei,out2-single-end;
> -               asahi-kasei,out3-single-end;
> -               asahi-kasei,out4-single-end;
> -               asahi-kasei,out5-single-end;
> -               asahi-kasei,out6-single-end;
> -
> -               port {
> -                       ak4613_endpoint: endpoint {
> -                               remote-endpoint =3D <&rsnd_endpoint0>;
> -                       };
> -               };
> -       };
> -
> -       cs2000: clk_multiplier@4f {
> -               #clock-cells =3D <0>;
> -               compatible =3D "cirrus,cs2000-cp";
> -               reg =3D <0x4f>;
> -               clocks =3D <&audio_clkout>, <&x12_clk>;
> -               clock-names =3D "clk_in", "ref_clk";
> -
> -               assigned-clocks =3D <&cs2000>;
> -               assigned-clock-rates =3D <24576000>; /* 1/1 divide */
> -       };
> -};
> -
> -&i2c4 {
> -       status =3D "okay";
> -
> -       pca9654: gpio@20 {
> -               compatible =3D "onnn,pca9654";
> -               reg =3D <0x20>;
> -               gpio-controller;
> -               #gpio-cells =3D <2>;
> -       };
> -
> -       video-receiver@70 {
> -               compatible =3D "adi,adv7482";
> -               reg =3D <0x70 0x71 0x72 0x73 0x74 0x75
> -                      0x60 0x61 0x62 0x63 0x64 0x65>;
> -               reg-names =3D "main", "dpll", "cp", "hdmi", "edid", "repe=
ater",
> -                           "infoframe", "cbus", "cec", "sdp", "txa", "tx=
b" ;
> -
> -               interrupt-parent =3D <&gpio6>;
> -               interrupt-names =3D "intrq1", "intrq2";
> -               interrupts =3D <30 IRQ_TYPE_LEVEL_LOW>,
> -                            <31 IRQ_TYPE_LEVEL_LOW>;
> -
> -               ports {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -
> -                       port@7 {
> -                               reg =3D <7>;
> -
> -                               adv7482_ain7: endpoint {
> -                                       remote-endpoint =3D <&cvbs_con>;
> -                               };
> -                       };
> -
> -                       port@8 {
> -                               reg =3D <8>;
> -
> -                               adv7482_hdmi: endpoint {
> -                                       remote-endpoint =3D <&hdmi_in_con=
>;
> -                               };
> -                       };
> -
> -                       port@a {
> -                               reg =3D <10>;
> -
> -                               adv7482_txa: endpoint {
> -                                       clock-lanes =3D <0>;
> -                                       data-lanes =3D <1 2 3 4>;
> -                                       remote-endpoint =3D <&csi40_in>;
> -                               };
> -                       };
> -
> -                       port@b {
> -                               reg =3D <11>;
> -
> -                               adv7482_txb: endpoint {
> -                                       clock-lanes =3D <0>;
> -                                       data-lanes =3D <1>;
> -                                       remote-endpoint =3D <&csi20_in>;
> -                               };
> -                       };
> -               };
> -       };
> -
> -       csa_vdd: adc@7c {
> -               compatible =3D "maxim,max9611";
> -               reg =3D <0x7c>;
> -
> -               shunt-resistor-micro-ohms =3D <5000>;
> -       };
> -
> -       csa_dvfs: adc@7f {
> -               compatible =3D "maxim,max9611";
> -               reg =3D <0x7f>;
> -
> -               shunt-resistor-micro-ohms =3D <5000>;
> -       };
> -};
> -
> -&i2c_dvfs {
> -       status =3D "okay";
> -
> -       clock-frequency =3D <400000>;
> -
> -       pmic: pmic@30 {
> -               pinctrl-0 =3D <&irq0_pins>;
> -               pinctrl-names =3D "default";
> -
> -               compatible =3D "rohm,bd9571mwv";
> -               reg =3D <0x30>;
> -               interrupt-parent =3D <&intc_ex>;
> -               interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> -               interrupt-controller;
> -               #interrupt-cells =3D <2>;
> -               gpio-controller;
> -               #gpio-cells =3D <2>;
> -               rohm,ddr-backup-power =3D <0xf>;
> -               rohm,rstbmode-level;
> -
> -               regulators {
> -                       dvfs: dvfs {
> -                               regulator-name =3D "dvfs";
> -                               regulator-min-microvolt =3D <750000>;
> -                               regulator-max-microvolt =3D <1030000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -               };
> -       };
> -
> -       eeprom@50 {
> -               compatible =3D "rohm,br24t01", "atmel,24c01";
> -               reg =3D <0x50>;
> -               pagesize =3D <8>;
> -       };
> -};
> -
> -&ohci0 {
> -       dr_mode =3D "otg";
> -       status =3D "okay";
> -};
> -
> -&ohci1 {
> -       status =3D "okay";
> -};
> -
> -&pcie_bus_clk {
> -       clock-frequency =3D <100000000>;
> -};
> -
> -&pciec0 {
> -       status =3D "okay";
> -};
> -
> -&pciec1 {
> -       status =3D "okay";
> -};
> -
> -&pfc {
> -       pinctrl-0 =3D <&scif_clk_pins>;
> -       pinctrl-names =3D "default";
> -
> -       avb_pins: avb {
> -               mux {
> -                       groups =3D "avb_link", "avb_mdio", "avb_mii";
> -                       function =3D "avb";
> -               };
> -
> -               pins_mdio {
> -                       groups =3D "avb_mdio";
> -                       drive-strength =3D <24>;
> -               };
> -
> -               pins_mii_tx {
> -                       pins =3D "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AV=
B_TD0",
> -                              "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3=
";
> -                       drive-strength =3D <12>;
> -               };
> -       };
> -
> -       du_pins: du {
> -               groups =3D "du_rgb888", "du_sync", "du_oddf", "du_clk_out=
_0";
> -               function =3D "du";
> -       };
> -
> -       hscif1_pins: hscif1 {
> -               groups =3D "hscif1_data_a", "hscif1_ctrl_a";
> -               function =3D "hscif1";
> -       };
> -
> -       i2c2_pins: i2c2 {
> -               groups =3D "i2c2_a";
> -               function =3D "i2c2";
> -       };
> -
> -       irq0_pins: irq0 {
> -               groups =3D "intc_ex_irq0";
> -               function =3D "intc_ex";
> -       };
> -
> -       keys_pins: keys {
> -               pins =3D "GP_5_17", "GP_5_20", "GP_5_22";
> -               bias-pull-up;
> -       };
> -
> -       pwm1_pins: pwm1 {
> -               groups =3D "pwm1_a";
> -               function =3D "pwm1";
> -       };
> -
> -       scif1_pins: scif1 {
> -               groups =3D "scif1_data_a", "scif1_ctrl";
> -               function =3D "scif1";
> -       };
> -
> -       scif2_pins: scif2 {
> -               groups =3D "scif2_data_a";
> -               function =3D "scif2";
> -       };
> -
> -       scif_clk_pins: scif_clk {
> -               groups =3D "scif_clk_a";
> -               function =3D "scif_clk";
> -       };
> -
> -       sdhi0_pins: sd0 {
> -               groups =3D "sdhi0_data4", "sdhi0_ctrl";
> -               function =3D "sdhi0";
> -               power-source =3D <3300>;
> -       };
> -
> -       sdhi0_pins_uhs: sd0_uhs {
> -               groups =3D "sdhi0_data4", "sdhi0_ctrl";
> -               function =3D "sdhi0";
> -               power-source =3D <1800>;
> -       };
> -
> -       sdhi2_pins: sd2 {
> -               groups =3D "sdhi2_data8", "sdhi2_ctrl", "sdhi2_ds";
> -               function =3D "sdhi2";
> -               power-source =3D <1800>;
> -       };
> -
> -       sdhi3_pins: sd3 {
> -               groups =3D "sdhi3_data4", "sdhi3_ctrl";
> -               function =3D "sdhi3";
> -               power-source =3D <3300>;
> -       };
> -
> -       sdhi3_pins_uhs: sd3_uhs {
> -               groups =3D "sdhi3_data4", "sdhi3_ctrl";
> -               function =3D "sdhi3";
> -               power-source =3D <1800>;
> -       };
> -
> -       sound_pins: sound {
> -               groups =3D "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
> -               function =3D "ssi";
> -       };
> -
> -       sound_clk_pins: sound_clk {
> -               groups =3D "audio_clk_a_a", "audio_clk_b_a", "audio_clk_c=
_a",
> -                        "audio_clkout_a", "audio_clkout3_a";
> -               function =3D "audio_clk";
> -       };
> -
> -       usb0_pins: usb0 {
> -               groups =3D "usb0";
> -               function =3D "usb0";
> -       };
> -
> -       usb1_pins: usb1 {
> -               mux {
> -                       groups =3D "usb1";
> -                       function =3D "usb1";
> -               };
> -
> -               ovc {
> -                       pins =3D "GP_6_27";
> -                       bias-pull-up;
> -               };
> -
> -               pwen {
> -                       pins =3D "GP_6_26";
> -                       bias-pull-down;
> -               };
> -       };
> -
> -       usb30_pins: usb30 {
> -               groups =3D "usb30";
> -               function =3D "usb30";
> -       };
> -};
> -
> -&pwm1 {
> -       pinctrl-0 =3D <&pwm1_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -
> -&rcar_sound {
> -       pinctrl-0 =3D <&sound_pins>, <&sound_clk_pins>;
> -       pinctrl-names =3D "default";
> -
> -       /* audio_clkout0/1/2/3 */
> -       #clock-cells =3D <1>;
> -       clock-frequency =3D <12288000 11289600>;
> -
> -       status =3D "okay";
> -
> -       /* update <audio_clk_b> to <cs2000> */
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
> -                <&audio_clk_a>, <&cs2000>,
> -                <&audio_clk_c>,
> -                <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
> -
> -       ports {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               rsnd_port0: port@0 {
> -                       reg =3D <0>;
> -                       rsnd_endpoint0: endpoint {
> -                               remote-endpoint =3D <&ak4613_endpoint>;
> -
> -                               dai-format =3D "left_j";
> -                               bitclock-master =3D <&rsnd_endpoint0>;
> -                               frame-master =3D <&rsnd_endpoint0>;
> -
> -                               playback =3D <&ssi0>, <&src0>, <&dvc0>;
> -                               capture =3D <&ssi1>, <&src1>, <&dvc1>;
> -                       };
> -               };
> -
> -               rsnd_port1: port@1 {
> -                       reg =3D <1>;
> -                       rsnd_endpoint1: endpoint {
> -                               remote-endpoint =3D <&dw_hdmi0_snd_in>;
> -
> -                               dai-format =3D "i2s";
> -                               bitclock-master =3D <&rsnd_endpoint1>;
> -                               frame-master =3D <&rsnd_endpoint1>;
> -
> -                               playback =3D <&ssi2>;
> -                       };
> -               };
> -
> -#ifdef SOC_HAS_HDMI1
> -               rsnd_port2: port@2 {
> -                       reg =3D <2>;
> -                       rsnd_endpoint2: endpoint {
> -                               remote-endpoint =3D <&dw_hdmi1_snd_in>;
> -
> -                               dai-format =3D "i2s";
> -                               bitclock-master =3D <&rsnd_endpoint2>;
> -                               frame-master =3D <&rsnd_endpoint2>;
> -
> -                               playback =3D <&ssi3>;
> -                       };
> -               };
> -#endif /* SOC_HAS_HDMI1 */
> -       };
> -};
> -
> -&rpc {
> -       /* Left disabled.  To be enabled by firmware when unlocked. */
> -
> -       flash@0 {
> -               compatible =3D "cypress,hyperflash", "cfi-flash";
> -               reg =3D <0>;
> -
> -               partitions {
> -                       compatible =3D "fixed-partitions";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> -
> -                       bootparam@0 {
> -                               reg =3D <0x00000000 0x040000>;
> -                               read-only;
> -                       };
> -                       bl2@40000 {
> -                               reg =3D <0x00040000 0x140000>;
> -                               read-only;
> -                       };
> -                       cert_header_sa6@180000 {
> -                               reg =3D <0x00180000 0x040000>;
> -                               read-only;
> -                       };
> -                       bl31@1c0000 {
> -                               reg =3D <0x001c0000 0x040000>;
> -                               read-only;
> -                       };
> -                       tee@200000 {
> -                               reg =3D <0x00200000 0x440000>;
> -                               read-only;
> -                       };
> -                       uboot@640000 {
> -                               reg =3D <0x00640000 0x100000>;
> -                               read-only;
> -                       };
> -                       dtb@740000 {
> -                               reg =3D <0x00740000 0x080000>;
> -                       };
> -                       kernel@7c0000 {
> -                               reg =3D <0x007c0000 0x1400000>;
> -                       };
> -                       user@1bc0000 {
> -                               reg =3D <0x01bc0000 0x2440000>;
> -                       };
> -               };
> -       };
> -};
> -
> -&rwdt {
> -       timeout-sec =3D <60>;
> -       status =3D "okay";
> -};
> -
> -#ifdef SOC_HAS_SATA
> -&sata {
> -       status =3D "okay";
> -};
> -#endif /* SOC_HAS_SATA */
> -
> -&scif1 {
> -       pinctrl-0 =3D <&scif1_pins>;
> -       pinctrl-names =3D "default";
> -
> -       uart-has-rtscts;
> -       /* Please only enable hscif1 or scif1 */
> -       /* status =3D "okay"; */
> -};
> -
> -&scif2 {
> -       pinctrl-0 =3D <&scif2_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -
> -&scif_clk {
> -       clock-frequency =3D <14745600>;
> -};
> -
> -&sdhi0 {
> -       pinctrl-0 =3D <&sdhi0_pins>;
> -       pinctrl-1 =3D <&sdhi0_pins_uhs>;
> -       pinctrl-names =3D "default", "state_uhs";
> -
> -       vmmc-supply =3D <&vcc_sdhi0>;
> -       vqmmc-supply =3D <&vccq_sdhi0>;
> -       cd-gpios =3D <&gpio3 12 GPIO_ACTIVE_LOW>;
> -       wp-gpios =3D <&gpio3 13 GPIO_ACTIVE_HIGH>;
> -       bus-width =3D <4>;
> -       sd-uhs-sdr50;
> -       sd-uhs-sdr104;
> -       status =3D "okay";
> -};
> -
> -&sdhi2 {
> -       /* used for on-board 8bit eMMC */
> -       pinctrl-0 =3D <&sdhi2_pins>;
> -       pinctrl-1 =3D <&sdhi2_pins>;
> -       pinctrl-names =3D "default", "state_uhs";
> -
> -       vmmc-supply =3D <&reg_3p3v>;
> -       vqmmc-supply =3D <&reg_1p8v>;
> -       bus-width =3D <8>;
> -       mmc-hs200-1_8v;
> -       mmc-hs400-1_8v;
> -       no-sd;
> -       no-sdio;
> -       non-removable;
> -       fixed-emmc-driver-type =3D <1>;
> -       full-pwr-cycle-in-suspend;
> -       status =3D "okay";
> -};
> -
> -&sdhi3 {
> -       pinctrl-0 =3D <&sdhi3_pins>;
> -       pinctrl-1 =3D <&sdhi3_pins_uhs>;
> -       pinctrl-names =3D "default", "state_uhs";
> -
> -       vmmc-supply =3D <&vcc_sdhi3>;
> -       vqmmc-supply =3D <&vccq_sdhi3>;
> -       cd-gpios =3D <&gpio4 15 GPIO_ACTIVE_LOW>;
> -       wp-gpios =3D <&gpio4 16 GPIO_ACTIVE_HIGH>;
> -       bus-width =3D <4>;
> -       sd-uhs-sdr50;
> -       sd-uhs-sdr104;
> -       status =3D "okay";
> -};
> -
> -&ssi1 {
> -       shared-pin;
> -};
> -
> -&usb_extal_clk {
> -       clock-frequency =3D <50000000>;
> -};
> -
> -&usb2_phy0 {
> -       pinctrl-0 =3D <&usb0_pins>;
> -       pinctrl-names =3D "default";
> -
> -       vbus-supply =3D <&vbus0_usb2>;
> -       status =3D "okay";
> -};
> -
> -&usb2_phy1 {
> -       pinctrl-0 =3D <&usb1_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -
> -&usb3_peri0 {
> -       phys =3D <&usb3_phy0>;
> -       phy-names =3D "usb";
> -
> -       companion =3D <&xhci0>;
> -
> -       status =3D "okay";
> -};
> -
> -&usb3_phy0 {
> -       status =3D "okay";
> -};
> -
> -&usb3s0_clk {
> -       clock-frequency =3D <100000000>;
> -};
> -
> -&vin0 {
> -       status =3D "okay";
> -};
> -
> -&vin1 {
> -       status =3D "okay";
> -};
> -
> -&vin2 {
> -       status =3D "okay";
> -};
> -
> -&vin3 {
> -       status =3D "okay";
> -};
> -
> -&vin4 {
> -       status =3D "okay";
> -};
> -
> -&vin5 {
> -       status =3D "okay";
> -};
> -
> -&vin6 {
> -       status =3D "okay";
> -};
> -
> -&vin7 {
> -       status =3D "okay";
> -};
> -
> -&xhci0 {
> -       pinctrl-0 =3D <&usb30_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -
> -#ifdef SOC_HAS_USB2_CH2
> -&ehci2 {
> -       status =3D "okay";
> -};
> -
> -&ohci2 {
> -       status =3D "okay";
> -};
> -
> -&pfc {
> -       usb2_pins: usb2 {
> -               groups =3D "usb2";
> -               function =3D "usb2";
> -       };
> -};
> -
> -&usb2_phy2 {
> -       pinctrl-0 =3D <&usb2_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -#endif /* SOC_HAS_USB2_CH2 */
> diff --git a/arch/arm/dts/salvator-x.dtsi b/arch/arm/dts/salvator-x.dtsi
> deleted file mode 100644
> index ddee50e6463..00000000000
> --- a/arch/arm/dts/salvator-x.dtsi
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for the Salvator-X board
> - *
> - * Copyright (C) 2015-2016 Renesas Electronics Corp.
> - */
> -
> -#include "salvator-common.dtsi"
> -
> -/ {
> -       model =3D "Renesas Salvator-X board";
> -       compatible =3D "renesas,salvator-x";
> -};
> -
> -&extal_clk {
> -       clock-frequency =3D <16666666>;
> -};
> -
> -&i2c4 {
> -       clock-frequency =3D <400000>;
> -
> -       versaclock5: clock-generator@6a {
> -               compatible =3D "idt,5p49v5923";
> -               reg =3D <0x6a>;
> -               #clock-cells =3D <1>;
> -               clocks =3D <&x23_clk>;
> -               clock-names =3D "xin";
> -       };
> -};
> diff --git a/arch/arm/dts/salvator-xs.dtsi b/arch/arm/dts/salvator-xs.dts=
i
> deleted file mode 100644
> index 08b925624e1..00000000000
> --- a/arch/arm/dts/salvator-xs.dtsi
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for the Salvator-X 2nd version board
> - *
> - * Copyright (C) 2015-2017 Renesas Electronics Corp.
> - */
> -
> -#include "salvator-common.dtsi"
> -
> -/ {
> -       model =3D "Renesas Salvator-X 2nd version board";
> -       compatible =3D "renesas,salvator-xs";
> -};
> -
> -&extal_clk {
> -       clock-frequency =3D <16640000>;
> -};
> -
> -&i2c4 {
> -       clock-frequency =3D <400000>;
> -
> -       versaclock6: clock-generator@6a {
> -               compatible =3D "idt,5p49v6901";
> -               reg =3D <0x6a>;
> -               #clock-cells =3D <1>;
> -               clocks =3D <&x23_clk>;
> -               clock-names =3D "xin";
> -       };
> -};
> -
> -#ifdef SOC_HAS_SATA
> -&pca9654 {
> -       pcie-sata-switch-hog {
> -               gpio-hog;
> -               gpios =3D <7 GPIO_ACTIVE_HIGH>;
> -               output-low; /* enable SATA by default */
> -               line-name =3D "PCIE/SATA switch";
> -       };
> -};
> -
> -/* SW12-7 must be set 'Off' (MD12 set to 1) which is not the default! */
> -#endif /* SOC_HAS_SATA */
> -
> -#ifdef SOC_HAS_USB2_CH3
> -&ehci3 {
> -       dr_mode =3D "otg";
> -       status =3D "okay";
> -};
> -
> -&hsusb3 {
> -       dr_mode =3D "otg";
> -       status =3D "okay";
> -};
> -
> -&ohci3 {
> -       dr_mode =3D "otg";
> -       status =3D "okay";
> -};
> -
> -&pfc {
> -       /*
> -        * - On Salvator-X[S], GP6_3[01] are connected to ADV7482 as irq =
pins
> -        *   (when SW31 is the default setting on Salvator-XS).
> -        * - If SW31 is the default setting, you cannot use USB2.0 ch3 on
> -        *   r8a77951 with Salvator-XS.
> -        *   Hence the SW31 setting must be changed like 2) below.
> -        *   1) Default setting of SW31: ON-ON-OFF-OFF-OFF-OFF:
> -        *      - Connect GP6_3[01] to ADV7842.
> -        *   2) Changed setting of SW31: OFF-OFF-ON-ON-ON-ON:
> -        *      - Connect GP6_3[01] to BD082065 (USB2.0 ch3's host power)=
.
> -        *      - Connect GP6_{04,21} to ADV7842.
> -        */
> -       usb2_ch3_pins: usb2_ch3 {
> -               groups =3D "usb2_ch3";
> -               function =3D "usb2_ch3";
> -       };
> -};
> -
> -&usb2_phy3 {
> -       pinctrl-0 =3D <&usb2_ch3_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -#endif /* SOC_HAS_USB2_CH3 */
> diff --git a/arch/arm/dts/ulcb-audio-graph-card.dtsi b/arch/arm/dts/ulcb-=
audio-graph-card.dtsi
> deleted file mode 100644
> index 3be54df645e..00000000000
> --- a/arch/arm/dts/ulcb-audio-graph-card.dtsi
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree for ULCB + Audio Graph Card
> - *
> - * Copyright (C) 2022 Renesas Electronics Corp.
> - */
> -
> -/*
> - *     (A) CPU0 <-----> ak4613
> - *     (B) CPU1  -----> HDMI
> - *
> - *     (A) aplay   -D plughw:0,0 xxx.wav
> - *     (B) aplay   -D plughw:0,1 xxx.wav
> - *
> - *     (A) arecord -D plughw:0,0 xxx.wav
> - */
> -
> -/ {
> -       sound_card: sound {
> -               compatible =3D "audio-graph-card";
> -               label =3D "rcar-sound";
> -
> -               dais =3D <&rsnd_port0 /* (A) CPU0 <-> ak4613 */
> -                       &rsnd_port1 /* (B) CPU1  -> HDMI   */
> -               >;
> -       };
> -};
> -
> -&ak4613 {
> -       #sound-dai-cells =3D <0>;
> -
> -       port {
> -               /*
> -                * (A) CPU0 <-> ak4613
> -                */
> -               ak4613_endpoint: endpoint {
> -                       remote-endpoint =3D <&rsnd_for_ak4613>;
> -               };
> -       };
> -};
> -
> -&hdmi0 {
> -       ports {
> -               port@2 {
> -                       /*
> -                        * (B) CPU1 -> HDMI
> -                        */
> -                       dw_hdmi0_snd_in: endpoint {
> -                               remote-endpoint =3D <&rsnd_for_hdmi>;
> -                       };
> -               };
> -       };
> -};
> -
> -&rcar_sound {
> -       ports {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               rsnd_port0: port@0 {
> -                       /*
> -                        * (A) CPU0 <-> ak4613
> -                        */
> -                       reg =3D <0>;
> -                       rsnd_for_ak4613: endpoint {
> -                               remote-endpoint =3D <&ak4613_endpoint>;
> -                               bitclock-master;
> -                               frame-master;
> -                               playback =3D <&ssi0>, <&src0>, <&dvc0>;
> -                               capture  =3D <&ssi1>, <&src1>, <&dvc1>;
> -                       };
> -               };
> -               rsnd_port1: port@1 {
> -                       /*
> -                        * (B) CPU1 -> HDMI
> -                        */
> -                       reg =3D <1>;
> -                       rsnd_for_hdmi: endpoint {
> -                               remote-endpoint =3D <&dw_hdmi0_snd_in>;
> -                               bitclock-master;
> -                               frame-master;
> -                               playback =3D <&ssi2>;
> -                       };
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/ulcb-audio-graph-card2.dtsi b/arch/arm/dts/ulcb=
-audio-graph-card2.dtsi
> deleted file mode 100644
> index 5ebec123584..00000000000
> --- a/arch/arm/dts/ulcb-audio-graph-card2.dtsi
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree for ULCB + Audio Graph Card2
> - *
> - * Copyright (C) 2022 Renesas Electronics Corp.
> - */
> -
> -/*
> - *     (A) CPU0 <----> ak4613
> - *     (B) CPU1  ----> HDMI
> - *
> - *     (A) aplay   -D plughw:0,0 xxx.wav
> - *     (B) aplay   -D plughw:0,1 xxx.wav
> - *
> - *     (A) arecord -D plughw:0,0 xxx.wav
> - */
> -#include "ulcb-audio-graph-card.dtsi"
> -
> -&sound_card {
> -       compatible =3D "audio-graph-card2";
> -
> -       /delete-property/ dais;
> -       links =3D <&rsnd_port0    /* (A) CPU0 <-> ak4613 */
> -                &rsnd_port1    /* (B) CPU1  -> HDMI   */
> -               >;
> -};
> diff --git a/arch/arm/dts/ulcb.dtsi b/arch/arm/dts/ulcb.dtsi
> deleted file mode 100644
> index 0be2716659e..00000000000
> --- a/arch/arm/dts/ulcb.dtsi
> +++ /dev/null
> @@ -1,509 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for the R-Car Gen3 ULCB board
> - *
> - * Copyright (C) 2016 Renesas Electronics Corp.
> - * Copyright (C) 2016 Cogent Embedded, Inc.
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -       model =3D "Renesas R-Car Gen3 ULCB board";
> -
> -       aliases {
> -               i2c0 =3D &i2c0;
> -               i2c1 =3D &i2c1;
> -               i2c2 =3D &i2c2;
> -               i2c3 =3D &i2c3;
> -               i2c4 =3D &i2c4;
> -               i2c5 =3D &i2c5;
> -               i2c6 =3D &i2c6;
> -               i2c7 =3D &i2c_dvfs;
> -               serial0 =3D &scif2;
> -               ethernet0 =3D &avb;
> -               mmc0 =3D &sdhi2;
> -               mmc1 =3D &sdhi0;
> -       };
> -
> -       chosen {
> -               bootargs =3D "ignore_loglevel rw root=3D/dev/nfs ip=3Don"=
;
> -               stdout-path =3D "serial0:115200n8";
> -       };
> -
> -       audio_clkout: audio-clkout {
> -               /*
> -                * This is same as <&rcar_sound 0>
> -                * but needed to avoid cs2000/rcar_sound probe dead-lock
> -                */
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <12288000>;
> -       };
> -
> -       hdmi0-out {
> -               compatible =3D "hdmi-connector";
> -               type =3D "a";
> -
> -               port {
> -                       hdmi0_con: endpoint {
> -                               remote-endpoint =3D <&rcar_dw_hdmi0_out>;
> -                       };
> -               };
> -       };
> -
> -       keyboard {
> -               compatible =3D "gpio-keys";
> -
> -               key-1 {
> -                       linux,code =3D <KEY_1>;
> -                       label =3D "SW3";
> -                       wakeup-source;
> -                       debounce-interval =3D <20>;
> -                       gpios =3D <&gpio6 11 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       leds {
> -               compatible =3D "gpio-leds";
> -
> -               led5 {
> -                       gpios =3D <&gpio6 12 GPIO_ACTIVE_HIGH>;
> -               };
> -               led6 {
> -                       gpios =3D <&gpio6 13 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       reg_1p8v: regulator-1p8v {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "fixed-1.8V";
> -               regulator-min-microvolt =3D <1800000>;
> -               regulator-max-microvolt =3D <1800000>;
> -               regulator-boot-on;
> -               regulator-always-on;
> -       };
> -
> -       reg_3p3v: regulator-3p3v {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "fixed-3.3V";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -               regulator-boot-on;
> -               regulator-always-on;
> -       };
> -
> -       vcc_sdhi0: regulator-vcc-sdhi0 {
> -               compatible =3D "regulator-fixed";
> -
> -               regulator-name =3D "SDHI0 Vcc";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -
> -               gpio =3D <&gpio5 2 GPIO_ACTIVE_HIGH>;
> -               enable-active-high;
> -       };
> -
> -       vccq_sdhi0: regulator-vccq-sdhi0 {
> -               compatible =3D "regulator-gpio";
> -
> -               regulator-name =3D "SDHI0 VccQ";
> -               regulator-min-microvolt =3D <1800000>;
> -               regulator-max-microvolt =3D <3300000>;
> -
> -               gpios =3D <&gpio5 1 GPIO_ACTIVE_HIGH>;
> -               gpios-states =3D <1>;
> -               states =3D <3300000 1>, <1800000 0>;
> -       };
> -
> -       x12_clk: x12 {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <24576000>;
> -       };
> -
> -       x23_clk: x23-clock {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <25000000>;
> -       };
> -};
> -
> -&a57_0 {
> -       cpu-supply =3D <&dvfs>;
> -};
> -
> -&audio_clk_a {
> -       clock-frequency =3D <22579200>;
> -};
> -
> -&avb {
> -       pinctrl-0 =3D <&avb_pins>;
> -       pinctrl-names =3D "default";
> -       phy-handle =3D <&phy0>;
> -       tx-internal-delay-ps =3D <2000>;
> -       status =3D "okay";
> -
> -       phy0: ethernet-phy@0 {
> -               compatible =3D "ethernet-phy-id0022.1622",
> -                            "ethernet-phy-ieee802.3-c22";
> -               rxc-skew-ps =3D <1500>;
> -               reg =3D <0>;
> -               interrupt-parent =3D <&gpio2>;
> -               interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> -               reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
> -       };
> -};
> -
> -&du {
> -       status =3D "okay";
> -};
> -
> -&ehci1 {
> -       status =3D "okay";
> -};
> -
> -&extal_clk {
> -       clock-frequency =3D <16666666>;
> -};
> -
> -&extalr_clk {
> -       clock-frequency =3D <32768>;
> -};
> -
> -&hdmi0 {
> -       status =3D "okay";
> -
> -       ports {
> -               port@1 {
> -                       reg =3D <1>;
> -                       rcar_dw_hdmi0_out: endpoint {
> -                               remote-endpoint =3D <&hdmi0_con>;
> -                       };
> -               };
> -               port@2 {
> -                       reg =3D <2>;
> -               };
> -       };
> -};
> -
> -&i2c2 {
> -       pinctrl-0 =3D <&i2c2_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -
> -       clock-frequency =3D <100000>;
> -
> -       ak4613: codec@10 {
> -               compatible =3D "asahi-kasei,ak4613";
> -               reg =3D <0x10>;
> -               clocks =3D <&rcar_sound 3>;
> -
> -               asahi-kasei,in1-single-end;
> -               asahi-kasei,in2-single-end;
> -               asahi-kasei,out1-single-end;
> -               asahi-kasei,out2-single-end;
> -               asahi-kasei,out3-single-end;
> -               asahi-kasei,out4-single-end;
> -               asahi-kasei,out5-single-end;
> -               asahi-kasei,out6-single-end;
> -       };
> -
> -       cs2000: clk-multiplier@4f {
> -               #clock-cells =3D <0>;
> -               compatible =3D "cirrus,cs2000-cp";
> -               reg =3D <0x4f>;
> -               clocks =3D <&audio_clkout>, <&x12_clk>;
> -               clock-names =3D "clk_in", "ref_clk";
> -
> -               assigned-clocks =3D <&cs2000>;
> -               assigned-clock-rates =3D <24576000>; /* 1/1 divide */
> -       };
> -};
> -
> -&i2c4 {
> -       status =3D "okay";
> -
> -       clock-frequency =3D <400000>;
> -
> -       versaclock5: clock-generator@6a {
> -               compatible =3D "idt,5p49v5925";
> -               reg =3D <0x6a>;
> -               #clock-cells =3D <1>;
> -               clocks =3D <&x23_clk>;
> -               clock-names =3D "xin";
> -       };
> -};
> -
> -&i2c_dvfs {
> -       status =3D "okay";
> -
> -       clock-frequency =3D <400000>;
> -
> -       pmic: pmic@30 {
> -               pinctrl-0 =3D <&irq0_pins>;
> -               pinctrl-names =3D "default";
> -
> -               compatible =3D "rohm,bd9571mwv";
> -               reg =3D <0x30>;
> -               interrupt-parent =3D <&intc_ex>;
> -               interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> -               interrupt-controller;
> -               #interrupt-cells =3D <2>;
> -               gpio-controller;
> -               #gpio-cells =3D <2>;
> -               rohm,ddr-backup-power =3D <0xf>;
> -               rohm,rstbmode-pulse;
> -
> -               regulators {
> -                       dvfs: dvfs {
> -                               regulator-name =3D "dvfs";
> -                               regulator-min-microvolt =3D <750000>;
> -                               regulator-max-microvolt =3D <1030000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -               };
> -       };
> -
> -       eeprom@50 {
> -               compatible =3D "rohm,br24t01", "atmel,24c01";
> -               reg =3D <0x50>;
> -               pagesize =3D <8>;
> -       };
> -};
> -
> -&ohci1 {
> -       status =3D "okay";
> -};
> -
> -&pfc {
> -       pinctrl-0 =3D <&scif_clk_pins>;
> -       pinctrl-names =3D "default";
> -
> -       avb_pins: avb {
> -               mux {
> -                       groups =3D "avb_link", "avb_mdio", "avb_mii";
> -                       function =3D "avb";
> -               };
> -
> -               pins_mdio {
> -                       groups =3D "avb_mdio";
> -                       drive-strength =3D <24>;
> -               };
> -
> -               pins_mii_tx {
> -                       pins =3D "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AV=
B_TD0",
> -                              "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3=
";
> -                       drive-strength =3D <12>;
> -               };
> -       };
> -
> -       i2c2_pins: i2c2 {
> -               groups =3D "i2c2_a";
> -               function =3D "i2c2";
> -       };
> -
> -       irq0_pins: irq0 {
> -               groups =3D "intc_ex_irq0";
> -               function =3D "intc_ex";
> -       };
> -
> -       scif2_pins: scif2 {
> -               groups =3D "scif2_data_a";
> -               function =3D "scif2";
> -       };
> -
> -       scif_clk_pins: scif_clk {
> -               groups =3D "scif_clk_a";
> -               function =3D "scif_clk";
> -       };
> -
> -       sdhi0_pins: sd0 {
> -               groups =3D "sdhi0_data4", "sdhi0_ctrl";
> -               function =3D "sdhi0";
> -               power-source =3D <3300>;
> -       };
> -
> -       sdhi0_pins_uhs: sd0_uhs {
> -               groups =3D "sdhi0_data4", "sdhi0_ctrl";
> -               function =3D "sdhi0";
> -               power-source =3D <1800>;
> -       };
> -
> -       sdhi2_pins: sd2 {
> -               groups =3D "sdhi2_data8", "sdhi2_ctrl", "sdhi2_ds";
> -               function =3D "sdhi2";
> -               power-source =3D <1800>;
> -       };
> -
> -       sound_pins: sound {
> -               groups =3D "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
> -               function =3D "ssi";
> -       };
> -
> -       sound_clk_pins: sound-clk {
> -               groups =3D "audio_clk_a_a", "audio_clk_b_a", "audio_clk_c=
_a",
> -                        "audio_clkout_a", "audio_clkout3_a";
> -               function =3D "audio_clk";
> -       };
> -
> -       usb1_pins: usb1 {
> -               groups =3D "usb1";
> -               function =3D "usb1";
> -       };
> -};
> -
> -&rcar_sound {
> -       pinctrl-0 =3D <&sound_pins>, <&sound_clk_pins>;
> -       pinctrl-names =3D "default";
> -
> -       /* audio_clkout0/1/2/3 */
> -       #clock-cells =3D <1>;
> -       clock-frequency =3D <12288000 11289600>;
> -
> -       status =3D "okay";
> -
> -       /* update <audio_clk_b> to <cs2000> */
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
> -                <&audio_clk_a>, <&cs2000>,
> -                <&audio_clk_c>,
> -                <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
> -};
> -
> -&rpc {
> -       /* Left disabled.  To be enabled by firmware when unlocked. */
> -
> -       flash@0 {
> -               compatible =3D "cypress,hyperflash", "cfi-flash";
> -               reg =3D <0>;
> -
> -               partitions {
> -                       compatible =3D "fixed-partitions";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> -
> -                       bootparam@0 {
> -                               reg =3D <0x00000000 0x040000>;
> -                               read-only;
> -                       };
> -                       bl2@40000 {
> -                               reg =3D <0x00040000 0x140000>;
> -                               read-only;
> -                       };
> -                       cert_header_sa6@180000 {
> -                               reg =3D <0x00180000 0x040000>;
> -                               read-only;
> -                       };
> -                       bl31@1c0000 {
> -                               reg =3D <0x001c0000 0x040000>;
> -                               read-only;
> -                       };
> -                       tee@200000 {
> -                               reg =3D <0x00200000 0x440000>;
> -                               read-only;
> -                       };
> -                       uboot@640000 {
> -                               reg =3D <0x00640000 0x100000>;
> -                               read-only;
> -                       };
> -                       dtb@740000 {
> -                               reg =3D <0x00740000 0x080000>;
> -                       };
> -                       kernel@7c0000 {
> -                               reg =3D <0x007c0000 0x1400000>;
> -                       };
> -                       user@1bc0000 {
> -                               reg =3D <0x01bc0000 0x2440000>;
> -                       };
> -               };
> -       };
> -};
> -
> -&rwdt {
> -       timeout-sec =3D <60>;
> -       status =3D "okay";
> -};
> -
> -&scif2 {
> -       pinctrl-0 =3D <&scif2_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -
> -&scif_clk {
> -       clock-frequency =3D <14745600>;
> -};
> -
> -&sdhi0 {
> -       pinctrl-0 =3D <&sdhi0_pins>;
> -       pinctrl-1 =3D <&sdhi0_pins_uhs>;
> -       pinctrl-names =3D "default", "state_uhs";
> -
> -       vmmc-supply =3D <&vcc_sdhi0>;
> -       vqmmc-supply =3D <&vccq_sdhi0>;
> -       cd-gpios =3D <&gpio3 12 GPIO_ACTIVE_LOW>;
> -       bus-width =3D <4>;
> -       sd-uhs-sdr50;
> -       sd-uhs-sdr104;
> -       status =3D "okay";
> -};
> -
> -&sdhi2 {
> -       /* used for on-board 8bit eMMC */
> -       pinctrl-0 =3D <&sdhi2_pins>;
> -       pinctrl-1 =3D <&sdhi2_pins>;
> -       pinctrl-names =3D "default", "state_uhs";
> -
> -       vmmc-supply =3D <&reg_3p3v>;
> -       vqmmc-supply =3D <&reg_1p8v>;
> -       bus-width =3D <8>;
> -       mmc-hs200-1_8v;
> -       mmc-hs400-1_8v;
> -       no-sd;
> -       no-sdio;
> -       non-removable;
> -       full-pwr-cycle-in-suspend;
> -       status =3D "okay";
> -};
> -
> -&ssi1 {
> -       shared-pin;
> -};
> -
> -&usb2_phy1 {
> -       pinctrl-0 =3D <&usb1_pins>;
> -       pinctrl-names =3D "default";
> -
> -       status =3D "okay";
> -};
> -
> -
> -/*
> - * For sound-test.
> - *
> - * We can switch Audio Card for testing
> - *
> - * #include "ulcb-simple-audio-card.dtsi"
> - * #include "ulcb-simple-audio-card-mix+split.dtsi"
> - * #include "ulcb-audio-graph-card.dtsi"
> - * #include "ulcb-audio-graph-card-mix+split.dtsi"
> - * #include "ulcb-audio-graph-card2-mix+split.dtsi"
> - */
> -#include "ulcb-audio-graph-card2.dtsi"
> --
> 2.43.0
>
