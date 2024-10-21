Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37590D15D8A
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE4B88DB2;
	Mon, 21 Oct 2024 14:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZgRv+kIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABEB88E35; Mon, 21 Oct 2024 14:50:01 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C9A88770
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9150f9ed4so5438118a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729514999; x=1730119799; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DF2NRhRScPpbe5BKWvyNBihmAvwc9sL6KAPyALNEBXQ=;
 b=ZgRv+kIkw/LjiCtut8MKo2pJ0xaod3QDy4ufgFknBypAHkoqAbA4l4sBlVEPrQXiyK
 U+KB8JNhFAxyawXStkZ9zF8qK0ceA9HZOOv5+Gl9U9708GvriZpHL0fyJJp44/9dNQjM
 +Oq0NMVya9g7KfNQePkUwtgh2iLAsrSMrSYrW+vY0FwNKHOJF9ApLQ4/5uBClVHn4Oo3
 oaHMVgO1a7EdhTvx/gpcnCyGz5wPyTYaosFQ3vhsRUdssU5XjZGjxu/Slvv3HC5rCAoX
 SM8Bst+CFFAObXjYXeHyzE0eHMH/VHo3eHr2rmsBHCW7pZ7yMjhk2bvjRmB8oEhMLB2K
 FQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729514999; x=1730119799;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DF2NRhRScPpbe5BKWvyNBihmAvwc9sL6KAPyALNEBXQ=;
 b=LuXx4/fCn07swHqDyjOrF+YW+ZVOmTbA1N4u/5U7auYcDWZ6WITGqCI766bl/C+BUQ
 V/VE3Mk0I2jq2Y4VtHJtksfOXsPf21Wof69TyFUMJt/O+9G2/e2TJUDk2i2Ep0o5Qzy0
 ciZd4iEwCIG+STksb5g5sGHsNi01d37x1PNlKKuzxzbvvNubdLX173l93eImZcPppNZs
 mgKwME8EfTw5cqDg/IJS0twTrLeTzUf20Wjz0khxwZqzIbwFuT8WGDQRKOwPU4ldduEp
 uLeiNzaEbUV84PLzYDo5s4bPpAk9+dx3Lt97zeMdxo/Z9IOVJEuLFLqk8ku7uNrR6/Xl
 XjKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjRm/0J0PvV8vdqowmySVY6/XuH+iUPeFa9awMO9RRWkSGWAo08+i29l7ge/D7YiXi71sBvz4=@lists.denx.de
X-Gm-Message-State: AOJu0YzNJADlEWzjs0F4hCDEa+6exwnk6FSWV9nf2EWdYx4AVRPB8PNa
 PDJlvuRakfEg42evh/C611hAi/u84mYfJ/ZLlsUOGlwkj5AKeICuflAyP05m758=
X-Google-Smtp-Source: AGHT+IEUIEibv84F9fD2u7XvJBaYdldTVTKQY5qyCZShuosr50xpTTLcHUFpKiQz+Syt0a+eXBSWrw==
X-Received: by 2002:a05:6402:2346:b0:5c9:547d:99 with SMTP id
 4fb4d7f45d1cf-5ca0ac44783mr9874500a12.2.1729514998648; 
 Mon, 21 Oct 2024 05:49:58 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c6b974sm1905776a12.67.2024.10.21.05.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 05:49:58 -0700 (PDT)
Message-ID: <f8bc8c69-2ac8-4070-829d-a650c1519786@linaro.org>
Date: Mon, 21 Oct 2024 15:49:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
To: ada@thorsis.com
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
 <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
 <20241021-profile-among-48555c7055b9@thorsis.com>
Content-Language: en-US
Cc: John Ogness <john.ogness@linutronix.de>,
 Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241021-profile-among-48555c7055b9@thorsis.com>
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


>>
>>>
>>> Yeah, been there.  Wanted at91bootstrap to boot from SPI-NOR which is
>>> _not_ Quad-SPI, and the feature request was closed with "if you wanna
>>> do it by yourself, ask our support for help". :-/
>>
>> iirc at91bootstrap can boot from raw spi-nor (yes, not UBI)
> 
> Speaking of at91bootstrap 3.x and later: It can, but only if you use
> the QSPI port, it does not work with flexcom for example.  See
> https://github.com/linux4sam/at91bootstrap/issues/181 for reference.
> 

Judging by the answer, we are both right, my memory was saying it works, 
and apparently for some older SoCs it's also implemented, while not for 
sam9x60 at the moment.
I remember using a flexcom in SPI mode was fairly simple and should work 
out of the box with the existing SPI driver in at91bootstrap, just that 
the flexcom mode has to be correctly configured, pinout, etc.
