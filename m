Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC8C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 13:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1902083479;
	Wed,  9 Jul 2025 15:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NGyyQfFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C4783443; Wed,  9 Jul 2025 15:20:06 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5496D8349B
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 15:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae36dc91dc7so988169766b.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752067204; x=1752672004; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KatpH0KkC2cd+wymBWr6I8rhuVgkQUdMEbkYbI4YJmQ=;
 b=NGyyQfFBZWL7nvo453aC0FQ5RxyciWkXB6pi4Du1cQLnWJTmA1dklfMZj5genD2jSN
 6QmtYwmJcY3+5klfmCe6S9JDzRad7PKqVo1V8kAKEAMc2RxhBX7GOXoY/Z9jd6NcUlo7
 PzCyZfqUHZytZjcKppaz84aJkn+hOA+Q4OBsAIrMy5jqGCtHsz8ebe7ggA+RTcUDozcz
 htck6pLpr3sZYtZX4EMTiekzwl4lbN4VSzqRtBK1VahsyLM2w46U3qppmhWrG68Pb4de
 00/Ap2QYZ5tobiDVaToO9K6rmme0bmBr6ScJpidHeNT6Vyhqu1Mg2xd6y6zj1edTCNqQ
 mwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752067204; x=1752672004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KatpH0KkC2cd+wymBWr6I8rhuVgkQUdMEbkYbI4YJmQ=;
 b=Vodph7PPb9mlaJH7C2bza8Q+SicU3FUqRtdx4Cj9gKxu8pddG4MHXd/6YODjkcIokV
 pW1EiWl9SOgTvmjJx+IXK1Cgo/cAWLH+04xZ44EVOKsYEs9Bs5E6K8RciqVolj/FHkKq
 bNvrPO4teBLdmVdbFJ9Ls7zhjR8r0ihTOmxWS+W2jPLujUoUGFBe28T2iZK6hCPyH+q9
 rMa5COdu8woch4cFN7tCWd9axwGy/LIe0K87UtxFR/ASw3NP7VCCYIugRhQtjF2V8UFI
 Q37yqTVp0OeCySqdlJ+hH4qAmUyJvQcvxTh3Jn/2QZBo7BmTzL2Pmhmnu7D+aOnDThUv
 aGuQ==
X-Gm-Message-State: AOJu0YyXeE2dbkEGeIa6wursRkAiok6GnUlS6TTu6EmvIRKlECIf6iuN
 Id2NVk+A++Nu4RNkLue5oGP1KLJqBjqKgrvivDNgi1rogoNtUWJnYuulzkdyr6IpUSQ=
X-Gm-Gg: ASbGncucAusJCb25lwf7xHraxIMrbkbGfbWxve9vqyryjWDwuRYiPSxCn1FErW9MS7Q
 gUGRjiVCzfIdLfOBjixyoyzw+oDrxethxI5M/aLqtpDb+6lN1TRDejblmoOnCbPVZCShJwsIIXJ
 wYKjsGJ8ZmUVzHM3DN0gl2kmpixF77eFeaQiVLrXYUZbhjSjYJfmqhs1QqDG+8GhX+XXiZvyPIl
 i6ASJu85N3V+dH2qEuU+ftA0j2dywPLrmX7/TpQixOIftdmhQi2fqw9lB6J3NtGi4QViYCGWs0n
 QBUa7JZTSSY4Bezgc+kcf+oReQ0gfXW0h/fvUWTMFImEfSVSIZKTacAOAjUAqREjt1tUcE9xBzO
 mkpEWSXk8+2sg4YGZEDs96+pD4MkGgjwOBsUyyewA3A==
X-Google-Smtp-Source: AGHT+IGQUy4QmMCAiGnhnQtrQFqTAezovF2l/wmwHwFieTJ5WtAXn7qcsN/+Be87hyp5MIAfn+GfbQ==
X-Received: by 2002:a17:907:72c5:b0:ae3:5e70:3306 with SMTP id
 a640c23a62f3a-ae6cf5bc2d2mr350837366b.19.1752067203595; 
 Wed, 09 Jul 2025 06:20:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3e87:9fed:9dd9:2f0e?
 ([2a01:e0a:3cb:7bb0:3e87:9fed:9dd9:2f0e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6bb1046sm1115271466b.174.2025.07.09.06.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:20:03 -0700 (PDT)
Message-ID: <d4e83482-f120-41e9-9cb7-06ddff2f3986@linaro.org>
Date: Wed, 9 Jul 2025 15:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: Incorrect NOP macro used for test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
 <20250708-net_fix-v1-2-292b9aa20f31@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250708-net_fix-v1-2-292b9aa20f31@linaro.org>
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
> In tcp_parse_options the uchar p[0] is attempted to test for a match
> with the 32bit macro TCP_0_NOP which can never be true. Instead test
> against the 8bit macro TCP_1_NOP.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tcp.c b/net/tcp.c
> index 2635727f47d..8740150365f 100644
> --- a/net/tcp.c
> +++ b/net/tcp.c
> @@ -804,7 +804,7 @@ void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
>  		}
>  
>  		/* Process optional NOPs */
> -		if (p[0] == TCP_O_NOP)
> +		if (p[0] == TCP_1_NOP)
>  			p++;
>  		else
>  			p += p[1];
> 

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
