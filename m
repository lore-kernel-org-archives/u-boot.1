Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879C0D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC3189048;
	Fri, 25 Oct 2024 14:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XC9LLHFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB87B8901C; Fri, 25 Oct 2024 14:00:11 +0200 (CEST)
Received: from mail-m127164.xmail.ntesmail.com
 (mail-m127164.xmail.ntesmail.com [115.236.127.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D8989028
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5859;
 Fri, 25 Oct 2024 19:59:36 +0800 (GMT+08:00)
Message-ID: <263cdd89-4019-43f8-899f-251d2e678b27@rock-chips.com>
Date: Fri, 25 Oct 2024 19:59:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] arm64: dts: rockchip: define cpu-supply on the
 Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-12-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-12-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlKQlZISElPGh9JGBhMTE1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38bdd5e09d6kunmebe5859
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6CAw4KDIZCxczKUs4NixP
 CzkwFD9VSlVKTElCQ05MTkxMSk5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEhONwY+
DKIM-Signature: a=rsa-sha256;
 b=XC9LLHFMkO3XaGPZtmXhMDxc3mU0N5ByXTuvXfCkjx+l5zW/qEV6TOxlo0wGrbOMDAPI6cZ+trUniAZXksetmSJzJTfp4I8vgekLZWSWlAc8J5+NRI90mdGsvgg6AJ+Q46VjjELRgYzjALKXIC9s8q/+OTPFfiqOL333yzmWtXY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=1VDnibGwA3UgaVtNYl4DCn+LCly1OoaF3TUKsONwzMY=;
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
> The TS433 seems to use a silergy,syr827 regulator for the cpu supply.
> At least that is the compatible used in the vendor devicetree, though
> it could very well also be another fan53555 clone.
>
> Define the needed regulator node and hook up the cpu-supply to the
> cpu cores.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-12-heiko@sntech.de
>
> [ upstream commit: 99b36ba910d896bddbb9a190ca686c6d9cd0325f ]
>
> (cherry picked from commit 2f0afd1a3cbf6f3192dc7a5c496affab718671b3)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 9f964b6f411..4bccefc0537 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -130,6 +130,16 @@
>   		vin-supply = <&vcc5v0_usb>;
>   	};
>   
> +	vcc5v0_sys: regulator-vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
>   	vcc5v0_usb: regulator-vcc5v0-usb {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc5v0_usb";
> @@ -156,6 +166,22 @@
>   	status = "okay";
>   };
>   
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
>   &gmac0 {
>   	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
>   	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
> @@ -175,12 +201,27 @@
>   };
>   
>   &i2c0 {
> +	status = "okay";
> +
>   	pmic@20 {
>   		compatible = "rockchip,rk809";
>   		reg = <0x20>;
>   		interrupt-parent = <&gpio0>;
>   		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>   	};
> +
> +	vdd_cpu: regulator@40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1390000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
>   };
>   
>   &i2c1 {
