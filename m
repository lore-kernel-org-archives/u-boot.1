Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD76D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8415783A26;
	Thu, 11 Dec 2025 09:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOOpDQyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E8283BFE; Thu, 11 Dec 2025 09:05:49 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88935830E4
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78c6a53187dso7154697b3.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440344; x=1766045144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eSN5uA3+zD6244VP/lGbbauB7KDtarcpQzTlTJ5wKzo=;
 b=OOOpDQyVsZjVaFYj728fcHKlkjsUwB72jmOCinANfmkFjtrUVm5L1AEXLG2PNLr2GZ
 Au+IAZpCHa0l4q2af48xinwzx65w2G21ZzzR/pZy0JsKNthhUg3iDFvwagq7WSPlwmLh
 e/hvtvp8bjkPBz2Nf7oT5LrhdmXBSZYEIu8OqGsfoa9uLZwJVRASYiZbViGjWu6/SZXx
 9MX1pTw7wp6gx9Jad+Qw6sR/PkSY+9ttJF/dPPLK4MuM5eYY8mMLB1qhX6yV0dbdJqCR
 3zZh4Gz5nqozmE/WM759kzezdICSbW5I3gvYRwZl/2o2G+XhwvqvzE/dZ007vzr5Yayo
 ASlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440344; x=1766045144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSN5uA3+zD6244VP/lGbbauB7KDtarcpQzTlTJ5wKzo=;
 b=RoqbC0d1ZNkVfoDfLqgsq/k+E8t64gIb+6JpgoSkCgzZ8d8fDJzkN7iaPBiU+WyCyR
 eEUXc0dobKexfzIqB2FA8DFqJwWFH43OrqHco95hEcK7a4a2Rtt6SDB8FQ3MaULMnXn3
 8mltyruEtGSqGqN1N6KRC2mNkNN4OmjYeXbZigmBgNCrz5ooAsY+r/yBDYLwXOcZnnhN
 bvCh82muxdydHQdV2CnkDX7pUi9jrZ/VEKiqjcZADV4qH1mED38hXpyHaXbTasHWyZWG
 MxmMaUmMdt5bgwgo/6h0bivSK4IfUarT3+lgPeQEWIsP5pxmAbKUDP51NLzXp/9P2o3j
 EzMw==
X-Gm-Message-State: AOJu0YwvqH8I2O+2zGpjjBcvZh2y37ZmTVKpk1V5bJ8Ok0uhU1g/o85T
 5sEsV0nYDmggm8dw2QCKrI/7cxmAT2Gn0EyMz+skXvmeURaGkGcoozlSCurgrko=
X-Gm-Gg: AY/fxX74rhIQuOHMP9ml0eKdIFi+2k+eSdifVY7khTbWOnwGj4aJYmy1MnqU/BZeUdU
 PnktzMHx+GoGmaX7xzBoAAVAVPh0LRiMPyrt34MK2DFN49PecHa3FzSfOwms3trGItF7FaZRAaF
 YusXwh9dk6NMQfmvYFWL55S8wcNjsizZiA6/eqOFR9L+eBSHtZPMu+UsPGAuNQ1ecHF5uK1kTF/
 GOU6l62CI6SnivC8rwgq3uJcB0LoyRAtVylqw91GkBtGhHYj4SU2S0RhWMUh3Z7fQEt3Xiw1Y03
 3EczBFvUX0682yM8kMWhxZHtt775p0BdSdOoVYzM+qwHikgsh3QkNY80BQdgsIk010TJwHP262l
 7GGqTVwC9hmrjydI3dlnQWL0nK2aa66eqG2tZSqnrvIxyUF9NgHhWWjiaHGPOe/7ubfYWZsb7dW
 YnQ8/LNvEUm1MaoQ8Tg66s0d/3hQ==
X-Google-Smtp-Source: AGHT+IHWbxJFsS/jDX331i6nlxm5GcxcY+Ow+e09/IvFjGtxgvqoCremZzLCjXHsBEad5pWTYald7g==
X-Received: by 2002:a05:690c:6083:b0:787:deea:1baf with SMTP id
 00721157ae682-78c9d85aa5dmr45912807b3.52.1765440343904; 
 Thu, 11 Dec 2025 00:05:43 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:43 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philip Molloy <philip@philipmolloy.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 00/12] sc5xx: Add complete board support for all ADI SC5xx
 boards
