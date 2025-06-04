Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0735C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1938070C;
	Wed,  4 Jun 2025 15:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G1j1xnC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFD9807B1; Wed,  4 Jun 2025 15:15:12 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC12F80584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451e24dfe1aso22907595e9.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749042910; x=1749647710; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9S6XnaA3REJM8qrmW/xD3lhvxJ4SQ8LXmsjhZFEWEdI=;
 b=G1j1xnC2UhbnAyt44gndUli/ho9yKUD0fOeZJH9jpV7TD4tXMiiETKACheAVZUq0xO
 PY3c84i8OWat2p/N+iyZxlnLYze12NS3FwY7kYbLOLb+peRHO9madoW5BiwUNEgtD9Gq
 qyhjftv8zpaGgYa/o38FX7MccASYSHQ5FGjrLaYB17OnbW05vR69V/sqkpY1QCP1cV/r
 L4WGfnSG4p+wWx8SjtdIDR9zl4GUuLRs7rWpbNqeYs254lUpsBbXLFsVaLfQNaCurCV5
 nGDhYLQeERU2BQUJ/TJ39asKUtw07+daNWdK8dLYEoedTvfIXYt/yU1wSThjnwyqz4/Z
 /vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749042910; x=1749647710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9S6XnaA3REJM8qrmW/xD3lhvxJ4SQ8LXmsjhZFEWEdI=;
 b=MlNoiFLxryRYcGF9jVy/MVkCbikHvLyIw/JaO5dOTd0/2CrDa8gBlmBbfCus7PYPmi
 ptCwOEXpdPCTtcl17zwNrrOhsxieoCeC8YLy5iDGe4fJC7M/+8/FU2Zn3w9cxeCZvel5
 Miv6IX+TKfw2nE8d45/fodnZejs7k/WQ2Y6i2nm0gan4/QX5t0sjJW7J4gOV/pqXNxyi
 EGsfbemHLXbtFrFaySUd90eIzEvXhM6BcY536UlpchNL8XCZb6PdG5OraQBYd5D7DFiG
 5Q3H7sPT5JlwEV2euzLZNBbfNlXciJHf2Ff+Foko9plEPWMXfPoHSRO5hYteNmvpnVYz
 iTiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfZW536JtuX0aiqI2qdiwAGsvw1dQI2Jun6WhC26LBzhYJONBsHUL+/6knGwb97sv0ZHwp1zc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4pmKUdUqLj+uDeoF3yRGY3AWSHJJjrsMSX6zJSqpeV+gufSyR
 Z7MeECflxCHvHeV9q38uAwMGQka3TQQZw8AbBFxyYYTfagtf4c7mcMFBW73B1Zlaebk=
X-Gm-Gg: ASbGncs27uCvT1oJ3j4hd68kxdYVVzrSrn6LGPZRYfUZ37FoploAVk62FTIU55zjaFs
 KYQpJusmanfhXXTae/+secXjUzVuuB4THMTIL1myydVN21f93ZG6QFWhFkQ021zp6OtSDr6T47V
 oCB/JZWkgMT2rpf1laUk+GJGS3mqQ9Cp6skHe/Ywp0G3sHidI6BE7GKxsma3aGeGvYq4oLqK/+9
 cTMDV0CBGXuneAr+VpLQIDN6IkMzamFWbU8zWcnHclrHptbwhCCZZyxbkviarPNEUfT33R9O1b9
 2mICAFG4/8DegdFX2fN3TACBHl6wGZE8lAcLb5zRe4KdIGDRtJYIj8OmFUnVahf1j51LuV1dZbk
 8RjBDnBEmZYHzMftHwTUzG5hcaVAqlgcw+w+W6HUkVw==
X-Google-Smtp-Source: AGHT+IFciRu7m6H67zaL253/cH4HNE3VNSU5q1kI/wl5yvUCk+BDY304sAx+DACqOjBZjCKdqvwkNw==
X-Received: by 2002:a05:600c:8288:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-451f0f2fc9dmr30750255e9.10.1749042910190; 
 Wed, 04 Jun 2025 06:15:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:64de:66a4:ac83:8698?
 ([2a01:e0a:3cb:7bb0:64de:66a4:ac83:8698])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000f3esm202219245e9.23.2025.06.04.06.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 06:15:09 -0700 (PDT)
Message-ID: <4d363f54-63b1-441f-b64b-a10c47a85edb@linaro.org>
Date: Wed, 4 Jun 2025 15:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Correct condition for init_cache_f_r()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250604130923.1484873-1-sjg@chromium.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250604130923.1484873-1-sjg@chromium.org>
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

On 6/4/25 15:09, Simon Glass wrote:
> The condition here is reversed, which makes link and coral very slow,
> leading to lab failures.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes 6c171f7a184 ("common: board: make initcalls static")
> ---
> 
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index bff465d9cb2..c8a612d6070 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -1079,7 +1079,7 @@ void board_init_f(ulong boot_flags)
>   */
>  static void initcall_run_f_r(void)
>  {
> -#if CONFIG_IS_ENABLED(X86_64)
> +#if !CONFIG_IS_ENABLED(X86_64)
>  	INITCALL(init_cache_f_r);
>  #endif
>  }

Sorry for that mistake.

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
