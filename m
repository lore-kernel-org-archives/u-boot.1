Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C48C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640EC81FEE;
	Fri,  6 Jun 2025 11:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="D7LIj9vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2F0803DF; Fri,  6 Jun 2025 11:21:04 +0200 (CEST)
Received: from mail-m49237.qiye.163.com (mail-m49237.qiye.163.com
 [45.254.49.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A684681FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c37d8c5;
 Fri, 6 Jun 2025 17:20:56 +0800 (GMT+08:00)
Message-ID: <e58db3b3-81c1-48c4-8895-478b44a1fb1b@rock-chips.com>
Date: Fri, 6 Jun 2025 17:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] rockchip: rk3399-nanopi-4: Enable IO-domain driver
 in SPL
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Alexandre Vicenzi <linux@alxd.me>, Anand Moon <linux.amoon@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Deepak Das <deepakdas.linux@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>
References: <20250523165406.40915-1-justin@tidylabs.net>
 <20250523165406.40915-6-justin@tidylabs.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250523165406.40915-6-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGE0eVk0fHRkYTUMaQktPSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97448b1b4603afkunm00abd6821ec2d8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6MSo4KjE*DxkYNEM5SEoi
 TjUKCjBVSlVKTE9CSUtKTU5DTUJPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpKQ01DNwY+
DKIM-Signature: a=rsa-sha256;
 b=D7LIj9vbc7I+gOIatoW+DLnlzCIrJBIuaQgsTdK4AcxuTbzF95zSGQkZkwSW5YfLbfKPKODx91QU7TriKjFLPxW9fPYCjx4Sm8m0ibii29lwkt7nqUeeW+8vmicC7kQZf5mZmQC2vOCfUnHfZ3WjFEX0mzgN2LkLooUcKtE2mZ8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=ya9SOVpebG8J8kS6T/IlgxOT9gb7G7V4h2eiEwHTN0o=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/5/24 00:53, Justin Klaassen wrote:
> The NanoPi RK3399 boards support UHS-I (up to SDR104) SD cards, however
> using any of these 1.8v modes results in a boot failure in SPL upon soft
> reboot.
>
> The issue is that the "vcc_sdio" regulator is left at 1.8v on reboot
> and the corresponding GPIO defaults to 3.3v. This prevents the SD card
> from being reinitialized and read successfully.
>
> This change enables the RK8XX regulators and Rockchip IO-domain drivers
> in SPL, which initializes "vcc_sdio" regulator to 3.0v and configures
> the GPIO for the correct level on boot.
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changes in v4:
> - Resolved merge conflict
>
> Changes in v2:
> - Added defconfig changes for all NanoPi RK3399 boards
>
>   arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 9 +++++++++
>   configs/nanopc-t4-rk3399_defconfig      | 7 +++++++
>   configs/nanopi-m4-2gb-rk3399_defconfig  | 7 +++++++
>   configs/nanopi-m4-rk3399_defconfig      | 7 +++++++
>   configs/nanopi-m4b-rk3399_defconfig     | 7 +++++++
>   configs/nanopi-neo4-rk3399_defconfig    | 7 +++++++
>   configs/nanopi-r4s-rk3399_defconfig     | 7 +++++++
>   7 files changed, 51 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> index ba2b73223d4..62fd21f2ca5 100644
> --- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> @@ -9,6 +9,14 @@
>   	bootph-pre-ram;
>   };
>   
> +&i2c0_xfer {
> +	bootph-pre-ram;
> +};
> +
> +&io_domains {
> +	bootph-pre-ram;
> +};
> +
>   &sdmmc {
>   	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
>   };
> @@ -23,6 +31,7 @@
>   };
>   
>   &vcc_sdio {
> +	bootph-pre-ram;
>   	/delete-property/ regulator-always-on;
>   	/delete-property/ regulator-boot-on;
>   	regulator-init-microvolt = <3000000>;
> diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
> index cf634bdce4c..40e99878016 100644
> --- a/configs/nanopc-t4-rk3399_defconfig
> +++ b/configs/nanopc-t4-rk3399_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopc-t4"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -18,6 +19,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopc-t4.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -33,6 +36,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -46,8 +50,11 @@ CONFIG_NVME_PCI=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
> index e4d6beeb493..5c53293757d 100644
> --- a/configs/nanopi-m4-2gb-rk3399_defconfig
> +++ b/configs/nanopi-m4-2gb-rk3399_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4-2gb"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -19,6 +20,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4-2gb.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -37,6 +40,7 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -50,8 +54,11 @@ CONFIG_NVME_PCI=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
> index 25761e3f9f8..76d2994ae57 100644
> --- a/configs/nanopi-m4-rk3399_defconfig
> +++ b/configs/nanopi-m4-rk3399_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-m4"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -19,6 +20,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -36,6 +39,7 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -49,8 +53,11 @@ CONFIG_NVME_PCI=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
> index f32d3e5ffd1..17241b38946 100644
> --- a/configs/nanopi-m4b-rk3399_defconfig
> +++ b/configs/nanopi-m4b-rk3399_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-m4b"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -19,6 +20,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4b.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -36,6 +39,7 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -49,8 +53,11 @@ CONFIG_NVME_PCI=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
> index 00822f7f655..c0aedd5288b 100644
> --- a/configs/nanopi-neo4-rk3399_defconfig
> +++ b/configs/nanopi-neo4-rk3399_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-neo4"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -17,6 +18,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-neo4.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -31,6 +34,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -43,8 +47,11 @@ CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
> index 100b68bb49e..3ce9bad76fe 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-r4s"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3399=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -17,6 +18,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-r4s.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> @@ -31,6 +34,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -43,8 +47,11 @@ CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
>   CONFIG_BAUDRATE=1500000
