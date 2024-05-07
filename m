Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078CCC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E9F8875E;
	Tue,  7 May 2024 05:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Rb1E4T34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F8A8875E; Tue,  7 May 2024 05:35:00 +0200 (CEST)
Received: from mail-m249.xmail.ntesmail.com (mail-m249.xmail.ntesmail.com
 [45.195.24.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FD488763
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Rb1E4T34hz9ai/QcJu0UQd7Y/9mPA8qBRpYvo4ozkeccBPyRwjiN3vl4caUf4wzMSD1x5JogzgcSHmEbk7sCVchuScJjWjIXjewfd0b7E6ByulTIrV6wvRw1uMHzWQplhjtEjhrh8Ps+nc0gnehBuaKODG6EthTGXqHH5jaYhmk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=OInF0WVEG1xpgBtzArMUxCobrHfJmvmpWW5t0SLW5S8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DF586900269;
 Tue,  7 May 2024 11:34:47 +0800 (CST)
Message-ID: <6ca7f30e-248e-4ab8-a9d9-e930d159a77d@rock-chips.com>
Date: Tue, 7 May 2024 11:34:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] rockchip: rk3588-rock-5b: Drop usb-typec node from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktIHlZNSkodHRhOHk0ZT01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f511e41a403a9kunmdf586900269
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6GAw*FTNPLhQoIj5CNQ9D
 DhIaCQ1VSlVKTEpOS05JQ0NDQ0NDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSU1DNwY+
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


On 2024/5/5 03:43, Jonas Karlman wrote:
> The usb-typec related nodes and props added in the board u-boot.dtsi
> file has not yet landed in upstream Linux kernel DT, and they are not
> needed for U-Boot to use the USB Type-C port in peripheral mode.
>
> Remove superfluous usb-typec related nodes and props and replace them
> with a simple dr_mode and maximum-speed prop to cleanup the board
> u-boot.dtsi file.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 106 +-----------------------
>   1 file changed, 2 insertions(+), 104 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index d6020ca790f6..69914f4ce183 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -4,32 +4,12 @@
>    */
>   
>   #include "rk3588-u-boot.dtsi"
> -#include <dt-bindings/usb/pd.h>
> -
> -/ {
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -};
>   
>   &fspim2_pins {
>   	bootph-pre-ram;
>   	bootph-some-ram;
>   };
>   
> -&pinctrl {
> -	usb {
> -		usbc0_int: usbc0-int {
> -			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-hs200-1_8v;
> @@ -76,26 +56,7 @@
>   };
>   
>   &usbdp_phy0 {
> -	orientation-switch;
> -	mode-switch;
> -	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> -	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
>   	status = "okay";
> -
> -	port {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		usbdp_phy0_typec_ss: endpoint@0 {
> -			reg = <0>;
> -			remote-endpoint = <&usbc0_ss>;
> -		};
> -
> -		usbdp_phy0_typec_sbu: endpoint@1 {
> -			reg = <1>;
> -			remote-endpoint = <&usbc0_sbu>;
> -		};
> -	};
>   };
>   
>   &usbdp_phy0_u3 {
> @@ -103,74 +64,11 @@
>   };
>   
>   &usb_host0_xhci {
> -	usb-role-switch;
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
>   	status = "okay";
> -
> -	port {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		usb_host0_xhci_drd_sw: endpoint {
> -			remote-endpoint = <&usbc0_hs>;
> -		};
> -	};
>   };
>   
>   &usb_host1_xhci {
>   	status = "okay";
>   };
> -
> -&i2c4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c4m1_xfer>;
> -	status = "okay";
> -
> -	usbc0: usb-typec@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&usbc0_int>;
> -		vbus-supply = <&vcc12v_dcin>;
> -		status = "okay";
> -
> -		usb_con: connector {
> -			compatible = "usb-c-connector";
> -			label = "USB-C";
> -			data-role = "dual";
> -			power-role = "sink";
> -			try-power-role = "sink";
> -			op-sink-microwatt = <1000000>;
> -			sink-pdos =
> -				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> -				<PDO_VAR(5000, 20000, 5000)>;
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> -					usbc0_hs: endpoint {
> -						remote-endpoint = <&usb_host0_xhci_drd_sw>;
> -					};
> -				};
> -
> -				port@1 {
> -					reg = <1>;
> -					usbc0_ss: endpoint {
> -						remote-endpoint = <&usbdp_phy0_typec_ss>;
> -					};
> -				};
> -
> -				port@2 {
> -					reg = <2>;
> -					usbc0_sbu: endpoint {
> -						remote-endpoint = <&usbdp_phy0_typec_sbu>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -};
