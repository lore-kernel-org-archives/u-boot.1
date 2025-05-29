Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14416C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 12:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD75083015;
	Thu, 29 May 2025 14:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="m/0HlIRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121188304A; Thu, 29 May 2025 12:22:38 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFDD82B20
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 12:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=237868047=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1748514155; x=1780050155;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sCWGoAqYnjycsaGzwTG9970WWFBL0OHBR2f1R3S6eLU=;
 b=m/0HlIRKQZMqCdx2x/qkcG3yxcdQpVb2Mlip7cfTBePNyZm/zdS51cjH
 6ENw1DdbpJhzaVl7nWNS6sCaZPskYh2+pRL/AQ6ytjE1C1GlK5h0CNUsB
 8fbLmaBzWbR3l70X3eGrInUsPHKD1uoox8+si/jSxeDv/GLp6Rf/gGD8/
 3mNQpKUPHEFxjD1WJNpWi6CuBso9fosdkxQyWPJ+nFrwMUnD6iLan2j5l
 uZpGeBdWC/ljVJZcfC8VgA1B+4ZDzlZ/GrdRDRCHY8p6XnWGZGmUNUwaL
 C4j6Z9RQdFC2xh4fyO04dnnBE2DHAytrUW6dpkyaS2jy9VYfnPxNVboS7 w==;
X-CSE-ConnectionGUID: /+gMfZswTAmcTF4tFF0uoQ==
X-CSE-MsgGUID: QDE8YXpnTHKHB/NMOcG4Yw==
X-IronPort-AV: E=Sophos;i="6.15,192,1739862000"; d="scan'208";a="209696251"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 May 2025 03:22:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 29 May 2025 03:22:03 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 29 May 2025 03:22:01 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <conor.dooley@microchip.com>, <jamie.gibbons@microchip.com>,
 <praveen.kumar@microchip.com>, <eoin.dickson@microchip.com>,
 <cyril.jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v2 0/2] Add SD card support to the Beagle-V-Fire
Date: Thu, 29 May 2025 15:51:10 +0530
Message-ID: <20250529102112.3544972-1-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 29 May 2025 14:27:03 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

This series add SD card support for the Beagle-V-Fire. The Beagle-V-Fire uses the
Microchip coreqspi xfer function and a gpio chip select, so this series adds gpio
support for PolarFire SoC and the xfer function into the Microchip coreqspi driver.


Eoin Dickson (2):
  gpio: add PolarFire SoC GPIO and Core GPIO driver
  spi: coreqspi: add xfer function for PolarFire SoC

 drivers/gpio/Kconfig             |   5 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/mpfs_gpio.c         | 198 +++++++++++++++++++++++++++++++
 drivers/spi/microchip_coreqspi.c | 113 +++++++++++++++++-
 4 files changed, 315 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpio/mpfs_gpio.c

-- 
2.34.1

