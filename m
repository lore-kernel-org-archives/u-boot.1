Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C424C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 17:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD609863B2;
	Mon,  4 Sep 2023 19:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YkRmDw02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7761866DC; Mon,  4 Sep 2023 19:15:08 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCAF847C3
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 19:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 007753F545
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693847706;
 bh=M9l5pldM3HwepI+4wG8OExYZ0u5p8xdfk1+gMbyykFA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YkRmDw02aSas6WMTE+fFjelYQYDoWIMG7+qiVE3BoDRUksllqa3DzPBXxBeUfK2wK
 ZofzXRNnvaoN6KYPqo6R0Tl3huQetJqeyc2irS4WdUuxH8us8CbIek6QyrWZMVkK6g
 8y/Kxhb5LT2eR1jqRnSKjc+PINad2h+jPImoyPKTFpNpP9ShTvxjshWCOx6wGegvxj
 qEmpgt9eJTq6pdeLaYmz9uQAuDXCZzCDca9towq55ZlQQ7UTnH7334PjmgwkungTQU
 DK7gyQl4kUawD+ith1dQu2e7Nc4J/3oCyeBVEOgQte5WzgO4CVVqU61+n0zKZt9Zku
 cH3ld2nInmyXQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401e1c55ddcso11806855e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 10:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693847705; x=1694452505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9l5pldM3HwepI+4wG8OExYZ0u5p8xdfk1+gMbyykFA=;
 b=HeocgSfRI8UvrWU9bbQwUOMv+CLYSXhDhihwTQZlqfhoLaSo4kzVuCiduvMue3t8AD
 6w+Ce/z0fqx685YxBVaKxBy7SBjKrSTAFnTfdAt9AisHKFB73NGphuNPWAtGOZisCNRk
 f43/TnSAho8xhEnbEFNlwl/YuI+vKmXYcUbbk6P1gt9xll27y0Kc4nN1b531nfBiTFrT
 SuM9TCbGxRXtQKn4HmtRJJeiFvmadmlAy4u7YRm1dIqd1Bt5Hs7gZfMBfWhMPDZvJfd5
 wEXhocXjXICmtP/OHyygKsmNzN91dWVMZr1x0NU/cu5w7ISFQ+CelAXF/nanL2lfiGPe
 jlpQ==
X-Gm-Message-State: AOJu0YzQNkSuUJnkT058lMvs4EPc/VNPE3wR2lhZCGDwPlMMJYG2Dc5x
 /5eHcP2TYCq6c5c4VjQzTR83eD5jk2roKcIQI/VyESQIRsBCIAOTR3nPAwC5wUaAd01gXqKU3IU
 xrUw0E6Td5mL5e2HooMGcMrtSo+0v0Wg=
X-Received: by 2002:a05:600c:b50:b0:400:57d1:4914 with SMTP id
 k16-20020a05600c0b5000b0040057d14914mr7368917wmr.5.1693847705638; 
 Mon, 04 Sep 2023 10:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr/hC+MBJmaO6xS9A0do9/Vt+fr10U01MN0AAU0K0wASpcLP3O3olNc41HsZK9exHxcZ/s+g==
X-Received: by 2002:a05:600c:b50:b0:400:57d1:4914 with SMTP id
 k16-20020a05600c0b5000b0040057d14914mr7368902wmr.5.1693847705233; 
 Mon, 04 Sep 2023 10:15:05 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 x2-20020adff0c2000000b0031971ab70c9sm15035028wro.73.2023.09.04.10.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 10:15:04 -0700 (PDT)
Message-ID: <1e6282a0-cabf-47fd-9659-ab8812424018@canonical.com>
Date: Mon, 4 Sep 2023 19:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cmd: gpt: fix calc_parts_list_len()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-4-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3AqhF=yvQeS+dT6L6hFMAahuLNYKOf7-hMtCiadYfeuA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3AqhF=yvQeS+dT6L6hFMAahuLNYKOf7-hMtCiadYfeuA@mail.gmail.com>
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
> On Sat, 2 Sept 2023 at 01:34, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> * Avoid incrementing by moving comma into strlen("uuid_disk=,") and
>>    considering NUL byte.
>> * Appending a UUID only adds UUID_STR_LEN bytes.
>>    Don't count the terminating NUL.
>> * The length of the hexadecimal representation of lba_int is
>>    2 * sizeof(lba_int).
>> * We don't use a 'MiB' postfix but a '0x' prefix.
> 
> Why do we want the 0x prefix?

This patch is about correcting the number of bytes allocated for the 
output buffer. Is does not change the output format.

We want 'gpt write' to understand the output of 'gpt read'.

The ustrtoull(p, &p, 0) function call in set_gpt_info() requires the 
"0x" prefix to understand that size and start are hexadecimal.

See function _parse_integer_fixup_radix().

Best regards

Heinrich

> 
>> * The uuid field is only needed if configured.
>>
>> Fixes: 2fcaa413b3f6 ("gpt: harden set_gpt_info() against non NULL-terminated strings")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
>> ---
>>   cmd/gpt.c | 33 ++++++++++++++++++++-------------
>>   1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/cmd/gpt.c b/cmd/gpt.c
>> index 092f7defff..e7a53747fc 100644
>> --- a/cmd/gpt.c
>> +++ b/cmd/gpt.c
>> @@ -162,22 +162,29 @@ static bool found_key(const char *str, const char *key)
>>          return result;
>>   }
>>
>> +/**
>> + * calc_parts_list_len() - get size of partition table description
>> + *
>> + * @numparts:  number of partitions
>> + * Return:     string size including terminating NUL
>> + */
>>   static int calc_parts_list_len(int numparts)
>>   {
>> -       int partlistlen = UUID_STR_LEN + 1 + strlen("uuid_disk=");
>> -       /* for the comma */
>> -       partlistlen++;
>> -
>> -       /* per-partition additions; numparts starts at 1, so this should be correct */
>> -       partlistlen += numparts * (strlen("name=,") + PART_NAME_LEN + 1);
>> +       /* number of hexadecimal digits of the lbaint_t representation */
>> +       const int lbaint_size = 2 * sizeof(lbaint_t);
>> +       int partlistlen;
>> +
>> +       /* media description including terminating NUL */
>> +       partlistlen = strlen("uuid_disk=;") + UUID_STR_LEN + 1;
>> +       /* per-partition descriptions; numparts */
>> +       partlistlen += numparts * (strlen("name=,") + PART_NAME_LEN);
>>          /* see part.h for definition of struct disk_partition */
>> -       partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
>> -       partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
>> -       partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
>> -       /* for the terminating null */
>> -       partlistlen++;
>> -       debug("Length of partitions_list is %d for %d partitions\n", partlistlen,
>> -             numparts);
>> +       partlistlen += numparts * (strlen("start=0x,") + lbaint_size);
>> +       partlistlen += numparts * (strlen("size=0x,") + lbaint_size);
>> +       if (IS_ENABLED(CONFIG_PARTITION_UUIDS))
>> +               partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN);
>> +       debug("Length of partitions_list is %d for %d partitions\n",
>> +             partlistlen, numparts);
>>          return partlistlen;
>>   }
>>
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon
