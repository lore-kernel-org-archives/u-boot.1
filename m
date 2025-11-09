Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C8CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 12:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E8E83EDC;
	Sun,  9 Nov 2025 13:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pUoHH39T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52AD83EDC; Sun,  9 Nov 2025 13:31:31 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F7CC83B9B
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 13:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b728a43e410so466996766b.1
 for <u-boot@lists.denx.de>; Sun, 09 Nov 2025 04:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762691489; x=1763296289; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j7mByhbd6WtL/yfLkVu01VeuwNMpv6AIew0KTNOu3e4=;
 b=pUoHH39T7qLGYsR3RNJFJHqxEr6otWJm6JftWU4EHVy8G4V3xwa3Zarax933hBv32a
 iFMiaMXgDUq4T6idMif9lB8UNnSjp5EPBr1FxJcCEyGPNllAOr12ozBQykZUoljziuio
 b/afuL6uBWV5+ZKQJc6Ju5K2lLp7LjfSntynVS9BGh+XlpCNgPREgxwTU8KA9fPZkIQH
 JqTfYaqVrvE7bepxvM8mi6XtS2VgtL6/8J2MWTtifmq7pGuHFX4/g5+0UhltsBGGQUua
 dRDTBW23uZWWHQ5A5F5ECniN3KrTHm1b2GNV05KTIABuszQ0O0Z4FtKWm/UfmQB9/IVG
 F4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762691489; x=1763296289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j7mByhbd6WtL/yfLkVu01VeuwNMpv6AIew0KTNOu3e4=;
 b=MLgXPDxamz8XqMTx0FeTuj/lxEYYwBvLt6qkD/yxC8Uo/e1wXTPjmdv6jB30EvfLZY
 HLyhh52hFfy7ArFHuOLDxGnmwu7o0pzePKXxdtGVxalKayvth6aBe4JA71hoxd2tpiVv
 hig6h/nYVkmQu0dgzEcuL00CbrHFxpSqWvo9nn02fyqXPr0Lj0Dp5GexD/sZ1ZZQLHe8
 g0ZGalhXujHq/qVEsSUk3CQWM8en2V8eWWb4ml5Lv2Cf77YuwN0n5dACIWQdaWVBTyMd
 otqWcQMZQODDG6p5T+kTOtwC3jHHSFumveYT3eC1yuf7bEhnmmSlEnC8eKPlF6PeNPsl
 xHVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoz80HckR0DuzxEX8SvTJRl2T8rO4uKgxew9VPd3LghbA2NzLMmmbibJUX8rJynG4yT7MWw+I=@lists.denx.de
X-Gm-Message-State: AOJu0YyjsFSIkCvSRKtbMh4c0CqH2RdylNFq2BtVRsQGqmdBys8ISuCg
 AR4RW4kdqjAHXY7HUst1ZURX6SNS3r2Vzx+waIdxi3cg5zFm3HvpEr6ifMB5OepC8AQ=
X-Gm-Gg: ASbGnctDzltY4jChH+5msY1/Dn9ZIZov4vCwuDWdvl7lsVIQKbTMOary22F3mtSUcn2
 0YccVqXLTzNZoEjqd9Vph3F9NS/tN4Bo2XgARNIQ1AXKfMFsseQJSPcxHyVhxESvCKgfzV9QA9H
 a9CnJXp8PEwEMbjXjmvJcKQmyTOBMUMOcR/gCkjnNXNlWeosXOoyyimWAidK0otMMVIxw466DUK
 edWMixBcFuOBgwQW7GALWfJLlOgrOmhyoHUZ/TXDtNt6QuUUU0/BffFWQ/Cnt17QF5PeNMzas5o
 ctZ961fMWur0JkXdiLSwfxxyLZeAI9KrkJw7Y6KUcJ/JV8IFPgygu83W1FMPgLAGYeHFOKJWHYa
 N4wiF5CAKKBMhTCMxo7G6KOlz+REfpt0dYjHBcFTFCcFc8Utkdu48ay9R3Uic0MTnP5Bnzp1m2y
 090Y6nc2jJPbHcV92tqyU9dUbFgZNGldt3jjstth3nHjTo7pw9rqHjXmxgthDW8ahNMS1fFUDfO
 Bku8+lsyBJhslY1PU9z8k90lRK8fYF8DKcffClHGLoyLu6xgzAsSOh/p/J4Lh9a3g==
