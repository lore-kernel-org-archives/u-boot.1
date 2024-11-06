Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60256D44D43
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4549891EA;
	Wed,  6 Nov 2024 11:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="V6Q28Cis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0392F891F4; Wed,  6 Nov 2024 11:22:49 +0100 (CET)
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com
 [103.129.254.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961A8891CF
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f801212;
 Wed, 6 Nov 2024 18:22:43 +0800 (GMT+08:00)
Message-ID: <ae0b4b42-30b3-4a0a-8248-0f74b1774aa4@rock-chips.com>
Date: Wed, 6 Nov 2024 18:22:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] rockchip: rk3288-tinker: Fix slow Ethernet
 initializion
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-13-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlJSlZDT0hOGR9JHxhKQ0pWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300ff7ac903afkunm1f801212
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6OSo5MTIfFjEdCQ89TEhJ
 Ty4KCgpVSlVKTEhLQ0NDTk1PT0pKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTExKNwY+
DKIM-Signature: a=rsa-sha256;
 b=V6Q28CisH4SglZCjkKHa6M3AUVbJR+sQ5nHriRY3hUZTcU8Zhe/tH+i3vKfEUfRB/gPcQzXS2uG/q87nXIEYeiATUxxiOH+1foNshIHuZsEHQos3vOK0f8BG8jg6ElGJlLx4kQuzm/6SS8KxhKJvVcFo86sjYd0xetVdBoG934U=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=+WybQ6gaoQ/QFdGWP3ixdgjOw2TigPDDPy5tVrtJXjs=;
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
> For some reason the Ethernet PHY reset delay is set to 1 second, this
> cause an unneccecery long boot delay.
>
> Tinker Board use RTL8211E or RTL8211F Ethernet PHY, datasheet list an
> initial 10ms delay and then a 30-76ms delay before accessing registers.
>
> Change to use 80ms delay instead of a full second to speed up Ethernet
> initializion in U-Boot.
>
> Also enable PHY_REALTEK, DM_ETH_PHY and PHY_GIGE to improve Ethernet PHY
> support in U-Boot.
>
> Before:
>
>    1,404,971    960,924  eth_common_init
>    2,438,830  1,033,859  eth_initialize
>    2,444,449      5,619  main_loop
>    2,445,153        704  cli_loop
>
> After:
>
>    1,404,987    960,710  eth_common_init
>    1,519,110    114,123  eth_initialize
>    1,524,734      5,624  main_loop
>    1,525,452        718  cli_loop
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> There are more boards having similar full second delay and a fix will be
> sent to upstream Linux to correct this in due time.
> ---
>   arch/arm/dts/rk3288-tinker-u-boot.dtsi | 4 ++++
>   configs/tinker-rk3288_defconfig        | 3 +++
>   configs/tinker-s-rk3288_defconfig      | 3 +++
>   3 files changed, 10 insertions(+)
>
> diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> index 7568b1495341..a6f6f14df93d 100644
> --- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> @@ -16,6 +16,10 @@
>   	rockchip,sdram-params = <0x20d266a4 0x5b6 2 533000000 6 9 0>;
>   };
>   
> +&gmac {
> +	snps,reset-delays-us = <0 10000 80000>;
> +};
> +
>   &gpio7 {
>   	/delete-property/ bootph-all;
>   };
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index b7636fe581f4..05dca105d609 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -58,6 +58,9 @@ CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PINCTRL=y
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index e50424746c81..1bee0d094c8d 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -58,6 +58,9 @@ CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PINCTRL=y
