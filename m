Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34AD883D9;
	Mon, 22 Apr 2024 10:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gaa74n6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35892883D8; Mon, 22 Apr 2024 10:43:09 +0200 (CEST)
Received: from mail-m1973197.qiye.163.com (mail-m1973197.qiye.163.com
 [220.197.31.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B6F88379
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Gaa74n6iFyzY18s49eUJjb7XnuHPje559RukNHI936yy5UU0kHHZUuicu2CZzK7JLRRZNTXLhORGEoVfwJNn3wPZhj5673eKQiq1HnBHTFd9jnOdIvvBKwKm6aIYYYRKTd88nH4wjQrDLRipdn7EllXJD5kxzG2sKD1TOpvs+XU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=QFR+e0YNsP4fl2BhPLY558AFoIq6ATs47ofpujhNLRo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D5D5B90031E;
 Mon, 22 Apr 2024 16:42:54 +0800 (CST)
Message-ID: <681f3373-308e-4920-9dd5-514f6b1cce7b@rock-chips.com>
Date: Mon, 22 Apr 2024 16:42:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] board: rockchip: rk3308: Add device tree files
 and myself to MAINTAINERS
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9OQ1ZOSBlDHUlCQhpMTRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f8f39303a9kunmd5d5b90031e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6CSo*ATNPNjoBHSsKPBgV
 GRcKCz5VSlVKTEpITExOSExOTUhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUtNNwY+
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


On 2024/4/9 02:13, Jonas Karlman wrote:
> Update MAINTAINERS files for RK3308 boards to include related device
> tree files. Also add myself as a reviewer for the ROCK Pi S board.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   board/firefly/firefly-rk3308/MAINTAINERS | 1 +
>   board/rockchip/evb_rk3308/MAINTAINERS    | 5 +++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/board/firefly/firefly-rk3308/MAINTAINERS b/board/firefly/firefly-rk3308/MAINTAINERS
> index e584038a2033..b70ff52ea741 100644
> --- a/board/firefly/firefly-rk3308/MAINTAINERS
> +++ b/board/firefly/firefly-rk3308/MAINTAINERS
> @@ -4,3 +4,4 @@ S:      Maintained
>   F:      board/firefly/firefly-rk3308/
>   F:      configs/roc-cc-rk3308_defconfig
>   F:      include/configs/firefly_rk3308.h
> +F:      arch/arm/dts/rk3308-roc-cc*
> diff --git a/board/rockchip/evb_rk3308/MAINTAINERS b/board/rockchip/evb_rk3308/MAINTAINERS
> index fe2c5f004c34..abffbb1eb0ab 100644
> --- a/board/rockchip/evb_rk3308/MAINTAINERS
> +++ b/board/rockchip/evb_rk3308/MAINTAINERS
> @@ -4,10 +4,11 @@ S:      Maintained
>   F:      board/rockchip/evb_rk3308
>   F:      include/configs/evb_rk3308.h
>   F:      configs/evb-rk3308_defconfig
> +F:      arch/arm/dts/rk3308-evb*
>   
>   ROCK-PI-S
>   M:      Akash Gajjar <gajjar04akash@gmail.com>
> +R:      Jonas Karlman <jonas@kwiboo.se>
>   S:      Maintained
>   F:      configs/rock-pi-s-rk3308_defconfig
> -F:      arch/arm/dts/rk3308-rock-pi-s.dts
> -F:      arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> +F:      arch/arm/dts/rk3308-rock-pi-s*
