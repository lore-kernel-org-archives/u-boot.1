Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0E4CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 22:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D4883B03;
	Wed,  5 Nov 2025 23:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XImn3G6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56EB083B07; Wed,  5 Nov 2025 23:57:33 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4725C83AD1
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 23:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E6693FBD6
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762383450;
 bh=kIlRsACjAh3CZs3qQS+kVUvVXvbpok5zp0iHhH1GRNY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XImn3G6aGkSLR2jf6uFADiTjQYjTMTqLh+bqZuQl4RImFcWU5xiq1sIohWh5rHvZx
 b0MVWB9YE6KXqYOD997z9+eDd5fLjnzS+jAO22ar+eoh8KVizsCWcrAD8GBBmftIbv
 WHVp3b4l36a3yzRaTYTMZiTVF+IXY+LFN79By64qFXJyKPKOrQNDcKz/+u2i1TmE3u
 V1AAwJ8Du4Pzl1WGiYeBaSoPZMRSBRYgS+xIW9DjVQZVksRBKr4KiigPMtbdtTi8ht
 HeYwJE5C1w/E0tGMJxHLAk56kdc/vzqM7gSDM12wri1A/sHhDNWf5qIYQVMRTEdVsZ
 pEz48b8WKMjpwczG2puk4BynHhxeYId2f5nn7ihi1lnK7pIIqg8bWyOV9Bk/gkot3U
 xt7XB70KdBcE7ZmycmN856krfFhiJEnU/mvem/7BHZCEGcRd/BsW244LiUguta9+mV
 XWosLTd9TGDbvMECnHjc+/Ztqvrm+3LWyGq8lGHTlORtctdxLWAT0BGQUQeKUGX/wY
 JwV/xNdrj8FyegTGQRC3QZK0zwRIZJdbmqBwu6Ze/eCnftlC0KBRcABVuuSGOrwDtH
 Uo8k/BpqjmcaGSdoUMU8V73MmGfUsVd2gLeNtEbuSNkAUFYN1pn2vMbbSryx1XowGo
 haBiHCUil3iycOjX0WK5PTmI=
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-35f62a3c170so2307211fa.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 14:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762383449; x=1762988249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kIlRsACjAh3CZs3qQS+kVUvVXvbpok5zp0iHhH1GRNY=;
 b=SrgXCZAi36304R8PPHZLJZjOkRuXplwCHN2fG3OZ3xUQwyDvBDfMQ101Q+DFKo2vFa
 BT/izCNIuWRg4yvtAY0vyNAE9SRI/Yn5ca8p+mn1/zI3MAmzHXDWjtltgSwYMM8eGXir
 Kx+ErmHje5p7pNvOm9tLKJmvLLMjuMlNOSwBOL/Aun/nCvN60ccg9Dncmt75/Z02WMlW
 iRfIUR1hVqZkEGBOwo0BvWF0u7KU6qQmkjmarNvzZgwaThkPiLROrosY8a7U4ApgnXb4
 7PRBmuQpXFu6DBxNAJwo4rqlEQbVUsdl+0fNd9GCo3Z8muRGyzpV01cDwtjhXbgN3HjZ
 QU/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf1GBrA/tQHk6XxiD4pVaH6fJHa6YPrVTJeC3QQkXI0y1XlWaQEp1/GLtfdyg6y7gwt6Uodwk=@lists.denx.de
X-Gm-Message-State: AOJu0YxsnINKBZ+ZfnDoM4gnKiOxYSLhpX5OZ125awSfF2Pwpw8F1j3O
 fMEPdzMdEWSa6s8FCUoYb5niraJ0TcqpyYS2U6OU93Q9PwrH9f7swJ2+6pNxinCjTr2TWqPHtoH
 u/nKQUtg3vATEM2dV5Jchl0ED8mAOuCWXLXQHGxVTjNj3442S4nupcesj49m/GvIW+5dCIhk=
