Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D753EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6FC88BDE;
	Fri,  9 Aug 2024 11:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NNIz5Ysm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D36F88BE0; Fri,  9 Aug 2024 11:44:37 +0200 (CEST)
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com
 [220.197.32.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE4288B81
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NNIz5YsmSITQs0QikYJwg1+bKEEZEk2R3XYixB8lyU3F4j5HC1Xh193aijx/NNOIbqTZrLRGPVdadpip7GDxi7xwgFJ8L+9cTz0DvBKmk+rRGR6lBxyAOelvxfIjsBUfAiiNdly6pT+igJZZwONFi9iAgb3yrd9R/pm5BGRwFBs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=DQ/BFDCDp0w+zv2KOi+MRDjZlzicvEuG30nU5/1yYnU=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8BA7A90061C;
 Fri,  9 Aug 2024 17:44:20 +0800 (CST)
Message-ID: <41bcf857-918b-449e-9eda-d1bedc541170@rock-chips.com>
Date: Fri, 9 Aug 2024 17:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: change spi-max-frequency for Radxa
 ROCK 3C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, sjg@chromium.org, philipp.tomsich@vrull.eu,
 Heiko Stuebner <heiko@sntech.de>
References: <20240805022601.913-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240805022601.913-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQk9IVk9LHx9KGUxMHU5OSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9136865d4e03a9kunm8ba7a90061c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46Hjo*ODIrHw4jLRIoDU1N
 DywaCg5VSlVKTElISkJNTU1KTk9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlISEk3Bg++
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


On 2024/8/5 10:26, FUKAUMI Naoki wrote:
> SPI NOR flash chip may vary, so use safe(lowest) spi-max-frequency.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> Link: https://lore.kernel.org/r/20240623023329.1044-3-naoki@radxa.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 06f6dd4d607766a527e37529f2f3f90dd1464293 ]
>
> (cherry picked from commit dd40945a1d0e28ae6eaf9da04f8e2dcebf8233ea)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts b/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts
> index b242409d378..f2cc086e500 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts
> @@ -633,7 +633,7 @@
>   	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
> -		spi-max-frequency = <120000000>;
> +		spi-max-frequency = <104000000>;
>   		spi-rx-bus-width = <4>;
>   		spi-tx-bus-width = <1>;
>   	};
