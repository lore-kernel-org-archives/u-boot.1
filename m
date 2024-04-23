Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70FFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDC0885A7;
	Tue, 23 Apr 2024 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ExIXJFGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994A8884F0; Tue, 23 Apr 2024 13:12:17 +0200 (CEST)
Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com
 [45.254.49.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08687884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ExIXJFGHsGsf+vlQ1r+VKP8dFRAqpj++UPfqrcFSTVxTjorkW4hcE5PKKqiqg1WN6ATjyEkou1BEWMK4VhJ9Q1u6UMNxT3jM9EvufpmLdr7oTJYW9mia8xTXG2cznB+6jNEli3yt+q2QuoPAkFfuY7FB+DdfiLUi9Hy/HmAaACo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=CV/7PtqRdLnYRenSaFqNO+WWq941LRhqImWpuE6hLhg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E427190024D;
 Tue, 23 Apr 2024 19:12:01 +0800 (CST)
Message-ID: <511a1eba-16d5-4370-972f-7349afeb7815@rock-chips.com>
Date: Tue, 23 Apr 2024 19:12:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/31] rockchip: rk3399-roc-pc: Sync device tree from
 linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-25-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-25-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhCGlZKQx5DSkJPHk5CSU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0aa7d54b03a9kunme427190024d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6Egw6HjNNHD0MEjA3HhoT
 ODgaCxpVSlVKTEpIQ0xLTElIS0hIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTk9DNwY+
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
> Sync rk3399-roc-pc related device tree from linux v6.8.
>
> Add SF_DEFAULT_SPEED=30000000 and SPI_FLASH_SFDP_SUPPORT=y to improve
> support for booting from SPI flash.
>
> Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA.
>
> Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.
>
> Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.
>
> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Remove USE_PREBOOT=y to speed up booting, standard boot will init USB
> after faster boot media has been evaluated.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-roc-pc.dtsi           | 15 ++++++++-------
>   configs/roc-pc-mezzanine-rk3399_defconfig | 11 ++++++++++-
>   configs/roc-pc-rk3399_defconfig           |  7 +++++--
>   3 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-roc-pc.dtsi b/arch/arm/dts/rk3399-roc-pc.dtsi
> index d1aaf8e83391..ca7a446b6568 100644
> --- a/arch/arm/dts/rk3399-roc-pc.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc.dtsi
> @@ -14,6 +14,7 @@
>   	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>   
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdmmc;
>   		mmc1 = &sdhci;
>   	};
> @@ -41,7 +42,7 @@
>   		keyup-threshold-microvolt = <1500000>;
>   		poll-interval = <100>;
>   
> -		recovery {
> +		button-recovery {
>   			label = "Recovery";
>   			linux,code = <KEY_VENDOR>;
>   			press-threshold-microvolt = <18000>;
> @@ -54,7 +55,7 @@
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwr_key_l>;
>   
> -		power {
> +		key-power {
>   			debounce-interval = <100>;
>   			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
>   			label = "GPIO Key Power";
> @@ -271,6 +272,8 @@
>   };
>   
>   &hdmi {
> +	avdd-0v9-supply = <&vcca0v9_hdmi>;
> +	avdd-1v8-supply = <&vcca1v8_hdmi>;
>   	ddc-i2c-bus = <&i2c3>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&hdmi_cec>;
> @@ -310,8 +313,6 @@
>   		vcc10-supply = <&vcc3v3_sys>;
>   		vcc11-supply = <&vcc3v3_sys>;
>   		vcc12-supply = <&vcc3v3_sys>;
> -		vcc13-supply = <&vcc3v3_sys>;
> -		vcc14-supply = <&vcc3v3_sys>;
>   		vddio-supply = <&vcc_3v0>;
>   
>   		regulators {
> @@ -371,8 +372,8 @@
>   				};
>   			};
>   
> -			vcc1v8_hdmi: LDO_REG2 {
> -				regulator-name = "vcc1v8_hdmi";
> +			vcca1v8_hdmi: LDO_REG2 {
> +				regulator-name = "vcca1v8_hdmi";
>   				regulator-always-on;
>   				regulator-boot-on;
>   				regulator-min-microvolt = <1800000>;
> @@ -735,7 +736,7 @@
>   	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
> -		spi-max-frequency = <10000000>;
> +		spi-max-frequency = <30000000>;
>   	};
>   };
>   
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
> index e13356faabbc..85a20957fa37 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -4,6 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_ENV_SECT_SIZE=0x1000
> @@ -19,6 +20,7 @@ CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-mezzanine.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -41,14 +43,21 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
> @@ -61,6 +70,7 @@ CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> +CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> @@ -84,5 +94,4 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index dee342898d1f..b8adf430e9ea 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -20,7 +20,6 @@ CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
> @@ -43,12 +42,17 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> @@ -85,5 +89,4 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
