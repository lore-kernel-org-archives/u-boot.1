Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C38C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCED87F88;
	Mon,  4 Mar 2024 15:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXF7Twj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9F187F8B; Mon,  4 Mar 2024 15:50:33 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC5587F85
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso6631414a12.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563829; x=1710168629; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Knu2LEP+ceELrdh086eBHazEzbcka8wuUFdrkLfPRo=;
 b=WXF7Twj0RIkcOe+wCc/lcUWHg510MYRJAs4QP8vQ91G8w8A3UXOiqCWYIKP85spODR
 C1SCh2X2IRNphqz9YtLqUahJzow9WXfsvigRy996FziWOppTRG66F6CufS5C76pM6JGg
 v4f/Ek94txXWbr1t9FBKDzWT4TiCSaBIgsxQ47XpC1d24g/fW8I3zOaE/DnVk1KyVwZS
 Se2otfqXrzGyTRf9JzIqn02PLSf5SfmN2i1qhSqola5Wkvq8CDto1PT7ZBbM1gr/7oTo
 MSnTvLA9pxV5bQkfVwiJJqYJqedgj+mYZhf2ty9yvP+8k/muuxCJbtPFRLnqI0kYvw6J
 xwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563829; x=1710168629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Knu2LEP+ceELrdh086eBHazEzbcka8wuUFdrkLfPRo=;
 b=rseU6fhLpgaEwJHPAmdYhUykBcN8tUjmP6EVX2VtoYnpxyVLk7H0duBXkgewiReZKS
 Ga+FFBVxEhgW92suY1fx05Mn5a4D2e0xSc0sY4BFYIzdrUg+x63ifr8Mn+qpYLNE0rWh
 c+jkCVB3wBSuSJZ9mZQrgBurLuK3GO9RcfE5yVCwSFwneQAqVC1fuagW72tJvHOb9rLz
 oolLDKy+jI+CPV7Xs+q88QDISBWv6BY5yjBU28g70+ss4ZF4MAwzElIS3I7XcEdQ2kmq
 bjljiUZxcySM12a6FvD3XgQAUD2doH48dxOockgNpuJ3r37A2Hw/IOlxUV2EOoiWIrUu
 XPwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQQpW1KoS3rTEF5Ragq+G5plekRXgch7pcDApug9sdEos37esTBZGTxbkF4UhRigIjupf9CwuoRgAo9ldavyxQcxRTeQ==
X-Gm-Message-State: AOJu0YyNL99+EbiuFNn5UrdnAOFSZEOfmyD02FzAIPqUO6y63otjwnJV
 pEhQIQ87VJWrTSGo34XhOQs7LdXIqS0OW4fxGrylDMgrBnN5I0JrEXkiAdbFdyLjBmqsAWUxfqY
 AkK+MSq+rnlCF6pMDDWsHLjUQYPU=
X-Google-Smtp-Source: AGHT+IHEiDry3CZ55NicRz8cIcGGblSbMnup0dtl1HHwHCGUpi6hSw9GngNRAKRK0vFankV95ukqG4BqXzrZu9Gxxhg=
X-Received: by 2002:a50:ab04:0:b0:565:bc3d:d9dd with SMTP id
 s4-20020a50ab04000000b00565bc3dd9ddmr6552668edc.38.1709563828888; Mon, 04 Mar
 2024 06:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20240301085004.1005425-1-zhangzj@rock-chips.com>
In-Reply-To: <20240301085004.1005425-1-zhangzj@rock-chips.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 4 Mar 2024 22:50:17 +0800
Message-ID: <CAHk0Hovsay8ON+mNMLEaOya7Lo5pHAEvpWCOb9yNdJ3S8B=snQ@mail.gmail.com>
Subject: Re: [PATCH v2] board: rockchip: add Rockchip Toybrick TB-RK3588X board
To: Elon Zhang <zhangzj@rock-chips.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, 
 weizhao.ouyang@arm.com, trini@konsulko.com, u-boot@lists.denx.de
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

