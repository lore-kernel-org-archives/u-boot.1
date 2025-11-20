Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDDECF8578
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C366F840E4;
	Thu, 20 Nov 2025 10:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="du0lC+D3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B357D840E6; Thu, 20 Nov 2025 10:48:08 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C0884057
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 603AE10B3A0; Thu, 20 Nov 2025 10:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763632085;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=X8LS4zusXGg/bFTf6pLmU8YzlNm+TKbb3RDvddHZYIQ=;
 b=du0lC+D3DVJJiVanQR88Z4SlXV9JA54bXtG5LH6toDLYokvdntBTNX3FJXKf+C75cMCt1n
 oCNz5ELTYqKqv6j+W7ZhAaC0Tbwzk+WDMz24sgU1hoNpKHqDFJJn7wxx3Kjlo4rtunkih3
 HGXA5g5xLEFushCT0On5Vgycyj5ZJe6yfGoLJBk5fDm+VbxI0OMU1sMrJh2iLKTCg/Npw8
 ZaznY8N/nsQfNFH/jEi/BJnPzzuuQTZ9fSbcLpM3y5n3dy5esbdSz44P7P/qZVy+8EOZmt
 PB3mZXetmmY6v/IMjeRPaObuiFMxGS0rz6QhH0laafM+WqobrB2UgDlvGh/Tyw==
Message-ID: <6c00bdcd-a662-a0ba-6895-dff858325470@nabladev.com>
Date: Thu, 20 Nov 2025 10:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] led: remove support for red LED in legacy API
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Freihofer, Adrian" <adrian.freihofer@siemens.com>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
 <20251119-corvus-led-red-green-v1-4-ce86b8d59dfc@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119-corvus-led-red-green-v1-4-ce86b8d59dfc@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

