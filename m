Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE565C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 11:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AA987C68;
	Fri,  2 Feb 2024 12:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aNZuv8R8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9219387C6D; Fri,  2 Feb 2024 12:11:49 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5472F87C64
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 12:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB59340C73
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 11:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706872306;
 bh=+ZXJU6/0eAmyQlQtLETNq2bMpt1v+NWYR2JmrcAhuyI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=aNZuv8R8RnR9yVrp4cSIuNz6arDdTZZdK8jX3OJNxKkwHiDq9PQpRRt+3UUdqpZQS
 2MYA0Ri6+9kcP1RqovI8ftSiSn24erwYhQ8GoQsmbv9aOz9L3GPmnKyn6wUa5Z+bOg
 zVQkfV0s9TPuohkBnvPZ+iYZKsEP1b4OVhH+7oGx3e9v3FXoA13UECRnRVkrDzqkE+
 8dFIZqhdQZesrllFNbqPUQaX9U0fGiHDAEfiEm40Nip9rc2/+K1NB2oaNnMTSj1atZ
 zMZlzo2R5cF4HfPbTfYkHb9PJezghp2d5ZmWimo6XFb/VwV/I+iwRXIJO98BBahLnr
 fTTy2kGr11Cjw==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-55fbf844bacso956748a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 03:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706872306; x=1707477106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZXJU6/0eAmyQlQtLETNq2bMpt1v+NWYR2JmrcAhuyI=;
 b=HYXnpM1LsiVn8sttAIMXJfQixuUhExgy2ypXny/NUtYYTCRYqwfaC1j7UpuY/jUrl9
 DnPQiiaw3AIiZ4GTEXuSNivDWiD77UlqJAFxcklxSDKaqrlifTTi6XXhifHUGwctPM2e
 lylFY/rsLZZT/YY+qJEeNNHpIif3prGfYgYKnb7hrgrjUgux9ANEB2cG3CHbvtTTRsrL
 D3lkiLRVQl6vFkSWk5E/k71kF8vVfN+kQcyMH6huptv6ZHQNjWwm8sR8jOGBVJnlA/Wr
 m0unKfIDR8D2S30Msl159e8aAMJkmg7Moxjg5an//On0Qx90uIHAn/+SOgncF92ntb3r
 ocVg==
X-Gm-Message-State: AOJu0YyMt5O6yol4vx/sB1D+relzFmX5mJJh8tja4MGF/EtROQx4cASU
 90DQHUoKAIG5bPXWMW9qwqk4sWv6CBs97lckS5iX8dtEte61sfEwDaXyPCtLfC186NjeXJBSVtq
 KjHTiJNTSoYOiPUH9RKUA9fIkTMMZ0fqmhfJTtTWGZ5gOQPmQCeM2Vhd9gcyhCqCYH3w=
X-Received: by 2002:a05:6402:b12:b0:55f:8054:93fb with SMTP id
 bm18-20020a0564020b1200b0055f805493fbmr5903936edb.29.1706872306528; 
 Fri, 02 Feb 2024 03:11:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM729EGqk21Y/tNjcQoS96Hrzi2CywMjCqYUt+SK+c1EjA0xXpyrbW0migQ9KTS+teAEUP3w==
X-Received: by 2002:a05:6402:b12:b0:55f:8054:93fb with SMTP id
 bm18-20020a0564020b1200b0055f805493fbmr5903916edb.29.1706872306140; 
 Fri, 02 Feb 2024 03:11:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVSPuNHIHe5AoIpFqIspPdUZpCddEf6PPwJMoLo/OfsG1wnliqTQBQCzkLe7/QieOdNWAfxfTDdQuFMWqS3zdgvMqCenS1wSiQJiwlH17nAjbkJaF6EmdJvz9/3oOb8pIHA+KvzH+gdw58kMPSl5mQAU0vC5D3d+fhWD0dcufhfr+6MAV3UKUi56XsliDAFUfPK6lOf1oW9tFN3SUQkITLx7irb+SNpkW03RceXWOJ3LYtUGc965K14RkgDxSivHsNFt557NbPnjjnPKAKeaH3ysTrTu+W/oULIoNIKNxdYkQ/9nMGWnCVoWwnYCQQ/PEnnSVoFrQMrtvLk2UZKzGiipEz4PZ+Y9PcoqlmjtAXm4me+/euw1F48JO+Ldd+IvEGyraNsR3k2GVSr
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 t14-20020a056402020e00b0055ef4a779d9sm718471edv.34.2024.02.02.03.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 03:11:45 -0800 (PST)
Message-ID: <8186f3b4-267c-4865-bee7-f59a49e5bea2@canonical.com>
Date: Fri, 2 Feb 2024 12:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: cpu: cv1800b: Add support for cv1800b SoC
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng@tinylab.org>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin <peterlin@andestech.com>,
 u-boot@lists.denx.de
