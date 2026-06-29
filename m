Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB550C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E6284A3A;
	Mon, 29 Jun 2026 19:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zsbXfByB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107DE84A4A; Mon, 29 Jun 2026 19:25:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7B984A30
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d2b5=E2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782753921;
 bh=E3dpLrInSCZuZOAq7ifMmN/pCzCmgxfxBvUpaakPALA=;
 b=zsbXfByB80L1+O9/Ep4t7I+8vdwDoLRcHOraW4SqEg6OnvIi5HfNUSPrlx7IIhVxux4Bvt8No
 82Jw4ab+f5dm3uvDjfV4RsysC06oBslvd8XralXbjFnOAatDQ5q0AQlBjUM/4466mQkCuh2Z/uO
 4PE//F3pwl9mL4tGiPDErKbG/kLMGJeGFUjB1KTgWcyT0uxBzZOTaUuNLDbbD1+nN8bmRD3Sjcm
 CaxmoT7JhDiqA64xm98uhYit8DtI8t+JkgtK9PB/oRpf3S7S8UyMUopN9qE9wDBoJjaahkFAv6l
 vKngOXmqNHmvrxLKyNVGdRgUmHLd+D+q/T65WdERGnxA==
X-Forward-Email-ID: 6a42aa7e85ec65c7fec37ae9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ca4ed1b5-e707-4c9e-bfc8-c767dd71731f@kwiboo.se>
Date: Mon, 29 Jun 2026 19:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk3568: make the WDT trigger a first
 global reset
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, quentin.schulz@cherry.de
References: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
 <20260629170517.1436613-2-andreas.zdziarstek@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260629170517.1436613-2-andreas.zdziarstek@gmail.com>
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

Hi Andreas,

On 6/29/2026 7:05 PM, Andreas Zdziarstek wrote:
> Default is a second global reset which causes a system hang on a timeout
> in U-Boot.
> 
> Access the register through the rk3568_cru struct to match how PX30 does
> it in arch_cpu_init().
> 
> Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
> cleanly reboots the board.
> 
> Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
> ---
>  arch/arm/mach-rockchip/rk3568/rk3568.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 2b1eafee37c..87bd443e9c4 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -9,6 +9,7 @@
>  #include <misc.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/cru_rk3568.h>
>  #include <asm/arch-rockchip/grf_rk3568.h>
>  #include <asm/arch-rockchip/hardware.h>
>  #include <dt-bindings/clock/rk3568-cru.h>
> @@ -37,6 +38,9 @@
>  #define CPU_GRF_BASE		0xfdc30000
>  #define GRF_CORE_PVTPLL_CON0	(0x10)
>  
> +#define CRU_BASE		0xfdd20000
> +#define WDT_GLB_SRST_CTRL	BIT(1)
> +
>  /* PMU_GRF_GPIO0D_IOMUX_L */
>  enum {
>  	GPIO0D1_SHIFT		= 4,
> @@ -116,6 +120,8 @@ void board_debug_uart_init(void)
>  
>  int arch_cpu_init(void)
>  {
> +	static struct rk3568_cru * const cru = (void *)CRU_BASE;
> +
>  #ifdef CONFIG_XPL_BUILD
>  	/*
>  	 * When perform idle operation, corresponding clock can
> @@ -146,6 +152,10 @@ int arch_cpu_init(void)
>  	writel((PMU_PD_VO_DWN_ENA << 16),
>  	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
>  #endif
> +
> +	/* Make WDT trigger a first global reset */
> +	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);

As mentioned in v1, please keep this inside XPL_BUILD.

SPL+U-Boot proper combined should be seen as a single firmware, we do
not consider vendor SPL + mainline U-Boot proper a supported combo.

If you also want to configure this in U-Boot proper, maybe probe of WDT
or CRU driver is a better fit?

arch_cpu_init() is mainly for one-off configuration that is needed very
early or otherwise does not really fit anywhere in the lazy loading of
driver model.

Regards,
Jonas

> +
>  	return 0;
>  }
>  

