Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA2EC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4ED87F06;
	Mon, 11 Mar 2024 10:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Il4rBavS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158B187F0F; Mon, 11 Mar 2024 10:22:39 +0100 (CET)
Received: from mail-m127205.xmail.ntesmail.com
 (mail-m127205.xmail.ntesmail.com [115.236.127.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578FB87E13
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Il4rBavS+Rvvv+5giOlUoRbM6tL2ahGPS6jRcKUhPLVgfNNK6ZW75EE+5qCVTlhep3nm+Y0t3brj5aFZ2Mq/UM2XgWcHJHb36dieFEMjpXdQ62dF1UMEjZ7SMBHkd5Ou8MujOAia+2v/uIpM2EmbYZ9F6INWkxJwvX48xW4jsVU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=maODJbJ4IfcheGVlwQ0J+ltm/SRi01hbb7QmajncWfI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BB912900419;
 Mon, 11 Mar 2024 17:22:28 +0800 (CST)
Message-ID: <6093465b-080d-43b0-8f73-2b0393c387e4@rock-chips.com>
Date: Mon, 11 Mar 2024 17:22:28 +0800
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
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlNSlYdGkIdShhPHUMYHxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cd2152003a9kunmbb912900419
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46LCo4HTMOFjAuLUtIKxwu
 KTYwFDVVSlVKTEpLSk9DQk9CTExCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
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
