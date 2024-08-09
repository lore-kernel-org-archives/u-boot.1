Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CBAC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AF388BB5;
	Fri,  9 Aug 2024 11:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="faCPxRAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C8288BB5; Fri,  9 Aug 2024 11:33:51 +0200 (CEST)
Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com
 [101.71.155.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF6F88BD2
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=faCPxRAHas4r3MJGC83y17rzt+7nP63io9C0Jx+wIjVvOliSoIIdBvmAhRgZhtTtE67nD0cHCpTmY3uTUt0aVjOw4AJtLS8bipszw85h39Z6Cd2z6CmJR5IWkGVtl219Ov3ePbl4nspyUbn30YexyjI2CGWGv1KasL5cjJqltTI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=LG/eQpKCkZWyIPNbmnqD+CU1fM1SphN45sXM2jLhVGQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E55E8900629;
 Fri,  9 Aug 2024 17:33:35 +0800 (CST)
Message-ID: <48b73e28-10ed-4072-a8f9-fa8e386816f1@rock-chips.com>
Date: Fri, 9 Aug 2024 17:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: fix mmc aliases for Radxa
 ZERO 3E/3W
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240802221231.2629416-1-jonas@kwiboo.se>
 <20240802221231.2629416-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802221231.2629416-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEJPVkweThlMSUtPQhkYHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91367c889903a9kunme55e8900629
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6Myo5EzI4Fw45LggCMigf
 Ky8KCUhVSlVKTElISkJNS0pMSEhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9KT0M3Bg++
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


On 2024/8/3 06:12, Jonas Karlman wrote:
> From: FUKAUMI Naoki <naoki@radxa.com>
>
> align with other Radxa products.
>
> - mmc0 is eMMC
> - mmc1 is microSD
>
> for ZERO 3E, there is no eMMC, but aliases should start at 0, so mmc0
> is microSD as exception.
>
> Fixes: 1a5c8d307c83 ("arm64: dts: rockchip: Add Radxa ZERO 3W/3E")
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>
> Changes in v3:
> - fix syntax error in rk3566-radxa-zero-3e.dts
> Changes in v2:
> - microSD is mmc0 instead of mmc1 for ZERO 3E
>
> Link: https://lore.kernel.org/r/20240620224435.2752-1-naoki@radxa.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 060c1950037e4c54ca4d8186a8f46269e35db901 ]
>
> (cherry picked from commit 8324bc7493e4088013c62bc41f49d6d181575493)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Add Signed-off-by tag
> ---
>   dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi | 4 ----
>   dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts | 1 +
>   dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts | 3 ++-
>   3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
> index 623d5939d194..081be841b286 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
> @@ -6,10 +6,6 @@
>   #include "rk3566.dtsi"
>   
>   / {
> -	aliases {
> -		mmc0 = &sdmmc0;
> -	};
> -
>   	chosen {
>   		stdout-path = "serial2:1500000n8";
>   	};
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
> index e166d66990b9..4a830eb09f0b 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
> @@ -10,6 +10,7 @@
>   
>   	aliases {
>   		ethernet0 = &gmac1;
> +		mmc0 = &sdmmc0;
>   	};
>   };
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
> index 9bf4f464915f..f92475c59deb 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
> @@ -9,7 +9,8 @@
>   	compatible = "radxa,zero-3w", "rockchip,rk3566";
>   
>   	aliases {
> -		mmc1 = &sdhci;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;
>   		mmc2 = &sdmmc1;
>   	};
>   
