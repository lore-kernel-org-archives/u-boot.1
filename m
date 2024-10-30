Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E30D7494F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57F7891B2;
	Wed, 30 Oct 2024 01:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YYofJd15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868CD891BB; Wed, 30 Oct 2024 01:34:41 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E734890AE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so4972737f8f.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730248478; x=1730853278; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lcQlV6ZAmrfw7zRaBCG1m7Z/Zaqe+NsuQIQXL9voEaE=;
 b=YYofJd15MW4uj8oSxD7GlsoPslAANxSE1T0Y6X+BpW/P/87gM3pTGq19a0ePkETVuo
 +UUPnWNJ7Q5VvleFsKiE80/EGxOkvGitxS25JVCWIdrZnAD1rn9BhgFuLwh4WwtklMDy
 J25juBzbUb7AN7alqdrwbokF/V0P3YC+YPvp8QAwkDYIxRQbkVFfkqXlxdFPgg1Fxdle
 emKdjMiWh/B4YKEbGtvX0r/8dP5+9pSvKyaGlP8X9Lt0g6L4GXcdRv6dnPw6h4vPDo6+
 cd6TeaKx8NFAtB2B3zP9DH8nEVgDsG/NKmdVKfg3csXJRxW9qroZjxfFvLTCyHk9LZld
 bsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730248478; x=1730853278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lcQlV6ZAmrfw7zRaBCG1m7Z/Zaqe+NsuQIQXL9voEaE=;
 b=wh6EEYiSbHD73FQENK5exHJ9u0ARruT5gDpzyQxxz/SbnWe8cYIfSAlEMCNzs9Vx8y
 AhPmmh2TnM1xWa32J38Uztnjvjc9LLsc8uDpMWpBsCG3zN4U5efa9IrpNA15yz7ELWUY
 tCW7NuLT5m2dWnZsfwKlhUlW+QTChkqD4PLaLtkOmvLVxD3aUYbSzNKkBsBsJq90uwmb
 1BotbaEZhQarKrcu8HzyS5vFSXyya/JA0X2AKYpzuqNIs9T1EsMffe3jvAvBi6xovW7H
 Ev1YuM9PrCS87xy/MbolTy9c1hMlOXadMbElyn7hXuusxX3Ho0YGCvuzmQznIyV3WTuu
 R9zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEELX//sPsSp5BsDqKqowrSN0IdbKsc5Uh200nYLHR2gAPZg/NwscOqOsXn0l1FVlNKafbjTg=@lists.denx.de
X-Gm-Message-State: AOJu0YzqytvJgoJxg+wT/fMY3JVjNEfTSWUfaWJFcb2ZS68IGGZ0nVpF
 /vgqRGVBo8SqeZ+wCI/IexoKkp0wAk0AFYzVWmU3KCtiBagEXeJ/H9+a0hCywPo=
X-Google-Smtp-Source: AGHT+IHe6ydyXWyvQvO7uX59K89VTpPW6UQwsmOMfXgquhnyptoxK6g8qbjuaL4kWHj5BHM0oNvdTg==
X-Received: by 2002:a5d:55c4:0:b0:374:c11c:c5ca with SMTP id
 ffacd0b85a97d-38061227bb9mr12573063f8f.46.1730248478423; 
 Tue, 29 Oct 2024 17:34:38 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f069954sm517991966b.96.2024.10.29.17.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 17:34:37 -0700 (PDT)
Message-ID: <eee0be71-8b3c-423a-b9c7-8ee5dd0f3107@linaro.org>
Date: Wed, 30 Oct 2024 01:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/11] lib: uuid: supporting building as part of host
 tools
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
 <20240830-b4-dynamic-uuid-v8-6-79b31b199bee@linaro.org>
 <4b60130d-030f-405c-a753-eeb52a5e7b1d@foss.st.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <4b60130d-030f-405c-a753-eeb52a5e7b1d@foss.st.com>
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

Hey Patrick,

Wow thanks for tracking this one down.

