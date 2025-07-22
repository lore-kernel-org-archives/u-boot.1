Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FACAC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C1583323;
	Tue, 22 Jul 2025 21:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AwhojD5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FE7833F1; Tue, 22 Jul 2025 21:00:40 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A0A83253
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so44789655e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753210838; x=1753815638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Alq3rF+M8wwOSbol3nv6duTbwK/eijTZ13zMLiDl8AQ=;
 b=AwhojD5u5MoaswDOEZpH9saWTyhgS2NqXHvNV/Od8ScWLeX61g02m1DaEh9CVYeCli
 uZoYwmB3/wfJ5ZUI/L2VZxZjuGe6bppo9cBxzTWthYxiYUZ+jfMpFf9jUTuP2V4NHtkI
 mqgP7cbX4/mgBcmTSL0KOm/oPcxNgP6yqfzUHtUDyw4w3W8AAmeP+VqusY0UNWk1xpJ5
 kDTXRuPZr7CamcuvY8OviNHXCkN3czDVUbWyuFyRI1Rwrg0T3eDDc/8vknhJUqgdqLNo
 RItAH1zYK4PwbsJrxNvuFiXD3uoTNtKy1DmudFTTdaSXEr9/aDxvOpDvPLL/U/KF8xWF
 NFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753210838; x=1753815638;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Alq3rF+M8wwOSbol3nv6duTbwK/eijTZ13zMLiDl8AQ=;
 b=Y8TVSezsTyfcpZ3ceBarX9FJ7f7xzxyV50fTHdaZajUtlfjMbnzTGXMfOsvzCYVHtZ
 hIN4FtaBVnVbrYW0Unxg+1wXApFEl2SOA0iJt0HHNR9TDrvlR5ak/XR8anbFy9dwAdLt
 pIB4ts0KPOFiYaSpt22fX73DFjNF4Qh+6cwtRF/KUBLqqG5UNa5z0TDQRcm0RM0Yhw8e
 bFJcgsYQDV68CU2vPxc1PJAha7i/cVckoaBZKAZDLM7uvwD7oU5cqGlFy/MxuOSboVdh
 CUK0NiQdHvjGLmgGpKa6HDaO9o7ZP0m3kOzwfRINaG5Tf8ihg4bMoJaf3ShgAVWwhTCH
 Uyew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/s1aoRNPW77tADbTGxrt0SQt+ZWPHTLq5SM/tuYkRuAAB6u+rjyzMfQGD18GRjxOKAlDcPkU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw0H70OAA/r9lRQaBdq5NCiSTpgXsbceYz9Y1bx8Py5P3kT2BC
 vXhXoIeexmoQk000leGhqeMJjn0Syq4GHcrCf5PTPW01XoC9pWARhLDB
X-Gm-Gg: ASbGncvP3JLIhViO9iEKQzZ5znLxGRtNHY5gWI9/vKB6+w9HNoiwS/fQH/1M8OEkEbm
 mhjrrNW+86ZyOcKLEfgeL1pP3pmb9BRbqacHUtLExsiCrK4OpQaKXtyap3s6sBlZxDL94jZzik4
 6L/uHVLaznn5fvXTDZ2hQNDg682l9vyTGgPvTeBbhXFka4vXAReU14ldv+h/X1CGAaD8ouskHFu
 5eTUm3plZ90ODft+7WG/YkxZ4UWJPkFuxS7rhCJE4f+SAnm0INkRnBE5I37FtOLWdbIiEfINp2C
 t9pvaCLQh1pByu733LLBI/5hkb2UqjzlFkz+g6YU9us/NKUsSDegXGa3dJdknOprOsSKOPWxYgs
 fDh5N6/T9IFwyX4LbTlyhooWErvPxa26Xjw==
X-Google-Smtp-Source: AGHT+IGuuodhmSlcqXNw29Sj4W4HxfcoTQqbdcn7U7a1iwi64bIgFOi9EHDpQOUaf8OuzZGHpctY/Q==
X-Received: by 2002:a05:600c:a115:b0:456:1a6f:8018 with SMTP id
 5b1f17b1804b1-4562e4f7a5dmr198178275e9.8.1753210837476; 
 Tue, 22 Jul 2025 12:00:37 -0700 (PDT)
