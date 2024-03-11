Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C18C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B60687EF2;
	Mon, 11 Mar 2024 10:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LUrAKuHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC80287EF2; Mon, 11 Mar 2024 10:22:26 +0100 (CET)
Received: from mail-m12778.qiye.163.com (mail-m12778.qiye.163.com
 [115.236.127.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF16987E13
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LUrAKuHebWAEaGYkrm1eziOPS25xGsnlILDx/0bdzBnbv5KGMjTiyZLDa8w+2QOld6aIVf+GxdRst5ZQ7RYezl7elEExNffgEvUGd3CnR5eb1YauICm5IKfc8i3vrAGKRE1iQ42wH0uw/kZi3NUFj6/Zg2r30WNmFIYXGlWsj4c=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=maODJbJ4IfcheGVlwQ0J+ltm/SRi01hbb7QmajncWfI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id B684F900369;
 Mon, 11 Mar 2024 17:22:08 +0800 (CST)
Message-ID: <9430dde2-581d-4595-89ca-5510011f822e@rock-chips.com>
Date: Mon, 11 Mar 2024 17:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] board: rockchip: rk3399: Add myself as reviewer to
 MAINTAINERS
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkaHVZDSB9OS0NLHUgfQxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cd1c6ac03a9kunmb684f900369
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6SSo4DjMLODBRF1YjKygY
 A0NPCzpVSlVKTEpLSk9DQklCTUJPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkhLNwY+
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


On 2024/2/18 02:35, Jonas Karlman wrote:
> Add myself as a reviewer for RK3399 boards that I have and can help with
> review and testing of defconfig and device tree changes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/pine64/pinebook-pro-rk3399/MAINTAINERS | 1 +
>   board/pine64/rockpro64_rk3399/MAINTAINERS    | 1 +
>   board/rockchip/evb_rk3399/MAINTAINERS        | 3 +++
>   3 files changed, 5 insertions(+)
>
> diff --git a/board/pine64/pinebook-pro-rk3399/MAINTAINERS b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
> index b80fc5cb6021..afd662600c69 100644
> --- a/board/pine64/pinebook-pro-rk3399/MAINTAINERS
> +++ b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
> @@ -1,5 +1,6 @@
>   PINEBOOK_PRO
>   M:	Peter Robinson <pbrobinson@gmail.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	board/pine64/pinebook-pro-rk3399/
>   F:	include/configs/pinebook-pro-rk3399.h
> diff --git a/board/pine64/rockpro64_rk3399/MAINTAINERS b/board/pine64/rockpro64_rk3399/MAINTAINERS
> index 396363cc8d9b..bb4335ae5b73 100644
> --- a/board/pine64/rockpro64_rk3399/MAINTAINERS
> +++ b/board/pine64/rockpro64_rk3399/MAINTAINERS
> @@ -1,5 +1,6 @@
>   ROCKPRO64
>   M:	Jagan Teki <jagan@amarulasolutions.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	board/pine64/rockpro64_rk3399
>   F:	include/configs/rockpro64_rk3399.h
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index 166e01bcc685..fa1f320f5a00 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -97,6 +97,7 @@ F:	arch/arm/dts/rk3399-orangepi-u-boot.dtsi
>   
>   ROCK-4C+
>   M:	FUKAUMI Naoki <naoki@radxa.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	configs/rock-4c-plus-rk3399_defconfig
>   F:	arch/arm/dts/rk3399-rock-4c-plus.dts
> @@ -104,6 +105,7 @@ F:	arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
>   
>   ROCK-4SE
>   M:	Christopher Obbard <chris.obbard@collabora.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	configs/rock-4se-rk3399_defconfig
>   F:	arch/arm/dts/rk3399-rock-4se.dts
> @@ -111,6 +113,7 @@ F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
>   
>   ROCK-PI-4
>   M:	Jagan Teki <jagan@amarulasolutions.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	configs/rock-pi-4-rk3399_defconfig
>   F:	arch/arm/dts/rk3399-rock-pi-4.dtsi
