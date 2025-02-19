Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC6CC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 14:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6CE800D7;
	Wed, 19 Feb 2025 15:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bUCEwDma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF78800D7; Wed, 19 Feb 2025 15:54:00 +0100 (CET)
Received: from mail-m1973185.qiye.163.com (mail-m1973185.qiye.163.com
 [220.197.31.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A836580F67
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 15:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f407c2;
 Wed, 19 Feb 2025 22:53:53 +0800 (GMT+08:00)
Message-ID: <0e3275ce-96f6-4ae4-838c-639a1e7b6292@rock-chips.com>
Date: Wed, 19 Feb 2025 22:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Revert "rockchip: rk3399: Fix TPL build of bob and
 kevin"
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250208224945.2641933-1-jonas@kwiboo.se>
 <20250208224945.2641933-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250208224945.2641933-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE9LVh9NTE8ZSB4YQxpKH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951eb378f403afkunmb8f407c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6HDo5NzITNy45EhUMNjAz
 Ay5PCzVVSlVKTEhCQkxNQ0hIQkhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUpKSkI3Bg++
DKIM-Signature: a=rsa-sha256;
 b=bUCEwDmaiugViRoGCkLNUYJ5ilE6iDqlenlY4r0XN0JIBw29F5SJ+SZsksmniwcD/61ZfjZ0LCo5m6C36c6HoBfk5YAmqY0JpCgcLgZDO6G6rWp2Tl9L+ksuczZ5RDC366LhgmH4lyEXoRfMRzmEetYFZ2cMqicVoaAJpHoeftU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=SEqhHquW4h+W3ZGUJRoeqOLzABghx4858kofBptl81s=;
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
> These power rails must be on very early for the U-Boos TPL banner to be
> show over debug UART.
>
> This reverts commit 4576e65a5d6b10fd207c3a44061676ce0220d794.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index ba89079b1e73..0c28241c603e 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -136,7 +136,7 @@ void board_debug_uart_init(void)
>   	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
>   	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
>   
> -	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
> +	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
>   	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
>   	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
>   		rk_setreg(&grf->io_vsel, 1 << 0);
