Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74560C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CD9845C8;
	Thu,  7 Aug 2025 17:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="abYqV4+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EF2845D8; Thu,  7 Aug 2025 17:16:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF4E845C5
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso7836275e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579785; x=1755184585; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOatucA2G4ZeXao7dtkMoBoejbNoz7Ytwl6g+1i530o=;
 b=abYqV4+gTbJKSKM6kR40p+sWxpwu0SC24cnmfXsU3M6JAARqbpGz8CNInOMvqgyP1h
 i/Yi8WdfDmpcRYub/C5FlRspZx5vypULNUleU0DTucZHwJR1JddPWpk/K3q4/iJi1ntP
 hmTnCtYALUPXXiboABF9K0uUWur0e82HNT8WucSQa36v/wMOcvaNmpmuOOrWtJ0LXvsY
 SiSKDb1j9ZQuva74CvIBuEn16NslhPxwA4gQuEY3ZOkGQqsuHGgaEBioDLzCFd9sehRZ
 LcQp2KtcwJ96IhU/iGWtlv7Xm3m1MAlwBcBiJPcCiTyjeGeteDefXBKrW+6XD+XNo4xe
 fjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579785; x=1755184585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOatucA2G4ZeXao7dtkMoBoejbNoz7Ytwl6g+1i530o=;
 b=bwhp9Xe0zoxqENQLLFpc5f9wCGQpW+p9HInlqjnRiDayLLkcZgQQup1TXkIstCgyUl
 gjVnylLG8q18Yop7wB0Wn4pQ6Df42oA8+06oeCZeCy25fNmTOLk2ZPRT1FEP9udPVu8k
 5jrZza1X0b86jtCfMSw6ShK3GPYgEk/nNV9KUQPkIMIOTCcCs1zWcXdxpE4msvekmE+e
 eXFnKAUd3DrsAxblfLK8wIMWx6hlmKRBNlIvN3G/8oKf7zg0UPnHCEvhMJlq/qIa3neN
 JA8pYy9UrUhJOi3Jf45USMEcXogKWhG3mYWoTIMUyl1nmn0Z9KNp+iBSdegg69U/8kOW
 Wq8Q==
X-Gm-Message-State: AOJu0Yyw2HTUtDRcFiZis1ryVscwZm8aUl7zXhU7bkpsvJWGUk7sXPuh
 1Dzf587z2BknmKFN364xf4NuWwJ8fhVlwofB+FMVkHILUa0sL4B7GEkYZSwE4G2raek=
X-Gm-Gg: ASbGncsSLKTvRGgROuzn00nUGqfhaPlYk+gYjjtXb4/P5qfcBTv1Xl9dD+SYTnvaP/p
 Xtv5l/1bSpYH8hSJNKLUZ8ZROFjyD9RNveSYNFPdgKB9dpUtdUkI22/OM+JKGsUHobrMAR3Lqez
 FANylX+LvUV+fZef3KizRb4/6XrXpG1Bi35MvkxHfYgf5MAUSTjxtgI3rJgu4xBFXZxR8R0rsD4
 7ScMCEAC4k3/rv4OE9QXKXzPiF4gVBZnok1J15FgpTV1CrNkUhiOYKxaVIvkdQr8gU2R5WTUmdM
 axFZs1klE0sgbrrU7ZWfNJJMQ6ToaLzC2jAWJeJrvQs7uavMs7920U7vxEc7xNWotrhn5Az9Ol3
 lvsFOxAx6NFJz9xH7cj1uzRSLXytl9PWyI2NQYwn0shL7L0eKnvE6oZktZ5hSgVdRVsPUTaQxhn
 crtg==
X-Google-Smtp-Source: AGHT+IGs2B2vPDIGAfIWcwkxAUoBZNfeoNmtZtzQQJzgz1XcOCWt5aua/kWZzV/ZSCY9yl8WkLovJg==
X-Received: by 2002:a05:600c:4e87:b0:459:e06b:afb4 with SMTP id
 5b1f17b1804b1-459e7080202mr70833915e9.4.1754579784906; 
 Thu, 07 Aug 2025 08:16:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b55b4b4bsm123862965e9.1.2025.08.07.08.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:16:24 -0700 (PDT)
Message-ID: <3de60992-4ed2-4aab-886a-f66138c2fada@linaro.org>
Date: Thu, 7 Aug 2025 16:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clk: at91: Fix issues found by Smatch
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
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

On 23/07/2025 15:13, Andrew Goodbody wrote:
> Unsigned variables will always fail tests that check for being negative.
> Use signed variables instead.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (2):
>        clk: at91: Fix testing of unsigned variable to be negative
>        clk: at91: Fix use of unsigned loop index
> 
>   drivers/clk/at91/clk-main.c   | 3 ++-
>   drivers/clk/at91/clk-master.c | 4 ++--
>   drivers/clk/at91/sckc.c       | 8 +++++---
>   3 files changed, 9 insertions(+), 6 deletions(-)
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-at91_clk-e71864ac6e7e
> 
> Best regards,

Are there any comments on this series please?

Thanks,
Andrew
