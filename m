Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCFD0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE1B892B8;
	Mon, 21 Oct 2024 10:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="U1xtRLNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8974892B9; Mon, 21 Oct 2024 10:17:38 +0200 (CEST)
Received: from mail-m24109.xmail.ntesmail.com (mail-m24109.xmail.ntesmail.com
 [45.195.24.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116F08897F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=U1xtRLNVWH3J0b5JAOKQgpZdOR4zwguCHcBZptqdoHRKf68UDgjCKlH8wntSDFFJtWoy4xityrCyaLKzqdX06pOboxHLappRf1mYVbqYyCO12x/0RA2lQUCtrPrXWoPSXrGkcZQVlvOC678s5PuYQ4jjHDIEzNsD72iUnt8ctEk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=OjgpwSQB65jxmmLZpSH8kYYRr3HjtOdBu1jLZfJ5TzI=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 3AD1C5206B4;
 Mon, 21 Oct 2024 16:17:14 +0800 (CST)
Message-ID: <b9408029-896d-4cb2-a537-787ac238552a@rock-chips.com>
Date: Mon, 21 Oct 2024 16:17:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: rockchip: fix dts for Radxa ROCK 4C+
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, jonas@kwiboo.se,
 Dragan Simic <dsimic@manjaro.org>
References: <20240815223713.2479-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240815223713.2479-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpDHVYdHUwYSE5CTBhIHRlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92ae26dcbf03afkunm3ad1c5206b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6EBw4IzIaOS5RKRM6FktO
 DBFPFCJVSlVKTElCT0JDTUhNSktCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lCNwY+
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


On 2024/8/16 06:37, FUKAUMI Naoki wrote:
> ROCK Pi 4 series and ROCK 4C+ cannot share .dtsi file because 4C+ is
> different board.
>
> add rk3399-rock-pi-4-u-boot.dtsi contents and remove dependency of it.
>
> no functional change is intended.
>
> Fixes: 71a95e2efd30 ("arm: dts: rockchip: add Radxa ROCK 4C+")
> Suggested-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - reword commit message
> ---
>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 5ec15a845c1..50dae5cb5ef 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -1,8 +1,10 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
> + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
>    * Copyright (c) 2023 Radxa Limited
>    */
> -#include "rk3399-rock-pi-4-u-boot.dtsi"
> +#include "rk3399-u-boot.dtsi"
> +#include "rk3399-sdram-lpddr4-100.dtsi"
>   
>   &pcfg_pull_none_18ma {
>   	bootph-pre-ram;
> @@ -14,6 +16,12 @@
>   	bootph-some-ram;
>   };
>   
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +};
> +
>   &spi1 {
>   	status = "okay";
>   
> @@ -25,3 +33,7 @@
>   		spi-max-frequency = <10000000>;
>   	};
>   };
> +
> +&vdd_log {
> +	regulator-init-microvolt = <950000>;
> +};
