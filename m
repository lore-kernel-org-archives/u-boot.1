Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1293CC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C163845B3;
	Thu,  7 Aug 2025 17:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OC4xuAWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7CD845BE; Thu,  7 Aug 2025 17:03:54 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6241C845B0
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458baf449cbso10914915e9.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579032; x=1755183832; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFd1zNPoGU/sSmiyFDzr37YCgIssKYj2qbDsMTUOVxQ=;
 b=OC4xuAWkS9EYvU12i4U4cnzQGHRpWD0EYxhQGpd3j0Q14zAd9U5lR8RxMf5kejxPmr
 xZm4YDuNJE+un2d/bYWScVeZStj8t4uvu0geZbYEG7Ml5XtvuxIrpaioQkawz5LGgYlq
 0VPDRIa/E7iUGoljLPIxiZP12Fv1DCXPMKzyG648MOno3R9Szo364zm9uBfKKzXZQ4uW
 JKJBplnghr65kuNQR4L4wdinCxzMMDkJUm1trxqtm3fMNj67ZEeXz0UzQV8BCvlpRl7S
 3KurQ6Jd+SKhrmGqUYrsjiaaPJWjmlueJIOBleCUBNn1Popx98BUdTza5ZwrgI5nrKqL
 wg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579032; x=1755183832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFd1zNPoGU/sSmiyFDzr37YCgIssKYj2qbDsMTUOVxQ=;
 b=QDrOsqil3x5fNY/Jdca4Q4ZiY5yMa4udSpEAn+bO7f0o8tXmbWsdygUVXxiPCxWIxv
 W5JlmY3GO93pez9I8BaNA6ZED3VveKrgW08lPdc1B+q692nMDinIN2eZkSAgRQJN68nk
 XJ1F23lqunqYB/OflUulkzrvShk9tBzNrSQlk+FokEK/5T6g50A2o8IJXv3n2522hX3f
 srIDUt8oB/5IoA/lrhE3Wu6iVA//vckUZ54TXUgee+kmYlO51/PX5JW7wqtJHxdcLL5P
 IaD0ObbyyHq+l4SqOPgcGNNsyVHh1D67qdvTkUF9BQr8JecE6JnOpA2KjDwDDxrlfHqi
 1xfw==
X-Gm-Message-State: AOJu0YzuvgGgPEb0ZuVspKP/8GtCSs8XAKh8GZ40egm/Gm5RQeXKotr3
 c2FxHT85P0xW5sxI0k0qIdXgntiaAUo2OfgZhn5vC5GEadXd+psN1bySfFhqKrVuyOo=
X-Gm-Gg: ASbGncsvS6aFh27HHKV1Wt0/aMqOXBB+r+YIySHSLmlDpAtxcVR5HdOwFWkMFP3d3HV
 L68B+eyrorpMhVKersUTyPO5OcsptToczpolJMuwNHZMK/c/9/kAaiwaVSc3VT2OMq98HBvXcNg
 EKx0yxBWcu4b75jzdzKs/LPqH/e66L62/zva2zZv4AlFxwoXzz5Ud36ZWP2BHo+lIuX3v3pwLnb
 WSrkDl+uNPtqyZwIyVujYadu/RXEUJCqYOC2PzbhAKmlZ1EyqvxYmSdKMdE1RlxJkhewhG+r4hc
 ZzK2DLF6DAHaojye2kCZoaPPjCqXZYkHNbvMEQ8FZhNqKg6EcWHl/LGZ1OK3y7Qlqwv4AvzhAr0
 YAIe7MEMRcjKemh5e9rZ9+FanhUrsgfNwCWAa/mD9kO3MOj5du3ljgphqzRe5GsZntyNAfZEQre
 oNcw==
X-Google-Smtp-Source: AGHT+IHH8shNeHVjo50Ikcajr0CJdLR507QA84MTJLHT5yNFwaQ5BHot3OvvcpG4vd0WKSW3QhOFGQ==
X-Received: by 2002:a05:600c:a03:b0:458:b068:777a with SMTP id
 5b1f17b1804b1-459e9ee8b3bmr69530055e9.30.1754579031604; 
 Thu, 07 Aug 2025 08:03:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bb04c612sm219941645e9.0.2025.08.07.08.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:03:51 -0700 (PDT)
Message-ID: <7f3ffa76-9c2e-4ac6-90eb-c53a2d27322d@linaro.org>
Date: Thu, 7 Aug 2025 16:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix incorrect use of binary and
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
 <977ae9e0-c34d-41a2-a615-640d484e7c1f@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <977ae9e0-c34d-41a2-a615-640d484e7c1f@cherry.de>
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

On 14/07/2025 13:31, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 7/3/25 1:53 PM, Andrew Goodbody wrote:
>> In regulator_list_autoset there is a test for ret being non-zero and
>> error being zero but it uses the binary '&' instead of the logical '&&'
>> which could well lead to unexpected results. Correct this to use the
>> logical '&&' instead.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> That seems like what was intended according to the documentation found 
> in include/power/regulator.h
> 
> """
> Return: 0 on successfully setup of all list entries, otherwise first error.
> """
> 
> Therefore:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Is there anything else needed before this can be merged please?

Thanks,
Andrew
