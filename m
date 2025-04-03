Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61718C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 07:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E0D81F69;
	Thu,  3 Apr 2025 09:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f8wAL8za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C890581F6B; Thu,  3 Apr 2025 09:10:12 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBD78043C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso2138945e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 00:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743664209; x=1744269009; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JqahBb5zOPa8Y5Fl3oih95i/IuT3Z35j8rTqmzodvz4=;
 b=f8wAL8zaK59frQgDspBqdFOrYP4/bL+DZBAFL03/U6raPqgnn0ZkhYhJ3kyBxQE8op
 QlLiHR1ffbAf568okseRvWOY0r/0GyV7ks4qGGZ8IXSp6XkzKpqyH4RmJ3upSLkqxq66
 CSDryiTXXUXlmkGcFiW3dbX/QEGnNIYbDwzv54vgHILYHPqgyLsCVFP8Fe+m7pfl1b3w
 SDbdL0JxrpkCKXui51wj9fte3/5+ygtzXwfu2hclH2P6uOXiALU+Q+H8LWag5cBy0HNH
 GDYaL7x08igLhhan8LKtWIXKtNSYrdAQ0c7bN8aIMX1H2Wj4/Thzt50uXzHXbwukjbfr
 amkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743664209; x=1744269009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JqahBb5zOPa8Y5Fl3oih95i/IuT3Z35j8rTqmzodvz4=;
 b=q8oyueaFMsCLgeLqwbuP9t6CcuTB8O1savcr9IsnC/wuE+0MQH7eGesq+5R7lR06l3
 QnF3Fgvwc5FaYOM8xZHiX84RFia2MoQi1PHYyar2C8qUY/Ax1D48oD7UPlLJqtEybIqg
 /9RdtmK+7FvdU5OJans6nCILk0gOvTZ4Os7ykZvhL2XhPHtKLTiqPmgzIFZZLFLZZ1Be
 Jkctg3nJ8gzdAakWhrJO7qXTaNEG5XXFuBnbdYanoHbaiuAreb2MuFAbQva6JQBs9Mxh
 rsGBIaDsyNymAIFHquq9ckt+3ANV4862LBcueO8QqIYminAT9iMVCvcylYP8sGadqWRR
 sgOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqq2KgKh3QNLz1K7oQGHpZEnqJQvEGU+hFDzWx2zsI7KTJvCeeEA2Jib6OkAWeMEPClnqhlAg=@lists.denx.de
X-Gm-Message-State: AOJu0YwT5Bu6j1Vte7t7zf0BSAY1ouw8UHwlhBZLCehQdHzPachVBb4E
 D4wneTT0cP9RFjC9RC8vze/yyfbHIWR5HPrp2VTgFzhWgtEc/4TJjfTJC4fkCHg=
X-Gm-Gg: ASbGnct2EnmLVdz0+cd9W76cbm8VrDRQWamFi5QWUW0Yo+CgxgtcdEhc3eckv0wbjb3
 LXHWCMILf/EdBj1blhNHiFC1AQdT0sr5Hefb2wV2guc0q54GLs5hyh2RlggMhMs/zWeaK79+y/F
 /wgyu+M9q0wJnAyfLQRTBU3uXtXikG5CE0RBfJetsfzVqvHDTjxMJ+E+/dhOTowcaBlazaLf1oL
 Nj93jGdBjzoZlelKWu03hwkMaRTxeuTwP4LV4xLyWpXq2618VkGpGqeksx7zlPyRqApPCcYKQrR
 cOUhYcVP0N+MPN2uBkTfQGmEH2MqWb0qNHXMrTuO4jvLhQwUtjN5iZNJAcKZA5K4nEz9WWJyTUy
 cQZ1LvjoHTWRlw5p7U5Y=
X-Google-Smtp-Source: AGHT+IGLz5HeQaMLoM3L3JD0+iUUT0wuSk9aA2tfzo5pKmzjOa+IdEqgaDfGgnf7EGzYv5RxuaKueg==
X-Received: by 2002:a05:6000:188e:b0:391:2e19:9ab with SMTP id
 ffacd0b85a97d-39c1211c900mr15508963f8f.47.1743664209402; 
 Thu, 03 Apr 2025 00:10:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a5e1:dbb:9c2:cc7b?
 ([2a01:e0a:3cb:7bb0:a5e1:dbb:9c2:cc7b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7586sm975274f8f.38.2025.04.03.00.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 00:10:09 -0700 (PDT)
Message-ID: <e2e311dd-edb2-4bcd-918e-71b3890250ed@linaro.org>
Date: Thu, 3 Apr 2025 09:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
 <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
 <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
 <CAC_iWjLHPLeX2DhnVqS3QtjhyPVd-Hkuqr0vF_dCXmBQApwvng@mail.gmail.com>
 <CAFLszThH3a7pLJG+zppu2qr5RwXAOk9Sj+S+RAT0B758hzOsyQ@mail.gmail.com>
 <9869b70e-0fec-4682-8ba0-c679df9c4603@linaro.org>
 <CAFLszTiAUh3O_8i1-zF2V4p2AW+0kmZsz2ft5phPcE0LzhQu4w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTiAUh3O_8i1-zF2V4p2AW+0kmZsz2ft5phPcE0LzhQu4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 4/2/25 21:22, Simon Glass wrote:
> Hi Jerome,
> 
> On Wed, 2 Apr 2025 at 20:48, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 4/1/25 19:55, Simon Glass wrote:
>>> Hi Ilias,
>>>
>>> On Wed, 2 Apr 2025 at 05:33, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Simon
>>>>
>>>> On Tue, 1 Apr 2025 at 18:42, Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> Hi Jerome,
>>>>>
>>>>> On Tue, 1 Apr 2025 at 03:14, Jerome Forissier
>>>>> <jerome.forissier@linaro.org> wrote:
>>>>>>
>>>>>> Hi Simon,
>>>>>>
>>>>>> Any feedback on this series?
>>>>>>
>>>>>> https://patchwork.ozlabs.org/project/uboot/list/?series=448553
>>>>>
>>>>> No, not from me, but thanks for doing it!
>>>>
>>>> Aren't you maintaining the sandbox drivers?
>>>
>>> Yes, I'm listed as maintainer for lots of things. What sort of
>>> feedback are you looking for?
>>
>> Well, you were pretty explicit that those tests were important to
>> you ([1], [2] and especially [3]), so I was expecting some kind of
>> review/ack on your part. The series is currently assigned to me in
>> patchwork and I got zero comments, so I'm not sure what to do with
>> it. Unless someone objects I will probably add it to my next PR to
>> Tom for -next.
> 
> OK, good. Yes you can add my review tag to the series:
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Cool, thanks!

> 
> Thanks again for doing this.

You're welcome.

Regards,
-- 
Jerome

>> [1] https://lists.denx.de/pipermail/u-boot/2025-February/581988.html
>> [2] https://lists.denx.de/pipermail/u-boot/2025-March/582435.html
>> [3] https://lists.denx.de/pipermail/u-boot/2025-March/583362.html
> 
> Regards,
> Simon
