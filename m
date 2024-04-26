Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E883FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E81088233;
	Fri, 26 Apr 2024 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ts2Sj9Of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311FF88233; Fri, 26 Apr 2024 16:53:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BAF088231
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 274C13FAEB
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714143178;
 bh=oHQv4CXatV6HVLMhpMiXl66kZU5mqZxWOVus6DxymK0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ts2Sj9OfN+3TtnLXE81U0ZlY2cJ67+ZecPeb2NFsUvDaETacrXVZ82IXhyEGRco+g
 nwnY2a9kpu83mKl/KsvkJ98y8rPz0lpEf40E6QHpAs2I2dQrGiKqFJi8wM57yQ3YUu
 YAN/HjeCSSz6khRdtP+suOORuOv8iM4jpe6Hc10RgN4L9eLkYOqIWF0kGLMiBcR9ui
 GCKzP3q2divv2yysVVr9K/i1Bt96kWvO5zUaOOp0cYiZrRwbZRBzb4bjwDaxn/9hRN
 FlxTkGjGyrdCxALz/5+FaEYCxbkssxlGCDnMMh23xeObSNYAtb2IIBykcl36xbr1Nd
 AIHsq7nWbgfIA==
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2db099e687fso18631711fa.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714143177; x=1714747977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHQv4CXatV6HVLMhpMiXl66kZU5mqZxWOVus6DxymK0=;
 b=O4FBPpVVxzrAIEUWnnPfU+5aWUuD0pezUCH24068p/pBiGwaf6hVldbLGAszfSU4AS
 A3v5/Z+i6ZpxQjkRCaD6nSCT+XmLuDjDm70I6L6CusxBsZeYVxo2YB9h08rnaUIK5l6C
 /V0dVfiTBX7E5hUanqL36XUeUyXihN0QsdhHPbPvHbEdUspb6muattDwyVr2oOun6ytj
 SCCYHfqrLt7h+roFJbxh01qomPAm4ryxmZc4nVXBOnopNRWPQ3eknoGQI+T9cEx4dien
 UVr5dsAHa0//uv8QqSGCxd6mbflqt22574bkaYXAwYb8uK8DFJC6d/2asUgn1YD3N0bW
 8yiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIhVwR+6mclvGxpWJsJtHB72RYJ2FRCQTRSLAVqpfjU7kyPeUKu7zxhXer3a50XL7x9F7lvpKkFVdStc/iAhiW2l4ybA==
X-Gm-Message-State: AOJu0Yy3d85tRMn2qAyWI8mY2Tr5O2010yXagRpXlIXayCPQptJI2WEB
 008nbnP24ghAT1yXgdhneDBHIKUca9gL0mbbWaePcYhOdarAlja+L7F9C1VLF41Mm3NIbH5AZsT
 UI6bl2BF6AIhLX1f/ClIEC1RCnJb3lFRyHFNy9OtA9hn+H7NbduLEJisneTnrQU+ao18=
X-Received: by 2002:a2e:b5cd:0:b0:2d8:394c:6e7e with SMTP id
 g13-20020a2eb5cd000000b002d8394c6e7emr1532835ljn.15.1714143177426; 
 Fri, 26 Apr 2024 07:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRmzRa8kc1DQFgRocpZudBFAhorwVj3rk1MLLZdc79nsUulU1cQDUwmTHP/lvOcwJSVNmlbg==
X-Received: by 2002:a2e:b5cd:0:b0:2d8:394c:6e7e with SMTP id
 g13-20020a2eb5cd000000b002d8394c6e7emr1532824ljn.15.1714143176840; 
 Fri, 26 Apr 2024 07:52:56 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a5d49ca000000b0034bfc32a4f6sm4875616wrs.48.2024.04.26.07.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 07:52:56 -0700 (PDT)
Message-ID: <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
Date: Fri, 26 Apr 2024 16:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/14] efi_loader: library function efi_dp_merge
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
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

On 26.04.24 16:30, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Provide a function to append a device_path to a list of device paths
>> that is separated by final end nodes.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/efi_loader.h             |  3 +++
>>   lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 9600941aa32..a7d7b8324f1 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -944,6 +944,9 @@ struct efi_load_option {
>>
>>   struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>>                                         const efi_guid_t *guid);
>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>> +                                    efi_uintn_t *size,
>> +                                    const struct efi_device_path *dp2);
>>   struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>>                                        const struct efi_device_path *dp2,
>>                                        bool split_end_node);
>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
>> index 46aa59b9e40..16cbe41d32f 100644
>> --- a/lib/efi_loader/efi_device_path.c
>> +++ b/lib/efi_loader/efi_device_path.c
>> @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>>          return ndp;
>>   }
>>
>> +/**
>> + * efi_dp_merge() - Concatenate two device paths separated by final end node
>> + *
>> + * @dp1:       first device path
>> + * @size:      pointer to length of @dp1, total size on return
>> + * @dp2:       second device path
>> + *
>> + * Return:     concatenated device path or NULL
>> + */
>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>> +                                    efi_uintn_t *size,
>> +                                    const struct efi_device_path *dp2)
>> +{
>> +       efi_uintn_t len, len1, len2;
>> +       struct efi_device_path *dp;
>> +       u8 *p;
>> +
>> +       len1 = *size;
>> +       len2 = efi_dp_size(dp2) + sizeof(END);
>> +       len = len1 + len2;
>> +       dp = efi_alloc(len);
>> +       if (!dp)
>> +               return NULL;
>> +       memcpy(dp, dp1, len1);
>> +       p = (u8 *)dp + len1;
>> +       memcpy(p, dp2, len2);
>> +       *size = len;
> 
> Can't we just use efi_dp_concat()?

efi_dp_concat cannot be used to put a device-path end-node in between 
two device-paths that are concatenated. We need that separator in the 
load options.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>> +
>> +       return dp;
>> +}
>> +
>>   /**
>>    * efi_dp_concat() - Concatenate two device paths and add and terminate them
>>    *                   with an end node.
>> --
>> 2.43.0
>>

