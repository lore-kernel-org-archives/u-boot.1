Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A82C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 18:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B108581671;
	Mon, 27 Jan 2025 19:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Adse+ldn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26BD8169E; Mon, 27 Jan 2025 19:59:36 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D69F812C8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 19:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so31569915e9.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738004374; x=1738609174; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9GmKjz3bkxCrPJO3s4Rd0HU9MvXNA0JHla6f3ZEzSM=;
 b=Adse+ldnYgjbu0VjmdaSjaaH9F3t97x4rgFfR5YCkGQe6uD8It+hQx2BvAR/tuiYHb
 t5DpYyZAOcqvnF0NGm6FHZZl6monqEFyY8foxXSFxy8Q3UOKwxOX/ks1IJ4yoGtF+0m7
 w0IvOVM1qz9XTkK3C0y3hHiwxwjQLZoRG3FF16vueEwR8GcB//x2V10OVBUusbKVDZJ0
 FXhbJY4dwXjAQuFDeF+v7ac1Ghmt5WHWU/2VBCyh0dHO7ShwBy7bkCWmPjt1U/lxAOza
 du4t32WRSSqMeOomA/m+7z9sCppvM2lAKYkOk1+yFKGeEFAJX69Iak4uXO2TPyxOyQWw
 e1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738004374; x=1738609174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9GmKjz3bkxCrPJO3s4Rd0HU9MvXNA0JHla6f3ZEzSM=;
 b=iFju7Q/3QBGem4IibqJXcucw/h3Yf0i03vgLcCSGZ/vX7U7MFoG4rZeXdsKhMrRV33
 c6j2RodKiwp0DdQiX8wk1SBTYpuBP+9L84g+SGmt/E+4c/5xx9aNZ6QijCdlW8WnqYDr
 mW1KBYivlk4EvoOZ0fC2fzbKjVQ01crkSEjYObwIqx9zm2GECAN6c60h0X9D30qBZss7
 A3sLktJPJ7I3ScnFY4q66olDpZeUk1CVDwarsvCDR6k1dtTZI5j83zL0kJwiu8cE2wi5
 mgkXJlzEiDKO7as6MWYB61wdXKoh9YQeYF2EwyWEifRQAac9kU0p0XbnDHtohEY6/wmi
 N/Qg==
X-Gm-Message-State: AOJu0YwUoh0GtbxTVUwoxipLRAwMNRpFHRvOaybQBJs9tQmM9MSuUQbU
 piCZjWOqJgF41PwLCBH1MrDDMT06mQFETsERyhKTBbTYccf9gbg=
X-Gm-Gg: ASbGnctH9vb5tdKThk2mQWLwKgwdq4W+Qlv/LQ1YS4NNTXuBWUUiH6a0nqy7OfwapLV
 HWXKzJJVVPteF7CP9VEUud7rNO4iZYUUbZJ1W+aGJsC0FLQOULunkUPOtOodvfHDRyoPhxVdPmv
 LjJivid3UXiI1O94J1ffVnNzh9EQtFoeWCMLJ/bpNuRVykkL50ejdlxQqEpnA4vFnSb6KFxmSPG
 YdyuvG/dfSqA79+kaaascwq7DIDUPEgW1LASw6UGgDj30TKAIem4obif7aTZLctcKSKeqFFBer0
 7x65e6/I1K5Y+ukSAH1z31wC1hlVrSXxEtG1LGNmqWKQ7qxUmIo=
X-Google-Smtp-Source: AGHT+IEk8I9rcBeWuGO1EPFi6FM35d8tYUfoygE1RrHVVl/p2OQ/vBQtI+nKdBDr06rT8KbykEpceA==
X-Received: by 2002:a05:600c:1987:b0:434:a7b6:10e9 with SMTP id
 5b1f17b1804b1-438913e2fa9mr409910285e9.17.1738004373493; 
 Mon, 27 Jan 2025 10:59:33 -0800 (PST)
Received: from ?IPV6:2a02:810b:f13:8500:ef9b:15f0:7162:3734?
 ([2a02:810b:f13:8500:ef9b:15f0:7162:3734])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d2c0esm140182005e9.33.2025.01.27.10.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 10:59:33 -0800 (PST)
Message-ID: <4e6629cf-9685-4b91-800e-82a9df30d5e3@gmail.com>
Date: Mon, 27 Jan 2025 19:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250126234838.561065-1-jonas@kwiboo.se>
 <20250126234838.561065-3-jonas@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250126234838.561065-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Jonas,

thanks for working on this.  Please see one comment below.

Am 27.01.25 um 00:48 schrieb Jonas Karlman:
> A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
> the more common 0x0 DRAM base address used on AArch64 SoCs.
>
> Add default options that should work for these ARMv7 SoCs. Same offsets
> as before are used, just below 64 MiB. Hex values have also been padded
> to improve alignment.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 5aa9e0f1af3b..da20d3233fe3 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -637,40 +637,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
>   if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>   
>   config CUSTOM_SYS_INIT_SP_ADDR
> -	default 0x3f00000
> +	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SYS_MALLOC_F_LEN
> -	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_SYS_MALLOC_F_LEN
> -	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TPL_SYS_MALLOC_F_LEN
> -	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TEXT_BASE
> -	default 0x00200000 if ARM64
> +	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_TEXT_BASE
> -	default 0x0 if ARM64
> +	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
> +			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \

I'm not sure if adding RK3036 and RK3188 is correct at this point. Both use
SPL (without TPL) currently for DRAM initialization and thus need their
CFG_IRAM_BASE as SPL_TEXT_BASE.

Regards,

Alex

> +			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
> +	default 0x00000000
>   
>   config SPL_HAS_BSS_LINKER_SECTION
>   	default y if ARM64
>   
>   config SPL_BSS_START_ADDR
> -	default 0x3f80000
> +	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_BSS_MAX_SIZE
> -	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
> +	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> +	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>   
>   config SPL_STACK_R
> -	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_STACK_R_ADDR
> -	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_STACK_R_MALLOC_SIMPLE_LEN
> -	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
> +	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
> +	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
>   
>   endif
>   endif
