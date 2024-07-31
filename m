Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C5C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CAE88958;
	Wed, 31 Jul 2024 12:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tnI0Bn0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B741D8811C; Wed, 31 Jul 2024 12:16:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A985B88356
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7a8553db90so764494166b.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722421017; x=1723025817; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=INmCd9tATTSC5oQHQ4+CdrpJ6/NZlOzSTzGPajpXgqk=;
 b=tnI0Bn0hMv2Yc/MSFmJ/Xo9hEl5My4+hS3xyPyNJ1mq7JqwkfCQiEQg/e7XpwUpax8
 Or0x0Q3f+Q80ZUv5+y1miT2icVZWpbVK0XHB3PCuiS0p1CqeJErQTLx/Rc8LmybyyaXU
 lzy/7CyDRaWSXR9uyNUR/Xghg8jaxaOODLOLLNogjRWM/jw11FuZrDZav2Q//MmTz69l
 5+vKeeQMDxcB53MFYOm/nn+7EltuGErcUYWzzOFtaX8u6OBKgizUsdPtS8/DWeNo8OJC
 sQfUFlUd1Yq+t/zQu4sz6jHGk+mFTMG6cHPaMoZTlglBR6pvtInyLlvu7ZdCL6uOfEm7
 NQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722421017; x=1723025817;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INmCd9tATTSC5oQHQ4+CdrpJ6/NZlOzSTzGPajpXgqk=;
 b=nQB4qzTv0L4z+C2jUju850Zdj+hnsNpOqELFqjgQgGMkKpiKwxFv2oAMCX8810mFyt
 AMxckuNxJnIZviK0Os7tX+KQgLHxRkd7ChNJuFLAbwhc4CX5fk1h+HqA2fftjF8Gxsx2
 2HKlxM2Dk4Pj3hr+j7jBnX4OddK1QK2E8SjjtG0rAfqpGB46foxAk9EAmqRAOHk4qoWv
 px+aFB7+9kSogvC4d+KMtxyFC8iK4q/5yfSvu0EMvl5bDJEXm+hPbfm69JoOFehYIdpE
 Iz38SGUNrXzY019uCtBnqTlPF6YxTnqg9fs21wg6KbIYo0h90p4AtGOL//vpVxFccWn+
 cxKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW283JqTpRSSpkbbMfV708W2X6EqtaD1LrE7t4QQmaZkSDAXXFesXn7kUUWa/Fa52V+vJ9QfTmzZKjYzPtI04/akenqoA==
X-Gm-Message-State: AOJu0YwK70uzTsKcbAj4JDvNE11dM9u5vY0E4VDqicjWWY5h31WFywYm
 mclavyhhkGyc5TkEG8bWR7hkt/eYZvP/s4IKQvaHjJG69NjLNFhDJutzLFQoO3c=
X-Google-Smtp-Source: AGHT+IHH9zNbXfRLzDoKoM8nj71Mbb826uThgwksjbgmep6ekWR3lFEB2JXFOdZelBcyFDKNANy0FA==
X-Received: by 2002:a17:907:e93:b0:a7a:ab1a:2d64 with SMTP id
 a640c23a62f3a-a7d4014bc9amr1010360266b.58.1722421017040; 
 Wed, 31 Jul 2024 03:16:57 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb9f55sm754647666b.221.2024.07.31.03.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 03:16:56 -0700 (PDT)
Message-ID: <23b45a9e-d2e6-40c9-beca-6de58c7f67e2@linaro.org>
Date: Wed, 31 Jul 2024 12:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] lib: uuid: add UUID v5 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-2-8a83de3fe3dc@linaro.org>
 <CAC_iWjK1j0hG7jurTEPLKoYLPCL5JuUhRUoBwohUr=U93rb6dQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWjK1j0hG7jurTEPLKoYLPCL5JuUhRUoBwohUr=U93rb6dQ@mail.gmail.com>
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


>> +       /* Make little endian */
>> +       tmp32 = (uint32_t *)&guid->b[0];
>> +       *tmp32 = be32_to_cpu(*tmp32);
>> +       tmp16 = (uint16_t *)&guid->b[4];
>> +       *tmp16 = be16_to_cpu(*tmp16);
>> +       tmp16 = (uint16_t *)&guid->b[6];
>> +       *tmp16 = be16_to_cpu(*tmp16);
> 
> you need to explicitly convert those to LE, instead of relying to the
> native cpu endianess here

The EFI spec iirc is not explicit on the binary format for GUIDs on big 
endian systems (and currently doesn't support them at all??). Is LE 
always correct??
> 
> cheers
> /Ilias
>> +}
>> +
>>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>>   void gen_rand_uuid(unsigned char *uuid_bin)
>>   {
>>          u32 ptr[4];
>> @@ -394,15 +444,9 @@ void gen_rand_uuid(unsigned char *uuid_bin)
>>          /* Set all fields randomly */
>>          for (i = 0; i < 4; i++)
>>                  ptr[i] = rand();
>>
>> -       clrsetbits_be16(&uuid->time_hi_and_version,
>> -                       UUID_VERSION_MASK,
>> -                       UUID_VERSION << UUID_VERSION_SHIFT);
>> -
>> -       clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
>> -                    UUID_VARIANT_MASK,
>> -                    UUID_VARIANT << UUID_VARIANT_SHIFT);
>> +       configure_uuid(uuid, UUID_VERSION);
>>
>>          memcpy(uuid_bin, uuid, 16);
>>   }
>>
>>
>> --
>> 2.45.2
>>

-- 
// Caleb (they/them)