On 28/10/2024 15:14, Patrick DELAUNAY wrote:
> Hi,
> 
> 
> This patch seens cause problemes for STM32MP1 platforms, AARCH32
> 
> For FIP UUID configuration.
> 
> 
> On 8/30/24 14:34, Caleb Connolly wrote:
>> Adjust the UUID library code so that it can be compiled as part of a
>> host tool.
>>
>> This removes the one redundant log_debug() call, as well as the
>> incorrectly defined LOG_CATEGORY.
>>
>> In general this is a fairly trivial change, just adjusting includes and
>> disabling list_guid.
>>
>> This will be used by a new genguid tool to generate v5 GUIDs that match
>> those generated by U-Boot at runtime.
>>
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   include/uuid.h |  4 ++--
>>   lib/uuid.c     | 44 ++++++++++++++++++++++++++++++--------------
>>   2 files changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/uuid.h b/include/uuid.h
>> index 1f4fa103b5e9..7f8414dc906c 100644
>> --- a/include/uuid.h
>> +++ b/include/uuid.h
>> @@ -69,10 +69,10 @@ struct uuid {
>>   } __packed;
>>     /* Bits of a bitmask specifying the output format for GUIDs */
>>   #define UUID_STR_FORMAT_STD    0
>> -#define UUID_STR_FORMAT_GUID    BIT(0)
>> -#define UUID_STR_UPPER_CASE    BIT(1)
>> +#define UUID_STR_FORMAT_GUID    0x1
>> +#define UUID_STR_UPPER_CASE    0x2
>>     /* Use UUID_STR_LEN + 1 for string space */
>>   #define UUID_STR_LEN        36
>>   #define UUID_BIN_LEN        sizeof(struct uuid)
>> diff --git a/lib/uuid.c b/lib/uuid.c
>> index c9dfdf007a18..6fdae7997702 100644
>> --- a/lib/uuid.c
>> +++ b/lib/uuid.c
>> @@ -6,25 +6,38 @@
>>    * Authors:
>>    *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>>    */
>>   -#define LOG_CATEGOT LOGC_CORE
>> -
>> +#ifndef USE_HOSTCC
>>   #include <command.h>
>>   #include <efi_api.h>
>>   #include <env.h>
>>   #include <rand.h>
>>   #include <time.h>
>> -#include <uuid.h>
>> -#include <linux/ctype.h>
>> -#include <errno.h>
>>   #include <asm/io.h>
>>   #include <part_efi.h>
>>   #include <malloc.h>
>>   #include <dm/uclass.h>
>>   #include <rng.h>
>> +#include <linux/ctype.h>
>> +#include <hexdump.h>
>> +#else
>> +#include <stdarg.h>
>> +#include <stdint.h>
>> +#include <eficapsule.h>
>> +#include <ctype.h>
>> +#endif
>> +#include <linux/types.h>
>> +#include <errno.h>
>> +#include <linux/kconfig.h>
>> +#include <uuid.h>
>>   #include <u-boot/sha1.h>
>>   +#ifdef USE_HOSTCC
>> +/* polyfill hextoul to avoid pulling in strto.c */
>> +#define hextoul(cp, endp) strtoul(cp, endp, 16)
>> +#endif
>> +
>>   int uuid_str_valid(const char *uuid)
>>   {
>>       int i, valid;
>>   @@ -51,8 +64,9 @@ int uuid_str_valid(const char *uuid)
>>   static const struct {
>>       const char *string;
>>       efi_guid_t guid;
>>   } list_guid[] = {
>> +#ifndef USE_HOSTCC
>>   #ifdef CONFIG_PARTITION_TYPE_GUID
>>       {"system",    PARTITION_SYSTEM_GUID},
>>       {"mbr",        LEGACY_MBR_PARTITION_GUID},
>>       {"msft",    PARTITION_MSFT_RESERVED_GUID},
>> @@ -231,8 +245,9 @@ static const struct {
>>       { "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
>>       { "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
>>       { "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },
>>   #endif
>> +#endif /* !USE_HOSTCC */
>>   };
>>     int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
>>   {
>> @@ -266,9 +281,8 @@ int uuid_str_to_bin(const char *uuid_str, unsigned
>> char *uuid_bin,
>>       uint32_t tmp32;
>>       uint64_t tmp64;
>>         if (!uuid_str_valid(uuid_str)) {
>> -        log_debug("not valid\n");
>>   #ifdef CONFIG_PARTITION_TYPE_GUID
>>           if (!uuid_guid_get_bin(uuid_str, uuid_bin))
>>               return 0;
>>   #endif
>> @@ -297,19 +311,19 @@ int uuid_str_to_bin(const char *uuid_str,
>> unsigned char *uuid_bin,
>>         tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
>>       memcpy(uuid_bin + 8, &tmp16, 2);
>>   -    tmp64 = cpu_to_be64(simple_strtoull(uuid_str + 24, NULL, 16));
>> +    tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
>>       memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
>>         return 0;
>>   }
>>     int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>>   {
>> -    u16 tmp16;
>> -    u32 tmp32;
>> -    u64 tmp64;
>> +    uint16_t tmp16;
>> +    uint32_t tmp32;
>> +    uint64_t tmp64;
>>         if (!uuid_str_valid(uuid_str) || !uuid_bin)
>>           return -EINVAL;
>>   @@ -324,22 +338,22 @@ int uuid_str_to_le_bin(const char *uuid_str,
>> unsigned char *uuid_bin)
>>         tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
>>       memcpy(uuid_bin + 8, &tmp16, 2);
>>   -    tmp64 = cpu_to_le64(simple_strtoull(uuid_str + 24, NULL, 16));
>> +    tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
> 
> Here you change
> 
> simple_strtoull  => return unsigned long long
> 
> to
> 
> hextoul => return unsigned long
> 
> for 32bits system that can the cause of issue I think

Yep that would do it, damn! I think I seriously just misread "strtoull"
as "strtoul" and didn't notice :(

I've sent
https://lore.kernel.org/u-boot/20241030003317.2901772-2-caleb.connolly@linaro.org
which should address this. I would greatly appreciate it if you could
give it a test.

Kind regards,
> 
> with UUID defined in stm32prog command, with use a gpt
> create command with UUID define in
> 
> ./arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> 
> /* FIP type partition UUID used by TF-A*/
> #define FIP_TYPE_UUID "19D5DF83-11B0-457B-BE2C-7559C13142A5"
> 
> /* unique partition guid (uuid) for FIP partitions A/B */
> #define FIP_A_UUID \
>     EFI_GUID(0x4FD84C93, 0x54EF, 0x463F, \
>          0xA7, 0xEF, 0xAE, 0x25, 0xFF, 0x88, 0x70, 0x87)
> 
> 
> with the patch the GPT partition is create with incorrect UUID (type and
> partion)
> with "0000" in last field.
> 
> 
> $> BAD
> Partition GUID code: 19D5DF83-11B0-457B-BE2C-0000C13142A5
> Partition unique GUID: 4FD84C93-54EF-463F-A7EF-0000FF887087
> 
> before the patch
> 
> $> OK
> Partition GUID code: 19D5DF83-11B0-457B-BE2C-7559C13142A5
> Partition unique GUID: 4FD84C93-54EF-463F-A7EF-AE25FF887087
> 
> for 32bits platform, we must use simple_strtoull and not
> 
> ulong hextoul(const char *cp, char **endp)
> {
>     return simple_strtoul(cp, endp, 16);
> }
> 
> for define hextoull()
> 
> 
> what do you thin, of this issue ?
> 
>>       memcpy(uuid_bin + 10, &tmp64, 6);
>>         return 0;
>>   }
>>     void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>>                int str_format)
>>   {
>> -    const u8 uuid_char_order[UUID_BIN_LEN] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
>> +    const uint8_t uuid_char_order[UUID_BIN_LEN] = {0, 1, 2, 3, 4, 5,
>> 6, 7, 8,
>>                             9, 10, 11, 12, 13, 14, 15};
>> -    const u8 guid_char_order[UUID_BIN_LEN] = {3, 2, 1, 0, 5, 4, 7, 6, 8,
>> +    const uint8_t guid_char_order[UUID_BIN_LEN] = {3, 2, 1, 0, 5, 4,
>> 7, 6, 8,
>>                             9, 10, 11, 12, 13, 14, 15};
>> -    const u8 *char_order;
>> +    const uint8_t *char_order;
>>       const char *format;
>>       int i;
>>         /*
>> @@ -419,8 +433,9 @@ void gen_v5_guid(const struct uuid *namespace,
>> struct efi_guid *guid, ...)
>>       tmp16 = (uint16_t *)&guid->b[6];
>>       *tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
>>   }
>>   +#ifndef USE_HOSTCC
>>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>>   void gen_rand_uuid(unsigned char *uuid_bin)
>>   {
>>       u32 ptr[4];
>> @@ -502,4 +517,5 @@ U_BOOT_CMD(guid, CONFIG_SYS_MAXARGS, 1, do_uuid,
>>          "e.g. guid guid_env"
>>   );
>>   #endif /* CONFIG_CMD_UUID */
>>   #endif /* CONFIG_RANDOM_UUID || CONFIG_CMD_UUID */
>> +#endif /* !USE_HOSTCC */
>>

-- 
// Caleb (they/them)

