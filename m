Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5C5ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0092088F90;
	Tue, 10 Sep 2024 11:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O2U7oje4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCB788C1B; Tue, 10 Sep 2024 11:51:48 +0200 (CEST)
Received: from mail-m127173.xmail.ntesmail.com
 (mail-m127173.xmail.ntesmail.com [115.236.127.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E75C88FDA
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=O2U7oje4/RjyLym6xQzKOSFQAVNx04KJwOMgkQENdl065bH4i2a+o19CP7WG0CNG3GB38r7zSvL5YTlMx02weSihiaH0X06Zigyn6fTLSl0K2g9OcXdfuJb5AKVcvve201RKuA76RAJLlC73ZwTEDBG0tgSKDzPzx5Vu0VnylJI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=f9ekfjsO/qaTifoF6MpHlPwL1N37b8BFzmaB1YsCWls=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6449D900623;
 Tue, 10 Sep 2024 17:51:19 +0800 (CST)
Message-ID: <9b484137-8595-4e23-bcd5-c7185c0a21ee@rock-chips.com>
Date: Tue, 10 Sep 2024 17:51:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] rockchip: px30: Weaken dependency TPL/SPL serial
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
 <20240903163858.1155218-5-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240903163858.1155218-5-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9KSVZDTR0YHk1PHU8ZQktWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91db5840a403a3kunm6449d900623
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46Dww4KzI8Iys#CzgpHS9C
 Tg1PCw9VSlVKTElOQk1KQ0NLSkJCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0lDNwY+
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


On 2024/9/4 00:38, Lukasz Czechowski wrote:
> Allow to disable serial console in TPL and SPL. Weak dependency
> to SPL_SERIAL and TPL_SERIAL is also used in other Rockchip boards.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index fc1b638ff01..47a6275d45f 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -11,8 +11,8 @@ config ROCKCHIP_PX30
>   	select TPL_TINY_FRAMEWORK if TPL
>   	select TPL_NEEDS_SEPARATE_STACK if TPL
>   	imply SPL_SEPARATE_BSS
> -	select SPL_SERIAL
> -	select TPL_SERIAL
> +	imply SPL_SERIAL
> +	imply TPL_SERIAL
>   	select DEBUG_UART_BOARD_INIT
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