References: <20240202093748.330658-1-seashell11234455@gmail.com>
 <20240202093748.330658-2-seashell11234455@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240202093748.330658-2-seashell11234455@gmail.com>
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

On 02.02.24 10:37, Kongyang Liu wrote:
> Add Sophgo cv1800b SoC to support RISC-V arch.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> 
> ---
> 
>   arch/riscv/Kconfig              |  1 +
>   arch/riscv/cpu/cv1800b/Kconfig  | 12 ++++++++++++
>   arch/riscv/cpu/cv1800b/Makefile |  6 ++++++
>   arch/riscv/cpu/cv1800b/cpu.c    | 22 ++++++++++++++++++++++
>   arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++++++++
>   board/sophgo/milkv_duo/Kconfig  |  4 ++--
>   6 files changed, 64 insertions(+), 2 deletions(-)
>   create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
>   create mode 100644 arch/riscv/cpu/cv1800b/Makefile
>   create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
>   create mode 100644 arch/riscv/cpu/cv1800b/dram.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ac52c5e6da..2c92b0d9f6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -93,6 +93,7 @@ source "board/xilinx/mbv/Kconfig"
>   
>   # platform-specific options below
>   source "arch/riscv/cpu/andesv5/Kconfig"
> +source "arch/riscv/cpu/cv1800b/Kconfig"
>   source "arch/riscv/cpu/fu540/Kconfig"
>   source "arch/riscv/cpu/fu740/Kconfig"
>   source "arch/riscv/cpu/generic/Kconfig"
> diff --git a/arch/riscv/cpu/cv1800b/Kconfig b/arch/riscv/cpu/cv1800b/Kconfig
> new file mode 100644
> index 0000000000..7225b1210c
> --- /dev/null
> +++ b/arch/riscv/cpu/cv1800b/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +config SOPHGO_CV1800B
> +	bool
> +	select ARCH_EARLY_INIT_R
> +	select SYS_CACHE_SHIFT_6
> +	imply CPU
> +	imply CPU_RISCV
> +	imply RISCV_TIMER
> +	imply CMD_CPU
> diff --git a/arch/riscv/cpu/cv1800b/Makefile b/arch/riscv/cpu/cv1800b/Makefile
> new file mode 100644
> index 0000000000..da12e0f64e
> --- /dev/null
> +++ b/arch/riscv/cpu/cv1800b/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +obj-y += dram.o
> +obj-y += cpu.o
> diff --git a/arch/riscv/cpu/cv1800b/cpu.c b/arch/riscv/cpu/cv1800b/cpu.c
> new file mode 100644
> index 0000000000..f13c18942f
> --- /dev/null
> +++ b/arch/riscv/cpu/cv1800b/cpu.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> + */
> +
> +#include <irq_func.h>
> +#include <asm/cache.h>
> +
> +/*
> + * cleanup_before_linux() is called just before we call linux
> + * it prepares the processor for linux
> + *
> + * we disable interrupt and caches.
> + */
> +int cleanup_before_linux(void)
> +{
> +	disable_interrupts();
> +
> +	cache_flush();
> +
> +	return 0;
> +}

Thank you for enabling another board.

The same cleanup_before_linux() code can be found in:

arch/riscv/cpu/fu740/cpu.c
arch/riscv/cpu/andesv5/cpu.c
arch/riscv/cpu/fu540/cpu.c
arch/riscv/cpu/generic/cpu.c
arch/riscv/cpu/jh7110/cpu.c

We should try to avoid this code duplication.

disable_interrupts() is already called by bootm_disable_interrupts().

flushing the instruction cache after loading a binary is not 
architecture specific either. This is why bootm_load_os() calls 
flush_cache().

It should be sufficient to let weak function flush_dcache_range() in 
arch/riscv/lib/cache.c call flush_dcache_all(). And then remove all 
cleanup_before_linux() implementations.

Best regards

Heinrich


> diff --git a/arch/riscv/cpu/cv1800b/dram.c b/arch/riscv/cpu/cv1800b/dram.c
> new file mode 100644
> index 0000000000..91007c0a3d
> --- /dev/null
> +++ b/arch/riscv/cpu/cv1800b/dram.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> + */
> +
> +#include <fdtdec.h>
> +#include <init.h>
> +#include <asm/global_data.h>
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
> diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kconfig
> index 2a458f291c..040a7487f1 100644
> --- a/board/sophgo/milkv_duo/Kconfig
> +++ b/board/sophgo/milkv_duo/Kconfig
> @@ -7,7 +7,7 @@ config SYS_VENDOR
>   	default "sophgo"
>   
>   config SYS_CPU
> -	default "generic"
> +	default "cv1800b"
>   
>   config SYS_CONFIG_NAME
>   	default "milkv_duo"
> @@ -23,6 +23,6 @@ config ENV_SECT_SIZE
>   
>   config BOARD_SPECIFIC_OPTIONS
>   	def_bool y
> -	select GENERIC_RISCV
> +	select SOPHGO_CV1800B
>   
>   endif

