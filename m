Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29026C0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F06482102;
	Thu, 30 Jan 2025 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZdJpF8MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C6E482104; Thu, 30 Jan 2025 15:53:18 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050F6820F6
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab69bba49e2so148447166b.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738248795; x=1738853595; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nq6SV6baubZD7yvtAn1rD3kc/4DBPB6ieyBSlZiicds=;
 b=ZdJpF8MKmcpRyz7tmm2YW7yjS1kZH0HYRatr6ChLUML0eQkGL0kcyuiMHOlSZO6h9C
 n8BX9dPQoHgJ/Lrc1LV0y4y+BLSI4yJeN72qs1QGbKcmis0L7/35s+f7dSRNSg7VlFC+
 ibR650i61q+G6oOa0IbOni0c6pbz9F6Pfi3oitH+N6E0w3ffU13A2rbgaky1QJb9c5BX
 sbUBMcKqU9kk6/Gtf6cqTqnGo3DYYoL3o8srYjXGldUdl9XltL27m0NGmFv5s0iTaju5
 wd7ZSI9KY0eC/7t2M9OE55F5dJobdbAmeQ+J6nwbOvHETwAtWC7e0H4gC+l2pR3pPNUJ
 SJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738248795; x=1738853595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nq6SV6baubZD7yvtAn1rD3kc/4DBPB6ieyBSlZiicds=;
 b=qN0hSrZXdR4FUswRNNDGInLT2HLS3dhyq5gnsHA3qtgXeu2xvsYnlgwHM0X9tmsKAv
 dEq3td4EZ4zEc+xF3qauNndYZBa0gu0PMQexseaG0GVZ+nwiV6R4uSgEEwp2zEXLFH7b
 0rsw1Di+R8t4r7GUp4wjjugqGORbMAyAAiAsjFQyM7Jmam7m8/N4gbro1MbCoS492j1v
 ZTN70vID1M9BLHdAbyxxYSkbebgeqh52YL6Gd2nVFZ4//T6qIlg/gJmvgQ6hSovgnp4u
 5ILaAKMh7dgKJYdDppwsSWjO+b3bfAVrD5X8eVfAo75yTlEHESyydMdFsMnCmxWfy6vD
 ND5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZw8m4gyJ6tJ9SukXFHjZVr4m40NvvK3KPZ1RGiVx3xlUCoisCQC4y4YtXRyCKTdf0d/2ddPc=@lists.denx.de
X-Gm-Message-State: AOJu0YzcHFvaE3paW+JS0QvrtdEjCE50FTF/i5WJSd81nY/o7p+Mag9B
 Wt2qIX/StXe7t4jVnbFhEi5CucG1MQdLCHNHNmdvdFX+EK1tb1jfen2SsGkjowI=
X-Gm-Gg: ASbGncvcGZ6sV6SFM3MkaDrj6oncRSsKcJpNoKsvy8kOurYtHxn7fURM/0q5uSIcnQc
 lmafopNDHQkca1Vsrjd78UDM87S3x+EYd7IPQmiZzCdQEGN71e57+wd6brQozYfPptbo4Ak3lJ4
 PVxmJuadDPWQvaQnMWORJ4Lt29iR+iGVN8ELrkFZiNwcNiE2Jw0gvC0zAcTwH6EAdMZmg9rSS+b
 mgIgQw5epCYt5sBO30xmRSYT4iEeJ3DjHmV23nf4D468zcJywu+HsPx7ac1wcaOJT2QMlGRXCJ7
 TBYl2rfo9YrWXS3vpWs3ohE=
X-Google-Smtp-Source: AGHT+IFh35ZHRVT1X0ripELsjIUKiIJPzU14tQePjBLctQdQnUhdesFr0HpgbIfdWi6UQJAVj1I2Ww==
X-Received: by 2002:a05:6402:1d4e:b0:5db:f423:19cf with SMTP id
 4fb4d7f45d1cf-5dc5efbf1b3mr16140476a12.9.1738248795333; 
 Thu, 30 Jan 2025 06:53:15 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7beesm132058066b.24.2025.01.30.06.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 06:53:14 -0800 (PST)
Message-ID: <800240f1-44e8-432b-a772-5a14e7746451@linaro.org>
Date: Thu, 30 Jan 2025 16:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] [U-Boot] spi: atmel-quadspi: Refresh and add classic
 mode support
