Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B8AC47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7322987BF4;
	Thu,  1 Feb 2024 04:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CG1DHgEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E296F87BF4; Thu,  1 Feb 2024 04:01:46 +0100 (CET)
Received: from mail-m12756.qiye.163.com (mail-m12756.qiye.163.com
 [115.236.127.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3A08760D
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CG1DHgEdtuxyFSDeIs1BTD5oCdEHdJoQgDSt4o/YvSYqsNSKgEqHDR53j9syoCNLklFLerH3UJx0yrweFs5hlHTmZ7J29tUnfyCNklzIRZt8vgIrTmty7yGUOKGMDAh1uIxRaAEuBZZeszpaP0zj1sfJs15ir0aTf7xCTUZXHJs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=sTnw+tNelRi6gFb97QptXRPSC8DPbdFJU87Qd1FKWeo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A20AB90018C;
 Thu,  1 Feb 2024 11:01:30 +0800 (CST)
Message-ID: <a915f251-0ef2-4b17-b4e3-11c049ccfd14@rock-chips.com>
Date: Thu, 1 Feb 2024 11:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] rockchip: rk356x: Move common uart2 props to
 rk356x-u-boot.dtsi
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240126221508.4093334-1-jonas@kwiboo.se>
 <20240126221508.4093334-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240126221508.4093334-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwdSVZJH0pOSUNPT0hCSx1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d629d499e03a9kunma20ab90018c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6GDo6UTMNDE0fPRITNQMu
 QjQKCzBVSlVKTEtNTE5NT0JJSUpNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUtJSTcG
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


On 2024/1/27 06:14, Jonas Karlman wrote:
> Move uart2 bootph-pre-ram and clock-frequency props from board to SoC
> u-boot.dtsi. Regular board device tree already enables the uart2 node,
> so status prop is dropped from u-boot.dtsi file.
>
> Also remove unnecessary stdout-path = &uart2, regular board device tree
> already provide a stdout-path = "serial2:" value.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  7 -------
>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi     | 12 ------------
>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi     | 12 ------------
>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi   | 12 ------------
>   arch/arm/dts/rk3566-soquartz-u-boot.dtsi       | 12 ------------
>   arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi     | 13 -------------
>   arch/arm/dts/rk3568-evb-u-boot.dtsi            | 17 -----------------
>   arch/arm/dts/rk3568-generic-u-boot.dtsi        | 11 -----------
>   arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi     | 12 ------------
>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi     | 12 ------------
>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi      | 12 ------------
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi      | 12 ------------
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi        | 12 ------------
>   arch/arm/dts/rk356x-u-boot.dtsi                |  5 +++++
>   14 files changed, 5 insertions(+), 156 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> index f986e1941e7f..fa3df73c33db 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> @@ -4,7 +4,6 @@
>   
>   / {
>   	chosen {
> -		stdout-path = &uart2;
>   		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
>   	};
>   
> @@ -88,9 +87,3 @@
>   	vqmmc-supply = <&vcc_1v8>;
>   	status = "okay";
>   };
> -
> -&uart2 {
> -	clock-frequency = <24000000>;
> -	bootph-all;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> index 06cc15ed21b8..11976fd3a6e0 100644
> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> @@ -2,12 +2,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &gpio0 {
>   	bootph-all;
>   };
> @@ -28,12 +22,6 @@
>   	};
>   };
>   
> -&uart2 {
> -	bootph-all;
> -	clock-frequency = <24000000>;
> -	status = "okay";
> -};
> -
>   /*
>    * U-Boot does not support multiple regulators using the same gpio,
>    * use vcc5v0_usb20_host to fix use of USB 2.0 port
> diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> index 3c2c54e94183..8de9d1535efb 100644
> --- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> @@ -2,12 +2,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> @@ -24,12 +18,6 @@
>   	};
>   };
>   
> -&uart2 {
> -	bootph-all;
> -	clock-frequency = <24000000>;
> -	status = "okay";
> -};
> -
>   &usb_host0_xhci {
>   	dr_mode = "host";
>   };
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> index c925439f71cd..158f652cb3b1 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> @@ -5,19 +5,7 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
>   };
> -
> -&uart2 {
> -	clock-frequency = <24000000>;
> -	bootph-all;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> index 793cca2ceaca..f65f4067f3e9 100644
> --- a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> @@ -2,12 +2,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> @@ -15,12 +9,6 @@
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   };
>   
> -&uart2 {
> -	bootph-all;
> -	clock-frequency = <24000000>;
> -	status = "okay";
> -};
> -
>   &usb_host0_xhci {
>   	dr_mode = "host";
>   };
> diff --git a/arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi b/arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> index 60a3b21f2d45..5f4f14b3bdae 100644
> --- a/arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> @@ -4,16 +4,3 @@
>    */
>   
>   #include "rk356x-u-boot.dtsi"
> -
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
> -&uart2 {
> -	clock-frequency = <24000000>;
> -	bootph-pre-ram;
> -	status = "okay";
> -};
> -
> diff --git a/arch/arm/dts/rk3568-evb-u-boot.dtsi b/arch/arm/dts/rk3568-evb-u-boot.dtsi
> index 382a52a28b10..5f4f14b3bdae 100644
> --- a/arch/arm/dts/rk3568-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-evb-u-boot.dtsi
> @@ -4,20 +4,3 @@
>    */
>   
>   #include "rk356x-u-boot.dtsi"
> -
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
> -	};
> -};
> -
> -&sdmmc0 {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	clock-frequency = <24000000>;
> -	bootph-pre-ram;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3568-generic-u-boot.dtsi b/arch/arm/dts/rk3568-generic-u-boot.dtsi
> index 90022580a13b..6e8307e3bdf6 100644
> --- a/arch/arm/dts/rk3568-generic-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-generic-u-boot.dtsi
> @@ -1,14 +1,3 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   
>   #include "rk356x-u-boot.dtsi"
> -
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
> -&uart2 {
> -	bootph-pre-ram;
> -	clock-frequency = <24000000>;
> -};
> diff --git a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> index 27c627752333..a44ac35bdacd 100644
> --- a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> @@ -19,9 +13,3 @@
>   	mmc-hs400-enhanced-strobe;
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   };
> -
> -&uart2 {
> -	bootph-all;
> -	clock-frequency = <24000000>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> index 880f8ff91fcb..62f572c4cf9f 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -8,12 +8,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &pcie3x1 {
>   	/delete-property/ vpcie3v3-supply;
>   };
> @@ -27,12 +21,6 @@
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   };
>   
> -&uart2 {
> -	clock-frequency = <24000000>;
> -	bootph-all;
> -	status = "okay";
> -};
> -
>   &vcc5v0_usb_host {
>   	/delete-property/ regulator-always-on;
>   	/delete-property/ regulator-boot-on;
> diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> index 0fc360b06df7..ecba91aa30f5 100644
> --- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> @@ -2,12 +2,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &fspi_dual_io_pins {
>   	bootph-all;
>   };
> @@ -29,9 +23,3 @@
>   		bootph-pre-ram;
>   	};
>   };
> -
> -&uart2 {
> -	bootph-all;
> -	clock-frequency = <24000000>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index 1136f0bb3b81..caf524443079 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -2,12 +2,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &pcie3x1 {
>   	pinctrl-0 = <&pcie30x1_reset_h>;
>   };
> @@ -28,12 +22,6 @@
>   	mmc-hs400-enhanced-strobe;
>   };
>   
> -&uart2 {
> -	bootph-all;
> -	clock-frequency = <24000000>;
> -	status = "okay";
> -};
> -
>   &usb_host0_xhci {
>   	dr_mode = "host";
>   };
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index b05b7151e6c7..46ebb77283f1 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
>   &pcie3x2 {
>   	pinctrl-0 = <&pcie3x2_reset_h>;
>   };
> @@ -48,9 +42,3 @@
>   		spi-tx-bus-width = <1>;
>   	};
>   };
> -
> -&uart2 {
> -	clock-frequency = <24000000>;
> -	bootph-all;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 354b6958e572..cacd45348a49 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -141,6 +141,11 @@
>   	bootph-pre-ram;
>   };
>   
> +&uart2 {
> +	bootph-pre-ram;
> +	clock-frequency = <24000000>;
> +};
> +
>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>   &binman {
>   	simple-bin-spi {
