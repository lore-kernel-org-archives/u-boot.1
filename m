Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6428CD65C5A
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 08:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BD1895DD;
	Thu, 14 Nov 2024 09:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yyc/Ii1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6E6895DE; Thu, 14 Nov 2024 09:48:11 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC607895DB
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso3697195e9.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 00:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731574088; x=1732178888; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KpOi8IkLklRBw8Uwdn0YjyEgAU2GsKfiENih1cLd2HM=;
 b=yyc/Ii1j2BP72K3A+8TBSq9isxjaT21bPdeLiwYfFGWu73ot/Q0mertcXIXX6jkf/0
 RSeRzvZ4BwVLnU2u3XCn18FDTDWZzxLqzOeBCVCaSxSvVe3osgQ5hbSjuH6UzQujxicL
 ParfoePNNl8vH5fY5e9HTFTwJeRTGH/mWCH/biYQDvz5bznZrBESldsEwGQexPehh8yU
 h88VLikW6xFmK8+1EV+wSYkec5O0j2baPJFke9G9piZ7/qSFHVFyc1iiMTlgtQWib7/q
 XC+ko88Qd9GU7g3g5o9AsteAg1M9A6rhoBgribxp35NSVutkbqJL8hdclR8I4xpukXxu
 h2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731574088; x=1732178888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KpOi8IkLklRBw8Uwdn0YjyEgAU2GsKfiENih1cLd2HM=;
 b=wlC3hQv6YastumP1p/hAu5lwR4rIdvTg6XcN6QRIIO7kKY+LGo47WocjX/C39eCbge
 0faGxcPLmPwVmilEKchdlkzEynBpKIjfN0G4Bvh9DSHp+qCrMejIKPIizVnHpJAWk7fz
 ibto2jrjdD+GbyZSV+dNVcwtjq57//ZgzEB+6xaAnJ6I8MT2WQur6EcE3w+sNE4s22/E
 gbFWeJrG6FYF2k9wEpVNzmdVNm4Fn6nArIGrvzvILrLGbyher4oqcWBqWolzb18QnXI0
 blP2CqLHcU/aCAMRz6Qkx3CWIESXzOpsvllNkG86coGr3VfBKmozeCsxL8IgCM2kYl2v
 yovA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqYHB/KPhJ950GHyPBOJcmt/rHj93ZRNrlTRnZQHP3gOPP/gZjuIdYCU06y2AOlAs8x7Xj+MQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzeNHNCnVwFMj17Ozh78ITpPMJ0BmABnHnqvXMrWuhbSTBhop5d
 eJy1TCR8Zc8OhEdeu8QZEGxWbYv8TSI+/KZcVyPsnn3vZjGDw06q9imUsV3ZWE2qHURzDSF+BHD
 jjoQ=
X-Google-Smtp-Source: AGHT+IGlNBxd11y2ZFwhjLELezoY2hLvOovAUmVm7eawECqyrFEtobvGMZClwbk8WpjEgdcmg9U3SQ==
X-Received: by 2002:a05:6000:184f:b0:37d:4dcc:7fb4 with SMTP id
 ffacd0b85a97d-382184fef0bmr1063085f8f.10.1731574088040; 
 Thu, 14 Nov 2024 00:48:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912?
 ([2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbe7dfsm840187f8f.56.2024.11.14.00.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 00:48:07 -0800 (PST)
Message-ID: <42870ab3-1621-491f-a221-8ced932ed703@linaro.org>
Date: Thu, 14 Nov 2024 09:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: Change https entropy requests
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, raymond.mao@linaro.org
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241114073514.418723-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241114073514.418723-1-ilias.apalodimas@linaro.org>
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



On 11/14/24 08:35, Ilias Apalodimas wrote:
> mbedTLS requires some randomess in order to setup a TLS conection.

MBed TLS, randomness, connection

> Since we don't have known APIs -- e.g /dev/urandom, we must define
> our own function which mbedTLS uses.
> The crypto library will call that function recursively until it gets all

s/recursively/repeatedly/

> the randomness it needs. Instead of doing it in 8b chunks fill in whatever
> mbedTLS asks for in one call.
> 
> It's worth noting that 'len' in this function is controlled by mbedTLS
> at build-time options and currently defaults to 128b.

The description does not reflect well what the patch does and why IMO.
The function already exists, there is no need to explain that. How about:

===
net: lwip: provide entropy to MBed TLS in one go

Take into account the 'len' parameter passed by MBed TLS to the entropy
gathering function instead of doing 8-byte chunks. Note that the current
code works because len is always 16 (defined at compile time), therefore
mbedtls_hardware_poll() is called twice and the buffer is filled
exactly. But passing 'len' to dm_rng_read() is both more correct and
simpler.
===

> 
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  net/lwip/wget.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

With or without an re-worded description:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index ba8579899002..4fd552fd306e 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -42,7 +42,6 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
>  			  size_t *olen)
>  {
>  	struct udevice *dev;
> -	u64 rng = 0;
>  	int ret;
>  
>  	*olen = 0;
> @@ -52,12 +51,11 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
>  		log_err("Failed to get an rng: %d\n", ret);
>  		return ret;
>  	}
> -	ret = dm_rng_read(dev, &rng, sizeof(rng));
> +	ret = dm_rng_read(dev, output, len);
>  	if (ret)
>  		return ret;
>  
> -	memcpy(output, &rng, len);
> -	*olen = sizeof(rng);
> +	*olen = len;
>  
>  	return 0;
>  }
