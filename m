Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B01C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 18:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EB982BBF;
	Sat,  4 Nov 2023 19:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RuCU9DE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5722D86FE4; Sat,  4 Nov 2023 19:27:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED438082A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 19:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C32243FAD9
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699122469;
 bh=Q+LFnGVQaEFp/QOyr5M3Ctz+4C2kdy/zb39lbkVl/6s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RuCU9DE6S4IFhahIIgIDoOCi4CrEapOACVO7koVc/RpeUqX+rCJkto2F402yOKzIH
 U9ED1U8aVh4kvdKatvuP4U5acduhC+Ufu7XZ3Cd4Se4/NJuPWjlXLvdB1qN/kAT5Sp
 XhWKvYq7WTFjS9hwJXeb+TZw30mL8hpK91hLjPbXKi8PkDuT1Vk7jjxw3jW88qBbyo
 E3MM2k9UGvD7MEbeZ/UOYhhFhaUsb2xFs45mR5r/OWwc2F5d/3cr0OZ+y97unUuIAC
 ZYAdfZmMGqfWB3EON/5AXbOTOUCYxuFJx3lxepztGwDZhRcWM/+BFPMdpNSo39YD73
 jCh7BaEGLU6Nw==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c50cec5d29so27010501fa.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 11:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699122469; x=1699727269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+LFnGVQaEFp/QOyr5M3Ctz+4C2kdy/zb39lbkVl/6s=;
 b=cl+2RAijE8NA33cC8xerPrD216zvnSINEnTqtQIW2JlXhj7EpNgG/Xq14F/uOOjBm6
 zj+HLsUJeXtAmYgCtK3d3usCcKt/7MvTlZqrI4ROej4BA4NZObyFF6y0mdLYjCDMNE6q
 yk8Kx3xNPoswmUC3732RlW5R7NSvrG+jvI196dLWcHtfl9josDc4hTIjyY2zKGTia3vN
 MFSgX1airL5evmlqnKN5wuz7UCnU6Bj8trCVIIee7Azxctvu3nwMOBh4R08fjaL4EQhg
 wHv7xw9ezIJdifaPK91XZZG9V+q77lsWy1vKMTRX07nrCyc3sBOS7XlsWmgzcE4A/7P2
 k35w==
X-Gm-Message-State: AOJu0YwZ2kFa2POKzySzeb6CrZuryFCLPsFKcVfXoXGK+kkMjUQT4iWU
 e0Pye7fXcYHZ+TOeT7ENGjNUufUwHtpgKeGVzPUE1jfLEbQGcGH6+NVfmYCLQ4F3xgPLkgByJlh
 /odze4iEQH9gsKE/Jp3HFGRcJCPPq7hw=
X-Received: by 2002:a2e:9784:0:b0:2c6:f3cf:d67 with SMTP id
 y4-20020a2e9784000000b002c6f3cf0d67mr7383457lji.9.1699122468738; 
 Sat, 04 Nov 2023 11:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyqEH84ypCDMYBCUsMwAqRwj1RbDDpwcUhKiWOC2HaqLydUGO8hrVbkdGPMOowuRuGZhdkwA==
X-Received: by 2002:a2e:9784:0:b0:2c6:f3cf:d67 with SMTP id
 y4-20020a2e9784000000b002c6f3cf0d67mr7383435lji.9.1699122468019; 
 Sat, 04 Nov 2023 11:27:48 -0700 (PDT)
Received: from [10.0.29.1] ([159.148.28.2]) by smtp.gmail.com with ESMTPSA id
 i5-20020a2e8085000000b002c4fdb0ef12sm567487ljg.19.2023.11.04.11.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 11:27:47 -0700 (PDT)
Message-ID: <1ad4bd2c-e667-42b6-b637-8816a6c60d94@canonical.com>
Date: Sat, 4 Nov 2023 20:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rng: fix ARMv8.5 RNDR driver
To: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <peter.hoyes@arm.com>
References: <20231104070007.30099-1-heinrich.schuchardt@canonical.com>
 <20231104171316.11fde076@slackpad.lan>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231104171316.11fde076@slackpad.lan>
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

On 11/4/23 19:13, Andre Przywara wrote:
> On Sat,  4 Nov 2023 09:00:07 +0200
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> 
> Hi Heinrich,
> 
> many thanks for finding and fixing this!
> 
>> In different parts of our code we assume that the first RNG device is the
>> one to be used. Therefore it is preferable to detect the availability of
>> the RNDR register already in the bind method.
>>
>> For signaling the non-existence of a device the driver model requires using
>> ENOENT (and not ENODEV).
> 
> Doh, now I feel silly! I thought I checked the call path, and looked at
> initcall_run_list(), which prints the error message, and suggests that
> only 0 would be acceptable.
> But indeed -ENOENT works, with the slight caveat of printing:
> ================
> No match for driver 'arm-rndr'
> Some drivers were not found

The message texts are definitively wrong. They should be:

No device for driver 'arm-rndr'.
Some devices not found.

@Simon

I think we should make these messages log_debug().

Best regards

Heinrich

> ================
> 
> But it's definitely an improvement over the current situation, and I
> don't feel like boiling the DM ocean for this stupid little driver.
> 
>> Fixes: 31565bb0aa2d ("driver: rng: Add DM_RNG interface for ARMv8.5 RNDR registers")
>> Signed-off-by: Heinrich Schuchardt> <heinrich.schuchardt@canonical.com>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> 
> Many thanks!
> Andre
> 
> ---
>>   drivers/rng/arm_rndr.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
>> index 55989743ea..4512330e68 100644
>> --- a/drivers/rng/arm_rndr.c
>> +++ b/drivers/rng/arm_rndr.c
>> @@ -62,10 +62,10 @@ static const struct dm_rng_ops arm_rndr_ops = {
>>   	.read = arm_rndr_read,
>>   };
>>   
>> -static int arm_rndr_probe(struct udevice *dev)
>> +static int arm_rndr_bind(struct udevice *dev)
>>   {
>>   	if (!cpu_has_rndr())
>> -		return -ENODEV;
>> +		return -ENOENT;
>>   
>>   	return 0;
>>   }
>> @@ -74,7 +74,7 @@ U_BOOT_DRIVER(arm_rndr) = {
>>   	.name = DRIVER_NAME,
>>   	.id = UCLASS_RNG,
>>   	.ops = &arm_rndr_ops,
>> -	.probe = arm_rndr_probe,
>> +	.bind = arm_rndr_bind,
>>   };
>>   
>>   U_BOOT_DRVINFO(cpu_arm_rndr) = {
> 

