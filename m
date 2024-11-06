Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D18D44D46
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569D788D51;
	Wed,  6 Nov 2024 11:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gOozj8AJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F1688D8D; Wed,  6 Nov 2024 11:46:46 +0100 (CET)
Received: from mail-m127157.xmail.ntesmail.com
 (mail-m127157.xmail.ntesmail.com [115.236.127.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EEA88D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8a3d16;
 Wed, 6 Nov 2024 18:46:38 +0800 (GMT+08:00)
Message-ID: <2cfc8a9b-93cd-472a-9fe4-2043cb194abd@rock-chips.com>
Date: Wed, 6 Nov 2024 18:46:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] rockchip: rk3288-miqi: Fix slow Ethernet
 initializion
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJLT1ZKH05OTR0eHxoZGEtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93011561f403afkunm1f8a3d16
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Ghw*EjIYNDEjNlEtHA4T
 TSMaCSJVSlVKTEhLQ0NCQkJCQ0lJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTU5CNwY+
DKIM-Signature: a=rsa-sha256;
 b=gOozj8AJkZO7fNQhDr15ZLmjA0qcQ8b46qXg/QOkkyRh0s18LBHPoNtTZ3n8kXXrE6Lw+oQjdzM52betx4nrJ/9skkQUs2Rn1rCRsJ3/KprcDj1UP9JVgIvi0erTqMVDalfmFT5Pd0EblEE9fWcjM8fEc5NJYnfmcjk8j1yImsY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=GoVJeyK8tTiFfz5dYo9zyKG3O8BP5yOscdjA/aihQyw=;
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


On 2024/11/6 05:51, Jonas Karlman wrote:
> For some reason the Ethernet PHY reset delay is set to 1 second, this
> cause an unneccecery long boot delay.
>
> MiQi use RTL8211 Ethernet PHY, datasheet list an initial 10ms delay and
> then a 30-76ms delay before accessing registers.
>
> Change to use 80ms delay instead of a full second to speed up Ethernet
> initializion in U-Boot.
>
> Also enable PHY_REALTEK, DM_ETH_PHY and PHY_GIGE to improve Ethernet PHY
> support in U-Boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-miqi-u-boot.dtsi | 4 ++++
>   configs/miqi-rk3288_defconfig        | 3 +++
>   2 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> index 4361b35d6c8f..e5c7e761c46f 100644
> --- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> @@ -41,6 +41,10 @@
>   	bootph-some-ram;
>   };
>   
> +&gmac {
> +	snps,reset-delays-us = <0 10000 80000>;
> +};
> +
>   &gpio7 {
>   	/delete-property/ bootph-all;
>   	bootph-pre-ram;
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index ee9917149734..55e8d30f675f 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -55,6 +55,9 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PINCTRL=y
