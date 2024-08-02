Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7BDC52D71
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5E588B8E;
	Fri,  2 Aug 2024 08:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CdbnN7s6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7D888B86; Fri,  2 Aug 2024 08:19:04 +0200 (CEST)
Received: from mail-m3283.qiye.163.com (mail-m3283.qiye.163.com
 [220.197.32.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A4988BA2
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CdbnN7s6fbHBKntDTUfsUTHTAzy16zuu24vQt71QU57CJRLF7MfqtW4IZbf7LkjvV6Lil9UM+3S3Yqp8AKeUQUtCiUpu3jtFb1BH5JJC73ftAt7GgA7rQFMfcFjql0tw/IapBc98atQNFHCaGlDFUdBxVwQ0aoyRbKpxKBhTbFY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=enGZVzbw7ZWvxEHYkZfsALUNOBMVrpPnh5+3zMubhig=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1CB489004A0;
 Fri,  2 Aug 2024 14:18:49 +0800 (CST)
Message-ID: <c822e048-8db7-427e-b2d7-44b02dcbc89f@rock-chips.com>
Date: Fri, 2 Aug 2024 14:18:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: rockchip: Update WIFi/BT related nodes on
 rk3308-rock-pi-s
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1NTFYYS0tLSh5NQx1IQ09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bdaf3203a9kunm1cb489004a0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6Mhw*HjI5NSIsOAE1FDEo
 LVFPCxRVSlVKTElJTkxCTkhLS0hMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUtDNwY+
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
> Update WiFi SDIO and BT UART related props to better reflect details
> about the optional onboard RTL8723DS WiFi/BT module.
>
> Also correct the compatible used for bluetooth to match the WiFi/BT
> module used on the board.
>
> Fixes: bc3753aed81f ("arm64: dts: rockchip: rock-pi-s add more peripherals")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-14-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 12c3ec878cbe3709782e85b88124abecc3bb8617 ]
>
> (cherry picked from commit caba73747c927b4fdccea3aeb16e077b4e6af006)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3308-rock-pi-s.dts   | 40 +++++++++++++++++--
>   1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> index 5c702f00b27f..62d18ca769a1 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> @@ -17,6 +17,7 @@
>   		ethernet0 = &gmac;
>   		mmc0 = &emmc;
>   		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
>   	};
>   
>   	chosen {
> @@ -245,6 +246,20 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&rtc_32k>;
>   
> +	bluetooth {
> +		bt_reg_on: bt-reg-on {
> +			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_host: bt-wake-host {
> +			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		host_wake_bt: host-wake-bt {
> +			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>   	gmac {
>   		mac_rst: mac-rst {
>   			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -294,11 +309,24 @@
>   	cap-sd-highspeed;
>   	cap-sdio-irq;
>   	keep-power-in-suspend;
> -	max-frequency = <1000000>;
> +	max-frequency = <100000000>;
>   	mmc-pwrseq = <&sdio_pwrseq>;
> +	no-mmc;
> +	no-sd;
>   	non-removable;
> -	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	vmmc-supply = <&vcc_io>;
> +	vqmmc-supply = <&vcc_1v8>;
>   	status = "okay";
> +
> +	rtl8723ds: wifi@1 {
> +		reg = <1>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_host_wake>;
> +	};
>   };
>   
>   &sdmmc {
> @@ -330,12 +358,16 @@
>   };
>   
>   &uart4 {
> +	uart-has-rtscts;
>   	status = "okay";
>   
>   	bluetooth {
> -		compatible = "realtek,rtl8723bs-bt";
> -		device-wake-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		compatible = "realtek,rtl8723ds-bt";
> +		device-wake-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
>   		host-wake-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_reg_on &bt_wake_host &host_wake_bt>;
>   	};
>   };
>   
