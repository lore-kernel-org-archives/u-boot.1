Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05B4C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F072849FB;
	Tue, 30 Jun 2026 03:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JaRHyZho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679DA84A0E; Tue, 30 Jun 2026 03:19:21 +0200 (CEST)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8E484119
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-13981833e13so4813423c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782357; x=1783387157;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hktvyZoMJZ1nzZIvS5XT2IINVRcqMLPPGr0dmJF/Ysk=;
 b=JaRHyZhodQX1QxqVdU9jqA1n4HDoKiK6gqWSN2NZk33NyyzslD4LmGCezfh/GZGkNQ
 QiBagugrCMmN8OdIOuujRWCUk/SoETzmt9GlmELf4rL8HzCgz+5pZSmOLRovDvMi2ArX
 uEQhqxpDDYeO2RtYcJrEEKsF6ggY1jQ2h9he0AU4/J8UnzlATPU2w6wWwytm4Uk3nPc2
 ZtnSXZT5scs/Ku9uCjNrDTFKXMa22X6FcQ4PPIlsIERJJr+W42FP4TtedaOMcJuAgAum
 Oji9BS7IntU8UjYDPmrR+nt4wVcSLTKGiNCjR/V88XaDtmdVHC9l2dz+IvvvCqJSgHyV
 ONVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782357; x=1783387157;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hktvyZoMJZ1nzZIvS5XT2IINVRcqMLPPGr0dmJF/Ysk=;
 b=JMHnAKTDLktzys/Nzsb/1weSdqEg3vwG6FRrpWDJgHbh2w0P3ArkXWhMAxnnuvLhCL
 DorGBTwFGgxzKzF8SG9lx15pItj3gsFSGr/9pyebX1ABzuajKBqHF3CXL3dDVHUt50lz
 NjYPlQ9C/xeEWcyltliPenpQUKf27VcirMRFNuqQpo+Q6r+LfXbfhTfJvyZEhoO262BE
 Tco9Mtd5BILPD748HphwZ+3vOKUSox4q5BaModT0TUS02wuLr/BjNaXlywzuEJIYZWj2
 bV8HZi3bnGJDgZqimJsv0f6ChJEK9qfuBJbiMnIsg/1wPS3ycQX9t194j6qSsAqCLEPF
 A8qQ==
X-Gm-Message-State: AOJu0YxHS65HZjw6TwKsAm0z6vTYygSutFRrNQAh1ReWj3m2ZiInkfVf
 JFX60uaX2JWj+0ls57ku8v+N0Kc8IrRi3x3zcwgR76yRe4oqDxGGrYdZ0wmgCxoYjgo=
X-Gm-Gg: AfdE7cklhge/H9EcY5HaCBN5CsB/JiDOLn+5kRC1mxr/Bis9Q8B2PL4xBl6jfuWvRZY
 2FZVVxvzodHJQcTiLPGctNDTY54F30BXmCeEra0CzZsafrmr0kqCCNS9Ev69cEQyeU5Whttt0U2
 OJ7wdb9OM/S30GbnY6+soWy7mHFim9nifQyhF67AozyTI7dKVLfqRP3sxEznWEzi0GnDknTGEfK
 GQNaZ2YRvCNxmxBAx7R4fU2idMMVNHyHYxE4OxIGStfks3qbw1Lng2HI7po0GbjQDiRAKxax3Gk
 c6paSPlgTDPGZa5R0KPXChj7ZDyGKsyFQN5UJE8CqxcSyBlqQPmfvw53WUB8qfTGP6k5cfq8bId
 PLgj1kOp1VsXMvCySHUm6RV+T3RlTbE7Lt5Ta7ZZy8friz6u61rxWFDIDQA85ifbsr67DYq/Me5
 9myV6nIImG/duQGdmDq14ZDl/ReyBBYxha3FYO+3Zclpid7A8vBlmGnI6XQy7Jb97CmO4IjzN/V
 y2qcu3Nr8jOL9ozqOLL0qRr621voPW/ST9oWWi3D39wnS7hqjxYLA==
