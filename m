Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B973C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 15:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481C68634D;
	Sat, 26 Aug 2023 17:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FEisuSCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D244B86366; Sat, 26 Aug 2023 17:33:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1088620C
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 17:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BDBDB3F65D
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693063984;
 bh=5zH9tEmwrr0wQ63kq4yc92xPPvMqMDtnfkFOU/g3fXg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=FEisuSCrQnh4NctMiUSpTqZsu6+oAYam3PDMFlC130RUgOXO3WySzkelogDeMi6Ek
 /QnynpzZVi14di54B5lpdIPEVxX+DjOYAV9Jjj9E8gqK+gcJiApZkB7i7MFkJpXmXS
 ANcVmtk/0nhgvBM39JqzMznv7NBHbUCUAvRrCBDw5sHqdrtHMiCvJMZl2sFToQR2Pl
 mOsZJpx+ydy5Xu+HnjMEmV/9pAjavoRJIMWvEDVfQuqpfAIK6+AhcgBhZpWV6DHuww
 L/dmBDcc4zKGRIkET0ysoogGur8T1cwfcFEa6lkQtRb2+wA3LSk2pENwC04JJ6oDSL
 pLSmDfcQths+g==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe1cdf2024so13386225e9.3
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 08:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693063984; x=1693668784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5zH9tEmwrr0wQ63kq4yc92xPPvMqMDtnfkFOU/g3fXg=;
 b=U3RzUL4Uw8LCfn4NJUZFEpuJznx0LgDfN6DNdK/9AtdK2mHtg/UciglI5u30QkszpE
 xHFvTehHkfbM6TR3uy3SUMrMxmsCOUxkJc4jS6aXwgH2GXCpriO1kcI71C9NKZ4Qprds
 fmPVs57EcTN+GqeF+9NYpD1iwNsJ1VgkRkJI/QDwRXwhcMizVNiZhpXbUWi/WlPSHqOJ
 aQyC/QkYMrUKA8E5hKJFow9y8IKFnffIIjsf13J1lvDcThbc7huJPVbIt9DrvwI5/pzZ
 lElmPuxIO6WKrPozsw3hW58xwlkgfsRUVvh8y2C07/8wkHdIrjtG47/xgH3IdrDR/Zil
 zN1Q==
X-Gm-Message-State: AOJu0Yzf5uo59LUlxbLcmF/7fnAZA2g4OyZEWabMzbjk2iaVseogoYtd
 U5qyETGDxdlWmxkecU1I93LW+iqPr+qZKx/sUu4hhH8j0nsWFWEHlYlW6bPMm5Zl0+BBW/091xG
 DRLmGllmzibqn/j9AbSMMvOdI2dheQbs=
X-Received: by 2002:a5d:44d1:0:b0:313:f94f:3b15 with SMTP id
 z17-20020a5d44d1000000b00313f94f3b15mr16841532wrr.2.1693063984274; 
 Sat, 26 Aug 2023 08:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH214O507wF1A1ADPGHZma5RBId/QplVpugGW1sQ1faSJ7Yt3GdZOCcvmz6LXgWi9Q824rTeg==
X-Received: by 2002:a5d:44d1:0:b0:313:f94f:3b15 with SMTP id
 z17-20020a5d44d1000000b00313f94f3b15mr16841514wrr.2.1693063983579; 
 Sat, 26 Aug 2023 08:33:03 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 a9-20020a05600c224900b003fef5402d2dsm8581222wmm.8.2023.08.26.08.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 08:33:03 -0700 (PDT)
Message-ID: <bbdf2631-f46c-f0cd-e26d-035079337152@canonical.com>
Date: Sat, 26 Aug 2023 17:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] cmd: fix gpt enumerate
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Joshua Watt <jpewhacker@gmail.com>, Corneliu Doban <cdoban@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
 <20230826015343.167612-3-heinrich.schuchardt@canonical.com>
 <CAPnjgZ1h5Mz=f8mjZk806bfa3RKyTetp+YGiNS-mH-fKSGNLYA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ1h5Mz=f8mjZk806bfa3RKyTetp+YGiNS-mH-fKSGNLYA@mail.gmail.com>
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



On 8/26/23 04:04, Simon Glass wrote:
> Hi Heinrich,
> 
> On Fri, 25 Aug 2023 at 19:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Do not assume that partitions are numbered continuously starting at 1.
>>
>> Only a single partition table type can exist on a block device. If we found
>> a GPT partition table, we must not re-enumerate with the MBR partition
>> driver which would find the protective partition.
> 
> Does it really? My understand is that it sets desc->part_type and it
> stays like that from then on?

Prior to my patch with printf statements added:

=> gpt enumerate host 0
enumeration by driver EFI
   partition 'EFI system partition'
enumeration by driver AMIGA
enumeration by driver DOS
   partition 'xxa1'
enumeration by driver ISO
enumeration by driver MAC
setenv gpt_partition_list EFI system partition xxa1
success!

Of course the value of $gpt_partition_list is useless because you do not 
even know how many partitions were discovered 'EFI', 'system', 
'partition' could be the names of three different partitions or there 
could be one partition 'EFI system partition'.

I wonder how Broadcom can use this in their update scripts. See 
12fc1f3bb223 ("cmd: gpt: add eMMC and GPT support").

For something usable we would have to add quotations marks, escape 
quotation marks in the string, and the do-for command would need to 
support a string with quotation marks like

"'Heinrich\'s partition one' 'EFI system partition'"

The "xxa1" string is generated in part_set_generic_name() because MBR 
partitions don't have a name.

xx = other block device type
a = device number 0
1 = partition number 0

Best regards

Heinrich

> 
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/gpt.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> 
>> diff --git a/cmd/gpt.c b/cmd/gpt.c
>> index d0e165d539..99ca0a6163 100644
>> --- a/cmd/gpt.c
>> +++ b/cmd/gpt.c
>> @@ -691,12 +691,13 @@ static int gpt_enumerate(struct blk_desc *desc)
>>                  int ret;
>>                  int i;
>>
>> +               if (part_drv->test(desc))
>> +                       continue;
>> +
>>                  for (i = 1; i < part_drv->max_entries; i++) {
>>                          ret = part_drv->get_info(desc, i, &pinfo);
>> -                       if (ret) {
>> -                               /* no more entries in table */
>> -                               break;
>> -                       }
>> +                       if (ret)
>> +                               continue;
>>
>>                          ptr = &part_list[str_len];
>>                          tmp_len = strlen((const char *)pinfo.name);
>> @@ -711,9 +712,10 @@ static int gpt_enumerate(struct blk_desc *desc)
>>                          /* One byte for space(" ") delimiter */
>>                          ptr[tmp_len] = ' ';
>>                  }
>> +               if (*part_list)
>> +                       part_list[strlen(part_list) - 1] = 0;
>> +               break;
>>          }
>> -       if (*part_list)
>> -               part_list[strlen(part_list) - 1] = 0;
>>          debug("setenv gpt_partition_list %s\n", part_list);
>>
>>          return env_set("gpt_partition_list", part_list);
>> --
>> 2.40.1
>>
