Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEB2C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 13:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88940834E5;
	Wed,  9 Jul 2025 15:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YTCVIYVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5F083515; Wed,  9 Jul 2025 15:20:15 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DB1834EC
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 15:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60cc11b34f6so1643329a12.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752067213; x=1752672013; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nj4I90Om1yjIrXgy9nhSNWKgmJAJI4qLOodIGUfgkbg=;
 b=YTCVIYVhiNRmMzzLyTrFI6UbZac3d/0PZ9txCsyUVf7EOuqGQL72xdKh+bW4K4K0FY
 BXRgxWCRx3Pzlf632sQFUSx4L0lvY4/M5nGnCztixRVybRnCMseTo12Oa1lOZXE7R4lK
 FQlwM/WOF1W5DJ2L3gfPPZPLLOFpj++1vWbsQUqrOta6ZMlrrxXfUuA4mOzskcPD2JDf
 xrEVBTNYp2+j41JJPKKKSTO6OWNmgB60N8VZNANCTdDu9U2+igybx9s1oCin8baQOfIr
 T2gVw7/TKSi8o1a0WFD2SFFHpS2viu8YUVxLbVFTEkF/PnwTFsUccLdcQ5CI7XEO8jt5
 TJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752067213; x=1752672013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nj4I90Om1yjIrXgy9nhSNWKgmJAJI4qLOodIGUfgkbg=;
 b=k/OGHfDhbHyB1ZUAMYlUZtPV8avze2+9p5kx1QWo268kuNUgn1YUCfOGUFYmkjHaiK
 brRmO9WnC27HwmYrqWDAFyxfbeFoJFqB7Kso8hhBVA69zUpB6p9fJDv2Qt0GYUmLNh1i
 Ua53ZsaqDWXLOIfTdJpmkEaYy1mideuvViiRuJ4w5HHdbGfcnzkOTveimzHOTKanNa4x
 YyjBxOIkHDTkoF/euJV1qqjzH63Fjbcmu6gHvzR4hoqHzaV+F0toJ55MC7HDBr7CF8sM
 CvZTQcCz8GDYV37CgpK4gBfY0LUwDo/z9MAomjfMhFneRiVLoQa3HSlWtdfcZe81WVAz
 2kiA==
X-Gm-Message-State: AOJu0YxyTKRfUQze6/s/NYBcaARvP9F4GeAowmT48H0gfOFZoTMzb5e/
 exC7ylShIeIMsa2FNgllS/c2TwbhmjC5RJvbjjYeX+c2j+JOuuFq53rPuMm5+DJP95o=
X-Gm-Gg: ASbGnctAVR7rVFfPnR6+Otn4UrANzdlxsrLFqruZYU3qmph1hu0adt7bGWmV2S8VM5W
 0ofcbMfP41zAjl8KACXto7Km1vZhnxkVlQ8MJaEbIGy5zuXEmexsE24BXLM1lGMqy93HRaEXot3
 LQ+jhGkn+dd0sEKqXYOAkVTPV0P0RdkAkuQ1BsqHn8JKt7L9B/zBE/8J/hLwKAzpFGydXBDwG1E
 B8I8PjAOHd2LVgtbz9AEh0WQSLnY/ucHQtnS+0rteTmLVw9CHHERsgCRia5rlvIjJv6iW7SzIKO
 56XWw2K1E4Y0Ao1t2L6xM1vYuE46YJNsX+6jtFdiEB9J/f15CU2sTbz1cKNipMfCoY0s31TQ8qH
 fPTy1o8k3EuqKws/hAEMP5XJgDArNEzQavZNupn/iJA==
X-Google-Smtp-Source: AGHT+IELbjxFhacJZE1nzIn03CkFl+6VBBmJfpd8chNtkw4PFCvxAyyl+nW2jQJnu1QKAweOuJb+Cg==
X-Received: by 2002:a17:906:c115:b0:ae3:6038:ad6f with SMTP id
 a640c23a62f3a-ae6b2366ed4mr766437166b.3.1752067212657; 
 Wed, 09 Jul 2025 06:20:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3e87:9fed:9dd9:2f0e?
 ([2a01:e0a:3cb:7bb0:3e87:9fed:9dd9:2f0e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b0717esm1105949466b.137.2025.07.09.06.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:20:12 -0700 (PDT)
Message-ID: <417c10e9-6af0-4385-b86a-991ee8b4d240@linaro.org>
Date: Wed, 9 Jul 2025 15:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: wget: Fix comparison of unsigned variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
 <20250708-net_fix-v1-3-292b9aa20f31@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250708-net_fix-v1-3-292b9aa20f31@linaro.org>
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
> content_length is an unsigned long and so testing that it is >= 0 will
> always be true. Instead test that it is != -1 as that is the condition
> set on error.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/wget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wget.c b/net/wget.c
> index 3c0fff488eb..428ee072330 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -214,7 +214,7 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
>  			content_length = -1;
>  	}
>  
> -	if (content_length >= 0) {
> +	if (content_length != -1) {
>  		debug_cond(DEBUG_WGET,
>  			   "wget: Connected Len %lu\n",
>  			   content_length);
> 

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
