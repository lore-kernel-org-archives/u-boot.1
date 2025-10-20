Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE7CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB35831D6;
	Mon, 20 Oct 2025 14:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tvea2osr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B672F807B1; Mon, 20 Oct 2025 14:03:20 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB67807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so45263395e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760961798; x=1761566598; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+spDjSUAnYkDmb7cEeUnsKrZSjlPJr9n15buWWyQsCw=;
 b=tvea2osr/1GbqeudbSCMspVFqtRXX1dsDatU9PQ38TKglvh7aFkRiNV3rnbAH501jx
 2lu+QJx/MVA9btOq6Yf0kR76O1nDLRGyhfK+lzi6R93xVJEgKQZ2B5tVxYyROYYhwJM1
 n5OQkpCDSKEgQd0ceqsNTGH+hiMhJhIqZ5RR8jJr2qmCcl6mXpkv6LEuHXA91WSYJPQG
 WiHNpiVb2813cUNFpXzMcrZNocAwCoPJLo9qemdcKimxkR8AQIml82sf3R61cz7y1TPM
 6xD71zbXSrGou6EBS0zHd7ewjovymOOjn5IbEqKbhhQhhX/Kt1VVYPkVl85dROw0NcKv
 IXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760961798; x=1761566598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+spDjSUAnYkDmb7cEeUnsKrZSjlPJr9n15buWWyQsCw=;
 b=w6kagoFn8pNm5Q6+6uBRyZt81iIrmOeH13lMp5qyj2QSbiRY5nqC6slf+M3/vUmF3Q
 wqWzZnbwOZbHyntRf+EQe0tIknZOchG+/pu3fS2ilOhHQZbbLgiAZSmFYy/QoVYa8nKL
 sf3TzBvwOCcivGQ8w/LzkAaI6R5xAQ0sSKEheauas78Y/E6n6Y0ma6Vs7V7uegCexn1M
 ycR3QSrWwLMRS6g/uz/OnuJuk7EHOX7AtqL4AE/GQh9FITVCkoENq1EIk4/ZZ3QhxJnN
 ScS0TPBKknrjOL+4cRmMW+9FfzyMFsvEqt1WrbG2CQSvEiRpvUjm1Kek8Fzm8268ARj3
 dZsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmxjX5J5sakwKVCNBMUhjXje3uPGsMKrt1e7Z5qBTrttGkX3UwvPZ0qbO1oSUuSgxS6L12Zl8=@lists.denx.de
X-Gm-Message-State: AOJu0YzcbDwhTFxr8V5AZRnl6DBKgw02uhzFrNaxo0/NR6kMDhT0PpHB
 QQxrHl06oGHvL3Z+dqLVIK55O8ViXVDEon3Lgh2H5577R7p4yRmv9povvb9RNumnSHA=
X-Gm-Gg: ASbGncs9jitLpsINv0eJPneZDqmO0RKWRN03IMs090iS2TyNQU4LXGFl43N+qDFg8xx
 3XqoOY3aIV9cI0N7Fair9jYu8/9SZMzmaFQAi4kxEKamLlFe4FWmofWuVNK+GZ5RibfrU0+UcIz
 yJ6GjIHAUieqapEpLEpNmscqlhU9eQBIBy36gSc2kB3Kb8LTUQDe70n0vOIkcWP6lHkufu5Hk77
 cgbvduM00C+eJoZYckZkGe/ozoWgNIMxHJdXKhNuP3IY/T234G0SslFu+SFQx9YYOr20uqdIh14
 mI8X6+fb8+FJ5wxiS0zuJPD2nO9qI0AtCm3pVgpF1ctBJcMzRrOTsBgCid+9KxI3oQHnah+pA5F
 H/rWnBmi9Tn9/3EHdMfwIJX+8I61wrdaeGI12anKw64+vtQpKUTKvdkfMu2xTY2HCM2Vq7VsHfR
 t3ctjp4ChoZ7UBCp+gAVhotoLSOqHXVarKmr3xlJpQGIbgVDuWLHoT1w2AHknRNJnCm4rJW1Ada
 KlK
