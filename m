Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42D7C10F16
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 17:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E35888F2;
	Mon, 22 Apr 2024 19:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IGtjm4H5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A9F888F8; Mon, 22 Apr 2024 19:52:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62D0884A4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 19:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c7e=L4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713808306;
 bh=58fbxcnPWj2J1iiOdUTuXlbGNSLUXfqxucJR4Ov0BWk=;
 b=IGtjm4H5J16EPf17VfAFtcaXsMhSuUgWMV/BF1sIqQxzYhNh+6Vz0IcrQPOzhcx5g/mxOCvgp
 g6gwnjl5ER2NeLOU5CI17pEKhI0J2ts1t9SPOcsU0G9kc+Qyl1z/Fb3p9VOw9ekZtFQC1eoab2+
 bORrtVvakiV3t3kLuyWK5bU1KT9H4G1XJPFazWM2m7re58n+0Hecq24wc662P0KsGCsPRnvUafN
 HwrGJhJbDnvHtkj3tK9fJ1hQXQlm7QqLCVtBtdzcO3VUaGjSsXa5clS6njfTR4+o5b6LBamCoEP
 R9FHPzzeUw1T4rarxfEWxyYVQ3JLGloyN277pQa6b/zg==
Message-ID: <99683d6a-2527-4aed-b168-28f0954b6ba4@kwiboo.se>
Date: Mon, 22 Apr 2024 19:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: add support for UART2 M1 and M2 in
 SPL
To: Quentin Schulz <foss+uboot@0leil.net>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6626a13beab47a2e03699207
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

On 2024-04-22 18:41, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> UART2 controller is the controller in the reference design for debug
> console. The default mux is M0 in that reference design. Until now, all
> boards seemed to be using UART2M0 but RK3588 Tiger for example will be
> using UART2M2 instead.
> 
> Therefore, let's add support for UART2M1 and M2 as possible muxes for
> the UART2 controller used as debug console. UART2M1 support was not
> tested.
> 
> The default value is M0 to match the one used currently by all devices
> and the reference design.

Is this really necessary?

Use of board_debug_uart_init() should typically only be needed in TPL on
Rockchip platform, and with ROCKCHIP_TPL being used it should be enough
to use rkbin/ddrbin_tool to change uart config and just ensure correct
pinctrl is used for uart node, and that the uart node is included in SPL
for correct serial console use.

May I suggest you try adding following to defconfig and drop this patch?

  # CONFIG_DEBUG_UART_BOARD_INIT is not set

I would expect that should result in same/working behavior without
having to add any new code.

Regards,
Jonas

> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/mach-rockchip/rk3588/Kconfig  | 10 ++++++++++
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index d7e4af31f24..cacdb0459c9 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -221,6 +221,16 @@ config ROCKCHIP_COMMON_STACK_ADDR
>  config TEXT_BASE
>  	default 0x00a00000
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
>  source board/edgeble/neural-compute-module-6/Kconfig
>  source board/friendlyelec/nanopc-t6-rk3588/Kconfig
>  source board/pine64/quartzpro64-rk3588/Kconfig
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index eb65dafe3a2..e330ad6a697 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -94,9 +94,32 @@ enum {
>  	GPIO0B6_UART2_RX_M0	= 10,
>  };
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
>  void board_debug_uart_init(void)
>  {
>  	__maybe_unused static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
> +#if (CONFIG_DEBUG_UART_CHANNEL == 0)
>  	static struct rk3588_pmu2_ioc * const pmu2_ioc = (void *)PMU2_IOC_BASE;
>  
>  	/* Refer to BUS_IOC */
> @@ -110,6 +133,19 @@ void board_debug_uart_init(void)
>  		     GPIO0B6_MASK | GPIO0B5_MASK,
>  		     GPIO0B6_UART2_RX_M0 << GPIO0B6_SHIFT |
>  		     GPIO0B5_UART2_TX_M0 << GPIO0B5_SHIFT);
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
>  }
>  
>  #ifdef CONFIG_SPL_BUILD
> 

