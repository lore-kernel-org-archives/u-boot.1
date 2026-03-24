Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13002E9A779
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 12:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85C0E839A8;
	Tue, 24 Mar 2026 13:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tPyWVJCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C2E839DF; Tue, 24 Mar 2026 13:10:10 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6B283981
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 13:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so43452215e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774354206; x=1774959006; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmtVBnVV5lUHBPmKe/jEOrqiciqOkU0YsH6msKciMOY=;
 b=tPyWVJCG6pZf8ccFGGhhDsyDMhDHAeWlpiWGRcKxA8rm3+gbesFsmvBHE90xBjOdEW
 GTfom3uC6exYKQMrPFl1K6Rxx/mgeWKSlHzDzrJ01Z+5lSsN/Sms4ta6MjGopMh1gG7c
 lryga5N3/Ur9sGHWRqWchP7rylc4DWnnV1RfNctMQjvPxSx4yxZ9BRW6HfOfYD70YRQ/
 y+R9qktrYSwvfRcKLnKDgGiErrITIsKCX9kJzWy/aZABsY376CnM8V9AbJgkw3Y5cSbA
 PmK61d92WrAxnKBcYtMJYW/Npd6lW76SfIDXQYXCx86ikymW4kBtP9uJiVdluczRVdIz
 RHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774354206; x=1774959006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmtVBnVV5lUHBPmKe/jEOrqiciqOkU0YsH6msKciMOY=;
 b=CiOAvJO4XxD2AEV1wB9YzNZUE1c7GIZVM/NAIdrc0hBvlxiMz8N/c8Z5HfSUEuD1u5
 s9wdLtzzCwcgtwIjlJfLNAkSJbUiufodLEVLHWXPPdI6sb4aclns6a0vG+1PbbSCzje2
 QkrddkBF3ZUYPmTBktJBDtVeyyIY+A7r/T23W7QwAPqp8HrUMJrNRvEW731C2PmRfwKm
 kR1Q8bZm28LUackgLug104cW4zwJ0k8ByWeFgA1ETz39g2Po0RB3QjlqrFWvR4zJjxwy
 OA0oWkHvfFBc4YVsVMHp+FJF9gHko9TqW/uAnlOFF5sDQ4DfNUrT9T5vfREt8bsxqs3L
 ZrWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTOsaUc2FlSi561cLLkAo+yrzdaTi0R1FsDXuQ+g95fLkH3Clcu3XgTI+F+ddTBJ0IanUZCI0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx027FIyoRgzAcwfjZLjUWhk1jmsnQeunvPNXNENWXhT+LcN+4t
 GPVgL4lLKhgVqYs/nSyGxrD8wWAQBFwA9rie/qufku4R5xrbQfJ9B3kMnqMufCMHctI=
X-Gm-Gg: ATEYQzyNuaHQBwPMX5EhzLIP23a6kXgMchDLhXNdtn8l8fr5KTC1O++N3dwRJ9XCxfZ
 pU3IxWdHyyHkgH/m4WMKH11vB3Jl5UNoemfwcnqosh4xZIkUGlNAHEM5MCYZdqamtX2SgAoflDW
 4IScNjcBoYoFHQb5BOhfvO0U8RGo6wdFsejRhkcKiX8l/+1jNW2OyY2lKcndfWkEYMNalbV/KqE
 h5YTq3/hIr0vkiRUV/jOHqiIsit5oG+0dHokY9PIjRjQFY+/ByzqbGjUQ+GVXNusOSAjUXGb8t8
 TE8PB28gr2VKL9TgAfklALpcBhXZKrzrG4sumr46BxFWZG7qoodZCgLl9tYYiUZw7m9mFuM3rER
 Q2TXgzidlCfinrW9p6d5L0sj9GwpNDTbo540aGi0631yORLBUjQqIwRetqQEE2mVDKFMvpZ9b7B
 xSYCOcVWaKLmYeqDD86RXHm30CoNkvsGtps+hqSYgR8WseFHSFncB7E3eRCv+Z0iU=
X-Received: by 2002:a05:600c:4705:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-486fee04f94mr211195875e9.19.1774354206011; 
 Tue, 24 Mar 2026 05:10:06 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4870f66fb13sm34645605e9.0.2026.03.24.05.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 05:10:05 -0700 (PDT)
Message-ID: <bdc10c1d-0235-4b07-a62a-004d61643f9a@linaro.org>
Date: Tue, 24 Mar 2026 13:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <6f12cae7-1dd3-4367-83d0-d35624dbfa4d@linaro.org>
 <6e74bf04-c05a-4628-8f50-b6d55a2af285@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <6e74bf04-c05a-4628-8f50-b6d55a2af285@mailbox.org>
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



On 09/02/2026 21:44, Marek Vasut wrote:
> On 2/9/26 7:45 PM, Casey Connolly wrote:
> 
> Hello Casey,
> 
>>> Which means, before we can really start switching boards to relocate to
>>> 64bit space, we need to find all these remaining 32bit limitation sites
>>> and fix them first. And to do that, we would need some way to force
>>> allocation from 32bit space for drivers which need that ... do we
>>> already have such a thing ? I couldn't find anything.
>>
>> For some (non-upstream) Qualcomm drivers we have just used lmb with
>> LMB_ALLOC_MAX and passed in 4GB as the max address, it would be nice to
>> have a wrapper function for this.
>>
>> Maybe this would just cause a whole bunch of other issues but perhaps it
>> would be easiest to have a config option to place the malloc arena in
>> 32-bit memory rather than always directly below U-Boot? Then again I
>> imagine this is something that has been bikeshed in the past...
> 
> Are those qualcomm devices suffering from 32bit DMA limitation too ?

Yeah, this is how we handle allocating the framebuffer for
not-yet-upstream display support.

Would it be possible to use SMMU TLBs to allow (most) 32-bit-only
peripherals to access 64-bit addresses?

> 
>> *casey grumbles something about making relocation optional and merging
>> the f/r init sequences for most boards*
> 
> Can you try CONFIG_SKIP_RELOCATE for your use case ?

That works fine, I'm mostly frustrated with the whole pre-reloc FDT
scanning/DM init, lack of dcache, etc... So pretty unrelated issues heh.

-- 
// Casey (she/her)

