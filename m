Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7DFC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA17E82B4A;
	Sun,  6 Apr 2025 17:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VmklFYDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3172B82B46; Sun,  6 Apr 2025 17:12:23 +0200 (CEST)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A44682B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0205c2;
 Sun, 6 Apr 2025 23:12:15 +0800 (GMT+08:00)
Message-ID: <1f29a0f1-ccf0-42f7-9b2c-10ddd3d2fadc@rock-chips.com>
Date: Sun, 6 Apr 2025 23:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS for px30
 to rk3308/etc
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250401144004.2342300-1-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250401144004.2342300-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTU0aVh1PS01PTUpDSh4eHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960ba8d40d03afkunm10d0205c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6Eww6LDJPKUkwMElJMzAI
 SD4wCglVSlVKTE9IQk5JSEhNTENDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJTEhDNwY+
DKIM-Signature: a=rsa-sha256;
 b=VmklFYDzMB151skU1pMRy0LpwYqNt8WAY61Jy+cH6zEJpJmqix2yV3gQeH796DJ/+abcQ6V32jRv4EXQR4iAX6tqI2eQFBt77zLUvKNpSlPiE1SNaxaVnv4awAF50EueEVxAyXXclIG9yQEAa9cDgohIV7ewhc1+jVAQrtx6jvM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=YUrhSB0DdaLIiHx6uJ73EA9iAwyfCWV1CK+2mOATFrQ=;
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


On 2025/4/1 22:40, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> Loading a FIT image for kernel, initrd and rootfs on px30 can result in an
> memory overlap, resulting in the not 100% helpful message of
> "This will not be a case any time" from lmb_fix_over_lap_regions().
>
> Adding a bit of debug info to lmb_fix_over_lap_regions() brings:
> lmb_fix_over_lap_regions: base1 0x280000-0x6005ac > base2 0x600000-0x6000d1
>
> So this is because the FIT image gets loaded to the kernel_addr_r at
> 0x280000 while the pxe-file is already living at 0x600000, only 3.5MB
> behind.
>
> In commit 4acc8bb044a4 ("configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS
> for rk3308, rk3328, and rk3399") FUKAUMI Naoki already brought the memory
> layouts for the mentioned socs in sync.
>
> Adjusting the env-layout on px30 to this scheme, magically solves the
> overlap issue and also brings px30 more in line with the other mentioned
> SoCs.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/px30_common.h | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/configs/px30_common.h b/include/configs/px30_common.h
> index 13ed9011764..2a3dc362f98 100644
> --- a/include/configs/px30_common.h
> +++ b/include/configs/px30_common.h
> @@ -18,11 +18,14 @@
>   
>   #define ENV_MEM_LAYOUT_SETTINGS \
>   	"scriptaddr=0x00500000\0" \
> +	"script_offset_f=0xffe000\0" \
> +	"script_size_f=0x2000\0" \
>   	"pxefile_addr_r=0x00600000\0" \
> -	"fdt_addr_r=0x08300000\0" \
> -	"kernel_addr_r=0x00280000\0" \
> -	"ramdisk_addr_r=0x0a200000\0" \
> -	"kernel_comp_addr_r=0x03e80000\0" \
> +	"fdt_addr_r=0x01e00000\0" \
> +	"fdtoverlay_addr_r=0x01f00000\0" \
> +	"kernel_addr_r=0x02080000\0" \
> +	"ramdisk_addr_r=0x06000000\0" \
> +	"kernel_comp_addr_r=0x08000000\0" \
>   	"kernel_comp_size=0x2000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS \
