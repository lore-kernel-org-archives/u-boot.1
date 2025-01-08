Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D246E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7738036B;
	Wed,  8 Jan 2025 15:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PcxgSRyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779C6803DC; Wed,  8 Jan 2025 15:32:00 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EBB8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so1801630a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736346717; x=1736951517; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N+nCc4DeAOAU8stWZu8jMXHLa0ZSbnliaqmZgi09YeE=;
 b=PcxgSRyYDSr78X74w0GvD0NUldeUFrX9dHxG9/EAIrYfhexuus3UHQZTY1XuJNrbJP
 C9Q0Utm84pPt1b9MUwsw7agr2qPOTt9YVyLX6z6k8rTCJHYVT1OUtS3HvhfuGw7OZeAf
 l2Va/nAi4/Ko1IfVdYtIE+mbozG27aq9wsADjFZKJTE41+XPirDQWGa4vMSoTa35byYo
 VPUA/P6FKhUA+oGwP7nmYWO7m6X2brkmt9FAQ7LogNIscWwbF6N1ZLIf/RNcxhyPnLlR
 p1yZudSkEy2WPvsA2jJqfYdCAfF3wwBCosVi97pgnNkHdnrNA2gamaiLBfIB7gq9SZ50
 r5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346717; x=1736951517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N+nCc4DeAOAU8stWZu8jMXHLa0ZSbnliaqmZgi09YeE=;
 b=bFcHXNx1zy8NfmrJ7FvGyaqDNW3BflYo94cfoWOT/5eLdsCcVt7qHOnYZdqsnwSNVx
 rhueqTmG3+elGncr1S8xieRijz2Vd5Sd/CQaxoKDGbEJ231oal5I73rDDuVAvLYdt3i5
 tOCaoaLsSNHF6QRjTrPWBzRrVwL1gTuqzIVmiUDluVfxVivDvHT25TUlNsVpEY3VIvxH
 aEay3OLmBMdXH6VktiEcXfIiohO6CacbGEefJOpfsrjwKmrLiZLrcCLQtiZerYYjCb6/
 bQaW1tDRzbjDf4E6+Yh2ZQF7eDVnlWmux51SoACEyuCw3OKDyArvyF8ODaD5dweyWryh
 IMhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJkOmw8hfJCHb/JtU8tEjsFaBy2+s8GXJWN303o82sY6cgaQGIGCuUZiFvwOoknpmzIjyrT4=@lists.denx.de
X-Gm-Message-State: AOJu0YzmRbR+vAj5X0YpXysKFIL/vPIdzerX2g/vKOrnHOB18zCMRZiQ
 azHMSbqITN2MZpvZ6y9R39NLmR20jTdWZ6rmSXWzjNk2RBps1CeSEfdavmIcntA=
X-Gm-Gg: ASbGnctONFEygjAdR7ZZl8EJRkVFdZfFt/dFJTGyY8stOovhPRStAnR+fEogPUxwbHl
 qMTPlJcsRTBQHuDmI4b11soXTkZ6C/m+9walo87e38VmG3vvqxphQU0+JY1M0gPjouyyuB58bmU
 WRlR7ETBfpvKIGfUIjqyPU0wz0yiAe5exR7WPLCgCJWkHDmJSBL1kpT4j5d37H4n6BKH8o2pqqf
 pN1EBe/TncdVlzQJviBlgQMW7db3LgRZFde4AVTSsAjRFN8ewrPd05tOWkORW0BGUUcfIOuJT/C
 btzUk7omtGTe3Ie1LJZo1UyFHQ8sIB/Mi4y805s=
X-Google-Smtp-Source: AGHT+IHrUVSI/aO6TLAvmI8EWGZWC6jQvJ1n6GHKO5raK2AP+dyn4alMx5LN6KE2THWpzFuPj3oOgg==
X-Received: by 2002:a17:906:4fd1:b0:aac:4f1:70bf with SMTP id
 a640c23a62f3a-ab2905017ecmr666578966b.12.1736346717490; 
 Wed, 08 Jan 2025 06:31:57 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e892bb7sm2478363966b.43.2025.01.08.06.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 06:31:56 -0800 (PST)
Message-ID: <be6dd684-8e2e-405a-a9aa-fa13283861a4@linaro.org>
Date: Wed, 8 Jan 2025 15:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk/qcom: Print more details about stuck GDSC
Content-Language: en-US
To: u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <20250108115911.4163437-1-alexeymin@postmarketos.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250108115911.4163437-1-alexeymin@postmarketos.org>
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



On 08/01/2025 12:59, Alexey Minnekhanov via groups.io wrote:
> Clearly say whether it's stuck during power on or power off.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks
> ---
>  drivers/clk/qcom/clock-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 25ca67e537d1..1cfc430c14a5 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -496,8 +496,8 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
>  					 GDSC_STATUS_POLL_TIMEOUT_US);
>  
>  	if (ret == -ETIMEDOUT)
> -		printf("WARNING: GDSC %lu is stuck during power on/off\n",
> -		       pwr->id);
> +		printf("WARNING: GDSC %lu is stuck during power o%s\n",
> +		       pwr->id, on ? "n" : "ff");
>  	return ret;
>  }
>  

-- 
// Caleb (they/them)

