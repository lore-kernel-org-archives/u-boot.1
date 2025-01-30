Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C030C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA5E80EC1;
	Thu, 30 Jan 2025 15:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LeR0fhYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F21A980EE5; Thu, 30 Jan 2025 15:07:31 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9794880E9A
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso5991935e9.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738246049; x=1738850849; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rpAkSrY21J1Ghjso3YWqK7zbBjyYYUoNHB8MRCPWOD0=;
 b=LeR0fhYhgv6DrKml9apUdl2NvyUgXeFw5VV3+O3RR/L/nzL+uLXSdVObXZFK6nq3n0
 +KuDFDTQjOxolwJBds4sce2hHMV6vkLfh9yn3ydZ5P+YA46RtkHUI+8gQtMbrxBYEGPg
 KFDdTJ74kM5xw0qRjvctkvYcQsSJ5wzbxEhfRejwGjtxr9AMJW/T1OYX5DLqjfIX3Kki
 pKfFQw8hxogrqkCDnQGAfdScsAU0S80oRK9NTAKyNlJZAufqdNGBfMZwi/lAbJDNAE6G
 QpFjfiAi2zHQ9kG6gvJLfB/b190T2GeUczO2QA5tFtoRNOcGBFkDrePI0zcOyCKJnq5m
 tQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738246049; x=1738850849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rpAkSrY21J1Ghjso3YWqK7zbBjyYYUoNHB8MRCPWOD0=;
 b=W9QMf6fi2aaXUHO0a+1Tuj+KOXDEzD/Zr0dAigTauDYZGHB/C23A4TIdi+8LKiXNA0
 aqn0pP6grgsNP32ugiCm8zwxmiP2zyA2J7UIax7W090/hkz8XIXKqOQIeKz+beKKFhzI
 JVNl4BicTP0YeBAjAunZkZPc/70Q7qailjR+s6zvXP7ZMY9tbIpy52jjBT5ofdM4/EFX
 smNIdGHWG50iKrD85BSJ7Hn9CyNisqIT1g7sfVu0up4O61/XzRTdxhN2PdKPyjZ91bkZ
 hp56fDpwhm1SnlbolOEbixj0A5iWxjgnCAQ6DHdIFgVs46EywoNnwAONP+jsKTQOffup
 WY5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYIHFLdt7yVBz7xWX4WrhoJiMEQz/Q0Jo2mzDms6qN1kmO9/lce2gzne7Ym9Q1B/p5x31CqPc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx20x9Bfr96Je023Gz+8jrk2reLeGFAZrWI4CuPL5lZJAXqpHfL
 G+sIkJ3Thv74NNgNSmnrJ3863UkPQAyvxCDq+u3mw5t1iLYUhDTLfHfAw+Lq/zI=
X-Gm-Gg: ASbGncu1iuS6xgkDk0xIwI2Bp12kKZ1/mFzrsV2Uc59G1eru4IvaxeGv07TDpm4zwE3
 44Pm8wPOrRo4cLBv6Kg/FkCwF4i6NuazxXr/DYG+JKiRdq1NbIYd/HQYGgKT/AhuH3aVMrPmumm
 mwmvoRcLn94QITwdbmuxyxye5kEenU/vxHdN46hNz2v8XtbCuzQKR4K/AxaOBngNAZAg95yuj0z
 OgD6OAnnWNrYoPzHdqcmfBLr09qOe8rIMgDW9PQi2fkDX+AeX18cXlnhhZQHbbu8scoOKpdWGQL
 Bq1dwrEzBPTYVeIQGHqsLvs=
X-Google-Smtp-Source: AGHT+IETNelhbix9i1a50Y2HfcNcp40tu1vgdv0VCs7RRFBgz8w9o88a15XrJ8vd96lAD1HzImdNJg==
X-Received: by 2002:a05:600c:1d1e:b0:436:a3a3:a70c with SMTP id
 5b1f17b1804b1-438dc4214c3mr50052755e9.28.1738246048998; 
 Thu, 30 Jan 2025 06:07:28 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244f0d2sm25036315e9.30.2025.01.30.06.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 06:07:28 -0800 (PST)
