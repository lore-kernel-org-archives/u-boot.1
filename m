Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C7CC54E67
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE8787F1A;
	Mon, 11 Mar 2024 10:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iEXfCHFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5837087F02; Mon, 11 Mar 2024 10:56:01 +0100 (CET)
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com
 [45.254.49.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8080D876F3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iEXfCHFy1f5rMKziwPtIVISUWom7FRNGb75CC3dGWS5H+lqw9AanX5GTYJHdX9RUf05dBh4wTDZeE3q3DStpqjpwFDFUOyj7Ydqupo79F8xyZlRVZtMlSjNz7ihaNgxHc5jdm0GqZtS6ddKav54pWbYk9da1ngH7Zh38xI3P6/E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=0C14DyA4023CaRFqhi61ZeVoym5VN+3fmd0N8BwK8zA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 362CE900117;
 Mon, 11 Mar 2024 17:55:51 +0800 (CST)
Message-ID: <811e15c4-3cad-4b15-abb1-a68f52471b06@rock-chips.com>
Date: Mon, 11 Mar 2024 17:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] rockchip: Add common default bss and stack
 addresses
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240302191629.322562-1-jonas@kwiboo.se>
 <20240302191629.322562-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240302191629.322562-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkpKSFZDGk8dHk9IHklIQxhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cf0a28903a9kunm362ce900117
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6DAw5NTMUDjBMFD80Dyo9
 GkwaCSpVSlVKTEpLSk5LQk5KQk1MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMSk9ONwY+
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

Hi Jonas,

On 2024/3/3 03:16, Jonas Karlman wrote:
> On Rockchip the typical aarch64 boot steps are as follows:
> - BROM load TPL to SRAM
> - TPL init full DRAM
>    - use stack in SRAM at TPL_STACK addr
>    - use malloc heap on stack, size is TPL_SYS_MALLOC_F_LEN
> - TPL jump back to BROM
> - BROM load SPL to beginning of DRAM
> - SPL init storage devices
>    - use bss in DRAM at SPL_BSS_START_ADDR, size is SPL_BSS_MAX_SIZE
>    - use stack in DRAM at SPL_STACK addr (or CUSTOM_SYS_INIT_SP_ADDR)
>    - use malloc heap on stack, size is SPL_SYS_MALLOC_F_LEN
> - SPL load FIT images from storage to DRAM
>    - use stack in DRAM at SPL_STACK_R_ADDR
>    - use new malloc heap on stack, size is SPL_STACK_R_MALLOC_SIMPLE_LEN
> - SPL jump to TF-A at 0x40000
> - (optional) TF-A load OPTEE
> - TF-A jump to U-Boot proper at TEXT_BASE
> - U-Boot proper init pre-reloc devices
>    - use stack in DRAM at CUSTOM_SYS_INIT_SP_ADDR
>    - use malloc heap on stack, size is SYS_MALLOC_F_LEN
> - U-Boot proper relocate to end of usable DRAM
> - U-Boot proper init devices and complete boot
>
> SPL have access to full DRAM, however, current configuration for text
> base, stack addr and malloc heap size used at the different boot steps
> are at risk of overlapping, e.g. when U-Boot proper + FDT grows close
> to 1 MiB on RK3328/RK3399 or when pre-reloc and reloc stack and malloc
> heap overlap on ROCK 5A.
>
> Fix this by defining safe defaults for bss, stack and malloc size and
> addresses. A range at around [60 MiB, 64 MiB) was chosen to be used for
> bss and stack until U-Boot proper have been relocated to end of usable
> DRAM. The range was primarily chosen to be able to accommodate SoCs with
> a small amount of embedded DRAM, e.g. RK3308G has 64 MiB DRAM.
>
> Overiew of the new common memory layout:
> [    0,   2M) - SPL / TF-A / reserved
> [   2M,   +X) - U-Boot proper pre-reloc
> [   -X,  64M) - bss, stack and malloc heap
>
> During SPL pre-reloc phase:
> [    0,	256K) - SPL binary is loaded by BROM to beginning of DRAM
> [   -X,	 63M) - SPL pre-reloc stack
> [ -32K,	 63M)   - SPL pre-reloc malloc heap
> [63.5M,	+32K) - SPL bss
>
> After SPL reloc phase:
> [    0,	256K) - SPL binary
> [ 256K,	  +X) - TF-A image is loaded by SPL
> [   2M,	  +X) - U-Boot proper + FDT image is loaded by SPL
> [   -X,	 62M) - SPL reloc stack
> [  60M,	 62M)   - SPL reloc malloc heap
> [ -32K,	 63M) - SPL init malloc heap, memory allocated during SPL
>                  pre-reloc phase is still in use at reloc phase
> [63.5M,	+32K) - SPL bss
>
> During U-Boot proper pre-reloc phase:
> [    0,   2M) - TF-A / reserved
> [   2M,   +X) - U-Boot proper + FDT
> [   -X,  63M) - U-Boot proper pre-reloc stack (shared addr with SPL)
> [ -64K,  63M)   - U-Boot proper pre-reloc malloc heap
>
> After U-Boot proper has relocated to top of memory we should be able to
> use 2M+ for loading kernel, initrd, scripts etc.

