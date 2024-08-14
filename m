Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB82CC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E491B889AA;
	Wed, 14 Aug 2024 14:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tlw0OFv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A447889AA; Wed, 14 Aug 2024 14:53:47 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67BCC87C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DC7A0400B2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723640024;
 bh=skPkXkty6p5SUDMDr46GBDhC+iXYlR6TI+tI0rwud0M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tlw0OFv/KJxA8Oge9Hs9I1xqpwKlLfI8fsWW6Obk32a/wIZDDeC1664cXLW8hKb4V
 VE9aTKUr9Y5X4YMk27fZ0er5gSGKC0buzo5XaEACeQyv7jEyyfcJDrMXW1wnuQSsBG
 I0gWm445055MvngHaeV+4vRWqhjWBRHMCwngad4HgK2DKj27GArMAgPTwmvEKtkb15
 T7fQ7xGid+eKzdzDLfaAXf7PQgkgpRMEL+fhzxvZVtHcmTL0ceazMfsh+B1aOyiZoU
 tZwIPl8jZFr2ZojLNtldnW4vEfsOTfGKg0dWhCrKD0D/QYz2Mi5B6Q1hHhAyu2ew5o
 byqhxzj6J1Ghw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-368374dc565so2849097f8f.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723640023; x=1724244823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skPkXkty6p5SUDMDr46GBDhC+iXYlR6TI+tI0rwud0M=;
 b=LvsmSLa0lvyHwvLVSAMuwgN2rppAbu9P6fprSNmuG+vVcW2TAosFtVoHTWe8azFgzJ
 hrLxLFPfj1yF5CUpSJyeg8tr9khDsjgw2TpOa1UJgnaSfgZUOJciAHjcfhfrv6WH3Fl4
 DQ68H7I2J3vL9drNRpS/XVnOlC00SyNetKS8hOsEHJg/b4hxp2tnXu+rj8CSu7E6X9aC
 v2HHmcxJne5S0GXQYbUoQdTWGvM+Jd+cs9CCPmZ8YR5gwV/qgbmyXsQxswDIxmVOMChS
 VAeqSHgemdj3bag3TVOqhiSeV1g+zEBhdPhtI/hEdkMPnQLvXRM0v06l1aPiGcU4+PFP
 LUPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6gO6/s2AnjGu9J0Pk62f/eTP8AiU0Gb6rB44rS0svbkMz5dn/R2lTX9jD1vRfQHegqdW9yjdnN/31USW7C4haajzcTQ==
X-Gm-Message-State: AOJu0Yy5jbzl165icR/oToz6n/mpMGiwV+VKF/ik7yBWChU9arVvb7+C
 K7IxO/F/kl3zHVQzdr5zgPJAMU4hiTSyGO08K0c+iQyGQgvLfOEjaA4t4U69wsA/i9ugHiVWlka
 7xKZdT5AxIWVdKvIPMtB4xEi6YWwds5kgn8xelh5OO2q3sX6nR7O6B7B4ff0XsY07VbA=
X-Received: by 2002:adf:ef12:0:b0:367:434f:caa2 with SMTP id
 ffacd0b85a97d-371776523e0mr1641167f8f.0.1723640022744; 
 Wed, 14 Aug 2024 05:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwxPvP7YOa0nT6YEVguLIk9zumSB6mQH6MX0/IB4/YyLMXaeiLWSRPEE8F4qcdsk+T9GjLqw==
X-Received: by 2002:adf:ef12:0:b0:367:434f:caa2 with SMTP id
 ffacd0b85a97d-371776523e0mr1641147f8f.0.1723640022121; 
 Wed, 14 Aug 2024 05:53:42 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c36bcf6sm12747056f8f.17.2024.08.14.05.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 05:53:41 -0700 (PDT)
Message-ID: <4b7a4178-1224-44fa-8998-800721728211@canonical.com>
Date: Wed, 14 Aug 2024 14:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
 <CAFLszTj29ZXtVSmyA-pDp61UuvvMEVks5barSYjNRqUH+mgSpQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTj29ZXtVSmyA-pDp61UuvvMEVks5barSYjNRqUH+mgSpQ@mail.gmail.com>
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

