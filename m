Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F4606A334
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nyBUSiVo;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XGQaLTfF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4E7C6062C;
	Sat, 21 Nov 2026 16:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4xrrnmcUo62; Sat, 21 Nov 2026 16:29:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE16960623
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795278573;
	b=BA1tb4iKUf7Ctceu4uFNbWLV6abimd2DsnLjMwb/b/rK+yD9OLOoblLRFYcq8VFMjaVb
	 zvA7BhjWtoUgnK2901qJ1Mc2xIaBjaf61f/uoDBdOV9z5txTdjVD/t5/fCyS3b+NZ4oyl
	 W5xYpRoE996p8Y5q0RdS647gCc80tuS21OJ5Bttdq5nf1d9mAVaiAB0Ic/qVYDvFQqQxz
	 3lnuwCMCCTTZw8zLFf1Sr1vpQTUzkMcMNH0mO0Z3/yuN2NtUNKP+T/XrLjIwHAgiyqcKI
	 lPWbIsLb5metfQaGDlRORYGYvmhQmg/VWWFK5LnQ7jmi2q5ezg/ukFR+InjW73qMlTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795278573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nWM4h1Dv3yiT4WADQfGcpsKMgfD8DbE4tE2BdCqiVmY=;
	b=RrV04otd/HsQg+zpOb5Tq0K69Nxl0kTaUpyyATyv+nSR/xALDh4f0se3HyfstK5yYb5/
	 avox9U9TTFybQ6ANcs2uv4gTeTQf3R3M/Iusc0FeCohh0W5ZlzswFshot+V46q9JXzKzZ
	 Vaaa2b3BK+y4nxpNO0dpsITD5XfMJ8eYSGagYfr/0GO0YrlH4LMDuPlQ8H5yCO1a++fHf
	 zAVGtko72fIKukYyaYQ0nI2Wl1eUrZVOmK6SCvQuBdt1E8L5sJSytzIE/REP06ZYrt792
	 OIesCuedVjUhBXBXL+pKmleUzIg0QAGEmTeTLdhU0FSd3UdQ3OdrvrDqazUHy2HcDGw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795278573;
	bh=nWM4h1Dv3yiT4WADQfGcpsKMgfD8DbE4tE2BdCqiVmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nyBUSiVopD+093EV1C7tEsfMRRQkYUtKbt1ukrA30w7OT7CIZuNB+w6d/AdxRiE4N
	 ffMc3oX/cd64smiKL/35oWTwG5mIcR/kc87N/bPGzJ76FEN7shRknGib2hmfNmn/92
	 2Wj5qKPcHb24mOvtPKnpYa968wUBqQXEr4FLhmhIs506L1brMorNsf6639WCCY26fC
	 MpRyaIBmNMIjL+ke0uYG6/bRiEjFwuMLP+sZ2rjUovZffC5rcksHjq5sDhzXNILkIk
	 b/6Ha3emUjPufJscVpPzaRLZx/lyqPwhj4HG0yEDtLxfmQJIQihjC1HiLbtVjCZaQj
	 5Khsevfzm4oSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE16960623;
	Sat, 21 Nov 2026 16:29:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3752E15D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 291B640688
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XG4FxBQUpw0r for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 16:29:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 285B240687
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XGQaLTfF
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 285B240687
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:29:28 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso18306985e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795278567; x=1795883367;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWM4h1Dv3yiT4WADQfGcpsKMgfD8DbE4tE2BdCqiVmY=;
 b=XGQaLTfFfzc5IdPy4SAoaEgNrX7FJyV7UDw3fHiPZ1Mr9V6LUZTz4oQwGWPRBbCzb/
 F8WUK45Ko5YghPpd4vtyZ2OjHM4taEKTwvCcGi3InlD//FYxKZ20NhwkmUJaXZTJcqqM
 5gfAWWm+40/8EIzm5ZWFQzQS/r7zKxsBR/iypPJouhWhiHW6Ou6RpYneNNbY9nB/vHuF
 sNsuCPgF97JDeDnp+LXgvWUlox0BdmZ8Rgm18ggQL0oC7K7+ZsiKoTfqI8P7dbBH+kor
 9vXH4E5klZ+TlupkJo8socUmSO37jvrxdT25vmeB8tYfF/XQBdubTLtNreesnndut5KK
 8eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795278567; x=1795883367;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWM4h1Dv3yiT4WADQfGcpsKMgfD8DbE4tE2BdCqiVmY=;
 b=fcljXXmhyptKUReuCuXjJslsVUAgVJyM1/Echcfx+w+QhQJzg1nt/p+P9SXpc7rnKo
 FFDB92IcZOhPHN39eLf25q7b4XuiY1iIg4RWgpT6uHAQOLHY3RylXbzzaAwyS3a8L1YJ
 adfbTERXIB1OhGDPohOeG0aIMJkXZ0is/2MhGtq3+q/4nkttRhxKwfK4IrQu7d1AJSC6
 aOanhy1B+BlxF83fubbfjUSnDQ5ecSYEaSfzlIG+pKN25VzYilMp4bx+ocx6xhcvUjRW
 plMXePqOjW9CN/8CIUcS+M7RfSwENm3/bPbrU0bIfIHggIh4ATpof9oUEdtuUwVi5He+
 uL4w==
