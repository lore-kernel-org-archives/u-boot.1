Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3749CC001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 06:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9401F875A8;
	Sat, 21 Oct 2023 08:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMXH3Eh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3E8875A9; Sat, 21 Oct 2023 08:34:20 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976C98756F
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 08:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c515527310so22028611fa.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697870048; x=1698474848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbC8h87UzfIRhyP1Qyy4557yzyg0hbjTmbjmrlFgJJI=;
 b=IMXH3Eh5t/+FQMqo3T84l9rD85VQE8J4OWUTCoqzqIYQ2J6xpSzOAHuh67hfX7wyNv
 2Q0G83F/kj9CbzGP+0zQjiNPvZ/kIWVbLxLeVLvvpeMfsI9B7f09q/l9kVNvuH5x5prp
 eKW9+ekErwG+fyIkVzesmJHEwZrQugIYAl7YSFNjotPbep++qZ4/SrkLV2SR0Vz6orMH
 Okv0TRvwl9LqisT+BFpOr4I6fPqhu5QKu3o4UcxzkxEjbJdgnS91iRGIkOOSpYN6OVDC
 QOTzY10hHNIoDJxUIJ1kbEAVZs17OrgQs4DODVEvLufbqocLRCf/00WfI/Ndt8zD2Vos
 lImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697870048; x=1698474848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbC8h87UzfIRhyP1Qyy4557yzyg0hbjTmbjmrlFgJJI=;
 b=AKQUXvPvIjRnu0khjgJJTW+KV7NP5fknmqpMSZzhopA/1i1cp262b2DCT/upJluCTb
 /mdTkl3tRWbkM0oStrrku/SfrliCWcSKb59IUC+9Z/9eQEGLSg9ShNAB8yUZ/kt0OFZf
 OU7xqvmWb9Se4khlfbMQL8AZFDE4lQXhjQ2/y3hGfv1f8igddJoXsQqP0nDEW3X01kWe
 uBpzIkoGh9QPDrjqXcq01pRi0tm+XEbR2FhJ0cO7gBEy+WFwOsLCcgW8JkheYbx/6iVi
 x9B0ABGIohO7lMAiO/YrQavlPUlGCjNA0Qn8qvMXgEOTjayUxXLV0A+3FfyZWEMGj/ID
 veaw==
X-Gm-Message-State: AOJu0Yzg34z3ve+1+06IYCuurC17UaTczlCpkuiZsvs+vwGSAa6ZFWFT
 rHkmSYB/thyhObPWxALEzJnghksxkU72mg==
X-Google-Smtp-Source: AGHT+IFehPW9UTf/d6o2gWO/RK9QDYe3YJqOmgQwojr59juPzciY/jFMsGBIp9X054loBe0wM/89/Q==
X-Received: by 2002:a05:651c:b20:b0:2c5:2298:d44e with SMTP id
 b32-20020a05651c0b2000b002c52298d44emr3017644ljr.5.1697870047739; 
 Fri, 20 Oct 2023 23:34:07 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b003fefb94ccc9sm3773524wms.11.2023.10.20.23.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 23:34:07 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, SASANO Takayoshi <uaa@mx5.nisiq.net>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
Date: Sat, 21 Oct 2023 08:34:06 +0200
Message-ID: <1965267.usQuhbGJ8B@archlinux>
In-Reply-To: <20231018155014.383566-2-andre.przywara@arm.com>
References: <20231018155014.383566-1-andre.przywara@arm.com>
 <20231018155014.383566-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Wednesday, October 18, 2023 5:50:12 PM CEST Andre Przywara wrote:
