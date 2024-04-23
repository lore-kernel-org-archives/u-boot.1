Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910FAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84858859F;
	Tue, 23 Apr 2024 13:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kXL33OBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C912884F0; Tue, 23 Apr 2024 13:02:31 +0200 (CEST)
Received: from mail-m3278.qiye.163.com (mail-m3278.qiye.163.com
 [220.197.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA47885A1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kXL33OBYJsAlMcTQgx8XBYZZA9By9d6LF6dgEFXVZAkLmEQagSQPeafI5UwNJVShiS3LLd0o2fThv37b7IPBrKV0RmahiKhYBg4ytj+S9FyFdCV7hV8DJBxNGStSEagjdnraUA1z2axTGq9ilvyqAbi4nMa/gcljg5sqMUw2zoU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=2c4tily7oJkvlRdhAtWD6PfmWmkHK+nIZJlnmA3Yve8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5189E900342;
 Tue, 23 Apr 2024 19:02:16 +0800 (CST)
Message-ID: <e085c6b8-b3bc-4b05-9b31-8a2d821f102a@rock-chips.com>
Date: Tue, 23 Apr 2024 19:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/31] rockchip: rk3399: Remove use of xPL_MISC_DRIVERS
 options
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpNHlZLTUJOSUsdGkxOGUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9ee57503a9kunm5189e900342
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTY6Qhw6STNNKj0IOU5OGT0I
 TxAwCUNVSlVKTEpIQ0xLSkhNQkNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0JKNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> The TPL and/or SPL control FDT on RK3399 boards does not contain any
> node with a compatible that is supported by driver/misc/ drivers.
>
> Remove use of xPL_MISC_DRIVERS options to stop including e.g an unused
> efuse driver in TPL and/or SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 8dca9d2853b4..bc03d69a7f5c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -250,7 +250,6 @@ config ROCKCHIP_RK3399
>   	select TPL_NEEDS_SEPARATE_STACK if TPL
>   	select SPL_SEPARATE_BSS
>   	select SPL_SERIAL
> -	select SPL_DRIVERS_MISC
>   	select CLK
>   	select FIT
>   	select PINCTRL
> @@ -282,7 +281,6 @@ config ROCKCHIP_RK3399
>   	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
>   	imply TPL_CLK
>   	imply TPL_DM
> -	imply TPL_DRIVERS_MISC
>   	imply TPL_LIBCOMMON_SUPPORT
>   	imply TPL_LIBGENERIC_SUPPORT
>   	imply TPL_OF_CONTROL
