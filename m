Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8711C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 01:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB1488517;
	Tue, 23 Apr 2024 03:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LoHLLauO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8B388513; Tue, 23 Apr 2024 03:10:07 +0200 (CEST)
Received: from mail-m127224.xmail.ntesmail.com
 (mail-m127224.xmail.ntesmail.com [115.236.127.224])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52F788523
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 03:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LoHLLauO8YFdQX7/X5dcdVUZLyuvR0XGdxygP7TBUeqMwvN9fdMGkv9s/9JOds2ZZ0qyg21uuCc9yiHy6L9hBc2qs2jnZvtPex6BF4aKa2LLt13k6OH1zGd8JbEQUCvt0oVvnogR2H1YA1SYDCnBTKwAFnK0+3MFIQxRe7aPlR0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=PLzoIqXuotATSLZm7w1CcIkYNBcgg/JgalYNjWMRgZ8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DC7FD900182;
 Tue, 23 Apr 2024 09:09:46 +0800 (CST)
Message-ID: <e8a60f99-4012-4ef6-a210-436ac41bd1ae@rock-chips.com>
Date: Tue, 23 Apr 2024 09:09:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: add support for UART2 M1 and M2 in
 SPL
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wdGlZCHh0dSR8ZHhoZGkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f088074a003a9kunmdc7fd900182
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Ljo6GDNRGDg#NzdWQkgR
 CiswFDdVSlVKTEpIQ0hPTkNMTU1NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOT0JNNwY+
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

Hi Quentin,

On 2024/4/23 00:41, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> UART2 controller is the controller in the reference design for debug
> console. The default mux is M0 in that reference design. Until now, all
> boards seemed to be using UART2M0 but RK3588 Tiger for example will be
> using UART2M2 instead.
This feature already been supported, please use CONFIG_DEBUG_UART_BASE and
CONFIG_ROCKCHIP_UART_MUX_SEL_M to select your output channel.

Thanks,
- Kever
>
> Therefore, let's add support for UART2M1 and M2 as possible muxes for
> the UART2 controller used as debug console. UART2M1 support was not
> tested.
>
> The default value is M0 to match the one used currently by all devices
> and the reference design.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig  | 10 ++++++++++
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 36 ++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index d7e4af31f24..cacdb0459c9 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -221,6 +221,16 @@ config ROCKCHIP_COMMON_STACK_ADDR
>   config TEXT_BASE
>   	default 0x00a00000
>   
> +config DEBUG_UART_CHANNEL
> +	int "Mux channel to use for debug UART2"
> +	depends on DEBUG_UART_BOARD_INIT
> +	default 0
> +	range 0 2
> +	help
> +	  UART2 can use three different set of pins to route the output.
> +	  For using the UART for early debugging the route to use needs
> +	  to be declared (0, 1 or 2).
> +
>   source board/edgeble/neural-compute-module-6/Kconfig
>   source board/friendlyelec/nanopc-t6-rk3588/Kconfig
>   source board/pine64/quartzpro64-rk3588/Kconfig
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index eb65dafe3a2..e330ad6a697 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -94,9 +94,32 @@ enum {
>   	GPIO0B6_UART2_RX_M0	= 10,
>   };
>   
> +/* GPIO3B_IOMUX_SEL_L */
> +enum {
> +	GPIO3B1_SHIFT		= 4,
> +	GPIO3B1_MASK		= GENMASK(7, 4),
> +	GPIO3B1_UART2_TX_M2	= 10,
> +
> +	GPIO3B2_SHIFT		= 8,
> +	GPIO3B2_MASK		= GENMASK(11, 8),
> +	GPIO3B2_UART2_RX_M2	= 10,
> +};
> +
> +/* GPIO4D_IOMUX_SEL_L */
> +enum {
> +	GPIO4D0_SHIFT		= 0,
> +	GPIO4D0_MASK		= GENMASK(3, 0),
> +	GPIO4D0_UART2_TX_M1	= 10,
> +
> +	GPIO4D1_SHIFT		= 4,
> +	GPIO4D1_MASK		= GENMASK(7, 4),
> +	GPIO4D1_UART2_RX_M1	= 10,
> +};
> +
>   void board_debug_uart_init(void)
>   {
>   	__maybe_unused static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
> +#if (CONFIG_DEBUG_UART_CHANNEL == 0)
>   	static struct rk3588_pmu2_ioc * const pmu2_ioc = (void *)PMU2_IOC_BASE;
>   
>   	/* Refer to BUS_IOC */
> @@ -110,6 +133,19 @@ void board_debug_uart_init(void)
>   		     GPIO0B6_MASK | GPIO0B5_MASK,
>   		     GPIO0B6_UART2_RX_M0 << GPIO0B6_SHIFT |
>   		     GPIO0B5_UART2_TX_M0 << GPIO0B5_SHIFT);
> +#elif (CONFIG_DEBUG_UART_CHANNEL == 1)
> +	/* UART2_M1 Switch iomux */
> +	rk_clrsetreg(&bus_ioc->gpio4d_iomux_sel_l,
> +		     GPIO4D0_MASK | GPIO4D1_MASK,
> +		     GPIO4D0_UART2_TX_M1 << GPIO4D0_UART2_TX_M1 |
> +		     GPIO4D1_UART2_RX_M1 << GPIO4D1_SHIFT);
> +#else
> +	/* UART2_M2 Switch iomux */
> +	rk_clrsetreg(&bus_ioc->gpio3b_iomux_sel_l,
> +		     GPIO3B1_MASK | GPIO3B2_MASK,
> +		     GPIO3B1_UART2_TX_M2 << GPIO3B1_SHIFT |
> +		     GPIO3B2_UART2_RX_M2 << GPIO3B2_SHIFT);
> +#endif /* CONFIG_DEBUG_UART_CHANNEL */
>   }
>   
>   #ifdef CONFIG_SPL_BUILD
>
