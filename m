Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC212C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 10:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1492787DE2;
	Mon, 18 Mar 2024 11:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kgW7OWVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20AA87DFA; Mon, 18 Mar 2024 11:37:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D129E87DA7
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 11:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2d81=KY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710758228;
 bh=65C6vZ+eLbP9rQfKVvmy+88W0WbFDMUJ5AwcauenVds=;
 b=kgW7OWVktsKU+Uck7EgZ0hEY4tH/qzf8twpJJQvZzix0b+goD9hZ/TOQFJPxxfd31PH0eeJzr
 ZDGvNz77Fk6Guyy72CSajT8bpry8vVniOU9rStDK50yDPBoF0eXRCV9C69/kOAFxtph5wBOXFtn
 7d8c85qzwv1tfvWDRw6rt+Lba/C+pbS9rnap7OdgdWpFjFlU1OyAct7iy+hymN1YPJULZMWYsT9
 yjUnqC4e6UQTlyn/zVT8AMpITVr6bYNi33Mo42nuUyZdUbi2lytVzX7Tsg3iu9f15HC7J+B8yfU
 QrPnHdQza5SudGv2WYoimoXlhGh7rzvIksOTM92F6EoQ==
Message-ID: <388ad937-a6e6-43d2-ac4e-fad32d7fbd8f@kwiboo.se>
Date: Mon, 18 Mar 2024 11:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: rock-pi-4-rk3399: enable booting from
 SPI flash
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de, kernel@collabora.com, "Chen-Yu Tsai"
 <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki
 <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240315120126.75424-1-chris.obbard@collabora.com>
 <20240315120126.75424-3-chris.obbard@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240315120126.75424-3-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f8195494d3faf4be110243
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

Hi Christopher,

On 2024-03-15 13:01, Christopher Obbard wrote:
> Some variants of the ROCK Pi 4 series have an SPI flash chip populated
> which can be booted from. This patch enables support in U-Boot for
> building the image for the SPI flash, support for booting U-Boot from the
> SPI flash chip and support in U-Boot for accessing the SPI flash using
> `sf` commands.
> 
> Not all variants (e.g. ROCK Pi 4B, ROCK 4 Model C Plus, ROCK 4SE) come
> populated with an SPI flash chip, but have the footprint on the board so
> a user could solder their own to the board. With this patchset applied,
> these board variants without an SPI flash chip still boot from MMC.
> 
> I have enabled support for both Winbond and XTX SPI flash devices since
> different hardware variants have different devices populated:
> 
>  - `rockpi4_v13_sch_20181112.pdf` contains a Winbond part `W25Q64FWZPIG`
>  - `rockpi4_v14_sch_20210114.pdf` contains an XTX part `XT25F32BWOIGT`
> 
> The ROCK Pi 4 I have is marked as "ROCK PI 4 v1.48" and contains an SPI
> flash chip from XTX:
> 
>     => sf probe
>     SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB
> 
> In the interest of supporting all board variants and not regressing
> existing users who boot from MMC, I have enabled support for booting from
> both SPI flash chip variants in the defconfig and left the environment
> storage location as MMC to not break existing users who have the
> environment stored on MMC.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

With a small nit below this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

> 
> ---
> 
> Changes in v2:
> - Rebase on top of rockchip/for-next.
> - Sync configuration changes with savedefconfig.
> - Remove GigaDevice SPI flash chip support (suggested by Kever Y).
> - Re-enable CONFIG_SPL_FIT_SIGNATURE=y (fixed in rockchip/for-next, solves
>   multiple problems mentioned in v1. Thanks Jonas!).
> - Remove spl-boot-order from rk3399-rock-pi-4a-u-boot.dtsi (suggested by
>   Jonas K).
> - Enable CONFIG_SPI_FLASH_SFDP_SUPPORT=y (suggested by Jonas K).
> 
>  arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi |  7 +++++++
>  configs/rock-pi-4-rk3399_defconfig         | 17 ++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> index 85ee5770add..38385621deb 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> @@ -4,3 +4,10 @@
>   */
>  
>  #include "rk3399-rock-pi-4-u-boot.dtsi"
> +
> +&spi1 {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index bca44beca12..315b8b853fc 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -3,25 +3,30 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>  CONFIG_COUNTER_FREQUENCY=24000000
>  CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=10000000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_LEGACY_IMAGE_FORMAT=y

This may stop scripts from working.

I am getting very close to send out a big rk3399 DT sync and update
series [1] on top of your series. That series will move to imply
LEGACY_IMAGE_FORMAT in Kconfig file, so this does not matter that much.

Please let me know if you will revert this line or if I should send out
my series on top of this patch as-is :-)

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-2024.07-wip

Regards,
Jonas

>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>  CONFIG_TPL=y
>  CONFIG_CMD_BOOTZ=y
> @@ -40,14 +45,20 @@ CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_DFU_MMC=y
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
>  CONFIG_ETH_DESIGNWARE=y
>  CONFIG_GMAC_ROCKCHIP=y
>  CONFIG_NVME_PCI=y
> @@ -61,6 +72,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>  CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
> @@ -81,7 +93,6 @@ CONFIG_VIDEO=y
>  CONFIG_DISPLAY=y
>  CONFIG_VIDEO_ROCKCHIP=y
>  CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>  CONFIG_ERRNO_STR=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