X-Google-Smtp-Source: AGHT+IEOQhHZ9mP3c+cH+fb2jb/qjZoFASdzp4tgxS94eYw1hPukCQsOu1b+altmlyVbntbVSH+iUw==
X-Received: by 2002:a17:907:96ab:b0:b72:588:2976 with SMTP id
 a640c23a62f3a-b72e0623e83mr514403966b.60.1762691488632; 
 Sun, 09 Nov 2025 04:31:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6?
 (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9be184sm781157866b.56.2025.11.09.04.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 04:31:27 -0800 (PST)
Message-ID: <3b7285d3-17eb-4c54-886c-872f26d1318d@linaro.org>
Date: Sun, 9 Nov 2025 13:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: capsule_update: Fix eMMC detection for
 non-UFS devices
To: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, ~postmarketos/upstreaming@lists.sr.ht
References: <20251107232935.283843-1-alexeymin@minlexx.ru>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251107232935.283843-1-alexeymin@minlexx.ru>
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

Hi Alexey,

Thanks for this detailed explanation and fix!

On 11/8/25 00:29, Alexey Minnekhanov wrote:
> Currently (since 2026.01-rc) on all SDM630/660 based devices this is
> printed, after observing long boot delay (several seconds) before
> executing preboot commands:
> 
>   QCOM-FMP: Failed to find boot partition
> 
> find_target_partition() function incorrectly assumes that eMMC is always
> at number 0. In general you can't rely on device numbering to determine if
> particular block device is eMMC or SD-card, because it depends on how
> aliases are defined in device tree "chosen" node. Some SoCs have MMC
> numbers starting at 1, not 0; so mmc1 is eMMC, mmc2 is SD-card.
> 
> Make eMMC detection reliable by using IS_SD() macro from mmc.h header.
> Using this method target boot partition can be found successfully.
> With debug prints enabled, this is printed:
> 
>   QCOM-FMP: skipped SD-Card (devnum 2)
>   QCOM-FMP: Capsule update target: boot (disk 1:60)
>   QCOM-FMP: DFU string: 'mmc 0=u-boot.bin part 1 60'
> 
> Without debug prints nothing is printed, no error about failure to find
> boot partition.>
> Fixes: fe80a5f80095 ("mach-snapdragon: CapsuleUpdate: support all boot methods")
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   arch/arm/mach-snapdragon/capsule_update.c | 28 +++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
> index 3699d91852d..586682434b7 100644
> --- a/arch/arm/mach-snapdragon/capsule_update.c
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -13,6 +13,7 @@
>   #include <efi.h>
>   #include <efi_loader.h>
>   #include <malloc.h>
> +#include <mmc.h>
>   #include <scsi.h>
>   #include <part.h>
>   #include <linux/err.h>
> @@ -80,6 +81,23 @@ static enum ab_slot get_part_slot(const char *partname)
>   	return SLOT_NONE;
>   }
>   
> +/* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
> +/*
> + * Determine if an MMC device is an SD card.
> + *
> + * @desc	block device descriptor
> + * Return:	true if the device is an SD card
> + */
> +static bool is_sd(struct blk_desc *desc)
> +{
> +	struct mmc *mmc = find_mmc_device(desc->devnum);
> +
> +	if (!mmc)
> +		return false;
> +
> +	return IS_SD(mmc) != 0U;
> +}
> +
>   /*
>    * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
>    * the slot status, and prioritizing the uefi partition over xbl if found.
> @@ -109,19 +127,21 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
>   		if (device_get_uclass_id(dev) != UCLASS_BLK)
>   			continue;
>   
> +		desc = dev_get_uclass_plat(dev);
> +
>   		/* If we have a UFS then don't look at any other block devices */
>   		if (have_ufs) {
>   			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
>   				continue;
> +		}
>   		/*
> -		 * If we don't have UFS, then U-Boot must be on the eMMC which is always the first
> -		 * MMC device.
> +		 * If we don't have UFS, then U-Boot must be on the eMMC
>   		 */
> -		} else if (dev->parent->seq_ > 0) {
> +		else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
> +			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
>   			continue;
>   		}
>   
> -		desc = dev_get_uclass_plat(dev);
>   		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
>   			continue;
>   		for (partnum = 1;; partnum++) {

