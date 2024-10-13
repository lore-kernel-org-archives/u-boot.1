Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DDCF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 16:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7940188F03;
	Sun, 13 Oct 2024 18:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fbOsTdnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B0088F55; Sun, 13 Oct 2024 18:35:23 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5ABC88EFD
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 18:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43120f65540so14237135e9.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728837321; x=1729442121; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bV8srbBtyKWvXBczF4Nd8zrfz4sXQVs2K/Dtc45JPrI=;
 b=fbOsTdnNCuRwyzDbHKj0s98GyNHKyvnq9D60C4pFghRKSuHMGBPzmw6w0QrGiD5Dlo
 cx1MblnrGwUiCWTNW2Gh1od5GkiE9TbLe7XBGjMVnycmMs3/EItGyhevvX90foZEPkfd
 QXQAoHz9gcZoF/PatHFHIbqXzfNC3WAWUkuhSwWSnijH+Zh7rRo2TVDvslvaE9AzdyK9
 MCT1cDJKQLN0oFJZAgG4rwWUg3RdFUZfIrtJEKldD3p8ppCHmgXvIjcAKR8H1nN9C5EV
 eYzHyXJkBjpPatKdbz/63XpScCv4EZzhG00ZkMqeCp3aIdEszCjbwqxsVID/1uZJxkXV
 UEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728837321; x=1729442121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bV8srbBtyKWvXBczF4Nd8zrfz4sXQVs2K/Dtc45JPrI=;
 b=vBu+wI4Rvoy9DWpkJiyr4jc2AAgMfQrRPA53Ido64KSuLwyGTp30OkXmW5VdxEM2Ih
 JCbxOmDsboDb26NI0axv1A3BpJm1Gx/GHdkOStnDDzTF18TygLJzJk2qbK4n18lTyq9Z
 fxd7kmkA0cHtPfsBzRh8ogk/zd1ZIBC+lpnc8dLzxCVxhK747nqYfBvtzTOt59ycjxdX
 g+HJWJ9rpFCBgMG4iPhM3OpkbDfZ3i2LdGVT2auLh4o4Uu2jKcYMmaTtq9mePu4YQFU6
 z6BoErP2jByuzacSKXIS9SOZshmm3PQtrAD8hLcu0XiQznOVSeJN+Fv/fDdMKQltVrG+
 SiUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSuTOEVPgO9CqoCPJ5SJLESyo/rQZh+oBMdnIpy6s9DMSgP6wAaSuHx2AwxEbNCzSEN1d4PU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7laojNpKwUZIGeKeNC0Iyet0bDBJmqXGVbm4/kpzPRWbrRDg+
 kL2T2rFxedb8aZu2oKcqaIX4+Ya7/t3/z/JUzrQiB7bGwMHvNaRAGn+nULvMUJ4=
X-Google-Smtp-Source: AGHT+IGr0Qs2LayVC1vSlvFR7HtyZSdKJE00WfgOoXADSCMeTlL6T5RRdO8VOOxVksGjqZDWm3inuw==
X-Received: by 2002:a05:600c:3b1f:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-43125609073mr50698765e9.23.1728837321244; 
 Sun, 13 Oct 2024 09:35:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:705a:8bb3:8b50:341e?
 ([2a01:e0a:982:cbb0:705a:8bb3:8b50:341e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d748f0a5sm129877495e9.48.2024.10.13.09.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:35:20 -0700 (PDT)
Message-ID: <99d3fe30-78c0-4bed-9bbb-299c5058034b@linaro.org>
Date: Sun, 13 Oct 2024 18:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] usb: dwc3: fix dcache flush range calculation
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-2-5f3498d8035b@linaro.org>
 <2eaba59e-bc6d-4ffc-b4eb-0eebc0b090a9@denx.de>
Content-Language: en-GB
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <2eaba59e-bc6d-4ffc-b4eb-0eebc0b090a9@denx.de>
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

Hi,

Le 12/10/2024 à 05:37, Marek Vasut a écrit :
> On 10/11/24 4:38 PM, Neil Armstrong wrote:
>> The current flush operation will omit doing a flush/invalidate on
>> the first and last bytes if the base address and size are not aligned
>> with CACHELINE_SIZE.
>>
>> This causes operation failures Qualcomm platforms.
>>
>> Take in account the alignment and size of the buffer and also
>> flush the previous and last cacheline.
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/dwc3/io.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
>> index 04791d4c9be..0ede323671b 100644
>> --- a/drivers/usb/dwc3/io.h
>> +++ b/drivers/usb/dwc3/io.h
>> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>>   {
>> -    flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
>> +    uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
>> +    uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
>> +
>> +    flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>>   }
>>   #endif /* __DRIVERS_USB_DWC3_IO_H */
> 
> You likely want a max(CONFIG_SYS_CACHELINE_SIZE, dwc3-buffer-alignment-requirement) to really correctly align the buffer.

No this change is related to the system cacheline to properly flush/invalidate the data
to the system memory, the dwc3 buffer alignment (if there's one) should be handled
when allocating the memory, but here we're using dma_alloc_coherent() which
use DMA_MINALIGN.

So it's another unrelated story.

Neil
