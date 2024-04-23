Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5530C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C68885B5;
	Tue, 23 Apr 2024 13:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iCdaCBic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C57885B1; Tue, 23 Apr 2024 13:09:46 +0200 (CEST)
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com
 [115.236.118.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB0D884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iCdaCBicl361aqVQMuEp41XEV19AJTAWRp9JonUSAlwebV1t9jJBGLHo9wvToHaY1UTqh/Yb5yAAcERkh9U3BwpWorrQsxlr0uGJFSIP/MF9R4bXKQEZWjYSltrA5RLAKBzep4CyZZFtbJByzzmlL5sTnBqbrQtAl1t3zpduevU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Ir1znRLrI4VASQwCP7CDzOfUqzVGZonxuMR5PK04PeE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 98A51900317;
 Tue, 23 Apr 2024 19:09:32 +0800 (CST)
Message-ID: <c8ebaf4d-6858-4eb2-a970-fdf1cfa06c76@rock-chips.com>
Date: Tue, 23 Apr 2024 19:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/31] rockchip: rk3399-evb: Sync device tree from linux
 v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-22-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-22-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5KSVZDGBgZHk8eT0pOHkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0aa58d4503a9kunm98a51900317
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6Tio4GTMMDD05ODAOH00i
 PgEaCxlVSlVKTEpIQ0xLTkxISElCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTENNNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> Sync rk3399-evb device tree from linux v6.8.
>
> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>
> Remove CONFIG_NET_RANDOM_ETHADDR=y, ethaddr and eth1addr is set based on
> cpuid read from eFUSE.
>
> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-evb-u-boot.dtsi | 11 +----------
>   arch/arm/dts/rk3399-evb.dts         |  3 ++-
>   configs/evb-rk3399_defconfig        |  6 +++---
>   3 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> index 9df4a02c3e74..68d86194cc4c 100644
> --- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> @@ -12,14 +12,6 @@
>   	};
>   };
>   
> -&i2c0 {
> -	bootph-all;
> -};
> -
> -&rk808 {
> -	bootph-all;
> -};
> -
>   &tcphy1 {
>   	status = "okay";
>   };
> @@ -41,10 +33,9 @@
>   	bus-width = <4>;
>   	cap-mmc-highspeed;
>   	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
>   	disable-wp;
>   	max-frequency = <150000000>;
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/rk3399-evb.dts b/arch/arm/dts/rk3399-evb.dts
> index 7b717ebec8ff..55eca7a50a1f 100644
> --- a/arch/arm/dts/rk3399-evb.dts
> +++ b/arch/arm/dts/rk3399-evb.dts
> @@ -12,6 +12,7 @@
>   	compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
>   
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdhci;
>   	};
>   
> @@ -55,7 +56,7 @@
>   	};
>   
>   	edp_panel: edp-panel {
> -		compatible ="lg,lp079qx1-sp0v";
> +		compatible = "lg,lp079qx1-sp0v";
>   		backlight = <&backlight>;
>   		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
>   		power-supply = <&vcc3v3_s0>;
> diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
> index afb79987464f..334259f73eb2 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -15,7 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-evb.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -30,7 +30,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MMC_HS400_SUPPORT=y
> @@ -39,6 +38,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> @@ -69,5 +70,4 @@ CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_VIDEO_ROCKCHIP_MAX_YRES=1200
>   CONFIG_DISPLAY_ROCKCHIP_MIPI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
