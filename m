Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE692D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED9D89020;
	Fri, 25 Oct 2024 14:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="B9Owz5Sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C661D89023; Fri, 25 Oct 2024 14:35:25 +0200 (CEST)
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com
 [220.197.31.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A441489020
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec47348;
 Fri, 25 Oct 2024 20:35:11 +0800 (GMT+08:00)
Message-ID: <00eaad92-262a-4fd8-9a8c-6fbeb9cc847e@rock-chips.com>
Date: Fri, 25 Oct 2024 20:35:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: rockchip: move NanoPC-T6 parts to DTS
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de, 
 Heiko Stuebner <heiko@sntech.de>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktNGlZPTkgeTk5MHk4fGUxWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3ac71a409d6kunmec47348
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6Cgw6DjIsSBcNKEtMA0gX
 Vg0KCh1VSlVKTElCQ05CTEpJTU5JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISk5CNwY+
DKIM-Signature: a=rsa-sha256;
 b=B9Owz5SkorCa3pocYMdcovZcfWmqzSxIdUDX+NojGcYJXsh4OFwGptFj/G+SCkAUhGbzXZGH0yUTvQ7hDbYTARIeCQXkBJag2yCMqznH4T95vzebEhr1Stz0yJfGaSuDUcWFAlwYyaFu5cZ/4qtgD3H8WbLG58IpSNdlzgvjI58=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=oUdwv5obQMb5y8rsvMU1+PAH2kUHvPMEPIatDOochs4=;
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


On 2024/10/18 04:00, Jonas Karlman wrote:
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> MiniPCIe slot is present only in first version of NanoPC-T6 (2301).
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Link: https://lore.kernel.org/r/20240829-friendlyelec-nanopc-t6-lts-v6-3-edff247e8c02@linaro.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: aea8d84070fe0846961deb23228d9dd3f8caefb3 ]
>
> (cherry picked from commit 697963b1c22336a44ac2e33536c652aae1671b3d)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3588-nanopc-t6.dts   | 23 +++++++++++++++++++
>   .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi  | 17 --------------
>   2 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts
> index 3f8fbec65098..92321c1d3ff1 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts
> @@ -14,4 +14,27 @@
>   	model = "FriendlyElec NanoPC-T6";
>   	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
>   
> +	vdd_4g_3v3: vdd-4g-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pin_4g_lte_pwren>;
> +		regulator-name = "vdd_4g_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&pinctrl {
> +	usb {
> +		pin_4g_lte_pwren: 4g-lte-pwren {
> +			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&u2phy2_host {
> +	phy-supply = <&vdd_4g_3v3>;
>   };
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
> index ad8e36a339dc..d199f51a220c 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
> @@ -170,18 +170,6 @@
>   		regulator-name = "vcc3v3_sd_s0";
>   		vin-supply = <&vcc_3v3_s3>;
>   	};
> -
> -	vdd_4g_3v3: vdd-4g-3v3-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pin_4g_lte_pwren>;
> -		regulator-name = "vdd_4g_3v3";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
>   };
>   
>   &combphy0_ps {
> @@ -527,10 +515,6 @@
>   	};
>   
>   	usb {
> -		pin_4g_lte_pwren: 4g-lte-pwren {
> -			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
>   		typec5v_pwren: typec5v-pwren {
>   			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
> @@ -912,7 +896,6 @@
>   };
>   
>   &u2phy2_host {
> -	phy-supply = <&vdd_4g_3v3>;
>   	status = "okay";
>   };
>   
