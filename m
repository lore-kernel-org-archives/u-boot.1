Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54976CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4078902A;
	Fri, 27 Sep 2024 00:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kYfkJIWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45732889AE; Thu, 26 Sep 2024 22:47:05 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C01488D13
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-45821ebb4e6so9443141cf.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383622; x=1727988422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xxvWwbKtkXUX7p+oVxlmhMEoMQZ1mWXFT1NL11pr7hg=;
 b=kYfkJIWwsVj1hSflIzli0RJumjQ4FKRzuJScFC8YK9TWFyFqDPPheTrK9YmD1T958Z
 +nnxUMbJjaP7ocIs9dWcX6+ABQobnQ/HGCnF4HkxOaMBqvZniNZUkofiHpts4V3J+Yhi
 gS8pe9c0NuiJYzrzSwSMcnw2LAq3VvsSriu9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383622; x=1727988422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxvWwbKtkXUX7p+oVxlmhMEoMQZ1mWXFT1NL11pr7hg=;
 b=kKwquFgizZGtJAz1dvVvpiU2Ae0TH5fuJxUFLLO4RBhkFSNc8UQwUUXrcbqvcyNC3I
 PnU+mTcI93HFAcduHAWHJnXmgjMz0pRiJdlMUkbkR4yCnbdyPNdZCpBrWiFvLhgDzWun
 ZwZ7Mgos+eM7FKa1uFJ0TypWzL5nTBB+y/l7p6y/ipDhJAWkjIXE0jBehQDbMFy2UqGS
 OXTrr54EHxjQ5/E0nXBPOc1mZ3J6ly2hrGbpKM8HplMh8zShMEPF9LQy/FTsPmMeQe3r
 nSWelN/KDHnrwUsLnaPXhQzYY1D14B2k3DPdILgo/BuH2ic9SvHkkqs/FJyZMoPG20jF
 SO1Q==
X-Gm-Message-State: AOJu0Yzf0rUbqLdAmTbKmBBr0PyPDJgv+xHYh6RlWf3q66K5IU6MDRs1
 52TzactuOr2XIaNxc767x8AC03fnEowGCn/uAhF8rzaSUG3v9PFFFHO1dv2rRislnrtMsnE9tLy
 cDgSwQ+A=
X-Google-Smtp-Source: AGHT+IF08wXICnUmxEcXTUjumMPYSOy7d4ujhp7/5EAY7XiDOu51ta/lHPDxXd/NXbk8xV3L4gheAQ==
X-Received: by 2002:a0c:f411:0:b0:6c5:b857:7837 with SMTP id
 6a1803df08f44-6cb3b5f8127mr15178246d6.13.1727383621801; 
 Thu, 26 Sep 2024 13:47:01 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:47:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Andre Przywara <andre.przywara@arm.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/27] led: Remove old status-LED code
Date: Thu, 26 Sep 2024 22:44:20 +0200
Message-ID: <20240926204455.963584-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Sep 2024 00:50:46 +0200
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


Simon Glass (27):
  led: Drop LED_STATUS_BOARD_SPECIFIC
  arm: Drop old LED support
  common: doc: Drop old LED support
  st: stm32f429: Drop old LED code
  led: Make the LED config common
  eb_cpu5282: Drop STATUS_LED
  mx23_olinuxino: Drop STATUS_LED
  pinephone: Drop STATUS_LED
  socfpga_vining_fpga: Drop STATUS_LED
  led: Drop LED_STATUS from Kconfig
  led: Drop the legacy LED command
  misc: Drop gpio_led driver
  pca9551_led: Delete driver
  misc: status_led: Delete driver
  m68k: Drop unused status_led.h header file
  powerpc: Drop status-LED code
  eb_cpu5282: Drop status-LED code
  igep00x0: Drop unused status_led.h header file
  mx23_olinuxino: Drop status-LED code
  vining_fpga: Drop status-LED code
  sunxi: Drop status-LED code
  common: Drop status-LED code in board_r
  image: Drop unused status_led.h header file
  ide: Drop unused status_led.h header file
  mpc83xx: Drop status-LED code
  net: Drop status-LED code
  led: Drop status_led header file

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
 common/board_r.c                             |  16 -
 configs/eb_cpu5282_defconfig                 |   6 -
 configs/eb_cpu5282_internal_defconfig        |   6 -
 configs/mx23_olinuxino_defconfig             |   8 -
 configs/pinephone_defconfig                  |   5 -
 configs/socfpga_vining_fpga_defconfig        |  11 -
 doc/README.LED                               |  77 -----
 drivers/led/Kconfig                          | 342 +------------------
 drivers/misc/Kconfig                         |  13 -
 drivers/misc/Makefile                        |   3 -
 drivers/misc/gpio_led.c                      | 106 ------
 drivers/misc/pca9551_led.c                   | 170 ---------
 drivers/misc/status_led.c                    | 124 -------
 drivers/timer/mpc83xx_timer.c                |   5 -
 include/configs/eb_cpu5282.h                 |   6 -
 include/status_led.h                         | 102 ------
 net/bootp.c                                  |   7 -
 net/net.c                                    |  33 --
 33 files changed, 11 insertions(+), 1336 deletions(-)
 delete mode 100644 board/st/stm32f429-discovery/led.c
 delete mode 100644 cmd/legacy_led.c
 delete mode 100644 doc/README.LED
 delete mode 100644 drivers/misc/gpio_led.c
 delete mode 100644 drivers/misc/pca9551_led.c
 delete mode 100644 drivers/misc/status_led.c
 delete mode 100644 include/status_led.h

-- 
2.43.0

