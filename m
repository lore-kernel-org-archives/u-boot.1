Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23D5D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EAC83A6A;
	Tue, 20 Jan 2026 16:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lx4kDf1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A06C83A91; Tue, 20 Jan 2026 16:12:32 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C28283A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8714a52072so832111366b.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 07:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768921949; x=1769526749; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fGiXVwwL+U8lTBZWA3VGDx6fNFy/fqGp1YcUtd2YR9Y=;
 b=lx4kDf1zHCVdM2uGL5aCfs+Att4RDZpRjYvu3FlYPZVJhwYzL+O70JK63WBAXHyfay
 d8iQxOgJo4sEqWI42WmHWqFYo0FjkWgcUQpQJAk4MoFq4Js3PZtNy+wh/uzj4sCQLaKn
 rZcCTfQhuFNp5mp8CRsH2BndP9mhoDh8a7Y5yigarLgbAXlUFK7tFugJPTAs3c0KJWr6
 K/5164tM2hQ9niE3nQUvNPrQSi/5jMIQ5bIWvn6pjWtG5bBKBGbdHQmEGygQQq3wfBL3
 mde99hZRqPOGNae9FXJbiyjV3aooVqUnORNuQcbY59cY+kQGAOGpN9NQ4zwqLYxVKYjT
 Vvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768921949; x=1769526749;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGiXVwwL+U8lTBZWA3VGDx6fNFy/fqGp1YcUtd2YR9Y=;
 b=bk26jKdIlVagwsE8V2mXsLll+VBIcEM7u/2Aip7J/9DFaZRDL9vw6zZ/9iJ22e9mP4
 eKviA2P43SU6gLY1lMvULruK5Mi/kkYagGuDZN9eehPbUdYyDsUP7/ZL5VwpQ6HnCKyi
 xoazdj0BbFMFlJsKgiWCF+lop8IsllXBiStlRw9U9obRakwPkurto+cEuVO/3aHefDeK
 tr1DMCudo/ycjRUSu6m1Lfec/k7Bz9Icpt7gITpudy7rOeQV1TFpA+KgH4dIOKIdmBqG
 12vK3X7PnaI3CSZR/Aa0LP4ngZ2+fpdZlt5dcsrNzi7nKxwe9KG62h8fkWeNfGIsUTl7
 DfCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURmLKLJIAZoEVI6+h+7qTNELEydIWv0oeyR2WmPg5pkKihycclKLeBcSSjtbef+WHyKPJ+fgQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwH1+eXuxdBzs5ZRSrkJpPoiVbr8+AHqNfSYETAn4f4Swx/UBra
 J0lBi7JipMioISCOEvskFGOAsSeguXq3RvMDN6DBnCvTBh6buleuzRiu9outDlfPwBo=
X-Gm-Gg: AY/fxX46D733uS5wyjriTp+Y4E/NphrGDTlJj80sveoPSONHBVouuy/4awB6rdYFl0r
 iuNGw8CkgkqbiyRgro2cu9UHgtm89++atHQAtShPyubP1gzWgJ6ggxNqszUVKsyRymOCNCHSdks
 5sjt43gKr7n5W0vA/nY9zPgB6+hXQjKNhBAkxiSQq5VDk3Z0Z5S9NbGajz+AMW0kcw/WiCxbHHZ
 1TX/Zmrtl9YSuIU+7xef7blFWPorIqogDHKSDgBpeAW6K0STXXSf35gmKl61JOrsv6KKoxj7x3K
 kxLesumSXPApsLL28I6K3/WYgZ8MBiH1L8v99i01VnEHsB6coW7TH32bpByVn2BqfvVRg3JXLtz
 Kxke9C7/XmdQ2u3myi1xXxS43A0Z34SONrDDdVjGKhjmt9zcD9SxbgkANTXgdWSi7dfaCNVWwZ4
 0UI7Hd0i4JFFs8sSn8nhyLPLAVjhsGl9/bG5FhEyD/1+Q4xHLiMLCzdg==
X-Received: by 2002:a17:907:868f:b0:b87:19ac:98df with SMTP id
 a640c23a62f3a-b87968d1727mr1143638066b.2.1768921948950; 
 Tue, 20 Jan 2026 07:12:28 -0800 (PST)
