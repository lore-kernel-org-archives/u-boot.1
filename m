Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8921D29C49
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0DF83A6A;
	Tue, 20 Jan 2026 16:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o/D3ztwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C5783A8F; Tue, 20 Jan 2026 16:45:28 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A432683A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D32DE3FE48
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1768923925;
 bh=rN6jpx7itfjx5EV4YMqw4ZZCLhkf0kWbMbM/0DBlklg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=o/D3ztwjF1NvD5PEQEscmpaH4Bk+lC8Le07zVaDhm91SUYIAMWB9oITBvbHb/3MVw
 U9hfmB3ysyyxE/RuUs/DAIqQ1TcC9tNdZk0XN/LIFs9ZBqfM69/dq7hj2jSjbJEdF5
 oS7KJKy+UpeW7u5ZDPHsP0y97sQB8KD5Pob9V4jQxuRMRdn/KKeSMRe3a8CLB75dnd
 wtQRRuniDNd424bimMYxQQY6KUOJOQj+JBjnNQTP2lOT5UWx32TEP4bcBjGn7oW/be
 gbCoRzItHiTg9IkPp0qdyGqxratYOQ8VWf10LQZm7P1KCBd1flKx4lCwagVHcmZpIW
 blLmmv8Pht2XwnWYeHg3s1Dy7BKqAtHsRBfKMXLCgPnMXrrjXTTatYSpKaWOwstD/3
 EBz8Scc5j6ZJVl0xYZKkzIl59BK0cfOcglewQ/ZeT3TdZ8j1SloG3hbZ4iVgi8q5aO
 2NTJ3Ywu98USUVPMd+Y58uWgCTK+E3F1Tfs/4KEsD0PUer+XHO8GWXeijllUL+7sCf
 3PZ/EF1NtLbzca/GKIKoo5EcHp1MQl6TWkVcPzfGstrbY7f1pFvlTuSruTvDBrzRKz
 Rr5OOYPgIDPPBTv0qV/dSXIS5YIcYwbAUfKIMJjxG6DBL2tedU027+qkEjPkJQhQIm
 Fq8iPczRaXnikHvxwFiflQbE=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43101a351c7so5069538f8f.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 07:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768923925; x=1769528725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rN6jpx7itfjx5EV4YMqw4ZZCLhkf0kWbMbM/0DBlklg=;
 b=WTuPY5Mn7caRrDpDADRG4wc+c/Z5Q1n5Q9L4p+9dBRYBmIChkUg7oHsa5mVa5k14ok
 iO87SMd/3L82L02aUNewLllgOxRlvDVBp/7m9ncHBk1KgvR+UAiNDFYAhQNGxSVrH6UY
 Mcpcn7UFssU/O82Gw79RN3tjUGVFBfqTSJ0pI1EaC9EnCCdwt/nyLXMZq9X5q9i865wg
 bCjuZtAqEp0wqqeLFCteDBwltsaNpL60txDb2E9fmyus/uTUmaEcb+pFRXY7JFpGeKsP
 3gcbzCf0EWYxQ8vS0mYq2NYCmy9A37FJ4OoLHQ4ZaM3fgDyO4bdAWkmJcXnQzA9JVhvv
 v+zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW79zc/SzOgtqfMlEkcTOPwVQDlTU5cLP9mxIBXan6aGZ3MWpsFBpCMA63GByFhaye0IBcurs8=@lists.denx.de
X-Gm-Message-State: AOJu0YyXKEgxzGI/nUfc1XNZiO23q/Y3N5frT1XZQl3/YkW9eTsde3jr
 55o3JxyFJbXgtjqhWK76UOuHHBvIEe1pPiLulv4G4a9Sy7bKTmUam85dpBruWgmL2sbCwQOCig2
 sB5I5ueaFoM0NbJcnqni1arL9Gsgq4aoK3Q7bhOjvYYKnAsX87+T0jdzFXt+bIyzMJIVyPqQ=
X-Gm-Gg: AZuq6aJY10Pg+9BsIDfEtb231fnQrBGJFRQGTPj6JIXbYJ2h42fjOdYidvgtcahPAbu
 EyCRIDy5Qor01H+erpi82USRIqOUBW68KLWZlpLwHqz3u/Yq+uI2g8lZlaOLskMTOAitfLezNFX
 jPAIc9G+8NvMx7S4KnxnmBu3rw/OH7m6/zfNEk4X0PyFZjzhliEc0Uwu6zg4XeWSavrj/kQw5eL
 Gmrqqk7he1iMxD9h2jGOUX5WszaVB4s/4eCTy1OUVISZmGGq+YL/r2mZzjP+kNFasJmfLZn5Kxb
 Vv1+2Qe1uNbGOJYO2Ng98VR1q69Ai4DtCjNBnIcuULqe5BZ/YbiKJxpSDguhufPWRZ1h0Ea/nNc
 vWRtQR7sYOfy3y4eyEESnnWFbjr7lp17leM+z8wj+RvKzMVM5Ce4+69NbaZZXqR8S2WkHx8fSIB
 5zHM9Sj/A=
