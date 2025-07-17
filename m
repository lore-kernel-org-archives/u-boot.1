Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62F3C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 15:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B19983423;
	Thu, 17 Jul 2025 17:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EiOlEr1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD998341A; Thu, 17 Jul 2025 17:38:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279C883429
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 17:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso714704f8f.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752766731; x=1753371531; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iVItApEiiMJVDtUyVAS8wtMSLcXR+AZBvQbFXSO9zB4=;
 b=EiOlEr1m8DALQQa4N1E8L9qf9STPb5cl3FrWVaW60LJvOlJJE7n28jH0fQTkydi2yI
 xZwiIauwtkkUE94CSnL4pmvcOnzBuUuy1Jv+602m1j/7rDybsjHD244QPJXbBkJNNnYW
 u0eQki8Xt2bEET0oOqiOQNpZzkPk5fH7FSH+Mv3ChgeA28krF9O+Lv6hd9Mpo8HCan33
 VDvjw3PcHPsm75gIJt6THj8QBhFXDJCDq0AYVGxfsANMbLXxvSflIyxKtKOAhdWOunVH
 vCwHA4wRc9DYQ6prp6WCK4zNTsMUHXY5d04rVbF3ALQPM+MfoMXInPzsvo9BWjExPLii
 BzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752766731; x=1753371531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iVItApEiiMJVDtUyVAS8wtMSLcXR+AZBvQbFXSO9zB4=;
 b=VIhsLjfrU7tz4njpqLxgTnik3+nUrbY/H4yxCtywwREzzIGrz08mRwJlYeeCr6p86v
 k1NRj/DdjYFSVod5cbSjCCygt7sMvDHqHlJP7K9IQNgsR17rMy8I5vTG65Qp+A1sSp7p
 hqpFLMVmedDYzSHmYa4Fz3XLxn+/ccdlXKGPWrNxnR9jX8C5VvS+F+8mqVsHZKqPnr6d
 Dj0eOVZnOk7svdP4IofTyLkbdvckJB/EXNwQUvwQYQZYalLdHbPwcD6ZXMYwckRJBQaL
 EvAcxJfJbNyo+BKaPs26w/PA6G6atiVywTtsbHdednpzBJ++RpDOMLLtgiIPeQ9LYVpL
 Gh6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6vmBRAR16WXf2g3SCskAU2SZqPiO3TjylovdtIG8FyNtzR8OWc7YpazBJT/PBjTb1b0iVFmo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9NReC1XRRWYIUWJvGrMpFGGBPUfzjs+KpfdBtR2M3oxF3PB/3
 ERoBL/4GcEOrtdpyWsK7JRdJR4gw0aiOtM+0y0NR7vEJetJbpBC0wl1HxniQIIS/c/0=
X-Gm-Gg: ASbGncsvt+fjn/JFOALXJkP+25sAVaXqsxXGGUgfVWh3v/m75LQSgD6G56NSM01FknL
 wLcWE4Ti4II01RcpzQBLPUX/WN3BwOL2bxNupMrs1SnmFw8xjJieT6LnnjqbYn8Lg76IPweW9VX
 o2bQfAh2vvgl57JDSCAG2n+2l60pveZdVQSr24k1Q3ejZ0uKAwbm81S4R56nCrU/01KvKBC9zMJ
 1XW2H43h9mQQXu2GJTh20hZW/1+tU3AfTdhDfSoyn1JClpe8v5IP4NjDVIJBYEl44asCk4hR59e
 nKX7LyXfOcksUVqjQV+cn+fX9anoNUj/hTBeuYJ3kYJqUc8b0q4cYxgwMCkpODLU2ryk5LNJ1sx
 RllGkk6Z++QyWeDcEs0kqVD3zEJc8xJ0SbqQANjmUsEE4IN7oH3hQJ1Ignbcq5CD3rDkBnAkvrC
 95J18W5FIcjKaA
X-Google-Smtp-Source: AGHT+IHqAFgbczfCe1vRu+4yrlPBDx/j/vU8tsmDUVGhPP5nvm1zlciOyWNcjTDkLgq5D3FgsVfPhw==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:e387:c0bb with SMTP id
 ffacd0b85a97d-3b613eb4c48mr3033657f8f.59.1752766731480; 
 Thu, 17 Jul 2025 08:38:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb9:1701:f497:a590:bf80:45c8?
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc91e3sm20950147f8f.43.2025.07.17.08.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 08:38:50 -0700 (PDT)
Message-ID: <1e80ff96-48a5-4a17-85df-59c8459b3083@linaro.org>
Date: Thu, 17 Jul 2025 16:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fat: Prevent possible buffer overflow
To: Martin Husemann <martin@NetBSD.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250717-fsfat-v1-1-4cfb1d1a77ca@linaro.org>
 <20250717145858.GB20410@mail.duskware.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250717145858.GB20410@mail.duskware.de>
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

On 17/07/2025 15:58, Martin Husemann wrote:
> On Thu, Jul 17, 2025 at 03:54:37PM +0100, Andrew Goodbody wrote:
>>   
>>   	memset(dent, 0, sizeof(*dent));
>> -	strcpy(dent->name, dir->itr.name);
>> +	strlcpy(dent->name, dir->itr.name, FS_DIRENT_NAME_LEN);
> 
> Shouldn't that be strncpy() instead? Using strlcpy() for fixed size
> records where strings may not be \0 terminated is quirky.
> 
> Martin

Hi Martin,

The original use of strcpy suggests that the string must be \0 
terminated. I will admit that I do not know the code well, is 
dir->itr.name guaranteed to be a known fixed size?

Andrew
