Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB2BD44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B284488D8D;
	Wed,  6 Nov 2024 11:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EKuiF70e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1B2891E1; Wed,  6 Nov 2024 11:46:13 +0100 (CET)
Received: from mail-m25473.xmail.ntesmail.com (mail-m25473.xmail.ntesmail.com
 [103.129.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC1688D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8a3cc1;
 Wed, 6 Nov 2024 18:46:07 +0800 (GMT+08:00)
Message-ID: <a8e5f615-8754-4ec2-b569-5d117b44a510@rock-chips.com>
Date: Wed, 6 Nov 2024 18:46:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] rockchip: rk3288-miqi: Drop USE_PREBOOT Kconfig
 option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9CGVZMSUpISh5DHU4ZShhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUNDSU
 1VSktLVUpCWQY+
X-HM-Tid: 0a930114e6cc03afkunm1f8a3cc1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6Czo6CDIoDjFIGAojEzdM
 LDYwCglVSlVKTEhLQ0NCQk1DSUpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCTUI3Bg++
DKIM-Signature: a=rsa-sha256;
 b=EKuiF70elCFE4hQzxpjUBKoEPwqZ4+7zTxy/1StVlHur5lqFhNUUUQl4pCBCExI5Q4DaAGcBfXjAmgPQwcz3lgIW1gayCChfb0CnAgCjkysXDRU0gE6Mm+z8yGcO987vX3st2kcxVIPtcjde8tZ+mVVk5Qafj9OmPnoh8S6+kQo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=NjNnAFpo6KwncLxjLYatqjzbIJJZ8RcPqiTqF0IMkDo=;
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


On 2024/11/6 05:51, Jonas Karlman wrote:
> After the migration to use standard boot, storage media devices should
> automatically be initialized in the order listed in boot_targets env.
>
> Drop USE_PREBOOT to speed up boot when booting from SD-card or eMMC.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/miqi-rk3288_defconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index 678d6fb33716..1643f2776801 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -17,7 +17,6 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-miqi.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
