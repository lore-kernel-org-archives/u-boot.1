Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F0EA8542
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE5883EEF;
	Mon,  9 Mar 2026 04:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OQk9uD18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDE483F8A; Mon,  9 Mar 2026 04:02:59 +0100 (CET)
Received: from mail-m128152.netease.com (mail-m128152.netease.com
 [103.209.128.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D674980517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36304abdd;
 Mon, 9 Mar 2026 11:02:53 +0800 (GMT+08:00)
Message-ID: <49eb3632-62a1-4527-9f3a-9fd8700f6b0a@rock-chips.com>
Date: Mon, 9 Mar 2026 11:02:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 01/12] rockchip: spl: Add common handling of USB
 bootsource_id 0x81
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-2-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260131233843.3419737-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd08c2e1c03afkunm1a416669162bf8d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0IfVk5NSxpJH08aHxhKS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=OQk9uD185c8kkrkTM4csCvOHcookq1UTWRBfrpuHFRxBETznYO73NrMxL1A0Zo8ERqW96mXrfCNYAR9UCwSoMUZHaUEi7X71GTvy3hftRqs7KGBXDCa8yic0guK7yzbW0Xv78ywj6mlCPBJJwvM9Pd0cJ2w2TjEM8ZkTHvi1jXA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=e3brmAxMaNZRR8UCRjcM/XAoxYIYsc2MzuUFHmFU/z8=;
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


On 2026/2/1 07:38, Jonas Karlman wrote:
> Multiple newer Rockchip SoCs report 0x81 instead of 0xa when booting
> from USB, i.e. on RK3576, RK3528, RK3506 and RV1106.
>
> Move the bootsource_id 0x81 handling currently only used for RK3528 to
> the common read_brom_bootsource_id() to reduce the need to override this
> function when support for newer SoCs is introduced.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   arch/arm/mach-rockchip/rk3528/rk3528.c | 15 ---------------
>   arch/arm/mach-rockchip/spl.c           | 12 +++++++++++-
>   2 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
> index 57ead0006f1f..f9bfc445b857 100644
> --- a/arch/arm/mach-rockchip/rk3528/rk3528.c
> +++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
> @@ -49,21 +49,6 @@ void board_debug_uart_init(void)
>   {
>   }
>   
> -u32 read_brom_bootsource_id(void)
> -{
> -	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> -
> -	/* Re-map the raw value read from reg to an existing BROM_BOOTSOURCE
> -	 * enum value to avoid having to create a larger boot_devices table.
> -	 */
> -	if (bootsource_id == 0x81)
> -		return BROM_BOOTSOURCE_USB;
> -	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
> -		log_debug("Unknown bootsource %x\n", bootsource_id);
> -
> -	return bootsource_id;
> -}
> -
>   int arch_cpu_init(void)
>   {
>   	u32 val;
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index a9155dceedb4..e989c148079a 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -35,7 +35,17 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   
>   __weak u32 read_brom_bootsource_id(void)
>   {
> -	return readl(BROM_BOOTSOURCE_ID_ADDR);
> +	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +
> +	/* Re-map the raw value read from reg to an existing BROM_BOOTSOURCE
> +	 * enum value to avoid having to create a larger boot_devices table.
> +	 */
> +	if (bootsource_id == 0x81)
> +		return BROM_BOOTSOURCE_USB;
> +	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
> +		log_debug("Unknown bootsource %x\n", bootsource_id);
> +
> +	return bootsource_id;
>   }
>   
>   const char *board_spl_was_booted_from(void)
