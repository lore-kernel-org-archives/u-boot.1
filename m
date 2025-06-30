Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA39C8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1FD81D6A;
	Mon, 30 Jun 2025 12:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MZSIOxem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D5E81FEE; Mon, 30 Jun 2025 12:06:41 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0080F800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso4523239f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751277997; x=1751882797; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tGureotnP9qYUSK7XiThREoyUUY53TxhRY5sB/FMHyI=;
 b=MZSIOxemiK3VejKCJHtgBbnzYs8xKMnRTm74zIQOIjq4s72JO+Z4l+aF39vmhz1eYk
 zyYM7WSdrCBUo0f4jPv78M/sah9UDto9/jR4s07jk57/HTfVBkab5htxo2Txfm4aZJR2
 i60VpBfUVxZ0o/wZccwrUJtYqWuUVJk/FqwZ9RK4tXziqpr1y7E5kMrUHzwvdymjer75
 j0K9rJh3BbWoEAlxCuYJl+9OQFBljT8CY5hP09M0x8r0bHlfLy5QNkklnKiIiCPLsV7o
 9E01Ohryg7kIqTt7C7bARblzkHxSXZVYzWlyXZEIiJiXTr8F1qDT7KUfHrGRMtbzmZod
 gLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751277997; x=1751882797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGureotnP9qYUSK7XiThREoyUUY53TxhRY5sB/FMHyI=;
 b=ua2sus5ezARHzLij+JsM+/ZghNVFwmGfnBwclfubO/1I3aPTACCp4r1jpjBX5pKjZp
 yIWOW/lypLreGfQCxF2hQST6FWgBjpdkjuVQzfsYxrZ9emtMSXDJ8UeaXkN1vAdHHaPi
 CXYdMORgJQJOjNfOjQ6L4dPjly94GJOxakvmexf3vquRkJrQB22bEDUtAgB+CXS+agfz
 KfMoif3lxFxM/KnBz5BLWcFMCOp8ZGTnMYRzXu/cKUKSP2IXN/YDTJLzBubPNLQy4PNH
 uuJXfSI8Oi8l/g601RunDPper9BahOHrgH+84ROxTUlhYroNzZyl0Ug7GwMuZY/SG2Fi
 vYrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4jvnUHiYRUgvOqwYTRNQtlsanKVwLWZ3Mq3mOad/HBPMaX92nMnZ313+T7TtLX0ggWmXcgjs=@lists.denx.de
X-Gm-Message-State: AOJu0YzvIq7FLLR18W5xEuR2limhXwTyjOwA4YMLpM8AdFL9XAasjErn
 bs9iIbGTLWYMr+yccV4tC2IVAhezbVxp4loF57iuuy6Voetb2P2H3f8Pa81kBGsOBVE=
X-Gm-Gg: ASbGncul5oqA9kn2h6HMCY0/6NJJtJ/eVF4ABCM1KLesDOVojIPO6HGnVEvG115OYaK
 19cE1JKZ+jLFMHbvu6oYP53bXVTV1PmXI4+2mGYq8YafKOahYgS2bKMCMg/JcFEZzIbJM1cpJ82
 G8McVzR8QdddmVssAGzjz/mCF+r22r7FnyIlMc5TbTIvdTzeWuZxcLmLeZHUXpvQxVhL2zRl1ZA
 b8ZsNhK5aTAb4Lw5ZeQthyiWQ+Fe1q1ztjwEVoe2C9ecdi0iWVxqgFFv9LW40IPpjOZ8AG/qm2t
 agKb4rnR9gtOr3yxjYEeaSaAM7hK/Rq64xaJE8kT4OHetc3tQDBKdQELUXQxYu6XcyBfw99CVCn
 rO47QoLyapTndwLsxpMdMWrEswVSio8MprS1JFHfgVlm2QWXvvaEK
