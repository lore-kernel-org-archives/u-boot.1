Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCA1C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DDCF831C8;
	Mon, 28 Jul 2025 17:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KW2LZ2te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5306F831D8; Mon, 28 Jul 2025 17:19:09 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E11831BE
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61557997574so951409a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753715946; x=1754320746; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hswj5MqffyJQr+UUmp09lTIxaqsY9MvOHoNju1i68R4=;
 b=KW2LZ2tetOqQAZ8BTq1VHJHvjhtr4j7yMG5sdxrm5nBixV0Zues+vcB528/XD+v3jC
 inN2Vf0y1mV6x+ovyTu2B9zkabIRx7HSlSBvFOBKF9cokjPkAY5L8Sbt54pW0r3BhttF
 CtaoyWJCpxD8j861PUkQ0djpGcJ1IfZRlVDievIY/OU2UE60+MUbHceRQ56nzbaCrWtl
 uyOUltm+vM2zAV61586XRgffwbewUnNDK4XmoSrXCO4VBiMhRyA3jyUcvzGUONtRO839
 VfBm+o3HtL06Xnlzl8zfIWM7E7aUt/QwH0MIw0HskEwKRJ9lV5LTZWca7o/tA0jSqvOA
 A0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753715946; x=1754320746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hswj5MqffyJQr+UUmp09lTIxaqsY9MvOHoNju1i68R4=;
 b=VdhLwPABET91fMbcxFkRqU3uAzok/RzCyHXHWt5s+FEU9P4vfAzxFJQ0xMimviYdoF
 S+rEu9Zz2vE98VwMreV7MmIbMWgw0FI4qpucOQ3fBgVRWz+ztCBBRMWygOhpdCWJfTPF
 LJVKGDFAKNNMWthbiC9plsuJYS/US5ZlOrTVo9oLBKkpYM5yUtcT1Z5g5X5nJH8HAVZZ
 DESKqru6rA8NFCgBzj0IEeII65nFymcjRIqiynpvWBL6h4k1YWrbAwv2stxIrUcp6w7s
 +sYyvX8BRSiUtkTr3jGucfgr/c3eO2kZLpbLKnB66/ni8gQ7se5BWlLQNdpFskHCxKVL
 KOzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX19UnyTIAE3dFpKpT3wwLwfDTVzBwizZenFeMnrDrZ5xKmklNzA+/3A1avGi54Oo90PUeJXwQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0oLWEat0hZQ+pSXYjqTDPkT+0GnyjAJP48M7gR3HEmZSmBjxI
 cUeOR2JIICTJ2KKxGDhcRCWbGmhGcwXyDSpeGMMnMZQKwDVqEebDZqjkSPcb6E2nFZA=
X-Gm-Gg: ASbGncsoymCslkb9zRYzRgWPZMH2gzU+3R7oGoBQ/9dX415Fbrn8VDrMO4y+5ewkegD
 B+zG8I5Bdlnl0H2DZzeIWVBwAvOIhcW1AmchobvzLwgUhzSuD2DJddG9kFamks8J2wV6JxOC98h
 6wLG3/Od2vLh0mJFByv9frb04lVki/AiTwQ43KQloMfk//TtGm5RbWOpnSMiTeu/Gm7dVSswbt6
 x7cEeYRnfgN8zxtO2AVUr6GmG8SEGsWIFv9Rc34LXl8B/3fSKXlBFzHeIYZJhKWMEjhQBDzfkGi
 RhcB6LKLLB6L/0n+Z8EWvx+jmiZ6RoU2fSVmcXCZUTxpVU0E01+ZkOqwxX/2tSKb9kdXDDnJoCo
 zjDLfad1OpDRFt+ee0TkL7uMIJ4+qV2+6qXcz
