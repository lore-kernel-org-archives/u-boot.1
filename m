Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C19C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DFF982CEB;
	Tue,  8 Apr 2025 05:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fbhlCGCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C39482CFA; Tue,  8 Apr 2025 05:18:04 +0200 (CEST)
Received: from mail-m32111.qiye.163.com (mail-m32111.qiye.163.com
 [220.197.32.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD2682CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101c691b;
 Tue, 8 Apr 2025 11:17:56 +0800 (GMT+08:00)
Message-ID: <b00a0045-cba3-4975-8295-f3b427d88c17@rock-chips.com>
Date: Tue, 8 Apr 2025 11:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] rockchip: rk3588: Use hptimer reg names in
 rockchip_stimer_init
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx4dS1ZLSR0fSEpOS01MTx9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9613678f5803afkunm1101c691b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46MTo4KTJIF0JNLzZPPkMo
 EBkwCR9VSlVKTE9PS0NJSUxMSUxPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0xONwY+
DKIM-Signature: a=rsa-sha256;
 b=fbhlCGCTdv3Ybr4FRUIlz3i9Dc3efGG3yqeQnNZTKDTS1iuMJh/x9sYyG6P1EQcSnCJDDmfcFfGcXZ8Qhz19raBzfzUO6XhZUbubuGc/oz09Bpk065w8X8j340or8e0iIa7eo5Y5G6/Ffv7ym+eKWF+Fm4DC3fAtrmAGH2hnuCw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=yrNDiVSD+WLYqu+6gDnCGrJ2EProslxdLUGhAyrSf7Q=;
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


On 2025/4/6 08:24, Jonas Karlman wrote:
> Define constants for hptimer reg names and use them instead of magic
> numbers in rockchip_stimer_init().
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index 6395483f14f1..ac35866e2f87 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -116,18 +116,25 @@ void board_debug_uart_init(void)
>   }
>   
>   #ifdef CONFIG_XPL_BUILD
> +
> +#define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
> +#define HP_CTRL_REG			0x04
> +#define TIMER_EN			BIT(0)
> +#define HP_LOAD_COUNT0_REG		0x14
> +#define HP_LOAD_COUNT1_REG		0x18
> +
>   void rockchip_stimer_init(void)
>   {
>   	/* If Timer already enabled, don't re-init it */
> -	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
> +	u32 reg = readl(HP_TIMER_BASE + HP_CTRL_REG);
>   
> -	if (reg & 0x1)
> +	if (reg & TIMER_EN)
>   		return;
>   
> -	asm volatile("msr CNTFRQ_EL0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x14);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x18);
> -	writel(0x1, CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
> +	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
> +	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
> +	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
> +	writel(TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
>   }
>   #endif
>   
