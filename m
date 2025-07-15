Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D659C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 15:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB318300B;
	Tue, 15 Jul 2025 17:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zGOsNsgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE74183010; Tue, 15 Jul 2025 17:00:57 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCF882FCA
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 17:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so4269218f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752591655; x=1753196455; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0RJL4y/3Eej4yfcMBmxL3JltnX5xfbliQzM3rcxgvU=;
 b=zGOsNsgWxDOzLUOQ3VI7N/1DkCWbgPo7uECT9gtlsrBMs9js8A950j/IqSmBAy4TP+
 h5aMxVa695KyxLmAB7osXZDTXpgF/ubwkTSkN0nFudDHFgVT6XkC6zawFBb0eY+EFIzc
 /VMAK755B5TxzAa5DcoKtTUg19XU62iLgaMKrKrKAYsC1oRjK0fn3tAW5d8ME/A0xHn3
 QHpcHFEOhI43m0H9jK0/IhKUmZpEkJDtOWk6W+Wewat7byFr7eo8nfi9MckETzvf8JYi
 K3/8RciWg71fW1KigB6IXkPcZg3gp94ofcK9Jd/3P2Kl8vmf5z1qmB8Kd/1fCUv3rOnn
 bsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752591655; x=1753196455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0RJL4y/3Eej4yfcMBmxL3JltnX5xfbliQzM3rcxgvU=;
 b=Zl9fWKeTpW3yn+cjVT4cwdhTS0kT9HpuzesI4TBplVXmULHdCEHw6SpSA305nHUdWq
 fo5+9Uq5cq7D3jkflTN77bvcGuy4kvuHKzS2I1/bDu2juPL93yc6jEJls/T9uAH3o8VN
 DsZOj3FK3oFkajIZoV7wf2cOuMqci5ugfplPEDhpRyxAHjNPgNf0/pECdPuVd2SadbkL
 qXH8dUfllh2cSeqlTVGRPCwxoe6QxF3J8J8zTixaYe7pyFsrJirN9G9XNVFggDFap0M+
 xfaPP6JaX/VUxx/FyeAJd0GCkSl8QSPshE+wJ5o/5Dzcn4cu8fBAr1zbb6Lz0YL6DT97
 VS7g==
X-Gm-Message-State: AOJu0Yxz3Fj3/kkdfnNTtAMegU2zBTuE+FgldAepl3ZjzmjYhtu1OWOw
 OFx4r63TUQr7/cLxfqSMpJGKMJwR/m9P0oDkkfW6rDTwIHsSBeJC+BXgvOC4t2Ob9uE=
X-Gm-Gg: ASbGncuIb2qUYlXeq16Q82pu0fisF1kkxoMOKXJ4J6xNg0uejHUKzYEKPYquXUx3Rdl
 eoF+tUBmpGPJdXxbemR1aXVypQ5vSVD5J5Tva7FMlTmQmzcMnFNshrVjsb9vwfG7BdVFyV53DNl
 Zo2/OU7652EhGPG2v//t6tzH1XYU//5jtj9+lL8sbxLWADZq5saWMSwjwwumZm/wbI9sI6BqLAP
 RWASgeQElPjZFNWH29S64QoJnfrPraSzGAqF1Pa+puMVsHnqGVg11g01/kKcI/d5TdbbTumLnBL
 Vl9t7Yfkyh14SI7AxwwOHXCaLznB0g5bKx2SQvKtemz/GNghVlv/T5q070ay2nqrMxtBb5TKa60
 Lk6V0UWNzEqMh8mK3vaLGZPhGK6Q68ReiiohcM8cXMvRN4D/sSEQTEVU0zh55VRYvbkAOXKl+4R
 NdxDXoN+pyXg==