Message-ID: <d6746615-550b-4290-ae17-42728ae68f1c@linaro.org>
Date: Thu, 30 Jan 2025 16:07:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] [U-Boot] spi: atmel-quadspi: Refresh and add classic
 mode support
To: Alexander Dahl <ada@thorsis.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?=
 <csokas.bence@prolan.hu>, u-boot@lists.denx.de,
 Yoshitaka Ikeda <ikeda@nskint.co.jp>
References: <20250123121215.21001-1-ada@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250123121215.21001-1-ada@thorsis.com>
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



On 1/23/25 14:12, Alexander Dahl wrote:
> Hello everyone,
> 
> this patch series is for U-Boot, although Linux might be affected.
> 
> The quadspi controller on microchip (former atmel) sama5d2, sam9x60 and
> other soc variants of the at91 family is usually used in hardware
> accelerated spi-mem mode.  It also supports a classic mode for
> interfacing all kinds of SPI peripherals like ADCs, IO expanders,
> displays, you name it.  However the drivers in Linux and U-Boot did not
> support that mode, yet.
> 
> While spi-mem subsystem interface is comparable between Linux and
> U-Boot, SPI subsystem interface is rather different in Linux and U-Boot.
> So there's no previously written Linux support just ported here.  I
> tried that, but the simple implementation for U-Boot's .xfer() used here
> does not work for Linux' .transfer_one() because of the OVRES flag set
> all the time.  I guess a more sophisticated approach has to be taken in
> Linux with interrupts, completions and/or dma?
> 
> According to commit 24c8ff4684c5 ("spi: Add Atmel QuadSPI driver")
> message, the initial U-Boot variant of this driver was ported from Linux
> v5.1-rc5 back then.  I hope it's okay to squash the fixes added to Linux
> after that into patch 2 and 3 of this series?
> 
> Patch 4 and 5 come from my efforts to hack this feature into the Linux
> driver.  (Not sure if those should be added to the Linux driver
> anyways, even if nobody ever implements transfer_one() over there?)
> 
> Patch 5 is the actual work, very much inspired by the current U-Boot
> driver atmel_spi for the generic SPI controllers on at91 family.
> 
> Patch 1 is copied from my other spi series for U-Boot, just added it
> here for better build results.
> 
> Patch 6 is optional, because not portable towards Linux.
> 
> Tested on top of v2024.10, because v2025.01 won't build as debug
> for sam9x60 as described in another thread.  But there are almost no
> changes related to at91 socs, boards, and drivers in the last months
> here, so it should be comparable.
> 
> Greets
> Alex
> 
> (Cc-ing the contributors of the Linux fixes here.)
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>
> Cc: Csókás Bence <csokas.bence@prolan.hu>
> 
> Alexander Dahl (7):
>   spi: atmel-quadspi: Depend on SPI_MEM
>   spi: atmel-quadspi: Port collected fixes from Linux v5.10 and v5.15
>   spi: atmel-quadspi: Avoid overwriting MR register settings
>   spi: atmel-quadspi: Remove default mode setting at probe time
>   spi: atmel-quadspi: Allow setting SMM to classic SPI mode
>   spi: atmel-quadspi: Add support for classic SPI mode
>   spi: atmel-quadspi: Improve probe debugging
> 
>  drivers/spi/Kconfig         |   2 +-
>  drivers/spi/atmel-quadspi.c | 294 ++++++++++++++++++++++++++++--------
>  2 files changed, 228 insertions(+), 68 deletions(-)
> 
> 
> base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a

Hello Alex,

I had a quick look over your patches, but it would require to get a
review from SPI maintainers to apply these.

Eugen

