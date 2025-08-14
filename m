Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C156ECA0EE3
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 08:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE29C8309A;
	Thu, 14 Aug 2025 10:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W5X0HmR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA7E8309A; Thu, 14 Aug 2025 10:18:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ED38367B
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b098f43so4424325e9.2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755159480; x=1755764280; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AKO5UdjgRAJPEmbreBME6PNQ2gwFG0wtQ5RecZKeGf4=;
 b=W5X0HmR+MVUvPCbUUL0t5/oo7M+P+hySPNGQqh6hOg7ScEwD/XkHbonuRoe3MPjkmC
 QScx+sUt/iKt+4kgrhEATUBFT+jYIyvh21KUBwbMq78n+U4abgdgeuUzvudT5H0fqr7R
 xRdSH6kGn2gGSMbKkHr74YvGA5YvWx+PB9B0wXwBVLbean90+Co+A5yEzfvB/lEiOYxp
 ll53kqH4HurPjkiyb81yXfq531vhA7rBGTw5gr0fD72xjFvT0aLzbCluaI2WV3orOKTh
 mvXoRjddmr0zu/8jyr/7g/FLkwvAmlIdvQWGXeyeTi+xf2FvzJfQJ+vYsoz7y+FB2A+T
 1FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755159480; x=1755764280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKO5UdjgRAJPEmbreBME6PNQ2gwFG0wtQ5RecZKeGf4=;
 b=XZ8qXwOOFiAnsHIQYqzjXu33kFJX3XhnFeN9iFXIX+1K7+hkbzHwUkMwICw3NcMhab
 aANZ1aLkBqsKTmedyGvqUPyJSjMHGHk5mMKpKDD1zVg2q3eODCDHoBygrWuxqCgVPTdD
 mRGfduV4hjmFGfV/Kz2cumhSssRBWk7GHI4nhi+zEAxn5zeJdh7G3Ki+TqHI3VR5HVFS
 eMhc8dfTOfzpcRBKNaLtziNKJKTKxgDpA9R4CR/tyoHGNY7dB9Gq2SnxguJKxTp/AXYe
 KP+UUzHtMaUUlgfg4DgCFt+5EHrhLpyYrD9WXcoW6MF1lTxx1AhaAg6u/HuDOXfnW84Q
 825A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQnU4aO8zIJwgd69kttNvV7nc7aZ9Hd238RH4x6WmEEGnfhQ/45ht2nbPs+ICdmAK/dW8W1lc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywsit9YF7bDh99QyYoim3+JBXuINVvS7Q1b/1x4qCV01Tq1RIu+
 Fc+4nooQciSi0iEUTfadgDzl2UXxLx42NpMsR3OtACcbrsd0vmPjLlvC8RF6MdCaIv0=
X-Gm-Gg: ASbGnctNvCrACDygRSdE1vfruaihSy/mRo+U0atDbYtRrc7Hqmvh/717MbLY3Jc+cTk
 erCyWWQKofvr3TX4DSq4szVWEsc9vkhYJheeXpMKo/tJRvye8t/d7BuwHDFhOZFlpj4h9mmLduw
 49gIQjJkW4bOQ8iq2+JfOtjakyX6H1Ut2Gby3GjPygv7kACDfEmJFX+QY3viUYycxh78QutDYvk
 V7P7uAFap+B9Tfunp5s1yaPBwxf7u0lmw7cM/yHJDjUX9VV4uxGbqTAivVfug7CN3eWuFdVEtQv
 vLCq7co5JZQUOWbUbzegoY3tcrlPDvw7xeoSwesstyWd6OkN7SPiGV/Wdaof9XmweSjXrLgJxlU
 YSSxcmYc5A/n8BHf5xRRv8bon2yI75noQaQHu0HOz1sA2nkRurh7aA3M1zN2y76zp13bPBC0CCn
 EBZQ==
X-Google-Smtp-Source: AGHT+IFJTNb1MEKLQxFX8K4AFKdZMRRWBgsckfqA+69dBXG7CYBzPckEzUJkMJOsesAs0oB6EKWxNA==
X-Received: by 2002:a05:600c:19c7:b0:459:dde3:1a33 with SMTP id
 5b1f17b1804b1-45a1b66e81emr14229985e9.26.1755159479708; 
 Thu, 14 Aug 2025 01:17:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:49c3:742c:5c4b:5c45?
 ([2a01:e0a:3cb:7bb0:49c3:742c:5c4b:5c45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b91b05b28fsm3834950f8f.21.2025.08.14.01.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 01:17:59 -0700 (PDT)
Message-ID: <733280be-f5a3-4e1a-b374-615566707f2a@linaro.org>
Date: Thu, 14 Aug 2025 10:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] lwip: add Kconfig to decode and print ICMP
 unreachable messages
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>
References: <20250806085959.2130339-1-jerome.forissier@linaro.org>
 <CALeDE9NsfBRyfOdxr8S0iRSj5kdSwyKVr-pfroJCdjqT0hbmvA@mail.gmail.com>
 <5f3e997a-f070-417f-a09a-90e1bf7774cb@linaro.org>
 <20250813171304.GD124814@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250813171304.GD124814@bill-the-cat>
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

Hi Tom,

On 8/13/25 19:13, Tom Rini wrote:
> On Tue, Aug 12, 2025 at 09:49:29AM +0200, Jerome Forissier wrote:
>>
>>
>> On 8/11/25 17:56, Peter Robinson wrote:
>>> Hi Jerome,
>>>
>>>> When using commands based on UDP such as tftp or sntp, if the server is
>>>> not reachable or the service is not started on the expected port then
>>>> the command ultimately times out. However it often happens that the server
>>>> or a router sends back an ICMP Destination Unreachable message. That can
>>>> help troubleshooting. Therefore, add support to the lwIP stack and to
>>>
>>> Has the patch for adding support to the lwIP stack been sent upstream
>>> for review? Please reference the upstream patch for this.
>>
>> Yes, see https://github.com/lwip-tcpip/lwip/pull/73. I will add a link to
>> the commit description.
>>  
>>> Also related, what is the status of other out of tree patches to upstream LWIP?
>>
>> At the moment we have:
>>
>> - 5634ecc88e9 ("net: lwip: tftp: bind to TFTP port only when in server mode")
>> Submitted upstream as https://savannah.nongnu.org/patch/?10480 and
>> https://github.com/lwip-tcpip/lwip/pull/61.
>> Status: MERGED (https://github.com/lwip-tcpip/lwip/commit/b1edb7780f5f)
>>
>> - 27d7ccda94f ("net: lwip: tftp: add support of blksize option to client")
>> further modified by 10917df17f2 ("net: lwip: tftp: fix find_option()")
>> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/62
>> Status: PENDING
>>
>> - f69f7aef26f ("lwip: tls: enforce checking of server certificates based on
>> CA availability")
>> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/63
>> Status: PENDING
>>
>> - Part of 9349fc2e9c76 ("net, net-lwip: wget: suppress console output when
>> called by EFI")
>> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/66
>> Status: PENDING
>>
>> - Patch 1/2 in this series ("lwip: icmp: allow reporting ICMP detination
>> unreachable")
>> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/73
>> Status: PENDING
>>
>> FYI we do track this information internally here at Linaro. I could as well
>> store it in a public location if it makes more sense.
> 
> If it's not too much trouble, filing issues in gitlab in the u-boot-net
> repository (I just enabled issue tracking there) would be good so it's
> visible to all? Thanks.

Good idea. https://source.denx.de/u-boot/custodians/u-boot-net/-/issues/1

Regards,
-- 
Jerome