To: Tom Rini <trini@konsulko.com>
Cc: Alexander Dahl <ada@thorsis.com>, Jagan Teki
 <jagan@amarulasolutions.com>, =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?=
 <csokas.bence@prolan.hu>, u-boot@lists.denx.de,
 Yoshitaka Ikeda <ikeda@nskint.co.jp>
References: <20250123121215.21001-1-ada@thorsis.com>
 <d6746615-550b-4290-ae17-42728ae68f1c@linaro.org>
 <20250130144946.GX1233568@bill-the-cat>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250130144946.GX1233568@bill-the-cat>
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



On 1/30/25 16:49, Tom Rini wrote:
> On Thu, Jan 30, 2025 at 04:07:27PM +0200, Eugen Hristev wrote:
>>
>>
>> On 1/23/25 14:12, Alexander Dahl wrote:
>>> Hello everyone,
>>>
>>> this patch series is for U-Boot, although Linux might be affected.
>>>
>>> The quadspi controller on microchip (former atmel) sama5d2, sam9x60 and
>>> other soc variants of the at91 family is usually used in hardware
>>> accelerated spi-mem mode.  It also supports a classic mode for
>>> interfacing all kinds of SPI peripherals like ADCs, IO expanders,
>>> displays, you name it.  However the drivers in Linux and U-Boot did not
>>> support that mode, yet.
>>>
>>> While spi-mem subsystem interface is comparable between Linux and
>>> U-Boot, SPI subsystem interface is rather different in Linux and U-Boot.
>>> So there's no previously written Linux support just ported here.  I
>>> tried that, but the simple implementation for U-Boot's .xfer() used here
>>> does not work for Linux' .transfer_one() because of the OVRES flag set
>>> all the time.  I guess a more sophisticated approach has to be taken in
>>> Linux with interrupts, completions and/or dma?
>>>
>>> According to commit 24c8ff4684c5 ("spi: Add Atmel QuadSPI driver")
>>> message, the initial U-Boot variant of this driver was ported from Linux
>>> v5.1-rc5 back then.  I hope it's okay to squash the fixes added to Linux
>>> after that into patch 2 and 3 of this series?
>>>
>>> Patch 4 and 5 come from my efforts to hack this feature into the Linux
>>> driver.  (Not sure if those should be added to the Linux driver
>>> anyways, even if nobody ever implements transfer_one() over there?)
>>>
>>> Patch 5 is the actual work, very much inspired by the current U-Boot
>>> driver atmel_spi for the generic SPI controllers on at91 family.
>>>
>>> Patch 1 is copied from my other spi series for U-Boot, just added it
>>> here for better build results.
>>>
>>> Patch 6 is optional, because not portable towards Linux.
>>>
>>> Tested on top of v2024.10, because v2025.01 won't build as debug
>>> for sam9x60 as described in another thread.  But there are almost no
>>> changes related to at91 socs, boards, and drivers in the last months
>>> here, so it should be comparable.
>>>
>>> Greets
>>> Alex
>>>
>>> (Cc-ing the contributors of the Linux fixes here.)
>>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>
>>> Cc: Csókás Bence <csokas.bence@prolan.hu>
>>>
>>> Alexander Dahl (7):
>>>   spi: atmel-quadspi: Depend on SPI_MEM
>>>   spi: atmel-quadspi: Port collected fixes from Linux v5.10 and v5.15
>>>   spi: atmel-quadspi: Avoid overwriting MR register settings
>>>   spi: atmel-quadspi: Remove default mode setting at probe time
>>>   spi: atmel-quadspi: Allow setting SMM to classic SPI mode
>>>   spi: atmel-quadspi: Add support for classic SPI mode
>>>   spi: atmel-quadspi: Improve probe debugging
>>>
>>>  drivers/spi/Kconfig         |   2 +-
>>>  drivers/spi/atmel-quadspi.c | 294 ++++++++++++++++++++++++++++--------
>>>  2 files changed, 228 insertions(+), 68 deletions(-)
>>>
>>>
>>> base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
>>
>> Hello Alex,
>>
>> I had a quick look over your patches, but it would require to get a
>> review from SPI maintainers to apply these.
> 
> Our SPI maintainer is currently not very responsive. Would you be OK
> taking this via the atmel tree since it's an atmel platform driver and
> not core changes? Thanks!
> 

Yes, that is fine. However the review would be to the best of my ability
only.
