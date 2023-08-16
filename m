Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9656EC04A6A
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 12:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A52B8677D;
	Wed, 16 Aug 2023 14:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kxCvGT7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFD98638B; Wed, 16 Aug 2023 14:46:17 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57859867F6
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [172.20.10.2] (unknown [109.166.130.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 51EAF6600359;
 Wed, 16 Aug 2023 13:46:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692189973;
 bh=11YkeYFtdyuHlp4S+xHkZHQMHLPDdEVxnNk/gyPs3MI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kxCvGT7n77zfBqRAr+tZgIQrx5GnuI2/rxuyQb2cp9aqEEcvvwbN/d+NAx1bHp2ga
 LAkexZLlX6LRezyVJc3gsV2QseSqERJBQIBAdilCezuvzA4ziMEwIcx4Us/QrL+ei2
 mCijxscxdW+/PlsnXjAhCGCVywgOWcalh8kRhXmH8cZwHvoLpIfFuPrgxMMd375GZP
 HlW9/Eb6piyaS/KUVjcOdITPqXOAhq6IkJqeEJsgnYyvhHcunXmLdN0HnaSuRz8dst
 OAkm7LW+fqVn+4vE0xGmRV8BQ5lrg0TDVfHBy+nx3tcYy1X7CSIApqMQiQMi8lzW+R
 dkHgWv/eI9Szw==
Message-ID: <672e9f35-3795-7176-e081-d49108fd9f7f@collabora.com>
Date: Wed, 16 Aug 2023 15:46:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] configs: at91: sam9x60_curiosity: Sync both defconfig
 variants
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-2-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230809141622.231247-2-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Alexander,

On 8/9/23 17:16, Alexander Dahl wrote:
> The board has two SD card slots and we have two defconfigs for booting
> from either the first (micro SD) named 'sam9x60_curiosity_mmc_defconfig'
> or the second (full size SD) named 'sam9x60_curiosity_mmc1_defconfig'.
> For comparable Microchip boards (sama5d27-som1-ek, sama5d29-curiosity,
> sama7g5ek) with two card slots the defconfigs only differ in BOOTARGS,
> BOOTCOMMAND, and ENV_FAT_DEVICE_AND_PART and the same should be the case
> for sam9x60_curiosity.

To shed some light on this: the defconfigs for different at91 boards 
should differ only in terms of *where the env is stored*, but all the 
drivers should be available in all defconfigs.
The `where it boots from` sometimes is not related to the name of the 
defconfig, because e.g. we have board_qspiflash_defconfigs, which store 
the env in the qspi flash, but do not boot Linux from it, main reason is 
that the QSPI flash is very small (8 Mbytes e.g.)
Most boards have a simple boot example from the same media as where the 
env is stored, but it's not always the case as seen above.

> 
> Here the 'mmc1' config has more options enabled to support the raw NAND
> flash populated on the board, so the 'mmc' config (for mmc0) was adapted
> by enabling additional options, instead of removing options from mmc1.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   configs/sam9x60_curiosity_mmc_defconfig | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
> index 10937d67d7..269f015989 100644
> --- a/configs/sam9x60_curiosity_mmc_defconfig
> +++ b/configs/sam9x60_curiosity_mmc_defconfig
> @@ -23,7 +23,7 @@ CONFIG_FIT=y
>   CONFIG_SD_BOOT=y
>   CONFIG_BOOTDELAY=3
>   CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="mem=128M console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait"
> +CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait"

Have you checked the Linux DT if the memory is 128M hence the `mem=128M` 
is redundant ?

>   CONFIG_USE_BOOTCOMMAND=y
>   CONFIG_BOOTCOMMAND="fatload mmc 0:1 0x21000000 at91-sam9x60_curiosity.dtb; fatload mmc 0:1 0x22000000 zImage; bootz 0x22000000 - 0x21000000"
>   CONFIG_SYS_CONSOLE_IS_IN_ENV=y
> @@ -38,6 +38,8 @@ CONFIG_CMD_DM=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_NAND=y
> +CONFIG_CMD_NAND_TRIMFFS=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_DHCP=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
> @@ -50,6 +52,8 @@ CONFIG_OF_CONTROL=y
>   CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_REGMAP=y
> +CONFIG_SYSCON=y
>   CONFIG_CLK=y
>   CONFIG_CLK_CCF=y
>   CONFIG_CLK_AT91=y
> @@ -60,10 +64,17 @@ CONFIG_CPU=y
>   CONFIG_AT91_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_AT91=y
> +CONFIG_ATMEL_EBI=y
> +CONFIG_MFD_ATMEL_SMC=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_MICROCHIP_FLEXCOM=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ATMEL=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_DM_NAND_ATMEL=y
> +CONFIG_SYS_NAND_ONFI_DETECTION=y
>   CONFIG_PHY_MICREL=y
>   CONFIG_MACB=y
>   CONFIG_PINCTRL=y
> @@ -71,6 +82,8 @@ CONFIG_PINCTRL_AT91=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_ATMEL_USART=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_AT91=y
>   CONFIG_TIMER=y
>   CONFIG_MCHP_PIT64B_TIMER=y
>   CONFIG_W1=y

