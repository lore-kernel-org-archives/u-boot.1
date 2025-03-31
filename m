Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84CC36014
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 20:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8741F8129B;
	Mon, 31 Mar 2025 22:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rgjy5qqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E9C81703; Mon, 31 Mar 2025 22:31:38 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B3780584
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 22:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so4316232f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743453095; x=1744057895; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRwJZCMyy4E1l2DXxGW4CahrQWyewIbspZDMXktGJo4=;
 b=Rgjy5qqX4o9rKlyNRQUdXg4ewGJGFZaunMy6z8TWw53vCLowNFzVk+Sld8eNZxaqwZ
 DYzPf2O8TvXb4rhsALZVsDCi8NtVg1RnuIK9r3ic8ifs23U+XwBieiRtA0Y0u43UEhHV
 ZIDOeekkIfonJdZjUlUNJ27KaMqHIZSVjFUlRnosaA4CrsRnaGu2qnGULIexwHpBTNjr
 p8vGtXwmrdmDowmMYeSLvZk+6aOJbptTFDVbXZ+aeKeAjDvVIG+DRoncY8hOVFRlyrVH
 WJNqaYeM1P/r0CsBIb3IhDNi6KbJxXVvRNDRs2p0P/OrJyqfvdFFicDYGIbC1jw6db+m
 Q6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743453095; x=1744057895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YRwJZCMyy4E1l2DXxGW4CahrQWyewIbspZDMXktGJo4=;
 b=dK0bkO1x0hvYnvVXsxQB9Xizl6J0+CHJeO6CzqWzlsSzqNJ2I0hD16Dh/1zLzDnMfY
 21JWL8rsHNmOnZ0tOR3dnsyu95vmrlAX9pQc613zlvgZCwzpzLIxzM/r9NcTb1UO1aWN
 hDgMaIerBYJR1gnbV/f2KvoasP4+gVgMEbva6sUUfi+GHE6WofcdRuBrNMcmk7w33waW
 mYnZ7MFfBC+eXM93fkmTBAicK7VMkqQVbNJyzIhHKuL3X6Er1dg1on76a9gretrocDMp
 g/BhJhodcAuiDL4+/cfMqo21M8NBZRsA6HQn8C67xV91nfD9TWDD27nx3ThUluguj48T
 K6ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt9J5B/9p75QmanbasEXiaQXX3gajoiJtPSP7Ap76NHRox4ntSTSmQu9nYFPxU2r4k61fJB5A=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4/MgVMPw2EGrmo9uRru6vHWBYWzdew3KFVZI0jVyjsd9fAMZ8
 dwnbCuDrgDs1uhaK3OYfBhM2Bis90DGAKdezA1K7k7bEv++FiR08pNhq3CtDtv8=
X-Gm-Gg: ASbGncvTaR0Xc/LPHcfRXyRN1rkMuArJ2dFRuIbSnLqVSh9a46ANUBGbdT38X0XYrGN
 s+d3xOY6qhCzRAHfshePsLsM8eRJekentet1hpTkMR8vWRD/7OokB2izhAsR/VUBxHhPYCG6G/D
 AA3IQMkODTRyOujjMIfLVyLvBNRdAPUoHiAzfg5ZIE8U7m1Qai2/Yr+xW3vx1JPCeYPLdiaKYv6
 m4LkD99sfXZgeBqW0ZGzNMIlUrlpTDzZcwGFQLFsWo7IV7vKAC2MaCJHnOCq4nLcfzAEcNJbFyV
 OTd+3LpQJVQEQsBMY0Gn9nMkN5kQxAcX1e6oRgm20RQGxY2bJmOH
X-Google-Smtp-Source: AGHT+IEu5Uuq9u1HTG5t6rEuxDaA1Q7Z+0Hw8+nTLg8KqUpWBy1dUdfICDIgmSciewd8bggV+cDpFw==
X-Received: by 2002:a05:6000:40cf:b0:399:728f:4673 with SMTP id
 ffacd0b85a97d-39c120e16eemr7208546f8f.33.1743453095070; 
 Mon, 31 Mar 2025 13:31:35 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e31csm12349056f8f.68.2025.03.31.13.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 13:31:34 -0700 (PDT)
