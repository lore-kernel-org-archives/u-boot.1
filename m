Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F7C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 14:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392AF82B4A;
	Sun,  6 Apr 2025 16:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OFxSwWGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7141182B53; Sun,  6 Apr 2025 16:25:40 +0200 (CEST)
Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com
 [220.197.32.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CF382B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 16:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10cfd74e5;
 Sun, 6 Apr 2025 22:25:29 +0800 (GMT+08:00)
Message-ID: <7017e7e1-92d7-4597-8436-97f94fb163e2@rock-chips.com>
Date: Sun, 6 Apr 2025 22:25:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rng: rockchip_rng: Add compatible for RK3568
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20250330214015.3466802-1-jonas@kwiboo.se>
 <20250330214015.3466802-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250330214015.3466802-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThlLVk9NHxoaHUIYSUkeGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960b7e025b03afkunm10cfd74e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6Lzo6CTJRC0kDGjQpIz1N
 E1ZPFA1VSlVKTE9IQk9CTkhKSkhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJQ0lDNwY+
DKIM-Signature: a=rsa-sha256;
 b=OFxSwWGtGRQTigpVlrEuB1a7y8LZzzdMh++xlf34EHHm22Iz5W9GRdwzE9tIKalGHRTB/OBspozNvJXFOZbWMmFnbN5/LLGXuW1VKx7xl4istJiF5CqGN/5n+6K/Vm2gc+QMEf1zMLDBwyWSi9P4pOsa87eiAndbjIYdXg4ghlo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=MzcRU0LnCIOwICi9nM/yzP6tWK+GdATeC5HhvjMZRNs=;
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

Hi Jonas,

     Please split the change to separate patches, the driver change and 
the dts change should not submit in one change.


Thanks,

- Kever

On 2025/3/31 05:40, Jonas Karlman wrote:
> Linux commit afeccc408496 ("arm64: dts: rockchip: add DT entry for RNG
> to RK356x") merged for v6.12-rc1 add a proper rng node to the SoC DT.
> The compatible used differs compared to what U-Boot is currently using.
>
> Add support for the rk3568-rng used in upstream Linux. Support for the
> cryptov2-rng compatible is still kept because PX30/RK3326 and RK3308 are
> still using it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi | 9 ++++-----
>   drivers/rng/rockchip_rng.c      | 4 ++++
>   2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 24a976cf7e21..871869739536 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -21,11 +21,6 @@
>   		bootph-all;
>   	};
>   
> -	rng: rng@fe388000 {
> -		compatible = "rockchip,cryptov2-rng";
> -		reg = <0x0 0xfe388000 0x0 0x2000>;
> -	};
> -
>   	otp: nvmem@fe38c000 {
>   		compatible = "rockchip,rk3568-otp";
>   		reg = <0x0 0xfe38c000 0x0 0x4000>;
> @@ -121,6 +116,10 @@
>   	bootph-all;
>   };
>   
> +&rng {
> +	status = "okay";
> +};
> +
>   &sdhci {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index 2426648fbd57..f673e2657c94 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -312,6 +312,10 @@ static const struct udevice_id rockchip_rng_match[] = {
>   		.compatible = "rockchip,rk3399-crypto",
>   		.data = (ulong)&rk_cryptov1_soc_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3568-rng",
> +		.data = (ulong)&rk_cryptov2_soc_data,
> +	},
>   	{
>   		.compatible = "rockchip,cryptov2-rng",
>   		.data = (ulong)&rk_cryptov2_soc_data,
