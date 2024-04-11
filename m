Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5665ACD11C2
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 00:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A457581F9A;
	Thu, 11 Apr 2024 02:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QcgdmiOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C4487150; Thu, 11 Apr 2024 02:01:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6978180245
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 02:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6559B3F17B
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712793692;
 bh=waK/9ObzTs80DjbNy8Cur50ohLI7hDUq5UFUHgzg0f4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=QcgdmiOUTVrDUko994/vO2/vh4jA1Rn49d6A1uCe7wfN3XcZeEUJEwiV7d7qLO+1h
 g+X4qlEl6YMmKDI6j1m6GkRILtu5i54Nv3ntQQIzhELibc9kzJrjuodtgcYtHEK6Ww
 Os67XeeglsNrSXxRr9sXoveaRROsKhXY89HSdJu9LSeDJwo42Sj/cT4IMAbhb3XX0m
 G142+VFzIVxHDuElVMt0wxPUIQszcd3+HOFntRhGYptf24o5mcdpvFWuV/Doe6OmfI
 Xx6eEl56HqnJTIjwsMbfyVLJhlAGBQOs+Y04hXC65izkP9m5WOfzraFADAY14wH8Ec
 BuqCkD26vtgDA==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56e592bebedso2560522a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 17:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712793692; x=1713398492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waK/9ObzTs80DjbNy8Cur50ohLI7hDUq5UFUHgzg0f4=;
 b=XXyaINjpY9+lyz1v8vVjQlW74D+gxacFgdmf2ivLlexpfv0ySERly2r/N9mwjLeEQb
 xjL6rLNVruljl1H8oK/yQusTZ/hAkgrlk6J1rciOzHFrnAoi8v3iDuytlvtlciReD46L
 Pt7nzQ1g5jYzYpmMkxrJNPVjBJT7pQFRIS7fTPC2353B2urGzA1YKuVe0nj9w91asaUY
 eIbdwsiiS/xSuSGBja+0B1ZxicAGw8O/Haiswf7ypqgubIj3bAT9hshM5QJXaHT9Z8zD
 OalEyWRD4ZwghWu+1UsWFeyYiAYzPjSfki+aXflPm6C2MSTdSteArW4XGFSJn4nvfTuN
 PNGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUygxnkHZ/r7P9mzlPKdFBc26p+vtFh/qPnFDcMo8Lvz5dFh4Nso2DVYak8FOe4ykobhXrQBRrEAwuLTiBl8MWeejKvIg==
X-Gm-Message-State: AOJu0Yy4I/3iM99z4I/nmrf/n6IwdKix2RxFdPEa903wckE10pHNY4w/
 DKHMDKbXqZHqXoyO+ul6BKFNXhK8FFeQ+1ohKkq2GKmzaClx3uDqIAZ/e2lF6rwbD/sBCo/KbRu
 QumMwuYnYAvv1saj3rlfXR9sZbtBopnpBGaJ4fSoL40adpa2IiG6r4rBvRdC8vl+sNO8=
X-Received: by 2002:a50:d51b:0:b0:56d:fb36:c388 with SMTP id
 u27-20020a50d51b000000b0056dfb36c388mr2964830edi.9.1712793692001; 
 Wed, 10 Apr 2024 17:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFG0G+3SNt3CP1yyHKVtSXqza5Af55gHsUk6BLKA6ghznbJ7MS4q6J3fHQhdO3ztMgSlIpzw==
X-Received: by 2002:a50:d51b:0:b0:56d:fb36:c388 with SMTP id
 u27-20020a50d51b000000b0056dfb36c388mr2964817edi.9.1712793691526; 
 Wed, 10 Apr 2024 17:01:31 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 a90-20020a509ee3000000b0056e0376286bsm154694edf.24.2024.04.10.17.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 17:01:31 -0700 (PDT)
Message-ID: <cc7bcf37-44cc-4c20-af26-ef089bcc02c4@canonical.com>
Date: Thu, 11 Apr 2024 02:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: use adequate entropy source for initialization
 vector
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, sjg@chromium.org, oleksandr.suvorov@foundries.io,
 paulerwan.rio@gmail.com, hugo.cornelis@essensium.com, u-boot@lists.denx.de
References: <20240410233116.57402-1-heinrich.schuchardt@canonical.com>
 <87sezshjbz.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <87sezshjbz.fsf@bloch.sibelius.xs4all.nl>
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

On 4/11/24 01:46, Mark Kettenis wrote:
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Date: Thu, 11 Apr 2024 01:31:16 +0200
>>
>> The random() function is unsafe to initialize cryptographic data.
>> Use getrandom() which reads from /dev/urandom instead.
>>
>> getrandom() is available on Linux sine release 3.17 and on BSD.
> 
> NACK
> 
> getrandom() isn't evailable on OpenBSD.  Either use getentropy() or
> arc4random_buf() instead.

Thanks for reviewing. arc4random_buf() was added to glibc only in 2022. 
So there might be too many users not using a recent enough Linux distro. 
So I guess getentropy() is a better choice.

Best regards

Heinrich

> 
>> Addresses-Coverity-ID: 312953 Calling risky function
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   tools/image-host.c | 36 +++---------------------------------
>>   1 file changed, 3 insertions(+), 33 deletions(-)
>>
>> diff --git a/tools/image-host.c b/tools/image-host.c
>> index b2a0f2e6d16..d30a235baf6 100644
>> --- a/tools/image-host.c
>> +++ b/tools/image-host.c
>> @@ -13,11 +13,11 @@
>>   #include <fdt_region.h>
>>   #include <image.h>
>>   #include <version.h>
>> -
>>   #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
>>   #include <openssl/pem.h>
>>   #include <openssl/evp.h>
>>   #endif
>> +#include <sys/random.h>
>>   
>>   /**
>>    * fit_set_hash_value - set hash value in requested has node
>> @@ -364,36 +364,6 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
>>   	return ret;
>>   }
>>   
>> -static int get_random_data(void *data, int size)
>> -{
>> -	unsigned char *tmp = data;
>> -	struct timespec date;
>> -	int i, ret;
>> -
>> -	if (!tmp) {
>> -		fprintf(stderr, "%s: pointer data is NULL\n", __func__);
>> -		ret = -1;
>> -		goto out;
>> -	}
>> -
>> -	ret = clock_gettime(CLOCK_MONOTONIC, &date);
>> -	if (ret) {
>> -		fprintf(stderr, "%s: clock_gettime has failed (%s)\n", __func__,
>> -			strerror(errno));
>> -		goto out;
>> -	}
>> -
>> -	srandom(date.tv_nsec);
>> -
>> -	for (i = 0; i < size; i++) {
>> -		*tmp = random() & 0xff;
>> -		tmp++;
>> -	}
>> -
>> - out:
>> -	return ret;
>> -}
>> -
>>   static int fit_image_setup_cipher(struct image_cipher_info *info,
>>   				  const char *keydir, void *fit,
>>   				  const char *image_name, int image_noffset,
>> @@ -465,8 +435,8 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
>>   		if (ret < 0)
>>   			goto out;
>>   	} else {
>> -		/* Generate an ramdom IV */
>> -		ret = get_random_data((void *)info->iv, info->cipher->iv_len);
>> +		/* Generate a ramdom initialization vector */
>> +		ret = getrandom((void *)info->iv, info->cipher->iv_len, 0);
>>   	}
>>   
>>    out:
>> -- 
>> 2.43.0
>>
>>

