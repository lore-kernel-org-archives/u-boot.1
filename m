Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C5BCF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE048923F;
	Thu, 19 Sep 2024 16:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VR3KjFAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A6F8923F; Thu, 19 Sep 2024 16:14:09 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BE589256
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7db174f9050so206168a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755246; x=1727360046; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k1V+ilz5fQvxHgta0zYyIXZ1FurEj1j0XAL4ozEOyV8=;
 b=VR3KjFAdxn0EpjD6Z2eobA4vGEvdhetX/nJGqyg4dFuBRAzoVeL9IuIHvP7QmZRY21
 +b0Orqzx5ZF68TvTNX7ZfSHjOmV7mn9bXE+PAMYEUdPlsUCRM6klIKrJQZogCzHWmisW
 AJOwzhjWnvxVo2kRe00JwyJUxSLn8jtEi9+84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755246; x=1727360046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k1V+ilz5fQvxHgta0zYyIXZ1FurEj1j0XAL4ozEOyV8=;
 b=TYlXK/7dae4k37QesJo5fop2D9eO/7njW20/TAVNUuqvR6FF/hy+qtlgAoxvccUQav
 WFwCSN49i8gla6bKbstlXGNFSOCexypeYnnOs/2SQd5BElcI8M4kxLJlwwodWwLeKd/5
 AnyNRWd2Tl73TFenoP70kMLST5/SSS6pW0eV3GZHbAPPob+aRzmQKTuwY7ZX8VZzB2BN
 z+PbfKDdtISpYbOVaFwL4TdZMXdAJEE/lzY/nJ2QUanRrb3VaY22VsryWqVPgx7OC1lT
 leypDTyxDJ23gCy0EBES+TLjUDJNyn9vqVJSyMz+aZ5qwujCLLrvBG/t96N9THi0hrbd
 k5uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQokiNkHueGkkmC5kmfDSyv1cAo4qlMDrpDj05CX3gfM33Ps3zz6dSKmRRxHLCjoo9CZHLfuo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi1kecyCFiIlt3w/rLnGwHtKOq72vfssAMQuh1QcZC3mqozmto
 vxo907SJyu5NFgYh86ddRdIHmPrK+bIAbHJteYqKn058vIUbLN5pelGhThzBbhBhq3VKwoXwiX8
 wUVeEscD4SYKiqikqG0LYpPGpM7Tm0GuMTSaq
X-Google-Smtp-Source: AGHT+IHNKQ9IQzzhvM9wnNkiqCHWo8XFGN4QEcidxQOr4UZRGlnE69pUbkj3wNcsMsl7bE2luODZ7PmPacvmzTD3LU8=
X-Received: by 2002:a05:6a21:a4c4:b0:1d2:e793:9fa with SMTP id
 adf61e73a8af0-1d2e7930c98mr13981840637.47.1726755245732; Thu, 19 Sep 2024
 07:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-5-ansuelsmth@gmail.com>
In-Reply-To: <20240812103254.26972-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:53 +0200
Message-ID: <CAFLszTiKqo0mgkHmNYUP7Af3n2Kc94ZyJuZ8BXb1kEJW-jPuxg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] common: board_r: rework BOOT LED handling
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Dmitry Dunaev <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Christian,

On Mon, 12 Aug 2024 at 12:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Rework BOOT LED handling. There is currently one legacy implementation
> for BOOT LED from Status Led API.
>
> This work on ancient implementation wused by BOOTP by setting the LED

used

> to Blink on boot and to turn it OFF when the firmware was correctly
> received by network.
>
> Now that we new LED implementation have support for LED boot, rework
> this by also set the new BOOT LED to blink and also set it to ON before
> entering main loop to confirm successful boot.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  common/board_r.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index d4ba245ac69..57957b4e99b 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -39,6 +39,7 @@
>  #include <initcall.h>
>  #include <kgdb.h>
>  #include <irq_func.h>
> +#include <led.h>
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <miiphy.h>
> @@ -462,14 +463,30 @@ static int initr_malloc_bootparams(void)
>  #if defined(CONFIG_LED_STATUS)
>  static int initr_status_led(void)
>  {
> -#if defined(CONFIG_LED_STATUS_BOOT)
> -       status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
> -#else
>         status_led_init();
> +

Please can you rework this to avoid the #ifdefs in this C file? You
can make empty static inlines if needed... probably here you can move
this code to led.h and have the #ifdef there.

> +       return 0;
> +}
> +#endif
> +
> +static int initr_boot_led_blink(void)
> +{
> +#ifdef CONFIG_LED_STATUS_BOOT
> +       status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
> +#endif
> +#ifdef CONFIG_LED_BOOT_ENABLE
> +       led_boot_blink();
>  #endif

Same here. Note it is OK to use if (IS_ENABLED(...))  - just not the #ifdef

>         return 0;
>  }
> +
> +static int initr_boot_led_on(void)
> +{
> +#ifdef CONFIG_LED_BOOT_ENABLE
> +       led_boot_on();
>  #endif
> +       return 0;
> +}
>
>  #ifdef CONFIG_CMD_NET
>  static int initr_net(void)
> @@ -716,6 +733,7 @@ static init_fnc_t init_sequence_r[] = {
>  #if defined(CONFIG_LED_STATUS)
>         initr_status_led,
>  #endif
> +       initr_boot_led_blink,
>         /* PPC has a udelay(20) here dating from 2002. Why? */
>  #ifdef CONFIG_BOARD_LATE_INIT
>         board_late_init,
> @@ -738,6 +756,7 @@ static init_fnc_t init_sequence_r[] = {
>  #if defined(CFG_PRAM)
>         initr_mem,
>  #endif
> +       initr_boot_led_on,
>         run_main_loop,
>  };
>
> --
> 2.45.2
>

Regards,
Simon
