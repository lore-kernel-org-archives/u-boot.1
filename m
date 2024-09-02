Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A3BCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D47188B49;
	Mon,  2 Sep 2024 17:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SA/WLGqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C3888B4B; Mon,  2 Sep 2024 17:13:02 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8D788AD3
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so469492966b.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725289980; x=1725894780; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84ytfQkAptZIZoQjKCbMfyRWOmvktaEuFcbB61eiT7E=;
 b=SA/WLGqDnkUZzUoBAi/mosazvCb2a9ErbLVhzDzwatkf+YAZTJtxZQybmYFwxMG4km
 MUff//556JOlPmCsbrESkGdhHYlRKmu8m88Tck+3eG18TueTHON6I3kKMQ69P/zBrJcG
 r1F9BF+gYLZNU2QvvqJ18gLNLWIt/2GIgy+e/XwjrY13IDBYw3CM2SndZWTOaSMK8OV/
 UNDj0pjLiSf4D7v3RcfxmxOdGwJXHSPh1ogVXTRW5EusF1V5Fitm5c7QZvzIeQ0n+YAU
 UOKjPErPKj5ewd+b8DR9LDYWWd/4vBteNvFDiQn8MKCvhtxWcUFGl1HukZKq1wLVxWWQ
 xGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725289980; x=1725894780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84ytfQkAptZIZoQjKCbMfyRWOmvktaEuFcbB61eiT7E=;
 b=uvA3Eh3rRcTcg7LhRbfGeWba5fpyPF7/csy0oazwpSkZPKA86feskkFbm5ZTT/DZUB
 S0SyWm+7U/VdveToOPpvT0KLQeDPA/D+E0ZAUVEJcMfgHLETxAodc4W45YMHNW7UnyC8
 +1fqYd1NZ/10c8ThDTpQ2FrNBz53C4+hRVnx2vGSVuKQGFUk2C0VBVfBOPitLM6LtE30
 3Q4M2dnQcNLqD9PppKbcThdPWtijzjClBd5F0ffpiuwEpr6uQ2xC3EmOc3bhnLITgQsF
 Kay/hb2hUBIbpacksaGDieiC8KdNIP+Z8AUFxT6EDLzghcpYpRwnM5j6ucupHX3fzY6k
 cYlA==
X-Gm-Message-State: AOJu0YwF8GtPm6WqYbhYhEIt1Kn4GZQulf1npE8iLbXG+hkBY9uCb7fX
 6/AXFHaYjY77KKcvtE8gDrfd2tUahd0UQpM7uwqY655kk7Zc6oSne0pXnNcBP8E=
X-Google-Smtp-Source: AGHT+IEi3DOMObSv+WaaIGqdglwVpom74AC2CM8YmV10t/WATkCFmDF959XTHH8ilb1aWRVPjxFWsA==
X-Received: by 2002:a17:907:2ce6:b0:a86:80b7:4743 with SMTP id
 a640c23a62f3a-a8a1d2c9c26mr40444066b.24.1725289980056; 
 Mon, 02 Sep 2024 08:13:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891a3ceasm567022866b.115.2024.09.02.08.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 08:12:59 -0700 (PDT)
Message-ID: <e22a18ee-9451-4a78-b557-786c120bc7a0@linaro.org>
Date: Mon, 2 Sep 2024 17:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] buildman/toolchain.py: set CROSS_COMPILE only if
 self.cross is set
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <655de02f937e3ea3a8f5306ef510d817bee8065b.1725012294.git.jerome.forissier@linaro.org>
 <CAFLszTgrNpeObzMCpgg_gDfVNSsYNEzU2uZOgSB=B-Bcrpf5oA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTgrNpeObzMCpgg_gDfVNSsYNEzU2uZOgSB=B-Bcrpf5oA@mail.gmail.com>
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

Hi Simon,

On 9/1/24 22:10, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 30 Aug 2024 at 04:17, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> In MakeEnvironment(), CROSS_COMPILE is defined to be self.cross (with
>> or without a full path), optionally prefixed by the toolchain wrapper
>> defined in ~/.buildman. This is fine when self.cross is not empty, but
>> it doesn't make sense when it is:
>> - Either there is no wrapper and we end up with an empty CROSS_COMPILE
>> which is the same as not defining it (the host compiler will be used),
>> - Or there is a wrapper and CROSS_COMPILE will contain only the wrapper
>> which obviously is not a valid compiler, hence an error.
>>
>> Test case:
>>
>>  $ sudo apt install ccache
>>  $ grep -q toolchain-wrapper ~/.buildman || \
>>      printf "[toolchain-wrapper]\nwrapper = ccache\n" >>~/.buildman
>>  $ make mrproper
>>  $ ./tools/buildman/buildman sandbox_noinst
>>  $ ./tools/buildman/buildman sandbox_noinst
>>  Building current source for 1 boards (1 thread, 24 jobs per thread)
>>     sandbox:  +   sandbox_noinst
>>  +In file included from boot/bootmeth_efi.c:16:
>>  +include/efi_default_filename.h:20:15: error: operator '==' has no left operand
>>  +   20 | #if HOST_ARCH == HOST_ARCH_X86_64
>>  +      |               ^~
>>  [...]
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  tools/buildman/toolchain.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Can you please put this on top of [1]? I am trying to resolve a
> code-coverage problem in the same function.

Which [1] and what do you mean by "on top off"?
- pick patch [1], then pick this patch (resulting in two patches
in the series)
- or pick patch [1] and combine it with this one?

> 
> Also, please do add a test case.

Done in v3.

Thanks,
-- 
Jerome
 
>>
>> diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
>> index 324ad0e082..ff987a9eea 100644
>> --- a/tools/buildman/toolchain.py
>> +++ b/tools/buildman/toolchain.py
>> @@ -201,10 +201,10 @@ class Toolchain:
>>          if self.override_toolchain:
>>              # We'll use MakeArgs() to provide this
>>              pass
>> -        elif full_path:
>> +        elif full_path and self.cross:
>>              env[b'CROSS_COMPILE'] = tools.to_bytes(
>>                  wrapper + os.path.join(self.path, self.cross))
>> -        else:
>> +        elif self.cross:
>>              env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
>>              env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
>>
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon
