Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C43DC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6CCF83721;
	Thu, 24 Jul 2025 11:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wLkF2TvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B3783666; Thu, 24 Jul 2025 11:00:55 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D1D836D2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so655357f8f.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347653; x=1753952453; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y9uKGreBFkdGmxHiQrbvULM6OaEgWKDZ2e3JjSeNiGM=;
 b=wLkF2TvJ8xEIzrEJL7IYl+MeUkwCRGVVlp3Jl8m44uVaahYDgnp0OAwPoIYQU+TSJ6
 gm5Ctx2oh3kZdz2DJ4v8mDI8d56qk4a3X3u75NMdBh/jV8C4TFbhGcZaPThzuLV1IcAy
 3Z0Rk8UVtZoE6C625QER2BDm93oD1WJghXz8wlg4ASWW54YSefHfjp5c8TYV1wLkkqIU
 5Q5waIxOCwHQosuZ4/KUoV1JKYjcjIGSQedzs5+ptoWRiVKh7RTnkBbZ4lPXUlNHWuBF
 sli37ORt0u/uVhlp5f3WY7u6PP2LE8dk4Idf0ZqzAZj8HrtR4Puok1cfpNPRWk2hmJrU
 1oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347653; x=1753952453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y9uKGreBFkdGmxHiQrbvULM6OaEgWKDZ2e3JjSeNiGM=;
 b=YPUZbKlqj7F9cYQvEt76Kh5RmykiCzUXWdW1wfOW3bPMsQTlW11/5fx+GYFvGfpKkq
 Tynp58oWovwFsSc4J3V36PFm2ErnjeaeIiCRCDorO5RnYwVT19L2ll7pHg47C/9UdGRZ
 ZMQ/8PtRngEXUg3qnUCxKu/NEZaP5969hX0IAvBpVMH9FTYc94Q63LiKIGqRD+e8+GTL
 44cnVlH15A0yhkhXU+rEzzrp30VVgZ65Ox3VV1n6C7NmnSiDNlG1MhwiIXiN5spgOd2z
 2L2SLA4S7Dd+ALbqeeHsJv+2YmfglIWLBaEB1fzNrZ8IvdL2rs+bgP3vZkqizIQFXq/G
 rSdw==
X-Gm-Message-State: AOJu0YzNJtEttG+Y6DmQuDGP0TfdXjRZxohE4V+0rr5Rkqb7akZBgYmU
 rHSDQtwsZbFRxMp8egpIMtG9ze/XSJ/oBhH4NsJNdOAcKOvOoc9STt8NkGyCB4U2r0Y=
X-Gm-Gg: ASbGncvFA2Yc8kKn2jMqxYyE3HuENu6tECFXUv9N7G7iHSyQI/6beWxmupj1+ZBQZUY
 s0Aql75qIqSrsKVJHAKgUfRcXU6Lr9Jyo34SWWKkKPfOi069uCFCurmIFfVF5wVixXryDFlyY7f
 UqcG19VSrdXM2DPvjFEzrSHgxyxq8MC0rBMsgA6/0BmUIuY+RF6b/mgpuCgYsDdSVNgZT1pCTXV
 iKtPYfThtP3HXUoM3N7BMzmHzGGWwYPUqNNoe4CT62gVtxbkJvgN9S/UPcqjajUYdeewjA9F9zu
 xrUQNBfje0CTOB3SMjGTbkMi+7TpcROi0ii98IijB42wguGZuL/uxpTzHx6i5e/nYJ1SwsJZ+Bg
 hcRnw26xUgJRgoNxNycclpi0CyoYeGzPd7mWgPdiuia5T4wWuHdtZ72/jtRcuGGx7VXh4c3h1Vd
 ieHA==
X-Google-Smtp-Source: AGHT+IHXuxC5PZBBSEjvMqGvJ0efMxYfGo3ATUgfrivIoyBmsHjbxPuUcxamU99RO8pDiCzCTFFyiA==
X-Received: by 2002:a05:6000:230d:b0:3a4:fc07:f453 with SMTP id
 ffacd0b85a97d-3b768c9c063mr4735736f8f.8.1753347653201; 
 Thu, 24 Jul 2025 02:00:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870532a4csm12187545e9.7.2025.07.24.02.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:00:52 -0700 (PDT)
Message-ID: <c5308be3-c351-48b4-9221-2f9a7f88e41d@linaro.org>
Date: Thu, 24 Jul 2025 10:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Return value calculated by ERR_PTR
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
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

ping?

On 03/07/2025 15:40, Andrew Goodbody wrote:
> In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
> done with the value that this calculates which is obviously not the
> intention of the code. This is confirmed by the code around where this
> function is called.
> Instead return the value from ERR_PTR.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/clk-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 2167cd5ad0f..cf48de766fe 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -194,7 +194,7 @@ static struct clk *clk_set_default_get_by_id(struct clk *clk)
>   		if (ret) {
>   			debug("%s(): could not get parent clock pointer, id %lu\n",
>   			      __func__, clk->id);
> -			ERR_PTR(ret);
> +			return ERR_PTR(ret);
>   		}
>   	}
>   
> 
> ---
> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> change-id: 20250703-clk_uclass_fix-eaf648b2ebb5
> 
> Best regards,

