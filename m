Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4664C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0961889F6;
	Tue, 23 Apr 2024 13:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bbKCfgKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6284C885AA; Tue, 23 Apr 2024 13:14:59 +0200 (CEST)
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com
 [115.236.118.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 514BC885BF
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=bbKCfgKOs/CEH38IrBRWFqkBzcWjVBEZUyY7UMH9XyXHAr9fAs+JMngyQQxTDogHubDb6egVhxBil1duO+7QkIzgSRdo3bZjLaDXWLZJPMH/c/aAX2sZBqo7JLJ6w0r0qr+S64AQoatdG2N7T6dRul7XpTvbouckkdTn7n+WNfs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=H7X2Oz62DTgFt3NKQg7xIKOBAOANo+BuyggorNU7LlI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E6C139002F3;
 Tue, 23 Apr 2024 19:14:41 +0800 (CST)
Message-ID: <bb5e3b6d-b8e7-4b5f-8d2b-98f29aa7a68c@rock-chips.com>
Date: Tue, 23 Apr 2024 19:14:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/31] rockchip: rk3399-pinebook-pro: Sync device tree
 from linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-31-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-31-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhNHlZLTk9JGR5KHx5DTE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0aaa46a803a9kunme6c139002f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6EAw4NzNPOj0hAigyFxcw
 N08aCxNVSlVKTEpIQ0xLQ0NJQ0pNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOS05NNwY+
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
> Sync rk3399-pinebook-pro device tree from linux v6.8.
>
> Add SF_DEFAULT_SPEED=10000000 and SPI_FLASH_SFDP_SUPPORT=y to improve
> support for booting from SPI flash.
>
> Add CMD_POWEROFF=y to support poweroff using cmdline and power on using
> the pwr button on the board.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-pinebook-pro.dts  | 24 +++++++-----------------
>   configs/pinebook-pro-rk3399_defconfig |  6 ++++--
>   2 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-pinebook-pro.dts b/arch/arm/dts/rk3399-pinebook-pro.dts
> index d6b68d77d63a..054c6a4d1a45 100644
> --- a/arch/arm/dts/rk3399-pinebook-pro.dts
> +++ b/arch/arm/dts/rk3399-pinebook-pro.dts
> @@ -50,19 +50,9 @@
>   		pinctrl-0 = <&panel_en_pin>;
>   		power-supply = <&vcc3v3_panel>;
>   
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				panel_in_edp: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&edp_out_panel>;
> -				};
> +		port {
> +			panel_in_edp: endpoint {
> +				remote-endpoint = <&edp_out_panel>;
>   			};
>   		};
>   	};
> @@ -76,7 +66,7 @@
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&lidbtn_pin>;
>   
> -		lid {
> +		switch-lid {
>   			debounce-interval = <20>;
>   			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
>   			label = "Lid";
> @@ -92,7 +82,7 @@
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwrbtn_pin>;
>   
> -		power {
> +		key-power {
>   			debounce-interval = <20>;
>   			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
>   			label = "Power";
> @@ -675,7 +665,7 @@
>   	i2c-scl-rising-time-ns = <168>;
>   	status = "okay";
>   
> -	es8316: es8316@11 {
> +	es8316: audio-codec@11 {
>   		compatible = "everest,es8316";
>   		reg = <0x11>;
>   		clocks = <&cru SCLK_I2S_8CH_OUT>;
> @@ -943,7 +933,7 @@
>   	disable-wp;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
>   	vmmc-supply = <&vcc3v0_sd>;
>   	vqmmc-supply = <&vcc_sdio>;
>   	status = "okay";
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index dd8bc2b72cc3..8ac6ddd49dea 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-pinebook-pro"
> @@ -36,6 +36,7 @@ CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
> +CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_TIME=y
> @@ -64,7 +65,9 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> @@ -98,5 +101,4 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_EDP=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
