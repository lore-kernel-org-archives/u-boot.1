Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AB5C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754CC88383;
	Mon, 22 Apr 2024 10:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="crjVkPrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827488838E; Mon, 22 Apr 2024 10:10:22 +0200 (CEST)
Received: from mail-m49240.qiye.163.com (mail-m49240.qiye.163.com
 [45.254.49.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E8E88372
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=crjVkPrA877jvnVW1Hl//5ZXoXBCJONCUDzWoB0BLstW8gYv/nIAeWP5ntL3LIJpggqKZlDM3XnVv0q7HJi1VzksvcOi3Xm0ppkfKm2Os7QLad2s6/iIDNhi+OxlN42fyJqMT1CmsS7YakJqgWjwRvboKexbFvvAgi5y2LvUs68=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=vms3i9KmPflRpzk+EgRACkKrzvlHH3iG32TyXYIXoyQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F2FB390028A;
 Mon, 22 Apr 2024 16:10:12 +0800 (CST)
Message-ID: <8855be4e-12ef-4ee7-bb4f-7e613d0ef773@rock-chips.com>
Date: Mon, 22 Apr 2024 16:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/28] rockchip: rk356x-generic: Fix eMMC and SD-card
 pinctrl
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-24-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-24-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hMGlZOGktOSUJOTx1JQ0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04db04a503a9kunmf2fb390028a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46PSo*OTMMCDoTGBk0GRkL
 K1EKCUxVSlVKTEpITExIT0pIQkNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkhCNwY+
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


On 2024/4/22 14:29, Jonas Karlman wrote:
> Add missing emmc_datastrobe and sdmmc0_det pinctrl to fix possible issue
> reading from eMMC or SD-card. Also use correct node for mmc1 alias.
>
> Fixes: 683f61a13f16 ("rockchip: board: Add minimal generic RK3566/RK3568 board")
> Fixes: 363cbd578169 ("rockchip: rk3568-generic: Enable eMMC HS200 mode")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: Split patch
> ---
>   arch/arm/dts/rk3568-generic.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
> index 88eb1bfd2aab..3b9bf8052046 100644
> --- a/arch/arm/dts/rk3568-generic.dts
> +++ b/arch/arm/dts/rk3568-generic.dts
> @@ -12,7 +12,7 @@
>   
>   	aliases {
>   		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> +		mmc1 = &sdmmc0;
>   	};
>   
>   	chosen {
> @@ -28,7 +28,7 @@
>   	no-sdio;
>   	non-removable;
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   	status = "okay";
>   };
>   
> @@ -39,7 +39,7 @@
>   	no-mmc;
>   	no-sdio;
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
>   	status = "okay";
>   };
>   
