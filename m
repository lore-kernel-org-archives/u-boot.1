Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03543C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1E382BCD;
	Mon,  7 Apr 2025 16:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fZFV2k8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F3082C55; Mon,  7 Apr 2025 16:30:49 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E951382B63
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3513477f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744036246; x=1744641046; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RVUp6yi4qu994R6bJuGzSnaGI/sMsPrXrkDdZckjcs0=;
 b=fZFV2k8JMhIhjB9DdEF84mYdU0p360echKb95iBCjAlpnBtvf04CnRv31nRZK58rEw
 gTiGiZ4wY5CTZzmCMA129+x+9mGdnds5ZqXOc/8eobYHHD1SjtKfWD7xKf/6z5x1gZ83
 5hAwqU77C8BkIEifZM5nUL3+gK9rTQRagHhNNbcGJuIVIeDjlgc6yp5SMtxpRJRsZI7a
 /nttF+gmpoiMo0RVB4FNnvgjkmuCXcTo7NEQoeiFJWuCmLC4x9kMHRpw0RMrCMaw9sSe
 bgLcP0oXzeEDSgNZeQf7ICYIflexmAJfRBUEqewJWaaQgsOe/Fw4lh4rVx9QHIz13KKu
 Q+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744036246; x=1744641046;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVUp6yi4qu994R6bJuGzSnaGI/sMsPrXrkDdZckjcs0=;
 b=F+IRoyQwgx59OZKv8freAMMos+9cjctaIjGm46nC1YktqjxEr2AZPCAF/Yfq1LJrAl
 KNjon1o+9Aekj0gScwjcaTirvnv8jSNKNj4PKO4EIVJFeZZRnk5ln25PSZPXFOdUembW
 ZDRgJFgu+L6c+ZqVg7gQEuiRiltPq/m3OWxRdTJWaBCJ4wiHUoJTwF3XW4PXVA1ky3No
 gdLaQVQv79VgYHgw6lXhnpsgfmPMWQ6eYscflEhCbbfpQX/4ZuoJZyTpjgHgA3fq0P0O
 dYQUMcBlD4TUztW4yKIq6VPfyW6RRQrEUvU6ZOnQQKCRCg8rm0+aXWGLKZ0GujUjNF87
 5Htg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8sdWDdAVPEfylmAJXYtX65Q1Skm83/01ODU9IjAkK6TH7+aIi+DwNNJLHVPR0TmHtFIoy4fg=@lists.denx.de
X-Gm-Message-State: AOJu0YyJZeWKob1X8jf39Z6iYedxAIuC26cFtJLiMGtGxz75v1BiZw43
 LAycHBp7N8+idAwuPnmUQejTqr1XaHPrSvIYJts889pMkM+e5o2nIO1gfVl+CGg=
X-Gm-Gg: ASbGncsLYzwyAFNaTa3qqmRHU0yh2kXYQfhDakL8zLsM4QH++DyJgQgHJgMfVs8aSzU
 1PNerQT7H3+heimXWFP9df560LpWgMLm2HrrnATAtvdGIw8MB4jh3DeGqzunkn6IosW0e8XxgAQ
 031FokF0QxT92Bzn/UCXL5PFrFgVme6teXnwP/IEpkhajuFZrlShNXBd6UGO197SWDAJpo1czu3
 hpCpzr3awPxx5AyUwEuq7TYGH1fR1yt9c+r5HWtGfOamzdmETjndCkBKf32XcnRAOJlRhALQhT/
 r9Rt0NCNYPew5BYCsk7KiyNIV8tAqSb+/rswYoHwAYjsMZs4h9qlY8cTocZ1rLJwPqSNchgvBtD
 92jFD/ynZo4o=
X-Google-Smtp-Source: AGHT+IFGLiLFRKMoIzSwcxrq3Ug7oqVqwZmr9CevZaLbHZZQ0cADDqxzYVuXioOYmnRuzJ8FoOO5Zg==
X-Received: by 2002:a05:6000:2211:b0:391:3207:2e68 with SMTP id
 ffacd0b85a97d-39c2e611194mr13191901f8f.9.1744036246402; 
 Mon, 07 Apr 2025 07:30:46 -0700 (PDT)
Received: from [192.168.1.47] (212-60-142-46.pool.kielnet.net. [46.142.60.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b33c2sm140670665e9.40.2025.04.07.07.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 07:30:45 -0700 (PDT)
Message-ID: <510b1e90-bf1e-4a7b-8a86-c8fbaf485fb6@linaro.org>
Date: Mon, 7 Apr 2025 16:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qcom_defconfig: Disable MMC HS200 mode support
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407132810.35149-3-sumit.garg@kernel.org>
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



On 4/7/25 15:28, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Currently the msm_sdhci doesn't yet support DLL configurations which are
> required to enable bus speeds greater that 100MHz. So disable HS200 mode
> support as of now as it requires bus speeds of 200MHz.
> 
> This should fix eMMC issues reported on RB1.

This fixes the write corruption issues? Nice find!!

Is this a problem on ALL Qualcomm platforms? the sdcard seems to work 
fine on other boards, would this reduce their performance?

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   configs/qcom_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index a2b54b95f19..537806450dc 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -81,7 +81,6 @@ CONFIG_QCOM_HYP_SMMU=y
>   CONFIG_MISC=y
>   CONFIG_NVMEM=y
>   CONFIG_I2C_EEPROM=y
> -CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_MMC_SDHCI_MSM=y

-- 
Caleb (they/them)

