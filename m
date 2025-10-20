Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AE9CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF9C82E34;
	Mon, 20 Oct 2025 17:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s0E108Yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA39831D6; Mon, 20 Oct 2025 17:57:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED5D982C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4710683a644so40703785e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760975844; x=1761580644; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPQUVlHk0UZh0PZ21j0rBpnd1GrZl8XThoew+1wiwD4=;
 b=s0E108YqJyq1ewtZPrlqR2DbcSPxbUiReCx6LXqY342TZEP7OI+2CTUX9cGmHdTfyH
 HYbn7L7zqGvfm/Xwh0mjA8AyortzI880Mhaf08knXVOQriuGz+Y+nhsoi0Xp8na93J2O
 TJMHdCY/fsJOKcMmLf8CSAgoi5+cb3RXTtqSUew62LmS9LQv7ni2QWBy2mHOozWayPSb
 70JpEnEruW1wzay17xzr4eg5U5CqwOAXxact7uSHXE4CXQy9Sy6HvImjrbHD7OFcRyLD
 /ZadNZiKhDzIXfqD8yclaU8BPmRJey5YwfHeElkIqGsKpf2E0TGgBTfTwX1P+qTFzMG6
 AIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760975844; x=1761580644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPQUVlHk0UZh0PZ21j0rBpnd1GrZl8XThoew+1wiwD4=;
 b=qHAba+nslH2D/Fm4LBjUEVSoZAtBOZ3G/D1iPi0oFMCsYZ2DfcoI6Y8Xi74H9ZIwUm
 9shA3bNopEqR3vOPLw7w/m1jqUuB0BkYNYplQ+orUyeGRf2uo5QbpVjXn9fe58KkTncN
 VGcI4HDNkIFGrZ1wl53G8VtDncCTeINai6uP9XoU8+k8kftepilJcZK6Oy9U/0jM/7IU
 0kOPkBsAJrvSJKxO6Gq6iW4rvZ08j1kNQ0d+9cPnGEod+aw7PJ6kaHngUtyV2DA5Zjs5
 FpGT0Vi9CsL41iJs3dVJuUlIvuaHt8Yv+y/LkC7j/ppiu4p6F3zFFcEe8E+acz94YPpJ
 KTng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIobgJ5mBi68tQgmD6gYXqCb6O8U5JEoIlQevesYFsAY4tVADN4j9pgEEnSpJzGj8bvXhVrl8=@lists.denx.de
X-Gm-Message-State: AOJu0YxZUnniqinCWWz8AD7uJZM8eUB7goFme6a/cNCPIS2JqdKXsha7
 rM4VkyxBUDZJD0FOoVMDGodJEXEGGtCHdUZ16EvaVg+i7s40ziqx2WKSSTLd+adZRng=
X-Gm-Gg: ASbGncu8DK9vuD3FgGUWz2bO0sHvwAjfElMp8WyZTDN0J4+3V6Yo5vWIb9tghFSS6IT
 bH2NGRsApO7RGve+XZinhDoRgCMKM6T5Swln8gJqFlvN5Fz/fCh3WETp0bBAEeasN82uQGWia1v
 jvsnenJTxFyX0w7KMEpaLPMlxu33ElnfZheoOtXAzYWI6ql+5pRLkcr6ouainmjgvvGc9WLSlWs
 gZhUw2RNGNZCJAvWtjNeJjDjVlCLBhRCRBUnHKCBweu/Phf8P6uQfV90p9ZREr0fIcLmQrc6Hul
 mzrlKo0N6UOXM2eEFumGrh1hVoPoMhirvNXZIMSk+evkBffFxiQUXKKxOdQ8yqawm+HNVdaRvur
 GxbtQIR37HrEp9EWseQxxBzxpbQLZUFebOn+QJTNPH48/86F+Oe6zfk2QHEKewmnO7YEiA6rG2N
 fzUmZtcZjgAVoj6bKBra/GQ2i1wY5toLs2655+EpK/C5mT5Um7WDahjt5cSka6jQfAZg==
