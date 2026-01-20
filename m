Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94848D2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 10:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF51C83A3B;
	Tue, 20 Jan 2026 11:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FMqAbaQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E8183A6A; Tue, 20 Jan 2026 11:01:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B88EB83A2D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 11:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 253E73FBD6
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 10:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1768903276;
 bh=q09MFPRUnDS5Ci0oRHy8XM2YPQH5+jVL0Qyg/TlA6wc=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=FMqAbaQI1GjeM23efe+svCgXPKx1a0kqYm3SAT0rHDGNorQCzIFEKo5We7HxxWWEe
 0OKEKXKMRc+DvbH8ddVxPZnOrGFrSJgQQCU6wyVeWqQGTHYKvoPvwCvWFuM0VT5ldM
 LhbKOfvR36hPW6+3s8dZYj1tIp3mKjrWpjl9WNmStdb3O08q8R4toXBNi/7HrhGMgr
 xWtDdC3OT2sRrpLXjnmLSVbncg1vqzYDRKSvkLbyEnYF/9vvnV9x4rl3T9vNB0EwrO
 qZXsAtXOIO1RJ0D/4D1MB2GJXodMCz8YVzQ3+xahAFyc8WnGvf46DoMCbrsL6ifF8s
 BLXMHyoDWkGoZnm9vLga46belfZ/ewz8EB3VveoEqWT+5Kc+3iWALCRwbRQC2MP3zs
 H1aQE/rzgIIuTmY/eULvvTdcdGJJpZb2M7pQSByVRCl78k+ZTLno0Of5LGN0+POr2E
 0DjKG1gh7lxJcm49FFaFMwc29uPYqWdOWWUt8JPQTNNBj1prS7npuQ4gMq7VQp+4X4
 vzEukQOq4yW6Z/vTdmtXrUQdSb6hDhE1vMg+qLW2MxhWii0PmTOQ9Y2E6agUEH18G3
 xaN9HuYrRqdm4cNMvCeUiwuLK1fsFQ8NbFbWJZ8Vmr7gn8NxA2QH6oVCzaG+no9Oe1
 lSgoUDYKD9FdAIUvrBlplh7s=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4310062d97bso3104811f8f.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 02:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768903276; x=1769508076;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q09MFPRUnDS5Ci0oRHy8XM2YPQH5+jVL0Qyg/TlA6wc=;
 b=Y804azBpxoIUrlMH1yVeHJ8psp/YVvxDUt+ZVyng5K6+sTT9Ed09yJC4xxid2XPdfZ
 V0wWR/GsUD7HU14l+yQrnajQUEp4lE3ulTb2mWepIaqeen/V1bcRmx9Wl97aRJ/Wiy49
 C4ePcI6CuxvYpVueyxvPD9Gmy+1bx0iBgdrwOnjeKdI3KO9cSx5nKUMD54sqHSBUTOun
 I6Hc3CqaFZqTsiv+NIP5fUYKopfx6MKC7I+iSUAOcqD+ZKkyG2b5L9SjusBOfJ1IpwMt
 GBNxnoY5+6pEtoBlUipkwdpE6O9OpoIeGSmtZikeQW33KcRYLCpZjzZpBEA1m7Rb/Veh
 20iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRQrV2xyYmNlQTPNecE+c9RNxlEBwHgass38Tvy/wu7WKRnkZJZBB3N5PhaHS/uyGZfVr7/ns=@lists.denx.de
X-Gm-Message-State: AOJu0YxiQlcDt+Yzoszik4bG3JhjoMtTHz5/rxGa1S/ccEnYMZT/dd5s
 /wzvNFvj6nVlduIaHcrBRmuk+yBpf/GAv7xMJmdLpEwF0nzyLR7JHIex2ycSr5AO6vWTzIfRWNu
 X7N4WOdDIcPewwYP3CDG7EcVHnj+4XVQa7ujbrGu1FXtIZdNtcbR29Zzoone6/F+Ag2xAoXU=
