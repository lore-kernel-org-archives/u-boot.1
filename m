Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33991CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E4B831D3;
	Thu,  2 Oct 2025 13:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FEqrqqD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0968F83526; Thu,  2 Oct 2025 13:00:11 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA68828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so7058865e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759402807; x=1760007607; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jmporUruuKt3Kd2oIuKmlt2SND2fYda1WzBOBZsg9Q=;
 b=FEqrqqD5Dwx/bKiYE7RGlEkjJJ8+N5BHKk0FCMLU4wZBvoAaJwWTQw9hhghUnHPV+2
 oLnYQbInx/gKcKvHq+vBSsUmfUOGOMyKNsYTbjz0M7SbpgTZ4eIBBLllOkyt6GsfVCks
 ANmbkZ9/iIy66FfnCU1Gzdyhg0eqZxOd5k01RpROG9l0Vln+Yg6SstBG0upnHoooVUUi
 3XpAURAKSZkAtDKKpFqmswbsw0VZm8fiUBk6/9O7hD+SV8KUnccJTCcu7p3qqVagRXIL
 2/2BSuOsnypxNWjlleQAaBD/n/tOLPA6AdbO2PJ0Mijbc5hswuw6MGb/5eo+8r+ZWko/
 JyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759402807; x=1760007607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jmporUruuKt3Kd2oIuKmlt2SND2fYda1WzBOBZsg9Q=;
 b=dKbYPJrC1D3aRYZ0UKAMZzj4p1FQ8tJfAY2Uw3Fhi2SlVitDNlrvBfGpQqsIc1nT62
 clHNiSrB/noD11BY6obL8MK7aMkY2JDga6HKRqKBa32jBChOTv4AeLy5c9uUDmWS9kF0
 MIG4VsScd7tekJLn4PaKJ+ynEjqITmFDJ3b7niupX+L2f+OovsFonN6CEqZgQrsvIg/H
 qybMqM6rWWr0Tayp3xPSOhu0o+QqbVyR0yRsttscDYdno//8jVMv3oHY6b2TdPwSDjeB
 ZSek8ouooCrMfMUsZmv/xSgcb24RhTfWqxBq1P/ZT/4Ig85bDtnzOLRXmrtT3T1jydl/
 rFug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSsD1kik/DB2gXod9xD9X0nCCWWZEXqTh3ewJGzWHSocOC7lN4rB2g1M+Az3KFEGfVTyyYoIY=@lists.denx.de
X-Gm-Message-State: AOJu0YwHLt4+tgtlQlnRj/cX5e1tmQlvclLjXdNkF0g7AVt5Y86Bh8jd
 Ov3x+4q1RhW+IIqWSmslG8tYzu8IUWxiEJTHgDUvJU12P4cgZux2ZaOaY8vwcp7vn98=
X-Gm-Gg: ASbGncs8UanH+tX+tNWYvuQW2F3sK3AcqNjKr1fVRoxqtVU7IhyQkH0qDYRkTpQ3lZA
 bFB/um5ToWAsctBfOqwkVIYIwIBpyorlwzBgd1ROLjsoGjkKe94hDHUIkHL9vNBNd8y1DNbRyAO
 oSAPtEBAlO0EXmvZwiEMzy462Fm9X1Vdu9Ablxzfa2tRR6gx8lEeHpAbETuh8QEjgH/zTraF605
 lP6eV3/kukxkL4re2zi536McmN6o307aR25l0X8eoTpQsECDi46a73don7p81wR1/6q2azYcPBE
 treOTujTxA6XOqR90qGsMU227lj5/CT0svm9n7EM6JQ22LY93IGJQGS0hWGol4zOnooZ9Jv216A
 B2QwdN4vUvUr7VbmxRaZJ/+HFCUd4sItoNMwrmh+v3/kZfDWlJvxQhiFAKosvtFMCLVglw/uSnf
 LxQBjw6k6HMPtl3+TKQWcJ2Af4dq6LxA==
X-Google-Smtp-Source: AGHT+IFw0ak0BZ2u1KQWJCArOGRA7i3ZW+vB30mD+jJF59nW90al+yody63VRMR/Yp+k06mJjseKtw==
X-Received: by 2002:a05:600c:c0c5:b0:46e:59bb:63cf with SMTP id
 5b1f17b1804b1-46e612691efmr47164695e9.24.1759402807391; 
 Thu, 02 Oct 2025 04:00:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:a21d:c610:1e27:3706?
 ([2a0a:ef40:ebd:e301:a21d:c610:1e27:3706])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e691824c8sm30392025e9.6.2025.10.02.04.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 04:00:06 -0700 (PDT)
Message-ID: <6de97f77-c998-4cf5-8ff4-89a8d4813201@linaro.org>
Date: Thu, 2 Oct 2025 12:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
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

On 02/10/2025 10:52, Heinrich Schuchardt wrote:
> On 10/2/25 11:39, Andrew Goodbody wrote:
>> After calling a function that can return an error, the test to detect
>> that error should use the return value not a different variable. Fix it.
>>
>> This issue was found by Smatch.
>>
> 
> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
> 
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   fs/semihostingfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 
>> 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, 
>> loff_t pos, void *buffer,
>>       }
>>       if (!maxsize) {
>>           size = smh_flen(fd);
>> -        if (ret < 0) {
>> +        if (size < 0) {
> 
> The ARM specification (https://developer.arm.com/documentation/dui0203/ 
> j/semihosting/semihosting-operations/sys-flen--0x0c-) has:
> 
> SYS_FLEN (0x0C)
> 
> Returns the length of a specified file.
> On exit, R0 contains:
>      the current length of the file object, if the call is successful
>      -1 if an error occurs.
> 
> Please, consider that the file length on 32bit systems may exceed 2^31 
> You must not consider this as an error.
> 
> %s/if (size < 0)/if (size == -1L)/

Unfortunately that is not sufficient with the current code. smh_flen() 
and others will call smh_errno() if the sys call returns -1 so other 
error codes may possibly be returned. [1]
This seems to be going well beyond the scope of my patch.

Andrew

1. 80e62ccfa63 arm: smh: Return errno on error

> Best regards
> 
> Heinrich
> 
>>               smh_close(fd);
>>               return size;
>>           }
>>
>> ---
>> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
>> change-id: 20251002-fs_semihosting-85d697fbfcad
>>
>> Best regards,
> 