Message-ID: <8dfa72b1-b7ba-4173-9354-498b6e09bc45@linaro.org>
Date: Mon, 31 Mar 2025 23:31:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sama5d27: Fix the 'reset' command
To: Fabio Estevam <festevam@gmail.com>
Cc: nicolas.ferre@microchip.com, trini@konsulko.com, greg@embeddedgreg.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20250331180436.2305205-1-festevam@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250331180436.2305205-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 3/31/25 21:04, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 61040097a9d1 ("reset: at91: Add reset driver for basic
> assert/deassert operations") the "atmel,sama5d3-rstc" compatible for
> the sama5d2 reset controller in sama5d2.dtsi is not handled by
> CONFIG_SYSRESET_AT91 anymore, but by CONFIG_RESET_AT91 now.
> 
> This resulted in the following error, when trying to reset from the U-Boot
> shell on a sama5d27_wlsom1 board:
>     
>  => reset
>  resetting ...
>  System reset not supported on this platform
>  ### ERROR ### Please RESET the board ###
> 
> Fix it by enabling the CONFIG_RESET_AT91 driver in all sama5d27 defconfigs.
> 
> Tested on a sama5d27_wlsom1 board.
> 
> Based on the fix in commit e1ee52ca56fc ("configs: at91: sam9x60: Switch
> to new reset driver")
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Eugen/Tom,
> 
> This is material for 2025.04.

This is something that would happen for a few years now, why the rush ?
There is still time for a fixes PR though .
Can you add a fixes tag then ?

> 
>  configs/sama5d27_giantboard_defconfig          | 2 ++
>  configs/sama5d27_som1_ek_mmc1_defconfig        | 2 ++
>  configs/sama5d27_som1_ek_mmc_defconfig         | 2 ++
>  configs/sama5d27_som1_ek_qspiflash_defconfig   | 2 ++
>  configs/sama5d27_wlsom1_ek_mmc_defconfig       | 2 ++
>  configs/sama5d27_wlsom1_ek_qspiflash_defconfig | 2 ++
>  6 files changed, 12 insertions(+)
> 
> diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
> index ad1621a94dd7..0b7940f4fb43 100644
> --- a/configs/sama5d27_giantboard_defconfig
> +++ b/configs/sama5d27_giantboard_defconfig
> @@ -14,6 +14,7 @@ CONFIG_ENV_SIZE=0x4000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_giantboard"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_SERIAL=y
> @@ -84,6 +85,7 @@ CONFIG_DM_SPI_FLASH=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_RESET_AT91=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_ATMEL_USART=y
> diff --git a/configs/sama5d27_som1_ek_mmc1_defconfig b/configs/sama5d27_som1_ek_mmc1_defconfig
> index bb29121bb156..2e5a4acf27d8 100644
> --- a/configs/sama5d27_som1_ek_mmc1_defconfig
> +++ b/configs/sama5d27_som1_ek_mmc1_defconfig
> @@ -14,6 +14,7 @@ CONFIG_ENV_SIZE=0x4000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_som1_ek"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_SERIAL=y
> @@ -93,6 +94,7 @@ CONFIG_MACB=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_RESET_AT91=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_ATMEL_USART=y
> diff --git a/configs/sama5d27_som1_ek_mmc_defconfig b/configs/sama5d27_som1_ek_mmc_defconfig
> index 308aafc7dfe5..11a536d714c3 100644
> --- a/configs/sama5d27_som1_ek_mmc_defconfig
> +++ b/configs/sama5d27_som1_ek_mmc_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ENV_SIZE=0x4000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_som1_ek"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_SERIAL=y
> @@ -93,6 +94,7 @@ CONFIG_MACB=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_RESET_AT91=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_ATMEL_USART=y
> diff --git a/configs/sama5d27_som1_ek_qspiflash_defconfig b/configs/sama5d27_som1_ek_qspiflash_defconfig
> index ac14dd53838d..86cb5c287be1 100644
> --- a/configs/sama5d27_som1_ek_qspiflash_defconfig
> +++ b/configs/sama5d27_som1_ek_qspiflash_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ENV_SECT_SIZE=0x1000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_som1_ek"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_SERIAL=y
> @@ -92,6 +93,7 @@ CONFIG_MACB=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_RESET_AT91=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_ATMEL_USART=y
> diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
> index 6db27280f0fa..014f0093eee6 100644
> --- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
> @@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=0x4000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_wlsom1_ek"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_SERIAL=y
> @@ -99,6 +100,7 @@ CONFIG_MACB=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_RESET_AT91=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_ATMEL_USART=y
> diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> index 765565265165..efe23115f620 100644
> --- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>  CONFIG_SPL_DM_SPI=y
>  CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_wlsom1_ek"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_SERIAL=y
>  CONFIG_SPL_DRIVERS_MISC=y
> @@ -103,6 +104,7 @@ CONFIG_MACB=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_RESET_AT91=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_ATMEL_USART=y

