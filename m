Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D00C4706F
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 00:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767BD878C9;
	Tue,  2 Jan 2024 01:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YBvOi8VP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DED6878DD; Tue,  2 Jan 2024 01:58:06 +0100 (CET)
Received: from mail-m25467.xmail.ntesmail.com (mail-m25467.xmail.ntesmail.com
 [103.129.254.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2EEB86FD5
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 01:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YBvOi8VPP+4AghlFI6iBacj4fSKJY7iXbV7MuxWZCrCuDznCVZGksW7/49GXxpH9VW4zuc4QH30bIYdswlqQ7gb10YH94an0Yh8urqpF2Hqtarb3zH+BKIKDpg2yFn751+S7KgDtzELnagzX6sawHPdVR0TSNPQKD4d6TDXMe58=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=35qYD2EqogGa7S7kUVome9lFz8pobLpRb5Wml8MxAxU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 0EC0240019C;
 Tue,  2 Jan 2024 08:57:52 +0800 (CST)
Message-ID: <eb40c776-1b4f-46d1-bf9a-015399dccbd4@rock-chips.com>
Date: Tue, 2 Jan 2024 08:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: rk35xx: expand space for decompressed kernel
Content-Language: en-US
To: Hugh Cole-Baker <sigmaris@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 John Clark <inindev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20231226164330.63725-1-sigmaris@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231226164330.63725-1-sigmaris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1MTFYYHk5OHxoaTUlOHxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8cc7ad4b9b2eb3kusn0ec0240019c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6Nzo5DTw9EUo5DTJMOSoT
 FBBPCxZVSlVKTEtPSk5MS0xJQ0tLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkJJNwY+
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


On 2023/12/27 00:43, Hugh Cole-Baker wrote:
> An uncompressed 6.7.0-rc1 Linux kernel Image built with the arm64
> defconfig is about 40MB. This does not fit in to the space between
> kernel_comp_addr_r and fdt_addr_r, so when uncompressing an Image.gz
> to this size, the FDT will be overwritten. Rearrange addresses to have
> 128MiB for the kernel and its decompression buffer, then devicetree,
> overlay and ramdisk at the end.
>
> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes from v1:
> Reorder things to have to have 128MiB for kernel and decompression space,
> then devicetree, overlays and ramdisk.
> Update kernel_comp_size to 128MiB.
>
>   include/configs/rk3568_common.h | 12 ++++++------
>   include/configs/rk3588_common.h | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> index 1b7d3437b1..48f93083de 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -20,12 +20,12 @@
>   	"script_offset_f=0xffe000\0"	\
>   	"script_size_f=0x2000\0"	\
>   	"pxefile_addr_r=0x00e00000\0"	\
> -	"fdt_addr_r=0x0a100000\0"	\
> -	"fdtoverlay_addr_r=0x02000000\0"	\
> -	"kernel_addr_r=0x02080000\0"	\
> -	"ramdisk_addr_r=0x0a200000\0"	\
> -	"kernel_comp_addr_r=0x08000000\0"	\
> -	"kernel_comp_size=0x2000000\0"
> +	"kernel_addr_r=0x02000000\0"	\
> +	"kernel_comp_addr_r=0x0a000000\0"	\
> +	"fdt_addr_r=0x12000000\0"	\
> +	"fdtoverlay_addr_r=0x12100000\0"	\
> +	"ramdisk_addr_r=0x12180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	ENV_MEM_LAYOUT_SETTINGS			\
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index 46389d087d..70430612ef 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -19,12 +19,12 @@
>   	"script_offset_f=0xffe000\0"	\
>   	"script_size_f=0x2000\0"	\
>   	"pxefile_addr_r=0x00e00000\0"	\
> -	"fdt_addr_r=0x0a100000\0"	\
> -	"fdtoverlay_addr_r=0x02000000\0"	\
> -	"kernel_addr_r=0x02080000\0"	\
> -	"ramdisk_addr_r=0x0a200000\0"	\
> -	"kernel_comp_addr_r=0x08000000\0"	\
> -	"kernel_comp_size=0x2000000\0"
> +	"kernel_addr_r=0x02000000\0"	\
> +	"kernel_comp_addr_r=0x0a000000\0"	\
> +	"fdt_addr_r=0x12000000\0"	\
> +	"fdtoverlay_addr_r=0x12100000\0"	\
> +	"ramdisk_addr_r=0x12180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
