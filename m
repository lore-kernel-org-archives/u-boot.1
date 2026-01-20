Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADA9CA5FA2
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AB383A6A;
	Tue, 20 Jan 2026 17:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fWxswVZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9079A83A91; Tue, 20 Jan 2026 17:08:59 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8C283A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 17:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1408D3FE42
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1768925337;
 bh=wtoDKXnfstrIYGwVTkoQRxWixcHtHpAANtwQa7kMbCk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=fWxswVZrjMWVxK+SeRShU0UYoGU6bHXHV08A+Q+k8sz9bF9J3ho71wPYaRHi8FXhI
 vfk395htRmyN/nN4K+SIaTpSiMxRo84KK4wODMb394dsCDAbLlStMDKXugEBISTjGo
 Dwf4OMz3F5DzYMLPcfE+rd7hXxF4qst5FEAGt0Jou4aM8RVJuqU4I+qvgXz+QtDXc4
 Tx1TI4zD747eXcRdnxXYpC5pIoH/mDoRT5L/QtuqHhsZi1Ak/yVM/V6boUMiLzXAFN
 53K1BW7Rai8Vm7xT3L3f/rfkdoZxFn0RfKddbcg3MYug6zBpUfC5U2H30k5mla8vT1
 Gy+t5Nrq34Javy8VHHukiciuY0wWMxsJdVqqywu7glNk6iXjY5qBPtDuwGZn9rfepZ
 3vr1Zxa/iH7OVetHvSw+cGPQH6Jxo6lYGIUWh8iNMPr9fDNbRygHxXlFlZN03sX9Fk
 I2DxYJaAv9MJao5mg5FNGZAO9nKy4/o23zyz3Yrn7IuI6J1edvr+xhk9e5wwvfVX18
 EZpJ6c9yu2licqLxbYYgPB4a7gU121CkrQuRT9EjByii+qIfzpj3QsWaYogMGuT4x2
 2M1ea4Hpm7GZ9sq139TrZ7yJxswBFmrXg5EB1pnOpOVRIZ3T6VRrB3B8l7OYG459Ps
 QiLNxNKnUIrGiqYjNScuxyrY=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso28761545e9.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 08:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768925336; x=1769530136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtoDKXnfstrIYGwVTkoQRxWixcHtHpAANtwQa7kMbCk=;
 b=hWTLEyS+61wuSWxVbiBjt/bfaecg5alrplz/OEWyijRK3CLwbxsWC5d63tbGEwZhaa
 ys7c1kd6rTcZBo9u3ZSdiNQnB7y7zBIBtqDgCr9YarO+fqRRUcTmzA3KXC++OtzWO1Gi
 kiErU8d3BAm6Qoe5OwkmpoY/KElKl1+YDP9ILIhK1ZCAaJ5B8XBq34cm+QenY6qjKItd
 718A/69WM2LJngG3XLABCz3xNS+nc5TuZim1Co05PpzP4BjXLpCQEEk65gSuziPFzIXl
 CYyqdlWU/FD3MOuKQStsXKS5xV3qEsC/ZNXNq21DbmsdvEq0Kzz3eJBqT7IZi3iFzMlF
 Fp9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ4kOsojUxe4wETB6PYGY1lusTcd7+b/Bz/HP7Ig4rQaGSQl82SRSFSoDtqSEbfcnNm1c4zcs=@lists.denx.de
X-Gm-Message-State: AOJu0YyapLCesUJl5yxOv+fFY3a+rAAmsvrPLetuVjMDjb1RvwzjIQYR
 9ekL95awq4RH239ELlEECATRodLqgFxCwFgtlHp0e3yF7PY/cfqWqyR5JvdSmU5OETXIpFP4DmB
 m+4RV+qEgjrH1M3VEDNN0KrCtGVyIKr68/jSdbsgM2+CYQZ2yyhmpFSJIoQMnIVJ4GruaqP0=
X-Gm-Gg: AY/fxX65aEp2Q004ogp3L0YAE1izpXHheOR0mMaLUepUPo827kFgUUTbmAm08dDdDIT
 COEcHIGJ38KMAdHSh4GVzFrtPe344pz+PJppdCJDjiEoF3wPn0h4l+X1exuXNEVyhwvAQ5FtB2C
 bsQ1ouvaq74OJJAovKHWAACK7YJkhsna0rZxI3NlmMoODcvYaa1JForcUfRl6yY7JZq+U+RWBDr
 DjxoO66sYyGXrUjBlzM+Y2QpHpJKrW+YkCT2B57wotBQrDx+W4LKRt+id5HgZgnJvFpVRot4VlI
 X3ixBFfbhn3UR9HapEGiVanWMS+A7kbeTmirCfNzUeZXdHnT4PycpTDi+ZiPJeiyJNI8NqEfPvw
 Kj1G0JQv9OGn9TJkPvRSpXULATI3KnaZXSQahFIbonOwj6wkacMsda+H4kpUmmklVafjk0GCusv
 jGdynhWq4=
