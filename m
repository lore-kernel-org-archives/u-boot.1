Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926DAC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D09845F8;
	Thu,  7 Aug 2025 17:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AyE5BoXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11174845F8; Thu,  7 Aug 2025 17:21:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B36845C5
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45994a72356so9295195e9.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754580097; x=1755184897; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LzAXQaJC89qupadgBWDAVQekOuWNPaeKcggckQZrtHw=;
 b=AyE5BoXppkAGIkcHRrf1SuRsd7XjrJV3CEYcoM/mNL3Mdmu6TXsie68u/fWhWG40A7
 T4QLoIJKxfZECnpJn0gwBHhpin7p79Z9Jk8fP2V7bEBpGyBR2lYNhGwV/uwk0/GEgymC
 3nC4UQCqBXLPHPA/JHsUY2rk30W3y0aNfav6OAk5J6oiotVaEjT3fnOBGP3EjjELKdoh
 cJWncU0wNhvEYf/0ND0kPgb1Zx5lr21nFbplQKvIHZSbGCp2TojH/LObj4VJvY2PXY+t
 daOE1bqWq0gKmEp0/haOx0HCoB2k+yyXSjTqPzI/z2Rj+wrLiqDntmhcxBb5EreX7tFe
 Z5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754580097; x=1755184897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LzAXQaJC89qupadgBWDAVQekOuWNPaeKcggckQZrtHw=;
 b=rg9UYeFFIey7HR8oh9jRI4s9u+4QCsYUu1fW2+VrjaVSZg+77I0ox7GQKSgEMY+fvX
 5cz0YGEKeLbfc5wXIfK2bAsUsf8CRDUfRdRgMsCDbCBPP4z4zYbMyV300+BPNTVJHWrk
 bDvGvzl0rsXglSbF8mzR8GCaPeHDGnPj44a3qr6zJL6c05WJJ5GjAKaU8zqk1t5X/eLI
 Zz+tUXQp3ir95xny+F37OldVY/ofg9r0JBDvFFE0oTlIb7Tl3Zeywo+wrJZTooyg9cl6
 2feXyA4RTssJ1nkBy80+2OQcRB7Zpfj3mocz7r7EtMu7TRzyBlEhNVC65kMh94XWuQMK
 D+bg==
X-Gm-Message-State: AOJu0Yy66bNvxtZtWKzyM6YE4Kme4RhOMHG91RJMR48mwz7ERXTr+tfA
 mMTZUl+nQvAhiWyCmZDHHqbObMVOBqmwh0oR2HiRFwuSEytKbswNVwSQ/Z1InkG2q7w=
X-Gm-Gg: ASbGncv+FCWqBYbxesMt/SIfRYWmkWl+UkPVNQjANNO6UAv4rYyB7sSKcNWLUy7+zUt
 mYp/F1iTabyV7gvYhCDP9YOxApArqpwQM7js8U73HBsXkv7z1kSkfy9oaDm+6mVmQhLB5YrRsqd
 qC6aTAqjua9vzq6KMyk9W9WvgzkKWzc2HxO8bVbeL4jB83v9uqcKfVvimp9lWN5gMAw3Osraj5e
 jXNgo5kmioLal/cRV+q4Dv/t1etgmM9ENZNQpGAeExnHc8b9CY/3Xjh+26RS6GXnoI5i9TUKhxT
 SwakndwyLIPFEp+HdacOBAk0mJQUerB/+YHOxL9cpD6fNoIDRTA/qU1E5p5Iw2O4AWJYxd5Y6iY
 suPJonP3QcayBDtkX8xVcxo8XA7oH7iK6CuScEVLoWnf14U+YHtx86MqNq8oOrH14FHcOr40zHr
 m89I73z1gJtSFa
X-Google-Smtp-Source: AGHT+IEcyKV58Mh0YJIT1/5dN8k4K4XNGnFu3fsHYF1BmWs1Qf0yG4G4SO2rWoV9EjcBM8wu7Acxzg==
X-Received: by 2002:a05:600c:c089:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-459f3a7ee89mr6928495e9.10.1754580097466; 
 Thu, 07 Aug 2025 08:21:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c466838sm28556770f8f.49.2025.08.07.08.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:21:37 -0700 (PDT)
Message-ID: <23cbb89b-62ed-4b34-95b6-c78dff871246@linaro.org>
Date: Thu, 7 Aug 2025 16:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: imx: Free pll on error path
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-clk-pll14xx-v1-1-f7c865f81a06@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723-clk-pll14xx-v1-1-f7c865f81a06@linaro.org>
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

On 23/07/2025 17:32, Andrew Goodbody wrote:
> For an unknown pll type the error path neglects to free the memory just
> allocated. Add the free.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/imx/clk-pll14xx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 7ec78dc3a80..f9fcec18f9f 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -409,6 +409,7 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
>   	default:
>   		pr_err("%s: Unknown pll type for pll clk %s\n",
>   		       __func__, name);
> +		kfree(pll);
>   		return ERR_PTR(-EINVAL);
>   	};
>   
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk-pll14xx-0dd5bd34a2b2
> 
> Best regards,

Are there any comments on this patch please?

Thanks,
Andrew
