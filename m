Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF518CF0427
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 21:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E2588F48;
	Tue,  8 Oct 2024 23:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jF64y7um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80BD88F82; Tue,  8 Oct 2024 23:23:03 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E72788F2F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 23:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3f28b6so8601484a12.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422576; x=1729027376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogu+n9mBQngO4GAMrS4+VkQ/sPjpWtoMlSeTCUzdMcQ=;
 b=jF64y7umFXR6waRQQGvbhM6/RI+c8OVhTesiIratLB6op3p0Xh0lg1iWK7wd8r0NAM
 muSNfuRc3bHjtxIBjmEuBMwQzzcVK1wZ7XKsgUSPfncdT85SSv99M/AQvT1wN3S/mSQj
 ZwUascIR/Njvsjf1YK47KnxW0gD70xXlO2bF/YFBKRf/uYyz9NQhlGXvfAzw0/CFCftH
 JaZ1RxiBFCggwcd8OMqyiizn9DAVWGwm5+/Uw6cAUKyTrE6CbxHCDG0BhRWuPg3gNaSK
 vbwV1hPWX6i70SoHYYALVEyawgbLfOK2Fi3CV17X15d9EDSyLGp8is9Fosh7fm8YuVjp
 KYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422576; x=1729027376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogu+n9mBQngO4GAMrS4+VkQ/sPjpWtoMlSeTCUzdMcQ=;
 b=imtEwdEEt8KrNjMoLRBQ1OOGsTFW6X5RI9dKCrntdArUhH9eYytJXT5yymIgRfctJl
 Dt5LZl3umLStiK5YLO+G0qgTbCwx5aRPwyDCMaa4vvwdWXekFpFZzHLPG0YfPOuLlaQi
 GjyV0BBLm9Xj+7YYolW7xxkj3l2XfSkyP9pkXznAomkqGBSzC6XFdsECC52x+8XFuu0A
 gkP3mFWZ6aPc6oSrgTd0ZDxztxtdbazDLmDjoFWDYzWqLpLy2Fo3bQ5XhbgMkatMAGGV
 pCO03L0a4+OEJ1smhYlL9Ak2XcjQRUXsPPDfzN9hRx0QXzIowvn0TAz9NQ+mvkY8BBD2
 AW0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzmImdFh0q1Nsl5/T2s8+BYRxoOK1o16bfrbicmy+DbzYWfcaP0m1SONGTXY76L5yzR9VQB9M=@lists.denx.de
X-Gm-Message-State: AOJu0YwQa7mZOB7YOd8INfFRFH3bRVXORBwQWk2okeQiXHBihN7Sfk9X
 5lCfwqms9nwvk/MPeYtfzDTes2p4KT/Ge7+zRo+ifBtGpTd4krFZvvwt40QOtM4Aw7jGJbQIJuu
 7zs/poDLmES+jSwTjehD0vin7ZG0=
X-Google-Smtp-Source: AGHT+IGCXdcsCf9BJpq3xdgPNentURYTChkrfo2g1diTVGFlEc3X5Fgx0roXKkGe+HybhDuIJrPewEsUFNWCXbavHFw=
X-Received: by 2002:a05:6402:34c4:b0:5c8:839c:8179 with SMTP id
 4fb4d7f45d1cf-5c91d5bd34cmr235711a12.7.1728422575760; Tue, 08 Oct 2024
 14:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241008200641.2203023-1-jonas@kwiboo.se>
 <20241008200641.2203023-3-jonas@kwiboo.se>
In-Reply-To: <20241008200641.2203023-3-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 8 Oct 2024 22:22:44 +0100
Message-ID: <CALeDE9Oi5fgYW2OeHsWG3Bu=C4oacyrqjZwG2fQcn88Y8+i4Vg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, 
 Heiko Stuebner <heiko@sntech.de>
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

