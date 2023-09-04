Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DB8C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 17:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72B986411;
	Mon,  4 Sep 2023 19:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZQO8M6N4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC1B863DC; Mon,  4 Sep 2023 19:04:35 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3ACB864EA
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 19:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6686D3F545
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693847072;
 bh=vqmXg+PQmpUuETCxaBQ4H0u5QR0X0+Hkr68gvTbScjo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ZQO8M6N4voWV+EiJxPLA/Wirrrw/kS9hUth9KUy9xO/ReU46BizPy+NL4uQPBPqak
 /h1pv3gIxp2YUpfH6JFDVSgwfXysueP/O+roAjwyPre4pr8AkXg4p6Qiij7DjhkFHJ
 XUxd3fALpbUVUHZNAAc6zsjq++kOb883ssZsU6K1svx+IP2IUJ2OFrHK7K2cVojzJU
 8inRzJvHHV6ForaA5KumYP/7KTOaFAvVTVl479cZAExFjD++Q3O3ptlnkAA/MlRluA
 4ksjGbej8/85oegqkrufe61d9oe1UuM6+j49pRv1w2II95y3fD+54X2g0OF+BhEZC9
 9XaeAtWjveCqA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso11689055e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 10:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693847072; x=1694451872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqmXg+PQmpUuETCxaBQ4H0u5QR0X0+Hkr68gvTbScjo=;
 b=V8NFM8RhLC5s/d2CJ3n9xBtHpvHbbTFHOAsJI1s1u11M9hu3h88DsNG4ea5AeGsDlN
 ACsWPD923aigm0ZWXFB3WQnWnH2lLuBkCjDAsV2rpVGua1POyKHUpVPXdtamUlHcpZFd
 DTnevxd/+5eyRZ9v5Ud8Zf2qc2kZ9IhIEEYLtOadroS1A0ZqGHqobE/CddHng+s5FjeF
 XzF729HF6gZsmuEbBW4+WWpP3B1nZxfpZkNkKPaELmhv1IlP0OU4mDkCYklDOMBH6MW9
 LzwI+BXTBgqfhrHYH6hF+bYzYmQTnplAyk4eLDiTQ6G/UQaMrG705PBu2hUjXbprS8Il
 +qtw==
X-Gm-Message-State: AOJu0YztrGV5Nn9jW1RW2F45xuWUdKbYm4xO2hLuQnyGCmFsghAA0vHt
 kWSLtkXxNmH7cMSSHhS5+er1tYOZz47wK/GqCBESYMeqqL6XnfJptRc0eqDFHhw7zNH2Nvq8fe9
 ruFgAvtfKZ3g+liqY24fn6E/6lenxQ10=
X-Received: by 2002:a05:600c:2108:b0:401:b1c6:97d8 with SMTP id
 u8-20020a05600c210800b00401b1c697d8mr8393401wml.35.1693847071946; 
 Mon, 04 Sep 2023 10:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAOVkoNCfqQ5F/Pe7xWY3338SbyJlADru2vmj8Q0V/7tIHw5a0lkGacqTTMoNFCYLlglgFpA==
X-Received: by 2002:a05:600c:2108:b0:401:b1c6:97d8 with SMTP id
 u8-20020a05600c210800b00401b1c697d8mr8393386wml.35.1693847071608; 
 Mon, 04 Sep 2023 10:04:31 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b003fe195cecb3sm17869334wmi.38.2023.09.04.10.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 10:04:30 -0700 (PDT)
Message-ID: <0469a0ae-b336-4ccd-9539-bf5d793c401d@canonical.com>
Date: Mon, 4 Sep 2023 19:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] part: rename disk_partition_type_uuid()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-2-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0UYquSyqyCoAYVG3UmiB-K07oyUsE6pXds_E1BiGf9NA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ0UYquSyqyCoAYVG3UmiB-K07oyUsE6pXds_E1BiGf9NA@mail.gmail.com>
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



On 9/4/23 18:48, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 2 Sept 2023 at 01:34, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Rename disk_partition_type_uuid to disk_partition_type_guid.
>>
>> Provide function descriptions for the getter and setter.
>>
>> Fixes: bcd645428c34 ("part: Add accessors for struct disk_partition type_uuid")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
>> ---
>>   disk/part_efi.c |  2 +-
>>   include/part.h  | 26 +++++++++++++++++++++++---
>>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> But this doesn't look like a rename

We replace *uuid by *guid. So the function is renamed.

Best regards

Heinrich

> 
> 
>>
>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>> index 39382c5fae..b7aef3731b 100644
>> --- a/disk/part_efi.c
>> +++ b/disk/part_efi.c
>> @@ -299,7 +299,7 @@ int part_get_info_efi(struct blk_desc *desc, int part,
>>          }
>>          if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
>>                  uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
>> -                               (char *)disk_partition_type_uuid(info),
>> +                               (char *)disk_partition_type_guid(info),
>>                                  UUID_STR_FORMAT_GUID);
>>          }
>>
>> diff --git a/include/part.h b/include/part.h
>> index f321479a5e..db34bc6bb7 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -108,18 +108,38 @@ static inline void disk_partition_clr_uuid(struct disk_partition *info)
>>   }
>>
>>   /* Accessors for struct disk_partition field ->type_guid */
>> -extern char *__invalid_use_of_disk_partition_type_uuid;
>> +extern char *__invalid_use_of_disk_partition_type_guid;
>>
>> +/**
>> + * disk_partition_type_guid() - get partition type GUID
>> + *
>> + * By using this function to get the partition type GUID we can use
>> + * 'if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))' instead of
>> + * '#ifdef CONFIG_PARTITION_TYPE_GUID'.
>> + *
>> + * @info:      partition information
>> + * Return:     partition type GUID
>> + */
>>   static inline const
>> -char *disk_partition_type_uuid(const struct disk_partition *info)
>> +char *disk_partition_type_guid(const struct disk_partition *info)
>>   {
>>   #ifdef CONFIG_PARTITION_TYPE_GUID
>>          return info->type_guid;
>>   #else
>> -       return __invalid_use_of_disk_partition_type_uuid;
>> +       return __invalid_use_of_disk_partition_type_guid;
>>   #endif
>>   }
>>
>> +/**
>> + * disk_partition_set_type_guid() - set partition type GUID
>> + *
>> + * By using this function to set the partition type GUID we can use
>> + * 'if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))' instead of
>> + * '#ifdef CONFIG_PARTITION_TYPE_GUID'.
>> + *
>> + * @info:      partition information
>> + * @val:       partition type GUID as string
>> + */
>>   static inline void disk_partition_set_type_guid(struct disk_partition *info,
>>                                                  const char *val)
>>   {
>> --
>> 2.40.1
>>
