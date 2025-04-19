Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9284AC369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 10:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723C382A18;
	Sat, 19 Apr 2025 12:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IpUCBwsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CB582A18; Sat, 19 Apr 2025 12:20:47 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57AD80BA8
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 12:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 017B941A03
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745058044;
 bh=yYYmpLvZGWs5gP2ecLKn8aHL+jygqg7HG71SvNgopd0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=IpUCBwsLy2STbDTRFftFJ+GapAtITOratktWN5h0DpQJcoULcykOWdJ2l0eIygSUN
 U502xkmzYVUoo1mQlc/eq5ZknFE5YoBykvwdjpeeJDtCA0M5nOX6Zpa4UqOZnNCQvI
 CEuzd++ilFbTbI4o15XVyHSWoZqigTGJ69q2CZGccyrwJihEwv64oGG4XjUfDvpE8J
 YN+bTx3pBPRg4ZN7nvrZY14fHVKlVXZYTeyCEKyDWIJJpU7meHAXrgfjQLG/ZkUY3j
 zn6MH55kWBEH9jO8esgWTNCuV+83SWt0hji/s/FrH21zzxX7CZ+gXwy4nfob7hyWok
 3RmbYRrSAuBUw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so18160235e9.2
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 03:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745058043; x=1745662843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yYYmpLvZGWs5gP2ecLKn8aHL+jygqg7HG71SvNgopd0=;
 b=mXuduaz2nXxG/xvE3bpNd+Yh1Ox0u3MRiKac3Ea1zG9Gc0YDx3lZdOysuajZB4Rx4U
 Hhk2QxlDvasVMK4ICaiTM9W8hRa37c+3CufN6q7veXnoqsFgXvkLRXTJ99Isra8hTK4n
 MbhKiz2AzufRzx9U6e7hlm8mDhPECLudXcbVy+16bQ3AZVnmERHJPWPHV1v3C0SKoT30
 t25i+B2epg/PmAK2gM/49+l+XXcMLIekr/sTSbkWOEcNxtPDCtCKYID5frZVFKg0KBqv
 btLCTqavM8HnQiCjoBM79uh6RkaC87xhwrazFj2kxr42sbU8vlejMUQhatFNY3/VmOFE
 QDpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBrKbQ1uSSTFt+HU4o9+i0pN5Wv5G6ad+zFuZdbxraasK+fFgk3Ssgamsengux0vZAK/Jn5es=@lists.denx.de
X-Gm-Message-State: AOJu0YzTu3K6dw4ZvEyorcQNO7AY92V2AIV3yXslttRfOXdD0FRZE1oq
 TO3W2Qjar4odMPzhPSokIg2MPdF2hU43sBQu1/kKvEfyfV6soou+bos5BNk2YW6AxdxnWPpiP/m
 XGad17mtSfbR2FkqBjXWT61oFCgl9haaQkNcHHAq2qW16Avk5LykZVPeQEHb6eX26nR8=
X-Gm-Gg: ASbGncuXBZJa8nZRq1Nx075Uw8P9jJbrmNI+8t/iTGg/SrjbDAq/9CHzv0igMTjbyIz
 lfh2akOqi3PFGnHwI0IJmwAPIbQdL8B/xHb5Y88JChQb9bol2KTLLzdB7bScFdB1FByFfD7qbht
 MnDFHLnJyCmrtjirRO6t+ErUvE6Xgyr4gA3TDQ74S6lr6JnXUHJZmn2MT2BKBi0dGfYaeL78XSO
 IngqhAQDkkYYWzPXaQMFdTVZK4zDd7blo+UUExVGLUDmLLq28Ak1gMDfQblrObc7VIg/drvEMaJ
 0wYgHTsLUnXTvcGdbUn2Ci0+xoCn42WOHorKdGJfGNe1jcn5XB6qHpO9lIgQreCztwsJtJm9uqU
 JWg==
X-Received: by 2002:a05:600c:8411:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-4406ab944edmr51932275e9.12.1745058043530; 
 Sat, 19 Apr 2025 03:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi5P/a5GPMhxPb2MDvY6rCin1sTJszCyewVkfrrMVyUTj0vpHGDmY916FoqA8ZRzwXViMJLg==
X-Received: by 2002:a05:600c:8411:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-4406ab944edmr51932055e9.12.1745058043100; 
 Sat, 19 Apr 2025 03:20:43 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:7543:2b69:829a:108e:3743?
 ([2a02:3035:6e0:7543:2b69:829a:108e:3743])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9eb8sm55115765e9.4.2025.04.19.03.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 03:20:41 -0700 (PDT)
Message-ID: <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
Date: Sat, 19 Apr 2025 12:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
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

On 4/18/25 13:39, Simon Glass wrote:
> Hi Quentin,
> 
> On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Heinrich,
>>
>> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
>>> Currently we are no able to build with configuration fragments in our CI.
>>> With this patch buildman gets a new argument --fragments for passing a
>>> comma separated list of configuration fragments to add to the board
>>> defconfigs, e.g.
>>>
>>>       tools/buildman/buildman \
>>>       -o build \
>>>       -k qemu-riscv64_smode \
>>>       --fragments acpi.config
>>>
>>
>> What about using:
>>
>> --fragment acpi.config --fragment fragment2.config
>>
>> ?
> 
> Yes that could be useful. It would also allow wildcards, although the
> code would need to drop the config/ directory prefix. Also, I see that
> -z is available so perhaps that could be a (bad) short option?

Hello Simon,

What do you mean by useful?

--fragments a,b conveys the same information as --fragment a --fragment b.

We are not passing any config/ directory with the fragment names.

Using wildcards in does not depend on how fragment names are passed.

As maintainer of buildman, please, clearly express how you want the 
fragment names to be passed. "Could be useful" does not indicate any 
decision but let's me hang in limbo.

Best regards

Heinrich

> 
> Another idea would be to also allow specifying the fragment name
> without the '.config' suffix. Less to type.
> 
>>
>> ...
>>
>> [...]
>>> @@ -412,6 +413,8 @@ class BuilderThread(threading.Thread):
>>>            args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
>>>                                                  work_dir, commit_upto)
>>>            config_args = [f'{brd.target}_defconfig']
>>> +        if fragments != None:
>>> +            config_args.extend(fragments.split(','))
>>>            config_out = io.StringIO()
>>>
>>>            _remove_old_outputs(out_dir)
>> [...]
>>> diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
>>> index 7573e5bdfe8..38ea7f9f335 100644
>>> --- a/tools/buildman/cmdline.py
>>> +++ b/tools/buildman/cmdline.py
>>> @@ -62,6 +62,8 @@ def add_upto_m(parser):
>>>              help="Fetch a toolchain for architecture FETCH_ARCH ('list' to list)."
>>>                  ' You can also fetch several toolchains separate by comma, or'
>>>                  " 'all' to download all")
>>> +    parser.add_argument('--fragments', type=str,
>>> +          help="Comma separated list of configuration fragments to be applied")
>>
>> ... and here have an action="append" instead, which will create a Python
>> list already, which seems to be what you want to use anyway considering
>> you later split this by comma? This would also allow to have config
>> fragments with comma in their filename (which is maybe valid?).
> 
> Regards,
> Simon