X-Gm-Gg: ASbGncs/bLauusoogzJBLUky1omm8LOxNuyoYSQTSs0+57ud5Z/raJ5OiSHqxj9xVr1
 g0+GGaVN9cE6jRrH7tPlptMonqr/jH1adRYNXcUL9Axj9ProevlNcV1OwbS3of3toLFkxGj5Etp
 QOvkDoQA6CqzQNGGo3BizV2lpTVsAXHLPQQmDeJg7UlpptQGBDuvmYQX0XV9P9IC95XMUke9mlH
 Q5WuhHt/jqtH14SAcdsz93sSKSDMpZxeGUukLXwCgD8OtbYZhwBQelVfq5Ewd/fDr/FKhLcrBiM
 y7K3lq4cy5pQZbn3uxQ9LwcN3TnmO6Lkq2mV82XaVhw6JI6k7xFnjC4JEluNgstTEk8n9zHkz5v
 6FZKQCf+1LUZH/vJwcNi8O/ktf1V44i0z7+PlQJFnkQBN
X-Received: by 2002:a2e:9ccd:0:b0:378:e0e7:40cc with SMTP id
 38308e7fff4ca-37a513e5962mr11872121fa.19.1762383448987; 
 Wed, 05 Nov 2025 14:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkMkjF5kNaUHMLhOAEr5x9oQLf+423oNjhErifjPKieI7O0Na1JGgFVabAtcHhFsGrrcVXsQ==
X-Received: by 2002:a2e:9ccd:0:b0:378:e0e7:40cc with SMTP id
 38308e7fff4ca-37a513e5962mr11872071fa.19.1762383448546; 
 Wed, 05 Nov 2025 14:57:28 -0800 (PST)
Received: from [172.26.194.12] ([93.94.208.154])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5944a019ef3sm184114e87.32.2025.11.05.14.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 14:57:26 -0800 (PST)
Message-ID: <0a146dc8-f1bd-4a92-ab42-29909da4e7c0@canonical.com>
Date: Wed, 5 Nov 2025 23:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
 <20251105192601.GT6688@bill-the-cat> <20251105193307.GU6688@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105193307.GU6688@bill-the-cat>
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

On 11/5/25 20:33, Tom Rini wrote:
> On Wed, Nov 05, 2025 at 01:26:01PM -0600, Tom Rini wrote:
>> On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:
>>> ARM and RISC-V do not have memory at 0x0.
>>> On X86 interrupt vectors are stored at 0x0.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   test/cmd/fdt.c      | 4 ++++
>>>   test/common/print.c | 8 ++++++--
>>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
>>> index 96a8488e172..6b07999c88f 100644
>>> --- a/test/cmd/fdt.c
>>> +++ b/test/cmd/fdt.c
>>> @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *uts)
>>>   	uint32_t ts;
>>>   	void *buf;
>>>   
>>> +	/* This test requires low writable memory */
>>> +	if (!IS_ENABLED(CONFIG_SANDBOX))
>>> +		return -EAGAIN;
>>> +
>>>   	/* Original source DT */
>>>   	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
>>>   	ts = fdt_totalsize(fdt);
>>
>> In one of those "what is even going on?" moments, just out of context we
>> set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loooking at
>> my logs for am62x_beagleplay_a53 where memory is not at 0x0, this test
>> is currently running and passing. I'm going to fire the platform up and
>> poke now.
>>
>>> diff --git a/test/common/print.c b/test/common/print.c
>>> index 76ee851fe6a..389d6bf4069 100644
>>> --- a/test/common/print.c
>>> +++ b/test/common/print.c
>>
>> These tests are also running and passing on am62x_beagleplay_a53 I see
>> in that same log.
> 
> I'm poking TI folks about this in that it seems like memory is really at
> 0x0 here.
> 
> But with respect to this patch, NAK, we need to figure out how to change
> these tests to run elsewhere rather than disable them on all of the
> platforms they currently run on.
> 

These tests that are not passing on qemu-riscv64_smode_acpi because of 
illegal memory accesses.

Unfortunately Simon has written a lot of tests with the sandbox in mind. 
I agree that it is preferable to make tests more generic.

test/cmd/fdt.c also has issues.

Best regards

Heinrich


