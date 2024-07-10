Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5362EC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 23:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC0888738;
	Thu, 11 Jul 2024 01:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCgUvx7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99CAD8872D; Thu, 11 Jul 2024 01:20:06 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F7528870C
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 01:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c6661bca43so161756eaf.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720653603; x=1721258403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2ijvrZzT8cXYcsNPx5TsQl01OrZPhHfu5BtRdUxd3g4=;
 b=SCgUvx7tdYNJiCi9VIZvPMq0fff9v2ruZBBd1b8SXsEpWtX5ULvTzd6aUT0XaR03py
 MBeLEQGaB36pxuRFNgTUthWmTwOha8btHZaoLNV4NUOgMIPGrBFj0poyInGT6Ic9+93k
 qHnYwHfAYPOpClcEzZTtkgGdelp92DAr0Q4G/7kWlL18/2Wx9OKPSeABqNoqEw/nFkK2
 Oe/meZWnEuKt5ykvVwsUz9zA4P94lws8GZN9k6E2QCxvnFKj9W6wsjei2fmPWl+W7Dlc
 ZH+IFqkTGZf5lfC2V3ZO3B14X7pbMaW3oZ4KA8chyKuQriXi5fn5m6bL/EawDLNexjmt
 Uqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720653603; x=1721258403;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ijvrZzT8cXYcsNPx5TsQl01OrZPhHfu5BtRdUxd3g4=;
 b=imtp1tMcLIVxRg4UZIr5s4QAnyw6lBH6CqBu/x5ObqKGTBZwreIeIvwjMcAokegw8H
 iVb0GqRZfKzX10xDpL0sPChuDZyPiisfpBNWomU9cRAeI1/schL/NQiALuJHdaxqYB3H
 eq7rK6Y33LrLoRybPHaw280QiZVQ9EeVl1xMcMxjS2//hB13OF4t1z6keAnsG5AmMcHd
 xYfbwI0k1MfqbPYGAVWelzul5P1Xt18EeMGQhMvEwClTeShWmcDxiEbPYVXitscL/6hi
 yNDMoHsaYOQoYdrSxxUZaPUTfkxUFphtj8hKRROq3qz15P0xgmW3giMiSrFMLQhGWTxd
 /Rkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/GSunA5NfUDrO9IcqQjAGKou5GxthYdadvp9mp4nuvtxICEPCRSYv7RKloEKwTW9OLe+TDEytfVwUfYwX7c2J+biOBA==
X-Gm-Message-State: AOJu0YxQOJ6Y6DljWVEG/BvMsqPKxgBUzvwJpSvAj+erV3aQxjSGuGY7
 Nl4VBPQYJwyNA6UjehcFvzWdLah67MnwKX96B4c5+lZbzySTlsF6
X-Google-Smtp-Source: AGHT+IEsXH3XgrHGbwJkkM6k3DOOaXXD1NsFsNspC9Ye1PRP/hleEj0cnB7VqQAQ2J1glmqhxv305w==
X-Received: by 2002:a4a:4e04:0:b0:5c4:396e:438c with SMTP id
 006d021491bc7-5c68dfaf8b9mr6269073eaf.0.1720653602935; 
 Wed, 10 Jul 2024 16:20:02 -0700 (PDT)
Received: from neuromancer. ([2600:1700:fb0:1bcf:4def:7e53:67cc:4ec0])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c7ad96b6ebsm477658eaf.4.2024.07.10.16.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 16:20:02 -0700 (PDT)
Message-ID: <668f1722.4a0a0220.666c8.2819@mx.google.com>
X-Google-Original-Message-ID: <Zo8XIXIeC/MmI+pN@neuromancer.>
Date: Wed, 10 Jul 2024 18:20:01 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Ryan Walklin <ryan@testtoast.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/6] power: pmic: sunxi: replace AXP717 SPL driver
References: <20240515234839.26898-1-andre.przywara@arm.com>
 <20240515234839.26898-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515234839.26898-4-andre.przywara@arm.com>
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

On Thu, May 16, 2024 at 12:48:36AM +0100, Andre Przywara wrote:
> We now have a generic AXP SPL driver implementation, that already covers
> the DC/DC converters of the AXP717 PMIC.
> 
> Remove the old, dedicated driver and switch to the new generic driver.
> This should not introduce any change in behaviour.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/power/Makefile |  2 +-
>  drivers/power/axp717.c | 92 ------------------------------------------
>  2 files changed, 1 insertion(+), 93 deletions(-)
>  delete mode 100644 drivers/power/axp717.c
> 
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 9d1f4c65262..6df23a81c29 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -14,7 +14,7 @@ obj-$(CONFIG_AXP209_POWER)	+= axp209.o
>  obj-$(CONFIG_AXP221_POWER)	+= axp221.o
>  obj-$(CONFIG_AXP305_POWER)	+= axp305.o
>  obj-$(CONFIG_AXP313_POWER)	+= axp313.o
> -obj-$(CONFIG_AXP717_POWER)	+= axp717.o
> +obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
>  obj-$(CONFIG_AXP809_POWER)	+= axp809.o
>  obj-$(CONFIG_AXP818_POWER)	+= axp818.o
>  endif
> diff --git a/drivers/power/axp717.c b/drivers/power/axp717.c
> deleted file mode 100644
> index 7c77c09ea8f..00000000000
> --- a/drivers/power/axp717.c
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * AXP717 SPL driver
> - * (C) Copyright 2024 Arm Ltd.
> - */
> -
> -#include <common.h>
> -#include <command.h>
> -#include <errno.h>
> -#include <asm/arch/pmic_bus.h>
> -#include <axp_pmic.h>
> -
> -enum axp717_reg {
> -	AXP717_CHIP_VERSION = 0x3,
> -	AXP717_SHUTDOWN = 0x27,
> -	AXP717_OUTPUT_CTRL1 = 0x80,
> -	AXP717_DCDC1_VOLTAGE = 0x83,
> -};
> -
> -#define AXP717_CHIP_VERSION_MASK	0xc8
> -#define AXP717_DCDC_1220MV_OFFSET	71
> -#define AXP717_POWEROFF			(1U << 0)
> -#define DCDC_DVM_ENABLE			(1U << 7)
> -
> -static u8 axp_mvolt_to_cfg(int mvolt, int min, int max, int div)
> -{
> -	if (mvolt < min)
> -		mvolt = min;
> -	else if (mvolt > max)
> -		mvolt = max;
> -
> -	return (mvolt - min) / div;
> -}
> -
> -static int axp_set_dcdc(int dcdc_num, unsigned int mvolt)
> -{
> -	int ret;
> -	u8 cfg = DCDC_DVM_ENABLE;
> -
> -	if (dcdc_num < 1 || dcdc_num > 3)
> -		return -EINVAL;
> -
> -	if (mvolt >= 1220)
> -		cfg |= AXP717_DCDC_1220MV_OFFSET +
> -			axp_mvolt_to_cfg(mvolt, 1220,
> -					 dcdc_num == 3 ? 1840 : 1540, 20);
> -	else
> -		cfg |= axp_mvolt_to_cfg(mvolt, 500, 1200, 10);
> -
> -	if (mvolt == 0)
> -		return pmic_bus_clrbits(AXP717_OUTPUT_CTRL1,
> -					1U << (dcdc_num -1));
> -
> -	ret = pmic_bus_write(AXP717_DCDC1_VOLTAGE + dcdc_num - 1, cfg);
> -	if (ret)
> -		return ret;
> -
> -	return pmic_bus_setbits(AXP717_OUTPUT_CTRL1, 1U << (dcdc_num - 1));
> -}
> -
> -int axp_set_dcdc1(unsigned int mvolt)
> -{
> -	return axp_set_dcdc(1, mvolt);
> -}
> -
> -int axp_set_dcdc2(unsigned int mvolt)
> -{
> -	return axp_set_dcdc(2, mvolt);
> -}
> -
> -int axp_set_dcdc3(unsigned int mvolt)
> -{
> -	return axp_set_dcdc(3, mvolt);
> -}
> -
> -int axp_init(void)
> -{
> -	return pmic_bus_init();
> -}
> -
> -#if !CONFIG_IS_ENABLED(ARM_PSCI_FW) && !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF)
> -int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -{
> -	pmic_bus_setbits(AXP717_SHUTDOWN, AXP717_POWEROFF);
> -
> -	/* infinite loop during shutdown */
> -	while (1) {}
> -
> -	/* not reached */
> -	return 0;
> -}
> -#endif
> -- 
> 2.35.8
> 

I've been using this for the past week or so on my RG35XX-H for which
I've been testing some code and it has worked well for me.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
