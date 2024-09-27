Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA8FCEBF8C
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78DD088B1C;
	Fri, 27 Sep 2024 12:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kS9bHC+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318ED88B2D; Fri, 27 Sep 2024 12:26:12 +0200 (CEST)
Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com
 [220.197.32.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22FD8898B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kS9bHC+aI+oe8UlWgAenVqjKx49JdMiGbJi5itgQp7Yf/0NKsK2oEMD1aKSpDnHDU/XdMx5weYS8NM9GHxFc7eTyLRZSvgeg8Tw3De8HNyIcHUQeOZeCmPcGk0Lh4wjJsgyIum+rRRkgfy/g8i2NMsf0Q/GMJlI1QkWu78qLshw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=6ZVg8HJhpIZ2uRp6RGOruewra2Xivx4o6ULnyojl8H0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E6F4A2806E9;
 Fri, 27 Sep 2024 18:25:56 +0800 (CST)
Message-ID: <e09da585-a742-4e61-abaf-602aaf1df34d@rock-chips.com>
Date: Fri, 27 Sep 2024 18:25:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: Weaken dependency on SPL serial
To: Daniel Semkowicz <dse@thaumatec.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240920090613.76154-1-dse@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240920090613.76154-1-dse@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IdGFZOGRhOGExPHRoeHU5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a923304109209d3kunme6f4a2806e9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6Ehw6DDIaFDUpH006Ay8K
 CkgKCyNVSlVKTElMT0hJTE5MQ01JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkJNNwY+
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


On 2024/9/20 17:06, Daniel Semkowicz wrote:
> Allow to disable serial console in SPL. Weak dependency is already used
> with TPL serial.
>
> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
>   arch/arm/mach-rockchip/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index fc1b638ff01..269c219a6f8 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -257,7 +257,6 @@ config ROCKCHIP_RK3399
>   	select SPL_SYSCON if SPL
>   	select TPL_NEEDS_SEPARATE_STACK if TPL
>   	select SPL_SEPARATE_BSS
> -	select SPL_SERIAL
>   	select CLK
>   	select FIT
>   	select PINCTRL
> @@ -288,6 +287,7 @@ config ROCKCHIP_RK3399
>   	imply SPL_DM_SEQ_ALIAS
>   	imply SPL_FIT_SIGNATURE
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply SPL_SERIAL
>   	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
>   	imply TPL_CLK
>   	imply TPL_DM
