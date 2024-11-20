Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44CFD711C0
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 592CC89234;
	Wed, 20 Nov 2024 17:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iw9ib6KT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C57D89234; Wed, 20 Nov 2024 17:37:39 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7852C89229
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa2099efdc3so215606566b.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732120657; x=1732725457; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=irGXXZt9TZuJMnvB+mAuCeIRIp9e2mVfxbMYRSlGcTY=;
 b=iw9ib6KTKSBdnqvxJcjAGOJSytk+ztL5+AxwpfrNyVstgjYIrWpmtysSr0THw9qfjB
 wvX+kLQhGLZYpCLdoT0/JULYLDQblUWjwUY9/UEvAjHyZ6drrU15SxFguehBnnJ3tqcj
 pBR0om6uWXARCgnTj/tIe6znl3ggp5Ily5QdRlur6ykqMLngkYEVKPmhukpbyt5g6W6J
 X/sKAkQeJOrIX9UPyMV9MTq80AK1Qe2jRubCeQy2QRPvaCtTf/H8YDi2Zu4cjP9CQzA6
 3Jh/Ex5DxYb0w3w/vrDE6EKwP8IYKrDPufPPtHFlynV20D3ZPEb5sQKO/ZF80zAW85ML
 Jhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732120657; x=1732725457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=irGXXZt9TZuJMnvB+mAuCeIRIp9e2mVfxbMYRSlGcTY=;
 b=CjS9OTXt26ZwPEXboCfz+JaJyYp04XpY+LXKgZh/vuqQmiHjhi9TUViMwswUASK+kV
 XYyzB1lwQWm4aQHSQawF557BWodR3sGXcYLFQF7cWWGMZND4IVwrtHbpEjvXVK7IJW4b
 9CjPdt+ncsMV36tUzmOo3BoeP6zwNBqRcR0en/N/dov2PiZsEFnO0dfq5TaLcgIAchgq
 ZwonyO2A2bBOSFsrva+7VbAcLy7QCfxIyh1Ak36EaRbYFn9fbrdJj9dZ4At8XCOq8gZ8
 ENJwF0FEB+ZLdugHoMg4pUpvUVMsSFSdgYOf5kHXt8u8JpMLZFuAnaX09x2HEe2YdSDK
 6m5A==
X-Gm-Message-State: AOJu0YzjmBPmVBk9mZg0IX9ldLh/TwLzcf/7/eOsJXkC5EMtgX0hJemh
 u+qFD2ktuYhRyAwQh2hSeMUbb2539FoYgwo38xCua2VlJbun1WGFlE8SJUTuJD4=
X-Google-Smtp-Source: AGHT+IFEOAzKn9FKfezfHTnE122NOl59mP0IQwapYER9dYtjoTjm3v7Pi06RQd3XdhuYZsuK4n/S0w==
X-Received: by 2002:a17:906:db06:b0:a99:5587:2a1f with SMTP id
 a640c23a62f3a-aa4efb75904mr4169566b.15.1732120656994; 
 Wed, 20 Nov 2024 08:37:36 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffaa0fsm794594366b.106.2024.11.20.08.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 08:37:36 -0800 (PST)
Message-ID: <7d13e591-11bd-4ee4-a3a7-96c59a2f7b22@linaro.org>
Date: Wed, 20 Nov 2024 17:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] serial: Support a disabled serial port
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng
 <bmeng.cn@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>, Robert Marko <robert.marko@sartura.hr>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
References: <20241120153554.860710-1-sjg@chromium.org>
 <3ff334f3-b8e3-4359-9c02-a35e9a66c432@linaro.org>
 <CAFLszTgi5uoAYgMNO_72XjU1zrTf=eAJF21a7rZpwQ=Ht+K9mw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgi5uoAYgMNO_72XjU1zrTf=eAJF21a7rZpwQ=Ht+K9mw@mail.gmail.com>
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



On 20/11/2024 17:03, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 20 Nov 2024 at 08:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 20/11/2024 16:35, Simon Glass wrote:
>>> This series provides a way to tell a serial UART that it can't actually
>>> work, at runtime. The main motivation is to deal with a coreboot feature
>>> where it does not provide UART details in the sysinfo structure unless
>>> the UART is also enabled in coreboot.
>>
>> Why is the UART driver probed if coreboot doesn't provide the necessary
>> info for it?
> 
> U-Boot doesn't do well without some sort of serial device. That could
> perhaps be improved. But the point here is that we need a single
> U-Boot build which can start from coreboot, regardless of what
> coreboot decides to do.

Right, I'm suggesting that at runtime you notice that coreboot didn't
provide a serial port definition (or gave you a bogus address or
something) and skip probing the serial port in that case.
> 
>>
>> Couldn't you disable CONFIG_REQUIRE_SERIAL_CONSOLE and skip probing it?
> 
> No, because I want it to work if the serial info is available.

This option doesn't disable the serial port, it just makes U-Boot not
panic if it can't find one. For example I enable this when building
U-Boot for the upstream supported Qualcomm phones since many don't
enable the serial port in their DTS.
> 
> [..]
> 
> Regards,
> SImon

-- 
// Caleb (they/them)

