Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35DF88389;
	Mon, 22 Apr 2024 10:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OQ1nx7OX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C62D88388; Mon, 22 Apr 2024 10:01:47 +0200 (CEST)
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com
 [101.71.155.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D788831B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OQ1nx7OXbA3fELY16i1PJkH3FWUPAxYIVUFB2lPBgIILfLgJY0PV6X1OelVogequpYPu595pJ+gnqAIqCy0BhMPve7mrNZN1nSHDfIkwT+Fjiv4QbC4E/cgYS8DjxDsWgbXRa45vs12VteL1F/RkYdFJdQw9ydPPI8s7lSoJYZ0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=wrbEJqHpTiv35feKTWrAHgOQsip4cdeqrEcw5Mt45fc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 04E069002E0;
 Mon, 22 Apr 2024 16:01:31 +0800 (CST)
Message-ID: <cdd5bac8-e5a3-4def-bf4c-1dfccd95eb43@rock-chips.com>
Date: Mon, 22 Apr 2024 16:01:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/28] rockchip: rk356x: Imply enhanced features for
 standard boot
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkodS1ZCGRoZTUMaH0JJQh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d3110903a9kunm04e069002e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6SQw4NDNWNjoWCQ00Mk0Z
 Hh8aCw1VSlVKTEpITExJQ0JJQ01OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0lONwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> Imply BOOTSTD_FULL for all RK356x boards to more closely follow RK3588.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Collect r-b tag
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig      | 1 +
>   configs/bpi-r2-pro-rk3568_defconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index ded749e92bdd..83779bd46208 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -306,6 +306,7 @@ config ROCKCHIP_RK3568
>   	select BOARD_LATE_INIT
>   	select DM_REGULATOR_FIXED
>   	select DM_RESET
> +	imply BOOTSTD_FULL
>   	imply DM_RNG
>   	imply MISC_INIT_R
>   	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
> index 5cc95241ba43..70837574462b 100644
> --- a/configs/bpi-r2-pro-rk3568_defconfig
> +++ b/configs/bpi-r2-pro-rk3568_defconfig
> @@ -15,7 +15,6 @@ CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> -CONFIG_BOOTSTD_FULL=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
