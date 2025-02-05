Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354D7C02197
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54F5801BE;
	Wed,  5 Feb 2025 17:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="t5CudTHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671C78033D; Wed,  5 Feb 2025 17:06:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A9180104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738771568;
 bh=YtaK6mtF/xsVFVpnDqSNPHkFu3Z7rW16WrLJAuKJ6u0=;
 b=t5CudTHUqtktfQDY6j7ALaskwLsbDpepjz1oQWt+uyfjAfgx3rsFjuFfwEQTHtXz4067+A46F
 hYxnMtyATX9jgYlIbWZ5tcMtATWsry4fkXYbbnoyP0lBrkeTh9fSmpJusOEY0vmp6odgiDwGPDt
 SmnGDFJSXNiVY3oymYPX7XuqhSUj4KyXsu9udo2OgyuTdHxOnNXI05aOedkzyXeO3zaUPJq/Ob6
 Qoi8uXUIgNvZQVgjHxz9Jg8iMM7pRoFf7IvZfGkh/fo4bCK8e7hAKVfh9//SafprZomKWAhK/G8
 49W+y3apM8z50rWVqzQpZ1ISJKpz0a8kVZIfsextcuZA==
X-Forward-Email-ID: 67a38c6cfb44099d0e594ba2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <440fa821-6eb7-4b5f-a513-97c96145abdd@kwiboo.se>
Date: Wed, 5 Feb 2025 17:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/29] rockchip: Provide a VPL phase on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Chen-Yu Tsai <wens@csie.org>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-22-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-22-sjg@chromium.org>
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

Hi Simon,

On 2025-02-05 02:55, Simon Glass wrote:
> Add support for this new phase, which runs after TPL. It determines the
> state of the machine, then selects which SPL image to use. SDRAM init is
> then done in SPL, so that it is updatable.

I am still unsure how this makes it more updatable, what happen when
DRAM init fails and board freezes? Are we relying on e.g. a watchdog to
properly reset a frozen board and try next image?

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/include/asm/spl.h               |   1 +
>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
>  arch/arm/mach-rockchip/Makefile          |   6 +-
>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
>  arch/arm/mach-rockchip/spl-boot-order.c  |   3 +-
>  arch/arm/mach-rockchip/spl.c             |   3 +
>  arch/arm/mach-rockchip/tpl.c             |   2 +-
>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>  common/spl/Kconfig                       |   1 +
>  10 files changed, 203 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>  create mode 100644 arch/arm/mach-rockchip/vpl.c
> 

[snip]

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 269c219a6f8..7e6e9411e79 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig

[snip]

> @@ -455,7 +459,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>  
>  config TPL_ROCKCHIP_BACK_TO_BROM
>  	bool "TPL returns to bootrom"
> -	default y
> +	default y if !VPL
>  	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>  	select TPL_BOOTROM_SUPPORT
>  	depends on TPL
> @@ -496,6 +500,16 @@ config ROCKCHIP_EXTERNAL_TPL
>  	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
>  	  include the external TPL in the image built by binman.
>  
> +config VPL_ROCKCHIP_COMMON_BOARD
> +	bool "Rockchip VPL common board file"
> +	depends on VPL
> +	default y
> +	help
> +	  Rockchip SoCs have similar boot process, prefer to use TPL to start
> +	  VPL, then ATF for DRAM init and back to bootrom, and SPL as Trust
> +	  ATF/U-Boot loader. VPL common board is a basic VPL board init which
> +	  can be shared for most SoCs to avoid copy-paste for different SoCs.

This help text is not correct, with VPL=y back to bootrom is not used
and TF-A is never used for DRAM init, only TPL/SPL or Rockchip TPL.

> +
>  config ROCKCHIP_BOOT_MODE_REG
>  	hex "Rockchip boot mode flag register address"
>  	help

[snip]

> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 3dce9b30898..d580d4fc84c 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -99,7 +99,8 @@ __weak const char *board_spl_was_booted_from(void)
>  void board_boot_order(u32 *spl_boot_list)
>  {
>  	/* In case of no fdt (or only plat), use spl_boot_device() */
> -	if (!CONFIG_IS_ENABLED(OF_CONTROL) || CONFIG_IS_ENABLED(OF_PLATDATA)) {
> +	if (IS_ENABLED(CONFIG_VPL) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
> +	    CONFIG_IS_ENABLED(OF_PLATDATA)) {
>  		spl_boot_list[0] = spl_boot_device();
>  		return;
>  	}

Another option could be to just skip spl-boot-order.o for VPL, the
default implementation should work as-is, not sure what is best.

Regards,
Jonas

> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index f4d29bbdd17..305373a161c 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -61,6 +61,9 @@ u32 spl_boot_device(void)
>  {
>  	u32 boot_device = BOOT_DEVICE_MMC1;
>  
> +	if (IS_ENABLED(CONFIG_VPL))
> +		return BOOT_DEVICE_VBE;
> +
>  #if defined(CONFIG_TARGET_CHROMEBOOK_JERRY) || \
>  		defined(CONFIG_TARGET_CHROMEBIT_MICKEY) || \
>  		defined(CONFIG_TARGET_CHROMEBOOK_MINNIE) || \
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index 6b880f19f84..cc794a7dca2 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -84,5 +84,5 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
>  
>  u32 spl_boot_device(void)
>  {
> -	return BOOT_DEVICE_BOOTROM;
> +	return IS_ENABLED(CONFIG_VPL) ? BOOT_DEVICE_VBE : BOOT_DEVICE_BOOTROM;
>  }

[snip]