X-Google-Smtp-Source: AGHT+IEtWQ5bn9Q8npJGH1Kgun4DCup2FHmuPPdvNneAlqXXc9i/OrNyeSCIaH8XV/zxP1++CTpWgQ==
X-Received: by 2002:a05:6402:1d4c:b0:60c:791e:586b with SMTP id
 4fb4d7f45d1cf-614f1a88a18mr12344937a12.3.1753715946004; 
 Mon, 28 Jul 2025 08:19:06 -0700 (PDT)
Received: from [192.168.91.100] ([185.132.172.209])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500491c53sm3419656a12.10.2025.07.28.08.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:19:05 -0700 (PDT)
Message-ID: <dad9299a-4005-4cef-b5f1-a7dec22afb9b@linaro.org>
Date: Mon, 28 Jul 2025 18:19:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add support for sama7d65 SoC and sama7d65 curiosity
 board
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ryan.wanner@microchip.com, lukma@denx.de, seanga2@gmail.com,
 manikandan.m@microchip.com, nicolas.ferre@microchip.com, sjg@chromium.org,
 balamanikandan.gunasundar@microchip.com, Romain.Sioen@microchip.com,
 u-boot@lists.denx.de
References: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
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



On 7/7/25 14:29, Varshini Rajendran wrote:
> This patch series adds support for the new SoC sama7d65.
>  - sama7d65 SoC is added
>  - Clock driver for sama7d65 is added
>  - Target board SAMA7D65 Curiosity is added with its differences in DT
>  and MMC config support
> 
> Ryan Wanner (6):
>   clk: at91: Update MAX PLL and master clk ID
>   clk: at91: sama7d65: add clock support
>   ARM: mach-at91: add support for new SoC sama7d65
>   ARM: dts: at91: sama7d65-curiosity: Add DT tweaks for
>     sama7d65-curiosity board
>   board: sama7d65_curiosity: Add support for sama7d65_curiosity
>   configs: sama7d65_curiosity: Add defconfig for sama7d65_curiosity
> 
>  .../dts/at91-sama7d65_curiosity-u-boot.dtsi   |   80 +
>  arch/arm/mach-at91/Kconfig                    |   13 +
>  arch/arm/mach-at91/armv7/Makefile             |    1 +
>  arch/arm/mach-at91/armv7/sama7d65_devices.c   |   31 +
>  arch/arm/mach-at91/include/mach/hardware.h    |    2 +
>  arch/arm/mach-at91/include/mach/sama7d65.h    |  107 ++
>  board/atmel/sama7d65_curiosity/Kconfig        |   15 +
>  board/atmel/sama7d65_curiosity/MAINTAINERS    |    6 +
>  board/atmel/sama7d65_curiosity/Makefile       |    7 +
>  .../sama7d65_curiosity/sama7d65_curiosity.c   |   75 +
>  configs/sama7d65_curiosity_mmc1_defconfig     |  108 ++
>  drivers/clk/at91/Makefile                     |    1 +
>  drivers/clk/at91/clk-master.c                 |    2 +-
>  drivers/clk/at91/clk-sam9x60-pll.c            |    2 +-
>  drivers/clk/at91/sama7d65.c                   | 1451 +++++++++++++++++
>  include/configs/sama7d65_curiosity.h          |   20 +
>  16 files changed, 1919 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi
>  create mode 100644 arch/arm/mach-at91/armv7/sama7d65_devices.c
>  create mode 100644 arch/arm/mach-at91/include/mach/sama7d65.h
>  create mode 100644 board/atmel/sama7d65_curiosity/Kconfig
>  create mode 100644 board/atmel/sama7d65_curiosity/MAINTAINERS
>  create mode 100644 board/atmel/sama7d65_curiosity/Makefile
>  create mode 100644 board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
>  create mode 100644 configs/sama7d65_curiosity_mmc1_defconfig
>  create mode 100644 drivers/clk/at91/sama7d65.c
>  create mode 100644 include/configs/sama7d65_curiosity.h
> 


Applied to u-boot-at91/master , thanks !
