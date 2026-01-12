Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D5ED25050
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 08:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A0E83C14;
	Mon, 12 Jan 2026 09:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ben0jYEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA7183C6C; Mon, 12 Jan 2026 09:46:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B5C83B7E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 09:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so44894915e9.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768207590; x=1768812390; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6wMvulYXOsp7OWCUwvWyQUyG3fsKRIHB6ZTJYWOshw=;
 b=ben0jYEn/4Gxyv3Vx0ArcCX2HtzuGe7hSN6xEttXTQrOtMSsfreX2TTMLek0Cn8pnl
 5Qt7a9v8iKzu+sAxXdbkSkIFyMrl1UiD9Yy4abGnjbYKr6QS5oaQYXm3Bl8cWOw7id7Q
 17yDfbu9MgVHJQkFveIppvZmIFo2BX1y67WvR8wav9bEnpQNRA7QaXnRv66o43x9XUoj
 pUVi4rMm+4srOqB3P0y19jjCY+JqO1UWJicHL8q9n4n7BM3WUxmpVL92wVQTsib/BWmm
 TDzq/e0SPG/NAT9u7sndjTBi+PKBoqrn+i5w3PI0DWnB0leQxWKSrnZrki305eQ3ybn1
 +9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768207590; x=1768812390;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T6wMvulYXOsp7OWCUwvWyQUyG3fsKRIHB6ZTJYWOshw=;
 b=bco7PCxNgZlCeg0Hjys38WsbhUju+pW1Jyvv/BL5bHaCxM93116pm0rmeqFvRPEp8S
 eh3SW3pRg7QWENzejZvLkdNrj2O1WGBT8CRdslew88hJTZXdFwXieh8hAWaoYt+MsH9S
 xlFY5lyc/39jgQjgJ/wTvdvcLGFWk9JDkPssq6on/BIVZUkYl7h/v+BWMxuY55Rnx32o
 NxwDfBgAiz06/zcVussLh08eARbQmlXjd+RRpk2dThVJEgj0X472TgOQAiH+j1jJGLmS
 Tz6dkKYYsh81BrjygA76LeL9ZDjUQ7JuaBnnU8xf2dyObSbViL0/IMBi9Njv+CR7sJxE
 XkxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX6UNNlkv6ASFh8j197tQFVvhrCrA63fCxdZJrdnXXA3mq2G2KCvUM/ekDAqzd55C+VxkboWQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1MEbRs3iRren1175iR5pBkzpkAYobH7/W9k+Jsr0H8XrHpRrt
 upOS56TisW+pCYNiRLA61sYujlYZAtGh65EYh0ADPpqF/SX1YnxR5m9Qbk/s1LnOZU4=
X-Gm-Gg: AY/fxX4ShYti1+SI3s1FoH0dSI+djn0mUr7JGc/OR4c6t2G8plt1DsHp++T1hbnNN/Z
 xmQVeegnA+TMLStbJb5IF39QwwL30np1YQLe9rFZO59+CPD5/OP85BwZmIPSnaOoLBIT4Nd2DlM
 L9yBTbIDBOlHVSel9Iws//fYcWcavMuGt03g9Q1xgonf04y262j7ljAzlz7oht6g0zfDr7XsEqq
 jfG/GgdxnnkweyADPnuCsfP/F1E5tnjrpIYCbMRGmJpLN2kS2kd1h7jMdY8Wer/T5BQ9/ab4hpi
 OMIARtyawk9dN4GEJTJkmb5zZO1Z4IjDgG+pctcadR9UMeNH6w2qE7vuTYjxnEGxIHpuxIqIM8D
 mkLFMaaQUNBceeOMedQk8Wgv0CgqgC2rK4Lg1SlQZY9GRTlNEh5HkPSGB/dn8nquXuVar9BgzSr
 XVdDIS8d2Ess0uM1ztELj8xBL3XYt1H3BoZMW5tDFBE3Mi6g9mZNrdeVi+ih6X3Lku
X-Google-Smtp-Source: AGHT+IEC73clqtW9dx7kSRncxUF/arCFUqRX+MxZs20pNgTB4x1BhyYlI8eWWZNqTg7CUdRNOuFYGQ==
X-Received: by 2002:a05:600c:37ce:b0:477:a0dd:b2af with SMTP id
 5b1f17b1804b1-47d84b61341mr181460655e9.33.1768207590392; 
 Mon, 12 Jan 2026 00:46:30 -0800 (PST)
Received: from ?IPV6:2a00:f2a:e0df:cca0:1161:e931:8b2e:a414?
 ([2a00:f2a:e0df:cca0:1161:e931:8b2e:a414])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ec5d95edbsm125759615e9.3.2026.01.12.00.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 00:46:30 -0800 (PST)
Message-ID: <b95c93d6-7a50-4fb3-b94e-ffd72b825cfc@linaro.org>
Date: Mon, 12 Jan 2026 10:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: at91: move atmel_serial.h to
 include/dm/platform_data