On 14.08.24 14:40, Simon Glass wrote:
> On Wed, 14 Aug 2024 at 01:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> A system may have multiple SATA controller. Removing the controller with
>> the lowest sequence number before probing all SATA controllers makes no
>> sense.
>>
>> In sata_rescan we remove all block devices which are children of SATA
>> controllers. We also have to remove the bootdev devices as they will be
>> created when scanning for block devices.
>>
>> After probing all SATA controllers we must scan for block devices otherwise
>> we end up without any SATA block device.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v3:
>>          continue unbinding and scanning if one device fails
>>          write a message if scanning fails
>>          add device name to error message
>> v2:
>>          Scanning for device on an unprobed SATA controller leads
>>          to an illegal memory access.
>>          Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().
>> ---
>>   drivers/ata/sata.c | 48 +++++++++++++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
>> index 84437d3d346..89cd516f3d6 100644
>> --- a/drivers/ata/sata.c
>> +++ b/drivers/ata/sata.c
>> @@ -9,9 +9,12 @@
>>    *             Dave Liu <daveliu@freescale.com>
>>    */
>>
>> +#define LOG_CATEGORY UCLASS_AHCI
>> +
>>   #include <ahci.h>
>>   #include <blk.h>
>>   #include <dm.h>
>> +#include <log.h>
>>   #include <part.h>
>>   #include <sata.h>
>>   #include <dm/device-internal.h>
>> @@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
>>
>>   int sata_rescan(bool verbose)
>>   {
>> +       struct uclass *uc;
>> +       struct udevice *dev; /* SATA controller */
>>          int ret;
>> -       struct udevice *dev;
>>
>>          if (verbose)
>> -               printf("Removing devices on SATA bus...\n");
>> -
>> -       blk_unbind_all(UCLASS_AHCI);
>> -
>> -       ret = uclass_find_first_device(UCLASS_AHCI, &dev);
>> -       if (ret || !dev) {
>> -               printf("Cannot find SATA device (err=%d)\n", ret);
>> -               return -ENOENT;
>> -       }
>> -
>> -       ret = device_remove(dev, DM_REMOVE_NORMAL);
>> -       if (ret) {
>> -               printf("Cannot remove SATA device '%s' (err=%d)\n", dev->name, ret);
>> -               return -ENOSYS;
>> +               printf("scanning bus for devices...\n");
>> +
>> +       ret = uclass_get(UCLASS_AHCI, &uc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Remove all children of SATA devices (blk and bootdev) */
>> +       uclass_foreach_dev(dev, uc) {
>> +               log_debug("unbind %s\n", dev->name);
>> +               ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
>> +               if (!ret)
>> +                       ret = device_chld_unbind(dev, NULL);
>> +               if (ret && verbose) {
>> +                       log_err("Unbinding from %s failed (%dE)\n",
>> +                               dev->name, ret);
>> +               }
>>          }
> 
> This code is in usb_stop() to, so please put it in a shared function.
> How about uclass_unbind_children(enum uclass_id) ?

git grep -A5 -n uclass_foreach_dev | grep device_chld_remove

only finds

drivers/scsi/scsi.c-571-
                 ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);

Where did you see matching USB code?

scsi_scan() could also use a rewrite to avoid stopping at the first error.

I guess sata_rescan() and scsi_scan() could be the same function taking 
a uclass ID as an argument?

Best regards

Heinrich

> 
>>
>>          if (verbose)
>>                  printf("Rescanning SATA bus for devices...\n");
>>
>> -       ret = uclass_probe_all(UCLASS_AHCI);
>> -
>> -       if (ret == -ENODEV) {
>> -               if (verbose)
>> -                       printf("No SATA block device found\n");
>> -               return 0;
>> +       uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
>> +               ret = sata_scan(dev);
>> +               if (ret && verbose)
>> +                       log_err("Scanning %s failed (%dE)\n", dev->name, ret);
>>          }
>>
>> -       return ret;
>> +       return 0;
>>   }
>>
>>   static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
>> --
>> 2.45.2
>>
> 
> If you have time, please add a test for ahci (dm/test/ahci)
> 
> Regards,
> Simon

