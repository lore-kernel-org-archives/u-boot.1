Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2D5C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 12:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85188677D;
	Wed, 16 Aug 2023 14:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="b1Kaey9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C68868BE; Wed, 16 Aug 2023 14:48:34 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10F08688D
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [172.20.10.2] (unknown [109.166.130.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id B5D9B6600359;
 Wed, 16 Aug 2023 13:48:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692190110;
 bh=qtLZPmzAsJVDR52tEEBBmCCb/y8CQqxBc/gzS/t1Www=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b1Kaey9Hn5PxAftIHYjs8s573I9wRQcdpeMLVrmANLTKBr8NlOJBWHKSnIib1iBga
 gAJz5bsHEUbIBupLEDChPRg/01Rd+kWlPtPftomyW2JInLsvUz3udwAkRsMo6EPyB8
 ZemQgnADsikSUj0BfVjtiyOeCvoz7TBeOIaiLmZkh0S0W0T3YqFrcioLy8FO29XQ+6
 b9dPxNEXCVnj4F5vLTMMjkSCpGTXZ99omT0dy/WWKmUtFTBpmmFKSRHgrUTG85x24T
 065dwtod1WxBVOREwDIFgNL0IPCAHzdsAjb4YtRlznSISIpzbSqZVAewPDpNy4m09P
 DOO10veSeo2/w==
Message-ID: <b3185256-aff2-eb6e-eae3-7ce9fe2ddd87@collabora.com>
Date: Wed, 16 Aug 2023 15:48:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] configs: at91: sam9x60: Switch to new reset driver
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-3-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230809141622.231247-3-ada@thorsis.com>
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
> Since commit 61040097a9d1 ("reset: at91: Add reset driver for basic
> assert/deassert operations") the compatible "microchip,sam9x60-rstc" for
> the sam9x60 reset controller in sam9x60.dtsi is not handled by
> CONFIG_SYSRESET_AT91 anymore, but by CONFIG_RESET_AT91 now.  This
> resulted in the following error message, when trying to reset from
> U-Boot shell:
> 
>      U-Boot> reset
>      resetting ...
>      System reset not supported on this platform
>      ### ERROR ### Please RESET the board ###
> 
> Fixed with the switch to the new driver.  Tested on sam9x60-curiosity
> board.  Defconfigs for sam9x60ek adapted in the same way, but without
> testing.  These should be all sam9x60 boards affected in U-Boot here.

 From what I remember from the top of my head, it makes sense to use the 
new reset driver, however, you should not remove the old SYSRESET 
driver, because that driver handles different kind of resets on the SoC 
and PHYs. Can you double check that?

> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   configs/sam9x60_curiosity_mmc1_defconfig | 4 ++--
>   configs/sam9x60_curiosity_mmc_defconfig  | 4 ++--
>   configs/sam9x60ek_mmc_defconfig          | 4 ++--
>   configs/sam9x60ek_nandflash_defconfig    | 4 ++--
>   configs/sam9x60ek_qspiflash_defconfig    | 4 ++--
>   5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/configs/sam9x60_curiosity_mmc1_defconfig b/configs/sam9x60_curiosity_mmc1_defconfig
> index 21b2cc2edd..e8781b363b 100644
> --- a/configs/sam9x60_curiosity_mmc1_defconfig
> +++ b/configs/sam9x60_curiosity_mmc1_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
>   CONFIG_SYS_PROMPT="U-Boot> "
>   CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xfffff200
>   CONFIG_DEBUG_UART_CLOCK=200000000
>   CONFIG_DEBUG_UART_BOARD_INIT=y
> @@ -79,11 +80,10 @@ CONFIG_PHY_MICREL=y
>   CONFIG_MACB=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_AT91=y
> +CONFIG_RESET_AT91=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_ATMEL_USART=y
> -CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_AT91=y
>   CONFIG_TIMER=y
>   CONFIG_MCHP_PIT64B_TIMER=y
>   CONFIG_W1=y
> diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
> index 269f015989..0f57588d8b 100644
> --- a/configs/sam9x60_curiosity_mmc_defconfig
> +++ b/configs/sam9x60_curiosity_mmc_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
>   CONFIG_SYS_PROMPT="U-Boot> "
>   CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xfffff200
>   CONFIG_DEBUG_UART_CLOCK=200000000
>   CONFIG_DEBUG_UART_BOARD_INIT=y
> @@ -79,11 +80,10 @@ CONFIG_PHY_MICREL=y
>   CONFIG_MACB=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_AT91=y
> +CONFIG_RESET_AT91=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_ATMEL_USART=y
> -CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_AT91=y
>   CONFIG_TIMER=y
>   CONFIG_MCHP_PIT64B_TIMER=y
>   CONFIG_W1=y
> diff --git a/configs/sam9x60ek_mmc_defconfig b/configs/sam9x60ek_mmc_defconfig
> index 2a1399748c..446caceba0 100644
> --- a/configs/sam9x60ek_mmc_defconfig
> +++ b/configs/sam9x60ek_mmc_defconfig
> @@ -15,6 +15,7 @@ CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
>   CONFIG_SYS_PROMPT="U-Boot> "
>   CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xfffff200
>   CONFIG_DEBUG_UART_CLOCK=200000000
>   CONFIG_DEBUG_UART_BOARD_INIT=y
> @@ -87,14 +88,13 @@ CONFIG_PHY_MICREL=y
>   CONFIG_MACB=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_AT91=y
> +CONFIG_RESET_AT91=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_ATMEL_USART=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ATMEL_QSPI=y
> -CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_AT91=y
>   CONFIG_TIMER=y
>   CONFIG_ATMEL_PIT_TIMER=y
>   CONFIG_W1=y
> diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
> index c6c4686658..acaa16ee49 100644
> --- a/configs/sam9x60ek_nandflash_defconfig
> +++ b/configs/sam9x60ek_nandflash_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
>   CONFIG_SYS_PROMPT="U-Boot> "
>   CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xfffff200
>   CONFIG_DEBUG_UART_CLOCK=200000000
>   CONFIG_DEBUG_UART_BOARD_INIT=y
> @@ -89,14 +90,13 @@ CONFIG_PHY_MICREL=y
>   CONFIG_MACB=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_AT91=y
> +CONFIG_RESET_AT91=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_ATMEL_USART=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ATMEL_QSPI=y
> -CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_AT91=y
>   CONFIG_TIMER=y
>   CONFIG_ATMEL_PIT_TIMER=y
>   CONFIG_W1=y
> diff --git a/configs/sam9x60ek_qspiflash_defconfig b/configs/sam9x60ek_qspiflash_defconfig
> index ef2e2db8b8..6fb79214e5 100644
> --- a/configs/sam9x60ek_qspiflash_defconfig
> +++ b/configs/sam9x60ek_qspiflash_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
>   CONFIG_SYS_PROMPT="U-Boot> "
>   CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xfffff200
>   CONFIG_DEBUG_UART_CLOCK=200000000
>   CONFIG_DEBUG_UART_BOARD_INIT=y
> @@ -88,14 +89,13 @@ CONFIG_PHY_MICREL=y
>   CONFIG_MACB=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_AT91=y
> +CONFIG_RESET_AT91=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_ATMEL_USART=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ATMEL_QSPI=y
> -CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_AT91=y
>   CONFIG_TIMER=y
>   CONFIG_ATMEL_PIT_TIMER=y
>   CONFIG_W1=y