X-Gm-Gg: AZuq6aJ2elPu7amwQsTvYy27U+qSIV2sr9S02iOT5Y3ImgXL+sFiA5UdfViUK8GksvD
 wvPlrE6660ELsNTMpCwjPacf1g036iqcB0ztYsUKH0PA5PUQnDtZnDw3GDA4+A5DNjS8V9zH+SY
 U09kr/6Y+k3njQFemyyMTWoGfyhXeRAtS9pa0w4a3tgOHLji8DY4c9+ZeREBeHFVfubYvva4wgp
 lueECbV7KB4CBvygkJ4yjootoDqHDpWn9Zc6nMhPeOkYr+vKvs/E2FrQIhPK4V22fYLyXe2zvVP
 PlghecCWbZim/Ix6U8XuaI4Zns8UxvTby7QNu7F+Ad97gEVk1VP22xC6k1hfRdbXD0yx6SMR7Rd
 epUGsESTjWgudFtfnY5US/fai3W5RqGuoFUuIr70anYfR48NGVQClP6F7
X-Received: by 2002:a05:6000:4022:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-4356a07210bmr19132713f8f.62.1768903275694; 
 Tue, 20 Jan 2026 02:01:15 -0800 (PST)
X-Received: by 2002:a05:6000:4022:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-4356a07210bmr19132657f8f.62.1768903275153; 
 Tue, 20 Jan 2026 02:01:15 -0800 (PST)
Received: from ?IPV6:2a02:3037:6ea:29a:22ce:ee4f:43a7:7a93?
 ([2a02:3037:6ea:29a:22ce:ee4f:43a7:7a93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359314bbc6sm1561298f8f.12.2026.01.20.02.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 02:01:14 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
Date: Tue, 20 Jan 2026 11:01:12 +0100
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
Content-Language: en-US
In-Reply-To: <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
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

On 1/20/26 10:33, Mark Kettenis wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>> Date: Mon, 19 Jan 2026 22:09:25 +0100
>>
>> Hardware watchdogs don't currently get stopped as part of
>> ExitBootServices, this can result in resets during boot if the OS
>> doesn't have a driver for the watchdog, or if the driver isn't loaded
>> in time.
>>
>> As with the EFI watchdog, stop any hardware watchdogs as well.
> 
> This has been discussed before and rejected on the grounds that this
> defeats the purpose of the watchdog.  I think there was some consensus
> that an OS that doesn't have a driver for the watchdog or doesn't load
> it in time is broken.  Some folks also pointed out that on some
> platforms it isn't possible to disable the watchdog.
> 
> Ultimately, I think EFI needs an API to control the hardware watchdog,
> such that an OS doesn't need a driver.

The hardware watchdog interrupting an OS if it is hanging is intended 
behavior. It is required for recovering from a failed capsule update.

Some watchdog timers have a maximum timeout that is too short for 
booting (e.g. 16s on some Sunxi boards). To avoid resets these options 
are available:

* Set CONFIG_WATCHDOG_AUTOSTART=n.
* Use device-tree property u-boot,noautostart.
* Use the `wdt stop` command in PREBOOT.

Best regards

Heinrich

> 
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>> Changes in v2:
>> * Fix compilation when CONFIG_WATCHDOG is disabled.
>>
>> ---
>>   lib/efi_loader/efi_boottime.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
>> index ddc935d22409..c34616db578a 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -21,8 +21,9 @@
>>   #include <time.h>
>>   #include <u-boot/crc.h>
>>   #include <usb.h>
>>   #include <watchdog.h>
>> +#include <wdt.h>
>>   #include <asm/global_data.h>
>>   #include <linux/libfdt_env.h>
>>   
>>   DECLARE_GLOBAL_DATA_PTR;
>> @@ -2263,8 +2264,10 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>>   	efi_update_table_header_crc32(&systab.hdr);
>>   
>>   	/* Give the payload some time to boot */
>>   	efi_set_watchdog(0);
>> +	if (CONFIG_IS_ENABLED(WDT))
>> +		wdt_stop_all();
>>   	schedule();
>>   out:
>>   	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>>   		if (ret != EFI_SUCCESS)
>> -- 
>> 2.52.0
>>
>>