Date: Thu, 11 Dec 2025 03:03:51 -0500
Message-ID: <20251211080414.5363-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
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

This series adds the final pieces to enable mainline U-Boot to build and
boot all Analog Devices SC5xx SoCs and supports the associated carrier
board options. At this point it should be viable for new users for these
platforms to start with the latest version of U-Boot rather than our
vendor fork, however some features (such as OSPI support and falcon
boot) remain unavailable until we are able to unify our implementations
with the mainline implementations.

Changes in v3:
- CI results: https://gitlab.com/gmalysa/lnxdsp-u-boot/-/pipelines/2205787455

Changes in v2:
- Rebased series to latest u-boot master
- Replaced SC_BOOT_MODE Kconfig with SC_BCODE
- Use Kconfig to restrict choices between EZKIT and EZLITE carriers when
  appropriate
- Separate dtsi for revD and revE of sc598 SOM. RevE is the default but
  revD is included so that any customers with older hardware can boot it
  with a single change to the .dts
- Fixed GPIO naming and polarity to use only positive names (such as
  gige-reset rather than ~gige-reset) and set the active low/high flag
  appropriately, with all code references updated to reflect logical
  values rather than voltage levels

Greg Malysa (10):
  mach-sc5xx: Rename SC_BOOT_MODE
  mach-sc5xx: Kconfig: Make EZKIT and EZLITE carriers mutually exclusive
  docker: add Analog Devices tools to docker image
  board: adi: Add SOMCRR infrastructure
  board: adi: Add support for SC573-ezkit
  board: adi: Add support for SC589 boards
  board: adi: Add support for SC584-ezkit
  board: adi: Add support for SC598
  board: adi: Add support for SC594
  MAINTAINERS: Update ADI entries for new boards

