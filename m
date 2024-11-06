Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E4ED44D43
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72238891E3;
	Wed,  6 Nov 2024 11:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PHca5/g7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BAE891E7; Wed,  6 Nov 2024 11:26:22 +0100 (CET)
Received: from mail-m1015.netease.com (mail-m1015.netease.com [154.81.10.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BCC788E75
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f81e5e1;
 Wed, 6 Nov 2024 18:26:15 +0800 (GMT+08:00)
Message-ID: <1c26d0b2-c61e-4800-8999-3115788c9869@rock-chips.com>
Date: Wed, 6 Nov 2024 18:26:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] rockchip: rk3288-miqi: Sort u-boot.dtsi nodes
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkseGlZCH0hNQ0MZQkgZGE9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a930102b96c03afkunm1f81e5e1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46KCo5SjIiKDEDCUsDChY6
 DzZPFCFVSlVKTEhLQ0NDTExNQ0tJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSkxDNwY+
DKIM-Signature: a=rsa-sha256;
 b=PHca5/g7LuYvX7PJraB6LgAMAT1FvuJj7+eep8IGN9BWUxksE0zEqkN8+mMGaDORC6R0jxrwTcCrEbTfV1eaE9k1nNRObyE/LdZ4zeIo6mGa5Z1B697ne+hTRXL7I8Ej5b05IpajYW8dqPJAQHr3XqHjUsXbZUQocfnOO4fCiQo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=sKqTwxD1RvVBDf3sbjMHMhIKPH6ejcL1o4ZOsxnW8kY=;
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
> Sort the nodes in rk3288-miqi-u-boot.dtsi in alphabetical order.
>
> This has no intended change to board DT, this only rearrange nodes in
> preparation for future changes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-miqi-u-boot.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> index 43cb48bd032d..ca839390ce74 100644
> --- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> @@ -25,11 +25,11 @@
>   	rockchip,sdram-params = <0x30B25564 0x627 3 666000000 3 9 1>;
>   };
>   
> -&pinctrl {
> +&emmc {
>   	bootph-all;
>   };
>   
> -&uart2 {
> +&pinctrl {
>   	bootph-all;
>   };
>   
> @@ -37,10 +37,6 @@
>   	bootph-all;
>   };
>   
> -&emmc {
> -	bootph-all;
> -};
> -
>   &sdmmc_bus4 {
>   	bootph-pre-ram;
>   };
> @@ -56,3 +52,7 @@
>   &sdmmc_pwr {
>   	bootph-pre-ram;
>   };
> +
> +&uart2 {
> +	bootph-all;
> +};
