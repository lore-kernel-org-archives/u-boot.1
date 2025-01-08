Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0433E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E28800DF;
	Wed,  8 Jan 2025 14:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rJ1ZSrSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0150E8036B; Wed,  8 Jan 2025 14:39:09 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 305D58006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso708482366b.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736343545; x=1736948345; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2KsWIK6zmI1Ht3kUjHF2ZR3CMXMb9vlXqzTM8GF0wnQ=;
 b=rJ1ZSrSzqVZe4PtM0xaMyiXnnjozZtIiC8+z52yRWIA0CGY0gDzh8MNOCOEc3kKVGt
 4I68FpBZEwKoCWbk/Aimfk3sXjgmPkrJFak/j806tXzgLLtKKw25MYf2+SCNif3B8JW8
 3jrcnlgpFMnuLjH/vwMWljywT2ROts/Y1XnQP2p0ZSXsuO9B1NOl4FxQ2e6ZItISUoYE
 9CVVO3hzg33EXMruIcOZ6TECC9ePL2EaY+OgNNp3HKg2KXnorekXPIttRtKXIO20KzcX
 QPENuAe0XgNPaEc6gASRjOlOu7ODIEEYAop6fNMXt6OnkuPSKlhbHwmFHOcnrYmuHDVQ
 3cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736343545; x=1736948345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KsWIK6zmI1Ht3kUjHF2ZR3CMXMb9vlXqzTM8GF0wnQ=;
 b=aEi5fCNpk5taEN6/jLqa9AvPbtUMXoqztq+aOd7E2oOQLnMQU7b52KofV+eZ1yxWvf
 JALTawcc5rT0pDFrZXA+3B3C9qBCGji9GpdF+PUd1IFSwleK9+iKE19aoXxZ6szpxvlG
 uhTG9vZRoTq8SOa8r7A5IT8D41SkjkS+cTR2u6UhL/VrAszFfJEVKOLRsUH44JpuLjwU
 cDdSpj7ke0Uh76aQu478gRxl/7pBqdh2NIjJZU1YjJJB+SmxNw6iPoQ9hUNKzCEMv/zK
 qT7yaDOyHcg677k47Nfb0XIosV7jSTwrDi9g0TmEXuhtpgKR7oibnZQXT6sOgf3k83ey
 Hiag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN1RcAoo5DCCQfBTNQsVIqnhDDSe+uYZeR3j6eaEG5Wx47LCuBiV+v0MhDC5CEUHvvMa8aOS8=@lists.denx.de
X-Gm-Message-State: AOJu0YxghGXNeaJCRsElUXAGDzRIk0mszBnnbCbUq1Nxme8jp880Ih1v
 cNWVJetB42+et5ci0CfeAFWIc6pAt76O3Wgstsdag829ROSiVvyMsm5LQ3FP/Sc=
X-Gm-Gg: ASbGncsW/I6scMwpf+0ntukmv2LQEsD0ZMKkPMagwj8zllQ7RnyFsL8Jwpq62qJzzZw
 R6nBd5sUa44pj9c3gzdBCFWRUbfKkgKKg8dJ+KVbja7Y3oevzfYWjEr+3+KzSHYykEo6SCWOV3j
 kOhbK0Ul4uUPW5QnbOWaT3RfZvwRE6onfq7jZsq/Tm313Yqyw7lERFwunCOKASZEcibtI8ggJGG
 1wxEMAQbcnUVFG2XEh/Li0bZIGgZJEuWenoQWidu9PcsbYkIjwBQGMfg0QkgvAaPMXO+ycyBXv+
 k6mi4HvRNJDcHU6RYr2NqKaY+EzuFNfTv9ymOao=
X-Google-Smtp-Source: AGHT+IGGvXivHfqfZ3yTKHHut4mLq1rM90X3zJZagjl2fGxrDn9VvpjxZH+bUkiYJfkbV3fTxO9hIA==
X-Received: by 2002:a17:907:3f93:b0:aae:ece4:6007 with SMTP id
 a640c23a62f3a-ab2ab70b071mr218652566b.59.1736343544985; 
 Wed, 08 Jan 2025 05:39:04 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aaf6afc3e11sm1079194766b.73.2025.01.08.05.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 05:39:04 -0800 (PST)
Message-ID: <39dcdeba-0314-4008-987d-306b63c3d0ea@linaro.org>
Date: Wed, 8 Jan 2025 14:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
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



