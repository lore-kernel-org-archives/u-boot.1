Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE0C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C4C82BCD;
	Tue, 17 Jun 2025 14:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NQ2/5rYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CE982C2F; Tue, 17 Jun 2025 14:12:32 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E339482BA1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so63974775e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750162349; x=1750767149; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b2wJUoUkkHLZJLSHZDgzC5j9od12ymR/b8Jhq/xU0Oo=;
 b=NQ2/5rYO2cZ71gOYpRVHYfQgWLBK+QO/TvCgYqY6gp3NUkT0aNEXSNs0avs+DvyUuB
 G8Hg+qfHel5QQnJtly/gl4xzrKA+E9ORVRpoqawJ0hs9Z93GV7ZHrICoxa34XsnkQoqB
 xyHcXXF5GGXOq0icr13EXfTtJns/1M8tKwxfyDQa2Bf2ysuxzpdC2khDsAV6zqPtZE+Z
 c1K47Rj+wRWI3qjAWb3G3iPbLLFRDugEAZyzbQK3NmFB8Id7z7fiezEYdvtLwUcueTvt
 Ae8sKspRVyYHUdf1GB37+hSl3ZLCezL4iMZHSmeNdzFhtFlvorXHzpVJUor6SvFcOUyS
 jUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162349; x=1750767149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b2wJUoUkkHLZJLSHZDgzC5j9od12ymR/b8Jhq/xU0Oo=;
 b=KYKcO2WSDogG9ekGjbzHoprV2Jj+/cW+ohx3r64eqbgiK+qHFY8DzCeilDiwVEbMxP
 X2BXg3vn9gav/Qelw9iFm9xj9nz+S+HHEVxXi5C1cZODFozkDYNfZNzlLMyASu3dE5Tw
 og5N+jy+YfHVMLHW3fEyS4cwr2pl1d89LBIiH8ZPcWRK5bvA9u6jhTbwuYGg8J8RwThr
 goSx6qMYChv1lp8DftV7kI3kz190b9Et4m497ghRwQS/lvn+9thgDoiE9qnecHV5p7Hy
 Tz69iB7Ll3/8l6BxRI1bPKLWTff/P+WB44uGeoJnq5o+oc1p1Da6PYXb7IR4u3igwoZE
 hWkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqGgXxEfbt90iUdNxyt3mVmroBj4UEh2bITzpPcOA2QC4YTHZwKnmfugy1wx3mx8aEmBQhMRI=@lists.denx.de
X-Gm-Message-State: AOJu0YzwZoQ7gs8wGbJDzU1gpOrhzJm02uVo+o/JNx0aB30PmbHFclv2
 pY2Ezrth401hlEfdiVfkU5XwVYem+P3DDGaeq7aSzt3oXyPc6iBQVotQjiWQbP8HULw=
X-Gm-Gg: ASbGncuFnfVtFxwrkZ1VY8RR/B5N7jQYrYm/kROeRmjI+cBBufllzfSoTvEjZEYi80T
 dwnBbkwQBJhBOO2EUMnyeksC8kVmdh8EnKFsAT4NbTKdCo5X9JwQf9nETb/BRZmXWgfqsGDLdDN
 GiLYc0/IdecSvbkQMB10wMC4OywjrQyTkn975L0wHK8PgMPcgBwUwgLH4PhxCiG8rLs2hzm+utp
 5WM477tJaS40gxPa2UKaBWaJiWSRf0JK7tFk0kbAmSNrBm6VrN+/25cfoDmofM3uDskYOz+brxd
 lFn+S/Nc9BscTGTLYh3V5azTrjLLORs1Cyewn7hwE8hc5gnK1bFlu8NUYA0cCeLCcgv2y99U
X-Google-Smtp-Source: AGHT+IHlawXdDSTbRrelIkyF+HD+ljtmL4vUfh88gpivayyUtFylftEz1qXi7Z8sZhcX/r4vkXrJ0g==
X-Received: by 2002:a5d:584c:0:b0:3a3:6e85:a529 with SMTP id
 ffacd0b85a97d-3a572e56293mr9872070f8f.51.1750162349303; 
 Tue, 17 Jun 2025 05:12:29 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a800d9sm13700059f8f.45.2025.06.17.05.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 05:12:29 -0700 (PDT)
Message-ID: <15ad15a6-4a94-4d4c-8655-c966b65c5e47@linaro.org>
Date: Tue, 17 Jun 2025 14:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: cmd: wget: remove erroneous note
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20250617113333.2546767-1-jerome.forissier@linaro.org>
 <d8b6371b-e9db-4536-9be2-ab7c80cb79e7@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <d8b6371b-e9db-4536-9be2-ab7c80cb79e7@gmx.de>
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

Hi Heinrich,

On 6/17/25 14:03, Heinrich Schuchardt wrote:
> On 17.06.25 13:33, Jerome Forissier wrote:
>> The note about U-Boot not being able to verify server certificates is
>> false now that WGET_CACERT and WGET_CACERT_BUILTIN have been added.
>> Remove it.
> 
> Thank you for the patch.
> 
> I can't find the string WGET_CACERT_BUILTIN in origin/next. Do you mean CONFIG_WGET_BUILTIN_CACERT?

Oops, yes. Fixed in v2.

> 
> Otherwise
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks,
-- 
Jerome

> 
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>>   doc/usage/cmd/wget.rst | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
>> index 44033aaff39..06df2842549 100644
>> --- a/doc/usage/cmd/wget.rst
>> +++ b/doc/usage/cmd/wget.rst
>> @@ -185,13 +185,6 @@ TCP Selective Acknowledgments in the legacy network stack can be enabled via
>>   CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
>>   Acknowledgments are enabled by default with lwIP.
>>   -.. note::
>> -
>> -    U-Boot currently has no way to verify certificates for HTTPS.
>> -    A place to store the root CA certificates is needed, and then MBed TLS would
>> -    need to walk the entire chain. Therefore, man-in-the middle attacks are
>> -    possible and HTTPS should not be relied upon for payload authentication.
>> -
>>   Return value
>>   ------------
>>   
> 
