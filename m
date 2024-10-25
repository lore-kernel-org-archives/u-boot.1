Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7914BD0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D7A88FEC;
	Fri, 25 Oct 2024 13:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YH1Ak3zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9EF88FCB; Fri, 25 Oct 2024 13:58:42 +0200 (CEST)
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com
 [220.197.31.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8929688F95
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe581a;
 Fri, 25 Oct 2024 19:58:30 +0800 (GMT+08:00)
Message-ID: <104ed934-3c26-4a02-b40a-f498227bcdee@rock-chips.com>
Date: Fri, 25 Oct 2024 19:58:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] arm64: dts: rockchip: enable usb ports on
 Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-5-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MZT1YYTkodGh0eQxpMQh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38ade2a09d6kunmebe581a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6HBw5MjIoORcfEwg4KEoj
 Sg5PCSFVSlVKTElCQ05MTkpKQk1KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ0NLNwY+
DKIM-Signature: a=rsa-sha256;
 b=YH1Ak3zkUS1SP7Lk4ebBAWnO7EHa0q38UyYyjd7C4k/Atk1hL1bssVS+VBbwkS6Mj+BhMoK/Z4wUpKrmz/oe/laiM1b0dWOIQqP9U3nE9lWC9nxdy4KYJAh7gUdw9loGNuBeHaXhBlkuZDRaJrj+MZofQmT1SQ57qQNdzLMZkl8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=9EN+E5ENKV5MV8oqWYKFIZ37IY9qJLUhNdykzjHfC40=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> Enable usb controllers and phys and add regulator infrastructure for the
> usb ports on the TS433.
>
> Of course there are no schematics available for the device, so the
> regulator information comes from the vendor-devicetree with unknown
> accuracy.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-5-heiko@sntech.de
>
> [ upstream commit: d992203f57c5caad0dbd4a9c669d79b315873c81 ]
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> (cherry picked from commit bb745ef13efb9f6589f9eda8f66664bf263a13f3)
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 105 ++++++++++++++++++
>   1 file changed, 105 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index bc26f2e98c1..da735c4764f 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -31,6 +31,49 @@
>   		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
>   		vin-supply = <&dc_12v>;
>   	};
> +
> +	vcc5v0_host: regulator-vcc5v0-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host_en>;
> +		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc5v0_host";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_otg: regulator-vcc5v0-otg {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_otg_en>;
> +		regulator-name = "vcc5v0_otg";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_usb: regulator-vcc5v0-usb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +};
> +
> +/* connected to usb_host0_xhci */
> +&combphy0 {
> +	status = "okay";
>   };
>   
>   &gmac0 {
> @@ -97,6 +140,18 @@
>   	status = "okay";
>   };
>   
> +&pinctrl {
> +	usb {
> +		vcc5v0_host_en: vcc5v0-host-en {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc5v0_otg_en: vcc5v0-otg-en {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
>   &sdhci {
>   	bus-width = <8>;
>   	max-frequency = <200000000>;
> @@ -121,3 +176,53 @@
>   &uart2 {
>   	status = "okay";
>   };
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +/* connected to usb_host0_xhci */
> +&usb2phy0_otg {
> +	phy-supply = <&vcc5v0_otg>;
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +/* connected to usb_host1_ehci/ohci */
> +&usb2phy1_host {
> +	phy-supply = <&vcc5v0_host>;
> +	status = "okay";
> +};
> +
> +/* connected to usb_host0_ehci/ohci */
> +&usb2phy1_otg {
> +	phy-supply = <&vcc5v0_host>;
> +	status = "okay";
> +};
> +
> +/* right port backside */
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +/* front port */
> +&usb_host0_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +/* left port backside */
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