X-Google-Smtp-Source: AGHT+IFRY2E8uooT6lQRyyLBnCjhFCe6f/5EexswM+K+JT8Qut69USMdQUFeP11zqGEbb1xNA5+t3A==
X-Received: by 2002:a5d:5f06:0:b0:3a4:f787:9b58 with SMTP id
 ffacd0b85a97d-3b60a1bb64dmr2168616f8f.58.1752591654722; 
 Tue, 15 Jul 2025 08:00:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1?
 ([2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5easm15193482f8f.48.2025.07.15.08.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:00:54 -0700 (PDT)
Message-ID: <60a53026-4758-4da1-9ec9-37a75b098ccd@linaro.org>
Date: Tue, 15 Jul 2025 16:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] uclass: Cleanup uclass_find_next_device
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
 <20250714-blk-uclass-v2-2-1bb1d2eee896@linaro.org>
 <a836de8e-5de1-4cdd-8dcc-643ffa0463b1@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <a836de8e-5de1-4cdd-8dcc-643ffa0463b1@cherry.de>
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



On 15/07/2025 13:06, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 7/15/25 11:23 AM, Andrew Goodbody wrote:
>> uclass_find_next_device always returns 0, so instead make it a void and
>> update calling sites.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   board/emulation/qemu-ppce500/qemu-ppce500.c |  4 ++--
>>   boot/bootdev-uclass.c                       |  2 +-
>>   cmd/regulator.c                             |  4 ++--
>>   drivers/core/uclass.c                       | 16 +++++-----------
>>   drivers/power/regulator/regulator-uclass.c  | 10 ++++++----
>>   drivers/remoteproc/rproc-uclass.c           |  6 ++++--
>>   include/dm/uclass-internal.h                |  4 +---
>>   test/dm/core.c                              | 28 +++++++++++++ 
>> +--------------
>>   8 files changed, 35 insertions(+), 39 deletions(-)
>>
>> diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/ 
>> emulation/qemu-ppce500/qemu-ppce500.c
>> index 40d295dbf06..58de4a05296 100644
>> --- a/board/emulation/qemu-ppce500/qemu-ppce500.c
>> +++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
>> @@ -170,9 +170,9 @@ int misc_init_r(void)
>>        * Detect the presence of the platform bus node, and
>>        * create a virtual memory mapping for it.
>>        */
>> -    for (ret = uclass_find_first_device(UCLASS_SIMPLE_BUS, &dev);
>> +    for (uclass_find_first_device(UCLASS_SIMPLE_BUS, &dev);
>>            dev;
>> -         ret = uclass_find_next_device(&dev)) {
>> +         uclass_find_next_device(&dev)) {
>>           if (device_is_compatible(dev, "qemu,platform")) {
>>               struct simple_bus_plat *plat = dev_get_uclass_plat(dev);
>> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
>> index 3791ebfcb42..6718c482e52 100644
>> --- a/boot/bootdev-uclass.c
>> +++ b/boot/bootdev-uclass.c
>> @@ -216,7 +216,7 @@ void bootdev_list(bool probe)
>>           if (probe)
>>               ret = uclass_next_device_check(&dev);
>>           else
>> -            ret = uclass_find_next_device(&dev);
>> +            uclass_find_next_device(&dev);
> 
> I think we need to ret = 0 here as well? Otherwise the printf at the top 
> of the for-loop will return whatever was the last return value?

Yes, will fix.

>>       }
>>       printf("---  ------  ------  --------  ------------------\n");
>>       printf("(%d bootdev%s)\n", i, i != 1 ? "s" : "");
>> diff --git a/cmd/regulator.c b/cmd/regulator.c
>> index da298090bb7..db843283662 100644
>> --- a/cmd/regulator.c
>> +++ b/cmd/regulator.c
>> @@ -97,9 +97,9 @@ static int do_list(struct cmd_tbl *cmdtp, int flag, 
>> int argc,
>>              "Parent");
>>       for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
>> -         ret = uclass_find_next_device(&dev)) {
>> +         uclass_find_next_device(&dev)) {
>>           if (ret)
>> -            continue;
>> +            break;
> 
> I think it would make this more readable by having
> 
> ret = uclass_find_first_device(UCLASS_REGULATOR, &dev);
> if (ret)
>      return ret;
> 
> for (; dev; uclass_find_next_device(&dev)) {
>      uc_pdata...
> }
> 
> return ret;
> 
> What do you think? This also avoids checking for ret in every loop 
> considering it won't ever change.

OK, will change as suggested.

> [...]
> 
>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/ 
>> power/regulator/regulator-uclass.c
>> index 09567eb9dbb..eac025c9c02 100644
>> --- a/drivers/power/regulator/regulator-uclass.c
>> +++ b/drivers/power/regulator/regulator-uclass.c
>> @@ -261,10 +261,10 @@ int regulator_get_by_platname(const char 
>> *plat_name, struct udevice **devp)
>>       *devp = NULL;
>>       for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
>> -         ret = uclass_find_next_device(&dev)) {
>> +         uclass_find_next_device(&dev)) {
>>           if (ret) {
>>               dev_dbg(dev, "ret=%d\n", ret);
>> -            continue;
>> +            break;
>>           }
> 
> Same here.
> 
>>           uc_pdata = dev_get_uclass_plat(dev);
>> @@ -411,8 +411,10 @@ static bool regulator_name_is_unique(struct 
>> udevice *check_dev,
>>       int len;
>>       for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
>> -         ret = uclass_find_next_device(&dev)) {
>> -        if (ret || dev == check_dev)
>> +         uclass_find_next_device(&dev)) {
>> +        if (ret)
>> +            break;
> 
> Ditto.
> 
>> +        if (dev == check_dev)
>>               continue;
>>           uc_pdata = dev_get_uclass_plat(dev);
>> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/ 
>> rproc-uclass.c
>> index 3233ff80419..7916cb27e3d 100644
>> --- a/drivers/remoteproc/rproc-uclass.c
>> +++ b/drivers/remoteproc/rproc-uclass.c
>> @@ -56,8 +56,10 @@ static int for_each_remoteproc_device(int (*fn) 
>> (struct udevice *dev,
>>       int ret;
>>       for (ret = uclass_find_first_device(UCLASS_REMOTEPROC, &dev); dev;
>> -         ret = uclass_find_next_device(&dev)) {
>> -        if (ret || dev == skip_dev)
>> +         uclass_find_next_device(&dev)) {
>> +        if (ret)
>> +            return ret;
> 
> Ditto.
> 
>> +        if (dev == skip_dev)
>>               continue;
>>           uc_pdata = dev_get_uclass_plat(dev);
>>           ret = fn(dev, uc_pdata, data);
>> diff --git a/include/dm/uclass-internal.h b/include/dm/uclass-internal.h
>> index 3ddcdd21439..9cb3f090271 100644
>> --- a/include/dm/uclass-internal.h
>> +++ b/include/dm/uclass-internal.h
>> @@ -149,10 +149,8 @@ int uclass_find_first_device(enum uclass_id id, 
>> struct udevice **devp);
>>    *
>>    * The device is not prepared for use - this is an internal function.
>>    * The function uclass_get_device_tail() can be used to probe the 
>> device.
>> - *
>> - * Return: 0 if OK (found or not found), -ve on error
>>    */
>> -int uclass_find_next_device(struct udevice **devp);
>> +void uclass_find_next_device(struct udevice **devp);
>>   /**
>>    * uclass_find_device_by_namelen() - Find uclass device based on ID 
>> and name
>> diff --git a/test/dm/core.c b/test/dm/core.c
>> index 959b834576f..201daee6836 100644
>> --- a/test/dm/core.c
>> +++ b/test/dm/core.c
>> @@ -737,7 +737,7 @@ static int dm_test_device_reparent(struct 
>> unit_test_state *uts)
>>       /* try to get devices */
>>       for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
>>            dev;
>> -         ret = uclass_find_next_device(&dev)) {
>> +         uclass_find_next_device(&dev)) {
>>           ut_assert(!ret);
> 
> Ditto for all the tests in test/dm/core.c.

The for loops in test/dm/core.c mostly reduce to being empty as the only 
test left inside is that dev is not NULL, but in that case the for loop 
terminates so the test can never fail. So the for loops can mostly be 
removed as they do nothing.

Thanks,
Andrew

> Cheers,
> Quentin