Utsav Agarwal (2):
  mach-sc5xx: Introduce Kconfig symbols for image addresses
  mach-sc5xx: Add preliminary support for binman

 MAINTAINERS                                   |   2 +
 arch/arm/dts/sc573-ezkit.dts                  | 240 ++++++++++++++++++
 arch/arm/dts/sc57x.dtsi                       | 123 ++++++++-
 arch/arm/dts/sc584-ezkit.dts                  | 230 +++++++++++++++++
 arch/arm/dts/sc589-ezkit.dts                  | 198 +++++++++++++++
 arch/arm/dts/sc589-mini.dts                   |  18 +-
 arch/arm/dts/sc58x.dtsi                       | 164 +++++++++++-
 arch/arm/dts/sc594-som-ezkit.dts              | 126 +++++++++
 arch/arm/dts/sc594-som-ezlite.dts             |  83 ++++++
 arch/arm/dts/sc594-som.dtsi                   | 193 +++++++++++++-
 arch/arm/dts/sc598-som-ezkit.dts              | 168 +++++++++++-
 arch/arm/dts/sc598-som-ezlite.dts             |  84 +++++-
 arch/arm/dts/sc598-som-revD.dtsi              |  72 ++++++
 arch/arm/dts/sc598-som-revE.dtsi              |  97 +++++++
 arch/arm/dts/sc598-som.dtsi                   | 154 ++++++++++-
 arch/arm/dts/sc59x.dtsi                       | 183 +++++++++++++
 arch/arm/dts/sc5xx.dtsi                       | 189 +++++++++++++-
 arch/arm/mach-sc5xx/Kconfig                   |  95 ++++++-
 arch/arm/mach-sc5xx/config.mk                 |   2 +-
 board/adi/carriers/Makefile                   |   8 +
 board/adi/carriers/somcrr.h                   |  14 +
 board/adi/carriers/somcrr_common.c            |  19 ++
 board/adi/carriers/somcrr_ezkit.c             |  38 +++
 board/adi/carriers/somcrr_ezlite.c            |  24 ++
 board/adi/common-sc594-som/sc594-som.c        |  34 +++
 board/adi/common-sc598-som/sc598-som.c        |  34 +++
 board/adi/sc573-ezkit/Makefile                |   6 +
 board/adi/sc573-ezkit/sc573-ezkit.c           |  21 ++
 board/adi/sc573-ezkit/sc573-ezkit.env         |  18 +-
 board/adi/sc584-ezkit/Makefile                |   6 +
 board/adi/sc584-ezkit/sc584-ezkit.c           |  21 ++
 board/adi/sc584-ezkit/sc584-ezkit.env         |  17 +-
 board/adi/sc589-ezkit/Makefile                |   6 +
 board/adi/sc589-ezkit/sc589-ezkit.c           |  21 ++
 board/adi/sc589-ezkit/sc589-ezkit.env         |  18 +-
 board/adi/sc589-mini/Makefile                 |   6 +
 board/adi/sc589-mini/sc589-mini.c             |  21 ++
 board/adi/sc589-mini/sc589-mini.env           |  18 +-
 board/adi/sc594-som-ezkit/Makefile            |   8 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  19 +-
 board/adi/sc594-som-ezlite/Makefile           |   8 +
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  19 +-
 board/adi/sc598-som-ezkit/Makefile            |   8 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  19 +-
 board/adi/sc598-som-ezlite/Makefile           |   8 +
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  13 +-
 configs/sc573-ezkit_defconfig                 |  90 +++++++
 configs/sc584-ezkit_defconfig                 |  96 +++++++
 configs/sc589-ezkit_defconfig                 | 101 ++++++++
 configs/sc589-mini_defconfig                  |  97 +++++++
 configs/sc594-som-ezkit-spl_defconfig         |  78 ++++++
 configs/sc594-som-ezlite-spl_defconfig        |  87 +++++++
 configs/sc598-som-ezkit-spl_defconfig         | 111 ++++++++
 configs/sc598-som-ezlite-spl_defconfig        | 110 ++++++++
 tools/docker/Dockerfile                       |  16 ++
 55 files changed, 3563 insertions(+), 96 deletions(-)
 create mode 100644 arch/arm/dts/sc598-som-revD.dtsi
 create mode 100644 arch/arm/dts/sc598-som-revE.dtsi
 create mode 100644 arch/arm/dts/sc59x.dtsi
 create mode 100644 board/adi/carriers/Makefile
 create mode 100644 board/adi/carriers/somcrr.h
 create mode 100644 board/adi/carriers/somcrr_common.c
 create mode 100644 board/adi/carriers/somcrr_ezkit.c
 create mode 100644 board/adi/carriers/somcrr_ezlite.c
 create mode 100644 board/adi/common-sc594-som/sc594-som.c
 create mode 100644 board/adi/common-sc598-som/sc598-som.c
 create mode 100644 board/adi/sc573-ezkit/Makefile
 create mode 100644 board/adi/sc573-ezkit/sc573-ezkit.c
 create mode 100644 board/adi/sc584-ezkit/Makefile
 create mode 100644 board/adi/sc584-ezkit/sc584-ezkit.c
 create mode 100644 board/adi/sc589-ezkit/Makefile
 create mode 100644 board/adi/sc589-ezkit/sc589-ezkit.c
 create mode 100644 board/adi/sc589-mini/Makefile
 create mode 100644 board/adi/sc589-mini/sc589-mini.c
 create mode 100644 board/adi/sc594-som-ezkit/Makefile
 create mode 100644 board/adi/sc594-som-ezlite/Makefile
 create mode 100644 board/adi/sc598-som-ezkit/Makefile
 create mode 100644 board/adi/sc598-som-ezlite/Makefile
 create mode 100644 configs/sc573-ezkit_defconfig
 create mode 100644 configs/sc584-ezkit_defconfig
 create mode 100644 configs/sc589-ezkit_defconfig
 create mode 100644 configs/sc589-mini_defconfig
 create mode 100644 configs/sc594-som-ezkit-spl_defconfig
 create mode 100644 configs/sc594-som-ezlite-spl_defconfig
 create mode 100644 configs/sc598-som-ezkit-spl_defconfig
 create mode 100644 configs/sc598-som-ezlite-spl_defconfig

-- 
2.49.1

base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
branch: dev/sc5xx-boards-v3
