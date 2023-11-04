Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3931C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C45A83414;
	Sat,  4 Nov 2023 21:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dx/atKxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B790686828; Sat,  4 Nov 2023 21:00:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA43803AC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A16B40620
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699128014;
 bh=Iui24WYhRG4C79ehk0syB4lEyHBoAP4RJCUSRd18eD8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dx/atKxuCiat2ZMuuF49cgnfMIBqIe1bJNPN9DMhkSyBtsKOTeQyWg2lfx3gwXki+
 EHWjKCAem4FS/aQAc/f1kd9ZGoT9N+BGMV1qjn/zL7lUhWvBkFb/CiGvep6d4yCXxR
 nWO3Jca7eClBnJ7Yy9Uf96Vnt6hDZUJ6mBYZ+U57EXX7KzwBNxYiCLFXe4n66TVM9S
 KQ6j+9n97uczDO5b+EEBfE7b5CaG7nNU8eFVEGc13JinIMGCw/nI+PJmdKAoeb1zVE
 GHiouKoA9VHgIF4wMluUoz+ryTMOXUvoRDpDVIQMlLYnGqZSXSog/tPCmpQwKC2qjP
 EfCIWieshWDCA==
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507c4c57567so3118142e87.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699128013; x=1699732813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iui24WYhRG4C79ehk0syB4lEyHBoAP4RJCUSRd18eD8=;
 b=oeuyLOXrYqz05n/9OUcRuVtYi7Wcepy9WVsVe6tsRTbD6aj1tO+rnrDkf02KAhEmyh
 55tpubTeKX0H8KQBFo4Eh1hNAHHrLpbpO3ymZC1SLIBpKstAQp0a7mBFy0X13xMcZc39
 ZXwJvL0Qe6hkzEgwld9oVH/aLolhRhDSGsym+1OFYIA3BX57Ih37XZWTU2hlQR2czM1i
 sSOsDbK2/zUU7SO5ClOL/2jH6on6XZOKIhq+JTOfpCn/Nzv3UCdpvQTzRA6Xl46bNHEa
 rX6ZsEjHp2vGZ6GsU4G+v0NTeXqEA3zXXrvf/4b61Ym0j5AixV+yvG1WYoEi8TwBL9wA
 BmRg==
X-Gm-Message-State: AOJu0YyzXhMchTk67ZuxCsnwWjon87Yt9muw7JKJKoOyevlSWlWyPfHd
 kFxgVblDdQjLEIBHNweiwzHm4o1Zd2tsdg/RA5Hqtsm7Xm/7WA893YJPWtzb2qjG31N+gHqblVk
 c8RDxudy36vy2nfd0zrW+gRx9JGX0QBfBbfxpz7Nivw==
X-Received: by 2002:a05:6512:2396:b0:507:9623:8ae8 with SMTP id
 c22-20020a056512239600b0050796238ae8mr26567289lfv.29.1699128013567; 
 Sat, 04 Nov 2023 13:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj05IA8U11OhXGPhqvOmKt9G+q+Ab2PU5lDtPZpMLL/k7cpfslFwu2z0KuROnDAptqkqAftg==
X-Received: by 2002:a05:6512:2396:b0:507:9623:8ae8 with SMTP id
 c22-20020a056512239600b0050796238ae8mr26567267lfv.29.1699128013099; 
 Sat, 04 Nov 2023 13:00:13 -0700 (PDT)
Received: from [10.0.29.1] ([159.148.28.2]) by smtp.gmail.com with ESMTPSA id
 d12-20020ac244cc000000b005079994a9e2sm595917lfm.252.2023.11.04.13.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:00:12 -0700 (PDT)
Message-ID: <ab1b51cb-3d7b-4e65-b28f-e42e6a0c70cb@canonical.com>
Date: Sat, 4 Nov 2023 22:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dm: fix misleading messages
To: Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
References: <20231104184716.13743-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3st2CHJeSVkZGL-N7fDQqebK9VD0vodsXaz+Er96sB1g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3st2CHJeSVkZGL-N7fDQqebK9VD0vodsXaz+Er96sB1g@mail.gmail.com>
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

On 11/4/23 21:45, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 4 Nov 2023 at 18:47, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> When no RNG device exists for a driver referenced via U_BOOT_DRVINFO() we
>> get messages like:
>>
>>      No match for driver 'arm-rndr'
>>      Some drivers were not found
>>
>> This is misleading as it is not the driver that was not found, it is the
>> device that is not found. Correct the messages.
>>
>> Reported-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/core/lists.c | 2 +-
>>   drivers/core/root.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
>> index 8034a8f48d..e39d3acc97 100644
>> --- a/drivers/core/lists.c
>> +++ b/drivers/core/lists.c
>> @@ -97,7 +97,7 @@ static int bind_drivers_pass(struct udevice *parent, bool pre_reloc_only)
>>                          if (CONFIG_IS_ENABLED(OF_PLATDATA))
>>                                  drt->dev = dev;
>>                  } else if (ret != -EPERM) {
>> -                       dm_warn("No match for driver '%s'\n", entry->name);
>> +                       dm_warn("No device for driver '%s'\n", entry->name);
> 
> This should be "No match for driver_info"
> 
> It is not a device
> 
>>                          if (!result || ret != -ENOENT)
>>                                  result = ret;
>>                  }
>> diff --git a/drivers/core/root.c b/drivers/core/root.c
>> index d4ae652bcf..29c918eb73 100644
>> --- a/drivers/core/root.c
>> +++ b/drivers/core/root.c
>> @@ -167,7 +167,7 @@ int dm_scan_plat(bool pre_reloc_only)
>>
>>          ret = lists_bind_drivers(DM_ROOT_NON_CONST, pre_reloc_only);
>>          if (ret == -ENOENT) {
>> -               dm_warn("Some drivers were not found\n");
>> +               dm_warn("Some devices were not found\n");
> 
> Some driver_infos were not found

This suggestion does not match the case that Andre and I were discussing in

https://lore.kernel.org/u-boot/1ad4bd2c-e667-42b6-b637-8816a6c60d94@canonical.com/T/#m13fbf9011d74f713080284fb9963c90646d527fb

U_BOOT_DRVINFO(cpu_arm_rndr) is triggering the arm-rndr driver's bind 
method. The bind method returns -ENOENT if there is no matching device.

Neither the driver U_BOOT_DRIVER(arm_rndr) nor the driver info 
U_BOOT_DRVINFO(cpu_arm_rndr) is missing. It is the non-existence of a 
matching device that triggers the messages.

Best regards

Heinrich

> 
> They are not devices
> 
>>                  ret = 0;
>>          }
>>
>> --
>> 2.40.1
>>
> 
> Also please add a Fixes tag, I think for this:
> 
> 20e442ab2df dm: Rename U_BOOT_DEVICE() to U_BOOT_DRVINFO()
> 
> Regards,
> Simon

