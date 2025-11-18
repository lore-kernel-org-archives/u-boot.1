Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142A8CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2498983B99;
	Tue, 18 Nov 2025 07:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JlARAbeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0631C83C16; Tue, 18 Nov 2025 07:40:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B883A83B8B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-786943affbaso41873927b3.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448024; x=1764052824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vzbi2h73gItWhEOTWlYRbuPm7s9lHFkUkWk6aNeHBFY=;
 b=JlARAbeGFvDZx+8m8Cglk0KGQ8+DC3JIN38j5ejV/H5s1cmuOa5J9lyjmUAOoti0t5
 b/qWPnh08t7hR9TlY8g/44WbYHG3iMm/TnaS0XQ6nu2XzsFQMvbO/R4+oJyRz3NyAIBq
 YXT7jZoQfcsy9dnHmihPQ/+BIHUH8g58yDLAHGMZ1qT4y3654huidUoQRCzgSYionrvd
 bpWBT0ieKp4lRfnN4FuClrb5VbTXa6n7yKz5Sxx695qdN1OtlCnqu1s1UulNanOoxDwo
 UUjJ/CMvCemEzKG101Q9fdd0Y+CqLVCRA+9WouVr4u1Zvzj+Ep+yVYoSeEL9APeOJjx2
 IFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448024; x=1764052824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vzbi2h73gItWhEOTWlYRbuPm7s9lHFkUkWk6aNeHBFY=;
 b=u4s7o/kEtc8rqUWs9dfKbmnlXFEdx90yyZKfLpz0yPGSCfnvS7OLn5oJgBYi3dSGtB
 +nZbYm9QIzhx34JDVu+AzrJHqrobMEl27jrrnwm2S8UB8T8UaMpA7idHP+OgV3kJ+KLo
 7sYNXVGRLN/wxy3J8DTR82B5Xc+CBKxfht3eM+C/zbQBY+EmVJW3HPqeoI/FLECmZ2s+
 XeepiJLz4d185M4ioztgkNBPg2yc24soR383LPCbVMSJAFQDbt6e5TSf7DIbRsGdn33d
 iFJ4b/P8taBnZt9iQ14qSHs/CSycJLqGeQutJjmZITCLZuEx9DkhsNl5U7FCZooYdgGk
 Yjbw==
X-Gm-Message-State: AOJu0Ywj4piTjUB1miQhUn2sVUdqDeuURpcM0mp9++hZ2wEubC+r6IQc
 5ohTs+Qn6cdiMXJFce6dq3ReOwA76dvPpwZXHxQ54qaT+jQ45c6rtqdthbR945w=
X-Gm-Gg: ASbGncsVPRz4fY/2E41j2V3jFvjkk+hTZLcCMwiQFuWFZZWgjBBIjBetgpyo0tOtIJm
 7vIXCYIblOxuVuzxf4kx2EWTGHH3K/1Ui+YKxZWuQ0xX0iRXpjoJrtYc60iZhWttXc3T0CK4QdG
 Rx7ah9s1Ps/MasmqkyyMgCc2woEITw+fncE480PFyJxj8zkH2CFLuQmAEdxhU9k7/V70LdUSChh
 TGXZoeFOnruAL29ABg1AKtyVWgdBzemBALBl+RoaMhm0yxA0x4Sg67QJnXDlAQm0fWXDIfwbHju
 jWCmEMKBH/Xlk7O9ODTvlV1qANg07gu3wUnDvNbLD836vgyUYWuW+eoqWCrDOglKhKXo454PM7c
 2NG6A28vzWuEzp7KL5YWqo4MY/TUYsxo9dSHN7b/ZFgQc3IjptL7ADqGL/wkDINqbbzxm6tlAIh
 xbFyDXjTWdFSO93XzH25uFu/UEWw==
X-Google-Smtp-Source: AGHT+IHKJmD72lEkLF+XZjAHCzB93ajqpEHoyYeIZTs5Bg87nNdtdRwBMtmemBg/qiqwwzTjttzjzw==
X-Received: by 2002:a05:690e:d06:b0:63f:b5a5:37c with SMTP id
 956f58d0204a3-641e74a3643mr12165952d50.2.1763448024005; 
 Mon, 17 Nov 2025 22:40:24 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:23 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philip Molloy <philip@philipmolloy.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH 00/12] sc5xx: Add complete board support for all ADI SC5xx
 boards
Date: Tue, 18 Nov 2025 01:39:33 -0500
Message-ID: <20251118064000.14613-1-malysagreg@gmail.com>
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
 board/adi/sc573-ezkit/sc573-ezkit.env         |  17 +-
 board/adi/sc584-ezkit/Makefile                |   6 +
 board/adi/sc584-ezkit/sc584-ezkit.c           |  21 ++
 board/adi/sc584-ezkit/sc584-ezkit.env         |  16 +-
 board/adi/sc589-ezkit/Makefile                |   6 +
 board/adi/sc589-ezkit/sc589-ezkit.c           |  21 ++
 board/adi/sc589-ezkit/sc589-ezkit.env         |  17 +-
 board/adi/sc589-mini/Makefile                 |   6 +
 board/adi/sc589-mini/sc589-mini.c             |  21 ++
 board/adi/sc589-mini/sc589-mini.env           |  17 +-
 board/adi/sc594-som-ezkit/Makefile            |   8 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  18 +-
 board/adi/sc594-som-ezlite/Makefile           |   8 +
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  18 +-
 board/adi/sc598-som-ezkit/Makefile            |   8 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  18 +-
 board/adi/sc598-som-ezlite/Makefile           |   8 +
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  12 +-
 configs/sc573-ezkit_defconfig                 |  90 +++++++
 configs/sc584-ezkit_defconfig                 |  96 +++++++
 configs/sc589-ezkit_defconfig                 | 101 ++++++++
 configs/sc589-mini_defconfig                  |  97 +++++++
 configs/sc594-som-ezkit-spl_defconfig         |  78 ++++++
 configs/sc594-som-ezlite-spl_defconfig        |  87 +++++++
 configs/sc598-som-ezkit-spl_defconfig         | 111 ++++++++
 configs/sc598-som-ezlite-spl_defconfig        | 110 ++++++++
 tools/docker/Dockerfile                       |  16 ++
 55 files changed, 3563 insertions(+), 88 deletions(-)
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

base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
branch: dev/sc5xx-boards-v2
