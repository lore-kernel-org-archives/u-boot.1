Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5829D44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EDB89035;
	Wed,  6 Nov 2024 11:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CxY5ZxnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D39589032; Wed,  6 Nov 2024 11:41:18 +0100 (CET)
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com
 [117.135.214.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA49488D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f884128;
 Wed, 6 Nov 2024 18:41:10 +0800 (GMT+08:00)
Message-ID: <0b6167fe-05cb-428c-a86e-8569a729960c@rock-chips.com>
Date: Wed, 6 Nov 2024 18:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] rockchip: rk3288-miqi: Remove unused work led node
 from xPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5NH1ZOHhoYTEJLSkNMQ09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9301105f1a03afkunm1f884128
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6USo*KDIvSzE0Nh0cDzcs
 Hg4aCgJVSlVKTEhLQ0NCTUxKSUJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDQ0I3Bg++
DKIM-Signature: a=rsa-sha256;
 b=CxY5ZxnRt1pFcHQVFdEFZSwqkfhBTW3taxjoX5neS0FfQsZFM/uT2l7HxWEqBdUbYe/3TCVjwz/yCxg5rK6yjA81t12TojO/yhwDlHLJTSZexD6kvtuHWRW5rRblRuYte6OObZgEQ64et3m+BtP5oWq8OPgUDRNiUiONMYnxgIM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=dTE9LRTS4QLJVeuxH2RzWFEPkR26cagOF20DsY9LU9w=;
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
> The work led is not used in xPL on rk3288-miqi, remove bootph props from
> the work led node to exclude it from xPL control FDT.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-miqi-u-boot.dtsi | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> index ca839390ce74..721d02086939 100644
> --- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> @@ -4,15 +4,6 @@
>    */
>   
>   #include "rk3288-u-boot.dtsi"
> -/ {
> -	leds {
> -		bootph-all;
> -
> -		work {
> -			bootph-all;
> -		};
> -	};
> -};
>   
>   &dmc {
>   	rockchip,pctl-timing = <0x29a 0xc8 0x1f8 0x42 0x4e 0x4 0xea 0xa
