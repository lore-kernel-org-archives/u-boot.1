Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1A1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C572885C1;
	Tue, 23 Apr 2024 13:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cNlWmwiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6A5885C2; Tue, 23 Apr 2024 13:14:33 +0200 (CEST)
Received: from mail-m19731125.qiye.163.com (mail-m19731125.qiye.163.com
 [220.197.31.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE8A885AA
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cNlWmwiR6zai1RCeXa2KBtPMsMRMiJwUCgU14aPFhdiqARxuLu/lj8EqcJnWkpVSUSAda/qJp4LPY/qXpafofmyq0+qmF4dCfQ1GMZtNSOxZjX9aBpEkDZ7x7cw+PiCh/6DPXsSEF8WPu4klr4CsyH0ADjQdYTHEyWzau6kVgAQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=jk0VUjPUoVli4PjwkLy7CHBc/+C0yFohU+XrFRwetHQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EB5E890010D;
 Tue, 23 Apr 2024 19:14:19 +0800 (CST)
Message-ID: <6d68715f-93f7-47d7-86a8-e71bbeedbd12@rock-chips.com>
Date: Tue, 23 Apr 2024 19:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/31] rockchip: rk3399-rock-pi-4: Sync device tree from
 linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-29-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-29-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJPSFYZSExIT0xKTkweGh5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0aa9f05503a9kunmeb5e890010d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46ORw4MTNWOj1JKC8#Fw8p
 MCgwCjxVSlVKTEpIQ0xLQ01LQktMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTkNPQzcG
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
> Sync rk3399-rock-pi-4 related device tree from linux v6.8.
>
> Add SPI flash related options to support booting from SPI flash.
>
> Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA boot.
>
> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>
> Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.
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
>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 12 ++++++++++
>   arch/arm/dts/rk3399-rock-4c-plus.dts         |  1 +
>   arch/arm/dts/rk3399-rock-4se-u-boot.dtsi     | 12 ++++++++++
>   arch/arm/dts/rk3399-rock-pi-4.dtsi           |  4 +++-
>   arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi   |  7 ++++++
>   arch/arm/dts/rk3399-rock-pi-4c.dts           | 10 ++++++++
>   configs/rock-4c-plus-rk3399_defconfig        | 24 +++++++++++++++-----
>   configs/rock-4se-rk3399_defconfig            | 23 +++++++++++++++++--
>   configs/rock-pi-4-rk3399_defconfig           |  8 +++++++
>   configs/rock-pi-4c-rk3399_defconfig          | 24 ++++++++++++++++++--
>   10 files changed, 114 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 9785b97b9eea..b5ee644a83dd 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -11,3 +11,15 @@
>   &pcfg_pull_up_8ma {
>   	bootph-pre-ram;
>   };
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus.dts b/arch/arm/dts/rk3399-rock-4c-plus.dts
> index 8bfd5f88d1ef..7baf9d1b22fd 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus.dts
> +++ b/arch/arm/dts/rk3399-rock-4c-plus.dts
> @@ -15,6 +15,7 @@
>   	compatible = "radxa,rock-4c-plus", "rockchip,rk3399";
>   
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdhci;
>   		mmc1 = &sdmmc;
>   	};
> diff --git a/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> index 85ee5770add0..2213d0093052 100644
> --- a/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> @@ -4,3 +4,15 @@
>    */
>   
>   #include "rk3399-rock-pi-4-u-boot.dtsi"
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4.dtsi b/arch/arm/dts/rk3399-rock-pi-4.dtsi
> index b1b7f4ffb1d4..281a12180703 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4.dtsi
> @@ -12,6 +12,7 @@
>   
>   / {
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdhci;
>   		mmc1 = &sdmmc;
>   	};
> @@ -44,7 +45,7 @@
>   	sdio_pwrseq: sdio-pwrseq {
>   		compatible = "mmc-pwrseq-simple";
>   		clocks = <&rk808 1>;
> -		clock-names = "ext_clock";
> +		clock-names = "lpo";
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&wifi_enable_h>;
>   		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> @@ -492,6 +493,7 @@
>   
>   &i2s0 {
>   	pinctrl-0 = <&i2s0_2ch_bus>;
> +	pinctrl-1 = <&i2s0_2ch_bus_bclk_off>;
>   	rockchip,capture-channels = <2>;
>   	rockchip,playback-channels = <2>;
>   	status = "okay";
> diff --git a/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> index 85ee5770add0..38385621deb1 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> @@ -4,3 +4,10 @@
>    */
>   
>   #include "rk3399-rock-pi-4-u-boot.dtsi"
> +
> +&spi1 {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4c.dts b/arch/arm/dts/rk3399-rock-pi-4c.dts
> index d32efab74e94..de2ebe4cb4f3 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4c.dts
> +++ b/arch/arm/dts/rk3399-rock-pi-4c.dts
> @@ -43,6 +43,16 @@
>   	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
>   };
>   
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> +
>   &uart0 {
>   	status = "okay";
>   
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index 2024defb2bf0..e97fde17acc2 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -3,22 +3,27 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_TARGET_ROCKPI4_RK3399=y
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
> -CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4c-plus.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -26,7 +31,6 @@ CONFIG_CMD_NVEDIT_EFI=y
>   CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> -CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
> @@ -40,23 +44,32 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
> -CONFIG_NVME_PCI=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> @@ -77,7 +90,6 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
>   CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index 9b2303fdf792..13f5f84b9836 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -3,22 +3,29 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_TARGET_ROCKPI4_RK3399=y
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_NVEDIT_EFI=y
> @@ -36,14 +43,25 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
> @@ -54,9 +72,11 @@ CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> +CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> @@ -77,7 +97,6 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
>   CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index e5a2bba8e7ff..d474d91053c1 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -17,6 +17,7 @@ CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -43,6 +44,8 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> @@ -54,8 +57,12 @@ CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
> @@ -66,6 +73,7 @@ CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> +CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 4a9d1c531c10..50c6755246f2 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -3,22 +3,29 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_TARGET_ROCKPI4_RK3399=y
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4c.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -37,13 +44,25 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
> @@ -54,9 +73,11 @@ CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> +CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> @@ -77,7 +98,6 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
>   CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
