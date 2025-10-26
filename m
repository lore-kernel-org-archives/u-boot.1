Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FC0CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D30838D2;
	Sun, 26 Oct 2025 16:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="C2Xi2UQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE28838E5; Sun, 26 Oct 2025 16:45:20 +0100 (CET)
Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com
 [45.254.49.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C76832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273749002;
 Sun, 26 Oct 2025 23:45:14 +0800 (GMT+08:00)
Message-ID: <cfde6659-c60e-4071-bf84-e578957b4650@rock-chips.com>
Date: Sun, 26 Oct 2025 23:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] rockchip: odroid-go2: Add support for SPI flash
 boot
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2131f84003afkunmfec7ecc14d3171
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHxlOVk8YH0lJTEIaSk8ZTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=C2Xi2UQ28TuquZYADKc4G1EmtZzdvlxKQw6lQdWp3/5Kp2MDs9X1b/Q+YNLnfzdZMXawl3Yr4PLDSPKAX6ZKFv6EZDqtPkgRZ6vODTjdDRgMwCrccphyq/p9XY0czm/zDxjaq7Rp/v7N4hN2DbGhuR8s1bBVzQGcjvati5KIk6I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=f5AAFYnMdBg1PRwJR9wirrGxEp1BZLYeHS3sFgxZhAM=;
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


On 2025/9/1 00:49, Jonas Karlman wrote:
> The ODROID GO2 devices come with onboard SPI flash, add support for
> using the SPI flash.
>
> The BootROM seem to expect the IDBlock at 64 KiB offset compared to the
> typical 32 KiB offset from start of SPI flash used by other SoCs.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3326-u-boot.dtsi | 18 +++++++++++++++++-
>   configs/odroid-go2_defconfig    | 11 +++++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
> index 196604a9987c..be1dd4f91c1b 100644
> --- a/arch/arm/dts/rk3326-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-u-boot.dtsi
> @@ -6,8 +6,12 @@
>   #include "rockchip-u-boot.dtsi"
>   
>   / {
> +	aliases {
> +		spi2 = &sfc;
> +	};
> +
>   	chosen {
> -		u-boot,spl-boot-order = &sdmmc;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc;
>   	};
>   
>   	dmc {
> @@ -22,6 +26,17 @@
>   	};
>   };
>   
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x10000>;
> +		};
> +	};
> +};
> +#endif
> +
>   &cru {
>   	bootph-all;
>   };
> @@ -102,6 +117,7 @@
>   
>   &sfc {
>   	bootph-some-ram;
> +	u-boot,spl-sfc-no-dma;
>   };
>   
>   &sfc_bus2 {
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index a6d02baa520f..09ba6b7fcfaa 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -3,17 +3,23 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=108000000
> +CONFIG_SF_DEFAULT_MODE=0x1000
>   CONFIG_ENV_SIZE=0x4000
>   CONFIG_ENV_OFFSET=0x4000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_PX30=y
>   CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_TARGET_ODROID_GO2=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_SF_DEFAULT_BUS=2
>   CONFIG_DEBUG_UART_BASE=0xFF160000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
> @@ -30,6 +36,8 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_POWER=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
>   CONFIG_SPL_ATF=y
>   # CONFIG_TPL_FRAMEWORK is not set
>   # CONFIG_TPL_BANNER_PRINT is not set
> @@ -70,6 +78,8 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_OTP=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_XTX=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
> @@ -87,6 +97,7 @@ CONFIG_ROCKCHIP_SDRAM_COMMON=y
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SOUND=y
> +CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_DM_THERMAL=y
>   CONFIG_USB=y

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

