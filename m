Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374C6C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 18:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B023288626;
	Wed, 29 May 2024 20:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mJwtT+GL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33AF8844E; Wed, 29 May 2024 20:55:19 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C97F88650
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 20:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6267643794so121444666b.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717008916; x=1717613716; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dsd1KHcCIaJfmjhULjfWq6NQq/DL8Z55szLQp6sjmUM=;
 b=mJwtT+GLorUDZBopDy6jQjMXdphSRz6Vw5qNUF7TAei7rr8HzfCZ2tzfewdvLLTw2n
 VMO0MlGYIEQ6heXS8bjdrub8dD89auIpBD5QUrYeu04Qv9ZIHdMADQDFA6BfWbywM1z0
 dQzPmanLOItCTLrPgi/gYZAUXy/Dqg7AH0ipEHw/5t8n5HC/Ywf0gM1EtgrZQw28+JcH
 +S26glDvB9IegcG1WOD/9qIxrwgT61+6szXkj3Has3w4E1fW0x5U1iicDSdgj9iFuDc+
 yFZrc+UvAXcVPhXdL/O9DsCxF0XIvaak9Dn1BSny+0YImjUlWm5hVFe10gkbHMypweBr
 /Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717008916; x=1717613716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dsd1KHcCIaJfmjhULjfWq6NQq/DL8Z55szLQp6sjmUM=;
 b=qwxTRzJ55pDG7Xq8m/FsZGUdRHde4Wag5GDBp+OAClrZ0UH29uzjBDjcWpQnoor1qS
 Tf3dkILQCzCYyVCZN26GDOTcBfmAqDXNI/2WzyTtYRWmi19LDVPBD1XRiasy+kcdNB83
 jePHYcO7oLiw4HRVxKXSQuH74qfw/UQGj//Y7+QebthMPUlIeKdzhD+HVCts6itBgp+r
 pchSTnCc/Vq4cG3c39e068Hq1YCqBzTixs6sw9tq9GusEJnU3t9xMBE6pshQJlmrhpBe
 2J4L6sBYvmrOCm/U4yr+Omq7VxSI2PHinpBoX1Xv3mbXXYzKQmRhOFs1/27epE0GtFpa
 V6/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwdTPFl6ivKBMpX7TMd0QQbJe0h7vjNfnfFbgo6+QwwAM/C/0jsk+7nCYBW9/DBRypw8PcHC7QVYHczZ7Irof1s1M8mw==
X-Gm-Message-State: AOJu0YxjTM3mDIFejzBBeTPolBRK92JZtrgv+hFFzsb/2gGqATLKxory
 +RsYb17vdkSfpm9rJ0qxLdt0oXRKP/ngHEWdoGzWNlMShwDkhKZMUl85+rWizO0=
X-Google-Smtp-Source: AGHT+IERs/SYRpMTpn3h16NehLHdP8BfDRIjEKLnnkAvIQ0NJNHpXqJ1JZQw3hPBAiaB23uN4eMyCQ==
X-Received: by 2002:a50:d749:0:b0:572:a770:1371 with SMTP id
 4fb4d7f45d1cf-57a17961a11mr9154a12.42.1717008915794; 
 Wed, 29 May 2024 11:55:15 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524bae15sm8791731a12.86.2024.05.29.11.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 11:55:15 -0700 (PDT)
Message-ID: <a58ab575-3a61-47fd-a0b7-1f7b0c1e8b40@linaro.org>
Date: Wed, 29 May 2024 20:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] lib: uuid: add UUID v5 support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
 <CAFLszTj2Ea8_oFaewsZ8bjNe3T3T9dfYbvFJ6wsw88B1HqDG8A@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTj2Ea8_oFaewsZ8bjNe3T3T9dfYbvFJ6wsw88B1HqDG8A@mail.gmail.com>
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

Hi Simon,

On 29/05/2024 18:30, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Add support for generate version 5 UUIDs, these are determistic and work
> 
> spelling

Thanks
> 
>> by hashing a "namespace" UUID together with some unique data. One intended
>> usecase is to allow for dynamically generate payload UUIDs for UEFI
>> capsule updates, so that supported boards can have their own UUIDs
>> without needing to hardcode them.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   include/uuid.h | 17 +++++++++++++++++
>>   lib/Kconfig    |  8 ++++++++
>>   lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
> 
> Can you please mention the tests for this? I believe they are in your
> last commit?

Yeah will do.
> 
>> diff --git a/include/uuid.h b/include/uuid.h
>> index f5a941250f48..539affaa47b9 100644
>> --- a/include/uuid.h
>> +++ b/include/uuid.h
>> @@ -10,8 +10,9 @@
>>   #ifndef __UUID_H__
>>   #define __UUID_H__
>>
>>   #include <linux/bitops.h>
>> +#include <linux/kconfig.h>
>>
>>   /*
>>    * UUID - Universally Unique IDentifier - 128 bits unique number.
>>    *        There are 5 versions and one variant of UUID defined by RFC4122
>> @@ -142,8 +143,24 @@ void gen_rand_uuid(unsigned char *uuid_bin);
>>    * @param          - uuid output type: UUID - 0, GUID - 1
>>    */
>>   void gen_rand_uuid_str(char *uuid_str, int str_format);
>>
>> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
>> +/**
>> + * gen_uuid_v5() - generate UUID v5 from namespace and other seed data.
>> + *
>> + * @namespace:   pointer to UUID namespace salt
>> + * @uuid:        pointer to allocated UUID output
>> + * @...:         NULL terminated list of seed data as pairs of pointers
>> + *               to data and their lengths
>> + */
>> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...);
>> +#else
>> +static inline void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
>> +{
>> +}
>> +#endif
>> +
[...]
>> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
>> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
> 
> Is this in a header file somewhere? It needs a function comment there.

Yes, see directly above where I add it to include/uuid.h

Kind regards,
> 
>> +{
>> +       sha1_context ctx;
>> +       va_list args;
>> +       const uint8_t *data;
>> +       uint8_t hash[SHA1_SUM_LEN];
>> +       uint32_t tmp;
>> +
>> +       sha1_starts(&ctx);
>> +       /* Hash the namespace UUID as salt */
>> +       sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
>> +       va_start(args, uuid);
>> +
>> +       while ((data = va_arg(args, const uint8_t *))) {
>> +               size_t len = va_arg(args, size_t);
>> +
>> +               sha1_update(&ctx, data, len);
>> +       }
>> +
>> +       va_end(args);
>> +       sha1_finish(&ctx, hash);
>> +
>> +       /* Truncate the hash into output UUID, it is already big endian */
>> +       memcpy(uuid, hash, sizeof(*uuid));
>> +
>> +       /* Configure variant/version bits */
>> +       tmp = be32_to_cpu(uuid->time_hi_and_version);
>> +       tmp = (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
>> +       uuid->time_hi_and_version = cpu_to_be32(tmp);
>> +
>> +       uuid->clock_seq_hi_and_reserved &= UUID_VARIANT_MASK;
>> +       uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
>> +}
>> +#endif
>> +
>>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>>   void gen_rand_uuid(unsigned char *uuid_bin)
>>   {
>>          u32 ptr[4];
>>
>> --
>> 2.45.0
>>
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
