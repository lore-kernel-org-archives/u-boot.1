Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7667BC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5CB8459D;
	Thu,  7 Aug 2025 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ri35m9QC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519FE845A2; Thu,  7 Aug 2025 16:53:27 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6ED8457E
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so931465f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754578404; x=1755183204; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6TTP/1gEj0uOlo2SdrbVobqenR9WuH4XQaWnnRRFuMk=;
 b=Ri35m9QCnF+I437fF9tZFt4gf+wiN3FjtBrwgexnajKnAbUc06S27bbj5L7FQWgxWt
 3HjhcJoX+hldSUxjeBvicnFr1OwdDgz3T9AU9Owm9D5qWLH4M8LJdX7z8lX+R2lzCcPK
 JkiOfysPnHjy5IWaQy8V6VMYEcol+mlMh5ky4w5ye2SpJDF5/3IMdXKggIk+jy93JcQx
 lTZng0m1Em35JnXGr0Ljn4mnbPxkUbtmWRScFvFLYSSBzA5QQl9bqBZzh75p2nGCdU4M
 cLilijR40miPUaqhmsrFJtq7obHk9T+qnNl8yPfuS0B5wQlrutZVD0Eum9RuBAIJnrIh
 Ht7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754578404; x=1755183204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TTP/1gEj0uOlo2SdrbVobqenR9WuH4XQaWnnRRFuMk=;
 b=h+l3d1c6/UgJsgLFmct/9+VTilzwYzfh546N7L8mgGFxaBmCXZB7gr0W6UVGdqirqd
 7R3Vl3PsKTEYftQbCNMkJPDLx19/Ktz/U9yQyTY12oPdRoG5s/hKnnvXWZxzgiXOnboA
 htdPwSnsJRpsat6mzKU5ymlxeWti0Devbjcz9MuCPmpTsNJ2a5Mh3tfnvoiim3/v6jjo
 81l7X7+4lR/7Q/BiX12m3ZbFO/lfUis3bE5xL31zqdwsQKMA97PtSDlMDMuPppmzsN8O
 w/IDIVOK6tV9LLob61018bcakjFzDCGCnMeRNCxbxokpaUAppXwPM96RfOUS3dp2TFe4
 odDQ==
X-Gm-Message-State: AOJu0YwTPOxr0l6htv/F7FBoZhTTxxccKxWTDeCAWe7BJ0/mSu2o6E73
 fpZF4CWYvqNTqnpECJ7VhSnu50g4GCDyRDtlcz+aQA76JgvRPE+l2GRkYDOVfob5/UnAwebJERl
 g/UHQm0k=
X-Gm-Gg: ASbGncsq150pnAPddNtRYs/RhiBANZrT6knu42BPrR3m/WbdevE1YvKXKOIULKVxtJ+
 eWH2Z5MGpKeMoD3s+3R8dHdJdpalb0rg4hP2HvOsi+ZnJSk+/XSkV8J5R4D5yX2rHoaEPLeEYmX
 mksW1WZFHNFYnS4wVbm5x1JGHm/bQRlfiHIyoIZnvoAPu2aFRl+wSPOiGFWb6jN7sj82TrkFZ3q
 bgAMxI/wXQUgpvoJAgl9MftNVJUAF4myD0avFAAiIpk3vUUsN0T28oh/r+mWO9HzYXHYXeXQ6ZN
 MDTesoodiOdan3J4iLmSZmfhfMjSzSInFFnPCoMb5qaLscyAokY1kTYQsTAeUFkKDq4H25MAoss
 ah3SbQBY0BP/CFOvjQRKUmiqd+Fqpoc/chV5xcWQ0NsJmbu00dHjIQ43kbXWfE+guCGpeRPAzVo
 b5pg==
X-Google-Smtp-Source: AGHT+IEabaY/J66YGzOZTyddiAU1BenHUEqraD14XgATB6a6wbyS7n5u5rrgV4l+cUTPB8rWYoDUzQ==
X-Received: by 2002:a05:6000:24c1:b0:3b7:8832:fdcc with SMTP id
 ffacd0b85a97d-3b8f4917bb0mr5312483f8f.38.1754578404492; 
 Thu, 07 Aug 2025 07:53:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5868fd7sm105212345e9.18.2025.08.07.07.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 07:53:23 -0700 (PDT)
Message-ID: <47d88897-b299-4389-b42f-475f10134f2b@linaro.org>
Date: Thu, 7 Aug 2025 15:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Return value calculated by ERR_PTR
To: Quentin Schulz <quentin.schulz@cherry.de>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
 <2f38e9d5-f030-4b66-ab90-9111a02657ec@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <2f38e9d5-f030-4b66-ab90-9111a02657ec@cherry.de>
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

On 14/07/2025 13:37, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 7/3/25 4:40 PM, Andrew Goodbody wrote:
>> In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
>> done with the value that this calculates which is obviously not the
>> intention of the code. This is confirmed by the code around where this
>> function is called.
> 
> Indeed, they do check the return code with IS_ERR() which indicates 
> there should be something returning an error pointer somewhere, which 
> doesn't happen right now?
> 
> So this seems like a valid change to do.
> 
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Is there anything else needed to happen before this can be merged please?

Thanks,
Andrew