X-Received: by 2002:a05:6000:18a4:b0:431:918:501d with SMTP id
 ffacd0b85a97d-43569bd7039mr19330047f8f.60.1768923925267; 
 Tue, 20 Jan 2026 07:45:25 -0800 (PST)
X-Received: by 2002:a05:6000:18a4:b0:431:918:501d with SMTP id
 ffacd0b85a97d-43569bd7039mr19330006f8f.60.1768923924796; 
 Tue, 20 Jan 2026 07:45:24 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb2asm30320587f8f.37.2026.01.20.07.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 07:45:24 -0800 (PST)
Message-ID: <51008b98-c2b3-491d-847a-ee7860a1dd53@canonical.com>
Date: Tue, 20 Jan 2026 16:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
To: Casey Connolly <casey.connolly@linaro.org>
Cc: paul.liu@linaro.org, adrianox@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, jerome@forissier.org, mkorpershoek@kernel.org,
 ravi@prevas.dk, trini@konsulko.com, me@ziyao.cc, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20260119210925.29185-3-casey.connolly@linaro.org>
 <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
 <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
 <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
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

On 1/20/26 16:12, Casey Connolly wrote:
> 
> 
> On 20/01/2026 11:01, Heinrich Schuchardt wrote:
>> On 1/20/26 10:33, Mark Kettenis wrote:
>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>> Date: Mon, 19 Jan 2026 22:09:25 +0100
>>>>
>>>> Hardware watchdogs don't currently get stopped as part of
>>>> ExitBootServices, this can result in resets during boot if the OS
>>>> doesn't have a driver for the watchdog, or if the driver isn't loaded
>>>> in time.
>>>>
>>>> As with the EFI watchdog, stop any hardware watchdogs as well.
>>>
>>> This has been discussed before and rejected on the grounds that this
>>> defeats the purpose of the watchdog.  I think there was some consensus
>>> that an OS that doesn't have a driver for the watchdog or doesn't load
>>> it in time is broken.  Some folks also pointed out that on some
>>> platforms it isn't possible to disable the watchdog.
>>>
>>> Ultimately, I think EFI needs an API to control the hardware watchdog,
>>> such that an OS doesn't need a driver.
>>
>> The hardware watchdog interrupting an OS if it is hanging is intended
>> behavior. It is required for recovering from a failed capsule update.
>>
>> Some watchdog timers have a maximum timeout that is too short for
>> booting (e.g. 16s on some Sunxi boards). To avoid resets these options
>> are available:
>>
>> * Set CONFIG_WATCHDOG_AUTOSTART=n.
>> * Use device-tree property u-boot,noautostart.
>> * Use the `wdt stop` command in PREBOOT.
> 
> Hmm, thanks for the suggestions. I considered doing this in some
> platform-specific way, but I don't think it's correct for U-Boot's
> default behaviour to leave watchdogs enabled, I haven't gone digging
> through the EFI spec but I would imagine it's not EFI compliant either?
> 
> I can totally understand why it would be desirable to leave the watchdog
> enabled, but I think boards that want/need that should have to opt-in
> rather than it being the upstream default.
> 
> Would you be ok with adding a new config option:
> CONFIG_WATCHDOG_LEAVE_ENABLED or something along those lines? I'd rather
> avoid adding platform-specific workarounds to U-Boot's default behaviour
> like this.>

Why does CONFIG_WATCHDOG_AUTOSTART=n not work for your specific hardware?

Best regards

Heinrich

>> Best regards
>>
>> Heinrich
>>
>>>
>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>> ---
>>>> Changes in v2:
>>>> * Fix compilation when CONFIG_WATCHDOG is disabled.
>>>>
>>>> ---
>>>>    lib/efi_loader/efi_boottime.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/
>>>> efi_boottime.c
>>>> index ddc935d22409..c34616db578a 100644
>>>> --- a/lib/efi_loader/efi_boottime.c
>>>> +++ b/lib/efi_loader/efi_boottime.c
>>>> @@ -21,8 +21,9 @@
>>>>    #include <time.h>
>>>>    #include <u-boot/crc.h>
>>>>    #include <usb.h>
>>>>    #include <watchdog.h>
>>>> +#include <wdt.h>
>>>>    #include <asm/global_data.h>
>>>>    #include <linux/libfdt_env.h>
>>>>      DECLARE_GLOBAL_DATA_PTR;
>>>> @@ -2263,8 +2264,10 @@ static efi_status_t EFIAPI
>>>> efi_exit_boot_services(efi_handle_t image_handle,
>>>>        efi_update_table_header_crc32(&systab.hdr);
>>>>          /* Give the payload some time to boot */
>>>>        efi_set_watchdog(0);
>>>> +    if (CONFIG_IS_ENABLED(WDT))
>>>> +        wdt_stop_all();
>>>>        schedule();
>>>>    out:
>>>>        if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>>>>            if (ret != EFI_SUCCESS)
>>>> -- 
>>>> 2.52.0
>>>>
>>>>
>>
> 

