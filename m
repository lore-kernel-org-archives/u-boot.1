Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB052C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 13:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EBB83444;
	Wed,  9 Jul 2025 15:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eSYKOt3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DADD183479; Wed,  9 Jul 2025 15:19:53 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D182383443
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 15:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo9465915a12.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752067190; x=1752671990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slDEw8t+s9FVGolE4FpEcoixQq9obv7cnIrhk81Dldc=;
 b=eSYKOt3QNWC4U6zkCIaA9V1VLX2XJm3sxR+eVM7zVlAIlovN+eOQJAaenaY54mOTxj
 qu1NcZUj328tepMFKRbjwfN1T71c8tTrqno5fD/p48IE8tzWKtnSqmdL+ktvWp5R/QkK
 O1BCYRgvxONdj42o4kf4zfpG06ZKDkLm0uoJiE4YHBVxATpjyV0aTGZ3Rry5uVS2Mbqf
 /AWvZGQbRYGly6qqduktv92jN2uymS5gn473d8FGnFJK3qbFQBjtsCteBDfH0S7mPmoJ
 njDUV4pmK1n1bMskngQpo9BCeWnM2W8ZXs1gvvNr6SBzhTsBQg2jVvzzyaUYAMNCaZyh
 oR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752067190; x=1752671990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slDEw8t+s9FVGolE4FpEcoixQq9obv7cnIrhk81Dldc=;
 b=fqSbBMHS2EM+YpOPc6Epk4wPsNSB+xSEJdojubCcRjjrL/vcd6+3JEUTJmPcUK+JNu
 cKqT3iZlMOh09W/X19zBj0NrVtIO4yDXuKjAduC0qz8UU75eQ6cWJI8oRTWnsZEysz17
 hDhV5AcienWe/erjiBLKXqZnKFRg5zkGPFVr/mICruMST9sOpSHB7hjfXc4rm5pbYxFd
 Z18CEliousROoBgLSrKi2L7uGQ5aK0eJgIE90oJCa+nrjmRhsk6ztM2sca1YaXZ3fqJN
 gPGwKytGNjrR0xB23Q6SWPka9T66pZtYDxoebIb1fZhigzvhfzHA/zRQzzlanTeD3GYP
 0B3w==
X-Gm-Message-State: AOJu0YwFi3eQjwgIDx8pjkJp/x5YsFGAsaT4zf5flEQ1kE+mx/rdBTP3
 nl4WvLqZs4wGFqYkXgAmdntyNfYHdQIhjwWDWOSeBbv14FJXrzuY0WxDtB18nwZIvSk=
X-Gm-Gg: ASbGncskcxzfkGhrMt06Uat2XCpFYxg2WtVFKCpIEeVO8a09/t2FKVMo3vp37pP5YqP
 H3T9wNRh2xGveGPlyXEBOY91rKdh7U5Er/Az73g6As69Vq/c1AwTRJeuXf/tb5q9m0xA6ixRkcG
 XVCY3LPRU96q4dq61L4HLS1y2Ca2vnDU6Lcgp4A6Trv5emmnrELMU8GDwO8uygHJWuz5Ifmatai
 lXjIcrgUxrQvFb7WveCnKiYz32spnfW5kCgFnlcGrOroh+7hwZcqrLNgbV5cz0F97UG7iON41mW
 C5sItbAUCEV5JrUdX7+yKi4C1OWB6v6hQRK7nbUiCXJGrf1OY28zaXxJanHBU0TAjcs8MPo9uM4
 Pkxi59lE9wbfY6uwCNxW+lrK7G+vGWGKAPhJNbSSPvA==
X-Google-Smtp-Source: AGHT+IE+RY9TApWVCoKxRKROTy8wAG93JZuwx//AQSjZDaihTvdfAEWnvYFWvc4oGTFHBdvqCENX6w==
X-Received: by 2002:a17:907:3d88:b0:ae0:67b4:991d with SMTP id
 a640c23a62f3a-ae6cf78d457mr277331866b.35.1752067190093; 
 Wed, 09 Jul 2025 06:19:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3e87:9fed:9dd9:2f0e?
 ([2a01:e0a:3cb:7bb0:3e87:9fed:9dd9:2f0e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f692e4ecsm1116559066b.55.2025.07.09.06.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:19:46 -0700 (PDT)
Message-ID: <47d0b98c-7ef0-4e4d-bf97-d926d0d8aefc@linaro.org>
Date: Wed, 9 Jul 2025 15:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: Add parens to macro PSEUDO_HDR_SIZE
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
 <20250708-net_fix-v1-1-292b9aa20f31@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250708-net_fix-v1-1-292b9aa20f31@linaro.org>
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



On 7/8/25 18:51, Andrew Goodbody wrote:
> Smatch reports a warning about possibly needing parens around the macro
> PSEUDO_HDR_SIZE. This will not affect the one place the macro is used
> but add the parens anyway as it is good practice to have them and if the
> macro is used again in the future it could possibly matter then.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  include/net/tcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5022fa9dc1b..6f4d58a1234 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -235,7 +235,7 @@ struct pseudo_hdr {
>  	u16     len;
>  } __packed;
>  
> -#define PSEUDO_HDR_SIZE	(sizeof(struct pseudo_hdr)) - PSEUDO_PAD_SIZE
> +#define PSEUDO_HDR_SIZE	((sizeof(struct pseudo_hdr)) - PSEUDO_PAD_SIZE)
>  
>  /**
>   * union tcp_build_pkt - union for building TCP/IP packet.
> 

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
