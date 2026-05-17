Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA6FCD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 21:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A4E8465D;
	Sun, 17 May 2026 23:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nJhECGKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A308466F; Sun, 17 May 2026 23:06:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF94845E3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 23:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5134=DP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779051979;
 bh=U2aK0M2pcm9F01Rr9xeiz+k2LQzZAE1SuwnaDGtm8Wc=;
 b=nJhECGKCYg2FhjYeMc2EmL2/rHBO+2Swm1aTb07FSKL+jBtis8bay1kG4w4LZRpYD7qRBigFh
 zVkMfXIu580i0zoDF2Z15lrDhR+LCElTMWg9cpLB2Z2FehnZTDG+5eoyF5Ge5GWJe30xBuXXg8J
 rv40ENzBl6fjXqCMQXSWsN53+T2QDx4GczwqIpdVC5CAUDosiUZb5SZnAYZnewGFl7jAG4F5cQk
 0l3eI6rgVzUUpLcd+VrbtC6koMRxthmNzbvg/RFngv2IP8uSKeZib0dwE1qgUVxRZJRTGvQnVKK
 AuECrUvOKex5G7coGuPkopCVMuV6PwgTeMKweLQ2G2cQ==
X-Forward-Email-ID: 6a0a2dc366ad49e327c5d4d0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5cc57912-603b-455a-97c6-0bbfd6357e9f@kwiboo.se>
Date: Sun, 17 May 2026 23:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 17/18] rockchip: rk356x-generic: Initialize SDRAM at
 TPL stage
To: Pavel Golikov <paullo612@ya.ru>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-17-a24e16302a13@ya.ru>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260517-rk3568-raminit-v1-17-a24e16302a13@ya.ru>
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

Hi Pavel,

On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> Only LPDDR4 initialization is confirmed to be working for now.
> 
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
> ---
>  arch/arm/mach-rockchip/Kconfig        | 28 +++++++++++++++++++++++++++-
>  arch/arm/mach-rockchip/rk3568/Kconfig | 16 ++++++++++++++++
>  common/spl/Kconfig.tpl                |  1 +
>  configs/generic-rk3568_defconfig      |  1 +
>  4 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 108713488af..9a6a580025e 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -413,11 +413,15 @@ config ROCKCHIP_RK3528
>  config ROCKCHIP_RK3568
>  	bool "Support Rockchip RK3568"
>  	select ARM64
> +	select SUPPORT_TPL
> +	select TPL_HAVE_INIT_STACK if TPL
> +	select TPL_ROCKCHIP_BACK_TO_BROM if TPL
>  	select SUPPORT_SPL
>  	select SPL
>  	select CLK
>  	select PINCTRL
>  	select RAM
> +	select ROCKCHIP_SDRAM_COMMON
>  	select REGMAP
>  	select SYSCON
>  	select BOARD_LATE_INIT
> @@ -433,10 +437,32 @@ config ROCKCHIP_RK3568
>  	imply RNG_ROCKCHIP
>  	imply ROCKCHIP_COMMON_BOARD
>  	imply ROCKCHIP_COMMON_STACK_ADDR
> -	imply ROCKCHIP_EXTERNAL_TPL

Not until this has been proven to work for all current supported dram
types and configurations, please select TPL in board specific defconfigs.

>  	imply ROCKCHIP_OTP
> +	imply ROCKCHIP_SERIAL if !ROCKCHIP_EXTERNAL_TPL
>  	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>  	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> +	imply TPL if !ROCKCHIP_EXTERNAL_TPL
> +	imply TPL_CLK
> +	imply TPL_DM
> +	imply TPL_LIBCOMMON_SUPPORT
> +	imply TPL_LIBGENERIC_SUPPORT
> +	imply TPL_OF_CONTROL
> +	imply TPL_OF_PLATDATA
> +	imply TPL_RAM
> +	imply TPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_SERIAL
> +	imply TPL_SYSCON
> +	imply SPL_CLK
> +	imply SPL_DM
> +	imply SPL_DRIVERS_MISC
> +	imply SPL_LIBCOMMON_SUPPORT
> +	imply SPL_LIBGENERIC_SUPPORT
> +	imply SPL_OF_CONTROL
> +	imply SPL_RAM
> +	imply SPL_REGMAP
> +	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply SPL_SERIAL
> +	imply SPL_SYSCON

These should all be sorted alphanumerically, also this is adding SPL
related implys, probably something that should be in a separate patch?

>  	help
>  	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
>  	  including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 2730220a18e..893185291d8 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -61,6 +61,10 @@ config TARGET_ORANGEPI_3B_RK3566
>  
>  endchoice
>  
> +config SOC_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +	select HAS_CUSTOM_SYS_INIT_SP_ADDR
> +
>  config ROCKCHIP_BOOT_MODE_REG
>  	default 0xfdc20200
>  
> @@ -70,6 +74,18 @@ config ROCKCHIP_STIMER_BASE
>  config SYS_SOC
>  	default "rk3568"
>  
> +config TPL_LDSCRIPT
> +	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
> +
> +config TPL_STACK
> +	default 0xfdcd8000
> +
> +config TPL_SYS_MALLOC_F_LEN
> +	default 0x2000
> +
> +config TPL_TEXT_BASE
> +	default 0xfdcc1000
> +
>  source "board/rockchip/evb_rk3568/Kconfig"
>  source "board/anbernic/rgxx3_rk3566/Kconfig"
>  source "board/hardkernel/odroid_m1/Kconfig"
> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> index a535b61ecd3..e64316b8eb3 100644
> --- a/common/spl/Kconfig.tpl
> +++ b/common/spl/Kconfig.tpl
> @@ -127,6 +127,7 @@ config TPL_TEXT_BASE
>  config TPL_MAX_SIZE
>  	hex "Maximum size (in bytes) for the TPL stage"
>  	default 0x2e000 if ROCKCHIP_RK3399
> +	default 0xe800 if ROCKCHIP_RK3568
>  	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
>  	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
>  	default 0x2800 if ROCKCHIP_PX30
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index a33c3af9255..4510fa94775 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -81,3 +81,4 @@ CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_ERRNO_STR=y
> +CONFIG_RAM_ROCKCHIP_LPDDR4=y

This generic-rk3568 target is explicitly created to be generic with
dynamic DRAM type lookup. So we cannot add explicit DRAM type support
for this target.

Regards,
Jonas
