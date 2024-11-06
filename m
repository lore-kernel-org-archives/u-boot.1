Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01874D44D42
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 845A588DB6;
	Wed,  6 Nov 2024 11:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DJ61b3kh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1167688FF6; Wed,  6 Nov 2024 11:17:19 +0100 (CET)
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com
 [103.129.254.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C8488009
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f7e40e1;
 Wed, 6 Nov 2024 18:17:11 +0800 (GMT+08:00)
Message-ID: <024be060-d55b-424d-8ee5-55e8ba12e140@rock-chips.com>
Date: Wed, 6 Nov 2024 18:17:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] board: rockchip: rk3288-tinker: Add myself as
 reviewer to MAINTAINERS
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMdTlZLShgZSUhKSUxCTR1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300fa6bce03afkunm1f7e40e1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6TQw4QjIaLDERCR0aCyMw
 PQkaCwlVSlVKTEhLQ0NDSUhJTElDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSk9PNwY+
DKIM-Signature: a=rsa-sha256;
 b=DJ61b3khpnscGsIUPP0+xTXAbizRVmyZBj6gp2LZpPI5M24ZCoESeKPpOuqjxRftBd4ReMgZqB6rIJiIM7WGHVEJmT84Eq+EifonBKJtl0v07ccbuKMcfCxZqQEAXd7hib+Pt4L41Tc61GJjh2eV9Mwmni4K5oyLdWPlue3x3qE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=uVE7L172szXOykcC/OTchR2sm1/FrsKd6OXEHqhUMHs=;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> Add myself as a reviewer for Tinker Board and S variant so that I can
> help with review and testing of defconfig and device tree changes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/rockchip/tinker_rk3288/MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/rockchip/tinker_rk3288/MAINTAINERS b/board/rockchip/tinker_rk3288/MAINTAINERS
> index 3869d5dc8534..a5cae55d4286 100644
> --- a/board/rockchip/tinker_rk3288/MAINTAINERS
> +++ b/board/rockchip/tinker_rk3288/MAINTAINERS
> @@ -1,5 +1,6 @@
>   TINKER-RK3288
>   M:	Lin Huang <hl@rock-chips.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	arch/arm/dts/rk3288-tinker.dts
>   F:	arch/arm/dts/rk3288-tinker.dtsi
> @@ -12,6 +13,7 @@ F:	configs/tinker-rk3288_defconfig
>   
>   TINKER-S-RK3288
>   M:	Michael Trimarchi <michael@amarulasolutions.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	board/rockchip/tinker_rk3288
>   F:	include/configs/tinker_rk3288.h
