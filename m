Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F5C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 10:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646C181E06;
	Tue, 29 Jul 2025 12:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hBw6vp5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6EBB82C65; Tue, 29 Jul 2025 12:10:15 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77091805D7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso25955025e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753783813; x=1754388613; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Klqzh+nzp7yPieg4QEzre+saFKuizwFoHoWLRVEl77g=;
 b=hBw6vp5xpXVncDVeXY1r/JnPM3FFYhpfDU6leyq8ON5aoHlHpYPwY+eOdUlezry2jx
 G2vnprtgv9MFqBooXFzW5oSIIXVh4tfPuxBEH0vYk4eZxSzWlU/tFo6NNmh40fk8mx/4
 iwEtrq8dfBQsmdPhcE96UcIK5JCf0WlSfy08NoTpQcEcpluqIGUM1/WL9SqGctp7YSsB
 VLSkA/Wl0KNeZC2WS19/6IzmvPWvaXIUn21hFsJkeJ/YI4KF9xIyjzeoxMWCyTKezn4O
 o41mjpVcJdoookI8exiqFt7KLSiUNkTaObukfkwrf8HnS6MKAUkgziO4ZuO25CD/oa7B
 +5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753783813; x=1754388613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Klqzh+nzp7yPieg4QEzre+saFKuizwFoHoWLRVEl77g=;
 b=wdshFsVL3eNjWYZKwpkkMVGQ0VON4sAPdDt32tciKyX44i+2c/dSK/WNEw/wdlhWFE
 uvxNEXo2KR0DC/O+RErG3VwLtlUiITdxvURn9t2KshbcWHY1Gc/iQjjCsASMxUKvjFCY
 MgisJ5pi9caZHbVFlCU807gKRUW6mEJQZIOh11HoJXg/BuugtCK7VW9AYY7dzphfv4N5
 jaMSy+CXD4tntha1k8Sjfxa8oKVqm7zl9q44KMuaSBfG5FUFfGzDq8SpMqw1TgApJ73C
 2qrcuf8JBDVJ+05FQ2AcBzGfV/yFsRh7TJ6JClGHU+RWrjsxTDcLFvUz1BEkrtW/55F8
 HuGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjJZZD8oawE4BgJwrrTanBOfyn0/0L2N2XEMsCHHbcyI2AQQaLoE0TAAAd/WrwRV9JKfKfRDA=@lists.denx.de
X-Gm-Message-State: AOJu0YzdjyCCXY2cnVI6fE7Q/doDf8Xh2Sk2qH5giSP5OxaVoSifzBzb
 hCrDwDJwzxPREegU7fUZ0U/oZ5EEMI5GxPDxJj9zaKIkIUxxC+r1jMTfma687/ZzYG0=
X-Gm-Gg: ASbGncvqQLvvFVhgM6yJXY7VYRi2rS3BFlydYNxsExXx2ui0rCN2/bBjj1mQ9Kg2Paf
 4fCACO/AmEFVO2P0Z0ZoIiNXkskVsmzQACDvqEx5hXZrGmiBmzmoyMkiDZ5GoA0y52b3kqyqVtC
 Z/zBoWDnh9ds3yzImS0FHNBhlrWnLP+lgZfrC6SqFHaH4i2//7pYkN/pW3NKkll1C3WALRzTiOh
 aJ6MaqHg0kJM2ZkyERgSZJI7Dsh7KXZsO6KlRPWOV9LooRrU7nxgWRvpjCd06ntWzkywdSQnUZ/
 7W+5Puy2Dd7elmoDawIbY2OvWqcxgwL9BHvgjkVufAv8KowroR9ZByqP0ROUTz3ZqST8R8zYzP8
 MgBFE4uUw7Rmzz4uvjgwTcOAEARmSC2NYsklUTvnR8g==
X-Google-Smtp-Source: AGHT+IHSYR0DRFAbKrEiiL1iAWGw5XoUp12DRANa/cfXlwurYCmF9qRO0u8088Ucj3H72re2X1aJ0g==
X-Received: by 2002:a05:600c:19d1:b0:456:eab:6344 with SMTP id
 5b1f17b1804b1-4587631448fmr147061325e9.15.1753783812757; 
 Tue, 29 Jul 2025 03:10:12 -0700 (PDT)
