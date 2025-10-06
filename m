Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC8CCCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 09:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD06083327;
	Mon,  6 Oct 2025 11:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jQQV1aGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6831E834D4; Mon,  6 Oct 2025 11:51:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6295182E34
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 11:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so45474305e9.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759744288; x=1760349088; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2akMuI21XpI3YYtnva0T3GTWanHzgvoQbns5I3C9xG8=;
 b=jQQV1aGTRkdAm5FQ8HbEuGBsvtCfHqHGfe55qQT5yMoOP6n4GZqKPhWBuhiHUQ/nHd
 u1M7zMgPqEAJ6kLjCYpKMgLkjRFyop4wrbUFmKZ0rMYAABZBuk56/7cDMF5EUpioCpKc
 TALTDJRx6P5092rN0YpsPZZ8C6g7Y8wpP17ti6iWC3vnAPJk6hNtiysAYmYvbiYYhKYu
 pqpdi7eK2J4dunP35EG+AN9VAv60n86z+K6tEDEzBTzxYuvqXgWbFlZ8zbP4kRDTVd6q
 g/rCrCqtVtredabF7L6xVV5pBmrj9uoV0Hsc8HShaYoZPeCT7PJko54C8beOb/84ogjs
 4ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759744288; x=1760349088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2akMuI21XpI3YYtnva0T3GTWanHzgvoQbns5I3C9xG8=;
 b=YhhqK/rqTSjsYG1SUEm/OxJG5yHoTU1UV4EjK62cNF2EQE/owUHqUgXnHENz1d+WwM
 k6zy2dz0SMGtoqEGHexkj8b5eEt/nwT7vgjNUbRSwBwcmr+XbbmL7NeQFXWLShqs+DcZ
 H98jw6VDS3kN2nqMKw+jWfXp1JiAMXDlk8ouRXwQD1If8/Vp6pk1sXdbgAGdesPm9ICM
 u/TF+cUMGuq3jm9qdzTE7PR7EkUBG39Zn0M3At8/CxzlH3NL6QJXpGNmMzuFKfP9Fr0T
 GTJfokkgiQnP8SKHAffQ3rX1kqzLLAcAp6YVNZEoOEYsDA+GJo9fC/xBjSltzuioEd7L
 JWfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4khKVkvfII1i5XcU9Ml/7b9dhHpCdtdE33hK0stFI2j//IdRvlOaDubLaa+nbVUpv6vkqacE=@lists.denx.de
X-Gm-Message-State: AOJu0YxVKOpBvK9XzRV0G0myYU56CviX/QGY1b4EhjoQff9AwZu3afh1
 v191h1TAf39zEXMpFfVOJdv1G8yQ+vtcnG8WggXEbtEbaFK79mjAGtBKh1q/g2YjB2w=
X-Gm-Gg: ASbGncusVGa0zgOM/USisCPpSc2GVPE+KInsj52u8jIz1IS5BKk8j+L2O4LKOly0q9t
 zgYw7/rX1/y69Yhwki6bHitoLIIqogi7sVeBUEEcBPpxwSGhmcTE4a7u6LwL+bVFnZI5KiN/3BJ
 LW//CYw3JPPfRl/76tOWu7/TN69xsdjveO7eEphfO8NMHcR2hk9D4tVZfou0YHtR9ok9+iU73R2
 ikwXuB24P2M3vq7QNdVynBMIsYHpCcaNt6H/6kvCDOKCf3Z/kM/DVL9X5yP3qi4wQpoDrnT2lAA
 4PCdrctNA+HxnlPCtIytYRONHZWaO6AkwzsNNVZR6K9wEuqqHxKkVuTSjtSeOI/XbIuOr8FwEsz
 1kkqpIsXjYs29crAaVNujD9S6sjW+GDhvGBeAxCAKFZPA/t7rGA1c4m+mPPRVW611hZUPmitZWJ
 /ldA4iK4ppVA6ghMzdam+bMoro2hoLSDcRrb856w==
X-Google-Smtp-Source: AGHT+IHIoAUvI7j/QpWi6VIEr+DGh+YeIjUmxjf0SOcib2CqhYe/ToVK/PO5xVaNRw/hWdswbSJmnQ==
X-Received: by 2002:a05:600c:3b0f:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-46e7110a268mr105179185e9.16.1759744287811; 
 Mon, 06 Oct 2025 02:51:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0?
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8343sm251581045e9.2.2025.10.06.02.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 02:51:27 -0700 (PDT)
Message-ID: <2952aa96-5787-4414-9435-1846d2b35bd3@linaro.org>
Date: Mon, 6 Oct 2025 10:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Prevent leak of memory from tmp_files
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20251003-efi_capsule-v1-1-07d5fd09b97f@linaro.org>
 <49d2c974-a2f1-44be-8d80-285154cf52d0@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <49d2c974-a2f1-44be-8d80-285154cf52d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 06/10/2025 08:47, Heinrich Schuchardt wrote:
> On 10/3/25 16:54, Andrew Goodbody wrote:
>> After the malloc of tmp_files and before its value is recorded an early
>> exit will need to free tmp_files to prevent leaking that memory.
>>
>> This issue was found by Smatch.
> 
> Thank you for following up through all those issues indicated by static 
> code analysis.
> 
> Tom could grant you access to Coverity to look at what is reported there 
> (https://scan.coverity.com/projects/das-u-boot).


Thanks Heinrich. Tom has already granted me access to Coverity. I am not 
quite sure where my priorities will be next but I hope to at least look 
at adding Smatch to CI.

Andrew

>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   lib/efi_loader/efi_capsule.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
>> index 
>> f19e78ae9d1e250f7bf8362f043877c6d10a9675..31b47a20186e036f6852c6baa4f353a5d7b97632 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -1096,8 +1096,10 @@ static efi_status_t efi_capsule_scan_dir(u16 
>> ***files, unsigned int *num)
>>       while (1) {
>>           tmp_size = dirent_size;
>>           ret = EFI_CALL((*dirh->read)(dirh, &tmp_size, dirent));
>> -        if (ret != EFI_SUCCESS)
>> +        if (ret != EFI_SUCCESS) {
>> +            free(tmp_files);
>>               goto err;
>> +        }
>>           if (!tmp_size)
>>               break;
> 
> LGTM
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