X-Google-Smtp-Source: AGHT+IG72iKO47Rw50XJ7A4tjlncnQr6Z0uXDEWy9msL21jowEK7HugBy/j6I4HCX3dBs20mYZYCIg==
X-Received: by 2002:a05:600d:8283:b0:46e:74bb:6bd with SMTP id
 5b1f17b1804b1-471098fe502mr87127785e9.4.1760975844346; 
 Mon, 20 Oct 2025 08:57:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:d996:1608:d8ca:d6e0?
 ([2a0a:ef40:fed:4601:d996:1608:d8ca:d6e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c56sm16230515f8f.18.2025.10.20.08.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:57:23 -0700 (PDT)
Message-ID: <bcf0e68a-fdb3-41f2-9157-994486f5c75c@linaro.org>
Date: Mon, 20 Oct 2025 16:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] clk: rockchip: Remove negative error returns from
 clk_get_rate
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
 <aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.se>
 <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
 <ba095360-147b-4c22-b2fa-8a3c17000381@kwiboo.se>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <ba095360-147b-4c22-b2fa-8a3c17000381@kwiboo.se>
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

On 20/10/2025 16:03, Jonas Karlman wrote:
> Hi Andrew,
> 
> On 10/20/2025 2:03 PM, Andrew Goodbody wrote:
>> On 19/10/2025 21:28, Jonas Karlman wrote:
>>> Hi Andrew,
>>>
>>> On 10/15/2025 4:32 PM, Andrew Goodbody wrote:
>>>> clk_get_rate() returns a ulong so do not attempt to pass negative error
>>>> codes through it.
>>>
>>> On Rockchip the clk drivers only implement support for a subset of all
>>> clocks supported by the hardware, mostly to save space for TPL/SPL and
>>> not having to implement logic for clocks not really needed by U-Boot.
>>>
>>> Because support for all clocks is not implemented the existing working
>>> error handling actually help us catch clock issues on the Rockchip
>>> platform. E.g. when a clk is referenced by assigned-clock-rates in DT we
>>> get an error and can fix the issue, or decide if we can safely ignore
>>> setting the clk rate.
>>>
>>> I do not understand why you need to change the way the clk ops work,
>>> just check with IS_ERR_VALUE() inside the clk-uclass or similar if you
>>> really must remove working error handling from the callers.
>>
>> OK, so here we have a question and it is one that I wish had come up in
>> the original discussion. IS_ERR_VALUE() and other related macros are
>> from include/linux/err.h and are introduced with this comment
> 
> I have no idea what the original discussion this relates to.

https://lore.kernel.org/u-boot/f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org/

Andrew

> In U-Boot most/all? uclass functions is documented to return >= 0 on
> success and -ve on error, I do not really see a reason why clk funcs
> should be changed away from this documented behavior.
> 
>>
>> /*
>>    * Kernel pointers have redundant information, so we can use a
>>    * scheme where we can return either an error code or a dentry
>>    * pointer with the same return value.
>>    *
>>    * This should be a per-architecture thing, to allow different
>>    * error and pointer decisions.
>>    */
>>
>> So they are clearly intended to be unambiguous and used to add
>> information about errors into kernel pointers. It also suggests that
>> there may be other implementations of these macros for other architectures.
>>
>> Much of the error checking of the return value from clk_get_rate() is
>> done with IS_ERR_VALUE() despite the return value not being a kernel
>> pointer and with this default implementation it does happen to work just
>> as long as your clock rate does not collide with an error. OK collisions
>> are very unlikely but it does still feel like an abuse of the macro to me.
> 
> The U-Boot documentation for clk_get_rate() clearly state that we should
> use -ve error code for errors. And the safest way to test for error
> codes will be to use something like IS_ERR_VALUE(), so why should we not use it as
> it does the job very well?
> 
> Also for Rockchip the clock rates do not really collide with error codes
> as the typical max clock rate go up to 2-3 GHz, and in U-Boot we
> typically only reference clocks with less than 1 GHz rates.
> 
> /**
>   * clk_get_rate() - Get current clock rate.
>   * @clk:	A clock struct that was previously successfully requested by
>   *		clk_request/get_by_*().
>   *
>   * Return: clock rate in Hz on success, 0 for invalid clock, or -ve error code
>   *	   for other errors.
>   */
> 
> To me this patch/series just look to break this documented and working
> error handling without any justified benefit or replacement.
> 
> Regards,
> Jonas
> 
>>
>> Is there any official guidance on this use of IS_ERR_VALUE()?
>>
>> Andrew
>>
>>> The current working clk error handling has really helped me time and
>>> time again on Rockchip platform during soc and board bring-up.
>>>
>>> This is a NAK for me without first having a proper replacement for all
>>> existing working error handling that is just being left ignored after
>>> this patch/series.
>>>
>>> Regards,
>>> Jonas