On 07/01/2025 16:47, Heinrich Schuchardt wrote:
> On 07.01.25 16:11, Tom Rini wrote:
>> On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> wrote:
>>>>
>>>> On 07.01.25 13:15, Simon Glass wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt
>>>>> <xypron.glpk@gmx.de> wrote:
>>>>>>
>>>>>> On 06.01.25 15:47, Simon Glass wrote:
>>>>>>> This test was hamstrung in code review so this series is an
>>>>>>> attempt to
>>>>>>> complete the intended functionality:
>>>>>>>
>>>>>>> - Check memory allocations look correct
>>>>>>> - Check that exit-boot-services removes active-DMA devices
>>>>>>> - Check that the bootflow is still present after testapp finishes
>>>>>>>
>>>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() and
>>>>>>> still
>>>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would
>>>>>>> be to
>>>>>>> call the bootm function instead, with suitable modifications.
>>>>>>> That would
>>>>>>> allow bootstage to work too.
>>>>>>>
>>>>>>> This series is based on sjg/master since the EFI logging was
>>>>>>> rejected so
>>>>>>> far.
>>>>>>
>>>>>> Yes, it was rejected because a solution at the lib/log.c level
>>>>>> would be
>>>>>> more generic.
>>>>>
>>>>> As I mentioned, that idea isn't suitable for programmatic use.
>>>>
>>>> What can be done with show_addr("mem", rec->memory); that log_debug()
>>>> does not offer or which you could not do with a new log function in
>>>> lib/log.c that takes variadic arguments?
>>>
>>> There are asserts in [1], for example. How do you propose to handle
>>> that? See [2] for my previous explanation, quoted here:
>>>
>>>> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
>>>> to programmatically scan text...plus only the external call sites are
>>>> actually logged.
>>>
>>> Also see the discussion on the original patch [3]. There was also your
>>> reply at [4], but I think you missed that this is intended for use in
>>> unit tests (i.e. with ut_assert()).
>>>
>>> You also requested that this be generalised, rather than being
>>> EFI-loader-specific. I have no objection to that, but don't have a use
>>> case for it yet, so have deferred that to later. It's a fairly simple
>>> change, if/when needed. If the series was not NAKed, I'd be happy to
>>> do it now.
>>>
>>>>>
>>>>>>
>>>>>> Tom suggested not to send patches that are for private enjoyment
>>>>>> to the
>>>>>> mailing list.
>>>>>
>>>>> My contributions to U-Boot are only ever about private enjoyment :-)
>>>>>
>>>>> Do you have any comments on the patches?
>>>
>>> Regards,
>>> Simon
>>>
>>> [1] https://patchwork.ozlabs.org/project/uboot/
>>> patch/20250106144755.3054780-6-sjg@chromium.org/
>>> [2] https://lore.kernel.org/u-boot/
>>> CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com/
>>> [3] https://lore.kernel.org/u-boot/
>>> CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
>>> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-
>>> B11F-85958065BCD2@gmx.de/
>>
>> Looking at the logging portions of the original series again, especially
>> if this was made generic, we probably don't want to print to actual
>> console every time we're making a note of some memory allocation for
>> example, that would be unreadable outside of a debug context. The point
>> of this really seems to be "log things for verifying in tests later".
>> Does that end up being useful? I don't know. Heinrich or Ilias, do the
>> tests in [1] look generally useful?
>>
> 
> The tests in [1] are not documented, not even in the commit message. So
> the reasoning behind the tests remains Simon's secret.
> 
> At first sight the tests in [1] don't make much sense. E.g. that only a
> subset of memory types have been used does not tell that the right
> memory type has been used for the right object.
> 
> Implementing a specific tracing functionality for EFI is definitively
> the wrong way forward as it will lead to code duplication.
> 
> We already have function _log() which is variadic.
> 
> Simon could write a new log driver that parses the `format` parameter
> and saves the binary data in an appropriate format for analysis by the
> unit tests:

Isn't this precisely what monkeypatching is for in unit tests? imho this
does not make sense as a logging API but expanding FTRACE to have more
capabilities (like Linux trace has) so that it can save arguments and
then having some nice interface to assert that certain functions were
called in a certain order with certain arguments would be a scalable way
to go (and surely useful in other cases too).

Honestly though it seems quite wrong for the bootflow test to inspect
EFI memory allocations, these are completely different levels of API and
any tests like this are going to be prone to breaking over time just
because they're making assumptions across so many layers.

Kind regards,
> 
> * For %s the driver should save the string and not the address of the
> string.
> * For %pD the driver should save the device path instead of the pointer.
> * ...
> 
> Some changes to the log driver interface will be needed to pass the
> variadic arguments instead of the formatted message.
> 
> Best regards
> 
> Heinrich

-- 
// Caleb (they/them)

