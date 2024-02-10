Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843BC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 18:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9E087C61;
	Sat, 10 Feb 2024 19:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="sibmuKA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526B987E52; Sat, 10 Feb 2024 19:31:59 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AADB878CB
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 19:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707589916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wy2siu/8LTun8z3qK+PrNLsW2cxA4zwPXxG1z17wR2M=;
 b=sibmuKA7TScEgPUavZX8wJ0OcUO1oowLJHWmW8b7GDYlUctzLyrC6htNfBpqKlTJd48MdY
 D9fuScUh7HeVSWiLfrq5m4RewHAi65wPneQxig87U8mS20twyCaXEjc6NED9uE/d9SVZId
 8XzeM/IJbB1TPuOh7mr8CfphPup5ol4n6YuSalMOvcf1Ynbql/LHlDT0vb1Wm+5Lyh9qJ0
 OfjuzEBz8Fmk3GRZvBPuMqJ0i0NmVqOTH+R/xeMZt4Yujcd4weQPUsY3SGboC0cL+6G8Wd
 pfdLwYaWpEI+JzeyraF+8spOWpvii1/BWCO7nnP1U1txoQ5caA5Vg6KGM8Wpxg==
Date: Sat, 10 Feb 2024 19:31:56 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 14/15] rockchip: rk3328-rock64: Enable boot from SPI NOR
 flash
In-Reply-To: <20240207000301.3270722-15-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-15-jonas@kwiboo.se>
Message-ID: <4cab520b0fa3c502a4c995ca236b87ee@manjaro.org>
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

On 2024-02-07 01:02, Jonas Karlman wrote:
> Add Kconfig options to enable support for booting from SPI NOR flash on
> Pine64 Rock64.
> 
> The generated bootable u-boot-rockchip-spi.bin that can be written to
> 0x0 of SPI NOR flash. The FIT image is loaded from 0x60000, same as on
> RK35xx boards.
> 
>   => sf probe
>   SF: Detected gd25q128 with page size 256 Bytes, erase size 4 KiB, 
> total 16 MiB
> 
>   => load mmc 1:1 10000000 u-boot-rockchip-spi.bin
>   1359872 bytes read in 65 ms (20 MiB/s)
> 
>   => sf update $fileaddr 0 $filesize
>   device 0 offset 0x0, size 0x14c000
>   1118208 bytes written, 241664 bytes skipped in 8.516s, speed 163516 
> B/s
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.  I'm just not sure that we need to support multiple
SPI chip brands, because I can't recall that the Rock64 has been shipped
with different SPI chips, but perhaps better safe than sorry.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  configs/rock64-rk3328_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/configs/rock64-rk3328_defconfig 
> b/configs/rock64-rk3328_defconfig
> index 0157a1efe374..01e447448513 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3328=y
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>  CONFIG_TPL_LIBCOMMON_SUPPORT=y
>  CONFIG_TPL_LIBGENERIC_SUPPORT=y
>  CONFIG_SPL_STACK_R_ADDR=0x600000
> @@ -20,6 +21,8 @@ CONFIG_SPL_STACK=0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>  CONFIG_DEBUG_UART_BASE=0xFF130000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_DEBUG_UART=y
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
> @@ -42,6 +45,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
>  CONFIG_SPL_STACK_R=y
>  CONFIG_SPL_I2C=y
>  CONFIG_SPL_POWER=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>  CONFIG_SPL_ATF=y
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=y
> @@ -76,7 +81,10 @@ CONFIG_MISC=y
>  CONFIG_ROCKCHIP_EFUSE=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_PHY_REALTEK=y
>  CONFIG_DM_ETH_PHY=y
>  CONFIG_ETH_DESIGNWARE=y
