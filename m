Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B81CF395B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C69891D1;
	Thu, 19 Sep 2024 17:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FshFciGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9124989221; Thu, 19 Sep 2024 17:05:49 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9854689173
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 313233F45F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726758345;
 bh=uU7TaF4+e+rE9a73a80aL6KTzx8PUW77oPU/f4kHZTE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=FshFciGIyyf3De2k6TU28riWzxuOVeC8dQJX042tWbo6Y3B/5kLs5hMCznQ0S7y3+
 3BFWI8rLsnrxQ4gqGrdsD5NufLwvYnUXsb3VrKMEQs0sq/79m1Ni6S95ZpojsGPoSm
 /1as5LlNrsaRmUlxs4lSOtboHvWPWlBEtKT/2+WCoRjTksMOawIzAKvyQp4xd5X0VK
 Pp4WCFs8PMOl1b1WMvRRk2pCxaBnmxp9Y1KY9WA6HXHBxOAHqWrPzb5Z9gg4xX3in+
 v9fsdYpbnbgXek4A0UJaHHampUuVw7YPK3VaAsApX819eJDjp5wxZCSL4SMbPy+dPK
 vGN57zs/jHNdQ==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5356a05fc7cso1084025e87.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726758344; x=1727363144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uU7TaF4+e+rE9a73a80aL6KTzx8PUW77oPU/f4kHZTE=;
 b=o4ClDYEe2Lvzg6q3PG0MdAj3B93XE3JsJ2iSNm7socm89t3dx4v5pIblJxg3QrClUp
 Sz/vpV8Dnpsi7LE7xc+Ul4LcnGokAbxkamIhpX6oOtz7ObeZ6PzsCP53UnmugLoz0LBT
 ymFRGpPowSInqAOY7lAdbaOHxNpUDowWKKlMx2qo7LPaMo+QIRyjQG6h9ZM65i56KA4C
 TwXKZq7l2LMv9wvY6To61qqujYMBE7K8BG6+HJ36aei1sJtZZ24UhCZpKq2DSexLDPgV
 3WdppNPYW2cV+UQiOMoZGhk8DBi+Ljc7liU7c52ULmGxR5qbbCL+zpv3qnnDF7Xc8xZ3
 oQZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUYA9OZ9gvRkfC5F3hea4balhOjCgWQAisfB4gxkLLHFRN/DU+RV8kQwEwRfKhV+CbZQOflSo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVqEW3nNiZpphwGLMm0nlWGsBL+eyViWwEFaZDdo8T2STqycCw
 RAsSMG1s9+7SggGlB/Q8T99+BvqNZ4Ar7uzzjMHhz8Hh4JDFg5UYoRNPbJucjvdGhvh9K83QNrA
 DVsoHE5T4a7BZ3m1p0V8+OJidFGQXUO5vekrHL7GL7KGj83c1iCx7XpAnLOwc9xPvgPP0Z/rU5O
 jHNQ==
X-Received: by 2002:a05:651c:1549:b0:2f6:4d1b:d9d6 with SMTP id
 38308e7fff4ca-2f791a0d0e9mr151138701fa.25.1726758344254; 
 Thu, 19 Sep 2024 08:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFQ8ZB6hXHSPr9u/amyz3amyj1mKoPAvTmgFjrCiPh6BRvC0romMY609Q06nN5oXYB9Zy3zw==
X-Received: by 2002:a05:651c:1549:b0:2f6:4d1b:d9d6 with SMTP id
 38308e7fff4ca-2f791a0d0e9mr151138321fa.25.1726758343704; 
 Thu, 19 Sep 2024 08:05:43 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7543ac4fsm24000255e9.19.2024.09.19.08.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 08:05:42 -0700 (PDT)
Message-ID: <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
Date: Thu, 19 Sep 2024 17:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
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

On 19.09.24 17:00, Simon Glass wrote:
> Hi,
> 
> On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi all,
>>
>> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> On 19.09.24 16:10, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> For measured be boot we must avoid any volatile values in the device-tree.
>>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>>>>
>>>> Could you explain a bit why this is, and where this is checked?
>>>>>
>>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>>>
>>> Measured boot relies on creating hashes of artifacts and writing these
>>> to TPM. If the hashes don't match the OS will either warn or refuse to
>>> boot. The device-tree is one of the artifacts that are measured.
>>>
>>> If we have random values in /chosen, measured boot will fail.
>>>
>>> When an EFI RNG protocol is provided by the firmware, GRUB and the
>>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
>>
>> There's a comment on top of that function that explains what happens as well.
>> In short the EFI stub does not even look at the KASLR seed and never
>> randomizes the physical placement of the kernel. It only does that
>> when the EFI_RNG protocol is there.
> 
> OK thank you. I suppose I am more just wondering why it got added in
> the first place?

For booting via the legacy Linux entry point adding kaslr-seed allows to 
randomize addresses. QEMU adds rng-seed instead of kaslr-seed.

Best regards

Heinrich

> 
> Regards,
> Simon
> 
> 
>>
>> Regards
>> /Ilias
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>>    include/efi_loader.h          |  2 +-
>>>>>    lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
>>>>>    lib/efi_loader/efi_helper.c   |  2 +-
>>>>>    3 files changed, 12 insertions(+), 7 deletions(-)
>>>>
>>>> [..]
>>>>
>>>> Regards,
>>>> Simon
>>>

