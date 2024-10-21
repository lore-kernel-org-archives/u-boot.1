Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BF7D3C927
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1FA891E7;
	Mon, 21 Oct 2024 03:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iZTjrA4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C074F891E9; Mon, 21 Oct 2024 03:31:48 +0200 (CEST)
Received: from mail-m127169.xmail.ntesmail.com
 (mail-m127169.xmail.ntesmail.com [115.236.127.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95228891E7
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iZTjrA4t02TzOQhkNiP5rK4358EYY7bYS94iwLBU1vnHjSz60Ise7RjvF0wXOLqRuqCiXH1WVrCD5PsAfXdy2m0yFcv+easigEnf6jE/xYNUxFStEl4p4m+O0qbnb+CvVex3cwSrvA6el+h/nsHIRgjS4xnda3k7MmbScifDZZM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=aR1l/TkiF2GmoOB7551sybgJkhbpBaLvYwF6dJOHp8o=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 8414752020D;
 Mon, 21 Oct 2024 09:31:33 +0800 (CST)
Message-ID: <9b1e4935-6e30-4c42-97d6-f4356b44c2dd@rock-chips.com>
Date: Mon, 21 Oct 2024 09:31:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Drop upstream props from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241016201413.903112-1-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241016201413.903112-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hDQlYZHx4ZSU8dGE9JGB1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb374e503afkunm8414752020d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06HAw*EjIeAyg2KU4JTjhW
 AiwKCy1VSlVKTElCT0xPSUJOTUJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSElINwY+
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


On 2024/10/17 04:14, Jonas Karlman wrote:
> The SPI flash node has been added in upstream DT, drop all props beside
> bootph-* props from the SPI flash related nodes in u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 4dd17ff408cb..3ff3bb64e4f7 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -16,18 +16,9 @@
>   };
>   
>   &sfc {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&fspim2_pins>;
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
>   
