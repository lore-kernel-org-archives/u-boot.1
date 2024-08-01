Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A46CC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6624688B6D;
	Fri,  2 Aug 2024 00:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqJf1LWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D9788B6A; Fri,  2 Aug 2024 00:57:45 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB24889D2
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d608060241so2172802eaf.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553062; x=1723157862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iTiCkPJKRvn+pMsIsIfXB6RQ22CGvusy/ddDV7Q5QlI=;
 b=hqJf1LWqjZ8nBmaSGpx0bAUuFdxjBvZytTUsbQNpJkk4SMieuFi+cVPUrA95xP6fEm
 fKc4MqSwZb2sZRg3spjW9hhtRG/46ueQJ6moRpqozSRCS6s2yvKyJU9bM9nIeqA779kY
 whYkgiigXoOZGuc/q2IZDEbT9rCsOryiMZDclxSEuJUAebvxiZnZoeKFyHEr4UBYDPov
 z7yiOq+dE70TBcjyfnVS6F7n2KOWbUClfesqYT1u8mkkugOeOBYEjzG7HlP8vNTY5Ehw
 g0nE+eKtGEhXDcuX5WOtqrWwmCtiD1JqF9w/OBgBsJUnrDJTzIdU9PeK9oZns69jnmIM
 Bp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553062; x=1723157862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTiCkPJKRvn+pMsIsIfXB6RQ22CGvusy/ddDV7Q5QlI=;
 b=iD7RCQjRZ8miHKwR8je/tde7o2dfjwA5tk0SwmuA1+wnyA8hbqVrCXogFTB5wmkZRu
 H+4NYVuV0+tpNU340AO4//N2M0RUY6LHD99Rx2d037KCizB2i+OmxfwilTlbMb0ikvz6
 A39mzbYQhFI1NIY+Hd7mxZDCWjDiWsShSQyOaE06p5ZE0nsI+a0GxAZv+Zd7Bc9CPByQ
 JegMqJwGwhiztdug3Obaxlw8hiOe2paushA2xlyhKTj2g/YRMaSCdczrvf42XYE+i7JE
 NCL74ztsBqIvt93tvalCO+G8WHYOgmyJ9HAzc34JzxZoQL3bhfViixk6Gd0eCSI2utVP
 wJyA==
X-Gm-Message-State: AOJu0Yz82+vvStI+taQ2/3NNYLcqmrCJ8iJiEG1jt0NzOSjzwIeqmsk7
 fVSf1SFLgZLoj9PU0sNrx/HrK/bHVrOUaZtQXdvPpmycl8urDdct+sDvLA==
X-Google-Smtp-Source: AGHT+IFlkaVUJkOqkCmkf8pB+nrw8kvltmnIUVJn0o1qnrwp85b/vhNU+nHZeiqBulLk49iPQSBUjw==
X-Received: by 2002:a05:6870:b015:b0:260:eb3a:1bc with SMTP id
 586e51a60fabf-26891ed88femr2160685fac.41.1722553062194; 
 Thu, 01 Aug 2024 15:57:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:41 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/9] Add Anbernic RG35XX-2024
Date: Thu,  1 Aug 2024 17:55:10 -0500
Message-Id: <20240801225519.336667-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Anbernic RG35XX-2024.

This device is a handheld gaming console (series) based around the
Anbernic H700 SoC. It comes with 1GB of RAM and multiple face buttons
for input.

Add support for the simplest model for now, and then iterate later to
add board detection logic, support the entire device lineup, and
move to using the mainline device tree.

Chris Morgan (2):
  sunxi: dts: arm/arm64: update sun50i-h616.dtsi from Linux-v6.11-rc1
  sunxi: Add support for Anbernic RG35XX-2024

Jernej Skrabec (7):
  sunxi: H616: dram: DDR3: adjust settings
  sunxi: H616: dram: LPDDR3: adjust settings
  sunxi: H616: dram: LPDDR4: adjust settings
  sunxi: H616: DRAM: Add alternative pin mapping
  sunxi: H616: DRAM: Adjust configuration procedure
  sunxi: H616: DRAM: Adjust size scan procedure
  sunxi: H616: dram: Update mbus priorities

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/sun50i-h616.dtsi                 |  98 +++++-
 .../dts/sun50i-h700-anbernic-rg35xx-2024.dts  | 320 ++++++++++++++++++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 178 ++++++----
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  |   5 +-
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c |   2 +-
 .../dram_timings/h616_lpddr4_2133.c           |   2 +-
 board/sunxi/MAINTAINERS                       |   5 +
 configs/anbernic_rg35xx_h700_defconfig        |  50 +++
 include/dt-bindings/clock/sun50i-h616-ccu.h   |   1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h   |   1 +
 11 files changed, 600 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
 create mode 100644 configs/anbernic_rg35xx_h700_defconfig

-- 
2.34.1

