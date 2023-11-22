Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D1C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D43E87675;
	Thu, 23 Nov 2023 00:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SlTPcA1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D003687675; Thu, 23 Nov 2023 00:55:25 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 0BA198768A
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 00:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [192.168.1.75] (d173-180-12-152.bchsia.telus.net
 [173.180.12.152])
 by linux.microsoft.com (Postfix) with ESMTPSA id 257D720B74C1;
 Wed, 22 Nov 2023 15:55:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 257D720B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700697321;
 bh=cNsRQks1tG0dK9cNVNcPZK0fGKDqwoABXgGiCTOHR8c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SlTPcA1WTbYOpV89UZde18xH+duGi30Y4fFsM5VcYnl5A8ybKQC/0oUBGflXiUK4c
 bVRtfxl3r85UKwad5GRR7ID54ZqgywYnRNb2bN6I9sgkXqnLQdBAe1dhxCq8SQynAl
 Jf9FAtMvJRn06o3S5SZ+ohqmzzQmgY9688JllSZk=
Message-ID: <89277e39-5b72-4d39-8bac-d5a9f174cd72@linux.microsoft.com>
Date: Wed, 22 Nov 2023 15:55:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] fdt: kaslr seed from RNG device
Content-Language: en-GB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, trini@konsulko.com,
 sjg@chromium.org
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-3-seanedmond@linux.microsoft.com>
 <CAC_iWjJf87DM=J0aKUHbOMj8ZhMi=8UtDEEyHRSL3Vv0s+iarQ@mail.gmail.com>
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <CAC_iWjJf87DM=J0aKUHbOMj8ZhMi=8UtDEEyHRSL3Vv0s+iarQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias, Applogies, I'm fairly new to upstream contributions and I've 
missed a few things on multi-version patch series such as this one. 
Simon has elightened about patman though (I feel a bit sheepish that I 
haven't been using this tool all along). Should I resubmit this as a new 
series to ensure prior reviews and change logs are captured?

Sean

On 2023-11-17 11:33 p.m., Ilias Apalodimas wrote:
> Hi Sean
> There are a few reviewed-by tags missing since v3/v4.  Any reason you
> dropped those? The change log doesn't mention anything
>
> Thanks
> /Ilias
>
> On Fri, 17 Nov 2023 at 04:02,<seanedmond@linux.microsoft.com>  wrote:
>> From: Dhananjay Phadke<dphadke@linux.microsoft.com>
>>
>> Add support for KASLR seed from the RNG device. Invokes dm_rng_read()
>> API to read 8-bytes of random bytes.  Performs the FDT fixup using event
>> spy.  To enable use CONFIG_KASLR_RNG_SEED
>>
>> Signed-off-by: Dhananjay Phadke<dphadke@linux.microsoft.com>
>> Signed-off-by: Drew Kluemke<ankluemk@microsoft.com>
>> Signed-off-by: Sean Edmond<seanedmond@microsoft.com>
>> ---
>>   boot/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
>>   lib/Kconfig        |  7 +++++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>> index 49d14a949be..12defcf645c 100644
>> --- a/boot/fdt_support.c
>> +++ b/boot/fdt_support.c
>> @@ -12,7 +12,10 @@
>>   #include <log.h>
>>   #include <mapmem.h>
>>   #include <net.h>
>> +#include <rng.h>
>>   #include <stdio_dev.h>
>> +#include <dm/device.h>
>> +#include <dm/uclass.h>
>>   #include <dm/ofnode.h>
>>   #include <linux/ctype.h>
>>   #include <linux/types.h>
>> @@ -650,6 +653,39 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
>>          return 0;
>>   }
>>
>> +int fdt_rng_kaslr_seed(void *ctx, struct event *event)
>> +{
>> +       u8 rand[8] = {0};
>> +       struct udevice *dev;
>> +       int ret;
>> +       oftree tree = event->data.ft_fixup.tree;
>> +       ofnode root_node = oftree_root(tree);
>> +
>> +       ret = uclass_first_device_err(UCLASS_RNG, &dev);
>> +       if (ret) {
>> +               printf("ERROR: Failed to find RNG device\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = dm_rng_read(dev, rand, sizeof(rand));
>> +       if (ret) {
>> +               printf("ERROR: RNG read failed, ret=%d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = fdt_fixup_kaslr_seed(root_node, rand, sizeof(rand));
>> +       if (ret) {
>> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +#if defined(CONFIG_KASLR_RNG_SEED)
>> +EVENT_SPY(EVT_FT_FIXUP, fdt_rng_kaslr_seed);
>> +#endif
>> +
>>   int fdt_record_loadable(void *blob, u32 index, const char *name,
>>                          uintptr_t load_addr, u32 size, uintptr_t entry_point,
>>                          const char *type, const char *os, const char *arch)
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 19649517a39..4f5dfc00d6f 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -477,6 +477,13 @@ config VPL_TPM
>>            for the low-level TPM interface, but only one TPM is supported at
>>            a time by the TPM library.
>>
>> +config KASLR_RNG_SEED
>> +       bool "Use RNG driver for KASLR random seed"
>> +       depends on DM_RNG
>> +       help
>> +         This enables support for using the RNG driver as entropy source for
>> +         KASLR seed populated in kernel's device tree.
>> +
>>   endmenu
>>
>>   menu "Android Verified Boot"
>> --
>> 2.42.0
>>
