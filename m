Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C56C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FA08855D;
	Tue, 23 Apr 2024 13:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FkMqsZMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8438858E; Tue, 23 Apr 2024 13:11:15 +0200 (CEST)
Received: from mail-m121151.qiye.163.com (mail-m121151.qiye.163.com
 [115.236.121.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BB2884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FkMqsZMGJNeIVqJwCKYHauhuQhVfg5LpOaQ6xqAfb44G/f0vvItthaVajLhwWNkMYP/AgarPUqHsoUXSDKmIDaqbFZbF+c+3G95CM1qyPgVoFP/TK3yHJWnC0UJ1PsBMfMN/yVglAT3fALGz2XSUrCMLShE+38Se+RDoaLkvKrQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=B9krSxdAKVm+HbmE+CgmG9Pd/etnhfMkQN3AXbi0V2A=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BF0B0900346;
 Tue, 23 Apr 2024 19:10:57 +0800 (CST)
Message-ID: <1ed663c0-937c-4e91-903b-5501954ddf39@rock-chips.com>
Date: Tue, 23 Apr 2024 19:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/31] rockchip: rk3399-firefly: Sync device tree from
 linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-23-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-23-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1PHlZMS0tOHR1KSkxJSkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0aa6daa403a9kunmbf0b0900346
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6Syo6PjNDIj0jEjcVHj0u
 AhoKCgtVSlVKTEpIQ0xLTU5DTENKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNS05MNwY+
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
> Sync rk3399-firefly device tree from linux v6.8.
>
> Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA.
>
> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>
> Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.
>
> Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.
>
> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>
> Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-firefly.dts  | 17 ++++++++++++-----
>   configs/firefly-rk3399_defconfig | 13 +++++++++++--
>   2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-firefly.dts b/arch/arm/dts/rk3399-firefly.dts
> index c4dd2a6b4836..260415d99aeb 100644
> --- a/arch/arm/dts/rk3399-firefly.dts
> +++ b/arch/arm/dts/rk3399-firefly.dts
> @@ -5,6 +5,7 @@
>   
>   /dts-v1/;
>   #include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/pwm/pwm.h>
>   #include <dt-bindings/usb/pd.h>
>   #include "rk3399.dtsi"
> @@ -15,6 +16,7 @@
>   	compatible = "firefly,firefly-rk3399", "rockchip,rk3399";
>   
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdio0;
>   		mmc1 = &sdmmc;
>   		mmc2 = &sdhci;
> @@ -86,7 +88,7 @@
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwrbtn>;
>   
> -		power {
> +		key-power {
>   			debounce-interval = <100>;
>   			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
>   			label = "GPIO Key Power";
> @@ -245,12 +247,12 @@
>   	vdd_log: vdd-log {
>   		compatible = "pwm-regulator";
>   		pwms = <&pwm2 0 25000 1>;
> +		pwm-supply = <&vcc_sys>;
>   		regulator-name = "vdd_log";
>   		regulator-always-on;
>   		regulator-boot-on;
>   		regulator-min-microvolt = <430000>;
>   		regulator-max-microvolt = <1400000>;
> -		vin-supply = <&vcc_sys>;
>   	};
>   };
>   
> @@ -298,6 +300,11 @@
>   	status = "okay";
>   };
>   
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
>   &hdmi {
>   	ddc-i2c-bus = <&i2c3>;
>   	pinctrl-names = "default";
> @@ -770,8 +777,8 @@
>   	sd-uhs-sdr104;
>   
>   	/* Power supply */
> -	vqmmc-supply = &vcc1v8_s3;	/* IO line */
> -	vmmc-supply = &vcc_sdio;	/* card's power */
> +	vqmmc-supply = <&vcc1v8_s3>;	/* IO line */
> +	vmmc-supply = <&vcc_sdio>;	/* card's power */
>   
>   	#address-cells = <1>;
>   	#size-cells = <0>;
> @@ -781,7 +788,7 @@
>   		reg = <1>;
>   		compatible = "brcm,bcm4329-fmac";
>   		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "host-wake";
>   		brcm,drive-strength = <5>;
>   		pinctrl-names = "default";
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
> index db98926b627a..2f81a2ed0da6 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -14,9 +14,10 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-firefly.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -32,19 +33,28 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
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
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> @@ -61,5 +71,4 @@ CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
