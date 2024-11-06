Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE02D44D43
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC908891CF;
	Wed,  6 Nov 2024 11:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Z5IPK+8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28640891E0; Wed,  6 Nov 2024 11:17:25 +0100 (CET)
Received: from mail-m10145.netease.com (mail-m10145.netease.com
 [154.81.10.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE68D88009
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f7e4104;
 Wed, 6 Nov 2024 18:17:19 +0800 (GMT+08:00)
Message-ID: <7f529cf0-3e4b-4fa1-8aa9-a39cad307fa2@rock-chips.com>
Date: Wed, 6 Nov 2024 18:17:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] rockchip: rk3288-tinker: Sort u-boot.dtsi nodes
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4aHVYeTRofQ0MYS0NIGUtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300fa88da03afkunm1f7e4104
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Qio6STIiQzEDNx0NCyEv
 H1ZPCRNVSlVKTEhLQ0NDSU9LSE1LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0xJNwY+
DKIM-Signature: a=rsa-sha256;
 b=Z5IPK+8hXd09EuNQYlKEKoHN/ZUZ+tPGM3ySStWTzZc4y4LI7QcU+tnpGb7pCg9+13v2ZvysZSF6uxKaU6pA2kHnocvNBikPkoTVlf7Vsh1IdiSdnUSyZaqyDOX+H3jwG2OGBxB5RXJAlt0R/hFno+7dgdGsiuvQgcz/zXlKys4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=YknYLXI1VmqNVhYKqdD2JPeOetsgNEwP4UnxOr/5ATI=;
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
> Sort the nodes in rk3288-tinker u-boot.dtsi files in alphabetical order.
>
> This has no intended change to board DTs and only rearrange nodes in
> preparation for future changes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-tinker-s-u-boot.dtsi |  8 ++---
>   arch/arm/dts/rk3288-tinker-u-boot.dtsi   | 44 ++++++++++++------------
>   2 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
> index b4c5483146ab..a782f2f9804a 100644
> --- a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
> @@ -17,18 +17,18 @@
>   	bootph-pre-ram;
>   };
>   
> -&emmc_clk {
> +&emmc_bus8 {
>   	bootph-pre-ram;
>   };
>   
> -&emmc_cmd {
> +&emmc_clk {
>   	bootph-pre-ram;
>   };
>   
> -&emmc_pwr {
> +&emmc_cmd {
>   	bootph-pre-ram;
>   };
>   
> -&emmc_bus8 {
> +&emmc_pwr {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> index 0cf1b696d168..032dac221c24 100644
> --- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> @@ -17,6 +17,10 @@
>   	rockchip,sdram-params = <0x20d266a4 0x5b6 2 533000000 6 9 0>;
>   };
>   
> +&gpio7 {
> +	bootph-pre-ram;
> +};
> +
>   &i2c2 {
>   	m24c08@50 {
>   		compatible = "at,24c08", "i2c-eeprom";
> @@ -24,31 +28,15 @@
>   	};
>   };
>   
> -&pinctrl {
> -	bootph-all;
> -};
> -
> -&uart2 {
> -	bootph-all;
> -};
> -
> -&uart2_xfer {
> -	bootph-all;
> -};
> -
> -&sdmmc {
> -	bootph-pre-ram;
> -};
> -
> -&gpio7 {
> +&pcfg_pull_none {
>   	bootph-pre-ram;
>   };
>   
> -&vcc_sd {
> +&pcfg_pull_none_drv_8ma {
>   	bootph-pre-ram;
>   };
>   
> -&pcfg_pull_none_drv_8ma {
> +&pcfg_pull_up {
>   	bootph-pre-ram;
>   };
>   
> @@ -56,11 +44,11 @@
>   	bootph-pre-ram;
>   };
>   
> -&pcfg_pull_none {
> -	bootph-pre-ram;
> +&pinctrl {
> +	bootph-all;
>   };
>   
> -&pcfg_pull_up {
> +&sdmmc {
>   	bootph-pre-ram;
>   };
>   
> @@ -83,3 +71,15 @@
>   &sdmmc_pwr {
>   	bootph-pre-ram;
>   };
> +
> +&uart2 {
> +	bootph-all;
> +};
> +
> +&uart2_xfer {
> +	bootph-all;
> +};
> +
> +&vcc_sd {
> +	bootph-pre-ram;
> +};
