Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACE4D0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7FA88F64;
	Fri, 25 Oct 2024 14:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hh4dZgXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C792388F64; Fri, 25 Oct 2024 14:35:46 +0200 (CEST)
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com
 [101.71.155.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D578857C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec4735f;
 Fri, 25 Oct 2024 20:35:36 +0800 (GMT+08:00)
Message-ID: <76117fb3-13a7-44b1-97c3-d8ce68e00a6f@rock-chips.com>
Date: Fri, 25 Oct 2024 20:35:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] rockchip: rk3588-nanopc-t6: Drop upstream props from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5LGFYaGB4dHUJIHx0dT0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3acd5cb09d6kunmec4735f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6TTo4NTIqPRcrAlYpAwwR
 PCwKCj5VSlVKTElCQ05CTEhMQ0xMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0JONwY+
DKIM-Signature: a=rsa-sha256;
 b=Hh4dZgXLN//VGSlTggj5ZHr+AAFD/B6HtjGGBYWjYWHN8KtNRqU/HRY1RT82mrj3SXN9wRO/ySgZLFNdP3xY+8ytaIoEYB66clBcyRXMpoArwIsa2RMu0pKBN/gfu0v4I/4DWmJmpMOrB1+0SvC4/ZLiw7uiBn81egEPku4DnFs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=fBlhk3OAz3/2qPu+KDkCaMou5IzPN5s2X6C+7gGUx18=;
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


On 2024/10/18 04:00, Jonas Karlman wrote:
> The SPI flash node has been added in upstream DT, drop all props beside
> bootph-* props from the SPI flash related nodes from u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> index 968385622fa5..3261b2c42b4b 100644
> --- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> @@ -12,19 +12,8 @@
>   };
>   
>   &sfc {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&fspim1_pins>;
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
