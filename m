Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77694C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A5D879F6;
	Wed, 27 Mar 2024 14:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i6IY+srI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A3E87E47; Wed, 27 Mar 2024 14:30:45 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473AE87971
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilbsgilbert@gmail.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7cb9dd46babso46040639f.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711546242; x=1712151042; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2o98hv4v3hX+sEQUZuQB3FV57TUA7SL5ZNE7WxBDOck=;
 b=i6IY+srI35KQPBBQB7L6ivehWH3AWRJAGAcuUHI5QTpPrB7XAclGvqI508qPY7bqxv
 u3wVLxAHgomjdB90pq29gLT78QRnZtin7Tbwdw5ICQnAMbXOnLGa96VAtIOVeySzUEoV
 II6sOqlw9Thqcvbj9rc1brIFrz/3dDwxyYgPioFyuuenSTBAXiEkJD/Z/OCxUP5pLiZX
 7bbptDYD7Vv5efwEfT7rN7CYH1TpDNUZ2tuqHrFxG8uScSgs+ptXP08z7OO0JEtI9ywb
 ORiEuAsmjfIWiMnK4k81bDwA2/WaXfFWNFJzNm889zv/VGXDRy2bzUVU5acVtz0BPP35
 x0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711546242; x=1712151042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2o98hv4v3hX+sEQUZuQB3FV57TUA7SL5ZNE7WxBDOck=;
 b=lYbHaHvmbU/StuEwcxS4n1TJbXqbunDp5MPUC8COsskjCqIL2euXM9hQ4ZyC8Hel6C
 nx7dN5ESZdYZO6o3wmfsfxZ9zrOxemvGI/IM2kdF66DxVMuQ9wvc57ylB5YxBX7Msm2K
 3OweUTU1PEXQNLxktHloZD7pdF4UMSJZxnPxNG2pu4JB0Jz6dLpx1GKCp5ygF79vc+gS
 /3PKyubtX39ILsOKU/lfUubd+6Da1zqHdVTQvyCD/Mq1wWDnV5QPDR1GQE3vRYa1m/Mu
 eXsdCXcXQl/ks4XnLllsQD9xPjZUUcif8zMneSa6YCMglGqNhEw0BueyRwlTVAzhKZrh
 Ql7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV54ILkAhQ2IBAUzybblFPG2UKUzxTqZ++30iVSN7PvQp0Efrqrk/vOZ2w4B65e6AN1Moxs54AjUxDxIjbA+zprCBkdJQ==
X-Gm-Message-State: AOJu0YzgT+Ahw4DXV/sjURaZReTHKsjjYNLLFTuUuVfEyPKwy6tCk0KV
 j8G4H6PrgpZQcPTm4zZaSEq/vLXq7RD6qd0RUgigLWzKnWBG73mg
X-Google-Smtp-Source: AGHT+IHpEwPMxp1kmNLVqwV+zP71j3XJD0aql2jNPds/pIWRFEJ/4+xHI9R2tnhiJS/sYqWe2dlrtA==
X-Received: by 2002:a05:6e02:786:b0:368:b52b:b449 with SMTP id
 q6-20020a056e02078600b00368b52bb449mr849421ils.0.1711546241880; 
 Wed, 27 Mar 2024 06:30:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:233:d260:84c3:f4d0:ae28:49ef?
 ([2a01:e0a:233:d260:84c3:f4d0:ae28:49ef])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a63454c000000b005dccf48e2a5sm9216825pgk.54.2024.03.27.06.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 06:30:41 -0700 (PDT)
Message-ID: <003d0b68-3784-4f04-a25e-e19cd41cc085@gmail.com>
Date: Wed, 27 Mar 2024 14:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpu: add t-head's c9xx
To: wefu@redhat.com, u-boot@lists.denx.de, bmeng@tinylab.org,
 rick@andestech.com, trini@konsulko.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, ycliang@andestech.com
Cc: tekkamanninja@gmail.com, tekkamanninja@163.com
References: <20240327080817.44501-1-wefu@redhat.com>
 <20240327080817.44501-2-wefu@redhat.com>
Content-Language: en-US
From: Nils Le Roux <gilbsgilbert@gmail.com>
In-Reply-To: <20240327080817.44501-2-wefu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi!

I tested this and it works fine. I also happen to have the glue layer ported
from the Linux somewhere on my machine. If you're interested, please 
reach out
to me and I'll arrange a patch. I have a few remarks on this patch:

