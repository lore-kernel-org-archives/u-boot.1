Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A23CFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 08:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5E088C98;
	Fri,  4 Oct 2024 10:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A0EkPE/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9345788D7F; Fri,  4 Oct 2024 10:36:37 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914C688C4C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 10:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3f28b6so2405607a12.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728030995; x=1728635795; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWfue5CAgBBJEUgIp2II0589Dnp64eL+P2avlyTkxXI=;
 b=A0EkPE/jklkMLlh0pKPneeXRmi0z6ntYrOFo2zKNRiO81dC/q+aftpRhhoy+xsM6f/
 jMr7AhXicPrABbJOP6OAJYm/BIBnBHLnJolRcmjwzgdvWGMLSzWlv93sQPAjR9dANXr4
 1bm7C9qm5g1r6AV2KJ5tD8pNsPHU+t8ytM8msxp2HapDit2fyq25Eko9UuG5xDRLTzhb
 bJJNgBIzdp/sMJPTh/mO8+w95peDTMmJl1hQPgh0NiiyemxgpMgRyWj8qr9KXEJGroE8
 mYEwnwssxvDQhNZitLD+6oRkVUd9ftazFl2WSwfnV5+b8XR7zd2BJS2osN1vwpNNC9el
 z27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728030995; x=1728635795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWfue5CAgBBJEUgIp2II0589Dnp64eL+P2avlyTkxXI=;
 b=ZWe0OcIuFxmHZqbaJHdMw/Rp00vBrKZrazUAYi9isvFoO88BLqbPDqRlS99AoecUNd
 c7dQbXN4RVGa/Z4ISM3f/2591kk8gz/3jv5Lr1+izArpEMIDG//YbXHeLyLxjBKR6dWc
 9dE2lp0bZY/u3t7XL4Zvx25iiUN1WEntmywISqWHmTeck9R6TTJiNgAAeheOQbwMzWJX
 2u0RpZUuesAd5jYcTz+cZsjz/qU02vIPP2vUr10dgylqJgDbLMH/r2t5VUlZ7tgHUbVy
 gZ79CryqbiYP2iiSYWUo63O6tlYXl6qSUg7dnx7ssFAqhrK8t4py9JxIgscadPOfXFy3
 z0Vg==
X-Gm-Message-State: AOJu0Yzl+sIsr9kF3luKww7QIW09un/LovVB4DWDKUHKlFjd+NZALSu2
 Ixo7klhwA/BmxqftcPWwKwfcjBEilHUk1Wsx23Hp8nusb6Xif8AYk+inpeuxpKo=
X-Google-Smtp-Source: AGHT+IEI9XV5Kc/pSPlHXLBS5w2C7i2byJJhnHgn+0dvqhsrSOBKdIDE4F9XgVqPY80JeRkGFXjaHQ==
X-Received: by 2002:a17:907:98c:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a991bce6187mr206838466b.1.1728030994963; 
 Fri, 04 Oct 2024 01:36:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9910285bbcsm194127966b.31.2024.10.04.01.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 01:36:34 -0700 (PDT)
Message-ID: <06ee18ff-e25d-4e66-ab80-b4ae0bd2574a@linaro.org>
Date: Fri, 4 Oct 2024 10:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/29] net-lwip: lwIP wget supports user defined port
 in the uri, so allow it.
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c14ec8b9788c30c205f7b605c9d2b46ebdcdcc91.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjL-oYMkYEZCdcyE7F8x0WPByaELOcYc6Bhz5afXj1Ysvg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjL-oYMkYEZCdcyE7F8x0WPByaELOcYc6Bhz5afXj1Ysvg@mail.gmail.com>
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



On 10/4/24 09:11, Ilias Apalodimas wrote:
> On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> From: Jonathan Humphreys <j-humphreys@ti.com>
> 
> A short description is missing here

I will fold this patch into the previous one since it was a review
comment from Jonathan H. ; Jonathan I hope you don't mind?

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
>>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/lwip/wget.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index e8768fc2acd..b495ebd1aa9 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -349,12 +349,6 @@ bool wget_validate_uri(char *uri)
>>                 ret = false;
>>                 goto out;
>>         }
>> -       s = strchr(authority, ':');
>> -       if (s) {
>> -               log_err("user defined port is not supported\n");
>> -               ret = false;
>> -               goto out;
>> -       }
>>
>>  out:
>>         free(str_copy);
>> --
>> 2.40.1
>>
