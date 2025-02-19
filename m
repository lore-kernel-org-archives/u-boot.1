Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7FAC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B407780A46;
	Wed, 19 Feb 2025 16:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AdoPY15s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F82A80EC0; Wed, 19 Feb 2025 16:06:35 +0100 (CET)
Received: from mail-m32118.qiye.163.com (mail-m32118.qiye.163.com
 [220.197.32.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BD7801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f63df9;
 Wed, 19 Feb 2025 23:06:26 +0800 (GMT+08:00)
Message-ID: <56ccb11a-3b7d-413f-8fd3-2325640f47ac@rock-chips.com>
Date: Wed, 19 Feb 2025 23:06:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: grf: Fix enum typos for UART2
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Jonas Karlman <jonas@kwiboo.se>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250204172954.3364927-1-wens@kernel.org>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250204172954.3364927-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHU5LVkMZSktLHxhOT0geTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951ebef91503afkunmb8f63df9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6CSo6ATIXIy5DKFYQDi8#
 N05PCz5VSlVKTEhCQkxMTkNMQklKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUlNTks3Bg++
DKIM-Signature: a=rsa-sha256;
 b=AdoPY15sUp3wojZ1VO8olXjT0k7ZGYrhBbbapIaX5jNvKXwnxAWeocUcSrPEaTSTmPWEC6Qr9Fhr2zQTcLq72LkmOnSI6f6pgrEN0OWv4k48AhfzsD3ALKfikrSheVM61eG+SmsL8Q2jCTCbQbS0cCcPhXPl94407CTvaG2cQio=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=r7IdnuOjNuvhpUF6CaPq4XKANLPdgTzlYzcg1jmpqio=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/2/5 01:29, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> In the GRF header file, some instances of UART2 pinmux are prefixed with
> "GRF_UART2DBG" while others have "GRF_UART2DGB".
>
> Since UART2 is the default console UART and used for debugging, it is
> more likely the name should be UART2DBG.
>
> Fix the ones that are wrong.
>
> Fixes: a2c08df3813b ("pinctrl: add driver for rk3399")
> Fixes: fa72de10452c ("rockchip: arm64: rk3399: move grf register definitions to grf_rk3399.h")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
>   arch/arm/include/asm/arch-rockchip/grf_rk3399.h | 6 +++---
>   arch/arm/mach-rockchip/rk3399/rk3399.c          | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3399.h b/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
> index dd89cd205056..e6125d6bf540 100644
> --- a/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
> +++ b/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
> @@ -466,18 +466,18 @@ enum {
>   	/*  GRF_GPIO4C_IOMUX */
>   	GRF_GPIO4C0_SEL_SHIFT   = 0,
>   	GRF_GPIO4C0_SEL_MASK    = 3 << GRF_GPIO4C0_SEL_SHIFT,
> -	GRF_UART2DGBB_SIN       = 2,
> +	GRF_UART2DBGB_SIN       = 2,
>   	GRF_HDMII2C_SCL         = 3,
>   	GRF_GPIO4C1_SEL_SHIFT   = 2,
>   	GRF_GPIO4C1_SEL_MASK    = 3 << GRF_GPIO4C1_SEL_SHIFT,
> -	GRF_UART2DGBB_SOUT      = 2,
> +	GRF_UART2DBGB_SOUT      = 2,
>   	GRF_HDMII2C_SDA         = 3,
>   	GRF_GPIO4C2_SEL_SHIFT   = 4,
>   	GRF_GPIO4C2_SEL_MASK    = 3 << GRF_GPIO4C2_SEL_SHIFT,
>   	GRF_PWM_0               = 1,
>   	GRF_GPIO4C3_SEL_SHIFT   = 6,
>   	GRF_GPIO4C3_SEL_MASK    = 3 << GRF_GPIO4C3_SEL_SHIFT,
> -	GRF_UART2DGBC_SIN       = 1,
> +	GRF_UART2DBGC_SIN       = 1,
>   	GRF_GPIO4C4_SEL_SHIFT   = 8,
>   	GRF_GPIO4C4_SEL_MASK    = 3 << GRF_GPIO4C4_SEL_SHIFT,
>   	GRF_UART2DBGC_SOUT      = 1,
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 1ce43c6f0d40..562d666ea092 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -136,7 +136,7 @@ void board_debug_uart_init(void)
>   	/* Enable early UART2 channel C on the RK3399 */
>   	rk_clrsetreg(&grf->gpio4c_iomux,
>   		     GRF_GPIO4C3_SEL_MASK,
> -		     GRF_UART2DGBC_SIN << GRF_GPIO4C3_SEL_SHIFT);
> +		     GRF_UART2DBGC_SIN << GRF_GPIO4C3_SEL_SHIFT);
>   	rk_clrsetreg(&grf->gpio4c_iomux,
>   		     GRF_GPIO4C4_SEL_MASK,
>   		     GRF_UART2DBGC_SOUT << GRF_GPIO4C4_SEL_SHIFT);
