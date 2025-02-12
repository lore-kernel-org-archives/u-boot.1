Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B698C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B6780C69;
	Wed, 12 Feb 2025 17:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O115TcY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFB480C7E; Wed, 12 Feb 2025 17:16:31 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36888001F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1111214666b.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739376988; x=1739981788; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJiOafMxOt/IWtkCY4NIFYSOVKvpeLUIIHUmIMCFJXQ=;
 b=O115TcY9jSo4TdKc40b6g72WR/5Z/h13ERWzQWjehdLixwXn7jKvm2UzpPHf3El/Pm
 /TozEwK8HsEJj5Q8WwnKIu6Y0xJQR2CTzQf6tFMKPdZhmr/PUwss8yAQWUWIECiKz63Y
 wXDCzAbPxub26KgO2e9byKCZ5Yye96UJyMaK4Q3JKGgaAy68g2quYanpV7QTUHHh5PBM
 NN6v7cxuynaLlU3uYT1ch2BPrsXEyiKeAPCsDdA5jNTIIr8ptaO7knbhuZuxCawzVCy8
 sNvX58YDXsq8p6CamM3J7g6A3R8WUkgEMoYrjzUI1p8//JfwAuBYd4bfho6JLfQHEWX4
 tMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739376988; x=1739981788;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJiOafMxOt/IWtkCY4NIFYSOVKvpeLUIIHUmIMCFJXQ=;
 b=WerTW+x8ekrPhlqTjonJIRrJFEelBbFivcZZqjOQnej889HsnNnItEn7r8fbx+xDWu
 SMT95Jj46zng1U7TtKokJPHR0onZlS7EQWHmovvVSB0DlpSoWs8/LaJle9FcEPUe9fIJ
 wujUfTSPFlv/JHMAck5hI8JSSckf0aj5m/3YqqvLZQJ9Bn6piSnDUfbFkjQekjTR3PPl
 g40Nu9+HS5b6IM8EoGyOFqtUzoKn6MKCZYYIXnNgV6fm2t6ePYJvM6rEZfCJYXwyI/Ov
 Ok/dGxMmHVDaO3JUc/6obtsfQJ/hngFYIeP40hM0mf29hVeXQH5IJbcwhERCrPwS9oG6
 PXTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Qx8/NCunKIZLvYSSxyDcCecP+tsoTdxnDdqWPk2IhHbL28nWelTjy0V3QtdRCfyg/naG+AM=@lists.denx.de
X-Gm-Message-State: AOJu0YyqNRhwzrgQwuF6QqcWoV0KIOCzIytURcTQsIaGT7994eB+koYd
 5/58P32JMq6gsB2Pq34VGxva1/00vkdaT4LxcMWWuQo/CeQSCjCW9UmzjQ8uO/s=
X-Gm-Gg: ASbGncuej2ovq8aiUWaYwGnKR2T56HxnFRL0u102qVPpZASM73DuiZIfZvx+yAMFPd4
 C+ZMd5q77fGuu7EFDYFSyNBjHYBfgC3lbJVU02oN6/nzHWDNl3lJu7ugVq3OqtHVEx8l2KkPwak
 J39ML/eyp2HUpa456CkaQ3+5xIUPzzsxVJapH2+Y2y/YDbi3I0Y9TlBrI5aAwSsC3dHc4sAcrbC
 ymmXtoY1tshL9uUCFPdJ82qGK21juhZgD3u+Oq3VDKw5rcjhJ8kafoU12TC1h1R8HMEl3E14fyk
 OSwAKeP1+2ub0VsP1VnSCIE=
X-Google-Smtp-Source: AGHT+IF30/b4xTJ0l64LP3w/MDJ+egW1Ddi+Gx8NtyOBM0oQ3GiU11gC40S4PVP8zNB3sVYBW59aig==
X-Received: by 2002:a17:906:7807:b0:ab7:dec1:b353 with SMTP id
 a640c23a62f3a-ab7f34aeca8mr350888566b.49.1739376988218; 
 Wed, 12 Feb 2025 08:16:28 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7bc28c58csm696245966b.135.2025.02.12.08.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:16:27 -0800 (PST)
Message-ID: <20c051a2-2643-4dd9-a21c-294d3b00c869@linaro.org>
Date: Wed, 12 Feb 2025 18:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] [U-Boot] spi: atmel-quadspi: Refresh and add classic
 mode support
To: Alexander Dahl <ada@thorsis.com>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?=
 <csokas.bence@prolan.hu>, u-boot@lists.denx.de,
 Yoshitaka Ikeda <ikeda@nskint.co.jp>, Jagan Teki <jagan@amarulasolutions.com>
References: <20250123121215.21001-1-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
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


Hi Alex,

The code can be improved, but since you preserved the original source
and the code works, I will apply the series as-is.
You can further work on this whether you see fit at a later time.

Applied to u-boot-at91/next !
Eugen
