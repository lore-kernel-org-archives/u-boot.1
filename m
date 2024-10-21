Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A18D3C927
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8FF89161;
	Mon, 21 Oct 2024 03:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="avmI9vpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4268925A; Mon, 21 Oct 2024 03:31:46 +0200 (CEST)
Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com
 [101.71.155.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F1689161
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=avmI9vpIOyh8emBvTE9mRt813BekIooDn1dsNsAU9MsL7w9KD/ZDOJrojoFtk1KDhzw3wejbIvNgFgqgrJBTclurNXSFryueSq5SAONs9EPfTsV2y17e0MIFdc/DguCBP3Q4zd/XxfJQZzkiNwPq4XUziVMdhjqvCgD/LB2xzzo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=OI/9g0t88y9UnEyUniuEXCjWgod9pkmhbX1CSwbm2iY=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 154CD52019D;
 Mon, 21 Oct 2024 09:31:29 +0800 (CST)
Message-ID: <884868a9-d019-4745-a7d1-0bd44e423611@rock-chips.com>
Date: Mon, 21 Oct 2024 09:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] rockchip: rk3399-pinephone-pro: Drop upstream props from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241016201523.903560-1-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241016201523.903560-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR0fHlZOSUIZTxhLQx8dGhhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb3665603afkunm154cd52019d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6TCo*HjIeFygROUg2TjxJ
 Tx1PCk5VSlVKTElCT0xPSUJJSk9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSUpCNwY+
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


On 2024/10/17 04:15, Jonas Karlman wrote:
> The SPI flash node has been added in upstream DT, drop all props beside
> bootph-* props from the SPI flash related nodes in u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index 037cec10ce36..7438bec4ee63 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -15,13 +15,8 @@
>   };
>   
>   &spi1 {
> -	status = "okay";
> -
>   	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
>   		bootph-pre-ram;
>   		bootph-some-ram;
> -		spi-max-frequency = <10000000>;
>   	};
>   };
