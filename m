Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C43E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 01:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1274A89109;
	Sun,  3 Nov 2024 02:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d131kXFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21CB4890B1; Sat,  2 Nov 2024 23:19:01 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD84D89102
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so2593164b3a.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730585935; x=1731190735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pny/6aZrMRKa1cJiQSXpo+LyH2LHLfG8xTW7X1mJzQY=;
 b=d131kXFqaUAy+epE+mQk9pw2dwJr7hhpF8PpWpT8biXXwT6otPJ9mG0IfK2egD0ANo
 vBV7DXPRqobxPOI7J2ZuGGyUn79oSq3Y4Urn3Zyyn2lNoxUj47AavIBj/OB434HnhcBn
 5RkPQ7IksvIqdNdKIjfNTvl96iJB0MD5uWvz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730585935; x=1731190735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pny/6aZrMRKa1cJiQSXpo+LyH2LHLfG8xTW7X1mJzQY=;
 b=iQMsW+cf1ZkTFJ8R6YSSkh6PpJzIBoSgK2e31A0viPk6qJqh6vro9FGXdlyXLaTf6T
 HpVtyu2WHVSBAmICqQkPRn+//m5gdwAGuuxk84E5cVb5VehPt54PRrGFKlRfTcZ/cpeV
 3NjhRomOdsLvOzrVX6sMB46vHoJWmjOldQPYVbzXGK5TzxM8r4OXq8M5Y39uIZoQ9MO/
 Ok8di6TvQ2tsFYKNgTJrqPypicOgYoFgf0A9ssCmveFeiuMSHGAQILGn9qtFttcRat/B
 4AbQD0n+UkxOiMOymeTvH7q05TzE3mQhebgDaBwMBLO2XBR9tSQEkYWQq+HtG++y6uMQ
 VEWw==
X-Gm-Message-State: AOJu0Yzkco6kOKEcqi1+suIKwLDYh20y1WZZSThMhzSIWqBgY/2+qfRn
 8tlSo3JfCOWlz3wSul2GzFd5P2y+LGGTrfc6aPSkSSirI47tFDVWn72nFhuxpR8qccK3D8yiUsp
 AuQ==
X-Google-Smtp-Source: AGHT+IHGe8V65gtGY5RnTJ65ochndhKXaqi/ybYy6vDG1cXXpq5S8/1BmpJDZWniwNV2Xx38/me+IA==
X-Received: by 2002:a05:6a20:d81b:b0:1d6:e635:5c5e with SMTP id
 adf61e73a8af0-1d9a83ab2e5mr35793588637.9.1730585935142; 
 Sat, 02 Nov 2024 15:18:55 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:18:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 00/25] led: Remove old status-LED code
Date: Sat,  2 Nov 2024 16:16:58 -0600
Message-ID: <20241102221737.547938-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 03 Nov 2024 02:40:26 +0100
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

There has been an LED framework in U-Boot which uses driver model for
about 9 years now. Recent work is underway to improve it and provide
more features. It is probably a good time to drop the old code, which
is only used by 5 boards:

   ./tools/qconfig.py -f LED_STATUS
   5 matches
   eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
   socfpga_vining_fpga

This series attempts that.

The new /options node provides a way to provide U-Boot settings, and
LEDs are implemented there. For now I have brought into the options
schema from upstream. We can update it once the LED additions land
there.

Changes in v3:
- Update commit message
- Combine removal and enable patches
- Combine removal and enable patches
- Combine removal and enable patches

Changes in v2:
- Combine code-removal and defconfig changes
- Add a patch to enable LED and LED_BOOT for these boards
- Enable LED on the 5 affected platforms
- Reorder patches for bisectability
- Add dt-schema bindings for LED

Simon Glass (25):
  eb_cpu5282: Drop status-LED code and enable LED
  vining_fpga: Drop status-LED code and use LED
  mx23_olinuxino: Drop status-LED code and use LED
  pinephone: Drop status-LED code and use LED
  led: Drop LED_STATUS_BOARD_SPECIFIC
  arm: Drop old LED support
  common: doc: Drop old LED support
  st: stm32f429: Drop old LED code
  led: Make the LED config common
  led: Drop LED_STATUS from Kconfig
  led: Drop the legacy LED command
  misc: Drop gpio_led driver
  pca9551_led: Delete driver
  misc: status_led: Delete driver
  m68k: Drop unused status_led.h header file
  powerpc: Drop status-LED code
  igep00x0: Drop unused status_led.h header file
  sunxi: Drop status-LED code
  common: Drop status-LED code in board_r
  image: Drop unused status_led.h header file
  ide: Drop unused status_led.h header file
  mpc83xx: Drop status-LED code
  net: Drop status-LED code
  led: Drop status_led header file
  doc: Add devicetree bindings for options

 arch/arm/lib/crt0.S                          |   4 -
 arch/m68k/lib/bootm.c                        |   3 -
 arch/powerpc/lib/interrupts.c                |   6 -
 board/BuS/eb_cpu5282/eb_cpu5282.c            |  20 --
 board/isee/igep00x0/igep00x0.c               |   1 -
 board/olimex/mx23_olinuxino/mx23_olinuxino.c |   7 -
 board/softing/vining_fpga/socfpga.c          |   4 -
 board/st/stm32f429-discovery/Makefile        |   1 -
 board/st/stm32f429-discovery/led.c           |  39 ---
 board/sunxi/board.c                          |   6 -
 boot/image.c                                 |   4 -
 cmd/Makefile                                 |   1 -
 cmd/ide.c                                    |   4 -
 cmd/legacy_led.c                             | 185 ----------
 common/board_f.c                             |  22 --
 common/board_r.c                             |  27 --
 configs/eb_cpu5282_defconfig                 |   8 +-
 configs/eb_cpu5282_internal_defconfig        |   8 +-
 configs/mx23_olinuxino_defconfig             |  10 +-
 configs/pinephone_defconfig                  |   7 +-
 configs/socfpga_vining_fpga_defconfig        |  13 +-
 doc/README.LED                               |  77 -----
 doc/device-tree-bindings/options.yaml        |  79 +++++
 doc/device-tree-bindings/options/u-boot.yaml | 136 ++++++++
 drivers/led/Kconfig                          | 342 +------------------
 drivers/misc/Kconfig                         |  13 -
 drivers/misc/Makefile                        |   3 -
 drivers/misc/gpio_led.c                      | 106 ------
 drivers/misc/pca9551_led.c                   | 170 ---------
 drivers/misc/status_led.c                    | 124 -------
 drivers/timer/mpc83xx_timer.c                |   5 -
 include/configs/eb_cpu5282.h                 |   6 -
 include/status_led.h                         | 115 -------
 net/bootp.c                                  |   7 -
 net/net.c                                    |  33 --
 35 files changed, 236 insertions(+), 1360 deletions(-)
 delete mode 100644 board/st/stm32f429-discovery/led.c
 delete mode 100644 cmd/legacy_led.c
 delete mode 100644 doc/README.LED
 create mode 100644 doc/device-tree-bindings/options.yaml
 create mode 100644 doc/device-tree-bindings/options/u-boot.yaml
 delete mode 100644 drivers/misc/gpio_led.c
 delete mode 100644 drivers/misc/pca9551_led.c
 delete mode 100644 drivers/misc/status_led.c
 delete mode 100644 include/status_led.h

-- 
2.43.0

