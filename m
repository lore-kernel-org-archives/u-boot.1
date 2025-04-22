Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36849C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4172D8209F;
	Tue, 22 Apr 2025 17:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PD+X5QIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F2D82054; Tue, 22 Apr 2025 17:28:29 +0200 (CEST)
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com
 [45.254.49.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3903981F4D
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bfc617b;
 Tue, 22 Apr 2025 23:28:23 +0800 (GMT+08:00)
Message-ID: <95dfac8a-e93c-4c90-a0c7-f9889f80f5e9@rock-chips.com>
Date: Tue, 22 Apr 2025 23:28:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rng: rockchip_rng: Update compatible for RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20250408221151.2762853-1-jonas@kwiboo.se>
 <20250408221151.2762853-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250408221151.2762853-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkxOVkJPTB5PT09CSk8fTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965e1d565a03afkunm12bfc617b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRA6Qio6GjJLCklKEAEtPzA*
 Ez0aFA9VSlVKTE9OSEhOTEtPT0tIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlOTUs3Bg++
DKIM-Signature: a=rsa-sha256;
 b=PD+X5QIXmkuC2VSI19ss0Kd1RpdT9rHEaoEk4ikn1qsqdcAKM/ulroUerKAIpbvc97lfkyCHcJHZt0KFvwrCa1v4K0hYm1A3YrDWKCA8rk5hvRGiKYEcxQFUkGvaVe9wvmgOUUOKuPYQ7Tii0GxN7p87NlzsDYtf5RjbR+RLxTU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=OZyEcwo9HCKGupqe+IDFQQss/yGArfR/4X9hrd2KBXs=;
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


On 2025/4/9 06:11, Jonas Karlman wrote:
> Linux commit 6ee0b9ad3995 ("arm64: dts: rockchip: Add rng node to
> RK3588") merged for v6.15-rc1 add a proper rng node to the device tree.
> The compatible used differs compared to what U-Boot is currently using.
>
> Replace the old trngv1 compatible with the dts/upstream compatible in
> the rng driver and remove the old rng node compatible override from SoC
> u-boot.dtsi to keep rng working after the driver change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Remove the rng node instead of changing compatible
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi | 5 -----
>   drivers/rng/rockchip_rng.c       | 2 +-
>   2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 8880d162b11c..5eeb138f3513 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -18,11 +18,6 @@
>   		compatible = "rockchip,rk3588-dmc";
>   		bootph-all;
>   	};
> -
> -	rng: rng@fe378000 {
> -		compatible = "rockchip,trngv1";
> -		reg = <0x0 0xfe378000 0x0 0x200>;
> -	};
>   };
>   
>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index f673e2657c94..6e4e3abf08c8 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -321,7 +321,7 @@ static const struct udevice_id rockchip_rng_match[] = {
>   		.data = (ulong)&rk_cryptov2_soc_data,
>   	},
>   	{
> -		.compatible = "rockchip,trngv1",
> +		.compatible = "rockchip,rk3588-rng",
>   		.data = (ulong)&rk_trngv1_soc_data,
>   	},
>   	{},
