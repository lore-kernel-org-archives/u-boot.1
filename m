Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67491C3ABC3
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 02:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19AA820EB;
	Thu,  8 May 2025 04:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="U7V8p10Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BEA98211F; Thu,  8 May 2025 04:44:33 +0200 (CEST)
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com
 [220.197.32.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF48B81FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 04:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.223] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14511c21e;
 Thu, 8 May 2025 10:44:24 +0800 (GMT+08:00)
Message-ID: <cbc27e24-5322-4742-bf70-d8ff83c66862@rock-chips.com>
Date: Thu, 8 May 2025 10:44:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rockchip: Move TEXT_BASE to 8 MiB offset from
 start of DRAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de
References: <20250405153832.1427549-1-jonas@kwiboo.se>
 <20250405153832.1427549-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250405153832.1427549-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5OQ1ZDS0gZTx0aT09KSk9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96adc7a45c03afkunm14511c21e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6Ehw6EjIMNwgMSgIeNQg9
 GUIwCRlVSlVKTE9NTUxJSU1OT0tJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0pPNwY+
DKIM-Signature: a=rsa-sha256;
 b=U7V8p10Z6qlI+ZYlRtbiMvSpRujxlmY1R+7qsSMY+saFoU1asKDU9s+2Syqiv2U6e3yLoQAbHDjcL2DlUAIQIFLVTX2YJi+kS2Mj7SVwCPkr/yxFw740iVYlPtG2u9dMNid/eyj2LkzE6RWpMEcZ6wTeCNfLQhrG4zu9oCzrB5Y=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=IRMSvBt4+R8px7nkuS4B1POi3R18VjDUPOhKMIpH/o8=;
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


On 2025/4/5 23:38, Jonas Karlman wrote:
> Drop SoC specific TEXT_BASE and use a common TEXT_BASE for all SoCs.
>
> Move the common TEXT_BASE to 8 MiB offset from start of DRAM to help
> support RAM boot from maskrom introduced in next patch.
>
> RAM boot from maskrom mode will expect the FIT payload to be located at
> 2 MiB offset from start or DRAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect t-b tag
> ---
>   arch/arm/mach-rockchip/Kconfig        | 6 +++---
>   arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
>   arch/arm/mach-rockchip/rk3568/Kconfig | 3 ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 3 ---
>   4 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 33a9f7a4dd4b..c9d8f9105083 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -667,9 +667,9 @@ config TPL_SYS_MALLOC_F_LEN
>   	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TEXT_BASE
> -	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
> -	default 0x40200000 if SPL_TEXT_BASE = 0x40000000
> -	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
> +	default 0x60800000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x40800000 if SPL_TEXT_BASE = 0x40000000
> +	default 0x00800000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_TEXT_BASE
>   	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
> diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
> index 06572d545f6e..b8d25c525424 100644
> --- a/arch/arm/mach-rockchip/rk3308/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3308/Kconfig
> @@ -17,9 +17,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3308"
>   
> -config TEXT_BASE
> -	default 0x00600000
> -
>   source "board/rockchip/evb_rk3308/Kconfig"
>   source "board/firefly/firefly-rk3308/Kconfig"
>   
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index c589fd586993..a271782fac5c 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -71,9 +71,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3568"
>   
> -config TEXT_BASE
> -	default 0x00a00000
> -
>   source "board/rockchip/evb_rk3568/Kconfig"
>   source "board/anbernic/rgxx3_rk3566/Kconfig"
>   source "board/hardkernel/odroid_m1/Kconfig"
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index efd192068ad1..1c6a85d07394 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -420,9 +420,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3588"
>   
> -config TEXT_BASE
> -	default 0x00a00000
> -
>   source "board/armsom/sige7-rk3588/Kconfig"
>   source "board/coolpi/genbook_cm5_rk3588/Kconfig"
>   source "board/edgeble/neural-compute-module-6/Kconfig"
