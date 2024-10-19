Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9616FD3E194
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 00:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F241E889DA;
	Sat, 19 Oct 2024 02:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P6YbZWLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD6B88B23; Sat, 19 Oct 2024 02:14:42 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927FA889AE
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 02:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30B104120B
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 00:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729296880;
 bh=HHyjczYIaLbklKeyDEBqtOEQHKyYM4pg/RYYbbHycYw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=P6YbZWLBeA9TwBHIsPYXwfjp3NtLY8hq/ifxl3vTLQBI7yb5DOgWD9ACsKQCza6WH
 G5lG5W7BLmjFZQ0zN0YfLAZVibd/3MQlFtQst372ul7Aty9TBGvX2xhFrkCmkgUf97
 un6oVWcdqjMR4Ba3ekIhu0lCyrL+7xau/ggsXsF2uUOsDhIEULfTJhedByCgwKOHmh
 DGBD0eef0RQy8jpOPjyqmxn+lJQZrKDJB7mwoOSGHP9JHJ9T6dBV5e721RYKFDlCEB
 vFV2MsY3NUtEHANXY0elSJ5FlLvvfto4D7FGK4xeTuYvC2aX/KhzZfIMOx1pC+5W0P
 wD18+g/hrYUXw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso16630465e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729296879; x=1729901679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHyjczYIaLbklKeyDEBqtOEQHKyYM4pg/RYYbbHycYw=;
 b=Qy1eUZEdN1Xyr1KMdVXQMobRWYZucKchepa9k0BOhud30chBF1jz6lCt8sqJcybpo1
 o4RnPscTVEoQHGMFCbMA1ssvdaKPXJ8L17Zvh9y/W2/IBmqHotDLgGOBT9kUn51WxCcP
 40dl1bzJCjykM3JLmm5IYrCB0tzHcSlssUkwjWr589ZhgNVo+n7DXWCcpGULf9xwyz2r
 hunbuCgAdiEKsQsH5Rr4BJ97DbyP7X0FH1DV1rRk0DcraEPPqK/tsU86z472GUUT5WS9
 5pl0Gs8FnzkxRZnAdma8QDqXE8Hcyvk58BuryRkpfdVyDLVhCIfH2P7vSPhwhk/TuYpZ
 trPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvvwcKE5CPpheAOyIwB5KlLCC1qh9UdYZ1HVevHo9AA7jat9ZQZsfobGs5HzhS/vQ+M721qT8=@lists.denx.de
X-Gm-Message-State: AOJu0YznyRtTpBcLKNiHvCYUlAeTOb6nihuVT6vuC7/kIHdUV2nRbey+
 6M7dkmCOvBHC8zyljfo7LzBvPWghbgLPJsrGWaPmqGhPqvjcgF1e8X61r4zfZCHXFYToX5RiSjB
 AbZTNufv1uApStChEmjTNB8H5FLsHGQYpJk9lyunLG51AtGH6oRkN0Zhgkn0i5HAvtbQ=
X-Received: by 2002:a05:600c:3b8c:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4316169a5e7mr32688875e9.25.1729296879597; 
 Fri, 18 Oct 2024 17:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6URjYEdKjPbI2UQDmGdELGW2SSIL7CUqPExy/Wm5ECkGmGPhZtQj0NFITX40TiGjCMb3tWw==
X-Received: by 2002:a05:600c:3b8c:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4316169a5e7mr32688725e9.25.1729296879139; 
 Fri, 18 Oct 2024 17:14:39 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160682586sm36671585e9.1.2024.10.18.17.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 17:14:38 -0700 (PDT)
Message-ID: <215a399c-8efd-4494-ae6a-6bfe4532a16a@canonical.com>
Date: Sat, 19 Oct 2024 02:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 mkorpershoek@baylibre.com, sughosh.ganu@linaro.org, kettenis@openbsd.org,
 u-boot@lists.denx.de
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
 <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
 <875xppggnk.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <875xppggnk.fsf@bloch.sibelius.xs4all.nl>
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

On 10/19/24 01:01, Mark Kettenis wrote:
>> Date: Fri, 18 Oct 2024 19:26:01 +0200
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Hi Heinrich,
> 
>> On 10/18/24 19:21, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> The EFI boot-manager is the default method to boot EFI binaries.
>>>> We should be able to use it on the Sandbox.
>>>>
>>>> * Enable EFI boot-manager bootmethod on the sandbox.
>>>> * Adjust unit tests to reflect the additional boot method.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>> ---
>>>> v2:
>>>>           no changes
>>>> ---
>>>>    arch/sandbox/dts/test.dts |  4 ++++
>>>>    test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>>>>    2 files changed, 21 insertions(+), 11 deletions(-)
>>>
>>> This is better, but I still see this.
>>>
>>> => bootflow scan
>>>        efi_var_to_file() Cannot persist EFI variables without system partition
>>>
>>> Please find a way to get rid of it. I can give some suggestions if you like.
>>>
>>
>> Would you, please, mind providing a rationale why you want this correct
>> message not to be written.
> 
> To me, warning about persisting EFI variables only makes sense if
> you're actually trying to persist an EFI variable.  But all we're
> doing here is scanning for possible bootflows.

The UEFI specification requires to create Boot#### variables which are 
non-volatile.

As the variables have to be non-volatile we try to persist them in a 
file. And the message describes that this fails.

> 
>> I expect the sandbox to behave as any other board and provide warnings
>> when they are adequate.
> 
> The warning doesn't make sense to me on non-sandbox boards either.
> 
> I suspect this is the code that autogenerates EFI Boot options, so
> code that sets Boot#### EFI variables.  But do we really care that we
> can't make those persistent?  The code will just regenerate them upon
> the next boot...

The same warning is written for any variable that cannot be persisted, 
e.g. for the Boot#### variables that you create manually.

Persisting auto-generated Boot#### makes sense as you may refer to these 
in the BootOrder or BootNext variables.

Best regards

Heinrich
