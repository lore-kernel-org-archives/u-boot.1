Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68626ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 08:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC7A88AE2;
	Tue, 10 Sep 2024 10:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LPwASn8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA4188F2E; Tue, 10 Sep 2024 10:43:37 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FCE88881
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso20354365e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725957815; x=1726562615; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEcidVICuYspp6GSAy5Ohk5T1Ej4h0Hog3fVJFd8+RQ=;
 b=LPwASn8SYrn6rC1OEeuQS/DnXJ4UaBWm97qI0k1CZW8NLXPKLH99QbHmpkNuTuPqJ6
 VP9ih9YWKHWKi/HGPHHvuRZ1mGIKc/bno4dib2wHBqoG674Y3cPQo/ruTc9JRSvPw1KD
 UHv2jAAFhvsU1zmMKQBaFI8gIvvErIk/cmf8f4ZZ44bAlSvfSQJ8QsHUspolE9NKuIdP
 QpNXCEYDaDdSRdRHqYND4FIf0i6RYUV4wmEYHR9uGcp1Ap7IckT6zJmukUKbSyXo9nuM
 +m1zUqwO8TuAMCGHwUBFFhmjUSRGEC0+767IVOEXX+JG8ezBnIE4kZNSd7x/LemYnVxI
 W8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725957815; x=1726562615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEcidVICuYspp6GSAy5Ohk5T1Ej4h0Hog3fVJFd8+RQ=;
 b=ljOytysyXgs4ginSGZ7wck5utsfshqkC6CgZDSkwYbTUKFd6hNqhyjG5mVnSlTlB/d
 WaCtjJxYfEI/ZN0mOaQcUvi6k8DGn63y2Ew2psuScE332fTfa88jjfaQBGgCeJugnoJH
 f6cxWC/HseZRaBmw+ZOjmUll1wDn72QdnWdwYl7WVszrB6NJN5Gase4KegKxpAQg3BZ/
 tReoDci5rZpHJuH3HvGXwtTTl+ifExkF+sZogJqh88PjtcLrE4nz1XA+f1db9DENJLAD
 133o0RkBbZxaFf7gwjutBUzEjzg35qGWMxxLjqCWf23arrMznNvZXH/oXYdDnUcWN0sW
 SzuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+9c8+MRyBG7WiEELTg5oVRWBatKoS+T3Cr7RFMCXh/LrZqZ8WFDEkPqiztRY2ntC6N2koyJ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6UE80KljI04QL9kod4AoDnlTUiwiUaU9E2W52QvpN/ZEUm1JA
 SnyoON3RzpRu2IcT3luZSVxfox8Yj+lhfFPOek+H6Rz/yO4dOHp8caMu9vhTS9w=
X-Google-Smtp-Source: AGHT+IGYzcRcYjDinR+lKolbE8jxk6JaEcAn7GZ09+An262uLVHJcuDu4hHYurV345a8ZuIHl4/+Sg==
X-Received: by 2002:a5d:5e10:0:b0:378:8aaa:9cd6 with SMTP id
 ffacd0b85a97d-3788aaa9d24mr7840241f8f.49.1725957814909; 
 Tue, 10 Sep 2024 01:43:34 -0700 (PDT)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb44887sm103716905e9.23.2024.09.10.01.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 01:43:34 -0700 (PDT)
Message-ID: <39b61a84-83fb-4fc4-9891-edc4660b5404@linaro.org>
Date: Tue, 10 Sep 2024 10:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: ram: fix build warning when neither RAM_DEVICE nor
 DFU are enabled
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240909132252.3975017-1-jerome.forissier@linaro.org>
 <8022cc2e-bcc0-62f9-b00e-c830987967e7@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <8022cc2e-bcc0-62f9-b00e-c830987967e7@gmail.com>
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



On 9/10/24 04:20, Sean Anderson wrote:
> On 9/9/24 09:22, Jerome Forissier wrote:
>> Fixes the following warning:
>>
>> common/spl/spl_ram.c:19:14: warning: ‘spl_ram_load_read’ defined but not used [-Wunused-function]
>>     19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>>        |              ^~~~~~~~~~~~~~~~~
> 
> Does this config even make sense? 

I don't think so.

> What is the point of enabling SPL_RAM_SUPPORT without one of the above configs?
> 
> Maybe we should make those configs select RAM_SUPPORT instead.

Yes, and make SPL_RAM_SUPPORT an internal symbol so that it cannot be enabled
on its own without SPL_DFU or SPL_RAM_DEVICE.
Note that SPL_DFU already selects SPL_RAM_SUPPORT but SPL_RAM_DEVICE "depends on"
it.

If that sounds good to you I will post a new patch.

> 
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   common/spl/spl_ram.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
>> index 71b7a8374bb..1a5874c3949 100644
>> --- a/common/spl/spl_ram.c
>> +++ b/common/spl/spl_ram.c
>> @@ -16,6 +16,7 @@
>>   #include <spl.h>
>>   #include <linux/libfdt.h>
>>   +#if CONFIG_IS_ENABLED(RAM_DEVICE) || CONFIG_IS_ENABLED(DFU)
>>   static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>>                      ulong count, void *buf)
>>   {
>> @@ -96,6 +97,8 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>>         return ret;
>>   }
>> +#endif
>> +
>>   #if CONFIG_IS_ENABLED(RAM_DEVICE)
>>   SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_ram_load_image);
>>   #endif
> 

Thanks,
-- 
Jerome
