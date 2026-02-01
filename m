Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721A8E7C6F6
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E32D83B55;
	Sun,  1 Feb 2026 01:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xo6bJVN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394F983AAD; Sun,  1 Feb 2026 01:45:11 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0227A83AA9
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79496f0ea3fso26104857b3.0
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906708; x=1770511508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=52z1EQnOCIF0i9Wf8UcvR0nDRSMIIhDVGSZBEhwPl9g=;
 b=Xo6bJVN35t/Bkb2nGvd3+A43deeejaPsYCyHNZR+aGHv6MXuuk0+lIQiesQc2/djRs
 ynJubE5xsK/SMRV58gBvwGFP4YTNFBV42thEHwgxPatvN+UWjIsBm5X6nTHNsrbPjENc
 HXsgX/Mdaj8/jsSFpNdp5UcHlXGBZwg1DMqHPkxGggmk9tVJjTccSoiJo3Y/armlxUik
 k4qfGkb1IE6dOCTxvDCW2eQcyF6A3rx72FTeYw987wmDK8D1eC6VL6g55lM5kdyv/+jw
 mVvTkN9j2GHgBD1zPXmDZMlic0BJeLJjT/DwoYlLmaqhAqeeQvnNlXIsRqLjsxhNaTM0
 QXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906708; x=1770511508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52z1EQnOCIF0i9Wf8UcvR0nDRSMIIhDVGSZBEhwPl9g=;
 b=Hikyi44ysnB9qGUHKRjIeu23ntZjSz7GW9JH7naFjpD61KbbZiPJlNQaOuHcqGIDI3
 WJdbGF3SBC2nm/go4yjeteMhdL/UsxouDmzU4Q4gtz1mcJ2pWjfcLSqsj++pbSwBroPU
 kh6VP7V1KX/es5daP3JEQSCfXTlzMC63Im+XBr687u5iuHRwMBUWQiFAR2vBR0Evl0FJ
 58OSVhFJ4wrzHa/1iTSfGDVO906TO54jddf079EMRgODEJm9puvUtVmaVd0GgL9oflCw
 /61gdjLyEYWNIiQndLW0fOIwTaENtJloG3gS81wjfuXI/Y70HEIjVX5TFd+pedzt2ms4
 md+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9nz5PtI6pkEaI1hEzXYZGdyVq1Wlkw5w7TuAXqCUIy5cWl2KVmmvjc2v8dICvc0oCoO+VVv0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3IU6a/Kj73IFmnE1lgFiRxy4YyR8I/aoCvMQwjCN3XZTwxywe
 uFw1NH5lwLIBwnD5dXjB9LqElDxbXf7AnA94UGJNpLjcBhj8POZIoe3ew+tPZw==
X-Gm-Gg: AZuq6aKV8oi0Y8U4qTwrbnQfJs+IeEXNOuJq2gMUlu3xsV/N41GiHb7YoJycTWz9TtQ
 fJCMP7Bbvm3MdTGUx2T2hwVFjZeA4cICujCY5lncONdQJADdphLTbISSwgezPJPvPW2F0G5iJDv
 3weOJnuPXjz9n/O7itFlVlv2lV+7esxhNOeu6NL/z67GrmJOhhD0XwZFxgXQNnXjT/dsoiTYQBO
 uHMsGSy6x8FuE/kEOippLBc/ujyVlUstM2Udyezr9xP1gezWCWu8kDtJsKmDjaAKxaTfLP+VGZ4
 vfd7UnFr5xg6SO8Ia0PN/91OFMaGW+FbQkfRmMb6MgQj/G2BEtW0Eqpkwou3LeaOcHXRO5V7zEi
 f4t4wDyCcikGHtCS/RBPAuhJudkHrAsyrLrGQknBXijbrGr2HpLt+l22sydamczZB04LgrR2AX/
 gbOy5NH+mWIplNvvmiPNr8MEFC
X-Received: by 2002:a05:690c:385:b0:794:7866:263b with SMTP id
 00721157ae682-7949de64fc5mr65342517b3.1.1769906707643; 
 Sat, 31 Jan 2026 16:45:07 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:07 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 0/7] ARM: Add RV1103 Omega4 board support
Date: Sat, 31 Jan 2026 21:44:49 -0300
Message-Id: <20260201004456.763107-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Fabio Estevam <festevam@nabladev.com>

Hi,

This patch series adds support for the Onion RV1103 Omega4 board to U-Boot.
It covers SPL, SPI NAND boot, and the minimal board devicetree required to
boot the board.