On Tue, 8 Oct 2024 at 21:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
>
> Add initial support for eMMC, SD-card, Ethernet, HDMI, PCIe and USB.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240827211825.1419820-5-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 10dc64fe0f980c47c7e747885ddf7a8c12780337 ]
>
> (cherry picked from commit f811548e758b52896f725753086c42b49dc42c0d)

Will this not just come through with the dts sync process?

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>  .../src/arm64/rockchip/rk3566-odroid-m1s.dts  | 663 ++++++++++++++++++
>  1 file changed, 663 insertions(+)
>  create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts b/dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts
> new file mode 100644
> index 000000000000..33bc5249d729
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts
> @@ -0,0 +1,663 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3566.dtsi"
> +
> +/ {
> +       model = "Hardkernel ODROID-M1S";
> +       compatible = "hardkernel,odroid-m1s", "rockchip,rk3566";
> +
> +       aliases {
> +               ethernet0 = &gmac1;
> +               mmc0 = &sdhci;
> +               mmc1 = &sdmmc0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:1500000n8";
> +       };
> +
> +       hdmi-con {
> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint = <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pwr_led>, <&sys_led>;
> +
> +               led_pwr: led-0 {
> +                       color = <LED_COLOR_ID_RED>;
> +                       default-state = "on";
> +                       function = LED_FUNCTION_POWER;
> +                       gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger = "default-on";
> +               };
> +
> +               led_sys: led-1 {
> +                       color = <LED_COLOR_ID_BLUE>;
> +                       default-state = "on";
> +                       function = LED_FUNCTION_HEARTBEAT;
> +                       gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +
> +       vcc3v3_lcd: regulator-3v3-vcc-lcd {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&lcd_pwren>;
> +               regulator-name = "vcc3v3_lcd";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               vin-supply = <&vcc3v3_sys>;
> +       };
> +
> +       vcc3v3_pcie: regulator-3v3-vcc-pcie {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pcie_pwren>;
> +               regulator-name = "vcc3v3_pcie";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               vin-supply = <&vcc3v3_sys>;
> +       };
> +
> +       vcc3v3_sys: regulator-3v3-vcc-sys {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc3v3_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_sys: regulator-5v0-vcc-sys {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +
> +       vcc5v0_usb2_host: regulator-5v0-vcc-usb2-host {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&usb2_host_pwren>;
> +               regulator-name = "vcc5v0_usb2_host";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_usb2_otg: regulator-5v0-vcc-usb2-otg {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&usb2_otg_pwren>;
> +               regulator-name = "vcc5v0_usb2_otg";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_usb3_host: regulator-5v0-vcc-usb3-host {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&usb3_host_pwren>;
> +               regulator-name = "vcc5v0_usb3_host";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,name = "Analog RK809";
> +               simple-audio-card,mclk-fs = <256>;
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&i2s1_8ch>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&rk809>;
> +               };
> +       };
> +};
> +
> +&combphy1 {
> +       status = "okay";
> +};
> +
> +&combphy2 {
> +       status = "okay";
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +       cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +       cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +       cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gmac1 {
> +       assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +       assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
> +       clock_in_out = "input";
> +       phy-handle = <&rgmii_phy1>;
> +       phy-mode = "rgmii-id";
> +       phy-supply = <&vcc_3v3>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&gmac1m1_miim
> +                    &gmac1m1_tx_bus2
> +                    &gmac1m1_rx_bus2
> +                    &gmac1m1_rgmii_clk
> +                    &gmac1m1_rgmii_bus
> +                    &gmac1m1_clkinout>;
> +       status = "okay";
> +};
> +
> +&gpu {
> +       mali-supply = <&vdd_gpu>;
> +       status = "okay";
> +};
> +
> +&hdmi {
> +       avdd-0v9-supply = <&vdda0v9_image>;
> +       avdd-1v8-supply = <&vcca1v8_image>;
> +       status = "okay";
> +};
> +
> +&hdmi_in {
> +       hdmi_in_vp0: endpoint {
> +               remote-endpoint = <&vp0_out_hdmi>;
> +       };
> +};
> +
> +&hdmi_out {
> +       hdmi_out_con: endpoint {
> +               remote-endpoint = <&hdmi_con_in>;
> +       };
> +};
> +
> +&hdmi_sound {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       vdd_cpu: regulator@1c {
> +               compatible = "tcs,tcs4525";
> +               reg = <0x1c>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-name = "vdd_cpu";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <712500>;
> +               regulator-max-microvolt = <1390000>;
> +               regulator-ramp-delay = <2300>;
> +               vin-supply = <&vcc3v3_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       rk809: pmic@20 {
> +               compatible = "rockchip,rk809";
> +               reg = <0x20>;
> +               assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +               assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +               #clock-cells = <1>;
> +               clocks = <&cru I2S1_MCLKOUT_TX>;
> +               clock-names = "mclk";
> +               clock-output-names = "rk809-clkout1", "rk809-clkout2";
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
> +               #sound-dai-cells = <0>;
> +               system-power-controller;
> +               wakeup-source;
> +
> +               vcc1-supply = <&vcc3v3_sys>;
> +               vcc2-supply = <&vcc3v3_sys>;
> +               vcc3-supply = <&vcc3v3_sys>;
> +               vcc4-supply = <&vcc3v3_sys>;
> +               vcc5-supply = <&vcc3v3_sys>;
> +               vcc6-supply = <&vcc3v3_sys>;
> +               vcc7-supply = <&vcc3v3_sys>;
> +               vcc8-supply = <&vcc3v3_sys>;
> +               vcc9-supply = <&vcc3v3_sys>;
> +
> +               regulators {
> +                       vdd_logic: DCDC_REG1 {
> +                               regulator-name = "vdd_logic";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-initial-mode = <0x2>;
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <6001>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_gpu: DCDC_REG2 {
> +                               regulator-name = "vdd_gpu";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-initial-mode = <0x2>;
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <6001>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_ddr: DCDC_REG3 {
> +                               regulator-name = "vcc_ddr";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-initial-mode = <0x2>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_npu: DCDC_REG4 {
> +                               regulator-name = "vdd_npu";
> +                               regulator-initial-mode = <0x2>;
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <6001>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8: DCDC_REG5 {
> +                               regulator-name = "vcc_1v8";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdda0v9_image: LDO_REG1 {
> +                               regulator-name = "vdda0v9_image";
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <900000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdda_0v9: LDO_REG2 {
> +                               regulator-name = "vdda_0v9";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <900000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdda0v9_pmu: LDO_REG3 {
> +                               regulator-name = "vdda0v9_pmu";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <900000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <900000>;
> +                               };
> +                       };
> +
> +                       vccio_acodec: LDO_REG4 {
> +                               regulator-name = "vccio_acodec";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vccio_sd: LDO_REG5 {
> +                               regulator-name = "vccio_sd";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc3v3_pmu: LDO_REG6 {
> +                               regulator-name = "vcc3v3_pmu";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <3300000>;
> +                               };
> +                       };
> +
> +                       vcca_1v8: LDO_REG7 {
> +                               regulator-name = "vcca_1v8";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcca1v8_pmu: LDO_REG8 {
> +                               regulator-name = "vcca1v8_pmu";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       vcca1v8_image: LDO_REG9 {
> +                               regulator-name = "vcca1v8_image";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v3: SWITCH_REG1 {
> +                               regulator-name = "vcc_3v3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc3v3_sd: SWITCH_REG2 {
> +                               regulator-name = "vcc3v3_sd";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&i2s0_8ch {
> +       status = "okay";
> +};
> +
> +&i2s1_8ch {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2s1m0_sclktx
> +                    &i2s1m0_lrcktx
> +                    &i2s1m0_sdi0
> +                    &i2s1m0_sdo0>;
> +       rockchip,trcm-sync-tx-only;
> +       status = "okay";
> +};
> +
> +&mdio1 {
> +       rgmii_phy1: ethernet-phy@1 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <1>;
> +               reset-assert-us = <20000>;
> +               reset-deassert-us = <100000>;
> +               reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
> +&pcie2x1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie20_pins>;
> +       reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
> +       vpcie3v3-supply = <&vcc3v3_pcie>;
> +       status = "okay";
> +};
> +
> +&pinctrl {
> +       lcd {
> +               lcd_pwren: lcd-pwren {
> +                       rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       leds {
> +               pwr_led: pwr-led {
> +                       rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               sys_led: sys-led {
> +                       rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       pcie {
> +               pcie20_pins: pcie20-pins {
> +                       rockchip,pins =
> +                               <1 RK_PB0 4 &pcfg_pull_none>,
> +                               <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>,
> +                               <1 RK_PB1 4 &pcfg_pull_none>;
> +               };
> +
> +               pcie_pwren: pcie-pwren {
> +                       rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       pmic {
> +               pmic_int: pmic-int {
> +                       rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +
> +       usb {
> +               usb2_host_pwren: usb2-host-pwren {
> +                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               usb2_otg_pwren: usb2-otg-pwren {
> +                       rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               usb3_host_pwren: usb3-host-pwren {
> +                       rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +};
> +
> +&pmu_io_domains {
> +       pmuio1-supply = <&vcc3v3_pmu>;
> +       pmuio2-supply = <&vcc3v3_pmu>;
> +       vccio1-supply = <&vccio_acodec>;
> +       vccio2-supply = <&vcc_1v8>;
> +       vccio3-supply = <&vccio_sd>;
> +       vccio4-supply = <&vcc_3v3>;
> +       vccio5-supply = <&vcc_3v3>;
> +       vccio6-supply = <&vcc_3v3>;
> +       vccio7-supply = <&vcc_3v3>;
> +       status = "okay";
> +};
> +
> +&saradc {
> +       vref-supply = <&vcca_1v8>;
> +       status = "okay";
> +};
> +
> +&sdhci {
> +       bus-width = <8>;
> +       cap-mmc-highspeed;
> +       max-frequency = <200000000>;
> +       mmc-hs200-1_8v;
> +       no-sd;
> +       no-sdio;
> +       non-removable;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe &emmc_rstnout>;
> +       vmmc-supply = <&vcc_3v3>;
> +       vqmmc-supply = <&vcc_1v8>;
> +       status = "okay";
> +};
> +
> +&sdmmc0 {
> +       bus-width = <4>;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +       sd-uhs-sdr50;
> +       vmmc-supply = <&vcc3v3_sd>;
> +       vqmmc-supply = <&vccio_sd>;
> +       status = "okay";
> +};
> +
> +&tsadc {
> +       rockchip,hw-tshut-mode = <1>;
> +       rockchip,hw-tshut-polarity = <0>;
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +       status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +       status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +       status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +       status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +       status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +       status = "okay";
> +};
> +
> +&usb2phy0 {
> +       status = "okay";
> +};
> +
> +&usb2phy0_host {
> +       phy-supply = <&vcc5v0_usb3_host>;
> +       status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +       phy-supply = <&vcc5v0_usb2_otg>;
> +       status = "okay";
> +};
> +
> +&usb2phy1 {
> +       status = "okay";
> +};
> +
> +&usb2phy1_host {
> +       phy-supply = <&vcc5v0_usb2_host>;
> +       status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +       phy-supply = <&vcc5v0_usb2_host>;
> +       status = "okay";
> +};
> +
> +&vop {
> +       assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +       assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +       status = "okay";
> +};
> +
> +&vop_mmu {
> +       status = "okay";
> +};
> +
> +&vp0 {
> +       vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +               reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +               remote-endpoint = <&hdmi_in_vp0>;
> +       };
> +};
> --
> 2.46.2
>
