Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F52C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B55A88622;
	Mon,  6 May 2024 12:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RL2T3WZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410FA8801F; Mon,  6 May 2024 12:38:02 +0200 (CEST)
Received: from mail-m6021.netease.com (mail-m6021.netease.com [210.79.60.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A2788624
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=RL2T3WZQ4rFM1uhWDbrYreoauBnhmkf49ZM7XQ8g8w2oQIbXL03dDWfVHr6X8kzxA2APpnBquy9Sf0kC5qizBXumWhfeeZUIB9GCsIAnJYfmRwA4gZUb9XG4q904PTZDyuFZ8OrRLt4EGnzY2Mu2YywCuCsMvF5VdrfA1HYUIvU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=1Iuqs3lr0TY2aQJHMGOdnsp9B0Fzg1CEDfQ3Yc2y1OU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BA6D990031B;
 Mon,  6 May 2024 18:37:49 +0800 (CST)
Message-ID: <88369f29-639f-4f9c-a8cc-87fbf7f9d580@rock-chips.com>
Date: Mon, 6 May 2024 18:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] rockchip: rk3399: Configure sdmmc regulator
 pinctrl in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-19-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-19-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlPTFYeSEoaGUsYTUpJTx9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d7b322a03a9kunmba6d990031b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6Tzo6LzMDNhYuMTwXOh4y
 QhVPFB9VSlVKTEpPQkJKQ0xKS0lJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQkxNSjcG
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> A few boards have shown to be required to properly configure pinctrl
> for the fixed regulator gpio pin used by sdmmc before being able to read
> from SD-cards.
>
> Include the related gpio, regulator and pinctrl nodes and enable related
> Kconfig options so that pinctrl can be configured in SPL for boards that
> may be affected by such issue.
>
> Also change to imply SPL_DM_SEQ_ALIAS for all boards because it must be
> enabled for working gpio usage in SPL after a future DT sync.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "Fix loading FIT from SD-card" patch
> ---
>   arch/arm/dts/rk3399-nanopi4-u-boot.dtsi      | 12 ++++++++++++
>   arch/arm/dts/rk3399-orangepi-u-boot.dtsi     | 12 ++++++++++++
>   arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi | 12 ++++++++++++
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi       | 12 ++++++++++++
>   arch/arm/dts/rk3399-rockpro64-u-boot.dtsi    | 12 ++++++++++++
>   arch/arm/mach-rockchip/Kconfig               |  1 +
>   configs/chromebook_bob_defconfig             |  1 -
>   configs/chromebook_kevin_defconfig           |  1 -
>   configs/nanopc-t4-rk3399_defconfig           |  2 ++
>   configs/nanopi-m4-2gb-rk3399_defconfig       |  2 ++
>   configs/nanopi-m4-rk3399_defconfig           |  2 ++
>   configs/nanopi-m4b-rk3399_defconfig          |  2 ++
>   configs/nanopi-neo4-rk3399_defconfig         |  2 ++
>   configs/nanopi-r4s-rk3399_defconfig          |  2 ++
>   configs/orangepi-rk3399_defconfig            |  2 ++
>   configs/pinebook-pro-rk3399_defconfig        |  3 ++-
>   configs/pinephone-pro-rk3399_defconfig       |  1 -
>   configs/puma-rk3399_defconfig                |  1 -
>   configs/roc-pc-mezzanine-rk3399_defconfig    |  2 +-
>   configs/roc-pc-rk3399_defconfig              |  2 +-
>   configs/rock-pi-4-rk3399_defconfig           |  1 -
>   configs/rockpro64-rk3399_defconfig           |  3 ++-
>   22 files changed, 81 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> index a126bbaf086f..e0d7a518dfc2 100644
> --- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> @@ -5,6 +5,18 @@
>   
>   #include "rk3399-u-boot.dtsi"
>   
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
>   &sdmmc {
>   	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
>   };
> +
> +&sdmmc0_pwr_h {
> +	bootph-pre-ram;
> +};
> +
> +&vcc3v0_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/rk3399-orangepi-u-boot.dtsi b/arch/arm/dts/rk3399-orangepi-u-boot.dtsi
> index d4327ea607c4..b7452eca2254 100644
> --- a/arch/arm/dts/rk3399-orangepi-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-orangepi-u-boot.dtsi
> @@ -6,6 +6,18 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-ddr3-1333.dtsi"
>   
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
> +&sdmmc0_pwr_h {
> +	bootph-pre-ram;
> +};
> +
> +&vcc3v0_sd {
> +	bootph-pre-ram;
> +};
> +
>   &vdd_log {
>   	regulator-init-microvolt = <950000>;
>   };
> diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> index 17af95a114fc..2341db444ef3 100644
> --- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> @@ -10,6 +10,10 @@
>   	rockchip,panel = <&edp_panel>;
>   };
>   
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
>   &sdhci {
>   	max-frequency = <25000000>;
>   };
> @@ -18,11 +22,19 @@
>   	max-frequency = <20000000>;
>   };
>   
> +&sdmmc0_pwr_h_pin {
> +	bootph-pre-ram;
> +};
> +
>   &spiflash {
>   	bootph-pre-ram;
>   	bootph-some-ram;
>   };
>   
> +&vcc3v0_sd {
> +	bootph-pre-ram;
> +};
> +
>   &vdd_log {
>   	regulator-init-microvolt = <950000>;
>   };
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index d40daacc7823..aecf7dbe383c 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -32,6 +32,10 @@
>   	vin-supply = <&vcc_vbus_typec0>;
>   };
>   
> +&gpio4 {
> +	bootph-pre-ram;
> +};
> +
>   &spi1 {
>   	flash@0 {
>   		bootph-pre-ram;
> @@ -39,6 +43,14 @@
>   	};
>   };
>   
> +&vcc3v0_sd {
> +	bootph-pre-ram;
> +};
> +
> +&vcc3v0_sd_en {
> +	bootph-pre-ram;
> +};
> +
>   &vcc5v0_host {
>   	regulator-always-on;
>   };
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index e280739057df..43b67991fe5a 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -28,11 +28,19 @@
>           };
>   };
>   
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
>   };
>   
> +&sdmmc0_pwr_h {
> +	bootph-pre-ram;
> +};
> +
>   &spi1 {
>   	flash@0 {
>   		bootph-pre-ram;
> @@ -40,6 +48,10 @@
>   	};
>   };
>   
> +&vcc3v0_sd {
> +	bootph-pre-ram;
> +};
> +
>   &vdd_center {
>   	regulator-min-microvolt = <950000>;
>   	regulator-max-microvolt = <950000>;
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 7d6374b73586..262cb7cba3ea 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -277,6 +277,7 @@ config ROCKCHIP_RK3399
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
> +	imply SPL_DM_SEQ_ALIAS
>   	imply SPL_FIT_SIGNATURE
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 5ffd5195ea19..9e15d9e3b8f6 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -61,7 +61,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index bacdcc367bda..a79703c0a138 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -62,7 +62,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
> index f935716ccf47..89c36e273a9b 100644
> --- a/configs/nanopc-t4-rk3399_defconfig
> +++ b/configs/nanopc-t4-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopc-t4"
> @@ -42,6 +43,7 @@ CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
> index d142b702ce89..eb1d2c1f51fc 100644
> --- a/configs/nanopi-m4-2gb-rk3399_defconfig
> +++ b/configs/nanopi-m4-2gb-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4-2gb"
> @@ -38,6 +39,7 @@ CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
> index 8ce879da4c07..bc0b90b3d861 100644
> --- a/configs/nanopi-m4-rk3399_defconfig
> +++ b/configs/nanopi-m4-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4"
> @@ -38,6 +39,7 @@ CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
> index 33ef74a1f690..678f4d9d823f 100644
> --- a/configs/nanopi-m4b-rk3399_defconfig
> +++ b/configs/nanopi-m4b-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4b"
> @@ -38,6 +39,7 @@ CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
> index 45a7d0a3257d..d9b7a90e8402 100644
> --- a/configs/nanopi-neo4-rk3399_defconfig
> +++ b/configs/nanopi-neo4-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-neo4"
> @@ -38,6 +39,7 @@ CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
> index a666547fe597..1fcccf2bae6e 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
> @@ -38,6 +39,7 @@ CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
> index 337eeab8b42b..703732ad15f0 100644
> --- a/configs/orangepi-rk3399_defconfig
> +++ b/configs/orangepi-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-orangepi"
> @@ -38,6 +39,7 @@ CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index a250624dfaa9..dd8bc2b72cc3 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_SIZE=0x8000
> @@ -44,7 +45,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
> @@ -72,6 +72,7 @@ CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_DM_PMIC_FAN53555=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index dcdac6b32d6d..c36898364b5d 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -43,7 +43,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 53fc62bf7e35..5edba19e6ce8 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -50,7 +50,6 @@ CONFIG_ENV_SPI_MAX_HZ=50000000
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_GPIO_HOG=y
>   CONFIG_SPL_GPIO_HOG=y
>   CONFIG_ROCKCHIP_GPIO=y
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
> index f281df6c1b12..e13356faabbc 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -41,7 +41,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MMC_DW=y
> @@ -57,6 +56,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index 0d4a03db9e65..dee342898d1f 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -41,7 +41,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MMC_DW=y
> @@ -56,6 +55,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index 6cf445dd6338..e5a2bba8e7ff 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -43,7 +43,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 6c829089fd91..173f8f75020d 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
> @@ -41,7 +42,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SATA=y
>   CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
> @@ -65,6 +65,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
