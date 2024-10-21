Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D010D15D8A
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76AA88DB2;
	Mon, 21 Oct 2024 14:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nMwDbokQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDF588E35; Mon, 21 Oct 2024 14:47:19 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80EB688770
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so5776751a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729514837; x=1730119637; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hsvEfE0le5yOrh1XuVOSxdSsEKe79VVGemEXZsh5ums=;
 b=nMwDbokQF6EWN8GJaKjDCRnPZj4hPJoSywKixT6E5nW4gAtKubVrDg6fMvNqW+m1vT
 d8G3RTtmJ4J/gatm7dteS8LTbQ9NZiBjpvD12w3ltHfFM/yBWkZwqSxF9oCvNRPTHt8O
 +YDe3FpPgNAkdWtlwkqSWXGNCrSdOmFLov4vS1kiN8fcDX2APPm/Vhw4P3GC5ygHcCnU
 9AjScz6+Nhzq7fdAe4QPYl4ZwYSaC60L2Orfc66nTzLnVg4aIVMe4SAEp3pRdVujeKTI
 zpckMXmC6Nf75mSs3VkHWtc28VEWnaS5YJQZ9Jil0C6umLygJeg9u0UzzR4jcZcCLtef
 kWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729514837; x=1730119637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hsvEfE0le5yOrh1XuVOSxdSsEKe79VVGemEXZsh5ums=;
 b=BPeQqh2SF+PJVcJ2982ZjDsfNRo2se0iOEuu4Ff15JtNtgIz98VvDD574qzuYiXw2N
 8JCkZP8zukAJ2+2LCfIAf+LQu9n0e6inq3UX+KDLSZ/wf6dcXOxPv8NrRjIj8vTYAS2w
 B7Is9bQAm2XsFgRJL38Ut/bU4Zh/W/ks8yBZ8pjCFI3eCFWdRrO7oZb93u6e0qXJEt1Y
 J+hBDKgJ6qb6u/+5GPXtVVM2GfoWHZkhuJgo+w3RZIUX6NC2PbX5haIFchCcsjN4DbXm
 iNya5Trh1lcQ9cvD88ZOjSKyR4LoBBZ0kFParkufO+OBKXnZiqMRG7IXKOg2uyIdvwdm
 4+QA==
X-Gm-Message-State: AOJu0YyN0hunXO9wd2GZjyyIwm3A/1Fo4PRzYQuFQJX8aLLBlTBYU1Gr
 AzNsyrjvDk0GZatkYRzF4zhREqTemBhEeCcaBh4YsiT9imYoDd6WpxpOBGQVJWOA9s6WQ8/CTeu
 7sZU=
X-Google-Smtp-Source: AGHT+IFjHfhqY1bKV5FV39iRl0P9SJjcFRRPhmnu6PLe2vbz+/1UEjaEw1NG6Mflyzovkh2CIfbEPg==
X-Received: by 2002:a05:6402:34d2:b0:5c8:ae9e:baba with SMTP id
 4fb4d7f45d1cf-5ca0ac44031mr11642793a12.2.1729514836921; 
 Mon, 21 Oct 2024 05:47:16 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a653f5sm1924494a12.26.2024.10.21.05.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 05:47:16 -0700 (PDT)
Message-ID: <fb8dafdf-821d-4bae-887b-42954caca8b5@linaro.org>
Date: Mon, 21 Oct 2024 15:47:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>,
 ada@thorsis.com
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
 <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
 <20241021143016.64dae8ca@mitra>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241021143016.64dae8ca@mitra>
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



On 10/21/24 15:30, Benedikt Spranger wrote:
> On Mon, 21 Oct 2024 10:17:54 +0300
> Eugen Hristev <eugen.hristev@linaro.org> wrote:
> 
> Hi,
>    
>>>>> Do you use at91bootstrap as 2nd level bootloader like me or
>>>>> something else?
>>>> I use the U-Boot SPL. There is no UBI support in at91boostrap.
>>>> There were some attemps, but...
>>>> No interest at the at91bootstrap side.
>>
>> It's not about interest. There are two main reasons:
>> First, all open source UBI stacks are GPL. At91bootstrap is not GPL
>> and it cannot take GPL restricted code (being MIT ).
> I do not recall any issue mentioned about a license issue, when I send
> out UBI patches for the AT91boostrap over a decade ago. It was a simple
> "nice, I put it in a branch, but we do not need it."
> I followed the UBI topic in AT91bootstrap loosely after that.

The patches that I saw ( I do not recall whether they were yours or not) 
while I was maintaining the project were GPL and about 4000 LOC.
It was adding more than 12k to the size.

> 
>> Second, all UBI stacks are huge in terms of code and memory.
> OK. Maybe we have a different view on huge. The board I am supporting
> now is the successor of a AT91SAM9263 board. This (old) board use
> AT91boootstrap with UBI support. BTW: The original requirement for UBI
> support was to fit into 4k (PPC 440 bootloader).
> 
>> At91bootstrap is a second stage that should fit in 16k , 32k or 64k
>> depending on the platform. So far this restriction could not be met
>> by any UBI implementation.
> OK. This need some more in depth view:
> A SPL needs UBI read support only. This support can be done in less
> then 4k, as I mentioned before. So UBI full read/write support?
> You're right. It does not fit.
> 
> Needed read support?
> It definitly fit (and works fine for over a decade).

I am glad you see you have an implementation that works. I am no longer 
maintaining that project so I cannot say anything about the possibility 
of ever merging it.

> 
>> ... and yes, doing a custom in-house small UBI implementation would
>> be challenging, and costly.
> If you look at ubispl, you got some clue, what's needed. The UBI
> support to the AT91boostrap (for the AT91SAM9263) is about ~450 LOC.
> Managable, but why should I do it, when U-Boot SPL does the job...

I can understand that. Nobody asked you to do it.

> 
>>> (What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
>>> at91bootstrap loads U-Boot from raw NAND at some offset like
>>> 0x20000, U-Boot (proper) loads everything else from UBI.)
>>
>> Either way, it is interesting to see that the U-boot proper NAND dm
>> driver does not work without at91bootstrap.
> To be clear: The U-Boot *SPL* does not work with the NAND dm driver.
> 
> The old NAND driver does. So from a developers view I can spend some
> spare cycles on that, from a overall project view: we use the old
> driver, since it is working.

Ok, so my understanding was wrong, in fact you cannot use NAND dm in the 
SPL. It may be that there are some missing components from U-boot proper 
that are not built in (or some quirk/initialization)
So this can be looked into by the people interested, and I can 
understand that you have a solution that works for you.


> 
> Regards
>      Benedikt Spranger

