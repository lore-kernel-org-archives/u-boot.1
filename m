Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4F5C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DEA886FD;
	Fri,  9 Aug 2024 11:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MY0ZR6iN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 282F7889F1; Fri,  9 Aug 2024 11:17:22 +0200 (CEST)
Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com
 [101.71.155.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A819286BF1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MY0ZR6iNkkldvM2JYwGEzGkFskc2vcX99Rkla7dTMHsOUs8dsc7w4UwltANy2n3CWl34ZhTJHTAKG5wNCkOly7za/74wzlXibCV7dsLBY/XjWM7gRx5sfNDb0WsJwj1N1wiiuAd5qBi79tn9sJDQqB/jx7dxd+/EP0qZPJRvm6E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=8PIeUd40/+aUjyEA+pQt3AQ4is667LX5dxasqryep9s=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5B2D1900575;
 Fri,  9 Aug 2024 17:17:08 +0800 (CST)
Message-ID: <15a14070-8767-4192-87c5-c7c8d7e809c3@rock-chips.com>
Date: Fri, 9 Aug 2024 17:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: remove upstreamed props for Radxa
 ROCK 3A
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: gajjar04akash@gmail.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240806011842.3718-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240806011842.3718-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkhIVkIYTUlITEtJTEhISFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91366d75a103a9kunm5b2d1900575
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6TDo4NDI*TA5JETVRCTQu
 TRUaCxxVSlVKTElISkJOS0lCSEtNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlKS0s3Bg++
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


On 2024/8/6 09:18, FUKAUMI Naoki wrote:
> "sfc" node was already upstreamed. remove unnecessary properties from
> u-boot.dtsi.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 9d18f5d0b36..4df40eec975 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -26,17 +26,8 @@
>   };
>   
>   &sfc {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
>   	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
>   		bootph-pre-ram;
>   		bootph-some-ram;
> -		spi-max-frequency = <24000000>;
> -		spi-rx-bus-width = <4>;
> -		spi-tx-bus-width = <1>;
>   	};
>   };
