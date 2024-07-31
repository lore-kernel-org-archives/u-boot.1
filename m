Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB07C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28F788970;
	Wed, 31 Jul 2024 10:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YZv2KFGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB75D88998; Wed, 31 Jul 2024 10:39:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBD08890F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2EAC53F6B5
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722415140;
 bh=mPqOrovr6CQV7YJyF6JecuPX2rmwYgqjgD3Cxptqdfg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YZv2KFGeb2OlMtEco7+QPp8Mkr7OcdGpOOPEKI1WnCkv4LoO1d+q7rtDpXPqRHgcf
 M4QSHP5pO5LzQks9OkDBSmfZIJqQnnF5cF6s+S16OSHw6kJmNt2oIp45qEx6Jmeo6k
 jWZU4qmW5c6qIVhc20M+V+Vo3l65sO6FI7AZ/cQwqiCvo3SzlLvnVzmmzHg3YPVWHK
 4xMgaTD7EN2OZd/nlLyzms5rDcjco9r5WE1LltKvTzSp5Y5VDEFHNu777BO3kz8VSz
 rjc43eH/Vzcn1sO+W/tHTwBrv/fko2xeOC2DHG7aLt5Aii9GY3yMjdsNX9Z0w/PtPG
 QekBbVXotBvrQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4280a39ecebso3200415e9.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 01:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415140; x=1723019940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mPqOrovr6CQV7YJyF6JecuPX2rmwYgqjgD3Cxptqdfg=;
 b=djkf7NWmVsQ4d76BvS7/2fsI/TMoIq9xaApihedVo57r6TTs8KTBBiDVNivNo0KUHV
 HRRu+T/qJckR393VSmWEe4IRZ5Lc1rQWmfp+VXa25aHJD/VNOrSwdCRngNhG7rtw7WMI
 x2Hcr7AoOtn75dYSFXSALn1bz6vfJjlPNHowQajNTociNKVv1wIjWkzf6rA85gu48jNw
 AM77WzHwysx7YerVCdgM/Tm4fBS9ERs8gP6+yUs9OPnjRCzsjoz5yBUdIbFbnGr7UMv0
 rNUKYjuONt+JaGbsuiBJMKO9RvRJlk1r2Jh6SO/xRRukl8f/GH31DXN3ThMVg6k8xbZp
 lkcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQIgxq8BuNwSYUdZA71cyQsOdYoRAP9HL9Me4vCFVFjrRTCcWDW6zh6UFXMHUmpOSI+raU5Ms93Jm1MB2tetQ3mAsfGQ==
X-Gm-Message-State: AOJu0YxrayYP59C/YzH4xUA7xTULrbOVkswbuHMUXEJCAA6riP5bONhX
 C3qONMk3jBQkcfHKc5ivQV6LQ5E5ZlVDRa9KbfK7NLEI0c+0ZogRmvd+zw9cMBBLCCMsUv/eUjS
 C/CQA0rbW+8VMDvRIc3z/9E4HdccScKNxXED5tbalUBGLhHOKOrxKwev29ngUOcRWA2U=
X-Received: by 2002:a05:600c:4707:b0:424:7871:2e9e with SMTP id
 5b1f17b1804b1-42824400d54mr32684425e9.6.1722415139708; 
 Wed, 31 Jul 2024 01:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9mvMlqRSpdNfXbDVAVuM+axyY5biZ88I28YU7/ZPppr3DDwTsHYM72y++SFZ4yTC2zAFPYA==
X-Received: by 2002:a05:600c:4707:b0:424:7871:2e9e with SMTP id
 5b1f17b1804b1-42824400d54mr32684255e9.6.1722415139197; 
 Wed, 31 Jul 2024 01:38:59 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89acacsm13248195e9.9.2024.07.31.01.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 01:38:58 -0700 (PDT)
Message-ID: <569b2366-14b3-4e7e-a986-2aa4eeb78e73@canonical.com>
Date: Wed, 31 Jul 2024 10:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: use list_count_nodes() in
 efi_protocols_per_handle()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240731081304.81848-1-heinrich.schuchardt@canonical.com>
 <CADg8p95P5iTuoJo-UZ1do8O=zKQVuorQh9-A4-XEguSVec2Fzw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CADg8p95P5iTuoJo-UZ1do8O=zKQVuorQh9-A4-XEguSVec2Fzw@mail.gmail.com>
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

On 31.07.24 10:34, Sughosh Ganu wrote:
> On Wed, 31 Jul 2024 at 13:43, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Simplify the code by using the list_count_nodes() function.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
> 
> I have made changes to the files that you mentioned in your review,
> and plan to come up with a v2 once the CI goes through. Thanks.

Hello Sughosh,

Please, rebase on 
https://source.denx.de/u-boot/custodians/u-boot-efi/-/commits/efi-2024-10-rc2 
for which I will create a pull request. It contains your v1.

Best regards

Heinrich

> 
> -sughosh
> 
>>   lib/efi_loader/efi_boottime.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
>> index eedc5f39549..4f52284b4c6 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -2509,16 +2509,12 @@ static efi_status_t EFIAPI efi_protocols_per_handle(
>>                  return EFI_EXIT(EFI_INVALID_PARAMETER);
>>
>>          *protocol_buffer = NULL;
>> -       *protocol_buffer_count = 0;
>>
>>          efiobj = efi_search_obj(handle);
>>          if (!efiobj)
>>                  return EFI_EXIT(EFI_INVALID_PARAMETER);
>>
>> -       /* Count protocols */
>> -       list_for_each(protocol_handle, &efiobj->protocols) {
>> -               ++*protocol_buffer_count;
>> -       }
>> +       *protocol_buffer_count = list_count_nodes(&efiobj->protocols);
>>
>>          /* Copy GUIDs */
>>          if (*protocol_buffer_count) {
>> --
>> 2.45.2
>>

