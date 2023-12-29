Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EBFC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 11:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C8A87B25;
	Fri, 29 Dec 2023 12:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N4IlqzJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB1B87B03; Fri, 29 Dec 2023 12:18:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA75687A78
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 12:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E0073F0CB
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703848719;
 bh=JTOVeGMGNF/a61+417vkdtfL+5T5laAELg2K8NBoX58=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=N4IlqzJBrcVKQGjp3QKZ156kgEk2EoT295ZJdXGvPJl1UiAmDPnFTXcpEdvfNXWjR
 FI7FMU3dxr4i+87LDd5Qx6x4NVVaqLFKRFUoJZ+QLHaLHCWx++DCiNhjHuTqydeav/
 f8gXLTnYPh4YvW+UcR4CC84ZcV1BkyD3Ol8Z4MiemUo1zEpFbKZvbgsNW7K+P5cfCh
 C2mK82F8DpQEJy8SVYbERJE6dN0B0WgL5/BngIS2BX2YK7UA7DhCXLhAokZIIqIkqe
 pkEh9QOO5GD0rYiAXBIs6olwIMkYXpd9WPYvzmYKT77UL4Bw7cAawG6ILpcubu8ooZ
 o5R67C7akOslw==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ccb53bc5ceso28663351fa.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 03:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703848718; x=1704453518;
 h=content-transfer-encoding:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTOVeGMGNF/a61+417vkdtfL+5T5laAELg2K8NBoX58=;
 b=hJ/zige9KYspJ75HI9j/tQJRXo64YeRLrthJQJm+9pFTraUx89WWRtScola8/FsCJ+
 8DyHAcZUB8MBhCIAKgyB4QxTl+j7GzOoITR91b5XJREWSrzP0Cex20CBhMPgU9ealHZK
 Qgi7hY7RC4kqhIXip12bU7LcehM6o1uYIYK11zwwaDkC0B6yI0aAcIjlHnED9GzDTGGq
 bnKiq7Y8KO0ysSRFqccD2XqhxC9uYFQco23cKz87ZUzl1xHUvseHiTShOa/BTqqRun95
 1SrSvY1iFwSCPE32JN7krjOAfP1O+RI+IcTSfH9G7YG2UBM/Qm4gKS4OvJOSvE8pBThZ
 zDnw==
X-Gm-Message-State: AOJu0Yy02Bvj5pYL9mRxVZNS5K2XUFZpVBwDagqC9E+RnGbj2bkrW54a
 di8OHtFVeKw1VfV/XMmjpqALAzMy0qipmGnrnpFWFJwT/CEmknxFbRZeiDsdxcphRQEHcbf4BQd
 ahkx6cU48h++5JL90wOnUS2lf+hTA+Z+bzEObgg==
X-Received: by 2002:a2e:9f0a:0:b0:2cc:89f4:1590 with SMTP id
 u10-20020a2e9f0a000000b002cc89f41590mr4247181ljk.101.1703848718561; 
 Fri, 29 Dec 2023 03:18:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWm9DjpIkQN05j8dLFWKzFcgwjjAYMUPBEgXCt/FwvAcgNNn0AwbLe+PFvMB5qcQar93IBQA==
X-Received: by 2002:a2e:9f0a:0:b0:2cc:89f4:1590 with SMTP id
 u10-20020a2e9f0a000000b002cc89f41590mr4247171ljk.101.1703848718098; 
 Fri, 29 Dec 2023 03:18:38 -0800 (PST)
Received: from [192.168.123.176]
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 i11-20020aa7c9cb000000b005551853c91esm4508166edt.12.2023.12.29.03.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 03:18:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <heinrich.schuchardt@canoncial.com>
Message-ID: <7a8a842e-234c-4a79-b0d9-7a9ae544c13b@canoncial.com>
Date: Fri, 29 Dec 2023 12:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] smbios: enable setting processor family > 0xff
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
 <20231228073024.6508-2-heinrich.schuchardt@canonical.com>
 <CAFLszTikYxynGe3o3Sg2qTUgy-oXot=9BJ9F8vxCYF3-puDC4g@mail.gmail.com>
In-Reply-To: <CAFLszTikYxynGe3o3Sg2qTUgy-oXot=9BJ9F8vxCYF3-puDC4g@mail.gmail.com>
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

On 12/28/23 14:37, Simon Glass wrote:
> Hi Heinrich,
> 
> On Thu, Dec 28, 2023 at 7:30 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Many value of processor type exceed 0xff and have to be stored as u16
>> value. In the type 4 table set processor_family = 0xfe signaling that
>> field processor_family2 is used and write the actual value into the
>> processor_family2 field.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/smbios.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index 45480b01af..550b2471f9 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -467,7 +467,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
>>          }
>>   #endif
>>
>> -       t->processor_family = processor_family;
>> +       t->processor_family = 0xfe;
>> +       t->processor_family2 = processor_family;
> 
> Why not use 'family' if it fits?

Using family for values less then 0x100 is allowable.
But there would be no benefit in making our code more complicated.

Best regards

Heinrich

> 
>>          t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
>>          t->processor_version = smbios_add_prop(ctx, NULL, name);
>>   }
>> @@ -489,7 +490,6 @@ static int smbios_write_type4(ulong *current, int handle,
>>          t->l1_cache_handle = 0xffff;
>>          t->l2_cache_handle = 0xffff;
>>          t->l3_cache_handle = 0xffff;
>> -       t->processor_family2 = t->processor_family;
>>
>>          len = t->length + smbios_string_table_len(ctx);
>>          *current += len;
>> --
>> 2.43.0
>>
> 
> Regards,
> Simon

