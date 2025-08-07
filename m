Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3B1C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5A5845C8;
	Thu,  7 Aug 2025 17:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rh3X/jIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64AB845C8; Thu,  7 Aug 2025 17:20:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E4D9845C5
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-458bf6d69e4so10834595e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754580045; x=1755184845; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVbhaCH4FKGpFN9dhwKq8d0wYmG/EYnsD9Q17932vRM=;
 b=rh3X/jIxfpltKFg4QA+S7BWGNXWbA2wLgvj2K7adxE9Krh3SJR9EUaeAcwTCl/2Xz1
 p9TKXKhlthqfOQ8pBmIy3+fgQf2rlT/43lTxgYCCWo7Ndls8lHaR1Xa/POBVoEe6/UPZ
 MqKFMinjb+1/yYFeH47oCuGOEmJBuBB5PIacyeK9Xzal5J+ZT2adZ0Ro/tUTX2izIYBs
 gxXvVd3sc2LoHltbqFw1gZhUyVNXT6eQ4cZDzRFtDouIYOdrbQHkmOsjMag2qk6Gipbd
 rLfff67+dRBsXvvmCYlXPELRQJV8alRNMcoV3ueNbGlYsw8AznwLC/tSlzUIpX+wkLIP
 usug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754580045; x=1755184845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVbhaCH4FKGpFN9dhwKq8d0wYmG/EYnsD9Q17932vRM=;
 b=KthXg9CRdgCqGaSPx732MCcC4xl4zIs+6E/eDZp5j8VkeN472h0w38+wSFLIVhwY9D
 s761vSrsg/X79MqLZAnxRf3+KgP1Dw0fVlrrEMXg5trllVodY3ppG/iHZ2BVSfNIfrqT
 h8LYc5V4IdZF2CaEjnM9jcIHpPtZl9q7Vnma1SA69enGFAs17m+v2oTKsAIrlgVmFPtY
 BvNCcjyVgnz3q6yD3UhEC3SEn9aPgec9f5FvHcukv4frcYIshqJ7ba1+tCrnsZ3YkcNQ
 YgBxc1ijzox7ViS96EUnxTH+FnP94u446HvJT+U6ZIUsH9izvOgvwIwMfPo+dYb+s73N
 og0A==
X-Gm-Message-State: AOJu0YxYGEUjQTJ7mDknecaezM00FoeetVIcL/f2SEsFAMg4beeOFiPP
 ZQ00N93wyZ6m2VBMS40jlKcYCT8QPE0f5aOZfLWU630XhoGxLqhy64xsC6Q8z+f4f0M=
X-Gm-Gg: ASbGncvhPwUB/oteuh0JcTMorDafKchS2T4XytUXnRMjKFJvqyf/vd8QKILglKIUBVy
 EF4l+YAQSXlMX8r1hsSXkTOEkKyXMRWAGSD+g0wWFHBOg5pZlBpTFrKbzO306+/V372TXPhefAM
 mtnsGOD5m+AmaCNCZL++xB0WqWOJVXCkoL3ichcIz5vqkrwNb98/fpu31lOohCKPCnN5Lp9SIhw
 dJMm4bqe4dzBqgd6CwLkomKbjJo0wFf4Bs/PpYkDUM09y47ICfWY7eBDet1EfXTfzOYyWpAjBMI
 XD4vPQgrrDFKP1IKJSRkfQT64kvkzH0dI2sxN6WgLwC9Y51gkY7DlrVrKTK6v5+9kHOE6hsLoWV
 NcONRzCi0LbM5liWUJLBnmm91oBDYrmlDt5EMQwRjPFyLhV9Wy2lJZPcxlMpUKdAYe2lNZ+QSqE
 j5OQ==
X-Google-Smtp-Source: AGHT+IE7Zu7kdJCWHPeJ5RpCFPEFv6qMcsPiSIs7mDoMFWMF9n52R6ALe69ow/y+TnsaVlCKU0PbJg==
X-Received: by 2002:a05:600c:3b8a:b0:456:f9f:657 with SMTP id
 5b1f17b1804b1-459f0261f59mr23858835e9.27.1754580045517; 
 Thu, 07 Aug 2025 08:20:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac51asm27744643f8f.1.2025.08.07.08.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:20:45 -0700 (PDT)
Message-ID: <da609352-e4de-4958-a257-66eb76d801ee@linaro.org>
Date: Thu, 7 Aug 2025 16:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: exynos: Fix always true test
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-clk_exynos-v1-1-fcedf6be444b@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723-clk_exynos-v1-1-fcedf6be444b@linaro.org>
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

On 23/07/2025 17:04, Andrew Goodbody wrote:
> In exynos7420_peric1_get_rate the variable ret is declared as an
> 'unsigned int' but is then used to receive the return value of
> clk_get_by_index which returns an int. The value of ret is then tested
> for being less than 0 which will always fail for an unsigned variable.
> Fix this by declaring ret as an 'int' so that the test for the error
> condition is valid.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/exynos/clk-exynos7420.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
> index 3aa751bf4e4..7de4e688f03 100644
> --- a/drivers/clk/exynos/clk-exynos7420.c
> +++ b/drivers/clk/exynos/clk-exynos7420.c
> @@ -192,7 +192,7 @@ static int exynos7420_clk_top0_probe(struct udevice *dev)
>   static ulong exynos7420_peric1_get_rate(struct clk *clk)
>   {
>   	struct clk in_clk;
> -	unsigned int ret;
> +	int ret;
>   	unsigned long freq = 0;
>   
>   	switch (clk->id) {
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk_exynos-b8ac6765f510
> 
> Best regards,

Are there any comments on this patch please?

Thanks,
Andrew