X-Google-Smtp-Source: AGHT+IFWV+x5pOT/ypBfxFbZGPxBUgP7OSa5J18T8MrlGnzZ1VcTbHc9AzCOMV4TXI1rM5FvEZszKA==
X-Received: by 2002:a05:6000:41d3:b0:3a5:52d4:5b39 with SMTP id
 ffacd0b85a97d-3a90d0d6a0fmr10091541f8f.8.1751277997307; 
 Mon, 30 Jun 2025 03:06:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75?
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a306a01sm136538325e9.0.2025.06.30.03.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 03:06:36 -0700 (PDT)
Message-ID: <f13d6cab-b748-4503-9f57-724a16ebf8f0@linaro.org>
Date: Mon, 30 Jun 2025 11:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cmd: tpm: Fix attempt to return value not in enum
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
References: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
 <20250625-tpm_enum-v2-1-ea3f84f6b639@linaro.org>
 <CAC_iWjJ69F_1n7V3jFLDggcot2OW+VaSAMuKs07SXjGk0P1J3g@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CAC_iWjJ69F_1n7V3jFLDggcot2OW+VaSAMuKs07SXjGk0P1J3g@mail.gmail.com>
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

On 30/06/2025 08:23, Ilias Apalodimas wrote:
> Hi Andrew
> 
> 
> 
> On Fri, 27 Jun 2025 at 12:37, Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> The function tpm2_name_to_algorithm is defined as returning an
>> enum for the algorithm specified but it also attempts to return
>> an error on failure, but that error is not included in the enum.
>> Add the error to the enum so that it can be returned.
>>
>> This issue was reported by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   cmd/tpm-v1.c                 | 1 +
>>   cmd/tpm_test.c               | 1 +
>>   drivers/tpm/sandbox_common.c | 1 +
>>   include/tpm-v2.h             | 1 +
>>   4 files changed, 4 insertions(+)
>>
>> diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
>> index 6e019d1c729..25402f7543b 100644
>> --- a/cmd/tpm-v1.c
>> +++ b/cmd/tpm-v1.c
>> @@ -8,6 +8,7 @@
>>   #include <malloc.h>
>>   #include <vsprintf.h>
>>   #include <asm/unaligned.h>
>> +#include <linux/errno.h>
> 
> Why is this needed? Shouldn't it only be on the header file?

OK, I will rework it.

Andrew

> Thanks
> /Ilias
>>   #include <tpm-common.h>
>>   #include <tpm-v1.h>
>>   #include "tpm-user-utils.h"
>> diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
>> index af83d78c3fe..1d9644d5aae 100644
>> --- a/cmd/tpm_test.c
>> +++ b/cmd/tpm_test.c
>> @@ -7,6 +7,7 @@
>>   #include <cpu_func.h>
>>   #include <log.h>
>>   #include <time.h>
>> +#include <linux/errno.h>
>>   #include <tpm-v1.h>
>>   #include <linux/printk.h>
>>   #include "tpm-user-utils.h"
>> diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
>> index 596e0156389..4bc003a2c09 100644
>> --- a/drivers/tpm/sandbox_common.c
>> +++ b/drivers/tpm/sandbox_common.c
>> @@ -7,6 +7,7 @@
>>
>>   #define LOG_CATEGORY   UCLASS_TPM
>>
>> +#include <linux/errno.h>
>>   #include <tpm-v1.h>
>>   #include <tpm-v2.h>
>>   #include <asm/unaligned.h>
>> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
>> index ece422df0c7..6c516dd3c9b 100644
>> --- a/include/tpm-v2.h
>> +++ b/include/tpm-v2.h
>> @@ -266,6 +266,7 @@ enum tpm2_return_codes {
>>    * TPM2 algorithms.
>>    */
>>   enum tpm2_algorithms {
>> +       TPM2_ALG_INVAL          = -EINVAL,
>>          TPM2_ALG_SHA1           = 0x04,
>>          TPM2_ALG_XOR            = 0x0A,
>>          TPM2_ALG_SHA256         = 0x0B,
>>
>> --
>> 2.39.5
>>

