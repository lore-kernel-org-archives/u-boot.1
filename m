Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F0CE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5965780079;
	Fri,  3 Jan 2025 04:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jjCQi0bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41378007D; Fri,  3 Jan 2025 04:12:29 +0100 (CET)
Received: from mail-m127206.xmail.ntesmail.com
 (mail-m127206.xmail.ntesmail.com [115.236.127.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717CB80017
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79178f7a;
 Fri, 3 Jan 2025 11:12:22 +0800 (GMT+08:00)
Message-ID: <7cb2b4b6-d7a8-411d-9493-f12481b3aa20@rock-chips.com>
Date: Fri, 3 Jan 2025 11:12:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: expand space for decompressed kernel
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: chris.obbard@collabora.com, pbrobinson@gmail.com, jonas@kwiboo.se,
 sjg@chromium.org
References: <20241202234018.92120-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241202234018.92120-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xNSlZOTk9OT0NCH0NJT0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a2654a303afkunm79178f7a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6Sxw*QjIWIS0qKBM2LDVO
 FBUaCRdVSlVKTEhOQ0xIQk9ITkpPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUtNNwY+
DKIM-Signature: a=rsa-sha256;
 b=jjCQi0bzVbNnNYkbmRiy0+d8xC6n9NzwrAnbvKlkBFN7MiT1ZB0TxVJ8HlYnj7MkVssMUX5XK4acaIuSn1oTd1OCXGcsOmQEwXwN1DTQrtgDw1T3g9XvtxZDVIwJj6p2wU0TGjDJ1Ll+i5FPc1bV8BgDG5DtO2T6AFBuo7nqEtY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=HQrQ6f2SP4vY64vRQvjrXMMR79POMW9kZYlEsV6A4pM=;
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


On 2024/12/3 07:40, FUKAUMI Naoki wrote:
> fix following error by using same ENV_MEM_LAYOUT_SETTINGS with rk35xx:
>
> U-Boot 2025.01-rc3-00001-g1527c7dcdb01 (Dec 02 2024 - 22:57:18 +0000)
>    :
> Retrieving file: /boot/extlinux/../nixos/dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
> Retrieving file: /boot/extlinux/../nixos/6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
> append: init=/nix/store/yjbxgzf1vkwbw6ab738bf4kxazhyypa1-nixos-system-rock-5b-25.05.20241201.ac35b10/init console=ttyS2,1500000n8 console=ttyAMA0,115200n8 console=tty0 loglevel=7
> Retrieving file: /boot/extlinux/../nixos/dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs/rockchip/rk3399-rock-4se.dtb
> Moving Image from 0x2080000 to 0x2200000, end=0x60d0000
> ERROR: RD image overlaps OS image (OS=2200000..60d0000)
> Boot failed (err=-14)
>
> $ ls -lh boot/nixos/
> total 84M
> -r--r--r--  1 root root  24M Jan  1  1970 6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
> -r--r--r--  1 root root  62M Jan  1  1970 dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
> dr-xr-xr-x 36 root root 4.0K Jan  1  1970 dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs
>
> similar problem was fixed for rk35xx by:
>
> commit 69b73877f02c ("rockchip: rk35xx: expand space for decompressed kernel")
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/rk3399_common.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index c5bcd7dc5e8a..76f40e7cd5f8 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -20,16 +20,16 @@
>   #endif
>   
>   #define ENV_MEM_LAYOUT_SETTINGS		\
> -	"scriptaddr=0x00500000\0"	\
> +	"scriptaddr=0x00c00000\0"	\
>   	"script_offset_f=0xffe000\0"	\
>   	"script_size_f=0x2000\0"	\
> -	"pxefile_addr_r=0x00600000\0"	\
> -	"fdt_addr_r=0x01e00000\0"	\
> -	"fdtoverlay_addr_r=0x01f00000\0"	\
> -	"kernel_addr_r=0x02080000\0"	\
> -	"ramdisk_addr_r=0x06000000\0"	\
> -	"kernel_comp_addr_r=0x08000000\0"	\
> -	"kernel_comp_size=0x2000000\0"
> +	"pxefile_addr_r=0x00e00000\0"	\
> +	"kernel_addr_r=0x02000000\0"	\
> +	"kernel_comp_addr_r=0x0a000000\0"	\
> +	"fdt_addr_r=0x12000000\0"	\
> +	"fdtoverlay_addr_r=0x12100000\0"	\
> +	"ramdisk_addr_r=0x12180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
