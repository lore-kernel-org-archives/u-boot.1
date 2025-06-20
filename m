Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97329C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 07:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE69582CBB;
	Fri, 20 Jun 2025 09:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DmhAAK/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B534F82CBB; Fri, 20 Jun 2025 09:36:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7BB8006D
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 09:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so273935766b.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750404970; x=1751009770; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPpHa6OuCQEYvxwTopvovgcLnqUvQAeziTg/QnH4j/g=;
 b=DmhAAK/Q9CEpOjRs76Fjm288AEO6Nz3G5o68vA9vl+k/a9dI1Os0fAKM7i7nJxyjKm
 TPWXvkzh+TApXG7wT1hWTBsYTNzyjM0Hw04N/bTzpoarmRAvQdA397CrUZzYlCUkznQF
 l5bznW23SuWr0e4uB9Wsv4XBCVv63pwO6fdqFIC5qMQAYscAmoHy+5WhiOgjyF0n5F0F
 q3Wt00BV5Vix0uiUV7wcdI5mYzOt/UTk9wW1Dsxs/jG7xQhyOM+388nHjyhuHt/5HPW3
 TVh/Njt2CjDHRW5eTPV4On1HOZhMUmXAuxYpmm1Zx5zbmh8Hpwc2x304OABO8XaHw1eE
 ZHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750404970; x=1751009770;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hPpHa6OuCQEYvxwTopvovgcLnqUvQAeziTg/QnH4j/g=;
 b=QxmDhkt2ZUUel0OJKjMBVOYaMjCSp7W+x+v7TqDaNh16I3R8xSh7e9IbfD/maN3kSa
 3fZZ0GwQD8Fu/ZnIRDnBYSdALmoZ2ChRQSk0HUHakA3TAC2njM1G8Rf2OuzV5khk1k3J
 vENHvpCj7XrUL4iWPkd/eSfamOfTbIjDiuEazlLsIlbfM4EEM6jx1blv20+9vSdWO4u1
 DVmL7BQT6z/dVJ8qrE/1dFQnZR5/KZv9D9DPY6tfGwZUOhyePsaE/nu6cY6bj/StacXU
 5vM0dMCs+q3t5/0uAECtediw+0JExEaZwEYxbX8jmBRXqIyEIA+HSt5SFQndfyNwojPy
 //EQ==
X-Gm-Message-State: AOJu0YziPQ6bKOUBZwDdLns51PkC4LFB7HJNzmzkZTb/F7Sx0pJFdukn
 mQormZtJm9kytIRu0M7kDk5zSMzTxo/U3OFcwRxJuvHp6kKiyqFiheMAuMQKhAem/QxfTkQgiDa
 sTPAC
X-Gm-Gg: ASbGncvK5g1VXUyikgdzt7wYhOvJXmW4x2G2bqDolrMtimNtAO7pgfnHjj5ucKvxD/B
 4Bb/oZRCWcIiM7Y4UYMcUvn10me+6Ki8jlfhMDDiFDInn2axRkizmlzbgm2CYTD0F9PqeR1j1uw
 0V76IvDcV45FdM2hgXlMpzXURb+BpGbePad+4fZjGWkClCvyRO6sZ+f/aAv9iqTnxr3pqb8AOsd
 ognU8c9b6ybcaFNMwDYQsZ4xm3fGHL35nYPGaTSEb26+L7NyLilbu7A7vUlCzd1pFeoHpB3fm1S
 LoCFkNpmbCDWueG0O2ZzBktg1ZU2+M9uVTGFDEJj7vf8BT8fh4a7JPvpgA8Nbs49zRXYLQ==
X-Google-Smtp-Source: AGHT+IHJmON7aMBxIeblbozpqex3lT3/qi/lCKfSh9UjKkSc1DLZFUFUub8EYg1lRNIqf0WHJq/RCA==
X-Received: by 2002:a17:907:b00f:b0:ad8:9084:4ec0 with SMTP id
 a640c23a62f3a-ae057b894cemr94259566b.35.1750404970403; 
 Fri, 20 Jun 2025 00:36:10 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0541b6e41sm115215766b.121.2025.06.20.00.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 00:36:10 -0700 (PDT)
