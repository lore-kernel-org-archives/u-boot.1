Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4128CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320EC82C84;
	Mon, 20 Oct 2025 17:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yu3Z067H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993A783642; Mon, 20 Oct 2025 17:30:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F93807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso32504795e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760974202; x=1761579002; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lj0gnR7EeSYcxeYprYYb5/8hWRbM6OoyNZ/0ZkKfvlw=;
 b=Yu3Z067HhTdPQBUUGLuuOEf8cnFR7fmSL9aqT6BWC3qbHUdj6wUfK1bCQXLMCKru/J
 W6VjfH41QGatcGLruCQ3QNjtriCvjiUmOE1ZiktkfGsYXGUJl5scLr4fb5oezUvpduRH
 sK3EGvAuca9ssWvVV68qzH9Dyc3GKih26CWMf1ArCWpy39mfs3SmUUtV9xu8WlPday5v
 Fnd5hIyINpanfZDBsJJQ+MNt0OjC5EdVY0+7nuirgIlZKVwWFADEGTisa+DFALmtJCv1
 aV2QSbfCyEbLrKlIhqNULrti1r9vtEAzZ1PHfhQMiqGWMNnCY3MhLhrI8vIPCWXQE2if
 tyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760974202; x=1761579002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lj0gnR7EeSYcxeYprYYb5/8hWRbM6OoyNZ/0ZkKfvlw=;
 b=doNg9+GJ/lUnKf0hHyN//114oPFdgVd49xhLSIx1c3b7DGJn9JwmVKVxw3q2Yy3u93
 05EzxgiWYB0XiwFRYJ3WZPMZhBTl7uS+v0psTDzCzgvt9pnhkNQBboyoYHb6/TUkmFuN
 RuuWVDNVnqasID6Go2LqPrELvih+NSHt572/oM1NzjjBhuU/GaW+0F6Wr8VRDIjpL3Yi
 kg/IM6wwu3RazwKwtXhTfLNLurfp+Kjk5nMhnCxBlCE2sxV/7CzJI/SazVaMDsvTclcD
 micgZpBt0rLJPz6nJndubF/udt/15dOJrtb8oAOUT5AxKHengBQzHhiSvAAgxsZLbSXL
 MkcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsHGN+By6rLlCFpU9KAzkWsTDCZtZrGTQYg0bqD4GlYT6IutiMQr4NsPmY/pGPL7nYmCdzexI=@lists.denx.de
X-Gm-Message-State: AOJu0YzrCA3pV10ycwjby7vIQdVitT3yiLRKBHXtlxahrv3BPsQ9Svop
 24x8OzuCXAP17Pspg1iykbA+2agcsWhvZiiaLxpk16wZF5EpkygMJuiNMpvagz2GC2s=
X-Gm-Gg: ASbGncupM9YIos9EnyNvgp9QOOL0vJ9nmWQhqtqwSp62FvGMPoul3bqM0mC6RzbYB2d
 mJEjCXuWhiurE+wAdDafxVndDq+V8W8eUB+GjMP0Ad+iM5Guzncv7quyJikS6xmRCoZ9EbxWvyW
 CwnXSGgv3yoUgJPvQePpyy9lGG0eDtV3TvhmzXC0G1caW9yFhO8+UfMMQYQpJFEWB5eAhY+giXM
 +a0NWIJlCGZJHEA/0OJahLd0ETwdR0euM+biZOqg3SVrR3M40Y7tF7cUlE6BZOhUNjJUXLTYFlR
 5/zzUguwXT+f2k8UxKTQWY04BwWCxclbt1BkD2h4DhYbVt+PJLw9rF/iUuHwOtFfBrFdNLvAJHs
 df1XlhymDfQCwens9LwoX0YN5Ow1RR8VLW5tRkQzNt8nqU13rvOc2+vwPA6F6XdQFwNVemVal+9
 Nx7WYtaH9U1FCDwWK8Owm0VQXXKP43w3Nj+KdXvOz/k75E0klivVgYl7TvTjycN1cK0A==
X-Google-Smtp-Source: AGHT+IFFUnN3WgdffMd8HEvGXhiZ6TWlM4ZNQEvjaoNlH2PvOUuP8400b6B1khzW4QVyolIx3VYGeg==
X-Received: by 2002:a05:600c:6290:b0:46e:2cfe:971c with SMTP id
 5b1f17b1804b1-471177c0f91mr99349155e9.0.1760974202540; 
 Mon, 20 Oct 2025 08:30:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:d996:1608:d8ca:d6e0?
 ([2a0a:ef40:fed:4601:d996:1608:d8ca:d6e0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47154d382d8sm153429155e9.12.2025.10.20.08.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:30:01 -0700 (PDT)
Message-ID: <9d3cc3ff-a064-4dc0-a73b-0edf1bb8a582@linaro.org>
Date: Mon, 20 Oct 2025 16:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] clk: rockchip: Remove negative error returns from
 clk_get_rate
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
 <aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.se>
 <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
 <20251020142307.GU6688@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251020142307.GU6688@bill-the-cat>
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



On 20/10/2025 15:23, Tom Rini wrote:
> On Mon, Oct 20, 2025 at 01:03:15PM +0100, Andrew Goodbody wrote:
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
>> OK, so here we have a question and it is one that I wish had come up in the
>> original discussion. IS_ERR_VALUE() and other related macros are from
>> include/linux/err.h and are introduced with this comment
>>
>> /*
>>   * Kernel pointers have redundant information, so we can use a
>>   * scheme where we can return either an error code or a dentry
>>   * pointer with the same return value.
>>   *
>>   * This should be a per-architecture thing, to allow different
>>   * error and pointer decisions.
>>   */
>>
>> So they are clearly intended to be unambiguous and used to add information
>> about errors into kernel pointers. It also suggests that there may be other
>> implementations of these macros for other architectures.
>>
>> Much of the error checking of the return value from clk_get_rate() is done
>> with IS_ERR_VALUE() despite the return value not being a kernel pointer and
>> with this default implementation it does happen to work just as long as your
>> clock rate does not collide with an error. OK collisions are very unlikely
>> but it does still feel like an abuse of the macro to me.
>>
>> Is there any official guidance on this use of IS_ERR_VALUE()?
> 
> We don't have any, really. So my question is, given the use case Jonas
> outlined (thanks!), what do you see as a good way to handle this?

I would hesitate to call it good as it still seems wrong to me to pass a 
negative error as an unsigned return value, but given the push back I 
guess the pragmatic thing to do here is accept the use of IS_ERR_VALUE() 
and that clk_get_rate() will be limited to < (ULONG_MAX - 4095). We can 
drop the current series and I will take another look over the code to 
see where there still may be needed some fixes.

Andrew
