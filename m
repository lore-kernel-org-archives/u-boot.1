Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ABFC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 20:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BCE80843;
	Mon, 17 Feb 2025 21:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="htRU413i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6DFC80F0B; Mon, 17 Feb 2025 21:28:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44327807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 21:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739824101;
 bh=CMMNgy7iqj6BV5ukzpBvLitN1QxLGlVSIgNWl2pSzfM=;
 b=htRU413i3E0rZvyIcaATgViPjudW+zqevNrekENyb8drH3xWJ01dXY3HjIi2XCTXVOxMtF9sA
 HNQc/2k+A+RRApb4S9xM74hmUnSNanDZfhpkW+sIiZCOyB0MOHjc8vW1CrmnCj1PClc23kqA6AI
 XLYpzAwYrMiSM5Ne73tm7S+x4w8v7txoWe/Q3ebX1ETELXJIcdzyvaEBWjMxKN5pHtp2RnrQqkL
 66CYxT/rN7c2lu3ZtTINEuhQS869fnmpPEmLYAA1GN1fW8/+VdZwHrtXAoJf2S/CqhnHUN7dSzf
 TAgpHdEnHhEnEk8ySDaRPZ+WAfUqnjdBnEt3nAxR91lg==
X-Forward-Email-ID: 67b39bdd179e723bb8e571df
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f244a0ff-32ac-451a-b088-93f142150630@kwiboo.se>
Date: Mon, 17 Feb 2025 21:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/35] tpl: Rename TPL_NEEDS_SEPARATE_STACK to
 TPL_HAVE_INIT_STACK
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Chen-Yu Tsai <wens@csie.org>, 
 Dragan Simic <dsimic@manjaro.org>, Gary Bisson <bisson.gary@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-2-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-2-sjg@chromium.org>
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

On 2025-02-09 22:14, Simon Glass wrote:
> The most common word for features that make a platform work is to use
> 'HAVE_xxx'. Rename this option to match.

We already have HAS_CUSTOM_SYS_INIT_SP_ADDR related to the init stack
pointer address, maybe the new symbol should be named something similar
to that? e.g. HAS_xPL_INIT_SP_ADDR

> 
> Update the help to use the word 'phase' rather than 'stage', since
> that is the current terminology. Also clarify that, absent this setting,
> the stack pointer generally comes from the value used by U-Boot proper,
> rather than SPL.

The last statement is not fully correct, see below.

> 
> Move the option just above TPL_STACK which depends on it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Add new patch to rename TPL_NEEDS_SEPARATE_STACK
> 
>  arch/arm/lib/crt0.S            |  2 +-
>  arch/arm/lib/crt0_64.S         |  2 +-
>  arch/arm/mach-rockchip/Kconfig | 14 +++++++-------
>  common/spl/Kconfig.tpl         | 19 ++++++++++---------
>  configs/mk808_defconfig        |  2 +-
>  5 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
> index a691d844847..a7e6f50d39a 100644
> --- a/arch/arm/lib/crt0.S
> +++ b/arch/arm/lib/crt0.S
> @@ -100,7 +100,7 @@ ENTRY(_main)
>   * Set up initial C runtime environment and call board_init_f(0).
>   */
>  
> -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
> +#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
>  	ldr	r0, =(CONFIG_TPL_STACK)
>  #elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
>  	ldr	r0, =(CONFIG_SPL_STACK)

Here we can see that SPL_STACK is used as the first fallback for
XPL_BUILD's.

> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index 32401f544a7..62a0abe1fed 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -69,7 +69,7 @@ ENTRY(_main)
>  /*
>   * Set up initial C runtime environment and call board_init_f(0).
>   */
> -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
> +#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
>  	ldr	x0, =(CONFIG_TPL_STACK)
>  #elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
>  	ldr	x0, =(CONFIG_SPL_STACK)
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 4d3157b2edd..4c515593718 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -9,7 +9,7 @@ config ROCKCHIP_PX30
>  	select SPL
>  	select TPL
>  	select TPL_TINY_FRAMEWORK if TPL
> -	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	select TPL_HAVE_INIT_STACK if TPL
>  	imply SPL_SEPARATE_BSS
>  	select SPL_SERIAL
>  	select TPL_SERIAL
> @@ -106,7 +106,7 @@ config ROCKCHIP_RK322X
>  	select TPL
>  	select TPL_DM
>  	select TPL_OF_LIBFDT
> -	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	select TPL_HAVE_INIT_STACK if TPL
>  	select SPL_DRIVERS_MISC
>  	imply ROCKCHIP_COMMON_BOARD
>  	imply SPL_SERIAL
> @@ -139,7 +139,7 @@ config ROCKCHIP_RK3288
>  	imply TPL_DRIVERS_MISC
>  	imply TPL_LIBCOMMON_SUPPORT
>  	imply TPL_LIBGENERIC_SUPPORT
> -	imply TPL_NEEDS_SEPARATE_STACK
> +	imply TPL_HAVE_INIT_STACK
>  	imply TPL_OF_CONTROL
>  	imply TPL_OF_PLATDATA
>  	imply TPL_RAM
> @@ -197,7 +197,7 @@ config ROCKCHIP_RK3328
>  	select SPL
>  	select SUPPORT_TPL
>  	select TPL
> -	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	select TPL_HAVE_INIT_STACK if TPL
>  	imply ARMV8_CRYPTO
>  	imply ARMV8_SET_SMPEN
>  	imply MISC
> @@ -225,7 +225,7 @@ config ROCKCHIP_RK3368
>  	select ARM64
>  	select SUPPORT_SPL
>  	select SUPPORT_TPL
> -	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	select TPL_HAVE_INIT_STACK if TPL
>  	imply ROCKCHIP_COMMON_BOARD
>  	imply SPL_ROCKCHIP_COMMON_BOARD
>  	imply SPL_SEPARATE_BSS
> @@ -257,7 +257,7 @@ config ROCKCHIP_RK3399
>  	select SPL_RAM if SPL
>  	select SPL_REGMAP if SPL
>  	select SPL_SYSCON if SPL
> -	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	select TPL_HAVE_INIT_STACK if TPL
>  	select SPL_SEPARATE_BSS
>  	select CLK
>  	select FIT
> @@ -392,7 +392,7 @@ config ROCKCHIP_RV1126
>  	select SKIP_LOWLEVEL_INIT_ONLY
>  	select TPL
>  	select SUPPORT_TPL
> -	select TPL_NEEDS_SEPARATE_STACK
> +	select TPL_HAVE_INIT_STACK
>  	select TPL_ROCKCHIP_BACK_TO_BROM
>  	select SPL
>  	select SUPPORT_SPL
> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> index 22ca7016453..980d6da202a 100644
> --- a/common/spl/Kconfig.tpl
> +++ b/common/spl/Kconfig.tpl
> @@ -106,12 +106,6 @@ config TPL_LDSCRIPT
>  	  May be left empty to trigger the Makefile infrastructure to
>  	  fall back to the linker-script used for the SPL stage.
>  
> -config TPL_NEEDS_SEPARATE_STACK
> -	bool "TPL needs a separate initial stack-pointer"
> -	help
> -	  Enable, if the TPL stage should not inherit its initial
> -	  stack-pointer from the settings for the SPL stage.
> -
>  config TPL_POWER
>  	bool "Support power drivers"
>  	help
> @@ -140,11 +134,18 @@ config TPL_MAX_SIZE
>  	help
>  	  The maximum size (in bytes) of the TPL stage.
>  
> +config TPL_HAVE_INIT_STACK
> +	bool "TPL requires a initial, fixed, stack-pointer location"
> +	help
> +	  Enable if the TPL phase should not use inherit its initial

"should not use inherit its initial" does not sound correct.

> +	  stack-pointer from the settings for U-Boot proper, but should set

Here you are changing from SPL to proper, however the SPL address will
be used as the fallback (if it is defined) and then SYS_INIT_SP_ADDR.

> +	  its own value.
> +
>  config TPL_STACK
> -	hex "Address of the initial stack-pointer for the TPL stage"
> -	depends on TPL_NEEDS_SEPARATE_STACK
> +	hex "Address of the initial stack-pointer for the TPL phase"
> +	depends on TPL_HAVE_INIT_STACK
>  	help
> -	  The address of the initial stack-pointer for the TPL stage.
> +	  The address of the initial stack-pointer for the TPL phase

Did you remove the . (period) on purpose?

Regards,
Jonas

>  	  Usually this will be the (aligned) top-of-stack.
>  
>  config TPL_READ_ONLY
> diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
> index e47d0b594f3..a1f089a23ea 100644
> --- a/configs/mk808_defconfig
> +++ b/configs/mk808_defconfig
> @@ -48,7 +48,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
>  CONFIG_SPL_SEPARATE_BSS=y
>  CONFIG_SPL_FS_EXT4=y
>  CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
> -CONFIG_TPL_NEEDS_SEPARATE_STACK=y
> +CONFIG_TPL_HAVE_INIT_STACK=y
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set

