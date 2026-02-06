Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70CEEB28FE
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 09:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF668382A;
	Fri,  6 Feb 2026 10:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="V5J/2rCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1A983A64; Fri,  6 Feb 2026 10:20:22 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02BEA836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 10:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.ferraris@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1770369619;
 bh=aWRon7vje8RFGeouo80GZ5n8BYoYljc+8H8A4NN0lPA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V5J/2rCAU+qqzS3GQNstfQnY2UHsEpt0ue+fh7sotn6RZKRpoBHx6qaf7kXYymm0x
 hh3gql79NdP1DZxvsdcpq6IKkA714EU/yBz0JbWozjZ1LCKDx4NAFi+CnhRdyF1hwl
 JHT29VrTLXuzQtnheYpI0MQzejGCs6XqEyMBWDv7JW1u42CV939WcDOZt0DHvD8h/q
 x7dlpfFXSC0ofSz6iy6p//cb7qLn3qiCOFTUSdxGiKoBTh1SjlVEo2OgcTuTaBiLCv
 zHSEfdQoz5c3gsj85uYF8i/wfGNDbgee0wSYO7U+VEFOkp5NBFanSXiEXdJ5qs+ELu
 srGREixbQXYaA==
Received: from [IPV6:2a01:e0a:212:79f0:be92:a52a:153f:7a60] (unknown
 [IPv6:2a01:e0a:212:79f0:be92:a52a:153f:7a60])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2810417E114C;
 Fri,  6 Feb 2026 10:20:19 +0100 (CET)
Message-ID: <50bceec0-6fe9-4e91-ba1c-57b2cdca7c7b@collabora.com>
Date: Fri, 6 Feb 2026 10:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm: mediatek: consolidate ARMv8 memory maps
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
 <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Content-Language: en-US, fr
Autocrypt: addr=arnaud.ferraris@collabora.com; keydata=
 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
 L9jD4jU=
In-Reply-To: <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi David,

Le 06/02/2026 à 00:51, David Lechner a écrit :
> Consolidate all mem_map definitions for MediaTek ARMv8 platforms into a
> single file. The size of the DDR and MMIO regions can vary, so Kconfig
> options are added to configure them by target.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   arch/arm/mach-mediatek/Kconfig                     | 21 ++++++++++++++++
>   arch/arm/mach-mediatek/Makefile                    |  1 +
>   .../arm/mach-mediatek/armv8-mem-map.c              | 14 ++++-------
>   arch/arm/mach-mediatek/mt7622/init.c               | 20 ---------------
>   arch/arm/mach-mediatek/mt7981/init.c               | 21 ----------------
>   arch/arm/mach-mediatek/mt7986/init.c               | 21 ----------------
>   arch/arm/mach-mediatek/mt7987/init.c               | 21 ----------------
>   arch/arm/mach-mediatek/mt7988/init.c               | 21 ----------------
>   arch/arm/mach-mediatek/mt8183/init.c               | 20 ---------------
>   arch/arm/mach-mediatek/mt8512/init.c               | 21 ----------------
>   arch/arm/mach-mediatek/mt8516/init.c               | 20 ---------------
>   arch/arm/mach-mediatek/mt8518/init.c               | 21 ----------------
>   board/mediatek/mt8365_evk/MAINTAINERS              |  5 ----
>   board/mediatek/mt8365_evk/Makefile                 |  3 ---
>   board/mediatek/mt8390_evk/MAINTAINERS              |  6 -----
>   board/mediatek/mt8390_evk/Makefile                 |  3 ---
>   board/mediatek/mt8390_evk/mt8390_evk.c             | 29 ----------------------
>   17 files changed, 27 insertions(+), 241 deletions(-)
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index d1d2605b2cc..33717a1864f 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -130,6 +130,27 @@ config TARGET_MT8518
>   
>   endchoice
>   
> +if ARM64
> +
> +config MTK_MEM_MAP_DDR_SIZE
> +	hex "DDR .size in mem_map"
> +	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188
> +	default 0xc0000000 if TARGET_MT8365
> +	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
> +	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
> +	default 0x20000000
> +	help
> +		Target-specific DDR region size in mem_map.
> +
> +config MTK_MEM_MAP_MMIO_SIZE
> +	hex "MMIO .size in mem_map"
> +	default 0x40000000 if TARGET_MT7622 || TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8512
> +	default 0x20000000
> +	help
> +		Target-specific MMIO region size in mem_map.
> +
> +endif
> +
>   config SYS_BOARD
>   	string "Board name"
>   	default "mt7622" if TARGET_MT7622
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 44591bed6fa..17e645989e5 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier:	GPL-2.0
>   
> +obj-$(CONFIG_ARM64) += armv8-mem-map.o
>   obj-y	+= cpu.o
>   obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
>   obj-$(CONFIG_XPL_BUILD)	+= spl.o
> diff --git a/board/mediatek/mt8365_evk/mt8365_evk.c b/arch/arm/mach-mediatek/armv8-mem-map.c
> similarity index 55%
> rename from board/mediatek/mt8365_evk/mt8365_evk.c
> rename to arch/arm/mach-mediatek/armv8-mem-map.c
> index 41a6febf03d..0abddb99f25 100644
> --- a/board/mediatek/mt8365_evk/mt8365_evk.c
> +++ b/arch/arm/mach-mediatek/armv8-mem-map.c
> @@ -1,22 +1,18 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2023 BayLibre SAS
> - * Author: Julien Masson <jmasson@baylibre.com>
> - */
> +// SPDX-License-Identifier: GPL-2.0-only
>   
>   #include <asm/armv8/mmu.h>
>   
> -static struct mm_region mt8365_evk_mem_map[] = {
> +static struct mm_region mediatek_mem_map[] = {
>   	{
>   		/* DDR */
>   		.virt = 0x40000000UL,
>   		.phys = 0x40000000UL,

This should be configurable as well: for now, all supported platforms 
have their DDR space starting at 0x40000000, but on MT8196 (which I'm 
currently working on) it starts at 0x80000000.

Best regards,
Arnaud

