Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D058CCD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292B38822B;
	Thu, 11 Apr 2024 14:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YmjmlVTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454AB88244; Thu, 11 Apr 2024 14:20:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAEB87E47
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a46ea03c2a5so134428066b.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712838041; x=1713442841; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZRuN9ITnnFJ7BN2bEAbha3KCYr2Xx3bPIOxShXj1ycs=;
 b=YmjmlVTFqjzUmE2d0GFU67TyE7xOniVhQC7DSjSwlLB4/b/UQTVAd49SiZKOOpFp72
 1LL2WD75P16nGbaWJxQCuyoJQfZqMI1KLljQGKwtQzSp4u58GIgP7a93H8pkVPrG5bF4
 Tbj6OjgUOnPx38/o6LUm+t0krQ4JLOWF4XD4ninxAg0DpWFHDwXCSQb1vFYBr0noY0uv
 1uLe3Oi07/u5cvHHil4rEpjsgPL45iknwAuHXA0BmSf7AuNiPQahwrJ+veBWLAY8EmsF
 5imI1vm3ldQ0+yjM21fhrNfgeoxizCGLQOH2lCCr0l5fqzJ7toWwA8htaXPOD1YDpO+w
 aHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712838041; x=1713442841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRuN9ITnnFJ7BN2bEAbha3KCYr2Xx3bPIOxShXj1ycs=;
 b=m1MllLAvPdB/faSBhq8wsWcACE3jC2c1BNnq2CUgwfDqFHPvgyHULWO62LbLkGH933
 Sy0ACbkHrPx47HXRqhmCR+Sqo+SjmLT5prbf96qSJtjT3ZmpBvbZ/XmvS9H77nRcscdU
 5+1/QwoUHvk3mdyVJxpgxNS7Uc5jLL2FmGmsV3mtngFM7HkCLklRvk1326VE8gxOy43T
 Gl6XaY6ksM2nuxJB5FTqYcRJJVw31hpDYlWCr17B0h9lDPHEHB+Lq/T8suw44RRGdV9n
 /trrIppSiN9YXSLapA3fIucTH7Ikok9qBofo1TWSB+W9LRdcflpx32byAXFicBr8W/kJ
 6G9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp44jjCccgYT4ljqLnQL3Fte/KYI6YB9YqTalN+juRjZYCElwkqJcmrkxicYhcFvUPyBHmEldEtuFab85krHdQWjoaHQ==
X-Gm-Message-State: AOJu0YyLoBg1DkP1HDxtpTn7QvhnnuyZo6q9QFgFJUsyq6+Qq+g1wD8G
 OHFmdQ9XfQyJLYYnhm68MJLO+9zvcSwBdc3p4qYSuUHrWeG0vVQ2zthRnz3ibBUKv8sT+L2PQrE
 n
X-Google-Smtp-Source: AGHT+IHkirHMc4CeSK4nmhJiEURgAvV9kwhhG36K59P8EZqyRnFoRQpTV28f7QzKRhzPs58j0RpztQ==
X-Received: by 2002:a17:907:1c2a:b0:a4e:410e:9525 with SMTP id
 nc42-20020a1709071c2a00b00a4e410e9525mr2390804ejc.30.1712838041537; 
 Thu, 11 Apr 2024 05:20:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::570d? ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 gv15-20020a170906f10f00b00a517995c070sm703673ejb.33.2024.04.11.05.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 05:20:41 -0700 (PDT)
Message-ID: <1ba79d58-8bf9-413d-845b-b91133a166e7@linaro.org>
Date: Thu, 11 Apr 2024 14:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: Allow other board vendors apart from Qcom
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, stephan@gerhold.net
References: <20240411115116.344595-1-sumit.garg@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240411115116.344595-1-sumit.garg@linaro.org>
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

Hi Sumit,

On 11/04/2024 13:51, Sumit Garg wrote:
> Qcom SoCs derived boards can come from various OEMs/ODMs and not just
> Qcom itself. So allow CONFIG_SYS_VENDOR to be set correctly
> corressponding to the actual board vendor.
> 
> Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Kconfig  | 15 +++++++++------
>   configs/dragonboard410c_defconfig |  1 +
>   configs/dragonboard820c_defconfig |  1 +
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 96e44e2c549..4615a140d0d 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -4,7 +4,11 @@ config SYS_SOC
>   	default "snapdragon"
>   
>   config SYS_VENDOR
> -	default "qualcomm"

Can you keep the default rather than adding it to the defconfig?

With that

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> +	string "Snapdragon board vendor"
> +	help
> +	  Allows to specify vendor for the Snapdragon SoCs based boards.
> +	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
> +	  will be used as the custom board directory.
>   
>   config SYS_MALLOC_F_LEN
>   	default 0x2000
> @@ -19,12 +23,11 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   	default 0x80000000
>   
>   config SYS_BOARD
> -	string "Qualcomm custom board"
> +	string "Snapdragon SoCs based board"
>   	help
> -	  The Dragonboard 410c and 820c have additional board init
> -	  code that isn't shared with other Qualcomm boards.
> -	  Based on this option board/qualcomm/<CONFIG_SYS_BOARD> will
> -	  be used.
> +	  Allows to specify the Snapdragon SoCs based board name.
> +	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
> +	  will be used as the custom board directory.
>   
>   config SYS_CONFIG_NAME
>   	string "Board configuration name"
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 260a8349d3b..3b6f50307a3 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -1,4 +1,5 @@
>   CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="qualcomm"
>   CONFIG_SYS_BOARD="dragonboard410c"
>   CONFIG_COUNTER_FREQUENCY=19000000
>   CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
> diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
> index ebc80eb2a46..a795497ef5d 100644
> --- a/configs/dragonboard820c_defconfig
> +++ b/configs/dragonboard820c_defconfig
> @@ -1,4 +1,5 @@
>   CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="qualcomm"
>   CONFIG_SYS_BOARD="dragonboard820c"
>   CONFIG_COUNTER_FREQUENCY=19000000
>   CONFIG_ARCH_SNAPDRAGON=y

-- 
// Caleb (they/them)
