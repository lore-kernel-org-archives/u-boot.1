Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CADC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F3C830EE;
	Tue,  8 Apr 2025 05:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EkSt089i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDD8830EE; Tue,  8 Apr 2025 05:19:29 +0200 (CEST)
Received: from mail-m32104.qiye.163.com (mail-m32104.qiye.163.com
 [220.197.32.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809458318F
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e89f2;
 Tue, 8 Apr 2025 11:19:20 +0800 (GMT+08:00)
Message-ID: <d7e3b683-f848-4475-accb-4bfbe8cd9888@rock-chips.com>
Date: Tue, 8 Apr 2025 11:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rockchip: Ensure device settings is defined before
 rk3588_common.h
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Elon Zhang <zhangzj@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8ZSFYZSxodShlKHx1IH0NWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961368da4d03afkunm1101e89f2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6ESo4SjJCD0IRASkqHTQw
 I0swCUxVSlVKTE9PS0NJSE1JS09LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQklLNwY+
DKIM-Signature: a=rsa-sha256;
 b=EkSt089iRh7T6zJrIYURrJIGbR10l6iTTgHbDkYHPamZ1iQh5uoqxVJ4ijcXSt4O68H3eR83ygZowPCetkPsUH8N8QzuTBNa0YNcYlJaU3dNqqBgsv1hdDBUO/oRhULDLG3EHcVhon+4ZOloOgfFTBHF/73m95PkOSYjP8Eyzr4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=luwj+2u/IlZDhq2bjIQ8CS++Ab4Gsinv6fb+xpWexNE=;
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
> Ensure ROCKCHIP_DEVICE_SETTINGS is defined before including
> rk3588_common.h in board include/configs files.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/evb_rk3588.h           | 4 ++--
>   include/configs/khadas-edge2-rk3588s.h | 4 ++--
>   include/configs/toybrick_rk3588.h      | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/configs/evb_rk3588.h b/include/configs/evb_rk3588.h
> index 4568e2cace66..5ff1ddbfcbec 100644
> --- a/include/configs/evb_rk3588.h
> +++ b/include/configs/evb_rk3588.h
> @@ -6,10 +6,10 @@
>   #ifndef __EVB_RK3588_H
>   #define __EVB_RK3588_H
>   
> -#include <configs/rk3588_common.h>
> -
>   #define ROCKCHIP_DEVICE_SETTINGS \
>   		"stdout=serial,vidconsole\0" \
>   		"stderr=serial,vidconsole\0"
>   
> +#include <configs/rk3588_common.h>
> +
>   #endif
> diff --git a/include/configs/khadas-edge2-rk3588s.h b/include/configs/khadas-edge2-rk3588s.h
> index d279cf3826a9..fe8461d63626 100644
> --- a/include/configs/khadas-edge2-rk3588s.h
> +++ b/include/configs/khadas-edge2-rk3588s.h
> @@ -6,10 +6,10 @@
>   #ifndef __KHADAS_EDGE2_RK3588_H
>   #define __KHADAS_EDGE2_RK3588_H
>   
> -#include <configs/rk3588_common.h>
> -
>   #define ROCKCHIP_DEVICE_SETTINGS \
>   		"stdout=serial,vidconsole\0" \
>   		"stderr=serial,vidconsole\0"
>   
> +#include <configs/rk3588_common.h>
> +
>   #endif /* __KHADAS_EDGE2_RK3588_H */
> diff --git a/include/configs/toybrick_rk3588.h b/include/configs/toybrick_rk3588.h
> index faa2e6c19c3e..005650896760 100644
> --- a/include/configs/toybrick_rk3588.h
> +++ b/include/configs/toybrick_rk3588.h
> @@ -6,10 +6,10 @@
>   #ifndef __TOYBRICK_RK3588_H
>   #define __TOYBRICK_RK3588_H
>   
> -#include <configs/rk3588_common.h>
> -
>   #define ROCKCHIP_DEVICE_SETTINGS \
>   		"stdout=serial,vidconsole\0" \
>   		"stderr=serial,vidconsole\0"
>   
> +#include <configs/rk3588_common.h>
> +
>   #endif
