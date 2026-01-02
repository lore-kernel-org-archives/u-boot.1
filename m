Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BE5EEB57A
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 08:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE8C83B82;
	Fri,  2 Jan 2026 09:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Vd/GGPSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64A683C04; Fri,  2 Jan 2026 09:27:07 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A12683B27
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 09:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F03FF3F91F
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767342424;
 bh=xcS3Mg8W1t5LOJzBZYOWGHINOCdeAtQJ/Pg+owE1Fb4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Vd/GGPSXKMaGNh9EyK/wRIEZYxRGlZtdkH6EjTYOkBVcI+yOWvpyQ7zdgI4gOyHim
 fEIP2BDrR25MvdDi3Q/5+iAzo/4GWBfCqKgDzs8L8yKeKU4DYi1TpX1+UgA2rxJmtv
 ZFrxVioeDsMLiaczmf+QpJ8h4fr8CEafPWeST4JCM+NU613Pz9lf3NcQIwAbCXmrfL
 vRdK+NVt4BFPczZddAJMuzJ6dDYIIsTL3rfkC+LjpEVI+4grFGO7IUQeClvCcrvAtx
 99PKMHWE3bjlJs2mgx2eLQDWtUXCv9od6SN7umcGzuQzTGn8MPO0KDxXwwgUYkN6Y7
 D8XaAPjAxq/ubg0m/Lp1XHL7z7s2WN2UBTp1HQvXPPr5ub3Eosr9ENL11McfEMSIzS
 vksxYEQuBrNaXuEge3023QrQ1WnvzL8utvz8TAdtSt3S72FT+xX3958YKRizLI4WgL
 HbuVgx56QonFWCQkd+immKJJROrF0KL8xsf2c7o/+0ypWtbKSFD2QLVxtDxCAMqoax
 CMH8HX8Y8TsbuhoDpoihonNgDzJrmi2NNRc+wtenShWLHT6hz3xnT2MRQ04QxpLpTI
 YsBhvpdUJsr9sXCIuG5qrookWehn2nxmlfwBs6vvgDRaJ+r/GiN9pkldJu9hCFmFjq
 AXUX+XbH2FCgFpXkZYhRPbvw=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso9274040f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 00:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767342424; x=1767947224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xcS3Mg8W1t5LOJzBZYOWGHINOCdeAtQJ/Pg+owE1Fb4=;
 b=Zf/YlXnmGoolwsu/+uJPD6mtRPl+wDM8uFj8iU0h2tETWVhlP7YzX+f//DZ56BAG8G
 qvXfsbqyjDrlV7dmXfjZch4YI5jYiRsLBlW44weL3bfkvK6IbpJHlZC/Nlwwqjpfenmf
 90sqG2o/9lAkm5u+hcB83ZCsUSjK+NF4ucCqXTVtzPC+mG6J+KO2oE1kSJXBlz1m3Wyx
 MEFfFwSe6HXaTNSF+KN3lrWcN51JSbsf77DFxlKNuHItlXMAHELDrv8VSnRROgDCTt97
 jM+SZbef7lHdQX33mqV5c3xnOdByV6H34xr59uv54tckVK6XS4giTFbZLMIHqQJKvq5N
 cl7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXXJGWY8gMY/TV4kURAdN/0GR1roeKPsWrO0NWlAzjdQ0UZujH2P1U+6L++24f4cslLJV0yvg=@lists.denx.de
X-Gm-Message-State: AOJu0YyDxNj5cgkjPnF5mvh2Ii1EVeIpmoxMMqmga3fW82fao/yLcEA8
 pQHhJq4X6FrEXp8xI0V8PaZ3lENUuGn/jlkjOoL7KcqLrPB1QeH2GxOVK3Ofdh1UPrnH8iDg/ra
 cXxIfL6MkET2WFnGvcbOGzN8m+fmftGDabG9bDzeVV1ZY/7Oh9TF+BhJqJdRjb4lWnBda6o0=
X-Gm-Gg: AY/fxX5klWccBOn+PYsaJA1RUfYLbet5Lolu4XjVPYcCxXyfkl+GuHd0xP5OSb3nC0u
 ndgneIyYV/O3x352T3egMPO84lm1O20wZQFxClXysnwhGbdrP+J38NAnn9H695/wYh2TOOF7Jx4
 UNtKEK/w3vRshK1ZZGG5y994t4z6t2jWea88JgAV+N8+cur4BEq17srti8IC6V3bIV5V96abpET
 8qzqZNEPF6XC3xODr8gHnEfz33QBKfQz9y/gqKv37a4hIr94BssT8+3j6YQKnLt1/Dr8IzKrzHZ
 lZ8tpbnv+Q5ukdyn97csdEyMpduc7Sk64056IHr82GX07GfHs5qk0Qiv98kxMeBQkBloKsWI7jH
 tA3E5jNJdgiFH0brW/SL5D/789r4E/ieZCAkK8jCHf8+Vw/WTIFaOWK0DPZRra+km6uVfzjTwQY
 C9X6YTvfg=
X-Received: by 2002:a05:6000:40dc:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-4325bac3a19mr47177247f8f.39.1767342424536; 
 Fri, 02 Jan 2026 00:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvmCK5QR7AeifLGRbGEYmusU1fxjB/H7dpDRuucnxUTUj2QTkifUC1GMWol1V/RGemyM436g==
X-Received: by 2002:a05:6000:40dc:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-4325bac3a19mr47177221f8f.39.1767342424138; 
 Fri, 02 Jan 2026 00:27:04 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm83770650f8f.42.2026.01.02.00.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 00:27:03 -0800 (PST)
Message-ID: <f2a7fb41-5059-4b52-95a6-d0754981d3ec@canonical.com>
Date: Fri, 2 Jan 2026 09:27:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+VHVyOv43pMxfdUr=0e+9bjp+Gz4nzuweX1uSibObrXg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+VHVyOv43pMxfdUr=0e+9bjp+Gz4nzuweX1uSibObrXg@mail.gmail.com>
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

On 1/2/26 08:12, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Wed, 31 Dec 2025 at 21:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Since commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
>> CONFIG_CC_OPTIMIZE_FOR_DEBUG has no effect on the non-host code.
>>
>> This patch reestablishes the prior logic to add
>>
>>      -Og -Wno-maybe-uninitialized
>>
>> to KBUILD_CFLAGS.
>>
>> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   Makefile | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 6b5c5ee019e..2a972af4906 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -869,6 +869,11 @@ endif
>>
>>   ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>>   KBUILD_CFLAGS  += -Os
>> +else ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
>> +-KBUILD_CFLAGS  += -Og
>> +# Avoid false positives -Wmaybe-uninitialized
>> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
>> +KBUILD_CFLAGS  += -Wno-maybe-uninitialized
>>   else
> 
> There's a ifdev CONFIG_CC_OPTIMIZE_FOR_DEBUG a few lines above.
> Wouldn't it be better to move the HOSTCFLAGS under the new ifdef as
> well?

Whether the Makefile is organized by host vs. device or by Kconfig flags 
is a matter of taste. In your patch 5f520875bdf0 you opted to organize 
the code by host vs. device (like in the pre 5f520875bdf0 era) and my 
patch keeps it that way adding the least invasive change.

Best regards

Heinrich

> 
> Cheers
> /Ilias
>>   KBUILD_CFLAGS   += -O2
>>   endif
>> --
>> 2.51.0
>>

