Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08877606A33B
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gzCrbbBV;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTqFJubD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE97F403D3;
	Mon,  9 Nov 2026 19:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VV6byl37nMn6; Mon,  9 Nov 2026 19:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3471404D0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794253893;
	b=PH84lrmbtYtp5zA46BVCGDsy9IThbN3xxEC6DF6eNc/yBcTCjHvBPHcSMK2gZbPf0FRa
	 7uUb2hh5QzjgyoyndK69UXy12wcFwXD/98conJWTZl6ljN/FSCHTGD93jFAuTiq22v/Yi
	 nsxejhNRI6aeLBRTRQ4R7ZNwt60BoyCtwdB+57Nu1ser3ciwR7iZZFoZibHElkR+0Rb3c
	 7ip80cEjj05ug+6BNIJgkRlHg79y8htAhZ90jlLzMUpYRuFWou1DdbSHqrrBsgp7V1yiF
	 vRo8hjW0iyC8OZkF218cE3vDyYJp04CYK1Nc9rdtuMJCYUtyS9tdGCKEjCuE3+BO1wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794253893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UYVf4/3bxYWC2e+l4uTgvyz6PDmK7zdGbSrQStzpzRU=;
	b=pMwHLhZztKtMXaByhn+ZHSIQLKAPDXenao2c02pcXE8BboPbDv0Seibep60OCd1cK2Sq
	 /YIlv8IvnEXJ8Pj+fTUD+bNDgG+/EzzMp8lFWmpiCzcHrJfrwqhe5UXqGFqbqS/PsQj5s
	 ciEhK1k2+HjqVEtRMN7qLCYUsfVKCCVvnRg/6frTQ646Vd2UWkScQ1jwHLMxINdbXsYv3
	 RTqKktxSYP2bzH+XUYgOx49fbJ7pv4nhabvIiGoXGmLiKlP1qP09cywWG6v9myEW7RwC4
	 Egu3x3ciw6uZIwxpjW/DI2NtBznNlhCQreYaDsI8gVmxVAyHHWm/OcoEgDjwXlec+5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794253893;
	bh=UYVf4/3bxYWC2e+l4uTgvyz6PDmK7zdGbSrQStzpzRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gzCrbbBVds78MO5dSE8tOM3wfIS/GTREff1cKa2Z2R5hmBzMeL3LMdJeKwu505F5/
	 O0fgu3w+23JQKB1FijQkZ5b9mm0aOMUAo0G3di+oi6zV7qNiORPBfBUJ4kyF+gNwqV
	 1Ci+m0AAoc8SzjmtGGAlLxBJ7eI8lf0KUnWi9z4h05bnQk+hHZDcXMhgsX/iUSHqlR
	 6qpQP6d5sgdicQTCWJDe3QPXHwFuBOwlD8wIT+H+OjrEVTxLzQAIGQHe1ZwedATQHk
	 pNs9F+kn6WE2S56ithiZNUr3dnUBSkDakO9syO8tHHk3nxmn5b/UVJewc05fU5FKcr
	 y/5scMYDRBgBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3471404D0;
	Mon,  9 Nov 2026 19:51:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A892235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C13180EED
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGsGEUCd4dAt for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:51:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05A2A80E00
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RTqFJubD
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05A2A80E00
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:51:30 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c49b431f022so212101366b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794253888; x=1794858688;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UYVf4/3bxYWC2e+l4uTgvyz6PDmK7zdGbSrQStzpzRU=;
 b=RTqFJubD/EvQZBi80GCEm7LLxN7/atwvDn9bLykc5X18oKDqDMb37EBt9ym10nOFO3
 21gIXQHRntgzO4AQ/FDltZfcuuq09efqdHquk8mEaJKN4J/SU4oqLp5HBTRSThQ5jJ/m
 ctHFvmAHDRXmhPE8PLhlkRvCWmpNFLnKvMus1IaMyrAAuMuwf1n1Hul3KCgYSm0GNI1e
 I9WG8DYdQUvyPICHHCo9CXv7e/pCCndlrkZPrz318/0AimyOnwvrGIg6r9MUmpf7X3Ex
 4dDSK1zZF+wFwTECdMQDkTd70qCCrN6aoJ+buJpBDTLzvn2knS/YT/IUoOqxdv0L/iiS
 4vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794253888; x=1794858688;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UYVf4/3bxYWC2e+l4uTgvyz6PDmK7zdGbSrQStzpzRU=;
 b=xu1zT886QY/hmpA2etlCfzO8i7DXoJ4ehoVkeZSEv3m5cf31TLRlyi3r8F5xN9VONJ
 njxbA4L3/75bpfujk8oLgAr3P2/4Hd0P92BE7ktY/qgCCBNfWiK+j5X6fXWeDdj5DP9A
 XuJEynsNk+pPhC9TKB2J9v4hyT9jHFM5pf6rCkaTrf/Wolbe6r4OEfFDtMTdQI4a/tFn
 AtfoQBmnkIL41pXkabqZ+ryAihNSxtTzc+B6ke2ntoiSienU1lAWe4oQjBDvTg7hpS4l
 AVux1DWLiVRD/RLLYptz9rNY+TdAX1Ye9/7+ULtTVIhwY9P8dIuGVzlNcz23ns/O83YJ
 twtg==
