Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B07C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 12:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B9C820EB;
	Tue,  6 May 2025 14:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H2efmXAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2EA8210D; Tue,  6 May 2025 10:06:20 +0200 (CEST)
Received: from mail-m82216.xmail.ntesmail.com (mail-m82216.xmail.ntesmail.com
 [156.224.82.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE9782076
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 10:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1417b087f;
 Tue, 6 May 2025 16:06:06 +0800 (GMT+08:00)
Message-ID: <eafc1363-2c4d-4956-848f-d432332070ed@rock-chips.com>
Date: Tue, 6 May 2025 16:06:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Nick Xie <nick@khadas.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peter Robinson
 <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Xiaobo Tian <peterwillcn@gmail.com>
References: <20250204172319.3361870-1-wens@kernel.org>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250204172319.3361870-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUIZVktMQx5OH08ZSEpMGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lIQktDVUpLS1
 VKQlkG
X-HM-Tid: 0a96a4a175a103afkunm1417b087f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6SSo5PzIMNxcuAgwrMykc
 SzMaC0tVSlVKTE9NTkpDTExLTklKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpDQkpDNwY+
DKIM-Signature: a=rsa-sha256;
 b=H2efmXAcSPvhbUTx+qnhzGKEI4mRx0xocdviRKk0g+p6l0o9KLSxXHefiKKPb7LmMU4GDv9b19DsFZ3tNWD4ULTjZygGDdCVr31NZc7hbD48Z5L+JpMTQcnjgroe7f7POANc0zIiaQ/DAR9UokOANxZEcCSS1+YiRbqIdSx2TJY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=zBQdMNfegu4ZtN8cF6ON9mr97iwgD2nN0SZwxCs2Eww=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Tue, 06 May 2025 14:32:15 +0200
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


On 2025/2/5 01:23, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The IO domain driver controls the I/O voltage for various pins,
> MMC included.
>
> Enable it by default for all supported Rockchip SoCs.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
>   configs/chromebook_bob_defconfig             | 1 -
>   configs/chromebook_kevin_defconfig           | 1 -
>   configs/eaidk-610-rk3399_defconfig           | 1 -
>   configs/ficus-rk3399_defconfig               | 1 -
>   configs/firefly-rk3399_defconfig             | 1 -
>   configs/khadas-edge-captain-rk3399_defconfig | 1 -
>   configs/khadas-edge-rk3399_defconfig         | 1 -
>   configs/khadas-edge-v-rk3399_defconfig       | 1 -
>   configs/leez-rk3399_defconfig                | 1 -
>   configs/nanopc-t4-rk3399_defconfig           | 1 -
>   configs/nanopi-m4-2gb-rk3399_defconfig       | 1 -
>   configs/nanopi-m4-rk3399_defconfig           | 1 -
>   configs/nanopi-m4b-rk3399_defconfig          | 1 -
>   configs/nanopi-neo4-rk3399_defconfig         | 1 -
>   configs/nanopi-r4s-rk3399_defconfig          | 1 -
>   configs/orangepi-rk3399_defconfig            | 1 -
>   configs/pinebook-pro-rk3399_defconfig        | 1 -
>   configs/pinephone-pro-rk3399_defconfig       | 1 -
>   configs/puma-rk3399_defconfig                | 1 -
>   configs/ringneck-px30_defconfig              | 1 -
>   configs/roc-pc-mezzanine-rk3399_defconfig    | 1 -
>   configs/roc-pc-rk3399_defconfig              | 1 -
>   configs/rock-4c-plus-rk3399_defconfig        | 1 -
>   configs/rock-4se-rk3399_defconfig            | 1 -
>   configs/rock-pi-4-rk3399_defconfig           | 1 -
>   configs/rock-pi-4c-rk3399_defconfig          | 1 -
>   configs/rock-pi-n10-rk3399pro_defconfig      | 1 -
>   configs/rock-pi-s-rk3308_defconfig           | 1 -
>   configs/rock-s0-rk3308_defconfig             | 1 -
>   configs/rock960-rk3399_defconfig             | 1 -
>   configs/rockpro64-rk3399_defconfig           | 1 -
>   drivers/misc/Kconfig                         | 6 +++++-
>   32 files changed, 5 insertions(+), 32 deletions(-)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 1b018ef4d7c8..7b45095fc041 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -57,7 +57,6 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_I2C_MUX=y
>   CONFIG_CROS_EC_KEYB=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_CROS_EC=y
>   CONFIG_CROS_EC_SPI=y
>   CONFIG_PWRSEQ=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 1ee0c0e6c9d8..cecd89cded45 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -58,7 +58,6 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_I2C_MUX=y
>   CONFIG_CROS_EC_KEYB=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_CROS_EC=y
>   CONFIG_CROS_EC_SPI=y
>   CONFIG_PWRSEQ=y
> diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
> index 8f9a76157f16..45a2d9016830 100644
> --- a/configs/eaidk-610-rk3399_defconfig
> +++ b/configs/eaidk-610-rk3399_defconfig
> @@ -31,7 +31,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
> index b32ca726b6cf..3a72156d3894 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -37,7 +37,6 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
> index 3871627318b6..be8cde094466 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -34,7 +34,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
> index 89611a0535ed..ce425eb9b20c 100644
> --- a/configs/khadas-edge-captain-rk3399_defconfig
> +++ b/configs/khadas-edge-captain-rk3399_defconfig
> @@ -45,7 +45,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
> index 3816f4327a61..10a20d749ba5 100644
> --- a/configs/khadas-edge-rk3399_defconfig
> +++ b/configs/khadas-edge-rk3399_defconfig
> @@ -43,7 +43,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
> index 35e209425729..d3345c12fe25 100644
> --- a/configs/khadas-edge-v-rk3399_defconfig
> +++ b/configs/khadas-edge-v-rk3399_defconfig
> @@ -45,7 +45,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
> index 57b097377fab..f12f39857e00 100644
> --- a/configs/leez-rk3399_defconfig
> +++ b/configs/leez-rk3399_defconfig
> @@ -31,7 +31,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
> index 26c12c510785..40844753ccd8 100644
> --- a/configs/nanopc-t4-rk3399_defconfig
> +++ b/configs/nanopc-t4-rk3399_defconfig
> @@ -34,7 +34,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
> index d24b7bc6d174..31b0e83cdea6 100644
> --- a/configs/nanopi-m4-2gb-rk3399_defconfig
> +++ b/configs/nanopi-m4-2gb-rk3399_defconfig
> @@ -38,7 +38,6 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
> index da3e44af8418..1a9b770c1692 100644
> --- a/configs/nanopi-m4-rk3399_defconfig
> +++ b/configs/nanopi-m4-rk3399_defconfig
> @@ -37,7 +37,6 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
> index 247056ab58b4..d3a8b5bb6d1f 100644
> --- a/configs/nanopi-m4b-rk3399_defconfig
> +++ b/configs/nanopi-m4b-rk3399_defconfig
> @@ -37,7 +37,6 @@ CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
> index 305877d20796..1e422befdf8e 100644
> --- a/configs/nanopi-neo4-rk3399_defconfig
> +++ b/configs/nanopi-neo4-rk3399_defconfig
> @@ -32,7 +32,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
> index a6dafe3d9eb5..04642bca7cbd 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -32,7 +32,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
> index fdf3d6989393..d5091ee8a0c5 100644
> --- a/configs/orangepi-rk3399_defconfig
> +++ b/configs/orangepi-rk3399_defconfig
> @@ -32,7 +32,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index dfa927ccb170..676d1e718945 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -51,7 +51,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
>   CONFIG_MMC_UHS_SUPPORT=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 5e16749ba7d4..85833c654b8f 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -47,7 +47,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 7a180b141303..95ed6eea953d 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -64,7 +64,6 @@ CONFIG_GPIO_HOG=y
>   CONFIG_SPL_GPIO_HOG=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 324581b4082e..93caaf68e2d7 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -81,7 +81,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_ROCKCHIP_OTP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
> index 3ab5fd69c62a..9c063ce82d34 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -45,7 +45,6 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index 0ef867487787..68c4267d2426 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -43,7 +43,6 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index 0c73a212ea1f..2f1ea314302f 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -49,7 +49,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index 3ae19692155a..7387130ecc18 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -53,7 +53,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index f3a5c2c45f35..97a7db3730df 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -54,7 +54,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 9bda50c8c77f..7da7ee4bce16 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -54,7 +54,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
> index a9c6d8a907a9..a38670d95d0e 100644
> --- a/configs/rock-pi-n10-rk3399pro_defconfig
> +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> @@ -35,7 +35,6 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 4b08af309b1b..907b999b274d 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -40,7 +40,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
> index 0a46e7bb1871..a762734231a0 100644
> --- a/configs/rock-s0-rk3308_defconfig
> +++ b/configs/rock-s0-rk3308_defconfig
> @@ -40,7 +40,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index aebfa73459ca..607aa61ba172 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -41,7 +41,6 @@ CONFIG_SYS_MMC_ENV_DEV=1
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 75322073285c..1b887cd9f3ea 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -49,7 +49,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> -CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index da84b35e8043..9f8bef5068c8 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -104,7 +104,11 @@ config ROCKCHIP_OTP
>   config ROCKCHIP_IODOMAIN
>   	bool "Rockchip IO-domain driver support"
>   	depends on DM_REGULATOR && ARCH_ROCKCHIP
> -	default y if ROCKCHIP_RK3328 || ROCKCHIP_RK3568
> +	default y if ROCKCHIP_PX30
> +	default y if ROCKCHIP_RK3308
> +	default y if ROCKCHIP_RK3328
> +	default y if ROCKCHIP_RK3399
> +	default y if ROCKCHIP_RK3568
>   	help
>   	  Enable support for IO-domains in Rockchip SoCs. It is necessary
>   	  for the IO-domain setting of the SoC to match the voltage supplied
