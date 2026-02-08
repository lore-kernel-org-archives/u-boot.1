Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C775EF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 16:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CCAF83642;
	Sun,  8 Feb 2026 17:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z05dqJUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB168366F; Sun,  8 Feb 2026 17:04:10 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C8680325
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 17:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4359a302794so1388777f8f.1
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770566645; x=1771171445; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dzo7Hx4n8smdo3erIKnfLW2BqjjYa6R58g0YaMGP7D0=;
 b=Z05dqJUtJURAmve4hFRyn93l+LtwFqP29MkU8ENs/oiOlbMKz8XLP+FEW5rWbkYk0i
 H4KDNrKXEvbqCI0dMixh5omNodc/wkQDu7yv4xCBbLvPFfExNN2QvQNbYgWaVosiwyBY
 P1mvlYr5ygqERW2MGtgdSfR3KHz3Lf7+Tu024rZYAgfwwdhEc53gsz2MI3b7B82vOp+k
 nB4KuXrnp4FCDwkY8KoJrpvKbjX7nqxZjqwOINWMNjxUFZpLlkEwD0lyz/z/kqnz4WVw
 j3m20SusKJmanyOinNN1D51gXs0qpVXzhwZmJuxK+rptvCgKOonwVb/9gyVzIYNCz7gS
 ee0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770566645; x=1771171445;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dzo7Hx4n8smdo3erIKnfLW2BqjjYa6R58g0YaMGP7D0=;
 b=CJG8silUGCpLc7bHjldbPsjx0ykzFJrbtV3xrtSxtZon2tEC3jsmdi+5J/krz1cRY+
 Nt7Eb8BFwPOrxU/pYsDnsyouYj9zJ0+j+7/sSz74iZqko0eHnEzTT4pB46Y2s6wHhgcI
 ivfLCn02/+5iDDWZ7qbDmDOJhFvs8YGppCVeUpv/EHIVhPu8TzbXcdXboLmnUA641HgS
 7HNEYPRDeBtlqaSDmqbqxvMw2WfsB79lRHsHNT85K+BwBYr4sTDOeVFYSqGkYCMJDbRi
 /sO7dPdi5eMl6C78vrpqqzpflJpd+FZQIqhRJuBD60mQMyRadWh3ft/6xfUMarC7BYq2
 DIIg==
X-Gm-Message-State: AOJu0YxTJuMSeSboXOZ6YbDf6ALCcGaSXY52z0SPcf3zojrpxIl21w6w
 8KMU1PUoH3YPq3a28Qwgzj+8gTZisZDplXiqIFaQBDtNl69plcS9u5fYor2RqNFI54DPrqmprmU
 1SDzuFJU=
X-Gm-Gg: AZuq6aJ+rOv9jJEuqc8AMi2j6k9GIgQSrfsOkSJefc5zQHSlXv4dj1G95AV+qlbDCZK
 jMmEJClvdHr7kFrZgkoLROsLf2lb6jZrsZ1jKf8RVArxH/pvT9HddjL8i2CrDKso+NOMSFlmi74
 MUD9Y3axP8Qqt6PZqXQ5CrXTWKlOrx5UBaENmWSDxhqWFLUqIZGhkRGKmjjiTDBfTi9gSZuDlSx
 lFfgE1CWraIu46jVW5H0bLP+rPF7jvwjquAR28fR0kgzb1/KVHGi/LSOguemWPAiYyThlBdsFyh
 U7h4UqBqLuelS8MRBRQ4qBTgNOm/iZhwK0kkSIZprDBDCTvMS+hYg3fUUyvf5iiMh8B56S2rKZQ
 4WtCOZeJeErFth3rcZCrGt1PXGH3yyCGeIVY5ZrtkckVsKhg09qyOfuiruxsKOIajjNh6iSOSh5
 ilsuykOhz+HWIh9hj7RQ==
X-Received: by 2002:a05:6000:22c4:b0:436:1517:aec7 with SMTP id
 ffacd0b85a97d-4362933efb8mr12747037f8f.17.1770566645027; 
 Sun, 08 Feb 2026 08:04:05 -0800 (PST)
Received: from [192.168.0.34] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629745f7asm17662283f8f.33.2026.02.08.08.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 08:04:04 -0800 (PST)
Message-ID: <ab0c56f2-0f5f-4c6d-9a7b-4abb74adeb1a@linaro.org>
Date: Sun, 8 Feb 2026 18:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-2026.04-a
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

Please pull tag u-boot-at91-2026.04-a , the first set of at91
features and fixes for the 2026.04 cycle.

This small fixes set includes fixing 64 bit builds and some warnings for
the at91 serial driver, and some cleanup on the nand driver.

Thanks,
Eugen



The following changes since commit a8d982e1f1726254ef27bbdf362f98954ee3feb7:

  x86: cpu: Fix crash on FTRACE enabled builds (2026-02-03 12:51:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2026.04-a

for you to fetch changes up to 1690228bac43cf5bb0dd4473abe68cca8400f23c:

  mtd: nand: raw: atmel: Access device ofnode through functions
(2026-02-04 14:13:02 +0200)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2026.04 cycle

----------------------------------------------------------------
Andy Yan (1):
      mtd: nand: raw: atmel: Access device ofnode through functions

Robert Marko (4):
      arm: at91: move atmel_serial.h to include/dm/platform_data
      dm: platform_data: atmel_serial: fix build warning on 64-bit platforms
      serial: atmel-usart: include arch specific headers only for AT91
      serial: atmel-usart: add support for skiping debug UART init

 board/bluewater/gurnard/gurnard.c                      |  2 +-
 board/siemens/corvus/board.c                           |  2 +-
 board/siemens/smartweb/smartweb.c                      |  2 +-
 board/siemens/taurus/taurus.c                          |  2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c           | 18
+++++++++---------
 drivers/mtd/nand/raw/atmel/pmecc.c                     |  6 +++---
 drivers/serial/atmel_usart.c                           |  7 ++++++-
 .../mach => include/dm/platform_data}/atmel_serial.h   |  2 +-
 8 files changed, 23 insertions(+), 18 deletions(-)
 rename {arch/arm/mach-at91/include/mach =>
include/dm/platform_data}/atmel_serial.h (90%)
