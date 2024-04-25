Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48586C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FF888F58;
	Thu, 25 Apr 2024 14:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dn6UJ9CC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C2688EF4; Thu, 25 Apr 2024 08:17:59 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84A388EF2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34665dd7610so292367f8f.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714025877; x=1714630677; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fseIrtNvG70enn6fAockWlbu7Au9zwJd8St3tDx/hoY=;
 b=dn6UJ9CCrJfCSNuF8hG23bYF8bKcCyMYrdysPWeCNJ+fUAaBjDNHsP9YJfpm7SIX/u
 GqvH8CarSLiXNBRO9HAh7lsJo7U74TFMIe+CexTmankusFIO6UPqCw5ElI/Y2djPevGE
 uN7/diMhaYW03iZblbM6ZcIyONvlD7+NFuQO09l5Nbb6heX3mbcBabOWpxuuJNSWyQc+
 +vzknqE2B8yrQmaxL0I6nQCaAvBy9fQNHOkSUQEm/u26ACY6P6Ywl09SXsayVCxBsr97
 J35oxFU8wtmbrClnzw8eKfjATWaDlgax1KZbwR1bZqDfJbursRd9/2xSAEn0NcGmpbP9
 0yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714025877; x=1714630677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fseIrtNvG70enn6fAockWlbu7Au9zwJd8St3tDx/hoY=;
 b=Y0KX7fz5UK3arfLCDmbrnfLAiu/Wju90j+bJsh26PqKiyUA0XkevRqxdTxyqjIpkVB
 kXlfQP2Mb9sYF1xwyANm6thJXiuEh+/AOWwCSuirhhItMH64fpQF51VHGf6dyfOBI8U+
 CQCITX0JfdUisbzMIwF5rjseCY7nrQPs9S48aig1+vZu8tIvSJXJQM8mbM0t/vu36vr/
 OxruapLlu629ho7t2wJt4IqTtKPEfAkMVrhdsheKFqfB06oHQH7NfuDNXPZr3CeoZQaS
 Of1on/IBaW2ktYuUIAXU/6rOjW36wCgQec9cqYFewOO/OoEgBmgg1FPolHRWyOZyX2Tn
 56EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwZtogZ2yKY42MbXslt3/ykN4gzsncUzRKXp5XUMbHSAG+A8gW820TNIex6sBVC68VysbbahQ3CMaqMpndncKHUwiORA==
X-Gm-Message-State: AOJu0Yy8vM3Bzi0b4Oc4f4U91Srrjrutv3ETALCSIuhxZvoUpQfb/3dX
 DX1v+AuN6d+u1iSoy7WXpgo0LaB2i5p4/yWhHWRHsaMBRZxjtAHPUGXEXfdohrU=
X-Google-Smtp-Source: AGHT+IHTA3kz5mjLUr8hQXssCr13r1pdk0VJ5aVv3ZPoqk+abMFbDR6J9bvOoULDLNQWzlROjyGX1g==
X-Received: by 2002:adf:f585:0:b0:34b:962c:e144 with SMTP id
 f5-20020adff585000000b0034b962ce144mr3046230wro.53.1714025877384; 
 Wed, 24 Apr 2024 23:17:57 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a5d40d0000000b00346406a5c80sm18919041wrq.32.2024.04.24.23.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 23:17:56 -0700 (PDT)
Message-ID: <c37104fa-1261-41e7-a685-02d06abc3d5b@linaro.org>
Date: Thu, 25 Apr 2024 07:17:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mtd: spi-nor: Check nor->info before setting
 macronix_octal_fixups
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, d-gole@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 JaimeLiao <jaimeliao.tw@gmail.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
 <8bd7edaaeefd69eb9bf2fa469ddbaeebd2433013.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <8bd7edaaeefd69eb9bf2fa469ddbaeebd2433013.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 25 Apr 2024 14:32:02 +0200
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



On 4/25/24 05:52, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> The macronix_octal_fixups should be set only when mfr and flags match.
> 
> Fixes: df3d5f9e41 ("mtd: spi-nor: add support for Macronix Octal flash")
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: JaimeLiao <jaimeliao.tw@gmail.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 1bfef6797f..c2d2ddf0c8 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -4003,7 +4003,9 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>  #endif
>  
>  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
> -	nor->fixups = &macronix_octal_fixups;
> +	if (JEDEC_MFR(nor->info) == SNOR_MFR_MACRONIX &&
> +	    nor->info->flags & SPI_NOR_OCTAL_DTR_READ)
> +		nor->fixups = &macronix_octal_fixups;

we still have the mfr checks in u-boot, sigh.

sounds sane:
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>  #endif /* SPI_FLASH_MACRONIX */
>  }
>  
