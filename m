Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7703C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B196587C74;
	Thu,  1 Feb 2024 04:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="e4+4jDbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F170E87C75; Thu,  1 Feb 2024 04:18:41 +0100 (CET)
Received: from mail-m121150.qiye.163.com (mail-m121150.qiye.163.com
 [115.236.121.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0514287C77
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=e4+4jDbtUkK1f7nvOtXegXLaXHNBiv9lzXe+XyNYZrjBKeAuESBn/A2uIU7lbaU8RTaa42nYFUQ7l6zLqGwR3+3PLmROw78hWpkOw/QrvyF5P41Vq2FoeurFcSWHxgQmubbK7WbMEclOBULfcfPvdIqAnQQDVIawjimtrOMlh88=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=oFX1xhtQweA5HoupPBYHHkncNqcLWlFX4z7S2WNZ62s=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1A3E99000E6;
 Thu,  1 Feb 2024 11:18:06 +0800 (CST)
Message-ID: <2f574d73-63ac-406c-8a20-6f0b33a21bee@rock-chips.com>
Date: Thu, 1 Feb 2024 11:18:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] rockchip: Convert rv1126 to standard boot
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@edgeble.ai>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240124032602.126059-1-tim@feathertop.org>
 <20240124032602.126059-4-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240124032602.126059-4-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUtCVk0eSR9LGkNKSBpIQ1UTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d62ac77b703a9kunm1a3e99000e6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6UQw4NTMKCE1KFhwhHQNW
 KBQaCh5VSlVKTEtNTE5MT0NNQ0xOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhKSUg3Bg++
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


On 2024/1/24 11:25, Tim Lunn wrote:
> RV1126 soc appears to have been missed with the conversion of
> rockchip socs to standard boot.
>
> Remove remnants of distro boot for rv1126 common and the one
> existing board.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> Link: https://lore.kernel.org/all/20230407223645.v8.8.I4cf7708a1ba953b9abd81375d93af34665c7b251@changeid/
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> ---
>
> Changes in v2:
> - New patch to clean up distro boot from rv1126_common.h
>
>   include/configs/neural-compute-module-2.h | 6 ------
>   include/configs/rv1126_common.h           | 3 +--
>   2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/include/configs/neural-compute-module-2.h b/include/configs/neural-compute-module-2.h
> index f0934ae00c..43a560906a 100644
> --- a/include/configs/neural-compute-module-2.h
> +++ b/include/configs/neural-compute-module-2.h
> @@ -12,10 +12,4 @@
>   
>   #include <configs/rv1126_common.h>
>   
> -#undef BOOT_TARGET_DEVICES
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -	func(MMC, mmc, 0) \
> -	func(MMC, mmc, 1)
> -
>   #endif /* __NEURAL_COMPUTE_MODULE_2_H */
> diff --git a/include/configs/rv1126_common.h b/include/configs/rv1126_common.h
> index a64c0c6364..168cd8b167 100644
> --- a/include/configs/rv1126_common.h
> +++ b/include/configs/rv1126_common.h
> @@ -28,7 +28,6 @@
>   	"kernel_addr_r=0x02008000\0" \
>   	"ramdisk_addr_r=0x0a200000\0"
>   
> -#include <config_distro_bootcmd.h>
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	"fdt_high=0x0fffffff\0" \
>   	"initrd_high=0x0fffffff\0" \
> @@ -36,6 +35,6 @@
>   	"partitions=" PARTS_DEFAULT \
>   	ENV_MEM_LAYOUT_SETTINGS	 \
>   	ROCKCHIP_DEVICE_SETTINGS \
> -	BOOTENV
> +	"boot_targets=" BOOT_TARGETS "\0"
>   
>   #endif /* __CONFIG_RV1126_COMMON_H */
