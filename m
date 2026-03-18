Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CE31088E4B
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 22:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09847836D3;
	Wed, 18 Mar 2026 23:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IAipHNZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C004583952; Wed, 18 Mar 2026 23:46:13 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB678352B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 23:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-464bc03efd8so275078b6e.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773873970; x=1774478770;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Glco6c0DU4OkSLyMsvJv8gTSlxTZSawaLH+mM1i3zRM=;
 b=IAipHNZEtZj1Wmcqk+2ATzYRUBHYGpI2jlsBQ4gILAlGYeqdXoFrHmx2cbJbf7Td6J
 aCffmI4t3+NhnPZ9ZjUNK9YWP4bPvIoLWF+aOy8Wp9sf57vdYB0Wsk7+MGmQ2xsixpu8
 ZGDAOGGmymly6uQuFn2icEiCobEPYl5BsYfYebIU7gLobXUQdjiXQ/s2vxEjN0yYWFm5
 9mWmkUfMVh0jHUiG9soVFcWjKBhyMreV/NcEGZudQbf4Nx8tq1qPHKfRXrySkB8/OPX9
 FIpgpJiqc00Iqe54IGFNaadhJ41n6AtgOh3sqGmPTpZnRTeuA5UJskaGq4Yiaki1arls
 XiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773873970; x=1774478770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Glco6c0DU4OkSLyMsvJv8gTSlxTZSawaLH+mM1i3zRM=;
 b=c3+8YwUkosa4j7usJ4Ay226i+BPZ46XhERTXcAaTN80WpGy1VpFAcCm/UTkpQNC/IY
 05J9GpXP6+N5XBDYdnApux/KxxmzeFL2nOB6HV7SrdPFZZ0LrdzXb6Axy3xEIBp6PoLj
 FhroYAstEQFhONVz3Ro1M9WAHLXbiTtXcNhj7RQJl94H43NGfTWn7rYGGjgGlxSG6pqi
 JQX5swuH37VEKRKFMB+GcfEhgUoILUz9vINJVAdnwaHcOBhC3WU8iRRCBoRmcvqo5D7p
 zUlA+50wayAE5V7QnKjR44/MY2O1zZu3d7jvdpmXwltIVGQ3mF/sgqBJ6OJTCgpwiEnr
 oYrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw6Bdm6JI92I7TD4G5hjruwdxcqugkzDJ2xcDgaeR3ToWDxp2RXGaKAWfNIssHnrZgrwBfMro=@lists.denx.de
X-Gm-Message-State: AOJu0YxCNuHXIEhAP+v7WhZlJ+OMvzaiZukY1axRXg4sUYrfWJXIBozR
 3mkQTePS0f5zgqebajiZmHGGtczVmvnXSzp5hau2Uo+msRYaH45BbHS5gDehXgShuyE=
X-Gm-Gg: ATEYQzwIWqxz2DmmBTybT85tSKrKWbn4RR7gm44EnYeSSMI/K0+puog/8GzSXI4GET6
 X9Wwc5Bt6dw23UoT9JjHyalI0NYKrp0wmZ/aez3ILf/8gHrk0Yj5l75tqgi1a6mzs5TGLrFjWV7
 WIHqJIwsXPOCpdgIDcgdrNO+WHu+U6Ye8KpVcL2b5Ab2fQzOo9ZZLxkNQce5iny1o78f0yX2/BV
 vj7MDQGAOKrvcf2SOgkqr0D9eNwFi5KlJoHQRF5IMLYmRctsx68bzfoT1lm6qggkTQJgCTR2bvq
 Yxa/fH0SSFezfCvK6OsFpSCcOPv5Z5KM2zqQvMEEWwCAT6keSFF7WVq6n61FuwQdudZ+VUTPgd6
 z0vds7WGd2XmWS7CVrMcqcFw/LGoxv367dSyPJIy5adl9w5g8PD92rQaLMFg4VWeerKN4THWHIV
 YuZ1fmyqEwt3ow6cZQ4b+e7HzCg/8rE1r72ufD7bOvDx7hpu4RwpbtELlWKvXODimS8/si38BfN
 C9qlHDwyOCB
X-Received: by 2002:a05:6808:4f62:b0:467:2926:1252 with SMTP id
 5614622812f47-467ba241d27mr3121366b6e.30.1773873969811; 
 Wed, 18 Mar 2026 15:46:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:244c:fc8c:8216:1344?
 ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467cb465136sm1015140b6e.0.2026.03.18.15.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 15:46:08 -0700 (PDT)
