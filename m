Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F297AE77198
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 09:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A74080381;
	Fri,  3 Jan 2025 10:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fzdWZCzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E12D80384; Fri,  3 Jan 2025 10:25:46 +0100 (CET)
Received: from mail-m118220.qiye.163.com (mail-m118220.qiye.163.com
 [115.236.118.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A41A6801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 10:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79d1fb04;
 Fri, 3 Jan 2025 17:25:38 +0800 (GMT+08:00)
Message-ID: <e87b8d00-cf21-467f-9682-a20ff2812c35@rock-chips.com>
Date: Fri, 3 Jan 2025 17:25:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 07/12] rockchip: rk3399: Drop common Kconfig options
 already implied
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-8-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241212235735.164272-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk8ZVh1OS05OHUkdHxkaHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a942b7c11ca03afkunm79d1fb04
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Ogw6GjIPOSwiDTZKDwkR
 Ni1PC0xVSlVKTEhOQ0JNSE9LTktCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpIQ0I3Bg++
DKIM-Signature: a=rsa-sha256;
 b=fzdWZCzNYC6ldeEFy8frfE7pTbXiAr6zE8WUgmQKT07gRlTgntfffvcFWU6mt621HLBtcYKssrJVC/blVSbf3fmdVXzRre1p9HMZRfpotrrV+/hlPENpxdfylc8sXBlJK51PVd3kGf39AlFI3sDpDbBNumC6Sf4tCvL1fH4Wwak=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=lzlOJee87rjm2LsR3YpxJmBmlY6QvfOW7iIiobu3vaQ=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> The last two RK3399 boards, chromebook bob and kevin, have now migraded
> to use common bss and stack addresses.
>
> Cleanup and remove Kconfig options no longer needed in rk3399/Kconfig
> when all boards now use common bss and stack addresses.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3399/Kconfig | 12 ------------
>   1 file changed, 12 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index 04a84e2f6a04..500cfcd87afd 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -146,15 +146,6 @@ config SYS_SOC
>   config ROCKCHIP_COMMON_STACK_ADDR
>   	default y
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x4000 if !SPL_SHARES_INIT_SP_ADDR
> -
> -config SPL_LIBCOMMON_SUPPORT
> -	default y
> -
> -config SPL_LIBGENERIC_SUPPORT
> -	default y
> -
>   config TPL_LDSCRIPT
>   	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
>   
> @@ -164,9 +155,6 @@ config TPL_STACK
>   config TPL_TEXT_BASE
>           default 0xff8c2000
>   
> -config SPL_STACK_R_ADDR
> -	default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR
> -
>   if BOOTCOUNT_LIMIT
>   
>   config BOOTCOUNT_BOOTLIMIT
