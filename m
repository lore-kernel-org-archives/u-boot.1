Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA53C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B67988653;
	Fri, 24 May 2024 14:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J28FUWe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 294B188660; Fri, 24 May 2024 14:20:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DCF8861D
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 14:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-578517c8b49so1050081a12.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716553250; x=1717158050; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PRPsnqSNxtJBAAap2v1L9s2J5FAs1YvOem8RXTgIaEE=;
 b=J28FUWe6CfCUfhjWpmsUk7JUHqViwGzvNm175tzSxJVqMaLRKgdpttmj3d03iV9Kyy
 fKcNkdYDKWCfBJ6NzZyOSbuj2j1L2EDfRuo/tQ8LU50keB71DsEazPrSjNZlv2wjS0gI
 lSwE4INVHdE8/gvwUEZoxNMaTKgfdLiJBT7BqKcO37jCqIZVwkswHH4ZIcp3+FKnaWAa
 07Z4ERieGjpEi8Slc8KLwhvvzva2mb9rqg/X2HxCa7h9Dz8G4EOKWanxeLvI+nn/KxUt
 Q5ExbPAhbRUpZ4BzeTDcZWvcZ2EZccpVl6g6k+uMKORcO4fWBgIW/ewJeR+1g2Nj8c3k
 +BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716553250; x=1717158050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PRPsnqSNxtJBAAap2v1L9s2J5FAs1YvOem8RXTgIaEE=;
 b=dxU3xL4h2YtG/SLngLBwGy5zeB4Py6wU7YK0aWtvGqiIgFVdnnSfE9gYzsPa4cWDyH
 T3FQIgtVBWM4Lfh7FnmVREpQPGAojQhhThPIt7E2vP8sFVPQeSi2+y/1FDBfkKrJtEIP
 jo+34ofzQAEXZzV8YTQUgQlqG9GhA0djJndKzlgjtNvurSgCeuLHyeoeFRk9i7pQbJGO
 cb1qYokLsiS4/RJCP0Oheb3T/uVPuFPoxyf/YajG4nSLAGgKxXdWd1XDBqfVuYJuqMbu
 Fh7CXo/uwpYxrashYCUEX+8ERrRg3XG1kRq8X99HBawdOFEXjkHUybogxKo30cMvDUsf
 Di2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmRPDZx13QjL0mK6EZgUe8FQqWun4AVPRNijyy055uqwoqtADh54IBIz4fmdDL9pJFXSgfoEtLqYICrcrHextejhdVqQ==
X-Gm-Message-State: AOJu0YyeJRiIXYxIzxVsSWb6PHxmBrzluLjt4Q/rGVmo2qA4s7sNhg8a
 H2MZyT20Djt57R5eTYsH8IyajsuTeDiTZvBzlocl2Pi96Pd+E3JNrv9BVM9D6Pg=
X-Google-Smtp-Source: AGHT+IEAwriixRkOmvNJVjwHkybDYd+AsZ+IzQLee0k2ETjekufMIg+03fuCMBrcOn4qFJfk7rZ+pA==
X-Received: by 2002:a50:ccd3:0:b0:573:4f61:ca9c with SMTP id
 4fb4d7f45d1cf-57862e12a13mr223483a12.4.1716553250574; 
 Fri, 24 May 2024 05:20:50 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578572e7aafsm1353821a12.46.2024.05.24.05.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 05:20:50 -0700 (PDT)
Message-ID: <6f354bbf-3062-4a2d-b0a5-b8559fbfe26a@linaro.org>
Date: Fri, 24 May 2024 14:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] lib: uuid: add UUID v5 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-1-e8154e00ec44@linaro.org>
 <CAC_iWj+WsO_dx84UHpv02b9cxNtzHYeCjZLP5VyVw9AbXet-yg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWj+WsO_dx84UHpv02b9cxNtzHYeCjZLP5VyVw9AbXet-yg@mail.gmail.com>
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



On 24/05/2024 08:01, Ilias Apalodimas wrote:
> [...]
> 
>>   #include <dm/uclass.h>
>>   #include <rng.h>
>> +#include <u-boot/sha1.h>
>>
>>   int uuid_str_valid(const char *uuid)
>>   {
>>          int i, valid;
>> @@ -368,8 +369,40 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>>                  }
>>          }
>>   }
>>
>> +#if CONFIG_IS_ENABLED(UUID_GEN_V5)
>> +void gen_uuid_v5(struct uuid *namespace, struct uuid *uuid, ...)
>> +{
>> +       sha1_context ctx;
>> +       va_list args;
>> +       const u8 *data;
>> +       u8 hash[SHA1_SUM_LEN];
>> +
>> +       sha1_starts(&ctx);
>> +       /* Hash the namespace UUID as salt */
>> +       sha1_update(&ctx, (char *)namespace, UUID_BIN_LEN);
>> +       va_start(args, uuid);
> 
> Should we use sha1 here? Is it described somewhere in UUIDv5 requirements?
> If not I'd rather have a sha256

The spec says sha1 yeah, this doesn't need to be cryptographically 
secure (the inputs are generally known) but just not have collisions.

That said, we don't need to be spec compliant - just consistent. So I'm 
fine either way. I'd err on the side of what's fastest to compute (if 
that even matters here).
> 
>> +
>> +       while ((data = va_arg(args, const u8 *)))
>> +               sha1_update(&ctx, (char *)data, va_arg(args, int));
> 
> sha1_update second argument is an unsigned int

Ah thanks.
> 
>> +
>> +       va_end(args);
>> +       sha1_finish(&ctx, hash);
>> +
>> +       /* Truncate the hash into output UUID and convert it to big endian */
>> +       cpu_to_be32_array((u32 *)uuid, (u32 *)hash, 4);
>> +
>> +       /* Configure variant/version bits */
>> +       clrsetbits_be16(&uuid->time_hi_and_version,
>> +                       UUID_VERSION_MASK,
>> +                       5 << UUID_VERSION_SHIFT);
>> +       clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
>> +                    UUID_VARIANT_MASK,
>> +                    UUID_VARIANT << UUID_VARIANT_SHIFT);
>> +}
>> +#endif
>> +
>>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>>   void gen_rand_uuid(unsigned char *uuid_bin)
>>   {
>>          u32 ptr[4];
>>
>> --
>> 2.44.0
>>
> 
> Thanks
> /Ilias

-- 
// Caleb (they/them)
