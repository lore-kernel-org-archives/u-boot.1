Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE21C36014
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 12:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D30582948;
	Fri,  4 Apr 2025 14:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fl33cHsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE8C82958; Fri,  4 Apr 2025 14:58:50 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBA2828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 14:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1124102f8f.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743771527; x=1744376327; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IR6t9NVH8L4pGCvOk+uxIcI/mvfqxD1jcewivX7fkQ=;
 b=fl33cHsExtu/tjrqs3g50qwGpd8nD6PPFeaV3SMr9s/CE1PGmolFniKxUkyFxbWxGz
 uF2LI/UoiITAz1myVOXzVTn6cgpDqMAwcrdhSzjUYNuTkX0ym1ds22BiWnz6kx4eSKNb
 NoXKBYafY1pzIbFH3nJOZFipoPWOogi85y+g3zdhQ4vMS2SxHGn1O+sdSq3f/6HG3aKP
 +FrLrt7YfqVrePg/44vTJk9JKHJfv1e3bxdGpFHrUjZtaFNG9z9iAr2k/iHEqsRGXyDc
 PjgQQvCRvV5bh4nFqeixksUs+e7sJJWvSexfPh5lERBSX+CnQF0u++Te56TL+siGUB2J
 PfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771527; x=1744376327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IR6t9NVH8L4pGCvOk+uxIcI/mvfqxD1jcewivX7fkQ=;
 b=iQKbdesf2lzy2WhUlbTVvTaAE3f6FyvHp5ZUiboQ51pATnNlPV+kXCK4BAtxBNm5F/
 xM8HjB3FIZZY3nhbX9DnngsllbQQsJKxTZKJzl8W7gLN6+xCsWgKKNA2vi2HFI5Dj3BC
 2hUN5RWe6pLpZ6Lckt696Dkn+RHDTvtqOwC3TxTlZ7EGIMPysN0K39gB0/30TNLmAQlN
 c8Oqra8m3rIhrhXl3/+VarCKpifxiIQSzFONmBjEm0e2hR+pZvSZDVzKehMvLs+fWHRz
 8FSwvWKbqd0L1Rfocnvl+pdLwV1p4FGTO6xTfPdl9x4+7cMiZkmU7OlkjDTgUyyWTBdb
 jhuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvUH2YfJNKdI/XEDqjDcZcP5HyQmwJEqXDGa9jb9kZxRvY/KkeoiJRjI9ROYSizXV2JpoqbLo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp3+65AlPwGTppRyz8tWsu3QvqbtdW7n+OYGAIkTiEAOqFrGD3
 zilx8aF8KIaI+eXNv8MopIms0eF2odXWrOLLcFjE0KpzPcb5bSeQjEKAX+QBImI=
X-Gm-Gg: ASbGncvSI1rotls7h/kPFqAx9cEKDf49GKN/sEW2kxlJxC4Poz+RciYhcgGv8IEt9N5
 VPTPHhO+PPXhonGTD4GLhPjXeiXT7NGkqGhLE3bwVoGF+TMa3Buass8CTb6mmfpFRFGi6Z7nI9Z
 lpRaV7kHLPizw9KGgOYVRdbS7fBrYwJMIYN2MBETX/zZEX3juEfp8Ymr6+fVob3cZJTbX1Zx6kG
 Q+xxWmt12mM1vV3EvCHCGO4CjKoO5jQ9WHyj2wr2/yR+jAeyDqZt1zC+sNlyYkxi4uduZH/NlrH
 MYuA3n3C2MvostGwySebS0QlT0+sgxe76XqXG/Kzk2cSGwf4zfJ80UexXoQDed6i18S6M2OAUmO
 od+cHEamv7pw/Yv3jBf+ptMHA
X-Google-Smtp-Source: AGHT+IE55IkfaAeT3MiJXBvMuRU4ibQWy7U60eZZFCNNcup/cWzmv+nmL/0r+SVtNFOA3JIYWuzEiw==
X-Received: by 2002:a05:6000:1acd:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-39cb35ab18bmr3013808f8f.34.1743771527639; 
 Fri, 04 Apr 2025 05:58:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:8991:16c1:56a2:323b?
 ([2a01:e0a:3cb:7bb0:8991:16c1:56a2:323b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b7dedsm4370853f8f.52.2025.04.04.05.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:58:47 -0700 (PDT)
Message-ID: <de58b8f6-4ef8-42b5-b743-91da6f9722f1@linaro.org>
Date: Fri, 4 Apr 2025 14:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: optee: fix hello subcommand argument check
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250404125358.538120-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250404125358.538120-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 4/4/25 14:53, Vincent Stehlé wrote:
> When the `optee hello' subcommand is called, the do_optee_hello_world_ta()
> function passes a NULL pointer to the strcmp() function while verifying its
> input argument, which results in the following crash:
> 
>   => optee hello
>   "Synchronous Abort" handler, esr 0x96000010, far 0x0
> 
> Fix this by verifying the number of input arguments instead.
> 
> Fixes: e3cf80fbe02d ("cmd: Add support for optee commands")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  cmd/optee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/optee.c b/cmd/optee.c
> index d0d37293986..e3aae5e9f9b 100644
> --- a/cmd/optee.c
> +++ b/cmd/optee.c
> @@ -53,7 +53,7 @@ static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
>  {
>  	int ret, value = 0;
>  
> -	if (strcmp(argv[1], NULL))
> +	if (argc > 1)
>  		value = hextoul(argv[1], NULL);
>  
>  	ret = hello_world_ta(value);

How did I miss that? :O Anyways...

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks!
-- 
Jerome