Upstreaming the RV1103 devicetree in Linux is ongoing, but to avoid blocking
U-Boot support, this series introduces board-specific devicetrees for now.
Once the Linux RV1103 devicetrees are upstreamed, the OF_UPSTREAM mechanism
can be enabled.

Fabio Estevam (7):
  pinctrl: rockchip: Add support for RV1103
  clk: rockchip: Add support for RV1103
  tools: rkcommon: Add rv1103 support
  rockchip: spl-boot-order: Add SPI NAND support
  spl: Add SPI NAND support via MTD in SPL
  ARM: dts: Add RV1103 Omega4 support
  omega4-rv1103: Add initial support

 arch/arm/dts/rv1103-omega4-u-boot.dtsi        |   11 +
 arch/arm/dts/rv1103-omega4.dts                |   40 +
 arch/arm/dts/rv1103-u-boot.dtsi               |    4 +
 arch/arm/dts/rv1103.dtsi                      |  267 +++++
 .../include/asm/arch-rockchip/cru_rv1103.h    |  271 +++++
 .../include/asm/arch-rockchip/grf_rv1103.h    |   31 +
 arch/arm/include/asm/arch-rv1103/boot0.h      |   11 +
 arch/arm/mach-rockchip/Kconfig                |   14 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rv1103/Kconfig         |   23 +
 arch/arm/mach-rockchip/rv1103/Makefile        |   12 +
 arch/arm/mach-rockchip/rv1103/boot0.h         |    5 +
 arch/arm/mach-rockchip/rv1103/clk_rv1103.c    |   32 +
 arch/arm/mach-rockchip/rv1103/rv1103.c        |  133 ++
 arch/arm/mach-rockchip/rv1103/syscon_rv1103.c |   19 +
 arch/arm/mach-rockchip/spl-boot-order.c       |   11 +-
 board/onion/omega4_rv1103/Kconfig             |   12 +
 board/onion/omega4_rv1103/MAINTAINERS         |    6 +
 board/onion/omega4_rv1103/Makefile            |    7 +
 board/onion/omega4_rv1103/omega4_rv1103.c     |   19 +
 board/onion/omega4_rv1103/omega4_rv1103.env   |    5 +
 common/spl/Kconfig                            |   10 +-
 common/spl/Makefile                           |    1 +
 common/spl/spl_spi_nand.c                     |   82 ++
 configs/omega4-rv1103_defconfig               |   82 ++
 doc/board/index.rst                           |    1 +
 doc/board/onion/index.rst                     |    9 +
 doc/board/onion/omega4-rv1103.rst             |   56 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rv1103.c             | 1068 +++++++++++++++++
 drivers/mtd/Makefile                          |    1 +
 drivers/mtd/nand/Makefile                     |   13 +-
 drivers/pinctrl/Kconfig                       |   10 +
 drivers/pinctrl/rockchip/Makefile             |    1 +
 drivers/pinctrl/rockchip/pinctrl-rv1103.c     |  411 +++++++
 include/configs/omega4_rv1103.h               |   11 +
 include/configs/rv1103_common.h               |   14 +
 include/dt-bindings/clock/rv1103-cru.h        |  489 ++++++++
 tools/rkcommon.c                              |    1 +
 39 files changed, 3191 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/rv1103-omega4-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103-omega4.dts
 create mode 100644 arch/arm/dts/rv1103-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103.dtsi
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1103.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rv1103.h
 create mode 100644 arch/arm/include/asm/arch-rv1103/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1103/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1103/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103/clk_rv1103.c
 create mode 100644 arch/arm/mach-rockchip/rv1103/rv1103.c
 create mode 100644 arch/arm/mach-rockchip/rv1103/syscon_rv1103.c
 create mode 100644 board/onion/omega4_rv1103/Kconfig
 create mode 100644 board/onion/omega4_rv1103/MAINTAINERS
 create mode 100644 board/onion/omega4_rv1103/Makefile
 create mode 100644 board/onion/omega4_rv1103/omega4_rv1103.c
 create mode 100644 board/onion/omega4_rv1103/omega4_rv1103.env
 create mode 100644 common/spl/spl_spi_nand.c
 create mode 100644 configs/omega4-rv1103_defconfig
 create mode 100644 doc/board/onion/index.rst
 create mode 100644 doc/board/onion/omega4-rv1103.rst
 create mode 100644 drivers/clk/rockchip/clk_rv1103.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103.c
 create mode 100644 include/configs/omega4_rv1103.h
 create mode 100644 include/configs/rv1103_common.h
 create mode 100644 include/dt-bindings/clock/rv1103-cru.h

-- 
2.34.1