Received: from [192.168.1.36] (p4fc3dfd7.dip0.t-ipconnect.de. [79.195.223.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87f6f69eedsm320031466b.46.2026.01.20.07.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 07:12:28 -0800 (PST)
Message-ID: <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
Date: Tue, 20 Jan 2026 16:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: paul.liu@linaro.org, adrianox@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, jerome@forissier.org, mkorpershoek@kernel.org,
 ravi@prevas.dk, trini@konsulko.com, me@ziyao.cc, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20260119210925.29185-3-casey.connolly@linaro.org>
 <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
 <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
Content-Type: text/plain; charset=UTF-8
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



On 20/01/2026 11:01, Heinrich Schuchardt wrote:
> On 1/20/26 10:33, Mark Kettenis wrote:
>>> From: Casey Connolly <casey.connolly@linaro.org>
>>> Date: Mon, 19 Jan 2026 22:09:25 +0100
>>>
>>> Hardware watchdogs don't currently get stopped as part of
>>> ExitBootServices, this can result in resets during boot if the OS
>>> doesn't have a driver for the watchdog, or if the driver isn't loaded
>>> in time.
>>>
>>> As with the EFI watchdog, stop any hardware watchdogs as well.
>>
>> This has been discussed before and rejected on the grounds that this
>> defeats the purpose of the watchdog.  I think there was some consensus
>> that an OS that doesn't have a driver for the watchdog or doesn't load
>> it in time is broken.  Some folks also pointed out that on some
>> platforms it isn't possible to disable the watchdog.
>>
>> Ultimately, I think EFI needs an API to control the hardware watchdog,
>> such that an OS doesn't need a driver.
> 
> The hardware watchdog interrupting an OS if it is hanging is intended
> behavior. It is required for recovering from a failed capsule update.
> 
> Some watchdog timers have a maximum timeout that is too short for
> booting (e.g. 16s on some Sunxi boards). To avoid resets these options
> are available:
> 
> * Set CONFIG_WATCHDOG_AUTOSTART=n.
> * Use device-tree property u-boot,noautostart.
> * Use the `wdt stop` command in PREBOOT.

Hmm, thanks for the suggestions. I considered doing this in some
platform-specific way, but I don't think it's correct for U-Boot's
default behaviour to leave watchdogs enabled, I haven't gone digging
through the EFI spec but I would imagine it's not EFI compliant either?

I can totally understand why it would be desirable to leave the watchdog
enabled, but I think boards that want/need that should have to opt-in
rather than it being the upstream default.

Would you be ok with adding a new config option:
CONFIG_WATCHDOG_LEAVE_ENABLED or something along those lines? I'd rather
avoid adding platform-specific workarounds to U-Boot's default behaviour
like this.>
> Best regards
> 
> Heinrich
> 
>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> ---
>>> Changes in v2:
>>> * Fix compilation when CONFIG_WATCHDOG is disabled.
>>>
>>> ---
>>>   lib/efi_loader/efi_boottime.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/
>>> efi_boottime.c
>>> index ddc935d22409..c34616db578a 100644
>>> --- a/lib/efi_loader/efi_boottime.c
>>> +++ b/lib/efi_loader/efi_boottime.c
>>> @@ -21,8 +21,9 @@
>>>   #include <time.h>
>>>   #include <u-boot/crc.h>
>>>   #include <usb.h>
>>>   #include <watchdog.h>
>>> +#include <wdt.h>
>>>   #include <asm/global_data.h>
>>>   #include <linux/libfdt_env.h>
>>>     DECLARE_GLOBAL_DATA_PTR;
>>> @@ -2263,8 +2264,10 @@ static efi_status_t EFIAPI
>>> efi_exit_boot_services(efi_handle_t image_handle,
>>>       efi_update_table_header_crc32(&systab.hdr);
>>>         /* Give the payload some time to boot */
>>>       efi_set_watchdog(0);
>>> +    if (CONFIG_IS_ENABLED(WDT))
>>> +        wdt_stop_all();
>>>       schedule();
>>>   out:
>>>       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>>>           if (ret != EFI_SUCCESS)
>>> -- 
>>> 2.52.0
>>>
>>>
> 

-- 
// Casey (she/her)

