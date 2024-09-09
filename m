Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A67EDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8759F88F2A;
	Tue, 10 Sep 2024 05:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AmpFgeCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543C4889B4; Mon,  9 Sep 2024 19:01:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2783288D08
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 19:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso11852725e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725901258; x=1726506058; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DZJikMAcxwWE2aw2RKNfyyewoqe6sj7RdH95sUzdQr8=;
 b=AmpFgeCuMOWaD85PAbLajmGYMM092HsLV6hjjyWPjJR/eWav9HpeVCXYcom+Mibosd
 wK8MzUl2YURUVxM4ce0fSiBcCDJVPtuzLOw7VdIyyEdzar1KYj6HY92QQLmLK6l4jD+u
 m4deDEH6t5q8MpBrNyY+EXEaqYzUZZAnGf06e/ngoSoSLKAFAfC1tqGSloVGszvuxQwd
 uA94nDqOpwUDQ0frECcARGM6lmSkKaww6xOQb/hGOzRFvOL+ftlFJJHP0h29oFSBfpGa
 dGHUnUIPDwhjSetXRFfZp1zn3XKII9usPvZ2aBfuFLKdbSIrXSSpRfG3456yMkbZk+tB
 /weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725901258; x=1726506058;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DZJikMAcxwWE2aw2RKNfyyewoqe6sj7RdH95sUzdQr8=;
 b=aKwu2DDzoxGLamWqnBZUJaEp6YpDUXeid73GSjJuiXlKW4XE6Jtd5eYlLhU+WWTtXv
 hQltghwzKE4JDIXhHPuaMbwNVIHeLVazpi6EOWbIJh9aWYhc7YJRPNRUIDqx97R6erGJ
 uEYfzJaO98Qb9qLqJaNC2VeXIG2x8Lng8oVIJTWJWdgDVZLrOvm9bY91jI6/c61039vl
 HLzDz+D5ZiXV29meqdz7CvUIW7V8XGmx6RIQqs6qsf5nTLR/w9NxQk0aqZ9Z4ToJ/3KZ
 I4vgDiQzoDJrlDM0SU+nO+q8V+ZffgPwFrxZ+Og2tay9ig1oyYMTMmvysBqV+OBVQvjo
 +8uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwnYKa8+ZRwFT8yPuzlRmSXDm1Kt4FFWdYVmwI0ZkckmwQ3pO/ZVEv6YTrkkc0ctk2WF3Gn0M=@lists.denx.de
X-Gm-Message-State: AOJu0YwCXw0P4Ras6iNshpFzb2nQqMgp+edKBh5TkqR5h1CW4Kwi2YXY
 xGvUIQgDghWwbtUuIiLWFiZ6otFPUzmqyurgy52fDnEpPUH68e6VPj8Dr4KC7ws=
X-Google-Smtp-Source: AGHT+IF95LsWLnMea4gGZBZl8JU9ouKVbgVJAPFNVgUSoWUmAXCxC0+S7ZxinIJRXeiMp1336AIEUg==
X-Received: by 2002:a05:600c:1d07:b0:42c:b4f1:f2ad with SMTP id
 5b1f17b1804b1-42cb4f1f3e5mr41159255e9.33.1725901258216; 
 Mon, 09 Sep 2024 10:00:58 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3796sm6469603f8f.80.2024.09.09.10.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:00:57 -0700 (PDT)
Message-ID: <62ea78e8-c834-4960-9e59-8e824cc6537c@linaro.org>
Date: Mon, 9 Sep 2024 20:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon 2Gb
 parts
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 tejas.arvind.bhumkar@amd.com, prasad.kummari@amd.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20240830000537.18862-1-Takahiro.Kuwano@infineon.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240830000537.18862-1-Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 05:19:45 +0200
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



On 30.08.2024 03:05, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> S25HS02GT, S25HL02GT, and S28HS02GT are dual-die package parts and do
> not support chip erase.
> 
Please split the patch and add fixes tag so that the fixes can be
applied/tracked easily. I already checked when those flashes were introduced

> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 88709a52b3..457965dad1 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -369,7 +369,7 @@ const struct flash_info spi_nor_ids[] = {
>  		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
>  		USE_CLSR) },
>  	{ INFO6("s25hl02gt",  0x342a1c, 0x0f0090, 256 * 1024, 1024,
> -		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
>  	{ INFO6("s25hs512t",  0x342b1a, 0x0f0390, 256 * 1024, 256,
>  		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
>  		USE_CLSR) },
> @@ -377,7 +377,7 @@ const struct flash_info spi_nor_ids[] = {
>  		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
>  		USE_CLSR) },
>  	{ INFO6("s25hs02gt",  0x342b1c, 0x0f0090, 256 * 1024, 1024,
> -		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },

one patch for these two changes please with the following fixes tag:
Fixes: c95a914aed7 ("mtd: spi-nor-ids: Add Cypress s25hl-t/s25hs-t")

>  	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
>  		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  #ifdef CONFIG_SPI_FLASH_S28HX_T
> @@ -385,7 +385,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
> -	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ) },
> +	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },

and another patch for this change:
Fixes: 16dd1095101 ("mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID")

With that feel free to my R-b tag on both:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>  #endif
>  #endif
>  #ifdef CONFIG_SPI_FLASH_SST		/* SST */
