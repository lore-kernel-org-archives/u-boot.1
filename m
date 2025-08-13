Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B28DCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 08:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE6E82D21;
	Wed, 13 Aug 2025 10:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OtvW/Sau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FBD08327A; Wed, 13 Aug 2025 10:02:45 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAD782CEA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-615c29fc31eso12005306a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755072163; x=1755676963; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJKHxEeAAtXn110X1SuR6dXoqiu5bE2Xq4QJuvEc4TU=;
 b=OtvW/SauAQfIcDtAcDC3MR4Oddz0ilmbVKmyYYLmFrX6u7bnVPgU5F5w6rLYucAMiA
 je3BcuGuQOflU92AGKCoCvlAxHZVQUp58UMBMMWFq0mYKK6X60Ro8r/GMJvrdXUPsZmU
 akcKQgJ2QV/psJBoeSCnoomnUMQZ9hP8UZgHyGitP7WXEN1tUczGQSJ8JUhoOi5i5WN3
 vaNYMf+XamvsZECUH2PIeBTNyp/nuDIBrnbyTXaaq552udmmNQ1+GFgbNIH5KkRCRkGZ
 CcTXjt1rh9bQURdxTKNMBowxomYc1397hNxwmi4RZvdzEV3riR/lOwX/vVaFBtlJOGH9
 /23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755072163; x=1755676963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJKHxEeAAtXn110X1SuR6dXoqiu5bE2Xq4QJuvEc4TU=;
 b=O+X2rxklyG4CsxbhI2utuVXJT1TB2rOwkz8JquXoSmnLCXH1eRE6TfiBJD6bZ3Nk8V
 8gv9KhyWxXil41hFA8OfXlwgRkNz8SxqDwm0qoddCFGfDu9OKU2cvPUgyUHpkVc9E8NP
 tt+hpxgPtxhyVdOQa11r/hLxOgDnpbnO5DGbr9hfdNk5o2Ydm8s64Sg9Gha8qFUgvM8d
 7idOCm/t2XBXRlPLxxUv9S9+eUoQwobUftwLtXdRkZpW9cXR6Su8atZ0ogQWpVyr3e5Z
 5NAGzh8fRDNRABVPF1gQBeY/MB3cCLs8axRpxiCLb3LYTWb72PKuJkWCgHqY8HE2a47l
 mhvw==
X-Gm-Message-State: AOJu0YwbHU+vMAjlUnZ/esGTq98ajPexVMhg/Y/qdv8ffqh65LM6c1Ev
 elNGkGPouL2xgTdCVdD0HSNZV+u/ZsxcN5dCZj6/W6zflTASRoc0FBWJE4WQu4MMhMQ=
X-Gm-Gg: ASbGncvaBaSU8YNrlpEck9B7FLy5+yKglQztckBgtSwDBpC+YJ2p+WPwz/u2LHqSRpJ
 RCndNyWwcGIr02y1ATSmvam5FTj6XDoMm214YpPeyzak4xBoZRNbi+xs0Pxoat5ZQ8mbaf/HQFc
 W05S2AjfsZhVfg4ht8MIiQcEttOCL6FFE3l3VAmeRWzVaZNpnAvatWFDijveAUmSZMoYn9clzfq
 jRCkDrJL/rx3F2gvLp94m9fULUMu+H88vIE8Xpc0wJDwjCP9k7YwAP5EiPijymteULw49cy1ueJ
 iqedZQ9cZrAi0oB9UnzAu3PHGV5NbH7rdmFb8u9jDmURRyx9PR+uaOXRan67J+M9EaraK6R2X1J
 WafF4R+rIq9ZrN+Vb1/skc3m11N+nk7ceDESg3rK1
X-Google-Smtp-Source: AGHT+IFRX+1Cpb0kuXL5kgMQWyByjQwI/uSw/234+VRZfgx4L8brRPo1w20FvB9jPv08l/Xl8Z+z4g==
X-Received: by 2002:a17:907:9620:b0:af9:2668:4c4e with SMTP id
 a640c23a62f3a-afca4df3bb1mr216794166b.28.1755072163160; 
 Wed, 13 Aug 2025 01:02:43 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a078a11sm2397815966b.7.2025.08.13.01.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 01:02:42 -0700 (PDT)
Message-ID: <eeb56e69-0485-4f3e-922c-52678e7078b1@linaro.org>
Date: Wed, 13 Aug 2025 11:02:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: atmel-smc: Ensure match is initialised
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250728-atmel-smc-v1-1-b3b8e1a4f1ad@linaro.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250728-atmel-smc-v1-1-b3b8e1a4f1ad@linaro.org>
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



On 7/28/25 19:12, Andrew Goodbody wrote:
> If the test in the for loop is never matched then the variable 'match'
> will never be assigned to. Provide an initial value so this cannot be a
> problem.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---

Applied to u-boot-at91/master, thanks !
