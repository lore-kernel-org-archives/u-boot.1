Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A800C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 15:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECD9867F0;
	Tue, 15 Aug 2023 17:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C2fNOWM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159C18685D; Tue, 15 Aug 2023 17:17:49 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206E1867E2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 17:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C8E33F03D
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692112666;
 bh=pNKgPx860hyFsUMThitrqgcCZHZMPk13+0MSV4GiCNM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=C2fNOWM5N5xl0pm68MNKADcEe4mDNnL3cuK2HJg1JdLCTBsZ88Mg1ZC/XCFlozYS9
 9wCndthU0YBS708aFQr8mEKhMMuEG1H5fpUHvx2+EEPIGnxz2d6lDc0zWk6ymSD3JZ
 TuzgOwOIPsKJEqLXprzVmHXQNHEvGm9JSnWJyEGQ2XHCiAJI8TczFkz2VZS5GztJIB
 2WzWiRlR4dkycTFJnYYI870uC8PzYLuirAoy9qHUzUaA0MzNjbmICYCgl92so8qlux
 lhyQ6VBUfBA4oK5ib3i6gXVuefKmn2YWPY8lh9AbUOoehxbBpdMkyS5vJoZX2YFMrm
 WeE4HnXIBRmBg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe2a5ced6dso33838575e9.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 08:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692112666; x=1692717466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNKgPx860hyFsUMThitrqgcCZHZMPk13+0MSV4GiCNM=;
 b=QRqei/6LC62kkRknaNcHv4ppRFuJrWokqg/rUn5S4VHypeFWxiOXIdtGeFC1KKipFL
 DfMj00JJ3g5xzNySgEw735Zex7PL+eVEyyyxjt8S0y1y/N82wgMaAXTMxqhGlWi1nGUD
 +WTlpJLx29U4yBD6tfZiWdHYA4KaAayEhILg6EZgzlMD265SAWzKTlBeWMp77Oc6oGne
 vaMbK8nYYVbLWZ7cNTYNsWj1WBrSoNvRn2PM37xbFigtkQJhTfYvjFaCXbFcptg9zEVa
 2zCBFtas9kMqeVHbNkpFkXvoDrklg3bjtHArqT9HQwjFulp/Ipd92qg/BG7rgQVX11eh
 /6DQ==
X-Gm-Message-State: AOJu0YxK1r2VhKRYgWFAxnSWP5ReYaPdim3+ofF3RDN7/T3jueWaVo8N
 ly1dR+plk0UuqeD8MDj3VUn3e7OzxIbc6auJByAoxDwrT1z7Vv8gdOhyC3dmRyHDr6oApwwpDbn
 LN7hgcAmtvbkrcLTna0DqlyznIXAwhsg=
X-Received: by 2002:a05:600c:218b:b0:3fb:b3aa:1c8f with SMTP id
 e11-20020a05600c218b00b003fbb3aa1c8fmr10326750wme.28.1692112666273; 
 Tue, 15 Aug 2023 08:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEeispmuiTuO2LSg5SC2mzrqjHc35nBEsfkkbIe9hRv92ELaOeGoWTyY08hgYbrOuZYxJUWg==
X-Received: by 2002:a05:600c:218b:b0:3fb:b3aa:1c8f with SMTP id
 e11-20020a05600c218b00b003fbb3aa1c8fmr10326737wme.28.1692112665884; 
 Tue, 15 Aug 2023 08:17:45 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c294500b003fe1fe56202sm18353979wmd.33.2023.08.15.08.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 08:17:45 -0700 (PDT)
Message-ID: <d359a225-fbda-3bfd-ee5a-6cab8e011568@canonical.com>
Date: Tue, 15 Aug 2023 17:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] doc: add partition API to HTML documentation
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
References: <20230815103259.17476-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0BB90F4Zpq6AtyTPuME3XiJJYmYUOBhFCG9FujOq4wHw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ0BB90F4Zpq6AtyTPuME3XiJJYmYUOBhFCG9FujOq4wHw@mail.gmail.com>
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



On 8/15/23 16:44, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 15 Aug 2023 at 04:32, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> * Convert comments in part.h to Sphinx style.
>> * Create documentation page for the partition API.
>> * Add the partition API page to the API index page.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   doc/api/index.rst |   1 +
>>   doc/api/part.rst  |   6 ++
>>   include/part.h    | 210 ++++++++++++++++++++++++----------------------
>>   3 files changed, 119 insertions(+), 98 deletions(-)
>>   create mode 100644 doc/api/part.rst
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Q below
> 
>>
>> diff --git a/doc/api/index.rst b/doc/api/index.rst
>> index a9338cfef9..3a80ae0635 100644
>> --- a/doc/api/index.rst
>> +++ b/doc/api/index.rst
>> @@ -15,6 +15,7 @@ U-Boot API documentation
>>      lmb
>>      logging
>>      nvmem
>> +   part
>>      pinctrl
>>      rng
>>      sandbox
>> diff --git a/doc/api/part.rst b/doc/api/part.rst
>> new file mode 100644
>> index 0000000000..d1df1d8494
>> --- /dev/null
>> +++ b/doc/api/part.rst
>> @@ -0,0 +1,6 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Partition API
>> +=============
>> +[..]
> 
>> +/**
>> + * struct part_driver - partition driver
>> + */
>>   struct part_driver {
>> +       /** @name:      partition name */
>>          const char *name;
>> +       /** @part_type: (MBR) partition type */
>>          int part_type;
>> -       const int max_entries;  /* maximum number of entries to search */
>> -
>> +       /** @max_entries:       maximum number of partition table entries */
>> +       const int max_entries;
>>          /**
>> -        * get_info() - Get information about a partition
>> +        * @get_info:           Get information about a partition
> 
> Are we not allowed the () at end? I much prefer brackets as they show
> it is a function.

Thanks for reviewing.

'make htmldocs' does not like parentheses here:

Incorrect use of kernel-doc format:
* @get_info(): Get ...
Incorrect use of kernel-doc format:
* @get_info() - Get ...

We are using code from the kernel.org. We would have to change that 
upstream first:

scripts/kernel-doc:2325:
print STDERR "Incorrect use of kernel-doc format: $_";

Best regards

Heinrich

> 
>>           *
>> -        * @dev_desc:   Block device descriptor
>> -        * @part:       Partition number (1 = first)
>> -        * @info:       Returns partition information
>> +        * @get_info.dev_desc:  Block device descriptor
>> +        * @get_info.part:      Partition number (1 = first)
>> +        * @get_info.info:      Returns partition information
>>           */
>>          int (*get_info)(struct blk_desc *dev_desc, int part,
>>                          struct disk_partition *info);
> [..]
> 
> Regards,
> Simon