To: Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
References: <20251230210201.496403-1-robert.marko@sartura.hr>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251230210201.496403-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12/30/25 23:01, Robert Marko wrote:
> Move the arch specific atmel_serial.h header from AT91 to the generic
> include/dm/platform_data.
> 
> This will be used for support on Microchip LAN969x.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  board/bluewater/gurnard/gurnard.c                               | 2 +-
>  board/siemens/corvus/board.c                                    | 2 +-
>  board/siemens/smartweb/smartweb.c                               | 2 +-
>  board/siemens/taurus/taurus.c                                   | 2 +-
>  drivers/serial/atmel_usart.c                                    | 2 +-
>  .../include/mach => include/dm/platform_data}/atmel_serial.h    | 0
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename {arch/arm/mach-at91/include/mach => include/dm/platform_data}/atmel_serial.h (100%)
> 
> diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurnard/gurnard.c
> index 3275803226a..71db6409721 100644
> --- a/board/bluewater/gurnard/gurnard.c
> +++ b/board/bluewater/gurnard/gurnard.c
> @@ -29,7 +29,7 @@
>  #include <asm/arch/at91_rstc.h>
>  #include <asm/arch/at91_rtc.h>
>  #include <asm/arch/at91_sck.h>
> -#include <asm/arch/atmel_serial.h>
> +#include <dm/platform_data/atmel_serial.h>
>  #include <asm/arch/clk.h>
>  #include <asm/arch/gpio.h>
>  #include <dm/uclass-internal.h>
> diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
> index a8714e055d7..7a70a7dfc8b 100644
> --- a/board/siemens/corvus/board.c
> +++ b/board/siemens/corvus/board.c
> @@ -20,7 +20,7 @@
>  #include <asm/arch/at91sam9_smc.h>
>  #include <asm/arch/at91_common.h>
>  #include <asm/arch/at91_rstc.h>
> -#include <asm/arch/atmel_serial.h>
> +#include <dm/platform_data/atmel_serial.h>
>  #include <asm/arch/gpio.h>
>  #include <asm/gpio.h>
>  #include <asm/arch/clk.h>
> diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
> index 6fa3ca573ae..ce16aad3b98 100644
> --- a/board/siemens/smartweb/smartweb.c
> +++ b/board/siemens/smartweb/smartweb.c
> @@ -25,7 +25,7 @@
>  #include <asm/arch/at91sam9260_matrix.h>
>  #include <asm/arch/at91sam9_smc.h>
>  #include <asm/arch/at91_common.h>
> -#include <asm/arch/atmel_serial.h>
> +#include <dm/platform_data/atmel_serial.h>
>  #include <asm/arch/at91_spi.h>
>  #include <spi.h>
>  #include <asm/arch/clk.h>
> diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
> index 252b0787124..690c00046fa 100644
> --- a/board/siemens/taurus/taurus.c
> +++ b/board/siemens/taurus/taurus.c
> @@ -24,7 +24,7 @@
>  #include <asm/arch/at91_rstc.h>
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/at91sam9_sdramc.h>
> -#include <asm/arch/atmel_serial.h>
> +#include <dm/platform_data/atmel_serial.h>
>  #include <asm/arch/clk.h>
>  #include <asm/gpio.h>
>  #include <linux/mtd/rawnand.h>
> diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
> index 0b35582aaa4..d6c3d4cbcc8 100644
> --- a/drivers/serial/atmel_usart.c
> +++ b/drivers/serial/atmel_usart.c
> @@ -18,7 +18,7 @@
>  
>  #include <asm/io.h>
>  #if CONFIG_IS_ENABLED(DM_SERIAL)
> -#include <asm/arch/atmel_serial.h>
> +#include <dm/platform_data/atmel_serial.h>
>  #endif
>  #include <asm/arch/clk.h>
>  #include <asm/arch/hardware.h>
> diff --git a/arch/arm/mach-at91/include/mach/atmel_serial.h b/include/dm/platform_data/atmel_serial.h
> similarity index 100%
> rename from arch/arm/mach-at91/include/mach/atmel_serial.h
> rename to include/dm/platform_data/atmel_serial.h

Hello Robert,

These patches break the build for some boards. e.g. corvus_defconfig


drivers/serial/atmel_usart.c: In function ‘atmel_serial_setbrg_internal’:
drivers/serial/atmel_usart.c:44:20: error: implicit declaration of
function ‘get_usart_clk_rate’ [-Werror=implicit-function-declaration]
   44 |         usart_hz = get_usart_clk_rate(id);
      |                    ^~~~~~~~~~~~~~~~~~
  AR      spl/disk/built-in.a
  CC      spl/fs/fs_internal.o
cc1: some warnings being treated as errors


Please have a look,
thanks,
Eugen

