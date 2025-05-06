Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D80C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 11:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587FE8219D;
	Tue,  6 May 2025 13:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOsGEVWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3303828F8; Tue,  6 May 2025 13:20:52 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D43820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 13:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac289147833so1023070966b.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746530450; x=1747135250; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tjg8F3b0d6w/5G9fS3Uy7B1yn+qrARfFwhWzidfsFqQ=;
 b=oOsGEVWcIAjLIw40WM/UTkMkvSKolSWcIx8Uky/IXv+R9uE8rGhtWb5g/NTxfAYPjg
 IE2ddi0FKyg57SfhCirqUEe4aFEM0le7XILcmN9m+JwFZBP2N1Ld6RVCt48pwLinGSaF
 OvLIQJaQrMK4sTrkQ/vr6J1L6Uo1LlGDgAEYOAvgUAFSpvdnqFXr+8KesZhEZg1FAiMt
 KztjoVjQpNCxb2GZViVJSGMnLM0EyUrmQU09rgeNp2XRYlfbyYD2V5Ys22+w5+UK8I45
 dy5s6HgMiCbKa0Fxm8/COdU4IDNPPy3SqQMzV2TCpBcSXusf5E3JXZoUBcFyY+n+Ivm8
 lsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746530450; x=1747135250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tjg8F3b0d6w/5G9fS3Uy7B1yn+qrARfFwhWzidfsFqQ=;
 b=xRprcbslml0kFqVyQu2NjsDsCCM3pnBx6+7pMMIiUtfbTYwjzT1+wqvRry2eyw64V7
 KI5XQZ1KrM3tRQB/XPmPPyclR1qRcSmEBtd8nBOBnVvdBGhzw81Bt48E4XZXh2exsrDG
 8Fp9+FV6/ZJCU9LX+ZbTMLHwiOt+6s93xNfd6GnIJKDvjcHaohsbmmaEL3zWQrQA0OtJ
 owJV0GynFc/8P6D4HPV2YYnmbTfxqvSwYelcXHcPjfzMpS+6CglYPI8J0QWW0rU9oEJI
 uFFaFKdTCGFkUrlbNxoXSYnhi2sxfmFN5UwVH6QxKoLYgNPmt9xEpggNZuaE20Ysxl1I
 XIjQ==
X-Gm-Message-State: AOJu0YxLoF84l2fFHZzHolprbHKriV8a/y9IQs+aNPgve8C/fGjSG8kT
 hs8B5lPlOmaC0MH/JpOIIl+vr/hSkUwO6qCafx3JpdrbjmmqEQFbXtbUghMsBiM=
X-Gm-Gg: ASbGnct1+aSkwvH6A2NMUfDihwIEFPAzzaZf3HZiJG/xS5zr+1vCl7P1lB0MTecPwVX
 5TA9z/g49RiK3IVi7M7eRasPO4kUlraWcMZXB5BI3OuH/6m57xX0i5fZYQfV7251ZlqOgboKSp3
 glJCTwkVIGff0ZSfZSY4sKxe7tGUgmkOO7EGFWpX664gFlEy8N+cn3V3KgG64AboBJN0g8GzCKS
 1fGIZ3MvaQhqF9vfJoOZBxDyXZ2mWB+swh6tHJ/nknoPmp/LNQkpS1tv38OdLy9gACX58eYzVc9
 ctSEm4ZFPyDzWQaQwkD+6KIlYpDVnyIVr1toCw1RZ/qIVPHK
X-Google-Smtp-Source: AGHT+IF2l4AJwlZTbLq0nTeFZxVsmzy1TSvxsCFQYVAHwTYiS24cwMuXTDYtWtfwpj4ZgH5H2OkeDA==
X-Received: by 2002:a17:907:7f8b:b0:ad1:8d47:f5a1 with SMTP id
 a640c23a62f3a-ad1d327b0c8mr298101966b.0.1746530450209; 
 Tue, 06 May 2025 04:20:50 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c031dsm676294566b.116.2025.05.06.04.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 04:20:49 -0700 (PDT)
