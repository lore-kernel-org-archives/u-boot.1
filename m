Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE426CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 08:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7156583B7E;
	Sat,  1 Nov 2025 09:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LrDTYf1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C44D83B81; Sat,  1 Nov 2025 09:01:33 +0100 (CET)
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com
 [45.254.49.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70E583B72
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 09:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 27ff79a35;
 Sat, 1 Nov 2025 16:01:27 +0800 (GMT+08:00)
Message-ID: <336071b8-06fe-4af7-9bae-dacd27c3a5c7@rock-chips.com>
Date: Sat, 1 Nov 2025 16:01:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: imply most symbols for ARCH_ROCKCHIP
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251029-arch-rockchip-imply-v1-1-899e1592a736@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251029-arch-rockchip-imply-v1-1-899e1592a736@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3e6f84ee03afkunmb70cbfca9264e8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ09IVhodGEwYTxpIQ00eGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=LrDTYf1PpxPf5wNJ5nbvjEwCVdUXrzlkxESVbikjQFR33NGgh/6d7xuGOgT7UlPp3Qc/xyaEsjAhB894HHU6yIDzEmBmuU/gdAXXYhrB+fk5eH/V1M+r8NHE65NXHuR3d+gsvpY7VzBp0kEHR4JIs6xD3GQflOjBipHyStXY0Aw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7haQzAFOv4DiSZ9PVf4YrUzwvNJIpB4duwqY1q5ac9c=;
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


On 2025/10/29 19:34, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Forcing all those symbols on means we cannot make the binary smaller or
> with unnecessary features or drivers disabled. This is especially useful
> for security, auditing and certification where less code built means
> less to look at (and less surface attack) and less to patch, but also
> for making binary images smaller which typically means faster boot.
>
> It is possible to have boards without MMC, NAND or SPI flashes, without
> anything on SPI or I2C buses, nothing to control over PWM or GPIO or for
> which we have no interest in regulator control or serial output so make
> it possible to remove all that if desired.
>
> No intended change in default selected symbols.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/Kconfig | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ef834542bd4..4ee74d5cdd8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2072,30 +2072,30 @@ config ARCH_ROCKCHIP
>   	bool "Support Rockchip SoCs"
>   	select BINMAN if SPL_OPTEE || SPL
>   	select DM
> -	select DM_GPIO
> -	select DM_I2C
> -	select DM_PWM
> -	select DM_REGULATOR
> -	select DM_SERIAL
> -	select DM_SPI
> -	select DM_SPI_FLASH
>   	select DM_USB_GADGET if USB_DWC3_GADGET
>   	select ENABLE_ARM_SOC_BOOT0_HOOK
>   	select OF_CONTROL
> -	select MMC
> -	select MTD
> -	select SPI
>   	select SPL_DM if SPL
> -	select SPL_DM_SPI if SPL
> -	select SPL_DM_SPI_FLASH if SPL
>   	select SYS_MALLOC_F
>   	select SYS_THUMB_BUILD if !ARM64
>   	imply ADC
> +	imply BOOTSTD_DEFAULTS
>   	imply CMD_DM
>   	imply DEBUG_UART_BOARD_INIT
> -	imply BOOTSTD_DEFAULTS
> +	imply DM_GPIO
> +	imply DM_I2C
> +	imply DM_PWM
> +	imply DM_REGULATOR
> +	imply DM_SERIAL
> +	imply DM_SPI
> +	imply DM_SPI_FLASH
>   	imply FAT_WRITE
> +	imply MMC
> +	imply MTD
>   	imply SARADC_ROCKCHIP
> +	imply SPI
> +	imply SPL_DM_SPI if SPL
> +	imply SPL_DM_SPI_FLASH if SPL
>   	imply SPL_SYSRESET
>   	imply SPL_SYS_MALLOC_SIMPLE
>   	imply SYS_NS16550
>
> ---
> base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
> change-id: 20251029-arch-rockchip-imply-dc2a843a1767
>
> Best regards,
