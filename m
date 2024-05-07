Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C79C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 04:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A9488743;
	Tue,  7 May 2024 06:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="D5tTMtfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F03788722; Tue,  7 May 2024 05:33:50 +0200 (CEST)
Received: from mail-m12820.netease.com (mail-m12820.netease.com
 [103.209.128.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B3A88747
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=D5tTMtflIcdnIlqdX5980Q+EBvyWN2PSPDgOu+ewGBHu9KZlNqn7M4dRNYkNkTF/OvTjwpl+3DEpqe6OEHQhJmSRjjMSI3xTay85q+moJ6007SnF+uR7xfw4ZJVAHdeG87cfak+3i4sKILMr4ZVERZodf9yhZZhoiiReF2mlV68=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=r5MnMEX9/glKkk6YnkbwnlJ/amOvyqHOWCJq7mUHIRM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1D18A900118;
 Tue,  7 May 2024 11:33:17 +0800 (CST)
Message-ID: <513667d1-b83d-4c7d-9a00-4823395e9e4c@rock-chips.com>
Date: Tue, 7 May 2024 11:33:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] rockchip: rk3399: Remove redundant device tree files
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4ZTVZLGhoZHU1IT0tPShlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f511ce15403a9kunm1d18a900118
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6HBw6FDNRGBQoFUMrCk9R
 DAhPClFVSlVKTEpOS05JTEJCSE9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSk5MSkw3Bg++
X-Mailman-Approved-At: Tue, 07 May 2024 06:25:34 +0200
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


On 2024/5/5 03:42, Jonas Karlman wrote:
> Remove redundant device tree files now that RK3399 boards have been
> migrated to use OF_UPSTREAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-eaidk-610.dts             |  940 ------
>   arch/arm/dts/rk3399-evb.dts                   |  485 ---
>   arch/arm/dts/rk3399-ficus.dts                 |  174 -
>   arch/arm/dts/rk3399-firefly.dts               |  944 ------
>   arch/arm/dts/rk3399-gru-bob.dts               |   95 -
>   arch/arm/dts/rk3399-gru-chromebook.dtsi       |  590 ----
>   arch/arm/dts/rk3399-gru-kevin.dts             |  328 --
>   arch/arm/dts/rk3399-gru.dtsi                  |  865 -----
>   arch/arm/dts/rk3399-khadas-edge-captain.dts   |   31 -
>   arch/arm/dts/rk3399-khadas-edge-v.dts         |   31 -
>   arch/arm/dts/rk3399-khadas-edge.dts           |   13 -
>   arch/arm/dts/rk3399-khadas-edge.dtsi          |  837 -----
>   arch/arm/dts/rk3399-leez-p710.dts             |  653 ----
>   arch/arm/dts/rk3399-nanopc-t4.dts             |  137 -
>   arch/arm/dts/rk3399-nanopi-m4.dts             |   66 -
>   arch/arm/dts/rk3399-nanopi-m4b.dts            |   52 -
>   arch/arm/dts/rk3399-nanopi-neo4.dts           |   50 -
>   arch/arm/dts/rk3399-nanopi-r4s.dts            |  133 -
>   arch/arm/dts/rk3399-nanopi4.dtsi              |  762 -----
>   arch/arm/dts/rk3399-op1-opp.dtsi              |  166 -
>   arch/arm/dts/rk3399-opp.dtsi                  |  133 -
>   arch/arm/dts/rk3399-orangepi.dts              |  896 -----
>   arch/arm/dts/rk3399-pinebook-pro.dts          | 1111 -------
>   arch/arm/dts/rk3399-pinephone-pro.dts         |  621 ----
>   arch/arm/dts/rk3399-puma-haikou.dts           |  306 --
>   arch/arm/dts/rk3399-puma.dtsi                 |  532 ---
>   arch/arm/dts/rk3399-roc-pc-mezzanine.dts      |  111 -
>   arch/arm/dts/rk3399-roc-pc.dts                |   12 -
>   arch/arm/dts/rk3399-roc-pc.dtsi               |  844 -----
>   arch/arm/dts/rk3399-rock-4c-plus.dts          |  709 ----
>   arch/arm/dts/rk3399-rock-4se.dts              |   65 -
>   arch/arm/dts/rk3399-rock-pi-4.dtsi            |  792 -----
>   arch/arm/dts/rk3399-rock-pi-4a.dts            |   24 -
>   arch/arm/dts/rk3399-rock-pi-4c.dts            |   80 -
>   arch/arm/dts/rk3399-rock960.dts               |  156 -
>   arch/arm/dts/rk3399-rock960.dtsi              |  673 ----
>   arch/arm/dts/rk3399-rockpro64.dts             |   30 -
>   arch/arm/dts/rk3399-rockpro64.dtsi            |  956 ------
>   arch/arm/dts/rk3399-t-opp.dtsi                |  114 -
>   arch/arm/dts/rk3399.dtsi                      | 2945 -----------------
>   arch/arm/dts/rk3399pro-rock-pi-n10.dts        |   22 -
>   arch/arm/dts/rk3399pro-vmarc-som.dtsi         |  477 ---
>   arch/arm/dts/rk3399pro.dtsi                   |   22 -
>   .../clock/rockchip,rk3399-dmc.txt             |   42 -
>   include/dt-bindings/clock/rk3399-cru.h        |  751 -----
>   include/dt-bindings/power/rk3399-power.h      |   53 -
>   46 files changed, 19829 deletions(-)
>   delete mode 100644 arch/arm/dts/rk3399-eaidk-610.dts
>   delete mode 100644 arch/arm/dts/rk3399-evb.dts
>   delete mode 100644 arch/arm/dts/rk3399-ficus.dts
>   delete mode 100644 arch/arm/dts/rk3399-firefly.dts
>   delete mode 100644 arch/arm/dts/rk3399-gru-bob.dts
>   delete mode 100644 arch/arm/dts/rk3399-gru-chromebook.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-gru-kevin.dts
>   delete mode 100644 arch/arm/dts/rk3399-gru.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-khadas-edge-captain.dts
>   delete mode 100644 arch/arm/dts/rk3399-khadas-edge-v.dts
>   delete mode 100644 arch/arm/dts/rk3399-khadas-edge.dts
>   delete mode 100644 arch/arm/dts/rk3399-khadas-edge.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-leez-p710.dts
>   delete mode 100644 arch/arm/dts/rk3399-nanopc-t4.dts
>   delete mode 100644 arch/arm/dts/rk3399-nanopi-m4.dts
>   delete mode 100644 arch/arm/dts/rk3399-nanopi-m4b.dts
>   delete mode 100644 arch/arm/dts/rk3399-nanopi-neo4.dts
>   delete mode 100644 arch/arm/dts/rk3399-nanopi-r4s.dts
>   delete mode 100644 arch/arm/dts/rk3399-nanopi4.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-op1-opp.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-opp.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-orangepi.dts
>   delete mode 100644 arch/arm/dts/rk3399-pinebook-pro.dts
>   delete mode 100644 arch/arm/dts/rk3399-pinephone-pro.dts
>   delete mode 100644 arch/arm/dts/rk3399-puma-haikou.dts
>   delete mode 100644 arch/arm/dts/rk3399-puma.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-roc-pc-mezzanine.dts
>   delete mode 100644 arch/arm/dts/rk3399-roc-pc.dts
>   delete mode 100644 arch/arm/dts/rk3399-roc-pc.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-rock-4c-plus.dts
>   delete mode 100644 arch/arm/dts/rk3399-rock-4se.dts
>   delete mode 100644 arch/arm/dts/rk3399-rock-pi-4.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-rock-pi-4a.dts
>   delete mode 100644 arch/arm/dts/rk3399-rock-pi-4c.dts
>   delete mode 100644 arch/arm/dts/rk3399-rock960.dts
>   delete mode 100644 arch/arm/dts/rk3399-rock960.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-rockpro64.dts
>   delete mode 100644 arch/arm/dts/rk3399-rockpro64.dtsi
>   delete mode 100644 arch/arm/dts/rk3399-t-opp.dtsi
>   delete mode 100644 arch/arm/dts/rk3399.dtsi
>   delete mode 100644 arch/arm/dts/rk3399pro-rock-pi-n10.dts
>   delete mode 100644 arch/arm/dts/rk3399pro-vmarc-som.dtsi
>   delete mode 100644 arch/arm/dts/rk3399pro.dtsi
>   delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3399-dmc.txt
>   delete mode 100644 include/dt-bindings/clock/rk3399-cru.h
>   delete mode 100644 include/dt-bindings/power/rk3399-power.h
>
> diff --git a/arch/arm/dts/rk3399-eaidk-610.dts b/arch/arm/dts/rk3399-eaidk-610.dts
> deleted file mode 100644
> index 173da81fc231..000000000000
> --- a/arch/arm/dts/rk3399-eaidk-610.dts
> +++ /dev/null
> @@ -1,940 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2022 Fuzhou Rockchip Electronics Co., Ltd.
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include <dt-bindings/usb/pd.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "OPEN AI LAB EAIDK-610";
> -	compatible = "openailab,eaidk-610", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm0 0 25000 0>;
> -		brightness-levels = <
> -			  0   1   2   3   4   5   6   7
> -			  8   9  10  11  12  13  14  15
> -			 16  17  18  19  20  21  22  23
> -			 24  25  26  27  28  29  30  31
> -			 32  33  34  35  36  37  38  39
> -			 40  41  42  43  44  45  46  47
> -			 48  49  50  51  52  53  54  55
> -			 56  57  58  59  60  61  62  63
> -			 64  65  66  67  68  69  70  71
> -			 72  73  74  75  76  77  78  79
> -			 80  81  82  83  84  85  86  87
> -			 88  89  90  91  92  93  94  95
> -			 96  97  98  99 100 101 102 103
> -			104 105 106 107 108 109 110 111
> -			112 113 114 115 116 117 118 119
> -			120 121 122 123 124 125 126 127
> -			128 129 130 131 132 133 134 135
> -			136 137 138 139 140 141 142 143
> -			144 145 146 147 148 149 150 151
> -			152 153 154 155 156 157 158 159
> -			160 161 162 163 164 165 166 167
> -			168 169 170 171 172 173 174 175
> -			176 177 178 179 180 181 182 183
> -			184 185 186 187 188 189 190 191
> -			192 193 194 195 196 197 198 199
> -			200 201 202 203 204 205 206 207
> -			208 209 210 211 212 213 214 215
> -			216 217 218 219 220 221 222 223
> -			224 225 226 227 228 229 230 231
> -			232 233 234 235 236 237 238 239
> -			240 241 242 243 244 245 246 247
> -			248 249 250 251 252 253 254 255>;
> -		default-brightness-level = <200>;
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	dc_12v: dc-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn>;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&work_led_pin>, <&user_led_pin>,
> -			    <&heartbeat_led_pin>, <&wlan_active_led_pin>,
> -			    <&bt_active_led_pin>;
> -
> -		work_led: led-0 {
> -			label = "blue:work";
> -			default-state = "on";
> -			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		user_led: led-1 {
> -			label = "read:user";
> -			default-state = "off";
> -			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		heartbeat_led: led-2 {
> -			label = "green:heartbeat";
> -			linux,default-trigger = "heartbeat";
> -			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		wlan_active_led: led-3 {
> -			label = "yellow:wlan";
> -			gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "phy0tx";
> -			default-state = "off";
> -		};
> -
> -		bt_active_led: led-4 {
> -			label = "blue:bt";
> -			gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "hci0-power";
> -			default-state = "off";
> -		};
> -	};
> -
> -	rt5651-sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "realtek,rt5651-codec";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,widgets =
> -			"Microphone", "Mic Jack",
> -			"Headphone", "Headphone Jack";
> -		simple-audio-card,routing =
> -			"Mic Jack", "MICBIAS1",
> -			"IN1P", "Mic Jack",
> -			"Headphone Jack", "HPOL",
> -			"Headphone Jack", "HPOR";
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s1>;
> -		};
> -		simple-audio-card,codec {
> -			sound-dai = <&rt5651>;
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -
> -		/*
> -		 * On the module itself this is one of these (depending
> -		 * on the actual card populated):
> -		 * - SDIO_RESET_L_WL_REG_ON
> -		 * - PDN (power down when low)
> -		 */
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	/* For USB3.0 Port1/2 */
> -	vcc5v0_host1: vcc5v0-host1-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host1_en>;
> -		regulator-name = "vcc5v0_host1";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	/* For USB2.0 Port1/2 */
> -	vcc5v0_host3: vcc5v0-host3-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host3_en>;
> -		regulator-name = "vcc5v0_host3";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_typec: vcc5v0-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec_en>;
> -		regulator-name = "vcc5v0_typec";
> -		regulator-always-on;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -
> -		vcc1-supply = <&vcc3v3_sys>;
> -		vcc2-supply = <&vcc3v3_sys>;
> -		vcc3-supply = <&vcc3v3_sys>;
> -		vcc4-supply = <&vcc3v3_sys>;
> -		vcc6-supply = <&vcc3v3_sys>;
> -		vcc7-supply = <&vcc3v3_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc3v3_sys>;
> -		vcc10-supply = <&vcc3v3_sys>;
> -		vcc11-supply = <&vcc3v3_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_3v0>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc2v8_dvp: LDO_REG2 {
> -				regulator-name = "vcc2v8_dvp";
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmu: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmu";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_b";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_gpu";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <300>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -
> -	rt5651: audio-codec@1a {
> -		compatible = "rockchip,rt5651";
> -		reg = <0x1a>;
> -		clocks = <&cru SCLK_I2S_8CH_OUT>;
> -		clock-names = "mclk";
> -		hp-det-gpio = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
> -		spk-con-gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
> -		#sound-dai-cells = <0>;
> -	};
> -
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -
> -	fusb0: typec-portc@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb0_int>;
> -		vbus-supply = <&vcc5v0_typec>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				usbc0_role_sw: endpoint@0 {
> -					remote-endpoint = <&dwc3_0_role_switch>;
> -				};
> -			};
> -		};
> -
> -		connector {
> -			compatible = "usb-c-connector";
> -			data-role = "dual";
> -			label = "USB-C";
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> -
> -					usbc_hs: endpoint {
> -						remote-endpoint = <&u2phy0_typec_hs>;
> -					};
> -				};
> -
> -				port@1 {
> -					reg = <1>;
> -
> -					usbc_ss: endpoint {
> -						remote-endpoint = <&tcphy0_typec_ss>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	status = "okay";
> -
> -	audio-supply = <&vcca1v8_codec>;
> -	bt656-supply = <&vcc_3v0>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	sdmmc-supply = <&vcc_sdio>;
> -};
> -
> -&pmu_io_domains {
> -	status = "okay";
> -
> -	pmu1830-supply = <&vcc_3v0>;
> -};
> -
> -&pinctrl {
> -	buttons {
> -		pwrbtn: pwrbtn {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	bt {
> -		bt_enable_h: bt-enable-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	fusb302x {
> -		fusb0_int: fusb0-int {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	lcd-panel {
> -		lcd_panel_reset: lcd-panel-reset {
> -			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		work_led_pin: work-led-pin {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led_pin: user-led-pin {
> -			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		heartbeat_led_pin: heartbeat-led-pin {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wlan_active_led_pin: wlan-led-pin {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_active_led_pin: bt-led-pin {
> -			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	rt5651 {
> -		rt5651_hpcon: rt5640-hpcon {
> -			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc5v0_typec_en: vcc5v0_typec_en {
> -			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host3_en: vcc5v0-host3-en {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		vcc5v0_host1_en: vcc5v0-host1-en {
> -			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	/* WiFi & BT combo module AMPAK AP6255 */
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	bus-width = <4>;
> -	clock-frequency = <50000000>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy0_usb3 {
> -	orientation-switch;
> -	port {
> -		tcphy0_typec_ss: endpoint {
> -			remote-endpoint = <&usbc_ss>;
> -		};
> -	};
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host3>;
> -		status = "okay";
> -	};
> -
> -	port {
> -		u2phy0_typec_hs: endpoint {
> -			remote-endpoint = <&usbc_hs>;
> -		};
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host3>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm4345c5";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		max-speed = <1500000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	usb-role-switch;
> -
> -	port {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		dwc3_0_role_switch: endpoint@0 {
> -			reg = <0>;
> -			remote-endpoint = <&usbc0_role_sw>;
> -		};
> -	};
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-evb.dts b/arch/arm/dts/rk3399-evb.dts
> deleted file mode 100644
> index 55eca7a50a1f..000000000000
> --- a/arch/arm/dts/rk3399-evb.dts
> +++ /dev/null
> @@ -1,485 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -
> -/ {
> -	model = "Rockchip RK3399 Evaluation Board";
> -	compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdhci;
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		brightness-levels = <
> -			  0   1   2   3   4   5   6   7
> -			  8   9  10  11  12  13  14  15
> -			 16  17  18  19  20  21  22  23
> -			 24  25  26  27  28  29  30  31
> -			 32  33  34  35  36  37  38  39
> -			 40  41  42  43  44  45  46  47
> -			 48  49  50  51  52  53  54  55
> -			 56  57  58  59  60  61  62  63
> -			 64  65  66  67  68  69  70  71
> -			 72  73  74  75  76  77  78  79
> -			 80  81  82  83  84  85  86  87
> -			 88  89  90  91  92  93  94  95
> -			 96  97  98  99 100 101 102 103
> -			104 105 106 107 108 109 110 111
> -			112 113 114 115 116 117 118 119
> -			120 121 122 123 124 125 126 127
> -			128 129 130 131 132 133 134 135
> -			136 137 138 139 140 141 142 143
> -			144 145 146 147 148 149 150 151
> -			152 153 154 155 156 157 158 159
> -			160 161 162 163 164 165 166 167
> -			168 169 170 171 172 173 174 175
> -			176 177 178 179 180 181 182 183
> -			184 185 186 187 188 189 190 191
> -			192 193 194 195 196 197 198 199
> -			200 201 202 203 204 205 206 207
> -			208 209 210 211 212 213 214 215
> -			216 217 218 219 220 221 222 223
> -			224 225 226 227 228 229 230 231
> -			232 233 234 235 236 237 238 239
> -			240 241 242 243 244 245 246 247
> -			248 249 250 251 252 253 254 255>;
> -		default-brightness-level = <200>;
> -		pwms = <&pwm0 0 25000 0>;
> -	};
> -
> -	edp_panel: edp-panel {
> -		compatible = "lg,lp079qx1-sp0v";
> -		backlight = <&backlight>;
> -		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		power-supply = <&vcc3v3_s0>;
> -
> -		port {
> -			panel_in_edp: endpoint {
> -				remote-endpoint = <&edp_out_panel>;
> -			};
> -		};
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	vdd_center: vdd-center {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm3 0 25000 0>;
> -		regulator-name = "vdd_center";
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		status = "okay";
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc_phy: vcc-phy-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_phy";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc_phy: vcc-phy-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_phy";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -};
> -
> -&edp {
> -	status = "okay";
> -	force-hpd;
> -
> -	ports {
> -		edp_out: port@1 {
> -			reg = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			edp_out_panel: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&panel_in_edp>;
> -			};
> -		};
> -	};
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc_phy>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -		#clock-cells = <1>;
> -		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> -
> -		vcc1-supply = <&vcc3v3_sys>;
> -		vcc2-supply = <&vcc3v3_sys>;
> -		vcc3-supply = <&vcc3v3_sys>;
> -		vcc4-supply = <&vcc3v3_sys>;
> -		vcc6-supply = <&vcc3v3_sys>;
> -		vcc7-supply = <&vcc3v3_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc3v3_sys>;
> -		vcc10-supply = <&vcc3v3_sys>;
> -		vcc11-supply = <&vcc3v3_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc1v8_pmu>;
> -
> -		regulators {
> -			vdd_log: DCDC_REG1 {
> -				regulator-name = "vdd_log";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v0_tp: LDO_REG2 {
> -				regulator-name = "vcc3v0_tp";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmu: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmu";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sd: LDO_REG4 {
> -				regulator-name = "vcc_sd";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&pwm3 {
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "disabled";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	status = "disabled";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -};
> -
> -&u2phy1_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins =
> -				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins =
> -				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-ficus.dts b/arch/arm/dts/rk3399-ficus.dts
> deleted file mode 100644
> index 30e4879f322c..000000000000
> --- a/arch/arm/dts/rk3399-ficus.dts
> +++ /dev/null
> @@ -1,174 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2018 Collabora Ltd.
> - * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> - *
> - * Schematics available at https://dl.vamrs.com/products/ficus/docs/hw
> - */
> -
> -/dts-v1/;
> -#include "rk3399-rock960.dtsi"
> -
> -/ {
> -	model = "96boards RK3399 Ficus";
> -	compatible = "vamrs,ficus", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&user_led1_pin>, <&user_led2_pin>,
> -			    <&user_led3_pin>, <&user_led4_pin>,
> -			    <&wlan_led_pin>, <&bt_led_pin>;
> -
> -		user_led1: led-1 {
> -			label = "red:user1";
> -			gpios = <&gpio4 25 0>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -
> -		user_led2: led-2 {
> -			label = "red:user2";
> -			gpios = <&gpio4 26 0>;
> -			linux,default-trigger = "mmc0";
> -		};
> -
> -		user_led3: led-3 {
> -			label = "red:user3";
> -			gpios = <&gpio4 30 0>;
> -			linux,default-trigger = "mmc1";
> -		};
> -
> -		user_led4: led-4 {
> -			label = "red:user4";
> -			gpios = <&gpio1 0 0>;
> -			panic-indicator;
> -			linux,default-trigger = "none";
> -		};
> -
> -		wlan_active_led: led-5 {
> -			label = "red:wlan";
> -			gpios = <&gpio1 1 0>;
> -			linux,default-trigger = "phy0tx";
> -			default-state = "off";
> -		};
> -
> -		bt_active_led: led-6 {
> -			label = "red:bt";
> -			gpios = <&gpio1 4 0>;
> -			linux,default-trigger = "hci0-power";
> -			default-state = "off";
> -		};
> -	};
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc3v3_sys>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&pinctrl {
> -	gmac {
> -		rgmii_sleep_pins: rgmii-sleep-pins {
> -			rockchip,pins =
> -				<3 RK_PB7 RK_FUNC_GPIO &pcfg_output_low>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_drv: pcie-drv {
> -			rockchip,pins =
> -				<1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -			};
> -	};
> -
> -	usb2 {
> -		host_vbus_drv: host-vbus-drv {
> -			rockchip,pins =
> -				<4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		user_led1_pin: user-led1-pin {
> -			rockchip,pins =
> -				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led2_pin: user-led2-pin {
> -			rockchip,pins =
> -				<4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led3_pin: user-led3-pin {
> -			rockchip,pins =
> -				<4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led4_pin: user-led4-pin {
> -			rockchip,pins =
> -				<1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wlan_led_pin: wlan-led-pin {
> -			rockchip,pins =
> -				<1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_led_pin: bt-led-pin {
> -			rockchip,pins =
> -				<1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&spi1 {
> -	/* On both Low speed and High speed expansion */
> -	cs-gpios = <0>, <&gpio4 RK_PA6 0>, <&gpio4 RK_PA7 0>;
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	dr_mode = "host";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	dr_mode = "host";
> -};
> -
> -&vcc3v3_pcie {
> -	gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&vcc5v0_host {
> -	gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> -};
> diff --git a/arch/arm/dts/rk3399-firefly.dts b/arch/arm/dts/rk3399-firefly.dts
> deleted file mode 100644
> index 260415d99aeb..000000000000
> --- a/arch/arm/dts/rk3399-firefly.dts
> +++ /dev/null
> @@ -1,944 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include <dt-bindings/usb/pd.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Firefly-RK3399 Board";
> -	compatible = "firefly,firefly-rk3399", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		pwms = <&pwm0 0 25000 0>;
> -		brightness-levels = <
> -			  0   1   2   3   4   5   6   7
> -			  8   9  10  11  12  13  14  15
> -			 16  17  18  19  20  21  22  23
> -			 24  25  26  27  28  29  30  31
> -			 32  33  34  35  36  37  38  39
> -			 40  41  42  43  44  45  46  47
> -			 48  49  50  51  52  53  54  55
> -			 56  57  58  59  60  61  62  63
> -			 64  65  66  67  68  69  70  71
> -			 72  73  74  75  76  77  78  79
> -			 80  81  82  83  84  85  86  87
> -			 88  89  90  91  92  93  94  95
> -			 96  97  98  99 100 101 102 103
> -			104 105 106 107 108 109 110 111
> -			112 113 114 115 116 117 118 119
> -			120 121 122 123 124 125 126 127
> -			128 129 130 131 132 133 134 135
> -			136 137 138 139 140 141 142 143
> -			144 145 146 147 148 149 150 151
> -			152 153 154 155 156 157 158 159
> -			160 161 162 163 164 165 166 167
> -			168 169 170 171 172 173 174 175
> -			176 177 178 179 180 181 182 183
> -			184 185 186 187 188 189 190 191
> -			192 193 194 195 196 197 198 199
> -			200 201 202 203 204 205 206 207
> -			208 209 210 211 212 213 214 215
> -			216 217 218 219 220 221 222 223
> -			224 225 226 227 228 229 230 231
> -			232 233 234 235 236 237 238 239
> -			240 241 242 243 244 245 246 247
> -			248 249 250 251 252 253 254 255>;
> -		default-brightness-level = <200>;
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	dc_12v: dc-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn>;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> -		pinctrl-0 = <&ir_int>;
> -		pinctrl-names = "default";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&work_led_pin>, <&diy_led_pin>;
> -
> -		work_led: led-0 {
> -			label = "work";
> -			default-state = "on";
> -			gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		diy_led: led-1 {
> -			label = "diy";
> -			default-state = "off";
> -			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	rt5640-sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "rockchip,rt5640-codec";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,widgets =
> -			"Microphone", "Mic Jack",
> -			"Headphone", "Headphone Jack";
> -		simple-audio-card,routing =
> -			"Mic Jack", "MICBIAS1",
> -			"IN1P", "Mic Jack",
> -			"Headphone Jack", "HPOL",
> -			"Headphone Jack", "HPOR";
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s1>;
> -		};
> -
> -		simple-audio-card,codec {
> -			sound-dai = <&rt5640>;
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -
> -		/*
> -		 * On the module itself this is one of these (depending
> -		 * on the actual card populated):
> -		 * - SDIO_RESET_L_WL_REG_ON
> -		 * - PDN (power down when low)
> -		 */
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	sound-dit {
> -		compatible = "audio-graph-card";
> -		label = "SPDIF";
> -		dais = <&spdif_p0>;
> -	};
> -
> -	spdif-dit {
> -		compatible = "linux,spdif-dit";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			dit_p0_0: endpoint {
> -				remote-endpoint = <&spdif_p0_0>;
> -			};
> -		};
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	vcc3v3_pcie: vcc3v3-pcie-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_pwr_en>;
> -		regulator-name = "vcc3v3_pcie";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcc5v0_typec: vcc5v0-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec_en>;
> -		regulator-name = "vcc5v0_typec";
> -		regulator-always-on;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcc_sys: vcc-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc_sys>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <430000>;
> -		regulator-max-microvolt = <1400000>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc_sys>;
> -		vcc2-supply = <&vcc_sys>;
> -		vcc3-supply = <&vcc_sys>;
> -		vcc4-supply = <&vcc_sys>;
> -		vcc6-supply = <&vcc_sys>;
> -		vcc7-supply = <&vcc_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc_sys>;
> -		vcc10-supply = <&vcc_sys>;
> -		vcc11-supply = <&vcc_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc1v8_pmu>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc2v8_dvp: LDO_REG2 {
> -				regulator-name = "vcc2v8_dvp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmu: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmu";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <0>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <300>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -
> -	rt5640: rt5640@1c {
> -		compatible = "realtek,rt5640";
> -		reg = <0x1c>;
> -		clocks = <&cru SCLK_I2S_8CH_OUT>;
> -		clock-names = "mclk";
> -		realtek,in1-differential;
> -		#sound-dai-cells = <0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rt5640_hpcon>;
> -	};
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -
> -	fusb0: typec-portc@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb0_int>;
> -		vbus-supply = <&vcc5v0_typec>;
> -		status = "okay";
> -
> -		connector {
> -			compatible = "usb-c-connector";
> -			data-role = "host";
> -			label = "USB-C";
> -			op-sink-microwatt = <1000000>;
> -			power-role = "dual";
> -			sink-pdos =
> -				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
> -			source-pdos =
> -				<PDO_FIXED(5000, 1400, PDO_FIXED_USB_COMM)>;
> -			try-power-role = "sink";
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> -
> -					usbc_hs: endpoint {
> -						remote-endpoint =
> -							<&u2phy0_typec_hs>;
> -					};
> -				};
> -
> -				port@1 {
> -					reg = <1>;
> -
> -					usbc_ss: endpoint {
> -						remote-endpoint =
> -							<&tcphy0_typec_ss>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
> -	accelerometer@68 {
> -		compatible = "invensense,mpu6500";
> -		reg = <0x68>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PC6 IRQ_TYPE_EDGE_RISING>;
> -	};
> -};
> -
> -&i2s0 {
> -	rockchip,playback-channels = <8>;
> -	rockchip,capture-channels = <8>;
> -	status = "okay";
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	status = "okay";
> -
> -	bt656-supply = <&vcc1v8_dvp>;
> -	audio-supply = <&vcca1v8_codec>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	gpio1830-supply = <&vcc_3v0>;
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	buttons {
> -		pwrbtn: pwrbtn {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	fusb302x {
> -		fusb0_int: fusb0-int {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	ir {
> -		ir_int: ir-int {
> -			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	lcd-panel {
> -		lcd_panel_reset: lcd-panel-reset {
> -			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		work_led_pin: work-led-pin {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		diy_led_pin: diy-led-pin {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_pwr_en: pcie-pwr-en {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie_3g_drv: pcie-3g-drv {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	rt5640 {
> -		rt5640_hpcon: rt5640-hpcon {
> -			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc5v0_typec_en: vcc5v0_typec_en {
> -			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	/* WiFi & BT combo module Ampak AP6356S */
> -	bus-width = <4>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -
> -	/* Power supply */
> -	vqmmc-supply = <&vcc1v8_s3>;	/* IO line */
> -	vmmc-supply = <&vcc_sdio>;	/* card's power */
> -
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		reg = <1>;
> -		compatible = "brcm,bcm4329-fmac";
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		brcm,drive-strength = <5>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&spdif {
> -	pinctrl-0 = <&spdif_bus_1>;
> -	status = "okay";
> -
> -	spdif_p0: port {
> -		spdif_p0_0: endpoint {
> -			remote-endpoint = <&dit_p0_0>;
> -		};
> -	};
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy0_usb3 {
> -	port {
> -		tcphy0_typec_ss: endpoint {
> -			remote-endpoint = <&usbc_ss>;
> -		};
> -	};
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -
> -	port {
> -		u2phy0_typec_hs: endpoint {
> -			remote-endpoint = <&usbc_hs>;
> -		};
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "otg";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-gru-bob.dts b/arch/arm/dts/rk3399-gru-bob.dts
> deleted file mode 100644
> index 1cba1d857c96..000000000000
> --- a/arch/arm/dts/rk3399-gru-bob.dts
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Gru-Bob Rev 4+ board device tree source
> - *
> - * Copyright 2018 Google, Inc
> - */
> -
> -/dts-v1/;
> -#include "rk3399-gru-chromebook.dtsi"
> -
> -/ {
> -	model = "Google Bob";
> -	compatible = "google,bob-rev13", "google,bob-rev12",
> -		     "google,bob-rev11", "google,bob-rev10",
> -		     "google,bob-rev9", "google,bob-rev8",
> -		     "google,bob-rev7", "google,bob-rev6",
> -		     "google,bob-rev5", "google,bob-rev4",
> -		     "google,bob", "google,gru", "rockchip,rk3399";
> -	chassis-type = "convertible";
> -
> -	edp_panel: edp-panel {
> -		compatible = "boe,nv101wxmn51";
> -		backlight = <&backlight>;
> -		power-supply = <&pp3300_disp>;
> -
> -		port {
> -			panel_in_edp: endpoint {
> -				remote-endpoint = <&edp_out_panel>;
> -			};
> -		};
> -	};
> -};
> -
> -&ap_i2c_ts {
> -	touchscreen: touchscreen@10 {
> -		compatible = "elan,ekth3500";
> -		reg = <0x10>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&touch_int_l &touch_reset_l>;
> -		reset-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&ap_i2c_tp {
> -	trackpad: trackpad@15 {
> -		compatible = "elan,ekth3000";
> -		reg = <0x15>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&trackpad_int_l>;
> -		wakeup-source;
> -	};
> -};
> -
> -&backlight {
> -	pwms = <&cros_ec_pwm 0>;
> -};
> -
> -&cpu_alert0 {
> -	temperature = <65000>;
> -};
> -
> -&cpu_alert1 {
> -	temperature = <70000>;
> -};
> -
> -&spi0 {
> -	status = "okay";
> -
> -	tpm@0 {
> -		compatible = "google,cr50";
> -		reg = <0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <5 IRQ_TYPE_EDGE_RISING>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&h1_int_od_l>;
> -		spi-max-frequency = <800000>;
> -	};
> -};
> -
> -&pinctrl {
> -	tpm {
> -		h1_int_od_l: h1-int-od-l {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&wlan_host_wake_l {
> -	/* Kevin has an external pull up, but Bob does not. */
> -	rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> -};
> diff --git a/arch/arm/dts/rk3399-gru-chromebook.dtsi b/arch/arm/dts/rk3399-gru-chromebook.dtsi
> deleted file mode 100644
> index cacbad35cfc8..000000000000
> --- a/arch/arm/dts/rk3399-gru-chromebook.dtsi
> +++ /dev/null
> @@ -1,590 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Gru-Chromebook shared properties
> - *
> - * Copyright 2018 Google, Inc
> - */
> -
> -#include "rk3399-gru.dtsi"
> -
> -/ {
> -	pp900_ap: pp900-ap {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp900_ap";
> -
> -		/* EC turns on w/ pp900_ap_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	/* EC turns on w/ pp900_usb_en */
> -	pp900_usb: pp900-ap {
> -	};
> -
> -	/* EC turns on w/ pp900_pcie_en */
> -	pp900_pcie: pp900-ap {
> -	};
> -
> -	pp3000: pp3000 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp3000";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pp3000_en>;
> -
> -		enable-active-high;
> -		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3000000>;
> -		regulator-max-microvolt = <3000000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	ppvar_centerlogic_pwm: ppvar-centerlogic-pwm {
> -		compatible = "pwm-regulator";
> -		regulator-name = "ppvar_centerlogic_pwm";
> -
> -		pwms = <&pwm3 0 3337 0>;
> -		pwm-supply = <&ppvar_sys>;
> -		pwm-dutycycle-range = <100 0>;
> -		pwm-dutycycle-unit = <100>;
> -
> -		/* EC turns on w/ ppvar_centerlogic_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <799434>;
> -		regulator-max-microvolt = <1049925>;
> -	};
> -
> -	ppvar_centerlogic: ppvar-centerlogic {
> -		compatible = "vctrl-regulator";
> -		regulator-name = "ppvar_centerlogic";
> -
> -		regulator-min-microvolt = <799434>;
> -		regulator-max-microvolt = <1049925>;
> -
> -		ctrl-supply = <&ppvar_centerlogic_pwm>;
> -		ctrl-voltage-range = <799434 1049925>;
> -
> -		regulator-settling-time-up-us = <378>;
> -		min-slew-down-rate = <225>;
> -		ovp-threshold-percent = <16>;
> -	};
> -
> -	/* Schematics call this PPVAR even though it's fixed */
> -	ppvar_logic: ppvar-logic {
> -		compatible = "regulator-fixed";
> -		regulator-name = "ppvar_logic";
> -
> -		/* EC turns on w/ ppvar_logic_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	pp1800_audio: pp1800-audio {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp1800_audio";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pp1800_audio_en>;
> -
> -		enable-active-high;
> -		gpio = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -
> -		vin-supply = <&pp1800>;
> -	};
> -
> -	/* gpio is shared with pp3300_wifi_bt */
> -	pp1800_pcie: pp1800-pcie {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp1800_pcie";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wlan_module_pd_l>;
> -
> -		enable-active-high;
> -		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> -
> -		/*
> -		 * Need to wait 1ms + ramp-up time before we can power on WiFi.
> -		 * This has been approximated as 8ms total.
> -		 */
> -		regulator-enable-ramp-delay = <8000>;
> -
> -		vin-supply = <&pp1800>;
> -	};
> -
> -	/* Always on; plain and simple */
> -	pp3000_ap: pp3000_emmc: pp3000 {
> -	};
> -
> -	pp1500_ap_io: pp1500-ap-io {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp1500_ap_io";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pp1500_en>;
> -
> -		enable-active-high;
> -		gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1500000>;
> -		regulator-max-microvolt = <1500000>;
> -
> -		vin-supply = <&pp1800>;
> -	};
> -
> -	pp3300_disp: pp3300-disp {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp3300_disp";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pp3300_disp_en>;
> -
> -		enable-active-high;
> -		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> -
> -		startup-delay-us = <2000>;
> -		vin-supply = <&pp3300>;
> -	};
> -
> -	/* EC turns on w/ pp3300_usb_en_l */
> -	pp3300_usb: pp3300 {
> -	};
> -
> -	/* gpio is shared with pp1800_pcie and pinctrl is set there */
> -	pp3300_wifi_bt: pp3300-wifi-bt {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp3300_wifi_bt";
> -
> -		enable-active-high;
> -		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> -
> -		vin-supply = <&pp3300>;
> -	};
> -
> -	/*
> -	 * This is a bit of a hack. The WiFi module should be reset at least
> -	 * 1ms after its regulators have ramped up (max rampup time is ~7ms).
> -	 * With some stretching of the imagination, we can call the 1.8V
> -	 * regulator a supply.
> -	 */
> -	wlan_pd_n: wlan-pd-n {
> -		compatible = "regulator-fixed";
> -		regulator-name = "wlan_pd_n";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wlan_module_reset_l>;
> -
> -		enable-active-high;
> -		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> -
> -		vin-supply = <&pp1800_pcie>;
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		enable-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> -		power-supply = <&pp3300_disp>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bl_en>;
> -	};
> -
> -	gpio_keys: gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l>;
> -
> -		wake_on_bt: key-wake-on-bt {
> -			label = "Wake-on-Bluetooth";
> -			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> -			linux,code = <KEY_WAKEUP>;
> -			wakeup-source;
> -		};
> -	};
> -};
> -
> -&ppvar_bigcpu {
> -	min-slew-down-rate = <225>;
> -	ovp-threshold-percent = <16>;
> -};
> -
> -&ppvar_litcpu {
> -	min-slew-down-rate = <225>;
> -	ovp-threshold-percent = <16>;
> -};
> -
> -&ppvar_gpu {
> -	min-slew-down-rate = <225>;
> -	ovp-threshold-percent = <16>;
> -};
> -
> -&cdn_dp {
> -	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
> -};
> -
> -&dmc {
> -	center-supply = <&ppvar_centerlogic>;
> -	rockchip,pd-idle-dis-freq-hz = <800000000>;
> -	rockchip,sr-idle-dis-freq-hz = <800000000>;
> -	rockchip,sr-mc-gate-idle-dis-freq-hz = <800000000>;
> -};
> -
> -&edp {
> -	status = "okay";
> -
> -	/*
> -	 * eDP PHY/clk don't sync reliably at anything other than 24 MHz. Only
> -	 * set this here, because rk3399-gru.dtsi ensures we can generate this
> -	 * off GPLL=600MHz, whereas some other RK3399 boards may not.
> -	 */
> -	assigned-clocks = <&cru PCLK_EDP>;
> -	assigned-clock-rates = <24000000>;
> -
> -	ports {
> -		edp_out: port@1 {
> -			reg = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			edp_out_panel: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&panel_in_edp>;
> -			};
> -		};
> -	};
> -};
> -
> -&gpio0 {
> -	gpio-line-names = /* GPIO0 A 0-7 */
> -			  "AP_RTC_CLK_IN",
> -			  "EC_AP_INT_L",
> -			  "PP1800_AUDIO_EN",
> -			  "BT_HOST_WAKE_L",
> -			  "WLAN_MODULE_PD_L",
> -			  "H1_INT_OD_L",
> -			  "CENTERLOGIC_DVS_PWM",
> -			  "",
> -
> -			  /* GPIO0 B 0-4 */
> -			  "WIFI_HOST_WAKE_L",
> -			  "PMUIO2_33_18_L",
> -			  "PP1500_EN",
> -			  "AP_EC_WARM_RESET_REQ",
> -			  "PP3000_EN";
> -};
> -
> -&gpio1 {
> -	gpio-line-names = /* GPIO1 A 0-7 */
> -			  "",
> -			  "",
> -			  "SPK_PA_EN",
> -			  "",
> -			  "TRACKPAD_INT_L",
> -			  "AP_EC_S3_S0_L",
> -			  "AP_EC_OVERTEMP",
> -			  "AP_SPI_FLASH_MISO",
> -
> -			  /* GPIO1 B 0-7 */
> -			  "AP_SPI_FLASH_MOSI_R",
> -			  "AP_SPI_FLASH_CLK_R",
> -			  "AP_SPI_FLASH_CS_L_R",
> -			  "WLAN_MODULE_RESET_L",
> -			  "WIFI_DISABLE_L",
> -			  "MIC_INT",
> -			  "",
> -			  "AP_I2C_DVS_SDA",
> -
> -			  /* GPIO1 C 0-7 */
> -			  "AP_I2C_DVS_SCL",
> -			  "AP_BL_EN",
> -			  /*
> -			   * AP_FLASH_WP is crossystem ABI. Schematics call it
> -			   * AP_FW_WP or CPU1_FW_WP, depending on the variant.
> -			   */
> -			  "AP_FLASH_WP",
> -			  "LITCPU_DVS_PWM",
> -			  "AP_I2C_AUDIO_SDA",
> -			  "AP_I2C_AUDIO_SCL",
> -			  "",
> -			  "HEADSET_INT_L";
> -};
> -
> -&gpio2 {
> -	gpio-line-names = /* GPIO2 A 0-7 */
> -			  "",
> -			  "",
> -			  "SD_IO_PWR_EN",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -
> -			  /* GPIO2 B 0-7 */
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -
> -			  /* GPIO2 C 0-7 */
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "AP_SPI_EC_MISO",
> -			  "AP_SPI_EC_MOSI",
> -			  "AP_SPI_EC_CLK",
> -			  "AP_SPI_EC_CS_L",
> -
> -			  /* GPIO2 D 0-4 */
> -			  "BT_DEV_WAKE_L",
> -			  "",
> -			  "WIFI_PCIE_CLKREQ_L",
> -			  "WIFI_PERST_L",
> -			  "SD_PWR_3000_1800_L";
> -};
> -
> -&gpio3 {
> -	gpio-line-names = /* GPIO3 A 0-7 */
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "AP_SPI_TPM_MISO",
> -			  "AP_SPI_TPM_MOSI_R",
> -			  "AP_SPI_TPM_CLK_R",
> -			  "AP_SPI_TPM_CS_L_R",
> -
> -			  /* GPIO3 B 0-7 */
> -			  "EC_IN_RW",
> -			  "",
> -			  "AP_I2C_TP_SDA",
> -			  "AP_I2C_TP_SCL",
> -			  "AP_I2C_TP_PU_EN",
> -			  "TOUCH_INT_L",
> -			  "",
> -			  "",
> -
> -			  /* GPIO3 C 0-7 */
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -
> -			  /* GPIO3 D 0-7 */
> -			  "I2S0_SCLK",
> -			  "I2S0_LRCK_RX",
> -			  "I2S0_LRCK_TX",
> -			  "I2S0_SDI_0",
> -			  "I2S0_SDI_1",
> -			  "",
> -			  "I2S0_SDO_1",
> -			  "I2S0_SDO_0";
> -};
> -
> -&gpio4 {
> -	gpio-line-names = /* GPIO4 A 0-7 */
> -			  "I2S_MCLK",
> -			  "AP_I2C_MIC_SDA",
> -			  "AP_I2C_MIC_SCL",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -
> -			  /* GPIO4 B 0-7 */
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -			  "",
> -
> -			  /* GPIO4 C 0-7 */
> -			  "AP_I2C_TS_SDA",
> -			  "AP_I2C_TS_SCL",
> -			  "GPU_DVS_PWM",
> -			  "UART_DBG_TX_AP_RX",
> -			  "UART_AP_TX_DBG_RX",
> -			  "",
> -			  "BIGCPU_DVS_PWM",
> -			  "EDP_HPD_3V0",
> -
> -			  /* GPIO4 D 0-5 */
> -			  "SD_CARD_DET_L",
> -			  "USB_DP_HPD",
> -			  "TOUCH_RESET_L",
> -			  "PP3300_DISP_EN",
> -			  "",
> -			  "SD_SLOT_PWR_EN";
> -};
> -
> -ap_i2c_mic: &i2c1 {
> -	status = "okay";
> -
> -	clock-frequency = <400000>;
> -
> -	/* These are relatively safe rise/fall times */
> -	i2c-scl-falling-time-ns = <50>;
> -	i2c-scl-rising-time-ns = <300>;
> -
> -	headsetcodec: rt5514@57 {
> -		compatible = "realtek,rt5514";
> -		reg = <0x57>;
> -		realtek,dmic-init-delay-ms = <20>;
> -	};
> -};
> -
> -ap_i2c_tp: &i2c5 {
> -	status = "okay";
> -
> -	clock-frequency = <400000>;
> -
> -	/* These are relatively safe rise/fall times */
> -	i2c-scl-falling-time-ns = <50>;
> -	i2c-scl-rising-time-ns = <300>;
> -
> -	/*
> -	 * Note strange pullup enable.  Apparently this avoids leakage but
> -	 * still allows us to get nice 4.7K pullups for high speed i2c
> -	 * transfers.  Basically we want the pullup on whenever the ap is
> -	 * alive, so the "en" pin just gets set to output high.
> -	 */
> -	pinctrl-0 = <&i2c5_xfer &ap_i2c_tp_pu_en>;
> -};
> -
> -&cros_ec {
> -	cros_ec_pwm: pwm {
> -		compatible = "google,cros-ec-pwm";
> -		#pwm-cells = <1>;
> -	};
> -
> -	usbc_extcon1: extcon1 {
> -		compatible = "google,extcon-usbc-cros-ec";
> -		google,usb-port-id = <1>;
> -	};
> -};
> -
> -&sound {
> -	rockchip,codec = <&max98357a &headsetcodec
> -			  &codec &wacky_spi_audio &cdn_dp>;
> -};
> -
> -&spi2 {
> -	wacky_spi_audio: spi2@0 {
> -		compatible = "realtek,rt5514";
> -		reg = <0>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&mic_int>;
> -		/* May run faster once verified. */
> -		spi-max-frequency = <10000000>;
> -		wakeup-source;
> -	};
> -};
> -
> -&pci_rootport {
> -	mvl_wifi: wifi@0,0 {
> -		compatible = "pci1b4b,2b42";
> -		reg = <0x0000 0x0 0x0 0x0 0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wlan_host_wake_l>;
> -		wakeup-source;
> -	};
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -	extcon = <&usbc_extcon1>;
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -	extcon = <&usbc_extcon1>;
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&pinctrl {
> -	discrete-regulators {
> -		pp1500_en: pp1500-en {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO
> -					 &pcfg_pull_none>;
> -		};
> -
> -		pp1800_audio_en: pp1800-audio-en {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO
> -					 &pcfg_pull_down>;
> -		};
> -
> -		pp3000_en: pp3000-en {
> -			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO
> -					 &pcfg_pull_none>;
> -		};
> -
> -		pp3300_disp_en: pp3300-disp-en {
> -			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO
> -					 &pcfg_pull_none>;
> -		};
> -
> -		wlan_module_pd_l: wlan-module-pd-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO
> -					 &pcfg_pull_down>;
> -		};
> -	};
> -};
> -
> -&wifi {
> -	wifi_perst_l: wifi-perst-l {
> -		rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -	};
> -
> -	wlan_host_wake_l: wlan-host-wake-l {
> -		/* Kevin has an external pull up, but Bob does not */
> -		rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-gru-kevin.dts b/arch/arm/dts/rk3399-gru-kevin.dts
> deleted file mode 100644
> index 2cc9b3386c16..000000000000
> --- a/arch/arm/dts/rk3399-gru-kevin.dts
> +++ /dev/null
> @@ -1,328 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Gru-Kevin Rev 6+ board device tree source
> - *
> - * Copyright 2016-2017 Google, Inc
> - */
> -
> -/dts-v1/;
> -#include "rk3399-gru-chromebook.dtsi"
> -#include <dt-bindings/input/linux-event-codes.h>
> -
> -/*
> - * Kevin-specific things
> - *
> - * Things in this section should use names from Kevin schematic since no
> - * equivalent exists in Gru schematic.  If referring to signals that exist
> - * in Gru we use the Gru names, though.  Confusing enough for you?
> - */
> -/ {
> -	model = "Google Kevin";
> -	compatible = "google,kevin-rev15", "google,kevin-rev14",
> -		     "google,kevin-rev13", "google,kevin-rev12",
> -		     "google,kevin-rev11", "google,kevin-rev10",
> -		     "google,kevin-rev9", "google,kevin-rev8",
> -		     "google,kevin-rev7", "google,kevin-rev6",
> -		     "google,kevin", "google,gru", "rockchip,rk3399";
> -	chassis-type = "convertible";
> -
> -	/* Power tree */
> -
> -	p3_3v_dig: p3-3v-dig {
> -		compatible = "regulator-fixed";
> -		regulator-name = "p3.3v_dig";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cpu3_pen_pwr_en>;
> -
> -		enable-active-high;
> -		gpio = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&pp3300>;
> -	};
> -
> -	edp_panel: edp-panel {
> -		compatible = "sharp,lq123p1jx31";
> -		backlight = <&backlight>;
> -		power-supply = <&pp3300_disp>;
> -
> -		panel-timing {
> -			clock-frequency = <266666667>;
> -			hactive = <2400>;
> -			hfront-porch = <48>;
> -			hback-porch = <84>;
> -			hsync-len = <32>;
> -			hsync-active = <0>;
> -			vactive = <1600>;
> -			vfront-porch = <3>;
> -			vback-porch = <120>;
> -			vsync-len = <10>;
> -			vsync-active = <0>;
> -		};
> -
> -		port {
> -			panel_in_edp: endpoint {
> -				remote-endpoint = <&edp_out_panel>;
> -			};
> -		};
> -	};
> -
> -	thermistor_ppvar_bigcpu: thermistor-ppvar-bigcpu {
> -		compatible = "murata,ncp15wb473";
> -		pullup-uv = <1800000>;
> -		pullup-ohm = <25500>;
> -		pulldown-ohm = <0>;
> -		io-channels = <&saradc 2>;
> -		#thermal-sensor-cells = <0>;
> -	};
> -
> -	thermistor_ppvar_litcpu: thermistor-ppvar-litcpu {
> -		compatible = "murata,ncp15wb473";
> -		pullup-uv = <1800000>;
> -		pullup-ohm = <25500>;
> -		pulldown-ohm = <0>;
> -		io-channels = <&saradc 3>;
> -		#thermal-sensor-cells = <0>;
> -	};
> -};
> -
> -&backlight {
> -	pwms = <&cros_ec_pwm 1>;
> -};
> -
> -&gpio_keys {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&bt_host_wake_l>, <&cpu1_pen_eject>;
> -
> -	switch-pen-insert {
> -		label = "Pen Insert";
> -		/* Insert = low, eject = high */
> -		gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> -		linux,code = <SW_PEN_INSERTED>;
> -		linux,input-type = <EV_SW>;
> -		wakeup-source;
> -	};
> -};
> -
> -&thermal_zones {
> -	bigcpu_reg_thermal: bigcpu-reg-thermal {
> -		polling-delay-passive = <100>; /* milliseconds */
> -		polling-delay = <1000>; /* milliseconds */
> -		thermal-sensors = <&thermistor_ppvar_bigcpu 0>;
> -		sustainable-power = <4000>;
> -
> -		ppvar_bigcpu_trips: trips {
> -			ppvar_bigcpu_on: ppvar-bigcpu-on {
> -				temperature = <40000>;	/* millicelsius */
> -				hysteresis = <2000>;	/* millicelsius */
> -				type = "passive";
> -			};
> -
> -			ppvar_bigcpu_alert: ppvar-bigcpu-alert {
> -				temperature = <50000>;	/* millicelsius */
> -				hysteresis = <2000>;	/* millicelsius */
> -				type = "passive";
> -			};
> -
> -			ppvar_bigcpu_crit: ppvar-bigcpu-crit {
> -				temperature = <90000>;	/* millicelsius */
> -				hysteresis = <0>;	/* millicelsius */
> -				type = "critical";
> -			};
> -		};
> -
> -		cooling-maps {
> -			map0 {
> -				trip = <&ppvar_bigcpu_alert>;
> -				cooling-device =
> -					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -					<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -					<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -					<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				contribution = <4096>;
> -			};
> -			map1 {
> -				trip = <&ppvar_bigcpu_alert>;
> -				cooling-device =
> -					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				contribution = <1024>;
> -			};
> -		};
> -	};
> -
> -	litcpu_reg_thermal: litcpu-reg-thermal {
> -		polling-delay-passive = <100>; /* milliseconds */
> -		polling-delay = <1000>; /* milliseconds */
> -		thermal-sensors = <&thermistor_ppvar_litcpu 0>;
> -		sustainable-power = <4000>;
> -
> -		ppvar_litcpu_trips: trips {
> -			ppvar_litcpu_on: ppvar-litcpu-on {
> -				temperature = <40000>;	/* millicelsius */
> -				hysteresis = <2000>;	/* millicelsius */
> -				type = "passive";
> -			};
> -
> -			ppvar_litcpu_alert: ppvar-litcpu-alert {
> -				temperature = <50000>;	/* millicelsius */
> -				hysteresis = <2000>;	/* millicelsius */
> -				type = "passive";
> -			};
> -
> -			ppvar_litcpu_crit: ppvar-litcpu-crit {
> -				temperature = <90000>;	/* millicelsius */
> -				hysteresis = <0>;	/* millicelsius */
> -				type = "critical";
> -			};
> -		};
> -	};
> -};
> -
> -ap_i2c_tpm: &i2c0 {
> -	status = "okay";
> -
> -	clock-frequency = <400000>;
> -
> -	/* These are relatively safe rise/fall times. */
> -	i2c-scl-falling-time-ns = <50>;
> -	i2c-scl-rising-time-ns = <300>;
> -
> -	tpm: tpm@20 {
> -		compatible = "infineon,slb9645tt";
> -		reg = <0x20>;
> -		powered-while-suspended;
> -	};
> -};
> -
> -ap_i2c_dig: &i2c2 {
> -	status = "okay";
> -
> -	clock-frequency = <400000>;
> -
> -	/* These are relatively safe rise/fall times. */
> -	i2c-scl-falling-time-ns = <50>;
> -	i2c-scl-rising-time-ns = <300>;
> -
> -	digitizer: digitizer@9 {
> -		/* wacom,w9013 */
> -		compatible = "hid-over-i2c";
> -		reg = <0x9>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cpu1_dig_irq_l &cpu1_dig_pdct_l>;
> -
> -		vdd-supply = <&p3_3v_dig>;
> -		post-power-on-delay-ms = <100>;
> -
> -		interrupt-parent = <&gpio2>;
> -		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> -
> -		hid-descr-addr = <0x1>;
> -	};
> -};
> -
> -/* Adjustments to things in the gru baseboard */
> -
> -&ap_i2c_tp {
> -	trackpad@4a {
> -		compatible = "atmel,maxtouch";
> -		reg = <0x4a>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&trackpad_int_l>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> -		linux,gpio-keymap = <KEY_RESERVED
> -				     KEY_RESERVED
> -				     KEY_RESERVED
> -				     BTN_LEFT>;
> -		wakeup-source;
> -	};
> -};
> -
> -&ap_i2c_ts {
> -	touchscreen@4b {
> -		compatible = "atmel,maxtouch";
> -		reg = <0x4b>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&touch_int_l>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -};
> -
> -&ppvar_bigcpu_pwm {
> -	regulator-min-microvolt = <798674>;
> -	regulator-max-microvolt = <1302172>;
> -};
> -
> -&ppvar_bigcpu {
> -	regulator-min-microvolt = <798674>;
> -	regulator-max-microvolt = <1302172>;
> -	ctrl-voltage-range = <798674 1302172>;
> -};
> -
> -&ppvar_litcpu_pwm {
> -	regulator-min-microvolt = <799065>;
> -	regulator-max-microvolt = <1303738>;
> -};
> -
> -&ppvar_litcpu {
> -	regulator-min-microvolt = <799065>;
> -	regulator-max-microvolt = <1303738>;
> -	ctrl-voltage-range = <799065 1303738>;
> -};
> -
> -&ppvar_gpu_pwm {
> -	regulator-min-microvolt = <785782>;
> -	regulator-max-microvolt = <1217729>;
> -};
> -
> -&ppvar_gpu {
> -	regulator-min-microvolt = <785782>;
> -	regulator-max-microvolt = <1217729>;
> -	ctrl-voltage-range = <785782 1217729>;
> -};
> -
> -&ppvar_centerlogic_pwm {
> -	regulator-min-microvolt = <800069>;
> -	regulator-max-microvolt = <1049692>;
> -};
> -
> -&ppvar_centerlogic {
> -	regulator-min-microvolt = <800069>;
> -	regulator-max-microvolt = <1049692>;
> -	ctrl-voltage-range = <800069 1049692>;
> -};
> -
> -&saradc {
> -	status = "okay";
> -	vref-supply = <&pp1800_ap_io>;
> -};
> -
> -&mvl_wifi {
> -	marvell,wakeup-pin = <14>; /* GPIO_14 on Marvell */
> -};
> -
> -&pinctrl {
> -	digitizer {
> -		/* Has external pullup */
> -		cpu1_dig_irq_l: cpu1-dig-irq-l {
> -			rockchip,pins = <2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		/* Has external pullup */
> -		cpu1_dig_pdct_l: cpu1-dig-pdct-l {
> -			rockchip,pins = <2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	discrete-regulators {
> -		cpu3_pen_pwr_en: cpu3-pen-pwr-en {
> -			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pen {
> -		cpu1_pen_eject: cpu1-pen-eject {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-gru.dtsi b/arch/arm/dts/rk3399-gru.dtsi
> deleted file mode 100644
> index d90fe4d40d48..000000000000
> --- a/arch/arm/dts/rk3399-gru.dtsi
> +++ /dev/null
> @@ -1,865 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Gru (and derivatives) board device tree source
> - *
> - * Copyright 2016-2017 Google, Inc
> - */
> -
> -#include <dt-bindings/input/input.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-op1-opp.dtsi"
> -
> -/ {
> -	aliases {
> -		mmc0 = &sdmmc;
> -		mmc1 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	/*
> -	 * Power Tree
> -	 *
> -	 * In general an attempt is made to include all rails called out by
> -	 * the schematic as long as those rails interact in some way with
> -	 * the AP.  AKA:
> -	 * - Rails that only connect to the EC (or devices that the EC talks to)
> -	 *   are not included.
> -	 * - Rails _are_ included if the rails go to the AP even if the AP
> -	 *   doesn't currently care about them / they are always on.  The idea
> -	 *   here is that it makes it easier to map to the schematic or extend
> -	 *   later.
> -	 *
> -	 * If two rails are substantially the same from the AP's point of
> -	 * view, though, we won't create a full fixed regulator.  We'll just
> -	 * put the child rail as an alias of the parent rail.  Sometimes rails
> -	 * look the same to the AP because one of these is true:
> -	 * - The EC controls the enable and the EC always enables a rail as
> -	 *   long as the AP is running.
> -	 * - The rails are actually connected to each other by a jumper and
> -	 *   the distinction is just there to add clarity/flexibility to the
> -	 *   schematic.
> -	 */
> -
> -	ppvar_sys: ppvar-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "ppvar_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	pp1200_lpddr: pp1200-lpddr {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp1200_lpddr";
> -
> -		/* EC turns on w/ lpddr_pwr_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1200000>;
> -		regulator-max-microvolt = <1200000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	pp1800: pp1800 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp1800";
> -
> -		/* Always on when ppvar_sys shows power good */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	pp3300: pp3300 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp3300";
> -
> -		/* Always on; plain and simple */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	pp5000: pp5000 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp5000";
> -
> -		/* EC turns on w/ pp5000_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -
> -		vin-supply = <&ppvar_sys>;
> -	};
> -
> -	ppvar_bigcpu_pwm: ppvar-bigcpu-pwm {
> -		compatible = "pwm-regulator";
> -		regulator-name = "ppvar_bigcpu_pwm";
> -
> -		pwms = <&pwm1 0 3337 0>;
> -		pwm-supply = <&ppvar_sys>;
> -		pwm-dutycycle-range = <100 0>;
> -		pwm-dutycycle-unit = <100>;
> -
> -		/* EC turns on w/ ap_core_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800107>;
> -		regulator-max-microvolt = <1302232>;
> -	};
> -
> -	ppvar_bigcpu: ppvar-bigcpu {
> -		compatible = "vctrl-regulator";
> -		regulator-name = "ppvar_bigcpu";
> -
> -		regulator-min-microvolt = <800107>;
> -		regulator-max-microvolt = <1302232>;
> -
> -		ctrl-supply = <&ppvar_bigcpu_pwm>;
> -		ctrl-voltage-range = <800107 1302232>;
> -
> -		regulator-settling-time-up-us = <322>;
> -	};
> -
> -	ppvar_litcpu_pwm: ppvar-litcpu-pwm {
> -		compatible = "pwm-regulator";
> -		regulator-name = "ppvar_litcpu_pwm";
> -
> -		pwms = <&pwm2 0 3337 0>;
> -		pwm-supply = <&ppvar_sys>;
> -		pwm-dutycycle-range = <100 0>;
> -		pwm-dutycycle-unit = <100>;
> -
> -		/* EC turns on w/ ap_core_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <797743>;
> -		regulator-max-microvolt = <1307837>;
> -	};
> -
> -	ppvar_litcpu: ppvar-litcpu {
> -		compatible = "vctrl-regulator";
> -		regulator-name = "ppvar_litcpu";
> -
> -		regulator-min-microvolt = <797743>;
> -		regulator-max-microvolt = <1307837>;
> -
> -		ctrl-supply = <&ppvar_litcpu_pwm>;
> -		ctrl-voltage-range = <797743 1307837>;
> -
> -		regulator-settling-time-up-us = <384>;
> -	};
> -
> -	ppvar_gpu_pwm: ppvar-gpu-pwm {
> -		compatible = "pwm-regulator";
> -		regulator-name = "ppvar_gpu_pwm";
> -
> -		pwms = <&pwm0 0 3337 0>;
> -		pwm-supply = <&ppvar_sys>;
> -		pwm-dutycycle-range = <100 0>;
> -		pwm-dutycycle-unit = <100>;
> -
> -		/* EC turns on w/ ap_core_en; always on for AP */
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <786384>;
> -		regulator-max-microvolt = <1217747>;
> -	};
> -
> -	ppvar_gpu: ppvar-gpu {
> -		compatible = "vctrl-regulator";
> -		regulator-name = "ppvar_gpu";
> -
> -		regulator-min-microvolt = <786384>;
> -		regulator-max-microvolt = <1217747>;
> -
> -		ctrl-supply = <&ppvar_gpu_pwm>;
> -		ctrl-voltage-range = <786384 1217747>;
> -
> -		regulator-settling-time-up-us = <390>;
> -	};
> -
> -	/* EC turns on w/ pp900_ddrpll_en */
> -	pp900_ddrpll: pp900-ap {
> -	};
> -
> -	/* EC turns on w/ pp900_pll_en */
> -	pp900_pll: pp900-ap {
> -	};
> -
> -	/* EC turns on w/ pp900_pmu_en */
> -	pp900_pmu: pp900-ap {
> -	};
> -
> -	/* EC turns on w/ pp1800_s0_en_l */
> -	pp1800_ap_io: pp1800_emmc: pp1800_nfc: pp1800_s0: pp1800 {
> -	};
> -
> -	/* EC turns on w/ pp1800_avdd_en_l */
> -	pp1800_avdd: pp1800 {
> -	};
> -
> -	/* EC turns on w/ pp1800_lid_en_l */
> -	pp1800_lid: pp1800_mic: pp1800 {
> -	};
> -
> -	/* EC turns on w/ lpddr_pwr_en */
> -	pp1800_lpddr: pp1800 {
> -	};
> -
> -	/* EC turns on w/ pp1800_pmu_en_l */
> -	pp1800_pmu: pp1800 {
> -	};
> -
> -	/* EC turns on w/ pp1800_usb_en_l */
> -	pp1800_usb: pp1800 {
> -	};
> -
> -	pp3000_sd_slot: pp3000-sd-slot {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pp3000_sd_slot";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sd_slot_pwr_en>;
> -
> -		enable-active-high;
> -		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> -
> -		vin-supply = <&pp3000>;
> -	};
> -
> -	/*
> -	 * Technically, this is a small abuse of 'regulator-gpio'; this
> -	 * regulator is a mux between pp1800 and pp3300. pp1800 and pp3300 are
> -	 * always on though, so it is sufficient to simply control the mux
> -	 * here.
> -	 */
> -	ppvar_sd_card_io: ppvar-sd-card-io {
> -		compatible = "regulator-gpio";
> -		regulator-name = "ppvar_sd_card_io";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sd_io_pwr_en &sd_pwr_1800_sel>;
> -
> -		enable-active-high;
> -		enable-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
> -		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> -		states = <1800000 0x1>,
> -			 <3000000 0x0>;
> -
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <3000000>;
> -	};
> -
> -	/* EC turns on w/ pp3300_trackpad_en_l */
> -	pp3300_trackpad: pp3300-trackpad {
> -	};
> -
> -	/* EC turns on w/ usb_a_en */
> -	pp5000_usb_a_vbus: pp5000 {
> -	};
> -
> -	ap_rtc_clk: ap-rtc-clk {
> -		compatible = "fixed-clock";
> -		clock-frequency = <32768>;
> -		clock-output-names = "xin32k";
> -		#clock-cells = <0>;
> -	};
> -
> -	max98357a: max98357a {
> -		compatible = "maxim,max98357a";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmode_en>;
> -		sdmode-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> -		sdmode-delay = <2>;
> -		#sound-dai-cells = <0>;
> -		status = "okay";
> -	};
> -
> -	sound: sound {
> -		compatible = "rockchip,rk3399-gru-sound";
> -		rockchip,cpu = <&i2s0 &spdif>;
> -	};
> -};
> -
> -&cdn_dp {
> -	status = "okay";
> -};
> -
> -/*
> - * Set some suspend operating points to avoid OVP in suspend
> - *
> - * When we go into S3 ARM Trusted Firmware will transition our PWM regulators
> - * from wherever they're at back to the "default" operating point (whatever
> - * voltage we get when we set the PWM pins to "input").
> - *
> - * This quick transition under light load has the possibility to trigger the
> - * regulator "over voltage protection" (OVP).
> - *
> - * To make extra certain that we don't hit this OVP at suspend time, we'll
> - * transition to a voltage that's much closer to the default (~1.0 V) so that
> - * there will not be a big jump.  Technically we only need to get within 200 mV
> - * of the default voltage, but the speed here should be fast enough and we need
> - * suspend/resume to be rock solid.
> - */
> -
> -&cluster0_opp {
> -	opp05 {
> -		opp-suspend;
> -	};
> -};
> -
> -&cluster1_opp {
> -	opp06 {
> -		opp-suspend;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&ppvar_litcpu>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&ppvar_litcpu>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&ppvar_litcpu>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&ppvar_litcpu>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&ppvar_bigcpu>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&ppvar_bigcpu>;
> -};
> -
> -
> -&cru {
> -	assigned-clocks =
> -		<&cru PLL_GPLL>, <&cru PLL_CPLL>,
> -		<&cru PLL_NPLL>,
> -		<&cru ACLK_PERIHP>, <&cru HCLK_PERIHP>,
> -		<&cru PCLK_PERIHP>,
> -		<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
> -		<&cru PCLK_PERILP0>, <&cru ACLK_CCI>,
> -		<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>,
> -		<&cru ACLK_VIO>, <&cru ACLK_HDCP>,
> -		<&cru ACLK_GIC_PRE>,
> -		<&cru PCLK_DDR>;
> -	assigned-clock-rates =
> -		<600000000>, <800000000>,
> -		<1000000000>,
> -		<150000000>, <75000000>,
> -		<37500000>,
> -		<100000000>, <100000000>,
> -		<50000000>, <800000000>,
> -		<100000000>, <50000000>,
> -		<400000000>, <400000000>,
> -		<200000000>,
> -		<200000000>;
> -};
> -
> -&dfi {
> -	status = "okay";
> -};
> -
> -&dmc {
> -	status = "okay";
> -
> -	rockchip,pd-idle-ns = <160>;
> -	rockchip,sr-idle-ns = <10240>;
> -	rockchip,sr-mc-gate-idle-ns = <40960>;
> -	rockchip,srpd-lite-idle-ns = <61440>;
> -	rockchip,standby-idle-ns = <81920>;
> -
> -	rockchip,ddr3_odt_dis_freq = <666000000>;
> -	rockchip,lpddr3_odt_dis_freq = <666000000>;
> -	rockchip,lpddr4_odt_dis_freq = <666000000>;
> -
> -	rockchip,sr-mc-gate-idle-dis-freq-hz = <1000000000>;
> -	rockchip,srpd-lite-idle-dis-freq-hz = <0>;
> -	rockchip,standby-idle-dis-freq-hz = <928000000>;
> -};
> -
> -&dmc_opp_table {
> -	opp03 {
> -		opp-suspend;
> -	};
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&ppvar_gpu>;
> -	status = "okay";
> -};
> -
> -ap_i2c_ts: &i2c3 {
> -	status = "okay";
> -
> -	clock-frequency = <400000>;
> -
> -	/* These are relatively safe rise/fall times */
> -	i2c-scl-falling-time-ns = <50>;
> -	i2c-scl-rising-time-ns = <300>;
> -};
> -
> -ap_i2c_audio: &i2c8 {
> -	status = "okay";
> -
> -	clock-frequency = <400000>;
> -
> -	/* These are relatively safe rise/fall times */
> -	i2c-scl-falling-time-ns = <50>;
> -	i2c-scl-rising-time-ns = <300>;
> -
> -	codec: da7219@1a {
> -		compatible = "dlg,da7219";
> -		reg = <0x1a>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&cru SCLK_I2S_8CH_OUT>;
> -		clock-names = "mclk";
> -		dlg,micbias-lvl = <2600>;
> -		dlg,mic-amp-in-sel = "diff";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&headset_int_l>;
> -		VDD-supply = <&pp1800>;
> -		VDDMIC-supply = <&pp3300>;
> -		VDDIO-supply = <&pp1800>;
> -
> -		da7219_aad {
> -			dlg,adc-1bit-rpt = <1>;
> -			dlg,btn-avg = <4>;
> -			dlg,btn-cfg = <50>;
> -			dlg,mic-det-thr = <500>;
> -			dlg,jack-ins-deb = <20>;
> -			dlg,jack-det-rate = "32ms_64ms";
> -			dlg,jack-rem-deb = <1>;
> -
> -			dlg,a-d-btn-thr = <0xa>;
> -			dlg,d-b-btn-thr = <0x16>;
> -			dlg,b-c-btn-thr = <0x21>;
> -			dlg,c-mic-btn-thr = <0x3E>;
> -		};
> -	};
> -};
> -
> -&i2s0 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	status = "okay";
> -
> -	audio-supply = <&pp1800_audio>;		/* APIO5_VDD;  3d 4a */
> -	bt656-supply = <&pp1800_ap_io>;		/* APIO2_VDD;  2a 2b */
> -	gpio1830-supply = <&pp3000_ap>;		/* APIO4_VDD;  4c 4d */
> -	sdmmc-supply = <&ppvar_sd_card_io>;	/* SDMMC0_VDD; 4b    */
> -};
> -
> -&pcie0 {
> -	status = "okay";
> -
> -	ep-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wifi_perst_l>;
> -	vpcie3v3-supply = <&pp3300_wifi_bt>;
> -	vpcie1v8-supply = <&wlan_pd_n>; /* HACK: see &wlan_pd_n */
> -	vpcie0v9-supply = <&pp900_pcie>;
> -
> -	pci_rootport: pcie@0,0 {
> -		reg = <0x0000 0 0 0 0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		ranges;
> -		device_type = "pci";
> -	};
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	status = "okay";
> -
> -	pmu1830-supply = <&pp1800_pmu>;		/* PMUIO2_VDD */
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&pwm3 {
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	/*
> -	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
> -	 * same (or nearly the same) performance for all eMMC that are intended
> -	 * to be used.
> -	 */
> -	assigned-clock-rates = <150000000>;
> -
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	status = "okay";
> -
> -	/*
> -	 * Note: configure "sdmmc_cd" as card detect even though it's actually
> -	 * hooked to ground.  Because we specified "cd-gpios" below dw_mmc
> -	 * should be ignoring card detect anyway.  Specifying the pin as
> -	 * sdmmc_cd means that even if you've got GRF_SOC_CON7[12] (force_jtag)
> -	 * turned on that the system will still make sure the port is
> -	 * configured as SDMMC and not JTAG.
> -	 */
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_cd_pin
> -		     &sdmmc_bus4>;
> -
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr50;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&pp3000_sd_slot>;
> -	vqmmc-supply = <&ppvar_sd_card_io>;
> -};
> -
> -&spdif {
> -	status = "okay";
> -
> -	/*
> -	 * SPDIF is routed internally to DP; we either don't use these pins, or
> -	 * mux them to something else.
> -	 */
> -	/delete-property/ pinctrl-0;
> -	/delete-property/ pinctrl-names;
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	pinctrl-names = "default", "sleep";
> -	pinctrl-1 = <&spi1_sleep>;
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -
> -		/* May run faster once verified. */
> -		spi-max-frequency = <10000000>;
> -	};
> -};
> -
> -&spi2 {
> -	status = "okay";
> -};
> -
> -&spi5 {
> -	status = "okay";
> -
> -	cros_ec: ec@0 {
> -		compatible = "google,cros-ec-spi";
> -		reg = <0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ec_ap_int_l>;
> -		spi-max-frequency = <3000000>;
> -
> -		i2c_tunnel: i2c-tunnel {
> -			compatible = "google,cros-ec-i2c-tunnel";
> -			google,remote-bus = <4>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -
> -		usbc_extcon0: extcon0 {
> -			compatible = "google,extcon-usbc-cros-ec";
> -			google,usb-port-id = <0>;
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -
> -	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -	extcon = <&usbc_extcon0>;
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&u2phy0_host {
> -	status = "okay";
> -};
> -
> -&u2phy1_host {
> -	status = "okay";
> -};
> -
> -&u2phy0_otg {
> -	status = "okay";
> -};
> -
> -&u2phy1_otg {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -	extcon = <&usbc_extcon0>;
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> -
> -#include <cros-ec-keyboard.dtsi>
> -#include <cros-ec-sbs.dtsi>
> -
> -&pinctrl {
> -	/*
> -	 * pinctrl settings for pins that have no real owners.
> -	 *
> -	 * At the moment settings are identical for S0 and S3, but if we later
> -	 * need to configure things differently for S3 we'll adjust here.
> -	 */
> -	pinctrl-names = "default";
> -	pinctrl-0 = <
> -		&ap_pwroff	/* AP will auto-assert this when in S3 */
> -		&clk_32k	/* This pin is always 32k on gru boards */
> -	>;
> -
> -	pcfg_output_low: pcfg-output-low {
> -		output-low;
> -	};
> -
> -	pcfg_output_high: pcfg-output-high {
> -		output-high;
> -	};
> -
> -	pcfg_pull_none_8ma: pcfg-pull-none-8ma {
> -		bias-disable;
> -		drive-strength = <8>;
> -	};
> -
> -	backlight-enable {
> -		bl_en: bl-en {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	cros-ec {
> -		ec_ap_int_l: ec-ap-int-l {
> -			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	discrete-regulators {
> -		sd_io_pwr_en: sd-io-pwr-en {
> -			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO
> -					 &pcfg_pull_none>;
> -		};
> -
> -		sd_pwr_1800_sel: sd-pwr-1800-sel {
> -			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO
> -					 &pcfg_pull_none>;
> -		};
> -
> -		sd_slot_pwr_en: sd-slot-pwr-en {
> -			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO
> -					 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	codec {
> -		/* Has external pullup */
> -		headset_int_l: headset-int-l {
> -			rockchip,pins = <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		mic_int: mic-int {
> -			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	max98357a {
> -		sdmode_en: sdmode-en {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_clkreqn_cpm: pci-clkreqn-cpm {
> -			/*
> -			 * Since our pcie doesn't support ClockPM(CPM), we want
> -			 * to hack this as gpio, so the EP could be able to
> -			 * de-assert it along and make ClockPM(CPM) work.
> -			 */
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdmmc {
> -		/*
> -		 * We run sdmmc at max speed; bump up drive strength.
> -		 * We also have external pulls, so disable the internal ones.
> -		 */
> -		sdmmc_bus4: sdmmc-bus4 {
> -			rockchip,pins =
> -				<4 RK_PB0 1 &pcfg_pull_none_8ma>,
> -				<4 RK_PB1 1 &pcfg_pull_none_8ma>,
> -				<4 RK_PB2 1 &pcfg_pull_none_8ma>,
> -				<4 RK_PB3 1 &pcfg_pull_none_8ma>;
> -		};
> -
> -		sdmmc_clk: sdmmc-clk {
> -			rockchip,pins =
> -				<4 RK_PB4 1 &pcfg_pull_none_8ma>;
> -		};
> -
> -		sdmmc_cmd: sdmmc-cmd {
> -			rockchip,pins =
> -				<4 RK_PB5 1 &pcfg_pull_none_8ma>;
> -		};
> -
> -		/*
> -		 * In our case the official card detect is hooked to ground
> -		 * to avoid getting access to JTAG just by sticking something
> -		 * in the SD card slot (see the force_jtag bit in the TRM).
> -		 *
> -		 * We still configure it as card detect because it doesn't
> -		 * hurt and dw_mmc will ignore it.  We make sure to disable
> -		 * the pull though so we don't burn needless power.
> -		 */
> -		sdmmc_cd: sdmmc-cd {
> -			rockchip,pins =
> -				<0 RK_PA7 1 &pcfg_pull_none>;
> -		};
> -
> -		/* This is where we actually hook up CD; has external pull */
> -		sdmmc_cd_pin: sdmmc-cd-pin {
> -			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	spi1 {
> -		spi1_sleep: spi1-sleep {
> -			/*
> -			 * Pull down SPI1 CLK/CS/RX/TX during suspend, to
> -			 * prevent leakage.
> -			 */
> -			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>,
> -					<1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_down>,
> -					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>,
> -					<1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	touchscreen {
> -		touch_int_l: touch-int-l {
> -			rockchip,pins = <3 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		touch_reset_l: touch-reset-l {
> -			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	trackpad {
> -		ap_i2c_tp_pu_en: ap-i2c-tp-pu-en {
> -			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_output_high>;
> -		};
> -
> -		trackpad_int_l: trackpad-int-l {
> -			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	wifi: wifi {
> -		wlan_module_reset_l: wlan-module-reset-l {
> -			rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			/* Kevin has an external pull up, but Gru does not */
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	write-protect {
> -		ap_fw_wp: ap-fw-wp {
> -			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-khadas-edge-captain.dts b/arch/arm/dts/rk3399-khadas-edge-captain.dts
> deleted file mode 100644
> index 99ac4ed0f13f..000000000000
> --- a/arch/arm/dts/rk3399-khadas-edge-captain.dts
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> - * (https://www.khadas.com)
> - */
> -
> -/dts-v1/;
> -#include "rk3399-khadas-edge.dtsi"
> -
> -/ {
> -	model = "Khadas Edge-Captain";
> -	compatible = "khadas,edge-captain", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -	};
> -};
> -
> -&gmac {
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-khadas-edge-v.dts b/arch/arm/dts/rk3399-khadas-edge-v.dts
> deleted file mode 100644
> index e12e7b4d64ca..000000000000
> --- a/arch/arm/dts/rk3399-khadas-edge-v.dts
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> - * (https://www.khadas.com)
> - */
> -
> -/dts-v1/;
> -#include "rk3399-khadas-edge.dtsi"
> -
> -/ {
> -	model = "Khadas Edge-V";
> -	compatible = "khadas,edge-v", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -	};
> -};
> -
> -&gmac {
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-khadas-edge.dts b/arch/arm/dts/rk3399-khadas-edge.dts
> deleted file mode 100644
> index 31616e7ad89d..000000000000
> --- a/arch/arm/dts/rk3399-khadas-edge.dts
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> - * (https://www.khadas.com)
> - */
> -
> -/dts-v1/;
> -#include "rk3399-khadas-edge.dtsi"
> -
> -/ {
> -	model = "Khadas Edge";
> -	compatible = "khadas,edge", "rockchip,rk3399";
> -};
> diff --git a/arch/arm/dts/rk3399-khadas-edge.dtsi b/arch/arm/dts/rk3399-khadas-edge.dtsi
> deleted file mode 100644
> index 9d9297bc5f04..000000000000
> --- a/arch/arm/dts/rk3399-khadas-edge.dtsi
> +++ /dev/null
> @@ -1,837 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> - * (https://www.khadas.com)
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	aliases {
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -
> -		/*
> -		 * On the module itself this is one of these (depending
> -		 * on the actual card populated):
> -		 * - SDIO_RESET_L_WL_REG_ON
> -		 * - PDN (power down when low)
> -		 */
> -		reset-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	vcc3v3_pcie: vcc3v3-pcie-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_pcie";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vsys_3v3>;
> -	};
> -
> -	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		vin-supply = <&vsys_5v0>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vsys_3v3>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -	};
> -
> -	vsys: vsys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vsys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vsys_3v3: vsys-3v3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vsys_3v3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vsys>;
> -	};
> -
> -	vsys_5v0: vsys-5v0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vsys_5v0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vsys>;
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "Recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <18000>;
> -		};
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn>;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
> -		linux,rc-map-name = "rc-khadas";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ir_rx>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sys_led_pin>, <&user_led_pin>;
> -
> -		sys_led: led-0 {
> -			label = "sys_led";
> -			linux,default-trigger = "heartbeat";
> -			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		user_led: led-1 {
> -			label = "user_led";
> -			default-state = "off";
> -			gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		cooling-levels = <0 150 200 255>;
> -		#cooling-cells = <2>;
> -		fan-supply = <&vsys_5v0>;
> -		pwms = <&pwm0 0 40000 0>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_thermal {
> -	trips {
> -		cpu_warm: cpu_warm {
> -			temperature = <55000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -
> -		cpu_hot: cpu_hot {
> -			temperature = <65000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -	};
> -
> -	cooling-maps {
> -		map2 {
> -			trip = <&cpu_warm>;
> -			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> -		};
> -
> -		map3 {
> -			trip = <&cpu_hot>;
> -			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> -		};
> -	};
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&gpu_thermal {
> -	trips {
> -		gpu_warm: gpu_warm {
> -			temperature = <55000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -
> -		gpu_hot: gpu_hot {
> -			temperature = <65000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -	};
> -
> -	cooling-maps {
> -		map1 {
> -			trip = <&gpu_warm>;
> -			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> -		};
> -
> -		map2 {
> -			trip = <&gpu_hot>;
> -			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> -		};
> -	};
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vsys_3v3>;
> -		vcc2-supply = <&vsys_3v3>;
> -		vcc3-supply = <&vsys_3v3>;
> -		vcc4-supply = <&vsys_3v3>;
> -		vcc6-supply = <&vsys_3v3>;
> -		vcc7-supply = <&vsys_3v3>;
> -		vcc8-supply = <&vsys_3v3>;
> -		vcc9-supply = <&vsys_3v3>;
> -		vcc10-supply = <&vsys_3v3>;
> -		vcc11-supply = <&vsys_3v3>;
> -		vcc12-supply = <&vsys_3v3>;
> -		vddio-supply = <&vcc_1v8>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_apio2: LDO_REG1 {
> -				regulator-name = "vcc1v8_apio2";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_vldo2: LDO_REG2 {
> -				regulator-name = "vcc_vldo2";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmupll: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmupll";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG4 {
> -				regulator-name = "vccio_sd";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc_vldo5: LDO_REG5 {
> -				regulator-name = "vcc_vldo5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcc1v8_codec: LDO_REG7 {
> -				regulator-name = "vcc1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cpu_b_sleep>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vsys_3v3>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gpu_sleep>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vsys_3v3>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c8 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <160>;
> -	i2c-scl-falling-time-ns = <30>;
> -	status = "okay";
> -};
> -
> -&i2s0 {
> -	rockchip,playback-channels = <8>;
> -	rockchip,capture-channels = <8>;
> -	status = "okay";
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	bt656-supply = <&vcc1v8_apio2>;
> -	audio-supply = <&vcc1v8_codec>;
> -	sdmmc-supply = <&vccio_sd>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_1v8>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	bt {
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_reg_on_h: bt-reg-on-h {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	buttons {
> -		pwrbtn: pwrbtn {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	ir {
> -		ir_rx: ir-rx {
> -		    rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		sys_led_pin: sys-led-pin {
> -			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led_pin: user-led-pin {
> -			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		cpu_b_sleep: cpu-b-sleep {
> -			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		gpu_sleep: gpu-sleep {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	/* WiFi & BT combo module Ampak AP6356S */
> -	bus-width = <4>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	vqmmc-supply = <&vcc1v8_s3>;
> -	vmmc-supply = <&vccio_sd>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		reg = <1>;
> -		compatible = "brcm,bcm4329-fmac";
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		brcm,drive-strength = <5>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	spiflash: flash@0 {
> -		compatible = "winbond,w25q128fw", "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <104000000>;
> -	};
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_rts &uart0_cts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		max-speed = <4000000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
> -		vbat-supply = <&vsys_3v3>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "otg";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-leez-p710.dts b/arch/arm/dts/rk3399-leez-p710.dts
> deleted file mode 100644
> index cb69e2145fa9..000000000000
> --- a/arch/arm/dts/rk3399-leez-p710.dts
> +++ /dev/null
> @@ -1,653 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Andy Yan <andy.yan@gmail.com>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Leez RK3399 P710";
> -	compatible = "leez,p710", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_reg_on_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	dc5v_adp: dc5v-adp {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc5v_adapter";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc3v3_lan: vcc3v3-lan {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_lan";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_host0: vcc5v0_host1: vcc5v0-host {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5500000>;
> -		regulator-max-microvolt = <5500000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_host3: vcc5v0-host3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_host3";
> -		enable-active-high;
> -		gpio = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host3_en>;
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc5v_adp>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc5v0_sys>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc3v3_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c7>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc5v0_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_hdmi: LDO_REG2 {
> -				regulator-name = "vcc1v8_hdmi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcca_1v8: LDO_REG3 {
> -				regulator-name = "vcca_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG4 {
> -				regulator-name = "vccio_sd";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcc0v9_hdmi: LDO_REG7 {
> -				regulator-name = "vcc0v9_hdmi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <300>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -};
> -
> -&i2s0 {
> -	rockchip,playback-channels = <8>;
> -	rockchip,capture-channels = <8>;
> -	status = "okay";
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	status = "okay";
> -
> -	bt656-supply = <&vcc1v8_dvp>;
> -	audio-supply = <&vcc_1v8>;
> -	sdmmc-supply = <&vccio_sd>;
> -	gpio1830-supply = <&vcc_3v0>;
> -};
> -
> -&pmu_io_domains {
> -	status = "okay";
> -	pmu1830-supply = <&vcc_3v0>;
> -};
> -
> -&pinctrl {
> -	bt {
> -		bt_reg_on_h: bt-reg-on-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host3_en: vcc5v0-host3-en {
> -			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_reg_on_h: wifi-reg-on-h {
> -			rockchip,pins =
> -				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	status = "okay";
> -
> -	vref-supply = <&vcc_1v8>;
> -};
> -
> -&sdio0 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	bus-width = <4>;
> -	clock-frequency = <50000000>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cd &sdmmc_cmd &sdmmc_bus4>;
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	status = "okay";
> -
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host0>;
> -		status = "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host1>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_reg_on_h>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "otg";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-nanopc-t4.dts b/arch/arm/dts/rk3399-nanopc-t4.dts
> deleted file mode 100644
> index 3bf8f959e42c..000000000000
> --- a/arch/arm/dts/rk3399-nanopc-t4.dts
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * FriendlyElec NanoPC-T4 board device tree source
> - *
> - * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> - * (http://www.friendlyarm.com)
> - *
> - * Copyright (c) 2018 Collabora Ltd.
> - */
> -
> -/dts-v1/;
> -#include "rk3399-nanopi4.dtsi"
> -
> -/ {
> -	model = "FriendlyElec NanoPC-T4";
> -	compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
> -
> -	vcc12v0_sys: vcc12v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-max-microvolt = <12000000>;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-name = "vcc12v0_sys";
> -	};
> -
> -	vcc5v0_host0: vcc5v0-host0 {
> -		compatible = "regulator-fixed";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-name = "vcc5v0_host0";
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "Recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <18000>;
> -		};
> -	};
> -
> -	ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ir_rx>;
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		/*
> -		 * With 20KHz PWM and an EVERCOOL EC4007H12SA fan, these levels
> -		 * work out to 0, ~1200, ~3000, and 5000RPM respectively.
> -		 */
> -		cooling-levels = <0 12 18 255>;
> -		#cooling-cells = <2>;
> -		fan-supply = <&vcc12v0_sys>;
> -		pwms = <&pwm1 0 50000 0>;
> -	};
> -};
> -
> -&cpu_thermal {
> -	trips {
> -		cpu_warm: cpu_warm {
> -			temperature = <55000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -
> -		cpu_hot: cpu_hot {
> -			temperature = <65000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -	};
> -
> -	cooling-maps {
> -		map2 {
> -			trip = <&cpu_warm>;
> -			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> -		};
> -
> -		map3 {
> -			trip = <&cpu_hot>;
> -			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> -		};
> -	};
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	vpcie3v3-supply = <&vcc3v3_sys>;
> -};
> -
> -&pinctrl {
> -	ir {
> -		ir_rx: ir-rx {
> -			/* external pullup to VCC3V3_SYS, despite being 1.8V :/ */
> -			rockchip,pins = <0 RK_PA6 1 &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&sdhci {
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_host0>;
> -};
> -
> -&u2phy1_host {
> -	phy-supply = <&vcc5v0_host0>;
> -};
> -
> -&vcc5v0_sys {
> -	vin-supply = <&vcc12v0_sys>;
> -};
> -
> -&vcc3v3_sys {
> -	vin-supply = <&vcc12v0_sys>;
> -};
> -
> -&vbus_typec {
> -	enable-active-high;
> -	gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> -	vin-supply = <&vcc5v0_sys>;
> -};
> diff --git a/arch/arm/dts/rk3399-nanopi-m4.dts b/arch/arm/dts/rk3399-nanopi-m4.dts
> deleted file mode 100644
> index 60358ab8c7df..000000000000
> --- a/arch/arm/dts/rk3399-nanopi-m4.dts
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * FriendlyElec NanoPi M4 board device tree source
> - *
> - * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> - * (http://www.friendlyarm.com)
> - *
> - * Copyright (c) 2018 Collabora Ltd.
> - * Copyright (c) 2019 Arm Ltd.
> - */
> -
> -/dts-v1/;
> -#include "rk3399-nanopi4.dtsi"
> -
> -/ {
> -	model = "FriendlyElec NanoPi M4";
> -	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
> -
> -	vdd_5v: vdd-5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdd_5v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc5v0_core: vcc5v0-core {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_core";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vdd_5v>;
> -	};
> -
> -	vcc5v0_usb1: vcc5v0-usb1 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb1";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_usb2: vcc5v0-usb2 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb2";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&vcc3v3_sys {
> -	vin-supply = <&vcc5v0_core>;
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_usb1>;
> -};
> -
> -&u2phy1_host {
> -	phy-supply = <&vcc5v0_usb2>;
> -};
> -
> -&vbus_typec {
> -	regulator-always-on;
> -	vin-supply = <&vdd_5v>;
> -};
> diff --git a/arch/arm/dts/rk3399-nanopi-m4b.dts b/arch/arm/dts/rk3399-nanopi-m4b.dts
> deleted file mode 100644
> index 65cb21837b0c..000000000000
> --- a/arch/arm/dts/rk3399-nanopi-m4b.dts
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * FriendlyElec NanoPi M4B board device tree source
> - *
> - * Copyright (c) 2020 Chen-Yu Tsai <wens@csie.org>
> - */
> -
> -/dts-v1/;
> -#include "rk3399-nanopi-m4.dts"
> -
> -/ {
> -	model = "FriendlyElec NanoPi M4B";
> -	compatible = "friendlyarm,nanopi-m4b", "rockchip,rk3399";
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1500000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "Recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <18000>;
> -		};
> -	};
> -};
> -
> -/* No USB type-C PD power manager */
> -/delete-node/ &fusb0;
> -
> -&i2c4 {
> -	status = "disabled";
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_usb2>;
> -};
> -
> -&u2phy0_otg {
> -	phy-supply = <&vbus_typec>;
> -};
> -
> -&u2phy1_otg {
> -	phy-supply = <&vcc5v0_usb1>;
> -};
> -
> -&vbus_typec {
> -	enable-active-high;
> -	gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> -};
> diff --git a/arch/arm/dts/rk3399-nanopi-neo4.dts b/arch/arm/dts/rk3399-nanopi-neo4.dts
> deleted file mode 100644
> index 195410b089b9..000000000000
> --- a/arch/arm/dts/rk3399-nanopi-neo4.dts
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (C) 2019 Amarula Solutions B.V.
> - * Author: Jagan Teki <jagan@amarulasolutions.com>
> - */
> -
> -/dts-v1/;
> -
> -#include "rk3399-nanopi4.dtsi"
> -
> -/ {
> -	model = "FriendlyARM NanoPi NEO4";
> -	compatible = "friendlyarm,nanopi-neo4", "rockchip,rk3399";
> -
> -	vdd_5v: vdd-5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdd_5v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc5v0_core: vcc5v0-core {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_core";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vdd_5v>;
> -	};
> -
> -	vcc5v0_usb1: vcc5v0-usb1 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb1";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&vcc3v3_sys {
> -	vin-supply = <&vcc5v0_core>;
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_usb1>;
> -};
> -
> -&vbus_typec {
> -	regulator-always-on;
> -	vin-supply = <&vdd_5v>;
> -};
> diff --git a/arch/arm/dts/rk3399-nanopi-r4s.dts b/arch/arm/dts/rk3399-nanopi-r4s.dts
> deleted file mode 100644
> index fe5b52610010..000000000000
> --- a/arch/arm/dts/rk3399-nanopi-r4s.dts
> +++ /dev/null
> @@ -1,133 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * FriendlyElec NanoPC-T4 board device tree source
> - *
> - * Copyright (c) 2020 FriendlyElec Computer Tech. Co., Ltd.
> - * (http://www.friendlyarm.com)
> - *
> - * Copyright (c) 2018 Collabora Ltd.
> - *
> - * Copyright (c) 2020 Jensen Huang <jensenhuang@friendlyarm.com>
> - * Copyright (c) 2020 Marty Jones <mj8263788@gmail.com>
> - * Copyright (c) 2021 Tianling Shen <cnsztl@gmail.com>
> - */
> -
> -/dts-v1/;
> -#include "rk3399-nanopi4.dtsi"
> -
> -/ {
> -	model = "FriendlyElec NanoPi R4S";
> -	compatible = "friendlyarm,nanopi-r4s", "rockchip,rk3399";
> -
> -	/delete-node/ display-subsystem;
> -
> -	gpio-leds {
> -		pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
> -
> -		/delete-node/ led-0;
> -
> -		lan_led: led-lan {
> -			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> -			label = "green:lan";
> -		};
> -
> -		sys_led: led-sys {
> -			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> -			label = "red:power";
> -			default-state = "on";
> -		};
> -
> -		wan_led: led-wan {
> -			gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> -			label = "green:wan";
> -		};
> -	};
> -
> -	gpio-keys {
> -		pinctrl-0 = <&reset_button_pin>;
> -
> -		/delete-node/ key-power;
> -
> -		key-reset {
> -			debounce-interval = <50>;
> -			gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
> -			label = "reset";
> -			linux,code = <KEY_RESTART>;
> -		};
> -	};
> -
> -	vdd_5v: vdd-5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdd_5v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&emmc_phy {
> -	status = "disabled";
> -};
> -
> -&i2c4 {
> -	status = "disabled";
> -};
> -
> -&pcie0 {
> -	max-link-speed = <1>;
> -	num-lanes = <1>;
> -	vpcie3v3-supply = <&vcc3v3_sys>;
> -};
> -
> -&pinctrl {
> -	gpio-leds {
> -		/delete-node/ status-led-pin;
> -
> -		lan_led_pin: lan-led-pin {
> -			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		sys_led_pin: sys-led-pin {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wan_led_pin: wan-led-pin {
> -			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	rockchip-key {
> -		/delete-node/ power-key;
> -
> -		reset_button_pin: reset-button-pin {
> -			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&sdhci {
> -	status = "disabled";
> -};
> -
> -&sdio0 {
> -	status = "disabled";
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vdd_5v>;
> -};
> -
> -&u2phy1_host {
> -	status = "disabled";
> -};
> -
> -&uart0 {
> -	status = "disabled";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	dr_mode = "host";
> -};
> -
> -&vcc3v3_sys {
> -	vin-supply = <&vcc5v0_sys>;
> -};
> diff --git a/arch/arm/dts/rk3399-nanopi4.dtsi b/arch/arm/dts/rk3399-nanopi4.dtsi
> deleted file mode 100644
> index b7f1e47978a6..000000000000
> --- a/arch/arm/dts/rk3399-nanopi4.dtsi
> +++ /dev/null
> @@ -1,762 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * RK3399-based FriendlyElec boards device tree source
> - *
> - * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> - *
> - * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> - * (http://www.friendlyarm.com)
> - *
> - * Copyright (c) 2018 Collabora Ltd.
> - * Copyright (c) 2019 Arm Ltd.
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-name = "vcc3v3_sys";
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-name = "vcc5v0_sys";
> -		vin-supply = <&vdd_5v>;
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		regulator-name = "vcc1v8_s3";
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	vcc3v0_sd: vcc3v0-sd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc0_pwr_h>;
> -		regulator-always-on;
> -		regulator-min-microvolt = <3000000>;
> -		regulator-max-microvolt = <3000000>;
> -		regulator-name = "vcc3v0_sd";
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	/*
> -	 * Really, this is supplied by vcc_1v8, and vcc1v8_s3 only
> -	 * drives the enable pin, but we can't quite model that.
> -	 */
> -	vcca0v9_s3: vcca0v9-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -		regulator-name = "vcca0v9_s3";
> -		vin-supply = <&vcc1v8_s3>;
> -	};
> -
> -	/* As above, actually supplied by vcc3v3_sys */
> -	vcca1v8_s3: vcca1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		regulator-name = "vcca1v8_s3";
> -		vin-supply = <&vcc1v8_s3>;
> -	};
> -
> -	vbus_typec: vbus-typec {
> -		compatible = "regulator-fixed";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-name = "vbus_typec";
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&power_key>;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	leds: gpio-leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&status_led_pin>;
> -
> -		status_led: led-0 {
> -			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> -			label = "status_led";
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_reg_on_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&emmc_phy {
> -	rockchip,enable-strobe-pulldown;
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clock-parents = <&clkin_gmac>;
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	clock_in_out = "input";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>, <&phy_intb>, <&phy_rstb>;
> -	phy-handle = <&rtl8211e>;
> -	phy-mode = "rgmii";
> -	phy-supply = <&vcc3v3_s3>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -
> -	mdio {
> -		compatible = "snps,dwmac-mdio";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rtl8211e: ethernet-phy@1 {
> -			reg = <1>;
> -			interrupt-parent = <&gpio3>;
> -			interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
> -			reset-assert-us = <10000>;
> -			reset-deassert-us = <30000>;
> -			reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -		};
> -	};
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c7>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <160>;
> -	i2c-scl-falling-time-ns = <30>;
> -	status = "okay";
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cpu_b_sleep>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-ramp-delay = <1000>;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gpu_sleep>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-name = "vdd_gpu";
> -		regulator-ramp-delay = <1000>;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		clock-output-names = "xin32k", "rtc_clko_wifi";
> -		#clock-cells = <1>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>, <&ap_pwroff>, <&clk_32k>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc3v3_sys>;
> -		vcc2-supply = <&vcc3v3_sys>;
> -		vcc3-supply = <&vcc3v3_sys>;
> -		vcc4-supply = <&vcc3v3_sys>;
> -		vcc6-supply = <&vcc3v3_sys>;
> -		vcc7-supply = <&vcc3v3_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc3v3_sys>;
> -		vcc10-supply = <&vcc3v3_sys>;
> -		vcc11-supply = <&vcc3v3_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_3v0>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-name = "vdd_center";
> -				regulator-ramp-delay = <6001>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-name = "vdd_cpu_l";
> -				regulator-ramp-delay = <6001>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc_ddr";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_cam: LDO_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc1v8_cam";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v0_touch: LDO_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "vcc3v0_touch";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmupll: LDO_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc1v8_pmupll";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_sdio";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "vcca3v0_codec";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-name = "vcc_1v5";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcca1v8_codec";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "vcc_3v0";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: SWITCH_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc3v3_s3";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc3v3_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	clock-frequency = <200000>;
> -	i2c-scl-rising-time-ns = <150>;
> -	i2c-scl-falling-time-ns = <30>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <160>;
> -	i2c-scl-falling-time-ns = <30>;
> -	status = "okay";
> -
> -	fusb0: typec-portc@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb0_int>;
> -		vbus-supply = <&vbus_typec>;
> -	};
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	bt656-supply = <&vcc_1v8>;
> -	audio-supply = <&vcca1v8_codec>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
> -	assigned-clock-rates = <100000000>;
> -	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	num-lanes = <2>;
> -	vpcie0v9-supply = <&vcca0v9_s3>;
> -	vpcie1v8-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	fusb30x {
> -		fusb0_int: fusb0-int {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	gpio-leds {
> -		status_led_pin: status-led-pin {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	gmac {
> -		phy_intb: phy-intb {
> -			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		phy_rstb: phy-rstb {
> -			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		cpu_b_sleep: cpu-b-sleep {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		gpu_sleep: gpu-sleep {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	rockchip-key {
> -		power_key: power-key {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	sdio {
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_reg_on_h: bt-reg-on-h {
> -			/* external pullup to VCC1V8_PMUPLL */
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wifi_reg_on_h: wifi-reg_on-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdmmc {
> -		sdmmc0_det_l: sdmmc0-det-l {
> -			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		sdmmc0_pwr_h: sdmmc0-pwr-h {
> -			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	pinctrl-names = "active";
> -	pinctrl-0 = <&pwm2_pin_pull_down>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-mmc-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc0_det_l>;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc3v0_sd>;
> -	vqmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&u2phy0_host {
> -	status = "okay";
> -};
> -
> -&u2phy0_otg {
> -	status = "okay";
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -};
> -
> -&u2phy1_host {
> -	status = "okay";
> -};
> -
> -&u2phy1_otg {
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_rts &uart0_cts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		max-speed = <4000000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	dr_mode = "host";
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-op1-opp.dtsi b/arch/arm/dts/rk3399-op1-opp.dtsi
> deleted file mode 100644
> index 783120e9cebe..000000000000
> --- a/arch/arm/dts/rk3399-op1-opp.dtsi
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> - */
> -
> -/ {
> -	cluster0_opp: opp-table-0 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <800000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <825000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <850000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <900000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <975000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <1100000>;
> -		};
> -		opp06 {
> -			opp-hz = /bits/ 64 <1512000000>;
> -			opp-microvolt = <1150000>;
> -		};
> -	};
> -
> -	cluster1_opp: opp-table-1 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <800000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <800000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <825000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <850000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <900000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <975000>;
> -		};
> -		opp06 {
> -			opp-hz = /bits/ 64 <1608000000>;
> -			opp-microvolt = <1050000>;
> -		};
> -		opp07 {
> -			opp-hz = /bits/ 64 <1800000000>;
> -			opp-microvolt = <1150000>;
> -		};
> -		opp08 {
> -			opp-hz = /bits/ 64 <2016000000>;
> -			opp-microvolt = <1250000>;
> -		};
> -	};
> -
> -	gpu_opp_table: opp-table-2 {
> -		compatible = "operating-points-v2";
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <200000000>;
> -			opp-microvolt = <800000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <297000000>;
> -			opp-microvolt = <800000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <400000000>;
> -			opp-microvolt = <825000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <850000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <925000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <800000000>;
> -			opp-microvolt = <1075000>;
> -		};
> -	};
> -
> -	dmc_opp_table: opp-table-3 {
> -		compatible = "operating-points-v2";
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <400000000>;
> -			opp-microvolt = <900000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <666000000>;
> -			opp-microvolt = <900000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <800000000>;
> -			opp-microvolt = <900000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <928000000>;
> -			opp-microvolt = <925000>;
> -		};
> -	};
> -};
> -
> -&cpu_l0 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l1 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l2 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l3 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_b0 {
> -	operating-points-v2 = <&cluster1_opp>;
> -};
> -
> -&cpu_b1 {
> -	operating-points-v2 = <&cluster1_opp>;
> -};
> -
> -&dmc {
> -	operating-points-v2 = <&dmc_opp_table>;
> -};
> -
> -&gpu {
> -	operating-points-v2 = <&gpu_opp_table>;
> -};
> diff --git a/arch/arm/dts/rk3399-opp.dtsi b/arch/arm/dts/rk3399-opp.dtsi
> deleted file mode 100644
> index fee5e7111279..000000000000
> --- a/arch/arm/dts/rk3399-opp.dtsi
> +++ /dev/null
> @@ -1,133 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> - */
> -
> -/ {
> -	cluster0_opp: opp-table-0 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <825000 825000 1250000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <825000 825000 1250000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <850000 850000 1250000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <925000 925000 1250000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <1000000 1000000 1250000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <1125000 1125000 1250000>;
> -		};
> -	};
> -
> -	cluster1_opp: opp-table-1 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <825000 825000 1250000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <825000 825000 1250000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <825000 825000 1250000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <875000 875000 1250000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <950000 950000 1250000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <1025000 1025000 1250000>;
> -		};
> -		opp06 {
> -			opp-hz = /bits/ 64 <1608000000>;
> -			opp-microvolt = <1100000 1100000 1250000>;
> -		};
> -		opp07 {
> -			opp-hz = /bits/ 64 <1800000000>;
> -			opp-microvolt = <1200000 1200000 1250000>;
> -		};
> -	};
> -
> -	gpu_opp_table: opp-table-2 {
> -		compatible = "operating-points-v2";
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <200000000>;
> -			opp-microvolt = <825000 825000 1150000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <297000000>;
> -			opp-microvolt = <825000 825000 1150000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <400000000>;
> -			opp-microvolt = <825000 825000 1150000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <875000 875000 1150000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <925000 925000 1150000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <800000000>;
> -			opp-microvolt = <1100000 1100000 1150000>;
> -		};
> -	};
> -};
> -
> -&cpu_l0 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l1 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l2 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l3 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_b0 {
> -	operating-points-v2 = <&cluster1_opp>;
> -};
> -
> -&cpu_b1 {
> -	operating-points-v2 = <&cluster1_opp>;
> -};
> -
> -&gpu {
> -	operating-points-v2 = <&gpu_opp_table>;
> -};
> diff --git a/arch/arm/dts/rk3399-orangepi.dts b/arch/arm/dts/rk3399-orangepi.dts
> deleted file mode 100644
> index e7551449e718..000000000000
> --- a/arch/arm/dts/rk3399-orangepi.dts
> +++ /dev/null
> @@ -1,896 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> - */
> -
> -/dts-v1/;
> -
> -#include "dt-bindings/pwm/pwm.h"
> -#include "dt-bindings/input/input.h"
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include "dt-bindings/usb/pd.h"
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Orange Pi RK3399 Board";
> -	compatible = "rockchip,rk3399-orangepi", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-up {
> -			label = "Volume Up";
> -			linux,code = <KEY_VOLUMEUP>;
> -			press-threshold-microvolt = <100000>;
> -		};
> -
> -		button-down {
> -			label = "Volume Down";
> -			linux,code = <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt = <300000>;
> -		};
> -
> -		button-back {
> -			label = "Back";
> -			linux,code = <KEY_BACK>;
> -			press-threshold-microvolt = <985000>;
> -		};
> -
> -		button-menu {
> -			label = "Menu";
> -			linux,code = <KEY_MENU>;
> -			press-threshold-microvolt = <1314000>;
> -		};
> -	};
> -
> -	dc_12v: dc-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	keys: gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Power";
> -			linux,code = <KEY_POWER>;
> -			linux,input-type = <1>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&pwr_btn>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_reg_on_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	vcc3v0_sd: vcc3v0-sd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc0_pwr_h>;
> -		regulator-boot-on;
> -		regulator-max-microvolt = <3000000>;
> -		regulator-min-microvolt = <3000000>;
> -		regulator-name = "vcc3v0_sd";
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vbus_typec: vbus-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec_en>;
> -		regulator-name = "vbus_typec";
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcc_sys: vcc-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc_sys>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc3v3_s3>;
> -	phy-mode = "rgmii";
> -	phy-handle = <&rtl8211e>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>, <&phy_intb>, <&phy_rstb>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -
> -	mdio {
> -		compatible = "snps,dwmac-mdio";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rtl8211e: ethernet-phy@1 {
> -			reg = <1>;
> -			interrupt-parent = <&gpio3>;
> -			interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
> -			reset-assert-us = <10000>;
> -			reset-deassert-us = <30000>;
> -			reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -		};
> -	};
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "rtc_clko_soc", "rtc_clko_wifi";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc3v3_sys>;
> -		vcc2-supply = <&vcc3v3_sys>;
> -		vcc3-supply = <&vcc3v3_sys>;
> -		vcc4-supply = <&vcc3v3_sys>;
> -		vcc6-supply = <&vcc3v3_sys>;
> -		vcc7-supply = <&vcc3v3_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc3v3_sys>;
> -		vcc10-supply = <&vcc3v3_sys>;
> -		vcc11-supply = <&vcc3v3_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_3v0>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v0_tp: LDO_REG2 {
> -				regulator-name = "vcc3v0_tp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmupll: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmupll";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <2500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <2500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <2500000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cpu_b_sleep>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gpu_sleep>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -
> -	ak09911@c {
> -		compatible = "asahi-kasei,ak09911";
> -		reg = <0x0c>;
> -		vdd-supply = <&vcc3v3_s3>;
> -		vid-supply = <&vcc3v3_s3>;
> -	};
> -
> -	mpu6500@68 {
> -		compatible = "invensense,mpu6500";
> -		reg = <0x68>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PC6 IRQ_TYPE_EDGE_RISING>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gsensor_int_l>;
> -		vddio-supply = <&vcc3v3_s3>;
> -	};
> -
> -	lsm6ds3@6a {
> -		compatible = "st,lsm6ds3";
> -		reg = <0x6a>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PD0 IRQ_TYPE_EDGE_RISING>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gyr_int_l>;
> -		vdd-supply = <&vcc3v3_s3>;
> -		vddio-supply = <&vcc3v3_s3>;
> -	};
> -
> -	cm32181@10 {
> -		compatible = "capella,cm32181";
> -		reg = <0x10>;
> -		interrupt-parent = <&gpio4>;
> -		interrupts = <RK_PD0 IRQ_TYPE_EDGE_RISING>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&light_int_l>;
> -		vdd-supply = <&vcc3v3_s3>;
> -	};
> -
> -	fusb302@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&chg_cc_int_l>;
> -		vbus-supply = <&vbus_typec>;
> -
> -		typec_con: connector {
> -			compatible = "usb-c-connector";
> -			data-role = "host";
> -			label = "USB-C";
> -			op-sink-microwatt = <1000000>;
> -			power-role = "dual";
> -			sink-pdos =
> -				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
> -			source-pdos =
> -				<PDO_FIXED(5000, 1400, PDO_FIXED_USB_COMM)>;
> -			try-power-role = "sink";
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> -					typec_hs: endpoint {
> -						remote-endpoint = <&u2phy0_typec_hs>;
> -					};
> -				};
> -				port@1 {
> -					reg = <1>;
> -					typec_ss: endpoint {
> -						remote-endpoint = <&tcphy0_typec_ss>;
> -					};
> -				};
> -				port@2 {
> -					reg = <2>;
> -					typec_dp: endpoint {
> -						remote-endpoint = <&tcphy0_typec_dp>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&io_domains {
> -	status = "okay";
> -	bt656-supply = <&vcc_3v0>;
> -	audio-supply = <&vcca1v8_codec>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	gpio1830-supply = <&vcc_3v0>;
> -};
> -
> -&pmu_io_domains {
> -	status = "okay";
> -	pmu1830-supply = <&vcc_3v0>;
> -};
> -
> -&pinctrl {
> -	buttons {
> -		pwr_btn: pwr-btn {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	gmac {
> -		phy_intb: phy-intb {
> -			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		phy_rstb: phy-rstb {
> -			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		cpu_b_sleep: cpu-b-sleep {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		gpu_sleep: gpu-sleep {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins =
> -				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	sd {
> -		sdmmc0_pwr_h: sdmmc0-pwr-h {
> -			rockchip,pins =
> -				<0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins =
> -				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		vcc5v0_typec_en: vcc5v0-typec-en {
> -			rockchip,pins =
> -				<1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_reg_on_h: wifi-reg-on-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	bluetooth {
> -		bt_reg_on_h: bt-enable-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	mpu6500 {
> -		gsensor_int_l: gsensor-int-l {
> -			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	lsm6ds3 {
> -		gyr_int_l: gyr-int-l {
> -			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	cm32181 {
> -		light_int_l: light-int-l {
> -			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	fusb302 {
> -		chg_cc_int_l: chg-cc-int-l {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	clock-frequency = <50000000>;
> -	disable-wp;
> -	keep-power-in-suspend;
> -	max-frequency = <50000000>;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		reg = <1>;
> -		compatible = "brcm,bcm4329-fmac";
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	clock-frequency = <150000000>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> -	vmmc-supply = <&vcc3v0_sd>;
> -	vqmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy0_dp {
> -	port {
> -		tcphy0_typec_dp: endpoint {
> -			remote-endpoint = <&typec_dp>;
> -		};
> -	};
> -};
> -
> -&tcphy0_usb3 {
> -	port {
> -		tcphy0_typec_ss: endpoint {
> -			remote-endpoint = <&typec_ss>;
> -		};
> -	};
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>;
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		phy-supply = <&vbus_typec>;
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -
> -	port {
> -		u2phy0_typec_hs: endpoint {
> -			remote-endpoint = <&typec_hs>;
> -		};
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_reg_on_h>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-pinebook-pro.dts b/arch/arm/dts/rk3399-pinebook-pro.dts
> deleted file mode 100644
> index 054c6a4d1a45..000000000000
> --- a/arch/arm/dts/rk3399-pinebook-pro.dts
> +++ /dev/null
> @@ -1,1111 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> - * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> - * Copyright (c) 2020 Tobias Schramm <t.schramm@manjaro.org>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/gpio-keys.h>
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include <dt-bindings/usb/pd.h>
> -#include <dt-bindings/leds/common.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Pine64 Pinebook Pro";
> -	compatible = "pine64,pinebook-pro", "rockchip,rk3399";
> -	chassis-type = "laptop";
> -
> -	aliases {
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	backlight: edp-backlight {
> -		compatible = "pwm-backlight";
> -		power-supply = <&vcc_12v>;
> -		pwms = <&pwm0 0 740740 0>;
> -	};
> -
> -	bat: battery {
> -		compatible = "simple-battery";
> -		charge-full-design-microamp-hours = <9800000>;
> -		voltage-max-design-microvolt = <4350000>;
> -		voltage-min-design-microvolt = <3000000>;
> -	};
> -
> -	edp_panel: edp-panel {
> -		compatible = "boe,nv140fhmn49";
> -		backlight = <&backlight>;
> -		enable-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&panel_en_pin>;
> -		power-supply = <&vcc3v3_panel>;
> -
> -		port {
> -			panel_in_edp: endpoint {
> -				remote-endpoint = <&edp_out_panel>;
> -			};
> -		};
> -	};
> -
> -	/*
> -	 * Use separate nodes for gpio-keys to allow for selective deactivation
> -	 * of wakeup sources via sysfs without disabling the whole key
> -	 */
> -	gpio-key-lid {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&lidbtn_pin>;
> -
> -		switch-lid {
> -			debounce-interval = <20>;
> -			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
> -			label = "Lid";
> -			linux,code = <SW_LID>;
> -			linux,input-type = <EV_SW>;
> -			wakeup-event-action = <EV_ACT_DEASSERTED>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	gpio-key-power {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn_pin>;
> -
> -		key-power {
> -			debounce-interval = <20>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwr_led_pin &slp_led_pin>;
> -
> -		green_led: led-0 {
> -			color = <LED_COLOR_ID_GREEN>;
> -			default-state = "on";
> -			function = LED_FUNCTION_POWER;
> -			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
> -			label = "green:power";
> -		};
> -
> -		red_led: led-1 {
> -			color = <LED_COLOR_ID_RED>;
> -			default-state = "off";
> -			function = LED_FUNCTION_STANDBY;
> -			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> -			label = "red:standby";
> -			panic-indicator;
> -			retain-state-suspended;
> -		};
> -	};
> -
> -	/* Power sequence for SDIO WiFi module */
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h_pin>;
> -		post-power-on-delay-ms = <100>;
> -		power-off-delay-us = <500000>;
> -
> -		/* WL_REG_ON on module */
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	/* Audio components */
> -	es8316-sound {
> -		compatible = "simple-audio-card";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hp_det_pin>;
> -		simple-audio-card,name = "rockchip,es8316-codec";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -
> -		simple-audio-card,widgets =
> -			"Microphone", "Mic Jack",
> -			"Headphone", "Headphones",
> -			"Speaker", "Speaker";
> -		simple-audio-card,routing =
> -			"MIC1", "Mic Jack",
> -			"Headphones", "HPOL",
> -			"Headphones", "HPOR",
> -			"Speaker Amplifier INL", "HPOL",
> -			"Speaker Amplifier INR", "HPOR",
> -			"Speaker", "Speaker Amplifier OUTL",
> -			"Speaker", "Speaker Amplifier OUTR";
> -
> -		simple-audio-card,hp-det-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
> -		simple-audio-card,aux-devs = <&speaker_amp>;
> -		simple-audio-card,pin-switches = "Speaker";
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s1>;
> -		};
> -
> -		simple-audio-card,codec {
> -			sound-dai = <&es8316>;
> -		};
> -	};
> -
> -	speaker_amp: speaker-amplifier {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		sound-name-prefix = "Speaker Amplifier";
> -		VCC-supply = <&pa_5v>;
> -	};
> -
> -	/* Power tree */
> -	/* Root power source */
> -	vcc_sysin: vcc-sysin {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_sysin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	/* Regulators supplied by vcc_sysin */
> -	/* LCD backlight supply */
> -	vcc_12v: vcc-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -		vin-supply = <&vcc_sysin>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	/* Main 3.3 V supply */
> -	vcc3v3_sys: wifi_bat: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_sysin>;
> -
> -		regulator-state-mem {
> -			regulator-on-in-suspend;
> -		};
> -	};
> -
> -	/* 5 V USB power supply */
> -	vcc5v0_usb: pa_5v: vcc5v0-usb-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwr_5v_pin>;
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc_sysin>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	/* RK3399 logic supply */
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc_sysin>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -
> -		regulator-state-mem {
> -			regulator-on-in-suspend;
> -		};
> -	};
> -
> -	/* Regulators supplied by vcc3v3_sys */
> -	/* 0.9 V supply, always on */
> -	vcc_0v9: vcc-0v9 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_0v9";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	/* S3 1.8 V supply, switched by vcc1v8_s3 */
> -	vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcca1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	/* micro SD card power */
> -	vcc3v0_sd: vcc3v0-sd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc0_pwr_h_pin>;
> -		regulator-name = "vcc3v0_sd";
> -		regulator-always-on;
> -		regulator-min-microvolt = <3000000>;
> -		regulator-max-microvolt = <3000000>;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	/* LCD panel power, called VCC3V3_S0 in schematic */
> -	vcc3v3_panel: vcc3v3-panel {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&lcdvcc_en_pin>;
> -		regulator-name = "vcc3v3_panel";
> -		regulator-always-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-enable-ramp-delay = <100000>;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	/* M.2 adapter power, switched by vcc1v8_s3 */
> -	vcc3v3_ssd: vcc3v3-ssd {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_ssd";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	/* Regulators supplied by vcc5v0_usb */
> -	/* USB 3 port power supply regulator  */
> -	vcc5v0_otg: vcc5v0-otg {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en_pin>;
> -		regulator-name = "vcc5v0_otg";
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usb>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	/* Regulators supplied by vcc5v0_usb */
> -	/* Type C port power supply regulator */
> -	vbus_5vout: vbus_typec: vbus-5vout {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec0_en_pin>;
> -		regulator-name = "vbus_5vout";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usb>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	/* Regulators supplied by vcc_1v8 */
> -	/* Primary 0.9 V LDO */
> -	vcca0v9_s3: vcca0v9-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc0v9_s3";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc_1v8>;
> -
> -		regulator-state-mem {
> -			regulator-on-in-suspend;
> -		};
> -	};
> -
> -	mains_charger: dc-charger {
> -		compatible = "gpio-charger";
> -		charger-type = "mains";
> -		gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_LOW>;
> -
> -		/* Also triggered by USB charger */
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&dc_det_pin>;
> -	};
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&edp {
> -	force-hpd;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&edp_hpd>;
> -	status = "okay";
> -
> -	ports {
> -		edp_out: port@1 {
> -			reg = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			edp_out_panel: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&panel_in_edp>;
> -			};
> -		};
> -	};
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-falling-time-ns = <4>;
> -	i2c-scl-rising-time-ns = <168>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l_pin>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc_sysin>;
> -		vcc2-supply = <&vcc_sysin>;
> -		vcc3-supply = <&vcc_sysin>;
> -		vcc4-supply = <&vcc_sysin>;
> -		vcc6-supply = <&vcc_sysin>;
> -		vcc7-supply = <&vcc_sysin>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc_sysin>;
> -		vcc10-supply = <&vcc_sysin>;
> -		vcc11-supply = <&vcc_sysin>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -
> -		regulators {
> -			/* rk3399 center logic supply */
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: vcc_wl: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			/* not used */
> -			LDO_REG1 {
> -			};
> -
> -			/* not used */
> -			LDO_REG2 {
> -			};
> -
> -			vcc1v8_pmupll: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmupll";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		vin-supply = <&vcc_1v8>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-name = "vdd_gpu";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		vin-supply = <&vcc_1v8>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	clock-frequency = <100000>;
> -	i2c-scl-falling-time-ns = <4>;
> -	i2c-scl-rising-time-ns = <168>;
> -	status = "okay";
> -
> -	es8316: audio-codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		clocks = <&cru SCLK_I2S_8CH_OUT>;
> -		clock-names = "mclk";
> -		#sound-dai-cells = <0>;
> -	};
> -};
> -
> -&i2c3 {
> -	i2c-scl-falling-time-ns = <15>;
> -	i2c-scl-rising-time-ns = <450>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-falling-time-ns = <20>;
> -	i2c-scl-rising-time-ns = <600>;
> -	status = "okay";
> -
> -	fusb0: fusb30x@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb0_int_pin>;
> -		vbus-supply = <&vbus_typec>;
> -
> -		connector {
> -			compatible = "usb-c-connector";
> -			data-role = "dual";
> -			label = "USB-C";
> -			op-sink-microwatt = <1000000>;
> -			power-role = "dual";
> -			sink-pdos =
> -				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
> -			source-pdos =
> -				<PDO_FIXED(5000, 1400, PDO_FIXED_USB_COMM)>;
> -			try-power-role = "sink";
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> -
> -					usbc_hs: endpoint {
> -						remote-endpoint =
> -							<&u2phy0_typec_hs>;
> -					};
> -				};
> -
> -				port@1 {
> -					reg = <1>;
> -
> -					usbc_ss: endpoint {
> -						remote-endpoint =
> -							<&tcphy0_typec_ss>;
> -					};
> -				};
> -
> -				port@2 {
> -					reg = <2>;
> -
> -					usbc_dp: endpoint {
> -						remote-endpoint =
> -							<&tcphy0_typec_dp>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
> -	cw2015@62 {
> -		compatible = "cellwise,cw2015";
> -		reg = <0x62>;
> -		cellwise,battery-profile = /bits/ 8 <
> -			0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
> -			0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
> -			0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
> -			0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
> -			0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
> -			0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
> -			0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
> -			0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
> -		>;
> -		cellwise,monitor-interval-ms = <5000>;
> -		monitored-battery = <&bat>;
> -		power-supplies = <&mains_charger>, <&fusb0>;
> -	};
> -};
> -
> -&i2s1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s_8ch_mclk_pin>, <&i2s1_2ch_bus>;
> -	rockchip,capture-channels = <8>;
> -	rockchip,playback-channels = <8>;
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	audio-supply = <&vcc_3v0>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	bus-scan-delay-ms = <1000>;
> -	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	vpcie0v9-supply = <&vcca0v9_s3>;
> -	vpcie1v8-supply = <&vcca1v8_s3>;
> -	vpcie3v3-supply = <&vcc3v3_ssd>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	buttons {
> -		pwrbtn_pin: pwrbtn-pin {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		lidbtn_pin: lidbtn-pin {
> -			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	dc-charger {
> -		dc_det_pin: dc-det-pin {
> -			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	es8316 {
> -		hp_det_pin: hp-det-pin {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	fusb302x {
> -		fusb0_int_pin: fusb0-int-pin {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	i2s1 {
> -		i2s_8ch_mclk_pin: i2s-8ch-mclk-pin {
> -			rockchip,pins = <4 RK_PA0 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	lcd-panel {
> -		lcdvcc_en_pin: lcdvcc-en-pin {
> -			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		panel_en_pin: panel-en-pin {
> -			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		lcd_panel_reset_pin: lcd-panel-reset-pin {
> -			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		pwr_led_pin: pwr-led-pin {
> -			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		slp_led_pin: slp-led-pin {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l_pin: pmic-int-l-pin {
> -			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdcard {
> -		sdmmc0_pwr_h_pin: sdmmc0-pwr-h-pin {
> -			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h_pin: wifi-enable-h-pin {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc5v0_typec0_en_pin: vcc5v0-typec0-en-pin {
> -			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		pwr_5v_pin: pwr-5v-pin {
> -			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		vcc5v0_host_en_pin: vcc5v0-host-en-pin {
> -			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wireless-bluetooth {
> -		bt_wake_pin: bt-wake-pin {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_pin: bt-host-wake-pin {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_reset_pin: bt-reset-pin {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	sd-uhs-sdr50;
> -	vmmc-supply = <&vcc3v0_sd>;
> -	vqmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&spi1 {
> -	max-freq = <10000000>;
> -	status = "okay";
> -
> -	spiflash: flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		m25p,fast-read;
> -		spi-max-frequency = <10000000>;
> -	};
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy0_dp {
> -	port {
> -		tcphy0_typec_dp: endpoint {
> -			remote-endpoint = <&usbc_dp>;
> -		};
> -	};
> -};
> -
> -&tcphy0_usb3 {
> -	port {
> -		tcphy0_typec_ss: endpoint {
> -			remote-endpoint = <&usbc_ss>;
> -		};
> -	};
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_otg>;
> -		status = "okay";
> -	};
> -
> -	port {
> -		u2phy0_typec_hs: endpoint {
> -			remote-endpoint = <&usbc_hs>;
> -		};
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_otg>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	uart-has-rtscts;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm4345c5";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		max-speed = <1500000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_pin &bt_wake_pin &bt_reset_pin>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		vbat-supply = <&wifi_bat>;
> -		vddio-supply = <&vcc_wl>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	dr_mode = "host";
> -	status = "okay";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	dr_mode = "host";
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-pinephone-pro.dts b/arch/arm/dts/rk3399-pinephone-pro.dts
> deleted file mode 100644
> index 61f3fec5a8b1..000000000000
> --- a/arch/arm/dts/rk3399-pinephone-pro.dts
> +++ /dev/null
> @@ -1,621 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
> - * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
> - */
> -
> -/*
> - * PinePhone Pro datasheet:
> - * https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/gpio-keys.h>
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Pine64 PinePhonePro";
> -	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
> -	chassis-type = "handset";
> -
> -	aliases {
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1600000>;
> -		poll-interval = <100>;
> -
> -		button-up {
> -			label = "Volume Up";
> -			linux,code = <KEY_VOLUMEUP>;
> -			press-threshold-microvolt = <100000>;
> -		};
> -
> -		button-down {
> -			label = "Volume Down";
> -			linux,code = <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt = <600000>;
> -		};
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm0 0 50000 0>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn_pin>;
> -
> -		key-power {
> -			debounce-interval = <20>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	vcc_sys: vcc-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcca1v8_s3: vcc1v8-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcca1v8_s3";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc3v3_sys>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc1v8_codec: vcc1v8-codec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc1v8_codec_en>;
> -		regulator-name = "vcc1v8_codec";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	wifi_pwrseq: sdio-wifi-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk818 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h_pin>;
> -		/*
> -		 * Wait between power-on and SDIO access for CYP43455
> -		 * POR circuit.
> -		 */
> -		post-power-on-delay-ms = <110>;
> -		/*
> -		 * Wait between consecutive toggles for CYP43455 CBUCK
> -		 * regulator discharge.
> -		 */
> -		power-off-delay-us = <10000>;
> -
> -		/* WL_REG_ON on module */
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	/* MIPI DSI panel 1.8v supply */
> -	vcc1v8_lcd: vcc1v8-lcd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		regulator-name = "vcc1v8_lcd";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc3v3_sys>;
> -		gpio = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -	};
> -
> -	/* MIPI DSI panel 2.8v supply */
> -	vcc2v8_lcd: vcc2v8-lcd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		regulator-name = "vcc2v8_lcd";
> -		regulator-min-microvolt = <2800000>;
> -		regulator-max-microvolt = <2800000>;
> -		vin-supply = <&vcc3v3_sys>;
> -		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -	};
> -};
> -
> -&cpu_alert0 {
> -	temperature = <65000>;
> -};
> -&cpu_alert1 {
> -	temperature = <68000>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk818: pmic@1c {
> -		compatible = "rockchip,rk818";
> -		reg = <0x1c>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc_sys>;
> -		vcc2-supply = <&vcc_sys>;
> -		vcc3-supply = <&vcc_sys>;
> -		vcc4-supply = <&vcc_sys>;
> -		vcc6-supply = <&vcc_sys>;
> -		vcc7-supply = <&vcc3v3_sys>;
> -		vcc8-supply = <&vcc_sys>;
> -		vcc9-supply = <&vcc3v3_sys>;
> -
> -		regulators {
> -			vdd_cpu_l: DCDC_REG1 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <875000>;
> -				regulator-max-microvolt = <975000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_center: DCDC_REG2 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG1 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -			};
> -
> -			vcc3v0_touch: LDO_REG2 {
> -				regulator-name = "vcc3v0_touch";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -			};
> -
> -			vcca1v8_codec: LDO_REG3 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -			};
> -
> -			rk818_pwr_on: LDO_REG4 {
> -				regulator-name = "rk818_pwr_on";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG5 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG7 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -			};
> -
> -			vcc3v3_s3: LDO_REG8 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG9 {
> -				regulator-name = "vccio_sd";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <875000>;
> -		regulator-max-microvolt = <1150000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <875000>;
> -		regulator-max-microvolt = <975000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -
> -	touchscreen@14 {
> -		compatible = "goodix,gt1158";
> -		reg = <0x14>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <RK_PB5 IRQ_TYPE_EDGE_RISING>;
> -		irq-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
> -		AVDD28-supply = <&vcc3v0_touch>;
> -		VDDIO-supply = <&vcc3v0_touch>;
> -		touchscreen-size-x = <720>;
> -		touchscreen-size-y = <1440>;
> -	};
> -};
> -
> -&cluster0_opp {
> -	opp04 {
> -		status = "disabled";
> -	};
> -
> -	opp05 {
> -		status = "disabled";
> -	};
> -};
> -
> -&cluster1_opp {
> -	opp06 {
> -		opp-hz = /bits/ 64 <1500000000>;
> -		opp-microvolt = <1100000 1100000 1150000>;
> -	};
> -
> -	opp07 {
> -		status = "disabled";
> -	};
> -};
> -
> -&io_domains {
> -	bt656-supply = <&vcc1v8_dvp>;
> -	audio-supply = <&vcca1v8_codec>;
> -	sdmmc-supply = <&vccio_sd>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&mipi_dsi {
> -	status = "okay";
> -	clock-master;
> -
> -	ports {
> -		mipi_out: port@1 {
> -			#address-cells = <0>;
> -			#size-cells = <0>;
> -			reg = <1>;
> -
> -			mipi_out_panel: endpoint {
> -				remote-endpoint = <&mipi_in_panel>;
> -			};
> -		};
> -	};
> -
> -	panel@0 {
> -		compatible = "hannstar,hsd060bhw4";
> -		reg = <0>;
> -		backlight = <&backlight>;
> -		reset-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;
> -		vcc-supply = <&vcc2v8_lcd>;
> -		iovcc-supply = <&vcc1v8_lcd>;
> -		pinctrl-names = "default";
> -
> -		port {
> -			mipi_in_panel: endpoint {
> -				remote-endpoint = <&mipi_out_panel>;
> -			};
> -		};
> -	};
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_1v8>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	buttons {
> -		pwrbtn_pin: pwrbtn-pin {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h_pin: wifi-enable-h-pin {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sound {
> -		vcc1v8_codec_en: vcc1v8-codec-en {
> -			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	wireless-bluetooth {
> -		bt_wake_pin: bt-wake-pin {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_pin: bt-host-wake-pin {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_reset_pin: bt-reset-pin {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	disable-wp;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&wifi_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> -	vmmc-supply = <&vcc3v3_sys>;
> -	vqmmc-supply = <&vccio_sd>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>;
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	uart-has-rtscts;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm4345c5";
> -		clocks = <&rk818 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		max-speed = <1500000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_pin &bt_wake_pin &bt_reset_pin>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>,
> -			  <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> -	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
> -	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP0_DIV>;
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -	assigned-clocks = <&cru DCLK_VOP1_DIV>, <&cru DCLK_VOP1>,
> -			  <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> -	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
> -	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP1_DIV>;
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-puma-haikou.dts b/arch/arm/dts/rk3399-puma-haikou.dts
> deleted file mode 100644
> index 18a98c4648ea..000000000000
> --- a/arch/arm/dts/rk3399-puma-haikou.dts
> +++ /dev/null
> @@ -1,306 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
> - */
> -
> -/dts-v1/;
> -#include "rk3399-puma.dtsi"
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -	model = "Theobroma Systems RK3399-Q7 SoM";
> -	compatible = "tsd,rk3399-puma-haikou", "rockchip,rk3399";
> -
> -	aliases {
> -		mmc1 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-0 = <&haikou_keys_pin>;
> -		pinctrl-names = "default";
> -
> -		button-batlow-n {
> -			gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -			label = "BATLOW#";
> -			linux,code = <KEY_BATTERY>;
> -		};
> -
> -		button-slp-btn-n {
> -			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
> -			label = "SLP_BTN#";
> -			linux,code = <KEY_SLEEP>;
> -		};
> -
> -		button-wake-n {
> -			gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
> -			label = "WAKE#";
> -			linux,code = <KEY_WAKEUP>;
> -			wakeup-source;
> -		};
> -
> -		switch-lid-btn-n {
> -			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -			label = "LID_BTN#";
> -			linux,code = <SW_LID>;
> -			linux,input-type = <EV_SW>;
> -		};
> -	};
> -
> -	leds {
> -		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
> -
> -		sd_card_led: led-1 {
> -			label = "sd_card_led";
> -			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "mmc0";
> -		};
> -	};
> -
> -	i2s0-sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,name = "Haikou,I2S-codec";
> -		simple-audio-card,mclk-fs = <512>;
> -
> -		simple-audio-card,codec {
> -			clocks = <&sgtl5000_clk>;
> -			sound-dai = <&sgtl5000>;
> -		};
> -
> -		simple-audio-card,cpu {
> -			bitclock-master;
> -			frame-master;
> -			sound-dai = <&i2s0>;
> -		};
> -	};
> -
> -	sgtl5000_clk: sgtl5000-oscillator  {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <24576000>;
> -	};
> -
> -	dc_12v: dc-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc3v3_baseboard: vcc3v3-baseboard {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_baseboard";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc5v0_baseboard: vcc5v0-baseboard {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_baseboard";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc5v0_otg: vcc5v0-otg-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&otg_vbus_drv>;
> -		regulator-name = "vcc5v0_otg";
> -		regulator-always-on;
> -	};
> -
> -	vdda_codec: vdda-codec {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdda_codec";
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_baseboard>;
> -	};
> -
> -	vddd_codec: vddd-codec {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vddd_codec";
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1600000>;
> -		regulator-max-microvolt = <1600000>;
> -		vin-supply = <&vcc5v0_baseboard>;
> -	};
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	status = "okay";
> -};
> -
> -&i2c1 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	sgtl5000: codec@a {
> -		compatible = "fsl,sgtl5000";
> -		reg = <0x0a>;
> -		clocks = <&sgtl5000_clk>;
> -		#sound-dai-cells = <0>;
> -		VDDA-supply = <&vdda_codec>;
> -		VDDIO-supply = <&vdda_codec>;
> -		VDDD-supply = <&vddd_codec>;
> -		status = "okay";
> -	};
> -};
> -
> -&i2c6 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	buttons {
> -		haikou_keys_pin: haikou-keys-pin {
> -			rockchip,pins =
> -			  /* LID_BTN */
> -			  <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
> -			  /* BATLOW# */
> -			  <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
> -			  /* SLP_BTN# */
> -			  <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
> -			  /* WAKE# */
> -			  <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		sd_card_led_pin: sd-card-led-pin {
> -			rockchip,pins =
> -			  <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb2 {
> -		otg_vbus_drv: otg-vbus-drv {
> -			rockchip,pins =
> -			  <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <40000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> -	vmmc-supply = <&vcc3v3_baseboard>;
> -	status = "okay";
> -};
> -
> -&spi5 {
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	dr_mode = "otg";
> -	extcon = <&extcon_usb3>;
> -	status = "okay";
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_otg>;
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-puma.dtsi b/arch/arm/dts/rk3399-puma.dtsi
> deleted file mode 100644
> index c08e69391c01..000000000000
> --- a/arch/arm/dts/rk3399-puma.dtsi
> +++ /dev/null
> @@ -1,532 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
> - */
> -
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdhci;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&module_led_pin>;
> -
> -		module_led: led-0 {
> -			label = "module_led";
> -			gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -			panic-indicator;
> -		};
> -	};
> -
> -	extcon_usb3: extcon-usb3 {
> -		compatible = "linux,extcon-usb-gpio";
> -		id-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&usb3_id>;
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	vcc1v2_phy: vcc1v2-phy {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v2_phy";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1200000>;
> -		regulator-max-microvolt = <1200000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc5v0_sys>;
> -		regulator-name = "vdd_log";
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -	drive-impedance-ohm = <33>;
> -};
> -
> -&gpio0 {
> -	/*
> -	 * The BIOS_DISABLE hog is a feedback pin for the actual status of the
> -	 * signal. This usually represents the state of a switch on the baseboard.
> -	 * The pin has a 10k pull-up resistor connected, so no pull-up setting is needed.
> -	 */
> -	bios-disable-hog {
> -		gpios = <RK_PB0 GPIO_ACTIVE_HIGH>;
> -		gpio-hog;
> -		input;
> -		line-name = "bios_disable";
> -	};
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc1v2_phy>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x10>;
> -	rx_delay = <0x10>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	clock-frequency = <400000>;
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc5v0_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc1v8_pmu>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_ldo1: LDO_REG1 {
> -				regulator-name = "vcc_ldo1";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_hdmi: LDO_REG2 {
> -				regulator-name = "vcc1v8_hdmi";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmu: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmu";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sd: LDO_REG4 {
> -				regulator-name = "vcc_sd";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc_ldo5: LDO_REG5 {
> -				regulator-name = "vcc_ldo5";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ldo6: LDO_REG6 {
> -				regulator-name = "vcc_ldo6";
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc0v9_hdmi: LDO_REG7 {
> -				regulator-name = "vcc0v9_hdmi";
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_efuse: LDO_REG8 {
> -				regulator-name = "vcc_efuse";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s3: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_gpu: regulator@60 {
> -		compatible = "fcs,fan53555";
> -		reg = <0x60>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <600000>;
> -		regulator-max-microvolt = <1230000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	fan: fan@18 {
> -		compatible = "ti,amc6821";
> -		reg = <0x18>;
> -		#cooling-cells = <2>;
> -	};
> -
> -	rtc_twi: rtc@6f {
> -		compatible = "isil,isl1208";
> -		reg = <0x6f>;
> -	};
> -};
> -
> -&i2c8 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	vdd_cpu_b: regulator@60 {
> -		compatible = "fcs,fan53555";
> -		reg = <0x60>;
> -		vin-supply = <&vcc5v0_sys>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <600000>;
> -		regulator-max-microvolt = <1230000>;
> -		regulator-ramp-delay = <1000>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&i2s0 {
> -	pinctrl-0 = <&i2s0_2ch_bus>;
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -};
> -
> -/*
> - * As Q7 does not specify neither a global nor a RX clock for I2S these
> - * signals are not used. Furthermore I2S0_LRCK_RX is used as GPIO.
> - * Therefore we have to redefine the i2s0_2ch_bus definition to prevent
> - * conflicts.
> - */
> -&i2s0_2ch_bus {
> -	rockchip,pins =
> -		<3 RK_PD0 1 &pcfg_pull_none>,
> -		<3 RK_PD2 1 &pcfg_pull_none>,
> -		<3 RK_PD3 1 &pcfg_pull_none>,
> -		<3 RK_PD7 1 &pcfg_pull_none>;
> -};
> -
> -&io_domains {
> -	status = "okay";
> -	bt656-supply = <&vcc_1v8>;
> -	audio-supply = <&vcc_1v8>;
> -	sdmmc-supply = <&vcc_sd>;
> -	gpio1830-supply = <&vcc_1v8>;
> -};
> -
> -&pmu_io_domains {
> -	status = "okay";
> -	pmu1830-supply = <&vcc_1v8>;
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	i2c8 {
> -		i2c8_xfer_a: i2c8-xfer {
> -			rockchip,pins =
> -			  <1 RK_PC4 1 &pcfg_pull_up>,
> -			  <1 RK_PC5 1 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		module_led_pin: module-led-pin {
> -			rockchip,pins =
> -			  <2 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins =
> -			  <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins =
> -			  <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb3 {
> -		usb3_id: usb3-id {
> -			rockchip,pins =
> -			  <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&sdhci {
> -	/*
> -	 * Signal integrity isn't great at 200MHz but 100MHz has proven stable
> -	 * enough.
> -	 */
> -	max-frequency = <100000000>;
> -
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	vqmmc-supply = <&vcc_sd>;
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	norflash: flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>;
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-roc-pc-mezzanine.dts b/arch/arm/dts/rk3399-roc-pc-mezzanine.dts
> deleted file mode 100644
> index 9447c8724b65..000000000000
> --- a/arch/arm/dts/rk3399-roc-pc-mezzanine.dts
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> - * Copyright (c) 2019 Markus Reichl <m.reichl@fivetechno.de>
> - */
> -
> -/dts-v1/;
> -#include "rk3399-roc-pc.dtsi"
> -
> -/ {
> -	model = "Firefly ROC-RK3399-PC Mezzanine Board";
> -	compatible = "firefly,roc-rk3399-pc-mezzanine", "rockchip,rk3399";
> -
> -	aliases {
> -		mmc2 = &sdio0;
> -	};
> -
> -	/* MP8009 PoE PD */
> -	poe_12v: poe-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "poe_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc3v3_ngff: vcc3v3-ngff {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_ngff";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc3v3_ngff_en>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&sys_12v>;
> -	};
> -
> -	vcc3v3_pcie: vcc3v3-pcie {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_pcie";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc3v3_pcie_en>;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&sys_12v>;
> -	};
> -};
> -
> -&sys_12v {
> -	vin-supply = <&poe_12v>;
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_perst>;
> -	vpcie3v3-supply = <&vcc3v3_pcie>;
> -	vpcie1v8-supply = <&vcc1v8_pmu>;
> -	vpcie0v9-supply = <&vcca_0v9>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	ngff {
> -		vcc3v3_ngff_en: vcc3v3-ngff-en {
> -			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie {
> -		vcc3v3_pcie_en: vcc3v3-pcie-en {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie_perst: pcie-perst {
> -			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc3v3_ngff>;
> -	vqmmc-supply = <&vcc_1v8>;
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-roc-pc.dts b/arch/arm/dts/rk3399-roc-pc.dts
> deleted file mode 100644
> index cd4195425309..000000000000
> --- a/arch/arm/dts/rk3399-roc-pc.dts
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> - */
> -
> -/dts-v1/;
> -#include "rk3399-roc-pc.dtsi"
> -
> -/ {
> -	model = "Firefly ROC-RK3399-PC Board";
> -	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> -};
> diff --git a/arch/arm/dts/rk3399-roc-pc.dtsi b/arch/arm/dts/rk3399-roc-pc.dtsi
> deleted file mode 100644
> index ca7a446b6568..000000000000
> --- a/arch/arm/dts/rk3399-roc-pc.dtsi
> +++ /dev/null
> @@ -1,844 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Firefly ROC-RK3399-PC Board";
> -	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdmmc;
> -		mmc1 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm0 0 25000 0>;
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1500000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "Recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <18000>;
> -		};
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwr_key_l>;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ir_int>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&work_led_pin>, <&diy_led_pin>, <&yellow_led_pin>;
> -
> -		work_led: led-0 {
> -			label = "green:work";
> -			gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -			default-state = "on";
> -			linux,default-trigger = "heartbeat";
> -		};
> -
> -		diy_led: led-1 {
> -			label = "red:diy";
> -			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> -			default-state = "off";
> -			linux,default-trigger = "mmc2";
> -		};
> -
> -		yellow_led: led-2 {
> -			label = "yellow:yellow-led";
> -			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> -			default-state = "off";
> -			linux,default-trigger = "mmc1";
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -
> -		/*
> -		 * On the module itself this is one of these (depending
> -		 * on the actual card populated):
> -		 * - SDIO_RESET_L_WL_REG_ON
> -		 * - PDN (power down when low)
> -		 */
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	vcc_vbus_typec0: vcc-vbus-typec0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_vbus_typec0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	sys_12v: sys-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "sys_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	vcc3v0_sd: vcc3v0-sd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc3v0_sd_en>;
> -		regulator-name = "vcc3v0_sd";
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3000000>;
> -		regulator-max-microvolt = <3000000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&sys_12v>;
> -	};
> -
> -	vcca_0v9: vcca-0v9 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcca_0v9";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en &hub_rst>;
> -		regulator-name = "vcc5v0_host";
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcc_vbus_typec1: vcc-vbus-typec1 {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc_vbus_typec1_en>;
> -		regulator-name = "vcc_vbus_typec1";
> -		regulator-always-on;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
> -	vcc_sys: vcc-sys {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio2 RK_PA6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc_sys_en>;
> -		regulator-name = "vcc_sys";
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&sys_12v>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <450000>;
> -		regulator-max-microvolt = <1400000>;
> -		pwm-supply = <&vcc3v3_sys>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	avdd-0v9-supply = <&vcca0v9_hdmi>;
> -	avdd-1v8-supply = <&vcca1v8_hdmi>;
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc3v3_sys>;
> -		vcc2-supply = <&vcc3v3_sys>;
> -		vcc3-supply = <&vcc3v3_sys>;
> -		vcc4-supply = <&vcc3v3_sys>;
> -		vcc6-supply = <&vcc3v3_sys>;
> -		vcc7-supply = <&vcc3v3_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc3v3_sys>;
> -		vcc10-supply = <&vcc3v3_sys>;
> -		vcc11-supply = <&vcc3v3_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_3v0>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG1 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcca1v8_hdmi: LDO_REG2 {
> -				regulator-name = "vcca1v8_hdmi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc1v8_pmu: LDO_REG3 {
> -				regulator-name = "vcc1v8_pmu";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca0v9_hdmi: LDO_REG7 {
> -				regulator-name = "vcca0v9_hdmi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <300>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -
> -	fusb1: usb-typec@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb1_int>;
> -		vbus-supply = <&vcc_vbus_typec1>;
> -		status = "okay";
> -	};
> -};
> -
> -&i2c7 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -
> -	fusb0: usb-typec@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb0_int>;
> -		vbus-supply = <&vcc_vbus_typec0>;
> -		status = "okay";
> -	};
> -
> -	mp8859: regulator@66 {
> -		compatible = "mps,mp8859";
> -		reg = <0x66>;
> -		dc_12v: mp8859_dcdc {
> -			regulator-name = "dc_12v";
> -			regulator-min-microvolt = <12000000>;
> -			regulator-max-microvolt = <12000000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			vin-supply = <&vcc_vbus_typec0>;
> -
> -			regulator-state-mem {
> -				regulator-on-in-suspend;
> -				regulator-suspend-microvolt = <12000000>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2s0 {
> -	rockchip,playback-channels = <8>;
> -	rockchip,capture-channels = <8>;
> -	status = "okay";
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	audio-supply = <&vcca1v8_codec>;
> -	bt656-supply = <&vcc_3v0>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	buttons {
> -		pwr_key_l: pwr-key-l {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	ir {
> -		ir_int: ir-int {
> -			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	lcd-panel {
> -		lcd_panel_reset: lcd-panel-reset {
> -			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		diy_led_pin: diy-led-pin {
> -			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		work_led_pin: work-led-pin {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		yellow_led_pin: yellow-led-pin {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdmmc {
> -		vcc3v0_sd_en: vcc3v0-sd-en {
> -			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		vcc_sys_en: vcc-sys-en {
> -			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		hub_rst: hub-rst {
> -			rockchip,pins = <2 RK_PA4 RK_FUNC_GPIO &pcfg_output_high>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc_vbus_typec1_en: vcc-vbus-typec1-en {
> -			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	fusb30x {
> -		fusb0_int: fusb0-int {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		fusb1_int: fusb1-int {
> -			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc3v0_sd>;
> -	vqmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <30000000>;
> -	};
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		phy-supply = <&vcc_vbus_typec0>;
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		phy-supply = <&vcc_vbus_typec1>;
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus.dts b/arch/arm/dts/rk3399-rock-4c-plus.dts
> deleted file mode 100644
> index 7baf9d1b22fd..000000000000
> --- a/arch/arm/dts/rk3399-rock-4c-plus.dts
> +++ /dev/null
> @@ -1,709 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> - * Copyright (c) 2019 Radxa Limited
> - * Copyright (c) 2022 Amarula Solutions(India)
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/leds/common.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-t-opp.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK 4C+";
> -	compatible = "radxa,rock-4c-plus", "rockchip,rk3399";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&user_led1 &user_led2>;
> -
> -		/* USER_LED1 */
> -		led-0 {
> -			function = LED_FUNCTION_POWER;
> -			color = <LED_COLOR_ID_GREEN>;
> -			gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_LOW>;
> -			linux,default-trigger = "default-on";
> -		};
> -
> -		/* USER_LED2 */
> -		led-1 {
> -			function = LED_FUNCTION_STATUS;
> -			color = <LED_COLOR_ID_BLUE>;
> -			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk809 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	vcc_3v3: vcc-3v3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_3v3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc3v3_phy1: vcc3v3-phy1-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_phy1";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_3v3>;
> -	};
> -
> -	vcc5v0_host1: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PD6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host1";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_host0_s0>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc5v0_typec: vcc5v0-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec0_en>;
> -		regulator-name = "vcc5v0_typec";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vdd_log: vdd-log-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <950000>;
> -		regulator-max-microvolt = <950000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc3v3_phy1>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x2a>;
> -	rx_delay = <0x21>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	avdd-0v9-supply = <&vcc_0v9_s0>;
> -	avdd-1v8-supply = <&vcc_1v8_s0>;
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -	i2c-scl-falling-time-ns = <30>;
> -	i2c-scl-rising-time-ns = <180>;
> -	clock-frequency = <400000>;
> -
> -	rk809: pmic@20 {
> -		compatible = "rockchip,rk809";
> -		reg = <0x20>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc_buck5_s3>;
> -		vcc6-supply = <&vcc_buck5_s3>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-initial-mode = <0x2>;
> -				regulator-name = "vdd_center";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-initial-mode = <0x2>;
> -				regulator-name = "vdd_cpu_l";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc_ddr";
> -				regulator-initial-mode = <0x2>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_sys: DCDC_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-initial-mode = <0x2>;
> -				regulator-name = "vcc3v3_sys";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_buck5_s3: DCDC_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_buck5_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_0v9_s3: LDO_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-name = "vcc_0v9_s3";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: LDO_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_0v9_s0: LDO_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-name = "vcc_0v9_s0";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vcc_1v8_s0: LDO_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_mipi: LDO_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "vcc_mipi";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5_s0: LDO_REG6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-name = "vcc_1v5_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0_s0: LDO_REG7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "vcc_3v0_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_sdio_s0: LDO_REG8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_sdio_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_cam: LDO_REG9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_cam";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc5v0_host0_s0: SWITCH_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc5v0_host0_s0";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			lcd_3v3: SWITCH_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "lcd_3v3";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-compatible = "fan53555-reg";
> -		pinctrl-0 = <&vsel1_gpio>;
> -		vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-compatible = "fan53555-reg";
> -		pinctrl-0 = <&vsel2_gpio>;
> -		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -		regulator-initial-mode = <1>; /* 1:force PWM 2:auto */
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	audio-supply = <&vcc_1v8_s0>;
> -	bt656-supply = <&vcc_3v0_s0>;
> -	gpio1830-supply = <&vcc_3v0_s0>;
> -	sdmmc-supply = <&vcc_sdio_s0>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	bt {
> -		bt_enable_h: bt-enable-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		user_led1: user-led1 {
> -			rockchip,pins = <3 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led2: user-led2 {
> -			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_gpio: vsel1-gpio {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_gpio: vsel2-gpio {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdmmc {
> -		sdmmc_bus4: sdmmc-bus4 {
> -			rockchip,pins = <4 8 1 &pcfg_pull_up_8ma>,
> -					<4 9 1 &pcfg_pull_up_8ma>,
> -					<4 10 1 &pcfg_pull_up_8ma>,
> -					<4 11 1 &pcfg_pull_up_8ma>;
> -		};
> -
> -		sdmmc_clk: sdmmc-clk {
> -			rockchip,pins = <4 12 1 &pcfg_pull_none_18ma>;
> -		};
> -
> -		sdmmc_cmd: sdmmc-cmd {
> -			rockchip,pins = <4 13 1 &pcfg_pull_up_8ma>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc5v0_typec0_en: vcc5v0-typec-en {
> -			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0_s0>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	status = "okay";
> -	vref-supply = <&vcc_1v8_s3>;
> -};
> -
> -&sdhci {
> -	max-frequency = <150000000>;
> -	bus-width = <8>;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	bus-width = <4>;
> -	clock-frequency = <50000000>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	card-detect-delay = <800>;
> -	disable-wp;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	vqmmc-supply = <&vcc_sdio_s0>;
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>;
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host1>;
> -		status = "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host1>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm4345c5";
> -		clocks = <&rk809 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		max-speed = <1500000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8_s3>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	extcon = <&u2phy0>;
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-rock-4se.dts b/arch/arm/dts/rk3399-rock-4se.dts
> deleted file mode 100644
> index 7cfc198bbae7..000000000000
> --- a/arch/arm/dts/rk3399-rock-4se.dts
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
> - * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
> - */
> -
> -/dts-v1/;
> -#include "rk3399-rock-pi-4.dtsi"
> -#include "rk3399-t-opp.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK 4SE";
> -	compatible = "radxa,rock-4se", "rockchip,rk3399";
> -
> -	aliases {
> -		mmc2 = &sdio0;
> -	};
> -};
> -
> -&pinctrl {
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&sdio0 {
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&uart0 {
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm4345c5";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		max-speed = <1500000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&vcc5v0_host {
> -	enable-active-high;
> -	gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&vcc5v0_host_en>;
> -};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4.dtsi b/arch/arm/dts/rk3399-rock-pi-4.dtsi
> deleted file mode 100644
> index 281a12180703..000000000000
> --- a/arch/arm/dts/rk3399-rock-pi-4.dtsi
> +++ /dev/null
> @@ -1,792 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
> - * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -
> -/ {
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&user_led2>;
> -
> -		/* USER_LED2 */
> -		led-0 {
> -			function = LED_FUNCTION_STATUS;
> -			color = <LED_COLOR_ID_BLUE>;
> -			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	sound: sound {
> -		compatible = "audio-graph-card";
> -		label = "Analog";
> -		dais = <&i2s0_p0>;
> -	};
> -
> -	sound-dit {
> -		compatible = "audio-graph-card";
> -		label = "SPDIF";
> -		dais = <&spdif_p0>;
> -	};
> -
> -	spdif-dit {
> -		compatible = "linux,spdif-dit";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			dit_p0_0: endpoint {
> -				remote-endpoint = <&spdif_p0_0>;
> -			};
> -		};
> -	};
> -
> -	vbus_typec: vbus-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec_en>;
> -		regulator-name = "vbus_typec";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc12v_dcin: dc-12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc3v3_lan: vcc3v3-lan-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_lan";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc3v3_pcie: vcc3v3-pcie-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_pwr_en>;
> -		regulator-name = "vcc3v3_pcie";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc_0v9: vcc-0v9 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_0v9";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc5v0_sys>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc3v3_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	avdd-0v9-supply = <&vcca0v9_hdmi>;
> -	avdd-1v8-supply = <&vcca1v8_hdmi>;
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc5v0_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG1 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcca1v8_hdmi: LDO_REG2 {
> -				regulator-name = "vcca1v8_hdmi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcca_1v8: LDO_REG3 {
> -				regulator-name = "vcca_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca0v9_hdmi: LDO_REG7 {
> -				regulator-name = "vcca0v9_hdmi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc_cam: SWITCH_REG1 {
> -				regulator-name = "vcc_cam";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_mipi: SWITCH_REG2 {
> -				regulator-name = "vcc_mipi";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <300>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -
> -	es8316: codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		clocks = <&cru SCLK_I2S_8CH_OUT>;
> -		clock-names = "mclk";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			es8316_p0_0: endpoint {
> -				remote-endpoint = <&i2s0_p0_0>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -};
> -
> -&i2s0 {
> -	pinctrl-0 = <&i2s0_2ch_bus>;
> -	pinctrl-1 = <&i2s0_2ch_bus_bclk_off>;
> -	rockchip,capture-channels = <2>;
> -	rockchip,playback-channels = <2>;
> -	status = "okay";
> -
> -	i2s0_p0: port {
> -		i2s0_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&es8316_p0_0>;
> -		};
> -	};
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	audio-supply = <&vcca1v8_codec>;
> -	bt656-supply = <&vcc_3v0>;
> -	gpio1830-supply = <&vcc_3v0>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> -	pinctrl-names = "default";
> -	vpcie0v9-supply = <&vcc_0v9>;
> -	vpcie1v8-supply = <&vcc_1v8>;
> -	vpcie3v3-supply = <&vcc3v3_pcie>;
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	bt {
> -		bt_enable_h: bt-enable-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	es8316 {
> -		hp_detect: hp-detect {
> -			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		hp_int: hp-int {
> -			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		user_led2: user-led2 {
> -			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_pwr_en: pcie-pwr-en {
> -			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdio0 {
> -		sdio0_bus4: sdio0-bus4 {
> -			rockchip,pins = <2 RK_PC4 1 &pcfg_pull_up_20ma>,
> -					<2 RK_PC5 1 &pcfg_pull_up_20ma>,
> -					<2 RK_PC6 1 &pcfg_pull_up_20ma>,
> -					<2 RK_PC7 1 &pcfg_pull_up_20ma>;
> -		};
> -
> -		sdio0_cmd: sdio0-cmd {
> -			rockchip,pins = <2 RK_PD0 1 &pcfg_pull_up_20ma>;
> -		};
> -
> -		sdio0_clk: sdio0-clk {
> -			rockchip,pins = <2 RK_PD1 1 &pcfg_pull_none_20ma>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc5v0_typec_en: vcc5v0-typec-en {
> -			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	status = "okay";
> -
> -	vref-supply = <&vcc_1v8>;
> -};
> -
> -&sdhci {
> -	max-frequency = <150000000>;
> -	bus-width = <8>;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	bus-width = <4>;
> -	clock-frequency = <50000000>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cd &sdmmc_cmd &sdmmc_bus4>;
> -	status = "okay";
> -};
> -
> -&spdif {
> -
> -	spdif_p0: port {
> -		spdif_p0_0: endpoint {
> -			remote-endpoint = <&dit_p0_0>;
> -		};
> -	};
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	status = "okay";
> -
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts b/arch/arm/dts/rk3399-rock-pi-4a.dts
> deleted file mode 100644
> index d5df8939a658..000000000000
> --- a/arch/arm/dts/rk3399-rock-pi-4a.dts
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
> - * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
> - */
> -
> -/dts-v1/;
> -#include "rk3399-rock-pi-4.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK Pi 4A";
> -	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4c.dts b/arch/arm/dts/rk3399-rock-pi-4c.dts
> deleted file mode 100644
> index de2ebe4cb4f3..000000000000
> --- a/arch/arm/dts/rk3399-rock-pi-4c.dts
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> - * Copyright (c) 2019 Radxa Limited
> - * Copyright (c) 2019 Amarula Solutions(India)
> - */
> -
> -/dts-v1/;
> -#include "rk3399-rock-pi-4.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK Pi 4C";
> -	compatible = "radxa,rockpi4c", "radxa,rockpi4", "rockchip,rk3399";
> -
> -	aliases {
> -		mmc2 = &sdio0;
> -	};
> -};
> -
> -&es8316 {
> -	pinctrl-0 = <&hp_detect &hp_int>;
> -	pinctrl-names = "default";
> -	interrupt-parent = <&gpio1>;
> -	interrupts = <RK_PA1 IRQ_TYPE_LEVEL_HIGH>;
> -};
> -
> -&sdio0 {
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sound {
> -	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -	};
> -};
> -
> -&uart0 {
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm4345c5";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		max-speed = <1500000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&vcc5v0_host {
> -	gpio = <&gpio3 RK_PD6 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&vcc5v0_host_en {
> -	rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -};
> diff --git a/arch/arm/dts/rk3399-rock960.dts b/arch/arm/dts/rk3399-rock960.dts
> deleted file mode 100644
> index 1a23e8f3cdf6..000000000000
> --- a/arch/arm/dts/rk3399-rock960.dts
> +++ /dev/null
> @@ -1,156 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2018 Linaro Ltd.
> - */
> -
> -/dts-v1/;
> -#include "rk3399-rock960.dtsi"
> -
> -/ {
> -	model = "96boards Rock960";
> -	compatible = "vamrs,rock960", "rockchip,rk3399";
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&user_led1_pin>, <&user_led2_pin>,
> -			    <&user_led3_pin>, <&user_led4_pin>,
> -			    <&wlan_led_pin>, <&bt_led_pin>;
> -
> -		user_led1: led-1 {
> -			label = "green:user1";
> -			gpios = <&gpio4 RK_PC2 0>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -
> -		user_led2: led-2 {
> -			label = "green:user2";
> -			gpios = <&gpio4 RK_PC6 0>;
> -			linux,default-trigger = "mmc0";
> -		};
> -
> -		user_led3: led-3 {
> -			label = "green:user3";
> -			gpios = <&gpio4 RK_PD0 0>;
> -			linux,default-trigger = "mmc1";
> -		};
> -
> -		user_led4: led-4 {
> -			label = "green:user4";
> -			gpios = <&gpio4 RK_PD4 0>;
> -			panic-indicator;
> -			linux,default-trigger = "none";
> -		};
> -
> -		wlan_active_led: led-5 {
> -			label = "yellow:wlan";
> -			gpios = <&gpio4 RK_PD5 0>;
> -			linux,default-trigger = "phy0tx";
> -			default-state = "off";
> -		};
> -
> -		bt_active_led: led-6 {
> -			label = "blue:bt";
> -			gpios = <&gpio4 RK_PD6 0>;
> -			linux,default-trigger = "hci0-power";
> -			default-state = "off";
> -		};
> -	};
> -
> -};
> -
> -&cpu_alert0 {
> -	temperature = <65000>;
> -};
> -
> -&cpu_thermal {
> -	sustainable-power = <1550>;
> -
> -	cooling-maps {
> -		map0 {
> -			trip = <&cpu_alert1>;
> -		};
> -	};
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&pinctrl {
> -	leds {
> -		user_led1_pin: user-led1-pin {
> -			rockchip,pins =
> -				<4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led2_pin: user-led2-pin {
> -			rockchip,pins =
> -				<4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led3_pin: user-led3-pin {
> -			rockchip,pins =
> -				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		user_led4_pin: user-led4-pin {
> -			rockchip,pins =
> -				<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		wlan_led_pin: wlan-led-pin {
> -			rockchip,pins =
> -				<4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_led_pin: bt-led-pin {
> -			rockchip,pins =
> -				<4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_drv: pcie-drv {
> -			rockchip,pins =
> -				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> -			};
> -	};
> -
> -	usb2 {
> -		host_vbus_drv: host-vbus-drv {
> -			rockchip,pins =
> -				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&spi0 {
> -	/* On Low speed expansion (LS-SPI0) */
> -	status = "okay";
> -};
> -
> -&spi4 {
> -	/* On High speed expansion (HS-SPI1) */
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	dr_mode = "otg";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	dr_mode = "host";
> -};
> -
> -&vcc3v3_pcie {
> -	gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&vcc5v0_host {
> -	gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
> -};
> diff --git a/arch/arm/dts/rk3399-rock960.dtsi b/arch/arm/dts/rk3399-rock960.dtsi
> deleted file mode 100644
> index c920ddf44baf..000000000000
> --- a/arch/arm/dts/rk3399-rock960.dtsi
> +++ /dev/null
> @@ -1,673 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2018 Collabora Ltd.
> - * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> - * Copyright (c) 2018 Linaro Ltd.
> - */
> -
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -#include <dt-bindings/interrupt-controller/irq.h>
> -
> -/ {
> -	aliases {
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc1v8_s0: vcc1v8-s0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s0";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		regulator-always-on;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_pcie: vcc3v3-pcie-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_drv>;
> -		regulator-boot-on;
> -		regulator-name = "vcc3v3_pcie";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&host_vbus_drv>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc_0v9: vcc-0v9 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_0v9";
> -		regulator-always-on;
> -		regulator-min-microvolt = <900000>;
> -		regulator-max-microvolt = <900000>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	avdd-0v9-supply = <&vcca0v9_hdmi>;
> -	avdd-1v8-supply = <&vcca1v8_hdmi>;
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -		status = "okay";
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc5v0_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcca1v8_hdmi: LDO_REG2 {
> -				regulator-name = "vcca1v8_hdmi";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcca_1v8: LDO_REG3 {
> -				regulator-name = "vcca_1v8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sd: LDO_REG4 {
> -				regulator-name = "vcc_sd";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc3v0_sd: LDO_REG5 {
> -				regulator-name = "vcc3v0_sd";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca0v9_hdmi: LDO_REG7 {
> -				regulator-name = "vcca0v9_hdmi";
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -};
> -
> -&i2c3 {
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	status = "okay";
> -};
> -
> -&i2s2 {
> -        status = "okay";
> -};
> -
> -&io_domains {
> -	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
> -	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
> -	sdmmc-supply = <&vcc_sd>; /* sdmmc_gpio4b_ms */
> -	gpio1830-supply = <&vcc_3v0>; /* gpio1833_gpio4cd_ms */
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	vpcie0v9-supply = <&vcc_0v9>;
> -	vpcie1v8-supply = <&vcca_1v8>;
> -	vpcie3v3-supply = <&vcc3v3_pcie>;
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_1v8>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	bt {
> -		bt_enable_h: bt-enable-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdmmc {
> -		sdmmc_bus1: sdmmc-bus1 {
> -			rockchip,pins =
> -				<4 RK_PB0 1 &pcfg_pull_up_8ma>;
> -		};
> -
> -		sdmmc_bus4: sdmmc-bus4 {
> -			rockchip,pins =
> -				<4 RK_PB0 1 &pcfg_pull_up_8ma>,
> -				<4 RK_PB1 1 &pcfg_pull_up_8ma>,
> -				<4 RK_PB2 1 &pcfg_pull_up_8ma>,
> -				<4 RK_PB3 1 &pcfg_pull_up_8ma>;
> -		};
> -
> -		sdmmc_clk: sdmmc-clk {
> -			rockchip,pins =
> -				<4 RK_PB4 1 &pcfg_pull_none_18ma>;
> -		};
> -
> -		sdmmc_cmd: sdmmc-cmd {
> -			rockchip,pins =
> -				<4 RK_PB5 1 &pcfg_pull_up_8ma>;
> -		};
> -	};
> -
> -	sdio0 {
> -		sdio0_bus4: sdio0-bus4 {
> -			rockchip,pins =
> -				<2 RK_PC4 1 &pcfg_pull_up_20ma>,
> -				<2 RK_PC5 1 &pcfg_pull_up_20ma>,
> -				<2 RK_PC6 1 &pcfg_pull_up_20ma>,
> -				<2 RK_PC7 1 &pcfg_pull_up_20ma>;
> -		};
> -
> -		sdio0_cmd: sdio0-cmd {
> -			rockchip,pins =
> -				<2 RK_PD0 1 &pcfg_pull_up_20ma>;
> -		};
> -
> -		sdio0_clk: sdio0-clk {
> -			rockchip,pins =
> -				<2 RK_PD1 1 &pcfg_pull_none_20ma>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins =
> -				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins =
> -				<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins =
> -				<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins =
> -				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifi {
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&pwm3 {
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	clock-frequency = <50000000>;
> -	cap-sdio-irq;
> -	cap-sd-highspeed;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	clock-frequency = <100000000>;
> -	max-frequency = <100000000>;
> -	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	sd-uhs-sdr104;
> -	vqmmc-supply = <&vcc_sd>;
> -	card-detect-delay = <800>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>;
> -	rockchip,hw-tshut-polarity = <1>;
> -	rockchip,hw-tshut-temp = <110000>;
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -};
> -
> -&u2phy0_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy1_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy0_otg {
> -	status = "okay";
> -};
> -
> -&u2phy1_otg {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-rockpro64.dts b/arch/arm/dts/rk3399-rockpro64.dts
> deleted file mode 100644
> index 4b42717800f7..000000000000
> --- a/arch/arm/dts/rk3399-rockpro64.dts
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> - * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> - * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
> - */
> -
> -/dts-v1/;
> -#include "rk3399-rockpro64.dtsi"
> -
> -/ {
> -	model = "Pine64 RockPro64 v2.1";
> -	compatible = "pine64,rockpro64-v2.1", "pine64,rockpro64", "rockchip,rk3399";
> -};
> -
> -&i2c1 {
> -	es8316: codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		clocks = <&cru SCLK_I2S_8CH_OUT>;
> -		clock-names = "mclk";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			es8316_p0_0: endpoint {
> -				remote-endpoint = <&i2s1_p0_0>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-rockpro64.dtsi b/arch/arm/dts/rk3399-rockpro64.dtsi
> deleted file mode 100644
> index f30b82a10ca3..000000000000
> --- a/arch/arm/dts/rk3399-rockpro64.dtsi
> +++ /dev/null
> @@ -1,956 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> - * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> - */
> -
> -#include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -
> -/ {
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdio0;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	/* enable for panel backlight support */
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		brightness-levels = <0 4 8 16 32 64 128 255>;
> -		default-brightness-level = <5>;
> -		pwms = <&pwm0 0 1000000 0>;
> -		status = "disabled";
> -	};
> -
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn>;
> -
> -		key-power {
> -			debounce-interval = <100>;
> -			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> -		pinctrl-0 = <&ir_int>;
> -		pinctrl-names = "default";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&work_led_pin>, <&diy_led_pin>;
> -
> -		work_led: led-0 {
> -			label = "work";
> -			default-state = "on";
> -			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		diy_led: led-1 {
> -			label = "diy";
> -			default-state = "off";
> -			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		cooling-levels = <0 100 150 200 255>;
> -		#cooling-cells = <2>;
> -		fan-supply = <&vcc12v_dcin>;
> -		pwms = <&pwm1 0 50000 0>;
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	sound {
> -		compatible = "audio-graph-card";
> -		label = "Analog";
> -		dais = <&i2s1_p0>;
> -	};
> -
> -	sound-dit {
> -		compatible = "audio-graph-card";
> -		label = "SPDIF";
> -		dais = <&spdif_p0>;
> -	};
> -
> -	spdif-dit {
> -		compatible = "linux,spdif-dit";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			dit_p0_0: endpoint {
> -				remote-endpoint = <&spdif_p0_0>;
> -			};
> -		};
> -	};
> -
> -	avdd: avdd-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "avdd";
> -		regulator-min-microvolt = <11000000>;
> -		regulator-max-microvolt = <11000000>;
> -		vin-supply = <&vcc3v3_s0>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	/* switched by pmic_sleep */
> -	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc1v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_1v8>;
> -	};
> -
> -	/* micro SD card power */
> -	vcc3v0_sd: vcc3v0-sd {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc0_pwr_h>;
> -		regulator-name = "vcc3v0_sd";
> -		regulator-always-on;
> -		regulator-min-microvolt = <3000000>;
> -		regulator-max-microvolt = <3000000>;
> -		vin-supply = <&vcc3v3_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vcc3v3_pcie: vcc3v3-pcie-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_pwr_en>;
> -		regulator-name = "vcc3v3_pcie";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_usb>;
> -	};
> -
> -	vcc5v0_typec: vcc5v0-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_typec_en>;
> -		regulator-name = "vcc5v0_typec";
> -		regulator-always-on;
> -		vin-supply = <&vcc5v0_usb>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		pwm-supply = <&vcc5v0_sys>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1700000>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_b>;
> -};
> -
> -&cpu_thermal {
> -	trips {
> -		cpu_warm: cpu_warm {
> -			temperature = <55000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -
> -		cpu_hot: cpu_hot {
> -			temperature = <65000>;
> -			hysteresis = <2000>;
> -			type = "active";
> -		};
> -	};
> -
> -	cooling-maps {
> -		map2 {
> -			trip = <&cpu_warm>;
> -			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> -		};
> -
> -		map3 {
> -			trip = <&cpu_hot>;
> -			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> -		};
> -	};
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	assigned-clock-parents = <&clkin_gmac>;
> -	clock_in_out = "input";
> -	phy-supply = <&vcc_lan>;
> -	phy-mode = "rgmii";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 50000>;
> -	tx_delay = <0x28>;
> -	rx_delay = <0x11>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -	status = "okay";
> -};
> -
> -&hdmi_sound {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-rising-time-ns = <168>;
> -	i2c-scl-falling-time-ns = <4>;
> -	status = "okay";
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc5v0_sys>;
> -		vcc12-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcca_1v8>;
> -
> -		regulators {
> -			vdd_center: DCDC_REG1 {
> -				regulator-name = "vdd_center";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8: DCDC_REG4 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc1v8_dvp: LDO_REG1 {
> -				regulator-name = "vcc1v8_dvp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v0_touch: LDO_REG2 {
> -				regulator-name = "vcc3v0_touch";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcca_1v8: LDO_REG3 {
> -				regulator-name = "vcca_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sdio: LDO_REG4 {
> -				regulator-name = "vcc_sdio";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcca3v0_codec: LDO_REG5 {
> -				regulator-name = "vcca3v0_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1500000>;
> -				};
> -			};
> -
> -			vcca1v8_codec: LDO_REG7 {
> -				regulator-name = "vcca1v8_codec";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v0: LDO_REG8 {
> -				regulator-name = "vcc_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
> -				regulator-name = "vcc3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_s0: SWITCH_REG2 {
> -				regulator-name = "vcc3v3_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	vdd_cpu_b: regulator@40 {
> -		compatible = "silergy,syr827";
> -		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel1_pin>;
> -		regulator-name = "vdd_cpu_b";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_gpu: regulator@41 {
> -		compatible = "silergy,syr828";
> -		reg = <0x41>;
> -		fcs,suspend-voltage-selector = <1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vsel2_pin>;
> -		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <712500>;
> -		regulator-max-microvolt = <1500000>;
> -		regulator-ramp-delay = <1000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-rising-time-ns = <300>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	i2c-scl-rising-time-ns = <600>;
> -	i2c-scl-falling-time-ns = <20>;
> -	status = "okay";
> -
> -	fusb0: typec-portc@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&fusb0_int>;
> -		vbus-supply = <&vcc5v0_typec>;
> -		status = "okay";
> -	};
> -
> -	/* enable for pine64 touch screen support */
> -	touch: touchscreen@5d {
> -		compatible = "goodix,gt911";
> -		reg = <0x5d>;
> -		interrupt-parent = <&gpio4>;
> -		interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
> -		AVDD28-supply = <&vcc3v0_touch>;
> -		VDDIO-supply = <&vcc3v0_touch>;
> -		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> -		status = "disabled";
> -	};
> -};
> -
> -&i2s0 {
> -	rockchip,playback-channels = <8>;
> -	rockchip,capture-channels = <8>;
> -	status = "okay";
> -};
> -
> -&i2s1 {
> -	rockchip,playback-channels = <2>;
> -	rockchip,capture-channels = <2>;
> -	status = "okay";
> -
> -	i2s1_p0: port {
> -		i2s1_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&es8316_p0_0>;
> -		};
> -	};
> -};
> -
> -&i2s2 {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	status = "okay";
> -
> -	bt656-supply = <&vcc1v8_dvp>;
> -	audio-supply = <&vcc_3v0>;
> -	sdmmc-supply = <&vcc_sdio>;
> -	gpio1830-supply = <&vcc_3v0>;
> -};
> -
> -/* enable for pine64 panel display support */
> -&mipi_dsi {
> -	clock-master;
> -	status = "disabled";
> -
> -	ports {
> -		mipi_out: port@1 {
> -			reg = <1>;
> -
> -			mipi_out_panel: endpoint {
> -				remote-endpoint = <&mipi_in_panel>;
> -			};
> -		};
> -	};
> -
> -	mipi_panel: panel@0 {
> -		compatible = "feiyang,fy07024di26a30d";
> -		reg = <0>;
> -		avdd-supply = <&avdd>;
> -		backlight = <&backlight>;
> -		dvdd-supply = <&vcc3v3_s0>;
> -
> -		port {
> -			mipi_in_panel: endpoint {
> -				remote-endpoint = <&mipi_out_panel>;
> -			};
> -		};
> -	};
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_perst>;
> -	vpcie12v-supply = <&vcc12v_dcin>;
> -	vpcie3v3-supply = <&vcc3v3_pcie>;
> -	status = "okay";
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	pmu1830-supply = <&vcc_3v0>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	bt {
> -		bt_enable_h: bt-enable-h {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_host_wake_l: bt-host-wake-l {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		bt_wake_l: bt-wake-l {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	buttons {
> -		pwrbtn: pwrbtn {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	fusb302x {
> -		fusb0_int: fusb0-int {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	ir {
> -		ir_int: ir-int {
> -			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		work_led_pin: work-led-pin {
> -			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		diy_led_pin: diy-led-pin {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_perst: pcie-perst {
> -			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie_pwr_en: pcie-pwr-en {
> -			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vsel1_pin: vsel1-pin {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		vsel2_pin: vsel2-pin {
> -			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	sdcard {
> -		sdmmc0_pwr_h: sdmmc0-pwr-h {
> -			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb-typec {
> -		vcc5v0_typec_en: vcc5v0_typec_en {
> -			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb2 {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcca1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdio0 {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	disable-wp;
> -	keep-power-in-suspend;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> -	sd-uhs-sdr104;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	vmmc-supply = <&vcc3v0_sd>;
> -	vqmmc-supply = <&vcc_sdio>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs200-1_8v;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&spdif {
> -	pinctrl-0 = <&spdif_bus_1>;
> -
> -	spdif_p0: port {
> -		spdif_p0_0: endpoint {
> -			remote-endpoint = <&dit_p0_0>;
> -		};
> -	};
> -};
> -
> -&spi1 {
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -	};
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tcphy1 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	/* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-mode = <1>;
> -	/* tshut polarity 0:LOW 1:HIGH */
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_otg: otg-port {
> -		status = "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vcc5v0_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		clocks = <&rk808 1>;
> -		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> -		vbat-supply = <&vcc3v3_sys>;
> -		vddio-supply = <&vcc_1v8>;
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&usbdrd3_1 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_1 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-t-opp.dtsi b/arch/arm/dts/rk3399-t-opp.dtsi
> deleted file mode 100644
> index 1ababadda9df..000000000000
> --- a/arch/arm/dts/rk3399-t-opp.dtsi
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> - * Copyright (c) 2022 Radxa Limited
> - */
> -
> -/ {
> -	cluster0_opp: opp-table-0 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <875000 875000 1250000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <875000 875000 1250000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <900000 900000 1250000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <975000 975000 1250000>;
> -		};
> -	};
> -
> -	cluster1_opp: opp-table-1 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <875000 875000 1250000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <875000 875000 1250000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <875000 875000 1250000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <925000 925000 1250000>;
> -		};
> -		opp04 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <1000000 1000000 1250000>;
> -		};
> -		opp05 {
> -			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <1075000 1075000 1250000>;
> -		};
> -		opp06 {
> -			opp-hz = /bits/ 64 <1512000000>;
> -			opp-microvolt = <1150000 1150000 1250000>;
> -		};
> -	};
> -
> -	gpu_opp_table: opp-table-2 {
> -		compatible = "operating-points-v2";
> -
> -		opp00 {
> -			opp-hz = /bits/ 64 <200000000>;
> -			opp-microvolt = <875000 875000 1150000>;
> -		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <300000000>;
> -			opp-microvolt = <875000 875000 1150000>;
> -		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <400000000>;
> -			opp-microvolt = <875000 875000 1150000>;
> -		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <975000 975000 1150000>;
> -		};
> -	};
> -};
> -
> -&cpu_l0 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l1 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l2 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_l3 {
> -	operating-points-v2 = <&cluster0_opp>;
> -};
> -
> -&cpu_b0 {
> -	operating-points-v2 = <&cluster1_opp>;
> -};
> -
> -&cpu_b1 {
> -	operating-points-v2 = <&cluster1_opp>;
> -};
> -
> -&gpu {
> -	operating-points-v2 = <&gpu_opp_table>;
> -};
> diff --git a/arch/arm/dts/rk3399.dtsi b/arch/arm/dts/rk3399.dtsi
> deleted file mode 100644
> index 6e12c5a920ca..000000000000
> --- a/arch/arm/dts/rk3399.dtsi
> +++ /dev/null
> @@ -1,2945 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> - */
> -
> -#include <dt-bindings/clock/rk3399-cru.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/power/rk3399-power.h>
> -#include <dt-bindings/thermal/thermal.h>
> -
> -/ {
> -	compatible = "rockchip,rk3399";
> -
> -	interrupt-parent = <&gic>;
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -
> -	aliases {
> -		gpio0 = &gpio0;
> -		gpio1 = &gpio1;
> -		gpio2 = &gpio2;
> -		gpio3 = &gpio3;
> -		gpio4 = &gpio4;
> -		i2c0 = &i2c0;
> -		i2c1 = &i2c1;
> -		i2c2 = &i2c2;
> -		i2c3 = &i2c3;
> -		i2c4 = &i2c4;
> -		i2c5 = &i2c5;
> -		i2c6 = &i2c6;
> -		i2c7 = &i2c7;
> -		i2c8 = &i2c8;
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -		serial3 = &uart3;
> -		serial4 = &uart4;
> -	};
> -
> -	cpus {
> -		#address-cells = <2>;
> -		#size-cells = <0>;
> -
> -		cpu-map {
> -			cluster0 {
> -				core0 {
> -					cpu = <&cpu_l0>;
> -				};
> -				core1 {
> -					cpu = <&cpu_l1>;
> -				};
> -				core2 {
> -					cpu = <&cpu_l2>;
> -				};
> -				core3 {
> -					cpu = <&cpu_l3>;
> -				};
> -			};
> -
> -			cluster1 {
> -				core0 {
> -					cpu = <&cpu_b0>;
> -				};
> -				core1 {
> -					cpu = <&cpu_b1>;
> -				};
> -			};
> -		};
> -
> -		cpu_l0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x0>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <485>;
> -			clocks = <&cru ARMCLKL>;
> -			#cooling-cells = <2>; /* min followed by max */
> -			dynamic-power-coefficient = <100>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> -		};
> -
> -		cpu_l1: cpu@1 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x1>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <485>;
> -			clocks = <&cru ARMCLKL>;
> -			#cooling-cells = <2>; /* min followed by max */
> -			dynamic-power-coefficient = <100>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> -		};
> -
> -		cpu_l2: cpu@2 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x2>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <485>;
> -			clocks = <&cru ARMCLKL>;
> -			#cooling-cells = <2>; /* min followed by max */
> -			dynamic-power-coefficient = <100>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> -		};
> -
> -		cpu_l3: cpu@3 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x3>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <485>;
> -			clocks = <&cru ARMCLKL>;
> -			#cooling-cells = <2>; /* min followed by max */
> -			dynamic-power-coefficient = <100>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> -		};
> -
> -		cpu_b0: cpu@100 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a72";
> -			reg = <0x0 0x100>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <1024>;
> -			clocks = <&cru ARMCLKB>;
> -			#cooling-cells = <2>; /* min followed by max */
> -			dynamic-power-coefficient = <436>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> -
> -			thermal-idle {
> -				#cooling-cells = <2>;
> -				duration-us = <10000>;
> -				exit-latency-us = <500>;
> -			};
> -		};
> -
> -		cpu_b1: cpu@101 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a72";
> -			reg = <0x0 0x101>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <1024>;
> -			clocks = <&cru ARMCLKB>;
> -			#cooling-cells = <2>; /* min followed by max */
> -			dynamic-power-coefficient = <436>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> -
> -			thermal-idle {
> -				#cooling-cells = <2>;
> -				duration-us = <10000>;
> -				exit-latency-us = <500>;
> -			};
> -		};
> -
> -		idle-states {
> -			entry-method = "psci";
> -
> -			CPU_SLEEP: cpu-sleep {
> -				compatible = "arm,idle-state";
> -				local-timer-stop;
> -				arm,psci-suspend-param = <0x0010000>;
> -				entry-latency-us = <120>;
> -				exit-latency-us = <250>;
> -				min-residency-us = <900>;
> -			};
> -
> -			CLUSTER_SLEEP: cluster-sleep {
> -				compatible = "arm,idle-state";
> -				local-timer-stop;
> -				arm,psci-suspend-param = <0x1010000>;
> -				entry-latency-us = <400>;
> -				exit-latency-us = <500>;
> -				min-residency-us = <2000>;
> -			};
> -		};
> -	};
> -
> -	display-subsystem {
> -		compatible = "rockchip,display-subsystem";
> -		ports = <&vopl_out>, <&vopb_out>;
> -	};
> -
> -	dmc: memory-controller {
> -		compatible = "rockchip,rk3399-dmc";
> -		rockchip,pmu = <&pmugrf>;
> -		devfreq-events = <&dfi>;
> -		clocks = <&cru SCLK_DDRC>;
> -		clock-names = "dmc_clk";
> -		status = "disabled";
> -	};
> -
> -	pmu_a53 {
> -		compatible = "arm,cortex-a53-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
> -	};
> -
> -	pmu_a72 {
> -		compatible = "arm,cortex-a72-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster1>;
> -	};
> -
> -	psci {
> -		compatible = "arm,psci-1.0";
> -		method = "smc";
> -	};
> -
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
> -			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
> -			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
> -			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
> -		arm,no-tick-in-suspend;
> -	};
> -
> -	xin24m: xin24m {
> -		compatible = "fixed-clock";
> -		clock-frequency = <24000000>;
> -		clock-output-names = "xin24m";
> -		#clock-cells = <0>;
> -	};
> -
> -	pcie0: pcie@f8000000 {
> -		compatible = "rockchip,rk3399-pcie";
> -		reg = <0x0 0xf8000000 0x0 0x2000000>,
> -		      <0x0 0xfd000000 0x0 0x1000000>;
> -		reg-names = "axi-base", "apb-base";
> -		device_type = "pci";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -		aspm-no-l0s;
> -		bus-range = <0x0 0x1f>;
> -		clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> -			 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> -		clock-names = "aclk", "aclk-perf",
> -			      "hclk", "pm";
> -		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sys", "legacy", "client";
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
> -				<0 0 0 2 &pcie0_intc 1>,
> -				<0 0 0 3 &pcie0_intc 2>,
> -				<0 0 0 4 &pcie0_intc 3>;
> -		max-link-speed = <1>;
> -		msi-map = <0x0 &its 0x0 0x1000>;
> -		phys = <&pcie_phy 0>, <&pcie_phy 1>,
> -		       <&pcie_phy 2>, <&pcie_phy 3>;
> -		phy-names = "pcie-phy-0", "pcie-phy-1",
> -			    "pcie-phy-2", "pcie-phy-3";
> -		ranges = <0x82000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
> -			 <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
> -		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> -			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
> -			 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>,
> -			 <&cru SRST_A_PCIE>;
> -		reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
> -			      "pm", "pclk", "aclk";
> -		status = "disabled";
> -
> -		pcie0_intc: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -	pcie0_ep: pcie-ep@f8000000 {
> -		compatible = "rockchip,rk3399-pcie-ep";
> -		reg = <0x0 0xfd000000 0x0 0x1000000>,
> -		      <0x0 0xfa000000 0x0 0x2000000>;
> -		reg-names = "apb-base", "mem-base";
> -		clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> -			 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> -		clock-names = "aclk", "aclk-perf",
> -			      "hclk", "pm";
> -		max-functions = /bits/ 8 <8>;
> -		num-lanes = <4>;
> -		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> -			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
> -			 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>,
> -			 <&cru SRST_A_PCIE>;
> -		reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
> -			      "pm", "pclk", "aclk";
> -		phys = <&pcie_phy 0>, <&pcie_phy 1>,
> -		       <&pcie_phy 2>, <&pcie_phy 3>;
> -		phy-names = "pcie-phy-0", "pcie-phy-1",
> -			    "pcie-phy-2", "pcie-phy-3";
> -		rockchip,max-outbound-regions = <32>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_clkreqnb_cpm>;
> -		status = "disabled";
> -	};
> -
> -	gmac: ethernet@fe300000 {
> -		compatible = "rockchip,rk3399-gmac";
> -		reg = <0x0 0xfe300000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "macirq";
> -		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
> -			 <&cru SCLK_MAC_TX>, <&cru SCLK_MACREF>,
> -			 <&cru SCLK_MACREF_OUT>, <&cru ACLK_GMAC>,
> -			 <&cru PCLK_GMAC>;
> -		clock-names = "stmmaceth", "mac_clk_rx",
> -			      "mac_clk_tx", "clk_mac_ref",
> -			      "clk_mac_refout", "aclk_mac",
> -			      "pclk_mac";
> -		power-domains = <&power RK3399_PD_GMAC>;
> -		resets = <&cru SRST_A_GMAC>;
> -		reset-names = "stmmaceth";
> -		rockchip,grf = <&grf>;
> -		snps,txpbl = <0x4>;
> -		status = "disabled";
> -	};
> -
> -	sdio0: mmc@fe310000 {
> -		compatible = "rockchip,rk3399-dw-mshc",
> -			     "rockchip,rk3288-dw-mshc";
> -		reg = <0x0 0xfe310000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH 0>;
> -		max-frequency = <150000000>;
> -		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
> -			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> -		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth = <0x100>;
> -		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> -		resets = <&cru SRST_SDIO0>;
> -		reset-names = "reset";
> -		status = "disabled";
> -	};
> -
> -	sdmmc: mmc@fe320000 {
> -		compatible = "rockchip,rk3399-dw-mshc",
> -			     "rockchip,rk3288-dw-mshc";
> -		reg = <0x0 0xfe320000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH 0>;
> -		max-frequency = <150000000>;
> -		assigned-clocks = <&cru HCLK_SD>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> -			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> -		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth = <0x100>;
> -		power-domains = <&power RK3399_PD_SD>;
> -		resets = <&cru SRST_SDMMC>;
> -		reset-names = "reset";
> -		status = "disabled";
> -	};
> -
> -	sdhci: mmc@fe330000 {
> -		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> -		reg = <0x0 0xfe330000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>;
> -		arasan,soc-ctl-syscon = <&grf>;
> -		assigned-clocks = <&cru SCLK_EMMC>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> -		clock-names = "clk_xin", "clk_ahb";
> -		clock-output-names = "emmc_cardclock";
> -		#clock-cells = <0>;
> -		phys = <&emmc_phy>;
> -		phy-names = "phy_arasan";
> -		power-domains = <&power RK3399_PD_EMMC>;
> -		disable-cqe-dcmd;
> -		status = "disabled";
> -	};
> -
> -	usb_host0_ehci: usb@fe380000 {
> -		compatible = "generic-ehci";
> -		reg = <0x0 0xfe380000 0x0 0x20000>;
> -		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
> -			 <&u2phy0>;
> -		phys = <&u2phy0_host>;
> -		phy-names = "usb";
> -		status = "disabled";
> -	};
> -
> -	usb_host0_ohci: usb@fe3a0000 {
> -		compatible = "generic-ohci";
> -		reg = <0x0 0xfe3a0000 0x0 0x20000>;
> -		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
> -			 <&u2phy0>;
> -		phys = <&u2phy0_host>;
> -		phy-names = "usb";
> -		status = "disabled";
> -	};
> -
> -	usb_host1_ehci: usb@fe3c0000 {
> -		compatible = "generic-ehci";
> -		reg = <0x0 0xfe3c0000 0x0 0x20000>;
> -		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
> -			 <&u2phy1>;
> -		phys = <&u2phy1_host>;
> -		phy-names = "usb";
> -		status = "disabled";
> -	};
> -
> -	usb_host1_ohci: usb@fe3e0000 {
> -		compatible = "generic-ohci";
> -		reg = <0x0 0xfe3e0000 0x0 0x20000>;
> -		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
> -			 <&u2phy1>;
> -		phys = <&u2phy1_host>;
> -		phy-names = "usb";
> -		status = "disabled";
> -	};
> -
> -	debug@fe430000 {
> -		compatible = "arm,coresight-cpu-debug", "arm,primecell";
> -		reg = <0 0xfe430000 0 0x1000>;
> -		clocks = <&cru PCLK_COREDBG_L>;
> -		clock-names = "apb_pclk";
> -		cpu = <&cpu_l0>;
> -	};
> -
> -	debug@fe432000 {
> -		compatible = "arm,coresight-cpu-debug", "arm,primecell";
> -		reg = <0 0xfe432000 0 0x1000>;
> -		clocks = <&cru PCLK_COREDBG_L>;
> -		clock-names = "apb_pclk";
> -		cpu = <&cpu_l1>;
> -	};
> -
> -	debug@fe434000 {
> -		compatible = "arm,coresight-cpu-debug", "arm,primecell";
> -		reg = <0 0xfe434000 0 0x1000>;
> -		clocks = <&cru PCLK_COREDBG_L>;
> -		clock-names = "apb_pclk";
> -		cpu = <&cpu_l2>;
> -	};
> -
> -	debug@fe436000 {
> -		compatible = "arm,coresight-cpu-debug", "arm,primecell";
> -		reg = <0 0xfe436000 0 0x1000>;
> -		clocks = <&cru PCLK_COREDBG_L>;
> -		clock-names = "apb_pclk";
> -		cpu = <&cpu_l3>;
> -	};
> -
> -	debug@fe610000 {
> -		compatible = "arm,coresight-cpu-debug", "arm,primecell";
> -		reg = <0 0xfe610000 0 0x1000>;
> -		clocks = <&cru PCLK_COREDBG_B>;
> -		clock-names = "apb_pclk";
> -		cpu = <&cpu_b0>;
> -	};
> -
> -	debug@fe710000 {
> -		compatible = "arm,coresight-cpu-debug", "arm,primecell";
> -		reg = <0 0xfe710000 0 0x1000>;
> -		clocks = <&cru PCLK_COREDBG_B>;
> -		clock-names = "apb_pclk";
> -		cpu = <&cpu_b1>;
> -	};
> -
> -	usbdrd3_0: usb@fe800000 {
> -		compatible = "rockchip,rk3399-dwc3";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> -			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> -			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> -		clock-names = "ref_clk", "suspend_clk",
> -			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
> -			      "aclk_usb3", "grf_clk";
> -		resets = <&cru SRST_A_USB3_OTG0>;
> -		reset-names = "usb3-otg";
> -		status = "disabled";
> -
> -		usbdrd_dwc3_0: usb@fe800000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0xfe800000 0x0 0x100000>;
> -			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,
> -				 <&cru SCLK_USB3OTG0_SUSPEND>;
> -			clock-names = "ref", "bus_early", "suspend";
> -			dr_mode = "otg";
> -			phys = <&u2phy0_otg>, <&tcphy0_usb3>;
> -			phy-names = "usb2-phy", "usb3-phy";
> -			phy_type = "utmi_wide";
> -			snps,dis_enblslpm_quirk;
> -			snps,dis-u2-freeclk-exists-quirk;
> -			snps,dis_u2_susphy_quirk;
> -			snps,dis-del-phy-power-chg-quirk;
> -			snps,dis-tx-ipgap-linecheck-quirk;
> -			power-domains = <&power RK3399_PD_USB3>;
> -			status = "disabled";
> -		};
> -	};
> -
> -	usbdrd3_1: usb@fe900000 {
> -		compatible = "rockchip,rk3399-dwc3";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
> -			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> -			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> -		clock-names = "ref_clk", "suspend_clk",
> -			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
> -			      "aclk_usb3", "grf_clk";
> -		resets = <&cru SRST_A_USB3_OTG1>;
> -		reset-names = "usb3-otg";
> -		status = "disabled";
> -
> -		usbdrd_dwc3_1: usb@fe900000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0xfe900000 0x0 0x100000>;
> -			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru SCLK_USB3OTG1_REF>, <&cru ACLK_USB3OTG1>,
> -				 <&cru SCLK_USB3OTG1_SUSPEND>;
> -			clock-names = "ref", "bus_early", "suspend";
> -			dr_mode = "otg";
> -			phys = <&u2phy1_otg>, <&tcphy1_usb3>;
> -			phy-names = "usb2-phy", "usb3-phy";
> -			phy_type = "utmi_wide";
> -			snps,dis_enblslpm_quirk;
> -			snps,dis-u2-freeclk-exists-quirk;
> -			snps,dis_u2_susphy_quirk;
> -			snps,dis-del-phy-power-chg-quirk;
> -			snps,dis-tx-ipgap-linecheck-quirk;
> -			power-domains = <&power RK3399_PD_USB3>;
> -			status = "disabled";
> -		};
> -	};
> -
> -	cdn_dp: dp@fec00000 {
> -		compatible = "rockchip,rk3399-cdn-dp";
> -		reg = <0x0 0xfec00000 0x0 0x100000>;
> -		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> -		assigned-clocks = <&cru SCLK_DP_CORE>, <&cru SCLK_SPDIF_REC_DPTX>;
> -		assigned-clock-rates = <100000000>, <200000000>;
> -		clocks = <&cru SCLK_DP_CORE>, <&cru PCLK_DP_CTRL>,
> -			 <&cru SCLK_SPDIF_REC_DPTX>, <&cru PCLK_VIO_GRF>;
> -		clock-names = "core-clk", "pclk", "spdif", "grf";
> -		phys = <&tcphy0_dp>, <&tcphy1_dp>;
> -		power-domains = <&power RK3399_PD_HDCP>;
> -		resets = <&cru SRST_DPTX_SPDIF_REC>, <&cru SRST_P_UPHY0_DPTX>,
> -			 <&cru SRST_P_UPHY0_APB>, <&cru SRST_DP_CORE>;
> -		reset-names = "spdif", "dptx", "apb", "core";
> -		rockchip,grf = <&grf>;
> -		#sound-dai-cells = <1>;
> -		status = "disabled";
> -
> -		ports {
> -			dp_in: port {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				dp_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_dp>;
> -				};
> -
> -				dp_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_dp>;
> -				};
> -			};
> -		};
> -	};
> -
> -	gic: interrupt-controller@fee00000 {
> -		compatible = "arm,gic-v3";
> -		#interrupt-cells = <4>;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -		interrupt-controller;
> -
> -		reg = <0x0 0xfee00000 0 0x10000>, /* GICD */
> -		      <0x0 0xfef00000 0 0xc0000>, /* GICR */
> -		      <0x0 0xfff00000 0 0x10000>, /* GICC */
> -		      <0x0 0xfff10000 0 0x10000>, /* GICH */
> -		      <0x0 0xfff20000 0 0x10000>; /* GICV */
> -		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> -		its: msi-controller@fee20000 {
> -			compatible = "arm,gic-v3-its";
> -			msi-controller;
> -			#msi-cells = <1>;
> -			reg = <0x0 0xfee20000 0x0 0x20000>;
> -		};
> -
> -		ppi-partitions {
> -			ppi_cluster0: interrupt-partition-0 {
> -				affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
> -			};
> -
> -			ppi_cluster1: interrupt-partition-1 {
> -				affinity = <&cpu_b0 &cpu_b1>;
> -			};
> -		};
> -	};
> -
> -	saradc: saradc@ff100000 {
> -		compatible = "rockchip,rk3399-saradc";
> -		reg = <0x0 0xff100000 0x0 0x100>;
> -		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH 0>;
> -		#io-channel-cells = <1>;
> -		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> -		clock-names = "saradc", "apb_pclk";
> -		resets = <&cru SRST_P_SARADC>;
> -		reset-names = "saradc-apb";
> -		status = "disabled";
> -	};
> -
> -	crypto0: crypto@ff8b0000 {
> -		compatible = "rockchip,rk3399-crypto";
> -		reg = <0x0 0xff8b0000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
> -		clock-names = "hclk_master", "hclk_slave", "sclk";
> -		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
> -		reset-names = "master", "slave", "crypto-rst";
> -	};
> -
> -	crypto1: crypto@ff8b8000 {
> -		compatible = "rockchip,rk3399-crypto";
> -		reg = <0x0 0xff8b8000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>, <&cru SCLK_CRYPTO1>;
> -		clock-names = "hclk_master", "hclk_slave", "sclk";
> -		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
> -		reset-names = "master", "slave", "crypto-rst";
> -	};
> -
> -	i2c1: i2c@ff110000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff110000 0x0 0x1000>;
> -		assigned-clocks = <&cru SCLK_I2C1>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c1_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c2: i2c@ff120000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff120000 0x0 0x1000>;
> -		assigned-clocks = <&cru SCLK_I2C2>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c2_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c3: i2c@ff130000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff130000 0x0 0x1000>;
> -		assigned-clocks = <&cru SCLK_I2C3>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c3_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c5: i2c@ff140000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff140000 0x0 0x1000>;
> -		assigned-clocks = <&cru SCLK_I2C5>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_I2C5>, <&cru PCLK_I2C5>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c5_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c6: i2c@ff150000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff150000 0x0 0x1000>;
> -		assigned-clocks = <&cru SCLK_I2C6>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_I2C6>, <&cru PCLK_I2C6>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c6_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c7: i2c@ff160000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff160000 0x0 0x1000>;
> -		assigned-clocks = <&cru SCLK_I2C7>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_I2C7>, <&cru PCLK_I2C7>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c7_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	uart0: serial@ff180000 {
> -		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xff180000 0x0 0x100>;
> -		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -		clock-names = "baudclk", "apb_pclk";
> -		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&uart0_xfer>;
> -		status = "disabled";
> -	};
> -
> -	uart1: serial@ff190000 {
> -		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xff190000 0x0 0x100>;
> -		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -		clock-names = "baudclk", "apb_pclk";
> -		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&uart1_xfer>;
> -		status = "disabled";
> -	};
> -
> -	uart2: serial@ff1a0000 {
> -		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xff1a0000 0x0 0x100>;
> -		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -		clock-names = "baudclk", "apb_pclk";
> -		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&uart2c_xfer>;
> -		status = "disabled";
> -	};
> -
> -	uart3: serial@ff1b0000 {
> -		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xff1b0000 0x0 0x100>;
> -		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
> -		clock-names = "baudclk", "apb_pclk";
> -		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&uart3_xfer>;
> -		status = "disabled";
> -	};
> -
> -	spi0: spi@ff1c0000 {
> -		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xff1c0000 0x0 0x1000>;
> -		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_peri 10>, <&dmac_peri 11>;
> -		dma-names = "tx", "rx";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi1: spi@ff1d0000 {
> -		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xff1d0000 0x0 0x1000>;
> -		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_peri 12>, <&dmac_peri 13>;
> -		dma-names = "tx", "rx";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi2: spi@ff1e0000 {
> -		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xff1e0000 0x0 0x1000>;
> -		clocks = <&cru SCLK_SPI2>, <&cru PCLK_SPI2>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_peri 14>, <&dmac_peri 15>;
> -		dma-names = "tx", "rx";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi4: spi@ff1f0000 {
> -		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xff1f0000 0x0 0x1000>;
> -		clocks = <&cru SCLK_SPI4>, <&cru PCLK_SPI4>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_peri 18>, <&dmac_peri 19>;
> -		dma-names = "tx", "rx";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi4_clk &spi4_tx &spi4_rx &spi4_cs0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi5: spi@ff200000 {
> -		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xff200000 0x0 0x1000>;
> -		clocks = <&cru SCLK_SPI5>, <&cru PCLK_SPI5>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_bus 8>, <&dmac_bus 9>;
> -		dma-names = "tx", "rx";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
> -		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	thermal_zones: thermal-zones {
> -		cpu_thermal: cpu-thermal {
> -			polling-delay-passive = <100>;
> -			polling-delay = <1000>;
> -
> -			thermal-sensors = <&tsadc 0>;
> -
> -			trips {
> -				cpu_alert0: cpu_alert0 {
> -					temperature = <70000>;
> -					hysteresis = <2000>;
> -					type = "passive";
> -				};
> -				cpu_alert1: cpu_alert1 {
> -					temperature = <75000>;
> -					hysteresis = <2000>;
> -					type = "passive";
> -				};
> -				cpu_crit: cpu_crit {
> -					temperature = <95000>;
> -					hysteresis = <2000>;
> -					type = "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu_alert0>;
> -					cooling-device =
> -						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu_alert1>;
> -					cooling-device =
> -						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -
> -		gpu_thermal: gpu-thermal {
> -			polling-delay-passive = <100>;
> -			polling-delay = <1000>;
> -
> -			thermal-sensors = <&tsadc 1>;
> -
> -			trips {
> -				gpu_alert0: gpu_alert0 {
> -					temperature = <75000>;
> -					hysteresis = <2000>;
> -					type = "passive";
> -				};
> -				gpu_crit: gpu_crit {
> -					temperature = <95000>;
> -					hysteresis = <2000>;
> -					type = "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&gpu_alert0>;
> -					cooling-device =
> -						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -	};
> -
> -	tsadc: tsadc@ff260000 {
> -		compatible = "rockchip,rk3399-tsadc";
> -		reg = <0x0 0xff260000 0x0 0x100>;
> -		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>;
> -		assigned-clocks = <&cru SCLK_TSADC>;
> -		assigned-clock-rates = <750000>;
> -		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> -		clock-names = "tsadc", "apb_pclk";
> -		resets = <&cru SRST_TSADC>;
> -		reset-names = "tsadc-apb";
> -		rockchip,grf = <&grf>;
> -		rockchip,hw-tshut-temp = <95000>;
> -		pinctrl-names = "init", "default", "sleep";
> -		pinctrl-0 = <&otp_pin>;
> -		pinctrl-1 = <&otp_out>;
> -		pinctrl-2 = <&otp_pin>;
> -		#thermal-sensor-cells = <1>;
> -		status = "disabled";
> -	};
> -
> -	qos_emmc: qos@ffa58000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa58000 0x0 0x20>;
> -	};
> -
> -	qos_gmac: qos@ffa5c000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa5c000 0x0 0x20>;
> -	};
> -
> -	qos_pcie: qos@ffa60080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa60080 0x0 0x20>;
> -	};
> -
> -	qos_usb_host0: qos@ffa60100 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa60100 0x0 0x20>;
> -	};
> -
> -	qos_usb_host1: qos@ffa60180 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa60180 0x0 0x20>;
> -	};
> -
> -	qos_usb_otg0: qos@ffa70000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa70000 0x0 0x20>;
> -	};
> -
> -	qos_usb_otg1: qos@ffa70080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa70080 0x0 0x20>;
> -	};
> -
> -	qos_sd: qos@ffa74000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa74000 0x0 0x20>;
> -	};
> -
> -	qos_sdioaudio: qos@ffa76000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa76000 0x0 0x20>;
> -	};
> -
> -	qos_hdcp: qos@ffa90000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa90000 0x0 0x20>;
> -	};
> -
> -	qos_iep: qos@ffa98000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffa98000 0x0 0x20>;
> -	};
> -
> -	qos_isp0_m0: qos@ffaa0000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffaa0000 0x0 0x20>;
> -	};
> -
> -	qos_isp0_m1: qos@ffaa0080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffaa0080 0x0 0x20>;
> -	};
> -
> -	qos_isp1_m0: qos@ffaa8000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffaa8000 0x0 0x20>;
> -	};
> -
> -	qos_isp1_m1: qos@ffaa8080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffaa8080 0x0 0x20>;
> -	};
> -
> -	qos_rga_r: qos@ffab0000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffab0000 0x0 0x20>;
> -	};
> -
> -	qos_rga_w: qos@ffab0080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffab0080 0x0 0x20>;
> -	};
> -
> -	qos_video_m0: qos@ffab8000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffab8000 0x0 0x20>;
> -	};
> -
> -	qos_video_m1_r: qos@ffac0000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffac0000 0x0 0x20>;
> -	};
> -
> -	qos_video_m1_w: qos@ffac0080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffac0080 0x0 0x20>;
> -	};
> -
> -	qos_vop_big_r: qos@ffac8000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffac8000 0x0 0x20>;
> -	};
> -
> -	qos_vop_big_w: qos@ffac8080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffac8080 0x0 0x20>;
> -	};
> -
> -	qos_vop_little: qos@ffad0000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffad0000 0x0 0x20>;
> -	};
> -
> -	qos_perihp: qos@ffad8080 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffad8080 0x0 0x20>;
> -	};
> -
> -	qos_gpu: qos@ffae0000 {
> -		compatible = "rockchip,rk3399-qos", "syscon";
> -		reg = <0x0 0xffae0000 0x0 0x20>;
> -	};
> -
> -	pmu: power-management@ff310000 {
> -		compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
> -		reg = <0x0 0xff310000 0x0 0x1000>;
> -
> -		/*
> -		 * Note: RK3399 supports 6 voltage domains including VD_CORE_L,
> -		 * VD_CORE_B, VD_CENTER, VD_GPU, VD_LOGIC and VD_PMU.
> -		 * Some of the power domains are grouped together for every
> -		 * voltage domain.
> -		 * The detail contents as below.
> -		 */
> -		power: power-controller {
> -			compatible = "rockchip,rk3399-power-controller";
> -			#power-domain-cells = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* These power domains are grouped by VD_CENTER */
> -			power-domain@RK3399_PD_IEP {
> -				reg = <RK3399_PD_IEP>;
> -				clocks = <&cru ACLK_IEP>,
> -					 <&cru HCLK_IEP>;
> -				pm_qos = <&qos_iep>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_RGA {
> -				reg = <RK3399_PD_RGA>;
> -				clocks = <&cru ACLK_RGA>,
> -					 <&cru HCLK_RGA>;
> -				pm_qos = <&qos_rga_r>,
> -					 <&qos_rga_w>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_VCODEC {
> -				reg = <RK3399_PD_VCODEC>;
> -				clocks = <&cru ACLK_VCODEC>,
> -					 <&cru HCLK_VCODEC>;
> -				pm_qos = <&qos_video_m0>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_VDU {
> -				reg = <RK3399_PD_VDU>;
> -				clocks = <&cru ACLK_VDU>,
> -					 <&cru HCLK_VDU>,
> -					 <&cru SCLK_VDU_CA>,
> -					 <&cru SCLK_VDU_CORE>;
> -				pm_qos = <&qos_video_m1_r>,
> -					 <&qos_video_m1_w>;
> -				#power-domain-cells = <0>;
> -			};
> -
> -			/* These power domains are grouped by VD_GPU */
> -			power-domain@RK3399_PD_GPU {
> -				reg = <RK3399_PD_GPU>;
> -				clocks = <&cru ACLK_GPU>;
> -				pm_qos = <&qos_gpu>;
> -				#power-domain-cells = <0>;
> -			};
> -
> -			/* These power domains are grouped by VD_LOGIC */
> -			power-domain@RK3399_PD_EDP {
> -				reg = <RK3399_PD_EDP>;
> -				clocks = <&cru PCLK_EDP_CTRL>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_EMMC {
> -				reg = <RK3399_PD_EMMC>;
> -				clocks = <&cru ACLK_EMMC>;
> -				pm_qos = <&qos_emmc>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_GMAC {
> -				reg = <RK3399_PD_GMAC>;
> -				clocks = <&cru ACLK_GMAC>,
> -					 <&cru PCLK_GMAC>;
> -				pm_qos = <&qos_gmac>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_SD {
> -				reg = <RK3399_PD_SD>;
> -				clocks = <&cru HCLK_SDMMC>,
> -					 <&cru SCLK_SDMMC>;
> -				pm_qos = <&qos_sd>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_SDIOAUDIO {
> -				reg = <RK3399_PD_SDIOAUDIO>;
> -				clocks = <&cru HCLK_SDIO>;
> -				pm_qos = <&qos_sdioaudio>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_TCPD0 {
> -				reg = <RK3399_PD_TCPD0>;
> -				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
> -					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_TCPD1 {
> -				reg = <RK3399_PD_TCPD1>;
> -				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
> -					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_USB3 {
> -				reg = <RK3399_PD_USB3>;
> -				clocks = <&cru ACLK_USB3>;
> -				pm_qos = <&qos_usb_otg0>,
> -					 <&qos_usb_otg1>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3399_PD_VIO {
> -				reg = <RK3399_PD_VIO>;
> -				#power-domain-cells = <1>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				power-domain@RK3399_PD_HDCP {
> -					reg = <RK3399_PD_HDCP>;
> -					clocks = <&cru ACLK_HDCP>,
> -						 <&cru HCLK_HDCP>,
> -						 <&cru PCLK_HDCP>;
> -					pm_qos = <&qos_hdcp>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3399_PD_ISP0 {
> -					reg = <RK3399_PD_ISP0>;
> -					clocks = <&cru ACLK_ISP0>,
> -						 <&cru HCLK_ISP0>;
> -					pm_qos = <&qos_isp0_m0>,
> -						 <&qos_isp0_m1>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3399_PD_ISP1 {
> -					reg = <RK3399_PD_ISP1>;
> -					clocks = <&cru ACLK_ISP1>,
> -						 <&cru HCLK_ISP1>;
> -					pm_qos = <&qos_isp1_m0>,
> -						 <&qos_isp1_m1>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3399_PD_VO {
> -					reg = <RK3399_PD_VO>;
> -					#power-domain-cells = <1>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					power-domain@RK3399_PD_VOPB {
> -						reg = <RK3399_PD_VOPB>;
> -						clocks = <&cru ACLK_VOP0>,
> -							 <&cru HCLK_VOP0>;
> -						pm_qos = <&qos_vop_big_r>,
> -							 <&qos_vop_big_w>;
> -						#power-domain-cells = <0>;
> -					};
> -					power-domain@RK3399_PD_VOPL {
> -						reg = <RK3399_PD_VOPL>;
> -						clocks = <&cru ACLK_VOP1>,
> -							 <&cru HCLK_VOP1>;
> -						pm_qos = <&qos_vop_little>;
> -						#power-domain-cells = <0>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
> -	pmugrf: syscon@ff320000 {
> -		compatible = "rockchip,rk3399-pmugrf", "syscon", "simple-mfd";
> -		reg = <0x0 0xff320000 0x0 0x1000>;
> -
> -		pmu_io_domains: io-domains {
> -			compatible = "rockchip,rk3399-pmu-io-voltage-domain";
> -			status = "disabled";
> -		};
> -	};
> -
> -	spi3: spi@ff350000 {
> -		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xff350000 0x0 0x1000>;
> -		clocks = <&pmucru SCLK_SPI3_PMU>, <&pmucru PCLK_SPI3_PMU>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi3_clk &spi3_tx &spi3_rx &spi3_cs0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	uart4: serial@ff370000 {
> -		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xff370000 0x0 0x100>;
> -		clocks = <&pmucru SCLK_UART4_PMU>, <&pmucru PCLK_UART4_PMU>;
> -		clock-names = "baudclk", "apb_pclk";
> -		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH 0>;
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&uart4_xfer>;
> -		status = "disabled";
> -	};
> -
> -	i2c0: i2c@ff3c0000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff3c0000 0x0 0x1000>;
> -		assigned-clocks = <&pmucru SCLK_I2C0_PMU>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&pmucru SCLK_I2C0_PMU>, <&pmucru PCLK_I2C0_PMU>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c0_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c4: i2c@ff3d0000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff3d0000 0x0 0x1000>;
> -		assigned-clocks = <&pmucru SCLK_I2C4_PMU>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&pmucru SCLK_I2C4_PMU>, <&pmucru PCLK_I2C4_PMU>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c4_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c8: i2c@ff3e0000 {
> -		compatible = "rockchip,rk3399-i2c";
> -		reg = <0x0 0xff3e0000 0x0 0x1000>;
> -		assigned-clocks = <&pmucru SCLK_I2C8_PMU>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&pmucru SCLK_I2C8_PMU>, <&pmucru PCLK_I2C8_PMU>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2c8_xfer>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	pwm0: pwm@ff420000 {
> -		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
> -		reg = <0x0 0xff420000 0x0 0x10>;
> -		#pwm-cells = <3>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwm0_pin>;
> -		clocks = <&pmucru PCLK_RKPWM_PMU>;
> -		status = "disabled";
> -	};
> -
> -	pwm1: pwm@ff420010 {
> -		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
> -		reg = <0x0 0xff420010 0x0 0x10>;
> -		#pwm-cells = <3>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwm1_pin>;
> -		clocks = <&pmucru PCLK_RKPWM_PMU>;
> -		status = "disabled";
> -	};
> -
> -	pwm2: pwm@ff420020 {
> -		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
> -		reg = <0x0 0xff420020 0x0 0x10>;
> -		#pwm-cells = <3>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwm2_pin>;
> -		clocks = <&pmucru PCLK_RKPWM_PMU>;
> -		status = "disabled";
> -	};
> -
> -	pwm3: pwm@ff420030 {
> -		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
> -		reg = <0x0 0xff420030 0x0 0x10>;
> -		#pwm-cells = <3>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwm3a_pin>;
> -		clocks = <&pmucru PCLK_RKPWM_PMU>;
> -		status = "disabled";
> -	};
> -
> -	dfi: dfi@ff630000 {
> -		reg = <0x00 0xff630000 0x00 0x4000>;
> -		compatible = "rockchip,rk3399-dfi";
> -		rockchip,pmu = <&pmugrf>;
> -		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru PCLK_DDR_MON>;
> -		clock-names = "pclk_ddr_mon";
> -	};
> -
> -	vpu: video-codec@ff650000 {
> -		compatible = "rockchip,rk3399-vpu";
> -		reg = <0x0 0xff650000 0x0 0x800>;
> -		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "vepu", "vdpu";
> -		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
> -		clock-names = "aclk", "hclk";
> -		iommus = <&vpu_mmu>;
> -		power-domains = <&power RK3399_PD_VCODEC>;
> -	};
> -
> -	vpu_mmu: iommu@ff650800 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff650800 0x0 0x40>;
> -		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -		power-domains = <&power RK3399_PD_VCODEC>;
> -	};
> -
> -	vdec: video-codec@ff660000 {
> -		compatible = "rockchip,rk3399-vdec";
> -		reg = <0x0 0xff660000 0x0 0x480>;
> -		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
> -			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
> -		clock-names = "axi", "ahb", "cabac", "core";
> -		iommus = <&vdec_mmu>;
> -		power-domains = <&power RK3399_PD_VDU>;
> -	};
> -
> -	vdec_mmu: iommu@ff660480 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff660480 0x0 0x40>, <0x0 0xff6604c0 0x0 0x40>;
> -		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
> -		clock-names = "aclk", "iface";
> -		power-domains = <&power RK3399_PD_VDU>;
> -		#iommu-cells = <0>;
> -	};
> -
> -	iep_mmu: iommu@ff670800 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff670800 0x0 0x40>;
> -		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	rga: rga@ff680000 {
> -		compatible = "rockchip,rk3399-rga";
> -		reg = <0x0 0xff680000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
> -		clock-names = "aclk", "hclk", "sclk";
> -		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
> -		reset-names = "core", "axi", "ahb";
> -		power-domains = <&power RK3399_PD_RGA>;
> -	};
> -
> -	efuse0: efuse@ff690000 {
> -		compatible = "rockchip,rk3399-efuse";
> -		reg = <0x0 0xff690000 0x0 0x80>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		clocks = <&cru PCLK_EFUSE1024NS>;
> -		clock-names = "pclk_efuse";
> -
> -		/* Data cells */
> -		cpu_id: cpu-id@7 {
> -			reg = <0x07 0x10>;
> -		};
> -		cpub_leakage: cpu-leakage@17 {
> -			reg = <0x17 0x1>;
> -		};
> -		gpu_leakage: gpu-leakage@18 {
> -			reg = <0x18 0x1>;
> -		};
> -		center_leakage: center-leakage@19 {
> -			reg = <0x19 0x1>;
> -		};
> -		cpul_leakage: cpu-leakage@1a {
> -			reg = <0x1a 0x1>;
> -		};
> -		logic_leakage: logic-leakage@1b {
> -			reg = <0x1b 0x1>;
> -		};
> -		wafer_info: wafer-info@1c {
> -			reg = <0x1c 0x1>;
> -		};
> -	};
> -
> -	dmac_bus: dma-controller@ff6d0000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x0 0xff6d0000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>;
> -		#dma-cells = <1>;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMAC0_PERILP>;
> -		clock-names = "apb_pclk";
> -	};
> -
> -	dmac_peri: dma-controller@ff6e0000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x0 0xff6e0000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>;
> -		#dma-cells = <1>;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMAC1_PERILP>;
> -		clock-names = "apb_pclk";
> -	};
> -
> -	pmucru: clock-controller@ff750000 {
> -		compatible = "rockchip,rk3399-pmucru";
> -		reg = <0x0 0xff750000 0x0 0x1000>;
> -		clocks = <&xin24m>;
> -		clock-names = "xin24m";
> -		rockchip,grf = <&pmugrf>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		assigned-clocks = <&pmucru PLL_PPLL>;
> -		assigned-clock-rates = <676000000>;
> -	};
> -
> -	cru: clock-controller@ff760000 {
> -		compatible = "rockchip,rk3399-cru";
> -		reg = <0x0 0xff760000 0x0 0x1000>;
> -		clocks = <&xin24m>;
> -		clock-names = "xin24m";
> -		rockchip,grf = <&grf>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		assigned-clocks =
> -			<&cru PLL_GPLL>, <&cru PLL_CPLL>,
> -			<&cru PLL_NPLL>,
> -			<&cru ACLK_PERIHP>, <&cru HCLK_PERIHP>,
> -			<&cru PCLK_PERIHP>,
> -			<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
> -			<&cru PCLK_PERILP0>, <&cru ACLK_CCI>,
> -			<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>,
> -			<&cru ACLK_VIO>, <&cru ACLK_HDCP>,
> -			<&cru ACLK_GIC_PRE>,
> -			<&cru PCLK_DDR>,
> -			<&cru ACLK_VDU>;
> -		assigned-clock-rates =
> -			 <594000000>,  <800000000>,
> -			<1000000000>,
> -			 <150000000>,   <75000000>,
> -			  <37500000>,
> -			 <100000000>,  <100000000>,
> -			  <50000000>, <600000000>,
> -			 <100000000>,   <50000000>,
> -			 <400000000>, <400000000>,
> -			 <200000000>,
> -			 <200000000>,
> -			 <400000000>;
> -	};
> -
> -	grf: syscon@ff770000 {
> -		compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
> -		reg = <0x0 0xff770000 0x0 0x10000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		io_domains: io-domains {
> -			compatible = "rockchip,rk3399-io-voltage-domain";
> -			status = "disabled";
> -		};
> -
> -		mipi_dphy_rx0: mipi-dphy-rx0 {
> -			compatible = "rockchip,rk3399-mipi-dphy-rx0";
> -			clocks = <&cru SCLK_MIPIDPHY_REF>,
> -				 <&cru SCLK_DPHY_RX0_CFG>,
> -				 <&cru PCLK_VIO_GRF>;
> -			clock-names = "dphy-ref", "dphy-cfg", "grf";
> -			power-domains = <&power RK3399_PD_VIO>;
> -			#phy-cells = <0>;
> -			status = "disabled";
> -		};
> -
> -		u2phy0: usb2phy@e450 {
> -			compatible = "rockchip,rk3399-usb2phy";
> -			reg = <0xe450 0x10>;
> -			clocks = <&cru SCLK_USB2PHY0_REF>;
> -			clock-names = "phyclk";
> -			#clock-cells = <0>;
> -			clock-output-names = "clk_usbphy0_480m";
> -			status = "disabled";
> -
> -			u2phy0_host: host-port {
> -				#phy-cells = <0>;
> -				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
> -				interrupt-names = "linestate";
> -				status = "disabled";
> -			};
> -
> -			u2phy0_otg: otg-port {
> -				#phy-cells = <0>;
> -				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
> -					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
> -					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
> -				interrupt-names = "otg-bvalid", "otg-id",
> -						  "linestate";
> -				status = "disabled";
> -			};
> -		};
> -
> -		u2phy1: usb2phy@e460 {
> -			compatible = "rockchip,rk3399-usb2phy";
> -			reg = <0xe460 0x10>;
> -			clocks = <&cru SCLK_USB2PHY1_REF>;
> -			clock-names = "phyclk";
> -			#clock-cells = <0>;
> -			clock-output-names = "clk_usbphy1_480m";
> -			status = "disabled";
> -
> -			u2phy1_host: host-port {
> -				#phy-cells = <0>;
> -				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
> -				interrupt-names = "linestate";
> -				status = "disabled";
> -			};
> -
> -			u2phy1_otg: otg-port {
> -				#phy-cells = <0>;
> -				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>,
> -					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>,
> -					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH 0>;
> -				interrupt-names = "otg-bvalid", "otg-id",
> -						  "linestate";
> -				status = "disabled";
> -			};
> -		};
> -
> -		emmc_phy: phy@f780 {
> -			compatible = "rockchip,rk3399-emmc-phy";
> -			reg = <0xf780 0x24>;
> -			clocks = <&sdhci>;
> -			clock-names = "emmcclk";
> -			drive-impedance-ohm = <50>;
> -			#phy-cells = <0>;
> -			status = "disabled";
> -		};
> -
> -		pcie_phy: pcie-phy {
> -			compatible = "rockchip,rk3399-pcie-phy";
> -			clocks = <&cru SCLK_PCIEPHY_REF>;
> -			clock-names = "refclk";
> -			#phy-cells = <1>;
> -			resets = <&cru SRST_PCIEPHY>;
> -			reset-names = "phy";
> -			status = "disabled";
> -		};
> -	};
> -
> -	tcphy0: phy@ff7c0000 {
> -		compatible = "rockchip,rk3399-typec-phy";
> -		reg = <0x0 0xff7c0000 0x0 0x40000>;
> -		clocks = <&cru SCLK_UPHY0_TCPDCORE>,
> -			 <&cru SCLK_UPHY0_TCPDPHY_REF>;
> -		clock-names = "tcpdcore", "tcpdphy-ref";
> -		assigned-clocks = <&cru SCLK_UPHY0_TCPDCORE>;
> -		assigned-clock-rates = <50000000>;
> -		power-domains = <&power RK3399_PD_TCPD0>;
> -		resets = <&cru SRST_UPHY0>,
> -			 <&cru SRST_UPHY0_PIPE_L00>,
> -			 <&cru SRST_P_UPHY0_TCPHY>;
> -		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
> -		rockchip,grf = <&grf>;
> -		status = "disabled";
> -
> -		tcphy0_dp: dp-port {
> -			#phy-cells = <0>;
> -		};
> -
> -		tcphy0_usb3: usb3-port {
> -			#phy-cells = <0>;
> -		};
> -	};
> -
> -	tcphy1: phy@ff800000 {
> -		compatible = "rockchip,rk3399-typec-phy";
> -		reg = <0x0 0xff800000 0x0 0x40000>;
> -		clocks = <&cru SCLK_UPHY1_TCPDCORE>,
> -			 <&cru SCLK_UPHY1_TCPDPHY_REF>;
> -		clock-names = "tcpdcore", "tcpdphy-ref";
> -		assigned-clocks = <&cru SCLK_UPHY1_TCPDCORE>;
> -		assigned-clock-rates = <50000000>;
> -		power-domains = <&power RK3399_PD_TCPD1>;
> -		resets = <&cru SRST_UPHY1>,
> -			 <&cru SRST_UPHY1_PIPE_L00>,
> -			 <&cru SRST_P_UPHY1_TCPHY>;
> -		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
> -		rockchip,grf = <&grf>;
> -		status = "disabled";
> -
> -		tcphy1_dp: dp-port {
> -			#phy-cells = <0>;
> -		};
> -
> -		tcphy1_usb3: usb3-port {
> -			#phy-cells = <0>;
> -		};
> -	};
> -
> -	watchdog@ff848000 {
> -		compatible = "rockchip,rk3399-wdt", "snps,dw-wdt";
> -		reg = <0x0 0xff848000 0x0 0x100>;
> -		clocks = <&cru PCLK_WDT>;
> -		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>;
> -	};
> -
> -	rktimer: rktimer@ff850000 {
> -		compatible = "rockchip,rk3399-timer";
> -		reg = <0x0 0xff850000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru PCLK_TIMER0>, <&cru SCLK_TIMER00>;
> -		clock-names = "pclk", "timer";
> -	};
> -
> -	spdif: spdif@ff870000 {
> -		compatible = "rockchip,rk3399-spdif";
> -		reg = <0x0 0xff870000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_bus 7>;
> -		dma-names = "tx";
> -		clock-names = "mclk", "hclk";
> -		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spdif_bus>;
> -		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s0: i2s@ff880000 {
> -		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
> -		reg = <0x0 0xff880000 0x0 0x1000>;
> -		rockchip,grf = <&grf>;
> -		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_bus 0>, <&dmac_bus 1>;
> -		dma-names = "tx", "rx";
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
> -		pinctrl-names = "bclk_on", "bclk_off";
> -		pinctrl-0 = <&i2s0_8ch_bus>;
> -		pinctrl-1 = <&i2s0_8ch_bus_bclk_off>;
> -		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s1: i2s@ff890000 {
> -		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
> -		reg = <0x0 0xff890000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_bus 2>, <&dmac_bus 3>;
> -		dma-names = "tx", "rx";
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		clocks = <&cru SCLK_I2S1_8CH>, <&cru HCLK_I2S1_8CH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s1_2ch_bus>;
> -		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s2: i2s@ff8a0000 {
> -		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
> -		reg = <0x0 0xff8a0000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH 0>;
> -		dmas = <&dmac_bus 4>, <&dmac_bus 5>;
> -		dma-names = "tx", "rx";
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		clocks = <&cru SCLK_I2S2_8CH>, <&cru HCLK_I2S2_8CH>;
> -		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	vopl: vop@ff8f0000 {
> -		compatible = "rockchip,rk3399-vop-lit";
> -		reg = <0x0 0xff8f0000 0x0 0x2000>, <0x0 0xff8f2000 0x0 0x400>;
> -		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
> -		assigned-clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> -		assigned-clock-rates = <400000000>, <100000000>;
> -		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		iommus = <&vopl_mmu>;
> -		power-domains = <&power RK3399_PD_VOPL>;
> -		resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
> -		reset-names = "axi", "ahb", "dclk";
> -		status = "disabled";
> -
> -		vopl_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			vopl_out_mipi: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&mipi_in_vopl>;
> -			};
> -
> -			vopl_out_edp: endpoint@1 {
> -				reg = <1>;
> -				remote-endpoint = <&edp_in_vopl>;
> -			};
> -
> -			vopl_out_hdmi: endpoint@2 {
> -				reg = <2>;
> -				remote-endpoint = <&hdmi_in_vopl>;
> -			};
> -
> -			vopl_out_mipi1: endpoint@3 {
> -				reg = <3>;
> -				remote-endpoint = <&mipi1_in_vopl>;
> -			};
> -
> -			vopl_out_dp: endpoint@4 {
> -				reg = <4>;
> -				remote-endpoint = <&dp_in_vopl>;
> -			};
> -		};
> -	};
> -
> -	vopl_mmu: iommu@ff8f3f00 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff8f3f00 0x0 0x100>;
> -		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> -		clock-names = "aclk", "iface";
> -		power-domains = <&power RK3399_PD_VOPL>;
> -		#iommu-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	vopb: vop@ff900000 {
> -		compatible = "rockchip,rk3399-vop-big";
> -		reg = <0x0 0xff900000 0x0 0x2000>, <0x0 0xff902000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
> -		assigned-clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> -		assigned-clock-rates = <400000000>, <100000000>;
> -		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		iommus = <&vopb_mmu>;
> -		power-domains = <&power RK3399_PD_VOPB>;
> -		resets = <&cru SRST_A_VOP0>, <&cru SRST_H_VOP0>, <&cru SRST_D_VOP0>;
> -		reset-names = "axi", "ahb", "dclk";
> -		status = "disabled";
> -
> -		vopb_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			vopb_out_edp: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&edp_in_vopb>;
> -			};
> -
> -			vopb_out_mipi: endpoint@1 {
> -				reg = <1>;
> -				remote-endpoint = <&mipi_in_vopb>;
> -			};
> -
> -			vopb_out_hdmi: endpoint@2 {
> -				reg = <2>;
> -				remote-endpoint = <&hdmi_in_vopb>;
> -			};
> -
> -			vopb_out_mipi1: endpoint@3 {
> -				reg = <3>;
> -				remote-endpoint = <&mipi1_in_vopb>;
> -			};
> -
> -			vopb_out_dp: endpoint@4 {
> -				reg = <4>;
> -				remote-endpoint = <&dp_in_vopb>;
> -			};
> -		};
> -	};
> -
> -	vopb_mmu: iommu@ff903f00 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff903f00 0x0 0x100>;
> -		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> -		clock-names = "aclk", "iface";
> -		power-domains = <&power RK3399_PD_VOPB>;
> -		#iommu-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	isp0: isp0@ff910000 {
> -		compatible = "rockchip,rk3399-cif-isp";
> -		reg = <0x0 0xff910000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_ISP0>,
> -			 <&cru ACLK_ISP0_WRAPPER>,
> -			 <&cru HCLK_ISP0_WRAPPER>;
> -		clock-names = "isp", "aclk", "hclk";
> -		iommus = <&isp0_mmu>;
> -		phys = <&mipi_dphy_rx0>;
> -		phy-names = "dphy";
> -		power-domains = <&power RK3399_PD_ISP0>;
> -		status = "disabled";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -			};
> -		};
> -	};
> -
> -	isp0_mmu: iommu@ff914000 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
> -		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_ISP0_WRAPPER>, <&cru HCLK_ISP0_WRAPPER>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -		power-domains = <&power RK3399_PD_ISP0>;
> -		rockchip,disable-mmu-reset;
> -	};
> -
> -	isp1: isp1@ff920000 {
> -		compatible = "rockchip,rk3399-cif-isp";
> -		reg = <0x0 0xff920000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_ISP1>,
> -			 <&cru ACLK_ISP1_WRAPPER>,
> -			 <&cru HCLK_ISP1_WRAPPER>;
> -		clock-names = "isp", "aclk", "hclk";
> -		iommus = <&isp1_mmu>;
> -		phys = <&mipi_dsi1>;
> -		phy-names = "dphy";
> -		power-domains = <&power RK3399_PD_ISP1>;
> -		status = "disabled";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -			};
> -		};
> -	};
> -
> -	isp1_mmu: iommu@ff924000 {
> -		compatible = "rockchip,iommu";
> -		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
> -		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_ISP1_WRAPPER>, <&cru HCLK_ISP1_WRAPPER>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -		power-domains = <&power RK3399_PD_ISP1>;
> -		rockchip,disable-mmu-reset;
> -	};
> -
> -	hdmi_sound: hdmi-sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,name = "hdmi-sound";
> -		status = "disabled";
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s2>;
> -		};
> -		simple-audio-card,codec {
> -			sound-dai = <&hdmi>;
> -		};
> -	};
> -
> -	hdmi: hdmi@ff940000 {
> -		compatible = "rockchip,rk3399-dw-hdmi";
> -		reg = <0x0 0xff940000 0x0 0x20000>;
> -		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru PCLK_HDMI_CTRL>,
> -			 <&cru SCLK_HDMI_SFR>,
> -			 <&cru SCLK_HDMI_CEC>,
> -			 <&cru PCLK_VIO_GRF>,
> -			 <&cru PLL_VPLL>;
> -		clock-names = "iahb", "isfr", "cec", "grf", "ref";
> -		power-domains = <&power RK3399_PD_HDCP>;
> -		reg-io-width = <4>;
> -		rockchip,grf = <&grf>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -
> -		ports {
> -			hdmi_in: port {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				hdmi_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_hdmi>;
> -				};
> -				hdmi_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_hdmi>;
> -				};
> -			};
> -		};
> -	};
> -
> -	mipi_dsi: dsi@ff960000 {
> -		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
> -		reg = <0x0 0xff960000 0x0 0x8000>;
> -		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_DPHY_PLL>, <&cru PCLK_MIPI_DSI0>,
> -			 <&cru SCLK_DPHY_TX0_CFG>, <&cru PCLK_VIO_GRF>;
> -		clock-names = "ref", "pclk", "phy_cfg", "grf";
> -		power-domains = <&power RK3399_PD_VIO>;
> -		resets = <&cru SRST_P_MIPI_DSI0>;
> -		reset-names = "apb";
> -		rockchip,grf = <&grf>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			mipi_in: port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				mipi_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_mipi>;
> -				};
> -
> -				mipi_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_mipi>;
> -				};
> -			};
> -
> -			mipi_out: port@1 {
> -				reg = <1>;
> -			};
> -		};
> -	};
> -
> -	mipi_dsi1: dsi@ff968000 {
> -		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
> -		reg = <0x0 0xff968000 0x0 0x8000>;
> -		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_DPHY_PLL>, <&cru PCLK_MIPI_DSI1>,
> -			 <&cru SCLK_DPHY_TX1RX1_CFG>, <&cru PCLK_VIO_GRF>;
> -		clock-names = "ref", "pclk", "phy_cfg", "grf";
> -		power-domains = <&power RK3399_PD_VIO>;
> -		resets = <&cru SRST_P_MIPI_DSI1>;
> -		reset-names = "apb";
> -		rockchip,grf = <&grf>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		#phy-cells = <0>;
> -		status = "disabled";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			mipi1_in: port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				mipi1_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_mipi1>;
> -				};
> -
> -				mipi1_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_mipi1>;
> -				};
> -			};
> -
> -			mipi1_out: port@1 {
> -				reg = <1>;
> -			};
> -		};
> -	};
> -
> -	edp: dp@ff970000 {
> -		compatible = "rockchip,rk3399-edp";
> -		reg = <0x0 0xff970000 0x0 0x8000>;
> -		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>, <&cru PCLK_VIO_GRF>;
> -		clock-names = "dp", "pclk", "grf";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&edp_hpd>;
> -		power-domains = <&power RK3399_PD_EDP>;
> -		resets = <&cru SRST_P_EDP_CTRL>;
> -		reset-names = "dp";
> -		rockchip,grf = <&grf>;
> -		status = "disabled";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			edp_in: port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				edp_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_edp>;
> -				};
> -
> -				edp_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_edp>;
> -				};
> -			};
> -
> -			edp_out: port@1 {
> -				reg = <1>;
> -			};
> -		};
> -	};
> -
> -	gpu: gpu@ff9a0000 {
> -		compatible = "rockchip,rk3399-mali", "arm,mali-t860";
> -		reg = <0x0 0xff9a0000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "job", "mmu", "gpu";
> -		clocks = <&cru ACLK_GPU>;
> -		#cooling-cells = <2>;
> -		dynamic-power-coefficient = <2640>;
> -		power-domains = <&power RK3399_PD_GPU>;
> -		status = "disabled";
> -	};
> -
> -	pinctrl: pinctrl {
> -		compatible = "rockchip,rk3399-pinctrl";
> -		rockchip,grf = <&grf>;
> -		rockchip,pmu = <&pmugrf>;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		gpio0: gpio@ff720000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xff720000 0x0 0x100>;
> -			clocks = <&pmucru PCLK_GPIO0_PMU>;
> -			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <0x2>;
> -		};
> -
> -		gpio1: gpio@ff730000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xff730000 0x0 0x100>;
> -			clocks = <&pmucru PCLK_GPIO1_PMU>;
> -			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <0x2>;
> -		};
> -
> -		gpio2: gpio@ff780000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xff780000 0x0 0x100>;
> -			clocks = <&cru PCLK_GPIO2>;
> -			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <0x2>;
> -		};
> -
> -		gpio3: gpio@ff788000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xff788000 0x0 0x100>;
> -			clocks = <&cru PCLK_GPIO3>;
> -			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <0x2>;
> -		};
> -
> -		gpio4: gpio@ff790000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xff790000 0x0 0x100>;
> -			clocks = <&cru PCLK_GPIO4>;
> -			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <0x2>;
> -		};
> -
> -		pcfg_pull_up: pcfg-pull-up {
> -			bias-pull-up;
> -		};
> -
> -		pcfg_pull_down: pcfg-pull-down {
> -			bias-pull-down;
> -		};
> -
> -		pcfg_pull_none: pcfg-pull-none {
> -			bias-disable;
> -		};
> -
> -		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
> -			bias-disable;
> -			drive-strength = <12>;
> -		};
> -
> -		pcfg_pull_none_13ma: pcfg-pull-none-13ma {
> -			bias-disable;
> -			drive-strength = <13>;
> -		};
> -
> -		pcfg_pull_none_18ma: pcfg-pull-none-18ma {
> -			bias-disable;
> -			drive-strength = <18>;
> -		};
> -
> -		pcfg_pull_none_20ma: pcfg-pull-none-20ma {
> -			bias-disable;
> -			drive-strength = <20>;
> -		};
> -
> -		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
> -			bias-pull-up;
> -			drive-strength = <2>;
> -		};
> -
> -		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
> -			bias-pull-up;
> -			drive-strength = <8>;
> -		};
> -
> -		pcfg_pull_up_18ma: pcfg-pull-up-18ma {
> -			bias-pull-up;
> -			drive-strength = <18>;
> -		};
> -
> -		pcfg_pull_up_20ma: pcfg-pull-up-20ma {
> -			bias-pull-up;
> -			drive-strength = <20>;
> -		};
> -
> -		pcfg_pull_down_4ma: pcfg-pull-down-4ma {
> -			bias-pull-down;
> -			drive-strength = <4>;
> -		};
> -
> -		pcfg_pull_down_8ma: pcfg-pull-down-8ma {
> -			bias-pull-down;
> -			drive-strength = <8>;
> -		};
> -
> -		pcfg_pull_down_12ma: pcfg-pull-down-12ma {
> -			bias-pull-down;
> -			drive-strength = <12>;
> -		};
> -
> -		pcfg_pull_down_18ma: pcfg-pull-down-18ma {
> -			bias-pull-down;
> -			drive-strength = <18>;
> -		};
> -
> -		pcfg_pull_down_20ma: pcfg-pull-down-20ma {
> -			bias-pull-down;
> -			drive-strength = <20>;
> -		};
> -
> -		pcfg_output_high: pcfg-output-high {
> -			output-high;
> -		};
> -
> -		pcfg_output_low: pcfg-output-low {
> -			output-low;
> -		};
> -
> -		pcfg_input_enable: pcfg-input-enable {
> -			input-enable;
> -		};
> -
> -		pcfg_input_pull_up: pcfg-input-pull-up {
> -			input-enable;
> -			bias-pull-up;
> -		};
> -
> -		pcfg_input_pull_down: pcfg-input-pull-down {
> -			input-enable;
> -			bias-pull-down;
> -		};
> -
> -		clock {
> -			clk_32k: clk-32k {
> -				rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		cif {
> -			cif_clkin: cif-clkin {
> -				rockchip,pins =
> -					<2 RK_PB2 3 &pcfg_pull_none>;
> -			};
> -
> -			cif_clkouta: cif-clkouta {
> -				rockchip,pins =
> -					<2 RK_PB3 3 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		edp {
> -			edp_hpd: edp-hpd {
> -				rockchip,pins =
> -					<4 RK_PC7 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		gmac {
> -			rgmii_pins: rgmii-pins {
> -				rockchip,pins =
> -					/* mac_txclk */
> -					<3 RK_PC1 1 &pcfg_pull_none_13ma>,
> -					/* mac_rxclk */
> -					<3 RK_PB6 1 &pcfg_pull_none>,
> -					/* mac_mdio */
> -					<3 RK_PB5 1 &pcfg_pull_none>,
> -					/* mac_txen */
> -					<3 RK_PB4 1 &pcfg_pull_none_13ma>,
> -					/* mac_clk */
> -					<3 RK_PB3 1 &pcfg_pull_none>,
> -					/* mac_rxdv */
> -					<3 RK_PB1 1 &pcfg_pull_none>,
> -					/* mac_mdc */
> -					<3 RK_PB0 1 &pcfg_pull_none>,
> -					/* mac_rxd1 */
> -					<3 RK_PA7 1 &pcfg_pull_none>,
> -					/* mac_rxd0 */
> -					<3 RK_PA6 1 &pcfg_pull_none>,
> -					/* mac_txd1 */
> -					<3 RK_PA5 1 &pcfg_pull_none_13ma>,
> -					/* mac_txd0 */
> -					<3 RK_PA4 1 &pcfg_pull_none_13ma>,
> -					/* mac_rxd3 */
> -					<3 RK_PA3 1 &pcfg_pull_none>,
> -					/* mac_rxd2 */
> -					<3 RK_PA2 1 &pcfg_pull_none>,
> -					/* mac_txd3 */
> -					<3 RK_PA1 1 &pcfg_pull_none_13ma>,
> -					/* mac_txd2 */
> -					<3 RK_PA0 1 &pcfg_pull_none_13ma>;
> -			};
> -
> -			rmii_pins: rmii-pins {
> -				rockchip,pins =
> -					/* mac_mdio */
> -					<3 RK_PB5 1 &pcfg_pull_none>,
> -					/* mac_txen */
> -					<3 RK_PB4 1 &pcfg_pull_none_13ma>,
> -					/* mac_clk */
> -					<3 RK_PB3 1 &pcfg_pull_none>,
> -					/* mac_rxer */
> -					<3 RK_PB2 1 &pcfg_pull_none>,
> -					/* mac_rxdv */
> -					<3 RK_PB1 1 &pcfg_pull_none>,
> -					/* mac_mdc */
> -					<3 RK_PB0 1 &pcfg_pull_none>,
> -					/* mac_rxd1 */
> -					<3 RK_PA7 1 &pcfg_pull_none>,
> -					/* mac_rxd0 */
> -					<3 RK_PA6 1 &pcfg_pull_none>,
> -					/* mac_txd1 */
> -					<3 RK_PA5 1 &pcfg_pull_none_13ma>,
> -					/* mac_txd0 */
> -					<3 RK_PA4 1 &pcfg_pull_none_13ma>;
> -			};
> -		};
> -
> -		i2c0 {
> -			i2c0_xfer: i2c0-xfer {
> -				rockchip,pins =
> -					<1 RK_PB7 2 &pcfg_pull_none>,
> -					<1 RK_PC0 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c1 {
> -			i2c1_xfer: i2c1-xfer {
> -				rockchip,pins =
> -					<4 RK_PA2 1 &pcfg_pull_none>,
> -					<4 RK_PA1 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c2 {
> -			i2c2_xfer: i2c2-xfer {
> -				rockchip,pins =
> -					<2 RK_PA1 2 &pcfg_pull_none_12ma>,
> -					<2 RK_PA0 2 &pcfg_pull_none_12ma>;
> -			};
> -		};
> -
> -		i2c3 {
> -			i2c3_xfer: i2c3-xfer {
> -				rockchip,pins =
> -					<4 RK_PC1 1 &pcfg_pull_none>,
> -					<4 RK_PC0 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c4 {
> -			i2c4_xfer: i2c4-xfer {
> -				rockchip,pins =
> -					<1 RK_PB4 1 &pcfg_pull_none>,
> -					<1 RK_PB3 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c5 {
> -			i2c5_xfer: i2c5-xfer {
> -				rockchip,pins =
> -					<3 RK_PB3 2 &pcfg_pull_none>,
> -					<3 RK_PB2 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c6 {
> -			i2c6_xfer: i2c6-xfer {
> -				rockchip,pins =
> -					<2 RK_PB2 2 &pcfg_pull_none>,
> -					<2 RK_PB1 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c7 {
> -			i2c7_xfer: i2c7-xfer {
> -				rockchip,pins =
> -					<2 RK_PB0 2 &pcfg_pull_none>,
> -					<2 RK_PA7 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c8 {
> -			i2c8_xfer: i2c8-xfer {
> -				rockchip,pins =
> -					<1 RK_PC5 1 &pcfg_pull_none>,
> -					<1 RK_PC4 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2s0 {
> -			i2s0_2ch_bus: i2s0-2ch-bus {
> -				rockchip,pins =
> -					<3 RK_PD0 1 &pcfg_pull_none>,
> -					<3 RK_PD1 1 &pcfg_pull_none>,
> -					<3 RK_PD2 1 &pcfg_pull_none>,
> -					<3 RK_PD3 1 &pcfg_pull_none>,
> -					<3 RK_PD7 1 &pcfg_pull_none>,
> -					<4 RK_PA0 1 &pcfg_pull_none>;
> -			};
> -
> -			i2s0_2ch_bus_bclk_off: i2s0-2ch-bus-bclk-off {
> -				rockchip,pins =
> -					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
> -					<3 RK_PD1 1 &pcfg_pull_none>,
> -					<3 RK_PD2 1 &pcfg_pull_none>,
> -					<3 RK_PD3 1 &pcfg_pull_none>,
> -					<3 RK_PD7 1 &pcfg_pull_none>,
> -					<4 RK_PA0 1 &pcfg_pull_none>;
> -			};
> -
> -			i2s0_8ch_bus: i2s0-8ch-bus {
> -				rockchip,pins =
> -					<3 RK_PD0 1 &pcfg_pull_none>,
> -					<3 RK_PD1 1 &pcfg_pull_none>,
> -					<3 RK_PD2 1 &pcfg_pull_none>,
> -					<3 RK_PD3 1 &pcfg_pull_none>,
> -					<3 RK_PD4 1 &pcfg_pull_none>,
> -					<3 RK_PD5 1 &pcfg_pull_none>,
> -					<3 RK_PD6 1 &pcfg_pull_none>,
> -					<3 RK_PD7 1 &pcfg_pull_none>,
> -					<4 RK_PA0 1 &pcfg_pull_none>;
> -			};
> -
> -			i2s0_8ch_bus_bclk_off: i2s0-8ch-bus-bclk-off {
> -				rockchip,pins =
> -					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
> -					<3 RK_PD1 1 &pcfg_pull_none>,
> -					<3 RK_PD2 1 &pcfg_pull_none>,
> -					<3 RK_PD3 1 &pcfg_pull_none>,
> -					<3 RK_PD4 1 &pcfg_pull_none>,
> -					<3 RK_PD5 1 &pcfg_pull_none>,
> -					<3 RK_PD6 1 &pcfg_pull_none>,
> -					<3 RK_PD7 1 &pcfg_pull_none>,
> -					<4 RK_PA0 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2s1 {
> -			i2s1_2ch_bus: i2s1-2ch-bus {
> -				rockchip,pins =
> -					<4 RK_PA3 1 &pcfg_pull_none>,
> -					<4 RK_PA4 1 &pcfg_pull_none>,
> -					<4 RK_PA5 1 &pcfg_pull_none>,
> -					<4 RK_PA6 1 &pcfg_pull_none>,
> -					<4 RK_PA7 1 &pcfg_pull_none>;
> -			};
> -
> -			i2s1_2ch_bus_bclk_off: i2s1-2ch-bus-bclk-off {
> -				rockchip,pins =
> -					<4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>,
> -					<4 RK_PA4 1 &pcfg_pull_none>,
> -					<4 RK_PA5 1 &pcfg_pull_none>,
> -					<4 RK_PA6 1 &pcfg_pull_none>,
> -					<4 RK_PA7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		sdio0 {
> -			sdio0_bus1: sdio0-bus1 {
> -				rockchip,pins =
> -					<2 RK_PC4 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_bus4: sdio0-bus4 {
> -				rockchip,pins =
> -					<2 RK_PC4 1 &pcfg_pull_up>,
> -					<2 RK_PC5 1 &pcfg_pull_up>,
> -					<2 RK_PC6 1 &pcfg_pull_up>,
> -					<2 RK_PC7 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_cmd: sdio0-cmd {
> -				rockchip,pins =
> -					<2 RK_PD0 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_clk: sdio0-clk {
> -				rockchip,pins =
> -					<2 RK_PD1 1 &pcfg_pull_none>;
> -			};
> -
> -			sdio0_cd: sdio0-cd {
> -				rockchip,pins =
> -					<2 RK_PD2 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_pwr: sdio0-pwr {
> -				rockchip,pins =
> -					<2 RK_PD3 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_bkpwr: sdio0-bkpwr {
> -				rockchip,pins =
> -					<2 RK_PD4 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_wp: sdio0-wp {
> -				rockchip,pins =
> -					<0 RK_PA3 1 &pcfg_pull_up>;
> -			};
> -
> -			sdio0_int: sdio0-int {
> -				rockchip,pins =
> -					<0 RK_PA4 1 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		sdmmc {
> -			sdmmc_bus1: sdmmc-bus1 {
> -				rockchip,pins =
> -					<4 RK_PB0 1 &pcfg_pull_up>;
> -			};
> -
> -			sdmmc_bus4: sdmmc-bus4 {
> -				rockchip,pins =
> -					<4 RK_PB0 1 &pcfg_pull_up>,
> -					<4 RK_PB1 1 &pcfg_pull_up>,
> -					<4 RK_PB2 1 &pcfg_pull_up>,
> -					<4 RK_PB3 1 &pcfg_pull_up>;
> -			};
> -
> -			sdmmc_clk: sdmmc-clk {
> -				rockchip,pins =
> -					<4 RK_PB4 1 &pcfg_pull_none>;
> -			};
> -
> -			sdmmc_cmd: sdmmc-cmd {
> -				rockchip,pins =
> -					<4 RK_PB5 1 &pcfg_pull_up>;
> -			};
> -
> -			sdmmc_cd: sdmmc-cd {
> -				rockchip,pins =
> -					<0 RK_PA7 1 &pcfg_pull_up>;
> -			};
> -
> -			sdmmc_wp: sdmmc-wp {
> -				rockchip,pins =
> -					<0 RK_PB0 1 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		suspend {
> -			ap_pwroff: ap-pwroff {
> -				rockchip,pins = <1 RK_PA5 1 &pcfg_pull_none>;
> -			};
> -
> -			ddrio_pwroff: ddrio-pwroff {
> -				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		spdif {
> -			spdif_bus: spdif-bus {
> -				rockchip,pins =
> -					<4 RK_PC5 1 &pcfg_pull_none>;
> -			};
> -
> -			spdif_bus_1: spdif-bus-1 {
> -				rockchip,pins =
> -					<3 RK_PC0 3 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		spi0 {
> -			spi0_clk: spi0-clk {
> -				rockchip,pins =
> -					<3 RK_PA6 2 &pcfg_pull_up>;
> -			};
> -			spi0_cs0: spi0-cs0 {
> -				rockchip,pins =
> -					<3 RK_PA7 2 &pcfg_pull_up>;
> -			};
> -			spi0_cs1: spi0-cs1 {
> -				rockchip,pins =
> -					<3 RK_PB0 2 &pcfg_pull_up>;
> -			};
> -			spi0_tx: spi0-tx {
> -				rockchip,pins =
> -					<3 RK_PA5 2 &pcfg_pull_up>;
> -			};
> -			spi0_rx: spi0-rx {
> -				rockchip,pins =
> -					<3 RK_PA4 2 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi1 {
> -			spi1_clk: spi1-clk {
> -				rockchip,pins =
> -					<1 RK_PB1 2 &pcfg_pull_up>;
> -			};
> -			spi1_cs0: spi1-cs0 {
> -				rockchip,pins =
> -					<1 RK_PB2 2 &pcfg_pull_up>;
> -			};
> -			spi1_rx: spi1-rx {
> -				rockchip,pins =
> -					<1 RK_PA7 2 &pcfg_pull_up>;
> -			};
> -			spi1_tx: spi1-tx {
> -				rockchip,pins =
> -					<1 RK_PB0 2 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi2 {
> -			spi2_clk: spi2-clk {
> -				rockchip,pins =
> -					<2 RK_PB3 1 &pcfg_pull_up>;
> -			};
> -			spi2_cs0: spi2-cs0 {
> -				rockchip,pins =
> -					<2 RK_PB4 1 &pcfg_pull_up>;
> -			};
> -			spi2_rx: spi2-rx {
> -				rockchip,pins =
> -					<2 RK_PB1 1 &pcfg_pull_up>;
> -			};
> -			spi2_tx: spi2-tx {
> -				rockchip,pins =
> -					<2 RK_PB2 1 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi3 {
> -			spi3_clk: spi3-clk {
> -				rockchip,pins =
> -					<1 RK_PC1 1 &pcfg_pull_up>;
> -			};
> -			spi3_cs0: spi3-cs0 {
> -				rockchip,pins =
> -					<1 RK_PC2 1 &pcfg_pull_up>;
> -			};
> -			spi3_rx: spi3-rx {
> -				rockchip,pins =
> -					<1 RK_PB7 1 &pcfg_pull_up>;
> -			};
> -			spi3_tx: spi3-tx {
> -				rockchip,pins =
> -					<1 RK_PC0 1 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi4 {
> -			spi4_clk: spi4-clk {
> -				rockchip,pins =
> -					<3 RK_PA2 2 &pcfg_pull_up>;
> -			};
> -			spi4_cs0: spi4-cs0 {
> -				rockchip,pins =
> -					<3 RK_PA3 2 &pcfg_pull_up>;
> -			};
> -			spi4_rx: spi4-rx {
> -				rockchip,pins =
> -					<3 RK_PA0 2 &pcfg_pull_up>;
> -			};
> -			spi4_tx: spi4-tx {
> -				rockchip,pins =
> -					<3 RK_PA1 2 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi5 {
> -			spi5_clk: spi5-clk {
> -				rockchip,pins =
> -					<2 RK_PC6 2 &pcfg_pull_up>;
> -			};
> -			spi5_cs0: spi5-cs0 {
> -				rockchip,pins =
> -					<2 RK_PC7 2 &pcfg_pull_up>;
> -			};
> -			spi5_rx: spi5-rx {
> -				rockchip,pins =
> -					<2 RK_PC4 2 &pcfg_pull_up>;
> -			};
> -			spi5_tx: spi5-tx {
> -				rockchip,pins =
> -					<2 RK_PC5 2 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		testclk {
> -			test_clkout0: test-clkout0 {
> -				rockchip,pins =
> -					<0 RK_PA0 1 &pcfg_pull_none>;
> -			};
> -
> -			test_clkout1: test-clkout1 {
> -				rockchip,pins =
> -					<2 RK_PD1 2 &pcfg_pull_none>;
> -			};
> -
> -			test_clkout2: test-clkout2 {
> -				rockchip,pins =
> -					<0 RK_PB0 3 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		tsadc {
> -			otp_pin: otp-pin {
> -				rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> -			};
> -
> -			otp_out: otp-out {
> -				rockchip,pins = <1 RK_PA6 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart0 {
> -			uart0_xfer: uart0-xfer {
> -				rockchip,pins =
> -					<2 RK_PC0 1 &pcfg_pull_up>,
> -					<2 RK_PC1 1 &pcfg_pull_none>;
> -			};
> -
> -			uart0_cts: uart0-cts {
> -				rockchip,pins =
> -					<2 RK_PC2 1 &pcfg_pull_none>;
> -			};
> -
> -			uart0_rts: uart0-rts {
> -				rockchip,pins =
> -					<2 RK_PC3 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart1 {
> -			uart1_xfer: uart1-xfer {
> -				rockchip,pins =
> -					<3 RK_PB4 2 &pcfg_pull_up>,
> -					<3 RK_PB5 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart2a {
> -			uart2a_xfer: uart2a-xfer {
> -				rockchip,pins =
> -					<4 RK_PB0 2 &pcfg_pull_up>,
> -					<4 RK_PB1 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart2b {
> -			uart2b_xfer: uart2b-xfer {
> -				rockchip,pins =
> -					<4 RK_PC0 2 &pcfg_pull_up>,
> -					<4 RK_PC1 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart2c {
> -			uart2c_xfer: uart2c-xfer {
> -				rockchip,pins =
> -					<4 RK_PC3 1 &pcfg_pull_up>,
> -					<4 RK_PC4 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart3 {
> -			uart3_xfer: uart3-xfer {
> -				rockchip,pins =
> -					<3 RK_PB6 2 &pcfg_pull_up>,
> -					<3 RK_PB7 2 &pcfg_pull_none>;
> -			};
> -
> -			uart3_cts: uart3-cts {
> -				rockchip,pins =
> -					<3 RK_PC0 2 &pcfg_pull_none>;
> -			};
> -
> -			uart3_rts: uart3-rts {
> -				rockchip,pins =
> -					<3 RK_PC1 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart4 {
> -			uart4_xfer: uart4-xfer {
> -				rockchip,pins =
> -					<1 RK_PA7 1 &pcfg_pull_up>,
> -					<1 RK_PB0 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uarthdcp {
> -			uarthdcp_xfer: uarthdcp-xfer {
> -				rockchip,pins =
> -					<4 RK_PC5 2 &pcfg_pull_up>,
> -					<4 RK_PC6 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm0 {
> -			pwm0_pin: pwm0-pin {
> -				rockchip,pins =
> -					<4 RK_PC2 1 &pcfg_pull_none>;
> -			};
> -
> -			pwm0_pin_pull_down: pwm0-pin-pull-down {
> -				rockchip,pins =
> -					<4 RK_PC2 1 &pcfg_pull_down>;
> -			};
> -
> -			vop0_pwm_pin: vop0-pwm-pin {
> -				rockchip,pins =
> -					<4 RK_PC2 2 &pcfg_pull_none>;
> -			};
> -
> -			vop1_pwm_pin: vop1-pwm-pin {
> -				rockchip,pins =
> -					<4 RK_PC2 3 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm1 {
> -			pwm1_pin: pwm1-pin {
> -				rockchip,pins =
> -					<4 RK_PC6 1 &pcfg_pull_none>;
> -			};
> -
> -			pwm1_pin_pull_down: pwm1-pin-pull-down {
> -				rockchip,pins =
> -					<4 RK_PC6 1 &pcfg_pull_down>;
> -			};
> -		};
> -
> -		pwm2 {
> -			pwm2_pin: pwm2-pin {
> -				rockchip,pins =
> -					<1 RK_PC3 1 &pcfg_pull_none>;
> -			};
> -
> -			pwm2_pin_pull_down: pwm2-pin-pull-down {
> -				rockchip,pins =
> -					<1 RK_PC3 1 &pcfg_pull_down>;
> -			};
> -		};
> -
> -		pwm3a {
> -			pwm3a_pin: pwm3a-pin {
> -				rockchip,pins =
> -					<0 RK_PA6 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm3b {
> -			pwm3b_pin: pwm3b-pin {
> -				rockchip,pins =
> -					<1 RK_PB6 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		hdmi {
> -			hdmi_i2c_xfer: hdmi-i2c-xfer {
> -				rockchip,pins =
> -					<4 RK_PC1 3 &pcfg_pull_none>,
> -					<4 RK_PC0 3 &pcfg_pull_none>;
> -			};
> -
> -			hdmi_cec: hdmi-cec {
> -				rockchip,pins =
> -					<4 RK_PC7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pcie {
> -			pcie_clkreqn_cpm: pci-clkreqn-cpm {
> -				rockchip,pins =
> -					<2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -			};
> -
> -			pcie_clkreqnb_cpm: pci-clkreqnb-cpm {
> -				rockchip,pins =
> -					<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -			};
> -		};
> -
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399pro-rock-pi-n10.dts b/arch/arm/dts/rk3399pro-rock-pi-n10.dts
> deleted file mode 100644
> index bf026786fa92..000000000000
> --- a/arch/arm/dts/rk3399pro-rock-pi-n10.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> - * Copyright (c) 2019 Radxa Limited
> - * Copyright (c) 2019 Amarula Solutions(India)
> - */
> -
> -/dts-v1/;
> -#include "rk3399.dtsi"
> -#include "rk3399-opp.dtsi"
> -#include <rockchip-radxa-dalang-carrier.dtsi>
> -#include "rk3399pro-vmarc-som.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK Pi N10";
> -	compatible = "radxa,rockpi-n10", "vamrs,rk3399pro-vmarc-som",
> -		     "rockchip,rk3399pro";
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399pro-vmarc-som.dtsi b/arch/arm/dts/rk3399pro-vmarc-som.dtsi
> deleted file mode 100644
> index 8823c924dc1d..000000000000
> --- a/arch/arm/dts/rk3399pro-vmarc-som.dtsi
> +++ /dev/null
> @@ -1,477 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> - * Copyright (c) 2019 Vamrs Limited
> - * Copyright (c) 2019 Amarula Solutions(India)
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/pwm/pwm.h>
> -
> -/ {
> -	compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
> -
> -	aliases {
> -		ethernet0 = &gmac;
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	vcc3v3_pcie: vcc-pcie-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_pwr>;
> -		regulator-name = "vcc3v3_pcie";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_l>;
> -};
> -
> -&emmc_phy {
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_RMII_SRC>;
> -	phy-supply = <&vcc_lan>;
> -	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_cec>;
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-falling-time-ns = <30>;
> -	i2c-scl-rising-time-ns = <180>;
> -	status = "okay";
> -
> -	rk809: pmic@20 {
> -		compatible = "rockchip,rk809";
> -		reg = <0x20>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <RK_PC2 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc_buck5>;
> -		vcc6-supply = <&vcc_buck5>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc3v3_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -
> -		regulators {
> -			vdd_log: DCDC_REG1 {
> -				regulator-name = "vdd_log";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-initial-mode = <0x2>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vdd_cpu_l: DCDC_REG2 {
> -				regulator-name = "vdd_cpu_l";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-initial-mode = <0x2>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-initial-mode = <0x2>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc3v3_sys: DCDC_REG4 {
> -				regulator-name = "vcc3v3_sys";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-initial-mode = <0x2>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_buck5: DCDC_REG5 {
> -				regulator-name = "vcc_buck5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2200000>;
> -				regulator-max-microvolt = <2200000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2200000>;
> -				};
> -			};
> -
> -			vcca_0v9: LDO_REG1 {
> -				regulator-name = "vcca_0v9";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vcc_1v8: LDO_REG2 {
> -				regulator-name = "vcc_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_0v9: LDO_REG3 {
> -				regulator-name = "vcc_0v9";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vcca_1v8: LDO_REG4 {
> -				regulator-name = "vcca_1v8";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1850000>;
> -				regulator-max-microvolt = <1850000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1850000>;
> -				};
> -			};
> -
> -			/*
> -			 * As per BSP, but schematic not showing any regulator
> -			 * pin for LD05.
> -			 */
> -			vdd1v5_dvp: LDO_REG5 {
> -				regulator-name = "vdd1v5_dvp";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v5: LDO_REG6 {
> -				regulator-name = "vcc_1v5";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_3v0: LDO_REG7 {
> -				regulator-name = "vccio_3v0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG8 {
> -				regulator-name = "vccio_sd";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			/*
> -			 * As per BSP, but schematic not showing any regulator
> -			 * pin for LD09.
> -			 */
> -			vcc_sd: LDO_REG9 {
> -				regulator-name = "vcc_sd";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc5v0_usb2: SWITCH_REG1 {
> -				regulator-name = "vcc5v0_usb2";
> -				regulator-min-microvolt = <5000000>;
> -				regulator-max-microvolt = <5000000>;
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <5000000>;
> -				};
> -			};
> -
> -			vccio_3v3: vcc_lan: SWITCH_REG2 {
> -				regulator-name = "vccio_3v3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	i2c-scl-falling-time-ns = <30>;
> -	i2c-scl-rising-time-ns = <140>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	clock-frequency = <400000>;
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		interrupt-parent = <&gpio4>;
> -		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -};
> -
> -&i2c3 {
> -	i2c-scl-rising-time-ns = <450>;
> -	i2c-scl-falling-time-ns = <15>;
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	status = "okay";
> -	bt656-supply = <&vcca_1v8>;
> -	gpio1830-supply = <&vccio_3v0>;
> -	sdmmc-supply = <&vccio_sd>;
> -};
> -
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> -	pinctrl-names = "default";
> -	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
> -	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
> -	vpcie3v3-supply = <&vcc3v3_pcie>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie_pwr: pcie-pwr {
> -			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC2 0 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	vbus_host {
> -		usb1_en_oc: usb1-en-oc {
> -			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	vbus_typec {
> -		usb0_en_oc: usb0-en-oc {
> -			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pmu_io_domains {
> -	status = "okay";
> -	pmu1830-supply = <&vcc_1v8>;
> -};
> -
> -&sdio_pwrseq {
> -	/*
> -	 * On the module itself this is one of these (depending
> -	 * on the actual card populated):
> -	 * - SDIO_RESET_L_WL_REG_ON
> -	 * - PDN (power down when low)
> -	 */
> -	reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	max-frequency = <150000000>;
> -};
> -
> -&tcphy0 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>;
> -	rockchip,hw-tshut-polarity = <1>;
> -	status = "okay";
> -};
> -
> -&u2phy0 {
> -	status = "okay";
> -
> -	u2phy0_otg: otg-port {
> -		phy-supply = <&vbus_typec>;
> -		status = "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply = <&vbus_host>;
> -		status = "okay";
> -	};
> -};
> -
> -
> -&u2phy1 {
> -	status = "okay";
> -
> -	u2phy1_host: host-port {
> -		phy-supply = <&vbus_host>;
> -		status = "okay";
> -	};
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usbdrd3_0 {
> -	status = "okay";
> -};
> -
> -&usbdrd_dwc3_0 {
> -	status = "okay";
> -};
> -
> -&vbus_host {
> -	enable-active-high;
> -	gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>; /* USB1_EN_OC# */
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&usb1_en_oc>;
> -};
> -
> -&vbus_typec {
> -	enable-active-high;
> -	gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>; /* USB0_EN_OC# */
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&usb0_en_oc>;
> -};
> diff --git a/arch/arm/dts/rk3399pro.dtsi b/arch/arm/dts/rk3399pro.dtsi
> deleted file mode 100644
> index bb5ebf6608b9..000000000000
> --- a/arch/arm/dts/rk3399pro.dtsi
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -// Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
> -
> -#include "rk3399.dtsi"
> -
> -/ {
> -	compatible = "rockchip,rk3399pro";
> -};
> -
> -/* Default to enabled since AP talk to NPU part over pcie */
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -/* Default to enabled since AP talk to NPU part over pcie */
> -&pcie0 {
> -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	status = "okay";
> -};
> diff --git a/doc/device-tree-bindings/clock/rockchip,rk3399-dmc.txt b/doc/device-tree-bindings/clock/rockchip,rk3399-dmc.txt
> deleted file mode 100644
> index 4a56f78f555b..000000000000
> --- a/doc/device-tree-bindings/clock/rockchip,rk3399-dmc.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Rockchip Dynamic Memory Controller Driver
> -Required properties:
> -- compatible: "rockchip,rk3399-dmc", "syscon"
> -- rockchip,cru: this driver should access cru regs, so need get cru here
> -- rockchip,pmucru: this driver should access pmucru regs, so need get pmucru here
> -- rockchip,pmugrf: this driver should access pmugrf regs, so need get pmugrf here
> -- rockchip,pmusgrf: this driver should access pmusgrf regs, so need get pmusgrf here
> -- rockchip,cic: this driver should access cic regs, so need get cic here
> -- reg: dynamic ram protocol controller(PCTL) address, PHY Independent(PI) address, phy controller(PHYCTL) address and memory schedule(MSCH) address
> -- clock: must include clock specifiers corresponding to entries in the clock-names property.
> -    Must contain
> -      dmc_clk: for ddr working frequency
> -- rockchip,sdram-params: SDRAM parameters, including all the information by ddr driver:
> -    Must contain
> -      Genarate by vendor tool and adjust for U-Boot dtsi.
> -
> -Example:
> -	dmc: dmc {
> -		bootph-all;
> -		compatible = "rockchip,rk3399-dmc";
> -		devfreq-events = <&dfi>;
> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_DDRCLK>;
> -		clock-names = "dmc_clk";
> -		reg = <0x0 0xffa80000 0x0 0x0800
> -		       0x0 0xffa80800 0x0 0x1800
> -		       0x0 0xffa82000 0x0 0x2000
> -		       0x0 0xffa84000 0x0 0x1000
> -		       0x0 0xffa88000 0x0 0x0800
> -		       0x0 0xffa88800 0x0 0x1800
> -		       0x0 0xffa8a000 0x0 0x2000
> -		       0x0 0xffa8c000 0x0 0x1000>;
> -	};
> -
> -	&dmc {
> -		rockchip,sdram-params = <
> -		0x2
> -		0xa
> -		0x3
> -		...
> -		>;
> -	};
> diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
> deleted file mode 100644
> index 39169d94a44e..000000000000
> --- a/include/dt-bindings/clock/rk3399-cru.h
> +++ /dev/null
> @@ -1,751 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
> - * Author: Xing Zheng <zhengxing@rock-chips.com>
> - */
> -
> -#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3399_H
> -#define _DT_BINDINGS_CLK_ROCKCHIP_RK3399_H
> -
> -/* core clocks */
> -#define PLL_APLLL			1
> -#define PLL_APLLB			2
> -#define PLL_DPLL			3
> -#define PLL_CPLL			4
> -#define PLL_GPLL			5
> -#define PLL_NPLL			6
> -#define PLL_VPLL			7
> -#define ARMCLKL				8
> -#define ARMCLKB				9
> -
> -/* sclk gates (special clocks) */
> -#define SCLK_I2C1			65
> -#define SCLK_I2C2			66
> -#define SCLK_I2C3			67
> -#define SCLK_I2C5			68
> -#define SCLK_I2C6			69
> -#define SCLK_I2C7			70
> -#define SCLK_SPI0			71
> -#define SCLK_SPI1			72
> -#define SCLK_SPI2			73
> -#define SCLK_SPI4			74
> -#define SCLK_SPI5			75
> -#define SCLK_SDMMC			76
> -#define SCLK_SDIO			77
> -#define SCLK_EMMC			78
> -#define SCLK_TSADC			79
> -#define SCLK_SARADC			80
> -#define SCLK_UART0			81
> -#define SCLK_UART1			82
> -#define SCLK_UART2			83
> -#define SCLK_UART3			84
> -#define SCLK_SPDIF_8CH			85
> -#define SCLK_I2S0_8CH			86
> -#define SCLK_I2S1_8CH			87
> -#define SCLK_I2S2_8CH			88
> -#define SCLK_I2S_8CH_OUT		89
> -#define SCLK_TIMER00			90
> -#define SCLK_TIMER01			91
> -#define SCLK_TIMER02			92
> -#define SCLK_TIMER03			93
> -#define SCLK_TIMER04			94
> -#define SCLK_TIMER05			95
> -#define SCLK_TIMER06			96
> -#define SCLK_TIMER07			97
> -#define SCLK_TIMER08			98
> -#define SCLK_TIMER09			99
> -#define SCLK_TIMER10			100
> -#define SCLK_TIMER11			101
> -#define SCLK_MACREF			102
> -#define SCLK_MAC_RX			103
> -#define SCLK_MAC_TX			104
> -#define SCLK_MAC			105
> -#define SCLK_MACREF_OUT			106
> -#define SCLK_VOP0_PWM			107
> -#define SCLK_VOP1_PWM			108
> -#define SCLK_RGA_CORE			109
> -#define SCLK_ISP0			110
> -#define SCLK_ISP1			111
> -#define SCLK_HDMI_CEC			112
> -#define SCLK_HDMI_SFR			113
> -#define SCLK_DP_CORE			114
> -#define SCLK_PVTM_CORE_L		115
> -#define SCLK_PVTM_CORE_B		116
> -#define SCLK_PVTM_GPU			117
> -#define SCLK_PVTM_DDR			118
> -#define SCLK_MIPIDPHY_REF		119
> -#define SCLK_MIPIDPHY_CFG		120
> -#define SCLK_HSICPHY			121
> -#define SCLK_USBPHY480M			122
> -#define SCLK_USB2PHY0_REF		123
> -#define SCLK_USB2PHY1_REF		124
> -#define SCLK_UPHY0_TCPDPHY_REF		125
> -#define SCLK_UPHY0_TCPDCORE		126
> -#define SCLK_UPHY1_TCPDPHY_REF		127
> -#define SCLK_UPHY1_TCPDCORE		128
> -#define SCLK_USB3OTG0_REF		129
> -#define SCLK_USB3OTG1_REF		130
> -#define SCLK_USB3OTG0_SUSPEND		131
> -#define SCLK_USB3OTG1_SUSPEND		132
> -#define SCLK_CRYPTO0			133
> -#define SCLK_CRYPTO1			134
> -#define SCLK_CCI_TRACE			135
> -#define SCLK_CS				136
> -#define SCLK_CIF_OUT			137
> -#define SCLK_PCIEPHY_REF		138
> -#define SCLK_PCIE_CORE			139
> -#define SCLK_M0_PERILP			140
> -#define SCLK_M0_PERILP_DEC		141
> -#define SCLK_CM0S			142
> -#define SCLK_DBG_NOC			143
> -#define SCLK_DBG_PD_CORE_B		144
> -#define SCLK_DBG_PD_CORE_L		145
> -#define SCLK_DFIMON0_TIMER		146
> -#define SCLK_DFIMON1_TIMER		147
> -#define SCLK_INTMEM0			148
> -#define SCLK_INTMEM1			149
> -#define SCLK_INTMEM2			150
> -#define SCLK_INTMEM3			151
> -#define SCLK_INTMEM4			152
> -#define SCLK_INTMEM5			153
> -#define SCLK_SDMMC_DRV			154
> -#define SCLK_SDMMC_SAMPLE		155
> -#define SCLK_SDIO_DRV			156
> -#define SCLK_SDIO_SAMPLE		157
> -#define SCLK_VDU_CORE			158
> -#define SCLK_VDU_CA			159
> -#define SCLK_PCIE_PM			160
> -#define SCLK_SPDIF_REC_DPTX		161
> -#define SCLK_DPHY_PLL			162
> -#define SCLK_DPHY_TX0_CFG		163
> -#define SCLK_DPHY_TX1RX1_CFG		164
> -#define SCLK_DPHY_RX0_CFG		165
> -#define SCLK_RMII_SRC			166
> -#define SCLK_PCIEPHY_REF100M		167
> -#define SCLK_DDRC			168
> -#define SCLK_TESTCLKOUT1		169
> -#define SCLK_TESTCLKOUT2		170
> -
> -#define DCLK_VOP0			180
> -#define DCLK_VOP1			181
> -#define DCLK_VOP0_DIV			182
> -#define DCLK_VOP1_DIV			183
> -#define DCLK_M0_PERILP			184
> -#define DCLK_VOP0_FRAC			185
> -#define DCLK_VOP1_FRAC			186
> -
> -#define FCLK_CM0S			190
> -
> -/* aclk gates */
> -#define ACLK_PERIHP			192
> -#define ACLK_PERIHP_NOC			193
> -#define ACLK_PERILP0			194
> -#define ACLK_PERILP0_NOC		195
> -#define ACLK_PERF_PCIE			196
> -#define ACLK_PCIE			197
> -#define ACLK_INTMEM			198
> -#define ACLK_TZMA			199
> -#define ACLK_DCF			200
> -#define ACLK_CCI			201
> -#define ACLK_CCI_NOC0			202
> -#define ACLK_CCI_NOC1			203
> -#define ACLK_CCI_GRF			204
> -#define ACLK_CENTER			205
> -#define ACLK_CENTER_MAIN_NOC		206
> -#define ACLK_CENTER_PERI_NOC		207
> -#define ACLK_GPU			208
> -#define ACLK_PERF_GPU			209
> -#define ACLK_GPU_GRF			210
> -#define ACLK_DMAC0_PERILP		211
> -#define ACLK_DMAC1_PERILP		212
> -#define ACLK_GMAC			213
> -#define ACLK_GMAC_NOC			214
> -#define ACLK_PERF_GMAC			215
> -#define ACLK_VOP0_NOC			216
> -#define ACLK_VOP0			217
> -#define ACLK_VOP1_NOC			218
> -#define ACLK_VOP1			219
> -#define ACLK_RGA			220
> -#define ACLK_RGA_NOC			221
> -#define ACLK_HDCP			222
> -#define ACLK_HDCP_NOC			223
> -#define ACLK_HDCP22			224
> -#define ACLK_IEP			225
> -#define ACLK_IEP_NOC			226
> -#define ACLK_VIO			227
> -#define ACLK_VIO_NOC			228
> -#define ACLK_ISP0			229
> -#define ACLK_ISP1			230
> -#define ACLK_ISP0_NOC			231
> -#define ACLK_ISP1_NOC			232
> -#define ACLK_ISP0_WRAPPER		233
> -#define ACLK_ISP1_WRAPPER		234
> -#define ACLK_VCODEC			235
> -#define ACLK_VCODEC_NOC			236
> -#define ACLK_VDU			237
> -#define ACLK_VDU_NOC			238
> -#define ACLK_PERI			239
> -#define ACLK_EMMC			240
> -#define ACLK_EMMC_CORE			241
> -#define ACLK_EMMC_NOC			242
> -#define ACLK_EMMC_GRF			243
> -#define ACLK_USB3			244
> -#define ACLK_USB3_NOC			245
> -#define ACLK_USB3OTG0			246
> -#define ACLK_USB3OTG1			247
> -#define ACLK_USB3_RKSOC_AXI_PERF	248
> -#define ACLK_USB3_GRF			249
> -#define ACLK_GIC			250
> -#define ACLK_GIC_NOC			251
> -#define ACLK_GIC_ADB400_CORE_L_2_GIC	252
> -#define ACLK_GIC_ADB400_CORE_B_2_GIC	253
> -#define ACLK_GIC_ADB400_GIC_2_CORE_L	254
> -#define ACLK_GIC_ADB400_GIC_2_CORE_B	255
> -#define ACLK_CORE_ADB400_CORE_L_2_CCI500 256
> -#define ACLK_CORE_ADB400_CORE_B_2_CCI500 257
> -#define ACLK_ADB400M_PD_CORE_L		258
> -#define ACLK_ADB400M_PD_CORE_B		259
> -#define ACLK_PERF_CORE_L		260
> -#define ACLK_PERF_CORE_B		261
> -#define ACLK_GIC_PRE			262
> -#define ACLK_VOP0_PRE			263
> -#define ACLK_VOP1_PRE			264
> -
> -/* pclk gates */
> -#define PCLK_PERIHP			320
> -#define PCLK_PERIHP_NOC			321
> -#define PCLK_PERILP0			322
> -#define PCLK_PERILP1			323
> -#define PCLK_PERILP1_NOC		324
> -#define PCLK_PERILP_SGRF		325
> -#define PCLK_PERIHP_GRF			326
> -#define PCLK_PCIE			327
> -#define PCLK_SGRF			328
> -#define PCLK_INTR_ARB			329
> -#define PCLK_CENTER_MAIN_NOC		330
> -#define PCLK_CIC			331
> -#define PCLK_COREDBG_B			332
> -#define PCLK_COREDBG_L			333
> -#define PCLK_DBG_CXCS_PD_CORE_B		334
> -#define PCLK_DCF			335
> -#define PCLK_GPIO2			336
> -#define PCLK_GPIO3			337
> -#define PCLK_GPIO4			338
> -#define PCLK_GRF			339
> -#define PCLK_HSICPHY			340
> -#define PCLK_I2C1			341
> -#define PCLK_I2C2			342
> -#define PCLK_I2C3			343
> -#define PCLK_I2C5			344
> -#define PCLK_I2C6			345
> -#define PCLK_I2C7			346
> -#define PCLK_SPI0			347
> -#define PCLK_SPI1			348
> -#define PCLK_SPI2			349
> -#define PCLK_SPI4			350
> -#define PCLK_SPI5			351
> -#define PCLK_UART0			352
> -#define PCLK_UART1			353
> -#define PCLK_UART2			354
> -#define PCLK_UART3			355
> -#define PCLK_TSADC			356
> -#define PCLK_SARADC			357
> -#define PCLK_GMAC			358
> -#define PCLK_GMAC_NOC			359
> -#define PCLK_TIMER0			360
> -#define PCLK_TIMER1			361
> -#define PCLK_EDP			362
> -#define PCLK_EDP_NOC			363
> -#define PCLK_EDP_CTRL			364
> -#define PCLK_VIO			365
> -#define PCLK_VIO_NOC			366
> -#define PCLK_VIO_GRF			367
> -#define PCLK_MIPI_DSI0			368
> -#define PCLK_MIPI_DSI1			369
> -#define PCLK_HDCP			370
> -#define PCLK_HDCP_NOC			371
> -#define PCLK_HDMI_CTRL			372
> -#define PCLK_DP_CTRL			373
> -#define PCLK_HDCP22			374
> -#define PCLK_GASKET			375
> -#define PCLK_DDR			376
> -#define PCLK_DDR_MON			377
> -#define PCLK_DDR_SGRF			378
> -#define PCLK_ISP1_WRAPPER		379
> -#define PCLK_WDT			380
> -#define PCLK_EFUSE1024NS		381
> -#define PCLK_EFUSE1024S			382
> -#define PCLK_PMU_INTR_ARB		383
> -#define PCLK_MAILBOX0			384
> -#define PCLK_USBPHY_MUX_G		385
> -#define PCLK_UPHY0_TCPHY_G		386
> -#define PCLK_UPHY0_TCPD_G		387
> -#define PCLK_UPHY1_TCPHY_G		388
> -#define PCLK_UPHY1_TCPD_G		389
> -#define PCLK_ALIVE			390
> -
> -/* hclk gates */
> -#define HCLK_PERIHP			448
> -#define HCLK_PERILP0			449
> -#define HCLK_PERILP1			450
> -#define HCLK_PERILP0_NOC		451
> -#define HCLK_PERILP1_NOC		452
> -#define HCLK_M0_PERILP			453
> -#define HCLK_M0_PERILP_NOC		454
> -#define HCLK_AHB1TOM			455
> -#define HCLK_HOST0			456
> -#define HCLK_HOST0_ARB			457
> -#define HCLK_HOST1			458
> -#define HCLK_HOST1_ARB			459
> -#define HCLK_HSIC			460
> -#define HCLK_SD				461
> -#define HCLK_SDMMC			462
> -#define HCLK_SDMMC_NOC			463
> -#define HCLK_M_CRYPTO0			464
> -#define HCLK_M_CRYPTO1			465
> -#define HCLK_S_CRYPTO0			466
> -#define HCLK_S_CRYPTO1			467
> -#define HCLK_I2S0_8CH			468
> -#define HCLK_I2S1_8CH			469
> -#define HCLK_I2S2_8CH			470
> -#define HCLK_SPDIF			471
> -#define HCLK_VOP0_NOC			472
> -#define HCLK_VOP0			473
> -#define HCLK_VOP1_NOC			474
> -#define HCLK_VOP1			475
> -#define HCLK_ROM			476
> -#define HCLK_IEP			477
> -#define HCLK_IEP_NOC			478
> -#define HCLK_ISP0			479
> -#define HCLK_ISP1			480
> -#define HCLK_ISP0_NOC			481
> -#define HCLK_ISP1_NOC			482
> -#define HCLK_ISP0_WRAPPER		483
> -#define HCLK_ISP1_WRAPPER		484
> -#define HCLK_RGA			485
> -#define HCLK_RGA_NOC			486
> -#define HCLK_HDCP			487
> -#define HCLK_HDCP_NOC			488
> -#define HCLK_HDCP22			489
> -#define HCLK_VCODEC			490
> -#define HCLK_VCODEC_NOC			491
> -#define HCLK_VDU			492
> -#define HCLK_VDU_NOC			493
> -#define HCLK_SDIO			494
> -#define HCLK_SDIO_NOC			495
> -#define HCLK_SDIOAUDIO_NOC		496
> -
> -#define CLK_NR_CLKS			(HCLK_SDIOAUDIO_NOC + 1)
> -
> -/* pmu-clocks indices */
> -
> -#define PLL_PPLL			1
> -
> -#define SCLK_32K_SUSPEND_PMU		2
> -#define SCLK_SPI3_PMU			3
> -#define SCLK_TIMER12_PMU		4
> -#define SCLK_TIMER13_PMU		5
> -#define SCLK_UART4_PMU			6
> -#define SCLK_PVTM_PMU			7
> -#define SCLK_WIFI_PMU			8
> -#define SCLK_I2C0_PMU			9
> -#define SCLK_I2C4_PMU			10
> -#define SCLK_I2C8_PMU			11
> -
> -#define PCLK_SRC_PMU			19
> -#define PCLK_PMU			20
> -#define PCLK_PMUGRF_PMU			21
> -#define PCLK_INTMEM1_PMU		22
> -#define PCLK_GPIO0_PMU			23
> -#define PCLK_GPIO1_PMU			24
> -#define PCLK_SGRF_PMU			25
> -#define PCLK_NOC_PMU			26
> -#define PCLK_I2C0_PMU			27
> -#define PCLK_I2C4_PMU			28
> -#define PCLK_I2C8_PMU			29
> -#define PCLK_RKPWM_PMU			30
> -#define PCLK_SPI3_PMU			31
> -#define PCLK_TIMER_PMU			32
> -#define PCLK_MAILBOX_PMU		33
> -#define PCLK_UART4_PMU			34
> -#define PCLK_WDT_M0_PMU			35
> -
> -#define FCLK_CM0S_SRC_PMU		44
> -#define FCLK_CM0S_PMU			45
> -#define SCLK_CM0S_PMU			46
> -#define HCLK_CM0S_PMU			47
> -#define DCLK_CM0S_PMU			48
> -#define PCLK_INTR_ARB_PMU		49
> -#define HCLK_NOC_PMU			50
> -
> -#define CLKPMU_NR_CLKS			(HCLK_NOC_PMU + 1)
> -
> -/* soft-reset indices */
> -
> -/* cru_softrst_con0 */
> -#define SRST_CORE_L0			0
> -#define SRST_CORE_B0			1
> -#define SRST_CORE_PO_L0			2
> -#define SRST_CORE_PO_B0			3
> -#define SRST_L2_L			4
> -#define SRST_L2_B			5
> -#define SRST_ADB_L			6
> -#define SRST_ADB_B			7
> -#define SRST_A_CCI			8
> -#define SRST_A_CCIM0_NOC		9
> -#define SRST_A_CCIM1_NOC		10
> -#define SRST_DBG_NOC			11
> -
> -/* cru_softrst_con1 */
> -#define SRST_CORE_L0_T			16
> -#define SRST_CORE_L1			17
> -#define SRST_CORE_L2			18
> -#define SRST_CORE_L3			19
> -#define SRST_CORE_PO_L0_T		20
> -#define SRST_CORE_PO_L1			21
> -#define SRST_CORE_PO_L2			22
> -#define SRST_CORE_PO_L3			23
> -#define SRST_A_ADB400_GIC2COREL		24
> -#define SRST_A_ADB400_COREL2GIC		25
> -#define SRST_P_DBG_L			26
> -#define SRST_L2_L_T			28
> -#define SRST_ADB_L_T			29
> -#define SRST_A_RKPERF_L			30
> -#define SRST_PVTM_CORE_L		31
> -
> -/* cru_softrst_con2 */
> -#define SRST_CORE_B0_T			32
> -#define SRST_CORE_B1			33
> -#define SRST_CORE_PO_B0_T		36
> -#define SRST_CORE_PO_B1			37
> -#define SRST_A_ADB400_GIC2COREB		40
> -#define SRST_A_ADB400_COREB2GIC		41
> -#define SRST_P_DBG_B			42
> -#define SRST_L2_B_T			43
> -#define SRST_ADB_B_T			45
> -#define SRST_A_RKPERF_B			46
> -#define SRST_PVTM_CORE_B		47
> -
> -/* cru_softrst_con3 */
> -#define SRST_A_CCI_T			50
> -#define SRST_A_CCIM0_NOC_T		51
> -#define SRST_A_CCIM1_NOC_T		52
> -#define SRST_A_ADB400M_PD_CORE_B_T	53
> -#define SRST_A_ADB400M_PD_CORE_L_T	54
> -#define SRST_DBG_NOC_T			55
> -#define SRST_DBG_CXCS			56
> -#define SRST_CCI_TRACE			57
> -#define SRST_P_CCI_GRF			58
> -
> -/* cru_softrst_con4 */
> -#define SRST_A_CENTER_MAIN_NOC		64
> -#define SRST_A_CENTER_PERI_NOC		65
> -#define SRST_P_CENTER_MAIN		66
> -#define SRST_P_DDRMON			67
> -#define SRST_P_CIC			68
> -#define SRST_P_CENTER_SGRF		69
> -#define SRST_DDR0_MSCH			70
> -#define SRST_DDRCFG0_MSCH		71
> -#define SRST_DDR0			72
> -#define SRST_DDRPHY0			73
> -#define SRST_DDR1_MSCH			74
> -#define SRST_DDRCFG1_MSCH		75
> -#define SRST_DDR1			76
> -#define SRST_DDRPHY1			77
> -#define SRST_DDR_CIC			78
> -#define SRST_PVTM_DDR			79
> -
> -/* cru_softrst_con5 */
> -#define SRST_A_VCODEC_NOC		80
> -#define SRST_A_VCODEC			81
> -#define SRST_H_VCODEC_NOC		82
> -#define SRST_H_VCODEC			83
> -#define SRST_A_VDU_NOC			88
> -#define SRST_A_VDU			89
> -#define SRST_H_VDU_NOC			90
> -#define SRST_H_VDU			91
> -#define SRST_VDU_CORE			92
> -#define SRST_VDU_CA			93
> -
> -/* cru_softrst_con6 */
> -#define SRST_A_IEP_NOC			96
> -#define SRST_A_VOP_IEP			97
> -#define SRST_A_IEP			98
> -#define SRST_H_IEP_NOC			99
> -#define SRST_H_IEP			100
> -#define SRST_A_RGA_NOC			102
> -#define SRST_A_RGA			103
> -#define SRST_H_RGA_NOC			104
> -#define SRST_H_RGA			105
> -#define SRST_RGA_CORE			106
> -#define SRST_EMMC_NOC			108
> -#define SRST_EMMC			109
> -#define SRST_EMMC_GRF			110
> -
> -/* cru_softrst_con7 */
> -#define SRST_A_PERIHP_NOC		112
> -#define SRST_P_PERIHP_GRF		113
> -#define SRST_H_PERIHP_NOC		114
> -#define SRST_USBHOST0			115
> -#define SRST_HOSTC0_AUX			116
> -#define SRST_HOST0_ARB			117
> -#define SRST_USBHOST1			118
> -#define SRST_HOSTC1_AUX			119
> -#define SRST_HOST1_ARB			120
> -#define SRST_SDIO0			121
> -#define SRST_SDMMC			122
> -#define SRST_HSIC			123
> -#define SRST_HSIC_AUX			124
> -#define SRST_AHB1TOM			125
> -#define SRST_P_PERIHP_NOC		126
> -#define SRST_HSICPHY			127
> -
> -/* cru_softrst_con8 */
> -#define SRST_A_PCIE			128
> -#define SRST_P_PCIE			129
> -#define SRST_PCIE_CORE			130
> -#define SRST_PCIE_MGMT			131
> -#define SRST_PCIE_MGMT_STICKY		132
> -#define SRST_PCIE_PIPE			133
> -#define SRST_PCIE_PM			134
> -#define SRST_PCIEPHY			135
> -#define SRST_A_GMAC_NOC			136
> -#define SRST_A_GMAC			137
> -#define SRST_P_GMAC_NOC			138
> -#define SRST_P_GMAC_GRF			140
> -#define SRST_HSICPHY_POR		142
> -#define SRST_HSICPHY_UTMI		143
> -
> -/* cru_softrst_con9 */
> -#define SRST_USB2PHY0_POR		144
> -#define SRST_USB2PHY0_UTMI_PORT0	145
> -#define SRST_USB2PHY0_UTMI_PORT1	146
> -#define SRST_USB2PHY0_EHCIPHY		147
> -#define SRST_UPHY0_PIPE_L00		148
> -#define SRST_UPHY0			149
> -#define SRST_UPHY0_TCPDPWRUP		150
> -#define SRST_USB2PHY1_POR		152
> -#define SRST_USB2PHY1_UTMI_PORT0	153
> -#define SRST_USB2PHY1_UTMI_PORT1	154
> -#define SRST_USB2PHY1_EHCIPHY		155
> -#define SRST_UPHY1_PIPE_L00		156
> -#define SRST_UPHY1			157
> -#define SRST_UPHY1_TCPDPWRUP		158
> -
> -/* cru_softrst_con10 */
> -#define SRST_A_PERILP0_NOC		160
> -#define SRST_A_DCF			161
> -#define SRST_GIC500			162
> -#define SRST_DMAC0_PERILP0		163
> -#define SRST_DMAC1_PERILP0		164
> -#define SRST_TZMA			165
> -#define SRST_INTMEM			166
> -#define SRST_ADB400_MST0		167
> -#define SRST_ADB400_MST1		168
> -#define SRST_ADB400_SLV0		169
> -#define SRST_ADB400_SLV1		170
> -#define SRST_H_PERILP0			171
> -#define SRST_H_PERILP0_NOC		172
> -#define SRST_ROM			173
> -#define SRST_CRYPTO0_S			174
> -#define SRST_CRYPTO0_M			175
> -
> -/* cru_softrst_con11 */
> -#define SRST_P_DCF			176
> -#define SRST_CM0S_NOC			177
> -#define SRST_CM0S			178
> -#define SRST_CM0S_DBG			179
> -#define SRST_CM0S_PO			180
> -#define SRST_CRYPTO0			181
> -#define SRST_P_PERILP1_SGRF		182
> -#define SRST_P_PERILP1_GRF		183
> -#define SRST_CRYPTO1_S			184
> -#define SRST_CRYPTO1_M			185
> -#define SRST_CRYPTO1			186
> -#define SRST_GIC_NOC			188
> -#define SRST_SD_NOC			189
> -#define SRST_SDIOAUDIO_BRG		190
> -
> -/* cru_softrst_con12 */
> -#define SRST_H_PERILP1			192
> -#define SRST_H_PERILP1_NOC		193
> -#define SRST_H_I2S0_8CH			194
> -#define SRST_H_I2S1_8CH			195
> -#define SRST_H_I2S2_8CH			196
> -#define SRST_H_SPDIF_8CH		197
> -#define SRST_P_PERILP1_NOC		198
> -#define SRST_P_EFUSE_1024		199
> -#define SRST_P_EFUSE_1024S		200
> -#define SRST_P_I2C0			201
> -#define SRST_P_I2C1			202
> -#define SRST_P_I2C2			203
> -#define SRST_P_I2C3			204
> -#define SRST_P_I2C4			205
> -#define SRST_P_I2C5			206
> -#define SRST_P_MAILBOX0			207
> -
> -/* cru_softrst_con13 */
> -#define SRST_P_UART0			208
> -#define SRST_P_UART1			209
> -#define SRST_P_UART2			210
> -#define SRST_P_UART3			211
> -#define SRST_P_SARADC			212
> -#define SRST_P_TSADC			213
> -#define SRST_P_SPI0			214
> -#define SRST_P_SPI1			215
> -#define SRST_P_SPI2			216
> -#define SRST_P_SPI3			217
> -#define SRST_P_SPI4			218
> -#define SRST_SPI0			219
> -#define SRST_SPI1			220
> -#define SRST_SPI2			221
> -#define SRST_SPI3			222
> -#define SRST_SPI4			223
> -
> -/* cru_softrst_con14 */
> -#define SRST_I2S0_8CH			224
> -#define SRST_I2S1_8CH			225
> -#define SRST_I2S2_8CH			226
> -#define SRST_SPDIF_8CH			227
> -#define SRST_UART0			228
> -#define SRST_UART1			229
> -#define SRST_UART2			230
> -#define SRST_UART3			231
> -#define SRST_TSADC			232
> -#define SRST_I2C0			233
> -#define SRST_I2C1			234
> -#define SRST_I2C2			235
> -#define SRST_I2C3			236
> -#define SRST_I2C4			237
> -#define SRST_I2C5			238
> -#define SRST_SDIOAUDIO_NOC		239
> -
> -/* cru_softrst_con15 */
> -#define SRST_A_VIO_NOC			240
> -#define SRST_A_HDCP_NOC			241
> -#define SRST_A_HDCP			242
> -#define SRST_H_HDCP_NOC			243
> -#define SRST_H_HDCP			244
> -#define SRST_P_HDCP_NOC			245
> -#define SRST_P_HDCP			246
> -#define SRST_P_HDMI_CTRL		247
> -#define SRST_P_DP_CTRL			248
> -#define SRST_S_DP_CTRL			249
> -#define SRST_C_DP_CTRL			250
> -#define SRST_P_MIPI_DSI0		251
> -#define SRST_P_MIPI_DSI1		252
> -#define SRST_DP_CORE			253
> -#define SRST_DP_I2S			254
> -
> -/* cru_softrst_con16 */
> -#define SRST_GASKET			256
> -#define SRST_VIO_GRF			258
> -#define SRST_DPTX_SPDIF_REC		259
> -#define SRST_HDMI_CTRL			260
> -#define SRST_HDCP_CTRL			261
> -#define SRST_A_ISP0_NOC			262
> -#define SRST_A_ISP1_NOC			263
> -#define SRST_H_ISP0_NOC			266
> -#define SRST_H_ISP1_NOC			267
> -#define SRST_H_ISP0			268
> -#define SRST_H_ISP1			269
> -#define SRST_ISP0			270
> -#define SRST_ISP1			271
> -
> -/* cru_softrst_con17 */
> -#define SRST_A_VOP0_NOC			272
> -#define SRST_A_VOP1_NOC			273
> -#define SRST_A_VOP0			274
> -#define SRST_A_VOP1			275
> -#define SRST_H_VOP0_NOC			276
> -#define SRST_H_VOP1_NOC			277
> -#define SRST_H_VOP0			278
> -#define SRST_H_VOP1			279
> -#define SRST_D_VOP0			280
> -#define SRST_D_VOP1			281
> -#define SRST_VOP0_PWM			282
> -#define SRST_VOP1_PWM			283
> -#define SRST_P_EDP_NOC			284
> -#define SRST_P_EDP_CTRL			285
> -
> -/* cru_softrst_con18 */
> -#define SRST_A_GPU			288
> -#define SRST_A_GPU_NOC			289
> -#define SRST_A_GPU_GRF			290
> -#define SRST_PVTM_GPU			291
> -#define SRST_A_USB3_NOC			292
> -#define SRST_A_USB3_OTG0		293
> -#define SRST_A_USB3_OTG1		294
> -#define SRST_A_USB3_GRF			295
> -#define SRST_PMU			296
> -
> -/* cru_softrst_con19 */
> -#define SRST_P_TIMER0_5			304
> -#define SRST_TIMER0			305
> -#define SRST_TIMER1			306
> -#define SRST_TIMER2			307
> -#define SRST_TIMER3			308
> -#define SRST_TIMER4			309
> -#define SRST_TIMER5			310
> -#define SRST_P_TIMER6_11		311
> -#define SRST_TIMER6			312
> -#define SRST_TIMER7			313
> -#define SRST_TIMER8			314
> -#define SRST_TIMER9			315
> -#define SRST_TIMER10			316
> -#define SRST_TIMER11			317
> -#define SRST_P_INTR_ARB_PMU		318
> -#define SRST_P_ALIVE_SGRF		319
> -
> -/* cru_softrst_con20 */
> -#define SRST_P_GPIO2			320
> -#define SRST_P_GPIO3			321
> -#define SRST_P_GPIO4			322
> -#define SRST_P_GRF			323
> -#define SRST_P_ALIVE_NOC		324
> -#define SRST_P_WDT0			325
> -#define SRST_P_WDT1			326
> -#define SRST_P_INTR_ARB			327
> -#define SRST_P_UPHY0_DPTX		328
> -#define SRST_P_UPHY0_APB		330
> -#define SRST_P_UPHY0_TCPHY		332
> -#define SRST_P_UPHY1_TCPHY		333
> -#define SRST_P_UPHY0_TCPDCTRL		334
> -#define SRST_P_UPHY1_TCPDCTRL		335
> -
> -/* pmu soft-reset indices */
> -
> -/* pmu_cru_softrst_con0 */
> -#define SRST_P_NOC			0
> -#define SRST_P_INTMEM			1
> -#define SRST_H_CM0S			2
> -#define SRST_H_CM0S_NOC			3
> -#define SRST_DBG_CM0S			4
> -#define SRST_PO_CM0S			5
> -#define SRST_P_SPI6			6
> -#define SRST_SPI6			7
> -#define SRST_P_TIMER_0_1		8
> -#define SRST_P_TIMER_0			9
> -#define SRST_P_TIMER_1			10
> -#define SRST_P_UART4			11
> -#define SRST_UART4			12
> -#define SRST_P_WDT			13
> -
> -/* pmu_cru_softrst_con1 */
> -#define SRST_P_I2C6			16
> -#define SRST_P_I2C7			17
> -#define SRST_P_I2C8			18
> -#define SRST_P_MAILBOX			19
> -#define SRST_P_RKPWM			20
> -#define SRST_P_PMUGRF			21
> -#define SRST_P_SGRF			22
> -#define SRST_P_GPIO0			23
> -#define SRST_P_GPIO1			24
> -#define SRST_P_CRU			25
> -#define SRST_P_INTR			26
> -#define SRST_PVTM			27
> -#define SRST_I2C6			28
> -#define SRST_I2C7			29
> -#define SRST_I2C8			30
> -
> -#endif
> diff --git a/include/dt-bindings/power/rk3399-power.h b/include/dt-bindings/power/rk3399-power.h
> deleted file mode 100644
> index 168b3bfbd6f5..000000000000
> --- a/include/dt-bindings/power/rk3399-power.h
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#ifndef __DT_BINDINGS_POWER_RK3399_POWER_H__
> -#define __DT_BINDINGS_POWER_RK3399_POWER_H__
> -
> -/* VD_CORE_L */
> -#define RK3399_PD_A53_L0	0
> -#define RK3399_PD_A53_L1	1
> -#define RK3399_PD_A53_L2	2
> -#define RK3399_PD_A53_L3	3
> -#define RK3399_PD_SCU_L		4
> -
> -/* VD_CORE_B */
> -#define RK3399_PD_A72_B0	5
> -#define RK3399_PD_A72_B1	6
> -#define RK3399_PD_SCU_B		7
> -
> -/* VD_LOGIC */
> -#define RK3399_PD_TCPD0		8
> -#define RK3399_PD_TCPD1		9
> -#define RK3399_PD_CCI		10
> -#define RK3399_PD_CCI0		11
> -#define RK3399_PD_CCI1		12
> -#define RK3399_PD_PERILP	13
> -#define RK3399_PD_PERIHP	14
> -#define RK3399_PD_VIO		15
> -#define RK3399_PD_VO		16
> -#define RK3399_PD_VOPB		17
> -#define RK3399_PD_VOPL		18
> -#define RK3399_PD_ISP0		19
> -#define RK3399_PD_ISP1		20
> -#define RK3399_PD_HDCP		21
> -#define RK3399_PD_GMAC		22
> -#define RK3399_PD_EMMC		23
> -#define RK3399_PD_USB3		24
> -#define RK3399_PD_EDP		25
> -#define RK3399_PD_GIC		26
> -#define RK3399_PD_SD		27
> -#define RK3399_PD_SDIOAUDIO	28
> -#define RK3399_PD_ALIVE		29
> -
> -/* VD_CENTER */
> -#define RK3399_PD_CENTER	30
> -#define RK3399_PD_VCODEC	31
> -#define RK3399_PD_VDU		32
> -#define RK3399_PD_RGA		33
> -#define RK3399_PD_IEP		34
> -
> -/* VD_GPU */
> -#define RK3399_PD_GPU		35
> -
> -/* VD_PMU */
> -#define RK3399_PD_PMU		36
> -
> -#endif