Message-ID: <1be04cd1-5de6-4cc4-96cf-9c90b9a76df1@linaro.org>
Date: Tue, 6 May 2025 14:20:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] watchdog: at91sam9_wdt driver enhancement
To: Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
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

Hello Zixun,

On 4/28/25 12:16, Zixun LI wrote:
> This patch series includes some code refactor and adds new device support
> for at91sam9_wdt driver.
> 
> Instead of add a new driver like Linux kernel, at91sam9_wdt driver is
> extended as new watchdog variant is similar to existing one, especially
> for the function subset used by u-boot.
> 
> 1. Remove typedef struct and rename variables for readability.
> 
> 2. Add SAMA5D4 compatible, it has the same watchdog as SAM9260 except a
> new lockout feature is added. Currently this feature is unimplemented.
> 
> 3. SAM9X60, SAM9X7 and SAMA7 series have a new watchdog variant, some
> bitfields bof MR register shifted their position, a new register is added
> for timer value.
> 
> 4. Add DT node to SAM9X60-Currently board
> 
> It has been tested on SAM9X60-Currently board:
> - Start & stop
> - Set timeout from DT node
> - Reset kick in with a while(1) loop
> 
> Changes in v4:
> - Move 'timeout-sec' to at91-sam9x60-curiosity-u-boot.dtsi
> 
> Changes in v3:
> - Merge relevant commits into one
> - Match DT node with Linux
> - Move default timeout from board dts to sam9x60.dtsi
> 
> Changes in v2:
> - Fix SPL build
> 
> Zixun LI (7):
>   arm: at91: wdt: Remove unused at91_wdt struct
>   arm: at91: wdt: Rename regval in priv data to mr
>   watchdog: at91sam9_wdt: Rename priv to wdt
>   arm: at91: wdt: Add SAM9X60 register definition
>   watchdog: at91sam9_wdt: Add SAM9X60 support
>   ARM: dts: sam9x60: Add watchdog DT node.
>   ARM: dts: at91: sam9x60-curiosity: Enable watchdog node
> 
>  arch/arm/dts/at91-sam9x60_curiosity.dts    |  5 ++
>  arch/arm/dts/sam9x60.dtsi                  |  7 +++
>  arch/arm/mach-at91/include/mach/at91_wdt.h | 25 ++++++----
>  drivers/watchdog/at91sam9_wdt.c            | 55 +++++++++++++++-------
>  4 files changed, 68 insertions(+), 24 deletions(-)
> 
> --
> 2.49.0
> 
> ---
> Zixun LI (6):
>       arm: at91: wdt: Remove at91_wdt struct
>       arm: at91: wdt: Rename regval in priv data to mr
>       watchdog: at91sam9_wdt: Rename priv to wdt
>       watchdog: at91sam9_wdt: Add SAM9X60 support
>       ARM: dts: sam9x60: Add watchdog DT node
>       ARM: dts: at91: sam9x60-curiosity: Enable watchdog node
> 
>  arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi |  4 ++
>  arch/arm/dts/at91-sam9x60_curiosity.dts         |  4 ++
>  arch/arm/dts/sam9x60.dtsi                       |  8 ++++
>  arch/arm/mach-at91/include/mach/at91_wdt.h      | 25 +++++++----
>  arch/arm/mach-at91/spl.c                        |  4 +-
>  drivers/watchdog/at91sam9_wdt.c                 | 55 ++++++++++++++++++-------
>  6 files changed, 73 insertions(+), 27 deletions(-)
> ---
> base-commit: 10f48365112b164bee6564033ab682747efcb483
> change-id: 20250417-wdt-da6560c1b258
> 
> Best regards,

Since you sent the patches apparently there were some changes in the
tree, and now smartweb_defconfig fails.
Could you please check and maybe resend ?
I was ready to apply these but hit this issue.

Thanks,
Eugen