Message-ID: <f2545bf9-3709-40fd-8d0b-b68f4d841d02@baylibre.com>
Date: Wed, 18 Mar 2026 17:46:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm: mediatek: add support of MT8189 SoC family
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
 <20260310-mtk-mt8391-initial-support-v2-2-1dc862d58532@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-2-1dc862d58532@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

On 3/10/26 7:16 PM, David Lechner wrote:
> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> 
> Add TARGET_MT8189 for MT8189 and similar SoCs.
> 
> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/mach-mediatek/Kconfig         | 11 ++++++-
>  arch/arm/mach-mediatek/Makefile        |  1 +
>  arch/arm/mach-mediatek/mt8189/Makefile |  3 ++
>  arch/arm/mach-mediatek/mt8189/init.c   | 58 ++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 671a6cb1cad..b5b06f4e5b2 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -93,6 +93,15 @@ config TARGET_MT8188
>            USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
>            several LPDDR3 and LPDDR4 options.
>  
> +config TARGET_MT8189
> +	bool "MediaTek MT8189 SoC"
> +	select ARM64
> +	help
> +	  The MediaTek MT8189 is a ARM64-based SoC with a dual-core Cortex-A78 and
> +	  a six-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
> +	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
> +	  and LPDDR5x options.
> +
>  config TARGET_MT8195
>  	bool "MediaTek MT8195 SoC"
>  	select ARM64
> @@ -201,7 +210,7 @@ config SYS_CONFIG_NAME
>  config MTK_BROM_HEADER_INFO
>  	string
>  	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
> -	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8195
> +	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
>  
>  config MTK_TZ_MOVABLE
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index d1f64d61ab9..35f748a70d6 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_TARGET_MT7987) += mt7987/
>  obj-$(CONFIG_TARGET_MT7988) += mt7988/
>  obj-$(CONFIG_TARGET_MT8183) += mt8183/
>  obj-$(CONFIG_TARGET_MT8188) += mt8188/
> +obj-$(CONFIG_TARGET_MT8189) += mt8189/
>  obj-$(CONFIG_TARGET_MT8195) += mt8195/
>  obj-$(CONFIG_TARGET_MT8365) += mt8365/
>  obj-$(CONFIG_TARGET_MT8512) += mt8512/
> diff --git a/arch/arm/mach-mediatek/mt8189/Makefile b/arch/arm/mach-mediatek/mt8189/Makefile
> new file mode 100644
> index 00000000000..886ab7e4eb9
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8189/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier:	GPL-2.0
> +
> +obj-y += init.o
> diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
> new file mode 100644
> index 00000000000..80910810668
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8189/init.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> + */
> +
> +#include <fdtdec.h>
> +#include <stdio.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +	int ret;
> +
> +	ret = fdtdec_setup_memory_banksize();

Enabling debug messages shows that this is setting
gd->bd->bi_dram[0].start and gd->bd->bi_dram[0].size with
junk values.

```
setup_memory_banksize: DRAM Bank #0: start = 0xe51ff004, size = 0xe51ff004
```

I believe gd->bd has not be assigned yet at this point. And we are
setting these values later in dram_init_banksize() anyway. So we should
be able to drop this call.

> +	if (ret)
> +		return ret;
> +
> +	fdtdec_setup_mem_size_base();

Should check return value here.

> +
> +	/*
> +	 * Limit gd->ram_top not exceeding SZ_4G.
> +	 * Because some periphals like mmc requires DMA buffer
> +	 * allocated below SZ_4G.
> +	 *
> +	 * Note: SZ_1M is for adjusting gd->relocaddr,
> +	 *       the reserved memory for u-boot itself.
> +	 */
> +	if (gd->ram_base + gd->ram_size >= SZ_4G)
> +		gd->mon_len = (gd->ram_base + gd->ram_size + SZ_1M) - SZ_4G;

It looks like this code is not actually acting as the comment says
that it should.

> +
> +	return 0;
> +}

The solution should be to replace it with:

phys_size_t get_effective_memsize(void) {
	/*
	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
	 * mmc requires DMA buffer allocated below SZ_4G.
	 */
	return SZ_4G - gd->ram_base;
}

> +
> +int dram_init_banksize(void)
> +{
> +	gd->bd->bi_dram[0].start = gd->ram_base;
> +	gd->bd->bi_dram[0].size = gd->ram_size;
> +
> +	return 0;
> +}
> +
> +void reset_cpu(ulong addr)
> +{
> +	if (!CONFIG_IS_ENABLED(SYSRESET))
> +		psci_system_reset();
> +}
> +
> +int print_cpuinfo(void)
> +{
> +	printf("CPU:   MediaTek MT8189\n");
> +
> +	return 0;
> +}
> 

