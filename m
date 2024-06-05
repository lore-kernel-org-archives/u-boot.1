Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B5C27C5E
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 12:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5582888354;
	Wed,  5 Jun 2024 14:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TMVCnduZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85F488261; Wed,  5 Jun 2024 14:06:07 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B6D88261
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 14:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a30b3a6cbso2765248a12.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717589165; x=1718193965; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vdIAUqEzJLD5eMi+hRrOuxewt1vWLCKR4z8DqNkGH74=;
 b=TMVCnduZXXqUbHXl6FmFK4uVWU7bX+sz/Z/1oIW54BSF9uA9GpsIWosaSe+h8dFprq
 qGWqkgN9hvltRP7fLsp6zniG+fJdmlyvGvk3vhg2s/HmX2h3hSqi+Q6UP8g6maa0jOXY
 KhyEdirRVnAD8KLsixuMeh3N1CxTi5P/Z/6hnNTu+jBbBS9+aF5a4vuBwy9kaU3qX6fd
 zeUK0vhzqegM0xGNI6EI5opHku/cs3Mm9pnvK5prVftkcpE39+otI3p5DqxCgRTFTtLK
 BYqzvB2n5N4hkt8afQBmNX3xt6tk03j0tdFUq1hCXYHqU59UbCd2kh5TyCcQG6HsWxOX
 FyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717589165; x=1718193965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vdIAUqEzJLD5eMi+hRrOuxewt1vWLCKR4z8DqNkGH74=;
 b=e/bF3AWJ9AHDQnjXYY3WsPfrDgq/CgsUNZaVb+8ZmFnIFzxWnkaaz53oWFPuZ/9Uin
 eYyXrkqsBTujOsWJMgP2MdDPzKMEh0lwhj6yaapUawXQcirDc/N7rFoS6XXpMkd/5AvT
 WLNu/GmVspYPnHkydKZ8yDkDexmx+bRhZvbKf5nfQ3U291liaemkSASt4+57+q1e0WUx
 UNantZ7L8kz0O3O7d+yZz6orE19YhYE4c1BNeGj983SzXO1TKEyOIfw7HDEnKD4R6kU0
 1hFLnxqFt7CnwO9PvZp1mxINuEZhIPPCI8DjFEaWJmdGsCiTPSBYBXhUYTVlLSJwP0+Y
 UgaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrn1N+w8T1LRdnXHK+sMJt0v7neGAsIhFIMjcHiCDqEPbUuLm1hfXRqxX1JTXA7ukEtqSv58vWaB7Rn1jyqXX+WMSL2Q==
X-Gm-Message-State: AOJu0YyMZPhb0scH9CzCbpnCFJApiO1bfWybDsgpKCFuJQzQzQrSVv3A
 BqpAerAaXvQMuv/+eDh66yykGapDsLsgKgId1hVR6c3A6xQWPpzb2d/NQCDSJGk=
X-Google-Smtp-Source: AGHT+IHXBqmBQK1yIsVnuLG/ytN2WfLvarW/Ud3eUvzg8paO6jcpHO8YcV9nilXhYOMUt1GxqgJwRw==
X-Received: by 2002:a50:aa93:0:b0:57a:4ff8:2f11 with SMTP id
 4fb4d7f45d1cf-57a8b674ac2mr1551735a12.5.1717589164527; 
 Wed, 05 Jun 2024 05:06:04 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a61b4e36dsm5460703a12.75.2024.06.05.05.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 05:06:03 -0700 (PDT)
Message-ID: <61e7da76-4599-4c2a-8c35-f3caa2724e0a@linaro.org>
Date: Wed, 5 Jun 2024 14:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] lib: uuid: add UUID v5 support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
 <CAFLszTj=yu5AGBDv7K7ir=_dCGzsZ1Zc3UXafxSDTM0wKZ=pNw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTj=yu5AGBDv7K7ir=_dCGzsZ1Zc3UXafxSDTM0wKZ=pNw@mail.gmail.com>
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

On 05/06/2024 04:13, Simon Glass wrote:
> Hi Caleb,
> 
> On Fri, 31 May 2024 at 07:50, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Add support for generating version 5 UUIDs, these are determistic and work
> 
> spelling
> 
>> by hashing a "namespace" UUID together with some unique data. One intended
>> usecase is to allow for dynamically generate payload UUIDs for UEFI
>> capsule updates, so that supported boards can have their own UUIDs
>> without needing to hardcode them.
>>
>> Tests for this are added in an upcoming patch.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   include/uuid.h | 17 +++++++++++++++++
>>   lib/Kconfig    |  8 ++++++++
>>   lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
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
> 
> Can you explain somewhere why the static inline is needed?

The explicit "inline" certainly isn't, but this must be static because 
it's defined in a header, so we'd otherwise have multiple definitions 
for every #include.
> 
>> +
>>   /**
>>    * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
>>    * @uuid_str:  pointer to UUID string
>>    * @uuid_bin:  pointer to allocated array for little endian output [16B]
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 189e6eb31aa1..2941532f25cf 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -80,8 +80,16 @@ config RANDOM_UUID
>>          help
>>            Enable the generation of partitions with random UUIDs if none
>>            are provided.
>>
>> +config UUID_GEN_V5
>> +       bool "Enable UUID version 5 generation"
>> +       select LIB_UUID
>> +       depends on SHA1
>> +       help
>> +         Enable the generation of version 5 UUIDs, these are determistic and
> 
> spelling
> 
>> +         generated from a namespace UUID, and a string (such as a board name).
>> +
>>   config SPL_LIB_UUID
>>          depends on SPL
>>          bool
>>
>> diff --git a/lib/uuid.c b/lib/uuid.c
>> index dfa2320ba267..2df0523e717f 100644
>> --- a/lib/uuid.c
>> +++ b/lib/uuid.c
>> @@ -21,8 +21,9 @@
>>   #include <part_efi.h>
>>   #include <malloc.h>
>>   #include <dm/uclass.h>
>>   #include <rng.h>
>> +#include <u-boot/sha1.h>
>>
>>   int uuid_str_valid(const char *uuid)
>>   {
>>          int i, valid;
>> @@ -368,8 +369,44 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>>                  }
>>          }
>>   }
>>
>> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
>> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
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
>> +               unsigned int len = va_arg(args, size_t);
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
