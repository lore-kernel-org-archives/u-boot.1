Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB7E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4852080196;
	Fri,  3 Jan 2025 07:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="J+1sJLk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F93801A0; Fri,  3 Jan 2025 07:40:21 +0100 (CET)
Received: from mail-m11883.qiye.163.com (mail-m11883.qiye.163.com
 [115.236.118.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69001800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 797587b7;
 Fri, 3 Jan 2025 14:40:14 +0800 (GMT+08:00)
Message-ID: <11afe5e9-0199-4a6c-a486-64df7a114e39@rock-chips.com>
Date: Fri, 3 Jan 2025 14:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rockchip: rk3288-firefly: Include required DT nodes
 in xPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhKQlYfGkwYQxhDSE0eGElWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae4a20603afkunm797587b7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORA6Fzo4FTIOHywCOiMdIxUj
 ShIKCgFVSlVKTEhOQ0NNT0pOSEtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQk5LNwY+
DKIM-Signature: a=rsa-sha256;
 b=J+1sJLk3tx8iGRKy6bju8RGEy58Ybn/Q0pJQGK/0im6VdOX3kX6XrcsQg6oryQ8MHxedDIBx/Lg3BVRA0Dd9VnA/8PlPgjeuUDJhSGf4mDAPtqA/MlBajbG+viANsI9NB91EMWdMxkrVs5DqYU5tMh/hLclZSPjQzArXF3RzYoU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=MFRfsgtfXbzOlX9h1KkE8fSifxtDNOop/wqHbyFQs3Q=;
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


On 2024/12/13 06:09, Jonas Karlman wrote:
> Add bootph- props to emmc, sdmmc, uart and related pinctrl nodes to
> ensure devices and pinctrl can be used in xPL and U-Boot pre-reloc.
>
> Remove the explicit bootph-all prop from the pinctrl node, any bootph-
> prop will automatically be propagated to the pinctrl node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-firefly-u-boot.dtsi | 55 ++++++++++++++++++++++---
>   configs/firefly-rk3288_defconfig        |  2 +-
>   2 files changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> index 8870188e6129..435a02acea5d 100644
> --- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> @@ -26,35 +26,75 @@
>   };
>   
>   &emmc {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_bus8 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
> -&gpio3 {
> +&emmc_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_pwr {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gpio7 {
> +	/delete-property/ bootph-all;
> +};
> +
> +&pcfg_pull_none {
>   	bootph-all;
>   };
>   
> -&pcfg_pull_up_drv_12ma {
> +&pcfg_pull_none_12ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
> -&pinctrl {
> +&pcfg_pull_up {
>   	bootph-all;
>   };
>   
> +&pcfg_pull_up_drv_12ma {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &sdmmc {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_bus4 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc_cd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_cmd {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_pwr {
> @@ -64,3 +104,8 @@
>   &uart2 {
>   	bootph-all;
>   };
> +
> +&uart2_xfer {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index 87ed0c0d2aea..862a17c84e07 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -38,7 +38,7 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_REGMAP=y
