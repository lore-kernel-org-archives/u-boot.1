Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D64E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECDAC803B7;
	Fri,  3 Jan 2025 04:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iD36i/vK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE36803CE; Fri,  3 Jan 2025 04:39:57 +0100 (CET)
Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com
 [220.197.32.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62050803DF
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79258e82;
 Fri, 3 Jan 2025 11:39:48 +0800 (GMT+08:00)
Message-ID: <7f8471df-3131-41ae-8436-6a7142737708@rock-chips.com>
Date: Fri, 3 Jan 2025 11:39:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Add HDMI0 node to rk3588
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@linaro.org,
 jonas@kwiboo.se, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20241210033614.2292-1-naoki@radxa.com>
 <20241210033614.2292-4-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241210033614.2292-4-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1LGlZMGkJMH01KSxpNTBhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a3f705503afkunm79258e82
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6MRw5KDIUDy1LEEkVHAMy
 FlZPFBFVSlVKTEhOQ0xOTkNCTUNOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0hNNwY+
DKIM-Signature: a=rsa-sha256;
 b=iD36i/vKTwhsJXp2W7IScPDW1ZqgMhYa9xiqGi5+JR6oqHHA5Z8Zflcr513I1a4N8wk82n/aDJrS7pOJ9hNw5kUmRQDqHTfmAOJoU3SvfksjyX7/dyHnufAyZynYi2zePQldWNI9+fghi1gWgR1Kpwdqfb5GTK9rLaTeVH5e8z4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=utL4schtmCkZJhkKgNTOHb2dMDkWiv2bsaP1pyJAPJ0=;
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


On 2024/12/10 11:36, FUKAUMI Naoki wrote:
> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>
> Add support for the HDMI0 output port found on RK3588 SoC.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Link: https://lore.kernel.org/r/20241019-rk3588-hdmi0-dt-v2-1-466cd80e8ff9@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> (cherry picked from commit d7bb71e69f58c1b3665a9f926bf8d3855111bf8e)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3588-base.dtsi       | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> index ee99166ebd46..3064ecf1e22a 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> @@ -1254,6 +1254,47 @@
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
