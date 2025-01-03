Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FE4E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F086A80107;
	Fri,  3 Jan 2025 07:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P8rjcajq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D321180196; Fri,  3 Jan 2025 07:41:18 +0100 (CET)
Received: from mail-m12742.qiye.163.com (mail-m12742.qiye.163.com
 [115.236.127.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BDD800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79758901;
 Fri, 3 Jan 2025 14:41:11 +0800 (GMT+08:00)
Message-ID: <22d295f3-f357-44e0-9695-f1933d450a8a@rock-chips.com>
Date: Fri, 3 Jan 2025 14:41:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] rockchip: rk3288-firefly: Include sdmmc regulator
 in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlCHlYZHk8dQ0tCHx9KSUtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae5839203afkunm79758901
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6Mhw6SDIIFywLOi4JIikC
 DzoKChdVSlVKTEhOQ0NNT0xISk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSkJJNwY+
DKIM-Signature: a=rsa-sha256;
 b=P8rjcajqWSuhVJj1tSl+4kqvWYvKM7+5PL64r0Gzk3sbF40ANYu41OPrmnGt9bJTjERNvMBVhydxkz8zNjBIz/0jelVZqhl2Z8+zUN0VETQBEospMACg0zVKGHajf5+Ri95PHIoKJDEAyaN3JmdcLg4ds9bVoGYvZjsYBoKehsg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=GYNZQRx7y3XPfz8mzKM4PHrptWIsz56CH83t6bZ424g=;
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
> Add bootph props and enable related Kconfig options to include the sdmmc
> regulator in SPL. Also enable SPL_DM_SEQ_ALIAS to ensure aliases is
> handled correctly in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-firefly-u-boot.dtsi | 5 +++++
>   configs/firefly-rk3288_defconfig        | 4 +++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> index 435a02acea5d..f953f6821326 100644
> --- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> @@ -52,6 +52,7 @@
>   
>   &gpio7 {
>   	/delete-property/ bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &pcfg_pull_none {
> @@ -109,3 +110,7 @@
>   	bootph-pre-sram;
>   	bootph-pre-ram;
>   };
> +
> +&vcc_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index 862a17c84e07..2160474fe0f3 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -4,6 +4,7 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
>   CONFIG_SYS_ARCH_TIMER=y
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3288-firefly"
> @@ -41,6 +42,7 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
> @@ -62,10 +64,10 @@ CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
> -# CONFIG_SPL_PMIC_CHILDREN is not set
>   CONFIG_PMIC_ACT8846=y
>   CONFIG_REGULATOR_ACT8846=y
>   CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM=y
>   CONFIG_SPL_RAM=y
