Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AACC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96400845C8;
	Thu,  7 Aug 2025 17:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lNowUzO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FAE845E4; Thu,  7 Aug 2025 17:19:34 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A8B845C5
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so635076f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579971; x=1755184771; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9OKXawvUtVueYSS2cWgqtGSKYcOtKTzzyUMtkt43NiA=;
 b=lNowUzO2IbUOslSP2fEl9yfGh07J/SONWkSyIkuAS52AkRByNyKdly1Y1BIabRO8un
 SjJWzr7LpnbUWN9n0nlMdjM+ncuMzrEIWtOZZJCMF4tSj1rcGXnQZbt5Tdn29PkKKxVa
 IFnGfWLU1NiQUws1lNiUVy/681eZUV7XuKYw5pwVGQFKluzYeWhc1b1yeBH1fAtrlBJc
 +gjSGaWlug+vkY+QfdfDfmVnXPhzRh2ap6uBOjeX71pjX8hNmoBZpnX/siy5qNszz10T
 ZXltkQXVY1EFbUzsENjMsMdx/eA68GZZMc7U8trHRljjGuJAyp35VJtQWgBdZWrvPqos
 yceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579971; x=1755184771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9OKXawvUtVueYSS2cWgqtGSKYcOtKTzzyUMtkt43NiA=;
 b=AgI5YcBJ2pcIlZXvRSDZboR4JjxNrWsfiYWdufCKvRA5XTcg63NMuvZBMnBHAdb1uj
 pK7/I1/gi3KjL7vl+CJHQpe1pz63I8soxsSfR5aUF0LNK5YEyjqExxueuBbnQVPSrTe9
 rdN9+fvTdrQxJKkl091oXVnYJcgVUp/+Mii7YBAKadDvOdVDNPeLofBh8aR+Ci8PJqEd
 FuNVU2iQoM5u61L2HTxzNPC7gmohRNhvsY2uBKlAZMmyEypX9FTgutyUYQf5sNqxFgZE
 NPJNc+7kSR64o6slVXPcPcRM/5ey0QPUrskMrmPgTe/as+wrwBz9FXoCHESxuDtxRdix
 plhg==
X-Gm-Message-State: AOJu0YydIp+UcLRXXVpbRs03J5tVvfo+WSIMC9C6zRX49v1GFPb5dtl3
 Z01itcCruuRyE7KUEU8186qojKIMCYWkRLWVs5n9LJgs6GQnhhvAs3NUskx+bjftqag=
X-Gm-Gg: ASbGnctntzaz/gStkyGg3dYjVLzOyxkFQJGjr5u0aSsArUaIPiU0agxffr05rxCVJEv
 eov86E8hwZJG2Wqb2YJ2NSR9jQ9BGlo1S/r/HaVv43GwN6SdGVcGzQ3F+5GPGXHNLZ9ZKy/Z7l0
 mb3ZozkxBIi52v3MW1Laf7ILWUaz4tDLZ9Wcm1ZxT/4DSa8OtRt3zK3IY7i/cw3UQ9KoOhCOvLQ
 teGTG4Io2kRHG4O/F0iInaTYPUKvedJ1DkgF4tYMV0F4I9dcNCp8D6bKlSYwzEXpAEU0WHeqn/5
 OZaVh09GpwUWw+IhJSJJYufDP6mU5dXYivE6ZDHlrmQpZGn/RTiDFfwg64pe0bRtwAze2qchYLn
 FlyZ+F/YGFxGUsWB1AL7tWytqrbOjAIpoO5TAH68f3CG1hTyHks4ivIF7I4Mpn0PB9SefGHdc6K
 1CLg==
X-Google-Smtp-Source: AGHT+IECVWVmzn3OYpbBcb7BMm3NvXgXc/7ynTec86UZ2TOKHh+zTxrz953JbHDCiAvAO7+oM9pnjg==
X-Received: by 2002:a05:6000:4011:b0:3a4:f975:30f7 with SMTP id
 ffacd0b85a97d-3b8f49402cfmr6015597f8f.56.1754579970894; 
 Thu, 07 Aug 2025 08:19:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5887b7fsm96366915e9.30.2025.08.07.08.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:19:30 -0700 (PDT)
Message-ID: <5ed657aa-476f-440d-8d9c-f5dd5ca354e9@linaro.org>
Date: Thu, 7 Aug 2025 16:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clk: versaclock: Fix two issues found by Smatch
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
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

On 23/07/2025 16:54, Andrew Goodbody wrote:
> Should return value calculated by ERR_PTR as calling code attempts to
> check for it.
> Also do not dereference a pointer that could be an error pointer before
> checking it with IS_ERR.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (2):
>        clk: versaclock: return value calculated by ERR_PTR
>        clk: versaclock: Use IS_ERR check before dereference
> 
>   drivers/clk/clk_versaclock.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk_versaclock-77e9ddbd4a51
> 
> Best regards,

Are there any comments on this series please?

Thanks,
Andrew
