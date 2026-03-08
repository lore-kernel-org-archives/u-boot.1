Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6ABEA852C
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DADC483F14;
	Sun,  8 Mar 2026 16:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VBZ59MHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B871283EEF; Sun,  8 Mar 2026 16:14:16 +0100 (CET)
Received: from mail-m19731114.qiye.163.com (mail-m19731114.qiye.163.com
 [220.197.31.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D7F780212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3625284f0;
 Sun, 8 Mar 2026 23:14:06 +0800 (GMT+08:00)
Message-ID: <110fb175-4267-4ca4-8f82-1790722fcb80@rock-chips.com>
Date: Sun, 8 Mar 2026 23:14:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3576: Use DMA when loading FIT images
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260108133234.4001390-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce0341ed03afkunm15f624c515bae1c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx9DVh9DH0saQxgeGUkdH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=VBZ59MHBqsuqnr/ZQyY1pc+WxBrQ9OoNeOra1QS8wYKvktXcKrlk9uKITC/sqrDPCUabSISoCKIeaWkwRa4oVUhY8jPN/H6I9dOjFiX/klzFAtCFFEdx9yALuDHlb1Y2KI4royWR6oqG7NKPm1vkBwvt4lcqaHrwbJjpZoQZ2rM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=b8yDLkKrAEfYPuiJnKBv3IzGgPr7csKkwcKCBZhrmWs=;
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


On 2026/1/8 21:32, Jonas Karlman wrote:
> Enable use of DMA when loading FIT images from eMMC, SD-card and SPI
> flash now that access to PMU_SRAM for non-secure masters is allowed.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index dc3771b556a3..018c9cc8d696 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -118,13 +118,11 @@
>   &sdhci {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> -	u-boot,spl-fifo-mode;
>   };
>   
>   &sdmmc {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> -	u-boot,spl-fifo-mode;
>   };
>   
>   &sdmmc0_bus4 {
> @@ -154,12 +152,10 @@
>   
>   &sfc0 {
>   	bootph-some-ram;
> -	u-boot,spl-sfc-no-dma;
>   };
>   
>   &sfc1 {
>   	bootph-some-ram;
> -	u-boot,spl-sfc-no-dma;
>   };
>   
>   &sys_grf {