On Fri, Mar 1, 2024 at 4:50=E2=80=AFPM Elon Zhang <zhangzj@rock-chips.com> =
wrote:
>
> TB-RK3588X board is a Rockchip Toybrick RK3588 based development board.
>
> Specification:
>         Rockchip Rk3588 SoC
>         4x ARM Cortex-A76, 4x ARM Cortex-A55
>         8/16GB Memory LPDDR4x
>         Mali G610MC4 GPU
>         2=C3=97 MIPI-CSI0 Connector
>         1x 2Lanes PCIe3.0 Connector
>         1x SATA3.0 Connector
>         32GB eMMC Module
>         2x USB 2.0, 2x USB 3.0
>         1x HDMI Output, 1x HDMI Input
>         2x Ethernet Port
>
> Functions work normally:
>         [1] USB2.0 Host
>         [2] Ethernet0 with PHY RTL8211F
>
> More information can be obtained from the following websites:
>         [1] https://t.rock-chips.com/en/wiki/EN/tb-rk3588x_en/index.html
>         [2] http://t.rock-chips.com/
>
> Kernel commits:
>         8ffe365f8dc7 ("arm64: dts: rockchip: Add devicetree support for T=
B-RK3588X board")
>         7140387ff49d ("dt-bindings: arm: rockchip: Add Toybrick TB-RK3588=
X")
>
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>

Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

BR,
Weizhao

> ---
> Changes since v1:
>   - Remove BOARD_SPECIFIC_OPTIONS in board Kconfig
> ---
>  arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi   |  12 +
>  arch/arm/dts/rk3588-toybrick-x0.dts           | 672 ++++++++++++++++++
>  arch/arm/mach-rockchip/rk3588/Kconfig         |  25 +
>  board/rockchip/toybrick_rk3588/Kconfig        |  12 +
>  board/rockchip/toybrick_rk3588/MAINTAINERS    |   8 +
>  board/rockchip/toybrick_rk3588/Makefile       |   6 +
>  .../toybrick_rk3588/toybrick-rk3588.c         |  39 +
>  configs/toybrick-rk3588_defconfig             |  82 +++
>  doc/board/rockchip/rockchip.rst               |   1 +
>  include/configs/toybrick_rk3588.h             |  15 +
>  10 files changed, 872 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3588-toybrick-x0.dts
>  create mode 100644 board/rockchip/toybrick_rk3588/Kconfig
>  create mode 100644 board/rockchip/toybrick_rk3588/MAINTAINERS
>  create mode 100644 board/rockchip/toybrick_rk3588/Makefile
>  create mode 100644 board/rockchip/toybrick_rk3588/toybrick-rk3588.c
>  create mode 100644 configs/toybrick-rk3588_defconfig
>  create mode 100644 include/configs/toybrick_rk3588.h
>
> diff --git a/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi b/arch/arm/dts/r=
k3588-toybrick-x0-u-boot.dtsi
> new file mode 100644
> index 0000000000..1aeb5410e4
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/ {
> +       chosen {
> +               u-boot,spl-boot-order =3D "same-as-spl", &sdhci;
> +       };
> +};
> diff --git a/arch/arm/dts/rk3588-toybrick-x0.dts b/arch/arm/dts/rk3588-to=
ybrick-x0.dts
> new file mode 100644
> index 0000000000..f3f7c1d35e
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-toybrick-x0.dts
> @@ -0,0 +1,672 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +       model =3D "Rockchip Toybrick TB-RK3588X Board";
> +       compatible =3D "rockchip,rk3588-toybrick-x0", "rockchip,rk3588";
> +
> +       aliases {
> +               mmc0 =3D &sdhci;
> +               serial2 =3D &uart2;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial2:1500000n8";
> +       };
> +
> +       adc-keys {
> +               compatible =3D "adc-keys";
> +               io-channels =3D <&saradc 1>;
> +               io-channel-names =3D "buttons";
> +               keyup-threshold-microvolt =3D <1800000>;
> +               poll-interval =3D <100>;
> +
> +               button-vol-up {
> +                       label =3D "Volume Up";
> +                       linux,code =3D <KEY_VOLUMEUP>;
> +                       press-threshold-microvolt =3D <17000>;
> +               };
> +
> +               button-vol-down {
> +                       label =3D "Volume Down";
> +                       linux,code =3D <KEY_VOLUMEDOWN>;
> +                       press-threshold-microvolt =3D <417000>;
> +               };
> +
> +               button-menu {
> +                       label =3D "Menu";
> +                       linux,code =3D <KEY_MENU>;
> +                       press-threshold-microvolt =3D <890000>;
> +               };
> +
> +               button-escape {
> +                       label =3D "Escape";
> +                       linux,code =3D <KEY_ESC>;
> +                       press-threshold-microvolt =3D <1235000>;
> +               };
> +       };
> +
> +       backlight: backlight {
> +               compatible =3D "pwm-backlight";
> +               power-supply =3D <&vcc12v_dcin>;
> +               pwms =3D <&pwm2 0 25000 0>;
> +       };
> +
> +       pcie20_avdd0v85: pcie20-avdd0v85-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pcie20_avdd0v85";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <850000>;
> +               regulator-max-microvolt =3D <850000>;
> +               vin-supply =3D <&vdd_0v85_s0>;
> +       };
> +
> +       pcie20_avdd1v8: pcie20-avdd1v8-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pcie20_avdd1v8";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               vin-supply =3D <&avcc_1v8_s0>;
> +       };
> +
> +       pcie30_avdd0v75: pcie30-avdd0v75-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pcie30_avdd0v75";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <750000>;
> +               regulator-max-microvolt =3D <750000>;
> +               vin-supply =3D <&avdd_0v75_s0>;
> +       };
> +
> +       pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pcie30_avdd1v8";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               vin-supply =3D <&avcc_1v8_s0>;
> +       };
> +
> +       vcc12v_dcin: vcc12v-dcin-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc12v_dcin";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <12000000>;
> +               regulator-max-microvolt =3D <12000000>;
> +       };
> +
> +       vcc5v0_host: vcc5v0-host-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_host";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               enable-active-high;
> +               gpio =3D <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vcc5v0_host_en>;
> +               vin-supply =3D <&vcc5v0_usb>;
> +       };
> +
> +       vcc5v0_sys: vcc5v0-sys-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               vin-supply =3D <&vcc12v_dcin>;
> +       };
> +
> +       vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_usbdcin";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               vin-supply =3D <&vcc12v_dcin>;
> +       };
> +
> +       vcc5v0_usb: vcc5v0-usb-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_usb";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               vin-supply =3D <&vcc5v0_usbdcin>;
> +       };
> +
> +       vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc_1v1_nldo_s3";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <1100000>;
> +               regulator-max-microvolt =3D <1100000>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +};
> +
> +&combphy0_ps {
> +       status =3D "okay";
> +};
> +
> +&combphy2_psu {
> +       status =3D "okay";
> +};
> +
> +&cpu_b0 {
> +       cpu-supply =3D <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +       cpu-supply =3D <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +       cpu-supply =3D <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +       cpu-supply =3D <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&gmac0 {
> +       clock_in_out =3D "output";
> +       phy-handle =3D <&rgmii_phy>;
> +       phy-mode =3D "rgmii-rxid";
> +       pinctrl-0 =3D <&gmac0_miim
> +                    &gmac0_tx_bus2
> +                    &gmac0_rx_bus2
> +                    &gmac0_rgmii_clk
> +                    &gmac0_rgmii_bus>;
> +       pinctrl-names =3D "default";
> +       rx_delay =3D <0x00>;
> +       tx_delay =3D <0x43>;
> +       status =3D "okay";
> +};
> +
> +&i2c0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c0m2_xfer>;
> +       status =3D "okay";
> +
> +       vdd_cpu_big0_s0: regulator@42 {
> +               compatible =3D "rockchip,rk8602";
> +               reg =3D <0x42>;
> +               fcs,suspend-voltage-selector =3D <1>;
> +               regulator-name =3D "vdd_cpu_big0_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <550000>;
> +               regulator-max-microvolt =3D <1050000>;
> +               regulator-ramp-delay =3D <2300>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_cpu_big1_s0: regulator@43 {
> +               compatible =3D "rockchip,rk8603", "rockchip,rk8602";
> +               reg =3D <0x43>;
> +               fcs,suspend-voltage-selector =3D <1>;
> +               regulator-name =3D "vdd_cpu_big1_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <550000>;
> +               regulator-max-microvolt =3D <1050000>;
> +               regulator-ramp-delay =3D <2300>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +};
> +
> +&i2c2 {
> +       status =3D "okay";
> +
> +       hym8563: rtc@51 {
> +               compatible =3D "haoyu,hym8563";
> +               reg =3D <0x51>;
> +               #clock-cells =3D <0>;
> +               clock-output-names =3D "hym8563";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&hym8563_int>;
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> +               wakeup-source;
> +       };
> +};
> +
> +&mdio0 {
> +       rgmii_phy: ethernet-phy@1 {
> +               /* RTL8211F */
> +               compatible =3D "ethernet-phy-id001c.c916";
> +               reg =3D <0x1>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&rtl8211f_rst>;
> +               reset-assert-us =3D <20000>;
> +               reset-deassert-us =3D <100000>;
> +               reset-gpios =3D <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
> +&pinctrl {
> +       rtl8211f {
> +               rtl8211f_rst: rtl8211f-rst {
> +                       rockchip,pins =3D <4 RK_PB3 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +
> +       };
> +
> +       hym8563 {
> +               hym8563_int: hym8563-int {
> +                       rockchip,pins =3D <0 RK_PD4 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> +               };
> +       };
> +
> +       usb {
> +               vcc5v0_host_en: vcc5v0-host-en {
> +                       rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +};
> +
> +&pwm2 {
> +       status =3D "okay";
> +};
> +
> +&saradc {
> +       vref-supply =3D <&vcc_1v8_s0>;
> +       status =3D "okay";
> +};
> +
> +&sdhci {
> +       bus-width =3D <8>;
> +       no-sdio;
> +       no-sd;
> +       non-removable;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
> +       status =3D "okay";
> +};
> +
> +&spi2 {
> +       status =3D "okay";
> +       assigned-clocks =3D <&cru CLK_SPI2>;
> +       assigned-clock-rates =3D <200000000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&spi2m2_cs0 &spi2m2_pins>;
> +       num-cs =3D <1>;
> +
> +       pmic@0 {
> +               compatible =3D "rockchip,rk806";
> +               spi-max-frequency =3D <1000000>;
> +               reg =3D <0x0>;
> +
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
> +                           <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +
> +               system-power-controller;
> +
> +               vcc1-supply =3D <&vcc5v0_sys>;
> +               vcc2-supply =3D <&vcc5v0_sys>;
> +               vcc3-supply =3D <&vcc5v0_sys>;
> +               vcc4-supply =3D <&vcc5v0_sys>;
> +               vcc5-supply =3D <&vcc5v0_sys>;
> +               vcc6-supply =3D <&vcc5v0_sys>;
> +               vcc7-supply =3D <&vcc5v0_sys>;
> +               vcc8-supply =3D <&vcc5v0_sys>;
> +               vcc9-supply =3D <&vcc5v0_sys>;
> +               vcc10-supply =3D <&vcc5v0_sys>;
> +               vcc11-supply =3D <&vcc_2v0_pldo_s3>;
> +               vcc12-supply =3D <&vcc5v0_sys>;
> +               vcc13-supply =3D <&vcc_1v1_nldo_s3>;
> +               vcc14-supply =3D <&vcc_1v1_nldo_s3>;
> +               vcca-supply =3D <&vcc5v0_sys>;
> +
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               rk806_dvs1_null: dvs1-null-pins {
> +                       pins =3D "gpio_pwrctrl1";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               rk806_dvs2_null: dvs2-null-pins {
> +                       pins =3D "gpio_pwrctrl2";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               rk806_dvs3_null: dvs3-null-pins {
> +                       pins =3D "gpio_pwrctrl3";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               regulators {
> +                       vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_gpu_s0";
> +                               regulator-enable-ramp-delay =3D <400>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_lit_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_log_s0: dcdc-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_log_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
750000>;
> +                               };
> +                       };
> +
> +                       vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-init-microvolt =3D <750000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_vdenc_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_ddr_s0: dcdc-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <900000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_ddr_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
850000>;
> +                               };
> +                       };
> +
> +                       vdd2_ddr_s3: dcdc-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name =3D "vdd2_ddr_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_2v0_pldo_s3: dcdc-reg7 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <2000000>;
> +                               regulator-max-microvolt =3D <2000000>;
> +                               regulator-name =3D "vdd_2v0_pldo_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
2000000>;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s3: dcdc-reg8 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc_3v3_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3300000>;
> +                               };
> +                       };
> +
> +                       vddq_ddr_s0: dcdc-reg9 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name =3D "vddq_ddr_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s3: dcdc-reg10 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc_1v8_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       avcc_1v8_s0: pldo-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "avcc_1v8_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s0: pldo-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc_1v8_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       avdd_1v2_s0: pldo-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <1200000>;
> +                               regulator-name =3D "avdd_1v2_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s0: pldo-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc_3v3_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vccio_sd_s0: pldo-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vccio_sd_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       pldo6_s3: pldo-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "pldo6_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s3: nldo-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-name =3D "vdd_0v75_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
750000>;
> +                               };
> +                       };
> +
> +                       vdd_ddr_pll_s0: nldo-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <850000>;
> +                               regulator-max-microvolt =3D <850000>;
> +                               regulator-name =3D "vdd_ddr_pll_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
850000>;
> +                               };
> +                       };
> +
> +                       avdd_0v75_s0: nldo-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <837500>;
> +                               regulator-max-microvolt =3D <837500>;
> +                               regulator-name =3D "avdd_0v75_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v85_s0: nldo-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <850000>;
> +                               regulator-max-microvolt =3D <850000>;
> +                               regulator-name =3D "vdd_0v85_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s0: nldo-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-name =3D "vdd_0v75_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&u2phy2 {
> +       status =3D "okay";
> +};
> +
> +&u2phy2_host {
> +       phy-supply =3D <&vcc5v0_host>;
> +       status =3D "okay";
> +};
> +
> +&u2phy3 {
> +       status =3D "okay";
> +};
> +
> +&u2phy3_host {
> +       phy-supply =3D <&vcc5v0_host>;
> +       status =3D "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-0 =3D <&uart2m0_xfer>;
> +       status =3D "okay";
> +};
> +
> +&usb_host0_ehci {
> +       status =3D "okay";
> +};
> +
> +&usb_host0_ohci {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_ehci {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_ohci {
> +       status =3D "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockch=
ip/rk3588/Kconfig
> index a2193fbd41..ff6c12903d 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -155,6 +155,30 @@ config TARGET_TURINGRK1_RK3588
>           Gigabit Ethernet
>           Size: 69.6mm x 45mm (260-pin SO-DIMM connector)
>
> +config TARGET_TOYBRICK_RK3588
> +       bool "Toybrick TB-RK3588X board"
> +       select BOARD_LATE_INIT
> +       help
> +         Rockchip Toybrick TB-RK3588X is a Rockchip RK3588 based develop=
ment board.
> +         TB-RK3588X adopts core board and mainboard design. The core boa=
rd is connected
> +         with the mainboard through the MXM314Pin standard interface, wh=
ich can form
> +         a complete industry development board.
> +
> +         Specifications:
> +
> +         Rockchip RK3588 SoC
> +         4x ARM Cortex-A76, 4x ARM Cortex-A55
> +         8/16GB Memory LPDDR4x
> +         Mali G610MC4 GPU
> +         2=C3=97 MIPI-CSI0 Connector
> +         1x 2Lanes PCIe3.0 Connector
> +         1x SATA3.0 Connector
> +         32GB eMMC Module
> +         2x USB2.0, 2x USB3.0
> +         1x HDMI Output, 1x HDMI Input
> +         2x Ethernet Port
> +
> +
>  config ROCKCHIP_BOOT_MODE_REG
>         default 0xfd588080
>
> @@ -174,5 +198,6 @@ source board/turing/turing-rk1-rk3588/Kconfig
>  source board/rockchip/evb_rk3588/Kconfig
>  source board/radxa/rock5a-rk3588s/Kconfig
>  source board/radxa/rock5b-rk3588/Kconfig
> +source board/rockchip/toybrick_rk3588/Kconfig
>
>  endif
> diff --git a/board/rockchip/toybrick_rk3588/Kconfig b/board/rockchip/toyb=
rick_rk3588/Kconfig
> new file mode 100644
> index 0000000000..8e781a18d9
> --- /dev/null
> +++ b/board/rockchip/toybrick_rk3588/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_TOYBRICK_RK3588
> +
> +config SYS_BOARD
> +       default "toybrick_rk3588"
> +
> +config SYS_VENDOR
> +       default "rockchip"
> +
> +config SYS_CONFIG_NAME
> +       default "toybrick_rk3588"
> +
> +endif
> diff --git a/board/rockchip/toybrick_rk3588/MAINTAINERS b/board/rockchip/=
toybrick_rk3588/MAINTAINERS
> new file mode 100644
> index 0000000000..cd4401c24f
> --- /dev/null
> +++ b/board/rockchip/toybrick_rk3588/MAINTAINERS
> @@ -0,0 +1,8 @@
> +TOYBRICK-RK3588
> +M:     Elon Zhang <zhangzj@rock-chips.com>
> +S:     Maintained
> +F:     board/rockchip/toybrick_rk3588
> +F:     include/configs/toybrick_rk3588.h
> +F:     configs/toybrick-rk3588_defconfig
> +F:     arch/arm/dts/rk3588-toybrick-x0.dts
> +F:     arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> diff --git a/board/rockchip/toybrick_rk3588/Makefile b/board/rockchip/toy=
brick_rk3588/Makefile
> new file mode 100644
> index 0000000000..75d4d9438f
> --- /dev/null
> +++ b/board/rockchip/toybrick_rk3588/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +# Copyright (c) 2024 Rockchip Electronics Co,. Ltd.
> +#
> +
> +obj-y +=3D toybrick-rk3588.o
> diff --git a/board/rockchip/toybrick_rk3588/toybrick-rk3588.c b/board/roc=
kchip/toybrick_rk3588/toybrick-rk3588.c
> new file mode 100644
> index 0000000000..dfbfba22c6
> --- /dev/null
> +++ b/board/rockchip/toybrick_rk3588/toybrick-rk3588.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co,. Ltd.
> + */
> +
> +#include <fdtdec.h>
> +#include <fdt_support.h>
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +static int rk3588_add_reserved_memory_fdt_nodes(void *new_blob)
> +{
> +       struct fdt_memory gap1 =3D {
> +               .start =3D 0x3fc000000,
> +               .end =3D 0x3fc4fffff,
> +       };
> +       struct fdt_memory gap2 =3D {
> +               .start =3D 0x3fff00000,
> +               .end =3D 0x3ffffffff,
> +       };
> +       unsigned long flags =3D FDTDEC_RESERVED_MEMORY_NO_MAP;
> +       unsigned int ret;
> +
> +       /*
> +        * Inject the reserved-memory nodes into the DTS
> +        */
> +       ret =3D fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL=
, 0,
> +                                        NULL, flags);
> +       if (ret)
> +               return ret;
> +
> +       return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL,=
 0,
> +                                         NULL, flags);
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +       return rk3588_add_reserved_memory_fdt_nodes(blob);
> +}
> +#endif
> diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_=
defconfig
> new file mode 100644
> index 0000000000..0b6016955d
> --- /dev/null
> +++ b/configs/toybrick-rk3588_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> +CONFIG_COUNTER_FREQUENCY=3D24000000
> +CONFIG_ARCH_ROCKCHIP=3Dy
> +CONFIG_TEXT_BASE=3D0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xc00000
> +CONFIG_ENV_SIZE=3D0x1f000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3588-toybrick-x0"
> +CONFIG_ROCKCHIP_RK3588=3Dy
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy
> +CONFIG_SPL_SERIAL=3Dy
> +CONFIG_SPL_STACK_R_ADDR=3D0x600000
> +CONFIG_TARGET_TOYBRICK_RK3588=3Dy
> +CONFIG_SPL_STACK=3D0x400000
> +CONFIG_DEBUG_UART_BASE=3D0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> +CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3588-toybrick-x0.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +CONFIG_SPL_PAD_TO=3D0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=3Dy
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_GPT=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_USB=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=3Dy
> +CONFIG_OF_LIVE=3Dy
> +CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names interr=
upt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=3Dy
> +CONFIG_SPL_REGMAP=3Dy
> +CONFIG_SPL_SYSCON=3Dy
> +CONFIG_SPL_CLK=3Dy
> +CONFIG_ROCKCHIP_GPIO=3Dy
> +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> +CONFIG_MISC=3Dy
> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS400_ES_SUPPORT=3Dy
> +CONFIG_MMC_HS400_SUPPORT=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_SDMA=3Dy
> +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DWC_ETH_QOS=3Dy
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> +CONFIG_REGULATOR_PWM=3Dy
> +CONFIG_PWM_ROCKCHIP=3Dy
> +CONFIG_SPL_RAM=3Dy
> +CONFIG_BAUDRATE=3D1500000
> +CONFIG_DEBUG_UART_SHIFT=3D2
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_SYSRESET=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_EHCI_GENERIC=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy
> +CONFIG_USB_OHCI_GENERIC=3Dy
> +CONFIG_ERRNO_STR=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchi=
p.rst
> index e23ca4231c..d5b6ee956e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -120,6 +120,7 @@ List of mainline supported Rockchip boards:
>       - Turing Machines RK1 (turing-rk1-rk3588)
>       - Radxa ROCK 5A (rock5a-rk3588s)
>       - Radxa ROCK 5B (rock5b-rk3588)
> +     - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>       - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
>       - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
>
> diff --git a/include/configs/toybrick_rk3588.h b/include/configs/toybrick=
_rk3588.h
> new file mode 100644
> index 0000000000..faa2e6c19c
> --- /dev/null
> +++ b/include/configs/toybrick_rk3588.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
> + */
> +
> +#ifndef __TOYBRICK_RK3588_H
> +#define __TOYBRICK_RK3588_H
> +
> +#include <configs/rk3588_common.h>
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +               "stdout=3Dserial,vidconsole\0" \
> +               "stderr=3Dserial,vidconsole\0"
> +
> +#endif
> --
> 2.34.1
>