On 3/27/24 9:07 AM, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
>
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-authored-by: Yixun Lan <dlan@gentoo.org>
> ---
>   arch/riscv/Kconfig               |  1 +
>   arch/riscv/cpu/c9xx/Kconfig      | 12 ++++++++
>   arch/riscv/cpu/c9xx/Makefile     |  5 ++++
>   arch/riscv/cpu/c9xx/cpu.c        | 51 ++++++++++++++++++++++++++++++++
>   arch/riscv/cpu/c9xx/dram.c       | 36 ++++++++++++++++++++++
>   arch/riscv/include/asm/csr.h     |  2 ++
>   board/thead/th1520_lpi4a/Kconfig |  3 +-
>   7 files changed, 109 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ac52c5e6da..ac3b802abe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -97,6 +97,7 @@ source "arch/riscv/cpu/fu540/Kconfig"
>   source "arch/riscv/cpu/fu740/Kconfig"
>   source "arch/riscv/cpu/generic/Kconfig"
>   source "arch/riscv/cpu/jh7110/Kconfig"
> +source "arch/riscv/cpu/c9xx/Kconfig"
>   
>   # architecture-specific options below
>   
> diff --git a/arch/riscv/cpu/c9xx/Kconfig b/arch/riscv/cpu/c9xx/Kconfig
> new file mode 100644
> index 0000000000..5a84bcacd6
> --- /dev/null
> +++ b/arch/riscv/cpu/c9xx/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2017-2020 Alibaba Group Holding Limited
> +
> +config RISCV_THEAD
> +	bool
> +	select ARCH_EARLY_INIT_R
> +	imply CPU
> +	imply CPU_RISCV
> +	imply RISCV_TIMER
> +	imply RISCV_RDTIME
> +	imply CMD_CPU
> diff --git a/arch/riscv/cpu/c9xx/Makefile b/arch/riscv/cpu/c9xx/Makefile
> new file mode 100644
> index 0000000000..e3f776cb41
> --- /dev/null
> +++ b/arch/riscv/cpu/c9xx/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2017-2020 Alibaba Group Holding Limited
> +
> +obj-y += cpu.o dram.o
> diff --git a/arch/riscv/cpu/c9xx/cpu.c b/arch/riscv/cpu/c9xx/cpu.c
> new file mode 100644
> index 0000000000..4b21edd62b
> --- /dev/null
> +++ b/arch/riscv/cpu/c9xx/cpu.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017-2020 Alibaba Group Holding Limited
> + */
> +
> +#include <asm/cache.h>
> +#include <asm/csr.h>
> +#include <cpu_func.h>
> +
> +/*
> + * cleanup_before_linux() is called just before we call linux
> + * it prepares the processor for linux
> + *
> + * we disable interrupt and caches.
> + */
> +int cleanup_before_linux(void)
> +{
> +	cache_flush();
> +
> +	return 0;
> +}
> +
> +void flush_dcache_range(unsigned long start, unsigned long end)
> +{
> +	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
Isn't this just round_down/ALIGN_DOWN macro?
> +
> +	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
> +		asm volatile(".long 0x0295000b");  /* dcache.cpa a0 */
> +
> +	sync_is();
> +}
> +
> +void invalidate_dcache_range(unsigned long start, unsigned long end)
> +{
> +	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
> +
> +	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
> +		asm volatile(".long 0x02b5000b");  /* dcache.cipa a0 */

`th.dcache.cipa` not only invalidates the dcache, but also flushes it 
which is
not expected here. In practice, this leads to a bug with the dwmac 
driver: when
U-Boot handles an ARP request, it overwrites the ARP request with the ARP
response in-place, directly in the ring buffer[^1]. When re-using the same
buffer later on, the driver will flush this data instead of invalidating
it[^2], and you'll read the ARP response you just sent instead of the packet
just written by the chip.

This can easily be reproduced by downloading a big file using TFTP. As 
soon as
you receive an ARP request, U-Boot hangs, timeouts and requests the packet
again. It also makes TCP completely unusable.

You can use `th.dcache.ipa` instead, as implemented in 
`invalid_dcache_range`.

[^1] 
https://github.com/u-boot/u-boot/blob/a5ec56aea1a56737a4e124d058a6920d16f5e686/net/arp.c#L154-L160
[^2] 
https://github.com/u-boot/u-boot/blob/a5ec56aea1a56737a4e124d058a6920d16f5e686/drivers/net/designware.c#L542

> +
> +	sync_is();
> +}
> +
> +void invalid_dcache_range(unsigned long start, unsigned long end)

I think this isn't used anywhere.

> +{
> +	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
> +
> +	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
> +		asm volatile(".long 0x02a5000b");  /* dcache.ipa a0 */
> +
> +	sync_is();
> +}
> diff --git a/arch/riscv/cpu/c9xx/dram.c b/arch/riscv/cpu/c9xx/dram.c
> new file mode 100644
> index 0000000000..614d7bf1cc
> --- /dev/null
> +++ b/arch/riscv/cpu/c9xx/dram.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> + */
> +
> +#include <fdtdec.h>
> +#include <init.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	return fdtdec_setup_memory_banksize();
> +}
> +
> +phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +	/*
> +	 * Ensure that we run from first 4GB so that all
> +	 * addresses used by U-Boot are 32bit addresses.
> +	 *
> +	 * This in-turn ensures that 32bit DMA capable
> +	 * devices work fine because DMA mapping APIs will
> +	 * provide 32bit DMA addresses only.
> +	 */
> +	if (gd->ram_top >= SZ_4G)
> +		return SZ_4G - 1;
> +
> +	return gd->ram_top;
> +}
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 986f951c31..3102de6cbb 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -145,6 +145,8 @@
>   #define CSR_MARCHID		0xf12
>   #define CSR_MHARTID		0xf14
>   
> +#define sync_is()   asm volatile (".long 0x01b0000b")
> +

I believe this instruction is also T-Head specific (at least my disassembler
doesn't know it). I doubt it belongs here.

Best regards,
Nils

>   #ifndef __ASSEMBLY__
>   
>   #define csr_swap(csr, val)					\
> diff --git a/board/thead/th1520_lpi4a/Kconfig b/board/thead/th1520_lpi4a/Kconfig
> index 622246127c..bef0638e80 100644
> --- a/board/thead/th1520_lpi4a/Kconfig
> +++ b/board/thead/th1520_lpi4a/Kconfig
> @@ -11,7 +11,7 @@ config SYS_VENDOR
>   	default "thead"
>   
>   config SYS_CPU
> -	default "generic"
> +	default "c9xx"
>   
>   config SYS_CONFIG_NAME
>   	default "th1520_lpi4a"
> @@ -30,6 +30,7 @@ config SPL_OPENSBI_LOAD_ADDR
>   config BOARD_SPECIFIC_OPTIONS
>   	def_bool y
>   	select ARCH_EARLY_INIT_R
> +	select RISCV_THEAD
>   	imply CPU
>   	imply CPU_RISCV
>   	imply RISCV_TIMER if RISCV_SMODE