Message-ID: <ce9f3c01-1025-48cb-8f4f-aa27781fa5df@linaro.org>
Date: Fri, 20 Jun 2025 10:36:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL next] u-boot-at91-2025.10-a
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

Hello Tom,

Please pull tag u-boot-at91-2025.10-a , the first set of at91 features
and fixes for the next 2025.10 cycle.

This feature set includes the addition of new sam9x7 SoC and a new board
named sam9x7-curiosity. There is also new support for sam9x60 compatible
at91 watchdog.

Thanks,
Eugen


The following changes since commit ce2a7fcbd565d55b1d3fdc0e68edd50a21eca7d4:

  Merge patch series "list.h/treewide: get rid of no-op prefetch()"
(2025-06-18 08:05:29 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2025.10-a

for you to fetch changes up to 9b9a2c99946a7ad43d9716618ae48ea01947f5fa:

  configs: sam9x75_curiosity: Add initial mmc default config (2025-06-19
13:56:43 +0300)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2025.10 cycle

----------------------------------------------------------------
Fabio Estevam (1):
      board: sama5d27_wlsom1_ek: Get RAM size and base from devicetree

Manikandan Muralidharan (5):
      dt-bindings: drop at91.h from clock includes
      clk: at91: clk-main: drop parent_name check when registering
main_rc oscillator
      ARM: dts: at91: sam9x75_curiosity: add tweaks for sam9x75
curiosity board
      board: sam9x75_curiosity: Add support for sam9x75 curiosity
      configs: sam9x75_curiosity: Add initial mmc default config

Varshini Rajendran (4):
      clk: at91: sam9x60-pll: add support for core clock frequency inputs
      clk: at91: sam9x60-pll: add support for HW PLL freq dividers
      clk: at91: sam9x7: add pmc driver for sam9x7 SoC family
      ARM: at91: Add sam9x7 soc

Zixun LI (6):
      arm: at91: wdt: Remove at91_wdt struct
      arm: at91: wdt: Rename regval in priv data to mr
      watchdog: at91sam9_wdt: Rename priv to wdt
      watchdog: at91sam9_wdt: Add SAM9X60 support
      ARM: dts: sam9x60: Add watchdog DT node
      ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 MAINTAINERS                                        |    1 -
 arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi    |    4 +
 arch/arm/dts/at91-sam9x60_curiosity.dts            |    4 +
 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi    |   95 ++
 arch/arm/dts/sam9x60.dtsi                          |    8 +
 arch/arm/mach-at91/Kconfig                         |   12 +
 arch/arm/mach-at91/arm926ejs/Makefile              |    1 +
 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c      |   49 +
 arch/arm/mach-at91/include/mach/at91_wdt.h         |   25 +-
 arch/arm/mach-at91/include/mach/hardware.h         |    2 +
 arch/arm/mach-at91/include/mach/sam9x7.h           |  172 ++++
 arch/arm/mach-at91/spl.c                           |    4 +-
 board/atmel/sam9x75_curiosity/Kconfig              |   15 +
 board/atmel/sam9x75_curiosity/MAINTAINERS          |    7 +
 board/atmel/sam9x75_curiosity/Makefile             |    7 +
 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c  |   66 ++
 .../atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c  |   11 +-
 configs/sam9x75_curiosity_mmc_defconfig            |   73 ++
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/clk-main.c                        |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |   55 +-
 drivers/clk/at91/pmc.h                             |    2 +
 drivers/clk/at91/sam9x60.c                         |    7 +
 drivers/clk/at91/sam9x7.c                          | 1085
++++++++++++++++++++
 drivers/clk/at91/sama7g5.c                         |    6 +
 drivers/watchdog/at91sam9_wdt.c                    |   55 +-
 include/configs/sam9x75_curiosity.h                |   23 +
 include/configs/sama5d27_wlsom1_ek.h               |    6 -
 28 files changed, 1749 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sam9x7.h
 create mode 100644 board/atmel/sam9x75_curiosity/Kconfig
 create mode 100644 board/atmel/sam9x75_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sam9x75_curiosity/Makefile
 create mode 100644 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
 create mode 100644 configs/sam9x75_curiosity_mmc_defconfig
 create mode 100644 drivers/clk/at91/sam9x7.c
 create mode 100644 include/configs/sam9x75_curiosity.h
