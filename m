Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17000D5E125
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 03:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD4D88EEA;
	Fri,  8 Nov 2024 04:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="b2uSlKpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EDC88EC6; Fri,  8 Nov 2024 04:41:30 +0100 (CET)
Received: from mail-m60107.netease.com (mail-m60107.netease.com
 [210.79.60.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC4E88DB6
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 227c5e3f;
 Fri, 8 Nov 2024 11:41:25 +0800 (GMT+08:00)
Message-ID: <636f2f1e-b125-4461-9b5b-66162e68903b@rock-chips.com>
Date: Fri, 8 Nov 2024 11:41:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] rockchip: Make it possible to define per board
 boot_targets
To: Andy Yan <andyshrk@163.com>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se
References: <20241104122307.439776-1-andyshrk@163.com>
 <20241104122307.439776-3-andyshrk@163.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241104122307.439776-3-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4aQlYaHkhITk1PH0MYTEpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9309dccb4303afkunm227c5e3f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6KDo4KTIsDisvI1E0EzY2
 Ok8KFEhVSlVKTEhKS0hMSUNNSk5NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCTU43Bg++
DKIM-Signature: a=rsa-sha256;
 b=b2uSlKpaiHtbY4zeG1sj3c7RC7+gLO5dh8c5zIM7w2j+VD0fW3lScnksTTMK7QkrefqSdgMQlZMlbGCCDBujDytoGlQ2tIJfJOMuwc8woeF+Pyb+R4xbgU9iJFCOVMAhDZGVQm+njRFrRrpOaQAEKzr2ENalB2IQDJslQIA+FJ0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=9YFm9+BS5fkfhOxtT7bi07xG7J6k+rSlHIqfuuxgwI0=;
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


On 2024/11/4 20:22, Andy Yan wrote:
> Some board may want to have a different boot priority(a laptop
> may want to usb has the highest boot priority for third-part
> os installation). So let the board can define it's own
> boot_targets.
>
> Signed-off-by: Andy Yan <andyshrk@163.com>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   include/configs/rockchip-common.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
> index 9b8ab3cdf20..d5550a46575 100644
> --- a/include/configs/rockchip-common.h
> +++ b/include/configs/rockchip-common.h
> @@ -13,7 +13,9 @@
>   
>   #ifndef CONFIG_XPL_BUILD
>   
> +#ifndef BOOT_TARGETS
>   #define BOOT_TARGETS	"mmc1 mmc0 nvme scsi usb pxe dhcp spi"
> +#endif
>   
>   #ifdef CONFIG_ARM64
>   #define ROOT_UUID "B921B045-1DF0-41C3-AF44-4C6F280D3FAE;\0"