X-Gm-Message-State: APuU4Z/iLHa2uo4wMhk9741p0UXx39rm7GWL3bAW5vSS1Og5v4rRTdvr
 n5FhWYNgBnY8jvgV5GyG7itaDErDcLAcwhnywDxBmTOhyFsoXlMDMbQjg4CECzqoU0gOOk9sV86
 PO9aQ0zs8RDykmkOFtAAcbLw+5ePhppo=
X-Gm-Gg: AYBFou2h27sImZZE6TRSw7e86SGCizzSZov6W6/RXAzqc/YNnj18jVIR5ZtTiscdHER
 kiRt0GQ5VeGhZib/P/cmQnXa5RjXqm0rUPkWzaJVdIZpndnLzwqHIyI/iRBHVo/ol5osXigmCYF
 7Zh/ATxgPhx5oMg9Gfr/8dqNdJDL7l1Lv35cw7lhYK9pj5GAz0HtFF+f2PIAIXslc9lH1sR4KOe
 FFk+r1g89JrDdQ67es2SJre4s2/qYlanYf1W7fJ/X3eqF5dDztWM/6l7UTairErgut1n0lJ0VE0
 dyo7W5NstLP8C6QFvpJBcm/1XeqBGdT8j17jRG3buVqst2IxCNdU7m+/enUeYSKnwsryj1gk/cf
 27OvzXQB8p7myZxkPZD3g9mrkz/+ILS07itBHXA==
X-Received: by 2002:a17:906:f5a9:b0:c4d:331c:2e97 with SMTP id
 a640c23a62f3a-c50495f3c7amr31437166b.36.1794253888223; Mon, 09 Nov 2026
 11:51:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
In-Reply-To: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 9 Nov 2026 20:51:15 +0100
X-Gm-Features: AclHuK8Au4syKJzh91ArNJIKZMAO2GJxoL6fx6LBQktCW8oaQsDHCm2gw4RI8pU
Message-ID: <CAC928HZLjxgkuoyMaZa8jFimiVPTGX+hkuN6dppCJeFja9axYA@mail.gmail.com>
Subject: Re: [PATCH] block: add legacy block support for TPL
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@jo-so.de>, 
 Johan Jonker <jbx6244@gmail.com>, Denis Mukhin <dmukhin@ford.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Il giorno lun 9 nov 2026 alle ore 09:01 Ferass El Hafidi ha scritto:
