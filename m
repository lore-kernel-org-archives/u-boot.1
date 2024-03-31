Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EB1CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F9F87C7F;
	Sun, 31 Mar 2024 23:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="fJqbfeQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3E987F8B; Sun, 31 Mar 2024 23:33:17 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB13C86FCE
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 23:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711920794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNks5VWZQ/ih8//kTKnvo6DABz78Xp9tiIyOv7uFN3w=;
 b=fJqbfeQiY8F1dfIG/ozmr56OYhk0cuClh5WM3gp4yv4SRbSURexzpGvMVwKy7NFiBe3mM3
 Zt+31le2nQECKm6iHbnAnU4YZ737U5LN+yfUlQxjjRDphbAu2MvIG3/ZOzave4PeJhzl1X
 ojU0M3dU4l4xFr0CVfSYA+YbImgA8GePdaxbKHNnKFcJWibkE9tDXdS32eiC7bfODsWx8K
 LkKpzjzLKWPuy3nfHhooa8U0hQ6b+Ke00mk4NcKWaZklEq3w3lAuZsXXyBZDF4Ms/ZMEPR
 C91gPIzfZf9b7T+MtIr/rn+41vqtUcIxIJov/J19suM7qPgIO4TQg2V7iOyu4Q==
Date: Sun, 31 Mar 2024 23:33:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 30/31] rockchip: rk3399-pinebook-pro: Sync device tree
 from linux v6.8
In-Reply-To: <20240331202921.262323-31-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-31-jonas@kwiboo.se>
Message-ID: <e0cb4cf1b038460ce476a555acd9eeb7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-03-31 22:28, Jonas Karlman wrote:
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

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm/dts/rk3399-pinebook-pro.dts  | 24 +++++++-----------------
>  configs/pinebook-pro-rk3399_defconfig |  6 ++++--
>  2 files changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3399-pinebook-pro.dts
> b/arch/arm/dts/rk3399-pinebook-pro.dts
> index d6b68d77d63a..054c6a4d1a45 100644
> --- a/arch/arm/dts/rk3399-pinebook-pro.dts
> +++ b/arch/arm/dts/rk3399-pinebook-pro.dts
> @@ -50,19 +50,9 @@
>  		pinctrl-0 = <&panel_en_pin>;
>  		power-supply = <&vcc3v3_panel>;
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
>  			};
>  		};
>  	};
> @@ -76,7 +66,7 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&lidbtn_pin>;
> 
> -		lid {
> +		switch-lid {
>  			debounce-interval = <20>;
>  			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
>  			label = "Lid";
> @@ -92,7 +82,7 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pwrbtn_pin>;
> 
> -		power {
> +		key-power {
>  			debounce-interval = <20>;
>  			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
>  			label = "Power";
> @@ -675,7 +665,7 @@
>  	i2c-scl-rising-time-ns = <168>;
>  	status = "okay";
> 
> -	es8316: es8316@11 {
> +	es8316: audio-codec@11 {
>  		compatible = "everest,es8316";
>  		reg = <0x11>;
>  		clocks = <&cru SCLK_I2S_8CH_OUT>;
> @@ -943,7 +933,7 @@
>  	disable-wp;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
>  	vmmc-supply = <&vcc3v0_sd>;
>  	vqmmc-supply = <&vcc_sdio>;
>  	status = "okay";
> diff --git a/configs/pinebook-pro-rk3399_defconfig
> b/configs/pinebook-pro-rk3399_defconfig
> index dd8bc2b72cc3..8ac6ddd49dea 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>  CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_SPL_GPIO=y
>  CONFIG_NR_DRAM_BANKS=1
> -CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_SF_DEFAULT_SPEED=10000000
>  CONFIG_ENV_SIZE=0x8000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-pinebook-pro"
> @@ -36,6 +36,7 @@ CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
> +CONFIG_CMD_POWEROFF=y
>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
> @@ -64,7 +65,9 @@ CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>  CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
>  CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> @@ -98,5 +101,4 @@ CONFIG_VIDEO=y
>  CONFIG_DISPLAY=y
>  CONFIG_VIDEO_ROCKCHIP=y
>  CONFIG_DISPLAY_ROCKCHIP_EDP=y
> -CONFIG_SPL_TINY_MEMSET=y
>  CONFIG_ERRNO_STR=y
