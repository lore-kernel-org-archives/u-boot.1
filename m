Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A039C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1DE8880F;
	Tue, 16 Jul 2024 04:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="N+wK/1Un";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2550A87D87; Tue, 16 Jul 2024 04:11:57 +0200 (CEST)
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com
 [220.197.32.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E4388898
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=N+wK/1Un7iL/CxNx9HxpGz21WayIxD1cSJ31ZRqcdTSgjItAZNxqm6hTyEKJB5oTqxHf59IZZD9EByU3Yx/A3U8BYiWIKkYt4vIaVv/kE8FfQg8iysovlkhyTlcfL4PH3W02T0vftiyJx7lIqL44RGn4+Kmigy3NrYCChdANe4c=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=EzZDPKLk8YuKY6i7jCYE7jMFHKAr5lTO4ZGFUQEjPw8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 82AEE9003B9;
 Tue, 16 Jul 2024 10:11:43 +0800 (CST)
Message-ID: <94df2ec7-dd94-4a46-b4bf-962200b51e81@rock-chips.com>
Date: Tue, 16 Jul 2024 10:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS
 for rk3308, rk3328, and rk3399
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, andy.yan@rock-chips.com,
 gajjar04akash@gmail.com, jonas@kwiboo.se
References: <20240618095334.47722-1-naoki@radxa.com>
 <20240618095334.47722-2-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240618095334.47722-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hPSFZMTh0eSUlPH0NCTUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b94f5a8503a9kunm82aee9003b9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Cio5ITI9NhgjTh4XCTA#
 DFYaFDhVSlVKTElKS0JOQktPT0lJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0JINwY+
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


On 2024/6/18 17:53, FUKAUMI Naoki wrote:
> - add support for compressed kernel for rk3308
> - prepare support for fdtoverlay for rk3328
>
> tested on ROCK Pi S 256MB, ROCK Pi E 2GB, and ROCK Pi 4A 4GB with
> linux-next-20240613 defconfig kernel.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> Changes in v2:
> - minor cosmetic change in commit message
> ---
>   include/configs/rk3308_common.h | 12 ++++++++----
>   include/configs/rk3328_common.h |  5 ++++-
>   include/configs/rk3399_common.h |  4 ++--
>   3 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
> index 80113220e4..2de55538fd 100644
> --- a/include/configs/rk3308_common.h
> +++ b/include/configs/rk3308_common.h
> @@ -15,11 +15,15 @@
>   
>   #define ENV_MEM_LAYOUT_SETTINGS		\
>   	"scriptaddr=0x00500000\0"	\
> +	"script_offset_f=0xffe000\0"	\
> +	"script_size_f=0x2000\0"	\
>   	"pxefile_addr_r=0x00600000\0"	\
> -	"fdt_addr_r=0x03e00000\0"	\
> -	"fdtoverlay_addr_r=0x03f00000\0"	\
> -	"kernel_addr_r=0x00680000\0"	\
> -	"ramdisk_addr_r=0x04000000\0"
> +	"fdt_addr_r=0x01e00000\0"	\
> +	"fdtoverlay_addr_r=0x01f00000\0"	\
> +	"kernel_addr_r=0x02080000\0"	\
> +	"ramdisk_addr_r=0x06000000\0"	\
> +	"kernel_comp_addr_r=0x08000000\0"	\
> +	"kernel_comp_size=0x2000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
> index f9e6634c5f..bd2bfe2910 100644
> --- a/include/configs/rk3328_common.h
> +++ b/include/configs/rk3328_common.h
> @@ -15,8 +15,11 @@
>   
>   #define ENV_MEM_LAYOUT_SETTINGS		\
>   	"scriptaddr=0x00500000\0"	\
> +	"script_offset_f=0xffe000\0"	\
> +	"script_size_f=0x2000\0"	\
>   	"pxefile_addr_r=0x00600000\0"	\
> -	"fdt_addr_r=0x01f00000\0"	\
> +	"fdt_addr_r=0x01e00000\0"	\
> +	"fdtoverlay_addr_r=0x01f00000\0"	\
>   	"kernel_addr_r=0x02080000\0"	\
>   	"ramdisk_addr_r=0x06000000\0"	\
>   	"kernel_comp_addr_r=0x08000000\0"	\
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index 62007c8b27..d652ae4ca3 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -24,8 +24,8 @@
>   	"script_offset_f=0xffe000\0"	\
>   	"script_size_f=0x2000\0"	\
>   	"pxefile_addr_r=0x00600000\0"	\
> -	"fdt_addr_r=0x01f00000\0"	\
> -	"fdtoverlay_addr_r=0x02000000\0"	\
> +	"fdt_addr_r=0x01e00000\0"	\
> +	"fdtoverlay_addr_r=0x01f00000\0"	\
>   	"kernel_addr_r=0x02080000\0"	\
>   	"ramdisk_addr_r=0x06000000\0"	\
>   	"kernel_comp_addr_r=0x08000000\0"	\
