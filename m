Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9418DE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A80380196;
	Fri,  3 Jan 2025 04:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NFIt7Sfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C36802EF; Fri,  3 Jan 2025 04:08:34 +0100 (CET)
Received: from mail-m127164.xmail.ntesmail.com
 (mail-m127164.xmail.ntesmail.com [115.236.127.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860FA80017
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 791518bb;
 Fri, 3 Jan 2025 11:08:24 +0800 (GMT+08:00)
Message-ID: <648afae5-670d-4260-ae00-81cf572aa7c5@rock-chips.com>
Date: Fri, 3 Jan 2025 11:08:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] dt-bindings: clock, reset: fix top-comment
 indentation rk3576 headers
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Stephen Boyd <sboyd@kernel.org>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-3-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241121142731.1202209-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4YQlZISk8dQkxCSkgaHx1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a22b41603afkunm791518bb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6UQw6CTIQOS0*AjEwMC84
 NjAwCUNVSlVKTEhOQ0xITEtMT05JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0tDNwY+
DKIM-Signature: a=rsa-sha256;
 b=NFIt7SfinCVrhYkNkMqoSh8qOlhTcYddsadJgBwEx+ZEAmM3WkuOeC3Yz8pPvY2WPZvlSAQkjyWc7iwNHfcZNqoP/qZx7j4wQvNtg9CiG2ut+It0uu2qY//wH0f0c4mnJIPqi/b5FXluobLXh5L85V4jc1cCW+oqvvdyvCjyOmg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=yV8apw3q6m+LqdShiZ75ppDdsT4XKIO7RpYYrzymyUI=;
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


On 2024/11/21 22:27, Heiko Stuebner wrote:
> Block comments should align the * on each line, as checkpatch rightfully
> pointed out, so fix that style issue on the newly added rk3576 headers.
>
> Fixes: 49c04453db81 ("dt-bindings: clock, reset: Add support for rk3576")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240909223149.85364-1-heiko@sntech.de
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>
> [ upstream commit: eb3b3f520518003cd363239fc160bdd7ed327319 ]
>
> (cherry picked from commit 92b03f0021dfe4686d84fb75d52a5b4203c000a5)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../include/dt-bindings/clock/rockchip,rk3576-cru.h  | 12 ++++++------
>   .../include/dt-bindings/reset/rockchip,rk3576-cru.h  | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h b/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
> index a2933021be8..25aed298ac2 100644
> --- a/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
> +++ b/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
> @@ -1,11 +1,11 @@
>   /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>   /*
> -* Copyright (c) 2023 Rockchip Electronics Co. Ltd.
> -* Copyright (c) 2024 Collabora Ltd.
> -*
> -* Author: Elaine Zhang <zhangqing@rock-chips.com>
> -* Author: Detlev Casanova <detlev.casanova@collabora.com>
> -*/
> + * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
> + * Copyright (c) 2024 Collabora Ltd.
> + *
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + * Author: Detlev Casanova <detlev.casanova@collabora.com>
> + */
>   
>   #ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
>   #define _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
> diff --git a/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h b/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
> index 291fec0ecba..ae856906f3a 100644
> --- a/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
> +++ b/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
> @@ -1,11 +1,11 @@
>   /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>   /*
> -* Copyright (c) 2023 Rockchip Electronics Co. Ltd.
> -* Copyright (c) 2024 Collabora Ltd.
> -*
> -* Author: Elaine Zhang <zhangqing@rock-chips.com>
> -* Author: Detlev Casanova <detlev.casanova@collabora.com>
> -*/
> + * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
> + * Copyright (c) 2024 Collabora Ltd.
> + *
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + * Author: Detlev Casanova <detlev.casanova@collabora.com>
> + */
>   
>   #ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
>   #define _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