X-Forwarded-Encrypted: i=1;
 AL+hErEpVLUAQfsWeGwtnIy20dGzK92zi0eOcr0t+j4cYc3Ca9sVOWasT1ZcqCA4fY4XSZsgQlbY66s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z87+RbZLsx/LhvYSHlFjvigHYoq12uAkIPpWJxtme96cyRxLo/i
 x8M1BIk+qy4A5+BmSg1R5MqTjVN23Dk7hEX1skIpUEB7FXIILasosMflX3ndQhRf81Q=
X-Gm-Gg: AZFdTZdzKN02xV2sbqnAavQ46HeTEJhsnZHA0lTHq8betg2D0k/SQgoT87JuGFbJ578
 7Nmv2ulEGkR7Ti9W7y0i1khgyHJcc0SCTVUK64QvR2gzhNl+Y4IDNGMiKtXIPH4suh1TIj3o3jb
 5eCcdctc8TvdxA8HiXL4ucVr7NOFRdfQFN1V6UVaPOn4oQKFLHv47HmGYEVavmV5J9LyZqbmTpl
 UZMPxVaCdN1srwqnt2c2aoDaQ67ONR4pfo3PhkhAH2ERzAHZyLH7zoI8Fxn6ofQXwiriMM/eqo9
 zuAxYuv4WyiyB5KjhHWs8Dc2xo5YcqYwfaXV19RPfmgs9b2jsTww33AzEnNqjYtPkEGBpIrABzE
 vUJbRyaxvuVeosS8jKYKs+3q0JX6XMtn+reO2yqkjlrqmnDmLxRwf0pi0nuYcBq5jOFcinsmTZu
 J/9ySk5PQUzmixUV3y8nVrFjGSce4bnFqWtMDrjauvkDwORVPo2afOjndzJR83IrCtwzX6iD1Sl
 vzG4w99xwPvtYLY/9TATdlsfDvDS73QxWZAxPKfF2alQ/QDmWzO8s0atrtE5ZaVmpW86iooDDYY
 25j510o39oWkll84gk8t2uZjkeLIVeRaM+z5ranAbYpSxMYlRJhQz1qahi8vBQ/yboGu4wRdd0W
 +rr2MvFIW1OB5
X-Received: by 2002:a05:600c:5395:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4bb8880ca2fmr142483275e9.20.1795278566787; 
 Sat, 21 Nov 2026 08:29:26 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm139507355e9.4.2026.11.21.08.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:29:26 -0800 (PST)
Date: Sat, 21 Nov 2026 17:29:21 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v3 1/2] arm: mediatek: enable the caches in SPL
Message-ID: <awHEzAIcwMkHvMIt@macbook>
References: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
 <20261120-std-upstream-mt8188-spl-caches-v3-1-b5ab70d56006@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-std-upstream-mt8188-spl-caches-v3-1-b5ab70d56006@beckhoff.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 17:29:18 +0100, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Running through spl without the dcache is very slow, especially when
> hashing or checking signatures.

[...]

> --- a/arch/arm/include/asm/arch-mediatek/misc.h
> +++ b/arch/arm/include/asm/arch-mediatek/misc.h
> @@ -14,4 +14,6 @@
>  #define APHW_VER		0x08
>  #define APSW_VER		0x0c
>  
> +void mtk_early_enable_caches(void);

nit: this should really be mtk_early_enable_dcache()

> +
>  #endif /* __MEDIATEK_MISC_H_ */
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index cdbcb6b3bc18..9e36b2a2c82d 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -221,6 +221,23 @@ config MTK_BROM_HEADER_INFO
>  	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
>  
> +config SPL_MTK_EARLY_CACHES
> +	bool "Enable caches in SPL"
> +	depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
> +	default y if TARGET_MT8188
> +	help
> +	  Enable the MMU and caches in SPL and disable them before
> +	  jumping to the next stage.

nit: same here SPL_MTK_EARLY_DCACHE

> +
> +config MTK_EARLY_TLB_ADDR
> +	hex "Address of the early page tables"
> +	depends on SPL_MTK_EARLY_CACHES
> +	default 0x401f8000 if TARGET_MT8188
> +	help
> +	  Address of the 32 KiB of page tables used while the early
> +	  caches are on. Nothing else may use this memory during that
> +	  time.
> +
>  config SPL_MTK_FIRMWARE_AB
>  	bool "MediaTek firmware A/B boot in SPL"
>  	depends on TARGET_MT8188 && SPL_MMC && SPL_LOAD_FIT && SPL_BLK
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 4b1524e5e2f1..55bf8790cc92 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
>  obj-$(CONFIG_XPL_BUILD)	+= spl.o
>  obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
>  obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o
> +obj-$(CONFIG_$(PHASE_)MTK_EARLY_CACHES) += early_caches.o
>  
>  obj-$(CONFIG_TARGET_MT7622) += mt7622/
>  obj-$(CONFIG_TARGET_MT7623) += mt7623/
> diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
> new file mode 100644
> index 000000000000..003393d2f681
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/early_caches.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MMU and caches before U-Boot sets up its final page tables
> + */
> +
> +#include <cpu_func.h>
> +#include <asm/global_data.h>
> +#include <asm/arch/misc.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* get_page_table_size() for the largest MediaTek mem_map */
> +#define EARLY_TLB_SIZE	SZ_32K

nit: MTK_EARLY_TLB_SIZE for naming consistency

besides the nits:

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

--
Carlo Caione