X-Received: by 2002:a05:7022:ea25:b0:138:49ea:f468 with SMTP id
 a92af1059eb24-13b2a1607acmr923851c88.2.1782782357227; 
 Mon, 29 Jun 2026 18:19:17 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:16 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v5 00/14] riscv: spacemit: add Spacemit K1 SoC support
Date: Tue, 30 Jun 2026 09:19:01 +0800
Message-Id: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYZQ2oC/yWM2wpAQBRFf0X72dQxbvEr8uBycJRLM0jJvxs8r
 t3a64JlI2yRexcMH2JlmR0EvodmqOaelbSOoUknlISkpkClWVwxRVpHRHDiariT84sUOGKU/2b
 3euRme9+47wdcleFyagAAAA==
X-Change-ID: 20260630-m1-795ae0422400
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

Changelog in v5:

- Rebase v4 patch set on next branch.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
Guodong Xu (2):
      clk: spacemit: k1: prune SPL clock tree
      doc: spacemit: add K1 SPL build and test guide

Raymond Mao (12):
      spacemit: k1: support multi-board infrastructure
      spacemit: k1: enable SPL with debug UART
      configs: k1: enable early timer support
      configs: k1: add default option for clock driver in SPL
      dts: k1: enable clocks in SPL
      board: k1: initialize clock and serial devices in SPL
      i2c: k1: add I2C driver support
      spacemit: k1: add TLV EEPROM support in SPL
      spacemit: k1: Add DDR firmware support to SPL
      power: pmic: add support for Spacemit P1 PMIC
      power: regulator: add support for Spacemit P1 SoC
      board: k1: enable pmic in spl

 arch/riscv/Kconfig                              |   8 +-
 arch/riscv/cpu/k1/Kconfig                       |   6 +
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi       | 100 +++++
 board/spacemit/bananapi-f3/MAINTAINERS          |   6 -
 board/spacemit/bananapi-f3/Makefile             |   5 -
 board/spacemit/{bananapi-f3 => k1}/Kconfig      |   6 +-
 board/spacemit/k1/MAINTAINERS                   |  11 +
 board/spacemit/k1/Makefile                      |  28 ++
 board/spacemit/{bananapi-f3 => k1}/board.c      |   0
 board/spacemit/k1/spl.c                         | 343 ++++++++++++++++
 board/spacemit/k1/tlv_codes.h                   |  22 +
 configs/bananapi-f3_defconfig                   |  26 --
 configs/spacemit_k1_defconfig                   |  66 +++
 doc/board/spacemit/bananapi-f3.rst              |   2 +-
 doc/board/spacemit/index.rst                    |   1 +
 doc/board/spacemit/k1-spl.rst                   | 243 +++++++++++
 drivers/clk/spacemit/clk-k1.c                   | 128 ++++++
 drivers/i2c/Kconfig                             |   7 +
 drivers/i2c/Makefile                            |   1 +
 drivers/i2c/k1_i2c.c                            | 523 ++++++++++++++++++++++++
 drivers/i2c/k1_i2c.h                            |  69 ++++
 drivers/power/pmic/Kconfig                      |   8 +
 drivers/power/pmic/Makefile                     |   1 +
 drivers/power/pmic/pmic_spacemit_p1.c           |  94 +++++
 drivers/power/regulator/Kconfig                 |   7 +
 drivers/power/regulator/Makefile                |   1 +
 drivers/power/regulator/spacemit_p1_regulator.c | 464 +++++++++++++++++++++
 include/configs/bananapi-f3.h                   |  13 -
 include/configs/k1.h                            |  20 +
 include/power/spacemit_p1.h                     | 163 ++++++++
 30 files changed, 2314 insertions(+), 58 deletions(-)
---
base-commit: 3c5e8836ccca95e4846f6f4b03b8729ede48daf4
change-id: 20260630-m1-795ae0422400

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

