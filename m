Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C8FC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2CC8397B;
	Fri, 25 Jul 2025 15:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RkJYOLef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE8283984; Fri, 25 Jul 2025 15:19:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAAC82F49
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso16386195e9.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449581; x=1754054381; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y03NZAMHeNHqJbzL+Gzw8zXi8ra/Rum8G1alRXIWs2E=;
 b=RkJYOLefEvkRQgt4tJEiJvFQkmLsrfyx2vVt2PIOVYxL8PcHoZEdRkUZqzsvSqIUU/
 1GhIuEDIOuG2crfdsasvYIvVG05CISqRLr/wsDP1ropSl+SAOWVzh1WOQazVRy04wEi7
 j9eRNr9viIpjv/EeX+3TTGP/Ri61AFxVmENC1dcTVFzoO+yQc8s9h2qOE3+iIAMWeqRR
 T9M54nj4fPe9aD/Js2dZaoXeDIoYJWKr3Q1sOXhgpcqDHnBJEaI3dgC0P3TcIVSXkNIs
 uvLU6BR/trAT0psSEZwILHrJ2iVK71b6q3M6DkrK9XSEdI6cXUhZbeMJvziXsXUAiWRN
 TeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449581; x=1754054381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y03NZAMHeNHqJbzL+Gzw8zXi8ra/Rum8G1alRXIWs2E=;
 b=MEOkFdc7NONR4XfO+wDr0SMEeI56ig8FdByH4IjvnqfV0lVeW/Mi1UwFfD0uXG98g5
 VsvqPEMTtP6gnRtCkAXzdEUnNFAsjMczIeoCSrNynLb0qQTwHee3OXNUmocX4BnJkA0R
 XP/cnS0IwLa70eXIRBw0o+ig9DtgnCwKYzOHSlCz6b17syLEHYKUQ6rDyWCSQiNtRaUw
 fNJ7Csr2KtMSnypkbUsGyaxhLz9ejtXXS8JHe6Q+hN2WangWuYuTh/xxcHAfnCMzLJr1
 oXJPDNYB/D2Q38S1MlDE0KxETCmMXFcCQ/dMH5SDtYm46MqfvTfyUJ4aPfI+5M1DsEV9
 Ux7g==
X-Gm-Message-State: AOJu0YxM/5icZdCkZjyVfNEBEjeYUYSEt2zq+tLVxv8wJCYEYotdvBEW
 2RRhl8/EUwS+Qa/LMfYowGX2hVxFPkDEQqckv3vJ4etQw0L0zo9BLE2ZF68U/nB5I0DeFlbYSzC
 PSycV
X-Gm-Gg: ASbGnctTduManRDgktos4aSWYRPaglZU4SBPnqVO91nVyAsUllNRxPC1Nc66Ir7NLYF
 71Iej2SAa6loEqf7bbWdYD5LVM7D43seMazHlW3SGeUcTFTU4kVNG124pc48Wwl+OaEhsTkj5He
 8poVsAOZCLXMMX5DUt8jXi6864HuNOgTBSxwhZRJ3uzX/P2MC9DG75FlMXn+dXbQIOzxFZqj8aI
 ySuIwAUVZip7aC9/oOIgGJIxbb6wM+M4DYrCS+KR4fJGjGfctsgSWLoTEGChv0PTFO5HjmUbEmg
 +z3FSbKT5O6HoqEtJfgcfw1zXbRNnPmcda4B4jYm/BITkezMSEI7wHmyt7Xgp4BXopQy7gX/MZU
 hl/WlFRHX9pamukEkvOIttrQEvdYmiWb8QXE7CmXaifcdHcE+R1BdzRvt6UP5wzTmBnAZtxqYOA
 ==
X-Google-Smtp-Source: AGHT+IFwdXMTS8OCWR70u9j2aGtDBxMWj0ZQa+kfpMZ2aV5ubcOGtOtqwSUuwwR2L25CpLpAdhGhAw==
X-Received: by 2002:a05:600c:6992:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-45879b2ff94mr1892735e9.22.1753449580766; 
 Fri, 25 Jul 2025 06:19:40 -0700 (PDT)
Received: from [192.168.1.37] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705378f4sm56384475e9.2.2025.07.25.06.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:19:40 -0700 (PDT)
Message-ID: <013b1877-e199-4f98-bcb6-54a06d86ae7d@linaro.org>
Date: Fri, 25 Jul 2025 15:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: Initialise size before first use
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
 <84393d64-b2c6-4287-8fe3-10c6b23dd8d4@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <84393d64-b2c6-4287-8fe3-10c6b23dd8d4@linaro.org>
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

Hi Andrew,

Sorry I missed the thank you letter for this one. This patch was picked
as 8830e72092e0

Kind regards,

On 24/07/2025 10:59, Andrew Goodbody wrote:
> ping?
> 
> On 26/06/2025 15:12, Andrew Goodbody wrote:
>> The local variable size is not assigned to before it is used
>> for the first time. Correct this.
>>
>> This issue was found by Smatch.
>>
>> Fixes: 86d462c05d57 (cmd: add a fetch utility)
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   cmd/ufetch.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
>> index 46bd16824e6..bc5db08eee1 100644
>> --- a/cmd/ufetch.c
>> +++ b/cmd/ufetch.c
>> @@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int
>> flag, int argc,
>>       const char *model, *compatible;
>>       char *ipaddr;
>>       int n_cmds, n_cpus = 0, compatlen;
>> -    size_t size;
>> +    size_t size = 0;
>>       ofnode np;
>>       bool skip_ascii = false;
>>  
>> ---
>> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
>> change-id: 20250626-ufetch_fix-54b741710142
>>
>> Best regards,
> 

-- 
// Casey (she/her)