Received: from [172.20.10.8] ([185.99.24.47]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870555065sm195698955e9.15.2025.07.29.03.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 03:10:11 -0700 (PDT)
Message-ID: <64795ab5-9516-4d8d-b228-8babbb6a34a4@linaro.org>
Date: Tue, 29 Jul 2025 12:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] capsule_update: fix partition match to exclude
 uefisecapps
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, adrianox@gmail.com, moritzf@google.com,
 sjg@chromium.org, maks.mishinfz@gmail.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-3-balaji.selvanathan@oss.qualcomm.com>
 <786a2fca-d137-45ff-91d4-6f9e8cf95f75@linaro.org>
 <1b8c2fcf-5ca2-4e76-96dd-35a8e37f9b4a@gmx.de>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <1b8c2fcf-5ca2-4e76-96dd-35a8e37f9b4a@gmx.de>
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



On 7/25/25 16:20, Heinrich Schuchardt wrote:
> On 25.07.25 15:11, Casey Connolly wrote:
>> Hi Balaji,
>>
>> On 24/07/2025 11:00, Balaji Selvanathan wrote:
>>> - Update partition name match to use "uefi_" instead of "uefi".
>>> - Prevents incorrect matches with partitions like uefisecapps_a/b.
>>> - Ensures only uefi_a and uefi_b partitions are considered valid.
>>> - Fixes capsule update logic when identifying target partitions.
>>> - Avoids flashing to unintended secure apps partitions.
>>
>> Please rewrite this in sentences rather than bullet points, this should
>> only take a sentence or two to explain.
>>
>> Kind regards,
> 
> The patch does not describe why the change is needed.
> 
> Wouldn't the suggested patch break existing systems using uefia and 
> uefib as partition names?
> 
> What is wrong about calling the A- and B-partition uefia and uefib 
> respectively? Looking at the code it seems only important that the 
> suffix is different. The suffix value seems to be ignored.
> 
> Reading the documentation I would not know if uefi_ALPHA and uefi_BRAVO 
> are valid partition names for the A- and B-slots. I would have expected 
> a matching documentation change in doc/boards/qualcomm describing the 
> precise restrictions on naming the A- and B-partitions.

Some docs explaining this would be a good idea.

These partitions are "firmware", they are provisioned from the factory 
with these names and they always follow the same pattern. We make the 
same assumption in U-Boot that these partitions exist and follow a 
certain scheme. We do assume that there will never be a "uefia" 
partition (if there were it would be added by the user probably on a 
different LUN and this would not be where U-Boot is flashed anyway).

If there is a product with a custom scheme which isn't supported by this 
code then at that point we would look at adjusting this code to be more 
generic somehow.

iirc these partitions also have custom GPT type UUIDs, so it would 
probably make sense to use those in the future rather than matching the 
names and then we can avoid any potential confusion.

In any case, I'm in favour of adding some docs with the expected 
partition layout, I'll send a separate patch for that.

Kind regards,
// Casey (she/her)

> 
> Best regards
> 
> Heinrich
> 
>>
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>>   arch/arm/mach-snapdragon/capsule_update.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/ 
>>> mach-snapdragon/capsule_update.c
>>> index 4dced4961b6..11ef4a0f4b9 100644
>>> --- a/arch/arm/mach-snapdragon/capsule_update.c
>>> +++ b/arch/arm/mach-snapdragon/capsule_update.c
>>> @@ -136,7 +136,7 @@ static int find_target_partition(int *devnum, 
>>> enum uclass_id *uclass,
>>>                * flags might not be set so we assume the A partition 
>>> unless the B
>>>                * partition is active.
>>>                */
>>> -            if (!strncmp(info.name, "uefi", strlen("uefi"))) {
>>> +            if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
>>>                   /*
>>>                    * If U-Boot was chainloaded somehow we can't be 
>>> flashed to
>>>                    * the uefi partition
> 

