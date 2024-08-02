Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177B7C52D71
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2722D88B7F;
	Fri,  2 Aug 2024 08:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VNLkIEqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F55D88B80; Fri,  2 Aug 2024 08:18:46 +0200 (CEST)
Received: from mail-m1018.netease.com (mail-m1018.netease.com [154.81.10.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4C488B7F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VNLkIEqvbLZzp8Vnr1+ghhyEDfpHZNj4eDXM+fogGYYW/lxkfWNZ0GbwShvZ1hhwem+ISQAG3aMGcbX/rg/0qOj6SEuxQiU8HCV/vscP4lRpZa3cvM6vm7kGeLuwvzV6kav5xTxY7gJSFH/rs/FpqDijG6pHF5u2LOUhlkvILIk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=l9NuDLyFv5rYNxpMdxHwf3Qfsrs+6cI89klqM1Bwlsw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 86F47900461;
 Fri,  2 Aug 2024 14:18:33 +0800 (CST)
Message-ID: <2d23275f-6103-4b2a-a56e-84db5559c299@rock-chips.com>
Date: Fri, 2 Aug 2024 14:18:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: rockchip: Add mdio and ethernet-phy nodes
 to rk3308-rock-pi-s
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1NTlZKSBgaShgdHkJLTE9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bd727a03a9kunm86f47900461
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6GCo4MDI*NSI6OAEeFVYo
 UTYKCitVSlVKTElJTkxCTkpPSE9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITU1KNwY+
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


On 2024/7/30 22:51, Jonas Karlman wrote:
> Be explicit about the Ethernet port and define mdio and ethernet-phy
> nodes in the device tree for ROCK Pi S.
>
> Fixes: bc3753aed81f ("arm64: dts: rockchip: rock-pi-s add more peripherals")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-8-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 4b64ed510ed946a4e4ca6d51d6512bf5361f6a04 ]
>
> (cherry picked from commit 703b8eae20eec5dbb0e52f0e1fb71e712c007dae)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3308-rock-pi-s.dts   | 26 ++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> index d4cf6026241c..f6fb90e13ad0 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> @@ -144,11 +144,25 @@
>   
>   &gmac {
>   	clock_in_out = "output";
> +	phy-handle = <&rtl8201f>;
>   	phy-supply = <&vcc_io>;
> -	snps,reset-gpio = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 50000 50000>;
>   	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rtl8201f: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mac_rst>;
> +			reset-assert-us = <20000>;
> +			reset-deassert-us = <50000>;
> +			reset-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
>   };
>   
>   &gpio0 {
> @@ -221,6 +235,12 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&rtc_32k>;
>   
> +	gmac {
> +		mac_rst: mac-rst {
> +			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>   	leds {
>   		green_led: green-led {
>   			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
