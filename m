Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C81EEF06E2
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C938341A;
	Sun,  8 Feb 2026 22:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSucIdpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8874483642; Sun,  8 Feb 2026 22:26:36 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 034AB805D7
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7963b25e0ffso5960817b3.0
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770585993; x=1771190793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DdGdWAtwxdkRHIp77UlvaySspmRxz6ElkM6AiYf+o6k=;
 b=ZSucIdpmabDmHx3BbkehWvnAKBYQBlaz1hMMyUK5eS8FTnFa6Xr8091kngD3cxcYz+
 UzCjyYRU1PmygoB5VHdzxBPGIb1MsLzoCbYpGxdqfj22DAv0kOt9AxLJXmAoZfQ23tni
 9wwxQeVyJ45phK2pwmN1+drRdjrR/XitLI5TrrbdjX2fCyWIE0URK/OUi5Uf8+KgjluA
 a4JUEdg8LfonMx60Y3GkEcaj8bHRZaWrBcpHcszdVF0q3/1KrcJhnVWjPPS1LKyDpP/a
 GLXyX33FMIXMMdm+RwapiwF6h5JKxcTwJg9rmi4Xt0U1bSGhAANb0puxfeyoz64q2h0d
 F64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770585993; x=1771190793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdGdWAtwxdkRHIp77UlvaySspmRxz6ElkM6AiYf+o6k=;
 b=nzFj5VSKmdPGu5QfVD3W5smRSU4Kgot92tdVznsmju9hLnkhZaIil61MaiMlmnwIVq
 JP1vuL3TSwf4+Bnyk8oBbebIu/aSrhzLBTEhHDZdp+ig/pN/icgjmInA1DAFI38cTdT/
 M0SlMVH3y1/mY38tD3XyIXglh983gi+VpnlYL9iJpY7ongIxIA7HV+WnFhDw8LAsowxi
 Jdiw3s7bsMJpLX+QYnHwJmQjcfcr7SVEryeaemiJ+EZTckPzYj95NyHzW61D5W7Dzwuj
 pA4hzUdKqcKFiVFpBD6Q2BfAXcd9oicd5ZRtAxpDM2kSN/sILHmj3TAUvtjY3D7kXDET
 A3xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrYoG55+BTkuqy7LgOOhmCbU86l34nguVcsOSK45DSKvXev0mlVuFFtTzP1AeCY/cga+9P+cM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9l2HeoJGP91qDUapEubuLm3nypLrxQqIaoVVLzdZj8bAOejWc
 gAGw8nw7ff3Re0SUefAQFy7blxRYm8qAVbx+OT9gDxHAG60h73tfvUM4
X-Gm-Gg: AZuq6aL9TiqffHw2lyIfgy0mYXO5lePrg7btDOBVAmpOk2NC66xx2PPuNzPsSHH+PRb
 /zCp4e34bbTnipoGLkjXdsuf7tn/iizj2lNqv5inVq9wj8K1y280V44e2dyry9STvzIV5NggFui
 cqme4AZvM+LAmdSvO8YFg9X6HdHkGfQ69p2+HNufYAgp+XvrECZYUKG+tl/JIv1aI/PfMB3e21V
 SToGZ9+9toWczLon/OdzMfRq1Pi/f5fPCjhg9s7w/7pNfNTCJdhm0igORmK966jYhRy9hM74fk8
 4U5M9tb62vLQUzDRP3haQ6+8gJUA0A56J/+D0UkV3ZM+oW+AYBq9NnxtoZh4DR0NdO5oAakYb9i
 FdGdNs5gp2reP84rSpsPLsNo9GTjqhdtpc7gpBZpTj4JBU5WSZZWpZEiCoSwrKirvhPk/kwSPYG
 9vtP9E0np42Bii5ib8wYBXhZuo
X-Received: by 2002:a05:690c:d81:b0:796:39c2:bcf6 with SMTP id
 00721157ae682-79639d21a89mr33937007b3.1.1770585992643; 
 Sun, 08 Feb 2026 13:26:32 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:32 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 0/7] ARM: Add RV1103B Omega4 board support
Date: Sun,  8 Feb 2026 18:26:17 -0300
Message-Id: <20260208212624.3413494-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Hi,

This patch series adds support for the Onion RV1103B Omega4 board.

It covers SPL, SPI NAND boot, and the minimal board devicetree required to
boot the board.

Upstreaming the RV1103B devicetree in Linux is ongoing, but to avoid blocking
U-Boot support, this series introduces board-specific devicetrees for now.

Once the Linux RV1103B devicetrees are upstreamed, the OF_UPSTREAM mechanism
can be enabled.

In v2, the correct SoC name was used: RV1103B instead of RV1103 (Thanks Jonas!),
the RV1103B dt-bindings, devicetrees, clock and pinctrl drivers have been
submitted upstream.

The dt-bindings have already been reviewed by the Linux DT maintainer:

https://lore.kernel.org/linux-devicetree/cadee46d-589b-4833-8650-691f7a0f8321@kernel.org/