X-Received: by 2002:a05:600c:1910:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-4801e67bceemr206608505e9.13.1768925336571; 
 Tue, 20 Jan 2026 08:08:56 -0800 (PST)
X-Received: by 2002:a05:600c:1910:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-4801e67bceemr206608075e9.13.1768925336160; 
 Tue, 20 Jan 2026 08:08:56 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c9cbcsm252305665e9.12.2026.01.20.08.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 08:08:55 -0800 (PST)
Message-ID: <5e09e65c-f8e4-4a05-b5de-342c74817036@canonical.com>
Date: Tue, 20 Jan 2026 17:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
To: Casey Connolly <casey.connolly@linaro.org>
Cc: paul.liu@linaro.org, adrianox@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, jerome@forissier.org, mkorpershoek@kernel.org,
 ravi@prevas.dk, me@ziyao.cc, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>
References: <20260119210925.29185-3-casey.connolly@linaro.org>
 <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
 <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
 <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
 <20260120155211.GN3416603@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260120155211.GN3416603@bill-the-cat>
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

On 1/20/26 16:52, Tom Rini wrote:
> On Tue, Jan 20, 2026 at 04:12:27PM +0100, Casey Connolly wrote:
>>
>>
>> On 20/01/2026 11:01, Heinrich Schuchardt wrote:
>>> On 1/20/26 10:33, Mark Kettenis wrote:
>>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>> Date: Mon, 19 Jan 2026 22:09:25 +0100
>>>>>
>>>>> Hardware watchdogs don't currently get stopped as part of
>>>>> ExitBootServices, this can result in resets during boot if the OS
>>>>> doesn't have a driver for the watchdog, or if the driver isn't loaded
>>>>> in time.
>>>>>
>>>>> As with the EFI watchdog, stop any hardware watchdogs as well.
>>>>
>>>> This has been discussed before and rejected on the grounds that this
>>>> defeats the purpose of the watchdog.  I think there was some consensus
>>>> that an OS that doesn't have a driver for the watchdog or doesn't load
>>>> it in time is broken.  Some folks also pointed out that on some
>>>> platforms it isn't possible to disable the watchdog.
>>>>
>>>> Ultimately, I think EFI needs an API to control the hardware watchdog,
>>>> such that an OS doesn't need a driver.
>>>
>>> The hardware watchdog interrupting an OS if it is hanging is intended
>>> behavior. It is required for recovering from a failed capsule update.
>>>
>>> Some watchdog timers have a maximum timeout that is too short for
>>> booting (e.g. 16s on some Sunxi boards). To avoid resets these options
>>> are available:
>>>
>>> * Set CONFIG_WATCHDOG_AUTOSTART=n.
>>> * Use device-tree property u-boot,noautostart.
>>> * Use the `wdt stop` command in PREBOOT.
>>
>> Hmm, thanks for the suggestions. I considered doing this in some
>> platform-specific way, but I don't think it's correct for U-Boot's
>> default behaviour to leave watchdogs enabled, I haven't gone digging
>> through the EFI spec but I would imagine it's not EFI compliant either?
> 
> We've had some long discussions about this in the past. It's very much
> intentional that U-Boot leaves watchdogs running. As Heinrich noted (and
> is a summary of the older threads) some hardware doesn't even let you
> disable a watchdog. But it otherwise defeats the purpose of one to turn
> it off. Part of my feedback before was that the EFI spec needs to be
> addressed if it can't handle this correctly.
> 

The UEFI specification explicitly requires a 5 min watchdog to be 
enabled when starting an EFI binary. It should be disabled when 
returning to the boot manager. See chapter 7.5.1 
EFI_BOOT_SERVICES.SetWatchdogTimer().

In 7.4.6 EFI_BOOT_SERVICES.ExitBootServices() the specification requires 
that "the boot services watchdog timer is disabled".

Both has has been implemented in U-Boot as a software watchdog because 
some hardware watchdogs don't support 5 min intervals.

A watchdog for the phase after ExitBootServices() is not described.

Setting CONFIG_WATCHDOG_AUTOSTART=n would comply with the specification.

Best regards

Heinrich
