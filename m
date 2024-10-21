Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E80D3E18D
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 07:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1500F885F4;
	Mon, 21 Oct 2024 09:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ihHa0db+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD6787042; Mon, 21 Oct 2024 09:17:58 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D58892D9
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso27085545e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729495076; x=1730099876; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbzwtnNrVXDHcio3kXDcIzZAbdvgbI/yxFyL60DHbDg=;
 b=ihHa0db+CEXydL2SPpGB7GYBe0QW1lBvWS/bTMYxwHvAgrsOHhftY2oyk2q/Kq2Zfc
 639n5UM4pCU8m5qs0cJvPdnPxe+tAVOdrvpb8FlQLk0iS9M7JOgoeFZZAW0VYFOpRwgf
 fNbwjYzxN/Ln4emCdbgk/JxXuUXLGo3o8R5v/evz5bzPH9/NTbVrlG/0TDh3NDtJM7WV
 TC1FiVkj0DHbrsJEFnUHXgjlPlHr6da31XO0OAfXbvfz3m6wUGNOw3pZsLEylxhRQHxx
 NJVgLx3UnkK09l3pWbW6IfNnZ7vim7v2tr0ymBwWSYsCnqgD4cAUykI1rUJLRdlSlr/3
 yzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729495076; x=1730099876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbzwtnNrVXDHcio3kXDcIzZAbdvgbI/yxFyL60DHbDg=;
 b=IljtxadhwIAKqHDAW+V/yxeGCYyMbKV6vU9pdepuWmUufza9n7yaaLuPUl27dnAlQk
 bbTRkObJuUIZ+Va/ElLnzK8Mnr2UkCIkg0SUAtjag/3HfeRxvj2kjieBkv1zm8Gf96lA
 DpWR+yWMTYJVLN+cH/DNUWP5FNcWdldsEtXeBuC9TJhrIqsqv8Gmknu+BlbOLz1lnv1F
 DM8TnbOZyzyx8Ud4Dcyv2vjabTC4HW/nf6+H9XInL90F36/fGmyaova/rFtmLnz39v+L
 EylDiU+clD4jiV8283ZRVg5hFod9aJge3qmA6IjJTq4MwZsOEkUuJLJ/nsKRuNVttk9Y
 d8kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWinVTyLBvf7MmPAi6GjulB6JXTTLjrFh8a8HS80rtJEvdGM7A+iHXvCDBx/e1SfVuGKZcvtlU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzjk87NFQYBsndCBBrAjho/dVSHXnTS7gY2nUR/1aQA/+5LlJUC
 QGrbL9Xrk3gFxxKjwrx72GbsJYx4uWWoS5yIPAZIVcr11d+FacVlvvOZgPCucz0=
X-Google-Smtp-Source: AGHT+IGdaudpkm+hpEERdeUZcPJck/HD20eT1OPYfeCdQwO7li8ReBXaErFJ3wZven0MAm5IDxqBgw==
X-Received: by 2002:a05:600c:1c82:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-4316169a56fmr72693605e9.22.1729495075940; 
 Mon, 21 Oct 2024 00:17:55 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57f89fsm46319545e9.16.2024.10.21.00.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 00:17:55 -0700 (PDT)
Message-ID: <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
Date: Mon, 21 Oct 2024 10:17:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
To: Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de,
 John Ogness <john.ogness@linutronix.de>, ada@thorsis.com
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
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

Hello,

On 10/21/24 09:03, Alexander Dahl wrote:
> Hello Benedikt,
> 
> Am Fri, Oct 18, 2024 at 04:19:08PM +0200 schrieb Benedikt Spranger:
>> On Fri, 18 Oct 2024 15:11:20 +0200
>> Alexander Dahl <ada@thorsis.com> wrote:
>>
>> Hello Alexander,
>>
>>> Am Fri, Oct 18, 2024 at 10:30:00AM +0200 schrieb Benedikt Spranger:
>>>> OK, you might say the nand_atmel NAND driver is obsolete, but it
>>>> was the only solution to get booting from NAND running. The new DM
>>>> based NAND driver refused to do anything usefull, so I dropped it
>>>> after spending a couple of days debugging it:
>>>
>>> Strange.  I have at least three different boards with SAMA5D27
>>> successfully booting from NAND flash with the new DM based driver
>>> (unfortunately none of them upstreamed, which also won't change in the
>>> foreseeable future, sorry).
>> OK.
>>   
>>> Do you use at91bootstrap as 2nd level bootloader like me or something
>>> else?
>> I use the U-Boot SPL. There is no UBI support in at91boostrap. There
>> were some attemps, but...
>> No interest at the at91bootstrap side.

It's not about interest. There are two main reasons:
First, all open source UBI stacks are GPL. At91bootstrap is not GPL and 
it cannot take GPL restricted code (being MIT ).
Second, all UBI stacks are huge in terms of code and memory. 
At91bootstrap is a second stage that should fit in 16k , 32k or 64k 
depending on the platform. So far this restriction could not be met by 
any UBI implementation.
... and yes, doing a custom in-house small UBI implementation would be 
challenging, and costly.

> 
> Yeah, been there.  Wanted at91bootstrap to boot from SPI-NOR which is
> _not_ Quad-SPI, and the feature request was closed with "if you wanna
> do it by yourself, ask our support for help". :-/

iirc at91bootstrap can boot from raw spi-nor (yes, not UBI)
> 
>>> For me it was basically getting the dts for U-Boot correct, but
>>> I got that running with all U-Boot releases since 2023.04 up to
>>> 2024.10.  Could you share some more detail?
>> I face all the trouble in SPL. And since the SPL is the essential part
>> here (UBI support) I gave up at one point. I simply couldn't any
>> usefull read data from the NAND flash, but all 0.
> 
> You can not store bootstrap or SPL in UBI, it must sit in first sector
> of raw NAND, I suppose that's how you load SPL?  Did you try
> reading/writing raw NAND from there?  I'm not familiar with SPL, does
> it consider dts?  I could share my dts parts if that helps you.

SPL should use dts. However on at91 platforms, SPL is dangerously close 
to the SRAM limit where it should fit, and it has been challenging in 
the last years to either make it fit or remove it.

> 
> (What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
> at91bootstrap loads U-Boot from raw NAND at some offset like 0x20000,
> U-Boot (proper) loads everything else from UBI.)

Either way, it is interesting to see that the U-boot proper NAND dm 
driver does not work without at91bootstrap.
There may be NAND quirks in at91bootstrap board init that may influence 
this (pins resets, timing delays, etc).

You can test NAND driver by booting at91bootstrap and Uboot from another 
medium, like sd-card. In this way, at91bootstrap will not touch NAND 
device, and you have a clean U-boot booted.

Eugen

> 
> Greets
> Alex

