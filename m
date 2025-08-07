Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04885C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92ACF845C8;
	Thu,  7 Aug 2025 17:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LoaRBqfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F20845F8; Thu,  7 Aug 2025 17:22:50 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C5E845C5
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so9546785e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754580168; x=1755184968; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJMqAiLZBfMzcgH+4cc0KROaqlvcSvrO/53Ei60uLVc=;
 b=LoaRBqfuHoVW+tMirCXF4PCfmETRfn0jk4WPDUEd+xyJk8NriO0Nb00tzAit8ekfYI
 y/QUxhNAUTh+2l0dASsP5KwP4xLNUoRO5lWTXiCoV+5CDS6UVmO15894JpCAl1mxdqtP
 be22Kd+opFzbk/jsj758cpuLEkH6iv/XPLXxZEAjk40fq77xpJQcS07jZEDwWm141t+0
 HqjoWBI5jABvkMs6JyzVKY72hR7825ra4bvskEGy+i3dF27ZszQTXy5H6h9ql3J45AU5
 Ajnj0G3XBj6JcCBc5JzxnhMYiXyAYxH59BRcDswIlJ5CVJQa3UP+v55nHHSVA32G7fI1
 WODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754580168; x=1755184968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJMqAiLZBfMzcgH+4cc0KROaqlvcSvrO/53Ei60uLVc=;
 b=b8qyyA61l+U8BIcGGdDeEtCrPXaqui4EGgVOH9/b1SOatr/wAkwE1z9lPQ6CbFkBm4
 gaII3/9xAvgoquAuqzGPyJy8aVNQh/JaK7OAT4xEj4P0vkFAHHoqOvhdftUFAs5vs/UO
 zrjZi2Q0tnljbpxoG6I5wtQsLfLbGZYIyQKU3eJwKT3VtyhZ1/dJdY49tN5jfSmh22U+
 U/XcSt3XWlw/OhflB5PqTziK+485o7gGKhJs78N25kgPlsiCL89xJ6u+Pj7MdNjRfnEy
 PJYyVEwnCWVHvrHre2cIOQPYzN7ikOa4bV0ZLsx9CLiLpo7rGs31dB3Fp0k5PvTTIrxc
 Oy/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0YFAA+x3mzBroLY58T6CRJx4jvOs7YFji4eNva/mgQqNIp5NXoWNF5Hap2ozI4+DTdDeWHns=@lists.denx.de
X-Gm-Message-State: AOJu0YwbJN2zYbn7MryL6c1XT/0HOTY8QDFaQamLNpL9/1lHVk7ePsQp
 n/IMMkEbqSqsjhnhCsGSvYNTMyztEoGpUVTUwkKmDVLDkKtXTAd8e8HHgFgfWSJpyHk=
X-Gm-Gg: ASbGncvo3+pzxfleQUNx9UoTHtfnGmAB1GEl0PdFaXZbQDkVsZLdNVLkX65QvhHCrhE
 Nd2hWdo4wUV25s/M5eoMSh+uUzbtm47kkpsF+1WEAxYeZaM9L0iPO9DOqE6iTDx6wsf3FsMLzXC
 fr1UfYxaBpkHmx+VZ8kzUpP6+UYQEzBv00YfK9yEWvrobiKwn2Vzh2KKI1XqHqUnMDxJsS6PVy4
 Xk+wNKjBjT3xoCUP+7BvoW2Fo+G3kUW60OzrVsUM8dgMyYJEtk9uINtcZzyPhQtypnfKVAu8/9Z
 HG1Eiy4bXmux4peFv+F2dLKQFb22KGWmr6JRC7r3aB+Aiu30G4/TJszBhcxgx6Ll/o0vH70Ittq
 UcvoEb2FzleOJy/sq8snXIqb3m5sNVG2V+ruYeSNFBeuOUKKnXgLVpFFFewvAdfbdPeOvO+RZTE
 W3XA==
X-Google-Smtp-Source: AGHT+IG+S6wbRf+5EtYGrRIQK8rAZIBoMJodiJVNXaAt4xCBVT+el9Zc4s9Gut992+o/Yx83qiy0jw==
X-Received: by 2002:a05:600c:1911:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-459f358b94fmr14058045e9.4.1754580168076; 
 Thu, 07 Aug 2025 08:22:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5853104sm98636655e9.8.2025.08.07.08.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:22:47 -0700 (PDT)
Message-ID: <492b9fe5-c25a-4523-8819-3886ecbbdd5e@linaro.org>
Date: Thu, 7 Aug 2025 16:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: meson: Remove unreachable code
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
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

On 23/07/2025 17:37, Andrew Goodbody wrote:
> A second return following the first return is unreachable code so remove
> it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/meson/g12a.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 5d7faaa3eab..a7a42b2edb6 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -916,8 +916,6 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   			return -EINVAL;
>   	case CLKID_PCIE_PLL:
>   		return meson_pcie_pll_set_rate(clk, rate);
> -
> -		return 0;
>   	case CLKID_VPU:
>   		return meson_clk_set_rate_by_id(clk,
>   				meson_mux_get_parent(clk, CLKID_VPU), rate,
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk_meson-3d90bc29f8dc
> 
> Best regards,

Is there anything else needed before this can be merged please?

Thanks,
Andrew