Received: from Ansuel-XPS. ([176.200.63.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458639ffca5sm21695845e9.1.2025.07.22.12.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:00:37 -0700 (PDT)
Message-ID: <687fdfd5.050a0220.29df4a.b412@mx.google.com>
X-Google-Original-Message-ID: <aH_f1BnGTXDxr6L7@Ansuel-XPS.>
Date: Tue, 22 Jul 2025 21:00:36 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] airoha: rework RAM size handling to support multiple
 RAM size
References: <20250716073716.11698-1-ansuelsmth@gmail.com>
 <20250716073716.11698-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073716.11698-2-ansuelsmth@gmail.com>
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

On Wed, Jul 16, 2025 at 09:37:08AM +0200, Christian Marangi wrote:
> There are multiple version of the same reference board with different
> RAM size and it's not enough to base the RAM size entirely from DT. To
> better support it use the get_ram_size way to scan for the actual RAM
> size of Airoha SoC and increase the size of the memory map.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sorry ignore this as it was sent by mistake, I resent a new version of
the same patch that actually apply and build.

> ---
>  arch/arm/mach-airoha/an7581/init.c | 22 ++++++++++++++++++----
>  arch/arm/mach-airoha/an7583/init.c | 22 ++++++++++++++++++----
>  2 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> index cefe9c6db9e..caf1006b22b 100644
> --- a/arch/arm/mach-airoha/an7581/init.c
> +++ b/arch/arm/mach-airoha/an7581/init.c
> @@ -3,8 +3,11 @@
>  #include <fdtdec.h>
>  #include <init.h>
>  #include <asm/armv8/mmu.h>
> +#include <asm/global_data.h>
>  #include <asm/system.h>
>  
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  int print_cpuinfo(void)
>  {
>  	printf("CPU:   Airoha AN7581\n");
> @@ -13,12 +16,23 @@ int print_cpuinfo(void)
>  
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	int ret;
> +
> +	ret = fdtdec_setup_mem_size_base();
> +	if (ret)
> +		return ret;
> +
> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
> +
> +	return 0;
>  }
>  
>  int dram_init_banksize(void)
>  {
> -	return fdtdec_setup_memory_banksize();
> +	gd->bd->bi_dram[0].start = gd->ram_base;
> +	gd->bd->bi_dram[0].size = gd->ram_size;
> +
> +	return 0;
>  }
>  
>  void reset_cpu(ulong addr)
> @@ -31,12 +45,12 @@ static struct mm_region an7581_mem_map[] = {
>  		/* DDR */
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x80000000UL,
> +		.size = 0x200000000ULL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>  	}, {
>  		.virt = 0x00000000UL,
>  		.phys = 0x00000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x40000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
> index 77c29290331..c00837b4234 100644
> --- a/arch/arm/mach-airoha/an7583/init.c
> +++ b/arch/arm/mach-airoha/an7583/init.c
> @@ -4,6 +4,9 @@
>  #include <init.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/system.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
>  
>  int print_cpuinfo(void)
>  {
> @@ -13,12 +16,23 @@ int print_cpuinfo(void)
>  
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	int ret;
> +
> +	ret = fdtdec_setup_mem_size_base();
> +	if (ret)
> +		return ret;
> +
> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
> +
> +	return 0;
>  }
>  
>  int dram_init_banksize(void)
>  {
> -	return fdtdec_setup_memory_banksize();
> +	gd->bd->bi_dram[0].start = gd->ram_base;
> +	gd->bd->bi_dram[0].size = gd->ram_size;
> +
> +	return 0;
>  }
>  
>  void reset_cpu(ulong addr)
> @@ -31,12 +45,12 @@ static struct mm_region an7583_mem_map[] = {
>  		/* DDR */
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x80000000UL,
> +		.size = 0x200000000ULL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>  	}, {
>  		.virt = 0x00000000UL,
>  		.phys = 0x00000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x40000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -- 
> 2.48.1
> 

-- 
	Ansuel
