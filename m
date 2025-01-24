Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8BCC0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 17:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECC480A45;
	Fri, 24 Jan 2025 18:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KD1ke7sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063A880A46; Fri, 24 Jan 2025 18:23:53 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61F180817
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 18:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1339781f8f.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737739430; x=1738344230; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3IP/7YQY1HLamqhiTIIi1TbB4lpLKWBI1HNto3+a/LM=;
 b=KD1ke7snUF2mwueY3ULiaAYtfJwu9bThKdLvAfpY0qz0zDszz4mOHsvaLFsyGzX6z0
 A4ZzQlFOPvMAlIBA8WTC/Z5So2OIf+E+5foh4gdL4e852KHXYb40MVNmFxO+3T331laM
 +TurB8m8wqpe45EaGew0V2uyPx5NhoNSfz1aExHrdWwja1WLrfi+fRt5TfGaKMPXYKlf
 x/zST/lzUiUZ15kO2BUt4CMFyuZLp4DzyHgSXjnB4tXxgYbhsRUSBNe5fg+8ozMbLhIS
 S9HS4YVyk6zQdUebsd/aMEAhl2HHnTS4+KHmQNIDJpbd4Z8eoxhSow+Sce9uSm034i6S
 691g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737739430; x=1738344230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3IP/7YQY1HLamqhiTIIi1TbB4lpLKWBI1HNto3+a/LM=;
 b=d2Zkwc3aeKV3eCEYOvHnAP6THiZLr5Yf/V+T000PHHat2GBYShNnJjDUwy1hkZiX51
 aJnrqXx0nCfybQHuNePVpBcZCg06GBRZ3Q82ASAb/Pa2sWnu0XVtD3XBZZxkUHGmMK6O
 e5DEVYtRMmwuUZneFMA2Qg6RGhKtM7F/As7dokMmtBxgxF7VjxHgVDGU3j1nY2QRuPuF
 m/GelMv5nxHfnSQX9N8e9YAalyXInC3b0hfFIPg3r3+yibZwKPkp52TL0mx42h8T/4YG
 Vnwh3V00vA6K3Zsr0RuVGw+v2yU+duOabdGrpzae6siqZlRrxR++EC3Q5zQA1BPSquzB
 jKhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ2IgzjYWFwqS2h05Atm8TbZgTi6hAHH4Ta5hpBbt5WS5AnbbuGeJ8B4MBOm01mzEgjviQKmc=@lists.denx.de
X-Gm-Message-State: AOJu0YwIwNh3o2Ym/BeLDTa2NBnLnf9jgMOu7c7b8V0g9s3YmCJ8qZ6C
 h9Nh+kF4g4MbrVfI5KHro06h7oydU8w6jN8Jb8q2JqhhYg8bPO5+xPQaktT03AM=
X-Gm-Gg: ASbGncvycPUjbLt2xxyk2tZrPs9lUL1VCB0piDVjsx6iqxdYWzq+tmN6GDv3lTWDvGw
 LEdWCZ9zAC6DLYPGYQQUSbt0UA4/UfOStFGNyMkAYzYLijfXIpaDuvQBqO2xAIgekGedMn9zrRo
 uxu/v5tkJKPYeG8nUS2WnxX0DDv0PZjMUybBBYKMNuugIqni2VjgQwMTGL7aGEno+TZYTVBlOZ4
 VcXQz7xIqtBubG9mcLRKBcOH9eP5KHKqM+jYAN7P5lCTbK/cxwztV3xwXcKABONYEuph+n4bnBj
 iKV8kiriendYJjDx089lmhjH5dA6eZeoUEWAqugW0AUSfoCsxqDZ5EcMpWnE
X-Google-Smtp-Source: AGHT+IF3zAL3snHc84WfDEMkJG4yWmSifAvCysStnzED96/RgivwqCyCdGQjMDpzcd6hhAZWapDfdA==
X-Received: by 2002:a05:6000:4026:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38bf57a9569mr33987060f8f.40.1737739430011; 
 Fri, 24 Jan 2025 09:23:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3f81:732e:4183:39c7?
 ([2a01:e0a:3cb:7bb0:3f81:732e:4183:39c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d74esm3357103f8f.37.2025.01.24.09.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:23:49 -0800 (PST)
Message-ID: <bebd3427-2d20-43ad-b682-ed02858db546@linaro.org>
Date: Fri, 24 Jan 2025 18:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common: board: make initcalls static
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
 <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
 <f9bfd3d8-dd30-4f4e-a73d-ab9082f832a8@denx.de>
 <38bb1c47-8001-4415-a421-ff1b501f0105@linaro.org>
 <77906c5f-3d67-4c43-9e22-c8ea74695146@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <77906c5f-3d67-4c43-9e22-c8ea74695146@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 1/24/25 17:23, Marek Vasut wrote:
> On 1/24/25 4:57 PM, Jerome Forissier wrote:
>>
>>
>> On 1/24/25 11:35, Marek Vasut wrote:
>>> On 1/24/25 10:10 AM, Jerome Forissier wrote:
>>>> +#define INITCALL(_call) \
>>>> +    do { \
>>>> +        if (_call()) { \
>>>> +            printf("%s(): initcall %s() failed\n", __func__, \
>>>> +                   #_call); \
>>>> +            hang(); \
>>>> +        } \
>>>> +    } while (0)
>>>
>>> Can this be turned into some static inline function too , so typechecking would be retained ? Maybe the function can be passed in a function pointer to call ?
>>
>>
>> Doing the below totally kills the space gain (-160 bytes instead of -2281
>> on zynqmp_kria_defconfig, with LTO).
> 
> Does the compiler not inline the functions perhaps ?

It does. inline vs __always_inline makes no difference. The assembly
code is pretty difficult to understand in any case (macro or static
inline function). There are pieces of called functions all over the
place inside initcall_run_f() which is to be expected with LTO I
suppose.

> 
>> And it prevents from printing the
>> function name in case of error, which is nicer than an address
>> (especially with relocation at play).
> That function name can be passed in using __func__ as a parameter.

True. That being said, the type-checking argument does not seem
decisive here, and although I too prefer to use static inline
functions over macros when possible, it looks like we have no choice
in this case.

-- 
Jerome