> So far we have a convoluted #ifdef mesh that guards the early AXP PMIC
> setup in board.c. That combination of &&, || and negations is very hard
> to read, maintain and especially to extend.
> 
> Fortunately we have those same conditions already modelled in the
> Kconfig file, so they are actually redundant. On top of that the real
> reason we have those preprocessor guards in the first place is about the
> symbols that are *conditionally* defined: without #ifdefs the build
> would break because of them being undefined for many boards.
> 
> To simplify this, just change the guards to actually look at the symbols
> needed, so CONFIG_AXP_xxx_VOLT instead of CONFIG_AXPyyy_POWER.
> This drastically improves the readability of this code, and makes adding
> PMIC support a pure Kconfig matter.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  board/sunxi/board.c   | 32 ++++++++++++++------------------
>  drivers/power/Kconfig |  2 +-
>  2 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index ebaa9431984..65d79a02c25 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -597,50 +597,46 @@ void sunxi_board_init(void)
>  		}
>  	}
> 
> -#if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
> -	defined CONFIG_AXP818_POWER
> +#ifdef CONFIG_AXP_DCDC1_VOLT
>  	power_failed |= axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
> +	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP305_POWER)
> +#ifdef CONFIG_AXP_DCDC2_VOLT
>  	power_failed |= axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
>  	power_failed |= axp_set_dcdc3(CONFIG_AXP_DCDC3_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP209_POWER) && !defined(CONFIG_AXP818_POWER)
> +#ifdef CONFIG_AXP_DCDC4_VOLT
>  	power_failed |= axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
>  #endif
> -#if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
> -	defined CONFIG_AXP818_POWER
> -	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
> -#endif
> 
> -#if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
> -	defined CONFIG_AXP818_POWER
> +#ifdef CONFIG_AXP_ALDO1_VOLT
>  	power_failed |= axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP305_POWER)
> +#ifdef CONFIG_AXP_ALDO2_VOLT
>  	power_failed |= axp_set_aldo2(CONFIG_AXP_ALDO2_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP152_POWER) && !defined(CONFIG_AXP305_POWER)
> +#ifdef CONFIG_AXP_ALDO3_VOLT
>  	power_failed |= axp_set_aldo3(CONFIG_AXP_ALDO3_VOLT);
>  #endif
> -#ifdef CONFIG_AXP209_POWER
> +#ifdef CONFIG_AXP_ALDO4_VOLT
>  	power_failed |= axp_set_aldo4(CONFIG_AXP_ALDO4_VOLT);
>  #endif
> 
> -#if defined(CONFIG_AXP221_POWER) || defined(CONFIG_AXP809_POWER) || \
> -	defined(CONFIG_AXP818_POWER)
> +#ifdef CONFIG_AXP_DLDO1_VOLT
>  	power_failed |= axp_set_dldo(1, CONFIG_AXP_DLDO1_VOLT);
>  	power_failed |= axp_set_dldo(2, CONFIG_AXP_DLDO2_VOLT);
> -#if !defined CONFIG_AXP809_POWER
> +#endif
> +#ifdef CONFIG_AXP_DLDO3_VOLT
>  	power_failed |= axp_set_dldo(3, CONFIG_AXP_DLDO3_VOLT);
>  	power_failed |= axp_set_dldo(4, CONFIG_AXP_DLDO4_VOLT);
>  #endif
> +#ifdef CONFIG_AXP_ELDO1_VOLT
>  	power_failed |= axp_set_eldo(1, CONFIG_AXP_ELDO1_VOLT);
>  	power_failed |= axp_set_eldo(2, CONFIG_AXP_ELDO2_VOLT);
>  	power_failed |= axp_set_eldo(3, CONFIG_AXP_ELDO3_VOLT);
>  #endif
> 
> -#ifdef CONFIG_AXP818_POWER
> +#ifdef CONFIG_AXP_FLDO1_VOLT
>  	power_failed |= axp_set_fldo(1, CONFIG_AXP_FLDO1_VOLT);
>  	power_failed |= axp_set_fldo(2, CONFIG_AXP_FLDO2_VOLT);
>  	power_failed |= axp_set_fldo(3, CONFIG_AXP_FLDO3_VOLT);
> @@ -649,7 +645,7 @@ void sunxi_board_init(void)
>  #if defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER
>  	power_failed |= axp_set_sw(IS_ENABLED(CONFIG_AXP_SW_ON));
>  #endif
> -#endif
> +#endif	/* CONFIG_AXPxxx_POWER */
>  	printf("DRAM:");
>  	gd->ram_size = sunxi_dram_init();
>  	printf(" %d MiB\n", (int)(gd->ram_size >> 20));
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 7f3b990d231..83cb31c937a 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -180,7 +180,7 @@ config AXP_DCDC3_VOLT
> 
>  config AXP_DCDC4_VOLT
>  	int "axp pmic dcdc4 voltage"
> -	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || 
AXP818_POWER ||
> AXP305_POWER +	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER 
||
> AXP305_POWER default 1250 if AXP152_POWER
>  	default 1200 if MACH_SUN6I
>  	default 0 if MACH_SUN8I

This patch is great, but this last change doesn't seem to be directly 
connected?

Best regards,
Jernej