Very good update and also good description here, can we also add the 
memory usage

  description  after update to rockchip.rst?


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/Kconfig | 55 ++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 2c6b045c51c8..edbe3fd30853 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -534,6 +534,21 @@ config ROCKCHIP_SPI_IMAGE
>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   	default TEXT_BASE
>   
> +config ROCKCHIP_COMMON_STACK_ADDR
> +	bool
> +	depends on SPL_SHARES_INIT_SP_ADDR
> +	select HAS_CUSTOM_SYS_INIT_SP_ADDR
> +	imply SPL_LIBCOMMON_SUPPORT if SPL
> +	imply SPL_LIBGENERIC_SUPPORT if SPL
> +	imply SPL_ROCKCHIP_COMMON_BOARD if SPL
> +	imply SPL_SYS_MALLOC_F if SPL
> +	imply SPL_SYS_MALLOC_SIMPLE if SPL
> +	imply TPL_LIBCOMMON_SUPPORT if TPL
> +	imply TPL_LIBGENERIC_SUPPORT if TPL
> +	imply TPL_ROCKCHIP_COMMON_BOARD if TPL
> +	imply TPL_SYS_MALLOC_F if TPL
> +	imply TPL_SYS_MALLOC_SIMPLE if TPL
> +
>   source "arch/arm/mach-rockchip/px30/Kconfig"
>   source "arch/arm/mach-rockchip/rk3036/Kconfig"
>   source "arch/arm/mach-rockchip/rk3066/Kconfig"
> @@ -549,4 +564,44 @@ source "arch/arm/mach-rockchip/rk3568/Kconfig"
>   source "arch/arm/mach-rockchip/rk3588/Kconfig"
>   source "arch/arm/mach-rockchip/rv1108/Kconfig"
>   source "arch/arm/mach-rockchip/rv1126/Kconfig"
> +
> +if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
> +
> +config CUSTOM_SYS_INIT_SP_ADDR
> +	default 0x3f00000
> +
> +config SYS_MALLOC_F_LEN
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +
> +config SPL_SYS_MALLOC_F_LEN
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +
> +config TPL_SYS_MALLOC_F_LEN
> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +
> +config TEXT_BASE
> +	default 0x00200000 if ARM64
> +
> +config SPL_TEXT_BASE
> +	default 0x0 if ARM64
> +
> +config SPL_HAS_BSS_LINKER_SECTION
> +	default y if ARM64
> +
> +config SPL_BSS_START_ADDR
> +	default 0x3f80000
> +
> +config SPL_BSS_MAX_SIZE
> +	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
> +
> +config SPL_STACK_R
> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +
> +config SPL_STACK_R_ADDR
> +	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +
> +config SPL_STACK_R_MALLOC_SIMPLE_LEN
> +	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
> +
> +endif
>   endif
