Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB4D44D42
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374BF88DB6;
	Wed,  6 Nov 2024 11:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BNUORdZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB4E8919A; Wed,  6 Nov 2024 11:18:01 +0100 (CET)
Received: from mail-m1017.netease.com (mail-m1017.netease.com [154.81.10.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 261AA88009
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f7e4162;
 Wed, 6 Nov 2024 18:17:55 +0800 (GMT+08:00)
Message-ID: <ff70ffcc-d638-4761-a383-cfa3b933f911@rock-chips.com>
Date: Wed, 6 Nov 2024 18:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] rockchip: rk3288-tinker: Only include required DT
 nodes in TPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05PGlZMT0tPTUlPQhhMQkxWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300fb182503afkunm1f7e4162
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6Lgw5GjIqSzFNGR0dCwka
 KAoaFC5VSlVKTEhLQ0NDSUxNQ09LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0lPNwY+
DKIM-Signature: a=rsa-sha256;
 b=BNUORdZuUddxUVnoZw89yIyewv0y9MqnjUqZ56/ty1rfxfZWliz+M8kd8WU/D6aJOT4VXBo+7k5mQrmBLsSddpGFnV3tYmstBAKP3UuEZLxaVloUH2lk0CRh7tabjfWXehQtclxrBLiJrnSro4YRZB5fMz1EwkFi31xJLWXkD/A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=up5a4eWPTCtigplhkpL/rJv4ZGoZjOLwEiqjUJ+jYGo=;
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
> Drop the unneeded bootph-all prop from dmc node, it is already defined
> in soc u-boot.dtsi.
>
> Remove booth-all prop from gpio7 node, this node is not needed in TPL.
>
> Adjust bootph props to include pinctrl related nodes for UART2.
>
> Remove the explicit bootph-all prop from the pinctrl node, any bootph-
> prop will automatically be propagated to the pinctrl node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-tinker-u-boot.dtsi | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> index 032dac221c24..1665e4f5d10f 100644
> --- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> @@ -6,7 +6,6 @@
>   #include "rk3288-u-boot.dtsi"
>   
>   &dmc {
> -	bootph-all;
>   	rockchip,pctl-timing = <0x215 0xc8 0x0 0x35 0x26 0x2 0x70 0x2000d
>   		0x6 0x0 0x8 0x4 0x17 0x24 0xd 0x6
>   		0x4 0x8 0x4 0x76 0x4 0x0 0x30 0x0
> @@ -18,6 +17,7 @@
>   };
>   
>   &gpio7 {
> +	/delete-property/ bootph-all;
>   	bootph-pre-ram;
>   };
>   
> @@ -29,7 +29,7 @@
>   };
>   
>   &pcfg_pull_none {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &pcfg_pull_none_drv_8ma {
> @@ -37,17 +37,13 @@
>   };
>   
>   &pcfg_pull_up {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &pcfg_pull_up_drv_8ma {
>   	bootph-pre-ram;
>   };
>   
> -&pinctrl {
> -	bootph-all;
> -};
> -
>   &sdmmc {
>   	bootph-pre-ram;
>   };
> @@ -77,7 +73,8 @@
>   };
>   
>   &uart2_xfer {
> -	bootph-all;
> +	bootph-pre-sram;
> +	bootph-pre-ram;
>   };
>   
>   &vcc_sd {