X-Google-Smtp-Source: AGHT+IFE6z3DN2PrjEfu6uFx4uyD0I39Lb0CupMXJcYp72ncoMPbRB6JrNeEwBAukwUyGd/ctoF/Iw==
X-Received: by 2002:a05:6000:310e:b0:425:73c9:7159 with SMTP id
 ffacd0b85a97d-42704d96566mr9134665f8f.33.1760961798034; 
 Mon, 20 Oct 2025 05:03:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:d996:1608:d8ca:d6e0?
 ([2a0a:ef40:fed:4601:d996:1608:d8ca:d6e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b985esm15558900f8f.34.2025.10.20.05.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 05:03:17 -0700 (PDT)
Message-ID: <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
Date: Mon, 20 Oct 2025 13:03:15 +0100
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
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.se>
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

On 19/10/2025 21:28, Jonas Karlman wrote:
> Hi Andrew,
> 
> On 10/15/2025 4:32 PM, Andrew Goodbody wrote:
>> clk_get_rate() returns a ulong so do not attempt to pass negative error
>> codes through it.
> 
> On Rockchip the clk drivers only implement support for a subset of all
> clocks supported by the hardware, mostly to save space for TPL/SPL and
> not having to implement logic for clocks not really needed by U-Boot.
> 
> Because support for all clocks is not implemented the existing working
> error handling actually help us catch clock issues on the Rockchip
> platform. E.g. when a clk is referenced by assigned-clock-rates in DT we
> get an error and can fix the issue, or decide if we can safely ignore
> setting the clk rate.
> 
> I do not understand why you need to change the way the clk ops work,
> just check with IS_ERR_VALUE() inside the clk-uclass or similar if you
> really must remove working error handling from the callers.

OK, so here we have a question and it is one that I wish had come up in 
the original discussion. IS_ERR_VALUE() and other related macros are 
from include/linux/err.h and are introduced with this comment

/*
  * Kernel pointers have redundant information, so we can use a
  * scheme where we can return either an error code or a dentry
  * pointer with the same return value.
  *
  * This should be a per-architecture thing, to allow different
  * error and pointer decisions.
  */

So they are clearly intended to be unambiguous and used to add 
information about errors into kernel pointers. It also suggests that 
there may be other implementations of these macros for other architectures.

Much of the error checking of the return value from clk_get_rate() is 
done with IS_ERR_VALUE() despite the return value not being a kernel 
pointer and with this default implementation it does happen to work just 
as long as your clock rate does not collide with an error. OK collisions 
are very unlikely but it does still feel like an abuse of the macro to me.

Is there any official guidance on this use of IS_ERR_VALUE()?

Andrew

> The current working clk error handling has really helped me time and
> time again on Rockchip platform during soc and board bring-up.
> 
> This is a NAK for me without first having a proper replacement for all
> existing working error handling that is just being left ignored after
> this patch/series.
> 
> Regards,
> Jonas
> 
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/clk/rockchip/clk_px30.c   | 24 +++++++--------
>>   drivers/clk/rockchip/clk_rk3036.c |  2 +-
>>   drivers/clk/rockchip/clk_rk3066.c |  8 ++---
>>   drivers/clk/rockchip/clk_rk3128.c |  6 ++--
>>   drivers/clk/rockchip/clk_rk3188.c |  6 ++--
>>   drivers/clk/rockchip/clk_rk322x.c |  4 +--
>>   drivers/clk/rockchip/clk_rk3288.c |  6 ++--
>>   drivers/clk/rockchip/clk_rk3308.c | 26 ++++++++--------
>>   drivers/clk/rockchip/clk_rk3328.c |  6 ++--
>>   drivers/clk/rockchip/clk_rk3368.c |  8 ++---
>>   drivers/clk/rockchip/clk_rk3399.c | 12 ++++----
>>   drivers/clk/rockchip/clk_rk3528.c | 20 ++++++-------
>>   drivers/clk/rockchip/clk_rk3568.c | 62 +++++++++++++++++++--------------------
>>   drivers/clk/rockchip/clk_rk3576.c | 36 +++++++++++------------
>>   drivers/clk/rockchip/clk_rk3588.c | 32 ++++++++++----------
>>   drivers/clk/rockchip/clk_rv1108.c |  4 +--
>>   drivers/clk/rockchip/clk_rv1126.c | 52 ++++++++++++++++----------------
>>   17 files changed, 157 insertions(+), 157 deletions(-)

