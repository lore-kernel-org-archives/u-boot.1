Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86303C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01B18880F;
	Tue, 16 Jul 2024 04:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ADhH5Ag3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4388890F; Tue, 16 Jul 2024 04:28:40 +0200 (CEST)
Received: from mail-m49201.qiye.163.com (mail-m49201.qiye.163.com
 [45.254.49.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BF488755
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ADhH5Ag3oF/u3+Fc52A7V1xahFYftIlWBsHVTAYRnzJhxV9o4I9x5MzVIktL1OPcpaefE0xrl4xVOtFRdrrTBHjPdObMybgDbmgntZwHY1iYYwz2sDP3pA9lcQIpBPk5JTTASTFt5z1s/rK9i9huZ/BBGkqn5Pol0DfP/jA6DMM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=NtqeaH0n9w7/8H3iuU6TP9WG+a3iovTWBZfgU12yRNo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 521969001FB;
 Tue, 16 Jul 2024 10:28:25 +0800 (CST)
Message-ID: <91a7502e-2b9d-4692-b1b0-5cbb506d00f2@rock-chips.com>
Date: Tue, 16 Jul 2024 10:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/23] rockchip: RK3328: Read the reset cause from
 clock reset unit for RK3328 SoC
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-2-linux.amoon@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240531141837.13189-2-linux.amoon@gmail.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlCSlZKQkwaHxhIShoZH0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b95ea40403a9kunm521969001fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6HCo6MTI1LhgOTVFMHwI8
 Py4KFCxVSlVKTElKS0JNQktNSk1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTk9PNwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Anand,

On 2024/5/31 22:18, Anand Moon wrote:
> From: Anand Moon<anand@edgeble.ai>
>
> Read the reset cause from clock reset unit for RK3328 SoC.
>
> Cc: Jagan Teki<jagan@edgeble.ai>
> Signed-off-by: Anand Moon<anand@edgeble.ai>
> Signed-off-by: Anand Moon<linux.amoon@gmail.com>
I thing one signature is enough for you, right?
> ---
>   arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
>   arch/arm/mach-rockchip/cpu-info.c        | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
> index 9778790f34..a1499e9652 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -13,6 +13,8 @@
>   
>   #if defined(CONFIG_ROCKCHIP_RK3288)
>   # include <asm/arch-rockchip/cru_rk3288.h>
> +#elif defined(CONFIG_ROCKCHIP_RK3328)
> +#include <asm/arch-rockchip/cru_rk3328.h>
>   #elif defined(CONFIG_ROCKCHIP_RK3399)
>   # include <asm/arch-rockchip/cru_rk3399.h>
>   #elif defined(CONFIG_ROCKCHIP_RK3568)
> diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
> index a62ff53c6a..86b0c02970 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -14,7 +14,9 @@
>   
>   char *get_reset_cause(void)
>   {
> -	struct rockchip_cru *cru = rockchip_get_cru();
> +#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
> +	struct rk3328_cru *cru = rockchip_get_cru();
> +#endif

I think we can use "rockchip_cru" for all the SoC with below define in 
cru_rk3568.h?

#define rockchip_cru rk3328_cru


Thanks,
- Kever
>   	char *cause = NULL;
>   
>   	if (IS_ERR(cru))
