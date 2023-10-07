Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FEFE94139
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 02:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3280786489;
	Sat,  7 Oct 2023 04:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WVkQbP/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045DC864A0; Sat,  7 Oct 2023 04:47:59 +0200 (CEST)
Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com
 [45.254.49.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEEA85894
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 04:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WVkQbP/e3z78tR0OhdSWJK9QwofLnJ0EKhN2PDNYJgAkNzNxj6DDJoaZIQk4J0m9yedBf7+iwsK3ZZTfo+3bIORMp0YxBxmWJB+RaI6zC8djjqhM+243VwrYjKdWjPs91P4LLfOr8ptWkw8VzcNkFfhPoGkNr50tO2A+wXP4rAk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Ss5JIu9oTHu4qn7aIMHwhGWZp61HK7r6/2MwBQJ7NH4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 258DA400265;
 Sat,  7 Oct 2023 10:47:18 +0800 (CST)
Message-ID: <4a5e6988-014f-8ae5-962a-bc23edae1ddc@rock-chips.com>
Date: Sat, 7 Oct 2023 10:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] configs: rockchip: rk3308: use CONFIG_DEFAULT_FDT_FILE
Content-Language: en-US
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: andy.yan@rock-chips.com, gajjar04akash@gmail.com, sjg@chromium.org,
 jonas@kwiboo.se
References: <20230911100121.122228-1-naoki@radxa.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230911100121.122228-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlPHVZPHh9MTk4YQx5CQ0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b080838192eb3kusn258da400265
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6Kjo4ODw6Mhk8Sj4tEBhI
 ExQwCUpVSlVKTUJNTU9NQ0hDQklLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS01INwY+
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


On 2023/9/11 18:01, FUKAUMI Naoki wrote:
> all rk3308 boards should use their own dtb file.
>
> also, change fdt_addr_r to avoid following error:
>   "ERROR: Did not find a cmdline Flattened Device Tree"
> it happens on Radxa ROCK Pi S (256MB/512MB) with kernel built from
> Radxa BSP.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/evb-rk3308_defconfig       | 1 +
>   configs/roc-cc-rk3308_defconfig    | 1 +
>   configs/rock-pi-s-rk3308_defconfig | 1 +
>   include/configs/rk3308_common.h    | 3 ++-
>   4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index a13a809c1e..2c7ac88ed9 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -24,6 +24,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_BOOTDELAY=0
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-evb.dtb"
>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> index 9a789b212f..9cb90f6ee6 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -24,6 +24,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_BOOTDELAY=0
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-roc-cc.dtb"
>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index cc3274a98b..e2abe4b4f7 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -25,6 +25,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_BOOTDELAY=0
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
> diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
> index 7d55fcd975..a413af1bd4 100644
> --- a/include/configs/rk3308_common.h
> +++ b/include/configs/rk3308_common.h
> @@ -16,11 +16,12 @@
>   #define ENV_MEM_LAYOUT_SETTINGS \
>   	"scriptaddr=0x00500000\0" \
>   	"pxefile_addr_r=0x00600000\0" \
> -	"fdt_addr_r=0x02800000\0" \
> +	"fdt_addr_r=0x03e00000\0" \
>   	"kernel_addr_r=0x00680000\0" \
>   	"ramdisk_addr_r=0x04000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
>   	ENV_MEM_LAYOUT_SETTINGS \
>   	"partitions=" PARTS_DEFAULT \
>   	ROCKCHIP_DEVICE_SETTINGS \
