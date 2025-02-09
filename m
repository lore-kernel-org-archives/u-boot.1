Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5448C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C8080821;
	Sun,  9 Feb 2025 16:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GBf/fFzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0D480834; Sun,  9 Feb 2025 16:53:17 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684F5807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D78B3F2BE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739116394;
 bh=bHy1+a5rgrQV0ev2qfmYKAriIDWVTRf9kHbRslHlh4w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GBf/fFzmm3MuHDBwHS9iodRyLv27oqCOOyRQVon/+bF3t+ZMuUckRRx7tdM3mvd0z
 i+oAi414C6uIsa6TbI6bbXWKuLtFn5nWmD3i3S4kSSVe31AexDnskKK2zyx1YS4CjW
 UGVS1RAo6zdvsdRtDJewi604Bh5PVSQRyit2jdXazHfti8JYvrf3KJ4hNl6w2BACer
 dIw6MiPv5xR9o91Ij+0oe5UiggNy2ZMkIvEkpoEK86Uy8U5Uzk0w/2OIr6+FRS8cMR
 MEnUEc/jPLh04ZFEnvjUXbkeBYmRC9LvdbDe509Ve2HiKd6h0Y7ntk0jjvadkiPtsr
 z0HfffAjSyzmA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438e180821aso21256685e9.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739116393; x=1739721193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bHy1+a5rgrQV0ev2qfmYKAriIDWVTRf9kHbRslHlh4w=;
 b=f/lg7ftLvXYmitAR4Tcg6UeEqmlyPJngtjQkjYHQKV6CsNKXAC077hw9vZs+BW1cuw
 CVUKywYPa32pT0RmsgMl0V0d4GBoUOGru3Z3ir1eiRe3pATSBqFaKCfckwD0LvIsGCKF
 NNAaujcqVXINZ33POGQqbSrgOT+xfTjFchN3moMc2U9nFAZTs4yMdISQuWjpBlX8IMrW
 sIfNKg6bzo8RIQHt/fV98HeYFAYrb6xUODPZkFV6XK1wF1EnQ12TIAAlY/7C0rqIEMrL
 psqUGyM+5Kjg4cHf5wvB9uTdmMG8xOgMmovaJyP5pZ1R+iDfCZYN8y0oHJqmg+RyWeEZ
 9Epw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/EKZv1v7vT4ILgj7F/caqW/ar/Tl262S1I5Uh/knpJMvY90pkfhG5v3+3iNt1Utir/9LQNuc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0lLmO2CZT4S1shkGTMU0mREt4FqZMistP/Cf9snTU8StPcqCR
 VSmZp2IL632JMwqZCHusmMdJV6e/LkAozodaRO4k8pn0TFgpDdFpViRhmBcc8EHJ420klP5/4HR
 uWXA1b0ckUSrz+GcV0zh/hflTFfg05xlpebelbHJrl5tEYn1N38MwKHjoCZWY0BkuyT4=
X-Gm-Gg: ASbGncuJM9gQTEArAvMVgJkEBB1Q3t81TduDi9woOuJY0r2f7sI9Jg+wJjFhRxFYMls
 xG31p5/k4BY3ulWXTz0KBy5ocgfIvLha8jlr8m+NMgDV/LWwrXD/4T/TErl/FwOltTgK+Lpzzsg
 8tsSQaXp2iPZOa7hUUaZE9gLlpFjmpifOwb8/861eyg126krtGr/Tpwi2p5c5riG5qmcAyrZG1u
 ud3JnW0JHpqMSf/yL236e003AaoU0st1nN/JPlE2pdgyV3NAKT9LkA8sSKufcjv4ZdxIpwShMEJ
 cAUNDhMJKvUH2Y9c9kxUS20h9JrcRCE82tn8mmLMy5xYEu6kFQ2Fo28+Opw08vWJPmnMaTBO82R
 eTA==
X-Received: by 2002:a05:600c:1d86:b0:439:4499:54de with SMTP id
 5b1f17b1804b1-439449955c6mr3222585e9.31.1739116393561; 
 Sun, 09 Feb 2025 07:53:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3cGuB2YgTV0+wibWjs/hWAe43MidhkuhYv1A4PCKOLq7vTZnaQfthpr2ywTJP7ZzUDYecPA==
X-Received: by 2002:a05:600c:1d86:b0:439:4499:54de with SMTP id
 5b1f17b1804b1-439449955c6mr3222455e9.31.1739116393176; 
 Sun, 09 Feb 2025 07:53:13 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439427b48f8sm11335005e9.30.2025.02.09.07.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 07:53:12 -0800 (PST)
Message-ID: <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
Date: Sun, 9 Feb 2025 16:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
 <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
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

On 09.02.25 15:29, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> If a single configuration node lacks a description, this does not rule out
>> that another node with a description matches. Anyway we have the default
>> configuration as a fallback.
>>
>> So continue if a description is missing.
>>
> 
> That field is mandatory, so we should really fail if it is missing.
> 
> What problem are you trying to solve here?

Sure the field is needed to make a configuration selectable.

But as long as we can find a good configuration we should boot instead 
of leaving the user with a bricked device.

Best regards

Heinrich

> 
> Regards,
> Simon
> 
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/common_fit.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/common_fit.c b/boot/common_fit.c
>> index a2f9b8d83c3..4c134e0e86f 100644
>> --- a/boot/common_fit.c
>> +++ b/boot/common_fit.c
>> @@ -57,7 +57,7 @@ int fit_find_config_node(const void *fdt)
>>                          printf("%s: Missing FDT description in DTB\n",
>>                                 __func__);
>>   #endif
>> -                       return -EINVAL;
>> +                       continue;
>>                  }
>>
>>                  if (dflt_conf_name) {
>> --
>> 2.47.1
>>
> 
> [1] https://fitspec.osfw.foundation/#configuration-nodes

