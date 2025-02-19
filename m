Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC859C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 14:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308FE800D7;
	Wed, 19 Feb 2025 15:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="If6qeWeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C54B80F67; Wed, 19 Feb 2025 15:53:18 +0100 (CET)
Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com
 [45.254.49.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C11680F56
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 15:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f40768;
 Wed, 19 Feb 2025 22:53:08 +0800 (GMT+08:00)
Message-ID: <f0b3e9bd-6505-44e5-9ec2-93cf2bac47b7@rock-chips.com>
Date: Wed, 19 Feb 2025 22:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "rockchip: rk3399: Drop unneeded bob and kevin
 board specific code"
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250208224945.2641933-1-jonas@kwiboo.se>
 <20250208224945.2641933-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250208224945.2641933-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGENJVkpLTkJCSBlOSE5NSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0hKSkJMVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951eb2cac003afkunmb8f40768
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6Pgw5EDIPTi4XAhAXNj8S
 TyNPCwhVSlVKTEhCQkxNTENCSENKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUlJTU03Bg++
DKIM-Signature: a=rsa-sha256;
 b=If6qeWebppqJ1qMfQ/biFQJL3r5PnDzcoQ8FqyLgvXI1/Xixau3voqR0yFXKYtO66Stmyr7k1m0g/eGctU3Iwr0cNKaJJD3NXp1UQqCaIty06oYbjRnxC3XJj/og+a5EcDLANraiWEvth29hAyV4rtGRg4QDX+u043WvVHOcZO8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Np8S6Bp4u/EH17OUnVWrjZjRg8ym4CHgUJibRs0yQRA=;
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


On 2025/2/9 06:49, Jonas Karlman wrote:
> These power rails must be on very early for the U-Boos SPL banner to be
> show over debug UART.
>
> This reverts commit af518a1dfe637cb4dc486d7a832585e4a48bc970.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 1ce43c6f0d40..ba89079b1e73 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -7,6 +7,7 @@
>   #include <init.h>
>   #include <log.h>
>   #include <spl.h>
> +#include <spl_gpio.h>
>   #include <syscon.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
> @@ -15,7 +16,6 @@
>   #include <asm/arch-rockchip/gpio.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   #include <asm/arch-rockchip/hardware.h>
> -#include <asm/gpio.h>
>   #include <linux/bitops.h>
>   #include <linux/printk.h>
>   #include <power/regulator.h>
> @@ -133,6 +133,27 @@ void board_debug_uart_init(void)
>   		     GRF_GPIO3B7_SEL_MASK,
>   		     GRF_UART3_SOUT << GRF_GPIO3B7_SEL_SHIFT);
>   #else
> +	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
> +	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
> +
> +	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
> +	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
> +	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
> +		rk_setreg(&grf->io_vsel, 1 << 0);
> +
> +		/*
> +		 * Let's enable these power rails here, we are already running
> +		 * the SPI-Flash-based code.
> +		 */
> +		spl_gpio_output(gpio, GPIO(BANK_B, 2), 1);  /* PP1500_EN */
> +		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_B, 2),
> +				  GPIO_PULL_NORMAL);
> +
> +		spl_gpio_output(gpio, GPIO(BANK_B, 4), 1);  /* PP3000_EN */
> +		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_B, 4),
> +				  GPIO_PULL_NORMAL);
> +	}
> +
>   	/* Enable early UART2 channel C on the RK3399 */
>   	rk_clrsetreg(&grf->gpio4c_iomux,
>   		     GRF_GPIO4C3_SEL_MASK,