>
> Legacy block support is only selectable for SPL. However it is
> useful in TPL too, where the full block driver (with DM and whatnot)
> will not fit.
> Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
> TPL. Note that it is hidden in menuconfig (just like the SPL variant).
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
> As I've been working on some TPL support for Amlogic I noticed that I
> could not choose the legacy block driver (while I could choose it for SPL).
> Given we only have 44K available, DM is a tight fit there so I'd rather not
> enable it where possible to save space.
>
> Adding the ability to select the legacy block driver in TPL seemed like
> a good option for the same reasons it is already available for SPL
> builds. And indeed it works just fine there too.
> ---
>  disk/Makefile          |  4 ++--
>  drivers/Makefile       |  7 ++++++-
>  drivers/block/Kconfig  | 12 +++++++++++-
>  drivers/block/Makefile |  2 +-
>  4 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/disk/Makefile b/disk/Makefile
> index c16876e2073..18b839f6ecd 100644
> --- a/disk/Makefile
> +++ b/disk/Makefile
> @@ -10,8 +10,8 @@ ifdef CONFIG_$(PHASE_)BLK
>  obj-$(CONFIG_$(PHASE_)PARTITIONS)  += disk-uclass.o
>  endif
>
> -# Must have BLK or SPL_LEGACY_BLOCK to support partitions
> -ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
> +# Must have BLK or LEGACY_BLOCK to support partitions
> +ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_$(PHASE_)LEGACY_BLOCK),)
>  obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
>  obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
>  obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 5403206159c..989be07cd02 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -74,7 +74,6 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
>  obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
>  obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>  obj-$(CONFIG_SPL_SATA) += ata/ scsi/
> -obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>  obj-$(CONFIG_SPL_THERMAL) += thermal/
>  obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
>
> @@ -82,6 +81,12 @@ endif
>  endif
>  endif
>
> +ifdef CONFIG_XPL_BUILD
> +
> +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += block/
> +
> +endif

What's the purpose of the ifdeffery? I would expect it to work with or without
ifdeffery exactly in the same way. If CONFIG_XPL_BUILD is not defined,
CONFIG_$(PHASE_)LEGACY_BLOCK becomes CONFIG_LEGACY_BLOCK which does not exists.

> +
>  ifdef CONFIG_TPL_BUILD
>
>  obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index d44cf4bcb6b..e6f1d82267b 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -15,7 +15,17 @@ config SPL_LEGACY_BLOCK
>         default y if SPL_AHCI_PCI
>         help
>           Some devices require block support whether or not DM is enabled. This
> -         is only supported in SPL. With this, the blk uclass is not used, but
> +         is only supported in SPL and TPL. With this, the blk uclass is not used, but
> +         instead a legacy implementation of block devices is used, with all
> +         devices consisting of 'struct blk_desc' records.
> +
> +config TPL_LEGACY_BLOCK
> +       bool # "Enable Legacy Block Device in TPL"
> +       depends on TPL
> +       default y if TPL_MMC || SCSI || NVME || IDE
> +       help
> +         Some devices require block support whether or not DM is enabled. This
> +         is only supported in SPL and TPL. With this, the blk uclass is not used, but
>           instead a legacy implementation of block devices is used, with all
>           devices consisting of 'struct blk_desc' records.
>
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index c827fa81a2d..e88914db283 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -6,7 +6,7 @@
>  obj-$(CONFIG_$(PHASE_)BLK) += blk-uclass.o
>
>  ifndef CONFIG_$(PHASE_)BLK
> -obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
> +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += blk_legacy.o

Should we have VPL_LEGACY_BLOCK too?
Right now, this breaks sandbox_vpl_defconfig build.

Regards,
Massimo

>  endif
>
>  ifndef CONFIG_XPL_BUILD
>
> ---
> base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
> change-id: 20261109-legacy-block-tpl-c5b09e42bc3f
>
> Best regards,
> --
> Ferass
>