On 19.11.25 18:01, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> To the exception of red_led_on in the arm-specific assembly code, all
> code interacting with the red status LED was guarded by the
> CONFIG_LED_STATUS_RED symbol, which is enabled in none of the upstream
> defconfigs.
> 
> Since the last board which overrode the weak red_led_on function got
> migrated to the new LED mechanism, there's also no user of the
> arm-specific assembly code anymore, therefore it can be removed along
> the other unreachable code sections.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   arch/arm/lib/crt0.S     |  3 ---
>   cmd/legacy_led.c        |  6 ------
>   common/board_f.c        | 14 --------------
>   doc/api/led.rst         | 16 ----------------
>   drivers/led/Kconfig     | 14 --------------
>   drivers/misc/gpio_led.c | 18 ------------------
>   include/status_led.h    | 12 ------------
>   7 files changed, 83 deletions(-)
> 
> diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
> index 9acaf2cddef..d10c129705d 100644
> --- a/arch/arm/lib/crt0.S
> +++ b/arch/arm/lib/crt0.S
> @@ -183,9 +183,6 @@ here:
>   	movne	r9, r0
>   # endif
>   
> -#if ! defined(CONFIG_XPL_BUILD)
> -	bl red_led_on
> -#endif
>   	/* call board_init_r(gd_t *id, ulong dest_addr) */
>   	mov     r0, r9                  /* gd_t */
>   	ldr	r1, [r9, #GD_RELOCADDR]	/* dest_addr */
> diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
> index 2c6d606f48b..4e0d09522ad 100644
> --- a/cmd/legacy_led.c
> +++ b/cmd/legacy_led.c
> @@ -44,9 +44,6 @@ static const led_tbl_t led_commands[] = {
>   #ifdef CONFIG_LED_STATUS5
>   	{ "5", CONFIG_LED_STATUS_BIT5, NULL, NULL, NULL },
>   #endif
> -#endif
> -#ifdef CONFIG_LED_STATUS_RED
> -	{ "red", CONFIG_LED_STATUS_RED, red_led_off, red_led_on, NULL },
>   #endif
>   	{ NULL, 0, NULL, NULL, NULL }
>   };
> @@ -158,9 +155,6 @@ U_BOOT_CMD(
>   #ifdef CONFIG_LED_STATUS5
>   	"5|"
>   #endif
> -#endif
> -#ifdef CONFIG_LED_STATUS_RED
> -	"red|"
>   #endif
>   	"all] [on|off|toggle|blink] [blink-freq in ms]",
>   	"[led_name] [on|off|toggle|blink] sets or clears led(s)"
> diff --git a/common/board_f.c b/common/board_f.c
> index 74571cb6d91..df2b0dc899b 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -54,20 +54,6 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -/*
> - * TODO(sjg@chromium.org): IMO this code should be
> - * refactored to a single function, something like:
> - *
> - * void led_set_state(enum led_colour_t colour, int on);
> - */
> -/************************************************************************
> - * Coloured LED functionality
> - ************************************************************************
> - * May be supplied by boards if desired
> - */
> -__weak void red_led_on(void) {}
> -__weak void red_led_off(void) {}
> -
>   /*
>    * Why is gd allocated a register? Prior to reloc it might be better to
>    * just pass it around to each function in this file?
> diff --git a/doc/api/led.rst b/doc/api/led.rst
> index e9705eb69a5..1a61f2ad916 100644
> --- a/doc/api/led.rst
> +++ b/doc/api/led.rst
> @@ -57,9 +57,6 @@ Some other LED macros
>   CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
>   This must be a valid LED number (0-5).
>   
> -CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. This must be
> -a valid LED number (0-5).
> -
>   General LED functions
>   ~~~~~~~~~~~~~~~~~~~~~
>   The following functions should be defined:
> @@ -71,19 +68,6 @@ __led_set is called to change the state of the LED.
>   
>   __led_toggle is called to toggle the current state of the LED.
>   
> -Colour LED
> -----------
> -
> -Colour LED's are at present only used by ARM.
> -
> -The functions names explain their purpose.
> -
> -- red_LED_on
> -- red_LED_off
> -
> -These are weakly defined in arch/arm/lib/board.c to noops. Where applicable, define
> -these functions in the board specific source.
> -
>   TBD : Describe older board dependent macros similar to what is done for
>   
>   TBD : Describe general support via asm/status_led.h
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 6b043f9a522..cc715ceb286 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -400,20 +400,6 @@ config LED_STATUS_BOOT
>   
>   endif # LED_STATUS_BOOT_ENABLE
>   
> -config LED_STATUS_RED_ENABLE
> -	bool "Enable red LED"
> -	help
> -	  Enable red status LED.
> -
> -if LED_STATUS_RED_ENABLE
> -
> -config LED_STATUS_RED
> -	int "Red LED identification"
> -	help
> -	  Valid enabled LED device number.
> -
> -endif # LED_STATUS_RED_ENABLE
> -
>   config LED_STATUS_CMD
>   	bool "Enable status LED commands"
>   
> diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
> index a1432a53440..1e2f83cca93 100644
> --- a/drivers/misc/gpio_led.c
> +++ b/drivers/misc/gpio_led.c
> @@ -50,21 +50,3 @@ void __led_toggle(led_id_t mask)
>   {
>   	gpio_set_value(mask, !gpio_get_value(mask));
>   }
> -
> -#ifdef CONFIG_GPIO_LED_STUBS
> -
> -/* 'generic' override of colored LED stubs, to use GPIO functions instead */
> -
> -#ifdef CONFIG_LED_STATUS_RED
> -void red_led_on(void)
> -{
> -	__led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_ON);
> -}
> -
> -void red_led_off(void)
> -{
> -	__led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_OFF);
> -}
> -#endif
> -
> -#endif /* CONFIG_GPIO_LED_STUBS */
> diff --git a/include/status_led.h b/include/status_led.h
> index 8e8b19f8c19..c3ff399b1ae 100644
> --- a/include/status_led.h
> +++ b/include/status_led.h
> @@ -65,16 +65,4 @@ static inline void status_led_set(int led, int state) { }
>   static inline void status_led_boot_blink(void) { }
>   
>   #endif	/* CONFIG_LED_STATUS	*/
> -
> -/*
> - * Coloured LEDs API
> - */
> -#ifndef	__ASSEMBLY__
> -void red_led_on(void);
> -void red_led_off(void);
> -#else
> -	.extern red_led_on
> -	.extern red_led_off
> -#endif
> -
>   #endif	/* _STATUS_LED_H_	*/
> 


Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
