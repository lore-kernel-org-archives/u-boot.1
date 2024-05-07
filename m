Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F232FC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832478872F;
	Tue,  7 May 2024 09:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YRTjA+Lm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943B688746; Tue,  7 May 2024 09:41:21 +0200 (CEST)
Received: from mail-m92251.xmail.ntesmail.com (mail-m92251.xmail.ntesmail.com
 [103.126.92.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB43F8872B
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YRTjA+LmVcCWSCc/t3KTueI4wzdiwDLBAnYcsb1Nd/vxEYRT7UXeOtck5Jvsy4MGzcgInz8+S71dLS1jIz/szMNFaAXklTkbRP7Lq+3u6xDVmxWZnSRuwSnd6/L8vuEhRmDsCiu7rOdat1NRJS2RmmL+xVXRFq3NnYwgBXSQx8I=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=lAe2eY3gzzhP+i+2XK7XL6Zl8TDCk6tNwwla/U37gJs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C56C7900350;
 Tue,  7 May 2024 15:41:03 +0800 (CST)
Message-ID: <7e4d2395-ae36-4bf1-86e9-bdb495654b16@rock-chips.com>
Date: Tue, 7 May 2024 15:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 111/149] board: rockchip: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: huang lin <hl@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andy.yan@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-111-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240501024316.1767971-111-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05DSVZOTRodGkxNSk5DHkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f51ffb71903a9kunmc56c7900350
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6ARw5SjNMFAtISgIYIgor
 TEwKCgpVSlVKTEpOS01MTU1PTU9OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSktPNwY+
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


On 2024/5/1 10:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: huang lin <hl@rock-chips.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   arch/arm/include/asm/arch-rockchip/grf_rk3308.h | 2 ++
>   board/rockchip/evb_rk3036/evb_rk3036.c          | 1 -
>   board/rockchip/evb_rk3308/evb_rk3308.c          | 1 -
>   board/rockchip/evb_rv1108/evb_rv1108.c          | 1 -
>   board/rockchip/kylin_rk3036/kylin_rk3036.c      | 1 -
>   board/rockchip/tinker_rk3288/tinker-rk3288.c    | 1 -
>   6 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3308.h b/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
> index a995bb950d97..f4bbc2401310 100644
> --- a/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
> +++ b/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
> @@ -5,6 +5,8 @@
>   #ifndef _ASM_ARCH_GRF_rk3308_H
>   #define _ASM_ARCH_GRF_rk3308_H
>   
> +#include <linux/kernel.h>
> +
>   struct rk3308_grf {
>   	unsigned int gpio0a_iomux;
>   	unsigned int reserved0;
> diff --git a/board/rockchip/evb_rk3036/evb_rk3036.c b/board/rockchip/evb_rk3036/evb_rk3036.c
> index 8c606463e455..a0805030ea46 100644
> --- a/board/rockchip/evb_rk3036/evb_rk3036.c
> +++ b/board/rockchip/evb_rk3036/evb_rk3036.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2015 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/uart.h>
> diff --git a/board/rockchip/evb_rk3308/evb_rk3308.c b/board/rockchip/evb_rk3308/evb_rk3308.c
> index e0c96fd70a28..c895da934a99 100644
> --- a/board/rockchip/evb_rk3308/evb_rk3308.c
> +++ b/board/rockchip/evb_rk3308/evb_rk3308.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2018 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <adc.h>
>   #include <asm/global_data.h>
>   
> diff --git a/board/rockchip/evb_rv1108/evb_rv1108.c b/board/rockchip/evb_rv1108/evb_rv1108.c
> index 0d7a486bed74..48b9d8f80c4b 100644
> --- a/board/rockchip/evb_rv1108/evb_rv1108.c
> +++ b/board/rockchip/evb_rv1108/evb_rv1108.c
> @@ -4,7 +4,6 @@
>    * Authors: Andy Yan <andy.yan@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <syscon.h>
>   #include <asm/global_data.h>
> diff --git a/board/rockchip/kylin_rk3036/kylin_rk3036.c b/board/rockchip/kylin_rk3036/kylin_rk3036.c
> index 0ca91cdeb014..c452b131208d 100644
> --- a/board/rockchip/kylin_rk3036/kylin_rk3036.c
> +++ b/board/rockchip/kylin_rk3036/kylin_rk3036.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2015 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <init.h>
> diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> index e6e75981c2d1..e966e9f201ab 100644
> --- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
> +++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <i2c_eeprom.h>
