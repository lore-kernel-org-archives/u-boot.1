Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153B9C25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 05:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E5287FEE;
	Thu, 16 May 2024 07:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="l8bFt497";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C57D86DBD; Wed, 15 May 2024 23:59:28 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BAF6882FE
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-622f5a0badcso40176877b3.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810362; x=1716415162;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h7TkX2G+ZKFob1Qzc61jcNTHgJJt+5rFqQ8T2yC8Fc8=;
 b=l8bFt497Ie6sf961jT10xyoozQZh+xs5Bm3TNkpxm3t152+L5VPxTgSHWwkikvh+GN
 Mg4Jf54t6Pb1ixuyyYg6g41eeJRkQHuVAs9c0NrPL3OB0VY3CaWdMUrXW+FcSOu1Q/89
 U8mMQ0D/28jhtVZhHNaqrh7PvLehhBjZ1m3qAjjERLtF7iSx9EtwWBv/Y9hXF8JXnIj3
 pC2t57t0545l4q9vGt8M9JpB6oKJRW24IQHj+bTEy+5ir9PhfDvs4zwoORWZdTW99gMu
 9/iKgS5Le83i1TOTXvHKF0EQa0ZwUbIfmE33160bRGwx+pjgc0Cntkb02Wa1Dae1bgLL
 PELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810362; x=1716415162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7TkX2G+ZKFob1Qzc61jcNTHgJJt+5rFqQ8T2yC8Fc8=;
 b=aV5OJ6wHJLHREvSOf63FcpXQ5w3BPdGoGn5NyMRE1TX43jkf6/bAkpj52kgKN3c7/J
 Ksao/HYD6FUrQUREkkDF4SctSNXNvuUp8YeYduWnYmgoN9pM6TFNWKEtN07Jxfs0dTHx
 4+zi1Y4P+wvRh4ugedfAuTsets8RtvWKTJTp4AkrSIZXHoCSC+y2jn8FuxE5olRotOsf
 kTZwrj6TFtl/Xslbmz4glyNYGE7hDZ9st2ZhUn3gducXL2NMhB5zn20U9m/wPEuRCvKC
 8vlr3ukcJCrK/lV0qc5X2yLwCTFE45GkDM7iP6MdkczNIsPnFpuEOVL+M8ZVcI1BYnt6
 vyyA==
X-Gm-Message-State: AOJu0YxlpCjd4EqO33E4/Q5uX14Cj49ACPgDDjM8qtdRThp1ejaUuDTe
 XrrH6E8lbhEkGVbPrwV+1sQoIdwu/YSGJxe497qwRo4Js1ojiGA9SRJ+kxh3CmHefa81b0CjPZ7
 4eQ==
X-Google-Smtp-Source: AGHT+IGqUlu9+sSD8kc39QXTVlXdzJvEQKTt1sH5SFDFQEHx7/wb6B/IuGATBiEQl71qNFJ6TF/VXQ==
X-Received: by 2002:a81:4c4b:0:b0:61b:1b51:371f with SMTP id
 00721157ae682-622affdea5cmr176319627b3.12.1715810361976; 
 Wed, 15 May 2024 14:59:21 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:21 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Igor Prusov <IVPrusov@sberdevices.ru>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 MD Danish Anwar <danishanwar@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Randolph <randolph@andestech.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 William Zhang <william.zhang@broadcom.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 00/11] drivers: Driver support for ADI SC5xx SoCs
Date: Wed, 15 May 2024 17:57:37 -0400
Message-ID: <20240515215837.14028-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 07:02:36 +0200
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


This series adds all of the supported peripheral drivers for the sc5xx
series of SoCs from Analog Devices and other drivers that are used by
the evaluation kits, such as a GPIO expander used by the EZLITE carrier
boards.

This series is based on uboot/next as it references the sc5xx machine
type at times and currently passes CI.


