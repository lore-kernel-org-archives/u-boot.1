Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FD9D711BC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F7B89241;
	Wed, 20 Nov 2024 16:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xFS3mb0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF68489001; Wed, 20 Nov 2024 16:56:25 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C98188FED
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9ee097a478so300097466b.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732118181; x=1732722981; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXHUyFW7KqPaK1dYRgDcSdY/qOSB8aXD3S0iYDASiZY=;
 b=xFS3mb0Dh9ydiy/3cxDhNUAy/x6MtQl33JpRxDcykIQHRJRGeZZYw3yfXkeR9e5a0a
 +5nrztnQvinUxLMpImwrGTZ+TiYi2/Vi7fmRSwc7yQAWilGvGXiD9331dTt8LfJbDLNu
 MoLkZ9o1MMQ/18NO0RdD5vMTA4Wd8hRhnWZQ4F+CzF0b/5B1tIvVVEo2FRsF2zWriqUg
 KmQYIIQNNZKi34P4b934D3D7NHjJw1SZaJZxMQIltFxnUqD0CWPUp6Bl5jle293vOtOB
 fmC69mHYD2ef8tgbuRaZ5SrAvnw6qgtrbyDse0uxg/+5jvJv8ZOqmJgAy5oLFk/9voNg
 7khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732118181; x=1732722981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXHUyFW7KqPaK1dYRgDcSdY/qOSB8aXD3S0iYDASiZY=;
 b=YH7XSWG/KVJ3WwSPAtoEkkAs2zycXGtBumNQ6BIO9gvfa0vAIAybN00juR4p75ON4B
 6h7yj44WgSWu6yk05tMq25Vs2ghB+PjQ1kTuDahtpEcrfmz+U8WOCNNEqHnv8ZZP582M
 6YTTLTl0NM7c9hchoO5dzG9pV+UCgZiBhI2c86AnKcMRncAdL7X6FsvCYfSPCWPLFWRm
 OtdHd/Q08Pl9yJF0l5Tmnb/u7kdz8TzDXIh+IdfmSFOLMGl1YTnP8TAJw01izLqRlirQ
 NXWE/D6PhGmMJmzbecybfHpQqZPt9IBRjjBsJbkk1I3PVr92JyII67sIX1CZvpRjdUrH
 j64g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6jvSdwM3vskNGehr97w7811gOoVaV+m+UxnXS7wnmZytQvei1g+14iK8YWWCdgBSu/ilMHQI=@lists.denx.de
X-Gm-Message-State: AOJu0YwUY0DAG/i8cR/bg24kwj1ow5sSbvpJhA9O7PhZQ+I7PcjMjCD6
 lni58Dnpn6iOCzqZKBgpulxB4O/bE79QIV9vI46MoyDwmM6h4a3KzrMIrJq66xI=
X-Google-Smtp-Source: AGHT+IEp0LN6DioKoUtWHMcRySmkygFFaXrwW6xf7vOpNkDWC1i406X+j4K1aQELQAlKGU4vMPFTIQ==
X-Received: by 2002:a05:6402:84d:b0:5cf:f361:1c11 with SMTP id
 4fb4d7f45d1cf-5cff4c43b40mr2856744a12.20.1732118181441; 
 Wed, 20 Nov 2024 07:56:21 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cff453e2a9sm924440a12.71.2024.11.20.07.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 07:56:19 -0800 (PST)
Message-ID: <3ff334f3-b8e3-4359-9c02-a35e9a66c432@linaro.org>
Date: Wed, 20 Nov 2024 16:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] serial: Support a disabled serial port
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241120153554.860710-1-sjg@chromium.org>
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

On 20/11/2024 16:35, Simon Glass wrote:
> This series provides a way to tell a serial UART that it can't actually
> work, at runtime. The main motivation is to deal with a coreboot feature
> where it does not provide UART details in the sysinfo structure unless
> the UART is also enabled in coreboot.

Why is the UART driver probed if coreboot doesn't provide the necessary
info for it?

Couldn't you disable CONFIG_REQUIRE_SERIAL_CONSOLE and skip probing it?

Kind regards,
> 
> Attempts to introduce a way to enable a silent UART in coreboot have
> lead to a large amount of discussion but no result, sadly.
> 
> This series reworks a patch sent last year, which was not quite ready to
> be applied. A coreboot user (on irc) hit this problem, so it needs to be
> resolved.
> 
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20231101180447.99361-1-sjg@chromium.org/
> 
> Changes in v3:
> - Put the feature behind a Kconfig
> - Move the feature to the serial uclass, so any serial driver can use it
> 
> Changes in v2:
> - Drop RFC tag since there were no comments
> 
> Simon Glass (3):
>   serial: Allow a serial port to be silent disabled
>   serial: ns16550: Avoid probing hardware when disabled
>   x86: coreboot: Make use of disabled console
> 
>  arch/x86/cpu/coreboot/Kconfig    |  1 +
>  drivers/serial/Kconfig           |  9 +++++++++
>  drivers/serial/ns16550.c         |  3 ++-
>  drivers/serial/serial-uclass.c   | 19 ++++++++++++++++++-
>  drivers/serial/serial_coreboot.c |  2 ++
>  include/serial.h                 | 25 +++++++++++++++++++++++++
>  6 files changed, 57 insertions(+), 2 deletions(-)
> 

-- 
// Caleb (they/them)

