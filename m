Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408B2E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 06:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936A58036B;
	Wed,  8 Jan 2025 07:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HQUiOodF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE898036B; Wed,  8 Jan 2025 07:57:09 +0100 (CET)
Received: from mail-m12775.qiye.163.com (mail-m12775.qiye.163.com
 [115.236.127.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CFE80607
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 07:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 815356e5;
 Wed, 8 Jan 2025 14:56:59 +0800 (GMT+08:00)
Message-ID: <c339765c-5ad5-403d-95fd-41ea643c5941@rock-chips.com>
Date: Wed, 8 Jan 2025 14:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] arm64: dts: rockchip: Add HDMI0 node to rk3588
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 sumit.garg@linaro.org, jonas@kwiboo.se, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, michal.simek@amd.com, seb-dev@mail.de,
 liujianfeng1994@gmail.com, heiko@sntech.de, zhangzj@rock-chips.com,
 macromorgan@hotmail.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 cfsworks@gmail.com, sebastian.reichel@collabora.com, alchark@gmail.com,
 didi.debian@cknow.org, cassel@kernel.org, boris.brezillon@collabora.com,
 cristian.ciocaltea@collabora.com, jing@jing.rocks
References: <20250104015704.1238-1-naoki@radxa.com>
 <20250104015704.1238-3-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250104015704.1238-3-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlOTVYdGU4YTBpIGEhKTUJWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9444b3c62a03afkunm815356e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6DSo5KzIKTBcIFhY6PBc5
 TzAKCwxVSlVKTEhNSEpCT0lKQ0NCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTktONwY+
DKIM-Signature: a=rsa-sha256;
 b=HQUiOodFrD0Rx1wFHkBiy6oQx0sNpbw2WPhn1WRjc8iWwfm93/Jc0M192tKrPEGGhOeY6vlLgVpusiJnkERCyqO1zpjC7tfdEFTEF/LHQt/o5Kvr357zblgjoGutf6apJs5dzH+NTIzSeGginKANWD50JQ46ikXNelaIwG6rDxo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=FLDUpLa+fp3GJpCG3vYIZ9qyQ6A99ouLazX6MpBv1v8=;
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


On 2025/1/4 09:57, FUKAUMI Naoki wrote:
> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>
> Add support for the HDMI0 output port found on RK3588 SoC.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Link: https://lore.kernel.org/r/20241019-rk3588-hdmi0-dt-v2-1-466cd80e8ff9@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: d7bb71e69f58c1b3665a9f926bf8d3855111bf8e ]
>
> (cherry picked from commit a839348380c2072e00a26bbdb80744982fe04c56)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3588-base.dtsi       | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> index fc67585b64b7..a337f3fb8377 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> @@ -1370,6 +1370,47 @@
>   		status = "disabled";
>   	};
>   
> +	hdmi0: hdmi@fde80000 {
> +		compatible = "rockchip,rk3588-dw-hdmi-qp";
> +		reg = <0x0 0xfde80000 0x0 0x20000>;
> +		clocks = <&cru PCLK_HDMITX0>,
> +			 <&cru CLK_HDMITX0_EARC>,
> +			 <&cru CLK_HDMITX0_REF>,
> +			 <&cru MCLK_I2S5_8CH_TX>,
> +			 <&cru CLK_HDMIHDP0>,
> +			 <&cru HCLK_VO1>;
> +		clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
> +		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "avp", "cec", "earc", "main", "hpd";
> +		phys = <&hdptxphy_hdmi0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmim0_tx0_cec &hdmim0_tx0_hpd
> +			     &hdmim0_tx0_scl &hdmim0_tx0_sda>;
> +		power-domains = <&power RK3588_PD_VO1>;
> +		resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
> +		reset-names = "ref", "hdp";
> +		rockchip,grf = <&sys_grf>;
> +		rockchip,vo-grf = <&vo1_grf>;
> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hdmi0_in: port@0 {
> +				reg = <0>;
> +			};
> +
> +			hdmi0_out: port@1 {
> +				reg = <1>;
> +			};
> +		};
> +	};
> +
>   	qos_gpu_m0: qos@fdf35000 {
>   		compatible = "rockchip,rk3588-qos", "syscon";
>   		reg = <0x0 0xfdf35000 0x0 0x20>;