https://lore.kernel.org/linux-devicetree/a2be67b7-a33a-4d72-b5b7-fa900063b599@kernel.org/

https://lore.kernel.org/linux-devicetree/47561412-cbaa-42c7-b8ab-9cafb7e0f9be@kernel.org/

https://lore.kernel.org/linux-devicetree/20260207-hulking-elegant-ferret-8efcea@quoll/

https://lore.kernel.org/linux-devicetree/20260208-analytic-fine-grouse-e17baa@quoll/

https://lore.kernel.org/linux-devicetree/20260208-pearl-ammonite-of-warranty-2c9212@quoll/

Tested the boot of a 6.6 OpenWRT kernel and also a 6.19-rc8 mainline kernel.

This series has successfully passed through CI.

Elaine Zhang (1):
  clk: rockchip: Add RV1103B clock driver

Fabio Estevam (4):
  ARM: dts: Add RV1103B Omega4 support
  rockchip: spl-boot-order: Add SPI NAND support
  spl: add SPI NAND support via MTD in SPL
  omega4-rv1103b: Add the initial support

Xuhui Lin (1):
  tools: rkcommon: Add RV1103B support

Ye Zhang (1):
  pinctrl: rockchip: Add RV1103B support

 arch/arm/dts/rv1103b-omega4-u-boot.dtsi       |   10 +
 arch/arm/dts/rv1103b-omega4.dts               |  105 ++
 arch/arm/dts/rv1103b-pinctrl.dtsi             |  831 +++++++++++++
 arch/arm/dts/rv1103b-u-boot.dtsi              |    4 +
 arch/arm/dts/rv1103b.dtsi                     |  266 ++++
 .../include/asm/arch-rockchip/cru_rv1103b.h   |  266 ++++
 .../include/asm/arch-rockchip/grf_rv1103b.h   |   31 +
 arch/arm/include/asm/arch-rv1103b/boot0.h     |   11 +
 arch/arm/mach-rockchip/Kconfig                |   14 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rv1103b/Kconfig        |   23 +
 arch/arm/mach-rockchip/rv1103b/Makefile       |   12 +
 arch/arm/mach-rockchip/rv1103b/boot0.h        |    5 +
 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c  |   32 +
 arch/arm/mach-rockchip/rv1103b/rv1103b.c      |  133 ++
 .../mach-rockchip/rv1103b/syscon_rv1103b.c    |   19 +
 arch/arm/mach-rockchip/spl-boot-order.c       |   11 +-
 board/onion/omega4_rv1103b/Kconfig            |   12 +
 board/onion/omega4_rv1103b/MAINTAINERS        |    6 +
 board/onion/omega4_rv1103b/Makefile           |    7 +
 board/onion/omega4_rv1103b/omega4_rv1103b.c   |   19 +
 board/onion/omega4_rv1103b/omega4_rv1103b.env |    5 +
 common/spl/Kconfig                            |   10 +-
 common/spl/Makefile                           |    1 +
 common/spl/spl_spi_nand.c                     |   82 ++
 configs/omega4-rv1103b_defconfig              |   82 ++
 doc/board/index.rst                           |    1 +
 doc/board/onion/index.rst                     |    9 +
 doc/board/onion/omega4-rv1103b.rst            |   56 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rv1103b.c            | 1068 +++++++++++++++++
 drivers/mtd/Makefile                          |    1 +
 drivers/mtd/nand/Makefile                     |   13 +-
 drivers/pinctrl/rockchip/Makefile             |    1 +
 drivers/pinctrl/rockchip/pinctrl-rv1103b.c    |  398 ++++++
 include/configs/omega4_rv1103b.h              |   11 +
 include/configs/rv1103b_common.h              |   14 +
 .../dt-bindings/clock/rockchip,rv1103b-cru.h  |  220 ++++
 tools/rkcommon.c                              |    1 +
 39 files changed, 3788 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/rv1103b-omega4-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b-omega4.dts
 create mode 100644 arch/arm/dts/rv1103b-pinctrl.dtsi
 create mode 100644 arch/arm/dts/rv1103b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b.dtsi
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1103b.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rv1103b.h
 create mode 100644 arch/arm/include/asm/arch-rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
 create mode 100644 board/onion/omega4_rv1103b/Kconfig
 create mode 100644 board/onion/omega4_rv1103b/MAINTAINERS
 create mode 100644 board/onion/omega4_rv1103b/Makefile
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.c
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.env
 create mode 100644 common/spl/spl_spi_nand.c
 create mode 100644 configs/omega4-rv1103b_defconfig
 create mode 100644 doc/board/onion/index.rst
 create mode 100644 doc/board/onion/omega4-rv1103b.rst
 create mode 100644 drivers/clk/rockchip/clk_rv1103b.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103b.c
 create mode 100644 include/configs/omega4_rv1103b.h
 create mode 100644 include/configs/rv1103b_common.h
 create mode 100644 include/dt-bindings/clock/rockchip,rv1103b-cru.h

-- 
2.34.1

