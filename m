Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08131EA852A
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795A580517;
	Sun,  8 Mar 2026 16:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SB0f2Cfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0403683A8C; Sun,  8 Mar 2026 16:14:03 +0100 (CET)
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com
 [220.197.31.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6322780212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3625284e0;
 Sun, 8 Mar 2026 23:13:54 +0800 (GMT+08:00)
Message-ID: <4d2d7277-66cb-4cfc-9df0-280eb6150660@rock-chips.com>
Date: Sun, 8 Mar 2026 23:13:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260108133234.4001390-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce0314c503afkunmf431034315badc9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHh1OVhlNTxpKHk9MSEIfTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=SB0f2CflF+SdSAgQiWnM+bbxxT1R58NinGRSGb7ounGTVva1MA8R88Ofqm6E9+4WZJDDCdZMfOyP/eHYqB1WFRKp7nQjoPb/Ct/MfoLh/ukFwGQ+IC2gEayulpw17a0nuUEDgubBDcptEzzKKML684rSUr9EAr9Icwz8gHnxQek=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Y/kiIGn9OZ9VNmd3JNZp99ukTDba0EG4pTXUAIk8jI8=;
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


On 2026/1/8 21:32, Jonas Karlman wrote:
> The firewall block access to pmu sram for non-secure masters by default
> after reset (0xffffbfff).
>
> Change the pmu lookup configuration to match the default lookup config
> for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
>
> Mainline TF-A will re-configure the firewall to use an even less
> restrictive lookup (0xbffe3ff0), so this change is not expected to have
> any real security implication.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index a1e8a7572fa4..c17ba418ced5 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -26,6 +26,9 @@
>   #define SYS_SGRF_SOC_CON15	0x005C
>   #define SYS_SGRF_SOC_CON20	0x0070
>   
> +#define FW_PMU1SGRF_BASE	0x26003000
> +#define PMU1SGRF_SLV_LOOKUP0	0x80
> +
>   #define FW_SYS_SGRF_BASE	0x26005000
>   #define SGRF_DOMAIN_CON1	0x4
>   #define SGRF_DOMAIN_CON2	0x8
> @@ -140,6 +143,9 @@ int arch_cpu_init(void)
>   	if (!IS_ENABLED(CONFIG_SPL_BUILD))
>   		return 0;
>   
> +	/* Allow pmu sram access for non-secure masters */
> +	writel(0xffff3fff, FW_PMU1SGRF_BASE + PMU1SGRF_SLV_LOOKUP0);
> +
>   	/* Set the emmc to access ddr memory */
>   	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
>   	writel(val | 0x7, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
