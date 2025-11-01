Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75E7CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 08:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E42F83B1B;
	Sat,  1 Nov 2025 09:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ThYuXGNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A243D83AC7; Sat,  1 Nov 2025 09:00:48 +0100 (CET)
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com
 [45.254.49.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA6C83B27
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 09:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 27ff799c7;
 Sat, 1 Nov 2025 16:00:42 +0800 (GMT+08:00)
Message-ID: <318f182d-ccde-4be2-8e6c-734ef3b955d9@rock-chips.com>
Date: Sat, 1 Nov 2025 16:00:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] rockchip: rk3036: use rockchip_stimer_init from
 spl_common.o
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
 <20251028-px30-rk3306-common-tpl-v1-2-251aba72de7c@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251028-px30-rk3306-common-tpl-v1-2-251aba72de7c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3e6ed4d203afkunm86cb4b84926124
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSh9OVh1PQxlOHhlJGh5JHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=ThYuXGNRvgfwDrC86aCpsODle3gC05R4JOI55dLilxcfqo+KSP9Ei6tnGwFxWk1XUluWrJkD6pOjHhmhdHi82xZadiu6GBnqqX9sfUrnPzbAKTJKizIxP9vUf6JzbaVCOARlMvOWKwIimE2/5nOl3vlQ5KPGk2iCMBcBGTHI0fI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=YxSoGz7BWCNyCEGwIT0ogi+AxLnJXoiJ0tHZ5wUwLxk=;
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


On 2025/10/29 00:57, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The only difference with the implementation in spl_common.c is that we
> check whether the timer has already been enabled. Considering this is
> running in SPL, the first stage on RK3036, I feel like it's guaranteed
> to not be enabled by default. No public TRM though and I don't have
> access to an RK3036 device so take this as a guess.
>
> Size of SPL binary increases by 8B for evb-rk3036.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Makefile           |  2 +-
>   arch/arm/mach-rockchip/rk3036-board-spl.c | 21 +--------------------
>   2 files changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 4c424091585..06fb527b21a 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -13,7 +13,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
>   obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
>   obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
>   
> -obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> +obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
>   
>   ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>   
> diff --git a/arch/arm/mach-rockchip/rk3036-board-spl.c b/arch/arm/mach-rockchip/rk3036-board-spl.c
> index 64e100172fa..d69139278a8 100644
> --- a/arch/arm/mach-rockchip/rk3036-board-spl.c
> +++ b/arch/arm/mach-rockchip/rk3036-board-spl.c
> @@ -5,28 +5,9 @@
>   
>   #include <debug_uart.h>
>   #include <init.h>
> -#include <asm/io.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/sdram_rk3036.h>
> -
> -#define TIMER_LOAD_COUNT_L	0x00
> -#define TIMER_LOAD_COUNT_H	0x04
> -#define TIMER_CONTROL_REG	0x10
> -#define TIMER_EN	0x1
> -#define	TIMER_FMODE	(0 << 1)
> -#define	TIMER_RMODE	(1 << 1)
> -
> -void rockchip_stimer_init(void)
> -{
> -	asm volatile("mcr p15, 0, %0, c14, c0, 0"
> -		     : : "r"(CONFIG_COUNTER_FREQUENCY));
> -
> -	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
> -	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
> -	       TIMER_CONTROL_REG);
> -}
> +#include <asm/arch-rockchip/timer.h>
>   
>   void board_init_f(ulong dummy)
>   {
>
