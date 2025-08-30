Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44975CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2887183857;
	Sat, 30 Aug 2025 17:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Z11JGFp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A008380E; Sat, 30 Aug 2025 17:12:16 +0200 (CEST)
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com
 [45.254.49.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8338983857
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4ed4;
 Sat, 30 Aug 2025 23:12:11 +0800 (GMT+08:00)
Message-ID: <cfa7fa2c-a517-40b5-9d8e-a9a3cf57500a@rock-chips.com>
Date: Sat, 30 Aug 2025 23:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] rockchip: odroid-go2: Remove cru assigned-clocks
 override
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250713233429.1376172-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb8939b403afkunm5e3ab6df411c0b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUtDVk0YTElLSUpJHktMGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Z11JGFp1iQJ/sW5Te6GKQI7FNpRKBqFTsKnuWO3sQEZZhNB1lkQnCya/lB8uc3lBewkE2v/7Jwl1KbRLV5RegNWEQQj5UlVetAKgfbWGVbOpo6j7Ud5b3nGyRnpGnrOUfa+JXlbi2RE6oklWMwOzCNVtB5ROgTsOwQlF8ObFhA8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=QPv9SUhIUcp6J3IanlkF0NzTZ/G4N6WP2qOuwHtIq6E=;
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


On 2025/7/14 07:33, Jonas Karlman wrote:
> Remove the cru assigned-clocks override now that SCLK_GPU is supported
> by the clock driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> index a0ab8b69f2e4..f37daa893c79 100644
> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> @@ -32,18 +32,8 @@
>   	};
>   };
>   
> -/* U-Boot clk driver for px30 cannot set GPU_CLK */
>   &cru {
>   	bootph-all;
> -	assigned-clocks = <&cru PLL_NPLL>,
> -		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> -		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
> -		<&cru PCLK_BUS_PRE>, <&cru PLL_CPLL>;
> -
> -	assigned-clock-rates = <1188000000>,
> -		<200000000>, <200000000>,
> -		<150000000>, <150000000>,
> -		<100000000>, <17000000>;
>   };
>   
>   &gpio0 {
