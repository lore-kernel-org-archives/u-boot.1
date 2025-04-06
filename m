Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B5EC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F067A82B7C;
	Sun,  6 Apr 2025 17:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GYM1qtFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6B482A96; Sun,  6 Apr 2025 17:33:37 +0200 (CEST)
Received: from mail-m1973194.qiye.163.com (mail-m1973194.qiye.163.com
 [220.197.31.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3CF82BB4
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680ce;
 Sun, 6 Apr 2025 23:33:29 +0800 (GMT+08:00)
Message-ID: <d89e540a-154a-4e94-96fa-6a8934d8ba57@rock-chips.com>
Date: Sun, 6 Apr 2025 23:33:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] rockchip: binman: Use the FIT template in the
 SPI image
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk5DVkpNSBlNTxofT08aGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbc41be03afkunm10d0680ce
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6Ahw*HDJJIUkeCT0IPBQN
 ET4KCiNVSlVKTE9IQk5ITUpLSU5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJSUhCNwY+
DKIM-Signature: a=rsa-sha256;
 b=GYM1qtFvtyGf9CjgENgPRNUlFdKlRk9KrJuBk0fVV/1RZ/Ib/i6ewcLvGMHmqjcS97EgQHNe/iF576I7cgwyVARnhhAS5VxA0e4ECKJlDKxJlwMx1GvvWASX3330vehkhjxjVsl/N53Xsm6ok1o77ZXdG9YsAtgFjMTMlColhqs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=OFt/8TNCPchDkoUPpdH6iy9x/OhANLqBOvMRSgA3pZM=;
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


On 2025/3/29 23:06, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
>
> At present simple-bin-spi relies on the u-boot.itb file created by the
> simple-bin image. Use the template to avoid this, since Binman may
> change to process images in parallel in the future.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Drop filename for the SPI FIT
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>
> Changes in v3:
> - Keep the filename for the SPI FIT
>
> This is an alternative for the issue reported and fixed in [1] and [2].
>
> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> [2] https://lore.kernel.org/u-boot/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de/
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index f860bfc1ba72..73149b2d8bdd 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -207,8 +207,7 @@
>   
>   #ifdef HAS_FIT
>   		fit {
> -			type = "blob";
> -			filename = "u-boot.itb";
> +			insert-template = <&fit_template>;
>   #else
>   		u-boot-img {
>   #endif
