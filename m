Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D5CC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36BA581F32;
	Mon,  2 Jun 2025 21:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TxKKpDbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23BD381F0D; Mon,  2 Jun 2025 21:47:06 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A0E80F9C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70f86c9e3e7so46457487b3.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893622; x=1749498422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ouYo/U5ISqilRG9vmjCjc+RBGzGwJ8snqtNBAxluiE=;
 b=TxKKpDbnxwyK/Accr/9m+3+zHj6zuipPy/tQD0+218HFDQxFmkRtZK1RwH1WKl8cu0
 amsU9USk+l0J1Rtd2GEDwvHOBbIa4WsRXgOSCE4hYuSXg/UuY+9aXP+/EIj/wsib5hL9
 8kKRWTCc0LHSrgx3/9LoH8EMYYh2w+EpOsuXJod4R0aCNaFOnfGciq2uycVdZSfcEzqy
 FJMwO+TG9EszLrmzSjPDd4xPGx2pfVJHKsYMNqVwvX2KY6BamSsmBtGEJNnyVkMYu0c/
 5tELlz68GzosQfHfLPzT/gt5vWFwUYIE8YR3JA4VHTToVhDhoftTVmT6HWyJBgOIRPvl
 hqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893622; x=1749498422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ouYo/U5ISqilRG9vmjCjc+RBGzGwJ8snqtNBAxluiE=;
 b=toTdxErNUsvgoWLtjgMa4v0E/juzsVyXRVhGie7qlRwIxxBemJCX6g+XM3lgpQfuUJ
 Fu9thN6PPeFwRKUBgNpnU2J4Pbbax2KAsSJJsLOmSVEJWqc36zc7RWw8fAgvG0G+C7wp
 zXkyI/VfBd9VQdAHkZzMblpFN238aI50AO9PtvhVshg3GVNkFabNXkSyIY+uxB9haNP7
 9NeviRzr5rTub7o3AmvK9ne7fUKC37UrHsb+ylpgZy65zuTJNx5Wor6KZ0GxNMWr6Bmu
 ZMUvBMMrWphx42Bvnp6wdoam95ULIC/l49AxGD4vJWuQzC+gggnbVOXyoKlV2g8VTZWX
 WlMg==
X-Gm-Message-State: AOJu0YzpDFiFkfRfTY2eWNSXTQLOkCZj/7SP2MI1jQJk+D3J7aqOvA/i
 5nXR34CuK51zSZNqLGVZrta60C0HtN8j8BGrFdVu+dy1tC/n8PjwNzgVnlmo
X-Gm-Gg: ASbGncvXdXpjrppk3yRToBDGj0eO5u2hg/kftt+3o5p1gSjrLZ6pJqRNIqd6x0HAmDj
 +H4azM5dvV1lRqD6CglktYVLDwCfYIFn/TnHGgqx6nsecElxtRbsD+2eBEcFYxMTBALw0pkvcvY
 IDmG4CrXEkHcSNQR/yjMAlSxYI2F1UBvxXcreUz8sLNgwcGVXiku/A9Du2MA52QmE1urE/CGzcO
 Gb6v2QuWDBXyhrIuTtYwDVqC/pKgBSYPDqZroH4kcYavpvWTPoQEu7GR0/G+MxX1RxL4zPHYeW/
 ZaIH2R7LkJZxpyqNSroCPhKlSHUGlNHdYTthIcGMcvoq1Uv3OBp4I3ZtNDptO3N2Paw=
X-Google-Smtp-Source: AGHT+IE+DhGnA2YtxQb14BbaXCCMFZGGSwp8faxTwDBHj9pTqWemHiQxiXnkoIdIHsjv7oJVzexcrw==
X-Received: by 2002:a05:690c:4c02:b0:70e:195:e926 with SMTP id
 00721157ae682-70f97e58c85mr203204947b3.9.1748893621423; 
 Mon, 02 Jun 2025 12:47:01 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:01 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 00/10] sc5xx: Add complete board support for all ADI SC5xx
 boards
Date: Mon,  2 Jun 2025 15:44:38 -0400
Message-ID: <20250602194507.15159-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
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


Greg Malysa (8):
  docker: add ADI build-related tools to docker image
  board: adi: Add SOMCRR infrastructure
  board: adi: Add support for SC573-ezkit
  board: adi: Add support for SC589 boards
  board: adi: Add support for SC584
  board: adi: Add support for SC598
  board: adi: Add support for SC594
  MAINTAINERS: Update ADI entries for new boards

Utsav Agarwal (2):
  mach-sc5xx: Introduce Kconfig symbols for image addresses
  mach-sc5xx: Add binman support

 MAINTAINERS                                   |   1 +
 arch/arm/dts/sc573-ezkit.dts                  | 227 +++++++++++++++++
 arch/arm/dts/sc57x.dtsi                       | 123 ++++++++-
 arch/arm/dts/sc584-ezkit.dts                  | 230 +++++++++++++++++
 arch/arm/dts/sc589-ezkit.dts                  | 198 +++++++++++++++
 arch/arm/dts/sc589-mini.dts                   |  18 +-
 arch/arm/dts/sc58x.dtsi                       | 153 ++++++++++-
 arch/arm/dts/sc594-som-ezkit.dts              | 126 ++++++++++
 arch/arm/dts/sc594-som-ezlite.dts             |  83 ++++++
 arch/arm/dts/sc594-som.dtsi                   | 184 +++++++++++++-
 arch/arm/dts/sc598-som-ezkit.dts              | 166 ++++++++++++
 arch/arm/dts/sc598-som-ezlite.dts             |  82 ++++++
 arch/arm/dts/sc598-som.dtsi                   | 237 +++++++++++++++++-
 arch/arm/dts/sc59x.dtsi                       | 183 ++++++++++++++
 arch/arm/dts/sc5xx.dtsi                       | 189 +++++++++++++-
 arch/arm/mach-sc5xx/Kconfig                   |  63 +++++
 board/adi/carriers/Makefile                   |   8 +
 board/adi/carriers/somcrr.h                   |  14 ++
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
 configs/sc573-ezkit_defconfig                 | 102 ++++++++
 configs/sc584-ezkit_defconfig                 | 108 ++++++++
 configs/sc589-ezkit_defconfig                 | 113 +++++++++
 configs/sc589-mini_defconfig                  | 109 ++++++++
 configs/sc594-som-ezkit-spl_defconfig         |  90 +++++++
 configs/sc594-som-ezlite-spl_defconfig        |  98 ++++++++
 configs/sc598-som-ezkit-spl_defconfig         | 123 +++++++++
 configs/sc598-som-ezlite-spl_defconfig        | 123 +++++++++
 tools/docker/Dockerfile                       |   8 +
 52 files changed, 3508 insertions(+), 73 deletions(-)
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
2.45.2

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: dev/sc5xx-boards-v1