Greg Malysa (4):
  pinctrl: Add support for ADI SC5XX-family pinctrl
  gpio: Add support for SC5XX-family processor GPIO driver
  net: Add support for ADI SC5xx SoCs with DWC QoS ethernet
  dma: Add driver for ADI SC5xx-family SoC MDMA functionality

Nathan Barrett-Morrison (7):
  gpio: Add support for ADI ADP5588 GPIO expander chips
  usb: musb-new: Add support for Analog Devices SC5xx SoCs
  i2c: Add support for ADI SC5XX-family I2C peripheral
  watchdog: Add support for ADI SC5XX-family watchdog peripheral
  remoteproc: Add in SHARC loading for ADI SC5XX-family processors
  spi: Add support for ADI SC5XX-family processor SPI peripherals
  mmc: Add support for ADI SC5XX-family processor SDHCI peripherals

 MAINTAINERS                            |  11 +
 drivers/dma/Kconfig                    |   7 +
 drivers/dma/Makefile                   |   1 +
 drivers/dma/adi_dma.c                  | 255 +++++++++
 drivers/gpio/Kconfig                   |  17 +
 drivers/gpio/Makefile                  |   2 +
 drivers/gpio/adp5588_gpio.c            | 208 ++++++++
 drivers/gpio/gpio-adi-adsp.c           | 179 +++++++
 drivers/i2c/Kconfig                    |   7 +
 drivers/i2c/Makefile                   |   1 +
 drivers/i2c/adi_i2c.c                  | 393 ++++++++++++++
 drivers/mmc/Kconfig                    |   8 +
 drivers/mmc/Makefile                   |   1 +
 drivers/mmc/adi_sdhci.c                | 152 ++++++
 drivers/net/Kconfig                    |   7 +
 drivers/net/Makefile                   |   1 +
 drivers/net/dwc_eth_qos.c              |   6 +
 drivers/net/dwc_eth_qos.h              |   2 +
 drivers/net/dwc_eth_qos_adi.c          | 101 ++++
 drivers/pinctrl/Kconfig                |   8 +
 drivers/pinctrl/Makefile               |   1 +
 drivers/pinctrl/pinctrl-adi-adsp.c     | 156 ++++++
 drivers/remoteproc/Kconfig             |  11 +
 drivers/remoteproc/Makefile            |   1 +
 drivers/remoteproc/adi_sc5xx_rproc.c   | 276 ++++++++++
 drivers/spi/Kconfig                    |   6 +
 drivers/spi/Makefile                   |   1 +
 drivers/spi/adi_spi3.c                 | 690 +++++++++++++++++++++++++
 drivers/usb/musb-new/Kconfig           |   7 +
 drivers/usb/musb-new/Makefile          |   1 +
 drivers/usb/musb-new/sc5xx.c           | 202 ++++++++
 drivers/watchdog/Kconfig               |   9 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/adi_wdt.c             | 145 ++++++
 include/dt-bindings/pinctrl/adi-adsp.h |  21 +
 35 files changed, 2895 insertions(+)
 create mode 100644 drivers/dma/adi_dma.c
 create mode 100644 drivers/gpio/adp5588_gpio.c
 create mode 100644 drivers/gpio/gpio-adi-adsp.c
 create mode 100644 drivers/i2c/adi_i2c.c
 create mode 100644 drivers/mmc/adi_sdhci.c
 create mode 100644 drivers/net/dwc_eth_qos_adi.c
 create mode 100644 drivers/pinctrl/pinctrl-adi-adsp.c
 create mode 100644 drivers/remoteproc/adi_sc5xx_rproc.c
 create mode 100644 drivers/spi/adi_spi3.c
 create mode 100644 drivers/usb/musb-new/sc5xx.c
 create mode 100644 drivers/watchdog/adi_wdt.c
 create mode 100644 include/dt-bindings/pinctrl/adi-adsp.h

-- 
2.43.2

